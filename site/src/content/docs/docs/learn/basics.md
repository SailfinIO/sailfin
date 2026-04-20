---
title: Language Basics
description: Variables, primitive types, operators, control flow, pattern matching, and collections in Sailfin.
section: learn
sidebar:
  order: 1
---

This guide covers the core building blocks of Sailfin: how to declare variables, work with types, write control flow, match patterns, and use collections. If you have read the [Tour](/docs/getting-started/tour), this goes deeper on each topic with complete examples and the edge cases that matter.

---

## Variables

Sailfin uses `let` for bindings. All bindings are **immutable by default**. You must opt into mutability explicitly with `let mut`.

```sfn
let language = "Sailfin";     // immutable — cannot be reassigned
let mut count = 0;             // mutable — can be reassigned
count = count + 1;             // OK
count += 1;                    // also OK (compound assignment)

// language = "Other";        // COMPILE ERROR: cannot assign to immutable binding
```

### Type Annotations

Type inference handles the common case. Annotate explicitly when the type is
ambiguous or when you want the code to serve as documentation. Variable, field,
and parameter type annotations use `:`:

```sfn
let x: number = 42;
let ratio: number = 3.14;
let name: string = "Alice";

// Without annotation — inferred from the right-hand side
let z = 100;                  // z: number
let flag = true;              // flag: boolean
```

Use explicit annotations when:
- The initializer could produce multiple types (e.g., you want `i32` rather than the default `number`)
- You are declaring a binding with no initializer (not currently supported; annotate and initialize together)
- You want the code to serve as documentation

### Shadowing

A new `let` binding can shadow an existing one within the same or a nested scope. The original binding is not mutated — a new binding with the same name is created:

```sfn
let value = 5;
let value = value * 2;        // shadows the first; value is now 10
let value = "{{value}}";      // shadows again; value is now a string

print(value);                 // prints "10"
```

Shadowing is useful when a value goes through a transformation and you want to reuse a descriptive name at each step, without needing `mut`.

### Scoping

Bindings are scoped to the block in which they appear. A block is any `{ }` body — function body, `if` branch, `for` loop body, etc.

```sfn
let outer = "outside";

{
    let inner = "inside";
    print(outer);             // OK — outer is visible here
    print(inner);             // OK
}

// print(inner);              // COMPILE ERROR: inner is not in scope here
print(outer);                 // OK
```

A binding introduced in an inner block shadows an outer binding with the same name for the duration of that block, then the outer binding becomes visible again:

```sfn
let x = 1;
{
    let x = 99;               // shadows outer x
    print(x);                 // prints 99
}
print(x);                     // prints 1 — outer x is back
```

### Value vs Reference Semantics

Sailfin's ownership story is part of the pre-1.0 roadmap — the borrow syntax
below is **parsed but not yet enforced**. Today, values behave similarly to
other modern systems languages: primitives are copied, and structs and
collections are passed by reference at the implementation level. Treat this
section as the direction of travel.

```sfn
// Primitives are copied
let a = 42;
let b = a;
print(a);
print(b);

// Borrow syntax (parsed today; enforcement post-1.0)
fn count(v: &number[]) -> number {
    return v.length;
}
```

See [Ownership & Borrowing](/docs/learn/ownership) and the
[roadmap](/roadmap) for when full enforcement lands.

---

## Primitive Types

### Core Types

| Type | Description | Literal examples |
|------|-------------|-----------------|
| `number` | 64-bit numeric (the single numeric type today) | `0`, `42`, `-7`, `3.14` |
| `boolean` | Boolean | `true`, `false` |
| `string` | UTF-8 text | `"hello"`, `""` |
| `void` | No value (return type only) | — |
| `null` | Absence of a value | `null` |

`number` is Sailfin's single numeric type today and covers both integer and
floating-point values. A forthcoming split into distinct `int` (i64) and
`float` (f64) types is tracked on the [roadmap](/roadmap); until that lands,
use `number` for both counts and measurements.

```sfn
let count: number = 100;
let ratio: number = 0.75;
let name: string = "Sailfin";
let active: boolean = true;
```

### FFI and Low-Level Integer Types

When interfacing with C libraries, system calls, or serialization formats,
Sailfin exposes sized integer and float types:

