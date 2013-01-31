#include <bios/checksum.h>

unsigned int checksum(void *ptr, int len, unsigned int chksum)
{
	unsigned char *p = (unsigned char *)ptr;
	int i;

	for (i = 0; i < len - 1; i += 2)
		chksum += (p[i] << 8) | p[i + 1];

	if (len & 1)
		chksum += p[len - 1] << 8;

	chksum = (chksum & 0xffff) + (chksum >> 16);
	chksum = (chksum & 0xffff) + (chksum >> 16);

	return chksum;
}
