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
	struct queue_s *queue = (struct queue_s *)malloc(sizeof(struct queue_s));
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
	struct queue_s *item = (struct queue_s *)removeFrontOfQueue(queue);
	while (item != NULL) {
		free(item);
		item = (struct queue_s *)removeFrontOfQueue(queue);
	}
	destroyMutex(queue->mutexIndex);
	free(queue);
	return 0;
}

void *removeItemFromQueue(struct queue_s *queue) {
	void *ret;
	struct queue_s *nextItem;
	if (queue->data == NULL) {
		// empty queue
		ret = NULL;
	}
	else {
		ret = queue->data;
		nextItem = queue->next;
		/* if the queue loops back on itself, then we just need to clear the data field */
		if (nextItem == queue) {
			queue->data = NULL;
		}
		else {
			queue->data = nextItem->data;
			queue->next = nextItem->next;
			if (queue->previous == nextItem) {
				queue->previous = queue;
			}
			free(nextItem);
		}
	}
	return ret;
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
	lockMutex(queue->mutexIndex);
	ret = removeItemFromQueue(queue);
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
		newItem->next = queue;
		newItem->mutexIndex = queue->mutexIndex;
		
		(queue->previous)->next = newItem;
		queue->previous = newItem;
	}
	unlockMutex(queue->mutexIndex);
}

/* move queueItem to the front of the queue, without changing the order other tha */
void expediteQueueItemToFront(struct queue_s *frontQueue, struct queue_s *queueItem) {
	
	void *dataHolder;
	struct queue_s *secondSlot;
	if (frontQueue->next == frontQueue) {
		/* already at the front of the queue */
		return;
	}
	lockMutex(frontQueue->mutexIndex);
	secondSlot = frontQueue->next;
	
	/* patch over hole where queue item came from */
	queueItem->previous->next = queueItem->next;
	queueItem->next->previous = queueItem->previous;

	/* place queue item in second slot */
	frontQueue->next = queueItem;
	secondSlot->previous = queueItem;
	queueItem->previous = frontQueue;
	queueItem->next = secondSlot;

	/* swap data between second slot and first slot */
	dataHolder = queueItem->data;
	queueItem->data = frontQueue->data;
	frontQueue->data = dataHolder;

	unlockMutex(frontQueue->mutexIndex);
}
