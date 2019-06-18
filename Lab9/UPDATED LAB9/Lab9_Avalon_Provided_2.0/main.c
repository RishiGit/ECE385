/************************************************************************
Lab 9 Nios Software

Dong Kai Wang, Fall 2017
Christine Chen, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "aes.h"

// Pointer to base address of AES module, make sure it matches Qsys
volatile unsigned int * AES_PTR = (unsigned int *) 0x00000100;

// Execution mode: 0 for testing, 1 for benchmarking
int run_mode = 0;

/** charToHex
 *  Convert a single character to the 4-bit value it represents.
 *  
 *  Input: a character c (e.g. 'A')
 *  Output: converted 4-bit value (e.g. 0xA)
 */
char charToHex(char c)
{
	char hex = c;

	if (hex >= '0' && hex <= '9')
		hex -= '0';
	else if (hex >= 'A' && hex <= 'F')
	{
		hex -= 'A';
		hex += 10;
	}
	else if (hex >= 'a' && hex <= 'f')
	{
		hex -= 'a';
		hex += 10;
	}
	return hex;
}

/** charsToHex
 *  Convert two characters to byte value it represents.
 *  Inputs must be 0-9, A-F, or a-f.
 *  
 *  Input: two characters c1 and c2 (e.g. 'A' and '7')
 *  Output: converted byte value (e.g. 0xA7)
 */
char charsToHex(char c1, char c2)
{
	char hex1 = charToHex(c1);
	char hex2 = charToHex(c2);
	return (hex1 << 4) + hex2;
}

/** encrypt
 *  Perform AES encryption in software.
 *
 *  Input: msg_ascii - Pointer to 32x 8-bit char array that contains the input message in ASCII format
 *         key_ascii - Pointer to 32x 8-bit char array that contains the input key in ASCII format
 *  Output:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *               key - Pointer to 4x 32-bit int array that contains the input key
 */
 
 //helper functions for encryption

void AddRoundKey(unsigned char * state, unsigned char * keyS)
{
	int i = 0;
	for(;i<16;i++)
	{
		state[i]^=keyS[i];
	}
}

void SubBytes(unsigned char * state)
{
	int i = 0;
	for(i = 0;i<16;i++)
	{
		state[i] = aes_sbox[state[i]];
	}
	
}

void ShiftRows(unsigned char * in)
{
	unsigned char temp = in[1];
	in[1]=in[5];
	in[5]=in[9];
	in[9]=in[13];
	in[13]=temp;
	temp=in[2];
	unsigned char temp1 = in[6];
	in[2]=in[10];
	in[6]=in[14];
	in[10]=temp;
	in[14]=temp1;
	temp = in[15];
	in[15] = in[11];
	in[11] = in[7];
	in[7] = in [3];
	in[3] = temp;
}

void MixCol(unsigned char * in)
{
	int i,j;
	unsigned char a[4];
	a[0] = in[0];
	a[1] = in[1];
	a[2] = in[2];
	a[3] = in[3];
	a[0] = gf_mul[in[0]][2]] ^ gf_mul[in[1]][3]] ^ in[2] ^ in[3];
	a[1] = in[0] ^ gf_mul[in[1]][2]] ^ gf_mul[in[2]][3]] ^ in[3];
	a[2] = in[0] ^ in[1] ^ gf_mul[in[2]][2]] ^ gf_mul[in[3]][3]];
	a[3] = gf_mul[in[0]][3]] ^ in[1] ^ in[2] ^ gf_mul[in[3]][2]];
	in[0]=a[0];
	in[1] = a[1];
	in[2] = a[2];
	in[3] = a[3];
	a[0] = gf_mul[in[4]][2]] ^ gf_mul[in[5]][3]] ^ in[6] ^ in[7];
	a[1] = in[4] ^ gf_mul[in[5]][2]] ^ gf_mul[in[6]][3]] ^ in[7];
	a[2] = in[4] ^ in[5] ^ gf_mul[in[6]][2]] ^ gf_mul[in[7]][3]];
	a[3] = gf_mul[in[4]][3]] ^ in[5] ^ in[6] ^ gf_mul[in[7]][2]];
	in[4]=a[0];
	in[5] = a[1];
	in[6] = a[2];
	in[7] = a[3];
	a[0] = gf_mul[in[8]][2]] ^ gf_mul[in[9]][3]] ^ in[10] ^ in[11];
	a[1] = in[8] ^ gf_mul[in[9]][2]] ^ gf_mul[in[10]][3]] ^ in[11];
	a[2] = in[8] ^ in[9] ^ gf_mul[in[10]][2]] ^ gf_mul[in[11]][3]];
	a[3] = gf_mul[in[8]][3]] ^ in[9] ^ in[10] ^ gf_mul[in[11]][2]];
	in[8]=a[0];
	in[9] = a[1];
	in[10] = a[2];
	in[11] = a[3];
	a[0] = gf_mul[in[12]][2]] ^ gf_mul[in[13]][3]] ^ in[14] ^ in[15];
	a[1] = in[12] ^ gf_mul[in[13]][2]] ^ gf_mul[in[14]][3]] ^ in[15];
	a[2] = in[12] ^ in[13] ^ gf_mul[in[14]][2]] ^ gf_mul[in[15]][3]];
	a[3] = gf_mul[in[12]][3]] ^ in[13] ^ in[14] ^ gf_mul[in[15]][2]];
	in[12]=a[0];
	in[13] = a[1];
	in[14] = a[2];
	in[15] = a[3];
}

