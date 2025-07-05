# Simple test to see what works on macOS
.section __TEXT,__text,regular,pure_instructions
.globl _main

_main:
    # Exit with status 0
    mov $0x2000001, %rax  # sys_exit on macOS
    mov $0, %rdi          # exit status
    syscall
    ret
