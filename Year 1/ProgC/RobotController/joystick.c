
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <comedilib.h>
#include <math.h>

	//int usleep(useconds_t usec);
#define PI 3.1415926535897	/* PI for converting radians to degrees easily */
#define RAD_TO_DEG(x) ((x/PI)*180)
#define MOTOR_MAX 2048		/* max value a motor can be in 1 direction. multiply by 2 to get max 
* value a motor can be. */

/* for compile testing. remove ASAP */
#ifndef AREF_GROUND
typedef unsigned int comedi_t;
#define AREF_GROUND 0
extern comedi_t *comedi_open(char *);
extern void comedi_perror(char *device);
extern void comedi_close(comedi_t *device);
extern void comedi_data_read(comedi_t *device, int, int, int, int, int *);
extern void comedi_data_write(comedi_t *device, int, int, int, int, int);
#endif

struct joystick {
	int x, y; /* value of joystick on x and y axes */
};

struct motor_s {
	int left, right;
};

struct joystick_calib {
	struct joystick neutral;			/* base values for analogue joystick position values */
	int forward, backward;
	int left, right;
	double stepBlock;		/* motor voltage value delta per unit change on joystick */
};

void calibrateJoystick(comedi_t *device, struct joystick_calib *calibration);
void readJoystick(comedi_t *device, struct joystick *joystickData);
void calculateMotorValue(struct joystick_calib calibration, struct joystick joystickValue, struct motor_s *motorValue);
void runMotors(comedi_t *device, struct motor_s motorValues);

int joystick_start () {
	
	struct joystick_calib joystickCalibData;
	char *filename = "/dev/comedi0";
	comedi_t *device = comedi_open(filename);
	if (!device) {
		comedi_perror(filename);
		return 1;
	}
	/* get the user to calibrate the joystick */
	calibrateJoystick(device, &joystickCalibData);
	
	struct joystick joystickData;
	struct motor_s motorValues;
	int time1 = 0;
	int time2 = 0;
	
	while (1) {
		/* TODO - fix recording mechanism. wasn't supposed to work in the first place */
			//	time1 = gettime();
		readJoystick(device, &joystickData);
		calculateMotorValue(joystickCalibData, joystickData, &motorValues);
		runMotors(device, motorValues);
			//	time2 = gettime();
		
			//	int timeDiff = time2 - time1;
			//recordMovement(timeDiff, motorValues);
		
		sleep(1);
	}
	
	comedi_close(device);
	return 0;
}

void calibrateJoystick(comedi_t *device, struct joystick_calib *calibration) {
	
	printf("Calibrating Joystick...\n");
	
	/* calibrate neutral data values */
	printf("Please let go of the joystick and press enter\n");
	while (getchar() != '\n'); /* loop endlessly until user presses enter */
	readJoystick(device, &calibration->neutral);
	printf("calibration value X: %d", calibration->neutral.x);
	printf("calibration value Y: %d", calibration->neutral.y);
	
	/* calibrate Y axis data values */
	printf("Please hold the joystick forward and press enter\n");
	while (getchar() != '\n'); /* loop endlessly until user presses enter */
	comedi_data_read(device, 0, 0, 1, AREF_GROUND, &calibration->forward);
	printf("calibration value: %d", calibration->forward);
	
	printf("Please hold the joystick backward and press enter\n");
	while (getchar() != '\n'); /* loop endlessly until user presses enter */
	comedi_data_read(device, 0, 0, 1, AREF_GROUND, &calibration->backward);
	printf("calibration value: %d", calibration->backward);
	
	/* calibrate X axis data values */
	printf("Please hold the joystick left and press enter\n");
	while (getchar() != '\n'); /* loop endlessly until user presses enter */
	comedi_data_read(device, 0, 1, 1, AREF_GROUND, &calibration->left);
	printf("calibration value: %d", calibration->left);
	
	printf("Please hold the joystick right and press enter\n");
	while (getchar() != '\n'); /* loop endlessly until user presses enter */
	comedi_data_read(device, 0, 1, 1, AREF_GROUND, &calibration->right);
	printf("calibration value: %d", calibration->right);
	
	calibration->stepBlock = (double)MOTOR_MAX/(double)((calibration->forward)-(calibration->neutral.y));
	printf("\nBlock Step val: %f", calibration->stepBlock);
}

/* TODO - Error checking. */
void readJoystick(comedi_t *device, struct joystick *joystickData) {
	
	comedi_data_read(device, 0, 1, 1, AREF_GROUND, &joystickData->y);
	comedi_data_read(device, 0, 0, 1, AREF_GROUND, &joystickData->x);
}

void calculateMotorValue(struct joystick_calib	calibration, 
						 struct joystick		joystickValue, 
						 struct motor_s		   *motorValue)
{
	signed int left, right;
	/* normalise joystick values */
	signed int dataX = joystickValue.x;
	signed int dataY = joystickValue.y;
	dataX -= calibration.neutral.x;
	dataY -= calibration.neutral.y;
	
		//	printf("\ndata x: %d", dataX);
		//	printf("\ndata y: %d", dataY);
	
