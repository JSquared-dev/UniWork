/*
 *
 */

#include "main.h"
#include "messageQueue.h"
#include "receive.h"
#include "packet.h"
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <unistd.h>
#include <termios.h>

#ifdef _WIN32						/* windows only definitions */
#define COM_PORT "COM1"				/* first serial port available on windows systems */
#else								/* non windows only definitions */

#include <pthread.h>				/* posix threading */
#define COM_PORT "/dev/ttyS0"		/* first serial port available on linux systems */

#endif

#define ESC_KEY 0x1B

void initThreadData(struct threadData_s *data);
void destroyThreadData(struct threadData_s *data);

void switchKbdBlocking();

int kbdhit();
int login(FILE *comPort);
int logout(FILE *comPort, int id);

int main(int argc, const char **argv) {
	
	pthread_t receiveThread;
	struct threadData_s data;
	switchKbdBlocking(1);
	initThreadData(&data);
	pthread_create(&receiveThread, NULL, receiveStart, &data);
	
	char letter = 'a';
	while (letter != ESC_KEY) {
		if(read(STDIN_FILENO, &letter, 1) > 0) {
			printf("%c",letter);
			letter = toupper(letter);
			switch (letter) {
				case 'D':
					break;
				default:
//					showMenu();
					break;
			}
		}
	}
	
	pthread_cancel(receiveThread);
	destroyThreadData(&data);
	switchKbdBlocking(0);
	return 0;
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

void initThreadData(struct threadData_s *data) {
	data->comPort = fopen(COM_PORT, "rb+");
	pthread_mutex_init(&data->comPort_mutex, NULL);
	
	data->userID = 0;
	pthread_mutex_init(&data->userID_mutex, NULL);
	
	createMessageQueue(&data->receiveQueue, 5);
	pthread_mutex_init(&data->receiveQueue_mutex, NULL);
	createMessageQueue(&data->transmitQueue, 5);
	pthread_mutex_init(&data->transmitQueue_mutex, NULL);
	
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

int login(FILE *comPort) {
	printf("\nLogin: ");
	char id = getchar();
	/* construct login packet and send */
	/* wait for reply */
	/* if reply is good, we have our ID. else refuse login */
	/* can be blocking. */
	return id;
}

int logout(FILE *comPort, int id) {
	/* construct logout packet and send */
	struct lanPacket_s packet;
	packet.destination = id;
	packet.source = id;
	packet.packetType = 'X';
	packet.checksum = packetChecksum(&packet);
//	transmit(comPort, &packet);
	
	return 0;
}

