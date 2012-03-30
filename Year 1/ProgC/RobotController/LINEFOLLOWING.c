/******************************************************************************
* Module name           ` : Line Following									  *
* Created by              : Silvestrs Timofejevs, 11000746                    *
* Date created            : 31.01.2012.                                       *
******************************************************************************/ 
                                
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <getopt.h>
#include <ctype.h>
#include <comedi.h>
#include <comedilib.h>
#include "INIT.h"
#include "DIGITALIO.h"
#include "LINEFOLLOWING.h"


/****************************************************************************************************************************************
*	FUNCTION NAME 	: line_following			   
*	  RETURNS	: 1 on bumper collision, returns 0 on line loose
*	  *MARCOSETUP	: structure with RACK pin configuration, essential calculations and data
*	CREATED BY      : Silvestrs Timofejevs
*	DATE CREATED	: 31.01.2012.
*	DESCRIPTION	: Function drives MARCO buggy to follow a white line. On line loose or physical obstruction returns appropriate	
*	                  exception ID.
****************************************************************************************************************************************/
int line_following (struct MARCOSETUP_s *MARCOSETUP) { 							
  	int lmotor_val, rmotor_val;							/* MARCO left and right motors */
  	int ms_counter = 0;								/* curve table delay counter */
	int TTL_counter = 0;								/* line loose counter */
	unsigned int state;								/* sensor state */
	int bottomSensors = MARCOSETUP->bottomLSensor + MARCOSETUP->bottomRSensor;	/* both bottom sensor code */
	int bumpers = MARCOSETUP->LBumper + MARCOSETUP->RBumper;			/* both bumper code */
	int index1 = 0;									/* curve table index */									
  
	/*--------- INFINITE LOOP, EXIT WHEN LINE LOST OR OBSTRUCTION ENCOUNTERED ---------- */ 
  	while (1) {		
		digitalIO(MARCOSETUP->device, DIGITALREAD, &state, 0x000000ff);		/* reads digital input from rack */
		if ((state & bumpers) != 0)						/* bumper collision, return exception id */
			return 1;
		/*----------- CURVES LEFT -------------*/
		else if ((state & bottomSensors) == 0) {				/* both sensors off the line */
			rmotor_val = table[ index1 ];
			lmotor_val = FULLFWD;
			
			/* changes curve strength in 4 steps */
			if ((ms_counter >= STEP_DELAY) && (index1 < 3)) {  /* if transition time-out between curve states has not been reached */
	 			 ms_counter = 0;
	  			 index1++;
			}
			TTL_counter++;
			ms_counter++;
		}
		/*----------- CURVES RIGHT -----------*/
		else if ((state & bottomSensors) == MARCOSETUP->bottomLSensor) {  /* left sensor on the line */
			rmotor_val = FULLFWD;			
			lmotor_val = FULLBCK;
		}
		/*----------- MOVES FORWARD ----------*/
		else if ((state & bottomSensors) == MARCOSETUP->bottomRSensor) {  /* right sensor on the line */
			rmotor_val = FULLFWD;
			lmotor_val = FULLFWD;
		}
		/*----------- CURVES RIGHT -----------*/
		else if ((state & bottomSensors) == bottomSensors) {  /* both sensors on the line */
			rmotor_val = FULLFWD;
			lmotor_val = FULLBCK;
		}

		/*---------- RESETS ALL RELEVANT COUNTERS ON TRANSITION FROM OFF TO ON THE LINE ----------------*/
		if ((state & bottomSensors) != 0) {
			ms_counter = 0;
			TTL_counter = 0;
			index1 = 0;	
		}
		/*----------------------------------------------------------------------------------------------*/

 		if (TTL_counter >= TTL)		/* line have been lost */
    			return 0;
		
  		comedi_data_write (MARCOSETUP->device, 1, lmotor, range, AREF_GROUND, lmotor_val);	  /* Set left motor value */
  		comedi_data_write (MARCOSETUP->device, 1, rmotor, range, AREF_GROUND, rmotor_val);	  /* Set right motor value */
  		usleep (delayUS);									  /* iteration delay */
	}
}
#endif


