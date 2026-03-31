---
title: Tour of Sailfin
description: A guided introduction to every major Sailfin feature, from Hello World to AI constructs.
section: getting-started
order: 4
---

This tour walks through Sailfin's major features with short, working examples. By the end you will have a clear picture of what makes Sailfin different and how its features — effects, ownership, pattern matching, and AI constructs — fit together into a coherent language.

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

Structs group related data together. Fields use `name -> Type;` syntax:

```sfn
struct Point {
    x -> number;
    y -> number;
}
```

Create a struct literal by naming the fields:

```sfn
let origin = Point { x: 0.0, y: 0.0 };
let p = Point { x: 3.0, y: 4.0 };
```

Access fields with dot notation:

```sfn
print("x = {{p.x}}, y = {{p.y}}");
```

Add methods in an `impl` block:

```sfn
impl Point {
    fn distance_from_origin(&self) -> number {
        return (self.x * self.x + self.y * self.y).sqrt();
    }

    fn translate(&mut self, dx: number, dy: number) {
        self.x = self.x + dx;
        self.y = self.y + dy;
    }
}

let dist = p.distance_from_origin();    // 5.0
```

`&self` is a read-only borrow of the receiver. `&mut self` is a mutable borrow. Methods that only read prefer `&self`; methods that modify state take `&mut self`.

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

Enum variants can carry data:

```sfn
enum Shape {
    Circle { radius -> number },
    Rectangle { width -> number, height -> number },
    Triangle { base -> number, height -> number },
}

let c = Shape.Circle { radius: 5.0 };
let r = Shape.Rectangle { width: 3.0, height: 4.0 };
```

The standard `Option` and `Result` types are also enums:

