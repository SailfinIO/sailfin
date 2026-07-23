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

#### `ascii_uppercase(text: string) -> string` and `ascii_lowercase(text: string) -> string`

Convert only the ASCII letters `a`–`z` or `A`–`Z`, respectively. Digits,
punctuation, and every non-ASCII byte are copied unchanged. These pure helpers
come from the `sfn/strings` capsule; they do not perform locale-sensitive
conversion or Unicode case folding.

```sfn
import { ascii_lowercase, ascii_uppercase } from "sfn/strings";

ascii_uppercase("Café 42"); // "CAFé 42"
ascii_lowercase("Δ-HTTP");  // "Δ-http"
```

---

#### `substring(text: string, start: int, end: int) -> string`

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

#### `find_char(text: string, character: string, start: int = 0) -> int`

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

#### `grapheme_count(text: string) -> int`

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

#### `grapheme_at(text: string, index: int) -> string`

Return the grapheme cluster at the given index. Returns `""` for an out-of-range index (negative or beyond the end of the string). Never panics.

```sfn
let s = "café";
grapheme_at(s, 0);  // "c"
grapheme_at(s, 3);  // "é"  (single grapheme, may be multiple bytes)
grapheme_at(s, 99); // ""
```

---

#### `char_code(character: string) -> int`

Return the Unicode code point of the first grapheme cluster in `character`. Returns `-1` for an empty string or an invalid input.

```sfn
char_code("A");    // 65
char_code("a");    // 97
char_code("€");    // 8364
char_code("");     // -1
```

**Note:** Only the first grapheme cluster of the argument is examined. Pass a single character for predictable results.

---

#### `char_from_code(code: int) -> string`

Build a one-byte string from the **raw byte value** `code` (1–255). This is the
write counterpart to `char_code`'s read: `char_code(char_from_code(n)) == n`
round-trips for every `n` in 1–255, letting pure-Sailfin code construct and
inspect arbitrary single bytes (binary data, multibyte UTF-8 sequences built
byte-by-byte).

Unlike a code-point encoder, the byte is written **verbatim** — there is no
UTF-8 expansion for `128..255`. `char_from_code(195)` is the single byte `0xC3`
(length 1), not the two-byte UTF-8 encoding of U+00C3.

```sfn
char_from_code(65);   // "A"
char_code(char_from_code(200));  // 200  (single raw byte, length 1)
char_from_code(0);    // ""   (see limitation below)
char_from_code(300);  // ""   (out of range)
```

**Caution — bytes `128..255` are not valid UTF-8 on their own.** A single byte
in that range is a UTF-8 *continuation* or *lead* byte, so a one-byte string
from `char_from_code(n)` for `n >= 128` is a raw byte, **not** a complete
character. The grapheme-oriented helpers above (`grapheme_count`, `grapheme_at`,
`char_code`, `substring`, `find_char`) assume valid UTF-8 and may treat such a
byte as a lone fallback grapheme or skip it. Treat `char_from_code`'s output as
**bytes**, not text: concatenate the bytes of a multibyte character together
before applying grapheme-oriented APIs, and use byte-oriented indexing
(`s[i]` + `char_code`) when you need the raw bytes back. Bytes `1..127` (ASCII)
are always valid single-character UTF-8 and round-trip through every API.

**Limitation — byte 0:** a lone NUL is unrepresentable under the current
NUL-terminated `string` model (`.length` is recovered with `strlen`), so
`char_from_code(0)` returns `""`. Faithful embedded-NUL bytes arrive with the
`SfnString` aggregate (carrying an explicit length) on the runtime roadmap;
until then, build NUL-containing payloads with a length-carrying structure
rather than a `string`.

**Known issue — reading ASCII bytes (`1..0x7f`) back with `char_code` on macOS
arm64:** `char_from_code(n)` writes the byte correctly for the full range, but
reading an ASCII byte back with `char_code` can return the wrong value on macOS
arm64. `char_code` decodes ASCII bytes through an immediate-codepoint tagged
pointer (`byte << 32`); on macOS the runtime distinguishes the tag from a real
pointer by checking whether the address is mapped, and for small byte values
`byte << 32` may land on a mapped region (e.g. the executable base) — which is
ASLR-dependent and varies run to run. This is a pre-existing `char_code`
limitation (it affects any string's ASCII bytes, not just `char_from_code`
output) tracked as a follow-up. It does **not** affect Linux, and does not affect
bytes `0x80..0xFF` (which take a non-immediate path). For binary data on macOS,
read bytes back via byte-oriented indexing of `0x80..0xFF` sequences or treat
the `1..0x7f` round-trip as platform-conditional until the follow-up lands.

