---
title: Keywords
description: Complete reference for every reserved keyword in the Sailfin language, with status, semantics, and examples.
section: reference
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
fn add(x: number, y: number) -> number {
    return x + y;
}

fn greet(name: string) ![io] {
    print("Hello, {{ name }}!");
}
```

Default parameter values and generic type parameters are supported:

```sfn
fn find_char(text: string, ch: string, start: number = 0) -> number {
    // ...
}

fn identity<T>(value: T) -> T {
    return value;
}
```

---

### `async`

**Status: Parsed**

Mark a function as asynchronous. The `async` modifier is recognized by the parser and captured in the AST, but `await` is not yet parsed or enforced. Currently, `async fn` is structurally identical to `fn` at runtime.

```sfn
async fn fetch_user(id: string) -> User ![net] {
    // async/await semantics are planned; currently runs synchronously
    return http.get("/users/{{ id }}");
}
```

> **Note:** `await` is not yet implemented. See the [Concurrency](#concurrency) section.

---

### `let`

**Status: Implemented**

Declare an immutable variable binding. Variables declared with `let` cannot be reassigned. Type annotations are optional; the compiler performs limited inference. The initializer may be omitted (the binding is initialized to `null`).

```sfn
let name = "Sailfin";
let count: number = 0;
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

### `struct`

**Status: Implemented**

Define a named product type with labeled fields. Field declarations use `name: Type;` syntax. Structs may carry generic type parameters and may implement interfaces.

