---
title: Language Basics
description: Variables, primitive types, operators, control flow, pattern matching, and collections in Sailfin.
section: learn
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

Type inference handles the common case. You can annotate explicitly when the type is ambiguous or you want to be explicit for documentation purposes. Both `:` and `->` work for type annotations on `let`:

```sfn
let x: Int = 42;
let y -> Float = 3.14;        // alternative annotation syntax
let name: String = "Alice";

// Without annotation — inferred from the right-hand side
let z = 100;                  // z: Int
let flag = true;              // flag: Bool
```

Use explicit annotations when:
- The initializer could produce multiple types (e.g., an integer literal used where `i32` vs `i64` matters)
- You are declaring a binding with no initializer (forward declaration is not supported; annotate and initialize together)
- You want the code to serve as documentation

### Shadowing

A new `let` binding can shadow an existing one within the same or a nested scope. The original binding is not mutated — a new binding with the same name is created:

```sfn
let value = 5;
let value = value * 2;        // shadows the first; value is now 10 (Int)
let value = "{{value}}";      // shadows again; value is now a String

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

Sailfin uses **move-by-default** semantics. Assigning a struct or collection to a new binding moves ownership — the original binding becomes invalid. Primitive types (`Int`, `Float`, `Bool`, etc.) are copied implicitly.

```sfn
// Primitives are copied
let a = 42;
let b = a;
print(a);    // still valid — a was copied into b
print(b);

// Structs and collections move
let items = Vec.new();
let moved = items;            // ownership transferred
// items.push("x");           // COMPILE ERROR: use after move

// Use a borrow to read without moving
fn count(v: &Vec<String>) -> Int {
    return v.len();
}
let data = Vec.new();
let n = count(&data);         // data is borrowed, not moved
print(n);
print(data.len());            // data is still valid
```

See [Ownership & Borrowing](/docs/learn/ownership) for the full picture.

---

## Primitive Types

### Core Types

| Type | Description | Literal examples |
|------|-------------|-----------------|
| `Int` | 64-bit signed integer | `0`, `42`, `-7`, `1_000_000` |
| `Float` | 64-bit floating-point (f64) | `0.0`, `3.14`, `-1.5e10` |
| `Bool` | Boolean | `true`, `false` |
| `String` | UTF-8 text | `"hello"`, `""` |
| `void` | No value (return type only) | — |
| `null` | Absence of a value | `null` |

`Int` and `Float` are the everyday numeric types. Use `Int` for counts, indices, and integer arithmetic. Use `Float` for measurements, ratios, and anything that requires fractions.

```sfn
let count: Int = 100;
let ratio: Float = 0.75;
let name: String = "Sailfin";
let active: Bool = true;
```

### FFI and Low-Level Integer Types

When interfacing with C libraries, system calls, or serialization formats, Sailfin exposes sized integer and float types:

| Type | Description |
|------|-------------|
| `i8` | 8-bit signed |
| `i16` | 16-bit signed |
| `i32` | 32-bit signed |
| `i64` | 64-bit signed (same width as `Int`) |
| `u8` | 8-bit unsigned |
| `u16` | 16-bit unsigned |
| `u32` | 32-bit unsigned |
| `u64` | 64-bit unsigned |
| `f32` | 32-bit float |
| `f64` | 64-bit float (same width as `Float`) |
| `usize` | Platform-native pointer-sized unsigned integer |

These are most useful in `extern` declarations and performance-sensitive code that must interoperate with C:

```sfn
extern fn c_write(fd: i32, buf: &u8, count: usize) -> i32 ![io];
```

For all ordinary application code, prefer `Int` and `Float`.

### Numeric Literals

Underscores can be used as separators in numeric literals to improve readability:

```sfn
let million: Int = 1_000_000;
let pi: Float = 3.141_592_653;
let byte: u8 = 0xFF;          // hex literal
let mask: u32 = 0b1111_0000;  // binary literal
```

### Conversions

Sailfin does not implicitly coerce numeric types. Use explicit conversion functions:

```sfn
let n: Int = 42;
let f: Float = Float.from(n);     // Int -> Float

let x: Float = 9.9;
let i: Int = Int.from(x);         // Float -> Int (truncates toward zero)

let small: i32 = 7;
let big: i64 = i64.from(small);
```

### Booleans

`Bool` has exactly two values: `true` and `false`. Sailfin has no implicit truthiness — numbers, strings, and null do not coerce to `Bool`. Every condition in an `if`, `while`, or `match` guard must be a `Bool` expression.

```sfn
let ready = true;
let done = false;

// if 0 { ... }              // COMPILE ERROR: Int is not Bool
if count == 0 { ... }        // OK — comparison produces Bool
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

Any expression works inside the braces, including function calls:

```sfn
fn initials(first: String, last: String) -> String {
    return "{{first[0]}}.{{last[0]}}.";
}

let s = "Result: {{compute(x, y).to_string()}}";
let padded = "Count: {{items.len()}} item(s)";
```

