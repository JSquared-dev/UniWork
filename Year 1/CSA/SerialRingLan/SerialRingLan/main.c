/* main.c
 * Written by: James Johns.
 * Date: 17/2/2012
 *
 * main functionality loop. Get and react to user input.
 *
 */

#include "main.h"
#include "queue.h"
#include "receive.h"
#include "transmit.h"
#include "packet.h"
#include "thread.h"
#include "platform.h"
#include "userTable.h"
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <fcntl.h>

#ifdef _WIN32
#include <Windows.h>
#include <io.h>
#include <time.h>
#include "PDCurses/curses.h"
#define COM_OPEN_FLAGS (O_RDWR | O_BINARY)
#else
#include <sys/time.h>
#include <termios.h>
#include <unistd.h>
#include <ncurses.h>
#define COM_OPEN_FLAGS (O_RDWR | O_NOCTTY | O_NONBLOCK)
#endif

#define ESC_KEY 0x1B

void initThreadData(struct threadData_s *data);
void destroyThreadData(struct threadData_s *data);

void switchKbdBlocking();

enum progState loginPrompt(struct threadData_s *data);
enum progState checkLogin(struct threadData_s *data);
enum progState mainMenu(struct threadData_s *data);
void logout(struct threadData_s *data);
enum progState logoutPending(struct threadData_s *data);

int main(int argc, const char **argv) {
	
	thread_t *receiveThread, *transmitThread; /* indexes in thread list */
	struct threadData_s data;
	
	initThreadData(&data);
	
	receiveThread = createThread(receiveStart, &data);
	transmitThread = createThread(transmitStart, &data);
	
	data.programState = LOGIN;
	printUserTable(data.userTable, data.userListWindow);
	while (data.programState != EXIT) {
		switch (data.programState) {
			case LOGIN:
				data.programState = loginPrompt(&data);
				break;
			case LOGIN_PEND:
				/* check receive queue for login packets. if we find our own user ID then we have
				 * successfully logged in. */
				data.programState = checkLogin(&data);
				break;
			case MENU:
				data.programState = mainMenu(&data);
				break;
			case LOGOUT:
				/* block until we receive a successful logout message on receiveQueue */
				data.programState = logoutPending(&data);
				break;
			default:
				break;
		}
	}
	
	/* clean up by destroying created threads and dynamic data */
	endThread(receiveThread);
	endThread(transmitThread);
	
	destroyThreadData(&data);
	return 0;
}

enum progState logoutPending(struct threadData_s *data) {
	struct lanPacket_s *packet = (struct lanPacket_s *)removeFrontOfQueue(data->receiveQueue);
	if (packet == NULL)
		return LOGOUT;
	else if (packet->packetType == LOGOUT_PACKET) {
		setCurrentID(data->userTable, 0);

		wbkgdset(data->messageWindow,COLOR_PAIR(1));
		wbkgdset(data->inputWindow,COLOR_PAIR(1));
		wbkgdset(data->userListWindow,COLOR_PAIR(1));
		wattrset(data->messageWindow, COLOR_PAIR(1));
		wattrset(data->inputWindow, COLOR_PAIR(1));
		wattrset(data->userListWindow, COLOR_PAIR(1));
		wclear(data->messageWindow);
		wclear(data->inputWindow);
		wclear(data->userListWindow);

		printUserTable(data->userTable, data->userListWindow);

		destroyPacket(packet);

		return LOGIN;
	}
	else {
		return LOGOUT;
	}
}

void logout(struct threadData_s *data) {
	char userID = getCurrentID(data->userTable);
	struct lanPacket_s *logoutPacket = (struct lanPacket_s *) createLanPacket(userID, userID, LOGOUT_PACKET, NULL);
	addToQueue(data->transmitQueue, logoutPacket);
	wprintw(data->messageWindow, "\nLogging out...\n");
	wrefresh(data->messageWindow);
}

struct lanPacket_s *createMessage(struct threadData_s *data) {
	int tmp = 0;
	struct lanPacket_s *packet;
	char target = 0;
	char message[10] = {' ',' ',' ',' ',' ',' ',' ',' ',' ',' '};
	
