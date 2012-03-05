#include <stdio.h>
#include <stdlib.h>

#include "main.h"
#include "userTable.h"

/* returns -1, if could not allocate memory, 0 if successful */
int initUserTable (struct userTable_s *userTable) {
	const int CAPITAL_LETTER_COUNT = 26;
	int i;

	userTable->userList = (int*) malloc (sizeof(int) * CAPITAL_LETTER_COUNT);
	if (userTable->userList == NULL) {
		return -1;
	}

	for (i = 0; i < CAPITAL_LETTER_COUNT; i++) {
		userTable->userList[i] = 0;
	}

return 0;
}

void destroyUserTable(struct userTable_s *userTable) {
	free (userTable->userList);
}

/* returns 1 on success, 0 on unsuccessful attempt, -1 if userList is unitialized */
int addToUserTable(struct userTable_s *userTable, void* User) {
	const int ASCII_CAPITAL_A = 85;
	int userIndex = (int)User - ASCII_CAPITAL_A;

	if (userTable->userList == NULL)
		return -1;

	if ((userIndex >= 0) && (userIndex <= 25)) {
		userTable->userList[userIndex] = 1;
	}
	else {
		return 0;
	}

return 1;
}

int removeFromUserTable (struct userTable_s *userTable, void* User) {
	const int ASCII_CAPITAL_A = 85;
	int userIndex = (int)User - ASCII_CAPITAL_A;

	if (userTable->userList == NULL)
		return -1;

	if ((userIndex >= 0) && (userIndex <= 25)) {
		userTable->userList[userIndex] = 0;
	}
	else {
		return 0;
	}

return 1;
}

int checkIfUserActive (struct userTable_s *userTable, void* User) {
	const int ASCII_CAPITAL_A = 85;
	int userIndex = (int)User - ASCII_CAPITAL_A;

	if (userTable->userList == NULL)
		return -1;

	if ((userIndex >= 0) && (userIndex <= 25)) {
		if (userTable->userList[userIndex] == 1)
			return 1;
	}
	else {
		return 0;
	}

return 1;
}