### Escaping Braces

To include a literal `{` or `}` in a string, double it:

```sfn
let json_template = "{{{{ \"key\": \"value\" }}}}";  // produces: { "key": "value" }
```

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

All comparison operators return `Bool`. They work on `Int`, `Float`, `String`, and `Bool`. Structs and enums require an explicit `Eq` interface implementation to use `==` and `!=`.

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

The `is` operator tests whether a value is a specific type at runtime. It returns `Bool` and is most useful with interface types or enum variants:

```sfn
fn describe(value: Any) -> String {
    if value is Int {
        return "an integer";
    } else if value is String {
        return "a string";
    } else {
        return "something else";
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

### While Loops

```sfn
let mut attempts = 0;

while attempts < 3 {
    let result = try_connect();
    if result.is_ok() {
        break;
    }
    attempts += 1;
}
```

### Loop

`loop` runs until explicitly broken. Use `break` to exit, and optionally return a value from the loop:

```sfn
let mut retries = 0;

loop {
    let result = try_operation();
    if result.is_ok() || retries >= 5 {
        break;
    }
    retries += 1;
}
```

`loop` with a break value — the entire `loop` expression evaluates to the value passed to `break`:

```sfn
let connection = loop {
    let attempt = try_connect(endpoint);
    if attempt.is_ok() {
        break attempt.unwrap();    // loop evaluates to the connection
    }
    wait_ms(500);
};
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

`return` exits the current function with a value. In a `void` function, `return` with no value exits early:

```sfn
fn find(items: Vec<String>, target: String) -> Int {
    for (i, item) in items.enumerate() {
        if item == target {
            return i;
        }
    }
    return -1;    // not found
}
```

Functions also support implicit returns: the last expression in a function body (without a semicolon) is the return value:

```sfn
fn clamp(value: Int, min: Int, max: Int) -> Int {
    if value < min { min }
    else if value > max { max }
    else { value }
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

This is the most powerful form. Enum variants can carry data, and pattern matching destructures that data:

```sfn
enum Shape {
    Circle(Float),           // radius
    Rectangle(Float, Float), // width, height
    Triangle(Float, Float, Float),
}

fn area(shape: Shape) -> Float {
    match shape {
        Circle(r)        => 3.14159 * r * r,
        Rectangle(w, h)  => w * h,
        Triangle(a, b, c) => {
            let s = (a + b + c) / 2.0;
            // Heron's formula
            (s * (s - a) * (s - b) * (s - c)).sqrt()
        },
    }
}
```

```sfn
enum Result<T, E> {
    Ok(T),
    Err(E),
}

match parse_int(input) {
    Ok(n)    => print("Parsed: {{n}}"),
    Err(msg) => print("Error: {{msg}}"),
}
```

### Tuple Patterns

Match on multiple values at once by wrapping them in a tuple:

```sfn
let point = (x, y);

match point {
    (0, 0) => print("origin"),
    (0, y) => print("on y-axis at {{y}}"),
    (x, 0) => print("on x-axis at {{x}}"),
    (x, y) => print("at ({{x}}, {{y}})"),
}
```

### Guard Conditions

Add an `if` clause after a pattern to further filter matches. The arm only fires if both the pattern matches and the guard is true:

```sfn
match value {
    n if n < 0    => print("negative: {{n}}"),
    n if n == 0   => print("zero"),
    n if n < 100  => print("small positive: {{n}}"),
    n             => print("large positive: {{n}}"),
}
```

Guards can reference bindings introduced by the pattern:

```sfn
match event {
    Click(x, y) if x > 0 && y > 0 => handle_first_quadrant(x, y),
    Click(x, y)                    => handle_other(x, y),
    KeyPress(key) if key == "Enter" => submit(),
    KeyPress(key)                   => print("Key: {{key}}"),
}
```

### Match as Expression

Because `match` is an expression, you can use it directly in assignments, function arguments, or return statements:

```sfn
let symbol = match direction {
    North => "^",
    South => "v",
    East  => ">",
    West  => "<",
};

