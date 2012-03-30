
#ifndef _INIT_H_
#define	_INIT_H_

/*----------------------- MARCO BUGGY CONFIGURATION, SHARED BETWEEN MODULES ----------------------*/
struct MARCOSETUP_s {
	comedi_t *device;		/* comedi_t type device pointer */
	int stepperSteps;		/* full stepmotor swipe steps */
	int stepDelay;			/* one stepmotor step delay in uS */
	unsigned int stepperRSwitch;	/* RACK digital input code for stepmotor right switch */
	unsigned int stepperLSwitch;	/* RACK digital input code for stepmotor left switch */
	unsigned int bottomRSensor;	/* RACK digital input code for bottom right sensor */
	unsigned int bottomLSensor;	/* RACK digital input code for bottom left sensor */
	unsigned int RBumper;		/* RACK digital input code for right bumper */
	unsigned int LBumper;		/* RACK digital input code for left bumper */
	unsigned int EYE;		/* RACK analogue input channel for EYE */
	unsigned int joystick_X;	/* RACK analogue input channel for Joystick X axis */
	unsigned int joystick_Y;	/* RACK analogue input channel for Joystick Y axis */
};
/*-------------------------------------------------------------------------------------------------*/

void swipeSteps (comedi_t *device, int *fullSwipeSteps);
void initialization (unsigned int in_subdevice, char *filename, comedi_t **device);
int createMARCOSETUP (struct MARCOSETUP_s **MARCOSETUP, comedi_t *device, int stepDelay);
void destroyMARCOSETUP (struct MARCOSETUP_s *MARCOSETUP);
#endif
