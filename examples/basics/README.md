# Sailfin Basic Language Examples

This directory contains comprehensive examples of Sailfin's basic language features. All examples in this directory compile and run successfully with the bootstrap compiler.

## 📖 Language Overview

**Sailfin** is a modern, statically-typed programming language with a focus on:

- **Type Safety**: Explicit type annotations and compile-time type checking
- **Memory Safety**: No null pointers, ownership semantics
- **Performance**: Compiled to efficient target languages (currently Python via bootstrap)
- **Expressiveness**: Pattern matching, algebraic data types, interfaces

## 🔑 Reserved Keywords

The Sailfin language uses the following reserved keywords:

### Core Language Keywords

- `fn` - Function declaration
- `lambda` - Anonymous function expression
- `let` - Immutable variable declaration
- `mut` - Mutable variable declaration
- `return` - Return statement

### Type and Structure Keywords

- `struct` - Structure definition
- `enum` - Enumeration definition
- `interface` - Interface definition
- `implements` - Interface implementation
- `new` - Object instantiation

### Control Flow Keywords

- `if`, `else` - Conditional statements
- `match` - Pattern matching
- `while` - While loops
- `for`, `in` - For loops (syntax defined, not fully implemented)

### Error Handling Keywords

- `try`, `catch`, `finally` - Exception handling
- `throw` - Throw exception

### Async/Concurrency Keywords

- `async` - Asynchronous function
- `await` - Await async operation

### Module System Keywords

- `import`, `from` - Module imports

### Testing Keywords

- `test` - Test block declaration
- `assert` - Assertion statement

### Utility Keywords

- `print` - Built-in print namespace
- `info` - Print info method
- `is` - Type checking/comparison

## 🔣 Operators and Symbols

### Arithmetic Operators

- `+` - Addition
- `-` - Subtraction
- `*` - Multiplication
- `/` - Division

### Assignment Operators

- `=` - Assignment
- `+=` - Plus assignment
- `-=` - Minus assignment
- `*=` - Multiply assignment
- `/=` - Divide assignment

### Comparison Operators

- `==` - Equality
- `!=` - Inequality
- `<` - Less than
- `>` - Greater than
- `<=` - Less than or equal
- `>=` - Greater than or equal

### Logical Operators

- `&&` - Logical AND
- `||` - Logical OR
- `!` - Logical NOT

### Special Operators

- `->` - Function return type annotation
- `=>` - Fat arrow (pattern matching, lambdas)
- `|` - Union type operator / pipe
- `&` - Intersection operator / ampersand
- `?` - Optional/nullable type operator
- `_` - Wildcard pattern

### Delimiters

- `()` - Parentheses (function calls, grouping)
- `{}` - Braces (blocks, struct literals)
- `[]` - Brackets (arrays, indexing)
- `;` - Semicolon (statement terminator)
- `,` - Comma (separator)
- `.` - Dot (member access)
- `:` - Colon (type annotations)
- `@` - At symbol (decorators/attributes)

## 📝 Basic Type System

### Primitive Types

- `number` - Numeric values (integers and floats)
- `string` - Text strings with interpolation support
- `bool` - Boolean values (`true`/`false`)
- `void` - No return value

### Collection Types

- `Type[]` - Arrays (e.g., `number[]`, `string[]`)

### Custom Types

- User-defined `struct` types
- User-defined `enum` types
- `interface` types for polymorphism

### Type Annotations

All variables require explicit type annotations:

```sailfin
let name: string = "Sailfin";
mut count: number = 42;
```

## ✅ Fully Working Examples

The following examples demonstrate **real, working language features**:

### Core Language Features

- **`hello-world.sfn`** - Basic program structure and print statements
- **`variables.sfn`** - Variable declarations with type annotations
- **`functions.sfn`** - Function definitions, parameters, and return types
- **`function-expression.sfn`** - Function expressions and closures

### Data Types and Structures

