//
//  main.c
//  RandomNumbers
//
//  Created by James Johns on 19/10/2011.
//  Copyright 2011 xD-Duncesoft. All rights reserved.
//

#include <stdlib.h>
#include <stdio.h>
#include <string.h>


struct fourInts {
	unsigned int first;
	unsigned int second;
	unsigned int third;
	unsigned int fourth;
};

struct threeInts {
	unsigned int first;
	unsigned int second;
	unsigned int third;
};
	/* Simplify displaying help information */
void printHelp();

	/* Main feature functions */
unsigned int randomNumber();
void meanAverage();
void frequencyTest();
void oddEvenTest();
void serialTest();
void gapTest();
void pokerTest();
void maximumTest();
void collectTest();

int main (int argc, const char * argv[])
{
	
	if (argc > 1) {
		if (strcmp(argv[1], "--mean") == 0) {
				/* calculate the mean of 1000 random numbers */
			meanAverage();
		}
		else if (strcmp(argv[1], "--freq") == 0) {
				/* calculate the frequency of 10,000 random numbers between 0 and 9 */
			frequencyTest();
		}
		else if (strcmp(argv[1], "--odd-even") == 0) {
				/* calculate the frequency of odd vs even numbers from 10,000 random numbers */
			oddEvenTest();
		}
		else if (strcmp(argv[1], "--serial") == 0) {
				/* calculate the frequency of each pair of 10,000 random numbers
				 * generate 10,000 pairs of numbers and analyze them. */
			serialTest();
		}
		else if (strcmp(argv[1], "--gap") == 0) {
				/* count the number of successive generated numbers 
				 * between specified number occuring
				 * generate a number until selected number appears
				 * count number of generations required until the number reappears */
			gapTest();
		}
		else if (strcmp(argv[1], "--poker") == 0) {
				/* generate digits, between 0 and 9, in groups of 4
				 * arrange in terms of poker hand, for 1000 sets of numbers */
			pokerTest();
		}
		else if (strcmp(argv[1], "--maximum") == 0) {
				/* 1000 groups of 3 digits between 0 and 9
				 * calculate the number of sets in which the middle number is bigger 
				 * than the first and last numbers */
			maximumTest();
		}
		else if (strcmp(argv[1], "--collect") == 0) {
				/* generate numbers between 0 and 9 
				 * until all numbers have been generated atleast once. */
			collectTest();
		}
		else if (strcmp(argv[1], "--poker-file") == 0) {
				/* repeat --poker test on a file of 4000 ASCII digits 
				 * Use scanf to scan in each digit as an integer. */
		}
		else if (strcmp(argv[1], "--poker-file-no-scanf") == 0) {
				/* repeat --poker-file without using scanf 
				 * instead of ASCII digits, use binary values in file */
		}
		else {
				/* error processing command line arguments */
			printHelp();
		}
		
	}
	else {
			/* error processing command line arguments */
		printHelp();
	}
	printf("\n\n");
    return 0;
}

/* Generate a random number between 0 and 9 inclusive. */
unsigned int randomNumber() {
	unsigned int randomnumber = (unsigned int)(10.0*rand()/(RAND_MAX+1.0));
	return randomnumber;
}

void meanAverage() {
	/* Calculate the mean average of 1000 random numbers between 0 and 9. */
	unsigned int randomNumberTotal = 0;
	for (int i = 0; i < 1000; i++) {
		randomNumberTotal += randomNumber();
	}
	double meanAverage = randomNumberTotal/1000.0;
	printf("\nMean average of 1000 random numbers was found to be: %.5f\n",meanAverage);
}

