---
title: The Effect System
description: A comprehensive guide to Sailfin's capability-based effect system — declaring effects, transitive enforcement, pure functions, diagnostics, and design patterns.
section: learn
sidebar:
  order: 4
---

Every function in Sailfin tells you — and the compiler — exactly what it is allowed to do. A function that reads a file must declare `![io]`. A function that makes an HTTP request must declare `![net]`. A function with no effect annotation is **guaranteed pure**: it cannot touch the filesystem, the network, a random number generator, or the clock. This guarantee is enforced at compile time based on direct usage of effectful operations.

This is Sailfin's effect system: a lightweight, compile-time capability mechanism that makes side effects explicit, auditable, and composable.

---

## What the Effect System Is

An effect is a named capability — a category of operation that reaches outside the pure computational model. In Sailfin, effects are declared on function signatures with the `![...]` annotation:

```sfn
fn read_config(path: string) -> string ![io] {
    return fs.read(path);
}
```

The `![io]` declares that `read_config` may perform I/O. The compiler enforces that any function which directly calls an effectful operation must declare the corresponding effect. Call-graph–transitive enforcement (where every caller of `read_config` must also declare `![io]`) is planned for a future release.

### Why this matters

- **Auditability**: You can look at any function signature and know immediately what capabilities it uses. No hidden side effects.
- **Testability**: Pure functions (no effects) are trivially testable — they have no setup or teardown, no mocking needed, and always return the same output for the same input.
- **Security**: Capability-based reasoning lets you audit data flows. If a function does not declare `![net]`, you know for certain it cannot exfiltrate data over the network.
- **Composability**: Effects compose via union. A function that calls both `![io]` and `![net]` helpers declares `![io, net]`. No surprises.

### How Sailfin compares to other languages

| Language | Mechanism | Compile-time? | Transitive? |
|----------|-----------|:---:|:---:|
| Sailfin | `![effect]` annotations | Yes | Planned (direct usage today) |
| Java | Checked exceptions | Yes | Yes (but fragile) |
| Rust | `unsafe`, `Send`/`Sync` | Partial | Partial |
| Haskell | `IO` monad | Yes | Yes (explicit) |
| Go, Python, JS | None | No | No |

Sailfin's system is closest to Haskell's `IO` monad in intent, but uses a flat list of named capabilities rather than monadic types — which means you write ordinary-looking functions and add `![io]` annotations, rather than wrapping everything in `IO<T>`.

Java's checked exceptions are also transitive, but they are limited to exception types and have well-known composability problems (checked exceptions on interfaces are painful). Sailfin effects are composable by union and do not require interface methods to list throws clauses.

---

## The Six Canonical Effects

| Effect | Grants access to | Example operations | Enforced today |
|--------|-----------------|-------------------|:--------------:|
| `io` | Filesystem, console, logging | `fs.read`, `fs.write`, `print()`, `print.err()`, `console.*`, `@logExecution` | Yes |
| `net` | Network I/O | `http.get`, `http.post`, `websocket.*`, `serve` | Yes |
| `model` | AI library invocation (`sfn/ai`, post-1.0) | Library functions carrying `![model]` (e.g., from `sfn/ai`) | Yes — required for any callee that declares `![model]` |
| `clock` | Wall-clock and sleep | `sleep(ms)`, `runtime.sleep(ms)` | Partial — `sleep`/`runtime.sleep` checked; hierarchical names not yet enforced |
| `gpu` | GPU and accelerator access | Tensor operations, `@gpu` blocks | Parsed only — not validated |
| `rand` | Random number generation | `rand.int()`, `rand.float()`, `rand.shuffle()` | Parsed only — not validated |

"Parsed only" means the compiler accepts the annotation in the source without error but does not (yet) verify that every call to a rand or GPU operation is properly guarded by an `![rand]` or `![gpu]` declaration. Full enforcement for these effects is planned before 1.0.

---

