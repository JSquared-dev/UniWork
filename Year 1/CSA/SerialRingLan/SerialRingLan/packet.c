/*************************************************
 *	Filename: packet.c
 *	Written by: James Johns, Silvestrs Timofejevs
 *	Date: 28/3/2012
 *************************************************/


#include <stdio.h>
#include <stdlib.h>

#include "packet.h"
#include "platform.h"
#include "queue.h"

/* Function name: createLanPacket
 * Written by: James Johns, Silvestrs Timofojevs. 
 * Date: 28/3/2012
 * Parameters:
 *		source		- character ID of packet's origin.
 *		destination - character ID of packet's destination.
 *		type		- Type of packet, can be any value described by PacketType enumeration.
 *		data		- 10 bytes of data to be placed in the packet's payload. Can be NULL.
 * Returns:
 *		a lanPacket_s structure populated with the appropriate fields. Return value MUST be 
 *		destroyed by destroyPacket function
 *
 * notes:
 *		Return value MUST be destroyed by destroyPacket.
 *		If data parameter is NULL, the current time is placed in the first 4 bytes of the payload.
 *
 */
struct lanPacket_s *createLanPacket(char source, char destination, 
									enum PacketType type, char data[10]) {
	struct lanPacket_s *packet = (struct lanPacket_s *) malloc(sizeof(struct lanPacket_s));
	int i;
	time_t time;
	packet->source = source;
	packet->destination = destination;
	packet->packetType = type;
	if (data != NULL) {
		for (i = 0; i < 10; i++) {
			packet->payload[i] = data[i];
		}
	}
	else {
		time = getTimeOfDay();
		/* place 32 bits into packet data */
		packet->payload[0] = (char)((time & (0xFF << 24)) >> 24);
		packet->payload[1] = (char)((time & (0xFF << 16)) >> 16);
		packet->payload[2] = (char)((time & (0xFF << 8 )) >> 8);
		packet->payload[3] = (char)((time & (0xFF << 0 )) >> 0);
		for (i = 4; i < 10; i ++)
			packet->payload[i] = ' ';
	}
	packet->checksum = packetChecksum(packet);
	packet->pending = 1;
	packet->lastTransmit = 0;
	return packet;
}

/* function name: destroyPacket
 * written by: James Johns
 * Date: 28/3/2012
 * Parameters:
 *		packet - lanPacket_s structure to destroy.
 *
 * notes:
 *		destroys packet. all memory allocated to it by createLanPacket is freed.
 *
 */
void destroyPacket(struct lanPacket_s *packet) {

	free(packet);
}

/* function name: packetChecksum
 * written by: James Johns
 * Date: 28/3/2012
 * Parameters:
 *		packet - lanPacket_s structure to calculate checksum of.
 * Returns:
 *		8 bit, inverted modulo-128 sum of all bytes in packet - except the checksum itself.
 *
 * notes:
 *
 */
char packetChecksum(struct lanPacket_s *packet) {
	
	char sum = 0;
	int i;
	sum += packet->destination;
	sum += packet->source;
	sum += packet->packetType;

	for (i = 0; i < 10; i++) {
		sum += packet->payload[i];
	}
	
	sum += PACKET_START + PACKET_END;
	
	sum = ~(sum%128);
	sum |= 0x80;

	return sum;
}

/* function name: removePendingPacketFromQueue
 * written by: James Johns
 * Date: 28/3/2012
 * Parameters:
 *		queue - queue object which should contain pending packet.
 *		packet - the ACK_PACKET type packet received indicating the packet has been received.
 * Returns:
 *		1 on success, else 0.
 *
 * notes:
 *		return value 0 does not indicate error, only that the packet may already have been 
 *		transmitted several times, or this ACK packet is not the first to be received.
 *		If corresponding packet is found, it is removed from the queue and destroyed.
 *
 */
int removePendingPacketFromQueue(struct queue_s *queue, struct lanPacket_s *packet) {
	struct lanPacket_s *tmpPacket;
	struct queue_s *curQueue = queue;
	lockMutex(queue->mutexIndex);
	
	curQueue = findQueueItemRelativeToPacket(queue, packet);
	if (curQueue != NULL) {
		tmpPacket = (struct lanPacket_s *)removeItemFromQueue(curQueue);
		destroyPacket(tmpPacket);
	}
	unlockMutex(queue->mutexIndex);

	return 1;
}

/* function name: findQueueItemRelativeToPacket
 * written by: James Johns
 * Date: 28/3/2012
 * Parameters:
 *		queue - queue object which should contain a packet related to 'packet'.
 *		packet - the packet that is related to the packet in 'queue'.
 * Returns:
 *		Queue item (found in 'queue') containing packet related to 'packet'.
 *
 * notes:
 *		return value 0 does not indicate error, only that the packet may already have been removed 
 *		from the queue, or this packet is not the first relative to be discovered.
 *		If corresponding packet is found, the function returns the queue item as it is in the queue.
 *		WARNING - this function does not lock queue->mutexIndex, but is required to maintain data 
 *					integrity.
 */
struct queue_s *findQueueItemRelativeToPacket(struct queue_s *queue, struct lanPacket_s *packet) {
	struct queue_s *toRet;
	struct queue_s *curQueue = queue;
	struct lanPacket_s *tmpPacket;
	do {
		tmpPacket = (struct lanPacket_s *)curQueue->data;
		if (tmpPacket == NULL) {
		  curQueue = curQueue->next;
		  if (curQueue == queue) {
		    unlockMutex(queue->mutexIndex);
		    return 0;
		  }
		}
		else if (tmpPacket->source == packet->destination && 
				 tmpPacket->destination == packet->source && tmpPacket->pending < 5) {
			toRet = curQueue;
			break;
		}
		curQueue = curQueue->next;
	} while (curQueue != queue);
	

	return toRet;
}
