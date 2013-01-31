L_TARGET	:= lib.a
L_OBJS		:= crt0.o serial.o timer.o ctype.o checksum.o string.o vsprintf.o printf.o malloc.o
CC              = arm-linux-gcc
AR              = arm-linux-ar
AS              = arm-linux-as
RM              = rm
IPATH           = -I../include 
CFLAGS          = -mcpu=strongarm110 -mapcs-32 -nostdinc -O2 -mno-sched-prolog -fno-builtin -fvolatile $(IPATH) \
                  -DCPU=ARMSA110 -DELF -DNO_MMU


ifdef L_TARGET
$(L_TARGET): $(L_OBJS)
	rm -f $@
	$(AR) $(EXTRA_ARFLAGS) rcs $@ $(LX_OBJS) $(L_OBJS)
endif

bare   :
	- $(RM) *.o 
	- $(RM) lib.a

clean   :
	- $(RM) *.o 



%.s: %.c
	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -S $< -o $@

%.i: %.c
	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -E $< > $@

%.o: %.c
	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -c -o $@ $<

%.o: %.S
	$(CC) $(CFLAGS) -D__ASSEMBLY__ $(EXTRA_CFLAGS) $(CFLAGS_$@) -c -o $@ $<

%.o: %.s
	$(AS) $(ASFLAGS) $(EXTRA_CFLAGS) -o $@ $<

