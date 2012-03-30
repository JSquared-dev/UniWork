/******************************************************************************
* Module 	          : DIGITALIO			                      *
* Created by              : Silvestrs Timofejevs, 11000746                    *
* Date created            : 31.01.2012.                                       *
******************************************************************************/ 
#ifndef _DIGITALIO_C_
#define _DIGITALIO_C_

#include <stdio.h>
#include <stdlib.h>
#include "DIGITALIO.h"

/********************************************************************************************************
* FUNCTION NAME	: digitalIO
*   RETURNS	: no return value
*   *device	: comedi_t type device handle
*   IOMask	: input or output mask
*   *data	: pointer to a IO operation data variable
*   ReadMask	: Mask for data read
* CREATED BY	: Silvestrs Timofejevs
* DATE CREATED	: 04.03.2012.
* DESCRIPTION	: Function for digital read and write, uses standard comedi dio function, on data read,
*                 takes last parameter as a mask, for the read data.
*                 NOTE: on write, last parameter may take any value and is irelevant.
********************************************************************************************************/
void digitalIO(comedi_t *device, unsigned int IOMask, unsigned int *data, unsigned int ReadMask) {
  const unsigned int subdevice = 2; /* IO */ 
 
  comedi_dio_bitfield(device, subdevice, IOMask, data);	 /* comedi device bidirectional IO */
  if (IOMask == DIGITALREAD) {
	*data &= 0x0000ff00;                  	      	/* obtains switch pattern */
	*data = *data >> 8;				/* moves switch pattern to first byte */
	*data = ~(*data);				/* inverts data to get active high result */
	*data &= ReadMask;	                      	/* masks the needed bits */
  }
}

/********************************************************************************************************
* FUNCTION NAME		: interruptDetect
*    RETURNS		: interrupt ID ( 0 - line, 1 - bumpers )
*   *MARCOSETUP		: pointer to essential shared structure between all modules of the program
* CREATED BY		: Silvestrs Timofejevs
* DATE CREATED		: 04.03.2012.
* DESCRIPTION		: Function reads RACK for bottom sensor and bumper activity, if such activity
*			  is encountered, returns 0 on line encounter, 1 on bumper collision.
********************************************************************************************************/
int interruptDetect (struct MARCOSETUP_s *MARCOSETUP) {
	unsigned int sensors;								/* rack input digital data */
	unsigned int line = MARCOSETUP->bottomLSensor + MARCOSETUP->bottomRSensor;	/* line mask */
	unsigned int bumpers = MARCOSETUP->LBumper + MARCOSETUP->RBumper;		/* bumper mask */
	const int DEFINITE_LINE = 10000;						/* line check delay */
	
	digitalIO(MARCOSETUP->device, DIGITALREAD, &sensors, 0x000000ff);
	/*---------------------- WHITE SPOT FOUND ------------------------------*/
	if ((sensors & line) != 0) {
		usleep (DEFINITE_LINE);
		digitalIO(MARCOSETUP->device, DIGITALREAD, &sensors, line);
	/*---------------------- WHITE SPOT IS A LINE --------------------------*/
		if (sensors != 0) {
		   comedi_data_write (MARCOSETUP->device,1, 0, 1, AREF_GROUND, 2047);
   		   comedi_data_write (MARCOSETUP->device, 1, 1, 1, AREF_GROUND, 2047);
		   return 0;
		}	  
	}
	/*------------------------ BUMPER COLLISION ----------------------------*/
	if ((sensors & bumpers) != 0) {
	   	comedi_data_write (MARCOSETUP->device,1, 0, 1, AREF_GROUND, 2047);
   		comedi_data_write (MARCOSETUP->device, 1, 1, 1, AREF_GROUND, 2047);
		return 1;
	}

	return -1;	/* <-------------------------------  no exception, return -1 */
}
#endif
