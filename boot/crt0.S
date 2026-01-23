/* Startup code for RISC-V RV32I */

.section .text.init
.global _start

_start:
    /* Disable interrupts */
    li t0, 0
    csrw mie, t0

    /* Initialize stack pointer */
    la sp, __stack_top

    /* Clear BSS section */
    la t0, __bss_start
    la t1, __bss_end
clear_bss:
    beq t0, t1, bss_done
    sw zero, 0(t0)
    addi t0, t0, 4
    j clear_bss

bss_done:
    /* Call main function */
    call main

    /* Halt if main returns */
halt:
    wfi
    j halt
