/*
 *  bootdev.h
 *
 *  Copyright (C) 1998 Russell King
 */
#ifndef BOOTDEV_H
#define BOOTDEV_H

struct bootdev {
	const char *name;

	int (*init)(void);
	int (*start)(void);
	int (*load)(void);
	int (*stop)(void);

	/* Internal */
	struct bootdev *next;
};

#endif
