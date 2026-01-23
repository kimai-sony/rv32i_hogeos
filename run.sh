#!/bin/bash
# Run script for HogeOS on QEMU

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ELF_FILE="build/hogeos.elf"

if [ ! -f "$ELF_FILE" ]; then
    echo -e "${YELLOW}Error: $ELF_FILE not found. Run ./build.sh first.${NC}"
    exit 1
fi

echo -e "${GREEN}Starting QEMU with HogeOS...${NC}"
echo "Press Ctrl-A, then X to exit QEMU"
echo ""

qemu-system-riscv32 -machine virt -nographic -bios none -kernel "$ELF_FILE"
