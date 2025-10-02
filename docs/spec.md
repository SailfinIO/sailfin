# Sailfin Language Specification

Version: 0.1.0 (bootstrap preview)
Date: October 2025

Sailfin is a statically-typed, expression-oriented programming language that
combines familiar TypeScript-style types with Go-inspired concurrency
primitives. This document focuses on the subset of the language implemented by
the Python bootstrap compiler and should be considered the authoritative source
for the current behaviour.

## 1. Lexical Structure

* **Identifiers** begin with a letter and may contain ASCII letters, digits, or
  `_`. Identifiers are case-sensitive.
* **Keywords** are listed in `docs/keywords.md` and cannot be used as
  identifiers. Notable keywords include `fn`, `async`, `await`, `let`, `mut`,
  `struct`, `enum`, `match`, `routine`, `try`, `catch`, and `throw`.
* **Literals**:
  * Numeric literals support integers (`42`) and decimals (`3.14`).
  * String literals are wrapped in double quotes and support escape sequences.
    The bootstrap compiler also recognises `{{ expression }}` for string
    interpolation (see §7).
  * Boolean literals are `true` and `false`.
  * The keyword `null` denotes the absence of a value.
* **Comments** use `//` for single-line comments and `/* … */` for multi-line
  comments.

## 2. Modules and Imports

Source files are compiled independently. A program consists of zero or more
imports followed by declarations. Imports use ES-module style syntax:

```sail
import { Channel, channel } from "sail/async";
```

The bootstrap compiler records imports but does not yet resolve them; runtime
support is provided by the Python backend.

## 3. Declarations

### 3.1 Variables and Constants

Variables default to immutability and are introduced with `let`. Add `mut`
after `let` to allow reassignment.

```sail
let name -> string = "Sailfin";
let mut counter -> number = 0;
```

Type annotations are optional; the compiler currently performs limited type
inference for unannotated declarations. Constants use `const` and must provide
an initializer.

### 3.2 Functions

Functions use the `fn` keyword. Parameters accept optional type annotations and
default values. Use the arrow syntax to annotate return types.

```sail
fn add(x -> number, y -> number) -> number {
    return x + y;
}

fn greet(name -> string = "World") -> string {
    return "Hello, {{name}}!";
}
```

Functions are synchronous by default. Prefix with `async` to enable `await`
within the body. Decorators (`@identifier`) are parsed but currently ignored by
code generation.

### 3.3 Structs and Methods

Structs group fields and methods. Fields are immutable unless declared with
`mut`. Methods are defined with `fn` inside the struct body and may reference a
`self` parameter explicitly. A struct may declare that it implements one or
more interfaces using an `implements` clause:

```sail
interface Greeter {
    fn greet(self) -> string;
}

struct User implements Greeter {
    id -> number;
    mut name -> string;

    fn greet(self) -> string {
        return "Hello, {{self.name}}!";
    }
}
```sail
let user -> User = User { id: 1, name: "Ada" };
print.info(user.greet());
```

Struct literals use `Type { field: expression }` syntax. Method calls follow
`instance.method(arguments)` semantics.

### 3.4 Enums

Enums mirror algebraic data types. Each variant may define an optional payload:

```sail
enum Response {
    Ok,
    Error { message -> string },
}
```

Enum syntax is parsed by the bootstrap compiler; the Python backend lowers
variants to helper objects in `runtime_support`.

### 3.5 Type Aliases

Type aliases provide named shortcuts:

```sail
type Result<T> = Response | T;
```

Generics are parsed but not yet enforced type-checking wise. The bootstrap
compiler treats type annotations as metadata for the code generator.

## 4. Statements and Control Flow

### 4.1 Assignment and Expressions

The standard arithmetic (`+`, `-`, `*`, `/`) and logical (`&&`, `||`, `!`)
operators are supported. Compound assignment (`+=`, `-=`, `*=`, `/=`) is
available for identifiers and member expressions.

### 4.2 Conditionals

`if` statements accept optional parentheses around the condition. The `else`
branch may nest another `if` to produce `else if` chains.

```sail
if score >= 90 {
    print.info("Excellent");
} else if score >= 70 {
    print.info("Pass");
} else {
    print.info("Retry");
}
```

### 4.3 Pattern Matching

`match` evaluates an expression against ordered cases. Patterns support
numerical literals, string literals, `_` wildcards, and constructor matching for
enums. Inline case bodies omit braces and may optionally end with a semicolon.

```sail
match value {
    42 -> print.info("The answer"),
    _  -> print.info("Something else"),
}
```

### 4.4 Error Handling

Sail provides `try`/`catch`/`finally` blocks alongside `throw` statements. The
bootstrap runtime raises Python exceptions internally.

```sail
try {
    account.withdraw(200);
} catch (err) {
    print.info("Error: {{err}}");
}
```

## 5. Concurrency

The concurrency model focuses on lightweight routines and channel-based
communication. `async fn` enables coroutines and `await` suspends execution
until the awaited routine completes. `routine { ... }` launches an asynchronous
task using the helper `runtime.spawn`.

```sail
async fn main() {
    let messages -> Channel<number> = channel();

    routine {
        messages.send(42);
    }

    let result -> number = await messages.receive();
    print.info("Received: {{result}}");
}
```

Parallel execution of pure computations is exposed via `runtime.parallel`
through function calls; native `parallel` expressions are reserved for future
work.

## 6. Types

Sail features a nominal type system with the following primitives:

| Type      | Description                                    |
|-----------|------------------------------------------------|
| `number`  | 64-bit floating point numbers                   |
| `string`  | UTF-8 encoded strings                          |
| `boolean` | Truth values                                   |
| `void`    | No return value (implicit when omitted)         |
| `null`    | Explicit absence of a value                     |

Composite types include structs, enums, arrays (`Type[]`), union types (`A | B`),
and optionals (`Type?`). Function types (`fn(Type, ...) -> Return`) are parsed
but not yet emitted by the bootstrap backend.

## 7. String Interpolation

String literals support inline expressions using `{{ expression }}`. The Python
backend evaluates the expression at runtime using the current local and global
scope:

```sail
let name -> string = "Sail";
print.info("Hello, {{name}}!");
```

If interpolation fails, the original placeholder is preserved to aid debugging.

## 8. Runtime Semantics

The bootstrap compiler translates Sail programs into Python 3 code backed by
`bootstrap/runtime_support.py`. Key helpers:

* `runtime.console.info` – console printing used by the `print.info` idiom.
* `runtime.channel`, `runtime.spawn`, `runtime.EnumType` – concurrency and enum
  helpers.
* `runtime.format_string` – implements string interpolation.

Generated Python exposes a `main` entry point when a `fn main` declaration is
present.

## 9. Future Directions

Upcoming milestones include:

1. Full type-checking and inference beyond the bootstrap subset.
2. More exhaustive pattern matching (guards and destructuring patterns).
3. Native modules, package management, and standard library build-out.
4. A self-hosted compiler once the bootstrap stabilises.

This specification will evolve alongside the bootstrap implementation. Refer to
`enbf.md` and the unit tests under `bootstrap/tests/` for executable examples of
the language.
