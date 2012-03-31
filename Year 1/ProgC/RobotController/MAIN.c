
#include <stdio.h>
#include <ncurses.h>
#include "LIGHT.h"
#include "LINEFOLLOWING.h"
#include "STEPMOTOR.h"
#include "RANDOMWALK.h"

int main () {
	comedi_t *device;
	unsigned int subdevice = 2;
	char *filename = "/dev/comedi0";
	struct MARCOSETUP_s *MARCOSETUP;
	int index;
	char task;
	
	initialization (subdevice, filename, &device);
	createMARCOSETUP (&MARCOSETUP, device, 3000);
	stepperSteps(MARCOSETUP);
	
	initscr();

	while(task != '0') {
		system("clear");
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
							comedi_data_write (device,1, 0, 1, AREF_GROUND, 2047);
							comedi_data_write (device, 1, 1, 1, AREF_GROUND, 2047);
							return 0;
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
	return 0;
}