	int i = 0;
	while (target == 0) {
		wprintw(data->inputWindow, "Target: ");
		tmp = wgetch(data->inputWindow);
		switch (tmp) {
			case CTRL_D:
				data->debugEnable = ~(data->debugEnable);
				break;
			default:
				wprintw(data->inputWindow, "%.1c", tmp);
				wrefresh(data->inputWindow);
				if (isalpha(tmp)) {
					target = toupper(tmp);
				}
				break;
		}
	}
	
	wprintw(data->inputWindow, "\nMessage: ");
	i = 0;
	while (i < 10) {
		tmp = wgetch(data->inputWindow);
		if (tmp == KEY_ENTER)
			break;
		
		switch (tmp) {
			case CTRL_D:
				data->debugEnable = ~(data->debugEnable);
				break;
			default:
				wprintw(data->inputWindow, "%.1c", tmp);
				wrefresh(data->inputWindow);
				message[i] = tmp;
				i++;
				break;
		}
	}
	packet = createLanPacket(getCurrentID(data->userTable), target, DATA_PACKET, message);
	
	wprintw(data->inputWindow, "\n"); /* tidy up the input window a little */
	wrefresh(data->inputWindow);
	return packet;
}

enum progState mainMenu(struct threadData_s *data) {
	
	static struct lanPacket_s *packet = NULL;
	char input = wgetch(data->inputWindow);
	input = toupper(input);
	switch (input) {
		case CTRL_D:
			data->debugEnable = ~(data->debugEnable);
			break;
		case 'D':
			/* construct a message to send to a user on the network */
			wprintw(data->inputWindow, "\nCreating message to send to user\n");
			wrefresh(data->inputWindow);
			packet = createMessage(data);
			wprintw(data->inputWindow, "\nMessage created, press S to send\n");
			wrefresh(data->inputWindow);
			break;
		case 'S':
			if (packet != NULL) {
				addToQueue(data->transmitQueue, packet);
				wprintw(data->messageWindow, "Sent message.\n");
				wrefresh(data->messageWindow);
				packet = NULL;
			}
			else {
				wprintw(data->messageWindow, "Please compose a message first\n");
			}
			break;
		case 'X':
			/* post logout packet for transmission */
			logout(data);
			return LOGOUT;
			break;
		default:
			return MENU;
			break;
	}
	return MENU;
}

enum progState loginPrompt(struct threadData_s *data) {
	char letter;
	struct lanPacket_s *loginPacket;
	wrefresh(data->messageWindow);
	wprintw(data->inputWindow, "\nlogin: ");
	wrefresh(data->inputWindow);
	letter = wgetch(data->inputWindow);
	
	while (letter == '\n' || letter == EOF) {
		if (letter == EOF)
			return LOGIN;
		letter = wgetch(data->inputWindow);
	}
	
	if (letter == CTRL_D) {
		data->debugEnable = ~(data->debugEnable);
		return LOGIN;
	}
	else if (letter == CTRL_Q) {
		return EXIT;
	}
	
	wprintw(data->inputWindow, "%.1c", letter);
	wrefresh(data->inputWindow);
	letter = toupper(letter);
	
	if (letter < 'A' || letter > 'Z') {
		scroll(data->inputWindow);
		wprintw(data->inputWindow, "\nPlease enter a valid login ID.\n ID should be a letter between A and Z\n");
		wrefresh(data->inputWindow);
		return LOGIN;
	}
	/* set up usedID for receive task to be able to identify which packets are targetted at us */
	setCurrentID(data->userTable, letter);
	
	/* create login packet and queue it for transmission */
	loginPacket = createLanPacket(letter, letter, LOGIN_PACKET, NULL);
	
	/* send packet to transmit queue to be sent onto LAN */
	addToQueue(data->transmitQueue, loginPacket);
	
	return LOGIN_PEND;
}

enum progState checkLogin(struct threadData_s *data) {
	
	/* receiveQueue only contains packets targetted at us */
	struct lanPacket_s *packet;
	packet = (struct lanPacket_s *)removeFrontOfQueue(data->receiveQueue);
	