	/* if very little movement on joystick, ignore input and stay still */
	if (dataX < 15 && dataX > -15 && dataY < 15 && dataY > -15) {
		motorValue->left = MOTOR_MAX;
		motorValue->right = MOTOR_MAX;
		printf("No motor value applicable");
		return;
	}
	
	/* calculate proportions of joystick in X and Y directions */
	/* use MOTOR_MAX as reference to minimise complexity */
		//	dataX = floor(((double)joystickValue.x)*((double)calibration.stepBlock));
		//	dataX += MOTOR_MAX;
		//	dataY = floor(((double)joystickValue.y)*((double)calibration.stepBlock));
		//	dataY += MOTOR_MAX;
	
	double angle = atan(((double) dataY)/((double)dataX));
	angle = RAD_TO_DEG(angle);
	/* angle is the angle created by dataX and dataY. +ve angle means forwards, -ve angle means backwards */
	/* there are some states we need to deal with, as arctan only gives values between +90 and -90 degrees (+PI/2 and -PI/2 really) */
	if ((dataX < 0) && (dataY < 0) && angle >= 0) { /* lower left quadrant */
		angle = (angle - 180);
	}
	else if ((dataX < 0) && dataY >= 0 && angle <= 0) { /* upper left quadrant */
		angle = (180 + angle);
	} /* else arctan gives angle as it is */
	printf("\nCalculated angle: %f", angle);
	
	if (angle >= 0) {
		/* set motor values to max, so all we need to do is calculate a multiplier to 
		 * change each motor. Add MOTOR_MAX to this value to make final motor values. */
		left = MOTOR_MAX;
		right = MOTOR_MAX;
		
		if (angle < 45) {
			/* left motor full forwards
			 * right motor variable backwards; 45 = 0, 0 = full */
			right /= 45;
			right *= (45-angle);
			right *= (-1); /* negative motor value makes for reversed direction. */
		}
		else if (angle < 90) {
			/* left motor full forwards
			 * right motor variable forwards; 90 = full, 45 = 0 */
			right /= 45;
			right *= (angle - 45);
		}
		else if (angle < 135) {
			/* left motor variable forwards; 135 = 0, 90 = full
			 * right motor full forwards */
			left /= 45;
			left *= (45 - (angle - 90));
		}
		else {
			/* left motor variable backwards; 135 = 0, 180 = full
			 * right motor full forwards */
			left /= 45;
			left *= (angle - 135);
			left *= -1; /* negative motor value makes for reversed direction */
		}
	}
	else {
		/* set motor values to max, so all we need to do is calculate a multiplier to 
		 * change each motor. Add MOTOR_MAX to this value to make final motor values. */
		left = 0-MOTOR_MAX;
		right = 0-MOTOR_MAX;
		if (angle > -45) {
			/* left motor full backwards
			 * right motor variable backwards; -45 = 0, 0 = full */
			right /= 45;
			right *= (angle + 45);
		}
		else if (angle > -90) {
			/* left motor full backwards
			 * right motor variable backwards; -90 = full, -45 = 0; */
			right /= 45;
			right *= (45 - (angle + 90));
		}
		else if (angle > -135) {
			/* left motor variable backwards; -135 = 0, -90 = full
			 * right motor full backwards */
			left /= 45;
			left *= (angle + 135);
			
		}
		else {
			/* left motor variable forwards; -135 = 0, -180 = full
			 * right motor full backwards */
			left /= 45;
			left *= (45 - (angle + 180));
		}
	}
	
	printf("\nLeft Motor: %d", left);
	printf("\nRight Motor: %d", right);
	/* motorValues are currently at their maximum possible value.
	 * make the joystick more interactive by scaling the motor values depending on how far
	 * the joystick has been pushed. */
	double hypotenuse = sqrt((dataX*dataX) + (dataY*dataY)); /* combined value the joystick has been pushed by. */
	unsigned int a = (calibration.left - calibration.neutral.x); a *= a;
	unsigned int b = (calibration.forward - calibration.neutral.y); b *= b;
	
	double maxHyp = sqrt(a + b);
	double multiplier = hypotenuse/maxHyp;
	
	motorValue->left = (left * multiplier) + MOTOR_MAX;
	motorValue->right = (right * multiplier) + MOTOR_MAX;
	printf("\nLeft Motor: %d", motorValue->left);
	printf("\nRight Motor: %d", motorValue->right);
}

void runMotors(comedi_t *device, struct motor_s motorValues) {
	
	/* values on motors are 0 to 4097 inclusive. make sure we are always within this range */
	if (motorValues.left > MOTOR_MAX*2) {
		motorValues.left = (MOTOR_MAX*2) - 1;
	}
	else if (motorValues.left < 0) {
		motorValues.left = 0;
	}
	
	if (motorValues.right > MOTOR_MAX*2) {
		motorValues.right = (MOTOR_MAX*2) - 1;
	}
	else if (motorValues.right < 0) {
		motorValues.right = 0;
	}
	
	comedi_data_write(device, 1, 0, 1, AREF_GROUND, motorValues.left); /* left motor */
	comedi_data_write(device, 1, 1, 1, AREF_GROUND, motorValues.right); /* right motor */
}