void frequencyTest() {
	/* Calculate the frequency of each randomly generated value between 0 and 9 
	 * in a selection of 10,000 random numbers */
	unsigned int freqTable[10] = { 0,0,0,0,0,0,0,0,0,0};
	unsigned int random = 0;
	for (int i = 0; i < 10000; i++) {
		random = randomNumber();
		freqTable[random] += 1;
	}
	printf("Frequency Test;\n"
		   "Value |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   |"
		   "\nFreq  |");
	
	/* Loop for each column in table and print data, adjusting whitespace in column depending 
	 * on digits in column data */
	for (int i = 0; i < 10; i ++) {
		double valToPrint = freqTable[i]/100.0;
		if (valToPrint >= 10)
			printf ("%.2f%% |", valToPrint);
		else
			printf (" %.2f%% |", valToPrint);
		
	}
}

void oddEvenTest() {
	/* Count the number of times a randomly generated number is odd or even in a selection of
	 * 10,000 numbers */
	unsigned int table[2] = {0,0};
	for (int i = 0; i < 10000; i++) {
		unsigned int random = randomNumber()%2;
		table[random] += 1;
	}
	printf("Odd/Even Test;\n"
		   "|  Odd  |  Even  |\n"
		   "|%.2f%% | %.2f%% |", table[0]/100.0, table[1]/100.0);
}

void serialTest() {
	/* Count the number of times each ordered pairing of numbers appear in 10,000 pairs 
	 * of randomly generated numbers
	 * e.g. 00, 01, 02, ..., 20, 21, 22, ..., 99.*/
	unsigned int randoms[10][10];
	/* zero out randoms */
	for (int i = 0; i < 10; i++) {
		for (int j = 0; j < 10; j++) {
			randoms[i][j] = 0;
		}
	}
	
	
	for (int i = 0; i < 10000; i++) {
		unsigned int x = randomNumber();
		unsigned int y = randomNumber();
		randoms[x][y] += 1;
	}
	
	/* Table header */
	printf("    |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |");
	/* loop 10 times to display 10 rows. i.e. rows 0 to 9. */
	for (int i = 0; i < 10; i++) {
		/* start new row with title of row */
		printf("\n %d  |", i);
		/* loop 10 more times for each entry in each row, adjust whitespace for formatting
		 * varying number of digits in each data entry. */
		for (int j = 0; j < 10; j++) {
			if (randoms[i][j] < 100)
				printf(" %d  |", randoms[i][j]);
			else
				printf(" %d |", randoms[i][j]);
		}
	}
}

void gapTest() {
	unsigned int count = 0;
	unsigned int random = randomNumber();
	
	do {
		count++;
	} while (random != randomNumber());
	
	printf("It took %d random numbers to repeat the number %d\n", count, random);
}


