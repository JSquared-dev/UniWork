
#include <pthread.h>
#include <unistd.h>

#include "main.h"
#include "messageQueue.h"
#include "transmit.h"

void *transmitStart(void *data) {
	struct threadData_s *threadData = data;
	struct messageQueue_s *transmitQueue = &threadData->transmitQueue;
	while (1) {
		pthread_mutex_lock(&threadData->transmitQueue_mutex); /* prevent modification of transmit queue by locking it */
		struct lanPacket_s *packet = removeFrontOfMessageQueue(transmitQueue);
		pthread_mutex_unlock(&threadData->transmitQueue_mutex);
		if (packet != NULL) {
			/* write packet to COM port */
		}
		else {
			usleep(100000);
		}
	}
	return NULL;
}

