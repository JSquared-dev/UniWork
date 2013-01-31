/*****************************************************************************\
*
* $Workfile: Sa1100.h $
*
* THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
* ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
* THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
* PARTICULAR PURPOSE.
* 
* Copyright (c) 1998, 1999  Transpond Ltd
* 
* Module:   BootServer / Transpond Windows CE BSP for SA1100 based platforms.
*
* Abstract: Debug serial port support.
* 
* Notes:    
*
* $History: Sa1100.h $
* 
* *****************  Version 15  *****************
* User: Rob          Date: 27/06/03   Time: 16:41
* Updated in $/Wince212/Platform/N200/C_APP/include
* Made independant of ancestor.
* 
* *****************  Version 14  *****************
* User: Rob          Date: 24/11/99   Time: 11:52
* Updated in $/Wince212/Platform/N200/C_APP/include
* Correct changes to DDAR macros for MCP port which resulted from an
* error in Intel's November 1999, SA-1100 Specification Update.
* 
* *****************  Version 13  *****************
* User: Rob          Date: 23/11/99   Time: 11:21
* Updated in $/Wince212/Platform/N200/C_APP/include
* Modified definition of DMA DMA_DDAR_ macros in accordance with Intel's
* Nov. 1999 SA-1100 Specification Update
* 
* *****************  Version 12  *****************
* User: Rob          Date: 7/07/99    Time: 17:04
* Updated in $/Wince211/Platform/N200/Inc
* Corrected bug in the definition of the macro DMA_BASE.
* 
* *****************  Version 11  *****************
* User: Rob          Date: 28/06/99   Time: 13:07
* Updated in $/Wince211/Platform/N200/Inc
* Removed psudo register access macros.
* 
* *****************  Version 10  *****************
* User: Rob          Date: 21/06/99   Time: 14:02
* Updated in $/Wince211/Platform/N200/Inc
* Corrected definition of control and status registers such that there
* are 3 locations for this (one for setting bits, one for clearing bits
* and one for reading the bits).
* Added macros for audio and telecom divisor manipulation within the MCP
* control register.
* 
* *****************  Version 9  *****************
* User: Rob          Date: 21/06/99   Time: 11:17
* Updated in $/Wince211/Platform/N200/Inc
* Changed the definition of the structure dmareg to be a single set of
* DMA registers.
* 
* *****************  Version 8  *****************
* User: Rob          Date: 21/06/99   Time: 10:36
* Updated in $/Wince211/Platform/N200/Inc
* Added missing macros for the DMA device address register, as well as
* macros for the DMA control and status register.
* 
* *****************  Version 7  *****************
* User: Rob          Date: 18/06/99   Time: 17:08
* Updated in $/Wince211/Platform/N200/Inc
* Added DMA register address macros and structures.
* 
* *****************  Version 6  *****************
* User: Rob          Date: 7/05/99    Time: 2:22
* Updated in $/Wince211/Platform/N200/Inc
* Definition of SSP_REAL_BASE corrected.
* SSP control register 1 bit-field select mask macros renamed to
* correpond to SA1100 reference manual.
* 
* *****************  Version 5  *****************
* User: Rob          Date: 6/05/99    Time: 13:07
* Updated in $/Wince211/Platform/N200/Inc
* Definition of macro MEM_CTRL_VIRT_BASE corrected.
* 
* *****************  Version 4  *****************
* User: Rob          Date: 5/05/99    Time: 15:33
* Updated in $/Wince211/Platform/N200/Inc
* STRONG_ARM_xxx_CLOCK_RATE macros added.
* 
* *****************  Version 3  *****************
* User: Rob          Date: 27/04/99   Time: 15:18
* Updated in $/Wince211/Platform/N200/Inc
* Video frame buffer address reference removed.
* 
* *****************  Version 2  *****************
* User: Rob          Date: 26/04/99   Time: 12:14
* Updated in $/Wince211/Platform/N200/Inc
* UART support extended to include serial ports 1 and 2.
* 
* *****************  Version 1  *****************
* User: Rob          Date: 14/04/99   Time: 17:19
* Created in $/Wince211/Platform/N200/Inc
* Inserted into VSS.
*
\*****************************************************************************/

