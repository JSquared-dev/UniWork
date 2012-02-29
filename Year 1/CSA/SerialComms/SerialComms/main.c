/* main.c
 * Written by: James Johns.
 * Date: 17/2/2012
 *
 * main functionality loop. Get and react to user input.
 *
 */

#include "main.h"
#include "messageQueue.h"
#include "receive.h"
#include "transmit.h"
#include "packet.h"
#include "thread.h"
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

#ifdef _WIN32
#else
#include <unistd.h>
#include <termios.h>
#endif

#define ESC_KEY 0x1B

void initThreadData(struct threadData_s *data);
void destroyThreadData(struct threadData_s *data);

void switchKbdBlocking();

enum progState loginPrompt(struct threadData_s *data);
enum progState checkLogin(struct threadData_s *data);
enum progState mainMenu(struct threadData_s *data);

int main(int argc, const char **argv) {
	
	int receiveThread, transmitThread; /* indexes in thread list */
	struct threadData_s data;
	
		//	switchKbdBlocking(1);
	initThreadData(&data);
	receiveThread = createThread(receiveStart, &data);
	transmitThread = createThread(transmitStart, &data);

	data.programState = LOGIN;
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
				break;
			default:
				break;
		}
	}
	
	/* clean up by destroying created threads and dynamic data */
	endThread(receiveThread);
	endThread(transmitThread);
	
	destroyThreadData(&data);
	
	/* restore terminal settings to how they were before we modified them */
	//switchKbdBlocking(0);
	return 0;
}

enum progState mainMenu(struct threadData_s *data) {
	
	return MENU;
}

enum progState loginPrompt(struct threadData_s *data) {
	char letter;
	struct lanPacket_s *loginPacket;
	printf("login: ");
	fflush(stdout);
	letter = getchar();
	
	while (letter == '\n') {
		letter = getchar();
	}

	letter = toupper(letter);
	if (letter < 'A' && letter > 'Z') {
		printf("Please enter a valid login ID.\n ID should be a letter between A and Z\n");
		return LOGIN;
	}
	/* create login packet and queue it for transmission */
	loginPacket = createLanPacket(letter, letter, 'L', NULL);
	
	/* set up usedID for receive task to be able to identify which packets are targetted at us */
	lockMutex(data->userID_mutex);
	data->userID = letter;
	unlockMutex(data->userID_mutex);
	
	/* send packet to transmit queue to be sent onto LAN */
	lockMutex(data->transmitQueue_mutex);
	addMessageToQueue(&data->transmitQueue, loginPacket);
	unlockMutex(data->transmitQueue_mutex);
	
	return LOGIN_PEND;
}

enum progState checkLogin(struct threadData_s *data) {
	
	/* receiveQueue only contains packets targetted at us */
	struct lanPacket_s *packet;
	lockMutex(data->receiveQueue_mutex);
	packet = (struct lanPacket_s *)removeFrontOfMessageQueue(&data->receiveQueue);
	
	if (packet != NULL) {
		if (packet->packetType == LOGIN_PACKET) { /* successful round trip login packet so we are now logged in */
			unlockMutex(data->receiveQueue_mutex);
			printf("Welcome to the network, %c\n", data->userID);
			return MENU;
		}
		else if (packet->packetType == NAK_PACKET) {
			unlockMutex(data->receiveQueue_mutex);
			data->userID = 0;
			printf("\nYour selected login ID is already active, please use another one\n");
			return LOGIN; /* user id was taken, so we need a new one */
		}
		else if (packet->packetType == RESPONSE_PACKET) { /* someone else has our userID so we need a new one */
			printf("found user on network\n");
			return LOGIN_PEND; /* still waiting for our login packet to return */
		}
		else {
			printf("received early packet\n");
			addMessageToQueue(&data->receiveQueue, packet); /* wrong time to read, so leave it for later */
			unlockMutex(data->receiveQueue_mutex);
			return LOGIN_PEND;								/* not logged in, but still waiting to check login so carry on */
		}
	}
	else {
		unlockMutex(data->receiveQueue_mutex);
		return LOGIN_PEND;
	}
}

void initThreadData(struct threadData_s *data) {
	data->comPort = fopen(COM_PORT, "rb+");
	if (data->comPort == NULL) {
		printf("Error opening serial device");
		exit(1);
	}
	/* init COM port to be non-blocking to allow simultaneous read/write */
	if ((data->comPort_mutex = createMutex()) < 0) {
		printf("Error making COM port mutex");
		exit(2);
	}
	
	data->userID = 0;
	if ((data->userID_mutex = createMutex()) < 0) {
		printf("Error making USer ID mutex");
		exit(3);
	}
	
	createMessageQueue(&data->receiveQueue, 5);
	if ((data->receiveQueue_mutex = createMutex()) < 0) {
		printf("Error making Receive Queue mutex");
		exit(4);
	}
	createMessageQueue(&data->transmitQueue, 5);
	if ((data->transmitQueue_mutex = createMutex()) < 0) {
		printf("Error making Transmit Queue mutex");
		exit(5);
	}
	
}

void destroyThreadData(struct threadData_s *data) {
	
	destroyMutex(data->comPort_mutex);
	fclose(data->comPort);
	
	destroyMutex(data->userID_mutex);
	
	destroyMutex(data->receiveQueue_mutex);
	destroyMessageQueue(&data->receiveQueue);
	destroyMutex(data->transmitQueue_mutex);
	destroyMessageQueue(&data->transmitQueue);
	destroyLists();
}

/* if type = 1, enable non blocking, else enable non-blocking */
/*
void switchKbdBlocking(int type) {
	static int saved = 0;
	static struct termios old;
	if (saved != 1) {
		tcgetattr(STDIN_FILENO, &old);
		saved = 1;
	}
	if (type == 1) {
		struct termios new = old;
		new.c_lflag &= ~(ICANON|ECHO);
		new.c_cc[VMIN] = 0;
		new.c_cc[VTIME] = 0;
		tcsetattr(STDIN_FILENO, TCSANOW, &new);
	}
	else {
		tcsetattr(STDIN_FILENO, TCSANOW, &old);
	}
}*/
