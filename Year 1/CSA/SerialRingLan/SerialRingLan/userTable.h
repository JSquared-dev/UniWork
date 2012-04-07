/*************************************************
 *	Filename: userTable.h
 *	Written by: James Johns, Silvestrs Timofejevs
 *	Date: 28/3/2012
 *************************************************/


#ifndef _USERTABLE_H_
#define _USERTABLE_H_

#ifdef _WIN32
#include "PDCurses\curses.h"
#else
#include <ncurses.h>
#endif

struct userTable_s {
	char ID;					/* Our station ID */
	int userList;				/* Bitwise ring station list */
	mutex_t *ID_mutex;
	mutex_t *userList_mutex;
};

struct userTable_s *createUserTable ();
void destroyUserTable (struct userTable_s *userTable);
int addToUserTable (struct userTable_s *userTable, char User);
int removeFromUserTable (struct userTable_s *userTable, char User);
int checkIfUserActive (struct userTable_s *userTable, char User);
void printUserTable(struct userTable_s *userTable, WINDOW *window);

char getCurrentID(struct userTable_s *userTable);
void setCurrentID(struct userTable_s *userTable, char ID);

#endif
