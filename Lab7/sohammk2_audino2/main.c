#include <stdio.h>

int main()
{
	int i = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x50;
	volatile unsigned int *Reset = (unsigned int*)0x40;
	volatile unsigned int *A = (unsigned int*)0x30;
	volatile unsigned int *S = (unsigned int*)0x20;//make a pointer to access the PIO block

	*LED_PIO = 0; //clear all LEDs
	//*Reset = 1;
	//*S=0;
	int f = 0;
	volatile unsigned int sum = 0;
	        while((1+1)!=3)
	        {
	            if(*A == 1 && f == 0)
	            {
	            	sum = *S + sum;
	            	//sum  = sum%256;
	                //*LED_PIO=(*S+*LED_PIO)%256;
	            	//*LED_PIO=sum;
	            	//*LED_PIO=*LED_PIO+*LED_PIO;
	            	//printf("hi: %x",*S);
	            	f = 1;
	            }

	            if(*A == 0){
	            	f = 0;
	            }
	            if(*Reset == 1)
	            {
	            	sum=0;
	            }
	            *LED_PIO = sum;}


		/*for (i = 0; i < 100000; i++); //software delay
		*LED_PIO |= 0x1; //set LSB
		for (i = 0; i < 100000; i++); //software delay
		*LED_PIO &= ~0x1;} //clear LSB*/
	return 1; //never gets here
}
