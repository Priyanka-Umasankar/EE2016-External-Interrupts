# AVR External Interrupt Handling

This repository contains a project for the Atmega8 microcontroller, demonstrating LED blinking with a 1-second timer delay. The main objective is setting up interrupt handling and a timer to control the blink rate.

## Features

- **LED Blinking**: The LED connected to Port B, Pin 0 will blink 10 times when interrupted.
- **Interrupt Handling**: External interrupt INT1 is used to trigger the LED blink.

## Code Breakdown

### 1. Reset Handler

- The stack pointer is set up at the beginning.
- Port B Pin 0 is set as an output for the LED, while Port D is made as input.
- The MCUCR register is configured to enable the low-level interrupt for INT1, and the GICR register is set to enable interrupt 1.
- The program enters a loop (`ind_loop`) after initialization, waiting for the interrupt to occur.
- When INT1 occurs, the ISR is triggered, and the LED blinks 10 times.
- Each blink consists of turning the LED ON and OFF with a delay, controlled by simple loop-based software delays.
- The global interrupt flag is cleared at the beginning of the ISR and re-enabled at the end.
- The interrupt flag is cleared to acknowledge the interrupt, and the ISR ends with a `RETI` instruction.

## How to Use

1. **Hardware Setup**:  
   - Connect an LED to Port B, Pin 0.
   - Use an external interrupt source for INT1 (here, a push button).
   
2. **Running the Program**:  
   - Upon pressing the interrupt source (here, a push button connected to INT1), the LED will blink 10 times with a 1-second delay between blinks.

