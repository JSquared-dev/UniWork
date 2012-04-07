/******************************************************************************
* Module 	          : Marco setup				              *
* Created by              : Silvestrs Timofejevs, 11000746                    *
* Date created            : 31.01.2012.                                       *
******************************************************************************/
#ifndef _DIGITALIO_H_
#define _DIGITALIO_H_

#include <comedi.h>
#include <comedilib.h>
#include "INIT.h"
#define DIGITALREAD 0x00000000		/* comedi device digital read mask */
#define DIGITALWRITE 0x000000ff		/* comedi device digital write mask */

void digitalIO(comedi_t *device, unsigned int IOMask, unsigned int *data, unsigned int ReadMask);
int interruptDetect (struct MARCOSETUP_s *MARCOSETUP);

#endif
