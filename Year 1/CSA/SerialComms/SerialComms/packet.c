
#include <stdio.h>
#include <stdlib.h>

#include "packet.h"

/* convienience method to create a packet.
 * to destroy the packet, just free returned address.
 */
struct lanPacket_s *createLanPacket(char source, char destination, char type, char data[10]) {
	struct lanPacket_s *packet = malloc(sizeof(struct lanPacket_s));
	
	packet->source = source;
	packet->destination = destination;
	packet->packetType = type;
	if (data != NULL) {
		for (int i = 0; i < 10; i++) {
			packet->payload[i] = data[i];
		}
	}
	
	packet->checksum = packetChecksum(packet);
	
	return packet;
}

void destroyPacket(struct lanPacket_s *packet) {

	free(packet);
}

char packetChecksum(struct lanPacket_s *packet) {
	
	char sum = 0;
	
	sum += packet->destination;
	sum += packet->source;
	sum += packet->packetType;
	
	for (int i = 0; i < 10; i++) {
		sum += packet->payload[i];
	}
	
	return sum;
}
