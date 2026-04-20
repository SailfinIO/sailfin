---
title: Standard Library
description: Complete reference for Sailfin's standard library, prelude functions, and built-in modules.
section: reference
sidebar:
  order: 5
---

The Sailfin standard library is divided into the **prelude** (always in scope, no import required) and named modules imported on demand. This page documents every available function, struct, and module with full signatures, behavior notes, and examples.

---

## Prelude

The prelude (`runtime/prelude.sfn`) is automatically available in every Sailfin program. No import statement is needed.

---

### Output

#### `print(value: any) ![io]`

Write a value to stdout followed by a newline. Accepts any type; non-string values are converted to their debug representation.

```sfn
fn greet(name: string) ![io] {
    print("Hello, {{name}}!");
}
```

#### `print.err(value: any) ![io]`

Write a value to stderr followed by a newline. Use for diagnostics, errors, and warnings that should not mix with normal stdout output.

```sfn
fn validate(path: string) -> boolean ![io] {
    if path.length == 0 {
        print.err("validation error: path must not be empty");
        return false;
    }
    return true;
}
```

#### Deprecated output functions

The following functions are still recognized by the runtime for backward compatibility. Prefer `print()` and `print.err()` in new code.

| Deprecated | Preferred replacement |
|---|---|
| `print.info(message)` | `print(message)` |
| `print.warn(message)` | `print.err(message)` |
| `print.error(message)` | `print.err(message)` |
| `print.debug(message)` | `print(message)` |

---

### String Utilities

These functions operate on Sailfin strings using Unicode grapheme clusters as the unit of indexing. "Index" always means a grapheme-cluster index, not a byte offset or code-unit index.

#### `substring(text: string, start: number, end: number) -> string`

Extract the substring from grapheme index `start` (inclusive) to `end` (exclusive). Both bounds are clamped to `[0, text.length]`. Returns `""` when the resulting range is empty or inverted.

```sfn
let s = "Hello, world!";
let hello = substring(s, 0, 5);   // "Hello"
let world = substring(s, 7, 12);  // "world"
let empty = substring(s, 5, 5);   // ""
let clamped = substring(s, 0, 999); // "Hello, world!" (end clamped)
```

**Notes:**
- Does not panic on out-of-range bounds — bounds are silently clamped.
- Safe to call on empty strings; always returns `""`.
- Works correctly with multi-byte Unicode characters because it indexes by grapheme cluster.

---

#### `find_char(text: string, character: string, start: number = 0) -> number`

Find the first occurrence of a single grapheme `character` in `text`, beginning the search at grapheme index `start`. Returns the index of the first match, or `-1` if not found.

The `start` parameter defaults to `0`. Negative values are treated as `0`. A `start` beyond the end of the string returns `-1` immediately.

Escape sequences are recognized when passed as two-character strings: `"\\n"` matches a literal newline, `"\\r"` matches a carriage return, and `"\\t"` matches a tab.

```sfn
let path = "/usr/local/bin";
let last_slash = find_char(path, "/", 1);  // 4

let csv = "name,age,city";
let first_comma = find_char(csv, ",");     // 4

let line = "hello\nworld";
let newline = find_char(line, "\\n");      // 5

let missing = find_char("abc", "z");       // -1
```

---

#### `grapheme_count(text: string) -> number`

Return the number of Unicode grapheme clusters in `text`. For ASCII strings this equals the byte length. For strings containing multi-byte characters, emoji, or combined sequences this may differ from `.length`.

```sfn
let ascii = "hello";
grapheme_count(ascii);       // 5

let emoji = "hi 👋";
grapheme_count(emoji);       // 4  (h, i, space, 👋)

let empty = "";
grapheme_count(empty);       // 0
```

**Note:** Use `grapheme_count` when you need the number of visible characters a user would perceive. Use `.length` only when operating on raw bytes or code units.

---

#### `grapheme_at(text: string, index: number) -> string`

Return the grapheme cluster at the given index. Returns `""` for an out-of-range index (negative or beyond the end of the string). Never panics.

```sfn
let s = "café";
grapheme_at(s, 0);  // "c"
grapheme_at(s, 3);  // "é"  (single grapheme, may be multiple bytes)
grapheme_at(s, 99); // ""
```

---

#### `char_code(character: string) -> number`

Return the Unicode code point of the first grapheme cluster in `character`. Returns `-1` for an empty string or an invalid input.

```sfn
char_code("A");    // 65
char_code("a");    // 97
char_code("€");    // 8364
char_code("");     // -1
```

**Note:** Only the first grapheme cluster of the argument is examined. Pass a single character for predictable results.

---

