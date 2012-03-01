/* Filename: thread.h
 * Author: James Johns.
 * Date: 21/2/2012.
 *
 * Abstraction layer for cross-platform multithreading.
 */

#ifndef _THREAD_H_
#define _THREAD_H_

/* conditional types to use on each platform */
#ifdef _WIN32
#include <Windows.h>
#include <process.h>
/* typedefs make things easier to deal with */
typedef HANDLE mutex_t;
typedef HANDLE thread_t;
#define THREAD_RET DWORD WINAPI
#else
#include <pthread.h>
/* typedefs make things easier to deal with */
typedef pthread_mutex_t mutex_t;
typedef pthread_t thread_t;
#define THREAD_RET void *
#endif

/* basic, all purpose structures for functions below */
struct threadList_s {
	int size;
	thread_t *list;
};
struct mutexList_s {
	int size;
	mutex_t *list;
};

void destroyLists();

/* returns threadIndex on succes, -1 on error */
int createThread(THREAD_RET (*entryPoint)(void *), void *data);
void endThread(int threadIndex);

/* returns mutexIndex on success, -1 on error */
int createMutex();
void destroyMutex(int mutexIndex);

/* should these return anything? or should they deal with issues internally? */
int lockMutex(int mutexIndex);
int trylockMutex(int mutexIndex);
int unlockMutex(int mutexIndex);


#endif
