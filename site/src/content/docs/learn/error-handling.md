---
title: Error Handling
description: try/catch/finally, result types, custom errors, and error propagation in Sailfin.
section: learn
order: 6
---

Every program encounters things that go wrong. A file that isn't there. An API that returns a 500. Input that doesn't parse. How you handle those situations determines whether your program behaves predictably or fails in confusing ways.

Sailfin gives you two complementary tools for errors, suited to different situations:

- **Exceptions** (`throw`, `try/catch/finally`) — for conditions that are genuinely exceptional, where the calling code can't reasonably proceed and control needs to unwind to a handler somewhere up the call stack.
- **Result values** — for expected failures, where the calling code should inspect the outcome and decide what to do. Representing errors as values is explicit: the compiler enforces that callers acknowledge them.

Understanding which tool to reach for in a given situation makes error handling code both safer and cleaner.

---

## Two kinds of error

Before the mechanics, a useful distinction:

**Expected failures** are outcomes the program anticipates and knows how to handle. A user types the wrong password. A network request times out. A configuration file has a syntax error. These are not bugs — they're part of the program's normal operating envelope. Code that handles them should be readable, not exceptional.

**Exceptional conditions** are outcomes that indicate something is wrong with the program itself, or with a system the program depends on. An invariant that shouldn't be violatable was violated. A service that is always up is down. A file that must exist doesn't. These warrant unwinding to a recovery point (or exiting cleanly with an error message).

Sailfin's `throw`/`try/catch` is designed for the second category. The `Result` pattern is designed for the first. In practice, many programs use both.

---

## `try` / `catch` / `finally`

The basic structure mirrors familiar syntax in other languages, with Sailfin specifics:

```sfn
fn load_config(path: String) -> Config ![io] {
    try {
        let content = fs.read(path);
        return Config.parse(content);
    } catch (e: ParseError) {
        print.err("Config file has invalid syntax: {{e.message}}");
        throw e;
    } catch (e: IoError) {
        print.err("Cannot read config at {{path}}: {{e.message}}");
        throw e;
    } finally {
        print("Config load attempt completed for {{path}}");
    }
}
```

- The `try` block contains the code that might fail.
- Each `catch` clause names a variable and optionally a type. Multiple `catch` clauses are checked in order; the first matching type wins.
- `finally` always runs, whether the `try` block succeeded, threw, or a `catch` clause threw. Use it for cleanup that must happen regardless of outcome.

### Catching without a type annotation

You can catch any error by omitting the type:

```sfn
fn attempt_operation() ![io] {
    try {
        risky_operation();
    } catch (e) {
        // catches anything thrown
        print("Something went wrong: {{e}}");
    }
}
```

This is convenient for top-level handlers or logging shims. For anything deeper, catching specific types is better — it prevents silently swallowing errors you didn't anticipate.

### Catching multiple types

```sfn
fn fetch_and_store(url: String, path: String) ![io, net] {
    try {
        let data = http.get(url);
        fs.write(path, data);
    } catch (e: NetworkError) {
        print.err("Network error fetching {{url}}: {{e.message}}");
    } catch (e: IoError) {
        print.err("Disk error writing {{path}}: {{e.message}}");
    } catch (e) {
        print.err("Unexpected error: {{e}}");
        throw e;   // re-throw things we didn't expect
    } finally {
        // always runs — good for releasing locks, closing progress indicators, etc.
        print("fetch_and_store finished");
    }
}
```

### Re-throwing

`throw e` inside a `catch` block re-throws the error. You can also throw a new, more informative error:

```sfn
fn read_user_config(user_id: Int) -> UserConfig ![io] {
    try {
        let path = "/etc/myapp/users/{{user_id}}.toml";
        return parse_toml(fs.read(path));
    } catch (e: IoError) {
        throw ConfigError {
            message: "No configuration found for user {{user_id}}",
            cause: e.message,
        };
    }
}
```

Wrapping and re-throwing lets you add context at each layer without losing the original error information.

### `finally` for cleanup

`finally` is the right place for cleanup that must happen regardless of what the `try` block does: closing connections, releasing locks, flushing buffers, decrementing reference counts.

```sfn
fn process_with_lock(resource: String) ![io] {
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
fn divide(a: Float, b: Float) -> Float {
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
    message -> String;
    field -> String;
    received -> String;
}

fn validate_email(email: String) -> String {
    if !email.contains("@") {
        throw ValidationError {
            message: "Invalid email address",
            field: "email",
            received: email,
        };
    }
    return email;
}
```

Callers can catch `ValidationError` specifically:

```sfn
fn register_user(email: String, name: String) ![io] {
    try {
        let valid_email = validate_email(email);
        create_account(valid_email, name);
    } catch (e: ValidationError) {
        print.err("Bad input for field '{{e.field}}': {{e.message}} (got: {{e.received}})");
    }
}
```

### Error hierarchies with enums