#ifndef __INC__SA1100_H__
#define __INC__SA1100_H__

/******************************************************************************/
/*                                                                            */
/* Global symbolic constants                                                  */
/*                                                                            */
/******************************************************************************/

//=====================================================================
//
//                 EXT and EXTV macros.
//
//=====================================================================
#define EXT(d, b) ((((unsigned int)(d))>>(b))&1)
#define EXTV(d, hb, lb)\
 (((((unsigned int)(d))>>(lb))&((((unsigned int)0xffffffff)<<(31-(hb)))>>((lb)+(31-(hb))))) & 0xffffffff)


//=====================================================================
//
//              CPU core clock frequencies.
//
//=====================================================================
#define STRONG_ARM_220_CLOCK_RATE  221200000 // 220 MHz parts.
#define STRONG_ARM_200_CLOCK_RATE  206400000 // 200 MHz parts.
#define STRONG_ARM_190_CLOCK_RATE  191700000 // 190 MHz parts.
#define STRONG_ARM_160_CLOCK_RATE  162200000 // 160 MHz parts.
#define STRONG_ARM_133_CLOCK_RATE  132700000 // 133 MHz parts.


//=====================================================================
//
// CPU register base addresses, access structures and associated macros.
//
//=====================================================================
//=============================================
//
//  Interrupt control (IC) registers.
//
//=============================================
#define IC_REAL_BASE     0x90050000
#define IC_VIRT_BASE     0xA9050000
#ifdef NO_MMU
#define IC_BASE   IC_REAL_BASE
#else
#define IC_BASE   IC_VIRT_BASE
#endif // NO_MMU

struct icreg 
{
    int icip;     // R
    int icmr;     // RW
    int iclr;     // RW
    int icr_0x0C;
    int icfp;     // R
    int icr_0x14;
    int icr_0x18;
    int icr_0x1C;
    int icpr;     // R
};

// Interrupt controller bits.
#define        RTC_ALM       0x80000000
#define        HZ_TIC        0x40000000
#define        OS_TIMER3     0x20000000
#define        OS_TIMER2     0x10000000
#define        OS_TIMER1     0x08000000
#define        OS_TIMER0     0x04000000
#define        IC_DMA_CH5    0x02000000
#define        IC_DMA_CH4    0x01000000
#define        IC_DMA_CH3    0x00800000
#define        IC_DMA_CH2    0x00400000
#define        IC_DMA_CH1    0x00200000
#define        IC_DMA_CH0    0x00100000
#define        SERIAL_4B     0x00080000  // SSP
#define        SERIAL_4A     0x00040000  // MCP
#define        SERIAL_3      0x00020000  // UART
#define        SERIAL_2      0x00010000  // HSSP/UART
#define        SERIAL_1B     0x00008000  // UART Interrupt
#define        SERIAL_1A     0x00004000  // SDLC Interrupt
#define        SERIAL_0      0x00002000  // UDC 
#define        LCD_CTRL      0x00001000
#define        GPIO_GRP      0x00000800
#define        GPIO_10       0x00000400
#define        GPIO_9        0x00000200
#define        GPIO_8        0x00000100
#define        GPIO_7        0x00000080
#define        GPIO_6        0x00000040
#define        GPIO_5        0x00000020
#define        GPIO_4        0x00000010
#define        GPIO_3        0x00000008
#define        GPIO_2        0x00000004
#define        GPIO_1        0x00000002
#define        GPIO_0        0x00000001

//=============================================
//
// Memory control registers
//
//=============================================
#define MEM_CTRL_REAL_BASE 0xA0000000
#define MEM_CTRL_VIRT_BASE 0xAA000000
#ifdef NO_MMU
#define MEM_CTRL_BASE MEM_CTRL_REAL_BASE
#else
#define MEM_CTRL_BASE MEM_CTRL_VIRT_BASE
#endif // NO_MMU