#### `strings_equal(left: string, right: string) -> boolean`

Return `true` if two strings have the same length and each grapheme cluster matches at every position. This performs a grapheme-by-grapheme comparison using `char_code` internally.

```sfn
strings_equal("hello", "hello");  // true
strings_equal("hello", "Hello");  // false
```

**Note:** The `==` operator compares strings by value in most contexts; `strings_equal` is available as an explicit alternative.

---

#### `clamp(value: number, minimum: number, maximum: number) -> number`

Return `value` clamped to the range `[minimum, maximum]`. Works with both integers and floating-point numbers.

```sfn
clamp(5, 0, 10);    // 5
clamp(-3, 0, 10);   // 0
clamp(15, 0, 10);   // 10
```

---

### Struct and Debug Utilities

#### `struct_field(name: string, value: any) -> StructField`

Construct a `StructField` record with a name and a value. Used as a building block for `struct_repr`.

```sfn
let field = struct_field("age", 30);
```

#### `struct_repr(name: string, fields: StructField[]) -> string`

Produce a human-readable debug representation of a struct. The output format is `Name(field1=value1, field2=value2, ...)`.

```sfn
struct Point {
    x: number;
    y: number;
}

fn point_repr(p: Point) -> string {
    return struct_repr("Point", [
        struct_field("x", p.x),
        struct_field("y", p.y),
    ]);
}

// point_repr(Point { x: 3, y: 7 }) => "Point(x=3, y=7)"
```

#### `to_debug_string(value: any) -> string`

Convert any value to its debug string representation. Used internally by `struct_repr` and string interpolation.

```sfn
to_debug_string(42);       // "42"
to_debug_string(true);     // "true"
to_debug_string(null);     // "null"
to_debug_string("hello");  // "hello"
```

---

### Type Checking Utilities

These functions are used internally by the compiler-generated type guards. They are available in user code but are most commonly used via the `check_type` wrapper.

#### `check_type(value: any, descriptor: string) -> boolean`

Return `true` if `value` conforms to the type described by the descriptor string. Descriptor syntax mirrors Sailfin type notation: `"string"`, `"number"`, `"boolean"`, `"string[]"`, `"string | null"`, etc.

```sfn
check_type("hello", "string");           // true
check_type(42, "number");                // true
check_type(null, "string?");             // true  (? => union with void/null)
check_type([1, 2], "number[]");          // true
check_type("x", "string | number");      // true
```

---

### Runtime Utilities

#### `match_exhaustive_failed(value: any) -> never`

Runtime backstop invoked by compiler-generated code when a `match` expression fails to cover all cases at runtime. Raises a `ValueError` with a message including the unmatched value. This function is never called when all match arms are genuinely exhaustive.

You should not call this function directly. It appears in generated code and in documentation so that stack traces referencing it can be understood.

---

### Concurrency and Async Utilities

> **Status:** `routine`, `await`, and `parallel` are shipped language
> constructs, and the `Channel<T>` type from the `sync` module works today
> (see the examples below). Structured-concurrency supervision — scope
> semantics, cancellation, and `spawn` — is on the [roadmap](/roadmap).

#### `monotonic_millis() -> number ![clock]`

Return the current value of a monotonic clock in milliseconds. Useful for measuring elapsed time. The absolute value is not meaningful; only differences between two calls are useful.

```sfn
fn timed_operation() ![io, clock] {
    let start = monotonic_millis();
    do_work();
    let elapsed = monotonic_millis() - start;
    print("elapsed: {{elapsed}} ms");
}
```

#### `channel<T>() -> Channel<T>` and `channel<T>(capacity: number) -> Channel<T>`

Create an unbuffered or bounded channel for passing values between concurrent
tasks. `capacity = 0` (the no-argument form) produces an unbuffered
(synchronous) channel. Imported from the `sync` module.

```sfn
import { Channel, channel } from "sync";

async fn main() ![io] {
    let messages: Channel<number> = channel();

    routine {
        messages.send(42);
    }

    let result: number = await messages.receive();
    print("Received: {{result}}");
}
```

#### `Channel<T>.send(value: T)` and `Channel<T>.receive() -> T`

Send a value into the channel, or await the next value out. `send` returns
immediately on a buffered channel (blocks when the buffer is full); `receive`
yields via `await` until a value is available.

```sfn
import { Channel, channel } from "sync";
import { sleep } from "time";

fn main() ![clock, io] {
    let buffer: Channel<number> = channel(10); // bounded buffer

    routine {
        for i in 1..20 {
            print("Producing {{i}}");
            buffer.send(i);
            sleep(500);
        }
    }

    routine {
        loop {
            let item = await buffer.receive();
            print("Consumed {{item}}");
            sleep(1000);
        }
    }
}
```

