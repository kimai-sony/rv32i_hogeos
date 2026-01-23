cmake_minimum_required(VERSION 3.20)

# Set toolchain file before project()
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/riscv32-toolchain.cmake)

project(HogeOS C ASM)

# Project settings
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Include directories
include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# Source files
set(SOURCES
    src/main.c
    src/uart.c
    boot/crt0.S
)

# Create executable
add_executable(hogeos.elf ${SOURCES})

# Set linker script
set_target_properties(hogeos.elf PROPERTIES
    LINK_FLAGS "-T ${CMAKE_CURRENT_SOURCE_DIR}/linker.ld"
)

# Custom target to generate binary file
add_custom_command(TARGET hogeos.elf POST_BUILD
    COMMAND /usr/lib/llvm-18/bin/llvm-objcopy -O binary hogeos.elf hogeos.bin
    COMMENT "Generating binary file hogeos.bin"
)

# Custom target to show size information
add_custom_command(TARGET hogeos.elf POST_BUILD
    COMMAND /usr/lib/llvm-18/bin/llvm-size hogeos.elf
    COMMENT "Size information:"
)

# Print build information
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "C Flags: ${CMAKE_C_FLAGS}")
