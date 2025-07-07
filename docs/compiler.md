# Sailfin Self-Hosting Compiler

## Overview

This directory contains the **self-hosting Sailfin compiler** - a Sailfin compiler written in Sailfin that compiles Sailfin source code directly to native machine code (ARM64 assembly for Apple Silicon).

## Architecture

### Key Components

1. **lexer.sfn** - Lexical analyzer that tokenizes Sailfin source code
2. **parser.sfn** - Parser that builds an Abstract Syntax Tree (AST) from tokens  
3. **ast.sfn** - AST node definitions for all Sailfin language constructs
4. **codegen.sfn** - Code generator that emits ARM64 assembly from the AST
5. **main.sfn** - Main entry point that orchestrates the compilation pipeline

### Compilation Pipeline

```
Sailfin Source Code
        ↓
    Lexer (lexer.sfn)
        ↓  
    Tokens
        ↓
    Parser (parser.sfn)
        ↓
    AST (ast.sfn)
        ↓
    Code Generator (codegen.sfn)
        ↓
    ARM64 Assembly
        ↓
    Assembler & Linker (clang)
        ↓
    Native Executable
```

## Machine Code Generation

The code generator (`codegen.sfn`) produces ARM64 assembly code that can be assembled and linked into native executables. Key features:

- **Target Architecture**: ARM64 (Apple Silicon)
- **Assembly Format**: Standard ARM64 assembly syntax compatible with clang
- **Variable Storage**: Stack-based allocation with frame pointer management
- **Expression Evaluation**: Register-based computation using ARM64 registers (w8, w9, etc.)
- **Function Convention**: Standard ARM64 calling convention with stack frame setup

### Generated Code Structure

```assembly
.section __TEXT,__text,regular,pure_instructions
.globl _main
.p2align 2

_main:
    sub sp, sp, #32           // Allocate stack frame
    stp x29, x30, [sp, #16]   // Save frame pointer and return address
    add x29, sp, #16          // Set up frame pointer
    
    // Variable declarations and computations...
    
    mov w0, #0                // Return value
    ldp x29, x30, [sp, #16]   // Restore frame pointer and return address
    add sp, sp, #32           // Deallocate stack frame
    ret                       // Return
```

## Build Process

The `build.sh` script provides a simple way to assemble and link generated assembly:

```bash
./build.sh output.s    # Assembles and links output.s to create executable
```

## Self-Hosting Status

✅ **Complete**: Basic self-hosting infrastructure
- Lexer, parser, AST, and code generator implemented in Sailfin
- Generates native ARM64 machine code
- Can compile simple Sailfin programs (variable declarations, arithmetic)

🚧 **In Progress**: Extended language support
- More expression types (function calls, conditionals, loops)
- Advanced features (structs, interfaces, generics)
- Standard library and runtime

## Example

Input Sailfin code:
```sailfin
let x: number = 42;
let y: number = x + 8;
```

Generated ARM64 assembly:
```assembly
.section __TEXT,__text,regular,pure_instructions
.globl _main
.p2align 2
_main:
    sub sp, sp, #32
    stp x29, x30, [sp, #16]
    add x29, sp, #16
    mov w8, #42
    str w8, [x29, #-4]
    ldr w8, [x29, #-4]
    add w8, w8, #8
    str w8, [x29, #-8]
    mov w0, #0
    ldp x29, x30, [sp, #16]
    add sp, sp, #32
    ret
```

## Key Achievements

1. **True Self-Hosting**: The compiler is written in Sailfin and compiles to native machine code
2. **No Intermediate Languages**: Direct compilation to assembly, no Python/JavaScript/etc. output
3. **Native Performance**: Generated code runs as fast as any other compiled language
4. **Platform Native**: Uses standard ARM64 conventions and can link with system libraries

## Future Enhancements

- File I/O for reading source files and writing assembly output
- More sophisticated register allocation and optimization
- Support for the full Sailfin language specification
- Cross-compilation support for other architectures (x86-64, RISC-V)
- Integration with LLVM for advanced optimizations
