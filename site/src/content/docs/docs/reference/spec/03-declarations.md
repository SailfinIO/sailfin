---
title: "§3 Declarations"
description: "Sailfin language specification — Declarations."
sidebar:
  order: 3
  label: "§3 Declarations"
---

#### §3.1 Variables

```sfn
let name = "Sailfin";             // immutable, type inferred
let x: int = 42;                  // immutable, explicit type
let mut counter = 0;              // mutable
counter = counter + 1;            // OK
// name = "Other";                // ERROR: immutable binding
```

Type annotations are optional; the compiler infers types where possible.
Uninitialized bindings default to `null`. Variables, parameters, and struct
fields use `:` for type annotations; only function return types use `->`.

##### §3.1.1 Thread-local storage class

Top-level `let mut` bindings accept a `thread_local` prefix that flips the
backing storage from process-global to per-thread:

```sfn
thread_local let mut frame_head: i64 = 0;   // per-thread storage
```

`thread_local` is a storage-class annotation, not a type. It is only valid
in front of a top-level `let mut` declaration — function-local `thread_local`
is rejected (an `alloca` is already stack-local and cannot be TLS), and
`thread_local let x` without `mut` is rejected with `E0807` (an immutable
thread-local is a contradiction). At LLVM lowering the declaration emits
`@global.<name> = internal thread_local global <T> <init>` instead of the
default `internal global` form; reads and writes against the binding use the
same `@global.<name>` symbol they would for an ordinary global.

#### §3.2 Functions

```sfn
fn add(x: int, y: int) -> int {
    return x + y;
}

fn greet(name: string) -> string {
    return "Hello, {{ name }}!";   // implicit return also works
}

fn save(path: string, data: string) ![io] {
    fs.write(path, data);
}

async fn fetch(url: string) -> string ![net] {
    // `async fn` is structural in v0 and runs synchronously.
    return http.get(url);
}
```

- Effect annotations `![...]` come after the parameter list and optional return type
- `async fn` records the `is_async` flag, but its return value is not yet a live
  future. `await` is implemented for futures created by `spawn fn() -> T { ... }`.
- Decorators `@name` are parsed as metadata (no semantic enforcement today)
- Default parameter values: `fn f(x: int = 0)`
- Generic functions: `fn first<T>(items: T[]) -> T?`

#### §3.3 Structs

```sfn
struct Point {
    x: float;
    mut y: float;
}

struct User implements Greeter {
    id: int;
    name: string;

    fn greet(self) -> string {
        return "Hi, {{ self.name }}!";
    }

    fn rename(self, new_name: string) {
        self.name = new_name;
    }
}
```

- Fields default to immutable; `mut` allows reassignment
- Fields use `:` for the type annotation and may be terminated with `;`, `,`, or — for the last field in the body — nothing at all. The semicolon form is canonical; the comma and bare-last forms are accepted to match Rust/TS conventions
- Methods are defined with `fn` inside the struct body; the first parameter is bare `self`
- The `implements` clause lists interfaces the struct satisfies (comma-separated for multiple)
- Struct literals: `Point { x: 1.0, y: 2.0 }`

#### §3.4 Enums

```sfn
enum Direction { North, South, East, West }

enum Response {
    Ok { value: string },
    NotFound,
    Error { code: int, message: string },
}
```

Variant payloads use named fields with `:` type annotations. Construct variants as
`Response.Ok { value: "hi" }` and destructure them with `match`.

Variants may be unit (no payload) or carry named fields. Enum values are
matched exhaustively with `match`.

#### §3.5 Interfaces

```sfn
interface Serializable {
    fn serialize(self) -> string;
}

interface Container<T> {
    fn get(self, index: int) -> T?;
    fn len(self) -> int;
}
```

Interfaces provide trait-style method signatures. A struct satisfies an interface
by implementing all its methods and declaring `implements InterfaceName`.

#### §3.6 Type Aliases

```sfn
type UserId = string;
type MaybeResponse<T> = Response | T;
type Row = int[];
```

> The prelude `Result<T, E>` type and postfix `?` operator ship today; see
> [§12 Result and the `?` Operator](/docs/reference/spec/12-result-and-errors/).
> Function type aliases remain planned; use plain function signatures today.

#### §3.7 AI Constructs (Moved to Library)

The `model`, `prompt`, `tool`, and `pipeline` block keywords have been removed
from the language. AI functionality will be delivered via the `sfn/ai` library
capsule, planned post-1.0. The `![model]` effect remains as the language-level
capability gate — see [§7 Effect System](/docs/reference/spec/07-effects/).

#### §3.8 Test Declarations

```sfn
test "basic arithmetic" {
    assert 2 + 2 == 4;
}

test "reads a file" ![io] {
    let content = fs.read("fixtures/sample.txt");
    assert content.length > 0;
}

@tag("slow")
test "rebuilds the whole index" ![io] {
    assert reindex() == Ok;
}
```

Tests accept decorators, parsed as metadata under the same rule as other
declarations (no semantic enforcement today). The `@tag("<value>")`
decorator is consumed by the `sfn test --tag <value>` filter — see
[§11 Testing](/docs/reference/spec/11-testing/).
