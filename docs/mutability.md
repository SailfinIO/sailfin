# Sailfin Mutability System

## Overview

Sailfin supports both immutable and mutable variables, providing memory safety and clear intent about data modification. This design is inspired by Rust's mutability model.

## Variable Declaration Syntax

### Immutable Variables (`let`)
```sailfin
let x: number = 42;        // Cannot be changed
let name: string = "test"; // Cannot be changed
```

### Mutable Variables (`mut`)
```sailfin
mut counter: number = 0;   // Can be changed
mut active: bool = true;   // Can be changed
```

## Assignment Syntax

### Initial Assignment (Declaration)
```sailfin
let x: number = 42;     // Immutable
mut y: number = 10;     // Mutable
```

### Reassignment (Mutation)
```sailfin
y = 20;                 // ✅ Valid - y is mutable
x = 50;                 // ❌ Error - x is immutable
```

## Language Features

### Compile-Time Mutability Checking
The compiler enforces mutability rules at compile time:

```sailfin
let constant: number = 100;
mut variable: number = 0;

variable = 42;    // ✅ OK - variable is mutable
constant = 200;   // ❌ Compile error - constant is immutable
```

### Scoped Mutability
Variables maintain their mutability within their scope:

```sailfin
mut x: number = 10;
if (x > 5) {
    x = x * 2;        // ✅ OK - x is still mutable in this scope
    let y: number = x;
    // y = 100;       // ❌ Error - y is immutable
}
```

## Implementation Details

### AST Representation
```sailfin
struct VariableDeclaration {
    name: string;
    var_type: string;
    value: Expression;
    isMutable: bool;      // New field for mutability
}

struct AssignmentStatement {
    target: string;       // Variable being assigned to
    value: Expression;    // New value
}
```

### Parser Support
- Recognizes both `let` and `mut` keywords
- Creates appropriate AST nodes with mutability flags
- Distinguishes between declarations and assignments

### Code Generation
- Tracks variable mutability in compilation context
- Enforces mutability rules during code generation
- Generates appropriate comments in assembly output

### Generated Assembly
```assembly
mov w8, #42
str w8, [x29, #-4]
// Immutable variable: x

mov w8, #10  
str w8, [x29, #-8]
// Mutable variable: y

ldr w8, [x29, #-8]
add w8, w8, #5
str w8, [x29, #-8]  
// Assignment to mutable variable: y
```

## Benefits

1. **Memory Safety**: Prevents accidental modification of data
2. **Clear Intent**: Explicitly shows which data can change
3. **Optimization**: Compiler can optimize immutable data
4. **Error Prevention**: Catches assignment bugs at compile time
5. **Modern Design**: Follows best practices from Rust, Swift, etc.

## Usage Patterns

### Constants and Configuration
```sailfin
let PI: number = 3.14159;
let MAX_USERS: number = 1000;
let CONFIG_FILE: string = "config.toml";
```

### Counters and State
```sailfin
mut count: number = 0;
mut isActive: bool = true;
mut currentIndex: number = 0;
```

### Calculations with Intermediate Results
```sailfin
let base: number = 100;
mut result: number = base;
result = result * 2;
result = result + 50;
```

## Comparison with Other Languages

| Language | Immutable | Mutable | Assignment |
|----------|-----------|---------|------------|
| Sailfin  | `let x = 5` | `mut x = 5` | `x = 10` |
| Rust     | `let x = 5` | `let mut x = 5` | `x = 10` |
| Swift    | `let x = 5` | `var x = 5` | `x = 10` |
| JavaScript | `const x = 5` | `let x = 5` | `x = 10` |

## Future Enhancements

- [ ] Mutable references and borrowing
- [ ] Interior mutability patterns
- [ ] Const evaluation for immutable expressions
- [ ] Mutability analysis and optimization
