

OBJECTS := main.o joystick.o 
UTILS := utils/stop.o

.PHONY: all utils clean RobotController

clean:
	-rm -rf stop
	-rm -rf RobotController
	-rm -rf joystick
	-rm -rf *.o

all: RobotController utils
	echo Build complete

RobotController: $(OBJECTS)
	cc -Wall -o $@ $(OBJECTS) -lcomedi -lncurses -lc -lm

utils: $(UTILS)
	cc -Wall -o stop utils/stop.c -lcomedi -lc -lm

.c.o:
	cc -std=c99 -Wall -c -o $@ $<

