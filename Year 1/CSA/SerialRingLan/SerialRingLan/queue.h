
#ifndef _queue_H_
#define _queue_H_

#define MAX_QUEUE_SIZE 64

#include "thread.h"

struct queue_s {
	struct queue_s *previous; /* previsou item in queue. wraps when underflowing the queue */
	struct queue_s *next; /* next item in queue. wraps when overflowing the queue */
	void *data; /* data to be held in queue */
	mutex_t *mutexIndex; /* mutex for this queue */
};

struct queue_s *createQueue();
int destroyQueue(struct queue_s *queue);
int increaseQueue(struct queue_s *queue, int amount);
void *removeFrontOfQueue(struct queue_s *queue);
void addToQueue(struct queue_s *queue, void *message);

void *removeItemFromQueue(struct queue_s *queue); /* used automatically, do not use without due care */
void expediteQueueItemToFront(struct queue_s *frontQueue, struct queue_s *queueItem);

#endif
