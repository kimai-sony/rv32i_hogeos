#!/bin/bash
# Build script for HogeOS

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Building HogeOS...${NC}"

# Create build directory if it doesn't exist
if [ ! -d "build" ]; then
    mkdir build
fi

# Configure and build
cd build
cmake .. && make

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Build successful!${NC}"
    echo "To run: qemu-system-riscv32 -machine virt -nographic -bios none -kernel build/hogeos.elf"
    echo "To exit QEMU: Ctrl-A, then X"
else
    echo -e "${RED}Build failed!${NC}"
    exit 1
fi
