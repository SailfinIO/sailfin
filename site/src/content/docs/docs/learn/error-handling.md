---
title: Error Handling
description: try/catch/finally, result types, custom errors, and error propagation in Sailfin.
section: learn
sidebar:
  order: 6
---

Every program encounters things that go wrong. A file that isn't there. An API that returns a 500. Input that doesn't parse. How you handle those situations determines whether your program behaves predictably or fails in confusing ways.

Sailfin gives you two complementary tools for errors, suited to different situations:

- **Exceptions** (`throw`, `try/catch/finally`) — for conditions that are genuinely exceptional, where the calling code can't reasonably proceed and control needs to unwind to a handler somewhere up the call stack.
- **Union return types** — for expected failures, where the calling code should inspect the outcome and decide what to do. A function that can succeed or return an error struct declares a union return type like `number | DivisionError`, and callers use `match` to handle each variant.

Understanding which tool to reach for in a given situation makes error handling code both safer and cleaner.

> **Coming in 1.0:** A built-in `Result<T, E>` type plus a `?` operator for automatic error propagation are on the [roadmap](/roadmap). Until they ship, use union return types (shown throughout this page) for expected failures.

---

## Two kinds of error

Before the mechanics, a useful distinction:

**Expected failures** are outcomes the program anticipates and knows how to handle. A user types the wrong password. A network request times out. A configuration file has a syntax error. These are not bugs — they're part of the program's normal operating envelope. Code that handles them should be readable, not exceptional.

**Exceptional conditions** are outcomes that indicate something is wrong with the program itself, or with a system the program depends on. An invariant that shouldn't be violatable was violated. A service that is always up is down. A file that must exist doesn't. These warrant unwinding to a recovery point (or exiting cleanly with an error message).

Sailfin's `throw`/`try/catch` is designed for the second category. Union return types are designed for the first. In practice, many programs use both.

---

## `try` / `catch` / `finally`

The basic structure mirrors familiar syntax in other languages, with Sailfin specifics:

```sfn
fn load_config(path: string) -> Config ![io] {
    try {
        let content = fs.read(path);
        return Config.parse(content);
    } catch (err) {
        print.err("Could not load config at {{path}}: {{err}}");
        throw err;
    } finally {
        print("Config load attempt completed for {{path}}");
    }
}
```

- The `try` block contains the code that might fail.
- The `catch` clause names a binding for the thrown value. Sailfin's `catch` does not currently take a type annotation — dispatch on the error's shape inside the block, typically with `match` against a tagged enum.
- `finally` always runs, whether the `try` block succeeded, threw, or the `catch` clause threw. Use it for cleanup that must happen regardless of outcome.

### Dispatching on error kind

Because `catch` captures the error bare, inspect it inside the block using `match` or struct/enum pattern matching:

```sfn
fn attempt_operation() ![io] {
    try {
        risky_operation();
    } catch (err) {
        // catches anything thrown; decide how to respond here
        print("Something went wrong: {{err}}");
    }
}
```

This is convenient for top-level handlers or logging shims. For anything deeper, prefer returning a union type so the caller cannot accidentally ignore the failure.

### Multiple failure modes

```sfn
fn fetch_and_store(url: string, path: string) ![io, net] {
    try {
        let data = http.get(url);
        fs.write(path, data);
    } catch (err) {
        // Inspect the error inside the block; an enum or struct makes this ergonomic.
        print.err("fetch_and_store failed: {{err}}");
        throw err;   // re-throw if the caller should still see it
    } finally {
        // always runs — good for releasing locks, closing progress indicators, etc.
        print("fetch_and_store finished");
    }
}
```

> **Coming in 1.0:** Typed `catch` clauses (`catch (err: NetworkError) { ... }`) are on the [roadmap](/roadmap). Today a single `catch` block captures the thrown value bare, and you discriminate inside — typically with `match`.

### Re-throwing

`throw err` inside a `catch` block re-throws the error. You can also throw a new, more informative error:

```sfn
struct ConfigError {
    message: string;
    cause: string;
}

fn read_user_config(user_id: number) -> UserConfig ![io] {
    try {
        let path = "/etc/myapp/users/{{user_id}}.toml";
        return parse_toml(fs.read(path));
    } catch (err) {
        throw ConfigError {
            message: "No configuration found for user {{user_id}}",
            cause: "{{err}}",
        };
    }
}
```

Wrapping and re-throwing lets you add context at each layer without losing the original error information.

### `finally` for cleanup

`finally` is the right place for cleanup that must happen regardless of what the `try` block does: closing connections, releasing locks, flushing buffers, decrementing reference counts.

