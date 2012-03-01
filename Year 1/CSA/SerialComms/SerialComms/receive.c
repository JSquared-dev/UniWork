
#include <stdio.h>
#include <stdlib.h>

#ifdef _WIN32
#else
#include <unistd.h>
#endif

#include "main.h"
#include "packet.h"

THREAD_RET receiveStart(void *data) {
	
	while (1) {
#ifdef _WIN32
		Sleep(20);
#else
		usleep(20000);
#endif
	}
	return NULL;
}
