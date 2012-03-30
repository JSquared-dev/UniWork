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

   while(task != '0') {
	system("clear");
   	printf ("\n ***************************************");
	printf ("\n *  0) Exit.                           *");
   	printf ("\n *  1) MARCO buggy line following.     *");
   	printf ("\n *  2) MARCO buggy light following.    *");
   	printf ("\n *  3) MARCO buggy joystick drive.     *");
   	printf ("\n *  4) MARCO buggy path retracing.     *");
   	printf ("\n *  5) MARCO buggy subsumptional task. *");
   	printf ("\n ***************************************");
   
   	printf ("\n\n Please choose the task ( 0 - 5 ): ");
   	task = getchar ();

   	switch (task) {
		case '1':
			printf ("\n Line following is currently running!");
			printf ("\n To stop execution, activate buggy bumpers!");
			fflush(stdout);
			line_following(MARCOSETUP);
		        comedi_data_write (device,1, 0, 1, AREF_GROUND, 2047);
		  	comedi_data_write (device, 1, 1, 1, AREF_GROUND, 2047);
		break;

		case '2':
			printf ("\n Light following is currently running!");
			printf ("\n To stop execution, activate buggy bumpers!");
			fflush(stdout);
			lightFollowing(MARCOSETUP);
		        comedi_data_write (device,1, 0, 1, AREF_GROUND, 2047);
		  	comedi_data_write (device, 1, 1, 1, AREF_GROUND, 2047);
		break;	
	
		case '5':
			index = randomWalk(MARCOSETUP);
			printf ("\n Main task is running!");
			printf ("\n To stop execution, activate buggy bumpers!");
			fflush(stdout);
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

