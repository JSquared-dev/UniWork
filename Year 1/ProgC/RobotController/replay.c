


#include <stdio.h>
#include <comedilib.h>
#include <ncurses.h>

#define RECORDFILE "record.txt"
#define MOTOR_MAX 2048
extern void runMotors(comedi_t *device, int left, int right);

int replay_start() {
	
	int time, leftMotor, rightMotor;
	char *filename = "/dev/comedi0";
	FILE *recordFile = fopen(RECORDFILE, "r");
	
	comedi_t *device = comedi_open(filename);
	if (!device) {
		comedi_perror(filename);
		return 1;
	}
	
	initscr(); /* initialise ncurses */
	timeout(0);/* nonblock input through ncurses */
	
	while ((getch() != 'q')) {
		fscanf(recordFile, "%d %d %d\n", &time, &leftMotor, &rightMotor);
		
		usleep(time); /* delay time is for the previous motor values, so sleep 
					   * before changing motors */
		
		runMotors(device, leftMotor, rightMotor);
	}
	
	endwin();
	
	comedi_close(device);
	
	return 0;
}
