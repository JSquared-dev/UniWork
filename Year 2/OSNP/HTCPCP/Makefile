
OUTPUT := ./bin/client ./bin/server

CC := gcc
CFLAGS := -Wall -c -g
LDFLAGS := -lc

all: $(OUTPUT)

clean:
	-make clean -C client -C ../server
	-rm $(OUTPUT)

./bin/client: ./client/client
	cp client/client bin/client

./bin/server: ./server/server
	cp server/server bin/server

./client/client:
	make -C client

./server/server:
	make -C server