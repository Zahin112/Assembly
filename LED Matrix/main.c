/*
 * LEDdemo.c
 *
 * Created: 4/12/2021 11:05:05 PM
 * Author : User
 */ 

#define F_CPU 1000000

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>



char p[8] = {1,2,4,8,16,32,64,128};
char c[][8]={
		{0x00,0xff,0xff,0x18,0x3c,0x66,0xc3,0x00}
	};

int a=0;
ISR(INT1_vect){
	a = ~a;	
}

int main(void)
{   
    DDRA =0b11111111;
	DDRB =0b11111111;
	//DDRD =0b00000000;//input
	
	GICR = (1<<INT1);
	MCUCR = MCUCR | 00001000;
	MCUCR = MCUCR & 11111011;
	sei(); 
	//unsigned char count =0;

    int i=0,j=0,k=0;
    while (1) {
		
		if(a & 0b00000001) {
			j++;
			_delay_ms(10);
		}
		
		if(j>7) {
			j=0;
			_delay_ms(10);
		}
		//j++;
		
		while(i<8)
		{
			/*k = i-j;
			if (k<0)
			{
				k=(k+8)%8;
			}
			PORTA = p[k];
			PORTB = ~c[0][i];*/
			k=(i+j)%8;
			PORTA = p[i];
			PORTB = ~c[0][k];
			_delay_ms(1);
			i++;
		}
		i=0;
			
		while(i<8)
		{
			k=(i+j)%8;
			PORTA = p[i];
			PORTB = ~c[0][k];
			_delay_ms(1);
			i++;
		}
		i=0;
					
		_delay_ms(40);	
		
    }

    return 0;
}