| Type | Description |
|------|-------------|
| `i8` | 8-bit signed |
| `i16` | 16-bit signed |
| `i32` | 32-bit signed |
| `i64` | 64-bit signed |
| `u8` | 8-bit unsigned |
| `u16` | 16-bit unsigned |
| `u32` | 32-bit unsigned |
| `u64` | 64-bit unsigned |
| `f32` | 32-bit float |
| `f64` | 64-bit float |
| `usize` | Platform-native pointer-sized unsigned integer |

These are most useful in `extern` declarations and performance-sensitive code
that must interoperate with C:

```sfn
unsafe extern fn malloc(size: usize) -> *u8;
unsafe extern fn free(ptr: *u8) -> void;
```

For all ordinary application code, prefer `number`.

### Numeric Literals

Numeric literals use ordinary decimal and floating-point forms. Hex and binary
literals are supported for sized integer types:

```sfn
let count: number = 1000000;
let pi: number = 3.141592653;
let byte: u8 = 0xFF;          // hex literal
let mask: u32 = 0b11110000;   // binary literal
```

### Booleans

`boolean` has exactly two values: `true` and `false`. Sailfin has no implicit
truthiness — numbers, strings, and null do not coerce to `boolean`. Every
condition in an `if` or `match` guard must be a `boolean` expression.

```sfn
let ready = true;
let done = false;

// if 0 { ... }              // COMPILE ERROR: number is not boolean
if count == 0 { ... }        // OK — comparison produces boolean
```

---

## String Interpolation

String literals support embedded expressions using double-brace syntax: `{{ expression }}`. The expression is evaluated at runtime and its result is converted to a string.

```sfn
let name = "Alice";
let age = 30;

let greeting = "Hello, {{name}}!";                // "Hello, Alice!"
let summary = "{{name}} is {{age}} years old.";   // "Alice is 30 years old."
let math = "3 * 4 = {{3 * 4}}";                  // "3 * 4 = 12"
```

Any expression works inside the braces, including function calls and field
accesses:

```sfn
struct User {
    name: string;
    age: number;
}

fn format_user(user: User) -> string {
    return "{{user.name}} ({{user.age}})";
}
```

> **Coming in 1.0:** String interpolation will migrate from `{{ expr }}` to
> `${ expr }`. The change is tracked on the [roadmap](/roadmap) under Syntax
> Reform; today's examples still use `{{ }}`.

### Multi-line Strings

Multi-line strings use the same double-quoted syntax. A newline in the source becomes a newline in the string:

```sfn
let message = "Line one
Line two
Line three";
```

For structured text with consistent indentation, leading whitespace on each line is preserved as written. Trim as needed with `.trim()` or `.trim_start()`.

---

## Operators

### Arithmetic

| Operator | Meaning | Example |
|----------|---------|---------|
| `+` | Addition | `x + y` |
| `-` | Subtraction | `x - y` |
| `*` | Multiplication | `x * y` |
| `/` | Division | `x / y` |
| `%` | Remainder (modulo) | `x % y` |
| `-` (unary) | Negation | `-x` |

Integer division truncates toward zero. Dividing by zero is a runtime panic.

```sfn
let a = 10;
let b = 3;
print(a / b);    // 3 (integer division)
print(a % b);    // 1 (remainder)

let x = 7.0;
let y = 2.0;
print(x / y);    // 3.5 (float division)
```

### Comparison

| Operator | Meaning |
|----------|---------|
| `==` | Equal |
| `!=` | Not equal |
| `<` | Less than |
| `>` | Greater than |
| `<=` | Less than or equal |
| `>=` | Greater than or equal |

All comparison operators return `boolean`. They work on `number`, `string`, and
`boolean` primitives today. Structural equality for structs and enums is part
of the pre-1.0 interface work tracked on the [roadmap](/roadmap).

```sfn
let result = 3 * 4 == 12;       // true
let in_range = x >= 0 && x < 100;
```

### Logical

| Operator | Meaning | Short-circuits? |
|----------|---------|-----------------|
| `&&` | Logical AND | Yes — right side only evaluated if left is `true` |
| `\|\|` | Logical OR | Yes — right side only evaluated if left is `false` |
| `!` | Logical NOT | — |

