


#ifndef _MAIN_H_
#define _MAIN_H_

#include <stdio.h>
#include "thread.h"
#include "queue.h"
#include "userTable.h"

/******************************************/
#ifdef _WIN32						/* windows only definitions */
	#include <process.h>
	#define COM_PORT "COM1"				/* first serial port available on windows systems */
/******************************************/
#elif defined (__APPLE__)				/* mac os x only definitions */
	#include <pthread.h>
	#define COM_PORT "/dev/master"
/******************************************/
#else									/* unix only definitions */
	#include <pthread.h>				/* posix threading */
	#define COM_PORT "/dev/ttyS0"		/* first serial port available on linux systems */
#endif

enum progState {
	LOGIN, /* login state requires user to choose a user id */
	LOGIN_PEND, /* login pending state requires a return packet stating user's selected ID is available */
	MENU, /* main interaction state. React to user input. */
	LOGOUT, /* logout state requires program to loop and refuse user input until successful logout request has been fulfilled */
	EXIT /* when in exit state, all threads halt execution and we exit this program entirely */
};

struct threadData_s {
	enum progState programState;			/* current state of the program */
	FILE *comPort;							/* COM port file stream */
	struct queue_s *receiveQueue;		/* packets received for current user */
	struct queue_s *transmitQueue;	/* packets to be transmitted */
	struct userTable_s userTable;			/* list of stations in a ring */

	/* unique locks for individual data elements */
	/* indexes in mutex list */
	int programState_mutex;
	int comPort_mutex;
	int userTable_mutex;
};


#endif
