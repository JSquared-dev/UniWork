


#ifndef _MAIN_H_
#define _MAIN_H_

#include <stdio.h>
#include <pthread.h>
#include "messageQueue.h"

struct threadData_s {
	FILE *comPort;
	char userID;
	struct messageQueue_s receiveQueue;
	struct messageQueue_s transmitQueue;
	
	/* unique locks for individual data elements */
	pthread_mutex_t comPort_mutex;
	pthread_mutex_t userID_mutex;
	pthread_mutex_t receiveQueue_mutex;
	pthread_mutex_t transmitQueue_mutex;
};



#endif
