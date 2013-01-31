#include <stdlib.h>
#include <bios/types.h>
#include <bios/system.h>
#include <bios/time.h>
#include <bios/timer.h>


/*************************************
 *
 *   SA1100 specific constants.
 *
 ************************************/
/*
 * OS timers
 */
#ifdef NO_MMU
    #define SA1100_OSMR0                       0x90000000
#else
    #define SA1100_OSMR0                       0xA9000000
#endif

#define SA1100_OSMR1                       (SA1100_OSMR0 + 0x04)
#define SA1100_OSMR2                       (SA1100_OSMR0 + 0x08)
#define SA1100_OSMR3                       (SA1100_OSMR0 + 0x0C)
#define SA1100_OSCR                        (SA1100_OSMR0 + 0x10)
#define SA1100_OSSR                        (SA1100_OSMR0 + 0x14)
#define SA1100_OWER                        (SA1100_OSMR0 + 0x18)
#define SA1100_OIER                        (SA1100_OSMR0 + 0x1C)


/*************************************
 *
 *   1/100 th of a second (10 milliseconds)
 *   in OS timer counts.
 *
 ************************************/
#define SA1100_OSMR_10MS_INC 36864


struct timer timers[NR_TIMERS];
unsigned long centisecs;


void clear_timer(int timer)
{
    timers[timer].to = 0;
    timers[timer].status = 0;
}   /* set_timer() */

void set_timer(int timer, int cs)
{
    timers[timer].to = cs;
    timers[timer].status = 0;
}  /* set_timer() */

void set_timer_fn(int timer, void (*fn)(int))
{
    timers[timer].to_fn = fn;
} /* set_timer_fn() */

void time_interrupt(void)
{
    int i;

    centisecs += 1;

    for (i = 0; i < NR_TIMERS; i++) 
    {
        if (timers[i].to) 
        {
            timers[i].to -= 1;
            if (timers[i].to == 0) 
            {
                timers[i].status = 1;
                if (timers[i].to_fn)
                    timers[i].to_fn(i);
            }
        }
    }
} /* time_interrupt() */

void timer_init(void)
{

    volatile u32* pu32OSMR    = (volatile u32*)SA1100_OSMR0;
    volatile u32* pu32OSSR    = (volatile u32*)SA1100_OSSR;
    volatile u32* pu32OIER    = (volatile u32*)SA1100_OIER;
    volatile u32* pu32OSCR    = (volatile u32*)SA1100_OSCR;
    u32           u32Time;
    int i;

    /*
     * Initialise variables.
     */
    for (i = 0; i < NR_TIMERS; i++)
    {
        timers[i].to     = 0;
        timers[i].status = 0;
        timers[i].to_fn  = NULL;
    }
    centisecs = 0;

    /*
     * Initialise match register 0 for 10 millisecond counting.
     */
    u32Time = *pu32OSCR + SA1100_OSMR_10MS_INC;

    /* Set match register 0  */
    *pu32OSMR = u32Time;
    
    /* Clear status register */
    *pu32OSSR = 1;

    /* Allow "interrupt"     */
    *pu32OIER = 1;

}  /* timer_init() */


int timer_poll(int timer)
{

    volatile u32* pu32OSMR    = (volatile u32*)SA1100_OSMR0;
    volatile u32* pu32OSSR    = (volatile u32*)SA1100_OSSR;
    volatile u32* pu32OIER    = (volatile u32*)SA1100_OIER;
    volatile u32* pu32OSCR    = (volatile u32*)SA1100_OSCR;
    u32           u32Time;

    /*
     * Check for 10 ms time-increment.
     */
    if ( (*pu32OSSR & 1) == 0) return timers[timer].status;

    /*
     * Clear the status register.
     */
    *pu32OSSR = 1;


    /*
     * Process the 10 ms "interrupt".
     */
    time_interrupt();

    /*
     * Set up the next 10 ms time-out.
     */
    u32Time = *pu32OSMR;
    u32Time += SA1100_OSMR_10MS_INC;
    *pu32OSMR = u32Time;

    return timers[timer].status;

}  /* timer_poll() */



void wait_cs(int cs)
{
    int target = centisecs + cs;

    while (centisecs < target) timer_poll(0);
} /* wait_cs() */


u32 CurrentTime(void)
{
    return *(u32*)(SA1100_OSCR);
} /* CurrentTime */
