#ifndef _LIGHT_H_
#define _LIGHT_H_
#include "INIT.h"

const int MININTENSITY = 2250;	/* minimal light intensity */

/* data to calculate brightest element position from centre */
struct ANGLECALC_s {
	char direction;		/* stepper swipe direction */
	char angleDir;		/* brightest element centralized direction */
	int angle;		/* centralized element pos */
	int nullPoint;		/* middle point of full swipe */
};

/* brightest element position and with calculation */
struct LIGHTPOSCALC_s {
	struct ANGLECALC_s ANGLECALC;
	/*------------ ALL ELEMENTS IN BETWEEN MAX INTENSITY TOP AND BOTTOM LIMIT ARE CONSIDERED IN CURRENT BRIGHTEST BUMP ------------*/
	int minIntensity;		/* minimal light intensity */
	int maxIntensity;		/* maximal light intensity middle point */
	int maxIntensityTLimit;		/* max intensity top limit (new light source is considered more intensive if more intense) */
	int maxIntensityBLimit;		/* max intensity bottom limit */
	/*-----------------------------------------------------------------------------------------------------------------------------*/
	int limit;			/* in correspondance with maxIntensity sets BLimit and TLimit */
	int End;			/* final element of the current brightest bump */
	int Start;			/* start element of the current brightest bump */
	int TMPConsecutives;		/* currently calculated bump width */
	int Consecutives;		/* current widest bump width */
};

void swapStepperDir (unsigned int **swipePattern, unsigned int **nextSwipePattern, char *swipeDir);
int lightFollowing (struct MARCOSETUP_s *MARCOSETUP);
unsigned int readLight (comedi_t *device, unsigned int channel);
void followTheLight (struct MARCOSETUP_s *MARCOSETUP,  struct LIGHTPOSCALC_s *LIGHTPOSCALC);
void centreAngle (struct ANGLECALC_s *ANGLECALC);
void clearLIGHTPOSCALC(struct LIGHTPOSCALC_s *LIGHTPOSCALC);
int lightPos (int stepperSteps, int *lightReadings, struct LIGHTPOSCALC_s *LIGHTPOSCALC);
#endif
