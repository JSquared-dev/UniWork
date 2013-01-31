/*
 * include/bios/ip.h
 *
 * Author: Russsell King
 */
#ifndef BIOS_IP_H
#define BIOS_IP_H

#ifndef INADDR_ANY
#define INADDR_ANY	(0xffffffffUL)
#endif

struct sin {
	u32	sin_addr;
	u16	sin_port;
};

struct iphdr {
	u8	ip_ihl:4;
	u8	ip_ver:4;
	u8	ip_tos;
	u16	ip_len;
	u16	ip_id;
	u16	ip_frag;
	u8	ip_ttl;
	u8	ip_proto;
	u16	ip_check;
	u32	ip_source;
	u32	ip_dest;
};

extern char *in_ntoa(u32 addr);

extern int ip_send(struct netdev *nd, int protocol, u32 from, u32 to, struct buflist *data);

#endif
