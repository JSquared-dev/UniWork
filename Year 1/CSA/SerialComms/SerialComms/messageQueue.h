/* Filename: messageQueue.h
 * Written by: James Johns.
 * Date: 16/2/2012
 *
 *
 * Prototype function definitions for external reference.
 *
 * messageQueue is a collection of functions for manipulating a messageQueue_s structure.
 * messageQueue implements a FIFO buffer, or a basic queue. The queue length is dynamically
 * modified as required.
 */

#ifndef _MESSAGEQUEUE_H_
#define _MESSAGEQUEUE_H_

#define MAX_QUEUE_SIZE 64

#include "thread.h"

struct messageQueue_s {
	struct messageQueue_s *previous; /* previsou item in queue. wraps when underflowing the queue */
	struct messageQueue_s *next; /* next item in queue. wraps when overflowing the queue */
	void *data; /* data to be held in queue */
	int mutexIndex; /* mutex for this queue */
};

struct messageQueue_s *createMessageQueue();
int destroyMessageQueue(struct messageQueue_s *queue);
int increaseMessageQueue(struct messageQueue_s *queue, int amount);
void *removeFrontOfQueue(struct messageQueue_s *queue);
void addToQueue(struct messageQueue_s *queue, void *message);

#endif