> **Coming in 1.0:** `Channel<T>.close()` and explicit cancellation, plus a
> structured `scope { ... }` supervisor for grouping routines. See the
> [roadmap](/roadmap).

#### `parallel [ ... ]` — language construct

Run an array literal of zero-argument lambdas concurrently and collect their
return values. `parallel` is a **keyword**, not a stdlib function — the
operand is an array literal of `fn() -> T { ... }` expressions.

```sfn
fn computeTask1() -> number { return 21; }
fn computeTask2() -> number { return 21; }

fn main() ![io] {
    let results = parallel [
        fn() -> number { return computeTask1(); },
        fn() -> number { return computeTask2(); },
    ];

    print("Results: {{results}}");
}
```

---

### Array Utilities

#### `array_map(items: any[], mapper: (any) -> any) -> any[]`

Apply `mapper` to each element and return a new array of results.

```sfn
let numbers = [1, 2, 3, 4];
let doubled = array_map(numbers, fn(n: number) -> number { return n * 2; });
// [2, 4, 6, 8]
```

#### `array_filter(items: any[], predicate: (any) -> boolean) -> any[]`

Return a new array containing only the elements for which `predicate` returns `true`.

```sfn
let numbers = [1, 2, 3, 4, 5];
let evens = array_filter(numbers, fn(n: number) -> boolean { return n % 2 == 0; });
// [2, 4]
```

#### `array_reduce(items: any[], initial: any, reducer: (any, any) -> any) -> any`

Fold `items` into a single value using `reducer`, starting from `initial`.

```sfn
let numbers = [1, 2, 3, 4, 5];
let sum = array_reduce(numbers, 0, fn(acc: number, n: number) -> number { return acc + n; });
// 15
```

---

### Enum Utilities

These functions are generated by the compiler for enum types and are available for use in custom enum-handling code. They are primarily an implementation detail of the compiler's enum lowering.

#### `enum_type(name: string) -> EnumType`

Create a new `EnumType` descriptor with no variants defined yet.

#### `enum_define_variant(enum_type: EnumType, variant_name: string, field_names: string[]) -> EnumType`

Return a new `EnumType` with the named variant added.

#### `enum_field(name: string, value: any) -> EnumField`

Construct a single `EnumField`.

#### `enum_instantiate(enum_type: EnumType, variant_name: string, provided: EnumField[]) -> EnumInstance`

Create an `EnumInstance` for the named variant, filling in `null` for any fields not in `provided`.

#### `enum_get_field(instance: EnumInstance, name: string) -> any`

Look up a field value by name on an `EnumInstance`. Returns `null` if not found.

---

### Prelude Structs

These structs are defined in the prelude and may appear in user-facing APIs or diagnostics.

#### `StructField`

```sfn
struct StructField {
    name: string;
    value: any;
}
```

#### `EnumField`

```sfn
struct EnumField {
    name: string;
    value: any;
}
```

#### `EnumVariantDefinition`

```sfn
struct EnumVariantDefinition {
    name: string;
    field_names: string[];
}
```

#### `EnumType`

```sfn
struct EnumType {
    name: string;
    variants: EnumVariantDefinition[];
}
```

#### `EnumInstance`

```sfn
struct EnumInstance {
    type: EnumType;
    variant: string;
    fields: EnumField[];
}
```

#### `TypeDescriptor`

```sfn
struct TypeDescriptor {
    kind: string;
    name: string?;
    items: TypeDescriptor[];
}
```

Used internally by `check_type` and `parse_type_descriptor`.

---

## `fs` module

The `fs` module provides filesystem access. All operations require the `![io]` effect. The module is bound from `runtime.fs` in the prelude — no import statement is needed.

---

#### `fs.readFile(path: string) -> string ![io]`

Read the entire contents of the file at `path` and return them as a string. Raises a runtime error if the file does not exist or cannot be read.

```sfn
fn load_config(path: string) -> string ![io] {
    return fs.readFile(path);
}
```

**Notes:**
- The returned string includes all bytes decoded as UTF-8.
- No line-ending normalization is performed.
- For large files, the entire content is loaded into memory.

---

#### `fs.writeFile(path: string, content: string) ![io]`

Write `content` to the file at `path`, creating the file if it does not exist and overwriting it completely if it does. Parent directories must already exist.

```sfn
fn save_result(path: string, data: string) ![io] {
    fs.writeFile(path, data);
}
```

---

#### `fs.appendFile(path: string, content: string) ![io]`

