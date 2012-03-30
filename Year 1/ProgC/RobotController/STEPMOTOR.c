
#include <comedi.h>
#include <comedilib.h>

#include "STEPMOTOR.h"
#include "DIGITALIO.h"

void stepperSteps (struct MARCOSETUP_s *MARCOSETUP) {
	unsigned int stepperState;
	int i;
	unsigned int *stepperDirection;
	unsigned int LRStepperSwitches = MARCOSETUP->stepperRSwitch + MARCOSETUP->stepperLSwitch;
	MARCOSETUP->stepperSteps = 0;


	stepperDirection = SWIPE_PATTERN_RIGHT;
	digitalIO(MARCOSETUP->device, DIGITALREAD, &stepperState, LRStepperSwitches);

	while (stepperState != MARCOSETUP->stepperRSwitch) {
		for (i = 0; i < 4; i++) {
			digitalIO(MARCOSETUP->device, DIGITALWRITE, &stepperDirection[i], 0);
			usleep (MARCOSETUP->stepDelay);
			digitalIO(MARCOSETUP->device, DIGITALREAD, &stepperState, LRStepperSwitches);
			if (stepperState == MARCOSETUP->stepperRSwitch)		
				break;
		}
	}

	stepperDirection = SWIPE_PATTERN_LEFT;
	while (stepperState != MARCOSETUP->stepperLSwitch) {
		for (i = 0; i < 4; i++) {
			MARCOSETUP->stepperSteps++;
			digitalIO(MARCOSETUP->device, DIGITALWRITE, &stepperDirection[i], 0);
			usleep (MARCOSETUP->stepDelay);
			digitalIO(MARCOSETUP->device, DIGITALREAD, &stepperState, LRStepperSwitches);
			if (stepperState == MARCOSETUP->stepperLSwitch)
				break;
		}
	}
}

