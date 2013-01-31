#define NR_TIMERS	2

#define KEY_TIMER	0
#define LED_TIMER	1

struct timer {
	unsigned int to;
	unsigned int status;
	void (*to_fn)(int);
};

extern struct timer timers[NR_TIMERS];

extern void clear_timer(int timer);
extern void set_timer(int timer, int cs);
extern void set_timer_fn(int timer, void (*fn)(int));
extern int timer_poll(int timer);

