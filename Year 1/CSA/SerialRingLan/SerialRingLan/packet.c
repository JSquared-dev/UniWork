
#include <stdio.h>
#include <stdlib.h>

#include "packet.h"
#include "platform.h"
#include "queue.h"

/* convienience method to create a packet.
 * to destroy the packet, just free returned address.
 */
struct lanPacket_s *createLanPacket(char source, char destination, enum PacketType type, char data[10]) {
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
//		sprintf(packet->payload, "%10d", time);
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

void destroyPacket(struct lanPacket_s *packet) {

	free(packet);
}

char packetChecksum(struct lanPacket_s *packet) {
	
	char sum = 0;
	int i;
	sum += packet->destination;
	sum += packet->source;
	sum += packet->packetType;

	for (i = 0; i < 10; i++) {
		sum += packet->payload[i];
	}
	
	sum = ~(sum%128);
	sum |= (1 << 7);

	return sum;
}

int removePendingPacketFromQueue(struct queue_s *queue, struct lanPacket_s *packet) {
	struct lanPacket_s *tmpPacket;
	struct queue_s *curQueue = queue;
	lockMutex(queue->mutexIndex);
	while (1) {
		tmpPacket = (struct lanPacket_s *)curQueue->data;
		if (tmpPacket->destination == packet->destination && tmpPacket->source == tmpPacket->source && tmpPacket->pending < 5) {
			/* found our packet */
			/* remove it from the queue */
			destroyPacket((struct lanPacket_s *)removeFrontOfQueue(curQueue));
			break;
		}
		else {
			curQueue = curQueue->next;
			if (curQueue == queue) {
				unlockMutex(queue->mutexIndex);
				return 0;
			}
		}
	}
	unlockMutex(queue->mutexIndex);

	return 1;
}
