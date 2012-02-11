

OBJECTS := main.c
UTILS := utils/stop.c

.PHONY: all utils clean joystick

clean:
	-rm -rf stop
	-rm -rf RobotController
	-rm -rf joystick
	-rm -rf *.o

all: $(OBJECTS) utils
	cc -std=c99 -Wall -o RobotController $(OBJECTS) -lcomedi -lncurses -lc -lm

utils: utils/stop.c
	cc -std=c99 -Wall -o stop utils/stop.c -lcomedi -lc -lm

joystick: joystick.c
	cc -std=c99 -Wall -o joystick joystick.c -lcomedi -lc -lm

linefollow: linefollow.c
	cc -std=c99 -Wall -o linefollow linefollow.c -lcomedi -lc -lm