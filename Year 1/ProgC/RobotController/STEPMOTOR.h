#ifndef _STEPMOTOR_H_
#define _STEPMOTOR_H_
#include "INIT.h"

const extern unsigned int SWIPE_PATTERN_RIGHT[4];
const extern unsigned int SWIPE_PATTERN_LEFT[4];

void stepperSteps (struct MARCOSETUP_s *MARCOSETUP);
void completeSwipe (struct MARCOSETUP_s *MARCOSETUP);
#endif
