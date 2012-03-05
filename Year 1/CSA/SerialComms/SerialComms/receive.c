
#include <stdio.h>
#include <stdlib.h>

#ifdef _WIN32
#else
#include <unistd.h>
#endif

#include "main.h"
#include "packet.h"
#include "queue.h"

void receiveStart(void *data) {
	struct threadData_s *threadData = (struct threadData_s *) data;
	struct lanPacket_s *Packet;
	char Destination;
	char Source;
	enum PacketType packetType;
	enum progState programState;
	int i;
	
	while (1) {
		
		if (fgetc(threadData->comPort) == '{') {
			Destination = fgetc(threadData->comPort);
			Source = fgetc(threadData->comPort);
			packetType = (enum PacketType) fgetc(threadData->comPort);
			Packet = createLanPacket(Source, Destination, packetType, NULL);
			i = 0;
			while (fgetc(threadData->comPort) != '}') {
				Packet->payload[i++] = fgetc(threadData->comPort);
			}
			
			lockMutex (threadData->programState_mutex);
			programState = threadData->programState;
			unlockMutex (threadData->programState_mutex);
			switch (programState) {
				case LOGIN:
					/*------------------------------------------------------------*/
					addToQueue(threadData->transmitQueue, Packet);
					break;
					
				case LOGIN_PEND:
					/************switch in case*************/
					switch (packetType) {
						case LOGIN_PACKET:
							if (Destination == threadData->userTable.ID) {
								/*------------------------------------------------------------*/
								addToQueue(threadData->receiveQueue, Packet);
							}
							else {
								/*------------------------------------------------------------*/
								addToQueue(threadData->transmitQueue, Packet);
							}
							break;
							
						case ACK_PACKET:
							if (Destination == threadData->userTable.ID) {
								/*------------------------------------------------------------*/
								addToQueue(threadData->receiveQueue, Packet);
							}
							else {
								/*------------------------------------------------------------*/
								addToQueue(threadData->transmitQueue, Packet);
							}
							break;
					}
					/***************************************/
					break;
					
			}
			
		}
	}
	
	
#ifdef _WIN32
	/* Sleep(20); */
#else
	/*usleep(20000);*/
#endif
	/*return NULL;*/
}