```sfn
fn process_with_lock(resource: string) ![io] {
    acquire_lock(resource);
    try {
        do_work(resource);
    } finally {
        release_lock(resource);   // runs even if do_work throws
    }
}
```

If `do_work` throws, `finally` still runs before the exception propagates. The caller receives the original exception — `finally` does not swallow it.

---

## Throwing errors

Use `throw` to signal an error condition. You can throw any value:

```sfn
fn divide(a: number, b: number) -> number {
    if b == 0.0 {
        throw "Division by zero";
    }
    return a / b;
}
```

In practice, throwing structured error types gives callers the ability to programmatically inspect and react to specific errors.

### Custom error structs

Define an error type as a struct with a `message` field and whatever additional context is useful:

```sfn
struct ValidationError {
    message: string;
    field: string;
    received: string;
}

fn validate_email(email: string) -> string | ValidationError {
    if !email.contains("@") {
        return ValidationError {
            message: "Invalid email address",
            field: "email",
            received: email,
        };
    }
    return email;
}
```

Callers inspect the union with `match`:

```sfn
fn register_user(email: string, name: string) ![io] {
    let result = validate_email(email);
    match result {
        ValidationError { field, message, received } => {
            print.err("Bad input for field '{{field}}': {{message}} (got: {{received}})");
        },
        _ => {
            create_account(result, name);
        },
    }
}
```

> **Coming in 1.0:** Typed `catch` clauses (e.g. `catch (e: ValidationError)`) are on the [roadmap](/roadmap). Until they land, either use union return types (above) or catch bare and dispatch with `match` inside.

### Error hierarchies with enums

When a subsystem can fail in multiple structured ways, a tagged enum is cleaner than a family of structs:

```sfn
enum DatabaseError {
    ConnectionFailed { host: string, port: number },
    QueryFailed { sql: string, reason: string },
    TransactionAborted { reason: string },
    ConstraintViolation { constraint: string, table: string },
}

fn find_user(id: number) -> User | DatabaseError ![io] {
    let raw = db.query("SELECT * FROM users WHERE id = {{id}}");
    if raw == null {
        return DatabaseError.QueryFailed {
            sql: "SELECT * FROM users WHERE id = {{id}}",
            reason: "no rows returned",
        };
    }
    return User.from_row(raw);
}

fn render_user(id: number) ![io] {
    let result = find_user(id);
    match result {
        DatabaseError.QueryFailed { sql, reason } =>
            print.err("Query failed: {{reason}}\nSQL: {{sql}}"),
        DatabaseError.ConnectionFailed { host, port } =>
            print.err("Cannot reach database at {{host}}:{{port}}"),
        DatabaseError.TransactionAborted { reason } =>
            print.err("Transaction aborted: {{reason}}"),
        DatabaseError.ConstraintViolation { constraint, table } =>
            print.err("Constraint {{constraint}} violated on {{table}}"),
        _ => print("Found user {{id}}"),
    }
}
```

Using a tagged enum for errors makes `match` exhaustiveness checking useful: if you add a new variant, the compiler will remind you anywhere you match on it without a wildcard.

---

## Union return types — errors as values

Some functions return errors as part of their normal output rather than throwing. In Sailfin today, the idiomatic way to express this is a **union return type**: the function returns either the success value or an error struct/enum, and the caller uses `match` to discriminate.

This is the pattern used in `examples/basics/error-handling.sfn`:

```sfn
struct DivisionError {
    message: string;
}

fn safe_divide(a: number, b: number) -> number | DivisionError {
    if b == 0 {
        return DivisionError { message: "Cannot divide by zero!" };
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

For a richer error surface, combine a success type with a tagged enum:

```sfn
enum PortError {
    NotAnInteger { input: string },
    OutOfRange { value: number },
}

fn parse_port(s: string) -> number | PortError {
    let n = to_number(s);
    if n == null {
        return PortError.NotAnInteger { input: s };
    }
    if n < 1 || n > 65535 {
        return PortError.OutOfRange { value: n };
    }
    return n;
}

