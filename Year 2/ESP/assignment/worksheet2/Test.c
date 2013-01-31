/*****************************************************************************\
*
*   A test application - copied from a program from Transpond
*   Craig 4/10/04
*
\*****************************************************************************/

/*----------------------------------------------------includes---------------*/
#include "include/bios/stdio.h"
/*----------------------------------------------------includes---------------*/

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

typedef void (*VOIDFUNCPTR) ();

#define    TRUE                            1
#define    FALSE                           0

#define    NULL                            ((void *) 0)

#define WAIT_TIME                          20

/*----------------------------------------------------defines----------------*/

/*----------------------------------------------------globals----------------*/
extern void InitPort(void);
extern Terr ReadChar(U32 U32Ticks, U32* pU32Status);
extern U32 CurrentTime(void);
extern void wait_cs(int);


/***************************************************************************
*
* DisplayBanner - Display the banner
*
***************************************************************************/
static void DisplayBanner(void)
{
    printf("Puppeteer GNU application (character and timme echo)\r");
} /* DisplayBanner */


/***************************************************************************
*
* EchoExec - charcter echo executive.
*
***************************************************************************/
static void EchoExec(void)
{
  int Ch;
  Ch = getc_timed(WAIT_TIME);

    for (;Ch != 'x';) 
    {
      Ch = getc_timed(WAIT_TIME);
      printf("You typed char '%c' - Hex 0x%x in %x \r\n",(char)Ch,(unsigned int) (Ch & 0xff), CurrentTime());
    }
} /* EchoExec */


/***************************************************************************
*
* Test - C - entry point.
*
***************************************************************************/

int main(int argc, char** argv)
{
  int i;
  for (i=0; i != 20; i++)
    DisplayBanner();
  printf("\r\n\r\n");
  EchoExec();
    return 0;
} /* BootLoader */
