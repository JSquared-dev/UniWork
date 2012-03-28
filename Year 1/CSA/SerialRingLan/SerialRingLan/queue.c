
#include "queue.h"
#include <stdlib.h>
#include <stdio.h>

/*	Function Name: createqueue
 *	Written by: James Johns.
 *	Date: 28/3/2012
 *	Returns:
 *		An allocated and initialised queue object.
 *
 *	Notes:
 *		Allocates and initialises the structure pointed to by 'queue', and allocates memory for the queue data.
 *		destroyqueue should be called on queue when finished with it.
 *
 */
struct queue_s *createQueue() {
	struct queue_s *queue = (struct queue_s *)malloc(sizeof(struct queue_s));
	queue->next = queue->previous = queue;
	queue->data = NULL;
	queue->mutexIndex = createMutex();
	return queue;
}

/*	Function Name: destroyqueue
 *	Parameters:
 *		queue		- pointer to structure to initialise
 *
 *	Notes:
 *		Destroys the structure pointed to by 'queue', and frees any memory allocated to it 
 *		by the message queue functions.
 *		If necessary, the address of queue should be freed after this function.
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

/*	Function name: setupCOMPort
 *	Written by: James Johns. 
 *	Date: 28/3/2012
 *	Parameters:
 *		queue - queue item to remove from the queue.
 *
 *	Notes:
 *		Remove the item specified by queue.
 *		Releases any memory allocated to the queue item if necessary.
 *		Returns NULL if queue is empty, otherwise returns data field of queue item being removed.
 *		WARNING - does not lock queue->mutexIndex. Must be locked before calling this function to 
 *					ensure data integrity.
 *
 */
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

/*	Function Name: removeFrontOfqueue
 *	Written by: James Johns.
 *	Date: 28/3/2012
 *	Parameters: 
 *		queue - pointer to structure to initialise.
 *	Returns:
 *		data field of first item entered into queue.
 *
 *	Notes:
 *		Returns the data field of the first object placed into queue, and removes it from the queue.
 *		Uses removeItemFromQueue() to remove the item from the queue.
 *
 */
void *removeFrontOfQueue(struct queue_s *queue) {
	void *ret = NULL;
	lockMutex(queue->mutexIndex);
	ret = removeItemFromQueue(queue);
	unlockMutex(queue->mutexIndex);
	return ret;
}


/*	Function Name: addMessageToQueue
 *	Parameters:
 *		queue		- pointer to structure to initialise.
 *		message		- object to place onto queue.
 *
 *	Notes:
 *		Adds message onto the back of the queue, increasing the size of the queue if necessary.
 *
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

/*	Function name: expediteQueueItemToFront
 *	Written by: James Johns. 
 *	Date: 28/3/2012
 *	Parameters:
 *		frontQueue - queue item at the front of the queue.
 *		queueItem - item to move to the front of the queue.
 *
 *	Notes:
 *		Moves the item specified by queueItem to the front of the queue.
 *		Locks the mutex associated with the queue to maintain data integrity.
 *
 */
void expediteQueueItemToFront(struct queue_s *frontQueue, struct queue_s *queueItem) {
	
	void *dataHolder;
	struct queue_s *secondSlot;
	lockMutex(frontQueue->mutexIndex);
	if (frontQueue->next == frontQueue) {
		/* already at the front of the queue */
		unlockMutex(frontQueue->mutexIndex);
		return;
	}
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
