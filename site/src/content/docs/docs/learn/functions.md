---
title: Functions & Methods
description: Declaring functions, effect signatures, generics, methods, closures, decorators, and async in Sailfin.
section: learn
sidebar:
  order: 2
---

Functions are the unit of computation in Sailfin. They are first-class values, support generics, carry explicit effect annotations, and can be defined as methods on structs. This guide covers every form a function can take.

---

## Function Declarations

The basic form:

```sfn
fn add(a: number, b: number) -> number {
    return a + b;
}
```

- Parameters use `name: Type` notation.
- The return type follows `->` after the parameter list.
- `return` exits the function with a value.

> `number` is Sailfin's single numeric type today. Separate `int` (i64) and `float` (f64) types are on the [roadmap](/roadmap).

### Explicit Returns

Every function body uses an explicit `return` statement to yield a value. Short helpers still need the keyword:

```sfn
fn square(n: number) -> number {
    return n * n;
}

fn max(a: number, b: number) -> number {
    if a > b {
        return a;
    }
    return b;
}
```

### Void Functions

Functions that perform side effects and return nothing use `![effect]` annotations (covered in the next section) and omit the return type or write `-> void`:

```sfn
fn greet(name: string) ![io] {
    print("Hello, {{name}}!");
}
```

### Multiple Parameters

```sfn
fn format_name(first: string, last: string, title: string) -> string {
    return "{{title}} {{first}} {{last}}";
}

let full = format_name("Jane", "Smith", "Dr.");
```

### Pure vs Effectful — Side by Side

A **pure function** has no effect annotations. It cannot read or write files, make network calls, access the clock, or invoke AI models. The compiler enforces this statically.

```sfn
// Pure — safe to call anywhere, easy to test, trivially parallelizable
fn clamp(value: number, min: number, max: number) -> number {
    if value < min {
        return min;
    }
    if value > max {
        return max;
    }
    return value;
}

// Effectful — declares exactly what it does
fn log_and_clamp(value: number, min: number, max: number) -> number ![io] {
    let result = clamp(value, min, max);
    print("clamped {{value}} -> {{result}}");
    return result;
}
```

Prefer pure functions wherever possible. Reserve effects for the boundary layers (entry points, I/O handlers, API clients).

---

## Effect Signatures

Every Sailfin function either is pure (no `![]`) or declares precisely which capabilities it exercises. This is not documentation — it is enforced by the compiler.

```sfn
fn read_config(path: string) -> string ![io] {
    return fs.read(path);
}

fn fetch_price(symbol: string) -> number ![net] {
    let resp = http.get("https://api.example.com/price/{{symbol}}");
    return number.parse(resp.body);
}

fn analyze(text: string) -> string ![model] {
    // Call into the `sfn/ai` capsule; the ![model] effect is the capability gate.
    return ai.complete("gpt4o", text);
}
```

> Language-level `prompt`/`model`/`tool` blocks are being migrated to the
> `sfn/ai` capsule. The `![model]` effect stays as the compile-time capability
> gate. See the [roadmap](/roadmap).

The six canonical effects are:

| Effect | Grants access to |
|--------|-----------------|
| `io` | Filesystem (`fs.*`), console (`print`, `console.*`), logging, decorators like `@logExecution` |
| `net` | HTTP (`http.*`), WebSocket (`websocket.*`), `serve` |
| `model` | AI model invocation (`sfn/ai` capsule) |
| `gpu` | GPU/accelerator operations, tensor compute |
| `rand` | Random number generation (`rand.*`) |
| `clock` | Wall clock, timers, `sleep` |

### Multiple Effects

Combine effects in a single annotation. Order does not matter:

```sfn
fn fetch_and_log(url: string) -> string ![io, net] {
    let resp = http.get(url);
    print("Status: {{resp.status}}");
    return resp.body;
}

fn run_experiment(prompt_text: string) ![io, model, clock] {
    let start = clock.now();
    let result = ai.complete("gpt4o", prompt_text);
    let elapsed = clock.now() - start;
    print("Completed in {{elapsed}}ms: {{result}}");
}
```

### Effect Enforcement

If function `A` directly calls an effectful API (like `fs.write` or `http.get`), `A` must declare the required effect. The compiler checks direct API usage — if you call a helper function `B` that uses `![io]`, you must also declare `![io]` on `A`:

```sfn
fn write_log(msg: string) ![io] {
    fs.appendFile("app.log", msg + "\n");
}

fn process(data: string) ![io] {
    // OK: process declares ![io], which covers write_log's requirement
    write_log("Processing: {{data}}");
}

// COMPILE ERROR — save() calls write_log() which needs ![io],
// but save() only declares ![net]
fn save(url: string, data: string) ![net] {
    let resp = http.post(url, data);
    write_log("Saved to {{url}}");    // ERROR: missing ![io]
}
```