---

#### `strings_equal(left: string, right: string) -> boolean`

Return `true` if two strings have the same length and each grapheme cluster matches at every position. This performs a grapheme-by-grapheme comparison using `char_code` internally.

```sfn
strings_equal("hello", "hello");  // true
strings_equal("hello", "Hello");  // false
```

**Note:** The `==` operator compares strings by value in most contexts; `strings_equal` is available as an explicit alternative.

---

#### `clamp(value: float, minimum: float, maximum: float) -> float`

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
    x: float;
    y: float;
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

Return `true` if `value` conforms to the type described by the descriptor string. Descriptor syntax mirrors Sailfin type notation: `"string"`, `"int"`, `"float"`, `"boolean"`, `"string[]"`, `"string | null"`, etc. The legacy `"number"` descriptor is accepted as an alias for `"float"` to preserve compatibility with the deprecated `number` type alias.

```sfn
check_type("hello", "string");        // true
check_type(42, "int");                // true
check_type(3.14, "float");            // true
check_type(null, "string?");          // true  (? => union with void/null)
check_type([1, 2], "int[]");          // true
check_type("x", "string | int");      // true
```

---

### Runtime Utilities

#### `match_exhaustive_failed(value: any) -> never`

Runtime backstop invoked by compiler-generated code when a `match` expression fails to cover all cases at runtime. Raises a `ValueError` with a message including the unmatched value. This function is never called when all match arms are genuinely exhaustive.

You should not call this function directly. It appears in generated code and in documentation so that stack traces referencing it can be understood.

---

### Concurrency and Async Utilities

> **Status:** `routine`, `await`, and `parallel` are shipped language
> constructs. `spawn fn() -> T { ... }` is also shipped, and `routine { ... }`
> is the structured-concurrency nursery that joins its children. The v0
> `channel(N)` surface is a language builtin; the typed `sfn/sync` capsule
> wrapper is not yet built.

#### `monotonic_millis() -> int ![clock]`

Return the current value of a monotonic clock in milliseconds. Useful for measuring elapsed time. The absolute value is not meaningful; only differences between two calls are useful.

```sfn
fn timed_operation() ![io, clock] {
    let start = monotonic_millis();
    do_work();
    let elapsed = monotonic_millis() - start;
    print("elapsed: {{elapsed}} ms");
}
```

#### `channel(capacity: int)` — language construct

Create a bounded MPMC channel for passing values between concurrent tasks. The
capacity is fixed at construction. Elements are pointer-sized in v0; when a
bare channel's element kind cannot be inferred, annotate the receive target as
`int` or `float`. A `Channel<T>` binding annotation enforces the element kind,
but the generic `channel<T>(...)` constructor and typed `sfn/sync` capsule API
are not yet shipped.

```sfn
fn main() ![io] {
    let messages = channel(1);

    routine {
        messages.send(42);
    }

    let result: int = messages.receive();
    print("Received: {{result}}");
}
```

#### Channel `send`, `receive`, and `close`

`send` blocks when the bounded buffer is full, `receive` blocks when it is
empty, and `close` closes the channel. `send` and `receive` require `![io]` as a
conservative v0 effect. They are synchronous channel methods; do not prefix a
receive with `await`.

```sfn
import { sleep } from "time";

fn main() ![clock, io] {
    let buffer = channel(10);

    routine {
        for i in 1..20 {
            print("Producing {{i}}");
            buffer.send(i);
            sleep(500);
        }
    }

    routine {
        loop {
            let item: int = buffer.receive();
            print("Consumed {{item}}");
            sleep(1000);
        }
    }
}
```

> **Not in v0:** cancel-on-fault nursery behavior, async-I/O integration, and
> the generic `channel<T>(...)` constructor. There is no separate
> `scope { ... }` construct; `routine { ... }` is the shipped supervisor.

#### `parallel [ ... ]` — language construct

Run an array literal of zero-argument lambdas concurrently and collect their
return values. `parallel` is a **keyword**, not a stdlib function — the
operand is an array literal of `fn() -> T { ... }` expressions.

```sfn
fn computeTask1() -> int { return 21; }
fn computeTask2() -> int { return 21; }

fn main() ![io] {
    let results = parallel [
        fn() -> int { return computeTask1(); },
        fn() -> int { return computeTask2(); },
    ];

    print("Results: {{results}}");
}
```

---

### Array Utilities

#### `array_map(items: any[], mapper: (any) -> any) -> any[]`

