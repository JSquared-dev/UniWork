#ifndef BIOS_TIME_H
#define BIOS_TIME_H

extern unsigned long centisecs;

extern void time_init(void);
extern void wait_cs(int cs);

#endif
