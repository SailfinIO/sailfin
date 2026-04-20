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
let x: number = 42;               // immutable, explicit type
let mut counter = 0;              // mutable
counter = counter + 1;            // OK
// name = "Other";                // ERROR: immutable binding
```

Type annotations are optional; the compiler infers types where possible.
Uninitialized bindings default to `null`. Variables, parameters, and struct
fields use `:` for type annotations; only function return types use `->`.

#### §3.2 Functions

```sfn
fn add(x: number, y: number) -> number {
    return x + y;
}

fn greet(name: string) -> string {
    return "Hello, {{ name }}!";   // implicit return also works
}

fn save(path: string, data: string) ![io] {
    fs.write(path, data);
}

async fn fetch(url: string) -> string ![net] {
    // await is planned — see Part B
    return http.get(url);
}
```

- Effect annotations `![...]` come after the parameter list and optional return type
- `async fn` records the `is_async` flag; `await` is not yet parsed (Part B)
- Decorators `@name` are parsed as metadata (no semantic enforcement today)
- Default parameter values: `fn f(x: number = 0)`
- Generic functions: `fn first<T>(items: T[]) -> T?`

#### §3.3 Structs

```sfn
struct Point {
    x: number;
    mut y: number;
}

struct User implements Greeter {
    id: number;
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
- Fields end with `;` and use `:` for the type annotation
- Methods are defined with `fn` inside the struct body; the first parameter is bare `self`
- The `implements` clause lists interfaces the struct satisfies (comma-separated for multiple)
- Struct literals: `Point { x: 1.0, y: 2.0 }`

#### §3.4 Enums

```sfn
enum Direction { North, South, East, West }

enum Response {
    Ok { value: string },
    NotFound,
    Error { code: number, message: string },
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
    fn get(self, index: number) -> T?;
    fn len(self) -> number;
}
```

Interfaces provide trait-style method signatures. A struct satisfies an interface
by implementing all its methods and declaring `implements InterfaceName`.

#### §3.6 Type Aliases

```sfn
type UserId = string;
type MaybeResponse<T> = Response | T;
type Row = number[];
```

> `Result<T, E>` and function type aliases are on the [roadmap](/roadmap);
> use union return types (`T | MyError`) and plain function signatures today.

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
```