### Compiler Fix-It Diagnostics

When a required effect is missing, the compiler produces a precise diagnostic with a suggested fix:

```
effects.missing: function `save` calls `write_log` which requires ![io],
                 but `save` only declares ![net]
  = help: add `io` to the effect list: `fn save(url: string, data: string) ![io, net]`
```

Apply the fix, recompile, and the error is gone. The compiler never guesses — it tells you exactly which call site is the problem and which effect to add.

### Effects in Tests

Test blocks also declare effects:

```sfn
test "reads and parses config" ![io] {
    let raw = fs.read("test/fixtures/config.toml");
    let config = Config.parse(raw);
    assert config.host == "localhost";
}

test "pure addition" {
    // No effects declared — this test cannot call any effectful function
    assert add(2, 3) == 5;
}
```

---

## Default Parameters

Functions can declare default values for trailing parameters. Callers may omit them:

```sfn
fn connect(host: string, port: number = 8080, timeout_ms: number = 5000) ![net] {
    return http.connect(host, port, timeout_ms);
}

connect("localhost");                    // port=8080, timeout_ms=5000
connect("example.com", 443);            // port=443, timeout_ms=5000
connect("example.com", 443, 10000);     // all explicit
```

Default parameters must come after all required parameters. You cannot skip a defaulted parameter to provide a later one by position — use named argument style in that case:

```sfn
connect("example.com", timeout_ms: 10000);   // port stays at default 8080
```

---

## Generic Functions

Generic functions work over a family of types. The type parameter is declared in angle brackets after the function name:

```sfn
fn identity<T>(value: T) -> T {
    return value;
}

let n = identity(42);          // T inferred as number
let s = identity("hello");     // T inferred as string
```

### Multiple Type Parameters

```sfn
fn pair<A, B>(a: A, b: B) -> (A, B) {
    return (a, b);
}

let p = pair(1, "one");
```

### Type Bounds

> Generic type bounds (`T: Interface`) are on the [roadmap](/roadmap) and not yet accepted by the parser. For now, write monomorphic helpers or use concrete types; once bounds ship, the intent is:

```sfn
// PLANNED — not yet available
interface Comparable {
    fn compare(self, other: Comparable) -> number;
}

fn min<T: Comparable>(a: T, b: T) -> T {
    if a.compare(b) <= 0 {
        return a;
    }
    return b;
}
```

See the [roadmap](/roadmap) for the generic bounds workstream.

### Real Examples: Map, Filter, Find

These patterns illustrate higher-order functions working with Sailfin's lambda syntax:

```sfn
fn main() ![io] {
    let numbers = [1, 2, 3, 4, 5];

    let squares = numbers.map(fn(x) -> number { return x * x; });
    let sum = squares.reduce(0, fn(acc, x) -> number { return acc + x; });

    print("Sum of squares: {{sum}}"); // Outputs: 55
}
```

You can also pass a named function where a function value is expected:

```sfn
fn double(x: number) -> number {
    return x * 2;
}

fn apply(value: number, transformer: (number) -> number) -> number {
    return transformer(value);
}

fn main() ![io] {
    let result = apply(5, double);
    print("Result: {{result}}");
}
```

---

## Methods on Structs

Methods are functions associated with a struct type. They are defined **inline inside the struct body** — Sailfin has no separate `impl` block today. Methods access the struct instance through a bare `self` first parameter.

> Ownership receivers (`&self`, `&mut self`, `Affine<T>`, `Linear<T>`) are parsed but not enforced. The borrow/ownership story is deferred to post-1.0 and is on the [roadmap](/roadmap). Until then, all methods take `self` by value.

```sfn
struct Counter {
    value: number;

    fn new() -> Counter {
        return Counter { value: 0 };
    }

    fn current(self) -> number {
        return self.value;
    }

    fn increment(self) {
        self.value = self.value + 1;
    }

    fn add(self, n: number) {
        self.value = self.value + n;
    }

    fn reset(self) {
        self.value = 0;
    }
}
```

Usage:

```sfn
let c: Counter = Counter.new();
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
    x: number;
    y: number;

    fn new(x: number, y: number) -> Point {
        return Point { x: x, y: y };
    }

    fn origin() -> Point {
        return Point { x: 0.0, y: 0.0 };
    }

    fn distance(self, other: Point) -> number {
        let dx = self.x - other.x;
        let dy = self.y - other.y;
        return math.sqrt(dx * dx + dy * dy);
    }

    fn translate(self, dx: number, dy: number) {
        self.x = self.x + dx;
        self.y = self.y + dy;
    }
}

let p: Point = Point.new(3.0, 4.0);
let o: Point = Point.origin();
print(p.distance(o));    // 5.0
p.translate(1.0, 0.0);
print(p.distance(o));    // ~5.099
```