- **`arrays.sfn`** - Array declarations, initialization, and access (syntax: `number[]`, `string[]`)
- **`strings.sfn`** - String literals, interpolation, and operations
- **`booleans.sfn`** - Boolean literals (`true`/`false`) and conditional logic
- **`structs.sfn`** - Struct definitions and field access
- **`struct-composition.sfn`** - Composing structs with other structs
- **`nested-structures.sfn`** - Complex nested data structures

### Control Flow

- **`conditionals.sfn`** - If/else statements and boolean expressions
- **`loops.sfn`** - While loops and iteration patterns
- **`for-loops.sfn`** - Alternative iteration using while loops (for-loops not yet implemented)

### Advanced Features

- **`interfaces.sfn`** - Interface definitions and implementation
- **`basic-enum.sfn`** - Simple enum declarations
- **`tagged-enum.sfn`** - Enums with associated data
- **`error-handling.sfn`** - Error handling patterns
- **`try-catch-finally.sfn`** - Exception handling blocks
- **`tests.sfn`** - Unit testing examples
- **`scope.sfn`** - Variable scoping (global, function, block scope)
- **`method-chaining.sfn`** - Method chaining patterns

## ⚠️ Documented Limitations

The following examples document intended syntax for features not yet implemented:

- **`type-conversion.sfn`** - Type conversion functions (`parseInt`, `toString`, etc.)
- **`optionals.sfn`** - Generic `Option<T>` enum and pattern matching

## 🔍 Key Language Features Confirmed Working

### Type System

- ✅ Explicit type annotations (`let name: string = "value"`)
- ✅ Basic types: `number`, `string`, `bool`, `void`
- ✅ Array types: `number[]`, `string[]`
- ✅ Struct types and field access
- ✅ Interface definitions

### Control Flow

- ✅ If/else statements with boolean conditions
- ✅ While loops
- ✅ Block scoping in if statements
- ❌ For-loops (not implemented - use while loops)
- ❌ Pattern matching (documented in examples)

### Functions

- ✅ Function declarations with parameters and return types
- ✅ Function calls with arguments
- ✅ Global and local variable scope
- ✅ Function parameters properly scoped

### Data Structures

- ✅ Arrays with bracket notation (`arr[0]`)
- ✅ Structs with dot notation (`obj.field`)
- ✅ String interpolation (`"Hello {{name}}"`)

### Boolean Logic

- ✅ Boolean literals: `true`, `false` (parsed as identifiers, emitted as Python `True`/`False`)
- ✅ Boolean variables in conditionals
- ✅ Comparison operators in expressions

## 🚀 Running the Examples

All examples can be compiled and run using the bootstrap compiler:

```bash
# Run a specific example
python bootstrap/bootstrap.py examples/basics/arrays.sfn

# Test all examples in the basics directory
python bootstrap/test_all_examples.py --dir basics
```

## 📈 Test Results

Current test status: **24/24 examples passing (100%)**

All examples in this directory successfully:

1. Parse without syntax errors
2. Generate valid Python code
3. Execute and produce expected output
4. Demonstrate real language features (not just print statements)

## 🔧 Syntax Notes

### Array Syntax

- Use `number[]` and `string[]`, not `[number]` or `[string]`
- Arrays are zero-indexed: `arr[0]`, `arr[1]`, etc.

### Boolean Syntax

- Use `true` and `false` (currently parsed as identifiers)
- Booleans work correctly in conditionals and assignments

### String Interpolation

- Use double braces: `"Hello {{variable}}"`
- Variables are properly interpolated in the generated Python code

### Iteration

- Use while loops instead of for-loops
- The `for-loops.sfn` example shows the recommended iteration pattern

## 📚 Next Steps

These examples provide a solid foundation for understanding Sailfin's current capabilities. For more advanced features, see the examples in other directories:

- `../advanced/` - Advanced language features
- `../concurrency/` - Parallel and concurrent programming
- `../functional/` - Functional programming patterns
- `../types/` - Advanced type system features

---

## 📋 Language Examples and Syntax Guide

### Function Definition

Functions are defined with the `fn` keyword:

```sailfin
fn functionName(param: Type) -> ReturnType {
    // function body
}
```

