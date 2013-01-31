/*
 * include/bios/if_ether.h
 *
 * Copyright (C) 1998 Russell King
 */
#ifndef BIOS_ETH_H
#define BIOS_ETH_H

#define SIZEOF_ETHHDR	14

#define ETH_P_IP	0x0800
#define ETH_P_ARP	0x0806

struct ethhdr {
	unsigned char	eth_dest[6];
	unsigned char	eth_source[6];
	unsigned short	eth_proto;
};

#endif
