/******************************************************************************
* Module name            : Line Following			              *
* Created by              : Silvestrs Timofejevs, 11000746                    *
* Date created            : 31.01.2012.                                       *
******************************************************************************/    

#ifndef _LIGHTFOLLOWING_H_
#define _LIGHTFOLLOWING_H_

#define delayUS 1000			/* ITERATION DELAY */
#define TTL 3000				/* NOTE: actual delay is calculated iteration (delay x TTL)*/						
#define STEP_DELAY 150			/* NOTE: actual delay is calculated (iteration delay x stepDelay) */ 
#define FULLFWD 4000
#define FULLBCK 0

extern const int table[4];	/* curve table, with motor values */

/*--------------- MARCO ANALOGUE INPUT CONFIGURATION ---------------*/
#define subdevice 1
#define rmotor 1
#define lmotor 0			
#define range 1
/*------------------------------------------------------------------*/
int line_following (struct MARCOSETUP_s *MARCOSETUP);

#endif
