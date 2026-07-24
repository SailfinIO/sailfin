---
title: The Effect System
description: A guide to Sailfin 0.8's shipped effect checks, propagation, sub-effects, capsule contracts, and purity boundary.
section: learn
sidebar:
  order: 4
---

Sailfin 0.8 makes supported side effects visible in function signatures. A filesystem operation requires an `io` grant, an HTTP operation requires `net`, and the checker propagates declared effects through resolved calls, including imported free functions. A function with no effect annotation is **effect-free with respect to the operations the 0.8 checker recognizes**. That is a compile-time statement, not yet a runtime sandbox or a proof about untracked FFI and reserved APIs.

The examples on this page that use undeclared application types or placeholder APIs are illustrative pseudocode. Snippets described as runnable use shipped APIs and syntax.

---

## What the Effect System Is

An effect is a named capability — a category of operation that reaches outside the pure computational model. In Sailfin, effects are declared on function signatures with the `![...]` annotation:

```sfn
fn read_config(path: string) -> string ![io] {
    return fs.read(path);
}
```

The `![io]` declares that `read_config` may perform I/O. The compiler checks direct calls to recognized effectful operations and propagates effects through statically resolved callees. Cross-module free-function calls and aliased imports are covered; unresolved or dynamic callees yield no guessed effect.

### Why this matters

- **Auditability**: Signatures expose the recognized capabilities used directly or inherited through resolved calls.
- **Testability**: An effect-free core avoids the recognized I/O, network, clock, and entropy boundaries and is easier to test in isolation. Determinism still depends on ordinary program inputs and on avoiding untracked escape hatches.
- **Security**: Missing `![net]` rules out recognized network operations along paths the checker can resolve. It does **not** yet prove that native/FFI code cannot exfiltrate data; the runtime syscall seal is a 1.0 target.
- **Composability**: Effects compose by union. A caller of resolved `![io]` and `![net]` callees declares `![io, net]`.

### How Sailfin compares to other languages

| Language | Mechanism | Compile-time? | Transitive? |
|----------|-----------|:---:|:---:|
| Sailfin 0.8 | `![effect]` annotations | Yes | Yes for statically resolved calls; unresolved/dynamic calls are not guessed |
| Java | Checked exceptions | Yes | Yes (but fragile) |
| Rust | `unsafe`, `Send`/`Sync` | Partial | Partial |
| Haskell | `IO` monad | Yes | Yes (explicit) |
| Go, Python, JS | None | No | No |

Sailfin's system is closest to Haskell's `IO` monad in intent, but uses a list of six canonical roots plus shipped dotted refinements rather than monadic types — which means you write ordinary-looking functions and add `![io]` annotations, rather than wrapping everything in `IO<T>`.

Java's checked exceptions are also transitive, but they are limited to exception types and have well-known composability problems (checked exceptions on interfaces are painful). Sailfin effects are composable by union and do not require interface methods to list throws clauses.

---

## The Six Canonical Effects

| Effect | Grants access to | Example operations | Enforced today |
|--------|-----------------|-------------------|:--------------:|
| `io` | Filesystem, console, logging | `fs.read`, `fs.write`, `print()`, `print.err()`, `console.*`, `@logExecution` | Yes |
| `net` | Network I/O | `http.get`, `http.post`, `websocket.*`, `serve` | Yes |
| `model` | Future AI library invocation | No shipped `sfn/ai` runtime API | Reserved — declaration/propagation works, but no detector or runtime API |
| `clock` | Sleep and clock reads | `sleep(ms)`, shipped clock helpers | Yes for registered operations |
| `gpu` | Future accelerator access | No effect-gated GPU runtime API | Parsed/reserved — no detector |
| `rand` | OS entropy boundary | `sfn/crypto::random_bytes` | Yes for `random_bytes`; no general call-name detector |

The taxonomy has exactly six canonical **root** effects. `io.fs`, `io.console`, `net.http`, and `net.ws` are shipped refinements within those roots, not additional canonical effects. `model` and `gpu` remain declarable so signatures and manifests can reserve their authority, but declaring a token does not imply that a corresponding runtime API exists.

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

