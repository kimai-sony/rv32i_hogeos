#include "uart.h"

int main(void) {
    /* Initialize UART */
    uart_init();
    
    /* Print "Hello world" message */
    uart_puts("Hello world\n");
    
    /* Loop forever */
    while (1) {
        /* Do nothing */
    }
    
    return 0;
}
