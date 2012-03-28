
#ifndef _PACKET_H_
#define _PACKET_H_

#include "queue.h"


#define PACKET_START '{'
#define PACKET_END '}'

enum PacketType {
	LOGIN_PACKET	= 'L',
	LOGOUT_PACKET	= 'X',
	RESPONSE_PACKET = 'R',
	DATA_PACKET		= 'D',
	ACK_PACKET		= 'Y',
	NAK_PACKET		= 'N'
};

struct lanPacket_s {
	char destination;
	char source;
	char checksum;
	enum PacketType packetType;
	char payload[10];
	int pending;
	int lastTransmit;
};

struct lanPacket_s *createLanPacket(char source, char destination, enum PacketType type, char data[10]);
void destroyPacket(struct lanPacket_s *packet);
char packetChecksum(struct lanPacket_s *packet);

int removePendingPacketFromQueue(struct queue_s *queue, struct lanPacket_s *packet);
struct queue_s *findQueueItemRelativeToPacket(struct queue_s *queue, struct lanPacket_s *packet);

#endif