```sfn
struct Point {
    x: number;
    y: number;
}

struct Response<T> {
    status: number;
    body: T;
}

struct User implements Printable {
    id: number;
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
    Circle { radius: number },
    Rectangle { width: number, height: number },
    Point,
}

fn area(shape: Shape) -> number {
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

> **Note:** `Result<T, E>` and function type aliases (`type Handler = fn(...) -> ...`) are on the [roadmap](/roadmap); use union return types (`number | MyError`) today.

---

### `extern`

**Status: Parsed**

Declare an external symbol provided by the native runtime or a linked library. `extern fn` declarations must be combined with `unsafe` and terminate with `;` instead of a block body.

```sfn
unsafe extern fn malloc(size: usize) -> *u8;
unsafe extern fn free(ptr: *u8) -> void;
```

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

### `model`

**Status: Parsed + IR**

Declare a model artifact with metadata (provider, model identifier, parameters). The compiler emits a `.model` directive in `.sfn-asm` IR. Model execution via `.call()` is not yet implemented. This construct is being migrated to the `sfn/ai` library capsule.

```sfn
model Summarizer : Model<Text, Summary> {
    engine = "openai:gpt-4o@2025-06";
    schema = Summary;
    max_tok = 2000;
}
```

---

### `pipeline`

**Status: Parsed + IR**

Declare a data-processing pipeline. Parsed as a function-like declaration and lowered to `.sfn-asm`. The `|>` pipeline operator is not yet implemented.

```sfn
pipeline process_orders(orders: Order[]) -> void ![io, model] {
    for order in orders {
        process(order);
    }
}
```

---

### `tool`

**Status: Parsed + IR**

Declare a callable tool that can be exposed to a model. Recorded as metadata in `.sfn-asm`; no dispatcher is implemented yet.

```sfn
tool GetWeather(location: string) -> string ![net] {
    return http.get("https://api.weather.example/current?q={{ location }}").body;
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

**Status: Planned**

> **Note:** `while` is reserved but **not yet implemented** in the parser. Use `loop` with an explicit `break` instead. Tracked on the [roadmap](/roadmap).

```sfn
// Planned — not yet parsed. Use `loop { if cond { break; } ... }` today.
let mut n: number = 1;
loop {
    if n >= 100 {
        break;
    }
    n = n * 2;
}
```

---

### `loop`

**Status: Implemented**

Unconditional loop. Use `break` to exit. This is the primary looping construct used in the self-hosted compiler internals.

```sfn
let mut index: number = 0;
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
fn find(items: number[], target: number) -> number {
    let mut i: number = 0;
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
fn divide(a: number, b: number) -> number {
    if b == 0 {
        throw "division by zero";
    }
    return a / b;
}
```

---

## Concurrency

> **Status:** `routine { }` is parsed today and appears in example code; `channel()` and `parallel [...]` are available as prelude-backed primitives (see [Standard Library](/docs/reference/standard-library)). Full structured-concurrency semantics (`scope`, `await`, joined shutdown) are on the [roadmap](/roadmap).

### `routine`

**Status: Parsed**

Introduce a concurrent task block. The surface syntax is `routine { body }` or
`routine "name" { body }` — anonymous or named. Full scheduler and join
semantics are on the [roadmap](/roadmap).

```sfn
import { Channel, channel } from "sync";

fn main() ![io] {
    let messages: Channel<string> = channel();
    routine {
        messages.send("hello");
    }
    routine "consumer" {
        print(messages.receive());
    }
}
```

---

### `scope`

**Status: Planned**

Define a structured-concurrency scope. All routines spawned inside a `scope` block are joined before the block exits.

```sfn
// Planned — not yet implemented
scope {
    routine { fetch_data("https://api.example.com/a"); }
    routine { fetch_data("https://api.example.com/b"); }
}
// both tasks complete here
```

---

### `await`

**Status: Planned**

Await the result of an `async fn` or a concurrent future. Not yet parsed.

```sfn
// Planned — not yet implemented
async fn load_user(id: string) -> User ![net] {
    let response = await http.get("/users/{{ id }}");
    return response.body;
}
```

---

### `spawn`

**Status: Planned (language keyword)**

Spawn a concurrent task. The prelude provides `spawn(task, name)` as a runtime function today; the `spawn` keyword for structured concurrency is planned.

```sfn
// Planned language keyword — not yet implemented
// (prelude function spawn() is available today)
spawn {
    process_queue();
}
```

---

## AI and Domain Keywords

### `prompt`

**Status: Parsed + IR**

Send a prompt to a model declared in the enclosing scope. Requires the `![model]` effect. Prompt blocks emit a `.prompt` directive in `.sfn-asm` IR. Runtime execution is not yet implemented.

```sfn
fn summarize(text: string) -> string ![model] {
    prompt system {
        "You are a precise summarizer.";
    }
    prompt user {
        "Summarize the following in one sentence: {{ text }}";
    }
    return call_model("summarizer", text);
}
```

---

### `system` / `user` / `assistant`

**Status: Parsed + IR**

Canonical channel identifiers used immediately after `prompt`. They correspond
to the standard `system`, `user`, and `assistant` roles in language model APIs.
Each `prompt CHANNEL { body }` block emits one `.prompt` directive.

```sfn
fn classify(input: string) -> string ![model] {
    prompt system {
        "You are a helpful classifier. Respond with a single category.";
    }
    prompt user {
        input;
    }
    return call_model("classifier", input);
}
```

The `assistant` channel seeds the model's reply context (few-shot examples) by
appending another prompt block:

```sfn
prompt system { "Translate English to French."; }
prompt user { "Good morning"; }
prompt assistant { "Bonjour"; }
prompt user { text_to_translate; }
```

> **Typed prompt channels** (`prompt user<MyType> { }`) are a design-stage feature and are not yet implemented.

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

These keywords are parsed and recorded in the AST. Semantic enforcement is in progress.

### `Affine<T>`

**Status: Parsed only**

An affine type wrapper: the value may be dropped without being consumed, but cannot be duplicated. Move semantics apply. Enforcement is not yet active.

```sfn
fn ingest(batch: Affine<DataChunk>) ![gpu] {
    // batch must not be duplicated; may be dropped
    process(batch);
}
```

---

### `Linear<T>`

**Status: Parsed only**

A linear type wrapper: the value must be consumed exactly once. Neither duplication nor silent dropping is permitted. Enforcement is not yet active.

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

**Status: Parsed**

Declare a symbol that is provided by the native linker or runtime. Enforcement is not yet active.

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
    value -> Int;

    fn increment() -> Counter {
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

*For an at-a-glance view of which features are fully shipped, partially implemented, or planned, see [Status](/docs/reference/spec).*