void pokerTest() {
	unsigned int randoms[1000][4];
	for (int i = 0; i < 1000; i++) {
		for (int j = 0; j < 4; j++) {
			unsigned int randnum = randomNumber();
			if (j == 0) {
				randoms[i][j] = randnum;
			}
			else {
				int k = 0;
				while (k < 4 && randoms[i][k] < randnum) {
					k++;
				}
				unsigned int tmp;
				while (k < 4) {
					tmp = randoms[i][k];
					randoms[i][k] = randnum;
					randnum = tmp;
					k++;
				}
			}
		}
	}
	
	unsigned int count[5] = {0,0,0,0,0};
	/* Use 'int i' to reference the generation of numbers we're looking at */
	for (int i = 0; i < 1000; i++) {
		/* tmpCount is used to count how many of each number we have */
		unsigned int tmpCount[10] = {0,0,0,0,0,0,0,0,0,0};
		/* Use k to reference the random number we're looking at */
		for (int k = 0; k < 4; k++) {
			unsigned int offset = randoms[i][k];
			tmpCount[offset] += 1;
		}
		/* Use 'pairCount' to count pairs in the number set. If a three or four of a kind
		 * is found, set discovered to non-zero */
		unsigned int pairCount = 0, discovered = 0;
		for (int k = 0; k < 10; k++) {
			if (tmpCount[k] == 4) {
				count[4] += 1;
				discovered++;
				break;			/* not possible to find any more groupings */
			}
			else if (tmpCount[k] == 3) {
				count[3] += 1;
				discovered++;
				break;			/* not possible to find any more groupings */
			}
			else if (tmpCount[k] == 2) {
				pairCount++;
				if (pairCount == 2)
					break;		/* not possible to find any more groupings */
				else
					continue;	/* could find 1 more pair */
			}
		}
		if (pairCount == 2) {
			count[2] += 1;
		}
		else if (pairCount == 1) {
			count[1] += 1;
		}
		else if (!discovered) {
			count[0] += 1;
		}
		
		/* unsure how to check each number set */
		/*
		if (randoms[i].first == randoms[i].second) {
			if (randoms[i].first == randoms[i].third) {
				if (randoms[i].first == randoms[i].fourth) {
					count[4] += 1;
				}
				else {
					count[3] += 1;
				}
			}
			else if (randoms[i].first == randoms[i].fourth) {
				count[2] += 1;
			}
			else {
				count[1] += 1;
			}
		}
		else if (randoms[i].first == randoms[i].third) {
			if (randoms[i].first == randoms[i].fourth) {
				count[2] += 1;
			}
			else {
				count[1] += 1;
			}
		}
		else if (randoms[i].first == randoms[i].fourth) {
			count[1] += 1;
		}
		else {
			count[0] += 1;
		} */
	}
	printf("|  None  |  Pair  | 2-Pair |  ToaK  |  FoaK  |\n|");
	for (int i = 0; i < 5; i ++) {
		if (count[i] >= 100)
			printf("   %d  |", count[i]);
		else if (count[i] >= 10)
			printf("   %d   |", count[i]);
		else
			printf("   %d    |", count[i]);
	}
}

void maximumTest() {
	unsigned int count = 0;
	
	for (int i = 0; i < 1000; i++) {
		unsigned int first	= randomNumber();
		unsigned int second	= randomNumber();
		unsigned int third	= randomNumber();
		
		if (second > first && second > third) {
			count++;
		}
	}
	
	printf("Of 1000 randomly generated triplets, %d of them had a middle number bigger than the first and third", count);
	
}

void collectTest() {
	unsigned int count = 0;
	unsigned int generated[10] = {0,0,0,0,0,0,0,0,0,0};
	while (1) {
		generated[randomNumber()] += 1;
		count ++;
		if (count >= 10) {
			unsigned int genCount = 0;
			for (int i = 0; i < 10; i++) {
				if (generated[i] != 0) {
					genCount++;
				}
			}
			if (genCount == 10)
				break;
		}
	}
	
	printf("It has taken %d tries to generate 1 of each number between 0 and 9 inclusively atleast" 
		   "1 time each.\n", count);
	
}

void printHelp() {
	
	printf("Please specify a valid command line argument.\n\nChoices include:\n\n\t"
		   "--mean:\t\t\tCalculate the mean average of 1000 random numbers\n\t"
		   "--freq:\t\t\tCalculate the frequency of 10,000 random numbers between 0 and 9\n\t"
		   "--odd-even:\t\tCalculate the frequency of generating an odd or even number\n" 
		   "\t\t\t\tfrom 10000 random numbers\n\t"
		   "--serial:\t\tCount the number of times each pairing of random numbers \n"
		   "\t\t\t\tbetween 0 and 9 appear in a selection of 10,000 random numbers\n\t"
		   "--gap:\t\t\tCount the number of random numbers required to repeat the first random number\n\t"
		   "--poker:\t\tCount th number of pairs, two pairs, three of a kinds and four of a kinds\n"
		   "\t\t\t\tIn 1000 sets of 4 randomly generated numbers\n\t"
		   "--maximum:\t\tIn 1000 sets of 3 digits, each randomly generated, count the number of occurrences\n"
		   "\t\t\t\tin which the second number is bigger than the first and third");
}
