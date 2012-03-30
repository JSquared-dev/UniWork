                                 
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <getopt.h>
#include <ctype.h>
#include <comedi.h>
#include <comedilib.h>
#include "LIGHT.h"
#include "INIT.h"
#include "STEPMOTOR.h"
#include "DIGITALIO.h"

/********************************************************************************************************************************************
*	FUNCTION NAME 		: clearLIGHTPOSCALC							   
*	  RETURNS	  	: no return value
*	  *LIGHTPOSCALC	        : structure pointer, for the brightest source calculation
*	CREATED BY		: Silvestrs Timofejevs
*	DATE CREATED		: 10.03.2012.	
*	DESCRIPTION		: Sets default settings needed for the brightest source position identification,
*                                 modifies structure pointed by an argument. 
********************************************************************************************************************************************/
void clearLIGHTPOSCALC(struct LIGHTPOSCALC_s *LIGHTPOSCALC) {
	LIGHTPOSCALC->minIntensity = MININTENSITY;
	LIGHTPOSCALC->maxIntensity = LIGHTPOSCALC->minIntensity;
	LIGHTPOSCALC->maxIntensityTLimit = LIGHTPOSCALC->minIntensity;
	LIGHTPOSCALC->maxIntensityBLimit = LIGHTPOSCALC->minIntensity;
	LIGHTPOSCALC->limit = 200;
	LIGHTPOSCALC->End = 0;
	LIGHTPOSCALC->Start = 0;
	LIGHTPOSCALC->TMPConsecutives = 0;
	LIGHTPOSCALC->Consecutives = 0;
}

/************************************************************************************************************************************************
*	FUNCTION NAME 			: swapStepperDir
*	  RETURNS	  		: no return value															  
*	  **swipePattern		: adress of a pointer to a current swipe direction pattern
*	  **nextSwipePattern	        : adress of a pointer to a next swipe direction pattern
*	  *swipeDir			: pointer to a swipe direction identifier
*	CREATED BY			: Silvestrs Timofejevs
*	DATE CREATED			: 10.03.2012.
*	DESCRIPTION: swaps adress of current swipe pattern with the next swipe pattern adress, and changes direction identifier to	
*	opposite
************************************************************************************************************************************************/
void swapStepperDir (unsigned int **swipePattern, unsigned int **nextSwipePattern, char *swipeDir) {
	unsigned int *swap;		        /* variable helps swap swipe patterns around */

	swap = *swipePattern;
	*swipePattern = *nextSwipePattern;
	*nextSwipePattern = swap;

	if (*swipeDir == 'r') *swipeDir = 'l';
	else *swipeDir = 'r';	
}

/********************************************************************************************************************************************
*	FUNCTION NAME 		: readLight
*	  RETURNS	  	: light intensity															  
*	  *device		: comedi_t type device pointer
*	  channel		: channel used to read analogue output from MARCO EYE
*	CREATED BY		: Silvestrs Timofejevs
*	DATE CREATED		: 10.03.2012.
*	DESCRIPTION		: reads and returns light intensity									
********************************************************************************************************************************************/
unsigned int readLight(comedi_t *device, unsigned int channel) {
	const unsigned int INPUT = 0;				   /* comedi analogue input identifier */
	const unsigned int RANGE = 1;				   /* comedi voltage range identifier (-10 to +10) */
	unsigned int lightIntensity;			           /* holds read light value */

	comedi_data_read(device, INPUT, channel, RANGE, AREF_GROUND, &lightIntensity);
	return lightIntensity;
}

