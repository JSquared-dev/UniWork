

.PHONY: all clean

all: main.o
	gcc -std=c99 -o comms main.o -lc -lm -lpthread

clean:
	rm comms
	rm *.o

main.o: main.c
	gcc -std=c99 -c -o $@ $<
