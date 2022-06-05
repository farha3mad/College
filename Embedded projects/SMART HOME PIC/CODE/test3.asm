
_key_val:

	MOVLW      1
	MOVWF      PORTB+0
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_key_val0:
	DECFSZ     R13+0, 1
	GOTO       L_key_val0
	DECFSZ     R12+0, 1
	GOTO       L_key_val0
	NOP
	NOP
	BTFSS      PORTB+0, 4
	GOTO       L_key_val1
	MOVLW      49
	MOVWF      R0+0
	GOTO       L_end_key_val
L_key_val1:
	BTFSS      PORTB+0, 5
	GOTO       L_key_val3
	MOVLW      50
	MOVWF      R0+0
	GOTO       L_end_key_val
L_key_val3:
	BTFSS      PORTB+0, 6
	GOTO       L_key_val5
	MOVLW      51
	MOVWF      R0+0
	GOTO       L_end_key_val
L_key_val5:
	MOVLW      2
	MOVWF      PORTB+0
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_key_val6:
	DECFSZ     R13+0, 1
	GOTO       L_key_val6
	DECFSZ     R12+0, 1
	GOTO       L_key_val6
	NOP
	NOP
	BTFSS      PORTB+0, 4
	GOTO       L_key_val7
	MOVLW      52
	MOVWF      R0+0
	GOTO       L_end_key_val
L_key_val7:
	BTFSS      PORTB+0, 5
	GOTO       L_key_val9
	MOVLW      53
	MOVWF      R0+0
	GOTO       L_end_key_val
L_key_val9:
	BTFSS      PORTB+0, 6
	GOTO       L_key_val11
	MOVLW      54
	MOVWF      R0+0
	GOTO       L_end_key_val
L_key_val11:
	MOVLW      4
	MOVWF      PORTB+0
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_key_val12:
	DECFSZ     R13+0, 1
	GOTO       L_key_val12
	DECFSZ     R12+0, 1
	GOTO       L_key_val12
	NOP
	NOP
	BTFSS      PORTB+0, 4
	GOTO       L_key_val13
	MOVLW      55
	MOVWF      R0+0
	GOTO       L_end_key_val
L_key_val13:
	BTFSS      PORTB+0, 5
	GOTO       L_key_val15
	MOVLW      56
	MOVWF      R0+0
	GOTO       L_end_key_val
L_key_val15:
	BTFSS      PORTB+0, 6
	GOTO       L_key_val17
	MOVLW      57
	MOVWF      R0+0
	GOTO       L_end_key_val
L_key_val17:
	MOVLW      64
	MOVWF      R0+0
L_end_key_val:
	RETURN
; end of _key_val

_main:

	CLRF       ANSELH+0
	MOVLW      1
	MOVWF      ANSEL+0
	MOVLW      240
	MOVWF      TRISB+0
	CLRF       TRISC+0
	MOVLW      1
	MOVWF      TRISA+0
	CLRF       PORTC+0
	CLRF       PORTB+0
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      124
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
	CALL       _Lcd_Init+0
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	NOP
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_test3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	CLRF       _i+0
L_main19:
	MOVLW      4
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main20
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	ADDLW      _pass+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
	INCF       _i+0, 1
	GOTO       L_main19
L_main20:
L_main22:
	CALL       _key_val+0
	MOVF       R0+0, 0
	MOVWF      _sw_press+0
	MOVF       R0+0, 0
	XORLW      64
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       _x+0, 0
	ADDLW      _check+0
	MOVWF      FSR
	MOVF       _sw_press+0, 0
	MOVWF      INDF+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _x+0, 0
	ADDLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _sw_press+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	INCF       _x+0, 1
	MOVF       _x+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_main25
	MOVLW      1
	MOVWF      _passwordValid+0
	CLRF       _i+0
L_main26:
	MOVLW      4
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main27
	MOVF       _i+0, 0
	ADDLW      _check+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FLOC__main+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       FLOC__main+0, 0
	XORWF      R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	CLRF       _passwordValid+0
L_main29:
	INCF       _i+0, 1
	GOTO       L_main26
L_main27:
	MOVF       _passwordValid+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_test3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	BSF        PORTC+0, 6
	BSF        PORTC+0, 3
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	DECFSZ     R11+0, 1
	GOTO       L_main31
	NOP
	NOP
	BCF        PORTC+0, 3
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	DECFSZ     R11+0, 1
	GOTO       L_main32
	NOP
	NOP
	BSF        PORTC+0, 4
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main33:
	DECFSZ     R13+0, 1
	GOTO       L_main33
	DECFSZ     R12+0, 1
	GOTO       L_main33
	DECFSZ     R11+0, 1
	GOTO       L_main33
	NOP
	NOP
	BCF        PORTC+0, 4
	BCF        PORTC+0, 6
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_test3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main34
L_main30:
	BSF        PORTC+0, 5
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_test3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	NOP
	BCF        PORTC+0, 5
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_test3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main34:
	CLRF       _x+0
L_main25:
L_main24:
	MOVLW      64
	MOVWF      _sw_press+0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _buffer+0
	MOVF       R0+1, 0
	MOVWF      _buffer+1
	CALL       _word2double+0
	MOVLW      246
	MOVWF      R4+0
	MOVLW      40
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _volt+0
	MOVF       R0+1, 0
	MOVWF      _volt+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
	MOVF       R0+1, 0
	MOVWF      _temp+1
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _text+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_test3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      _text+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
	MOVLW      ?lstr_7_test3+0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      0
	SUBWF      _temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVLW      30
	SUBWF      _temp+0, 0
L__main52:
	BTFSS      STATUS+0, 0
	GOTO       L_main38
	MOVLW      0
	SUBWF      _temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVLW      32
	SUBWF      _temp+0, 0
L__main53:
	BTFSC      STATUS+0, 0
	GOTO       L_main38
L__main49:
	CALL       _PWM1_Stop+0
	MOVLW      204
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
	BCF        PORTC+0, 1
	GOTO       L_main39
L_main38:
	MOVLW      0
	SUBWF      _temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVLW      32
	SUBWF      _temp+0, 0
L__main54:
	BTFSS      STATUS+0, 0
	GOTO       L_main42
	MOVLW      0
	SUBWF      _temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      34
	SUBWF      _temp+0, 0
L__main55:
	BTFSC      STATUS+0, 0
	GOTO       L_main42
L__main48:
	CALL       _PWM1_Stop+0
	MOVLW      230
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
	BCF        PORTC+0, 1
	GOTO       L_main43
L_main42:
	MOVLW      0
	SUBWF      _temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVLW      34
	SUBWF      _temp+0, 0
L__main56:
	BTFSS      STATUS+0, 0
	GOTO       L_main44
	CALL       _PWM1_Stop+0
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
	BCF        PORTC+0, 1
	GOTO       L_main45
L_main44:
	MOVLW      0
	SUBWF      _temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      30
	SUBWF      _temp+0, 0
L__main57:
	BTFSC      STATUS+0, 0
	GOTO       L_main46
	CALL       _PWM1_Stop+0
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
	BSF        PORTC+0, 1
L_main46:
L_main45:
L_main43:
L_main39:
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main47:
	DECFSZ     R13+0, 1
	GOTO       L_main47
	DECFSZ     R12+0, 1
	GOTO       L_main47
	NOP
	CALL       _PWM1_Start+0
	GOTO       L_main22
L_end_main:
	GOTO       $+0
; end of _main