Append `content` to the file at `path`. If the file does not exist it is created. Existing content is preserved; the new content is added at the end.

```sfn
fn log_to_file(path: string, message: string) ![io] {
    fs.appendFile(path, message + "\n");
}
```

---

#### `fs.exists(path: string) -> boolean ![io]`

Return `true` if a file or directory exists at `path`, `false` otherwise. Does not distinguish between files and directories.

```sfn
fn ensure_config(path: string) ![io] {
    if !fs.exists(path) {
        fs.writeFile(path, "{}");
    }
}
```

---

#### `fs.writeLines(path: string, lines: string[]) ![io]`

Write an array of strings to `path`, one per line, overwriting any existing file. Each element is written with a trailing newline.

```sfn
fn write_report(path: string, lines: string[]) ![io] {
    fs.writeLines(path, lines);
}
```

---

### Filesystem — Planned

The following filesystem helpers are planned for a future release and are not available today:

- `fs.readLines(path: string) -> string[] ![io]` — read file as an array of lines
- `fs.deleteFile(path: string) ![io]` — delete a file
- `fs.listDir(path: string) -> string[] ![io]` — list directory contents
- `fs.makeDir(path: string) ![io]` — create a directory (and parents)
- `fs.move(src: string, dst: string) ![io]` — rename or move a file
- `fs.copy(src: string, dst: string) ![io]` — copy a file

---

## `http` module

The `http` module provides outbound HTTP client functionality. All operations require the `![net]` effect. The module is bound from `runtime.http` in the prelude.

---

#### `http.get(url: string) -> Response ![net]`

Perform an HTTP GET request to `url` and return a `Response`. Blocks until the response is received or the request fails.

```sfn
fn fetch_json(url: string) -> string ![net] {
    let response = http.get(url);
    return response.body;
}
```

---

#### `http.post(url: string, body: string) -> Response ![net]`

Perform an HTTP POST request to `url` with the given string `body`. Returns a `Response`. The `Content-Type` is not set automatically; include it in a custom header when required (see planned headers API below).

```sfn
fn submit(url: string, payload: string) -> string ![net] {
    let response = http.post(url, payload);
    return response.body;
}
```

---

### Response type

The `Response` object returned by `http.get` and `http.post` has the following fields:

| Field | Type | Description |
|---|---|---|
| `body` | `string` | Response body as a UTF-8 string |
| `status` | `number` | HTTP status code (e.g. `200`, `404`) |

> **Note:** The full response shape (headers, streaming body, redirect policy, timeouts) is planned. The current `Response` exposes `body` and `status` only.

---

### HTTP — Planned

The following HTTP features are planned for a future release:

- Request headers and custom `Content-Type`
- Authentication helpers (Bearer, Basic)
- Timeout and retry configuration
- `http.put`, `http.delete`, `http.patch`
- Streaming response bodies
- `websocket.connect` for WebSocket support

---

## `sfn/log` capsule

The `sfn/log` capsule provides structured log output with severity levels. Unlike `print`, log functions include a level prefix and route warnings and errors to stderr automatically.

Import the capsule before use:

```sfn
import { log } from "sfn/log";
```

All `log` functions require the `![io]` effect.

---

#### `log.info(message: string) ![io]`

Write an informational message to stdout with an `[INFO]` prefix. Use for routine operational messages.

```sfn
fn start_server(port: number) ![io] {
    log.info("Server starting on port {{port}}");
}
```

---

#### `log.warn(message: string) ![io]`

Write a warning message to **stderr** with a `[WARN]` prefix. Use when something unexpected occurred but execution can continue.

```sfn
fn load_optional(path: string) -> string ![io] {
    if !fs.exists(path) {
        log.warn("optional config not found: {{path}}");
        return "";
    }
    return fs.readFile(path);
}
```

---

#### `log.error(message: string) ![io]`

Write an error message to **stderr** with an `[ERROR]` prefix. Use for failures that require attention.

```sfn
fn connect(host: string) ![io, net] {
    let response = http.get("http://{{host}}/health");
    if response.status != 200 {
        log.error("health check failed: status {{response.status}}");
    }
}
```

---

#### `log.debug(message: string) ![io]`

Write a debug message to stdout with a `[DEBUG]` prefix. Use for verbose diagnostic output that is typically suppressed in production. Whether debug output appears may be controlled by runtime log-level configuration in a future release.

```sfn
fn parse_token(raw: string) -> string ![io] {
    log.debug("parsing token: {{raw}}");
    // ...
    return raw;
}
```

---

## Collections — Planned

