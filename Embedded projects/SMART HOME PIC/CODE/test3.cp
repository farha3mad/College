#line 1 "D:/EMBEDDED PROJECT/New folder/test3.c"
sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_RS at RD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D4_Direction at TRISD2_bit;
sbit LCD_D4 at RD2_bit;
sbit LCD_D5_Direction at TRISD3_bit;
sbit LCD_D5 at RD3_bit;
sbit LCD_D6_Direction at TRISD4_bit;
sbit LCD_D6 at RD4_bit;
sbit LCD_D7_Direction at TRISD5_bit;
sbit LCD_D7 at RD5_bit;

char i;
char pass[] = {'7','7','7','7'};
char check[5];
char sw_press = 0;
char x=0;
char passwordValid;
char text[7];
unsigned int buffer ;
float volt;
unsigned int temp;

char key_val()
{
 portb=1;
 delay_ms(20);
 if(portb.b4 == 1) return '1';
 else if(portb.b5 == 1) return '2';
 else if(portb.b6 == 1) return '3';
 portb=2;
 delay_ms(20);
 if(portb.b4 == 1) return '4';
 else if(portb.b5 == 1) return '5';
 else if(portb.b6 == 1) return '6';
 portb=4;
 delay_ms(20);
 if(portb.b4 == 1) return '7';
 else if(portb.b5 == 1) return '8';
 else if(portb.b6 == 1) return '9';
 return '@';
}

void main() {
 ANSELH = 0x00;
 ANSEL = 0x01;
 TRISB = 0xF0;
 TRISC = 0x00;
 TRISA = 0x01;
 portc =0;
 portb =0;
 PWM1_init(1000);
 LCD_Init();
 lcd_cmd(_lcd_clear);
 lcd_cmd(_LCD_CURSOR_OFF);
 delay_ms(10);
 lcd_out(1,1,"Enter pass: ");

 for(i=0; i<4; i++) eeprom_write(i,pass[i]);

 while(1)
 {

 sw_press = key_val();
 if(sw_press != '@')
 {
 check[x] = sw_press;
 lcd_chr(1,12+x,sw_press);
 x++;
 if(x>3)
 {
 passwordValid =1;
 for(i=0; i<4; i++) if(check[i] != eeprom_read(i)) passwordValid = 0;

 if(passwordValid){
 lcd_cmd(_lcd_clear);
 lcd_out(1,1,"WLECOME");
 portc.b6 = 1;
 portc.b3 = 1;
 delay_ms(500);
 portc.b3 = 0;
 delay_ms(500);
 portc.b4 = 1;
 delay_ms(500);
 portc.b4 = 0;
 portc.b6 = 0;
 lcd_cmd(_lcd_clear);
 lcd_out(1,1,"Enter pass: ");
 }else{
 portc.b5 = 1;
 lcd_cmd(_lcd_clear);
 lcd_out(1,1,"WORNG PASSWROD!");
 delay_ms(500);
 portc.b5 = 0;
 lcd_cmd(_lcd_clear);
 lcd_out(1,1,"Enter pass: ");
 }
 x=0;
 }
 }
 sw_press = '@';

 buffer = ADC_read(0);
 volt = buffer*4.88;
 temp = volt/10;
 Inttostr(temp,text);
 LCD_OUT(2,1,"Temp= ");
 LCD_OUT_CP(text);
 LCD_Chr_CP(" ");
 LCD_Chr_CP('C');

 if(temp>=20 && temp<30)
 {
 PWM1_stop();
 PWM1_set_duty(204);
 PORTC.b1=0;
 PORTC.b0=0;
 }
 else if(temp>=30 && temp<40)
 {
 PWM1_stop();
 PWM1_set_duty(230);
 PORTC.b1=0;
 PORTC.b0=0;
 }
 else if(temp>40 && temp<50)
 {
 PWM1_stop();
 PWM1_set_duty(255);
 PORTC.b1=0;
 PORTC.b0=0;
 }
 else if(temp<20)
 {
 PWM1_stop();
 PWM1_set_duty(0);
 PORTC.b1=1;
 PORTC.b0=0;
 }
 else if(temp>50)
 {
 PORTC.b1=0;
 PORTC.b0=1;

 }
 delay_ms(10);
 PWM1_start();

 }
}
