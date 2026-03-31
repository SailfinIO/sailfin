---
title: Functions & Methods
description: Declaring functions, effect signatures, generics, methods, closures, decorators, and async in Sailfin.
section: learn
order: 2
---

Functions are the unit of computation in Sailfin. They are first-class values, support generics, carry explicit effect annotations, and can be defined as methods on structs. This guide covers every form a function can take.

---

## Function Declarations

The basic form:

```sfn
fn add(a: Int, b: Int) -> Int {
    return a + b;
}
```

- Parameters use `name: Type` notation.
- The return type follows `->` after the parameter list.
- `return` exits the function with a value.

### Implicit Returns

The last expression in a function body (without a trailing semicolon) is automatically the return value. This is idiomatic Sailfin for short functions:

```sfn
fn square(n: Int) -> Int {
    n * n
}

fn max(a: Int, b: Int) -> Int {
    if a > b { a } else { b }
}
```

Both `return expr;` and the trailing expression form are valid — use whichever reads more clearly for the function. Long functions with multiple exit points typically benefit from explicit `return`.

### Void Functions

Functions that perform side effects and return nothing use `![effect]` annotations (covered in the next section) and omit the return type or write `-> void`:

```sfn
fn greet(name: String) ![io] {
    print("Hello, {{name}}!");
}
```

### Multiple Parameters

```sfn
fn format_name(first: String, last: String, title: String) -> String {
    "{{title}} {{first}} {{last}}"
}

let full = format_name("Jane", "Smith", "Dr.");
```

### Pure vs Effectful — Side by Side

A **pure function** has no effect annotations. It cannot read or write files, make network calls, access the clock, or invoke AI models. The compiler enforces this statically.

```sfn
// Pure — safe to call anywhere, easy to test, trivially parallelizable
fn clamp(value: Int, min: Int, max: Int) -> Int {
    if value < min { min }
    else if value > max { max }
    else { value }
}

// Effectful — declares exactly what it does
fn log_and_clamp(value: Int, min: Int, max: Int) -> Int ![io] {
    let result = clamp(value, min, max);
    print("clamped {{value}} -> {{result}}");
    result
}
```

Prefer pure functions wherever possible. Reserve effects for the boundary layers (entry points, I/O handlers, API clients).

---

## Effect Signatures

Every Sailfin function either is pure (no `![]`) or declares precisely which capabilities it exercises. This is not documentation — it is enforced by the compiler.

```sfn
fn read_config(path: String) -> String ![io] {
    fs.read(path)
}

fn fetch_price(symbol: String) -> Float ![net] {
    let resp = http.get("https://api.example.com/price/{{symbol}}");
    Float.parse(resp.body)
}

fn analyze(text: String) -> Summary ![model] {
    let result = prompt gpt4o ![model] {
        system "You are a precise analyst."
        user "Summarize the following:\n{{text}}"
    };
    result
}
```

The six canonical effects are:

| Effect | Grants access to |
|--------|-----------------|
| `io` | Filesystem (`fs.*`), console (`print`, `console.*`), logging, decorators like `@logExecution` |
| `net` | HTTP (`http.*`), WebSocket (`websocket.*`), `serve` |
| `model` | AI model invocation (`prompt` blocks) |
| `gpu` | GPU/accelerator operations, tensor compute |
| `rand` | Random number generation (`rand.*`) |
| `clock` | Wall clock, timers, `sleep` |

### Multiple Effects

Combine effects in a single annotation. Order does not matter:

```sfn
fn fetch_and_log(url: String) -> String ![io, net] {
    let resp = http.get(url);
    print("Status: {{resp.status}}");
    resp.body
}

fn run_experiment(prompt_text: String) ![io, model, clock] {
    let start = clock.now();
    let result = prompt gpt4o ![model] {
        user "{{prompt_text}}"
    };
    let elapsed = clock.now() - start;
    print("Completed in {{elapsed}}ms: {{result}}");
}
```

