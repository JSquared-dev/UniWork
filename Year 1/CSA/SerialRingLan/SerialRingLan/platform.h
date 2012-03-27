/* filename: platform.h
 * Written by: James Johns.
 *
 */


#ifndef _PLATFORM_H_
#define _PLATFORM_H_

#include <time.h>

time_t getTimeOfDay();
void waitMilliSecs(unsigned int milli);
void setupCOMPort(int comFileDescriptor);
void restoreCOMPort(int comFileDescriptor);

#ifdef _WIN32
#include <Windows.h>
unsigned int systemTimeToUnixTime(SYSTEMTIME time);
#endif /* _WIN32 */

#endif
