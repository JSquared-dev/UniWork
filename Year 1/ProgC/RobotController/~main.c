

#include <comedilib.h>
#include <comedi.h>
#include <ncurses.h>
#include <stdio.h>

#define VERSION_STRING "v0.1"
#define MENU_MIN_LINE 3
#define MENU_MAX_LINE 7

extern int joystick_start();
void printMenu();
void interpretKey(int key);
void moveCursor(int direction);

int main(int argc, char **argv) {

	initscr();
	timeout(0);
	raw();
	keypad(stdscr, TRUE);
	printMenu();
	int ch = ' ';
	while(ch != 'q') {
		interpretKey(ch);
		refresh();
		ch = getch();
	}
	
	endwin();
	return 0;
}

int runModule(int line) {
  int ret = -1;
     switch (line) {
          case 5:
	       ret = joystick_start();
          break;
          default:
	      
          break;
     }
     return ret;
}

void interpretKey(int key) {
  int ret, y, x;
	switch (key) {
		case KEY_UP:
		case KEY_DOWN:
			moveCursor(key);
			break;
		case '\n':
		  getyx(stdscr,y,x);
		  move(0,0);
		  ret = runModule(y);
		  printMenu();
		  if (ret > 0) {
		    getyx(stdscr,y,x);
		    move(y-1,x);
		    printw("Error executing joystick %d", ret);
		  }
			break;
		default:
			break;
	}
}

void printMenu() {
     clear();
     move(0,0);
     printw("Welcome to the Robot Controller %s\n\n", VERSION_STRING);
     printw("\n\t[ ] Line follower");
     printw("\n\t[ ] Light follower");
     printw("\n\t[ ] Joystick free-roaming");
     printw("\n\t[ ] Retrace last Joystick track");
     printw("\n\t[ ] Free flow AI");
     move(0,0);
     interpretKey(KEY_UP);
     refresh();
}

void moveCursor(int direction) {
	int x, y;
	getyx(stdscr, y, x);
	x = 9;
	if (direction == KEY_UP) {
		y--;
		if (y < MENU_MIN_LINE) {
			y = MENU_MIN_LINE;
		}
	}
	else if (direction == KEY_DOWN) {
		y++;
		/* correct for over shooting menu */
		if (y > MENU_MAX_LINE) {
			y = MENU_MAX_LINE;
		}
	}
	int i;
	for (i = MENU_MIN_LINE; i <= MENU_MAX_LINE; i++) {
		move(i, 9);
		addch(' ');
	}
	move(y,x);
	addch(' '|A_REVERSE);
	move(y,x);
}
