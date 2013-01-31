
#define sti()							\
	do {							\
		unsigned int dummy;				\
		__asm__ __volatile__(				\
		"mrs	%0, cpsr\n\t"				\
		"orr	%0, %0, #1 << 7\n\t"			\
		"msr	cpsr, %0" : "=r" (dummy) : : "memory");	\
	} while(0)

#define cli()							\
	do {							\
		unsigned int dummy;				\
		__asm__ __volatile__(				\
		"mrs	%0, cpsr\n\t"				\
		"bic	%0, %0, #1 << 7\n\t"			\
		"msr	cpsr, %0" : "=r" (dummy) : : "memory");	\
	} while(0)


#define save_flags()						\
	({ unsigned int __x; __asm__ __volatile__(		\
		"mrs	%0, cpsr\n\t" : "=r" (__x));		\
	   __x;							\
	})

#define restore_flags(x)					\
	do {							\
		unsigned int dummy;				\
		__asm__ __volatile__(				\
		"mrs	%0, cpsr\n\t"				\
		"bic	%0, %0, #1 << 7\n\t"			\
		"and	%1, %1, #1 << 7\n\t"			\
		"orr	%0, %0, %1\n\t"				\
		"msr	cpsr, %0" : "=r" (dummy) : "r" (x) : "memory"); \
	} while (0)

typedef unsigned long flags_t;
