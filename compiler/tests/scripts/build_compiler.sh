#!/bin/bash
# build.sh - Assemble and link generated ARM64 assembly into executable

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <assembly_file.s>"
    exit 1
fi

ASM_FILE="$1"
OBJ_FILE="${ASM_FILE%.s}.o"
EXE_FILE="${ASM_FILE%.s}"

echo "Assembling $ASM_FILE..."
clang -c "$ASM_FILE" -o "$OBJ_FILE"

if [ $? -ne 0 ]; then
    echo "Assembly failed!"
    exit 1
fi

echo "Linking $OBJ_FILE..."
clang -o "$EXE_FILE" "$OBJ_FILE"

if [ $? -ne 0 ]; then
    echo "Linking failed!"
    exit 1
fi

echo "Successfully built executable: $EXE_FILE"
echo "Run with: ./$EXE_FILE"