fn main() ![io] {
    let result = parse_port("8080");
    match result {
        PortError.NotAnInteger { input } => print.err("Bad port: not a number: {{input}}"),
        PortError.OutOfRange { value } => print.err("Bad port: out of range: {{value}}"),
        _ => print("Listening on port {{result}}"),
    }
}
```

> **Coming in 1.0:** A built-in `Result<T, E>` type and the `?` operator for automatic error propagation are on the [roadmap](/roadmap). `Result` will compose better than unions (no ambiguity when the success type is itself a struct) and the `?` operator will let you write `parse_port(s)?` instead of the explicit `match`-and-return. Until they ship, use union return types as shown above.

### When to use union returns vs. `throw`

| Situation | Prefer |
|-----------|--------|
| Caller should always check the outcome | Union return type |
| Failure is a programming error or invariant violation | `throw` |
| Multiple failure modes need to be returned with data | Union with a tagged enum |
| The error needs to propagate many layers without being inspected | `throw` |
| Working with a library that models errors as values | Union return type |
| Simple scripts or top-level orchestration | Either; `throw` is often cleaner |

The two approaches are compatible. You can `throw` from inside a union-returning function on truly unexpected conditions, and you can catch exceptions and convert them to an error variant at API boundaries.

### Chaining union returns

When multiple operations each return a union, you can chain them with `match` and early returns:

```sfn
struct LoadError {
    message: string;
}

fn load_server_config(path: string) -> ServerConfig | LoadError ![io] {
    let content = fs.read(path);  // may throw IoError; wrap with try/catch if needed

    let parsed = ServerConfig.try_parse(content);
    match parsed {
        LoadError { message } => return LoadError { message: "Invalid config format: {{message}}" },
        _ => return parsed,
    }
}
```

The early-return pattern keeps the happy path linear while handling errors explicitly.

---

## Error propagation

Errors typically need to travel from where they occur to where they can be meaningfully handled. There are two mechanisms:

**Exception propagation** is automatic. An uncaught `throw` unwinds the call stack until it hits a `catch` block or reaches the top of the program (causing a runtime error message and non-zero exit code).

**Union-return propagation** is explicit. The caller must decide what to do with the error variant. The early-return pattern above is the standard approach.

For deep call stacks where most intermediate layers have nothing useful to do with an error, exceptions are often cleaner — the error propagates without every layer needing to handle it. For shallow call stacks or library APIs where callers need to inspect and handle errors, a union return type makes the failure modes explicit in the type signature.

A common pattern at system boundaries: throw internally, but expose a union-returning wrapper for external callers:

```sfn
struct FetchError {
    message: string;
}

fn fetch_order_internal(id: number) -> Order ![io, net] {
    // can throw NetworkError, ParseError, etc.
    let response = http.get("/orders/{{id}}");
    return Order.parse(response.body);
}

fn fetch_order(id: number) -> Order | FetchError ![io, net] {
    try {
        return fetch_order_internal(id);
    } catch (err) {
        return FetchError { message: "Failed to fetch order {{id}}: {{err}}" };
    }
}
```

---

## `try/catch` with effects

Catching errors from effectful operations requires the function to declare the appropriate effects. You cannot hide an `![io]` operation inside a `try` block and avoid declaring the effect on the outer function:

```sfn
// This requires ![io] because fs.read needs it — the try block doesn't change that
fn read_optional(path: string) -> string ![io] {
    try {
        return fs.read(path);
    } catch (err) {
        return "";
    }
}
```

Effects are transitive through the call stack. If a function you call declares `![net]`, your function must also declare `![net]`, whether or not the call is inside a `try` block.

This is intentional: a `catch` block is not a capability boundary. Catching an I/O error doesn't mean you didn't do I/O; it means you handled the failure case. The capability declaration reflects what the function *does*, not what it *allows to propagate*.

---

## Panics vs. errors

A **panic** is an abrupt program termination caused by a programming error — something that should never happen in correct code. Panics are not catchable with `try/catch` (they terminate the process). They include:

- **Failed assertions** (`assert condition` where `condition` is false)
- **Non-exhaustive match** (a `match` expression reaches the catch-all without a matching case at runtime — only possible if the match isn't exhaustive)
- **Index out of bounds**
- **Integer overflow** (in debug builds)
- **Explicit `panic(message)`** calls

```sfn
fn get_first(items: number[]) -> number {
    assert items.length > 0;   // panics if items is empty
    return items[0];
}
```

Use panics (via `assert`) for:

- **Invariants**: conditions that must hold for your program to be correct. If they fail, something is fundamentally wrong — there's no recovery, only debugging.
- **Type-system gaps**: places where the types can't express the constraint but the logic requires it.

Do not use panics for expected failures. If a user can trigger a panic by providing bad input, replace the panic with a proper error or a union return type.

In tests, `assert` is idiomatic and correct — failing assertions should stop the test immediately:

```sfn
test "parse_port accepts valid ports" {
    let result = parse_port("8080");
    match result {
        PortError.NotAnInteger { input } => assert false,
        PortError.OutOfRange { value } => assert false,
        _ => assert result == 8080,
    }
}
```

---

## Testing error cases

Good test coverage includes the failure paths. Sailfin's `test` blocks integrate with `try/catch` naturally:

```sfn
test "validate_email rejects addresses without @" {
    let result = validate_email("not-an-email");
    match result {
        ValidationError { field, received, message } => {
            assert field == "email";
            assert received == "not-an-email";
        },
        _ => assert false,  // should have returned an error
    }
}
```

For functions that do throw, set a flag in `catch` and assert it afterwards:

```sfn
test "divide throws on zero" {
    let threw = false;
    try {
        let _ = divide(10, 0);
    } catch (err) {
        threw = true;
    }
    assert threw;
}
```

For union-returning functions:

```sfn
test "parse_port rejects port 0" {
    let result = parse_port("0");
    match result {
        PortError.OutOfRange { value } => assert value == 0,
        _ => assert false,
    }
}

