# Sailfin Loops and Iteration

## Overview

Sailfin supports loop constructs for repetitive execution of code blocks. The current implementation focuses on `while` loops with planned support for `for` loops.

## While Loops

### Syntax
```sailfin
while (condition) {
    // body statements
}
```

### Example: Basic Counter
```sailfin
fn countToFive() -> void {
    mut i: number = 0;
    
    while (i < 5) {
        print("Count: " + i.toString());
        i = i + 1;
    }
}
```

### Example: Factorial Calculation
```sailfin
fn factorial(n: number) -> number {
    mut result: number = 1;
    mut i: number = 1;
    
    while (i <= n) {
        result = result * i;
        i = i + 1;
    }
    
    return result;
}
```

### Example: Sum Calculation
```sailfin
fn sumNumbers(max: number) -> number {
    mut sum: number = 0;
    mut current: number = 1;
    
    while (current <= max) {
        sum = sum + current;
        current = current + 1;
    }
    
    return sum;
}
```

## Loop Semantics

### Condition Evaluation
- The condition is evaluated before each iteration
- If the condition is false (0), the loop terminates
- If the condition is true (non-zero), the loop body executes

### Variable Scope
- Variables declared inside the loop body are scoped to that iteration
- Variables declared outside the loop remain accessible inside the loop
- Mutable variables can be modified within the loop body

### Example: Variable Scoping
```sailfin
fn demonstrateScoping() -> void {
    let limit: number = 10;  // Accessible inside loop
    mut counter: number = 0; // Modifiable inside loop
    
    while (counter < limit) {
        let doubled: number = counter * 2;  // Local to this iteration
        print("Counter: " + counter.toString() + ", Doubled: " + doubled.toString());
        counter = counter + 1;
    }
    
    // 'doubled' is not accessible here
    print("Final counter: " + counter.toString());
}
```

## Generated Assembly

The compiler generates efficient ARM64 assembly for while loops using labels and conditional branches:

### Input Sailfin Code:
```sailfin
mut i: number = 0;
while (i < 5) {
    i = i + 1;
}
```

### Generated ARM64 Assembly:
```assembly
    // Initialize i = 0
    mov w8, #0
    str w8, [x29, #-4]          // Store i at stack offset -4

.L1:                            // Loop start label
    // Load condition: i < 5
    ldr w8, [x29, #-4]         // Load i
    cmp w8, #5                  // Compare with 5
    b.ge .L2                    // Branch to end if i >= 5
    
    // Loop body: i = i + 1
    ldr w8, [x29, #-4]         // Load i
    add w8, w8, #1             // Add 1
    str w8, [x29, #-4]         // Store back to i
    
    b .L1                       // Jump back to loop start
    
.L2:                            // Loop end label
```

## Implementation Details

### AST Representation
```sailfin
struct WhileStatement implements Statement {
    condition: Expression;
    body: Statement[];
    
    fn getStatementKind(self) -> string {
        return "WhileStatement";
    }
}
```

### Parser Support
The parser recognizes the `while` keyword and constructs a `WhileStatement` AST node:

1. Consume `while` keyword
2. Parse condition expression in parentheses
3. Parse body statements in braces
4. Create WhileStatement with condition and body

### Code Generation
The code generator creates:
1. **Loop label**: Target for backward jumps
2. **Condition evaluation**: Expression result in register
3. **Conditional branch**: Exit if condition is false
4. **Body generation**: All statements in loop body
5. **Backward jump**: Return to loop start
6. **End label**: Target for loop exit

## Performance Considerations

### Efficient Conditionals
- Condition expressions are optimized for ARM64 comparison instructions
- Simple numeric comparisons compile to single `cmp` instructions
- Complex conditions may require multiple instructions

### Register Usage
- Loop variables are stored on the stack for persistence across iterations
- Temporary values use registers when possible
- The compiler manages register allocation for loop-local computations

### Stack Management
- Loop-local variables are allocated on the stack
- Stack space is managed efficiently across iterations
- No memory leaks or stack overflow from loop execution

## Future Enhancements

### For Loops
Planned syntax:
```sailfin
for (init; condition; update) {
    // body
}

// Example:
for (let i = 0; i < 10; i = i + 1) {
    print("Iteration: " + i.toString());
}
```

### Break and Continue
Planned control flow statements:
```sailfin
while (true) {
    if (shouldExit) {
        break;    // Exit loop
    }
    if (shouldSkip) {
        continue; // Skip to next iteration
    }
    // Normal processing
}
```

### Nested Loops
Full support for nested loop constructs:
```sailfin
mut i: number = 0;
while (i < 3) {
    mut j: number = 0;
    while (j < 3) {
        print("(" + i.toString() + ", " + j.toString() + ")");
        j = j + 1;
    }
    i = i + 1;
}
```

## Testing

Current test cases cover:
- ✅ Simple counting loops
- ✅ Loops with mutable variables
- ✅ Condition evaluation
- ✅ Variable scoping
- ✅ Assembly generation

The loop implementation provides a solid foundation for iterative algorithms and is ready for use in real Sailfin programs.
