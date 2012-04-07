/*************************************************
 *	Filename: userTable.c
 *	Written by: James Johns, Silvestrs Timofejevs
 *	Date: 28/3/2012
 *************************************************/


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

#define ASCII_CAPITAL_A 'A'
#define ASCII_CAPITAL_Z 'Z'

/*	Function name: createUserTable
 *	Written by: Silvestrs Timofejevs
 *	Date: 28/3/2012
 *	Returns:
 *		Allocated an initialised userTable_s structure.
 *
 *	Notes:
 *		Allocates and initialises an empty User Table.
 *		Must be destroyed by destroyUserTable().
 *		userTable_s objects are bitfields. Each user is repesented by a single bit. 
 *		If the bit is set, the user is online, not set means user is offline.
 *		Users are identified by their ID letter relative to the alphabet; A=1, B=2, C=3 etc.
 *
 */
struct userTable_s *createUserTable () {
	struct userTable_s *userTable = malloc(sizeof(struct userTable_s));
	userTable->ID_mutex = createMutex();
	userTable->ID = 0;
	userTable->userList_mutex = createMutex();
	userTable->userList = 0;
	return userTable;
}

/*	Function name: createUserTable
 *	Written by: Silvestrs Timofejevs
 *	Date: 28/3/2012
 *	Parameters:
 *		userTable - userTable_s object to destroy
 *
 *	Notes:
 *		Clears, deallocates and destroys a userTable_S object specified by userTable
 *
 */
void destroyUserTable(struct userTable_s *userTable) {
	userTable->ID &= 0;
	destroyMutex(userTable->ID_mutex);
	userTable->userList &= 0;
	destroyMutex(userTable->userList_mutex);
	free(userTable);
}

/* returns 0 on successful attempt, -1 on unsuccessful */

/*	Function name: createUserTable
 *	Written by: Silvestrs Timofejevs
 *	Date: 28/3/2012
 *	Returns:
 *		0 on success, non zero on error.
 *
 *	Notes:
 *		Adds a user to the userTable.
 *
 */
int addToUserTable(struct userTable_s *userTable, char User) {
	char UserUppercase = toupper(User);
	char offset;

	if ((UserUppercase < ASCII_CAPITAL_A)  || (UserUppercase > ASCII_CAPITAL_Z))
		return -1;
	else
		offset = UserUppercase - ASCII_CAPITAL_A;
	
	lockMutex(userTable->userList_mutex);
	userTable->userList |= (1 << offset);
	unlockMutex(userTable->userList_mutex);

	return 0;
}

/*	Function name: removeFromUserTable
 *	Written by: Silvestrs Timofejevs
 *	Date: 28/3/2012
 *	Parameters:
 *		userTable - table to remove user status from
 *		User - user to remove from userTable.
 *	Returns:
 *		0 on sucess, non zero on error.
 *		
 *	Notes:
 *		Clears the bit in the bitfield in userTable relative to User's ID.
 *
 */
int removeFromUserTable (struct userTable_s *userTable, char User) {
	char UserUppercase = toupper(User);
	char offset;

	if ((UserUppercase < ASCII_CAPITAL_A)  || (UserUppercase > ASCII_CAPITAL_Z))
		return -1;
	else
		offset = UserUppercase - ASCII_CAPITAL_A;

	lockMutex(userTable->userList_mutex);
	userTable->userList &= ~(1 << offset);
	unlockMutex(userTable->userList_mutex);

	return 0;
}

/*	Function name: checkIfUserActive
 *	Written by: Silvestrs Timofejevs
 *	Date: 28/3/2012
 *	Parameters:
 *		userTable - table to check status in
 *		User - user to check status for.
 *
 *	Returns:
 *		0 if online, non zero if offline, negative on error.
 *
 *	Notes:
 *		Queries userTable bitfield for status of bit related to User's ID.
 *
 */
int checkIfUserActive (struct userTable_s *userTable, char User) {
	char UserUppercase = toupper(User);
	char offset;
	int result;

	if ((UserUppercase < ASCII_CAPITAL_A)  || (UserUppercase > ASCII_CAPITAL_Z))
		return -1;		/* character is not within allowed id range */
	else
		offset = UserUppercase - ASCII_CAPITAL_A;		/* user index in a table */

	lockMutex(userTable->userList_mutex);
	result = (userTable->userList & (1 << offset));	/* finds user state in a table */
	unlockMutex(userTable->userList_mutex);

	return result;
}

/*	Function name: printUserTable
 *	Written by: James Johns
 *	Date: 28/3/2012
 *	Paramters:
 *		userTable - table to print to window.
 *		window - area of screen to print to. Curses window object.
 *
 *	Notes:
 *		steps through userTable and prints the user status to window.
 *		Uses colour pairs to change the colour of the text of the status when printing to the 
 *		screen; Red for offline, green for offline.
 *		Also prints the status of the user currntly logged in.
 *
 */
void printUserTable(struct userTable_s *userTable, WINDOW *window) {
	int i;
	short pair;
	char *status;
	attr_t attr;
	char userID = getCurrentID(userTable);
	wattr_get(window, &attr, &pair, NULL);
	wprintw(window, "Users");
	for (i = 0; i < 26; i ++) { 
		wattron(window, COLOR_PAIR(pair));
		wprintw(window, "%c", 'A' + i);
		if ((userID == (i + 'A')) || checkIfUserActive(userTable, 'A' + i)) {
			if (pair == 1) { /* use colour pair 1 as a guide for what background we need. */
				wattron(window, COLOR_PAIR(3));
			}
			else {
				wattron(window, COLOR_PAIR(5));
			}
		}
		else {
			if (pair == 1) { /* use colour pair 1 as a guide for what background we need. */
				wattron(window, COLOR_PAIR(4));
			}
			else {
				wattron(window, COLOR_PAIR(6));
			}
		}
		wprintw(window, "%.4s", ((userID == ('A' + i)) ? " you" : 
								 (checkIfUserActive(userTable, 'A' + i) ? "  on" : " off")));
		wattroff(window, COLOR_PAIR(3));
		wattroff(window, COLOR_PAIR(4));
		wattroff(window, COLOR_PAIR(5));
		wattroff(window, COLOR_PAIR(6));
	}
	wattron(window, COLOR_PAIR(pair));
	wrefresh(window);
}

/*	Function name: getCurrentID
 *	Written by: James Johns
 *	Date: 28/3/2012
 *	Parameters:
 *		userTable - userTable_s object used to store current active users
 *	Returns:
 *		The current ID character being used to identify the user
 *
 *	Notes:
 *		
 *
 */
char getCurrentID(struct userTable_s *userTable) {
	char ret;
	lockMutex(userTable->ID_mutex);
	ret = userTable->ID;
	unlockMutex(userTable->ID_mutex);
	return ret;
}

/*	Function name: setCurrentID
 *	Written by: James Johns
 *	Date: 28/3/2012
 *	Parameters:
 *		userTable - userTable object used to store ID.
 *		ID - identifying character ID of the current user.
 *
 *	Notes:
 *		
 *
 */
void setCurrentID(struct userTable_s *userTable, char ID) {
	lockMutex(userTable->ID_mutex);
	userTable->ID = ID;
	unlockMutex(userTable->ID_mutex);
}
