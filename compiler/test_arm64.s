.section __TEXT,__text,regular,pure_instructions
.globl _main
.p2align 2

_main:
    sub sp, sp, #32
    stp x29, x30, [sp, #16]
    add x29, sp, #16
    
    // Simple computation: let x = 42; let y = x + 8;
    mov w8, #42           // x = 42
    str w8, [x29, #-4]    // Store x
    ldr w8, [x29, #-4]    // Load x
    add w8, w8, #8        // x + 8
    str w8, [x29, #-8]    // Store y
    
    // Return 0
    mov w0, #0
    ldp x29, x30, [sp, #16]
    add sp, sp, #32
    ret