### Methods with Effects

Methods can declare effects just like free functions:

```sfn
struct Config {
    host: string;
    port: number;

    fn load(path: string) -> Config ![io] {
        let raw = fs.read(path);
        return Config.parse(raw);
    }

    fn save(self, path: string) ![io] {
        fs.write(path, self.serialize());
    }
}
```

---

## First-Class Functions

Functions are values in Sailfin. You can store them in variables, pass them as arguments, and return them from other functions.

### Function Types

The type of a function is written `(Param1, Param2, ...) -> ReturnType`:

```sfn
let op: (number, number) -> number = add;
let result = op(3, 4);    // 7
```

### Passing Functions as Arguments

```sfn
fn apply_twice(f: (number) -> number, x: number) -> number {
    return f(f(x));
}

fn double(n: number) -> number {
    return n * 2;
}

let result = apply_twice(double, 3);    // double(double(3)) = 12
```

### Returning Functions

> Closures that capture values from the enclosing scope are on the [roadmap](/roadmap). Today a lambda can reference values that are already in scope, but capturing mutable state across calls is not yet guaranteed. When closure capture ships, a curried adder looks like this:

```sfn
// PLANNED — depends on closure capture
fn make_adder(n: number) -> (number) -> number {
    return fn(x: number) -> number { return x + n; };
}

let add5 = make_adder(5);
print(add5(10));    // 15
print(add5(20));    // 25
```

---

## Closures and Lambdas

Anonymous functions are written with the same `fn` keyword as named functions — there is no `|x| body` pipe-closure syntax in Sailfin. A lambda is simply an `fn` literal you can store in a variable, pass as an argument, or return from another function.

### Basic Syntax

```sfn
let double = fn(x: number) -> number { return x * 2; };
let greet  = fn(name: string) -> string { return "Hello, {{name}}!"; };

print(double(5));         // 10
print(greet("world"));    // "Hello, world!"
```

For a multi-statement body, use additional statements inside the block:

```sfn
let process = fn(item: string) -> string {
    let trimmed = item.trim();
    let upper = trimmed.to_upper();
    return "processed: {{upper}}";
};
```

### Lambdas in map / filter / reduce

```sfn
let numbers = [1, 2, 3, 4, 5];

let doubled = numbers.map(fn(n) -> number { return n * 2; });
let evens   = numbers.filter(fn(n) -> boolean { return n % 2 == 0; });
let sum     = numbers.reduce(0, fn(acc, n) -> number { return acc + n; });
```

### Capturing from Outer Scope

> Closures that capture enclosing variables are on the [roadmap](/roadmap). Today a lambda can reference values that are already in scope during a single synchronous call (for example, inside `map`/`filter`/`reduce`), but storing a closure that keeps mutable state across calls is not yet guaranteed.

For mutation across iterations, use an explicit loop rather than a closure:

```sfn
let mut total: number = 0;

for n in numbers {
    total = total + n;
}

print(total);
```

### Lambdas in Sorting and Transformations

```sfn
let people = [
    Person { name: "Carol", age: 31 },
    Person { name: "Alice", age: 25 },
    Person { name: "Bob",   age: 28 },
];

// Sort by age
people.sort_by(fn(a, b) -> number { return a.age - b.age; });

// Extract names
let names = people.map(fn(p) -> string { return p.name; });
```

---

## Recursion

Sailfin functions can call themselves. The compiler does not automatically optimize tail calls yet — deeply recursive algorithms over large inputs should use iterative alternatives or an explicit stack.

### Simple Recursion

```sfn
fn factorial(n: number) -> number {
    if n <= 1 {
        return 1;
    }
    return n * factorial(n - 1);
}

fn fibonacci(n: number) -> number {
    match n {
        0: return 0,
        1: return 1,
        _: return fibonacci(n - 1) + fibonacci(n - 2),
    }
}
```

### Mutual Recursion

Two functions can call each other as long as both are declared before the call site, or forward declarations are available:

```sfn
fn is_even(n: number) -> boolean {
    if n == 0 {
        return true;
    }
    return is_odd(n - 1);
}

fn is_odd(n: number) -> boolean {
    if n == 0 {
        return false;
    }
    return is_even(n - 1);
}
```

### Recursive Data Structures