```sfn
let valid = name != "" && name.len() < 64;
let allowed = is_admin || has_permission("write");
let rejected = !is_valid(token);
```

### Compound Assignment

| Operator | Equivalent to |
|----------|--------------|
| `x += y` | `x = x + y` |
| `x -= y` | `x = x - y` |
| `x *= y` | `x = x * y` |
| `x /= y` | `x = x / y` |
| `x %= y` | `x = x % y` |

These require `x` to be a `let mut` binding.

### Type-Check Operator

The `is` operator tests whether a value matches a particular type branch at
runtime. It is most useful with union types:

```sfn
fn describe(value: string | number) -> string ![io] {
    if value is string {
        return "a string: {{value}}";
    } else {
        return "a number: {{value}}";
    }
}
```

### Operator Precedence

From highest to lowest (operators on the same row have equal precedence):

| Precedence | Operators |
|------------|-----------|
| 1 (highest) | `-` (unary), `!` |
| 2 | `*`, `/`, `%` |
| 3 | `+`, `-` |
| 4 | `<`, `>`, `<=`, `>=` |
| 5 | `==`, `!=`, `is` |
| 6 | `&&` |
| 7 | `\|\|` |
| 8 (lowest) | Assignment: `=`, `+=`, `-=`, `*=`, `/=`, `%=` |

When in doubt, use parentheses. `(a + b) * c` is always unambiguous.

---

## Control Flow

### If / Else

```sfn
if temperature > 100 {
    print("Too hot!");
} else if temperature < 0 {
    print("Too cold!");
} else {
    print("Just right.");
}
```

`if` is an expression. The value of an `if` expression is the value of the branch that ran. Both branches must produce the same type:

```sfn
let label = if score >= 90 { "A" } else if score >= 80 { "B" } else { "C" };
let clamped = if x < 0 { 0 } else if x > 100 { 100 } else { x };
```

When used as an expression, every branch (including the implicit `else`) must be present and all must produce compatible types.

### For Loops

Iterate over any collection with `for item in collection`:

```sfn
let names = ["Alice", "Bob", "Carol"];

for name in names {
    print("Hello, {{name}}!");
}
```

To iterate with indices, use the `.enumerate()` method, which yields `(index, value)` pairs:

```sfn
for (i, name) in names.enumerate() {
    print("{{i}}: {{name}}");
}
```

Iterate over a range of integers with `..` (exclusive end) or `..=` (inclusive end):

```sfn
for i in 0..10 {
    print(i);    // 0, 1, 2, ..., 9
}

for i in 1..=5 {
    print(i);    // 1, 2, 3, 4, 5
}
```

You can also iterate over `Map` entries:

```sfn
for (key, value) in config {
    print("{{key}} = {{value}}");
}
```

### Loop

Sailfin has no `while` keyword today; use `loop` with an `if`/`break` pattern
instead. `loop` runs until explicitly broken via `break`. Use `continue` to
skip ahead to the next iteration:

```sfn
let mut attempts: number = 0;

loop {
    attempts += 1;

    if attempts == 1 {
        continue;
    }

    if attempts > 3 {
        break;
    }

    print("loop iteration {{attempts}}");
}
```

### Break and Continue

`break` exits the innermost loop. `continue` skips to the next iteration of the innermost loop:

```sfn
for item in items {
    if item.is_deleted() {
        continue;    // skip deleted items
    }
    if item.is_terminal() {
        break;       // stop at the first terminal item
    }
    process(item);
}
```

### Labeled Loops

When breaking or continuing an outer loop from inside a nested loop, use a label. Labels are identifiers prefixed with `#`:

```sfn
#outer for row in matrix {
    for cell in row {
        if cell.is_poison() {
            break #outer;    // exits the outer for loop entirely
        }
        process(cell);
    }
}
```

```sfn
#search for x in 0..width {
    for y in 0..height {
        if grid[x][y] == target {
            found_x = x;
            found_y = y;
            break #search;
        }
    }
}
```

### Return

`return` exits the current function with a value. In a `void` function,
`return` with no value exits early:

