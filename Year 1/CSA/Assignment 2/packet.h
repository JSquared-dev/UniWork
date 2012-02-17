


#ifndef _PACKET_H_
#define _PACKET_H_


#define PACKET_START '{'
#define PACKET_END '}'

struct lanPacket_s {
	char destination;
	char source;
	char packetType;
	char payload[10];
	char checksum;
};

char packetChecksum(struct lanPacket_s *packet);

#endif
