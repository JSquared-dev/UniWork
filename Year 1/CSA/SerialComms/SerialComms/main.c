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
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <unistd.h>
#include <termios.h>

#ifdef _WIN32						/* windows only definitions */
#define COM_PORT "COM1"				/* first serial port available on windows systems */
#elif defined (__APPLE__)				/* mac os x only definitions */
#include <pthread.h>
#define COM_PORT "/dev/master"
#else								/* non windows only definitions */
#include <pthread.h>				/* posix threading */
#define COM_PORT "/dev/ttyS0"		/* first serial port available on linux systems */
#endif

#define ESC_KEY 0x1B

void initThreadData(struct threadData_s *data);
void destroyThreadData(struct threadData_s *data);

void switchKbdBlocking();
int kbdhit();

enum progState loginPrompt(struct threadData_s *data);
enum progState checkLogin(struct threadData_s *data);
enum progState mainMenu(struct threadData_s *data);

int main(int argc, const char **argv) {
	
	pthread_t receiveThread, transmitThread;
	struct threadData_s data;
	
		//	switchKbdBlocking(1);
	initThreadData(&data);
	pthread_create(&receiveThread, NULL, receiveStart, &data);
	pthread_create(&transmitThread, NULL, transmitStart, &data);
	
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
	pthread_cancel(receiveThread);
	pthread_cancel(transmitThread);
	destroyThreadData(&data);
	
	/* restore terminal settings to how they were before we modified them */
	switchKbdBlocking(0);
	return 0;
}

enum progState mainMenu(struct threadData_s *data) {
	
	return MENU;
}

enum progState loginPrompt(struct threadData_s *data) {
	char letter;
	printf("login: ");
	if(read(STDIN_FILENO, &letter, 1) > 0) {
		printf("%c",letter); /* echo back letter */
		letter = toupper(letter);
		/* create login packet and queue it for transmission */
		struct lanPacket_s *loginPacket = createLanPacket(letter, letter, 'L', NULL);
		
		/* set up usedID for receive task to be able to identify which packets are targetted at us */
		if (pthread_mutex_lock(&data->userID_mutex) == 0) {
			data->userID = letter;
			pthread_mutex_unlock(&data->userID_mutex);
		}
		else {
			printf("Error locking userID");
			return LOGIN;
		}
		
		/* send packet to transmit queue to be sent onto LAN */
		if (pthread_mutex_lock(&data->transmitQueue_mutex) == 0) {
			
			addMessageToQueue(&data->transmitQueue, loginPacket);
			pthread_mutex_unlock(&data->transmitQueue_mutex);
		}
		else {
			printf("Error locking transmit queue");
			return LOGIN;
		}
		return LOGIN_PEND;
	}
	else {
		return LOGIN;
	}
}

enum progState checkLogin(struct threadData_s *data) {
	
	pthread_mutex_lock(&data->receiveQueue_mutex);
	struct lanPacket_s *packet = removeFrontOfMessageQueue(&data->receiveQueue);
	if (packet != NULL) {
		if (packet->packetType == 'L') { /* successful round trip login packet so we are now logged in */
			pthread_mutex_unlock(&data->receiveQueue_mutex);
			return MENU;
		}
		else if (packet->packetType == 'R') { /* someone else has our userID so we need a new one */
			pthread_mutex_unlock(&data->receiveQueue_mutex);
			data->userID = 0;
			printf("\nYour selected login ID is already active, please use another one\n");
			return LOGIN; /* user id was taken, so we need a new one */
		}
		else {
			addMessageToQueue(&data->receiveQueue, packet); /* wrong time to read, so leave it for later */
			pthread_mutex_unlock(&data->receiveQueue_mutex);
			return LOGIN_PEND;								/* not logged in, but still waiting to check login so carry on */
		}
	}
	else {
		pthread_mutex_unlock(&data->receiveQueue_mutex);
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
	if (pthread_mutex_init(&data->comPort_mutex, NULL) != 0) {
		printf("Error making COM port mutex");
		exit(2);
	}
	
	data->userID = 0;
	if (pthread_mutex_init(&data->userID_mutex, NULL) != 0) {
		printf("Error making USer ID mutex");
		exit(2);
	}
	
	createMessageQueue(&data->receiveQueue, 5);
	if (pthread_mutex_init(&data->receiveQueue_mutex, NULL) != 0) {
		printf("Error making Receive Queue mutex");
		exit(2);
	}
	createMessageQueue(&data->transmitQueue, 5);
	if (pthread_mutex_init(&data->transmitQueue_mutex, NULL) != 0) {
		printf("Error making Transmit Queue mutex");
		exit(2);
	}
	
}

void destroyThreadData(struct threadData_s *data) {
	
	pthread_mutex_destroy(&data->comPort_mutex);
	fclose(data->comPort);
	
	pthread_mutex_destroy(&data->userID_mutex);
	
	pthread_mutex_destroy(&data->receiveQueue_mutex);
	destroyMessageQueue(&data->receiveQueue);
	pthread_mutex_destroy(&data->transmitQueue_mutex);
	destroyMessageQueue(&data->transmitQueue);
}

/* if type = 1, enable non blocking, else enable non-blocking */
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
}

/* non-blocking keyboard input */
int kbdhit() {
	struct termios saveState;
	struct termios newState;
	int c;
	if (tcgetattr(STDIN_FILENO, &saveState) < 0) {
		return EOF;
	}
	newState = saveState;
	
	newState.c_lflag &= ~(ICANON|ECHO);
	newState.c_cc[VMIN] = 1;
	newState.c_cc[VTIME] = 0;
	
	if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &newState) < 0) {
		return EOF;
	}
	
	if (read(STDIN_FILENO, &c, 1) != 1) {
		c = EOF;
	}
	
	if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &saveState) < 0) { /* restore old terminal settings */
		return EOF;											  /* takes effect after all required terminal */
	}														  /* operations have finished */
	
	return c;
}
