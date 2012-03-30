#ifndef _STEPMOTOR_H_
#define _STEPMOTOR_H_
#include "INIT.h"

unsigned int SWIPE_PATTERN_RIGHT[4]= {2,4,1,8};
unsigned int SWIPE_PATTERN_LEFT[4] = {8,1,4,2};

void stepperSteps (struct MARCOSETUP_s *MARCOSETUP);
void completeSwipe (struct MARCOSETUP_s *MARCOSETUP);
#endif