struct memreg 
   {
   int mdcnfg;
   int mdcas0;
   int mdcas1;
   int mdcas2;
   int msc0;
   int msc1;
   int mecr;
   };

#define PCMCIA_SLOW  0xFFFFFFFF
#define PCMCIA_FAST  0x08840884


//=============================================
//
// GPIO registers.
//
//=============================================
#define GPIO_REAL_BASE  0x90040000
#define GPIO_VIRT_BASE  0xA9040000
#ifdef NO_MMU
#define GPIO_BASE GPIO_REAL_BASE
#else
#define GPIO_BASE GPIO_VIRT_BASE
#endif // NO_MMU

struct gpioreg 
{
    int gplr; // R
    int gpdr; // RW
    int gpsr; // W
    int gpcr; // W
    int grer; // RW
    int gfer; // RW
    int gedr; // RW
    int gafr; // RW
};


//=============================================
//
// OS timer (OST) registerss
//
//=============================================
#define OST_REAL_BASE   0x90000000
#define OST_VIRT_BASE   0xA9000000
#ifdef NO_MMU
#define OST_BASE OST_REAL_BASE
#else
#define OST_BASE OST_VIRT_BASE
#endif // NO_MMU

struct ostreg 
{
    int osmr0;
    int osmr1;
    int osmr2;
    int osmr3;
    int oscr;
    int ossr;
    int ower;
    int oier;
};

#define OSSR_M_M0 0x00000001
#define OSSR_M_M1 0x00000002
#define OSSR_M_M2 0x00000004
#define OSSR_M_M3 0x00000008
#define OIER_M_E0 0x00000001
#define OIER_M_E1 0x00000002
#define OIER_M_E2 0x00000004
#define OIER_M_E3 0x00000008


//=============================================
//
// Real-time clock (RTC) registers.
//
//=============================================
#define RTC_REAL_BASE  0x90010000
#define RTC_VIRT_BASE  0xA9010000
#ifdef NO_MMU
#define RTC_BASE RTC_REAL_BASE
#else
#define RTC_BASE RTC_VIRT_BASE
#endif // NO_MMU

struct rtcreg
   {
   int rtar;
   int rcnr;
   int rttr;
   int pad;
   int rtsr;
   };

// RTC Status reg bits
#define RTC_AL    0x00000001     // Alarm detected
#define RTC_HZ    0x00000002     // 1 HZ rising edge detected
#define RTC_ALE   0x00000004     // Alarm interrupt enabled
#define RTC_HZE   0x00000008     // 1 HZ interrupt enabled


//=============================================
//
// LCD (video) registers.
//
//=============================================
#define LCD_REAL_BASE      0xB0100000
#define LCD_VIRT_BASE      0xAB100000
#ifdef NO_MMU
#define LCD_BASE LCD_REAL_BASE
#else
#define LCD_BASE LCD_VIRT_BASE
#endif // NO_MMU

#define VIDEO_BASE LCD_BASE

/* These are ordered according to the tests in Ashleys area */
/* They DO NOT match the current V2.0 spec as of 4-19-97    */
struct lcd_regs 
{
  int Control0;     /* LCCR0 */
  int Status;       /* LCSR  */
  int Reserved1;    /* Pad   */
  int Reserved2;    /* Pad   */
  int DMA1Base;     /* DBAR1 */
  int DMA1Current;  /* DCAR1 */
  int DMA2Base;     /* DBAR2 */
  int DMA2Current;  /* DCAR2 */
  int Control1;     /* LCCR1 */
  int Control2;     /* LCCR2 */
  int Control3;     /* LCCR3 */
};

struct FrameBuffer 
{
   unsigned short palette [256];
   unsigned char pixel[240][320];
   int row,col;
};

// LCD status register
#define LCD_LFD      0x00000001
#define LCD_BAU      0x00000002
#define LCD_BER      0x00000004
#define LCD_ABC      0x00000008
#define LCD_IOL      0x00000010
#define LCD_IUL      0x00000020
#define LCD_IOU      0x00000040
#define LCD_IUU      0x00000080
#define LCD_OOL      0x00000100
#define LCD_OUL      0x00000200
#define LCD_OOU      0x00000400
#define LCD_OUU      0x00000800