---

## Hello World

**File: [`hello-world.sfn`](./hello-world.sfn)**

The simplest Sailfin program demonstrates the basic structure and built-in printing functionality.

```sailfin
// examples/basics/hello-world.sfn

fn main() -> void {
    print.info("Hello, Sailfin!");
}
```

**Key Features:**

- `fn main()` is the entry point function
- `-> void` indicates the function returns nothing
- `print.info()` is the built-in logging function for informational output
- Comments use `//` for single-line comments

---

## Variables

**File: [`variables.sfn`](./variables.sfn)**

Sailfin supports both immutable and mutable variables with explicit type annotations.

```sailfin
// examples/basics/variables.sfn

let name: string = "Sail"; // Immutable by default
mut age: number = 25;      // Mutable variable

fn increment() -> void {
    age += 1;
}

fn main() -> void {
    increment();
    print.info("Age is now {{age}}");
}
```

**Key Features:**

- `let` creates immutable variables (default)
- `mut` creates mutable variables
- Type annotations are explicit: `variable: type`
- String interpolation with `{{variable}}`
- Global variables can be accessed from functions
- Compound assignment operators (`+=`, `-=`, `*=`, `/=`) supported

---

## Functions

**File: [`functions.sfn`](./functions.sfn)**

Functions in Sailfin support parameters, return types, and default arguments.

```sailfin
// examples/basics/functions.sfn

fn add(x: number, y: number) -> number {
    return x + y;
}

fn greet(name: string = "Sail") -> string {
    return "Hello, {{name}}!";
}

fn main() -> void {
    print.info(add(3, 5));        // Outputs: 8
    print.info(greet());          // Outputs: Hello, Sail!
    print.info(greet("Alice"));   // Outputs: Hello, Alice!
}
```

**Key Features:**

- Functions are declared with `fn` keyword
- Parameters have explicit type annotations
- Return type is specified after `->`
- Default parameter values are supported (`name: string = "Sail"`)
- Functions must explicitly `return` values (except for `void` functions)
- Function calls use standard parentheses syntax

---

## Function Expressions (Lambdas)

**File: [`function-expression.sfn`](./function-expression.sfn)**

Sailfin supports anonymous functions using lambda expressions.

```sailfin
// examples/basics/function-expression.sfn

fn main() -> void {
    let add = lambda(x: number, y: number) -> number { return x + y; };
    print.info("Result: {{add(5, 3)}}");
}
```

**Key Features:**

- `lambda` keyword for anonymous functions
- Lambda expressions can be assigned to variables
- Full type annotations for parameters and return types
- Lambdas support closures and first-class function behavior

---

## Arrays

**File: [`arrays.sfn`](./arrays.sfn)**

Sailfin provides typed arrays with bracket syntax for indexing.

```sailfin
// examples/basics/arrays.sfn

fn main() -> void {
    // Creating arrays with correct syntax: type[]
    let numbers: number[] = [1, 2, 3, 4, 5];
    let names: string[] = ["Alice", "Bob", "Charlie"];
    let empty: number[] = [];

    // Array access - demonstrating real array indexing
    print.info("First number: {{numbers[0]}}");
    print.info("Second name: {{names[1]}}");
    print.info("Third number: {{numbers[2]}}");
    print.info("Last number: {{numbers[4]}}");
    print.info("Last name: {{names[2]}}");

    // Array element access and assignment
    let firstElement: number = numbers[0];
    let middleName: string = names[1];

    print.info("Stored first element: {{firstElement}}");
    print.info("Stored middle name: {{middleName}}");
}
```

**Key Features:**

- Array types use `Type[]` syntax (e.g., `number[]`, `string[]`)
- Array literals use square brackets `[1, 2, 3]`
- Zero-indexed access with bracket notation `arr[0]`
- Empty arrays can be declared: `let empty: number[] = []`
- Array elements can be stored in variables

---

## Strings

**File: [`strings.sfn`](./strings.sfn)**

Sailfin provides string literals with interpolation support.

