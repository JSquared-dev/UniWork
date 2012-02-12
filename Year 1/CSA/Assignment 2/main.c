/*
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <termios.h>

#ifdef _WIN32						/* windows only definitions */
#define COM_PORT "COM1"				/* first serial port available on windows systems */
#else								/* non windows only definitions */

#include <pthread.h>				/* posix threading */
#define COM_PORT "/dev/ttyS0"		/* first serial port available on linux systems */

#endif

#define PACKET_START '{'
#define PACKET_END '}'

struct lanPacket_s {
	char destination;
	char source;
	char packetType;
	char payload[10];
	char checksum;
};

int kbdhit();
int login(FILE *comPort);
int logout(FILE *comPort, int id);
char packetChecksum(struct lanPacket_s *packet);
void transmit(FILE *comPort, struct lanPacket_s *packet);
void *networkStart(void *comPort);

int main(int argc, const char **argv) {
	
	printf("connecting to network...");
	FILE *comPort = fopen(COM_PORT, "r+");
	
	pthread_t networkThread;
	pthread_create(&networkThread, NULL, networkStart, comPort);
	int id = login(comPort);
	char input = 0;
	
	while (input != 'q') {
		if ((input = kbdhit()) != EOF) {
			putchar(input);
		}
	}
	logout(comPort, id);
	pthread_cancel(networkThread);
	fclose(comPort);
	return 0;
}

void *networkStart(void *comPort) {
	while(1) {
		printf(".");
		sleep(1);
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
	
	newState.c_lflag &= ~(ICANON|ECHO); /* disable screen echos of keyboard input */
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
	transmit(comPort, &packet);
	
	return 0;
}

char packetChecksum(struct lanPacket_s *packet) {
	char sum = 0;
	sum += packet->destination;
	sum += packet->source;
	sum += packet->packetType;
	for (int i = 0; i < 10; i++) {
		sum += packet->payload[i];
	}
	return sum;
}

void transmit(FILE *comPort, struct lanPacket_s *packet) {
	/* lock comPort */
	/* transmit contents of packet on comPort */
	/* unlock comPort */
}

