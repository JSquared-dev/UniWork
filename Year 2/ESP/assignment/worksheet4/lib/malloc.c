#include <bios/malloc.h>
#include <bios/system.h>
#include <bios/stdio.h>

#define debug_printf printf
#define END_OF_RAM 0x81000000 + 0xFFFFFF

struct free {
	int		size;
	struct free	*next;
};

static struct free *free_list;
extern int ram_size;

void malloc_init(void)
{
	free_list = (struct free *)(END_OF_RAM - 1048576);
	free_list->next = NULL;
	free_list->size = 1048576;
}

void *malloc(int size)
{
	struct free **f;
	void *ptr = NULL;
	flags_t flags;

debug_printf("malloc(%d) ", size);
	size = (size + 19) & ~15;
debug_printf("will malloc %d bytes\n", size);

	flags = save_flags();
	cli();

	for (f = &free_list; *f; f = &(*f)->next) {
		struct free *tf, *nf;

		tf = *f;

debug_printf("  checking block at %p size %d: ", tf, tf->size);

		if (tf->size < size) {
debug_printf("too small\n");
			continue;
		}

		ptr = &tf->next;

		if (tf->size >= size + sizeof(struct free)) {
			nf = (struct free *)((int)ptr + size);
			nf->next = tf->next;
			nf->size = tf->size - size;
			*f = nf;
debug_printf("oversize: creating new block at %p size %d\n", nf, nf->size);
		} else {
debug_printf("exact!\n");
			*f = tf->next;
		}

		tf->size = size;
		break;
	}
debug_printf("malloced at %p\n", ptr);

	restore_flags(flags);

	return ptr;
}

void free(void *ptr)
{
	struct free *tf, **ff;
	flags_t flags;

	if (!ptr)
		return;

	tf = (struct free *)((int)ptr - 4);

debug_printf("freeing %p (block at %p, size %d)\n", ptr, tf, tf->size);

	flags = save_flags();
	cli();

	for (ff = &free_list; *ff; ff = &(*ff)->next) {
		struct free *pf;

		pf = *ff;

		if ((int)pf + pf->size == (int)tf) {
debug_printf(" combining previous at %p size %d and current\n", pf, pf->size);
			pf->size += tf->size;
			tf = pf;
			ptr = NULL;
		}
		if ((int)tf + tf->size == (int)pf) {
debug_printf(" combining current and next at %p size %d\n", pf, pf->size);
			tf->next = pf->next;
			tf->size += pf->size;
			*ff = tf;
			ptr = NULL;
		}
	}

	if (ptr) {
		for (ff = &free_list; *ff && (int)*ff < (int)tf; ff = &(*ff)->next);

		tf->next = NULL;
		*ff = tf;
	}

	restore_flags(flags);
}