```sailfin
// examples/basics/strings.sfn

fn main() -> void {
    // String literals
    let greeting: string = "Hello";
    let name: string = "Sailfin";

    // String interpolation (the main string feature currently supported)
    let world: string = "World";
    print.info("Hello, {{world}}!");
    print.info("Welcome to {{name}}!");

    // Multiple string variables in interpolation
    let firstName: string = "Alice";
    let lastName: string = "Johnson";
    print.info("Full name: {{firstName}} {{lastName}}");

    // String variables in calculations/interpolation
    let version: string = "1.0";
    let appName: string = "Sailfin";
    print.info("Running {{appName}} version {{version}}");
}
```

**Key Features:**

- String literals use double quotes `"text"`
- String interpolation with `{{variable}}` syntax
- Multiple variables can be interpolated in a single string
- Strings support Unicode and special characters

---

## Booleans

**File: [`booleans.sfn`](./booleans.sfn)**

Boolean type with `true`/`false` literals and comparison operations.

```sailfin
// examples/basics/booleans.sfn

fn main() -> void {
    // Boolean literals (true/false are identifiers in current implementation)
    let isActive: bool = true;
    let isComplete: bool = false;

    // Comparison operators
    let x: number = 10;
    let y: number = 5;

    print.info("Comparing {{x}} and {{y}}:");
    print.info("x > y: (calculated as {{x}} > {{y}})");
    print.info("x < y: (calculated as {{x}} < {{y}})");
    print.info("x == y: (calculated as {{x}} == {{y}})");

    // Boolean variables in conditionals
    if isActive {
        print.info("System is active");
    }

    if isComplete {
        print.info("Task is complete");
    }
}
```

**Key Features:**

- Boolean type is `bool`
- Boolean literals: `true` and `false`
- Comparison operators: `==`, `!=`, `<`, `>`, `<=`, `>=`
- Booleans work directly in `if` conditions
- Logical operators: `&&` (AND), `||` (OR), `!` (NOT)

---

## Conditionals

**File: [`conditionals.sfn`](./conditionals.sfn)**

Sailfin provides both `if-else` statements and pattern matching with `match`.

```sailfin
// examples/basics/conditionals.sfn

fn checkNumber(value: number) -> void {
    if value > 0 {
        print.info("{{value}} is positive");
    } else if value < 0 {
        print.info("{{value}} is negative");
    } else {
        print.info("{{value}} is zero");
    }

    match value {
        42 =>    print.info("The answer to life, the universe, and everything!"),
        -1 =>    print.info("A special negative number!"),
        _  =>    print.info("Just another number.")
    }
}

fn main() -> void {
    checkNumber(42);
    checkNumber(-5);
    checkNumber(0);
}
```

**Key Features:**

- Standard `if-else if-else` chains
- No parentheses required around conditions
- Pattern matching with `match` expressions
- Fat arrow `=>` for match arms
- Wildcard pattern `_` for catch-all cases
- Multiple conditions can be chained

---

## Loops

**File: [`loops.sfn`](./loops.sfn)**

Sailfin currently supports `while` loops for iteration.

```sailfin
// examples/basics/loops.sfn

fn testWhile() -> void {
    let i: number = 0;
    while i < 10 {
        i = i + 1;
    }
}
```

**Key Features:**

- Functions can have multiple parameters
- Return types are explicitly declared
- Default parameter values are supported
- Functions must explicitly `return` values

---

## Conditionals

**File: [`conditionals.sfn`](./conditionals.sfn)**

Sailfin provides both traditional `if-else` statements and powerful pattern matching with `match`.

```sailfin
// examples/basics/conditionals.sfn

fn checkNumber(value: number) -> void {
    if value > 0 {
        print.info("{{value}} is positive");
    } else if value < 0 {
        print.info("{{value}} is negative");
    } else {
        print.info("{{value}} is zero");
    }

    match value {
        42 =>    print.info("The answer to life, the universe, and everything!"),
        -1 =>    print.info("A special negative number!"),
        _  =>    print.info("Just another number.")
    }
}

fn main() -> void {
    checkNumber(42);
    checkNumber(-5);
    checkNumber(0);
}
```

