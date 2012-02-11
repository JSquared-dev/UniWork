/**************************************************************************************************
 * com_asm.c
 * serial communications program to send a data file encrypted over COM port.
 **************************************************************************************************/
#include <stdio.h>
#include <string.h>
#include <conio.h>

#define EOT 0x80

int main(int argc, const char *argv[]) {
	
	char portOpenType[] = "wb";
	char fileOpenType[] = "rb";

	char portName[] = "COM1";
	char msgFileName[] = "W:/profile/j2-johns/random.txt";

	char errorMsgCOM[] = "Failed to open COM port\n";
	char errorMsgFile[] = "Could not load message file\n";
	char successMsg[] = "Transfer complete!\n";

	char passwordRequest[] = "Please enter password: ";
	char passScanString[] = "%15s";
	char password[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}; /* max 15 letter password */
	int passLength = 0;

	FILE *comport, *srcfile;

	__asm {
		lea eax, passwordRequest
		push eax
		call DWORD PTR [printf]		/* print password request */
		add esp, 4
		lea eax, password
		push eax
		lea eax, passScanString
		push eax
		call DWORD PTR[scanf]		/* scan in password string, scanf(passScanString, password) */
		add esp, 4			/* scrub scan format string from stack, keep password pointer on stack */
		call DWORD PTR[strlen]		/* get length of password by strlen(password) */
		add esp, 4			/* clean password pointer from stack */
		mov passLength, eax		/* save password length */

openFile:
		lea eax, fileOpenType
		push eax
		lea eax, msgFileName
		push eax
		call DWORD PTR [fopen]		/* open message source file, fopen(msgFileName, fileOpenType) */
		add esp, 8			/* stack scrub */
		or eax, eax
		jz fileError			/* if eax == 0, error opening file */
		mov srcfile, eax		/* otherwise, save file pointer */
		jmp openPort			/* continue to open COM port */
fileError:
		lea eax, errorMsgFile
		push eax
		call DWORD PTR [printf]		/* print file error message, printf(errorMsgFile) */
		add esp, 4
		jmp end				/* exit early */

openPort:
		lea eax, portOpenType
		push eax
		lea eax, portName
		push eax
		call DWORD PTR [fopen]		/* open COM port, fopen(portName, portOpenType) */
		add esp, 8
		or eax, eax
		jz portError
		mov comport, eax            	/* save comport file pointer */
		xor ecx, ecx                	/* clear ecx ready for loop. ecx will be our offset into password. */
		jmp L1

portError:
		mov eax, DWORD PTR [errorMsgCOM]
		push eax
		call DWORD PTR [printf]     	/* print com port error message, printf(errorMsgCom) */
		add esp, 4
		jmp end                     	/* exit early */

L1:
		push ecx
		mov eax, sf			/* load up stack to call fgetc(sf) */
		push eax
		call DWORD PTR [fgetc]
		add esp, 4
		pop ecx

    		cmp eax, EOF    		/* end execution if we have hit end of file */
		je end
		
		ror al, 4		     	/* effective nibble swap for obfuscation */
		lea ebx, password		/* get password string so we can xor with one of the characters for security */
		add ebx, ecx			/* ecx is our offset into password */
		xor al, [ebx]
		
		/* al is now encrypted */
		push ecx                    	/* save ecx, as it is our current offset into password[] */
		push cp
		push eax			/* load up stack to call fputc(c, cp) */
		call DWORD PTR [fputc]
		add esp, 8

		push cp				/* load up stack to call fflush(cp) */
		call DWORD PTR [fflush]
		add esp, 4
		pop ecx                     	/* restore ecx for modification */
		inc ecx                     	/* increment through to the next character in password */
		mov eax, passLength    
		cmp ecx, eax		     	/* if we have reached the end of the password */
		jge resetPassCount		/* reset to beginning of password string to endlessly use the string */
		jmp L1				/* repeat loop endlessly. */

/* reset our offset into password by clearing ecx */
resetPassCount:
		xor ecx, ecx			/* ecx is out offset into password. */
		jmp L1

/* finish up by sending EOT, flushing and closing files */
end:
		/* send EOT to receiver */
		mov al, EOT
		ror al, 4		     	/* effective nibble swap for obfuscation. */
		lea ebx, password		/* get password string so we can xor with one of the characters for security. */
		add ebx, ecx			/* ecx is our offset into password. */
		xor al, [ebx]               	/* dereference ebx to get the value within the password array. */

		push comport
		push eax			/* load up stack to call fputc(EOT, comport), when EOT has been encrypted */
		call DWORD PTR [fputc]
		add esp, 8

		lea eax, successMsg
		push eax
		call DWORD PTR [printf]     	/* print transmission complete message, printf(successMsg) */
		add esp, 4
		
		push comport
		call DWORD PTR [fclose]     	/* close comport file, fclose(comport) */
		add esp, 4
		
		push srcfile
		call DWORD PTR [fclose]     	/* close srcfile, fclose(comport) */
		add esp,4
	}
	return 0;
}
