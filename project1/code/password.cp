#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/password.c"
sbit LCD_RS at porta.b2;
sbit LCD_EN at porta.b1;
sbit LCD_D4 at portd.b4;
sbit LCD_D5 at portd.b5;
sbit LCD_D6 at portd.b6;
sbit LCD_D7 at portd.b7;
sbit LCD_RS_Direction at Trisa.b2;
sbit LCD_EN_Direction at Trisa.b1;
sbit LCD_D4_Direction at Trisd.b4;
sbit LCD_D5_Direction at Trisd.b5;
sbit LCD_D6_Direction at Trisd.b6;
sbit LCD_D7_Direction at Trisd.b7;
sbit input at portb.b4;
sbit ok at portb.b5;
char i;
char password[4]={0,0,0,0};
unsigned int input_pass;
unsigned int correct_pass=1234;
char txt1[]="correct password";
char txt2[]="wrong password";

void main() {
 lcd_init();
 ANSELH=0;
 ANSEL=0;
 Trisb=255;
 lcd_cmd(_lcd_clear);
 lcd_cmd(_lcd_cursor_off);
 while(1)
 {
 i=0;
 lcd_out(1,1,"password:");
 lcd_out(1,11,"****");
 if(ok)
 {
 delay_ms(250);
 while(i<4)
 {
 if(ok)
 {
 while(ok);
 i++;
 }
 else if(input)
 {
 delay_ms(500);
 password[i]++;
 password[i]%=10;
 }
 Lcd_Chr(1,11+i,' ');
 Delay_ms(250);
 Lcd_Chr(1,11+i,password[i]+48);
 delay_ms(250);
 }
 input_pass=1000*password[0]+100*password[1]+10*password[2]+password[3];
 LCD_cmd(_LCD_CLEAR);
 if(input_pass==correct_pass)
 { Lcd_Out(1,1,txt1); }
 else
 { Lcd_Out(1,1,txt2); }
 delay_ms(1000);
 password[0]=0;
 password[1]=0;
 password[2]=0;
 password[3]=0;
 LCD_cmd(_LCD_CLEAR);
 }
 }
}
