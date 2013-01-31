#include <bios/linkage.h>

	.text

ENTRY(memcpy)
1:	subs	r2, r2, #1
	ldrplb	r3, [r1], #1
	strplb	r3, [r0], #1
	bpl	1b
	mov	pc, lr

ENTRY(memzero)
	mov	r2, r1
	mov	r1, #0

ENTRY(memset)
1:	subs	r2, r2, #1
	strplb	r1, [r0], #1
	bpl	1b
	mov	pc, lr


ENTRY(memeq)
	teq	r2, #0
	moveq	r0, #1
	moveq	pc, lr
1:	ldrb	r3, [r0], #1
	ldrb	ip, [r1], #1
	teq	r3, ip
	movne	r0, #0
	movne	pc, lr
	subs	r2, r2, #1
	bne	1b
	mov	r0, #1
	mov	pc, lr

ENTRY(strcpy)
1:	ldrb	r3, [r1], #1
	strb	r3, [r0], #1
	teq	r3, #0
	bne	1b
	mov	pc, lr

ENTRY(strnlen)
	add	r3, r0, #1
1:	ldrb	r2, [r0], #1
	teq	r2, #0
	subnes	r1, r1, #1
	bne	1b
	sub	r0, r0, r3
	mov	pc, lr
