/******************************************************************************
* Module 	          : Marco setup				              *
* Created by              : Silvestrs Timofejevs, 11000746                    *
* Date created            : 31.01.2012.                                       *
******************************************************************************/    
#ifndef _INIT_C_
#define _INIT_C_
#include <stdio.h>
#include <stdlib.h>
#include "INIT.h"
#include "STEPMOTOR.c"


/************************************************************************************************************************
* FUNCTION NAME 	: createMARCOSETUP
*   RETURNS		: 0 on success, -1 on fail
*   **MARCOSETUP	: passes adress of a pointer to MARCOSETUP_s structure for the initialization purposes
*   *device		: comedi_t type device handle
*   stepDelay	        : stepmotor one step delay
* CREATED BY		: Silvestrs Timofejevs
* DATE  CREATED		: 3.03.2012
* DESCRIPTION		: Allocates memory for the MARCO buggy configuration structure, sets all data to default.
************************************************************************************************************************/
int createMARCOSETUP (struct MARCOSETUP_s **MARCOSETUP, comedi_t *device, int stepDelay) {

    /*---------------- ALOCATES DATA, FOR MARCOSETUP_s TYPE POINTER, RETURNS -1 ON FAIL -------------------*/
	
	*MARCOSETUP =(struct MARCOSETUP_s*) malloc (sizeof(struct MARCOSETUP_s));
	if (*MARCOSETUP == NULL)
		return -1;	
	/*-----------------------------------------------------------------------------------------------------*/	
	(*MARCOSETUP)->stepperSteps = 0;
	(*MARCOSETUP)->device = device;
	(*MARCOSETUP)->stepDelay = stepDelay;
	(*MARCOSETUP)->stepperRSwitch = 0x00000080;
	(*MARCOSETUP)->stepperLSwitch = 0x00000040;
	(*MARCOSETUP)->bottomRSensor = 0x00000002;
	(*MARCOSETUP)->bottomLSensor = 0x00000001;
	(*MARCOSETUP)->RBumper = 0x00000008;
	(*MARCOSETUP)->LBumper = 0x00000004;
	(*MARCOSETUP)->EYE = 3;
	(*MARCOSETUP)->joystick_X = 1;
	(*MARCOSETUP)->joystick_Y = 2;
	return 0;
}

/************************************************************************************************************************
* FUNCTION NAME 	: destroyMARCOSETUP
*   RETURNS		: no return value
*   **MARCOSETUP	: passes adress of a pointer to MARCOSETUP_s structure for destruction purpose
* CREATED BY		: Silvestrs Timofejevs
* DATE CREATED		: 3.03.2012
* DESCRIPTION		: Allocates memory for the MARCO buggy configuration structure, sets all data to default.
************************************************************************************************************************/
void destroyMARCOSETUP (struct MARCOSETUP_s *MARCOSETUP) {
	free (MARCOSETUP);
}

 /*****************************************************************************
 * Function name         : initialization                                     *
 *   Returns             : no return value                                    *
 *   in_subdevice        : passes id of a subdevice                           *
 *   *filename           : pointer to file location variable                  *
 *   **device            : passes adress of a comedi_t type device handle     *
 * into function.                                                             *
 * Created by            : Silvestrs Timofejevs                               *
 * Date created          : 17.11.2011.                                        *
 * Description           : Opens the comedi device, checks if there is a      *
 * valid bidirectional DIO port subdevice, configures ports for output.       *
 * Modifies device handle variable in main()                                  *
 *****************************************************************************/
void initialization (unsigned int in_subdevice, char *filename, comedi_t **device)
{ 
  int stype;
  int i, retval;

  /* open the comedi device, exit with error message if something goes wrong. */
  *device=comedi_open(filename);
  if(!(*device)) {
    comedi_perror(filename);
    exit(0);
  }

  /* check we have a valid bidirection DIO port subdevice*/
  stype = comedi_get_subdevice_type(*device, in_subdevice);
  if(stype!=COMEDI_SUBD_DIO) {
    printf("%d is not a digital I/O subdevice\n", in_subdevice);
    exit(0);
  }

  /* configure ports for output */
  for(i=0;i<8;i++)
    retval=comedi_dio_config(*device, in_subdevice,i,COMEDI_OUTPUT); 
}
#endif
