/**************************************************************************************************
 * Filename: thread.h
 * Author: James Johns.
 * Date: 21/2/2012.
 *
 * Abstraction layer for cross-platform multithreading.
 **************************************************************************************************/

#include "thread.h"
#include <stdlib.h>

#ifndef _WIN32
#include <pthread.h>
#else
#include <process.h>
#endif

/* platform independently start a thread */
/* returns threadIndex on succes, -1 on error */
thread_t *createThread(THREAD_RET (*entryPoint)(void *), void *data) {
	thread_t *ret = (thread_t *) malloc(sizeof(thread_t));
	/* conditional thread start */
#ifdef _WIN32
	*ret = (HANDLE)_beginthread(entryPoint, 0, data);
#else
	pthread_create(ret, NULL, entryPoint, data);
#endif
	return ret;
}


/* platform independently end a thread */
void endThread(thread_t *thread) {
	/* wait for thread to exit gracefully. Assuming thread has been signalled to exit before calling this function. */
#ifdef _WIN32
	WaitForSingleObject(*thread, INFINITE);
#else
	pthread_join(*thread, NULL);
#endif
}

/* platform independently create a mutex */
/* returns mutexIndex on success, -1 on error */
mutex_t *createMutex() {
	mutex_t *ret = (mutex_t *)malloc(sizeof(mutex_t));
	/* conditional mutex creation */
#ifdef _WIN32
	*ret = CreateMutex(NULL, FALSE, NULL);
#else
	pthread_mutex_init(ret, NULL);
#endif
	return ret;	
}

/* platform independently destroy a mutex */
void destroyMutex(mutex_t *mutex) {
#ifdef _WIN32
	CloseHandle(*mutex);
#else
	pthread_mutex_destroy(mutex);
#endif
	free(mutex);
}

int lockMutex(mutex_t *mutex) {
	int ret = 0;
#ifdef _WIN32
	ret = WaitForSingleObject(*mutex, INFINITE);
#else
	ret = pthread_mutex_lock(mutex);
#endif
	return ret;
}

int trylockMutex(mutex_t *mutex) {
	int ret = 0;
#ifdef _WIN32
	ret = WaitForSingleObject(*mutex, 0);
#else
	ret = pthread_mutex_trylock(mutex);
#endif
	return ret;
}

int unlockMutex(mutex_t *mutex) {
	int ret = 0;
#ifdef _WIN32
	ret = ReleaseMutex(*mutex);
#else
	ret = pthread_mutex_unlock(mutex);
#endif
	return ret;
}
