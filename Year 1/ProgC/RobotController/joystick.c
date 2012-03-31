
#include <unistd.h>
#include <stdlib.h>
#include <sys/time.h>
#include <stdio.h>
#include <string.h>
#include <comedilib.h>
#include <math.h>
#include <ncurses.h>

#include "INIT.h"
#include "joystick.h"
int usleep(unsigned int usec);

int joystick_start (struct MARCOSETUP_s *setup) {
	
	struct joystick_calib joystickCalibData = setup->joystickCalib;
	struct joystick joystickData;
	struct motor_s motorValues;
	unsigned int line = 0;
	
	struct timeval timeStart = {0, 0};
	struct timeval timeEnd = {0,0};
	int timeDiff = 0;
	
	char *recFileName = "record.txt";
	FILE *recordFile = fopen(recFileName, "w");
	
	comedi_t *device = setup->device;
	while (!(line & (setup->bottomLSensor | setup->bottomRSensor))) {
		
		readJoystick(device, &joystickData);
		calculateMotorValue(joystickCalibData, joystickData, &motorValues);
		
		/* record time motor activation started and stopped. the difference is the motor time to record */
		gettimeofday(&timeEnd,NULL);
		if (timeStart.tv_sec != 0) {
			/* calculate the number of microseconds (millionths of a second) that have passed  */
			timeDiff = ((timeEnd.tv_sec-timeStart.tv_sec) * 1000000) + (timeEnd.tv_usec-timeStart.tv_usec);
		}
		gettimeofday(&timeStart,NULL);
		runMotors(device, motorValues);
		
		recordMovement(timeDiff, motorValues, recordFile);
		usleep(20000);
		digitalIO(device, 0, &line, 0xFFFF );
	}
	motorValues.left = 2048;
	motorValues.right = 2048;
	runMotors(device, motorValues);
	
	fclose(recordFile);

	return 0;
}

void recordMovement(int timeLength, struct motor_s motorValues, FILE *recordFile) {
  char outputString[100];
       sprintf(outputString, "%d %d %d\n", timeLength, motorValues.left, motorValues.right);
	fwrite(outputString, strlen(outputString), 1, recordFile);
}

void calibrateJoystick(comedi_t *device, struct joystick_calib *calibration) {
	
	printw("Calibrating Joystick...\n");
	
	/* calibrate neutral data values */
	printw("Please let go of the joystick and press enter\n");
	refresh();
	while (getch() != '\n'); /* loop endlessly until user presses enter */
	readJoystick(device, &calibration->neutral);
	printw("calibration value X: %d", calibration->neutral.x);
	printw("calibration value Y: %d", calibration->neutral.y);
	
	/* calibrate Y axis data values */
	printw("Please hold the joystick forward and press enter\n");
	refresh();
	while (getch() != '\n'); /* loop endlessly until user presses enter */
	comedi_data_read(device, 0, 0, 1, AREF_GROUND, &calibration->forward);
	printw("calibration value: %d", calibration->forward);
	
	printw("Please hold the joystick backward and press enter\n");
	refresh();
	while (getch() != '\n'); /* loop endlessly until user presses enter */
	comedi_data_read(device, 0, 0, 1, AREF_GROUND, &calibration->backward);
	printw("calibration value: %d", calibration->backward);
	
	/* calibrate X axis data values */
	printw("Please hold the joystick left and press enter\n");
	refresh();
	while (getch() != '\n'); /* loop endlessly until user presses enter */
	comedi_data_read(device, 0, 1, 1, AREF_GROUND, &calibration->left);
	printw("calibration value: %d", calibration->left);
	
	printw("Please hold the joystick right and press enter\n");
	refresh();
	while (getch() != '\n'); /* loop endlessly until user presses enter */
	comedi_data_read(device, 0, 1, 1, AREF_GROUND, &calibration->right);
	printw("calibration value: %d", calibration->right);
	
	calibration->stepBlock = (double)MOTOR_MAX/(double)((calibration->forward)-(calibration->neutral.y));
	printw("\nBlock Step val: %f", calibration->stepBlock);
	refresh();
}