A function with no `![]` annotation is conventionally called **pure**. In 0.8, the precise guarantee is narrower: the compiler rejects recognized direct effectful operations and effects inherited through resolved calls. The guarantee does not cover untracked FFI/native code, unresolved or dynamic calls, or runtime syscall confinement.

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

Effect-free functions are easy to test and reason about and may be called from effectful contexts. For `add`, the body and resolved callees contain no operation recognized by the 0.8 checker; this is not a general runtime non-interference proof.

### Separating pure logic from effects

A key design pattern in Sailfin is to push side effects to the edges of your program and keep the business logic pure. See [Effect Minimization as a Design Pattern](#effect-minimization-as-a-design-pattern) for detailed examples.

---

## Caller and Cross-Module Propagation

Caller propagation is shipped. When a statically resolved function declares an effect, its caller must declare a grant that covers it. This includes imported free functions and aliased imports (`E0402`), and propagation continues through resolved call chains.

```sfn
fn fetch_data(url: string) -> string ![net] {
    return http.get(url);
}

fn process(url: string) -> string ![net] {
    return fetch_data(url);
}
```

Removing `![net]` from `process` is a compile-time error because the resolved `fetch_data` signature requires it. The same rule applies when `fetch_data` is imported from another module.

Propagation is not yet universal dynamic whole-program analysis. In 0.8, unresolved or dynamic callees cannot contribute a guessed effect. Direct registered operations inside a function are still checked independently.

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

Immediately invoked closures are checked in their enclosing effect scope. Do not infer a general effect-polymorphic closure guarantee from this rule: effect polymorphism and broader escaped-closure analysis remain post-1.0 work.

---

## Compiler Diagnostics

The effect checker produces source-spanned diagnostics with per-call-site carets and structured fix suggestions. Direct missing effects use `E0400`, imported-callee propagation uses `E0402`, and capsule-manifest violations use `E0403`.

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

## Shipped Dotted Sub-effects

Sailfin 0.8 detects four dotted refinements: `io.fs`, `io.console`, `net.http`, and `net.ws`. A broad root grant subsumes its refinements, so `![io]` authorizes both filesystem and console operations. A narrow grant authorizes only that detected family:

```sfn
fn read_only_op(path: string) -> string ![io.fs] {
    return fs.read(path);
}
```

Here `![io.fs]` satisfies the registered filesystem operation but would not satisfy `print`, which requires the sibling `io.console`. Capsule manifests use the same subsumption rule: `required = ["io"]` permits all `io.*` declarations, while `required = ["io.fs"]` rejects a function declaring `![io.console]` with `E0403`.

Detection is deliberately conservative. Other registered operations may still require a bare root, and deeper names such as `io.fs.read` are preview design rather than a shipped detector. See [Hierarchical Effects](/docs/reference/preview/hierarchical-effects) for the exact readiness boundary.

## Capsule Contracts and the 1.0 Runtime Seal

Inside a capsule with a non-empty `[capabilities] required` surface, every function's declared effects must fit that manifest (`E0403`). An absent or empty surface skips this cross-check for compatibility; it is **not** an implicit deny-all sandbox. Workspace envelopes can enforce member **declared surfaces**, but inferred source-surface auditing across a workspace remains planned.

All of these are compile-time checks. The emitted 0.8 binary does not carry a capability context that gates every syscall, so effects do not yet confine FFI or arbitrary native objects at runtime. That runtime capability seal is explicitly a **1.0 target**.

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

- [Ownership & Borrowing](/docs/learn/ownership) — Enforced move and single-use semantics for owned, `Affine<T>`, and `Linear<T>` bindings
- [Testing](/docs/learn/testing) — Writing pure and effectful tests
- [AI Integration](/docs/learn/ai-constructs) — The `![model]` effect and the `sfn/ai` capsule
- [Effect System Reference](/docs/reference/effects) — Complete specification and enforcement rules