> **Coming in 1.0:** Generic containers (`Map<K, V>`, `Set<T>`, and an explicit growable `Vec<T>`) depend on generic type constraints landing first. See the [roadmap](/roadmap) for sequencing.
>
> Today, array literals (`[1, 2, 3]`) with `T[]` types, `.length`, `.push(item)`, and the prelude array utilities (`array_map`, `array_filter`, `array_reduce`) are the shipped collection surface.

### Arrays (available today)

```sfn
let numbers: number[] = [1, 2, 3];
numbers.push(4);
let n = numbers.length;        // 4
let first = numbers[0];         // 1
```

### Planned `Vec<T>`

```sfn
// Planned API — not yet implemented
Vec<T>.new() -> Vec<T>
Vec<T>.push(item: T) -> void
Vec<T>.pop() -> T?
Vec<T>.get(index: number) -> T?
Vec<T>.len() -> number
Vec<T>.is_empty() -> boolean
Vec<T>.contains(item: T) -> boolean
Vec<T>.remove(index: number) -> T
Vec<T>.slice(start: number, end: number) -> Vec<T>
```

### Planned `Map<K, V>`

```sfn
// Planned API — not yet implemented
Map<K, V>.new() -> Map<K, V>
Map<K, V>.set(key: K, value: V) -> void
Map<K, V>.get(key: K) -> V?
Map<K, V>.has(key: K) -> boolean
Map<K, V>.delete(key: K) -> void
Map<K, V>.keys() -> K[]
Map<K, V>.values() -> V[]
Map<K, V>.len() -> number
```

### Planned `Set<T>`

```sfn
// Planned API — not yet implemented
Set<T>.new() -> Set<T>
Set<T>.add(item: T) -> void
Set<T>.has(item: T) -> boolean
Set<T>.delete(item: T) -> void
Set<T>.size() -> number
```

---

## Planned modules

The modules below are on the roadmap and are documented here to give a preview of the planned API. None are available in the current release.

---

### `rand` module — Planned (`![rand]` effect)

> **Coming in 1.0:** Random-number helpers as a standard module. The `rand` effect token is parsed today but no `rand.*` APIs ship yet. See the [roadmap](/roadmap).

```sfn
// Planned — not yet implemented
rand.int(min: number, max: number) -> number ![rand]
rand.float() -> number ![rand]          // uniform in [0.0, 1.0)
rand.bool() -> boolean ![rand]
rand.shuffle<T>(items: T[]) -> T[] ![rand]
rand.choice<T>(items: T[]) -> T? ![rand]
```

---

### `time` module (`![clock]` effect)

#### `sleep(milliseconds: number) ![clock]`

Imported from the `time` module. Suspend the current execution context for at
least `milliseconds` milliseconds. Requires the `clock` effect.

```sfn
import { sleep } from "time";

fn wait_a_bit() ![clock] {
    sleep(500);  // pause for 500 ms
}
```

> **Coming in 1.0:** A structured date/time API on top of the existing
> `clock` effect. `sleep` (from `time`) and the `monotonic_millis` prelude
> function are available today; richer wall-clock access is planned.
> See the [roadmap](/roadmap).

```sfn
// Planned — not yet implemented
clock.now() -> Timestamp ![clock]
clock.utc_now() -> Timestamp ![clock]
Timestamp.unix_millis() -> number
Timestamp.format(pattern: string) -> string
```

---

### `process` module — Planned (`![io]` effect)

> **Coming in 1.0:** Subprocess execution and process lifecycle helpers. See the [roadmap](/roadmap).

```sfn
// Planned — not yet implemented
process.exec(command: string) -> ProcessResult ![io]
process.exit(code: number) -> never ![io]

struct ProcessResult {
    stdout: string;
    stderr: string;
    exit_code: number;
}
```

---

### `sync` module

The `sync` module exposes `Channel<T>` and the `channel()` constructor. See
the [Concurrency and Async Utilities](#concurrency-and-async-utilities)
section above for the full API and examples.

---

### AI / Model adapters — Planned (`![model]` effect)

> **Coming in 1.0:** First-class model invocation via the `sfn/ai` capsule. `model` and `prompt` blocks are parsed and emit metadata today; actual `.call()` execution is planned. See the [roadmap](/roadmap).

```sfn
// Planned — not yet implemented
model MyModel {
    provider = "anthropic";
    model_id = "claude-sonnet-4-20250514";
    max_tokens = 1024;
}

fn classify(text: string) -> string ![model] {
    prompt user {
        "Classify the following: {{text}}";
    }
    return "";
}
```

---

*The standard library is actively expanding as the runtime migrates from C to Sailfin. See [Runtime ABI](/docs/reference/runtime-abi) for migration status.*