// LCD control register 0 bits.
#define LCD0_M_LEN 0x00000001
#define LCD0_M_CMS 0x00000002
#define LCD0_M_SDS 0x00000004
#define LCD0_M_PAS 0x00000080
#define LCD0_M_BLE 0x00000100
#define LCD0_M_DPD 0x00000200
#define LCD0_M_FDD 0x000FF000
#define LCD0_VIRT_LEN 0
#define LCD0_VIRT_CMS 1
#define LCD0_VIRT_SDS 2
#define LCD0_VIRT_PAS 7
#define LCD0_VIRT_BLE 8
#define LCD0_VIRT_DPD 9
#define LCD0_VIRT_FDD 12

// LCD control register 1 bits.
#define LCD1_M_PPL 0x000003FF
#define LCD1_M_HSW 0x0000FC00
#define LCD1_M_ELW 0x00FF0000
#define LCD1_M_BLW 0xFF000000
#define LCD1_VIRT_PPL 0
#define LCD1_VIRT_HSW 10
#define LCD1_VIRT_ELW 16
#define LCD1_VIRT_BLW 24

// LCD control register 2 bits.
#define LCD2_M_LPP 0x000003FF
#define LCD2_M_VSW 0x0000FC00
#define LCD2_M_EFW 0x00FF0000
#define LCD2_M_BFW 0xFF000000
#define LCD2_VIRT_LPP 0
#define LCD2_VIRT_VSW 10
#define LCD2_VIRT_EFW 16
#define LCD2_VIRT_BFW 24

// LCD control register 3 bits.
#define LCD3_M_PCD 0x000000FF
#define LCD3_M_ACB 0x0000FF00
#define LCD3_M_API 0x000F0000
#define LCD3_M_VSP 0x00100000
#define LCD3_M_HSP 0x00200000
#define LCD3_M_PCP 0x00400000
#define LCD3_M_OEP 0x00800000
#define LCD3_VIRT_PCD 0
#define LCD3_VIRT_ACB 8
#define LCD3_VIRT_API 16
#define LCD3_VIRT_VSP 20
#define LCD3_VIRT_HSP 21
#define LCD3_VIRT_PCP 22
#define LCD3_VIRT_OEP 23



//=============================================
//
// SERIAL PORT 1 (SDLC):
//     - SDLC operation
//     - UART operation.
//
//=============================================
//
// SDLC operation.
//
#define SDLC_REAL_BASE    0x80020060
#define SDLC_VIRT_BASE    0xA8020060

#ifdef NO_MMU
#define SDLC_BASE SDLC_REAL_BASE
#else
#define SDLC_BASE SDLC_VIRT_BASE
#endif // NO_MMU

struct sdlc 
{
   int sdcr0;
   int sdcr1;
   int sdcr2;
   int sdcr3;
   int sdcr4;
   int RES1;
   int sddr;
   int RES2;
   int sdsr0;
   int sdsr1;
   };

//
// UART operation.
//
#define UART1_REAL_BASE    0x80010000
#define UART1_VIRT_BASE    0xA8010000

#ifdef NO_MMU
#define UART1_BASE UART1_REAL_BASE
#else
#define UART1_BASE UART1_VIRT_BASE
#endif // NO_MMU


//=============================================
//
// SERIAL PORT 2 (IrDA):
//     - HSSP operation
//     - UART operation.
//
//=============================================
//
// HSSP operation.
//
#define HSSP_REAL_BASE    0x80040060
#define HSSP_VIRT_BASE    0xA8040060

#ifdef NO_MMU
#define HSSP_BASE HSSP_REAL_BASE
#else
#define HSSP_BASE HSSP_VIRT_BASE
#endif // NO_MMU

struct hssp 
{
   int hscr0;
   int hscr1;
   int RES1;
   int hsdr;
   int RES2;
   int hssr0;
   int hssr1;
   };


//
// UART operation.
//
#define UART2_REAL_BASE    0x80030000
#define UART2_VIRT_BASE    0xA8030000