/********************************************************************************************************************************************
*	FUNCTION NAME 		: lightPos
*	  RETURNS	  	: 0 if light source found, -1 if not												  
*	  stepperSteps	        : stepmotor full swipe steps count		
*	  *lightReadings	: pointer to array of light readings corresponding to each stepmotor step
*	  *LIGHTPOSCALC	        : pointer to data structure for brightest light position calculation ( NOTE: is used in multiple functions )
*	CREATED BY		: Silvestrs Timofejevs
*	DATE CREATED		: 10.03.2012.
*	DESCRIPTION		: Calculates the middle point of the most intense and wide light bump
********************************************************************************************************************************************/
int lightPos (int stepperSteps, int *lightReadings, struct LIGHTPOSCALC_s *LIGHTPOSCALC) {
	struct ANGLECALC_s *ANGLECALC = &LIGHTPOSCALC->ANGLECALC;	/* structure for the position calibration */
	int i;
	
	clearLIGHTPOSCALC(LIGHTPOSCALC);		               /* sets default calculation settings */
	for (i = 0; i < stepperSteps; i++) { 	
		LIGHTPOSCALC->End = i;				       /* NOTE: abstract variable, needed to calculate start*/

		/*----------- WHEN FOUND BRIGHTER SOURCE THAN CURRENT BRIGHTEST SOURCE TOP ALIGNMENT ------------*/
		if (lightReadings[i] > LIGHTPOSCALC->maxIntensityTLimit) {
		/*-----------------------------------------------------------------------------------------------*/
			LIGHTPOSCALC->maxIntensity = lightReadings[i];			/* changes maximal intensity */
			/*-------------- MAXINTENSITY BOTTOM ALIGNMENT IS LESS THAN MINIMAL INTENSITY ---------------*/
			if ((LIGHTPOSCALC->maxIntensity - LIGHTPOSCALC->limit) < LIGHTPOSCALC->minIntensity)
				continue;					        /* does not change top and bottom alignment */
			
			/* sets top and bottom alignment accordingly to the new brightest light value
			   saves the start of the current (temporary brightest) bump start position
			   starts the consecutive and temporary consecutive element count - representing
			   brightest bump width. */
			LIGHTPOSCALC->maxIntensityBLimit = LIGHTPOSCALC->maxIntensity - LIGHTPOSCALC->limit;
			LIGHTPOSCALC->maxIntensityTLimit = LIGHTPOSCALC->maxIntensity + LIGHTPOSCALC->limit;
			LIGHTPOSCALC->Consecutives = 1;
			LIGHTPOSCALC->Start = i;
			LIGHTPOSCALC->TMPConsecutives = 1;	
		}
		/*------ LIGHT INTENSITY > THAN MAXINTENSITY BOTTOM ALIGNMENT, BUT LESS THAN TOP ALIGNMENT ------*/
		else if (lightReadings[i] > LIGHTPOSCALC->maxIntensityBLimit) {
			LIGHTPOSCALC->TMPConsecutives++;				/* increments source width */
		}
		/*------------------------- LIGHT INTENSITY IS LESS THAN BOTOM LIMIT ----------------------------*/
		else if (LIGHTPOSCALC->TMPConsecutives > LIGHTPOSCALC->Consecutives) { /* new found light width is wider */
			/* overrites last brightest source data with new */
			LIGHTPOSCALC->Consecutives = LIGHTPOSCALC->TMPConsecutives;
			LIGHTPOSCALC->Start = LIGHTPOSCALC->End - LIGHTPOSCALC->Consecutives;
			LIGHTPOSCALC->TMPConsecutives = 0;  
		}
	}
 
	if (LIGHTPOSCALC->Consecutives == 0) return -1;					/* could not find light, return -1 */
	
	ANGLECALC->angle = LIGHTPOSCALC->Start + LIGHTPOSCALC->Consecutives / 2;	/* finds middle of the brightest light source */
	ANGLECALC->nullPoint = stepperSteps / 2;					/* middle of the stepper swipe steps */
	centreAngle(ANGLECALC);
	return 0;
}

