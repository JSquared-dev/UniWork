#include <bios/stdio.h>
#include <bios/stdioint.h>
#include <bios/timer.h>
//#include <stdarg.h>

extern void ser_write(const char *buf, int nr);
extern int  ser_read(char *buf, int nr);
extern int  ser_stat(void);
extern void ser_init(void);

struct stdfn stdfn =
{
	ser_write,
	ser_read,
	ser_stat,
        ser_init
};

int printf(const char *fmt, ...)
{
	char buffer[1024];
	va_list ap;
	int len;

	va_start(ap, fmt);
	len = vsprintf(buffer, fmt, ap);
	va_end(ap);

	if (stdfn.write)
		stdfn.write(buffer, len);

	return len;
}

int getc(void)
{
	char buffer[2];

	clear_timer(KEY_TIMER);

	return (stdfn.read(buffer, 1) == 1) ? buffer[0] : -1;
}

int getc_timed(int cs)
{
	char buffer[2];

	set_timer(KEY_TIMER, cs);

	return (stdfn.read(buffer, 1) == 1) ? buffer[0] : -1;
}