#ifdef NO_MMU
#define UART2_BASE UART2_REAL_BASE
#else
#define UART2_BASE UART2_VIRT_BASE
#endif // NO_MMU



//=============================================
//
// SERIAL PORT 3 (UART)
//
//
// Note that UART operation is the same for
// serial ports 1 and 2 when they are 
// configured as UARTs.
//
//=============================================
#define UART3_REAL_BASE    0x80050000
#define UART3_VIRT_BASE    0xA8050000

#ifdef NO_MMU
#define UART3_BASE UART3_REAL_BASE
#else
#define UART3_BASE UART3_VIRT_BASE
#endif // NO_MMU

struct uart3 
{
   int utcr0;
   int utcr1;
   int utcr2;
   int utcr3;
   int utcr4; // serial port 2 only.
   int utdr;
   int RES2;
   int utsr0;
   int utsr1;
   };

// UART status register 0 bits.
#define UART_TFS           0x00000001
#define UART_RFS           0x00000002
#define UART_RID           0x00000004
#define UART_RBB           0x00000008
#define UART_REB           0x00000010
#define UART_EIF           0x00000020

// UART status register 1 bits.
#define UART_TBY           0x00000001
#define UART_RNE           0x00000002
#define UART_TNF           0x00000004
#define UART_PRE           0x00000008
#define UART_FRE           0x00000010
#define UART_ROR           0x00000020

// UART control register 0 bits.
#define UART_PE            0x00000001
#define UART_OES           0x00000002
#define UART_SBS           0x00000004
#define UART_DSS           0x00000008
#define UART_SCE           0x00000010
#define UART_RCE           0x00000020
#define UART_TCE           0x00000040
#define UART_N_8_1         0x00000008

// UART control register 1 bits.
#define BAUD_HI            0x00000000

// UART control register 2 bits.
#undef BAUD_9600
#define BAUD_9600          0x00000017
#undef BAUD_19200
#define BAUD_19200         0x0000000B
#undef BAUD_38400
#define BAUD_38400         0x00000005
#undef BAUD_115200
#define BAUD_115200        0x00000001

// UART control register 3 bits.
#define UART_RXE           0x00000001
#define UART_TXE           0x00000002
#define UART_BRK           0x00000004
#define UART_RIM           0x00000008
#define UART_TIM           0x00000010
#define UART_LBM           0x00000020

#define UART_CLEAR_ALL     0xFFFFFFFF
#define UART_DISABL_ALL    0x00000000



//=============================================
//
// SERIAL PORT 4 (UCB1100/1200 bus):
//   - SSP operation
//   - MCP operation.
//
// Note virtual base has to be at 4K page 
// boundary; hence the virtual copy register
// structure is padded accordingly.
//
//=============================================
//
// SSP operation.
//
#define SSP_REAL_BASE 0x80070000
#define SSP_VIRT_BASE 0xA8070000
#ifdef NO_MMU
#define SSP_BASE  SSP_REAL_BASE
#else
#define SSP_BASE  SSP_VIRT_BASE
#endif // NO_MMU

struct sspreg 
{
   int mccr;
   int res1;
   int mcdr0;
   int mcdr1;
   int mcdr2;
   int res2;
   int mcsr;
   int res0x1C;
   int res0x20;
   int res0x24;
   int res0x28;
   int res0x2C;
   int res0x30;
   int res0x34;
   int res0x38;
   int res0x3C;
   int res0x40;
   int res0x44;
   int res0x48;
   int res0x4C;
   int res0x50;
   int res0x54;
   int res0x58;
   int res0x5C;
   int sscr0;
   int sscr1;
   int ssppad0;
   int ssdr;
   int ssppad1;
   int sssr;
};

// SSP control register 0 bits.
#define SSPCR0_M_DSS 0x0000000F
#define SSPCR0_M_FRF 0x00000030
#define SSPCR0_M_SSE 0x00000080
#define SSPCR0_M_SCR 0x0000FF00

