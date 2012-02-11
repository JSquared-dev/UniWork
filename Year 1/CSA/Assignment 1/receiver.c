
/* ***************************Receiver File*****************************
 *
 *Author: Sami Giacaman
 *Date Created: 12/11/2011
 *Date Modified: 
 *Purpose: A Program to act as a Receiver for Another Computer Transmitter.
 *
 ********************************************************************** */

/* ***************************Include Part**************************** */

#include <stdio.h>
#include <conio.h>
#include <string.h>
#define EndT 0x80       /* To Be Used for Knowing When it is the End of Transmitting. */

/* ******************************************************************* */

/* ***************************Main Program**************************** */

int main(void) 

{
	
	char rdmode[] ="r";                           /* Used For Reading Data From the COM Port. */
	char wtmode[] ="w";                           /* Used For Writing Data to File. */
	char pname[]  ="COM1";
	char error1[] ="\nFail to Open COM Port.\n";                        /* Error Message One. */
	char error2[] ="\nFail to Open Data File.\n";                       /* Error Message Two. */
	char fname[]  ="C:/CSA/data.txt";                                   /* File Location. */ 
	char Receive[] ="\n\nReceiving Completed!.\n";                      /* Received Message. */   
	char PasswordMessage[] = "\nPlease Enter Password:\n";              /* Password Request. */
	char Password[16] ={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};                 /* 15 Char Password. */
	char PasswordScan[] ="%15s";                                        /* Password Length Scan. */
	
	char Intro[] ="           **********************Receiver Program*********************\n"; /* Intro Display. */
	FILE *portptr;
	FILE *fileptr;
	int  PassLength = 0;
	int c;
	
	
	__asm
	{
	    lea     eax,Intro                    /* Display an Into Message. */
		push    eax 
		call    DWORD PTR (printf)           /* Display Message. */
		add     esp, 4
	    lea     eax,PasswordMessage          /* Display an Input Password Message. */
		push    eax 
		call    DWORD PTR (printf)           /* Display Message. */
		add     esp, 4
	    lea     eax, Password
        push    eax
		lea     eax, PasswordScan
		push    eax
		call    DWORD PTR (scanf)             /* Scan the Input Password. */ 
		add     esp, 4                        /* Clean Password of the Stack. */
	    call    DWORD PTR (strlen)            /* Get The Password Length. */ 
		add     esp, 4
		mov     PassLength, eax
		
		/* **********************************************************************
		 * Open File. Make Sure its Open, to Write on it the Received Data.
		 ********************************************************************** */
		
	    lea     eax,wtmode
		push    eax
		lea     eax,fname
		push    eax
		call    DWORD PTR (fopen)            /* Open Data File For Writting. */
		add     esp,8
		mov     fileptr, eax
		or      eax,eax
		
		jnz     PortCheck                    /* Jump to PortCheck, to Open the COM Port, after Opening the File. */
		
		lea     eax,error2                   /* Fail to Open File, Will Display an Error and Shutdown the program. */
		push    eax 
		call    DWORD PTR (printf)           /* Display Error Message. */
		add     esp, 4
		jmp     Endit
		
		
		/* **********************************************************************
		 *	           
		 *            if ((portptr = fopen("COM1", "r"))== NULL)
		 *				{
		 *					printf("Fail to Open COM Port\n"); 
		 *
		 ********************************************************************** */
		
	PortCheck:
		
		lea     eax, rdmode
        push    eax
		lea     eax,pname
		push    eax
		call    DWORD PTR (fopen)             /* Open COM Port For Reading. */
		mov     portptr,eax
        add     esp,8
		xor     edx, edx
		or      eax,eax
		jnz     FPOK                          /* Jump to File/Port OK Loop, to Start Receiving Data, after Check the Port. */
		
		lea     eax,error1                    /* Fail to Open Port, Will Display an Error and Shutdown the program. */
		push    eax
		call    DWORD PTR (printf)            /* Display Error Message. */
		add     esp,4
		jmp     Endit
		
		
		/* ******************************************************************** *
		 *}
		 *  while ((c= fgetc(dp)) != EOF) {
		 *  putch( c);
		 *}
		 ********************************************************************** */
		
	FPOK:	
		
	    push    edx
	    mov     eax, portptr                   /* Get the Next Char, In the COM Port. */
		push    eax
		call    DWORD PTR (fgetc)
		add     esp,4
		pop     edx
		
		
		/* ******************************************************************** *
		 *
		 *Decryption:
		 *
		 *char Decrypt(char byte)
		 *
		 *{
		 *  char Code= 0x00;
		 *
		 *  byte^=0xAD
		 *
		 *  Code = (byte &0x0f) <<4;
		 *  Code|= ((byte &0xf0) >>4;
		 *}
		 *
		 * And Password XORing with data and Characters.
		 * Also Checking if it's the end of transmitting.
		 *  
		 /* ***************************Decryption***************************** */
		
        lea    ebx, Password
		add    ebx, edx
		
		xor    al,[ebx]                
		ror    al, 4                  /* Effective Nibble Swap for Obfuscation. 
									   * Get Password String so We Can XOR it With One of the 
									   * Characters for Security, edx is our Offset into Password. */
		
		
		
		cmp    al,EndT                /* Compare al to 0x80, to Check if there are no more Chars to be Sent.*/
		je     end                    /* If True, End Program. */
        
		/* ******************************************************************* */
        
        push    edx
		mov		ecx, eax                        /* Move eax to ecx, to be Compared, to know if it's the end of transmitting.
												 * Then also save it's value to the file, and display it on the consol. */ 
		
		cmp     ecx, EOF
		je      end                             /* Escape Loop if NO More File to Process. */  
		
		mov     eax, fileptr         
		push    eax
		push    ecx
		call    DWORD PTR (fputc)               /* Save Char to File. */
		pop     ecx
		add     esp,4
		
		push    ecx
		call    DWORD PTR (putch)               /* Display Char to Screen. */
		add     esp,4
		pop     edx
		inc     edx
		mov     eax, PassLength                 /* To Save The Password Length. */
		cmp     edx, eax                        /* If we Have the End of the Password, Reset to
												 * the Beginning  of Password String to Endlessly Use String.
												 * Repeat Loop Endlessly. */ 
		jge     Resetedx
		
	    jmp     FPOK                            /* Loop Again until the End Of File. */
		
		
		
	Resetedx:     
		
		xor edx,edx                             /* Begin in Negative Offset of Password, edx is Our Offset into Password. */
		jmp  FPOK
		
	end:   
		lea     eax,Receive                     /* Display Received Message. */
		push    eax 
		call    DWORD PTR (printf)              /* Display Message. */
		add     esp, 4
		
	    mov    eax, fileptr          
		push   eax
		call   DWORD PTR (fclose)               /* Close File. */
		add    esp, 4
		
		mov    eax, portptr                 
		push   eax
		call   DWORD PTR (fclose)               /* Flush & Close COM Port. */ 
		add    esp, 4
		
		xor    eax,eax                          /* Clear eax. */
		xor    ecx,ecx                          /* Clear ecx. */
		
		
		
		
	Endit:
		NOP
	}
	/* ******************************************************************* */
	
	return 0;
}

/* ******************************************************************* */

/* ******************************************************************* */