**Key Features:**

- Standard `if-else if-else` chains
- Pattern matching with `match` expressions
- Wildcard pattern `_` for catch-all cases
- No parentheses required around conditions

---

## Loops

**File: [`loops.sfn`](./loops.sfn)**

Sailfin supports `while` loops for iteration.

```sailfin
fn testWhile() -> void {
    let i: number = 0;
    while i < 10 {
        i = i + 1;
    }
}
```

**Key Features:**

- `while` loops with condition checking
- Loop variables can be modified within the loop body
- No parentheses required around loop conditions

---

## Structs

**File: [`structs.sfn`](./structs.sfn)**

Structs in Sailfin can contain both data fields and methods.

```sailfin
// examples/basics/structs.sfn

struct User {
    id: number;
    name: string;

    fn greet(self) -> string {
        return "Hello, {{ self.name }}!";
    }
}

fn main() -> void {
    let user: User = new User { id: 1, name: "Alice" };
    print.info(user.greet()); // Outputs: Hello, Alice!
}
```

**Key Features:**

- Structs define custom data types
- Methods can be defined within structs
- `self` parameter for instance methods
- Object construction with `new StructName { field: value }`
- Field access with dot notation

---

## Interfaces

**File: [`interfaces.sfn`](./interfaces.sfn)**

Interfaces define contracts that structs can implement, enabling polymorphism.

```sailfin
// examples/basics/interfaces.sfn

interface Greeter {
    fn greet(self) -> string;
}

struct User implements Greeter {
    id: number;
    name: string;

    fn greet(self) -> string {
        return "Hello, {{self.name}}!";
    }
}

fn main() -> void {
    let greeter: Greeter = new User { id: 1, name: "Alice" };
    print.info(greeter.greet()); // Outputs: Hello, Alice!
}
```

**Key Features:**

- Interfaces define method signatures
- Structs can implement interfaces with `implements`
- Interface types can hold any implementing struct
- Polymorphic behavior through interface references

---

## Enums

**File: [`basic-enum.sfn`](./basic-enum.sfn)**

Basic enums represent a fixed set of named values.

```sailfin
// examples/basics/basic-enum.sfn

enum Color {
    Red,
    Green,
    Blue,
}

fn main() -> void {
    let favorite: Color = Color.Red;

    if (favorite == Color.Red) {
        print.info("Your favorite color is red!");
    }
}
```

**Key Features:**

- Enums define a set of named constants
- Enum values are accessed with `EnumName.Value`
- Enums can be compared for equality
- Type-safe enumeration values

---

## Tagged Enums

**File: [`tagged-enum.sfn`](./tagged-enum.sfn)**

Tagged enums (also known as algebraic data types) can carry associated data.

```sailfin
// examples/basics/tagged-enum.sfn

enum Shape {
    Circle { radius: number },
    Rectangle { width: number, height: number },
}

fn area(shape: Shape) -> number {
    match shape {
        Shape.Circle { radius } => 3.14 * radius * radius,
        Shape.Rectangle { width, height } => width * height,
    }
}

fn main() -> void {
    let circle: Shape = Shape.Circle { radius: 5 };
    print.info("Area: {{area(circle)}}"); // Outputs: Area: 78.5
}
```

**Key Features:**

- Enum variants can contain structured data
- Pattern matching extracts data from enum variants
- Destructuring assignment in match patterns
- Type-safe data modeling with variants

---

## Error Handling

**File: [`error-handling.sfn`](./error-handling.sfn)**

Sailfin uses union types for explicit error handling without exceptions.

```sailfin
// examples/basics/error-handling.sfn

struct DivisionError {
    message: string;
}

fn safeDivide(a: number, b: number) -> number | DivisionError {
    if b == 0 {
        return new DivisionError { message: "Cannot divide by zero!" };
    }
    return a / b;
}

fn main() -> void {
    let result: number | DivisionError = safeDivide(10, 0);

    match result {
        DivisionError { message } => print.error("Error: {{message}}"),
        _ => print.info("Result: {{result}}"),
    }
}
```

