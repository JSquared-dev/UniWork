
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "main.h"
#include "userTable.h"
#include "thread.h"

#ifdef _WIN32
#include "PDCurses\curses.h"
#else
#include <ncurses.h>
#endif

const char ASCII_CAPITAL_A = 'A';				/* valid station range bottom limit */
const char ASCII_CAPITAL_Z = 'Z';				/* valid station range top limit */
const int USERLIST_ENTRY_POINT = 0x00000001;	/* userList first station index */
const int INIT_MASK = 0x00000000;				/* userList clearance mask */

struct userTable_s *createUserTable () {
	struct userTable_s *userTable = malloc(sizeof(struct userTable_s));
	userTable->ID_mutex = createMutex();
	if (userTable->ID_mutex == NULL) {
		/*need to think what exit code to output for inner mutexes, possibly (exit(0))*/
		/* print error to screen and quit thread? */
	}
	userTable->ID = 0;
	userTable->userList_mutex = createMutex();
	if (userTable->userList_mutex == NULL) {
		/*need to think what exit code to output for inner mutexes, possibly (exit(0))*/
		/* print error to screen and quit thread? */
	}
	userTable->userList = 0;
	return userTable;
}

void destroyUserTable(struct userTable_s *userTable) {
	userTable->ID &= INIT_MASK;
	destroyMutex(userTable->ID_mutex);
	userTable->userList &= INIT_MASK;
	destroyMutex(userTable->userList_mutex);
	free(userTable);
}

/* returns 0 on successful attempt, -1 on unsuccessful */
int addToUserTable(struct userTable_s *userTable, char User) {
	char UserUppercase = toupper(User);
	char offset;

	if ((UserUppercase < ASCII_CAPITAL_A)  || (UserUppercase > ASCII_CAPITAL_Z))
		return -1;
	else
		offset = ASCII_CAPITAL_Z - UserUppercase;
	
	lockMutex(userTable->userList_mutex);
	userTable->userList |= (USERLIST_ENTRY_POINT << offset);
	unlockMutex(userTable->userList_mutex);

	return 0;
}

int removeFromUserTable (struct userTable_s *userTable, char User) {
	char UserUppercase = toupper(User);
	char offset;

	if ((UserUppercase < ASCII_CAPITAL_A)  || (UserUppercase > ASCII_CAPITAL_Z))
		return -1;
	else
		offset = ASCII_CAPITAL_Z - UserUppercase;

	lockMutex(userTable->userList_mutex);
	userTable->userList &= ~(USERLIST_ENTRY_POINT << offset);
	unlockMutex(userTable->userList_mutex);

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
		offset = ASCII_CAPITAL_Z - UserUppercase;		/* user index in a table */

	lockMutex(userTable->userList_mutex);
	result = (userTable->userList & (USERLIST_ENTRY_POINT << offset));	/* finds user state in a table */
	unlockMutex(userTable->userList_mutex);

	return result;
}

void printUserTable(struct userTable_s *userTable, WINDOW *window) {
	int i;
	wprintw(window, "Users");
	for (i = 0; i < 26; i ++) {
		wprintw(window, "%c%.4s", 'A' + i, (checkIfUserActive(userTable,'A' + i) ? "  on" : " off"));
	}
	wrefresh(window);
}

char getCurrentID(struct userTable_s *userTable) {
	char ret;
	lockMutex(userTable->ID_mutex);
	ret = userTable->ID;
	unlockMutex(userTable->ID_mutex);
	return ret;
}

void setCurrentID(struct userTable_s *userTable, char ID) {
	lockMutex(userTable->ID_mutex);
	userTable->ID = ID;
	unlockMutex(userTable->ID_mutex);
}
