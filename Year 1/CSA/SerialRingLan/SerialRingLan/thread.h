
#ifndef _THREAD_H_
#define _THREAD_H_

/* conditional types to use on each platform */
#ifdef _WIN32
#include <Windows.h>
#include <process.h>
/* typedefs make things easier to deal with */
typedef HANDLE mutex_t;
typedef HANDLE thread_t;
typedef DWORD THREAD_RET;
#else
#include <pthread.h>
/* typedefs make things easier to deal with */
typedef pthread_mutex_t mutex_t;
typedef pthread_t thread_t;
typedef void * THREAD_RET;
#endif

/* returns threadIndex on succes, -1 on error */
thread_t *createThread(THREAD_RET (*entryPoint)(void *), void *data);
void endThread(thread_t *thread);

/* returns mutexIndex on success, -1 on error */
mutex_t *createMutex();
void destroyMutex(mutex_t *mutex);

/* should these return anything? or should they deal with issues internally? */
int lockMutex(mutex_t *mutex);
int trylockMutex(mutex_t *mutex);
int unlockMutex(mutex_t *mutex);


#endif
