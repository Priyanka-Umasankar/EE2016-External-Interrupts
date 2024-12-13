.org 0
rjmp reset

.org 0x0002
rjmp int1_ISR

.org 0x0100

reset:
 ;Loading stack pointer address
      LDI R16,0x70
 OUT SPL,R16
 LDI R16,0x00
 OUT SPH,R16

 ;Interface port B pin0 to be output
 ;so to view LED blinking
 
 LDI R16,0x02
 OUT DDRB,R16
 LDI R16,0x00
 OUT DDRD,R16

 ;Set MCUCR register to enable low level interrupt
 LDI R16, (1 << ISC11) | (1 << ISC10)
 OUT MCUCR,R16

 ;Set GICR register to enable interrupt 1
      LDI R16, (1 << INT1)
      OUT GICR, R16

 
      ; Set Timer1 for 1 second delay
      LDI R16, 0x00
      OUT TCCR1A, R16    ; Normal mode
      LDI R16, (1 << CS12) | (1 << CS10)  ; Prescaler = 1024
      OUT TCCR1B, R16
      LDI R16, 0x00
      OUT TCNT1H, R16
      LDI R16, 0x00
      OUT TCNT1L, R16
      LDI R16, 0xF9    ; 1 second delay value for TCNT1
      OUT OCR1AH, R16
      LDI R16, 0xF9
      OUT OCR1AL, R16

      ; Enable Timer1 Compare Match interrupt
      LDI R16, (1 << OCIE1A)
      OUT TIMSK, R16



 LDI R16,0x00
 OUT PORTB,R16

 SEI
ind_loop:rjmp ind_loop

int1_ISR:
      ; Disable global interrupts during ISR
      CLI

      ; LED Blink 10 times
      LDI R16, 10        ; Number of blinks
      MOV R0, R16

blink_loop:
      LDI R16, 0x02
      OUT PORTB, R16    ; Turn LED ON
      LDI R16, 0xFF
a1:  LDI R17, 0xFF
a2:  DEC R17
      BRNE a2
      DEC R16
      BRNE a1

      LDI R16, 0x00
      OUT PORTB, R16    ; Turn LED OFF
      LDI R16, 0xFF
b1:  LDI R17, 0xFF
b2:  DEC R17
      BRNE b2
      DEC R16
      BRNE b1

      DEC R0
      BRNE blink_loop



      ; Re-enable global interrupts
      SEI

      ; Clear the interrupt flag and return from ISR
      RETI
