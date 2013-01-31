#include <bios/types.h>
#include <bios/time.h>
#include <bios/timer.h>
#include <bios/malloc.h>
#include <bios/stdioint.h>

void __gccmain(void) {}

extern int main(int, char**);
void crt0(void)
{
    timer_init();
    malloc_init();
    if (stdfn.init) stdfn.init();
    main(0,NULL);
}  /* crt0() */