When a subsystem can fail in multiple structured ways, an enum is cleaner than a family of structs:

```sfn
enum DatabaseError {
    ConnectionFailed { host -> String; port -> Int; },
    QueryFailed { sql -> String; reason -> String; },
    TransactionAborted { reason -> String; },
    ConstraintViolation { constraint -> String; table -> String; },
}

fn find_user(id: Int) -> User ![io] {
    try {
        return db.query("SELECT * FROM users WHERE id = {{id}}");
    } catch (e: DatabaseError) {
        match e {
            DatabaseError.QueryFailed { sql, reason } =>
                print.err("Query failed: {{reason}}\nSQL: {{sql}}"),
            DatabaseError.ConnectionFailed { host, port } =>
                print.err("Cannot reach database at {{host}}:{{port}}"),
            _ => print.err("Database error: {{e}}"),
        }
        throw e;
    }
}
```

Using an enum for errors makes `match` exhaustiveness checking useful: if you add a new variant, the compiler will remind you anywhere you match on it without a wildcard.

---

## `Result<T, E>` — errors as values

Some functions return errors as part of their normal output rather than throwing. This is the **Result pattern**: represent success and failure as distinct enum variants.

Define a result enum for your domain:

```sfn
enum ParseResult<T> {
    Ok(T),
    Err(String),
}
```

Or define a generic one and reuse it:

```sfn
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

Return it from functions that can fail in expected ways:

```sfn
fn parse_port(s: String) -> Result<Int, String> {
    let n = Int.parse(s);
    if n == null {
        return Result.Err("Not a valid integer: {{s}}");
    }
    if n < 1 || n > 65535 {
        return Result.Err("Port out of range: {{n}}");
    }
    return Result.Ok(n);
}
```

Callers use `match` to handle both cases:

```sfn
fn main() ![io] {
    match parse_port("8080") {
        Result.Ok(port) => print("Listening on port {{port}}"),
        Result.Err(msg) => print.err("Bad port: {{msg}}"),
    }
}
```

### When to use `Result` vs. `throw`

| Situation | Prefer |
|-----------|--------|
| Caller should always check the outcome | `Result<T, E>` |
| Failure is a programming error or invariant violation | `throw` |
| Multiple failure modes need to be returned with data | `Result` with enum `E` |
| The error needs to propagate many layers without being inspected | `throw` |
| Working with a library that models errors as values | `Result` |
| Simple scripts or top-level orchestration | Either; `throw` is often cleaner |

The two approaches are compatible. You can `throw` from inside a `Result`-returning function on truly unexpected conditions, and you can catch exceptions and convert them to `Result.Err(...)` at API boundaries.

### Chaining Results

When multiple operations each return a `Result`, you can chain them with `match` or early returns:

```sfn
fn load_server_config(path: String) -> Result<ServerConfig, String> ![io] {
    let read_result = fs.try_read(path);
    let content = match read_result {
        Result.Ok(c) => c,
        Result.Err(e) => return Result.Err("Cannot read file: {{e}}"),
    };

    let parse_result = ServerConfig.try_parse(content);
    let config = match parse_result {
        Result.Ok(c) => c,
        Result.Err(e) => return Result.Err("Invalid config format: {{e}}"),
    };

    return Result.Ok(config);
}
```

The early-return pattern keeps the happy path linear while handling errors explicitly.

> **Planned feature**: The `?` operator for automatic error propagation is on the roadmap. It will allow `fs.try_read(path)?` as shorthand for the match-and-return pattern above, automatically unwrapping `Ok` values and returning `Err` from the current function. This is not yet implemented; use the explicit `match` pattern today.

---

## Error propagation

Errors typically need to travel from where they occur to where they can be meaningfully handled. There are two mechanisms:

**Exception propagation** is automatic. An uncaught `throw` unwinds the call stack until it hits a `catch` block or reaches the top of the program (causing a runtime error message and non-zero exit code).

**Result propagation** is explicit. The caller must decide what to do with `Result.Err`. The early-return pattern above is the standard approach.

For deep call stacks where most intermediate layers have nothing useful to do with an error, exceptions are often cleaner — the error propagates without every layer needing to handle it. For shallow call stacks or library APIs where callers need to inspect and handle errors, `Result` makes the failure modes explicit in the type signature.

A common pattern at system boundaries: throw internally, but expose a `Result`-returning wrapper for external callers:

```sfn
fn fetch_order_internal(id: Int) -> Order ![io, net] {
    // can throw NetworkError, ParseError, etc.
    let response = http.get("/orders/{{id}}");
    return Order.parse(response.body);
}

