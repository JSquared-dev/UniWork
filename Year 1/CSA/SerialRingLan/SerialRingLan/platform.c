/*************************************************
 *	Filename: platform.c
 *	Written by: James Johns, Silvestrs Timofejevs
 *	Date: 28/3/2012
 *************************************************/


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

/* required for termios configuration. not always defined in termios.h but is safe to define here */
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


/* Function name: getTimeOfDay
 * Written by: James Johns
 * Date: 28/3/2012
 *	Returns:
 *		Current time in Unix format (number of seconds since January 1, 1970).
 *
 * notes:
 *		Cross platform compatible. Converts windows system time into unix time via 
 *		systemTimeToUnixTime().
 *
 */
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

/* Function name: initUI
 * Written by: James Johns
 * Date: 28/3/2012
 * Parameters:
 *		milli - number of milliseconds to pause for.
 *
 * notes:
 *		Pause the calling thread for 'milli' number of milliseconds.
 *		Uses usleep on unix, Sleep on windows.
 *		Allows a single function call to cover all operating systems.
 */
void waitMilliSecs(unsigned int milli) {
#ifdef _WIN32
	Sleep(milli);
#else
	usleep(milli*1000);
#endif
}

/* windows only functionality */
#ifdef _WIN32
/* Function name: systemTimeToUnixTime
 * Written by: James Johns. 
 * Date: 28/3/2012
 * Parameters:
 *		time - SYSTEMTIME value to convert to unix time (32 bit integer - number of seconds since 
 *		January 1, 1970)
 *	Return:
 *		number of seconds since January 1, 1970 (epoch)
 *
 * notes:
 *		Uses algorithm described by Microsoft on MSDN to convert SYSTEMTIME to unix time.
 *					
 *
 */
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


/* Function name: setupCOMPort
 * Written by: James Johns. 
 * Date: 28/3/2012
 * Parameters:
 *		comFileDescriptor - file descriptor for serial COM port.
 *
 * notes:
 *		Initialise the com port through by managing the attributes of the file descriptor 
 *		(using Termios in linux, DCB in windows).
 *		COM port is initialised to 9600 bps, 8 bit bytes, no parity, 2 stop bits, RTS/CTS handshake 
 *		flow control.
 *		Original state on call is saved to static global variable.
 *		WARNING - calling twice will overwrite the saved state, disabling the ability to restore the
 *		original state.
 *
 */
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

/* Function name: restoreCOMPort
 * Written by: James Johns. 
 * Date: 28/3/2012
 * Parameters:
 *		comFileDescriptor - file descriptor for serial COM port.
 *
 * notes:
 *		Restore the COM port settings to how they were before calling setupCOMPort.
 *		WARNING - calling before setupCOMPort hasbeen called will result in an unknown state.
 *		WARNING - restoring the state through this method is non-recoverable. If anything goes 
 *					wrong, subsequent calls will restore the same erroneous data.
 *
 */
void restoreCOMPort(int comFileDescriptor) {
	
#ifdef _WIN32
	HANDLE hcom = (HANDLE)_get_osfhandle(comFileDescriptor);
	SetCommState(hcom, &dcb);
	SetCommTimeouts(hcom, &noblock);
#else
	tcsetattr(comFileDescriptor, TCSANOW, &old);
#endif
}
