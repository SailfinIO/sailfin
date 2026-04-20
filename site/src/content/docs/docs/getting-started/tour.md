---
title: Tour of Sailfin
description: A guided introduction to every major Sailfin feature, from Hello World to effect types.
section: getting-started
sidebar:
  order: 4
---

This tour walks through Sailfin's major features with short, working examples. By the end you will have a clear picture of what makes Sailfin different and how its features — effect types, capability security, pattern matching, and structured concurrency — fit together into a coherent language.

Each section stands alone. If you already know what `let` does, skip to the part that is new to you.

---

## Hello, World — Explained

```sfn
fn main() ![io] {
    print("Hello, World!");
}
```

Let's break this down word by word.

**`fn`** — the keyword that introduces a function declaration.

**`main`** — the name of the function. `main` is the program entry point, just as in Go or Rust.

**`()`** — the parameter list. `main` takes no parameters.

**`![io]`** — an **effect annotation**. It declares that `main` is allowed to perform I/O operations such as printing to the console and reading files. Without this annotation, calling `print` would be a compile error. This is a key feature of Sailfin: every function declares what it is allowed to do.

**`{ print("Hello, World!"); }`** — the function body. `print` writes to standard output and requires the `io` effect.

Try removing `![io]`:

```
effects.missing: function `main` calls `print` which requires ![io],
                 but `main` declares no effects
  = help: add `io` to the effect list: `fn main() ![io]`
```

Sailfin is telling you exactly what went wrong and how to fix it. This is the effect system in action.

---

## Variables

Sailfin uses `let` for immutable bindings. Add `mut` to allow reassignment.

```sfn
let language = "Sailfin";     // immutable — cannot be reassigned
let mut count = 0;             // mutable
count = count + 1;             // OK

// language = "other";         // ERROR: cannot assign to immutable binding
```

Type inference works for all of these. You can add an explicit type annotation when you want to be precise or when inference cannot determine the type:

```sfn
let x: number = 42;
let ratio: number = 0.75;
let active: boolean = true;
let label: string = "processing";
```

**Primitive types at a glance:**

| Type | Description | Example |
|------|-------------|---------|
| `number` | 64-bit float (primary numeric type) | `42`, `3.14`, `-7` |
| `boolean` | Boolean | `true`, `false` |
| `string` | UTF-8 string | `"hello"` |

---

## Functions

A function declares its name, parameters, return type, and effects:

```sfn
fn add(a: number, b: number) -> number {
    return a + b;
}
```

`add` is a **pure function** — it has no effect annotation because it does not perform any side effects. Pure functions are deterministic, easy to test, and can be optimized aggressively.

Add an effect when the function needs one:

```sfn
fn greet(name: string) ![io] {
    print("Hello, {{name}}!");
}
```

The double-brace syntax `{{ expression }}` is Sailfin's string interpolation. Any expression can appear inside the braces.

```sfn
fn describe_temperature(celsius: number) -> string {
    return "{{celsius}}°C is {{celsius * 9.0 / 5.0 + 32.0}}°F";
}
```

A function that calls an effectful function must itself declare that effect:

```sfn
fn greet_twice(name: string) ![io] {
    greet(name);   // greet requires ![io], so this function must declare it too
    greet(name);
}
```

---

## Structs

Structs group related data together. Fields use `name: Type;` syntax:

```sfn
struct Point {
    x: number;
    y: number;
}
```

Create a struct literal by naming the fields:

```sfn
let origin: Point = Point { x: 0.0, y: 0.0 };
let p: Point = Point { x: 3.0, y: 4.0 };
```

Access fields with dot notation:

```sfn
print("x = {{p.x}}, y = {{p.y}}");
```

Methods are declared **inside the struct body**. The first parameter is
conventionally named `self` and receives the instance:

```sfn
struct Point {
    x: number;
    y: number;

    fn distance_from_origin(self) -> number {
        return math.sqrt(self.x * self.x + self.y * self.y);
    }

    fn describe(self) -> string {
        return "Point({{self.x}}, {{self.y}})";
    }
}

let p: Point = Point { x: 3.0, y: 4.0 };
let dist = p.distance_from_origin();    // 5.0
```

