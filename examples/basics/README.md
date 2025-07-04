# Sailfin Language Basics

Welcome to the Sailfin programming language! This directory contains basic examples that demonstrate the core syntax and features of Sailfin. Each `.sfn` file showcases different aspects of the language, from simple "Hello World" programs to more advanced concepts like interfaces and error handling.

## Table of Contents

1. [Hello World](#hello-world)
2. [Variables](#variables)
3. [Functions](#functions)
4. [Conditionals](#conditionals)
5. [Loops](#loops)
6. [Structs](#structs)
7. [Interfaces](#interfaces)
8. [Enums](#enums)
9. [Tagged Enums](#tagged-enums)
10. [Error Handling](#error-handling)
11. [Exception Handling](#exception-handling)
12. [Function Expressions](#function-expressions)
13. [Struct Composition](#struct-composition)
14. [Testing](#testing)

## Language Overview

Sailfin is a modern, statically-typed programming language that emphasizes safety, expressiveness, and performance. It features:

- **Static typing** with type inference
- **Memory safety** without garbage collection overhead
- **Pattern matching** for elegant control flow
- **Interfaces** for clean abstractions
- **Enums and tagged unions** for safe data modeling
- **Built-in testing** support
- **Error handling** through union types

## Syntax Highlights

### Comments

```sailfin
// Single-line comments start with //
```

### String Interpolation

Sailfin uses `{{}}` syntax for string interpolation:

```sailfin
let name = "World";
print.info("Hello, {{name}}!");
```

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

- `fn main()` is the entry point
- `-> void` indicates the function returns nothing
- `print.info()` is the built-in logging function for informational output

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

- `let` creates immutable variables
- `mut` creates mutable variables
- Type annotations are explicit: `variable: type`
- String interpolation with `{{variable}}`
- Global variables can be accessed from functions

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
