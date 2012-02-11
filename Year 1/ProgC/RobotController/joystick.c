
#include <unistd.h>
#include <stdlib.h>
#include <comedilib.h>
#include <math.h>

	//int usleep(useconds_t usec);
#define MOTOR_MAX 2048
#define READ_ACCURACY 5 /* accuracy of read. values should be within +/- of this value. */

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
struct motor_s *calculateMotorValue(struct joystick_calib *calibration, struct joystick *joystickValue);
void runMotors(comedi_t *device, struct motor_s *motorValues);

int main (int argc, const char **argv) {
	
	struct joystick_calib joystickCalibData;
	struct joystick joystickData;
	char *filename = "/dev/comedi0";
	comedi_t *device = comedi_open(filename);
	if (!device) {
		comedi_perror(filename);
		return 1;
	}
	/* get the user to calibrate the joystick */
	calibrateJoystick(device, &joystickCalibData);

	while (1) {
		
		readJoystick(device, &joystickData);
		struct motor_s *motorValues = calculateMotorValue(&joystickCalibData, &joystickData);
		runMotors(device, motorValues);

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

void readJoystick(comedi_t *device, struct joystick *joystickData) {
	
	comedi_data_read(device, 0, 1, 1, AREF_GROUND, &joystickData->y);
	comedi_data_read(device, 0, 0, 1, AREF_GROUND, &joystickData->x);
}

struct motor_s *calculateMotorValue(struct joystick_calib *calibration, struct joystick *joystickValue) {
	
	struct motor_s *motorValue = malloc(sizeof(struct motor_s));
	printf("\njoystick data x: %d", joystickValue->x);
	printf("\njoystick data y: %d", joystickValue->y);

	signed int dataX = joystickValue->x;
	signed int dataY = joystickValue->y;
	dataX -= calibration->neutral.x;
	dataY -= calibration->neutral.x;
	
	motorValue->left = floor(((double)joystickValue->x)*((double)calibration->stepBlock));
	motorValue->left += MOTOR_MAX;
	motorValue->right = floor(((double)joystickValue->y)*((double)calibration->stepBlock));
	motorValue->right += MOTOR_MAX;
	
	if ((joystickValue->x + READ_ACCURACY) > calibration->netural.x ||
		(joystickValue->x - READ_ACCURACY) < calibration->netural.x		) {
		double tmp = motorValue->left;
		tmp -= MOTOR_MAX;
		tmp /= MOTOR_MAX;
		motorValue->left *= cos(tmp);
	}
	else {
		motorValue->right = floor(cos((motorValue->right/(MOTOR_MAX*2))*180));
	}
	
	return motorValue;
}

void runMotors(comedi_t *device, struct motor_s *motorValues) {
	
	comedi_data_write(device, 1, 0, 1, AREF_GROUND, motorValues->left); /* left motor */
	comedi_data_write(device, 1, 1, 1, AREF_GROUND, motorValues->right); /* right motor */
}
