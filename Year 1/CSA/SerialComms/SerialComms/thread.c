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
/***************************************************************************************************
 * allowable semi dynamic (increases as needed) as they should rarely be needed (limited nuber of
 * threads and mutexes required for this system. 
 * Bigger project needs a better solution (linked list?).
 **************************************************************************************************/
static struct threadList_s threadList = { 0, NULL};
static struct mutexList_s mutexList = { 0, NULL};

/* convenience method to free memory allocated to 
 * thread and mutex lists and prevent memory leaks */
void destroyLists() {
	if (threadList.list != NULL)
		free (threadList.list);
	if (mutexList.list != NULL)
		free (mutexList.list);
}

/* platform independently start a thread */
/* returns threadIndex on succes, -1 on error */
int createThread(void (*entryPoint)(void *), void *data) {
	int ret = 0;
	/* increase size of threadList to accomodate new thread */
	if (threadList.size == 0) {
		threadList.list = (thread_t *)malloc(sizeof(thread_t));
		threadList.size = 1;
	}
	else {
		ret = threadList.size;
		threadList.size ++;
		threadList.list = (thread_t *)realloc(threadList.list,sizeof(thread_t)*threadList.size);
	}
	/* conditional thread start */
#ifdef _WIN32
	_beginthread(entryPoint, 0, data);
#else
	pthread_create(&threadList.list[ret], NULL, entryPoint, data);
#endif
	return ret;
}


/* platform independently end a thread */
void endThread(int threadIndex) {
#ifdef _WIN32
//	_endthread(); /* is wrong. needs something else instead. ClosHandle()? */
	CloseHandle(threadList.list[threadIndex]);
#else
	pthread_cancel(threadList.list[threadIndex]);
#endif
}

/* platform independently create a mutex */
/* returns mutexIndex on success, -1 on error */
int createMutex() {
	int ret = 0;
	/* increase size of mutexList to accomodate new mutex */
	if (mutexList.size == 0) {
		mutexList.list = malloc(sizeof(mutex_t));
		mutexList.size = 1;
	}
	else {
		ret = mutexList.size;
		mutexList.size ++;
		mutexList.list = realloc(mutexList.list,sizeof(mutex_t)*mutexList.size);
	}
	/* conditional mutex creation */
#ifdef _WIN32
	mutexList.list[ret] = CreateMutex(NULL, FALSE, NULL);
#else
	pthread_mutex_init(&mutexList.list[ret], NULL);
#endif
	return ret;	
}

/* platform independently destroy a mutex */
void destroyMutex(int mutexIndex) {
#ifdef _WIN32
	CloseHandle(mutexList.list[mutexIndex]);
#else
	pthread_mutex_destroy(&mutexList.list[mutexIndex]);
#endif
}

int lockMutex(int mutexIndex) {
	int ret = 0;
#ifdef _WIN32
	ret = WaitForSingleObject(mutexList.list[mutexIndex], INFINITE);
#else
	ret = pthread_mutex_lock(&mutexList.list[mutexIndex]);
#endif
	return ret;
}

int trylockMutex(int mutexIndex) {
	int ret = 0;
#ifdef _WIN32
	ret = WaitForSingleObject(mutexList.list[mutexIndex], 0);
#else
	ret = pthread_mutex_trylock(&mutexList.list[mutexIndex]);
#endif
	return ret;
}

int unlockMutex(int mutexIndex) {
	int ret = 0;
#ifdef _WIN32
	ret = ReleaseMutex(mutexList.list[mutexIndex]);
#else
	ret = pthread_mutex_unlock(&mutexList.list[mutexIndex]);
#endif
	return ret;
}
