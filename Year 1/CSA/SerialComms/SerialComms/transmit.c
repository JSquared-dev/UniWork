/* transmit.c
 * written by: James Johns
 * Date: 21/2/2012
 *
 */

#ifdef _WIN32
#include <Windows.h>
#include <time.h>
#else
#include <unistd.h>
#endif

#include <stdio.h>
#include "main.h"
#include "packet.h"
#include "queue.h"
#include "transmit.h"

THREAD_RET transmitStart(void *data) {
	int i; char tmp;
	struct lanPacket_s *packet;
	struct threadData_s *threadData = (struct threadData_s *) data;
	struct queue_s *transmitQueue = threadData->transmitQueue;

	while (1) {
		packet = (struct lanPacket_s *) removeFrontOfQueue(transmitQueue);
		if (packet != NULL) {
			printf("{%c%c%c%10s%c}\n", packet->source, packet->destination, packet->packetType, packet->payload, packet->checksum);
			fflush(stdout);
			/* if the packet is self addressed, simulate a round trip by receiving it instantly */
			if (packet->source == threadData->userTable.ID) {
				/* add to pend table to keep track of packet */
			}
			lockMutex(threadData->comPort_mutex);
			tmp = PACKET_START;
			write(threadData->comPort, &tmp, 1);
			write(threadData->comPort, &packet->destination, 1);
			write(threadData->comPort, &packet->source, 1);
			write(threadData->comPort, &packet->packetType, 1);
			for (i = 0; i < 10; i ++)
				write(threadData->comPort, &packet->payload[i], 1);
			write( threadData->comPort, &packet->checksum, 1);
			tmp = PACKET_END;
			write(threadData->comPort, &tmp, 1);
			unlockMutex(threadData->comPort_mutex);
		}
		else {
#ifdef _WIN32
			Sleep(10);
#else
			usleep(100000);
#endif
		}
	}
	return NULL;
}