/* TODO - Error checking. */
void readJoystick(comedi_t *device, struct joystick *joystickData) {
	
	comedi_data_read(device, 0, 1, 1, AREF_GROUND, &joystickData->y);
	comedi_data_read(device, 0, 0, 1, AREF_GROUND, &joystickData->x);
}

void calculateMotorValue(struct joystick_calib	calibration, 
			 struct joystick	joystickValue, 
			 struct motor_s		*motorValue)
{
	signed int left, right;
	/* normalise joystick values */
	signed int dataX = joystickValue.x;
	signed int dataY = joystickValue.y;
	dataX -= calibration.neutral.x; 
	dataX *= -1; /* X axis is inverted on joysticks. after normalising about X axis, reverse sign to correct inversion */
	dataY -= calibration.neutral.y;
	dataY *= -1;
	
		//	printf("\ndata x: %d", dataX);
		//	printf("\ndata y: %d", dataY);
	
	/* if very little movement on joystick, ignore input and stay still */
	if (dataX < 15 && dataX > -15 && dataY < 15 && dataY > -15) {
		motorValue->left = MOTOR_MAX;
		motorValue->right = MOTOR_MAX;
		//	printw("No motor value applicable");
		return;
	}
	
	/* calculate proportions of joystick in X and Y directions */
	/* use MOTOR_MAX as reference to minimise complexity */	
	double angle = atan(((double) dataY)/((double)dataX));
	angle = RAD_TO_DEG(angle);
	/* joystick left > joystick right. all angles should be mirrored in x = 0. */
	
	/* double angle is currently the result of an arctan function. It is limited to between +90 and -90 degrees.
	 * to allow +180 to -180 degrees, move the angles that should be in the 2 left quadrants. */
	if ((dataX < 0) && (dataY >= 0)) {
		angle = (angle+180);
	}
	else if ((dataX < 0) && (dataY < 0)) {
		angle = (angle-180);
	}
	angle -= 90;
	if ( angle < -180) {
	  angle = 180 + (angle + 180);
	}
	if (angle >= 0) {
		/* set motor values to max, so all we need to do is calculate a multiplier to 
		 * change each motor. Add MOTOR_MAX to this value to make final motor values. */
		left = MOTOR_MAX;
		right = MOTOR_MAX;
		
		if (angle < 45) {
			/* left motor full forwards. 
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
			/* left motor variable direction; 0 to -22.5 = fwd, -22.5 to -45 = bwd.
			 * right motor variable backwards; -45 = 0, 0 = full */
			right /= 45;
			right *= (angle + 45);
			left /= 22.5;
			left *= (-1 * (angle + 22.5)); /* normalise angle about 0, multiply by negative 1 to invert direction */
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
			 * right motor variable direction; -180 to -157.5 = fwd, -157.5 to -135 = bwd */
			left /= 45; /* 45 degrees of variance range, evenly distribute motor speed across angle */
			left *= (45 - (angle + 180));
			right /= 22.5; /* 45 degrees of variance, between 2 directions. lower half denotes forward, upper half denotes backward */
			right *= ((angle + 180) - 22.5); /* mirror angle in y=-x. offset by 22.5 to normalise the 45 degree range around 0.
							  * multiply to acheive proportional motor value for angle. */
		}
	}
	
	/* motorValues are currently at their maximum possible value.
	 * make the joystick more interactive by scaling the motor values depending on how far
	 * the joystick has been pushed. */
	double hypotenuse = sqrt((dataX*dataX) + (dataY*dataY)); /* combined value the joystick has been pushed by. */
	unsigned int a = (calibration.left - calibration.neutral.x); 
					 a *= a;
	unsigned int b = (calibration.forward - calibration.neutral.y); 
					 b *= b;
	
	double maxHyp = sqrt(a + b);
	double multiplier = hypotenuse/maxHyp;
	
	motorValue->left = (left * multiplier) + MOTOR_MAX;
	motorValue->right = (right * multiplier) + MOTOR_MAX;
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
