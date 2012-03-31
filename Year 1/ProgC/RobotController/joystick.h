

#ifndef _JOYSTICK_H_
#define _JOYSTICK_H_

#define PI 3.1415926535897	/* PI for converting radians to degrees easily */
#define RAD_TO_DEG(x) ((x/PI)*180)
#define MOTOR_MAX 2048		/* max value a motor can be in 1 direction. multiply by 2 to get max 
* value a motor can be. */

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
void recordMovement(int timeLength, struct motor_s motorValues, FILE *recordFile);

#endif
