

#include "platform.h"
#include <stdio.h>

#ifdef _WIN32
#include <Windows.h>
#include <io.h>
#else
#include <unistd.h>
#endif

/* returns number of seconds since January 1, 1970 */
time_t getTimeOfDay() {
	unsigned long int ret = 0;
#ifdef _WIN32
	SYSTEMTIME time;
	GetSystemTime(&time);
	ret = systemTimeToUnixTime(time);
#else
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
	COMMTIMEOUTS noblock;
	DCB dcb;
	HANDLE hCom = (HANDLE)_get_osfhandle(comFileDescriptor);
	fSuccess = GetCommTimeouts(hCom, &noblock);
	noblock.ReadTotalTimeoutConstant = 1;
	noblock.ReadTotalTimeoutMultiplier = MAXDWORD;
	noblock.ReadIntervalTimeout = MAXDWORD;
	fSuccess = SetCommTimeouts(hCom, &noblock);

	fSuccess = GetCommState(hCom, &dcb);
	if(!fSuccess){
		printf("GetCommState Error!");
	}
	dcb.BaudRate = 9600;
	dcb.ByteSize = 8;
	dcb.fParity = FALSE;
	dcb.Parity = NOPARITY;
	dcb.StopBits = TWOSTOPBITS;
	dcb.fRtsControl = RTS_CONTROL_HANDSHAKE;
	dcb.fOutxCtsFlow = TRUE;
	fSuccess = SetCommState(hCom, &dcb);
	if(!fSuccess){
		printf("SetCommState Error!");
	}
#endif
}
