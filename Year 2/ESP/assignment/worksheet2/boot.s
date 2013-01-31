/****************************************************************************
*   A very simple start up for the Puppeteer
*   taken from Rob Smith's full example code
*   by Craig 4th Oct 2004
*****************************************************************************/


/***************************************************************************
*
*                        Define constants.
*
***************************************************************************/
/*
 * GNU related constants
 */
#define    _ASMLANGUAGE   
#define ARM             120     /* CPU_FAMILY */
#define ARMSA110        124     /* CPU */
#define CPU_FAMILY      ARM

#define ARM_HAS_HALFWORD_INSTRUCTIONS 1

#define CP_MMU 15
#define MMU_INIT_VALUE 0x0


/***************************************************************************
*
*                 Exported internal functions.
*
***************************************************************************/
    .globl    _romInit       /* Start of system code       */
    .globl    _sdata         /* Start of data              */
    .globl    _WarmBoot      /* Warm boot entry point.     */


/***************************************************************************
*
*                   Imported external functions.
*
***************************************************************************/
    .extern    crt0

/***************************************************************************
*
*                   Start of data string.
*
***************************************************************************/
    .data
_sdata:
    .asciz    "start of data"
    .balign    4


/***************************************************************************
*
* romInit - Entry point from ROM.
*
* romInit
*     (
*     int startType    /@ only used by 2nd entry point @/
*     )
*
***************************************************************************/
    .text
    .balign 4

_romInit:

    /*
     * Set processor and MMU to known state as follows (we may have not
     * been entered from a reset):
     *
     * MMU Control Register layout.
     *
     * bit
     *  0 M 0 MMU disabled
     *  1 A 0 Address alignment fault disabled, initially
     *  2 C 0 Data cache disabled
     *  3 W 0 Write Buffer disabled
     *  4 P 1 Should Be One (PROG32 on earlier CPUs)
     *  5 D 1 Should Be One (DATA32 on earlier CPUs)
     *  6 L 1 Should Be One (Late abort on earlier CPUs)
     *  7 B 0 Little-endian
     *  8 S 0 System bit to zero } Modifies MMU protections, not really
     *  9 R 1 ROM bit to one     } relevant until MMU switched on later.
     * 10 F 0 Should Be Zero
     * 11 Z 0 Should Be Zero (Branch prediction control on 810)
     * 12 I 0 Instruction cache disabled
     *
     * Setup MMU Control Register
     */
	
#ifdef NO_MMU
    MOV    r1, #MMU_INIT_VALUE
    MCR    CP_MMU, 0, r1, c1, c0, 0    /* Write to MMU CR */
    MOV    r0,r0
    MOV	   r0,r0
    MOV    r0,r0  /*3 nops to clear the cache of 3 instructions */
#endif /* NO_MMU */
    /*
     * Initialise the stack pointer.
     */
    LDR    sp, L$_STACK_ADDR  
    MOV    fp, #0            /* zero frame pointer */

    /*
     * Jump to C entry point in ROM: routine - entry point + ROM base
     */
    LDR    r1, L$_rStrtInRom       /* r0 = boot type */
    MOV    pc, r1     /* r0 = boot type */

Halt:   B       Halt
/**************************************************************************/



/***************************************************************************
*
*                        Define parameters.
*
***************************************************************************/
    .balign    4
    /*
     * PC-relative-addressable pointers - LDR Rn,=sym was (is?) broken
     * note "_" after "$" to stop preprocessor performing substitution
     */
L$_rStrtInRom:
    .long     crt0

L$_STACK_ADDR:
#ifdef NO_MMU
    .long    0xC0004000    /* 16K stack from C0000000 to C0003FFF */
#else
    .long    0x80004000    /* 16K stack from 80000000 to 80003FFF */
#endif