fn fetch_order(id: Int) -> Result<Order, String> ![io, net] {
    try {
        return Result.Ok(fetch_order_internal(id));
    } catch (e) {
        return Result.Err("Failed to fetch order {{id}}: {{e}}");
    }
}
```

---

## `try/catch` with effects

Catching errors from effectful operations requires the function to declare the appropriate effects. You cannot hide an `![io]` operation inside a `try` block and avoid declaring the effect on the outer function:

```sfn
// This requires ![io] because fs.read needs it — the try block doesn't change that
fn read_optional(path: String) -> String ![io] {
    try {
        return fs.read(path);
    } catch (e: IoError) {
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
fn get_first(items: Array<Int>) -> Int {
    assert items.length > 0;   // panics if items is empty
    return items[0];
}
```

Use panics (via `assert`) for:

- **Invariants**: conditions that must hold for your program to be correct. If they fail, something is fundamentally wrong — there's no recovery, only debugging.
- **Type-system gaps**: places where the types can't express the constraint but the logic requires it.

Do not use panics for expected failures. If a user can trigger a panic by providing bad input, replace the panic with a proper error or `Result`.

In tests, `assert` is idiomatic and correct — failing assertions should stop the test immediately:

```sfn
test "parse_port accepts valid ports" {
    match parse_port("8080") {
        Result.Ok(n) => assert n == 8080,
        Result.Err(msg) => assert false,   // test should not reach here
    }
}
```

---

## Testing error cases

Good test coverage includes the failure paths. Sailfin's `test` blocks integrate with `try/catch` naturally:

```sfn
test "validate_email rejects addresses without @" {
    let threw = false;
    try {
        validate_email("not-an-email");
    } catch (e: ValidationError) {
        threw = true;
        assert e.field == "email";
        assert e.received == "not-an-email";
    }
    assert threw;   // confirm the error was actually thrown
}
```

The pattern — set a flag in the `catch`, assert the flag was set after the block — is idiomatic. It fails the test both when no error is thrown and when the wrong error type is thrown.

For `Result`-returning functions:

```sfn
test "parse_port rejects port 0" {
    match parse_port("0") {
        Result.Ok(_) => assert false,   // should not succeed
        Result.Err(msg) => assert msg.contains("out of range"),
    }
}

test "parse_port rejects non-numeric input" {
    match parse_port("abc") {
        Result.Ok(_) => assert false,
        Result.Err(msg) => assert msg.contains("Not a valid integer"),
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
} catch (e) {
    // nothing
}

// Better: log and continue, or rethrow
try {
    save_audit_log(event);
} catch (e: IoError) {
    print.err("Warning: audit log write failed: {{e.message}}");
    // decide: continue anyway, or rethrow?
}
```

**Add context when wrapping errors.** When you catch an error and rethrow a new one, include the original message:

```sfn
// Bad: original cause is lost
} catch (e: IoError) {
    throw ConfigError { message: "Config load failed" };
}

// Better: include the cause
} catch (e: IoError) {
    throw ConfigError {
        message: "Config load failed",
        cause: e.message,
    };
}
```

**Match the abstraction level of the error to its catch site.** Low-level I/O errors (`IoError`, `NetworkError`) should typically be caught and wrapped at module boundaries, not bubbled raw to top-level application code. High-level errors (`ConfigError`, `AuthError`) are more meaningful to the code that can actually act on them.

**Use `Result` for library APIs.** Libraries can't control how their callers handle exceptions. Returning `Result<T, E>` from public APIs makes the failure modes explicit in the type, forces callers to handle them, and avoids surprising exception propagation.

**Prefer specific `catch` clauses over generic ones.** Catching a specific type (`catch (e: NetworkError)`) documents what you expect and prevents accidentally swallowing unrelated errors:

```sfn
// Risky: catches everything, including unexpected errors
try {
    ...
} catch (e) {
    print.err("Error: {{e}}");
    // application continues — may be in a broken state
}

// Safer: only handles what you understand; others propagate
try {
    ...
} catch (e: NetworkError) {
    handle_network_failure(e);
} catch (e: TimeoutError) {
    handle_timeout(e);
}
// Any other errors propagate to the caller
```

**Log before rethrowing, not after.** If you're going to rethrow, log first — the log and the throw happen in the same stack frame, making correlation easier:

```sfn
} catch (e: DatabaseError) {
    print.err("Database error in payment processing: {{e.message}}");
    throw e;   // log happened — safe to rethrow
}
```

---

## Summary

| Tool | Use for | Type signature |
|------|---------|----------------|
| `throw` + `try/catch` | Exceptional conditions, deep propagation | Function may throw |
| `Result<T, E>` | Expected failures, library APIs | `-> Result<T, E>` |
| `assert` | Invariants and programmer errors | Panics on failure |

The two main tools compose naturally. Use exceptions where propagation is the right model; use `Result` where the caller should inspect the outcome. Add context at layer boundaries. Don't swallow errors.

---

## Next steps

- [Ownership & Borrowing](/docs/learn/ownership) — Move semantics, borrows, and linear types
- [Concurrency](/docs/learn/concurrency) — Routines, channels, and parallelism (planned)
- [Testing](/docs/learn/testing) — Writing and running tests
- [The Effect System](/docs/learn/effects) — How effects interact with error-producing operations