// SSP control register 1 bits.
#define SSPCR1_M_RIE 0x00000001
#define SSPCR1_M_TIE 0x00000002
#define SSPCR1_M_LBM 0x00000004

// SSP status register bits.
#define SSPSR_M_TNF 0x00000002
#define SSPSR_M_RNE 0x00000004
#define SSPSR_M_BSY 0x00000008
#define SSPSR_M_TFS 0x00000010
#define SSPSR_M_RFS 0x00000020
#define SSPSR_M_ROR 0x00000040

//
// MCP operation.
//
#define MCP_REAL_BASE 0x80060000
#define MCP_VIRT_BASE 0xA8060000
#ifdef NO_MMU
#define MCP_BASE  MCP_REAL_BASE
#else
#define MCP_BASE  MCP_VIRT_BASE
#endif // NO_MMU

struct mcpreg
   {
   int mccr;
   int res1;
   int mcdr0;
   int mcdr1;
   int mcdr2;
   int res2;
   int mcsr;
   };

// MCP control register bits.
#define MCP_ASD       0x0000007F
#define MCP_ASD_SHIFT 0
#define MCP_TSD       0x00007F00
#define MCP_TSD_SHIFT 8
#define MCP_MCE       0x00010000
#define MCP_ECS       0x00020000
#define MCP_ADM       0x00040000
#define MCP_TTM       0x00080000
#define MCP_TRM       0x00100000
#define MCP_ATM       0x00200000
#define MCP_ARM       0x00400000
#define MCP_LBM       0x00800000
#define MCP_ECP0      0x00000000
#define MCP_ECP1      0x01000000
#define MCP_ECP2      0x02000000
#define MCP_ECP3      0x03000000

// MCP status register bits.
#define MCP_ATS      0x00000001
#define MCP_ARS      0x00000002
#define MCP_TTS      0x00000004
#define MCP_TRS      0x00000008
#define MCP_ATU      0x00000010
#define MCP_ARO      0x00000020
#define MCP_TTU      0x00000040
#define MCP_TRO      0x00000080
#define MCP_ANF      0x00000100
#define MCP_ANE      0x00000200
#define MCP_TNF      0x00000400
#define MCP_TNE      0x00000800
#define MCP_CWC      0x00001000
#define MCP_CRC      0x00002000
#define MCP_ACE      0x00004000
#define MCP_TCE      0x00008000


//=============================================
//
// PPC registers.
//
//=============================================
#define PPC_REAL_BASE 0x90060000
#define PPC_VIRT_BASE 0xA9060000
#ifdef NO_MMU
#define PPC_BASE  PPC_REAL_BASE
#else
#define PPC_BASE  PPC_VIRT_BASE
#endif // NO_MMU

struct ppcreg
   {          // Offset
   int ppdr;  //  00
   int ppsr;  //  04
   int ppar;  //  08
   int psdr;  //  0C
   int ppfr;  //  10
   int RES1;  //  14
   int RES2;  //  18
   int RES3;  //  1C
   int RES4;  //  20
   int RES5;  //  24
   int hscr2; //  28 - HSSP reg (serial port 2)
   int RES7;  //  2C
   int mccr1; //  30 - MCP reg (serial port 4)
   };

#define PPAR_SPR 0x00040000


//=============================================
//
// DMA registers.
//
//=============================================
#define DMA_REAL_BASE 0xB0000000
#define DMA_VIRT_BASE 0xAB000000
#ifdef NO_MMU
#define DMA_BASE  DMA_REAL_BASE
#else
#define DMA_BASE  DMA_VIRT_BASE
#endif // NO_MMU

struct dmareg
   {
   int ddar;      //  0x00
   int dcsr_set;  //  0x04
   int dcsr_clr;  //  0x08
   int dcsr_rd;   //  0x0C
   int dbsa;      //  0x10
   int dbta;      //  0x14
   int dbsb;      //  0x18
   int dbtb;      //  0x1C
   };