### Effect Enforcement

If function `A` directly calls an effectful API (like `fs.write` or `http.get`), `A` must declare the required effect. The compiler checks direct API usage — if you call a helper function `B` that uses `![io]`, you must also declare `![io]` on `A`:

```sfn
fn write_log(msg: String) ![io] {
    fs.appendFile("app.log", msg + "\n");
}

fn process(data: String) ![io] {
    // OK: process declares ![io], which covers write_log's requirement
    write_log("Processing: {{data}}");
}

// COMPILE ERROR — save() calls write_log() which needs ![io],
// but save() only declares ![net]
fn save(url: String, data: String) ![net] {
    let resp = http.post(url, data);
    write_log("Saved to {{url}}");    // ERROR: missing ![io]
}
```

### Compiler Fix-It Diagnostics

When a required effect is missing, the compiler produces a precise diagnostic with a suggested fix:

```
effects.missing: function `save` calls `write_log` which requires ![io],
                 but `save` only declares ![net]
  = help: add `io` to the effect list: `fn save(url: String, data: String) ![io, net]`
```

Apply the fix, recompile, and the error is gone. The compiler never guesses — it tells you exactly which call site is the problem and which effect to add.

### Effects in Tests

Test blocks also declare effects:

```sfn
test "reads and parses config" ![io] {
    let raw = fs.read("test/fixtures/config.toml");
    let config = Config.parse(raw);
    assert(config.host == "localhost");
}

test "pure addition" {
    // No effects declared — this test cannot call any effectful function
    assert(add(2, 3) == 5);
}
```

---

## Default Parameters

Functions can declare default values for trailing parameters. Callers may omit them:

```sfn
fn connect(host: String, port: Int = 8080, timeout_ms: Int = 5000) ![net] {
    http.connect(host, port, timeout_ms)
}

connect("localhost");                    // port=8080, timeout_ms=5000
connect("example.com", 443);            // port=443, timeout_ms=5000
connect("example.com", 443, 10_000);   // all explicit
```

Default parameters must come after all required parameters. You cannot skip a defaulted parameter to provide a later one by position — use named argument style in that case:

```sfn
connect("example.com", timeout_ms: 10_000);   // port stays at default 8080
```

---

## Generic Functions

Generic functions work over a family of types. The type parameter is declared in angle brackets after the function name:

```sfn
fn identity<T>(value: T) -> T {
    value
}

let n = identity(42);          // T inferred as Int
let s = identity("hello");     // T inferred as String
```

### Multiple Type Parameters

```sfn
fn zip<A, B>(a: Vec<A>, b: Vec<B>) -> Vec<(A, B)> {
    let mut result = Vec.new();
    let len = if a.len() < b.len() { a.len() } else { b.len() };
    for i in 0..len {
        result.push((a[i], b[i]));
    }
    result
}
```

### Type Bounds

Constrain a type parameter to only types that implement a specific interface. Use `:` after the type parameter name:

```sfn
interface Comparable {
    fn compare(&self, other: &Self) -> Int;
}

fn min<T: Comparable>(a: T, b: T) -> T {
    if a.compare(&b) <= 0 { a } else { b }
}
```

Multiple bounds use `+`:

```sfn
interface Printable {
    fn display(&self) -> String;
}

fn show_min<T: Comparable + Printable>(items: Vec<T>) ![io] {
    let m = items.reduce(items[0], |acc, x| min(acc, x));
    print(m.display());
}
```

### Real Examples: Map, Filter, Find

These patterns illustrate generic functions working with closures (covered in full below):

```sfn
fn map<T, U>(items: Vec<T>, f: fn(T) -> U) -> Vec<U> {
    let mut result = Vec.new();
    for item in items {
        result.push(f(item));
    }
    result
}

fn filter<T>(items: Vec<T>, pred: fn(&T) -> Bool) -> Vec<T> {
    let mut result = Vec.new();
    for item in items {
        if pred(&item) {
            result.push(item);
        }
    }
    result
}

fn find<T>(items: Vec<T>, pred: fn(&T) -> Bool) -> T? {
    for item in items {
        if pred(&item) {
            return Some(item);
        }
    }
    None
}
```

