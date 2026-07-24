---
title: Keywords
description: Complete reference for every reserved keyword in the Sailfin language, with status, semantics, and examples.
section: reference
sidebar:
  order: 3
---

This page lists every reserved keyword in Sailfin. For each keyword, the implementation status is one of:

- **Implemented** — fully enforced in the current compiler and runtime
- **Parsed** — recognized by the parser and captured in the AST, but semantic rules are not yet enforced
- **Parsed + IR** — parsed and lowered to `.sfn-asm` IR, but runtime execution is not available
- **Planned** — not yet in the parser; reserved for a future release

---

## Declarations

### `fn`

**Status: Implemented**

Declare a named function. Parameters use `name: Type` syntax. The return type follows `->`. Effect annotations follow the return type using `![effect, ...]`.

```sfn
fn add(x: int, y: int) -> int {
    return x + y;
}

fn greet(name: string) ![io] {
    print("Hello, {{ name }}!");
}
```

Default parameter values and generic type parameters are supported:

```sfn
fn find_char(text: string, ch: string, start: int = 0) -> int {
    // ...
}

fn identity<T>(value: T) -> T {
    return value;
}
```

---

### `async`

**Status: Parsed**

Mark a function as asynchronous. The `async` modifier is recognized by the
parser and captured in the AST, but its return value is not yet a live future.
Currently, `async fn` is structurally identical to `fn` at runtime.

```sfn
async fn fetch_user(id: string) -> User ![net] {
    // Runs synchronously in v0.
    return http.get("/users/{{ id }}");
}
```