// DMA device address register (DDARn) macros
#define DMA_DDAR_RW  0x00000001
#define DMA_DDAR_E   0x00000002
#define DMA_DDAR_BS  0x00000004
#define DMA_DDAR_DW  0x00000008
#define DMA_DDAR_DS  0x000000F0
#define DMA_DDAR_DA  0xFFFFFF00

#define DMA_DDAR_SER0_UDC_TX_LENDIAN     0x80000A04
#define DMA_DDAR_SER0_UDC_TX_BENDIAN     0x80000A06
#define DMA_DDAR_SER0_UDC_RX_LENDIAN     0x80000A15
#define DMA_DDAR_SER0_UDC_RX_BENDIAN     0x80000A17

#define DMA_DDAR_SER1_SDLC_TX_LENDIAN    0x80801E20
#define DMA_DDAR_SER1_SDLC_TX_BENDIAN    0x80801E22
#define DMA_DDAR_SER1_SDLC_RX_LENDIAN    0x80801E31
#define DMA_DDAR_SER1_SDLC_RX_BENDIAN    0x80801E33

#define DMA_DDAR_SER1_UART_TX_LENDIAN    0x80400540
#define DMA_DDAR_SER1_UART_TX_BENDIAN    0x80400542
#define DMA_DDAR_SER1_UART_RX_LENDIAN    0x80400551
#define DMA_DDAR_SER1_UART_RX_BENDIAN    0x80400553

#define DMA_DDAR_SER2_HSSP_TX_LENDIAN    0x81001B64
#define DMA_DDAR_SER2_HSSP_TX_BENDIAN    0x81001B66
#define DMA_DDAR_SER2_HSSP_RX_LENDIAN    0x81001B75
#define DMA_DDAR_SER2_HSSP_RX_BENDIAN    0x81001B77

#define DMA_DDAR_SER2_UART_TX_LENDIAN    0x80C00560
#define DMA_DDAR_SER2_UART_TX_BENDIAN    0x80C00562
#define DMA_DDAR_SER2_UART_RX_LENDIAN    0x80C00571
#define DMA_DDAR_SER2_UART_RX_BENDIAN    0x80C00573

#define DMA_DDAR_SER3_UART_TX_LENDIAN    0x81400580
#define DMA_DDAR_SER3_UART_TX_BENDIAN    0x81400582
#define DMA_DDAR_SER3_UART_RX_LENDIAN    0x81400591
#define DMA_DDAR_SER3_UART_RX_BENDIAN    0x81400593

#define DMA_DDAR_SER4_MCP_AUD_TX_LENDIAN 0x818002A8
#define DMA_DDAR_SER4_MCP_AUD_TX_BENDIAN 0x818002AA
#define DMA_DDAR_SER4_MCP_AUD_RX_LENDIAN 0x818002B9
#define DMA_DDAR_SER4_MCP_AUD_RX_BENDIAN 0x818002BB

#define DMA_DDAR_SER4_MCP_TEL_TX_LENDIAN 0x818003C8
#define DMA_DDAR_SER4_MCP_TEL_TX_BENDIAN 0x818003CA
#define DMA_DDAR_SER4_MCP_TEL_RX_LENDIAN 0x818003D9
#define DMA_DDAR_SER4_MCP_TEL_RX_BENDIAN 0x818003DB

#define DMA_DDAR_SER4_SSP_TX_LENDIAN     0x81C01BEC
#define DMA_DDAR_SER4_SSP_TX_bENDIAN     0x81C01BEE
#define DMA_DDAR_SER4_SSP_RX_LENDIAN     0x81C01BFD
#define DMA_DDAR_SER4_SSP_RX_bENDIAN     0x81C01BFF


// DMA control and status register (DCSRn) macros
#define DMA_DCSR_RUN       0x00000001
#define DMA_DCSR_IE        0x00000002
#define DMA_DCSR_ERROR     0x00000004
#define DMA_DCSR_DONEA     0x00000008
#define DMA_DCSR_STRTA     0x00000010
#define DMA_DCSR_DONEB     0x00000020
#define DMA_DCSR_STRTB     0x00000040
#define DMA_DCSR_BIU       0x00000080

#endif // __INC__SA1100_H__
