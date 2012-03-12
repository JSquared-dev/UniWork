
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include "main.h"
#include "userTable.h"
#include "thread.h"


const char ASCII_CAPITAL_A = 'A';				/* valid station range bottom limit */
const char ASCII_CAPITAL_Z = 'Z';				/* valid station range top limit */
const int USERLIST_ENTRY_POINT = 0x00000001;	/* userList first station index */
const int INIT_MASK = 0x00000000;				/* userList clearance mask */

void initUserTable (struct userTable_s *userTable) {
	userTable->ID_mutex = createMutex();
	if (userTable->ID_mutex == -1) {
		/*need to think what exit code to output for inner mutexes, possibly (exit(0))*/
	}
	userTable->ID &= INIT_MASK;
	userTable->userList_mutex = createMutex();
	if (userTable->userList_mutex == -1) {
		/*need to think what exit code to output for inner mutexes, possibly (exit(0))*/
	}
	userTable->userList &= INIT_MASK; 
}

void destroyUserTable(struct userTable_s *userTable) {
	userTable->ID &= INIT_MASK;
	destroyMutex(userTable->ID_mutex);
	userTable->userList &= INIT_MASK;
	destroyMutex(userTable->ID_mutex);
}

/* returns 0 on successful attempt, -1 on unsuccessful */
int addToUserTable(struct userTable_s *userTable, char User) {
	char UserUppercase = toupper(User);
	char offset;

	if ((UserUppercase < ASCII_CAPITAL_A)  || (UserUppercase > ASCII_CAPITAL_Z))
		return -1;
	else
		offset = ASCII_CAPITAL_A - UserUppercase;

	userTable->userList |= (USERLIST_ENTRY_POINT << offset);
	return 0;
}

int removeFromUserTable (struct userTable_s *userTable, char User) {
	char UserUppercase = toupper(User);
	char offset;

	if ((UserUppercase < ASCII_CAPITAL_A)  || (UserUppercase > ASCII_CAPITAL_Z))
		return -1;
	else
		offset = ASCII_CAPITAL_A - UserUppercase;

	userTable->userList &= ~(USERLIST_ENTRY_POINT << offset);
	return 0;
}

/* returns -1 on error, 0 if not active, 1 if active */
int checkIfUserActive (struct userTable_s *userTable, char User) {
	char UserUppercase = toupper(User);
	char offset;
	int result;

	if ((UserUppercase < ASCII_CAPITAL_A)  || (UserUppercase > ASCII_CAPITAL_Z))
		return -1;		/* character is not within allowed id range */
	else
		offset = ASCII_CAPITAL_A - UserUppercase;		/* user index in a table */

	result = userTable->userList & (USERLIST_ENTRY_POINT << offset);	/* finds user state in a table */

	return result;
}