/******************************************************************************************************************
*	FUNCTION NAME 		: centreAngle						   
*	  RETURNS	  	: no return value																	  	
*	  *ANGLECALC		: pointer to data structure for position calibration
*	CREATED BY		: Silvestrs Timofejevs
*	DATE CREATED		: 10.03.2012.			
*	DESCRIPTION		: Calculates the position of the brightest source from the centr point of stepmotor,
*                                 using start of the the most intense bump and direction of stepmotor movement.
*******************************************************************************************************************/
void centreAngle (struct ANGLECALC_s *ANGLECALC) {
	int nullPoint = ANGLECALC->nullPoint;

	/* calculates the position of the brightest step, according to stepper direction and 
	   brightest step position counting from the one of the switches */
	switch (ANGLECALC->direction) {
		case 'r':
			/* if brightest step position from the side - centre ( steps / 2 ) is positive then
			   direction identifier is 'r', and position is pos from the side - centre */
			if (ANGLECALC->angle - nullPoint >= 0) {
				ANGLECALC->angleDir = 'r';
				ANGLECALC->angle = ANGLECALC->angle - nullPoint;
			}
			/* if - then the same only direction identifier is 'l' */
			else if (ANGLECALC->angle - nullPoint < 0) {
				ANGLECALC->angleDir = 'l';
				ANGLECALC->angle = (-1) * (ANGLECALC->angle - nullPoint);
			}
		break;

		case 'l':
			/* if brightest step position from the side - centre ( steps / 2 ) is positive then
			direction identifier is 'l', and position is pos from the side - centre */
			if (ANGLECALC->angle - nullPoint > 0) {
				ANGLECALC->angleDir = 'l';
				ANGLECALC->angle = ANGLECALC->angle - nullPoint;
			}
			/* if - then the same only direction identifier is 'r' */
			else if (ANGLECALC->angle - nullPoint < 0) {
				ANGLECALC->angleDir = 'r';
				ANGLECALC->angle = (-1) * (ANGLECALC->angle - nullPoint);
			}
		break;
		default:
		break;
  }
}

/********************************************************************************************************************************************
*      FUNCTIONNAME 		:followTheLight
* 	 RETURNS	  	: no return value	
*	 *MARCOSETUP		: pointer to essential shared structure between all modules of the program		
*	 *LIGHTPOSCALC		: pointer to data structure for brightest light position calculation (NOTE: is being used in multiple functions)
*     CREATED BY		: Silvestrs Timofejevs				
*     DATE CREATED		: 10.03.2012.	
*     DESCRIPTION		: Puts power on corresponding motor proportionaly to the brightest element position, if it is last element
*                                 from the right of the centre, then full power on left motor, right motor turned off and opposite.	
********************************************************************************************************************************************/
void followTheLight (struct MARCOSETUP_s *MARCOSETUP,  struct LIGHTPOSCALC_s *LIGHTPOSCALC) {
	
	unsigned int motorMAX = 4000;				/* MARCO buggy motor max spead */
	unsigned int lmotor = motorMAX;				/* MARCO buggy left motor */
	unsigned int rmotor = motorMAX;				/* MARCO buggy right motor */
	float valueFloat;					/* Proportion precision varible (temporary) */
	unsigned int valueInt;					/* Motor proportion variable */
	
	/* motor proportion calculation, motor max value divided by half of swipe steps multiplied by the 
	   brightest element position from the centre */
	valueFloat = ((float) motorMAX / LIGHTPOSCALC->ANGLECALC.nullPoint) * LIGHTPOSCALC->ANGLECALC.angle;
	valueInt = (int)valueFloat;			   /* drops off decimal part of light following proportion value */	
	
	/*------------------ PROPORTIONAL DECREMENT OF CORRESPONDING MOTOR VALUE ----------------------------*/
	if (LIGHTPOSCALC->ANGLECALC.angleDir == 'r') {
		lmotor -= valueInt;
	}
	else if (LIGHTPOSCALC->ANGLECALC.angleDir == 'l') {
		rmotor -= valueInt;
	}
	/*--------------------------------------- RACK MOTOR VALUE OUTPUT ------------------------------------*/
	comedi_data_write (MARCOSETUP->device,1, 0, 1, AREF_GROUND, rmotor);
	comedi_data_write (MARCOSETUP->device, 1, 1, 1, AREF_GROUND, lmotor);
	
}