Constructor-style (static) methods omit `self` and can be called as
`TypeName.new(...)`:

```sfn
struct Point {
    x: number;
    y: number;

    fn new(x: number, y: number) -> Point {
        return Point { x: x, y: y };
    }

    fn origin() -> Point {
        return Point { x: 0.0, y: 0.0 };
    }
}

let origin = Point.origin();
let p = Point.new(3.0, 4.0);
```

---

## Enums

Enums represent a value that can be one of several variants. Simple enums work like named constants:

```sfn
enum Direction {
    North,
    South,
    East,
    West,
}

let heading = Direction.North;
```

Enum variants can carry data as named fields:

```sfn
enum Shape {
    Circle { radius: number },
    Rectangle { width: number, height: number },
    Triangle { base: number, height: number },
}

let c: Shape = Shape.Circle { radius: 5.0 };
let r: Shape = Shape.Rectangle { width: 3.0, height: 4.0 };
```

> **Current status:** Optional values today are written with the `T?` syntax
> (for example, `TreeNode?`) and handled via `null` checks or `match`. A
> `Result<T, E>` type with a `?` propagation operator is on the
> [roadmap](/roadmap) and is tracked in the 1.0 readiness checklist.

---

## Pattern Matching

`match` evaluates an expression against a series of patterns. It is exhaustive — the compiler ensures every possible variant is covered.

```sfn
fn area(shape: Shape) -> number {
    match shape {
        Shape.Circle { radius } => return 3.14159 * radius * radius,
        Shape.Rectangle { width, height } => return width * height,
        Shape.Triangle { base, height } => return 0.5 * base * height,
    }
}
```

If you add a new variant to `Shape` and forget to update `area`, the compiler
produces a non-exhaustive-match diagnostic.

Use guard conditions to add extra constraints on a matched pattern. Each arm is
followed by `=>` and either a single expression with `return`, or a block:

```sfn
fn classify_score(score: number) -> string {
    match score {
        s if s >= 90 => { return "A"; }
        s if s >= 80 => { return "B"; }
        s if s >= 70 => { return "C"; }
        s if s >= 60 => { return "D"; }
        _ => { return "F"; }
    }
}
```

Match on optional types (`T?`) to safely handle absent values:

```sfn
fn describe(user: User?) ![io] {
    match user {
        null => print.err("no user"),
        _ => print("Hello, {{user.name}}!"),
    }
}
```

---

## The Effect System

The effect system is Sailfin's defining feature. Every function that reaches outside of pure computation must declare what capabilities it uses. The six canonical effects are:

| Effect | Grants access to |
|--------|-----------------|
| `io` | Filesystem, console, print, logging |
| `net` | HTTP, WebSocket, network operations |
| `model` | AI model invocation |
| `gpu` | GPU and accelerator access |
| `rand` | Random number generation |
| `clock` | Timers, sleep, wall-clock time |

A function can declare multiple effects:

```sfn
fn fetch_and_log(url: string) -> string ![io, net] {
    let response = http.get(url);
    print("Status: {{response.status}}");
    return response.body;
}
```

**Effects are transitive.** If `A` calls `B`, then `A` must declare everything `B` declares. The compiler checks this at every call site.

```sfn
fn helper() ![io, net] {
    let _ = http.get("https://api.example.com");
    print("fetched");
}

// ERROR: missing ![net]
fn caller() ![io] {
    helper();
}
```

```
effects.missing: function `caller` calls `helper` which requires ![net],
                 but `caller` only declares ![io]
  = help: add `net` to the effect list: `fn caller() ![io, net]`
```

**Pure functions have no annotation at all.** They cannot call effectful code and they cannot produce side effects. This is a guarantee you can rely on.

```sfn
fn square(n: number) -> number {
    return n * n;    // pure — no effects possible
}
```

