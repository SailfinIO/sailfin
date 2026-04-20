---
title: Effective Sailfin
description: Idiomatic patterns, naming conventions, and best practices for writing clear, safe, and maintainable Sailfin.
section: learn
sidebar:
  order: 10
---

This guide covers the idioms and practices that make Sailfin code easy to read, safe to modify, and efficient to run. It is similar in spirit to [Effective Go](https://go.dev/doc/effective_go) — less a reference and more an opinionated guide to writing code that fits the language.

None of this is enforced by the compiler (except where noted). These are conventions the Sailfin community converges on because they make codebases easier to work with.

## Naming Conventions

Consistent naming reduces the mental overhead of reading unfamiliar code.

### Types, structs, enums, interfaces — `PascalCase`

```sfn
struct HttpClient { /* ... */ }
enum Direction { North, South, East, West }
interface Serializable { /* ... */ }
type UserId = string;
```

### Functions, methods, variables, fields — `snake_case`

```sfn
fn fetch_and_parse(url: string) -> Document ![io, net] { /* ... */ }

let retry_count: number = 3;
let mut pending_jobs: Job[] = [];
```

```sfn
struct UserProfile {
    display_name: string;
    email_address: string;
    created_at: number;
}
```

### Constants — `UPPER_SNAKE_CASE`

```sfn
let MAX_RETRIES: number = 3;
let DEFAULT_TIMEOUT_MS: number = 5000;
let BASE_URL: string = "https://api.example.com";
```

### Files — `snake_case.sfn`

```
http_client.sfn
effect_checker.sfn
user_profile.sfn
```

Test files end in `_test.sfn`. Module entry points are named `mod.sfn`.

### What not to do

```sfn
// Wrong: functions should not be PascalCase
fn FetchData(url: string) -> string ![net] { /* ... */ }

// Wrong: types should not be snake_case
struct user_profile { /* ... */ }

// Wrong: constants should not be camelCase
let maxRetries: number = 3;
```

---

## Effect Discipline

The effect system is Sailfin's most distinctive feature. Used well, it makes the boundary between pure computation and side effects explicit, which benefits readability, testability, and optimizer performance.

### Declare the narrowest effects possible

Only list the effects a function actually needs. This is not just style — it is safety. A function that declares `![io, net, model]` but only needs `![io]` has been granted capabilities it doesn't use, which makes it harder to reason about.

```sfn
// Too broad
fn format_report(data: Record[]) -> string ![io, net, model] {
    return data.map(fn(r: Record) -> string { return "{{r.name}}: {{r.value}}"; }).join("\n");
}

// Correct — this function is pure
fn format_report(data: Record[]) -> string {
    return data.map(fn(r: Record) -> string { return "{{r.name}}: {{r.value}}"; }).join("\n");
}
```

> **Coming in 1.0:** closures with captures are on the [roadmap](/roadmap). The
> lambda-capture support that lets `.map(...)` read surrounding state is not
> shipped today; treat the two examples above as illustrative of the declared
> effect set, not as runnable code.

### Separate pure computation from effectful operations

Write your logic as pure functions, then call them from effectful entry points. This pattern makes individual functions easier to test and reason about.

```sfn
// Before: computation and IO tangled together
fn process_and_save(records: Record[], path: string) -> void ![io] {
    let mut output: string = "";
    for r in records {
        let line: string = "{{r.name}},{{r.value}}\n";
        output = output + line;
    }
    fs.write(path, output);
}

// After: pure function + thin effectful wrapper
fn format_csv(records: Record[]) -> string {
    let mut output: string = "";
    for r in records {
        output = output + "{{r.name}},{{r.value}}\n";
    }
    return output;
}

fn save_csv(records: Record[], path: string) -> void ![io] {
    let content: string = format_csv(records);
    fs.write(path, content);
}
```

`format_csv` is now independently testable without any filesystem setup.

### Group effectful operations at boundaries

Push effects toward the edges of your system — main functions, HTTP handlers, event loops. The more of your codebase that is pure, the more of it can be tested without infrastructure.

```sfn
// Pure domain logic — returns a union of success / error for typed failures.
fn validate_order(order: Order) -> Order | ValidationError { /* ... */ }
fn calculate_total(order: Order) -> number { /* ... */ }
fn apply_discount(order: Order, code: string) -> Order { /* ... */ }

// Thin effectful entry point
fn handle_order_request(req: HttpRequest) -> HttpResponse ![io, net] {
    let order: Order = Order.from_request(req);
    let validated: Order | ValidationError = validate_order(order);
    if validated is ValidationError {
        return HttpResponse.bad_request(validated.message);
    }
    let total: number = calculate_total(apply_discount(validated, req.discount_code));
    db.save_order(validated);
    return HttpResponse.ok("Total: {{total}}");
}
```

> **Coming in 1.0:** `Result<T, E>` plus the `?` propagation operator is
> planned — see the [roadmap](/roadmap). Today, model typed failures with a
> union return type and use `is` type guards to discriminate, as shown above.

---

## Struct Design

### Use `:` for field declarations

Sailfin uses `name: Type;` syntax for struct fields (semicolon-terminated) — the
same `:` separator used for variable and parameter annotations. Only return
types use `->`.

```sfn
struct Connection {
    host: string;
    port: number;
    timeout_ms: number;
    is_tls: boolean;
}
```

### Prefer immutable fields; use `mut` only when needed

Most fields do not need to change after construction. Marking a field mutable is a signal that it changes during the object's lifetime — make that explicit and intentional.

```sfn
// Good: fields are immutable by default
struct Config {
    host: string;
    port: number;
    max_connections: number;
}

// Only when mutation is genuinely required
struct RateLimiter {
    max_per_second: number;
    mut current_count: number;
    mut window_start: number;
}
```

### Small, focused structs

A struct that does one thing is easier to test and reuse than one that does many.

```sfn
// Hard to work with — mixes concerns
struct Request {
    url: string;
    method: string;
    headers: Header[];
    body: string;
    retry_count: number;
    timeout_ms: number;
    auth_token: string;
    log_requests: boolean;
}

// Better: separate what belongs together
struct Request {
    url: string;
    method: string;
    headers: Header[];
    body: string;
}

struct RetryPolicy {
    max_attempts: number;
    timeout_ms: number;
}

struct HttpClient {
    auth_token: string;
    retry_policy: RetryPolicy;
    log_requests: boolean;
}
```

### Interface-driven design

Define interfaces for any type you want to substitute or test in isolation. Small, focused interfaces are more useful than large, prescriptive ones.

```sfn
// Too large — forces implementers to provide everything at once
interface Store {
    fn get(self, key: string) -> string ![io];
    fn set(self, key: string, value: string) -> void ![io];
    fn delete(self, key: string) -> void ![io];
    fn list_keys(self) -> string[] ![io];
    fn flush(self) -> void ![io];
    fn compact(self) -> void ![io];
}

// Better: split by usage pattern
interface Reader {
    fn get(self, key: string) -> string ![io];
}

interface Writer {
    fn set(self, key: string, value: string) -> void ![io];
    fn delete(self, key: string) -> void ![io];
}
```

Code that only reads can accept a `Reader`. Code that reads and writes accepts both. This makes substitution easier and intent clearer.

---

## Error Handling Idioms

### Use union return types for expected failures

If a function can fail in a way that callers should be prepared to handle,
return a union of the success value and a typed error. This makes the failure
mode part of the function's type signature and forces callers to discriminate
with `is` or `match`.

```sfn
enum ConfigError {
    NotFound { path: string },
    ParseFailed { message: string },
    PermissionDenied,
}

fn load_config(path: string) -> Config | ConfigError ![io] { /* ... */ }
```

Discriminate with `is` type guards or `match`:

```sfn
let loaded: Config | ConfigError = load_config("app.toml");
if loaded is ConfigError {
    print.err("Config error: {{loaded}}");
    return;
}
run(loaded);
```

> **Coming in 1.0:** `Result<T, E>` plus the `?` propagation operator is
> planned — see the [roadmap](/roadmap). Until it ships, union return types
> give you the same compile-time exhaustiveness without the sugar.

### Use `try/catch` for exceptional conditions

`try/catch` is for situations that are not expected in normal operation and cannot easily be threaded through return types — corrupted files, out-of-memory conditions, unexpected network resets.

```sfn
fn main() -> void ![io] {
    try {
        let config: Config = load_config_or_throw("app.toml");
        run(config);
    } catch (e) {
        print.err("Configuration error: {{e}}");
    } finally {
        print("Shutting down.");
    }
}
```

### Always provide context in error messages

An error message that says "file not found" is harder to debug than one that says "config file not found: /home/user/.config/myapp/app.toml". Include the relevant input in the message.

```sfn
// Bad
throw "file not found";

// Good
throw "config file not found: {{path}}";
```

### Don't silently swallow errors

A `catch` block that does nothing is a trap. If you genuinely want to ignore an error, say so explicitly in a comment.

```sfn
// Bad: silent swallowing hides bugs
try {
    cache.invalidate(key);
} catch (e) {
}

// Better: explicit about the intent
try {
    cache.invalidate(key);
} catch (e) {
    // Cache invalidation is best-effort; proceed without it
}

// Or: log it if there's any chance it matters
try {
    cache.invalidate(key);
} catch (e) {
    print.err("Cache invalidation failed for {{key}}: {{e}}");
}
```

---

## Function Design

### Single responsibility

A function should do one thing. If you find yourself writing "and" in a function's name or docstring, it probably does two things.

```sfn
// Does too much
fn fetch_validate_and_save(url: string, path: string) -> void ![io, net] { /* ... */ }

// Better: separate responsibilities
fn fetch(url: string) -> Response ![net] { /* ... */ }
fn validate(response: Response) -> Data | ValidationError { /* ... */ }
fn save(data: Data, path: string) -> void ![io] { /* ... */ }
```

### Pure functions where possible

A pure function — one with no effects — is always easier to reason about, test, and compose than an effectful one. Reach for pure functions first and add effects only when required.

### Descriptive parameter names

Parameter names at a call site communicate intent. Single-letter names save typing but cost the reader context.

```sfn
// Unclear at the call site: rotate(img, 90, true)
fn rotate(i: Image, d: number, c: boolean) -> Image { /* ... */ }

// Clear: the name does the documenting at the call site.
fn rotate(image: Image, degrees: number, clockwise: boolean) -> Image { /* ... */ }
```

### Avoid deeply nested effects — extract helpers

When a function has many effects and a long body, it becomes difficult to understand what any single part of it does. Extract named helpers to break it up.

```sfn
// Hard to follow — a wall of effects and steps
fn deploy(config: Config) -> void ![io, net, clock] {
    print("Validating...");
    let validation: Config | ValidationError = validate_config(config);
    if validation is ValidationError {
        throw "invalid config: {{validation.message}}";
    }
    print("Uploading artifacts...");
    let upload_result: Response = http.post(config.registry_url, config.artifact);
    if upload_result.status != 200 {
        throw "upload failed: {{upload_result.status}}";
    }
    print("Waiting for health check...");
    let mut attempts: number = 0;
    loop {
        runtime.sleep(2000);
        let health: Response = http.get("{{config.base_url}}/health");
        if health.status == 200 { break; }
        attempts = attempts + 1;
        if attempts > 10 { throw "health check timed out"; }
    }
    print("Deploy complete.");
}

// Better: named helpers make each phase clear
fn validate_or_throw(config: Config) -> Config ![io] { /* ... */ }
fn upload_artifact(config: Config) -> void ![net] { /* ... */ }
fn await_healthy(base_url: string) -> void ![net, clock] { /* ... */ }

fn deploy(config: Config) -> void ![io, net, clock] {
    let validated: Config = validate_or_throw(config);
    print("Uploading artifacts...");
    upload_artifact(validated);
    print("Waiting for service to become healthy...");
    await_healthy(validated.base_url);
    print("Deploy complete.");
}
```

---

## Pattern Matching Idioms

### Use `match` for exhaustive enum handling

When a function receives an enum, `match` forces you to handle every variant. This is a feature, not a chore — the compiler will tell you when a new variant is added and you have not handled it.

```sfn
enum Status {
    Pending,
    Running,
    Succeeded,
    Failed { reason: string },
}

fn describe(status: Status) -> string {
    match status {
        Status.Pending                   => return "waiting to start",
        Status.Running                   => return "currently executing",
        Status.Succeeded                 => return "finished successfully",
        Status.Failed { reason }         => return "failed: {{reason}}",
    }
}
```

> **Coming in 1.0:** simple tuple-style variants (e.g. `Failed(string)`) are not
> supported today. Use struct-style variants with named fields as shown above.

### Prefer `match` over chains of `if/else` for type discrimination

```sfn
// Hard to read — repeated type guards and rebinding
if result is ParseError {
    print.err("Error: {{result.message}}");
} else {
    process(result);
}

// Better — clear and exhaustive
match result {
    ParseError { message } => print.err("Error: {{message}}"),
    Document { body }      => process(body),
}
```

> **Coming in 1.0:** `Result<T, E>` plus dedicated `Ok(...)`/`Err(...)`
> patterns are on the [roadmap](/roadmap). Today, model success/failure as a
> union return type and discriminate with `match` on the tagged variants.

### Use guard conditions to narrow cases

Guards let you add a boolean condition to a match arm, expressed with `if`:

```sfn
match event {
    Event.Click { x, y } if x < 0 || y < 0 => handle_out_of_bounds(x, y),
    Event.Click { x, y }                   => handle_click(x, y),
    Event.KeyPress { key } if key == "Escape" => close_dialog(),
    Event.KeyPress { key }                 => handle_key(key),
    Event.Resize { width, height }         => handle_resize(width, height),
}
```

### Don't use `_` when you can be specific

The wildcard `_` matches any value. Overusing it can hide the fact that a case is not handled. Be specific when the cases are finite and known.

```sfn
// Risky: if a new Direction variant is added, this silently falls through
match direction {
    Direction.North => move_up(),
    Direction.South => move_down(),
    _               => move_sideways(),   // catches East and West, but also any future variants
}

// Better: explicit
match direction {
    Direction.North => move_up(),
    Direction.South => move_down(),
    Direction.East  => move_right(),
    Direction.West  => move_left(),
}
```

Use `_` for truly uninteresting cases, like ignoring a value you need to bind but don't use.

---

## Module Organization

### When to split into multiple files

One file per module is the default. Split a file when:

- It exceeds roughly 300–400 lines and covers more than one logical concept.
- Multiple people frequently edit different parts of it in parallel.
- You want to make certain types or functions private to a sub-module.

### `mod.sfn` as the public API

The `mod.sfn` file in a directory is the entry point for that module. It should export exactly what callers need — nothing more. Treat it as the public surface area of the module.

```
http_client/
├── mod.sfn          # Exports HttpClient, Request, Response
├── client.sfn       # HttpClient implementation (internal detail)
├── request.sfn      # Request builder (internal detail)
└── response.sfn     # Response parsing (internal detail)
```

### Capsule structure for libraries vs applications

A **library capsule** exports types and functions for other capsules to use. Minimize the public surface. Every exported symbol is a commitment.

An **application capsule** has a `fn main() ![...]` entry point and depends on library capsules. It is not imported by others.

```
# Library
my_http/
├── capsule.toml
└── src/
    ├── mod.sfn       # Public API
    ├── client.sfn
    └── request.sfn

# Application
my_app/
├── capsule.toml
└── src/
    ├── main.sfn      # Entry point
    ├── config.sfn
    └── handlers.sfn
```

### Import grouping

Group imports in this order, with a blank line between groups:

1. Standard library
2. External capsule dependencies
3. Local modules

```sfn
import { fs, http } from "std";

import { JsonParser } from "capsule:json-parser";
import { Logger } from "capsule:logger";

import { Config } from "./config";
import { validate_order } from "./validation";
```

---

## Performance Patterns

### Avoid unnecessary copies

When a function only needs to read a value, shape your API so callers can pass
the value by reference without surrendering it. The plan is to expose this via
explicit borrow syntax (`&T`), but ownership and borrowing are deferred until
after 1.0 — see the [roadmap](/roadmap). Today, prefer small structs and arrays
passed by value; the compiler is free to share underlying storage.

```sfn
// Today: pass-by-value, compiler shares storage where it can
fn summarise(records: Record[]) -> string { /* ... */ }
```

> **Coming in 1.0:** explicit borrow annotations (`&T`, `&mut T`) and
> `Affine<T>`/`Linear<T>` ownership markers parse today but are not enforced;
> they are tracked on the [roadmap](/roadmap). Do not rely on borrow-checker
> semantics yet.

### Batch effectful operations

Each effectful call has overhead. When writing to a file or making a network request, batch the data rather than calling in a tight loop.

```sfn
// Slow: one filesystem write per line
fn write_log_lines(lines: string[], path: string) -> void ![io] {
    for line in lines {
        fs.append(path, line + "\n");
    }
}

// Better: build the content first, write once
fn write_log_lines(lines: string[], path: string) -> void ![io] {
    let mut content: string = "";
    for line in lines {
        content = content + line + "\n";
    }
    fs.write(path, content);
}
```

> **Coming in 1.0:** closures that capture enclosing variables (needed for
> `.map(fn(l) -> string { return l + "\n"; })` to read surrounding state)
> are on the [roadmap](/roadmap). Until then, use explicit `for` loops when
> the body references captured bindings.

### Effect minimization enables optimizer improvements

Pure functions — those with no effects — are safe for the compiler to reorder, inline, and eliminate. As effect checking matures in the Sailfin optimizer, keeping more of your code pure will allow more aggressive optimization without any change to your source.

### Profile before optimizing

Do not rewrite code for performance without measuring first. A profile will tell you where the time actually goes. Sailfin's effect annotations make it easy to identify effectful paths — start there when looking for slowness.

---

## Working with the Type System

### Use type aliases for domain concepts

A bare `string` carrying a user ID and a bare `string` carrying an email address look identical to the compiler. A type alias makes the distinction explicit and catches transposed arguments.

```sfn
type UserId = string;
type EmailAddress = string;
type OrderId = string;

fn send_receipt(user: UserId, order: OrderId, email: EmailAddress) -> void ![io, net] { /* ... */ }

// Compiler can now catch: send_receipt(order_id, user_id, email)  — arguments transposed
```

### Use enums to make invalid states unrepresentable

If a struct has fields that are only valid in certain combinations, model those combinations as enum variants instead.

```sfn
// Hard to reason about — which fields are set in which states?
struct Connection {
    state: string;           // "connecting", "connected", "failed"
    socket: Socket?;
    error: string?;
    retry_count: number;
}

// Better: each variant carries exactly the data it needs
enum Connection {
    Connecting { attempt: number },
    Connected { socket: Socket },
    Failed { reason: string },
}
```

### Small, focused interfaces

An interface with two methods is easier to implement, test, and substitute than one with ten. If you find yourself writing large interfaces, look for natural splits.

```sfn
// Too many methods — hard to implement a test double
interface Database {
    fn find_user(self, id: UserId) -> User? ![io];
    fn save_user(self, user: User) -> void ![io];
    fn delete_user(self, id: UserId) -> void ![io];
    fn list_users(self, filter: UserFilter) -> User[] ![io];
    fn find_order(self, id: OrderId) -> Order? ![io];
    fn save_order(self, order: Order) -> void ![io];
    fn list_orders(self, user_id: UserId) -> Order[] ![io];
}

// Better: split by domain
interface UserStore {
    fn find(self, id: UserId) -> User? ![io];
    fn save(self, user: User) -> void ![io];
}

interface OrderStore {
    fn find(self, id: OrderId) -> Order? ![io];
    fn save(self, order: Order) -> void ![io];
    fn list_for_user(self, user_id: UserId) -> Order[] ![io];
}
```

### Generic functions vs concrete functions

Generics are valuable when a function's logic genuinely applies to any type that satisfies a constraint. Don't reach for generics just because a type could theoretically vary — wait until it actually does.

```sfn
// Overly generic — this is only ever called with string
fn first<T>(items: T[]) -> T? { /* ... */ }

// Fine as concrete until it needs to be generic
fn first_string(items: string[]) -> string? { /* ... */ }
```

> **Coming in 1.0:** generic type constraints (`fn sort<T: Comparable>`) and
> a first-class `Option<T>` type are tracked on the [roadmap](/roadmap). Today,
> use the `T?` optional-type sugar (which lowers to a `T | null` union).

---

## Testing Discipline

### Test-driven development flow

Writing the test before the implementation forces you to think about the interface before the internals. The sequence:

1. Write a test that describes the behavior you want.
2. Run it — it should fail (it has nothing to test yet).
3. Write the minimum implementation to make it pass.
4. Refactor the implementation without changing the tests.

This cycle keeps tests focused on behavior, not implementation details.

### Test the behavior, not the implementation

If your tests break when you refactor internals without changing behavior, the tests are too closely coupled to the implementation. Tests should describe what the function does from the outside.

```sfn
// Tests implementation detail (internal data structure layout)
test "parser stores tokens in internal buffer" {
    let p: Parser = Parser.new("fn main() {}");
    assert p._token_buffer.length == 7;  // fragile
}

// Tests observable behavior
test "parser produces a function declaration from valid source" {
    let program: Program = parse("fn main() {}");
    assert program.statements.length == 1;
    assert program.statements[0].is_function_decl();
}
```

### Write a regression test for every bug fix

Before fixing a bug:

1. Write a test that reproduces the bug. It should fail.
2. Fix the bug.
3. Confirm the test passes.
4. Keep the test forever.

This makes the bug report a permanent part of your test suite.

### Keep tests fast

Slow tests get skipped. Separate pure unit tests from integration tests that touch the filesystem or network. Run pure tests on every save; run integration tests before committing.

---

## Common Pitfalls

### Forgetting to declare an effect

The most common error for new Sailfin programmers. The compiler message includes the missing effect and a fix-it hint:

```
effects.missing: function `process` calls `fetch` which requires ![net],
                 but `process` only declares ![io]
  = help: add `net` to the effect list: `fn process(url: string) ![io, net]`
```

The fix: add the missing effect to the function signature.

### Anticipating borrow semantics

Ownership and borrow annotations (`&T`, `&mut T`, `Affine<T>`, `Linear<T>`)
are parsed today but not enforced — they are scheduled for the post-1.0
ownership milestone (see the [roadmap](/roadmap)). Until then, write signatures
in terms of plain types and design for reference semantics in your head. When
borrows ship, reserve `&T` for read-only access and `&mut T` for mutation:

```sfn
// Today: plain pass-by-value signature
fn greet(name: string) -> void ![io] {
    print("Hello, {{name}}!");
}
```

> **Coming in 1.0:** explicit borrow annotations will let callers keep access
> to `name` while `greet` merely reads it. Do not ship code today that relies
> on borrow-checker enforcement — there is none.

### Deeply nested match expressions

When match arms contain match expressions that contain match expressions, the code becomes hard to follow. Extract inner matches into named helper functions.

```sfn
// Hard to follow
match request.method {
    "GET" => {
        let parsed: Id | ParseError = parse_id(request.path);
        if parsed is ParseError {
            return respond_bad_request(parsed.message);
        }
        let record: Record? = db.find(parsed);
        if record == null {
            return respond_not_found();
        }
        return respond_ok(record);
    },
    _ => return respond_method_not_allowed(),
}

// Better: named helpers
fn handle_get(request: Request) -> Response ![io] {
    let parsed: Id | ParseError = parse_id(request.path);
    if parsed is ParseError {
        return respond_bad_request(parsed.message);
    }
    let record: Record? = db.find(parsed);
    if record == null {
        return respond_not_found();
    }
    return respond_ok(record);
}

match request.method {
    "GET" => return handle_get(request),
    _     => return respond_method_not_allowed(),
}
```

> **Coming in 1.0:** `Result<T, E>`, the `?` propagation operator, and a
> first-class `Option<T>` (with `Some`/`None` patterns) are on the
> [roadmap](/roadmap). Today, discriminate union returns with `is` and compare
> optional values to `null`.

### Using `print.info()` — it is deprecated

Earlier versions of Sailfin used `print.info()` for stdout. This is deprecated. Use `print()` for stdout and `print.err()` for stderr.

```sfn
// Deprecated — do not use
print.info("Processing {{id}}");
print.error("Failed: {{e.message}}");

// Correct
print("Processing {{id}}");
print.err("Failed: {{e.message}}");
```

---

## Next Steps

- [Testing](/docs/learn/testing) — Testing guide with patterns and examples
- [The Effect System](/docs/learn/effects) — Deep dive into capability declarations
- [Ownership & Borrowing](/docs/learn/ownership) — Memory safety model
- [Language Spec](/docs/reference/spec/) — Complete formal reference, by chapter
