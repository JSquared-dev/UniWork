
#include <stdio.h>
#include <stdlib.h>

#ifdef _WIN32
#else
#include <unistd.h>
#endif

#include "main.h"
#include "packet.h"
#include "queue.h"

THREAD_RET receiveStart(void *data) {
	struct threadData_s *threadData = (struct threadData_s *) data;
	struct lanPacket_s *Packet;
	struct lanPacket_s *transmitPacket;
	char tmp;
	int i;
	char Destination = 0;
	char Source = 0;
	enum PacketType packetType;
		
	while (1) {
		
		Packet = createLanPacket(Source, Destination, packetType, NULL);
		if (read(threadData->comPort, &tmp, 1) != 0 && (tmp == PACKET_START) ) {
			while (read(threadData->comPort, &Destination, 1) != 1)
				usleep(20000);
			while (read(threadData->comPort, &Source, 1) != 1)
				usleep(20000);
			while (read(threadData->comPort, &packetType, 1) != 1)
				usleep(20000);
			Packet->source = Source;
			Packet->destination = Destination;
			Packet->packetType = packetType;
			i = 0;
			while (1) {
				/* read a maximum of 10 bytes over several loops. i keeps count of bytes read so far. */
				i += read(threadData->comPort, (Packet->payload)+i, 10-i);
				if (i < 10) /* not enough bytes read, pause and wait for more bytes to become available */
					usleep(20000);
				else /* enough bytes read to move on */
					break;
			}
			while (read(threadData->comPort, &Packet->checksum, 1) != 1)
				usleep(20000);
			/*~~~~~~~~~~debuging purpose~~~~~~~~~~~~~~*/
			while (1) {
				if (read(threadData->comPort, &tmp, 1) == 1 && tmp == PACKET_END) {
					break;
				}
				else {
					usleep(20000);
					continue;
				}
			}
			/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
			/*--------------looks nasty, will do something about it------------*/
			lockMutex(threadData->userTable.ID_mutex);
			if (Destination == threadData->userTable.ID) {
				unlockMutex(threadData->userTable.ID_mutex);
				/*-----------------------------------------------------------------*/		
				if (packetType == RESPONSE_PACKET)
					addToUserTable(&threadData->userTable, Source);
				else 
					addToQueue(threadData->receiveQueue, Packet);
			}
			else {
				addToQueue (threadData->transmitQueue, Packet);
				if (packetType == LOGIN_PACKET) {
					transmitPacket = createLanPacket(threadData->userTable.ID, Destination, RESPONSE_PACKET, NULL);
					addToQueue (threadData->transmitQueue, transmitPacket);
				}
			}
			
		}
		else {
#ifdef _WIN32
			Sleep(20);
#else
			usleep(20000);
#endif
		}
	}
	return NULL;
}