**Key Features:**

- Union types with `|` operator for multiple possible return types
- Explicit error handling without exceptions
- Pattern matching on union types
- `print.error()` for error output
- Errors are values that must be handled

---

## Exception Handling

**File: [`try-catch-finally.sfn`](./try-catch-finally.sfn)**

Sailfin also supports traditional exception handling for exceptional cases.

```sailfin
// examples/basics/finally.sfn

try {
    // Risky operation
} catch (SpecificError e) {
    // Handle the specific error
} finally {
    // Cleanup code
}
```

**Key Features:**

- `try-catch-finally` blocks for exception handling
- Specific error type catching
- `finally` blocks for cleanup code

---

## Function Expressions

**File: [`function-expression.sfn`](./function-expression.sfn)**

Sailfin supports lambda expressions for anonymous functions.

```sailfin
// examples/basics/function-expression.sfn

fn main() -> void {
    let add = lambda(x: number, y: number) -> number { return x + y; };
    print.info("Result: {{add(5, 3)}}");
}
```

**Key Features:**

- `lambda` keyword for anonymous functions
- Lambda expressions can be assigned to variables
- Full type annotations for lambda parameters and return types
- First-class function support

---

## Struct Composition

**File: [`struct-composition.sfn`](./struct-composition.sfn)**

This example demonstrates how to compose behavior using interfaces and multiple struct implementations.

```sailfin
// examples/basics/struct-composition.sfn

interface Driveable {
    fn drive(self) -> string;
}

struct Car implements Driveable {
    brand: string;

    fn create(brand: string) -> Car {
        return new Car { brand };
    }

    fn drive(self) -> string {
        return "Driving a {{self.brand}} car.";
    }
}

struct Bike implements Driveable {
    brand: string;

    fn create(brand: string) -> Bike {
        return new Bike { brand };
    }

    fn drive(self) -> string {
        return "Riding a {{self.brand}} bike.";
    }
}

fn main() -> void {
    let vehicle1: Driveable = Car.create("Tesla");
    let vehicle2: Driveable = Bike.create("Yamaha");

    print.info(vehicle1.drive()); // Outputs: Driving a Tesla car.
    print.info(vehicle2.drive()); // Outputs: Riding a Yamaha bike.
}
```

**Key Features:**

- Static methods on structs (like `Car.create()`)
- Multiple structs implementing the same interface
- Polymorphic behavior through interface references
- Factory methods for object creation

---

## Testing

**File: [`tests.sfn`](./tests.sfn)**

Sailfin has built-in testing support with the `test` keyword and `assert` statements.

```sailfin
// examples/basics/tests.sfn

fn add(x: number, y: number) -> number {
    return x + y;
}

test "add function should return correct sum" {
    assert add(2, 3) == 5;
    assert add(-1, 1) == 0;
}
```

**Key Features:**

- Built-in `test` blocks with descriptive names
- `assert` statements for test assertions
- Integration with the language's testing framework

---

## Running Examples

To run any of these examples, use the Sailfin bootstrap compiler:

```bash
cd /path/to/sailfin/bootstrap
python bootstrap.py ../examples/basics/hello-world.sfn
```

Replace `hello-world.sfn` with any other example file to see it in action.

## Type System

Sailfin features a strong, static type system with:

- **Primitive types**: `number`, `string`, `bool`
- **Custom types**: `struct`, `enum`, `interface`
- **Union types**: `Type1 | Type2` for expressing alternatives
- **Generic types**: (demonstrated in advanced examples)
- **Type inference**: The compiler can often infer types automatically

## Memory Model

Sailfin emphasizes memory safety through:

- **Ownership semantics**: Clear rules about who owns what data
- **No null pointers**: Types are non-nullable by default
- **Pattern matching**: Safe extraction of data from complex types
- **Compile-time checks**: Many errors caught before runtime

---

_This README provides a comprehensive overview of Sailfin's basic features. For more advanced examples, check out the `../advanced/` directory._
