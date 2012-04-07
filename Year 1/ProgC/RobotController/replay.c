


#include <stdio.h>
#include <comedilib.h>
#include <ncurses.h>

#define RECORDFILE "record.txt"

void runMotors(comedi_t *device, struct motor_s motorValues);

int main(int argc, char **argv) {
	
	int time, left, right;
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

void runMotors(comedi_t *device, int left, int right) {
	
	/* values on motors are 0 to 4097 inclusive. make sure we are always within this range */
	if (left > MOTOR_MAX*2) {
		left = (MOTOR_MAX*2) - 1;
	}
	else if (left < 0) {
		left = 0;
	}
	
	if (right > MOTOR_MAX*2) {
		right = (MOTOR_MAX*2) - 1;
	}
	else if (right < 0) {
		right = 0;
	}
	
	comedi_data_write(device, 1, 0, 1, AREF_GROUND, left); /* left motor */
	comedi_data_write(device, 1, 1, 1, AREF_GROUND, right); /* right motor */
}
