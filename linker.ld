/* Linker script for QEMU RISC-V virt machine */

OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
    /* QEMU virt machine RAM starts at 0x80000000 */
    RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS
{
    /* Start address in RAM */
    . = 0x80000000;

    /* Code section */
    .text : {
        *(.text.init)
        *(.text*)
    } > RAM

    /* Read-only data */
    .rodata : {
        *(.rodata*)
    } > RAM

    /* Data section */
    .data : {
        *(.data*)
    } > RAM

    /* BSS section (zero-initialized data) */
    .bss : {
        __bss_start = .;
        *(.bss*)
        *(COMMON)
        __bss_end = .;
    } > RAM

    /* Stack grows downward from end of RAM */
    . = ALIGN(16);
    __stack_start = .;
    . = . + 0x10000;  /* 64KB stack */
    __stack_top = .;

    /* Discard debug sections */
    /DISCARD/ : {
        *(.comment)
    }
}
