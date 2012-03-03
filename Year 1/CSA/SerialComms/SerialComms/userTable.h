#ifndef _USERTABLE_H_
#define _USERTABLE_H_


/* waiting for comments */
struct userTable_s {
	char ID;
	int *userList;
};


/* creates array with 'a to z' elements, id is ASCII code ( 0 is offline 1 is online) */
int initUserTable (struct userTable_s *userTable);
void destroyUserTable (struct userTable_s *userTable);
int addToUserTable (struct userTable_s *userTable, void* User);
int removeFromUserTable (struct userTable_s *userTable, void* User);
int checkIfUserActive (struct userTable_s *userTable, void* User);
#endif