Usage:

```sfn
let numbers = [1, 2, 3, 4, 5, 6];
let doubled  = map(numbers, |n| n * 2);
let evens    = filter(numbers, |n| n % 2 == 0);
let first_gt3 = find(numbers, |n| *n > 3);
```

---

## Methods on Structs

Methods are functions associated with a struct type. They are defined inline in the struct body or in a separate `impl` block. Methods access the struct instance through `self`.

### Receiver Types

| Receiver | Meaning |
|----------|---------|
| `self` | Takes ownership of the instance (consumes it) |
| `&self` | Shared (read-only) borrow — can read fields, cannot mutate |
| `&mut self` | Exclusive mutable borrow — can read and write fields |

```sfn
struct Counter {
    mut value -> Int;
}

impl Counter {
    fn new() -> Counter {
        Counter { value: 0 }
    }

    fn current(&self) -> Int {
        self.value
    }

    fn increment(&mut self) {
        self.value += 1;
    }

    fn add(&mut self, n: Int) {
        self.value += n;
    }

    fn reset(&mut self) {
        self.value = 0;
    }
}
```

Usage:

```sfn
let mut c = Counter.new();
c.increment();
c.increment();
c.add(10);
print(c.current());    // 12
c.reset();
print(c.current());    // 0
```

### Static Methods (Constructors)

Methods with no receiver are called as `TypeName.method()`. The convention is to use `new` for the primary constructor:

```sfn
struct Point {
    x -> Float;
    y -> Float;
}

impl Point {
    fn new(x: Float, y: Float) -> Point {
        Point { x: x, y: y }
    }

    fn origin() -> Point {
        Point { x: 0.0, y: 0.0 }
    }

    fn distance(&self, other: &Point) -> Float {
        let dx = self.x - other.x;
        let dy = self.y - other.y;
        (dx * dx + dy * dy).sqrt()
    }

    fn translate(&mut self, dx: Float, dy: Float) {
        self.x += dx;
        self.y += dy;
    }
}

let mut p = Point.new(3.0, 4.0);
let o = Point.origin();
print(p.distance(&o));    // 5.0
p.translate(1.0, 0.0);
print(p.distance(&o));    // ~5.099
```

### Methods with Effects

Methods can declare effects just like free functions:

```sfn
impl Config {
    fn load(path: String) -> Config ![io] {
        let raw = fs.read(path);
        Config.parse(raw)
    }

    fn save(&self, path: String) ![io] {
        fs.write(path, self.serialize());
    }
}
```

---

## First-Class Functions

Functions are values in Sailfin. You can store them in variables, pass them as arguments, and return them from other functions.

### Function Types

The type of a function is written `fn(Param1, Param2, ...) -> ReturnType`:

```sfn
let op: fn(Int, Int) -> Int = add;
let result = op(3, 4);    // 7
```

### Passing Functions as Arguments

```sfn
fn apply_twice(f: fn(Int) -> Int, x: Int) -> Int {
    f(f(x))
}

fn double(n: Int) -> Int { n * 2 }

let result = apply_twice(double, 3);    // double(double(3)) = 12
```

### Returning Functions

```sfn
fn make_adder(n: Int) -> fn(Int) -> Int {
    |x| x + n
}

let add5 = make_adder(5);
print(add5(10));    // 15
print(add5(20));    // 25
```

---

## Closures and Lambdas

Closures are anonymous functions defined inline with `|params| body` syntax. They can capture bindings from the enclosing scope.

### Basic Syntax

```sfn
let double = |x: Int| x * 2;
let greet  = |name: String| "Hello, {{name}}!";

print(double(5));         // 10
print(greet("world"));    // "Hello, world!"
```

For a multi-statement body, use a block:

