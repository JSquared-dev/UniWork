/*
 * include/bios/buflist.h
 *
 * Copyright (C) 1998 Russell King
 */
#ifndef BIOS_BUFLIST_H
#define BIOS_BUFLIST_H

struct buflist {
	struct buflist	*next;
	void		*data;
	int		 size;
};

#endif
