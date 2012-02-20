


#ifndef _MAIN_H_
#define _MAIN_H_

#include <stdio.h>
#include <pthread.h>
#include "messageQueue.h"


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
	char userID;							/* user id of current logged in user */
	struct messageQueue_s receiveQueue;		/* packets received for current user */
	struct messageQueue_s transmitQueue;	/* packets to be transmitted */
	
	/* unique locks for individual data elements */
	pthread_mutex_t programState_mutex;
	pthread_mutex_t comPort_mutex;
	pthread_mutex_t userID_mutex;
	pthread_mutex_t receiveQueue_mutex;
	pthread_mutex_t transmitQueue_mutex;
};


#endif