fn grade(score: Int) -> String {
    match score {
        n if n >= 90 => "A",
        n if n >= 80 => "B",
        n if n >= 70 => "C",
        n if n >= 60 => "D",
        _            => "F",
    }
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
let primes: Array<Int> = [2, 3, 5, 7, 11];
let first = primes[0];          // 2
let len = primes.length;        // 5
```

Arrays are best for small, fixed sets of values known at compile time (days of the week, a lookup table of fixed size, etc.).

### Vec — Growable Sequences

`Vec<T>` is the workhorse collection. It grows dynamically and supports most sequence operations.

```sfn
let mut items: Vec<String> = Vec.new();
items.push("alpha");
items.push("beta");
items.push("gamma");

print(items.len());             // 3
print(items[0]);                // "alpha"
print(items[items.len() - 1]); // "gamma"

items.pop();                    // removes and returns "gamma"
print(items.len());             // 2
```

Common operations:

```sfn
// Iteration
for item in items {
    print(item);
}

// Indexed iteration
for (i, item) in items.enumerate() {
    print("{{i}}: {{item}}");
}

// Check membership
let has_beta = items.contains("beta");

// Find first match
let found = items.find(|x| x.starts_with("a"));

// Filter to a new Vec
let long_names = items.filter(|name| name.len() > 4);

// Transform to a new Vec
let upper = items.map(|name| name.to_upper());

// Reduce
let total_len = items.reduce(0, |acc, name| acc + name.len());

// Sort (requires Ord implementation)
let mut nums = [5, 2, 8, 1, 9];
nums.sort();
```

### Map — Key-Value Collections

`Map<K, V>` stores key-value pairs with O(1) average lookup.

```sfn
let mut scores: Map<String, Int> = Map.new();
scores.insert("Alice", 95);
scores.insert("Bob", 87);
scores.insert("Carol", 92);

let alice_score = scores.get("Alice");    // returns Int? (optional)
let has_dave = scores.contains_key("Dave");

scores.remove("Bob");
print(scores.len());    // 2
```

Iterating a `Map` yields `(key, value)` pairs. Iteration order is not guaranteed:

```sfn
for (name, score) in scores {
    print("{{name}}: {{score}}");
}
```

Common operations:

```sfn
// Get all keys
let names = scores.keys();

// Get all values
let all_scores = scores.values();

// Update a value in place
scores.insert("Alice", scores.get("Alice").unwrap_or(0) + 5);

// Get or insert a default
let val = scores.get_or_insert("Dave", 0);
```

### Accessing Elements Safely

Direct indexing (`items[i]`) panics at runtime if the index is out of bounds. Use `.get(i)` to get an optional result instead:

```sfn
let item = items.get(5);   // returns String? — None if out of bounds

match item {
    Some(v) => print("Found: {{v}}"),
    None    => print("Index out of range"),
}
```

---

## Null and Optionals

Sailfin expresses "value may be absent" through optional types written as `T?` (equivalent to `Option<T>` in the standard library). The value `null` can be assigned to any optional binding.

```sfn
let middle_name: String? = null;          // no middle name
let nickname: String? = "Ace";            // has a nickname
```

### Working with Optionals

The safe way to use an optional is `match`:

```sfn
match middle_name {
    Some(name) => print("Middle name: {{name}}"),
    None       => print("No middle name"),
}
```

`unwrap_or` provides a default when the value is absent:

```sfn
let display = middle_name.unwrap_or("(none)");
print("Middle name: {{display}}");
```

`unwrap` extracts the value and panics if it is `null`. Use it only when you are certain the value is present:

```sfn
let name = nickname.unwrap();    // panics if nickname is null
```

### Null Safety

Sailfin does not allow using a `T?` value where a `T` is required without an explicit unwrap or guard. There is no null pointer dereference — null values can only exist in optional-typed positions.

```sfn
fn greet(name: String) ![io] {
    print("Hello, {{name}}!");
}

let maybe_name: String? = get_name();

// greet(maybe_name);            // COMPILE ERROR: expected String, got String?

if maybe_name != null {
    greet(maybe_name.unwrap());   // safe: we checked above
}
```

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

Doc comments use `///` and are attached to the declaration that follows them. Tooling and the language server display them as hover documentation:

```sfn
/// Returns the distance between two points in Euclidean space.
///
/// # Parameters
/// - `a`: The first point
/// - `b`: The second point
///
/// # Returns
/// A non-negative `Float` representing the distance.
fn distance(a: Point, b: Point) -> Float {
    let dx = a.x - b.x;
    let dy = a.y - b.y;
    return (dx * dx + dy * dy).sqrt();
}
```

For struct and interface fields, the doc comment goes above the field:

```sfn
struct Config {
    /// Hostname or IP address of the target server.
    host -> String;

    /// Port number (1–65535).
    port -> Int;

    /// Maximum number of connection attempts before giving up.
    mut max_retries -> Int;
}
```

---

## Putting It Together

Here is a small program that uses all the concepts from this guide:

```sfn
struct Student {
    name -> String;
    scores -> Vec<Int>;
}

fn average(scores: &Vec<Int>) -> Float {
    if scores.len() == 0 {
        return 0.0;
    }
    let sum = scores.reduce(0, |acc, s| acc + s);
    return Float.from(sum) / Float.from(scores.len());
}

fn letter_grade(avg: Float) -> String {
    match avg {
        n if n >= 90.0 => "A",
        n if n >= 80.0 => "B",
        n if n >= 70.0 => "C",
        n if n >= 60.0 => "D",
        _              => "F",
    }
}

fn report(student: &Student) ![io] {
    let avg = average(&student.scores);
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
        report(&student);
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