This design means you can look at any function signature and know immediately what it is capable of. A function that declares only `![rand]` cannot touch the filesystem. A function with no effects cannot do anything observable outside of returning a value.

---

## Generics

Generics let you write functions and types that work over any type that satisfies a constraint.

A generic function:

```sfn
fn first<T>(items: T[]) -> T? {
    if items.length == 0 {
        return null;
    }
    return items[0];
}

let n = first([1, 2, 3]);    // 1
let s = first(["a", "b"]);   // "a"
```

A generic struct:

```sfn
struct Pair<A, B> {
    first: A;
    second: B;
}

let coords = Pair<number, number> { first: 10, second: 20 };
let labeled = Pair<string, number> { first: "latitude", second: 51.5 };
```

Generics work with interfaces to express constraints — a generic function can
require that its type parameter implements a specific interface. Generic
constraints (`T: Interface`) are part of the
[roadmap](/roadmap) pre-1.0 work; today, generic functions accept any type and
rely on structural usage of methods inside the body:

```sfn
interface Displayable {
    fn display(self) -> string;
}

fn print_all<T>(items: T[]) ![io] {
    for item in items {
        print(item.display());
    }
}
```

---

## Error Handling

Sailfin has two complementary error handling mechanisms.

### Tagged-union return types

Model failure as part of a function's return type using a union (`T | Error`)
or an explicit enum. Callers use `match` to handle each case:

```sfn
struct DivisionError {
    message: string;
}

fn safe_divide(a: number, b: number) -> number | DivisionError {
    if b == 0 {
        return DivisionError { message: "Cannot divide by zero" };
    }
    return a / b;
}

fn main() ![io] {
    let result = safe_divide(10, 0);

    match result {
        DivisionError { message } => print("Error: {{message}}"),
        _ => print("Result: {{result}}"),
    }
}
```

> **Coming in 1.0:** A generic `Result<T, E>` type plus a `?` propagation
> operator are on the [roadmap](/roadmap) under the Syntax Reform track. Until
> they land, prefer the tagged-union pattern above for expected failures.

### `try/catch/finally` for exceptional conditions

Use `try/catch` for failures that are not part of normal operation and cannot
easily be threaded through return types:

```sfn
fn perform_risky_operation() -> void {
    throw "Simulated failure";
}

fn main() ![io] {
    try {
        perform_risky_operation();
    } catch (err) {
        print("Something went wrong: {{err}}");
    } finally {
        print("Shutting down cleanly.");
    }
}
```

`finally` runs whether or not an exception was thrown — useful for cleanup that
must happen regardless.

---

## Interfaces

An interface defines a set of methods that a type must provide. A struct
declares conformance inline with the `implements` keyword, and provides the
methods in its body:

```sfn
interface Serializable {
    fn to_json(self) -> string;
}

struct User implements Serializable {
    name: string;
    email: string;

    fn to_json(self) -> string {
        return "{\"name\":\"{{self.name}}\",\"email\":\"{{self.email}}\"}";
    }
}
```

A struct can implement multiple interfaces by listing them:

```sfn
struct Account implements Serializable, Auditable {
    // fields and methods satisfying both interfaces
}
```

Use an interface as a parameter type to write code that works with any
conforming type:

```sfn
fn write_record(record: Serializable, path: string) ![io] {
    let json = record.to_json();
    fs.write(path, json);
}
```

Now `write_record` works for `User`, `Order`, `Config`, or anything else that
implements `Serializable`.

---

## Testing

The `test` keyword is built into the language. No imports, no framework.

```sfn
fn add(a: number, b: number) -> number {
    return a + b;
}

test "add returns the correct sum" {
    assert add(2, 3) == 5;
    assert add(-1, 1) == 0;
    assert add(0, 0) == 0;
}
```

Run all tests:

```bash
sfn test
```

Tests declare effects just like functions. The compiler enforces capability discipline in test code too:

