
OBJECTS := main.o queue.o receive.o transmit.o packet.o thread.o userTable.o platform.o


.PHONY: all clean

all: $(OBJECTS)
	gcc -std=c99 -o comms $(OBJECTS) -lc -lm -lpthread -lncurses

clean:
	-rm comms
	-rm *.o

.c.o:
	gcc -std=c99 -c -o $@ $<
