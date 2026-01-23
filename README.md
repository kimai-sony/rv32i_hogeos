# rv32i_hogeos
Simple RTOS implementation (HogeOS) for RISC-V RV32I architecture

## Overview
This is a trial project to port RTOS for RISC-V RV32I architecture. Currently implements a "Hello world" program that outputs via UART on QEMU virt machine.

## Prerequisites
- LLVM/Clang compiler (tested with version 18.1.3)
- CMake (version 3.20 or later)
- QEMU with RISC-V support (`qemu-system-riscv32`)
- zsh (for DevContainer environment)

## Building
```bash
# Create build directory
mkdir build
cd build

# Configure with CMake
cmake ..

# Build the project
make
```

Or use the convenience script:
```bash
./build.sh
```

This will generate:
- `hogeos.elf` - ELF executable
- `hogeos.bin` - Raw binary

## Running
To run on QEMU virt machine:
```bash
qemu-system-riscv32 -machine virt -nographic -bios none -kernel build/hogeos.elf
```

Or use the convenience script:
```bash
./run.sh
```

To exit QEMU, press `Ctrl-A` then `X`.

## Project Structure
- `src/` - Source code files
  - `main.c` - Main application
  - `uart.c` - UART driver implementation
- `boot/` - Boot and startup code
  - `crt0.S` - Assembly startup code
- `include/` - Header files
  - `uart.h` - UART driver interface
- `linker.ld` - Linker script for QEMU virt machine
- `riscv32-toolchain.cmake` - CMake toolchain file for RISC-V RV32I
- `CMakeLists.txt` - CMake build configuration
