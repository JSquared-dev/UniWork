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

/* Function Name: createMessageQueue
 * Parameters: 
 *		IN:
 *			queue		- pointer to structure to initialise
 *			initialSize - initial number of positions in queue.
 *		OUT:
 *			queue		- fully intialised message queue structure
 *
 * initialises the structure pointed to by 'queue', and allocates memory for the queue data.
 * destroyMessageQueue should be called on queue when finished with it.
 */
int createMessageQueue(struct messageQueue_s *queue, int initialSize) {
	queue->front = queue->back = 0;
	queue->maxQueueSize = initialSize;
	queue->queue = malloc(sizeof(void *)*initialSize);
	return 0;
}

/* Function Name: destroyMessageQueue
 * Parameters: 
 *		IN:
 *			queue		- pointer to structure to initialise
 *
 * Destroys the structure pointed to by 'queue', and frees any memory allocated to it 
 * by the message queue functions.
 * If necessary, the address of queue should be freed after this function.
 */
int destroyMessageQueue(struct messageQueue_s *queue) {
	queue->front = queue->back = 0;
	queue->maxQueueSize = 0;
	free(queue->queue);
	return 0;
}

/* Function Name: increaseMessageQueue
 * Parameters: 
 *		IN:
 *			queue		- pointer to structure to initialise.
 *			amount		- size of modify the queue length by.
 *
 * Reallocates the memory allocated for the queue data, to allow 'amount' more positions.
 */
int increaseMessageQueue(struct messageQueue_s *queue, int amount) {
	int newSize = queue->maxQueueSize + amount;
	queue->queue = realloc(queue->queue, sizeof(void*)*newSize);
	queue->maxQueueSize += amount;
	return 0;
}

/* Function Name: removeFrontOfMessageQueue
 * Parameters: 
 *		IN:
 *			queue		- pointer to structure to initialise.
 *		OUT:
 *			return		- address of the first object entered into queue.
 *
 * returns the address of the first object placed into queue, and removes it from the queue.
 */
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

/* Function Name: addMessageToQueue
 * Parameters: 
 *		IN:
 *			queue		- pointer to structure to initialise.
 *			message		- object to place onto queue.
 *
 * Adds message onto the back of the queue, increasing the size of the queue if necessary.
 */
void addMessageToQueue(struct messageQueue_s *queue, void *message) {
	int ref = queue->back;
	int newQueueLoc, i;

	queue->queue[ref] = message;
	queue->back += 1;
	if (queue->back >= queue->maxQueueSize && queue->front != 0) {
		queue->back = 0;
	}
	else if(queue->back >= queue->maxQueueSize && queue->front == 0) {
		increaseMessageQueue(queue, 15);
	}
	if (queue->back == queue->front) {
		/* queue collision */
		/* Increase queue length and move queue into new space freeing up a gap between the front 
		 * and back of the queue */
		increaseMessageQueue(queue, 5);
		newQueueLoc = queue->maxQueueSize - 5; /* start moving data into new area at top of queue */
		for (i = 0; i < queue->back; i++) {
			queue->queue[newQueueLoc] = queue->queue[i];
			newQueueLoc += 1;
			if (newQueueLoc >= queue->maxQueueSize) {
				newQueueLoc = 0; /* once we run over the end of the new are, it is safe to 
								  * re-use lower end of queue */
			}
		}
	}
}
