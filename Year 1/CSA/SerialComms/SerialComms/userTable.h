#ifndef _USERTABLE_H_
#define _USERTABLE_H_

struct userTable_s {
	char ID;					/* Our station ID */
	int userList;				/* Bitwise ring station list */
	int ID_mutex;
	int userList_mutex;
};

void initUserTable (struct userTable_s *userTable);
void destroyUserTable (struct userTable_s *userTable);
int addToUserTable (struct userTable_s *userTable, char User);
int removeFromUserTable (struct userTable_s *userTable, char User);
int checkIfUserActive (struct userTable_s *userTable, char User);
#endif