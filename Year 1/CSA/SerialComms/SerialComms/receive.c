
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
	char Destination = 0;
	char Source = 0;
	enum PacketType packetType;
	int i;
		
	while (1) {
		
		Packet = createLanPacket(Source, Destination, packetType, NULL);
		transmitPacket = createLanPacket(threadData->userTable.ID, Destination, RESPONSE_PACKET, NULL);

		if (fgetc(threadData->comPort) == '{') {
			Destination = fgetc(threadData->comPort);
			Source = fgetc(threadData->comPort);
			packetType = (enum PacketType) fgetc(threadData->comPort);
			Packet->source = Source;
			Packet->destination = Destination;
			Packet->packetType = packetType;
			for (i = 0; i < 10; i++)
				Packet->payload[i] = fgetc(threadData->comPort);
			Packet->checksum = fgetc(threadData->comPort);
			/*~~~~~~~~~~debuging purpose~~~~~~~~~~~~~~*/
			if (fgetc(threadData->comPort) != '}') {
				printf ("\n Looks like an error");
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
				if (packetType == LOGIN_PACKET) {
					addToQueue (threadData->transmitQueue, Packet);
					
					lockMutex(threadData->userTable.ID_mutex);
					transmitPacket->source = threadData->userTable.ID;
					transmitPacket->destination = Source;
					transmitPacket->packetType = RESPONSE_PACKET;
					transmitPacket->checksum = packetChecksum(transmitPacket);
					addToQueue (threadData->transmitQueue, transmitPacket);
					unlockMutex(threadData->userTable.ID_mutex);
				}
				else
					addToQueue (threadData->transmitQueue, Packet);
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