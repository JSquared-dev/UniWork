

#include "platform.h"
#include <stdio.h>

#ifdef _WIN32
#include <Windows.h>
#include <io.h>
static COMMTIMEOUTS noblock;
static DCB dcb;
#else /* _WIN32 */
#include <unistd.h>
#include <sys/termios.h>
#include <time.h>
static struct termios old;
int usleep(int secs);


#ifndef CCTS_OFLOW
     #define CCTS_OFLOW 0x00010000
#endif /* CCTS_OFLOW */
#ifndef CRTS_IFLOW
     #define CRTS_IFLOW 0x00020000
#endif /* CRTS_IFLOW */
#ifndef CRTSCTS
     #define CRTSCTS (CCTS_OFLOW|CRTS_IFLOW)
#endif /* CRTSCTS */
#ifndef ONOEOT
#define ONOEOT 0x00000008
#endif 
#endif /* else !_WIN32 */

/* returns number of seconds since January 1, 1970 */
time_t getTimeOfDay() {
	unsigned long int ret = 0;
#ifdef _WIN32
	SYSTEMTIME time;
	GetSystemTime(&time);
	ret = systemTimeToUnixTime(time);
#else
	ret = time(NULL);
#endif
	return ret;
}

void waitMilliSecs(unsigned int milli) {
#ifdef _WIN32
	Sleep(milli);
#else
	usleep(milli*1000);
#endif
}

#ifdef _WIN32
/* convert system time to time_t compatible value */
unsigned int systemTimeToUnixTime(SYSTEMTIME time) {
	unsigned int ret = 0;
	FILETIME ft;
	__int64 lTime;
	SystemTimeToFileTime(&time, &ft);
	lTime = (__int64)(((__int64)ft.dwHighDateTime << 32) | (ft.dwLowDateTime));
	lTime -= 116444736000000000;
	lTime /= 10000000;
	lTime &= 0x00000000FFFFFFFF;
	ret = lTime;
	return ret;
}
#endif

void setupCOMPort(int comFileDescriptor) {
#ifdef _WIN32
	BOOL fSuccess;
	COMMTIMEOUTS noblockNew;
	DCB dcbNew;
	HANDLE hCom = (HANDLE)_get_osfhandle(comFileDescriptor);
	fSuccess = GetCommTimeouts(hCom, &noblock);
	noblockNew = noblock;
	noblockNew.ReadTotalTimeoutConstant = 1;
	noblockNew.ReadTotalTimeoutMultiplier = MAXDWORD;
	noblockNew.ReadIntervalTimeout = MAXDWORD;
	fSuccess = SetCommTimeouts(hCom, &noblockNew);

	fSuccess = GetCommState(hCom, &dcb);
	dcbNew = dcb;
	if(!fSuccess){
		printf("GetCommState Error!");
	}
	dcbNew.BaudRate = 9600;					/* 9600 bps */
	dcbNew.ByteSize = 8;						/* 8 bit bytes */
	dcbNew.fParity = FALSE;					/* no parity */
	dcbNew.Parity = NOPARITY;					/* no parity */
	dcbNew.StopBits = TWOSTOPBITS;				/* 2 stop bits */
	dcbNew.fRtsControl = RTS_CONTROL_HANDSHAKE;/* CTS/RTS enabled */
	dcbNew.fOutxCtsFlow = TRUE;				/* CTS/RTS enabled */
	fSuccess = SetCommState(hCom, &dcbNew);	/* enable modifications */
	if(!fSuccess){
		printf("SetCommState Error!");
	}
#else
	struct termios new;
	/* save current settings for restoring later, and make a copy for use now */
	tcgetattr(comFileDescriptor, &old);
	new = old;
	/* baud rate - 9600 bps
	 * 8 bit characters
	 * RTS/CTS enabled
	 * Receive enabled
	 * 2 stop bits
	 */
	new.c_cflag = B9600 | CS8 | CRTSCTS | CREAD | CSTOPB | CLOCAL;
	/* ignore parity
	 * map carriage return to new line character - required for cross platform
	 */
 	new.c_iflag = IGNPAR | ONLCR;
	/* no initial carriage return
	 * ignore EOT (^D)
	 */
 	new.c_oflag = ONOCR | ONOEOT;
	/* non-canonical - deal character by character, not line by line
	 * disable echo
	 * disable signaling
	 */
 	new.c_lflag = ~(ICANON | ECHO | ISIG);
	
	/* activate changes on serial port */
	tcsetattr(comFileDescriptor,TCSANOW,&new);
#endif
}

void restoreCOMPort(int comFileDescriptor) {
	
#ifdef _WIN32
	HANDLE hcom = (HANDLE)_get_osfhandle(comFileDescriptor);
	SetCommState(hcom, &dcb);
	SetCommTimeouts(hcom, &noblock);
#else
	tcsetattr(comFileDescriptor, TCSANOW, &old);
#endif
}
