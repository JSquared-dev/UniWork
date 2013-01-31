

OBJECTS := main.o
CC := gcc
CFLAGS := -Wall -g -c
LDFLAGS := -lc


all: $(OBJECTS)
	$(CC) $(LDFLAGS) -o client $(OBJECTS)

clean:
	-rm client
	-rm $(OBJECTS)

.c.o:
	$(CC) $(CFLAGS) -o $@ $<
