/*****************************************************************************\
 *
 *   Setting serial port 3 - get and put routines
 *   Craig 30/11/04
 *
\*****************************************************************************/

/*----------------------------------------------------includes---------------*/
#include <bios/stdio.h>

/*----------------------------------------------------defines----------------*/

/*************************************
 *
 *     Basic type definitions.
 *
 ************************************/
typedef    char                            S08;
typedef    unsigned char                   U08;

typedef    short                           S16;
typedef    unsigned short                  U16;

typedef    int                             S32;
typedef    unsigned int                    U32;

typedef    long                            S64;
typedef    unsigned long                   U64;

typedef    float                           F32;

typedef    U32                             Terr;
typedef    U08                             BOOL;

#define    NULL                            ((void *) 0)

/* UART defines */
#define SA1100_UART1_BASE        0x80010000
#define SA1100_UART3_BASE        0x80030000
#define SA1100_UTCR0             0x00
#define SA1100_UTCR1             0x04
#define SA1100_UTCR2             0x08
#define SA1100_UTCR3             0x0C
#define SA1100_UTCR4             0x10
#define SA1100_UTDR              0x14
#define SA1100_UTSR0             0x1C
#define SA1100_UTSR1             0x20

/*
** UART status definitions
*/
#define SA1100_UTSR1_TBY         0x1   /*  transmitter busy flag         */
#define SA1100_UTSR1_RNE         0x2   /*  receiver not empty (LSR_DR)   */
#define SA1100_UTSR1_TNF         0x4   /*  transmit fifo non full        */
#define SA1100_UTSR1_PRE         0x8   /*  parity read error (LSR_PE)    */
#define SA1100_UTSR1_FRE         0x10  /*  framing error (LSR_FE)        */
#define SA1100_UTSR1_ROR         0x20  /*  receive fifo overrun (LSR_OE) */

/*
** UART Macros 
*/
#define UART_PUT_CHAR(p,c)       ((*(volatile U32 *)(p + SA1100_UTDR)) = c)
#define UART_GET_STATUS(p)       (*(volatile U32 *)(p + SA1100_UTSR1))
#define UART_GET_CHAR(p)         (*(volatile U32 *)(p + SA1100_UTDR))
#define UART_RX_READY(s)         ((s & UTSR1_RNE) == 1)
#define UART_TX_READY(s)         ((s & 4) != 0)
#define UART_TBY_READY(s)         ((s & 1) != 0)

#define UartBase  SA1100_UART3_BASE

/***************************************************************************
 * Prototypes of functions used
 ***************************************************************************/

void SerialWriteByte(U32,const U08);
U32 SerialReadByte(U32);
void delay(void);
/***************************************************************************
 *
 * Test - C - entry point.
 *
 ***************************************************************************/

int main(int argc, char** argv)
{
  volatile U32*    pU32CR0   =  (U32 *)((U08 *)(UartBase) + SA1100_UTCR0);
  volatile U32*    pU32CR1   =  (U32 *)((U08 *)(UartBase) + SA1100_UTCR1);
  volatile U32*    pU32CR2   =  (U32 *)((U08 *)(UartBase) + SA1100_UTCR2);
  volatile U32*    pU32CR3   =  (U32 *)((U08 *)(UartBase) + SA1100_UTCR3);
  volatile U32*    pU32SR0   =  (U32 *)((U08 *)(UartBase) + SA1100_UTSR0);
  volatile U32*    pU32SR1   =  (U32 *)((U08 *)(UartBase) + SA1100_UTSR1);
  int i;
  U32 ch;

  printf("starting");
  /* Wait for any pending transmissions to complete   */
  while(*pU32SR1 & 0x01);

  /* Disable rx, tx and interrupts - to reset line speed */
  *pU32CR3 = 0x0;    

  /* Clear status by writing 1's overkill does doesn't hurt*/
  *pU32SR0 = 0xFF;             

  /* 8 bit, no parity, 1 stop */
  *pU32CR0 = 0x08;     

  /* Set default baud rate, high byte & low byte */
  *pU32CR1 =     0x00;    /* upper baud rate select */
  *pU32CR2 = 1;        /* 1 == 115200 baud. 23 == 9600 baud */

  /* Enable rx and tx, NOT interrupts */
  *pU32CR3 = 0x03 ;            

  delay();  /* wait a while */

  SerialWriteByte(SA1100_UART3_BASE,'h');
  SerialWriteByte(SA1100_UART3_BASE,'e');
  SerialWriteByte(SA1100_UART3_BASE,'l');
  SerialWriteByte(SA1100_UART3_BASE,'l');
  SerialWriteByte(SA1100_UART3_BASE,'o');
  SerialWriteByte(SA1100_UART3_BASE,'\n');
  for ( i = 0; i != 9; i++ )
    {
      ch = SerialReadByte(SA1100_UART3_BASE);
      SerialWriteByte(SA1100_UART3_BASE,(U08)ch);
      SerialWriteByte(SA1100_UART1_BASE,(U08)ch);
    }

  SerialWriteByte(SA1100_UART1_BASE,'B');
  SerialWriteByte(SA1100_UART1_BASE,'Y');
  SerialWriteByte(SA1100_UART1_BASE,'E');
  SerialWriteByte(SA1100_UART1_BASE,'\n');

  return 0;
} /* main - halt */

/******************************************************************************
 * Functions.
 ******************************************************************************/

void SerialWriteByte(U32 UB,const U08 U08Char) 
{
  volatile S32 S32Status ;

  /* wait until we can transmit */
    do 
      {
        S32Status = UART_GET_STATUS(UB) ;
      } 
    while (!UART_TX_READY(S32Status)) ;

    UART_PUT_CHAR(UB, U08Char) ;


    /* wait for the data to flush through the FIFO
       wait for TBY to go 0 - 1 then 1 - 0 
    */
    do /* 0 to 1 */
      {
	S32Status = UART_GET_STATUS(UB) ;
      } 
    while (!UART_TBY_READY(S32Status)) ;
    do /* 1 to 0 */
      {
	S32Status = UART_GET_STATUS(UB) ;
      } 
    while (UART_TBY_READY(S32Status)) ;
    
} /* SerialWriteByte */



U32 SerialReadByte(U32 UB)
{
  U08    U08Char;
  volatile S32 U32Status;
    do 
      {
        U32Status = UART_GET_STATUS(UB) ;
      }
    while (!(U32Status & SA1100_UTSR1_RNE));    /* wait until ready */

    U08Char = UART_GET_CHAR(UB);
    return (U32)U08Char;
} /* SerialReadByte */



void delay(void)
{
  volatile int i;

  for (i=0; i != 100000; i++)
    ;
} /* delay */
