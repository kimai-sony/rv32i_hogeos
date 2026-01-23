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

# Find LLVM tools
find_program(LLVM_OBJCOPY llvm-objcopy
    PATHS /usr/lib/llvm-18/bin /usr/lib/llvm-17/bin /usr/lib/llvm-16/bin
    DOC "Path to llvm-objcopy"
)
find_program(LLVM_SIZE llvm-size
    PATHS /usr/lib/llvm-18/bin /usr/lib/llvm-17/bin /usr/lib/llvm-16/bin
    DOC "Path to llvm-size"
)

if(NOT LLVM_OBJCOPY)
    message(WARNING "llvm-objcopy not found, binary file will not be generated")
endif()

if(NOT LLVM_SIZE)
    message(WARNING "llvm-size not found, size information will not be displayed")
endif()

# Custom target to generate binary file
if(LLVM_OBJCOPY)
    add_custom_command(TARGET hogeos.elf POST_BUILD
        COMMAND ${LLVM_OBJCOPY} -O binary hogeos.elf hogeos.bin
        COMMENT "Generating binary file hogeos.bin"
    )
endif()

# Custom target to show size information
if(LLVM_SIZE)
    add_custom_command(TARGET hogeos.elf POST_BUILD
        COMMAND ${LLVM_SIZE} hogeos.elf
        COMMENT "Size information:"
    )
endif()

# Print build information
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "C Flags: ${CMAKE_C_FLAGS}")
