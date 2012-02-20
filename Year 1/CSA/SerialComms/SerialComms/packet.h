


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

struct lanPacket_s *createLanPacket(char source, char destination, char type, char data[10]);
void destroyPacket(struct lanPacket_s *packet);
char packetChecksum(struct lanPacket_s *packet);

#endif