```sfn
let process = |item: String| {
    let trimmed = item.trim();
    let upper = trimmed.to_upper();
    "processed: {{upper}}"
};
```

### Type Inference in Closures

Parameter and return types are usually inferred from context:

```sfn
let numbers = [1, 2, 3, 4, 5];

let doubled = numbers.map(|n| n * 2);          // n: Int inferred
let evens   = numbers.filter(|n| n % 2 == 0);  // Bool return inferred
let sum     = numbers.reduce(0, |acc, n| acc + n);
```

### Capturing from Outer Scope

Closures capture variables from the enclosing scope. Captured bindings follow the same ownership rules as other uses — if the closure takes ownership, the binding is moved:

```sfn
let prefix = ">>>";

let annotate = |line: String| "{{prefix}} {{line}}";

let lines = ["one", "two", "three"];
let annotated = lines.map(annotate);
```

Capturing a mutable binding requires care — only one closure may hold a mutable reference at a time:

```sfn
let mut total = 0;

for n in numbers {
    total += n;    // direct mutation — no closure needed here
}

print(total);
```

### Closures in Sorting and Transformations

```sfn
let mut people = [
    Person { name: "Carol", age: 31 },
    Person { name: "Alice", age: 25 },
    Person { name: "Bob",   age: 28 },
];

// Sort by age
people.sort_by(|a, b| a.age - b.age);

// Sort by name
people.sort_by(|a, b| a.name.compare(&b.name));

// Extract names
let names = people.map(|p| p.name);
```

---

## Recursion

Sailfin functions can call themselves. The compiler does not automatically optimize tail calls yet — deeply recursive algorithms over large inputs should use iterative alternatives or an explicit stack.

### Simple Recursion

```sfn
fn factorial(n: Int) -> Int {
    if n <= 1 { 1 }
    else { n * factorial(n - 1) }
}

fn fibonacci(n: Int) -> Int {
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}
```

### Mutual Recursion

Two functions can call each other as long as both are declared before the call site, or forward declarations are available:

```sfn
fn is_even(n: Int) -> Bool {
    if n == 0 { true } else { is_odd(n - 1) }
}

fn is_odd(n: Int) -> Bool {
    if n == 0 { false } else { is_even(n - 1) }
}
```

### Recursive Data Structures

Recursion is natural for tree-shaped data:

```sfn
enum Tree<T> {
    Leaf(T),
    Node(T, Box<Tree<T>>, Box<Tree<T>>),
}

fn depth<T>(tree: &Tree<T>) -> Int {
    match tree {
        Leaf(_)           => 1,
        Node(_, l, r)     => {
            let ld = depth(l);
            let rd = depth(r);
            1 + if ld > rd { ld } else { rd }
        },
    }
}
```

---

## Decorators

Decorators apply metadata or behavior modifications to functions. They are written with `@` before the function declaration:

```sfn
@logExecution
fn compute(input: Vec<Float>) -> Float ![io] {
    input.reduce(0.0, |acc, x| acc + x)
}

@deprecated("Use compute_v2 instead")
fn compute_legacy(input: Vec<Float>) -> Float {
    input.reduce(0.0, |acc, x| acc + x)
}
```

Currently, decorators are **parsed and stored as metadata**. The `@logExecution` decorator requires `![io]` because the runtime logs entry and exit. The following decorators are recognized:

| Decorator | Effect required | Behavior |
|-----------|----------------|----------|
| `@logExecution` | `![io]` | Logs function entry and exit |
| `@deprecated(msg)` | none | Emits a compiler warning at call sites |
| `@inline` | none | Hint to inline the function at call sites |
| `@test` | varies | Marks a function as a test (prefer `test` blocks) |

Custom decorators are planned for a future release as part of the macro system.

---

## Async Functions

Declare an async function with `async fn`. Async functions return a `Future<T>` — a value that represents a computation that will complete later.