```sfn
fn find(items: string[], target: string) -> number {
    let mut i: number = 0;
    for item in items {
        if item == target {
            return i;
        }
        i += 1;
    }
    return -1;    // not found
}
```

---

## Pattern Matching

`match` dispatches on the shape or value of an expression. It is an expression — it produces a value. Every `match` must be exhaustive: the compiler rejects cases where some possible value is not covered.

### Literal Patterns

```sfn
let status = "active";

match status {
    "active"  => print("System is active"),
    "paused"  => print("System is paused"),
    "stopped" => print("System is stopped"),
    _         => print("Unknown status: {{status}}"),
}
```

The `_` wildcard matches anything and is used as the catch-all. Without it here, you would need to list every possible string — which is impossible, so `_` is required.

### Integer Patterns

```sfn
let code = 404;

let description = match code {
    200 => "OK",
    201 => "Created",
    400 => "Bad Request",
    401 => "Unauthorized",
    403 => "Forbidden",
    404 => "Not Found",
    500 => "Internal Server Error",
    _   => "Unknown",
};

print("HTTP {{code}}: {{description}}");
```

### Variable Capture

A pattern that is a plain identifier (not a literal, `_`, or enum variant) captures the matched value into a new binding:

```sfn
let value = compute();

match value {
    0       => print("zero"),
    n       => print("got {{n}}"),    // n binds to the matched value
}
```

### Enum Variant Matching

Enum variants can carry data as named fields, and pattern matching
destructures that data:

```sfn
enum Shape {
    Circle { radius: number },
    Rectangle { width: number, height: number },
    Triangle { base: number, height: number },
}

fn area(shape: Shape) -> number {
    match shape {
        Shape.Circle { radius } => return 3.14159 * radius * radius,
        Shape.Rectangle { width, height } => return width * height,
        Shape.Triangle { base, height } => return 0.5 * base * height,
    }
}
```

Match on a struct-wrapped error to handle union return types:

```sfn
struct ParseError {
    message: string;
}

fn parse_port(s: string) -> number | ParseError {
    if s.length == 0 {
        return ParseError { message: "input was empty" };
    }
    return 8080;
}

fn main() ![io] {
    let result = parse_port("");
    match result {
        ParseError { message } => print("error: {{message}}"),
        _ => print("port: {{result}}"),
    }
}
```

### Guard Conditions

Add an `if` clause after a pattern to further filter matches. The arm only
fires if both the pattern matches and the guard is true:

```sfn
fn classify(n: number) ![io] {
    match n {
        v if v < 0 => print("negative: {{v}}"),
        v if v == 0 => print("zero"),
        v if v < 100 => print("small positive: {{v}}"),
        v => print("large positive: {{v}}"),
    }
}
```

Guards work alongside tagged-enum destructuring too:

```sfn
match user {
    User { name, age } if age >= 18 => print("Adult user: {{name}}"),
    User { name, age } => print("Minor user: {{name}}"),
    _ => print("Unknown entity"),
}
```

### Exhaustiveness

The compiler checks that every possible value is matched. If you forget a case, you get a compile error:

```
error[E0302]: non-exhaustive match on `Direction`
  --> src/main.sfn:14:5
   |
14 |     match direction {
   |     ^^^^^ missing variant: `West`
   |
   = help: add a `West => ...` arm, or add a `_ => ...` wildcard arm
```

---

## Collections

### Arrays

Fixed-size, stack-allocated sequences. The size is part of the type.

```sfn
let primes = [2, 3, 5, 7, 11];
let first = primes[0];          // 2
let count = primes.length;      // 5
```

