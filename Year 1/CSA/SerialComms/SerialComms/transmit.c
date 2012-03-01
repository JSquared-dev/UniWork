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
#include "messageQueue.h"
#include "transmit.h"

void *transmitStart(void *data) {
	int i;
	struct lanPacket_s *packet;
	struct threadData_s *threadData = (struct threadData_s *) data;
	struct messageQueue_s *transmitQueue = &threadData->transmitQueue;

	while (1) {
		packet = (struct lanPacket_s *) removeFrontOfQueue(transmitQueue);
		if (packet != NULL) {
			printf("{%c%c%c%10s%c}\n", packet->source, packet->destination, packet->packetType, packet->payload, packet->checksum);
			fflush(stdout);
			/* if the packet is self addressed, simulate a round trip by receiving it instantly */
			if (packet->source == threadData->userID) {
				/* add to pend table to keep track of packet */
			}
			lockMutex(threadData->comPort_mutex);
			fputc(PACKET_START, threadData->comPort);
			fputc(packet->destination, threadData->comPort);
			fputc(packet->source, threadData->comPort);
			fputc(packet->packetType, threadData->comPort);
			for (i = 0; i < 10; i ++)
				fputc(packet->payload[i], threadData->comPort);
			fputc(packet->checksum, threadData->comPort);
			fputc(PACKET_END, threadData->comPort);
			fflush(threadData->comPort);
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

