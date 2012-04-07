
#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>
#include "LIGHT.h"
#include "LINEFOLLOWING.h"
#include "STEPMOTOR.h"
#include "RANDOMWALK.h"

int joystick_start(struct MARCOSETUP_s *setup);
void calibrateJoystick(comedi_t *device, struct joystick_calib *calib);

int main (int argc, char **argv) {
	comedi_t *device;
	unsigned int subdevice = (2);
	char *filename = "/dev/comedi0";
	struct MARCOSETUP_s *MARCOSETUP = malloc(sizeof(struct MARCOSETUP_s));
	int index;
	char task;
	
	initialization (subdevice, filename, &device);
	createMARCOSETUP (&MARCOSETUP, device, 3000);
	stepperSteps(MARCOSETUP);

	initscr();
	scrollok(stdscr, TRUE);

	calibrateJoystick(device, &MARCOSETUP->joystickCalib);
	
	while(task != '0') {
	  clear();
		printw ("\n ***************************************");
		printw ("\n *  0) Exit.                           *");
		printw ("\n *  1) MARCO buggy line following.     *");
		printw ("\n *  2) MARCO buggy light following.    *");
		printw ("\n *  3) MARCO buggy joystick drive.     *");
		printw ("\n *  4) MARCO buggy path retracing.     *");
		printw ("\n *  5) MARCO buggy subsumptional task. *");
		printw ("\n ***************************************");
		
		printw ("\n\n Please choose the task ( 0 - 5 ): ");
		refresh();
		task = getch();
		
		switch (task) {
			case '1':
				printw ("\n Line following is currently running!");
				printw ("\n To stop execution, activate buggy bumpers!");
				refresh();
				line_following(MARCOSETUP);
		        comedi_data_write (device,1, 0, 1, AREF_GROUND, 2047);
				comedi_data_write (device, 1, 1, 1, AREF_GROUND, 2047);
				break;
				
			case '2':
				printw ("\n Light following is currently running!");
				printw ("\n To stop execution, activate buggy bumpers!");
				refresh();
				lightFollowing(MARCOSETUP);
		        comedi_data_write (device,1, 0, 1, AREF_GROUND, 2047);
				comedi_data_write (device, 1, 1, 1, AREF_GROUND, 2047);
				break;	
		case '3':
		  printw("\n Joystick is running");
		  refresh();
		  joystick_start(MARCOSETUP);
		  break;
		case '4':
		  printw("\n Replaying last joystick run");
		  refresh();
		  replay_start(MARCOSETUP);
		  break;
			case '5':
				index = randomWalk(MARCOSETUP);
				printw ("\n Main task is running!");
				printw ("\n To stop execution, activate buggy bumpers!");
				refresh();
				while (1) {
					switch (index) {
						case 0:
							index = line_following(MARCOSETUP);
							if (index == 0) index = 3;						
							break;
							
						case 1:
		 					joystick_start(MARCOSETUP);
							index = 0;
							break;
							
						case 2:
							index = lightFollowing(MARCOSETUP);
							if (index == 2) index = 3;
							break;
							
						case 3:
							index = randomWalk(MARCOSETUP);	
							break;
					}
				}
				break;
			default:
				break;
		}
	} 
	destroyMARCOSETUP (MARCOSETUP);
	comedi_data_write (device,1, 0, 1, AREF_GROUND, 2047);
	comedi_data_write (device, 1, 1, 1, AREF_GROUND, 2047);
	endwin();
	return 0;
}