Arrays grow dynamically with `.push(...)`. Declare an array type with the
`T[]` suffix syntax (same form used in the compiler's own source):

```sfn
let mut items: string[] = [];
items.push("alpha");
items.push("beta");
items.push("gamma");

print("{{items.length}} items; first is {{items[0]}}");

let mut totals: number[] = [];
for n in [1, 2, 3] {
    totals.push(n * n);
}
```

Common operations — most functional collection helpers (`.map`, `.filter`,
`.reduce`) accept lambda expressions:

```sfn
let numbers = [1, 2, 3, 4, 5];

let squares = numbers.map(fn(x) -> number { return x * x; });
let total = squares.reduce(0, fn(acc, x) -> number { return acc + x; });

print("sum of squares: {{total}}");
```

> **Coming in 1.0:** A richer standard-library surface — `Map<K, V>`,
> iterator adapters, sort helpers — lands alongside the runtime migration
> tracked on the [roadmap](/roadmap). Today the array type with built-in
> helpers is the primary collection.

---

## Optional Values

Sailfin expresses "value may be absent" through optional types written as
`T?`. The value `null` can be assigned to any optional binding.

```sfn
let middle_name: string? = null;          // no middle name
let nickname: string? = "Ace";            // has a nickname
```

### Working with Optionals

Today, the idiomatic pattern is an explicit `null` check:

```sfn
fn describe(name: string?) ![io] {
    if name == null {
        print("no name");
        return;
    }
    print("hello, {{name}}");
}
```

`match` also destructures an optional struct — for example, a recursive tree:

```sfn
struct TreeNode {
    value: number;
    left: TreeNode?;
    right: TreeNode?;
}

fn traverse(node: TreeNode?) ![io] {
    if node == null { return; }
    traverse(node.left);
    print("{{node.value}}");
    traverse(node.right);
}
```

> **Coming in 1.0:** A `Result<T, E>` type plus a `?` propagation operator are
> on the [roadmap](/roadmap) under Syntax Reform. Until they land, prefer the
> explicit `null` check or the tagged-union pattern shown in
> [Error Handling](/docs/learn/error-handling).

---

## Comments

### Line Comments

```sfn
// This is a line comment — everything after // is ignored

let x = 5;    // inline comment explaining this binding
```

### Block Comments

```sfn
/*
 * This is a block comment.
 * It can span multiple lines.
 */

let result = compute(/* intermediate step */ transform(input));
```

Block comments do not nest by default.

### Documentation Comments

Doc comments use `///` and are attached to the declaration that follows them.
Tooling and the language server display them as hover documentation:

```sfn
/// Returns the distance between two points in Euclidean space.
///
/// # Parameters
/// - `a`: The first point
/// - `b`: The second point
///
/// # Returns
/// A non-negative `number` representing the distance.
fn distance(a: Point, b: Point) -> number {
    let dx = a.x - b.x;
    let dy = a.y - b.y;
    return math.sqrt(dx * dx + dy * dy);
}
```

For struct and interface fields, the doc comment goes above the field:

```sfn
struct Config {
    /// Hostname or IP address of the target server.
    host: string;

    /// Port number (1–65535).
    port: number;

    /// Maximum number of connection attempts before giving up.
    mut max_retries: number;
}
```

---

## Putting It Together

Here is a small program that uses all the concepts from this guide:

```sfn
struct Student {
    name: string;
    scores: number[];
}

fn average(scores: number[]) -> number {
    if scores.length == 0 {
        return 0.0;
    }
    let sum = scores.reduce(0, fn(acc, s) -> number { return acc + s; });
    return sum / scores.length;
}

fn letter_grade(avg: number) -> string {
    if avg >= 90.0 { return "A"; }
    if avg >= 80.0 { return "B"; }
    if avg >= 70.0 { return "C"; }
    if avg >= 60.0 { return "D"; }
    return "F";
}

fn report(student: Student) ![io] {
    let avg = average(student.scores);
    let grade = letter_grade(avg);
    print("{{student.name}}: avg={{avg}}, grade={{grade}}");
}

fn main() ![io] {
    let students = [
        Student { name: "Alice", scores: [95, 87, 92] },
        Student { name: "Bob",   scores: [72, 68, 75] },
        Student { name: "Carol", scores: [88, 91, 84] },
    ];

    for student in students {
        report(student);
    }
}
```

---

## Next Steps

- [Functions & Methods](/docs/learn/functions) — Parameters, effects, closures, generics, and decorators
- [Types & Structs](/docs/learn/types) — Defining structs, enums, interfaces, and type aliases
- [The Effect System](/docs/learn/effects) — How Sailfin enforces capability-based security at compile time
- [Error Handling](/docs/learn/error-handling) — `try/catch`, result types, and propagation patterns
- [Ownership & Borrowing](/docs/learn/ownership) — Move semantics, borrows, and linear types
