/*************************************************
 *	Filename: thread.c
 *	Written by: James Johns, Silvestrs Timofejevs
 *	Date: 28/3/2012
 *************************************************/


#include "thread.h"
#include <stdlib.h>

#ifndef _WIN32
#include <pthread.h>
#else
#include <process.h>
#endif

/*	Function name: createThread
 *	Written by: James Johns
 *	Data: 28/3/2012
 *	Parameters:
 *		entryPoint - pointer to function where thread will start execution.
 *		data - parameter to pass to entrypoint function on thread start.
 *	Returns:
 *		NULL on error, else pointer to valid thread_t object.
 *
 *	Notes:
 *		OS independently creates a thread with the specified entrypoint and parameter.
 *		WARNING - must be deleted by calling endThread.
 *		
 */
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

/*	Function name: endThread
 *	Written by: James Johns
 *	Date: 28/3/2012
 *	Parameters:
 *		thread - thread object to quit and delete.
 *
 *	Notes:
 *		Waits for thread to exit and then deletes the memory allocated to the thread structure.
 *		WARNING - does not cancel the thread. The thread must be signalled to end before calling 
 *					endThread.
 *		WARNING - blocks calling thread until thread ends.
 *		
 */
void endThread(thread_t *thread) {
	/* wait for thread to exit gracefully. Assuming thread has been signalled to exit before 
	 * calling this function. */
#ifdef _WIN32
	WaitForSingleObject(*thread, INFINITE);
#else
	pthread_join(*thread, NULL);
#endif
	free(thread);
}

/*	Function name: receiveStart
 *	Written by: James Johns
 *	Returns:
 *		Allocated and initialised mutex_t object. Must be deleted by destroyMutex().
 *
 *	Notes:
 *		Allocates and initialises a mutex_t object.
 *		Can be locked and unlocked by lockMutex(), trylockMutex() and unlockMutex().
 *		WARNING - must be deleted by createMutex.
 *
 */
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

/*	Function name: destroyMutex
 *	Written by: James Johns
 *	Date: 28/3/2012
 *	Parameters:
 *		mutex - mutex_t object to destroy
 *
 *	Notes:
 *		Destroys and deallocates all memory allocated to mutex object.
 *		WARNING - must only be called on object created by createMutex().
 *		
 */
void destroyMutex(mutex_t *mutex) {
#ifdef _WIN32
	CloseHandle(*mutex);
#else
	pthread_mutex_destroy(mutex);
#endif
	free(mutex);
}

/*	Function name: lockMutex
 *	Written by: James Johns
 *	Date: 28/3/2012
 *	Parameters:
 *		mutex - mutex to lock.
 *	Returns:
 *		0 on succes, non zero on error
 *
 *	Notes:
 *		Locks mutex object specified by mutex.
 *		Blocks until mutex becomes available if mutex is already locked.
 *		Should be unlocked by unlockMutex().
 *		WARNING -Blocks the calling thread. To do non-blocking mutex acquisition, use trylockMutex()
 *
 */
int lockMutex(mutex_t *mutex) {
	int ret = 0;
#ifdef _WIN32
	ret = WaitForSingleObject(*mutex, INFINITE);
#else
	ret = pthread_mutex_lock(mutex);
#endif
	return ret;
}

/*	Function name: trylockMutex
 *	Written by: James Johns
 *	Parameters:
 *		mutex - mutex object to attempt to lock
 *	Returns:
 *		0 on success, non zero on error.
 *
 *	Notes:
 *		Attempts to lock the mutex object specified by mutex. If the mutex is already locked by 
 *		another thread, function returns non zero. If the mutex is acquired, function returns zero.
 *		Does not block the calling thread.
 *		
 */
int trylockMutex(mutex_t *mutex) {
	int ret = 0;
#ifdef _WIN32
	ret = WaitForSingleObject(*mutex, 0);
#else
	ret = pthread_mutex_trylock(mutex);
#endif
	return ret;
}

/*	Function name: unlockMutex
 *	Written by: James Johns
 *	Parameters:
 *		mutex - mutex object to unlock.
 *	Returns:
 *		0 on success, non zero on error.
 *
 *	Notes:
 *		Unlocks mutex object specified by mutex.
 *		
 */
int unlockMutex(mutex_t *mutex) {
	int ret = 0;
#ifdef _WIN32
	ret = ReleaseMutex(*mutex);
#else
	ret = pthread_mutex_unlock(mutex);
#endif
	return ret;
}
