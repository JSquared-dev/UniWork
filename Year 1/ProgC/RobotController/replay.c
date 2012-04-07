


#include <stdio.h>
#include <comedilib.h>
#include <ncurses.h>
#include "INIT.h"
#include "joystick.h"
#define RECORDFILE "record.txt"
#define MOTOR_MAX 2048

int replay_start(struct MARCOSETUP_s *setup) {
	
	int time;
	struct motor_s *motorValues = malloc(sizeof(struct motor_s));
	FILE *recordFile = fopen(RECORDFILE, "r");
	
	comedi_t *device = setup->device;
	
	while (1) {
	  int escape = fscanf(recordFile, "%d %d %d\n", &time, &motorValues->left, &motorValues->right);
		if (escape == EOF)
		  break;
		usleep(time); /* delay time is for the previous motor values, so sleep 
					   * before changing motors */
		
		runMotors(device, *motorValues);
	}
	
	return 0;
}
