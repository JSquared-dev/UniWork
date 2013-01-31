@first example assembler program
	@ ------------------------------------------------------------------
	@ Constant values used in this program

	.set	URT1,      0x80010000	@ Base of the Microcontroller I/O space
	.set	UTDR,      0x14	@ Offset to the Serial Data Register
	.set	UTSR1,     0x20	@ Offset to the Serial Status port

	.set	UTSR1_TNF, 0b00000100	@ Mask to check Tx FIFO Not Full
	@ data
	.data
ostring:	.asciz "String printing here!\0"
	@ -----------------------------------------------------------------------
	@ Assembly-language preamble
	.text				@ Executable code follows
	.global	_start			@ "_start" is required by the linker
	.global	main			@ "main" is our main program

_start:
	b	main


	@ -----------------------------------------------------------------------
	@ Start of the main program

main:

	ldr	r1, =URT1		@ Use R1 as a base register for uart

	mov	r0, #'\n'
	bl	wb
	mov	r0, #'h'
	bl	wb
	mov	r0, #'e'
	bl	wb
	mov	r0, #'l'
	bl	wb
	mov	r0, #'l'
	bl	wb
	mov	r0, #'o'
	bl	wb
	mov	r0, #' '
	bl 	wb
	
	ldr 	r5, =ostring
	bl 	ws
	
	b	halt

	@ Send the character to the internal serial port

wb:		ldrb	r2, [r1, #UTSR1]	@ Check the Serial Status port again
	tst	r2, #UTSR1_TNF		@ Can a character be sent out?
	beq	wb			@ No: wait until port is ready

	strb	r0, [r1, #UTDR]	@ Send the actual character out
	mov	pc, lr			@ go back

ws:	mov r4, lr
@	mov r5, r0 		@ free up r0 to pass parameters to wb
	mov r6, #0
ws_loop:
	ldrb r0, [r5, r6]
@	add r6, r6, #1
	cmp r0, #0
	beq halt
	add r6, r6, #1
	bl wb
	b ws_loop
@ws_escape:
@	b halt
@	mov lr, r4
@	mov pc, lr
	
	
halt:		b	halt			@ Do this forever (or until stopped)

	.rept	100				@padding to stop bsp problems
	nop				@better to place at end of boot.s
	.endr					@so we don’t need to remember for each prog!
	@ -----------------------------------------------------------------------
	.end