
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#ifdef _WIN32
#include <io.h>
#else
#include <unistd.h>
#endif

#include "main.h"
#include "packet.h"
#include "queue.h"
#include "platform.h"

struct lanPacket_s *readPacket(int comPort);
void processPacket(struct lanPacket_s *packet, struct threadData_s *threadData);

THREAD_RET receiveStart(void *data) {
	struct threadData_s *threadData = (struct threadData_s *) data;
	struct lanPacket_s *Packet;
		
	/* loop forever, reading packets and processing them */
	while (threadData->programState != EXIT) {
		Packet = readPacket(threadData->comPort);
		/* if we have received a valid packet, process it. 
		 * otherwise pause for a short time to wait for more data and free up the CPU */
		if (Packet != NULL)
			processPacket(Packet, threadData);
		else
			waitMilliSecs(20);
	}
	return (THREAD_RET)NULL;
}

void processPacket(struct lanPacket_s *packet, struct threadData_s *threadData) {
	char userID = getCurrentID(threadData->userTable);
	
	/* print debug information if in debug mode */
	if (threadData->debugEnable != 0) {
		wprintw(threadData->messageWindow, "Received packet: {%c%c%c%.10s%.1c}\n", packet->source, packet->destination, packet->packetType, packet->payload, packet->checksum);
		wrefresh(threadData->messageWindow);
	}
	/* if the packet is meant for the user currently logged in, the packet needs to be checked */
	if (packet->destination == userID) {
		/*-----------------------------------------------------------------*/
		/* make sure packet is valid via checksum */

		if (packet->packetType == LOGIN_PACKET) {
			/* if we are waiting for a login packet, and we get one, place it on the receive queue
				otherwise if the packet came from our user ID, transmit ACK PACKET
				if none of the above, we have a false packet and need to deal with it. */
			if (threadData->programState == LOGIN_PEND)
				addToQueue(threadData->receiveQueue, packet);
			else {
				if (packet->source == userID) {
					packet->packetType = ACK_PACKET;
				}
				addToQueue(threadData->transmitQueue, packet);
			}
		}
		if (packet->packetType == DATA_PACKET) {
			struct lanPacket_s *ackPacket = createLanPacket(packet->destination, packet->source, ACK_PACKET, packet->payload);
			addToQueue(threadData->transmitQueue, ackPacket);
			wprintw(threadData->messageWindow, "Message from %c: %.10s\n", packet->source, packet->payload);
			wrefresh(threadData->messageWindow);
			destroyPacket(packet);
		}
		else if (packet->packetType == RESPONSE_PACKET) {
			addToUserTable(threadData->userTable, packet->source);
			wprintw(threadData->messageWindow, "found user on network\n");
			wrefresh(threadData->messageWindow);
			destroyPacket(packet);
		}
		else if (packet->packetType == ACK_PACKET) {
			/* remove packet from lan, and removce pending packet from transmit queue */
			destroyPacket(packet);
		}
		else if (packet->packetType == LOGOUT_PACKET) {
		  if (threadData->programState != LOGOUT) {
		    destroyPacket(packet); /* we're not trying to logout, so stop anyone from forcing us offline */
		  }
		  else {
		    addToQueue(threadData->receiveQueue, packet);
		  }
		}
		/* don't accept packets if we're logging out, only report back with our own logout packet */
		else if (threadData->programState != LOGOUT) {
			addToQueue(threadData->receiveQueue, packet);
		}
		else {
			addToQueue(threadData->transmitQueue, packet); /* feign inactivity as we cannot handle incoming messages while logging out */
		}
	}
	else {
		/* the packet is not for the current user, so pass it on to the next station, unless it's a LOGIN_PACKET or LOGOUT_PACKET */
		if (packet->source == userID) {
			/* packet has returned to us, destroy it */
			wprintw(threadData->messageWindow, "Failed message send\n");
			wrefresh(threadData->messageWindow);
			destroyPacket(packet);
		}
		else {
			if (packet->packetType == LOGIN_PACKET) {
				/* new user appears, add entry to user table and update the display */
				addToUserTable(threadData->userTable, packet->source);
				printUserTable(threadData->userTable, threadData->userListWindow);
				/* if there is a user currently logged in, transmit a response packet to let new user know the current user is logged in */
				if (userID != 0) {
					struct lanPacket_s *respPacket = createLanPacket(userID, userID, RESPONSE_PACKET, NULL);
					addToQueue (threadData->transmitQueue, respPacket);
				}
			}
			else if (packet->packetType == LOGOUT_PACKET) {
				removeFromUserTable(threadData->userTable, packet->source);
				printUserTable(threadData->userTable, threadData->userListWindow);
			}
			/* add packet to transmit queue for sending to next station */
			addToQueue (threadData->transmitQueue, packet);
		}
	}
}

struct lanPacket_s *readPacket(int comPort) {
	int i; 
	char Source, Destination, tmp;
	struct lanPacket_s *Packet = NULL;
	enum PacketType packetType;
	/* try reading from the com port, if there is the beginning of a packet, read in the rest of the packet, 
	 * otherwise pause execution for a short time to let the CPU do other things, and wait for more data to become available on the COM port */
	if (read(comPort, &tmp, 1) != 0 && (tmp == PACKET_START) ) {
		/* Async compatible blocking reads.  */
		while (read(comPort, &Destination, 1) != 1)
			waitMilliSecs(20);
		while (read(comPort, &Source, 1) != 1)
			waitMilliSecs(20);
		while (read(comPort, &tmp, 1) != 1)
			waitMilliSecs(20);
		packetType = (enum PacketType)tmp;
		Packet = createLanPacket(Source, Destination, packetType, NULL);
		i = 0;
		/* read a maximum of 10 bytes over several loops. i keeps count of bytes read so far. */
		while (i < 10) {
			i += read(comPort, (Packet->payload)+i, 10-i);
			if (i < 10) /* not enough bytes read, pause and wait for more bytes to become available */
				waitMilliSecs(20);
		}
		while (read(comPort, &Packet->checksum, 1) != 1)
			waitMilliSecs(20);
		/* make sure we read to the end of the packet, to synchronise packet reads/writes between stations */
		while (1) {
			if (read(comPort, &tmp, 1) == 1 && tmp == PACKET_END) {
				break;
			}
			else {
				waitMilliSecs(20);
				continue;
			}
		}
	}
	else {
		waitMilliSecs(20);
	}
	return Packet;
}
