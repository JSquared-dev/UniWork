/* Stop utility.
 * Used to stop all motors on the Tethered Robot when things start going wrong.
 *
 * Compile with: gcc -ansi -Wall -o stop stop.c -lcomedi -lc -lm 
 */
#include <comedilib.h>
#include <stdio.h>

int main(int argc, const char **argv) {
	
	char *filename = "/dev/comedi0";
	printf("Stopping Motors");
	comedi_t *device = comedi_open(filename);
	if (!device) {
		comedi_perror(filename);
		return 1;
	}
	int ret;
	ret = comedi_data_write(device, 1, 0, 1, AREF_GROUND, 2048);
	if (ret < 0) {
		comedi_perror(filename);
		return 2;
	}
	ret = comedi_data_write(device, 1, 1, 1, AREF_GROUND, 2048);
	if (ret < 0) {
		comedi_perror(filename);
		return 3;
	}
	
	comedi_close(device);
	return 0;
}
