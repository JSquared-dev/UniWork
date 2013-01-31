/*
 *  bootdev.h
 *
 *  Copyright (C) 1998 Russell King
 */
#ifndef BIOS_NETDEV_H
#define BIOS_NETDEV_H

#include <bios/types.h>
#include <bios/buflist.h>

#define htonl(x)	(((x) & 0x000000ff) << 24 |\
			 ((x) & 0x0000ff00) << 8  |\
			 ((x) & 0x00ff0000) >> 8  |\
			 ((x) & 0xff000000) >> 24)

#define htons(x)	(((x) & 0x000000ff) << 8 |\
			 ((x) & 0x0000ff00) >> 8)

typedef enum {
	media_autodetect,
	media_coax,
	media_utp,
	media_aui
} media_t;

struct netdev;

struct netdev_ops {
	int		(*probe)(void);
	int		(*open)(struct netdev *);
	int		(*close)(struct netdev *);
	int		(*status)(struct netdev *);
	int		(*set_media)(struct netdev *, media_t media);
	int		(*check_media)(struct netdev *);
	int		(*send)(struct netdev *, void *buffer, int size);
	int		(*recv)(struct netdev *, void *buf);
	const char	*driver_name;
};

struct trans_ops {
	struct buflist *(*header)(struct netdev *nd, u8 *dest, u16 proto, struct buflist *blp);
	int		(*send)(struct netdev *nd, struct buflist *blp);
	int		(*recv)(struct netdev *nd, u16 proto, u8 *buf);
};

struct netdev {
	const struct netdev_ops	*hard;
	const struct trans_ops	*trans;

	const		char *name;

	struct netdev	*next;
	u32		io_base;
	u8		hw_addr[6];
	u8		hw_broadcast[6];
	u8		hw_addr_len;

	u32		ip_addr;

	media_t		media;
	int		up:1;
};

extern struct netdev *probed_net_devs;

#endif
