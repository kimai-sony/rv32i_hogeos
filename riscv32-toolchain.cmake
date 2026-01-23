# RISC-V RV32I Toolchain File for LLVM/Clang

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv32)

# Specify the cross compiler
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_ASM_COMPILER clang)

# Compiler flags for RV32I architecture
set(ARCH_FLAGS "-target riscv32-unknown-elf -march=rv32i -mabi=ilp32 -mno-relax")

# Common flags
set(CMAKE_C_FLAGS_INIT "${ARCH_FLAGS} -nostdlib -ffreestanding -fno-builtin")
set(CMAKE_CXX_FLAGS_INIT "${ARCH_FLAGS} -nostdlib -ffreestanding -fno-builtin")
set(CMAKE_ASM_FLAGS_INIT "${ARCH_FLAGS}")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS_INIT "${ARCH_FLAGS} -nostdlib -static")

# Search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# Search for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
