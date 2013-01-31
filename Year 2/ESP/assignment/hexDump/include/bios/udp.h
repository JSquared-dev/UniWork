#include <bios/types.h>
#include <bios/buflist.h>
#include <bios/ip.h>

struct udphdr {
	u16	udp_source;
	u16	udp_dest;
	u16	udp_length;
	u16	udp_check;
};

extern int udp_send(struct netdev *nd, struct sin *from, struct sin *to,
		    struct buflist *data);
extern int udp_recv(struct netdev *nd, struct sin *from, struct sin *to,
		    void *buffer, int size);