```sfn
async fn fetch_user(id: String) -> User ![net] {
    let resp = http.get("https://api.example.com/users/{{id}}");
    User.from_json(resp.body)
}
```

> **Note: `await` is not yet implemented.** The `async fn` syntax is parsed and included in the IR, but the `await` keyword and the async executor are planned features. Do not use `await` in current code — it will produce a compile error.

When `await` lands, the calling pattern will be:

```sfn
// PLANNED — not yet available
async fn load_dashboard(user_id: String) -> Dashboard ![net] {
    let user    = await fetch_user(user_id);
    let orders  = await fetch_orders(user_id);
    Dashboard { user: user, orders: orders }
}
```

For now, concurrent I/O is handled through synchronous calls with the `net` effect. See the [Concurrency](/docs/learn/concurrency) page for the current state of async and the `routine` primitive (also planned).

---

## Function Naming and Dispatch

Sailfin does not support traditional overloading — you cannot define two functions with the same name and different parameter types in the same scope. Instead:

**Use distinct names:**

```sfn
fn parse_int(s: String) -> Int { ... }
fn parse_float(s: String) -> Float { ... }
fn parse_bool(s: String) -> Bool { ... }
```

**Use generics when behavior is truly uniform across types:**

```sfn
fn parse<T: Parseable>(s: String) -> T {
    T.from_string(s)
}
```

**Use interface methods when types should define their own behavior:**

```sfn
interface FromString {
    fn from_string(s: String) -> Self;
}

impl FromString for Int {
    fn from_string(s: String) -> Int { Int.parse(s) }
}

impl FromString for Float {
    fn from_string(s: String) -> Float { Float.parse(s) }
}
```

### Named Arguments

Sailfin supports named arguments at the call site for any parameter. This is especially useful for boolean flags or when passing the same type multiple times:

```sfn
fn create_user(name: String, role: String, active: Bool) -> User { ... }

// Without named args — the reader must count parameters
let u1 = create_user("Alice", "admin", true);

// With named args — intent is clear
let u2 = create_user("Alice", role: "admin", active: true);
```

---

## Complete Example

This example pulls together effects, generics, methods, closures, and pattern matching:

```sfn
struct Pipeline<T> {
    steps -> Vec<fn(T) -> T>;
}

impl Pipeline<T> {
    fn new() -> Pipeline<T> {
        Pipeline { steps: Vec.new() }
    }

    fn add_step(&mut self, step: fn(T) -> T) {
        self.steps.push(step);
    }

    fn run(&self, input: T) -> T {
        self.steps.reduce(input, |acc, step| step(acc))
    }
}

fn normalize(s: String) -> String {
    s.trim().to_lower()
}

fn remove_punctuation(s: String) -> String {
    s.filter_chars(|c| c.is_alphanumeric() || c == ' ')
}

fn collapse_spaces(s: String) -> String {
    s.split(" ").filter(|w| w.len() > 0).join(" ")
}

fn clean_text(input: String) -> String {
    let mut pipe: Pipeline<String> = Pipeline.new();
    pipe.add_step(normalize);
    pipe.add_step(remove_punctuation);
    pipe.add_step(collapse_spaces);
    pipe.run(input)
}

test "text cleaning pipeline" {
    let result = clean_text("  Hello, World!!!  ");
    assert(result == "hello world");
}

fn main() ![io] {
    let raw = "  The Quick Brown Fox...  ";
    print(clean_text(raw));    // "the quick brown fox"
}
```

---

## Next Steps

- [Types & Structs](/docs/learn/types) — Defining custom types, enums, interfaces, and generics
- [The Effect System](/docs/learn/effects) — Deep dive into capability-based security and effect inference
- [Error Handling](/docs/learn/error-handling) — `try/catch`, result types, and propagation
- [Testing](/docs/learn/testing) — Writing unit and integration tests
- [Ownership & Borrowing](/docs/learn/ownership) — Move semantics, borrows, `Affine<T>`, and `Linear<T>`