> **Note:** `await` works on a future created by `spawn`; awaiting an `async fn`
> return value is not yet wired into the live typecheck walk. See
> [Concurrency](#concurrency).

---

### `let`

**Status: Implemented**

Declare an immutable variable binding. Variables declared with `let` cannot be reassigned. Type annotations are optional; the compiler performs limited inference. The initializer may be omitted (the binding is initialized to `null`).

```sfn
let name = "Sailfin";
let count: int = 0;
let message: string;   // initialized to null
```

---

### `mut`

**Status: Implemented**

Combined with `let`, allows a binding to be reassigned after declaration. A `mut` binding is still block-scoped.

```sfn
let mut counter = 0;
counter = counter + 1;

let mut results: string[] = [];
results.push("new item");
```

---

### `thread_local`

**Status: Implemented**

Storage-class prefix for top-level `let mut` declarations. Flips the backing storage from a process-global to per-thread (ELF TLS): the binding lowers to `@global.<name> = internal thread_local global <T> <init>` instead of `internal global`. Reads and writes against the binding use the same `@global.<name>` symbol, so the prefix is invisible to call sites.

```sfn
// Per-thread counter — each thread's storage starts at 0
thread_local let mut request_counter: i64 = 0;
```

`thread_local` is rejected on function-local `let` (an `alloca` is already stack-local and cannot be TLS) and on immutable bindings (`thread_local let x` reports `E0807` — an immutable thread-local is a contradiction). The prefix exists ahead of the M4 scheduler (#321) so per-thread runtime state ships before any concurrency primitive lands.

---

### `struct`

**Status: Implemented**

Define a named product type with labeled fields. Field declarations use `name: Type;` syntax. Structs may carry generic type parameters and may implement interfaces.

```sfn
struct Point {
    x: float;
    y: float;
}

struct Response<T> {
    status: int;
    body: T;
}

struct User implements Printable {
    id: int;
    name: string;
    email: string;
}
```

Instantiation uses `StructName { field: value, ... }`:

```sfn
let p: Point = Point { x: 3.0, y: 7.0 };
```

---

### `enum`

**Status: Implemented**

Define a sum type (algebraic data type). Each variant may carry zero or more payload fields. Match expressions are the primary way to destructure enum values.

```sfn
enum Shape {
    Circle { radius: float },
    Rectangle { width: float, height: float },
    Point,
}

fn area(shape: Shape) -> float {
    match shape {
        Shape.Circle { radius } => return 3.14159 * radius * radius,
        Shape.Rectangle { width, height } => return width * height,
        Shape.Point => return 0.0,
    }
}
```

---

### `interface`

**Status: Implemented (basic checks)**

Declare a named set of method signatures that a struct must fulfill. Structs opt in via `implements InterfaceName`. Interface conformance checking performs basic validation; variance rules are not yet enforced.

```sfn
interface Printable {
    fn display(self) -> string;
}

struct Greeting implements Printable {
    message: string;

    fn display(self) -> string {
        return self.message;
    }
}
```

---

### `type`

**Status: Implemented**

Introduce a type alias. Aliases may carry generic type parameters.

```sfn
type UserId = string;
type MaybeError<T> = T | ParseError;
```

> **Note:** The prelude `Result<T, E>` type and postfix `?` propagation operator
> ship today; see [Result and the `?` Operator](/docs/reference/spec/12-result-and-errors/).
> Function type aliases (`type Handler = fn(...) -> ...`) remain planned; use
> plain function signatures for those today.

---

### `extern`

**Status: Implemented** (parser, typechecker, native-IR emitter, LLVM `declare` lowering)

Declare an external symbol provided by a linked platform library (libc, libpthread, etc.). The compiler emits an LLVM `declare` directive for each `extern fn`; the linker resolves the symbol against platform shared libraries at link time.

```sfn
extern fn write(fd: i32, buf: *u8, count: i64) -> i64;
unsafe extern fn malloc(size: usize) -> *u8;
unsafe extern fn free(ptr: *u8) -> void;
```

`extern fn` signatures must use only C-ABI-compatible types that the LLVM backend can lower today: `int` (i64), `float` / `f64` (double), `f32` (single-precision float), `i8`, `i16`, `i32`, `i64`, `u8`, `u16`, `u32`, `u64`, `usize` (i64), `isize` (i64), `bool`, `void` (return only), raw pointers (`*T`, `**T`, `*const T`, `*mut T`, `*OpaqueStruct`, `*void`), or function pointers (`fn(A) -> B`). `usize`/`isize` are pointer-sized aliases that lower to `i64` on every platform Sailfin currently targets. Sailfin aggregates (`string`, `T[]`, structs) cannot cross the extern boundary directly — adapters must decompose them into pointer + length pairs first. Externs must not declare effects (`![io]`, `![net]`, …); effects belong on the wrapping adapter, not the raw extern.

Diagnostic codes: `E0801` (`string` parameter/return), `E0802` (array), `E0803` (type parameters), `E0804` (effects on the extern), `E0805` (other non-C-ABI types — including the legacy `number` alias).

`unsafe` is optional on extern declarations and primarily documents the call site as opting out of Sailfin's safety story.

---

### `unsafe`

**Status: Parsed**

Mark a block or function as opting out of Sailfin's safety guarantees. Recognized by the parser; semantic restrictions are not yet enforced.

```sfn
unsafe fn write_raw(ptr: *mut u8, value: u8) -> void {
    // raw memory access — safety not enforced yet
}
```

---

### `test`

**Status: Implemented**

Declare a named test case. Test files use the `*_test.sfn` naming convention. The `assert` statement is available inside test bodies.

```sfn
test "addition works" {
    let result = add(2, 3);
    assert result == 5;
}

test "string length" {
    let s = "hello";
    assert s.length == 5;
}
```

Run tests with `sfn test` or `make test`.

---

## Control Flow

### `if` / `else`

**Status: Implemented**

Conditional branching. Both `if` and `else if` chains are supported. The `else` branch is optional. Braces are required.

```sfn
if score >= 90 {
    print("A");
} else if score >= 80 {
    print("B");
} else {
    print("C");
}
```

---

### `for` / `in`

**Status: Implemented**

Iterate over a collection. The iteration variable is immutable within the loop body.

```sfn
for item in items {
    print("{{ item }}");
}

for i in 0..10 {
    print("{{ i }}");
}
```

---

### `while`

**Status: Implemented**

Repeat a block while its condition is true. The parser desugars this form to
the equivalent `loop` plus a leading conditional `break`, so `break`,
`continue`, nesting, effects, and block scope follow the canonical loop path.

```sfn
let mut n: int = 1;
while n < 100 {
    n = n * 2;
}
```

---

### `loop`

**Status: Implemented**

Unconditional loop. Use `break` to exit. This is the primary looping construct used in the self-hosted compiler internals.

```sfn
let mut index: int = 0;
loop {
    if index >= items.length {
        break;
    }
    print("{{ items[index] }}");
    index = index + 1;
}
```

---

### `break`

**Status: Implemented**

Exit the innermost `loop`, `while`, or `for` loop immediately.

```sfn
loop {
    if done {
        break;
    }
    do_work();
}
```

---

### `continue`

**Status: Implemented**

Skip the remainder of the current iteration and proceed to the next.

```sfn
for item in items {
    if item == null {
        continue;
    }
    process(item);
}
```

---

### `return`

**Status: Implemented**

Return a value from a function. An unadorned `return` with no expression is valid in `void` functions.

```sfn
fn find(items: int[], target: int) -> int {
    let mut i: int = 0;
    loop {
        if i >= items.length {
            return -1;
        }
        if items[i] == target {
            return i;
        }
        i = i + 1;
    }
}
```

---

### `match`

**Status: Implemented**

Pattern-match a value against a set of arms. Supports literal patterns, `_` wildcard, and enum variant destructuring. Guards are supported. A runtime backstop (`match_exhaustive_failed`) fires if no arm matches at runtime.

```sfn
match status {
    200 => print("OK"),
    404 => print("Not found"),
    500 => print("Server error"),
    _ => print("Unknown: {{ status }}"),
}

match shape {
    Shape.Circle { radius } => return 3.14159 * radius * radius,
    Shape.Rectangle { width, height } => return width * height,
    _ => return 0.0,
}
```

---

### `try` / `catch` / `finally`

**Status: Implemented**

Structured exception handling. The `finally` block runs whether or not an exception was thrown. The `catch` clause binds the caught value.

```sfn
fn read_config(path: string) -> string ![io] {
    try {
        return fs.read(path);
    } catch (err) {
        print.err("failed to read config: {{ err }}");
        return "{}";
    } finally {
        print("config read attempted");
    }
}
```

---

### `throw`

**Status: Implemented**

Raise an exception value. The thrown value can be caught by an enclosing `catch` block.

```sfn
fn divide(a: float, b: float) -> float {
    if b == 0 {
        throw "division by zero";
    }
    return a / b;
}
```

---

## Concurrency

The shipped v0 surface is `routine { ... }`, `spawn fn() -> T { ... }`, and
`await task`. These are language constructs, not prelude functions. The example
below is checked from
[`examples/concurrency/routine-spawn-await.sfn`](https://github.com/SailfinIO/sailfin/blob/main/examples/concurrency/routine-spawn-await.sfn).

```sfn
// Shipped v0 structured concurrency: a routine nursery joins its spawned task.
fn main() ![io] {
    routine {
        let task = spawn fn () -> int { return 40 + 2; };
        let result: int = await task;
        print("Result: {{result}}");
    }
}
```

### `routine`

**Status: Implemented (v0 nursery)**

Open a structured-concurrency nursery with `routine { body }`. Leaving the
block waits for every task spawned in that nursery, so no child outlives it.
Named `routine "name" { ... }` syntax is not part of v0. Non-local exits from
the body are rejected. v0 joins all tasks without cancel-on-fault, does not
destroy the nursery after joining, and keeps nursery state per thread.

---

### `scope`

**Status: Not a language construct**

Earlier previews used `scope { ... }` for structured concurrency. That design
was superseded: `routine { ... }` is the shipped nursery boundary. `scope` is
not a keyword or a planned alias.

---

### `await`

**Status: Implemented for spawned tasks (v0)**

Join a future returned by `spawn` and produce its typed result. Awaiting an
`async fn` return value is not yet wired into the live typecheck walk.

---

### `spawn`

**Status: Implemented (v0)**

Spawn a zero-argument task lambda on the runtime thread pool. The shipped typed
form is `spawn fn() -> T { ... }`; the return type selects the future kind and
`await` joins the task. `spawn` requires `![io]` in v0. A captured owned value
moves into the task and cannot be reused by the sender.

---

## AI and Domain Keywords

The `model`, `prompt`, `tool`, and `pipeline` block keywords have been removed
from the language. AI functionality is being delivered as a post-1.0 library
via the `sfn/ai` capsule. The `![model]` effect remains in the language as the
capability gate for any code that calls into AI library functions.

---

## Module Keywords

### `import`

**Status: Implemented**

Bring declarations from another module into scope. Sailfin uses ES-module-style named imports.

```sfn
import { substring, find_char } from "prelude";
import { log } from "sfn/log";
import { UserService } from "./services/user";
```

---

### `export`

**Status: Implemented**

Make declarations available to importers. Supports aliasing with `as`.

```sfn
export { add, subtract };
export { add as plus, subtract as minus };
export { substring, find_char as locate } from "./string_utils";
```

---

### `from`

**Status: Implemented**

Used as part of `import ... from "..."` and `export ... from "..."` syntax. Not a standalone keyword.

---

### `as`

**Status: Implemented**

Rename an imported or exported identifier.

```sfn
import { find_char as locate } from "prelude";
export { add as plus };
```

---

## Literal Keywords

### `true` / `false`

**Status: Implemented**

Boolean literal values.

```sfn
let is_valid: boolean = true;
let is_done: boolean = false;

if is_valid && !is_done {
    print("still running");
}
```

---

### `null`

**Status: Implemented**

The absence of a value. A type suffixed with `?` is a union with `null` (e.g., `string?` means `string | null`).

```sfn
let user: User? = null;

fn find_user(id: string) -> User? {
    // ...
    return null;
}
```

---

## Ownership and Safety Keywords

Ownership enforcement is shipped for `Affine<T>` and `Linear<T>`; the other
wrappers in this section remain syntax-only.

### `Affine<T>`

**Status: Single-use enforced**

An affine type wrapper: the value may be dropped without being consumed, but
cannot be duplicated. Move and use-after-move violations are rejected with
`E0901` or `E0904`.

```sfn
fn ingest(batch: Affine<DataChunk>) ![gpu] {
    // batch must not be duplicated; may be dropped
    process(batch);
}
```

---

### `Linear<T>`

**Status: Exactly-once enforced**

A linear type wrapper: the value must be consumed exactly once. Move and
use-after-move violations are rejected with `E0901` or `E0904`; leaving scope
without consuming the value is rejected with `E0907`.

```sfn
fn send_message(msg: Linear<Message>) ![net] {
    // msg must be consumed exactly once
    deliver(msg);
}
```

---

### `PII<T>`

**Status: Parsed only**

Marks a value as containing personally identifiable information. Planned to prevent PII from flowing to `net` or `model` effects without explicit declassification. No taint enforcement today.

```sfn
fn render_invoice(user: PII<User>) -> string ![io] {
    // PII<T> is a nominal type today; no enforcement ([roadmap](/roadmap))
    return build_html(user.name, user.email);
}
```

---

### `Secret<T>`

**Status: Parsed only**

Marks a value as a secret (e.g., API key, password). Planned to prevent secrets from appearing in logs or being transmitted without explicit handling. No taint enforcement today.

```sfn
fn connect(api_key: Secret<string>) ![net] {
    // Secret<T> is a nominal type today; no enforcement ([roadmap](/roadmap))
    let response = http.get("https://api.example.com?key={{ api_key }}");
}
```

---

## Unsafe and FFI Keywords

### `unsafe` (block)

**Status: Parsed**

Opt out of Sailfin's safety guarantees for a block or function. Syntax is accepted; no additional permissions are granted or revoked at this time.

```sfn
unsafe fn write_ptr(ptr: *mut u8, offset: usize, value: u8) -> void {
    // raw pointer arithmetic — not enforced yet
}
```

---

### `extern`

**Status: Implemented**

Declare a symbol that is provided by the native linker or runtime. Declaration
validation and native lowering are shipped; locally declared extern calls also
participate in the ownership check at the `unsafe` boundary.

```sfn
unsafe extern fn platform_clock() -> i64;
```

---

### `raw`

**Status: Parsed**

Used in the `&raw x` borrow form to create a raw pointer from a value. Raw
pointer expressions and the matching pointer types are only usable inside an
`unsafe { }` block.

```sfn
unsafe {
    let ptr: *u8 = &raw buffer;
    // ... raw pointer operations
}
```

---

### `opaque`

**Status: Parsed**

Used in the pointer type `*opaque` to denote an opaque foreign pointer
(equivalent to C's `void*`) — most often in FFI declarations.

```sfn
unsafe extern fn fopen(path: *u8, mode: *u8) -> *opaque;
```

---

## Other Keywords

### `in`

**Status: Implemented**

Used in `for ... in ...` iteration. Not a standalone expression keyword.

```sfn
for item in collection {
    print(item);
}
```

---

### `assert`

**Status: Implemented**

Assert that a condition is true. Raises a runtime error with a diagnostic if the condition is false. Available inside `test` blocks and ordinary functions.

```sfn
test "bounds are valid" {
    let s = "hello";
    assert s.length == 5;
    assert substring(s, 1, 3) == "el";
}
```

---

### `self`

**Status: Implemented**

Refer to the current struct instance inside a method body.

```sfn
struct Counter {
    value: int;

    fn increment(self) -> Counter {
        return Counter { value: self.value + 1 };
    }
}
```

---

### `implements`

**Status: Implemented (basic)**

Declare that a struct conforms to one or more interfaces. Multiple interfaces are listed with commas.

```sfn
struct MyLogger implements Logger, Printable {
    // must provide methods declared in Logger and Printable
}
```

---

*For an at-a-glance view of which features are fully shipped, partially implemented, or planned, see the [Language Spec](/docs/reference/spec/) chapters (current language) and [Design Preview](/docs/reference/preview/) pages (planned features).*