## Declaring Effects

Effects are declared with `![...]` syntax. By default, place them after the return type: `fn f(...) -> T ![effects] { ... }`. The parser also accepts the alternate `fn f(...) ![effects] -> T { ... }` ordering, and for functions without a return type you write them after the parameter list, before the function body: `fn f(...) ![effects] { ... }`.

### Single effect

```sfn
fn write_log(message: string) ![io] {
    fs.append("app.log", message);
}
```

### Multiple effects

List them comma-separated inside `![]`:

```sfn
fn fetch_and_log(url: string) -> string ![io, net] {
    let body = http.get(url);
    print("Fetched {{body.length}} bytes from {{url}}");
    return body;
}
```

### With a return type

By default, the effect annotation goes after the return type: `fn f(...) -> T ![effects] { ... }`. The parser also accepts effects before `->`. The conventional style is effects after the return type:

```sfn
fn load_user(id: number) -> User ![io, net] {
    let row = db.query("SELECT * FROM users WHERE id = {{id}}");
    return User.from_row(row);
}
```

### All six effects together (unusual but valid)

```sfn
fn full_pipeline(input: string) -> Report ![io, net, model, clock, gpu, rand] {
    // hypothetical function that legitimately uses every capability
}
```

---

## Pure Functions

A function with no `![]` annotation is **pure**. The compiler enforces this: calling any effectful function from a pure function is a compile-time error.

```sfn
// Pure — no effects declared, no effects allowed
fn add(a: number, b: number) -> number {
    return a + b;
}

fn clamp(value: number, low: number, high: number) -> number {
    if value < low  { return low; }
    if value > high { return high; }
    return value;
}

fn format_currency(amount: number) -> string {
    return "${{amount}}";
}
```

Pure functions are the best kind of function. They are easy to test, easy to reason about, and safe to call from any context — effectful or not. The effect system gives you a compile-time guarantee that `add` will never do anything except add two numbers.

### Separating pure logic from effects

