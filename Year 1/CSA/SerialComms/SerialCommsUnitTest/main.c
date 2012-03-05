//
//  main.c
//  SerialCommsUnitTest
//
//  Created by James Johns on 29/02/2012.
//  Copyright 2012 James Johns. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include "queue.h"

int main (int argc, const char * argv[])
{
	struct queue_s *queue = createQueue();
	if (queue->data != NULL) {
		printf("Invalid Data init");
		return 1;
	}
	if (queue->next != queue) {
		printf("Invalid next init");
		return 2;
	}
	if (queue->previous != queue) {
		printf("Invalid previous init");
		return 3;
	}
	char *test = "Test";
	char *test2 = "Test2";
	
	addToQueue(queue, test);
	addToQueue(queue, test2);
	if (queue->next == queue) {
		printf("Invalid queue add - next");
		return 4;
	}
	if (queue->previous == queue) {
		printf("Invalid queue add - previous");
		return 5;
	}
	if (strcmp(queue->data, "Test")) {
		printf("Invalid Data add");
		return 6;
	}
	char *ret = removeFrontOfQueue(queue);
	
	if (strcmp(queue->data, "Test2")) {
		printf("Invalid remove data");
		return 7;
	}
	if (queue->next != queue) {
		printf("Invalid remove - next");
		return 8;
	}
	if (queue->previous != queue) {
		printf("Invalid remove - previous");
		return 9;
	}
	
	if (strcmp(ret, "Test")) {
		printf("Invalid remove - return data");
		return 10;
	}
	
    return 0;
}