test "parse_port rejects non-numeric input" {
    let result = parse_port("abc");
    match result {
        PortError.NotAnInteger { input } => assert input == "abc",
        _ => assert false,
    }
}
```

Testing error messages in addition to error types gives you regression coverage: if someone accidentally changes an error message that a monitoring system parses, the test catches it.

---

## Best practices

**Don't swallow errors silently.** A `catch` that does nothing (no log, no rethrow, no fallback) hides failures and makes debugging much harder:

```sfn
// Bad: exception is silently swallowed
try {
    save_audit_log(event);
} catch (err) {
    // nothing
}

// Better: log and continue, or rethrow
try {
    save_audit_log(event);
} catch (err) {
    print.err("Warning: audit log write failed: {{err}}");
    // decide: continue anyway, or rethrow?
}
```

**Add context when wrapping errors.** When you catch an error and rethrow a new one, include the original message:

```sfn
// Bad: original cause is lost
} catch (err) {
    throw ConfigError { message: "Config load failed", cause: "" };
}

// Better: include the cause
} catch (err) {
    throw ConfigError {
        message: "Config load failed",
        cause: "{{err}}",
    };
}
```

**Match the abstraction level of the error to its catch site.** Low-level I/O errors should typically be caught and wrapped at module boundaries, not bubbled raw to top-level application code. High-level errors (`ConfigError`, `AuthError`) are more meaningful to the code that can actually act on them.

**Use union return types for library APIs.** Libraries can't control how their callers handle exceptions. Returning `T | ErrorType` from public APIs makes the failure modes explicit in the type, forces callers to handle them, and avoids surprising exception propagation.

**Dispatch on error shape inside the catch.** Typed `catch` clauses are on the [roadmap](/roadmap); today, a `catch` binds the error bare. Use `match` or struct/enum pattern matching inside the block to discriminate:

```sfn
try {
    risky_network_op();
} catch (err) {
    match err {
        NetworkError { code } => handle_network_failure(code),
        TimeoutError { elapsed_ms } => handle_timeout(elapsed_ms),
        _ => {
            print.err("Unexpected error: {{err}}");
            throw err;   // re-raise anything we don't understand
        },
    }
}
```

**Log before rethrowing, not after.** If you're going to rethrow, log first — the log and the throw happen in the same stack frame, making correlation easier:

```sfn
} catch (err) {
    print.err("Database error in payment processing: {{err}}");
    throw err;   // log happened — safe to rethrow
}
```

---

## Summary

| Tool | Use for | Type signature |
|------|---------|----------------|
| `throw` + `try/catch` | Exceptional conditions, deep propagation | Function may throw |
| Union return (`T \| Err`) | Expected failures, library APIs | `-> T \| ErrorType` |
| `assert` | Invariants and programmer errors | Panics on failure |

The two main tools compose naturally. Use exceptions where propagation is the right model; use union returns where the caller should inspect the outcome. Add context at layer boundaries. Don't swallow errors.

> **Coming in 1.0:** `Result<T, E>`, the `?` operator, and typed `catch` clauses are all on the [roadmap](/roadmap). They will replace the union-return pattern with a more ergonomic, non-ambiguous alternative and let you propagate errors without explicit `match`.

---

## Next steps

- [Ownership & Borrowing](/docs/learn/ownership) — Move semantics, borrows, and linear types
- [Concurrency](/docs/learn/concurrency) — Routines, channels, and parallelism (planned)
- [Testing](/docs/learn/testing) — Writing and running tests
- [The Effect System](/docs/learn/effects) — How effects interact with error-producing operations
