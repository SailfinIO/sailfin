---
title: Effective Sailfin
description: Idiomatic patterns, naming conventions, and best practices for writing clear, safe, and maintainable Sailfin.
section: learn
order: 10
---

This guide covers the idioms and practices that make Sailfin code easy to read, safe to modify, and efficient to run. It is similar in spirit to [Effective Go](https://go.dev/doc/effective_go) — less a reference and more an opinionated guide to writing code that fits the language.

None of this is enforced by the compiler (except where noted). These are conventions the Sailfin community converges on because they make codebases easier to work with.

## Naming Conventions

Consistent naming reduces the mental overhead of reading unfamiliar code.

### Types, structs, enums, interfaces — `PascalCase`

```sfn
struct HttpClient { ... }
enum Direction { North, South, East, West }
interface Serializable { ... }
type UserId = String;
```

### Functions, methods, variables, fields — `snake_case`

```sfn
fn fetch_and_parse(url: String) -> Document ![io, net] { ... }

let retry_count = 3;
let mut pending_jobs: Vec<Job> = Vec.new();
```

```sfn
struct UserProfile {
    display_name -> String;
    email_address -> String;
    created_at -> Int;
}
```

### Constants — `UPPER_SNAKE_CASE`

```sfn
let MAX_RETRIES = 3;
let DEFAULT_TIMEOUT_MS = 5000;
let BASE_URL = "https://api.example.com";
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
fn FetchData(url: String) -> String ![net] { ... }

// Wrong: types should not be snake_case
struct user_profile { ... }

// Wrong: constants should not be camelCase
let maxRetries = 3;
```

---

## Effect Discipline

The effect system is Sailfin's most distinctive feature. Used well, it makes the boundary between pure computation and side effects explicit, which benefits readability, testability, and optimizer performance.

### Declare the narrowest effects possible

Only list the effects a function actually needs. This is not just style — it is safety. A function that declares `![io, net, model]` but only needs `![io]` has been granted capabilities it doesn't use, which makes it harder to reason about.

```sfn
// Too broad
fn format_report(data: Array<Record>) -> String ![io, net, model] {
    return data.map(|r| "{{r.name}}: {{r.value}}").join("\n");
}

// Correct — this function is pure
fn format_report(data: Array<Record>) -> String {
    return data.map(|r| "{{r.name}}: {{r.value}}").join("\n");
}
```

### Separate pure computation from effectful operations

Write your logic as pure functions, then call them from effectful entry points. This pattern makes individual functions easier to test and reason about.

```sfn
// Before: computation and IO tangled together
fn process_and_save(records: Array<Record>, path: String) ![io] {
    let mut output = "";
    for r in records {
        let line = "{{r.name}},{{r.value}}\n";
        output = output + line;
    }
    fs.write(path, output);
}

// After: pure function + thin effectful wrapper
fn format_csv(records: Array<Record>) -> String {
    return records.map(|r| "{{r.name}},{{r.value}}").join("\n");
}

fn save_csv(records: Array<Record>, path: String) ![io] {
    let content = format_csv(records);
    fs.write(path, content);
}
```

`format_csv` is now independently testable without any filesystem setup.

### Group effectful operations at boundaries

Push effects toward the edges of your system — main functions, HTTP handlers, event loops. The more of your codebase that is pure, the more of it can be tested without infrastructure.

```sfn
// Pure domain logic
fn validate_order(order: Order) -> Result<Order, ValidationError> { ... }
fn calculate_total(order: Order) -> Float { ... }
fn apply_discount(order: Order, code: String) -> Order { ... }

// Thin effectful entry point
fn handle_order_request(req: HttpRequest) -> HttpResponse ![io, net] {
    let order = Order.from_request(req);
    let validated = match validate_order(order) {
        Ok(o) => o,
        Err(e) => return HttpResponse.bad_request(e.message),
    };
    let total = calculate_total(apply_discount(validated, req.discount_code));
    db.save_order(validated);
    return HttpResponse.ok("Total: {{total}}");
}
```

---

## Struct Design

### Use `->` for field declarations

Sailfin uses `name -> Type;` syntax for struct fields (semicolon-terminated). This visually distinguishes struct field declarations from function parameter lists.

```sfn
struct Connection {
    host -> String;
    port -> Int;
    timeout_ms -> Int;
    is_tls -> Bool;
}
```

### Prefer immutable fields; use `mut` only when needed

Most fields do not need to change after construction. Marking a field mutable is a signal that it changes during the object's lifetime — make that explicit and intentional.

```sfn
// Good: fields are immutable by default
struct Config {
    host -> String;
    port -> Int;
    max_connections -> Int;
}

// Only when mutation is genuinely required
struct RateLimiter {
    max_per_second -> Int;
    mut current_count -> Int;
    mut window_start -> Int;
}
```

### Small, focused structs

A struct that does one thing is easier to test and reuse than one that does many.

```sfn
// Hard to work with — mixes concerns
struct Request {
    url -> String;
    method -> String;
    headers -> Array<Header>;
    body -> String;
    retry_count -> Int;
    timeout_ms -> Int;
    auth_token -> String;
    log_requests -> Bool;
}

// Better: separate what belongs together
struct Request {
    url -> String;
    method -> String;
    headers -> Array<Header>;
    body -> String;
}

struct RetryPolicy {
    max_attempts -> Int;
    timeout_ms -> Int;
}

struct HttpClient {
    auth_token -> String;
    retry_policy -> RetryPolicy;
    log_requests -> Bool;
}
```

### Interface-driven design

Define interfaces for any type you want to substitute or test in isolation. Small, focused interfaces are more useful than large, prescriptive ones.

```sfn
// Too large — forces implementers to provide everything at once
interface Store {
    fn get(key: String) -> String;
    fn set(key: String, value: String) ![io];
    fn delete(key: String) ![io];
    fn list_keys() -> Array<String> ![io];
    fn flush() ![io];
    fn compact() ![io];
}

// Better: split by usage pattern
interface Reader {
    fn get(key: String) -> String ![io];
}

interface Writer {
    fn set(key: String, value: String) ![io];
    fn delete(key: String) ![io];
}
```

Code that only reads can accept a `Reader`. Code that reads and writes accepts both. This makes substitution easier and intent clearer.

---

## Error Handling Idioms

### Use `Result<T, E>` for expected failures

If a function can fail in a way that callers should be prepared to handle, return a `Result`. This makes the failure mode part of the function's type signature and forces callers to acknowledge it.

```sfn
enum ConfigError {
    NotFound(String),
    ParseFailed(String),
    PermissionDenied,
}

fn load_config(path: String) -> Result<Config, ConfigError> ![io] { ... }
```

### Use `try/catch` for exceptional conditions

`try/catch` is for situations that are not expected in normal operation and cannot easily be threaded through return types — corrupted files, out-of-memory conditions, unexpected network resets.

```sfn
fn main() ![io] {
    try {
        let config = load_config("app.toml");
        run(config);
    } catch (e: ConfigError) {
        print.err("Configuration error: {{e.message}}");
    } catch (e) {
        print.err("Unexpected error: {{e.message}}");
    }
}
```

### Always provide context in error messages

An error message that says "file not found" is harder to debug than one that says "config file not found: /home/user/.config/myapp/app.toml". Include the relevant input in the message.

```sfn
// Bad
throw IoError { message: "file not found" };

// Good
throw IoError { message: "config file not found: {{path}}" };
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
    print.err("Cache invalidation failed for {{key}}: {{e.message}}");
}
```

---

## Function Design

### Single responsibility

A function should do one thing. If you find yourself writing "and" in a function's name or docstring, it probably does two things.

```sfn
// Does too much
fn fetch_validate_and_save(url: String, path: String) ![io, net] { ... }

// Better: separate responsibilities
fn fetch(url: String) -> Response ![net] { ... }
fn validate(response: Response) -> Result<Data, ValidationError> { ... }
fn save(data: Data, path: String) ![io] { ... }
```

### Pure functions where possible

A pure function — one with no effects — is always easier to reason about, test, and compose than an effectful one. Reach for pure functions first and add effects only when required.

### Descriptive parameter names

Parameter names at a call site communicate intent. Single-letter names save typing but cost the reader context.

```sfn
// Unclear at the call site: rotate(img, 90, true)
fn rotate(i: Image, d: Int, c: Bool) -> Image { ... }

// Clear: rotate(avatar, 90, clockwise: true)
fn rotate(image: Image, degrees: Int, clockwise: Bool) -> Image { ... }
```

### Avoid deeply nested effects — extract helpers

When a function has many effects and a long body, it becomes difficult to understand what any single part of it does. Extract named helpers to break it up.

```sfn
// Hard to follow — a wall of effects and steps
fn deploy(config: Config) ![io, net, clock] {
    print("Validating...");
    let validation = validate_config(config);
    if validation.is_err() { throw validation.unwrap_err(); }
    print("Uploading artifacts...");
    let upload_result = http.post(config.registry_url, config.artifact);
    if upload_result.status != 200 { throw DeployError { message: "upload failed" }; }
    print("Waiting for health check...");
    let mut attempts = 0;
    loop {
        runtime.sleep(2000);
        let health = http.get("{{config.base_url}}/health");
        if health.status == 200 { break; }
        attempts = attempts + 1;
        if attempts > 10 { throw DeployError { message: "health check timed out" }; }
    }
    print("Deploy complete.");
}

// Better: named helpers make each phase clear
fn upload_artifact(config: Config) ![net] { ... }
fn await_healthy(base_url: String) ![net, clock] { ... }

fn deploy(config: Config) ![io, net, clock] {
    validate_config(config).unwrap_or_throw();
    print("Uploading artifacts...");
    upload_artifact(config);
    print("Waiting for service to become healthy...");
    await_healthy(config.base_url);
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
    Failed(String),
}

fn describe(status: Status) -> String {
    match status {
        Pending    => "waiting to start",
        Running    => "currently executing",
        Succeeded  => "finished successfully",
        Failed(msg) => "failed: {{msg}}",
    }
}
```

### Prefer `match` over chains of `if/else` for type discrimination

```sfn
// Hard to read — repeated variable extraction
if result.is_ok() {
    let value = result.unwrap();
    process(value);
} else {
    let err = result.unwrap_err();
    print.err("Error: {{err}}");
}

// Better — clear and exhaustive
match result {
    Ok(value) => process(value),
    Err(err)  => print.err("Error: {{err}}"),
}
```

### Use guard conditions to narrow cases

Guards let you add a boolean condition to a match arm, expressed with `if`:

```sfn
match event {
    Click { x, y } if x < 0 || y < 0 => handle_out_of_bounds(x, y),
    Click { x, y }                    => handle_click(x, y),
    KeyPress { key } if key == "Escape" => close_dialog(),
    KeyPress { key }                    => handle_key(key),
    Resize { width, height }            => handle_resize(width, height),
}
```

### Don't use `_` when you can be specific

The wildcard `_` matches any value. Overusing it can hide the fact that a case is not handled. Be specific when the cases are finite and known.

```sfn
// Risky: if a new Direction variant is added, this silently falls through
match direction {
    North => move_up(),
    South => move_down(),
    _     => move_sideways(),   // catches East and West, but also any future variants
}

// Better: explicit
match direction {
    North => move_up(),
    South => move_down(),
    East  => move_right(),
    West  => move_left(),
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

### Avoid unnecessary copies — use borrows

When a function only needs to read a value, take a borrow (`&T`) rather than ownership. Taking ownership forces the caller to give up the value or clone it.

```sfn
// Takes ownership — caller can't use records afterwards
fn summarise(records: Array<Record>) -> String { ... }

// Takes a borrow — caller retains ownership
fn summarise(records: &Array<Record>) -> String { ... }
```

### Batch effectful operations

Each effectful call has overhead. When writing to a file or making a network request, batch the data rather than calling in a tight loop.

```sfn
// Slow: one filesystem write per line
fn write_log_lines(lines: Array<String>, path: String) ![io] {
    for line in lines {
        fs.appendFile(path, line + "\n");
    }
}

// Better: build the content first, write once
fn write_log_lines(lines: Array<String>, path: String) ![io] {
    let content = lines.map(|l| l + "\n").join("");
    fs.write(path, content);
}
```

### Effect minimization enables optimizer improvements

Pure functions — those with no effects — are safe for the compiler to reorder, inline, and eliminate. As effect checking matures in the Sailfin optimizer, keeping more of your code pure will allow more aggressive optimization without any change to your source.

### Profile before optimizing

Do not rewrite code for performance without measuring first. A profile will tell you where the time actually goes. Sailfin's effect annotations make it easy to identify effectful paths — start there when looking for slowness.

---

## Working with the Type System

### Use type aliases for domain concepts

A bare `String` carrying a user ID and a bare `String` carrying an email address look identical to the compiler. A type alias makes the distinction explicit and catches transposed arguments.

```sfn
type UserId = String;
type EmailAddress = String;
type OrderId = String;

fn send_receipt(user: UserId, order: OrderId, email: EmailAddress) ![io, net] { ... }

// Compiler can now catch: send_receipt(order_id, user_id, email)  — arguments transposed
```

### Use enums to make invalid states unrepresentable

If a struct has fields that are only valid in certain combinations, model those combinations as enum variants instead.

```sfn
// Hard to reason about — which fields are set in which states?
struct Connection {
    state -> String;         // "connecting", "connected", "failed"
    socket -> Option<Socket>;
    error -> Option<String>;
    retry_count -> Int;
}

// Better: each variant carries exactly the data it needs
enum Connection {
    Connecting { attempt -> Int },
    Connected { socket -> Socket },
    Failed { reason -> String },
}
```

### Small, focused interfaces

An interface with two methods is easier to implement, test, and substitute than one with ten. If you find yourself writing large interfaces, look for natural splits.

```sfn
// Too many methods — hard to implement a test double
interface Database {
    fn find_user(id: UserId) -> Option<User> ![io];
    fn save_user(user: User) ![io];
    fn delete_user(id: UserId) ![io];
    fn list_users(filter: UserFilter) -> Array<User> ![io];
    fn find_order(id: OrderId) -> Option<Order> ![io];
    fn save_order(order: Order) ![io];
    fn list_orders(user_id: UserId) -> Array<Order> ![io];
}

// Better: split by domain
interface UserStore {
    fn find(id: UserId) -> Option<User> ![io];
    fn save(user: User) ![io];
}

interface OrderStore {
    fn find(id: OrderId) -> Option<Order> ![io];
    fn save(order: Order) ![io];
    fn list_for_user(user_id: UserId) -> Array<Order> ![io];
}
```

### Generic functions vs concrete functions

Generics are valuable when a function's logic genuinely applies to any type that satisfies a constraint. Don't reach for generics just because a type could theoretically vary — wait until it actually does.

```sfn
// Overly generic — this is only ever called with String
fn first<T>(items: Array<T>) -> Option<T> { ... }

// Fine as concrete until it needs to be generic
fn first_string(items: Array<String>) -> Option<String> { ... }
```

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
    let p = Parser.new("fn main() {}");
    assert(p._token_buffer.length == 7);  // fragile
}

// Tests observable behavior
test "parser produces a function declaration from valid source" {
    let program = parse("fn main() {}");
    assert(program.statements.length == 1);
    assert(program.statements[0].is_function_decl());
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
  = help: add `net` to the effect list: `fn process(url: String) ![io, net]`
```

The fix: add the missing effect to the function signature.

### Taking ownership when a borrow was intended

If a helper function only reads from a value, take `&T` rather than `T`. Requiring ownership is a stronger contract and forces callers to either transfer ownership permanently or clone the value.

```sfn
// Takes ownership — caller loses access to `name`
fn greet(name: String) ![io] {
    print("Hello, {{name}}!");
}

// Takes a borrow — caller keeps `name`
fn greet(name: &String) ![io] {
    print("Hello, {{name}}!");
}
```

### Deeply nested match expressions

When match arms contain match expressions that contain match expressions, the code becomes hard to follow. Extract inner matches into named helper functions.

```sfn
// Hard to follow
match request.method {
    "GET" => match parse_id(request.path) {
        Ok(id) => match db.find(id) {
            Some(record) => respond_ok(record),
            None         => respond_not_found(),
        },
        Err(e) => respond_bad_request(e.message),
    },
    _ => respond_method_not_allowed(),
}

// Better: named helpers
fn handle_get(request: Request) -> Response ![io] {
    let id = parse_id(request.path).map_err(|e| respond_bad_request(e.message))?;
    match db.find(id) {
        Some(record) => respond_ok(record),
        None         => respond_not_found(),
    }
}

match request.method {
    "GET" => handle_get(request),
    _     => respond_method_not_allowed(),
}
```

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
- [Language Spec](/docs/reference/spec) — Complete formal reference
