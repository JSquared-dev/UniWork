/* Filename: queue.c
 * Written by: James Johns.
 * Date: 16/2/2012
 *
 *
 * queue is a collection of functions for manipulating a queue_s structure.
 * queue implements a FIFO buffer, or a basic queue. The queue length is dynamically
 * modified as required.
 */

#include "queue.h"
#include <stdlib.h>
#include <stdio.h>

/* Function Name: createqueue
 * Parameters: 
 *		IN:
 *			queue		- pointer to structure to initialise
 *			initialSize - initial number of positions in queue.
 *		OUT:
 *			queue		- fully intialised message queue structure
 *
 * initialises the structure pointed to by 'queue', and allocates memory for the queue data.
 * destroyqueue should be called on queue when finished with it.
 */
struct queue_s *createQueue() {
	struct queue_s *queue = malloc(sizeof(struct queue_s));
	queue->next = queue->previous = queue;
	queue->data = NULL;
	queue->mutexIndex = createMutex();
	return queue;
}

/* Function Name: destroyqueue
 * Parameters: 
 *		IN:
 *			queue		- pointer to structure to initialise
 *
 * Destroys the structure pointed to by 'queue', and frees any memory allocated to it 
 * by the message queue functions.
 * If necessary, the address of queue should be freed after this function.
 */
int destroyQueue(struct queue_s *queue) {
//	lockMutex(queue->mutexIndex);
	struct queue_s *message;
	while (queue != NULL) {
		message = removeFrontOfQueue(queue);
		free(message);
	}
	destroyMutex(queue->mutexIndex);
	free(queue);
	return 0;
}

/* Function Name: removeFrontOfqueue
 * Parameters: 
 *		IN:
 *			queue		- pointer to structure to initialise.
 *		OUT:
 *			return		- address of the first object entered into queue.
 *
 * returns the address of the first object placed into queue, and removes it from the queue.
 */
void *removeFrontOfQueue(struct queue_s *queue) {
	void *ret = NULL;
	struct queue_s *nextItem;
	lockMutex(queue->mutexIndex);
	if (queue->data == NULL) {
		// empty queue
		ret = NULL;
	}
	else {
		ret = queue->data;
		/* if the queue loops back on itself, then we just need to clear the data field */
		if (queue->next == queue) {
			queue->data = NULL;
		}
		/* otherwise knock item out of the queue */
		else {
			/* hacky version - move the data of the 2nd item into the front of the queue,
			 *                 link front of the queue to 3rd item in queue and free item 2 */
			nextItem = queue->next;
			queue->data = nextItem->data;
			queue->next = nextItem->next;
			if (queue->previous == nextItem) {
				queue->previous = queue;
			}
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
void addToQueue(struct queue_s *queue, void *message) {
	lockMutex(queue->mutexIndex);
	if (queue->data == NULL) {
		queue->data = message;
	}
	else {
		struct queue_s *newItem = malloc(sizeof(struct queue_s));
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