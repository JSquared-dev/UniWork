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
struct messageQueue_s *createMessageQueue() {
	struct messageQueue_s *queue = malloc(sizeof(struct messageQueue_s));
	queue->next = queue->previous = queue;
	queue->data = NULL;
	queue->mutexIndex = createMutex();
	return queue;
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
	lockMutex(queue->mutexIndex);
	struct messageQueue_s *message;
	while (queue != NULL) {
		message = removeFrontOfQueue(queue);
		free(message);
	}
	destroyMutex(queue->mutexIndex);
	free(queue);
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
void *removeFrontOfQueue(struct messageQueue_s *queue) {
	void *ret = NULL;
	struct messageQueue_s *nextItem;
	lockMutex(queue->mutexIndex);
	if (queue->data == NULL) {
		// empty queue
		ret = NULL;
	}
	else {
		ret = queue->data;
		/* if the queue loops back on itself, then we just need to clear the data field */
		if (queue->next == queue->previous) {
			queue->data = NULL;
		}
		/* otherwise knock item out of the queue */
		else {
			/* hacky version - move the data of the 2nd item into the front of the queue,
			 *                 link front of the queue to 3rd item in queue and free item 2 */
			nextItem = queue->next;
			queue->data = nextItem->data;
			queue->next = nextItem->next;
			free(nextItem);
		}
	}
	unlockMutex(queue->mutexIndex);
	return ret;
}

/* Function Name: addMessageToQueue
 * Parameters: 
 *		IN:
 *			queue		- pointer to structure to initialise.
 *			message		- object to place onto queue.
 *
 * Adds message onto the back of the queue, increasing the size of the queue if necessary.
 */
void addToQueue(struct messageQueue_s *queue, void *message) {
	lockMutex(queue->mutexIndex);
	if (queue->data == NULL) {
		queue->data = message;
	}
	else {
		struct messageQueue_s *newItem = malloc(sizeof(struct messageQueue_s));
		newItem->data = message;
		/* replace the end of the queue to fit in new item in queue, 
		 * and tie it into the cyclic buffer */
		newItem->previous = queue->previous;
		newItem->next = queue->previous->next;
		newItem->mutexIndex = queue->mutexIndex;
		
		(queue->previous)->next = newItem;
		queue->previous = newItem;
	}
	unlockMutex(queue->mutexIndex);
}