```sfn
test "config file can be read" ![io] {
    let content = fs.read("tests/fixtures/sample.toml");
    assert content.length > 0;
}
```

Test names are documentation. A good test name reads as a statement of fact about what the system does:

```sfn
test "parse_int returns Err on empty string" { ... }
test "Vec.push increases length by one" { ... }
test "HTTP client retries on 503" ![io, net] { ... }
```

See the [Testing guide](/docs/learn/testing) for patterns, organization, and integration testing.

---

## Type Safety Wrappers

Sailfin parses four special wrapper types that express stronger safety
guarantees. They are recognised by the parser today but **enforcement is
deferred to post-1.0** — treat them as documentation for the roadmap, not as
shipped safety features.

### `PII<T>` — Personally Identifiable Information

Marks a value as PII. Future runtime enforcement will require explicit
declassification before the value can be used in non-PII contexts, preventing
accidental logging or exposure.

```sfn
struct UserProfile {
    display_name: string;
    email: PII<string>;          // future: cannot be logged without declassification
    date_of_birth: PII<string>;
}
```

### `Secret<T>` — Secret values

Similar to `PII<T>` but for credentials and tokens.

```sfn
let api_key: Secret<string> = Secret.wrap("sk-abc123");
```

### `Affine<T>` — May be dropped, not duplicated

An affine type can be used zero or one times. It can be dropped, but it cannot
be copied or cloned.

```sfn
let handle: Affine<FileHandle> = fs.open("data.bin");
```

### `Linear<T>` — Must be consumed exactly once

A linear type is stronger: it must be consumed.

```sfn
let token: Linear<AuthToken> = auth.mint_token(user_id);
```

> **Current status**: `Affine<T>`, `Linear<T>`, `PII<T>`, and `Secret<T>` all
> parse and type-check, but none of the additional guarantees are enforced yet.
> See the [roadmap](/roadmap) for the post-1.0 sequencing. Sailfin's shipped
> safety story today is the effect system and capability-based capsules, not
> ownership or taint tracking.

---

## AI Integration (Future — Library-Based)

Sailfin gates AI operations through the effect system using the `![model]` effect, but AI constructs are being migrated from language-level syntax to the `sfn/ai` library capsule. This keeps the language grammar stable while letting AI integration iterate as a library.

### The `![model]` effect

Any function that interacts with an AI model must declare the `![model]` effect. This is enforced at compile time today:

```sfn
fn summarize(text: string) -> string ![model, io] {
    let result = ai.complete("Summarize: " + text);
    print(result);
    return result;
}
```

### Current status

> **Important**: The compiler currently parses `model`, `prompt`, `pipeline`, and `tool` blocks as language syntax and emits them to `.sfn-asm` IR, but **no runtime execution exists**. These constructs are being migrated to the `sfn/ai` capsule for post-1.0 delivery. The `![model]` effect annotation — the capability gate — remains a language-level feature and is enforced today.
>
> See the [roadmap](/roadmap) for the timeline on `sfn/ai` capsule delivery.

---

## Where to Go Next

You have seen every major feature of the language. Here is where to go deeper:

- **[Language Basics](/docs/learn/basics)** — Variables, control flow, loops, and collections in detail
- **[Functions & Methods](/docs/learn/functions)** — Closures, methods, and effect propagation
- **[Types & Structs](/docs/learn/types)** — Structs, enums, generics, and type aliases
- **[The Effect System](/docs/learn/effects)** — The complete capability model
- **[Ownership & Borrowing](/docs/learn/ownership)** — Memory safety without a garbage collector
- **[Error Handling](/docs/learn/error-handling)** — Result types, try/catch, and error design
- **[AI Integration](/docs/learn/ai-constructs)** — The `![model]` effect and the `sfn/ai` capsule (post-1.0)
- **[Testing](/docs/learn/testing)** — Built-in testing, test organization, and patterns
- **[Effective Sailfin](/docs/learn/effective-sailfin)** — Idioms and best practices
- **[Language Spec](/docs/reference/spec)** — Complete formal reference
