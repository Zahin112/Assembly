/*
 * ADC.c
 *
 * Created: 4/12/2021 11:05:05 PM
 * Author : User
 */ 

#define F_CPU 1000000

#define D4 eS_PORTC2
#define D5 eS_PORTC3
#define D6 eS_PORTC4
#define D7 eS_PORTC5
#define RS eS_PORTC6
#define EN eS_PORTC7

#include <stdio.h> 
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include "lcd.h" 



int main(void)
{   
	DDRD = 0xFF;
	DDRC = 0xFF;
	
	ADMUX = 0b00100110;
	ADCSRA = 0b10000111;
	
	
	char str[30] = {0};
	
	Lcd4_Init();
	
	while(1)
	{	
		ADCSRA |=(1<<ADSC);
		while(ADCSRA & (1<<ADSC)){;}
		
		//count = ADCH;
		float v = (ADCL>>6)*3.5/1024;
		float voltage = (ADCH<<2)*3.5/1024;
		
		//float vl = ADC *3.5/1024;		
		float vlt = v+ voltage;
		
		
		Lcd4_Set_Cursor(1,1);
		//sprintf(str,"%.2f", vl);
		Lcd4_Write_String("Voltage: ");
		
		Lcd4_Set_Cursor(1,10);
		sprintf(str,"%.2f", vlt);
		Lcd4_Write_String(str);
		//Lcd4_Write_Char('S');
		_delay_ms(2);
	}
	
    return 0;
}

