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

struct messageQueue_s {
	int front, back;
	void **queue;
	int maxQueueSize;
};

int createMessageQueue(struct messageQueue_s *queue, int initialSize);
int destroyMessageQueue(struct messageQueue_s *queue);
int increaseMessageQueue(struct messageQueue_s *queue, int amount);
void *removeFrontOfMessageQueue(struct messageQueue_s *queue);
void addMessageToQueue(struct messageQueue_s *queue, void *message);

#endif