/********************************************************************************************************************************************
*	FUNCTION NAME 		: lightFollowing			  
*	  RETURNS	  	: 0 on line encounter, 1 on bumper collision
*	  *MARCOSETUP		: pointer to essential shared structure between all modules of the program
*	CREATED BY		: Silvestrs Timofejevs
*	DATE CREATED		: 10.03.2012.
*	DESCRIPTION		: scans for the light, and proportionally drives MARCO buggy towards the brightest source, runs until line 
*	or bumper collision is encountered.
********************************************************************************************************************************************/
int lightFollowing (struct MARCOSETUP_s *MARCOSETUP) {
	struct LIGHTPOSCALC_s LIGHTPOSCALC;			   /* structure for the brightest step calculation */
	unsigned int *swipePattern = SWIPE_PATTERN_RIGHT;          /* current stepmotor swipe pattern */
	unsigned int *nextSwipePattern = SWIPE_PATTERN_LEFT;	   /* next stepmotor swipe pattern */
	unsigned int expectedSwitch = MARCOSETUP->stepperRSwitch;  /* current direction swipe stop switch */

	unsigned int stepperState = 0;				   /* variable used to read digital input from rack */
	int *lightReadings = NULL; 				   /* pointer to a light reading array */		
	int interrupt;						   /* holds interrupt code */
	int i, counter;
	int index = 0;						   /* index, when 0 ignores iteration (NOTE: is 0 only durring first iteration) */			
	
	LIGHTPOSCALC.ANGLECALC.direction = 'r';			   /* stepmotor direction */

	/* performs initial swipe if have not been made already */
	if (MARCOSETUP->stepperSteps == 0)
		stepperSteps(MARCOSETUP);				
	
	/*-------- ALOCATES DATA FOR THE LIGHT READING ACCORDING TO FULL STEPMOTOR SWIPE STEP COUNT ---------------------------*/
	lightReadings = (int*) malloc(sizeof(int) * MARCOSETUP->stepperSteps);
	if (lightReadings == NULL)    /* returns -1 if failed to reserve data */					
		return -1;
	/*---------------------------------------------------------------------------------------------------------------------*/
	
	while (1) {
		counter = 0;
		/*------------------------------- TAKES LIGHT READINGS UNTIL SWITCH IS ENCOUNTERED --------------------------------*/
		while (stepperState != expectedSwitch) {
			for (i = 0; i < 4; i++) {	  /* stepper movement substeps */
				/*--------------------INTERRUPTS (LIGHT, LINE, OR BUMPER COLLISION ENCOUNTERED)----------------------------*/			
				interrupt = interruptDetect(MARCOSETUP);					
				if (interrupt != -1) return interrupt;	  /* returns -1, if no exception, 1 on bumper collision, 0 on line */			
				/*---------------------------------------------------------------------------------------------------------*/
				digitalIO(MARCOSETUP->device, DIGITALWRITE, &swipePattern[i], 0);	
				usleep (MARCOSETUP->stepDelay);
				
				/* writes light readings,if step count is less than initial swipe step count (prevents, false data access) */
				if (counter < MARCOSETUP->stepperSteps)
					lightReadings[counter] = readLight(MARCOSETUP->device, MARCOSETUP->EYE);
				counter++;											
			
				/*-------------------CHANGES STEPMOTOR DIRECTION-----------------------------------------------------------*/
				digitalIO(MARCOSETUP->device, DIGITALREAD, &stepperState, 0x000000ff);
				if (stepperState == expectedSwitch) 		/* breaks the stepmotor drive if switch is encountered */				
					break;
				/*---------------------------------------------------------------------------------------------------------*/
			}
		}

		/* --------------- IGNORES FIRST ITERATION (NEEDED TO ACHIEVE TRANSITION FROM RANDOM WALK) ------------------*/
		if (index != 0)
			if (lightPos (MARCOSETUP->stepperSteps, lightReadings, &LIGHTPOSCALC) == -1) return 2; 
				followTheLight (MARCOSETUP,  &LIGHTPOSCALC);
		index = 1;
		
		/*-------------------CHANGES STEPMOTOR EXPECTED SWITCH-------------------------------------------------------*/
			swapStepperDir(&swipePattern, &nextSwipePattern, &LIGHTPOSCALC.ANGLECALC.direction);	
			if (expectedSwitch == MARCOSETUP->stepperRSwitch) expectedSwitch = MARCOSETUP->stepperLSwitch;
			else expectedSwitch = MARCOSETUP->stepperRSwitch;
		/*-----------------------------------------------------------------------------------------------------------*/
		
	}
	free (lightReadings);										
	return 0;
}