```sfn
enum Option<T> {
    Some(T),
    None,
}

enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

---

## Pattern Matching

`match` evaluates an expression against a series of patterns. It is exhaustive — the compiler ensures every possible variant is covered.

```sfn
fn area(shape: Shape) -> number {
    match shape {
        Circle { radius }         => 3.14159 * radius * radius,
        Rectangle { width, height } => width * height,
        Triangle { base, height } => 0.5 * base * height,
    }
}
```

If you add a new variant to `Shape` and forget to update `area`, the compiler produces an error: _"match is not exhaustive: missing variant `Pentagon`"_.

Use guard conditions to add extra constraints on a matched pattern:

```sfn
fn classify_score(score: number) -> string {
    match score {
        s if s >= 90 => "A",
        s if s >= 80 => "B",
        s if s >= 70 => "C",
        s if s >= 60 => "D",
        _            => "F",
    }
}
```

Match on `Option` and `Result` to safely handle absent values and errors:

```sfn
fn greet_user(id: UserId) ![io] {
    match find_user(id) {
        Some(user) => print("Hello, {{user.name}}!"),
        None       => print.err("User {{id}} not found"),
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
fn first<T>(items: Array<T>) -> Option<T> {
    if items.length == 0 {
        return Option.None;
    }
    return Option.Some(items[0]);
}

let n = first([1, 2, 3]);    // Option.Some(1)
let s = first(["a", "b"]);   // Option.Some("a")
let e = first([]);            // Option.None
```

A generic struct:

```sfn
struct Pair<A, B> {
    first -> A;
    second -> B;
}

let coords = Pair { first: 10, second: 20 };
let labeled = Pair { first: "latitude", second: 51.5 };
```

Generics work with interfaces to express constraints — a generic function can require that its type parameter implements a specific interface:

```sfn
interface Displayable {
    fn display(&self) -> string;
}

fn print_all<T: Displayable>(items: Array<T>) ![io] {
    for item in items {
        print(item.display());
    }
}
```

---

## Error Handling

Sailfin has two complementary error handling mechanisms.

### `Result` for expected failures

Use `Result<T, E>` when failure is a normal part of a function's contract — something callers should handle:

```sfn
enum ParseError {
    EmptyInput,
    InvalidCharacter { pos -> number, char -> string },
    Overflow,
}

fn parse_int(s: string) -> Result<number, ParseError> {
    if s.length == 0 {
        return Result.Err(ParseError.EmptyInput);
    }
    // ...
}

match parse_int(input) {
    Ok(n)  => print("Parsed: {{n}}"),
    Err(ParseError.EmptyInput) => print.err("Input was empty"),
    Err(ParseError.Overflow)   => print.err("Number too large"),
    Err(ParseError.InvalidCharacter { pos, char }) =>
        print.err("Bad character '{{char}}' at position {{pos}}"),
}
```

### `try/catch/finally` for exceptional conditions

Use `try/catch` for failures that are not part of normal operation and cannot easily be threaded through return types:

```sfn
fn load_config(path: string) -> Config ![io] {
    try {
        let content = fs.read(path);
        return Config.parse(content);
    } catch (e: IoError) {
        print.err("Cannot read config at {{path}}: {{e.message}}");
        throw e;
    } finally {
        print("Config load attempted for {{path}}");
    }
}
```

`finally` runs whether or not an exception was thrown — useful for cleanup that must happen regardless.

---

## Interfaces

An interface defines a set of methods that a type must provide. Any struct that implements those methods satisfies the interface.

```sfn
interface Serializable {
    fn to_json(&self) -> string;
    fn from_json(s: string) -> Self;
}

struct User {
    name -> string;
    email -> string;
}

impl Serializable for User {
    fn to_json(&self) -> string {
        return "{\"name\":\"{{self.name}}\",\"email\":\"{{self.email}}\"}";
    }

    fn from_json(s: string) -> Self {
        // parse s and return a User
    }
}
```

Use an interface as a parameter type to write code that works with any conforming type:

```sfn
fn write_record<T: Serializable>(record: T, path: string) ![io] {
    let json = record.to_json();
    fs.write(path, json);
}
```

Now `write_record` works for `User`, `Order`, `Config`, or anything else that implements `Serializable`.

---

## Testing

The `test` keyword is built into the language. No imports, no framework.

```sfn
fn add(a: number, b: number) -> number {
    return a + b;
}

test "add returns the correct sum" {
    assert(add(2, 3) == 5);
    assert(add(-1, 1) == 0);
    assert(add(0, 0) == 0);
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
    assert(content.length > 0);
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

Sailfin provides four special wrapper types for expressing stronger safety guarantees. They parse and type-check today; enforcement of the stronger semantics is coming before 1.0.

### `PII<T>` — Personally Identifiable Information

Marks a value as PII. Future runtime enforcement will require explicit declassification before the value can be used in non-PII contexts, preventing accidental logging or exposure.

```sfn
struct UserProfile {
    display_name -> string;
    email -> PII<string>;          // cannot be logged without declassification
    date_of_birth -> PII<string>;
}
```

### `Secret<T>` — Secret values

Similar to `PII<T>` but for credentials and tokens. Prevents secrets from appearing in logs, error messages, or network responses.

```sfn
let api_key: Secret<string> = Secret.wrap("sk-abc123");
```

### `Affine<T>` — May be dropped, not duplicated

An affine type can be used zero or one times. It can be dropped (like a file you decide not to open), but it cannot be copied or cloned.

```sfn
let handle: Affine<FileHandle> = fs.open("data.bin");
// handle can be used once or dropped — never duplicated
```

### `Linear<T>` — Must be consumed exactly once

A linear type is stronger: it must be consumed. The compiler will eventually reject code that drops a `Linear<T>` without using it.

```sfn
let token: Linear<AuthToken> = auth.mint_token(user_id);
// token must be used exactly once — dropping it would be an error
```

These types encode resource management and security properties directly in the type system, where the compiler can check them instead of relying on runtime guards or programmer discipline.

> **Current status**: `Affine<T>` and `Linear<T>` are parsed and tracked but not yet enforced by the borrow checker. `PII<T>` and `Secret<T>` parse and carry metadata but runtime enforcement is planned for after 1.0.

---

## AI Constructs (Design Preview)

Sailfin treats AI as a first-class language concern, not a library. Model bindings, prompts, pipelines, and tools have dedicated syntax.

### Why first-class?

When AI is a library, the compiler cannot reason about it. When it is a language feature, the compiler can enforce that:

- Every model call declares `![model]`
- Prompts are well-formed at compile time
- Generation cards (provenance metadata) are automatically attached to every call
- Cost, latency, and seed are tracked structurally, not as ad-hoc logs

### Model bindings

Declare a model binding at the module level:

```sfn
model claude = anthropic:"claude-sonnet-4-20250514";
model gpt4o = openai:"gpt-4o";
```

### Prompt blocks

A `prompt` block composes a structured request to a model:

```sfn
fn summarize(text: string) -> string ![model] {
    let result = prompt claude ![model] {
        system "You are a concise summarizer. Respond in two to three sentences."
        user "Summarize the following:\n\n{{text}}"
    };
    return result;
}
```

String interpolation works inside prompt blocks. The `![model]` annotation on the `prompt` expression matches the one on the enclosing function — it is explicit about which capability is being used.

### Pipelines

A pipeline chains steps into a reusable unit, each step declaring its own effects:

```sfn
pipeline analyze_feedback {
    step classify(input: string) -> Category ![model] {
        return prompt claude ![model] {
            system "Classify this feedback as: positive, negative, or neutral."
            user "{{input}}"
        };
    }

    step extract_themes(input: string) -> Array<string> ![model] {
        return prompt claude ![model] {
            system "Extract the key themes from this feedback as a list."
            user "{{input}}"
        };
    }
}
```

### Tools

Tools expose Sailfin functions to models for function calling:

```sfn
tool lookup_user {
    description "Look up a user by their unique identifier"
    param id: string "The user ID to look up"

    fn execute(id: string) -> User ![io] {
        return db.find_user(id);
    }
}
```

### Current status

> **Important**: `model`, `prompt`, `pipeline`, and `tool` blocks are **parsed and syntactically validated** by the current compiler, but **model execution is not yet implemented**. Calls to `prompt` blocks do not send requests. This is planned for after the 1.0 release.
>
> The syntax is stable. Writing code with these constructs today will compile, and the code will work once execution support lands.

---

## Where to Go Next

You have seen every major feature of the language. Here is where to go deeper:

- **[Language Basics](/docs/learn/basics)** — Variables, control flow, loops, and collections in detail
- **[Functions & Methods](/docs/learn/functions)** — Closures, methods, and effect propagation
- **[Types & Structs](/docs/learn/types)** — Structs, enums, generics, and type aliases
- **[The Effect System](/docs/learn/effects)** — The complete capability model
- **[Ownership & Borrowing](/docs/learn/ownership)** — Memory safety without a garbage collector
- **[Error Handling](/docs/learn/error-handling)** — Result types, try/catch, and error design
- **[AI Constructs](/docs/learn/ai-constructs)** — Models, prompts, pipelines, and tools
- **[Testing](/docs/learn/testing)** — Built-in testing, test organization, and patterns
- **[Effective Sailfin](/docs/learn/effective-sailfin)** — Idioms and best practices
- **[Language Spec](/docs/reference/spec)** — Complete formal reference
