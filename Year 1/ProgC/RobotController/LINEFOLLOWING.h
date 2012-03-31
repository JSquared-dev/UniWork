/******************************************************************************
* Module name            : Line Following			              *
* Created by              : Silvestrs Timofejevs, 11000746                    *
* Date created            : 31.01.2012.                                       *
******************************************************************************/    

#ifndef _LIGHTFOLLOWING_H_
#define _LIGHTFOLLOWING_H_

extern const int delayUS;			/* ITERATION DELAY */
extern const int TTL;				/* NOTE: actual delay is calculated iteration (delay x TTL)*/						
extern const int table[4];	/* curve table, with motor values */
extern const int STEP_DELAY; 			/* NOTE: actual delay is calculated (iteration delay x stepDelay) */ 
extern const int FULLFWD;
extern const int FULLBCK;

/*--------------- MARCO ANALOGUE INPUT CONFIGURATION ---------------*/
extern const int subdevice;						
extern const int rmotor, lmotor;					
extern const int range;
/*------------------------------------------------------------------*/
int line_following (struct MARCOSETUP_s *MARCOSETUP);

#endif
