#include "uart.h"

/* UART base address for QEMU virt machine (NS16550A compatible) */
#define UART_BASE 0x10000000

/* UART register offsets */
#define UART_RBR_OFFSET 0  /* Receive Buffer Register (read) */
#define UART_THR_OFFSET 0  /* Transmit Holding Register (write) */
#define UART_IER_OFFSET 1  /* Interrupt Enable Register */
#define UART_FCR_OFFSET 2  /* FIFO Control Register */
#define UART_LCR_OFFSET 3  /* Line Control Register */
#define UART_MCR_OFFSET 4  /* Modem Control Register */
#define UART_LSR_OFFSET 5  /* Line Status Register */
#define UART_MSR_OFFSET 6  /* Modem Status Register */
#define UART_SCR_OFFSET 7  /* Scratch Register */

/* Line Status Register bits */
#define UART_LSR_THRE (1 << 5)  /* Transmit Holding Register Empty */

/* Helper macros for UART register access */
#define UART_REG(offset) (*(volatile uint8_t *)(UART_BASE + (offset)))

/* Initialize UART */
void uart_init(void) {
    /* For QEMU virt machine, UART is already initialized by firmware */
    /* We can optionally configure it here if needed */
    
    /* Set 8N1 (8 data bits, no parity, 1 stop bit) */
    UART_REG(UART_LCR_OFFSET) = 0x03;
    
    /* Enable FIFO */
    UART_REG(UART_FCR_OFFSET) = 0x01;
}

/* Send a single character via UART */
void uart_putc(char c) {
    /* Wait until transmit holding register is empty */
    while ((UART_REG(UART_LSR_OFFSET) & UART_LSR_THRE) == 0) {
        /* Busy wait */
    }
    
    /* Write character to transmit holding register */
    UART_REG(UART_THR_OFFSET) = c;
}

/* Send a null-terminated string via UART */
void uart_puts(const char *s) {
    while (*s) {
        /* Convert LF to CR+LF for proper line endings */
        if (*s == '\n') {
            uart_putc('\r');
        }
        uart_putc(*s++);
    }
}