A key design pattern in Sailfin is to push side effects to the edges of your program and keep the business logic pure. See [Effect Minimization as a Design Pattern](#effect-minimization-as-a-design-pattern) for detailed examples.

---

## Transitive Enforcement

> **Status**: Call-graph–transitive enforcement (where a caller must declare every effect that a callee declares) is **planned** but not yet implemented. Today the compiler checks that functions which directly call effectful operations (filesystem, print, HTTP, `prompt`, etc.) declare the appropriate effect. The examples below show the intended behavior once transitive enforcement ships.

Effects are designed to propagate through the call graph. If function `A` calls function `B`, and `B` declares `![io]`, then `A` should also declare at least `![io]`.

### Example: missing effect (future behavior)

```sfn
fn fetch_data(url: string) -> string ![net] {
    return http.get(url);
}

// Planned: fetch_data requires ![net], but process only declares ![io]
fn process(url: string) -> string ![io] {
    let raw = fetch_data(url);   // will be a compile error once transitive checking is enforced
    return raw.trim();
}
```

Expected compiler output (once transitive enforcement is implemented):

```
error[effects.missing]: function `process` uses `![net]` operation but does not declare net
  --> src/main.sfn:8:15
   |
   = hint: add `net` to the effect list of `process`
```

### Example: the fix

```sfn
fn process(url: string) -> string ![io, net] {
    let raw = fetch_data(url);
    print("Processing response...");
    return raw.trim();
}
```

### Multi-level propagation

Effects propagate across as many call levels as needed:

```sfn
fn read_file(path: string) -> string ![io] {
    return fs.read(path);
}

fn parse_config(path: string) -> Config ![io] {
    let text = read_file(path);         // OK: both declare ![io]
    return Config.parse(text);
}

fn init_app(config_path: string) -> App ![io] {
    let config = parse_config(config_path);  // OK: both declare ![io]
    return App.new(config);
}

fn main() ![io] {
    let app = init_app("app.toml");
    app.run();
}
```

Every function in the chain declares `![io]`. If you remove the annotation from any intermediate function, the compiler catches it immediately.

---

## Effects in Tests

Tests use the same `![...]` annotation syntax. A test block that calls effectful code must declare those effects:

```sfn
test "pure arithmetic" {
    // No effects — pure test
    assert add(2, 3) == 5;
    assert clamp(1.5, 0.0, 1.0) == 1.0;
}

test "reads a config file" ![io] {
    let config = parse_config("tests/fixtures/sample.toml");
    assert config.host == "localhost";
    assert config.port == 5432;
}

test "fetches from API" ![io, net] {
    let response = http.get("https://httpbin.org/get");
    assert response.status == 200;
}
```

The effect requirement on tests is intentional: it makes it visible at a glance which tests are pure unit tests and which require I/O, network access, or other infrastructure. Pure tests run everywhere and always; effectful tests may need environment setup.

---

---

## Effects in Lambdas and Closures

Closures capture the effect context of their enclosing scope. A lambda used inside an `![io]` function may call I/O operations; a lambda used inside a pure function may not.

```sfn
fn process_files(paths: string[]) ![io] {
    // This lambda is used in an ![io] context — it can call fs.read
    let contents = paths.map(fn(path: string) -> string { return fs.read(path); });
    for content in contents {
        print(content);
    }
}
```

If a closure escapes its declaring scope and is stored for later invocation in a different effect context, the compiler will verify that the closure's effects are compatible with the use site. In practice, most closures are used immediately (passed to `map`, `filter`, etc.) and inherit the surrounding effect context naturally.

---

## Compiler Diagnostics

The effect checker produces diagnostics when a required effect is missing. Diagnostics use the code `effects.missing` and include a fix-it hint showing what to add to the function signature.

> **Note:** Effect diagnostics are currently spanless — they report the function name and missing effect but do not yet include a precise source line/column pointer. Source span support is planned.

### Missing effect on a direct call

```
effects.missing: function `save_report` calls `fs.write` which requires ![io],
                 but `save_report` declares no effects
  = help: add `io` to the function signature: `fn save_report(content: string) ![io]`
```

### Missing effect from a callee

```
effects.missing: function `run_query` calls `http.post` which requires ![net],
                 but `run_query` only declares ![io]
  = help: add `net` to the effect list: `fn run_query(...) ![io, net]`
```

### How to read the diagnostic

- **Diagnostic code** `effects.missing` identifies the class of problem (effect violation).
- **Fix-it hint** shows exactly what to add to the signature. In most cases you can copy the suggestion directly.

---

## Effect Minimization as a Design Pattern

The most important pattern the effect system enables is **separating pure logic from effectful operations**. Keep business logic in pure functions; push I/O, network, and randomness to thin wrappers at the edges.

### Before: mixed concerns

```sfn
// Hard to test — requires a real database and HTTP connection
fn process_order(order_id: string) -> boolean ![io, net] {
    let raw = http.get("https://api.example.com/orders/{{order_id}}");
    let order = Order.parse(raw);
    if order.total > 1000.0 {
        print("High-value order: {{order_id}}");
        fs.append("high_value.log", order_id);
    }
    let discount = order.total * 0.1;
    http.post("https://api.example.com/orders/{{order_id}}/discount",
              "{{discount}}");
    return true;
}
```

### After: pure core, thin effectful shell

```sfn
// Pure business logic — easily testable
fn calculate_discount(order: Order) -> number {
    return order.total * 0.1;
}

fn is_high_value(order: Order) -> boolean {
    return order.total > 1000.0;
}

fn format_log_entry(order_id: string, order: Order) -> string {
    return "{{order_id}}: ${{order.total}}";
}

// Thin effectful shell — tested via integration tests
fn process_order(order_id: string) -> boolean ![io, net] {
    let raw = http.get("https://api.example.com/orders/{{order_id}}");
    let order = Order.parse(raw);

    if is_high_value(order) {
        print("High-value order: {{order_id}}");
        fs.append("high_value.log", format_log_entry(order_id, order));
    }

    let discount = calculate_discount(order);
    http.post("https://api.example.com/orders/{{order_id}}/discount",
              "{{discount}}");
    return true;
}
```

Now `calculate_discount`, `is_high_value`, and `format_log_entry` are pure and can be tested exhaustively without any I/O infrastructure:

```sfn
test "discount calculation" {
    let order = Order { total: 500.0 };
    assert calculate_discount(order) == 50.0;
}

test "high value threshold" {
    assert is_high_value(Order { total: 1001.0 }) == true;
    assert is_high_value(Order { total: 999.0 })  == false;
    assert is_high_value(Order { total: 1000.0 }) == false;
}
```

### Another example: validation

```sfn
// Pure validator — no effects
fn validate_email(email: string) -> boolean {
    return email.contains("@") && email.contains(".");
}

fn validate_username(username: string) -> boolean {
    return username.length >= 3 && username.length <= 32;
}

struct ValidationResult {
    valid: boolean;
    errors: string[];
}

fn validate_registration(username: string, email: string) -> ValidationResult {
    let mut errors: string[] = [];
    if !validate_username(username) {
        errors.push("Username must be 3–32 characters");
    }
    if !validate_email(email) {
        errors.push("Invalid email address");
    }
    return ValidationResult { valid: errors.length == 0, errors: errors };
}

// Effectful boundary: calls the pure validator, then writes to DB
fn register_user(username: string, email: string) -> boolean ![io, net] {
    let result = validate_registration(username, email);
    if !result.valid {
        for error in result.errors {
            print.err("Validation error: {{error}}");
        }
        return false;
    }
    db.insert_user(username, email);
    return true;
}
```

The pure `validate_registration` can be tested with dozens of cases in milliseconds. The effectful `register_user` needs a database but only needs a handful of integration tests.

---

## Future: Hierarchical Effects

> **This section describes planned (not yet active) functionality.**

The current system uses flat effect names: `io`, `net`, `model`, etc. A future release will support hierarchical sub-effects to give finer-grained capability control:

```sfn
// Planned syntax — not active today
fn read_only_op(path: string) -> string ![io.fs.read] {
    return fs.read(path);
}

fn http_only(url: string) -> string ![net.http] {
    return http.get(url);
}
```

Hierarchical effects will allow you to require read-only filesystem access without granting write access, or restrict a function to HTTP without granting WebSocket or server capabilities. The flat names (`io`, `net`, etc.) will remain valid as "all sub-effects granted" shorthands.

Until hierarchical effects ship, use comments and code organisation to document intent when only a sub-capability is used:

```sfn
// Uses only fs.read — write capability not needed despite declaring ![io]
fn load_template(path: string) -> string ![io] {
    return fs.read(path);
}
```

---

## Quick Reference

```sfn
// No effect — pure function
fn pure_fn(x: number) -> number { ... }

// Single effect
fn io_fn() ![io] { ... }

// Multiple effects
fn network_fn() ![io, net] { ... }

// With return type
fn fetch_fn(url: string) -> string ![net] { ... }

// Test with effects
test "my test" ![io] { ... }

// Function using AI library (post-1.0 sfn/ai capsule)
fn ai_fn(input: string) -> string ![model] { ... }
```

---

## Next Steps

- [Ownership & Borrowing](/docs/learn/ownership) — Move semantics and `Affine<T>`/`Linear<T>` (syntax parsed today; enforcement on the [roadmap](/roadmap))
- [Testing](/docs/learn/testing) — Writing pure and effectful tests
- [AI Integration](/docs/learn/ai-constructs) — The `![model]` effect and the `sfn/ai` capsule
- [Effect System Reference](/docs/reference/effects) — Complete specification and enforcement rules