Apply `mapper` to each element and return a new array of results. The
working spelling today is the method form `arr.map(closure)` for `int[]`
arrays (see [Arrays (available today)](#arrays-available-today) above) —
use that:

```sfn
let numbers = [1, 2, 3, 4];
let doubled: int[] = numbers.map(fn (n: int) -> int { return n * 2; });
// [2, 4, 6, 8]
```

This `array_map` prelude free function is a thin wrapper and remains an
internal utility; its generic `(any) -> any` closure path is gated on
generic type constraints (designed in SFEP-0028). Prefer the `.map` method form.

#### `array_filter(items: any[], predicate: (any) -> boolean) -> any[]`

Return a new array containing only the elements for which `predicate` returns `true`.
The working spelling today is the method form `arr.filter(closure)` for `int[]`
arrays — prefer it:

```sfn
let numbers = [1, 2, 3, 4, 5];
let evens = numbers.filter(fn (n: int) -> bool { return n % 2 == 0; });
// [2, 4]
```

#### `array_reduce(items: any[], initial: any, reducer: (any, any) -> any) -> any`

Fold `items` into a single value using `reducer`, starting from `initial`. The
working spelling today is the method form `arr.reduce(init, closure)` for
`int[]` arrays — prefer it:

```sfn
let numbers = [1, 2, 3, 4, 5];
let sum = numbers.reduce(0, fn (acc: int, n: int) -> int { return acc + n; });
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

#### `fs.set_perms(path: string, mode: int) -> boolean ![io]`

Set POSIX permission bits on `path` — the `chmod(2)` wrapper. `mode` is masked to the lower 12 bits (perm + sticky/setuid/setgid). Returns `true` on success, `false` on any error (missing file, permission denied, etc.). POSIX-only; Windows returns `false`.

```sfn
fn make_executable(path: string) ![io] {
    // 0o755 = rwxr-xr-x (octal literals are pending; decimal for now)
    fs.set_perms(path, 493);
}
```

Note: octal literals (`0o755`) are pending parser support. Until they land, pass the decimal equivalent.

---

#### `fs.get_perms(path: string) -> int ![io]`

Return the lower 12 bits of `st_mode` for `path` — the `stat -c '%a'` equivalent. Returns `-1` on any error (missing file, permission denied, etc.).

```sfn
fn is_world_readable(path: string) -> boolean ![io] {
    let mode = fs.get_perms(path);
    if mode == -1 { return false; }
    // 4 = 0o004 = world-readable bit
    return (mode & 4) != 0;
}
```

---

#### `fs.mkdtemp(prefix: string) -> string ![io]`

Create a unique directory under `$TMPDIR` (or `/tmp` if unset) with mode `0700`, using `mkdtemp(3)` so the kernel guarantees uniqueness. Returns the absolute path, or an empty string on failure.

If `prefix` contains a `/`, it is treated as a path-prefixed template (the caller picks the parent dir); otherwise the result lives under the system temp dir.

```sfn
fn scratch_for_run() -> string ![io] {
    return fs.mkdtemp("sfn-build-");
}
```

POSIX-only; Windows returns an empty string.

---

#### `fs.is_executable(path: string) -> boolean ![io]`

Return `true` iff the current process can `exec` the path — the `access(path, X_OK)` equivalent. Permission errors and missing files both collapse to `false`. POSIX-only; Windows returns `false`.

```sfn
fn find_in_path(name: string) -> string ![io] {
    let candidate = "/usr/local/bin/" + name;
    if fs.is_executable(candidate) { return candidate; }
    return "";
}
```

---

#### `fs.symlink(target: string, link: string) -> boolean ![io]`

Create a symbolic link at `link` pointing at `target` — the `symlink(2)` wrapper. Per POSIX, the target need not exist; dangling links are intentionally allowed. Returns `true` on success, `false` if `link` already exists or any other error occurs. POSIX-only; Windows returns `false`.

```sfn
fn pin_current_release(target: string, link: string) ![io] {
    fs.symlink(target, link);
}
```

---

#### `fs.read_link(path: string) -> string ![io]`

Read the target of the symbolic link at `path` — the `readlink(2)` wrapper. Returns the **raw target text exactly as stored in the link**, e.g. `../../llms.txt` for a link at `site/public/llms.txt`. This is a **single-hop** read: it does not canonicalize the result, does not resolve multiple levels of symlinks, and does not check whether the target exists. It is **not** `readlink -f` or `realpath` — use `fs.symlink`'s target convention as the mental model (whatever string was written at link-creation time is what comes back). Returns an empty string if `path` is not a symlink, does not exist, or on any other error. POSIX-only; Windows returns an empty string.

```sfn
fn release_pin_target(link: string) -> string ![io] {
    // Raw target text, not resolved — a relative target stays relative.
    return fs.read_link(link);
}
```

---

### Filesystem — Planned

The following filesystem helpers are planned for a future release and are not available today:

- `fs.readLines(path: string) -> string[] ![io]` — read file as an array of lines
- `fs.move(src: string, dst: string) ![io]` — rename or move a file
- `fs.copy(src: string, dst: string) ![io]` — copy a file
- `fs.walk(path: string) -> string[] ![io]` — recursive directory walk

---

## `http` module

The `http` module provides outbound HTTP client functionality. All operations require the `![net]` effect. The module is bound from `runtime.http` in the prelude.

`https://` URLs are supported transparently (SFEP-0036): the client TLS-wraps the socket, verifies the server's certificate chain **and** hostname against the system CA trust store, and defaults to port 443. Verification is **on by default and fail-closed** — a certificate that does not validate closes the connection rather than being parsed and ignored. The trust store is discovered from OpenSSL's default verify paths plus the `/etc/ssl/certs/ca-certificates.crt` fallback; set `SAILFIN_TLS_CAFILE` to add an extra CA bundle (e.g. a private CA in tests). See the [OpenSSL build-host dependency runbook](https://github.com/SailfinIO/sailfin/blob/main/docs/runbooks/openssl-build-dependency.md) for the `libssl-dev` link precondition.

---

#### `http.get(url: string) -> Response ![net]`

Perform an HTTP GET request to `url` and return a `Response`. Blocks until the response is received or the request fails.

```sfn
fn fetch_status() -> string ![net] {
    // http:// and https:// both work; TLS is transparent for https://,
    // with certificate-chain + hostname verification enforced by default.
    let response = http.get("https://example.com/status");
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

- Authentication helpers (Bearer, Basic)
- Timeout and retry configuration
- `http.put`, `http.delete`, `http.patch`
- Streaming response bodies
- Per-request allocation cleanup, and a typed routing layer (sfn/http Waves 3+)

> TLS shipped for this client (SFEP-0036): `https://` URLs are handled transparently with certificate verification — see the note under [`http` module](#http-module). The typed `sfn/http` `fetch`/keep-alive client uses the same verified TLS path for `https://`.

---

## `websocket` module

The `websocket` module provides a Sailfin-native RFC 6455 `ws://` client and a v0 echo server. Like `http.*`, the `websocket.*` calls are a built-in runtime namespace available without an explicit import (the examples below call `websocket.*` directly); an `import { websocket } from "http";` also resolves for readers who prefer a named import. The module is bound from `runtime/sfn/adapters/websocket.sfn` and, as of #1876 (client) and #1877 (server), lowers to real `sfn_websocket_*` runtime symbols — not the `sfn_websocket_unbridged` metadata-only sentinel these calls previously carried. There is no `WebSocket` struct type — a connection is an opaque handle (a raw pointer under the hood); treat it as an unannotated value threaded between calls.

---

#### `websocket.connect(url: string) -> <handle> ![net]`

Parse `url` (`ws://host[:port][/path]`), open a TCP connection, and perform the RFC 6455 client handshake. Returns an opaque connection handle, or a null-equivalent handle on failure (DNS/connect/handshake error).

```sfn
fn open_conn(url: string) ![net] {
    let conn = websocket.connect(url);
}
```

---

#### `websocket.send(handle, msg: string) -> <handle> ![io, net]`

Send `msg` as a single masked TEXT frame over `handle`'s connection (client → server frames must be masked per RFC 6455). Returns the handle unchanged on success. **Requires `![io, net]`, not just `![net]`:** any `.send(...)` member call — regardless of receiver — trips the effect checker's conservative, receiver-agnostic channel-op rule (shared with `channel.send`), which adds `io` on top of the registry's `net` requirement for `websocket.send` itself.

```sfn
fn round_trip(url: string) ![io, net] {
    let conn = websocket.connect(url);
    websocket.send(conn, "hello");
    websocket.close(conn);
}
```

---

#### `websocket.close(handle) -> <handle> ![net]`

Send a masked CLOSE frame, close the underlying socket, and free the handle. Safe to call on an already-failed handle.

---

#### `websocket.serve(port: int) ![net]`

Bind and listen on `port`, then block forever, accepting **one connection at a time**. Each accepted connection completes the RFC 6455 server handshake and then echoes TEXT/BINARY frames back **unmasked** (server → client frames must not be masked) until the client sends CLOSE (answered with an unmasked CLOSE reply) or the connection drops.

```sfn
fn run_echo_server() ![net] {
    websocket.serve(8080);
}
```

> **Convention:** like other registry-driven member-call runtime bridges, the argument is a bare scalar — `websocket.serve(8080)` — not an object literal. `websocket.serve({ port: 8080 })` is unreachable; the bridge marshals scalar arguments only, not struct literals.

**v0 scope.** Shipped: the client half (connect / one masked TEXT send / close) and a single-connection blocking echo server (bind/listen/accept, RFC 6455 handshake, unmasked TEXT/BINARY echo, CLOSE reply). Not yet shipped (epic #1180 follow-ups):

- Concurrency-pool dispatch, so the server can hold more than one connection at a time (#1923)
- Ping/pong, frame fragmentation, and close-code completeness (#1924)
- `wss://` / TLS (#1925)
- A richer per-client handler API — `server.clients()`, `onMessage`, per-client send (#1926)
- Typed message channels and backpressure (#1927)
- Client-side receive

---

## `sfn/http` capsule

The `sfn/http` capsule (v0.4.0, epic #1321, PR #1326) ships a pure-Sailfin HTTP/1.1 wire layer — request parsing, response serialization, header/query accessors, response builders, and a blocking `serve` — alongside thin wrappers over the runtime HTTP client.

**Declare the dependency in `capsule.toml` before importing:**

```toml
[dependencies]
"sfn/http" = "*"
```

Capsule functions are only staged into a consumer's codegen through a declared dependency. A loose `sfn run` of a manifest-less file cannot resolve them.

Import the functions and types you need:

```sfn
import { serve, Request, Response, response, not_found } from "sfn/http";
```

All server functions require the `![net, io]` effect; the client wrappers require `![net]`.

---

### Types

#### `Request`

```sfn
struct Request {
    method: string;
    path: string;
    query: string;
    headers: string[];
    body: string;
}
```

An incoming HTTP request. `headers` are raw `"Name: value"` lines. `query` is the raw string after `?` with no percent-decoding in v0. `body` is populated for POST/PUT in a future wave — **do not rely on `body` for non-GET requests in v0**.

---

#### `Response`

```sfn
struct Response {
    status: int;
    headers: string[];
    body: string;
}
```

An outgoing HTTP response. `headers` are raw `"Name: value"` lines; framing headers (`Content-Length`, `Connection`, `Transfer-Encoding`) and any header containing CR/LF are added or dropped automatically by `serialize_response`.

---

#### `ServerConfig`

```sfn
struct ServerConfig {
    port: int;
    host: string;
}
```

Carried for forward compatibility. **`host` is not enforced in v0** — the runtime binds `INADDR_ANY` regardless of this field. The v0 `serve` function takes a bare `port: int`, not a `ServerConfig`.

---

### Server

#### `serve(handler: * fn (Request) -> Response, port: int = 8080) -> void ![net, io]`

Start a blocking HTTP/1.1 server on `port`. Dispatches each accepted connection to `handler` and does not return. Only one server per process is supported in v0.

The handler **must be a top-level named function passed address-taken**. Closures are not supported as handlers in v0; the type system enforces this.

```sfn
import { serve, Request, Response, response, not_found } from "sfn/http";

fn handle(req: Request) -> Response {
    if strings_equal(req.path, "/") { return response("Welcome to Sailfin!"); }
    return not_found();
}

fn main() ![net, io] {
    serve(handle as * fn (Request) -> Response, 8080);
}
```

#### `serve_tls(handler: * fn (Request) -> Response, port: int, cert_path: string, key_path: string) -> void ![net, io]`

Start a blocking HTTP/1.1 server on `port`, terminate TLS with the PEM certificate and private key loaded from `cert_path` / `key_path`, and dispatch each request to the same typed `Request -> Response` handler shape as plaintext `serve`. Status codes and headers from the returned `Response` are serialized before the TLS worker writes the response. If the cert or key fails to load the server never binds — there is **no plaintext downgrade**.

```sfn
import { serve_tls, Request, Response, response, not_found } from "sfn/http";

fn handle(req: Request) -> Response {
    if strings_equal(req.path, "/") { return response("Welcome to Sailfin over TLS!"); }
    return not_found();
}

fn main() ![net, io] {
    serve_tls(
        handle as * fn (Request) -> Response,
        8443,
        "/etc/sailfin/cert.pem",
        "/etc/sailfin/key.pem",
    );
}
```

##### Low-level TLS runtime entry

The runtime also exposes `sfn_serve_tls(handler, port, cert, key)` for low-level callers that already speak the raw moved-`OwnedBuf` handler ABI. Prefer the typed capsule wrapper above for new code.

```sfn
extern fn sfn_serve_tls(handler: * u8, port: i32, cert: * u8, key: * u8) -> void;
```

Out of scope for 1.0: mTLS / client-certificate request (the server terminates TLS but does not request client certs). Both the outbound `https://` client and this inbound path require OpenSSL on the link host — see the [OpenSSL build-host dependency runbook](https://github.com/SailfinIO/sailfin/blob/main/docs/runbooks/openssl-build-dependency.md).

---

### Response builders

#### `response(body: string) -> Response`

Build a 200 OK response with the given body.

```sfn
fn handle(req: Request) -> Response {
    return response("Hello, world!");
}
```

---

#### `response_with_status(status: int, body: string) -> Response`

Build a response with an explicit HTTP status code.

```sfn
fn handle(req: Request) -> Response {
    return response_with_status(201, "Created");
}
```

---

#### `json_response(body: string) -> Response`

Build a 200 OK response with `Content-Type: application/json`. The caller is responsible for producing valid JSON in `body`.

```sfn
fn handle(req: Request) -> Response {
    return json_response("{\"ok\": true}");
}
```

---

#### `not_found(body: string = "Not Found") -> Response`

Build a 404 Not Found response.

```sfn
fn handle(req: Request) -> Response {
    if strings_equal(req.path, "/") { return response("OK"); }
    return not_found();
}
```

---

### Wire helpers

#### `parse_request(raw: string) -> Request`

Parse a raw HTTP/1.1 request string into a `Request`. Used internally by `serve`; exposed for testing and custom I/O loops.

```sfn
let req = parse_request("GET /hello?name=world HTTP/1.1\r\nHost: localhost\r\n\r\n");
```

---

#### `parse_response(raw: string) -> Response`

Parse a raw HTTP/1.1 response string into a `Response` — the client-side twin of `parse_request`. The status line yields the numeric `status` (the reason phrase is discarded); `headers` are the raw `"Name: value"` lines up to the blank line; `body` is whatever follows. An empty input (e.g. a connect failure) yields a `Response` with `status: 0`. Used internally by `fetch`; exposed for testing and custom client loops.

```sfn
let rsp = parse_response("HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\n\r\n");
// rsp.status == 404
```

---

#### `serialize_response(rsp: Response, keep_alive: boolean = false) -> string`

Serialize a `Response` to a raw HTTP/1.1 response string. Emits the status line (using an internal reason-phrase table), the user-supplied headers, `Content-Length`, and a `Connection` header: `Connection: keep-alive` when `keep_alive` is `true`, otherwise `Connection: close` (the default). Any user header containing CR or LF is silently dropped (injection guard). Headers that name `Content-Length`, `Connection`, or `Transfer-Encoding` are also dropped to prevent response smuggling.

```sfn
let raw = serialize_response(Response { status: 200, headers: [], body: "OK" });
```

---

#### `header(req: Request, name: string) -> string?`

Case-insensitive header lookup. Returns the trimmed header value, or `null` if the header is absent.

```sfn
fn handle(req: Request) -> Response {
    let ct = header(req, "Content-Type");
    if ct == null { return response_with_status(400, "Missing Content-Type"); }
    return response("OK");
}
```

---

#### `query_param(req: Request, name: string) -> string?`

Look up a query-string parameter by name. Returns the raw (non-percent-decoded) value, or `null` if the parameter is absent.

```sfn
fn handle(req: Request) -> Response {
    let name = query_param(req, "name");
    if name == null { return response("Hello, stranger!"); }
    return response("Hello, " + name + "!");
}
```

---

#### `reason_phrase(status: int) -> string`

Return the standard reason phrase for common HTTP status codes (e.g. `200` → `"OK"`, `404` → `"Not Found"`). Returns `"Status"` for codes not in the table.

```sfn
let phrase = reason_phrase(418); // "Status"
```

---

### Client

The following wrappers call the underlying runtime HTTP client and return the response **body string** directly (distinct from the `runtime.http` client which returns a `Response` struct with both `body` and `status`). Like `http.get`/`http.post`, `get`, `post`, and typed `fetch` support `https://` transparently with certificate verification (SFEP-0036).

#### `get(url: string) -> string ![net]`

Perform an HTTP GET request and return the response body.

```sfn
import { get } from "sfn/http";

fn fetch_data(url: string) -> string ![net] {
    return get(url);
}
```

---

#### `post(url: string, body: string) -> string ![net]`

Perform an HTTP POST request with the given body and return the response body.

```sfn
import { post } from "sfn/http";

fn submit(url: string, payload: string) -> string ![net] {
    return post(url, payload);
}
```

---

#### `fetch(method: string, url: string, headers: string[], body: string) -> Response ![net]`

Typed HTTP client (Wave 4, epic #1321). Unlike `get`/`post` (which return only the response body string), `fetch` returns a `Response` exposing the **status code** and **response headers** as well as the body. `headers` are raw `"Name: value"` request-header lines; `body` is sent with a `Content-Length` only when non-empty. A connect/socket failure yields a `Response` with `status: 0`. Built on the additive runtime primitive `sfn_http_request_raw`, which returns the full raw response; the capsule parses it via `parse_response`.

```sfn
import { fetch } from "sfn/http";

fn check(url: string) -> int ![net] {
    let resp = fetch("GET", url, [], "");
    return resp.status; // e.g. 200, 403, 404
}
```

The `fetch` client shares the v0 client limits: no chunked decoding and no redirect following. `http://` and `https://` both use the shared DNS-capable socket path; `https://` verifies the peer chain and hostname by default and fails closed on an untrusted certificate.

---

#### Native keep-alive client primitives (single-connection reuse)

For back-to-back requests to the same authority, `sfn/http` exposes three runtime adapter primitives that hold a TCP or TLS connection open across multiple send/receive cycles (#1711). These are externable from a consumer capsule and bypass the per-request connect overhead of `get`/`post`/`fetch`; `https://` authorities use the same verified TLS client path as one-shot requests.

##### `sfn_http_conn_open(url: string) -> int ![net]`

Open a persistent TCP connection to the authority in `url`. Returns a file-descriptor integer on success, or `-1` on failure. The caller must pass this fd to every subsequent `_send` call and close it with `_close` when done.

##### `sfn_http_conn_send(fd: int, method: string, url: string, headers: string[], body: string) -> Response ![net]`

Send an HTTP request over an already-open connection `fd` and read back a `Response`. The response must be `Content-Length`-framed (chunked transfer-encoding is not decoded on this path). Sends `Connection: keep-alive` automatically so the server holds the socket open.

##### `sfn_http_conn_close(fd: int) -> void ![net]`

Close the persistent connection identified by `fd`. Always call this when the connection is no longer needed to avoid fd exhaustion.

```sfn
import { sfn_http_conn_open, sfn_http_conn_send, sfn_http_conn_close } from "sfn/http";

fn batch_requests(base: string) -> void ![net] {
    let fd = sfn_http_conn_open(base);
    if fd < 0 { return; }
    let r1 = sfn_http_conn_send(fd, "GET", base + "/a", [], "");
    let r2 = sfn_http_conn_send(fd, "GET", base + "/b", [], "");
    sfn_http_conn_close(fd);
}
```

v0 limit: the response to each `_send` call must carry a `Content-Length` header; responses without one are not decoded on this path.

---

### v0 limitations

- **HTTP/1.1 only, blocking accept.** The typed capsule provides plaintext `serve` and TLS `serve_tls`; inbound TLS termination is enforced end-to-end (SFEP-0036) and fails closed on cert/key load errors. Keep-alive IS honored: the server reuses a connection for back-to-back requests unless the client sends `Connection: close` (#1711). HTTP pipelining (multiple in-flight requests on one connection) remains out of scope.
- **`Content-Length` bodies only** — POST/PUT request bodies are drained via `Content-Length` (capped at 1 MiB; over-cap requests get a `500`), so `Request.body` is reliable. Chunked transfer-encoding is not decoded (post-1.0).
- **`host` binding not enforced** — the server always binds `INADDR_ANY` regardless of `ServerConfig.host`.
- **Per-request allocations are not freed** — a known leak; acceptable for short-lived or v0 servers but not production long-running processes.
- **One server per process** — multiple concurrent `serve` calls in one process are not supported in v0.

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
fn start_server(port: int) ![io] {
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

> **Planned:** Generic containers (`Map<K, V>`, `Set<T>`, and an explicit
> growable `Vec<T>`) do not ship yet. Generic constraints now work for the
> current pointer-width scope, but these container APIs and arbitrary-width
> element lowering remain future work. See the [roadmap](/roadmap) for sequencing.
>
> Today, array literals (`[1, 2, 3]`) with `T[]` types, `.length`, `.push(item)`, and the `.map(closure)` / `.filter(closure)` / `.reduce(init, closure)` method forms (pointer-width `int` elements — #1507 / #1508, epic #1118) are the shipped collection surface, along with the prelude array utilities (`array_map`, `array_filter`, `array_reduce`). Generic non-pointer-width collection lowering remains incomplete (designed in SFEP-0028).

### Arrays (available today)

```sfn
let numbers: int[] = [1, 2, 3];
numbers.push(4);
let n = numbers.length;        // 4
let first = numbers[0];        // 1

// .map / .filter / .reduce (closure) — shipped for pointer-width int arrays
let base: int = 10;
let shifted: int[] = numbers.map(fn (x: int) -> int { return x + base; });
// shifted == [11, 12, 13, 14]
let evens: int[] = shifted.filter(fn (x: int) -> bool { return x % 2 == 0; });
// evens == [12, 14]
let total: int = numbers.reduce(0, fn (acc: int, x: int) -> int { return acc + x; });
// total == 10
```

**`.map` / `.filter` / `.reduce` scope:** the callback ABI is `iN(i8* env, i64 …)`, so all three method forms work on `int[]` arrays today (the binding must be annotated `int[]`). They dispatch through real `runtime/sfn/array.sfn` bodies (`sfn_array_sfn_map` / `_filter` / `_reduce`) over the runtime-callable closure-apply seam (#1507 landed the seam + `map`; #1508 landed `filter` / `reduce`; epic #1118), and capturing closures work. Other element/accumulator widths (e.g. `float[]`, `string[]`, struct arrays) do not yet have collection lowering and are rejected with a diagnostic rather than mis-mapped.

### Planned `Vec<T>`

```sfn
// Planned API — not yet implemented
Vec<T>.new() -> Vec<T>
Vec<T>.push(item: T) -> void
Vec<T>.pop() -> T?
Vec<T>.get(index: int) -> T?
Vec<T>.len() -> int
Vec<T>.is_empty() -> boolean
Vec<T>.contains(item: T) -> boolean
Vec<T>.remove(index: int) -> T
Vec<T>.slice(start: int, end: int) -> Vec<T>
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
Map<K, V>.len() -> int
```

### Planned `Set<T>`

```sfn
// Planned API — not yet implemented
Set<T>.new() -> Set<T>
Set<T>.add(item: T) -> void
Set<T>.has(item: T) -> boolean
Set<T>.delete(item: T) -> void
Set<T>.size() -> int
```

---

## Planned modules

The modules below are on the roadmap and are documented here to give a preview of the planned API. None are available in the current release.

---

### `rand` module — Planned (`![rand]` effect)

> **Coming in 1.0:** Random-number helpers as a standard module. The `rand` effect token is parsed today but no `rand.*` APIs ship yet. See the [roadmap](/roadmap).

```sfn
// Planned — not yet implemented
rand.int(min: int, max: int) -> int ![rand]
rand.float() -> float ![rand]          // uniform in [0.0, 1.0)
rand.bool() -> boolean ![rand]
rand.shuffle<T>(items: T[]) -> T[] ![rand]
rand.choice<T>(items: T[]) -> T? ![rand]
```

---

### `time` module (`![clock]` effect)

#### `sleep(milliseconds: int) ![clock]`

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
Timestamp.unix_millis() -> int
Timestamp.format(pattern: string) -> string
```

---

### `process` module — Planned (`![io]` effect)

> **Coming in 1.0:** Subprocess execution and process lifecycle helpers. See the [roadmap](/roadmap).

```sfn
// Planned — not yet implemented
process.exec(command: string) -> ProcessResult ![io]
process.exit(code: int) -> never ![io]

struct ProcessResult {
    stdout: string;
    stderr: string;
    exit_code: int;
}
```

---

### `sync` module

The `sync` module exposes `Channel<T>` and the `channel()` constructor. See
the [Concurrency and Async Utilities](#concurrency-and-async-utilities)
section above for the full API and examples.

---

### `sfn/ai` capsule — Planned (`![model]` effect)

> **Post-1.0:** The `sfn/ai` capsule will provide model invocation, typed output schemas, tool dispatch, and provider adapters as library functions. All `sfn/ai` functions carry `![model]` in their signatures, so any caller must declare `![model]`. The `model`, `prompt`, `tool`, and `pipeline` block keywords have been removed from the language. See the [roadmap](/roadmap).

```sfn
// Planned sfn/ai API — not yet implemented
import { call_model } from "sfn/ai";

fn classify(text: string) -> string ![model] {
    return call_model("classifier", text);
}
```

---

*The standard library is actively expanding as the runtime migrates from C to Sailfin. See [Runtime ABI](/docs/reference/runtime-abi) for migration status.*
