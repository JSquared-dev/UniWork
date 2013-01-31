/*
 * include/bios/checksum.h
 *
 * Copyright (C) 1998 Russell King
 */
#ifndef BIOS_CHECKSUM_H
#define BIOS_CHECKSUM_H

extern unsigned int checksum(void *ptr, int size, unsigned int oldcheck);

#endif
