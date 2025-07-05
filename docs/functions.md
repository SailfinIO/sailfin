# Sailfin Functions

## Overview

Sailfin supports function declarations using the `fn` keyword, with typed parameters and return values. Functions are first-class citizens and support both named and anonymous functions.

## Function Declaration Syntax

### Basic Function Declaration
```sailfin
fn function_name(param1: Type1, param2: Type2) -> ReturnType {
    // Function body
    return value;
}
```

### Void Functions
```sailfin
fn greet() -> void {
    // Function with no return value
    let message: string = "Hello!";
}
```

### Functions with Parameters
```sailfin
fn add(x: number, y: number) -> number {
    return x + y;
}

fn max(a: number, b: number) -> number {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}
```

## Function Calls

### Simple Function Calls
```sailfin
fn main() -> void {
    let result: number = add(10, 20);
    let maximum: number = max(result, 25);
}
```

### Nested Function Calls
```sailfin
let final: number = add(max(10, 15), multiply(2, 3));
```

## Language Features

### Parameter Passing
- Parameters are passed by value
- Parameters are immutable by default within the function
- ARM64 calling convention: first 8 parameters in registers (x0-x7)

### Return Values
- Functions can return any type or `void`
- `return` statement exits function immediately
- Functions without explicit return automatically return 0 for non-void types

### Local Variables
- Functions have their own variable scope
- Local variables are allocated on the stack
- Variables are deallocated when function exits

### Mutability
```sailfin
fn increment(value: number) -> number {
    mut result: number = value;  // Local mutable variable
    result = result + 1;
    return result;
}
```

## Implementation Details

### AST Representation
```sailfin
struct FunctionDeclaration {
    name: string;
    parameters: Parameter[];
    returnType: string;
    body: Statement[];
}

struct Parameter {
    name: string;
    paramType: string;
}

struct CallExpr {
    callee: Expression;
    arguments: Expression[];
}
```

### Code Generation
```assembly
# Function declaration: fn add(x: number, y: number) -> number
.globl _add
_add:
    sub sp, sp, #32        # Allocate stack frame
    stp x29, x30, [sp, #16] # Save frame pointer and return address
    add x29, sp, #16       # Set up frame pointer
    
    # Function body here...
    
    ldp x29, x30, [sp, #16] # Restore frame pointer and return address
    add sp, sp, #32         # Deallocate stack frame
    ret                     # Return to caller

# Function call: add(10, 20)
mov x0, #10               # First argument
mov x1, #20               # Second argument
bl _add                   # Branch and link to function
mov w8, w0                # Move result to working register
```

### Call Stack Management
- ARM64 AAPCS (Procedure Call Standard)
- Frame pointer (x29) and return address (x30) saved/restored
- Local variables allocated after frame setup
- Proper stack unwinding for nested calls

## Examples

### Factorial Function
```sailfin
fn factorial(n: number) -> number {
    if (n <= 1) {
        return 1;
    } else {
        return n * factorial(n - 1);  // Recursive call
    }
}
```

### Utility Functions
```sailfin
fn abs(x: number) -> number {
    if (x < 0) {
        return -x;
    } else {
        return x;
    }
}

fn min(a: number, b: number) -> number {
    if (a < b) {
        return a;
    } else {
        return b;
    }
}
```

### Main Function Pattern
```sailfin
fn helper() -> number {
    return 42;
}

fn main() -> void {
    let value: number = helper();
    let doubled: number = value * 2;
}
```

## Function Features Status

- ✅ **Function Declarations**: `fn name(params) -> type { ... }`
- ✅ **Parameters**: Typed parameter lists
- ✅ **Return Types**: Including `void` functions
- ✅ **Function Calls**: With argument passing
- ✅ **Local Variables**: Function-scoped variables
- ✅ **Return Statements**: Early function exit
- ✅ **Code Generation**: ARM64 assembly with proper calling convention
- 🚧 **Anonymous Functions**: Planned (lambda expressions)
- 🚧 **Higher-Order Functions**: Planned (functions as values)
- 🚧 **Closures**: Planned (capturing outer scope)

## Comparison with Other Languages

| Language | Declaration | Call | Return |
|----------|-------------|------|--------|
| Sailfin  | `fn add(x: number) -> number` | `add(5)` | `return x;` |
| Rust     | `fn add(x: i32) -> i32` | `add(5)` | `return x;` |
| Go       | `func add(x int) int` | `add(5)` | `return x` |
| TypeScript | `function add(x: number): number` | `add(5)` | `return x;` |

## Future Enhancements

- [ ] Anonymous functions and lambdas
- [ ] Function types and higher-order functions
- [ ] Closures and captured variables
- [ ] Generic functions
- [ ] Method syntax for structs
- [ ] Function overloading