Recursion is natural for tree-shaped data. Self-referential fields use the nullable type operator `T?`:

```sfn
struct TreeNode {
    value: number;
    left: TreeNode?;
    right: TreeNode?;
}

fn depth(node: TreeNode?) -> number {
    if node == null {
        return 0;
    }
    let ld = depth(node.left);
    let rd = depth(node.right);
    if ld > rd {
        return 1 + ld;
    }
    return 1 + rd;
}
```

---

## Decorators

Decorators apply metadata or behavior modifications to functions. They are written with `@` before the function declaration:

```sfn
@logExecution
fn compute(input: number[]) -> number ![io] {
    return input.reduce(0.0, fn(acc, x) -> number { return acc + x; });
}

@deprecated("Use compute_v2 instead")
fn compute_legacy(input: number[]) -> number {
    return input.reduce(0.0, fn(acc, x) -> number { return acc + x; });
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
async fn fetch_user(id: string) -> User ![net] {
    let resp = http.get("https://api.example.com/users/{{id}}");
    return User.from_json(resp.body);
}
```

`async fn` and `await` are both shipped. Awaiting a future unwraps its value:

```sfn
async fn load_dashboard(user_id: string) -> Dashboard ![net] {
    let user_future   = fetch_user(user_id);
    let orders_future = fetch_orders(user_id);

    let user   = await user_future;
    let orders = await orders_future;
    return Dashboard { user: user, orders: orders };
}
```

Structured concurrency primitives such as `routine`, `spawn`, and `channel`
are on the [roadmap](/roadmap). See the [Concurrency](/docs/learn/concurrency)
page for the current state and the `routine` keyword preview.

---

## Function Naming and Dispatch

Sailfin does not support traditional overloading — you cannot define two functions with the same name and different parameter types in the same scope. Instead:

**Use distinct names:**

```sfn
fn parse_int(s: string) -> number { ... }
fn parse_float(s: string) -> number { ... }
fn parse_bool(s: string) -> boolean { ... }
```

**Use generics when behavior is truly uniform across types:**

```sfn
// PLANNED — generic bounds are on the /roadmap.
// Today, write a monomorphic helper per type, or accept the value by concrete type.
fn parse<T: Parseable>(s: string) -> T {
    return T.from_string(s);
}
```

**Use interface methods when types should define their own behavior.** Interfaces are implemented inline on structs with `implements` — there is no separate `impl Trait for Type` block:

```sfn
interface FromString {
    fn from_string(s: string) -> FromString;
}

struct Version implements FromString {
    major: number;
    minor: number;

    fn from_string(s: string) -> Version {
        // parse "major.minor"
        let parts = s.split(".");
        return Version { major: number.parse(parts[0]), minor: number.parse(parts[1]) };
    }
}
```

### Named Arguments

Sailfin supports named arguments at the call site for any parameter. This is especially useful for boolean flags or when passing the same type multiple times:

```sfn
fn create_user(name: string, role: string, active: boolean) -> User { ... }

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
    steps: ((T) -> T)[];

    fn new() -> Pipeline<T> {
        return Pipeline<T> { steps: [] };
    }

    fn add_step(self, step: (T) -> T) {
        self.steps.append(step);
    }

    fn run(self, input: T) -> T {
        let mut acc: T = input;
        for step in self.steps {
            acc = step(acc);
        }
        return acc;
    }
}

fn normalize(s: string) -> string {
    return s.trim().to_lower();
}

fn collapse_spaces(s: string) -> string {
    return s.split(" ").filter(fn(w) -> boolean { return w.length > 0; }).join(" ");
}

fn clean_text(input: string) -> string {
    let pipe: Pipeline<string> = Pipeline.new();
    pipe.add_step(normalize);
    pipe.add_step(collapse_spaces);
    return pipe.run(input);
}

test "text cleaning pipeline" {
    let result = clean_text("  Hello   World  ");
    assert result == "hello world";
}

fn main() ![io] {
    let raw = "  The Quick Brown Fox  ";
    print(clean_text(raw));    // "the quick brown fox"
}
```

---

## Next Steps

- [Types & Structs](/docs/learn/types) — Defining custom types, enums, interfaces, and generics
- [The Effect System](/docs/learn/effects) — Deep dive into capability-based security and effect inference
- [Error Handling](/docs/learn/error-handling) — `try/catch`, result types, and propagation
- [Testing](/docs/learn/testing) — Writing unit and integration tests
- [Ownership & Borrowing](/docs/learn/ownership) — Move semantics, borrows, `Affine<T>`, and `Linear<T>` (parsed today, enforcement on the [roadmap](/roadmap))
