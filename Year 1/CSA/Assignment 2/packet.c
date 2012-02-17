
#include <stdio.h>

#include "packet.h"


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
