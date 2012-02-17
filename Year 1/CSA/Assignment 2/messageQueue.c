/* Filename: messageQueue.c
 * Written by: James Johns.
 * Date: 16/2/2012
 *
 *
 * messageQueue is a collection of functions for manipulating a messageQueue_s structure.
 * messageQueue implements a FIFO buffer, or a basic queue. The queue length is dynamically
 * modified as required.
 */

#include "messageQueue.h"
#include <stdlib.h>
#include <stdio.h>


int createMessageQueue(struct messageQueue_s *queue, int initialSize) {
	queue->front = queue->back = 0;
	queue->maxQueueSize = initialSize;
	queue->queue = malloc(sizeof(void *)*initialSize);
	return 0;
}

int destroyMessageQueue(struct messageQueue_s *queue) {
	queue->front = queue->back = 0;
	queue->maxQueueSize = 0;
	free(queue->queue);
	return 0;
}

int increaseMessageQueue(struct messageQueue_s *queue, int amount) {
	int newSize = queue->maxQueueSize + amount;
	queue->queue = realloc(queue->queue, sizeof(void*)*newSize);
	return 0;
}

void *removeFrontOfMessageQueue(struct messageQueue_s *queue) {
	if (queue->front == queue->back) {
			// empty queue
		return NULL;
	}
	else {
		int ref = queue->front;
		queue->front += 1;
		if (queue->front >= queue->maxQueueSize) {
			queue->front = 0;
		}
		return queue->queue[ref];
	}
}

int addMessageToQueue(struct messageQueue_s *queue, void *message) {
	int ref = queue->back;
	queue->queue[ref] = message;
	queue->back += 1;
	if (queue->back >= queue->maxQueueSize && queue->front != 0) {
		queue->back = 0;
	}
	else {
		increaseMessageQueue(queue, 5);
	}
	if (queue->back == queue->front) {
		/* queue collision */
		/* Increase queue length and move queue into new space freeing up a gap between the front 
		 * and back of the queue */
		increaseMessageQueue(queue, 5);
		int newQueueLoc = queue->maxQueueSize - 5; /* start moving data into new area at top of queue */
		for (int i = 0; i < queue->back; i++) {
			queue->queue[newQueueLoc] = queue->queue[i];
			newQueueLoc += 1;
			if (newQueueLoc >= queue->maxQueueSize) {
				newQueueLoc = 0; /* once we run over the end of the new are, it is safe to 
								  * re-use lower end of queue */
			}
		}
	}
}
