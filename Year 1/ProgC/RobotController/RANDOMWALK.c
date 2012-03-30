#ifndef _RANDOMWALK_C_
#define _RANDOMWALK_C_


#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <getopt.h>
#include <ctype.h>
#include <comedi.h>
#include <comedilib.h>
#include <time.h>
#include "DIGITALIO.c"
#include "LIGHT.c"
#include "STEPMOTOR.c"
#include "INIT.c"

int randomWalk (struct MARCOSETUP_s *MARCOSETUP);

int randomWalk (struct MARCOSETUP_s *MARCOSETUP) {
	const int degreeDelayUs = 6667;				        /* one grade turn delay in uS */
	int FRWRDTIME = 1000000;					/* MARCO buggy forward move time */
	unsigned int stepperState;					/* stepper digital readings */
	unsigned int *stepperDirection = SWIPE_PATTERN_RIGHT;		/* stepper current swipe pattern */
	unsigned int *nextDirection = SWIPE_PATTERN_LEFT;		/* stepper next swipe pattern */
	unsigned int expectedSwitch = MARCOSETUP->stepperRSwitch;	/* current stepper stop switch */
	char swipeDir = 'r';						/* stepmotor swipe direction */
	int counter = 0;						/* step counter */
	int UScounter = 0;						/* delay counter */
	int i = 0;
	int angleRatio;							/* random angle multiplier */
	int angle;							/* angle calculation */
	unsigned int interrupt;						/* reads line or bumper interrupt id */
	int light;							/* light readings */
	
	srand((unsigned)time(0)); 

	while (1) {
		comedi_data_write (MARCOSETUP->device,1, 0, 1, AREF_GROUND, 4000);
		comedi_data_write (MARCOSETUP->device, 1, 1, 1, AREF_GROUND, 4000);
		
		UScounter = 0;
		counter = 0;
		while (UScounter <= FRWRDTIME) {
			for (i = 0; i < 4; i++) {
				/*--------------------INTERRUPTS (LIGHT, LINE, OR BUMPER COLLISION ENCOUNTERED)----------------------------*/			
				interrupt = interruptDetect(MARCOSETUP);
				light = readLight (MARCOSETUP->device, MARCOSETUP->EYE);
				if (light > MININTENSITY) {
		   			comedi_data_write (MARCOSETUP->device,1, 0, 1, AREF_GROUND, 2047);
  					comedi_data_write (MARCOSETUP->device, 1, 1, 1, AREF_GROUND, 2047);
					return 2;
				}									    /* light found */
				else if (interrupt != -1) return interrupt;		                    /* line or bumper collision */
				/*---------------------------------------------------------------------------------------------------------*/
				digitalIO(MARCOSETUP->device, DIGITALWRITE, &stepperDirection[i], 0);
				usleep (MARCOSETUP->stepDelay);
			
				counter++;
				UScounter = MARCOSETUP->stepDelay * counter;		/* counts the time spent in a loop */
				if (UScounter >= FRWRDTIME) break;			/* breaks loop if forward movement time exceeded  */		
				/*-------------------CHANGES STEPMOTOR DIRECTION-----------------------------------------------------------*/
				digitalIO(MARCOSETUP->device, DIGITALREAD, &stepperState, 0x000000ff);
				if (stepperState == expectedSwitch) {					/* if pushed particular switch */
					swapStepperDir(&stepperDirection, &nextDirection, &swipeDir);	/* change stepper movement pattern */
					if (expectedSwitch == MARCOSETUP->stepperRSwitch)		/* change stepper exception switch */
						expectedSwitch = MARCOSETUP->stepperLSwitch;
					else
						expectedSwitch = MARCOSETUP->stepperRSwitch;
				}
				/*---------------------------------------------------------------------------------------------------------*/
			}
		}
		
		angleRatio = rand()%10; 						/* random angle ratio */
		angle = 30 * angleRatio;						/* angle to turn (minimal change 30 degree) */
		UScounter = angle * degreeDelayUs;					/* delay in uS to perform corresponding angle turn */
		comedi_data_write (MARCOSETUP->device,1, 0, 1, AREF_GROUND, 4000);
		comedi_data_write (MARCOSETUP->device, 1, 1, 1, AREF_GROUND, 10);
		i = 0;
		for (counter = 0; counter < UScounter; counter += MARCOSETUP->stepDelay) {
		
			/*--------------------INTERRUPTS (LIGHT, LINE, OR BUMPER COLLISION ENCOUNTERED)----------------------------*/
			interrupt = interruptDetect(MARCOSETUP);
			light = readLight (MARCOSETUP->device, MARCOSETUP->EYE);
			if (light > MININTENSITY) {
		   		comedi_data_write (MARCOSETUP->device,1, 0, 1, AREF_GROUND, 2047);
  				comedi_data_write (MARCOSETUP->device, 1, 1, 1, AREF_GROUND, 2047);
				return 2;
			}										/* light found */
			else if (interrupt != -1) return interrupt;					/* line or bumper collision */
			/*---------------------------------------------------------------------------------------------------------*/
			
			digitalIO(MARCOSETUP->device, DIGITALWRITE, &stepperDirection[i], 0);
			usleep (MARCOSETUP->stepDelay);
			i++;
			if (i == 4) i = 0;
			
			/*-------------------CHANGES STEPMOTOR DIRECTION-----------------------------------------------------------*/
			digitalIO(MARCOSETUP->device, DIGITALREAD, &stepperState, 0x000000ff);
			if (stepperState == expectedSwitch) {					/* if pushed particular switch */
				swapStepperDir(&stepperDirection, &nextDirection, &swipeDir);	/* change stepper movement pattern */
				if (expectedSwitch == MARCOSETUP->stepperRSwitch)	        /* change stepper exception switch */
					expectedSwitch = MARCOSETUP->stepperLSwitch;
				else
					expectedSwitch = MARCOSETUP->stepperRSwitch;
			}
			/*---------------------------------------------------------------------------------------------------------*/
		}
	}  
}
#endif