void rotWord(unsigned char * in)
{
	unsigned char temp = in[0];
	in[0] = in[1];
	in[1] = in[2];
	in[2] = in[3];
	in[3] = temp;
}

void subWord(unsigned char * in)
{
	int i = 0;
	for(i = 0;i<4;i++)
	{
		in[i] = aes_sbox[in[i]];
	}
}

void KeyExpansions(unsigned char * key, unsigned char * keySchedule)
{
	int i;
	for(i = 0;i<16;i++)
	{
		keySchedule[i] = key[i];
	}
	unsigned char word[4];
	int c =1;
	for(i=16;i<176;i++)
	{
		int j =0;
		for(;j<4;j++)
		{
			word[j]=keySchedule[j+i-4];
		}
		if(i%16==0)
		{
			word = subWord(rotWord(word))^Rcon[c];
			c++;
		}
		int k;
		for(k=0;k<4;k++)
		{
			keySchedule[i]=keySchedule[i-16]^word[k];
			i++;
		}
		
	}
}

void encrypt(unsigned char * msg_ascii, unsigned char * key_ascii, unsigned int * msg_enc, unsigned int * key)
{
	// Implement this function
	unsigned char temp[16];
	unsigned char tempKey[16];
	int i = 0;
	for(;i<16;i++)
	{
		temp[i] = charsToHex(msg_ascii[i*2],msg_ascii[(i*2)+1]);
		tempKey[i] = charsToHex(key_ascii[i*2],key_ascii[(i*2)+1]);
		//now temp and tempkey is a 4x4 matrix of hex values. Each value is two characters 0xAB.
	}
	unsigned char keyS[176];
	KeyExpansions(key_ascii,keyS);
	AddRoundKey(temp,key_ascii);
	for(i=1;i<10;i++)
	{
		SubBytes(temp);
		ShiftRows(temp);
		MixCol(temp);
		AddRoundKey(temp,keyS+(16*(i)));
	}
	SubBytes(temp);
	ShiftRows(temp);
	//MixCol(temp);
	i = i+1;
	AddRoundKey(temp,keyS+(16*(i+1)));
	
}

/** decrypt
 *  Perform AES decryption in hardware.
 *
 *  Input:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *              key - Pointer to 4x 32-bit int array that contains the input key
 *  Output: msg_dec - Pointer to 4x 32-bit int array that contains the decrypted message
 */
void decrypt(unsigned int * msg_enc, unsigned int * msg_dec, unsigned int * key)
{
	// Implement this function
	
}

/** main
 *  Allows the user to enter the message, key, and select execution mode
 *
 */
int main()
{
	// Input Message and Key as 32x 8-bit ASCII Characters ([33] is for NULL terminator)
	unsigned char msg_ascii[33];
	unsigned char key_ascii[33];
	// Key, Encrypted Message, and Decrypted Message in 4x 32-bit Format to facilitate Read/Write to Hardware
	unsigned int key[4];
	unsigned int msg_enc[4];
	unsigned int msg_dec[4];

	printf("Select execution mode: 0 for testing, 1 for benchmarking: ");
	scanf("%d", &run_mode);

	if (run_mode == 0) {
		// Continuously Perform Encryption and Decryption
		while (1) {
			int i = 0;
			printf("\nEnter Message:\n");
			scanf("%s", msg_ascii);
			printf("\n");
			printf("\nEnter Key:\n");
			scanf("%s", key_ascii);
			printf("\n");
			encrypt(msg_ascii, key_ascii, msg_enc, key);
			printf("\nEncrpted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_enc[i]);
			}
			/*printf("\n");
			decrypt(msg_enc, msg_dec, key);
			printf("\nDecrypted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_dec[i]);
			}
			printf("\n");*/
		}
	}
	else {
		// Run the Benchmark
		int i = 0;
		int size_KB = 2;
		// Choose a random Plaintext and Key
		for (i = 0; i < 32; i++) {
			msg_ascii[i] = 'a';
			key_ascii[i] = 'b';
		}
		// Run Encryption
		clock_t begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			encrypt(msg_ascii, key_ascii, msg_enc, key);
		clock_t end = clock();
		double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		double speed = size_KB / time_spent;
		printf("Software Encryption Speed: %f KB/s \n", speed);
		// Run Decryption
		/*begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			decrypt(msg_enc, msg_dec, key);
		end = clock();
		time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		speed = size_KB / time_spent;
		printf("Hardware Encryption Speed: %f KB/s \n", speed);*/
	}
	return 0;
}
