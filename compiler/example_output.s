# Example output from Sailfin self-hosting compiler
# Input: let x: number = 42; let y: number = x + 8;

.text
.globl _start
_start:
    push %rbp
    mov %rsp, %rbp
    
    # Variable declaration: let x: number = 42;
    mov $42, %rax          # Load immediate value 42
    mov %rax, -8(%rbp)     # Store x at offset -8
    
    # Variable declaration: let y: number = x + 8;
    mov -8(%rbp), %rax     # Load x into %rax
    push %rax              # Save x on stack
    mov $8, %rax           # Load immediate value 8
    mov %rax, %rcx         # Move 8 to %rcx
    pop %rax               # Restore x to %rax
    add %rcx, %rax         # Add: x + 8
    mov %rax, -16(%rbp)    # Store y at offset -16
    
.function_end:
    mov %rbp, %rsp
    pop %rbp
    mov $60, %rax          # sys_exit system call
    mov $0, %rdi           # exit status 0
    syscall
