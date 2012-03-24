/* transmit.c
 * written by: James Johns
 * Date: 21/2/2012
 *
 */

#ifdef _WIN32
#include <Windows.h>
#include <time.h>
#include <io.h>
#else
#include <unistd.h>
#endif

#include <stdio.h>
#include "platform.h"
#include "main.h"
#include "packet.h"
#include "queue.h"
#include "transmit.h"

THREAD_RET transmitStart(void *data) {
	char tmp;
	int minlimit;
	struct lanPacket_s *packet;
	struct threadData_s *threadData = (struct threadData_s *) data;
	struct queue_s *transmitQueue = threadData->transmitQueue;

	while (threadData->programState != EXIT) {
		packet = (struct lanPacket_s *) removeFrontOfQueue(transmitQueue);
		if (packet != NULL) {
			/* if the packet is coming from the current user, enter pending data and keep track of it. */
			if (packet->source == getCurrentID(threadData->userTable)) {
				if (packet->packetType != ACK_PACKET && packet->packetType != NAK_PACKET) {
					if (packet->lastTransmit == 0) {
						packet->pending = 5;
					}
					minlimit = getTimeOfDay() - 5;
					if (packet->lastTransmit > minlimit) {
						addToQueue(threadData->transmitQueue, packet);
						waitMilliSecs(20);
						continue;
					}
					else {
						packet->lastTransmit = getTimeOfDay();
					}
				}
			}
			if (threadData->debugEnable != 0) {
				wprintw(threadData->messageWindow, "\nTransmit packet: {%c%c%c%.10s%.1s}", packet->source, packet->destination, packet->packetType, packet->payload, &packet->checksum);
				wrefresh(threadData->messageWindow);
			}
			lockMutex(threadData->comPort_mutex);
			tmp = PACKET_START;
			write(threadData->comPort, &tmp, 1);
			write(threadData->comPort, &packet->destination, 1);
			write(threadData->comPort, &packet->source, 1);
			write(threadData->comPort, &packet->packetType, 1);
			write(threadData->comPort,  packet->payload, 10);
			write(threadData->comPort, &packet->checksum, 1);
			tmp = PACKET_END;
			write(threadData->comPort, &tmp, 1);
			unlockMutex(threadData->comPort_mutex);
			packet->pending -= 1;
			if (packet->pending == 0) {
				destroyPacket(packet);
			}
			else {
				addToQueue(threadData->transmitQueue, packet);
			}
		}
		else {
			waitMilliSecs(20);
		}
	}
	return (THREAD_RET)NULL;
}

