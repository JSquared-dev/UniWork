@ Generated by gcc 2.95.3 20010315 (release) for ARM/elf
	.file	"main.c"
@ GNU C version 2.95.3 20010315 (release) (arm-linux) compiled by GNU C version 2.95.2 20000220 (Debian GNU/Linux).
@ options passed:  -fverbose-asm
@ options enabled:  -fpeephole -ffunction-cse -fkeep-static-consts
@ -freg-struct-return -fsjlj-exceptions -fcommon -fverbose-asm -fgnu-linker
@ -fargument-alias -fident -mapcs-32 -mshort-load-bytes
@ -mno-short-load-words

gcc2_compiled.:
.section	.rodata
	.align	2
.LC0:
	.ascii	"test string\015\012\000"
	.align	2
.LC1:
	.ascii	"n o w h i t e s p a c e ! ! ! ! !\000"
.text
	.align	2
	.global	main
	.type	 main,function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, current_function_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	mov	r0, #1
	ldr	r1, .L6
	bl	putstring
	ldr	r0, .L6+4
	mov	r1, #1
	bl	putnws
.L3:
.L5:
	b	.L5
.L4:
	mov	r0, #0
	b	.L2
.L7:
	.align	2
.L6:
	.word	.LC0
	.word	.LC1
.L2:
	ldmea	fp, {fp, sp, pc}
.Lfe1:
	.size	 main,.Lfe1-main
	.align	2
	.global	stripwhitespace
	.type	 stripwhitespace,function
stripwhitespace:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, current_function_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	str	r0, [fp, #-16]
	mov	r3, #0
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-20]
.L9:
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-20]
	add	r3, r3, r2
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	cmp	r2, #0
	bne	.L12
	b	.L10
.L12:
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-20]
	add	r3, r3, r2
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	cmp	r2, #32
	beq	.L11
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-24]
	add	r3, r3, r2
	ldr	r2, [fp, #-16]
	ldr	r1, [fp, #-20]
	add	r2, r2, r1
	ldrb	r1, [r2, #0]
	strb	r1, [r3, #0]
	ldr	r3, [fp, #-24]
	add	r2, r3, #1
	str	r2, [fp, #-24]
	b	.L11
.L13:
.L14:
.L11:
	ldr	r3, [fp, #-20]
	add	r2, r3, #1
	str	r2, [fp, #-20]
	b	.L9
.L10:
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-24]
	add	r3, r3, r2
	mov	r2, #0
	mov	r1, r2
	strb	r1, [r3, #0]
.L8:
	ldmea	fp, {fp, sp, pc}
.Lfe2:
	.size	 stripwhitespace,.Lfe2-stripwhitespace
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"