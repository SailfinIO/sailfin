# Sailfin Arrays and Data Structures

## Overview

Sailfin supports array literals and indexing operations for storing and accessing collections of data. Arrays provide stack-based storage for homogeneous data types.

## Array Literals

### Syntax
```sailfin
let arrayName: type[] = [element1, element2, element3];
```

### Examples

#### Numeric Arrays
```sailfin
let numbers: number[] = [1, 2, 3, 4, 5];
let fibonacci: number[] = [1, 1, 2, 3, 5, 8, 13];
let empty: number[] = [];
```

#### String Arrays (Future)
```sailfin
// Planned support
let words: string[] = ["hello", "world", "sailfin"];
```

## Array Indexing

### Syntax
```sailfin
let element: type = arrayName[index];
```

### Examples
```sailfin
let numbers: number[] = [10, 20, 30, 40, 50];

let first: number = numbers[0];   // 10
let third: number = numbers[2];   // 30
let last: number = numbers[4];    // 50
```

### Zero-Based Indexing
- Arrays use zero-based indexing
- Valid indices range from `0` to `length - 1`
- Index `0` refers to the first element
- Index `length - 1` refers to the last element

## Array Operations in Functions

### Passing Arrays as Parameters
```sailfin
fn processArray(arr: number[], size: number) -> number {
    let sum: number = 0;
    mut i: number = 0;
    
    while (i < size) {
        sum = sum + arr[i];
        i = i + 1;
    }
    
    return sum;
}

fn main() -> void {
    let data: number[] = [1, 2, 3, 4, 5];
    let total: number = processArray(data, 5);
    print("Sum: " + total.toString());
}
```

### Array Manipulation
```sailfin
fn findMax(arr: number[], size: number) -> number {
    if (size == 0) {
        return 0;
    }
    
    let max: number = arr[0];
    mut i: number = 1;
    
    while (i < size) {
        if (arr[i] > max) {
            max = arr[i];
        }
        i = i + 1;
    }
    
    return max;
}
```

### Array Searching
```sailfin
fn search(arr: number[], size: number, target: number) -> number {
    mut i: number = 0;
    
    while (i < size) {
        if (arr[i] == target) {
            return i;  // Found at index i
        }
        i = i + 1;
    }
    
    return -1;  // Not found
}
```

## Memory Model

### Stack-Based Storage
Arrays in Sailfin are currently stored on the stack:
- Each element occupies 4 bytes (32-bit integers)
- Elements are stored contiguously in memory
- Array base address points to the first element

### Memory Layout
```
Array: [10, 20, 30]

Stack Layout:
[x29 - 12] = 10    (first element)
[x29 - 8]  = 20    (second element)  
[x29 - 4]  = 30    (third element)
[x29]      = base pointer
```

## Generated Assembly

### Array Literal
Input Sailfin:
```sailfin
let arr: number[] = [10, 20, 30];
```

Generated ARM64:
```assembly
    // Allocate stack space for 3 elements (12 bytes)
    sub sp, sp, #12
    
    // Store elements
    mov w8, #10
    str w8, [x29, #-12]    // arr[0] = 10
    mov w8, #20  
    str w8, [x29, #-8]     // arr[1] = 20
    mov w8, #30
    str w8, [x29, #-4]     // arr[2] = 30
    
    // Store array base address
    add x8, x29, #-12      // x8 = &arr[0]
```

### Array Indexing
Input Sailfin:
```sailfin
let value: number = arr[2];
```

Generated ARM64:
```assembly
    // Load array base address
    add x9, x29, #-12      // x9 = &arr[0]
    
    // Calculate index offset
    mov w8, #2             // index = 2
    lsl x8, x8, #2         // multiply by 4 (element size)
    add x8, x9, x8         // x8 = &arr[2]
    
    // Load element
    ldr w8, [x8]           // value = arr[2]
```

## Implementation Details

### AST Nodes
```sailfin
// Array literal: [1, 2, 3]
struct ArrayExpr implements Expression {
    elements: Expression[];
    
    fn getExpressionKind(self) -> string {
        return "ArrayExpr";
    }
}

// Array indexing: arr[index]
struct IndexExpr implements Expression {
    array: Expression;
    index: Expression;
    
    fn getExpressionKind(self) -> string {
        return "IndexExpr";
    }
}
```

### Parser Implementation
1. **Array Literals**: Recognizes `[expr, expr, ...]` syntax
2. **Array Indexing**: Handles postfix `[expr]` operations  
3. **Type Annotations**: Supports `type[]` array type syntax
4. **Chaining**: Allows complex expressions like `arr[i][j]`

### Code Generation
1. **Stack Allocation**: Reserves contiguous stack space
2. **Element Storage**: Stores each element at calculated offset
3. **Address Calculation**: Computes element addresses for indexing
4. **Bounds Checking**: Currently minimal (future enhancement)

## Current Limitations

### Fixed Size
- Array size is determined at compile time
- No dynamic resizing capabilities
- Stack allocation limits array size

### Type Homogeneity  
- All elements must be the same type
- No mixed-type arrays currently supported

### No Bounds Checking
- No runtime bounds validation
- Out-of-bounds access may cause crashes
- Planned safety enhancement

## Future Enhancements

### Dynamic Arrays
```sailfin
// Planned heap-allocated arrays
let dynamic: number[] = make(10);  // Array of size 10
dynamic.append(42);                // Dynamic growth
```

### Array Methods
```sailfin
// Planned built-in array operations
let length: number = arr.length();
let contains: bool = arr.contains(value);
arr.sort();                        // In-place sorting
```

### Multi-dimensional Arrays
```sailfin
// Planned 2D array support
let matrix: number[][] = [[1, 2], [3, 4]];
let element: number = matrix[0][1];  // 2
```

### Array Slicing
```sailfin
// Planned slice operations
let subset: number[] = arr[1:4];     // Elements 1 through 3
let tail: number[] = arr[2:];        // Elements from index 2 to end
```

## Performance Characteristics

### Access Time
- **O(1)** element access by index
- Direct memory address calculation
- No search or traversal required

### Memory Efficiency
- Minimal overhead (no metadata stored)
- Contiguous memory layout
- Cache-friendly access patterns

### Compilation
- Compile-time size determination
- Static memory allocation
- Efficient assembly generation

## Best Practices

### Size Management
```sailfin
// Use constants for array sizes
let ARRAY_SIZE: number = 10;
let buffer: number[] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

// Pass size explicitly to functions
fn process(arr: number[], size: number) -> void {
    // Always check bounds manually
    mut i: number = 0;
    while (i < size) {
        // Process arr[i]
        i = i + 1;
    }
}
```

### Initialization Patterns
```sailfin
// Initialize with known values
let data: number[] = [1, 2, 3, 4, 5];

// Initialize empty (all zeros)
let zeros: number[] = [0, 0, 0, 0, 0];
```

### Safe Indexing
```sailfin
fn safeGet(arr: number[], index: number, size: number) -> number {
    if (index >= 0 && index < size) {
        return arr[index];
    } else {
        return 0;  // Default value for out-of-bounds
    }
}
```

## Testing

Current test coverage includes:
- ✅ Array literal creation
- ✅ Element access by index
- ✅ Empty array handling
- ✅ Arrays in function parameters
- ✅ Assembly generation verification

The array implementation provides a solid foundation for data structure operations and enables more complex algorithms in Sailfin programs.