	if (packet != NULL) {
		if (packet->packetType == LOGIN_PACKET) { /* successful round trip login packet so we are now logged in */
			wbkgdset(data->messageWindow,COLOR_PAIR(2));
			wbkgdset(data->inputWindow,COLOR_PAIR(2));
			wbkgdset(data->userListWindow,COLOR_PAIR(2));
			wattrset(data->messageWindow, COLOR_PAIR(2));
			wattrset(data->inputWindow, COLOR_PAIR(2));
			wattrset(data->userListWindow, COLOR_PAIR(2));
			wclear(data->messageWindow);
			wclear(data->inputWindow);
			wclear(data->userListWindow);
	
			wprintw(data->messageWindow, "Welcome to the network, %c\n", getCurrentID(data->userTable));
			wprintw(data->messageWindow, "To send a message, press D. To log out, press X.\n");
			wrefresh(data->messageWindow);
			wclear(data->inputWindow);
			wrefresh(data->inputWindow);
			destroyPacket(packet);

			printUserTable(data->userTable, data->userListWindow);

			return MENU;
		}
		else if (packet->packetType == NAK_PACKET) {
			wprintw(data->inputWindow, "\nYour selected login ID is already active, please use another one");
			wrefresh(data->inputWindow);
			setCurrentID(data->userTable, 0);
			return LOGIN; /* user id was taken, so we need a new one */
		}
		else {
			wprintw(data->inputWindow, "received early packet\n");
			wrefresh(data->inputWindow);
			addToQueue(data->receiveQueue, packet); /* wrong time to read, so leave it for later */
			return LOGIN_PEND;								/* not logged in, but still waiting to check login so carry on */
		}
	}
	else {
		return LOGIN_PEND;
	}
}

void initUI(struct threadData_s *data) {
	
	initscr();
	
	raw();
	keypad(stdscr, TRUE);
	//nonl();
	noecho();
	resize_term(27,80);
	start_color();

	init_pair(1, COLOR_WHITE, COLOR_BLACK); /* logged out colours */
	init_pair(2, COLOR_BLACK, COLOR_WHITE); /* logged in colours */

	init_pair(3, COLOR_GREEN, COLOR_BLACK); /* logged out, user table logged in */
	init_pair(4, COLOR_RED, COLOR_BLACK); /* logged out, user table logged out */

	init_pair(5, COLOR_GREEN, COLOR_WHITE); /* logged in, user table logged in */
	init_pair(6, COLOR_RED, COLOR_WHITE); /* logged in, user table logges out */

	
	data->userListWindow = newwin(27, 5, 0, 75);
	data->inputWindow = newwin(5, 75, 22, 0);
	data->messageWindow = newwin(22,75,0,0);
	data->debugEnable = 0;

	
	scrollok(data->inputWindow, TRUE);
	scrollok(data->userListWindow, TRUE);
	scrollok(data->messageWindow, TRUE);
	
	refresh();

	wbkgdset(data->messageWindow,COLOR_PAIR(1));
	wbkgdset(data->inputWindow,COLOR_PAIR(1));
	wbkgdset(data->userListWindow,COLOR_PAIR(1));
	wattrset(data->messageWindow, COLOR_PAIR(1));
	wattrset(data->inputWindow, COLOR_PAIR(1));
	wattrset(data->userListWindow, COLOR_PAIR(1));
	wclear(data->messageWindow);
	wclear(data->inputWindow);
	wclear(data->userListWindow);
	
	wprintw(data->userListWindow, "Users logged in");
	wrefresh(data->userListWindow);
	
	wprintw(data->messageWindow, "Loading network");
	wrefresh(data->messageWindow);
}

void destroyUI(struct threadData_s *data) {
	delwin(data->inputWindow);
	delwin(data->userListWindow);
	endwin();
}

void initThreadData(struct threadData_s *data) {
	data->comPort = open(COM_PORT, COM_OPEN_FLAGS);
	if (data->comPort < 0) {
		fprintf(stderr,"Error opening serial device");
		fflush(stderr);
		exit(1);
	}
	setupCOMPort(data->comPort);
	/* init COM port to be non-blocking to allow simultaneous read/write */
	if ((data->comPort_mutex = createMutex()) < 0) {
		fprintf(stderr,"Error making COM port mutex");
		fflush(stderr);
		exit(2);
	}
	data->userTable = createUserTable();
	data->receiveQueue = createQueue();
	data->transmitQueue = createQueue();
	
	/* initialise Curses screen */
	initUI(data);
}

void destroyThreadData(struct threadData_s *data) {
	
	destroyUserTable(data->userTable);
	
	destroyQueue(data->receiveQueue);
	destroyQueue(data->transmitQueue);
	
	restoreCOMPort(data->comPort);
	destroyMutex(data->comPort_mutex);
	close(data->comPort);
	
	destroyUI(data);
}
