/******************************************************************************
* Module name            : Line Following			              *
* Created by              : Silvestrs Timofejevs, 11000746                    *
* Date created            : 31.01.2012.                                       *
******************************************************************************/    

#ifndef _LIGHTFOLLOWING_H_
#define _LIGHTFOLLOWING_H_

const int delayUS = 1000;			/* ITERATION DELAY */
const int TTL = 3000;				/* NOTE: actual delay is calculated iteration (delay x TTL)*/						
const int table[4] = {2400, 2200, 2047, 0 };	/* curve table, with motor values */
const int STEP_DELAY = 150; 			/* NOTE: actual delay is calculated (iteration delay x stepDelay) */ 
const int FULLFWD = 4000;
const int FULLBCK = 0;

/*--------------- MARCO ANALOGUE INPUT CONFIGURATION ---------------*/
const int subdevice = 1;						
const int rmotor = 1, lmotor = 0;					
const int range = 1;
/*------------------------------------------------------------------*/
int line_following (struct MARCOSETUP_s *MARCOSETUP);

#endif
