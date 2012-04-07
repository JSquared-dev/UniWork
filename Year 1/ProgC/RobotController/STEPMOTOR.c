
#include <comedi.h>
#include <comedilib.h>

#include "STEPMOTOR.h"
#include "DIGITALIO.h"

const unsigned int SWIPE_PATTERN_RIGHT[4]= {2,4,1,8};
const unsigned int SWIPE_PATTERN_LEFT[4] = {8,1,4,2};

void stepperSteps (struct MARCOSETUP_s *MARCOSETUP) {
  unsigned int *stepperState = malloc(sizeof(unsigned int));
	int i;
	unsigned int stepperDirection[4] = {0,0,0,0};// = malloc(sizeof(unsigned int) * 4);
	unsigned int LRStepperSwitches = MARCOSETUP->stepperRSwitch + MARCOSETUP->stepperLSwitch;
	MARCOSETUP->stepperSteps = 0;


	stepperDirection[0] = SWIPE_PATTERN_RIGHT[0];
	stepperDirection[1] = SWIPE_PATTERN_RIGHT[1];
	stepperDirection[2] = SWIPE_PATTERN_RIGHT[2];
	stepperDirection[3] = SWIPE_PATTERN_RIGHT[3];
	digitalIO(MARCOSETUP->device, DIGITALREAD, stepperState, LRStepperSwitches);

	while ((*stepperState & MARCOSETUP->stepperRSwitch)) {
		for (i = 0; i < 4; i++) {
		  digitalIO(MARCOSETUP->device, DIGITALWRITE, &(stepperDirection[i]), 0);
			usleep (MARCOSETUP->stepDelay);
			digitalIO(MARCOSETUP->device, DIGITALREAD, stepperState, LRStepperSwitches);
			if (!(*stepperState & MARCOSETUP->stepperRSwitch))		
				break;
		}
	}

	stepperDirection[0] = SWIPE_PATTERN_LEFT[0];
	stepperDirection[1] = SWIPE_PATTERN_LEFT[1];
	stepperDirection[2] = SWIPE_PATTERN_LEFT[2];
	stepperDirection[3] = SWIPE_PATTERN_LEFT[3];
	while (*stepperState & MARCOSETUP->stepperLSwitch) {
		for (i = 0; i < 4; i++) {
			MARCOSETUP->stepperSteps++;
			digitalIO(MARCOSETUP->device, DIGITALWRITE, &(stepperDirection[i]), 0);
			usleep (MARCOSETUP->stepDelay);
			digitalIO(MARCOSETUP->device, DIGITALREAD, stepperState, LRStepperSwitches);
			if (!(*stepperState & MARCOSETUP->stepperLSwitch))
				break;
		}
	}
}

