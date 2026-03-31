---
title: Language Specification
description: The complete Sailfin language reference.
section: reference
order: 1
---

This page is the authoritative web reference for the Sailfin language.
The canonical source file is [`docs/spec.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/spec.md)
in the repository. For deeper tutorials, see the [Learning Sailfin](/docs/learn/basics) section.

The specification is organized in two parts:

- **Part A — Current Language**: behavior available in the self-hosted native compiler today.
- **Part B — Design Preview**: planned extensions, tracked in proposals under `docs/proposals/`. Treat as informative until `docs/status.md` marks the feature as shipped.

---

## Part A — Current Language

### §1 Lexical Structure

**Identifiers** begin with a letter or `_` and may contain ASCII letters, digits, or `_`.
Identifiers are case-sensitive. Reserved keywords may not be used as identifiers.

**Keywords** — see [Keywords Reference](/docs/reference/keywords) for the full list with descriptions.

**Literals**:

| Kind | Examples | Notes |
|------|----------|-------|
| Integer | `42`, `0`, `1_000_000` | Underscores allowed as separators |
| Float | `3.14`, `0.5`, `1.0e6` | 64-bit IEEE 754 |
| String | `"hello"`, `"line\n"` | UTF-8, escape sequences, `{{ }}` interpolation |
| Boolean | `true`, `false` | |
| Null | `null` | Explicit absence of a value |

Currency literals (`$0.05`) are **not yet parsed** — use `0.05 // USD` as a comment annotation.
Time literals (`1s`, `150ms`) are **not yet parsed** — use numeric milliseconds.

**Comments**:
- `//` single-line
- `/* ... */` multi-line
- `///` doc comments (on declarations)

**Effect annotations** — `![effect, ...]` after a function/test/pipeline signature:

```sfn
fn fetch(url: string) -> string ![io, net] { ... }
```

### §2 Modules and Imports

```sfn
import { Channel, channel } from "sync";
import { log } from "sfn/log";
import { parse } from "./parser";
import { substring as substr } from "runtime/prelude";

export { MyType, my_fn };
export { helper as publicHelper } from "./internal";
```

- **Relative paths** (`"./module"`) — same capsule
- **Registry capsules** (`"sfn/log"`) — from the capsule registry
- **Workspace capsules** (`"core"`) — sibling capsules in a workspace

Modules may re-export items from other modules. Specifiers support aliasing with `as`.

### §3 Declarations

#### §3.1 Variables

```sfn
let name = "Sailfin";             // immutable, type inferred
let x: int = 42;                  // immutable, explicit type
let x -> int = 42;                // alternative annotation syntax
let mut counter = 0;              // mutable
counter = counter + 1;            // OK
// name = "Other";                // ERROR: immutable binding
```

Type annotations are optional; the compiler infers types where possible.
Uninitialized bindings default to `null`.

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
    // await is planned — see Part B
    return http.get(url);
}
```

- Effect annotations `![...]` come after the parameter list and optional return type
- `async fn` records the `is_async` flag; `await` is not yet parsed (Part B)
- Decorators `@name` are parsed as metadata (no semantic enforcement today)
- Default parameter values: `fn f(x: int = 0)`
- Generic functions: `fn first<T>(items: Vec<T>) -> T?`

#### §3.3 Structs

```sfn
struct Point {
    x -> Float;
    mut y -> Float;
}

struct User implements Greeter {
    id   -> int;
    name -> string;

    fn greet(self) -> string {
        return "Hi, {{ self.name }}!";
    }

    fn rename(&mut self, new_name: string) {
        self.name = new_name;
    }
}
```

- Fields default to immutable; `mut` allows reassignment
- Both `name -> Type` and `name: Type` syntax are accepted
- Methods are defined with `fn` inside the struct body
- The `implements` clause lists interfaces the struct satisfies
- Struct literals: `Point { x: 1.0, y: 2.0 }`

#### §3.4 Enums

```sfn
enum Direction { North, South, East, West }

enum Response {
    Ok { value -> string },
    NotFound,
    Error { code -> int, message -> string },
}
```

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
type Result<T> = Response | T;
type Matrix = Vec<Vec<Float>>;
```

#### §3.7 Model Declarations

> **Status**: Parsed and emits `.model` IR. Model execution (`.call()`) and
> generation cards are planned for the post-1.0 AI milestone.

```sfn
model Summarizer : Model<Text, Summary> {
    engine     = "gpt-foo@2.3.1";
    schema     = Summary;
    max_tok    = 2000;
    cost_cap   = 0.05;           // USD
    evaluators = [ Faithfulness, LatencyBudget ];
}
```

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `engine` | string | Yes | Provider + version tag |
| `schema` | Type | Yes | Output validation type |
| `max_tok` | number | No | Maximum output tokens |
| `cost_cap` | number | No | Maximum spend per call |
| `evaluators` | Array | No | Quality/guardrail evaluators |
| `temperature` | number | No | Sampling temperature (0–2) |
| `seed` | number | No | Deterministic seed |

#### §3.8 Prompt Blocks

> **Status**: Parsed and emits `.prompt` IR. The `model` effect is enforced.
> No network calls are made — prompt execution is planned post-1.0.

```sfn
fn summarize(doc: string) -> Summary ![model] {
    prompt system { "You are a precise technical summarizer." }
    prompt user   { "Summarize:\n{{ doc }}" }
    // Summarizer.call() — execution planned
}
```

Prompt blocks execute in source order. Canonical channel names: `system`, `user`,
`assistant`, `tool`. Any identifier is accepted; vocabulary enforcement is planned.

#### §3.9 Pipeline Declarations

> **Status**: Parsed as plain functions. The `|>` operator is not yet implemented.

```sfn
pipeline process_docs(docs: Vec<string>) ![io] {
    // Use function calls until |> is implemented
    let chunked = chunk(docs);
    let embedded = embed(chunked);
    upsert(embedded, "docs_idx");
}
```

#### §3.10 Tool Declarations

> **Status**: Parsed and recorded as metadata. No dispatcher yet.

```sfn
tool FetchUser(id: string) -> User ![net] {
    return http.get("/users/{{ id }}");
}
```

#### §3.11 Test Declarations

```sfn
test "basic arithmetic" {
    assert(2 + 2 == 4);
}

test "reads a file" ![io] {
    let content = fs.read("fixtures/sample.txt");
    assert(content.length > 0);
}
```

### §4 Statements and Control Flow

```sfn
// Variables
let x = 10;
let mut y = 0;

// Conditionals
if x > 5 {
    y = 1;
} else if x == 5 {
    y = 0;
} else {
    y = -1;
}

// For loop
for item in items {
    process(item);
}

// While loop
while queue.len() > 0 {
    handle(queue.pop());
}

// Loop with break value
let result = loop {
    let val = compute();
    if val > threshold {
        break val;
    }
};

// Match — see stability note below
match status {
    "active"  => activate(),
    "paused"  => pause(),
    _         => print.err("Unknown: {{ status }}"),
}

// Try / catch / finally
try {
    let data = fs.read(path);
    process(data);
} catch (e: IoError) {
    print.err("Read failed: {{ e.message }}");
    throw e;
} finally {
    cleanup();
}
```

**Assignment operators**: `=`, `+=`, `-=`, `*=`, `/=`

> **Note on `match` stability**: `match` is parsed and emits IR, but LLVM lowering of common match patterns (number literals, enum variants) may trigger crashes or incorrect codegen in the current compiler. String pattern matching (as shown above) is more reliable. Move complex match expressions to Part B patterns or use `if`/`else if` chains until lowering stabilizes.

### §5 Expressions and Operators

| Category | Operators |
|----------|-----------|
| Arithmetic | `+` `-` `*` `/` `%` |
| Comparison | `==` `!=` `<` `>` `<=` `>=` |
| Logical | `&&` `\|\|` `!` |
| Compound assignment | `+=` `-=` `*=` `/=` |
| Type check | `is` |
| Borrow | `&expr` `&mut expr` |
| Cast | `expr as Type` |

`&&` and `||` short-circuit. `is` performs a runtime type check and returns `boolean`.

Operator precedence: unary > multiplicative > additive > comparison > equality > `&&` > `||` > assignment.

### §6 Type System

**Primitive types**:

| Type | Description | FFI C equivalent |
|------|-------------|-----------------|
| `number` | 64-bit float (primary numeric type) | `double` |
| `string` | UTF-8 string | — |
| `boolean` | Boolean | `_Bool` |
| `void` | No return value | `void` |
| `null` | Absence of a value | — |

**Integer and float types** (for FFI and low-level use):
`i8`, `i16`, `i32`, `i64`, `u8`, `u16`, `u32`, `u64`, `usize`, `isize`, `f32`, `f64`

**Composite types**: structs, enums, `Vec<T>`, `Map<K,V>`, arrays

**Optional types**: `T?` — the value is `T` or `null`

**Union types**: `A | B` — the value is either type; matched with `match`

**Generic types**: `Vec<T>`, `Pair<A,B>`, `Result<T, E>`

**Wrapper types** (syntax accepted; enforcement planned for 1.0+):

| Type | Semantics |
|------|-----------|
| `Affine<T>` | May be dropped, cannot be duplicated |
| `Linear<T>` | Must be consumed exactly once |
| `PII<T>` | Personally identifiable information — egress guards planned |
| `Secret<T>` | Secret value — logging/serialization guards planned |

**Reference types** (syntax accepted; borrow checking planned):
- `&T` — shared (read-only) borrow
- `&mut T` — exclusive mutable borrow

**Raw pointer types** (FFI, `unsafe` only):
- `*T` — read-only raw pointer
- `*mut T` — mutable raw pointer
- `*opaque` — opaque foreign pointer (`void*`)

### §7 Effect System

Every function that performs side effects must declare them with `![...]`:

```sfn
fn pure(x: int) -> int { x * 2 }           // no effects — guaranteed pure
fn read_file(path: string) ![io] { ... }    // requires io capability
fn fetch(url: string) ![net] { ... }        // requires net capability
fn analyze(text: string) ![io, model] { }  // multiple effects
```

**Canonical effects**:

| Effect | Token | Grants | Enforced Today |
|--------|-------|--------|----------------|
| IO | `io` | Filesystem, console, logging | Yes |
| Network | `net` | HTTP, WebSocket, serve | Yes |
| Model | `model` | Prompt blocks, model invocation | Yes (prompt blocks) |
| Clock | `clock` | `sleep`, wall-clock | Partial |
| GPU | `gpu` | Tensor operations | Parsed only |
| Random | `rand` | Random generation | Parsed only |

**Enforcement rules**:
1. Any function calling an effectful operation must declare that effect
2. Effects are transitive: if A calls B, A must declare B's effects
3. Tests follow the same rules as functions
4. Missing effects are compile errors with fix-it hints

See [Effect System Reference](/docs/reference/effects) for the complete API surface per effect.

### §8 Pattern Matching

> **Note**: `match` is parsed by the compiler and emits IR, but LLVM lowering of numeric and enum variant patterns may be unreliable in the current release. String and wildcard patterns are more stable. See the stability note in §4.

```sfn
match value {
    0               => print("zero"),
    n if n < 0      => print("negative"),
    Response.Ok { value } => process(value),
    Response.Error { code, message } => print.err("{{ code }}: {{ message }}"),
    _               => print("other"),
}
```

Pattern forms:
- **Literal** — `0`, `"hello"`, `true`
- **Variable capture** — any identifier binds the value
- **Wildcard** — `_` matches anything, discards
- **Enum destructuring** — `Variant { field }` extracts payload fields
- **Guard** — `pattern if condition` adds a boolean filter
- **Exhaustiveness** — the compiler requires all cases be covered (or a `_` wildcard)

### §9 String Interpolation

```sfn
let name = "Sailfin";
let greeting = "Hello, {{ name }}!";         // "Hello, Sailfin!"
let math = "2 + 2 = {{ 2 + 2 }}";           // "2 + 2 = 4"
let nested = "User: {{ user.name.trim() }}"; // arbitrary expressions
```

Mandatory double braces. Whitespace at the edges is ignored: `{{name}}` and
`{{ name }}` are equivalent. The compiler lowers interpolated strings into
segment arrays evaluated at runtime.

### §10 Runtime

**Output**:
- `print(value) ![io]` — write to stdout
- `print.err(value) ![io]` — write to stderr
- `print.info/warn/error` — deprecated; use `print()` and `print.err()`

**Filesystem** (require `![io]`):
`fs.read(path)`, `fs.write(path, content)`, `fs.appendFile(path, content)`,
`fs.exists(path)`, `fs.writeLines(path, lines)`

**HTTP** (require `![net]`):
`http.get(url)`, `http.post(url, body)`

**Logging** (via `sfn/log` capsule, require `![io]`):
`log.info(msg)`, `log.warn(msg)`, `log.error(msg)`, `log.debug(msg)`
`log.warn` and `log.error` write to stderr.

**String utilities** (from `runtime/prelude`):
`substring(text, start, end)`, `find_char(text, char, start?)`,
`grapheme_count(text)`, `grapheme_at(text, index)`, `char_code(char)`

See [Standard Library](/docs/reference/standard-library) for full signatures.

### §11 Testing

```sfn
test "name" ![effects] {
    assert(expression);
    assert(actual == expected);
}
```

- `test` is a first-class keyword — no external framework needed
- Effects are declared just like on functions
- Test files are named `*_test.sfn` and discovered automatically by `sfn test`
- `assert(expr)` fails with the expression text on failure

---

## Part B — Design Preview

The features below are specified and designed but **not yet implemented**. They
are tracked as 1.0 or post-1.0 milestones in [`docs/roadmap.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/roadmap.md).

### Concurrency

```sfn
// All of these are planned — not yet parsed by the compiler

async fn fetch(url: string) -> string ![net] {
    return await http.get(url);   // await not yet implemented
}

fn process_batch(items: Vec<Item>) ![io] {
    let messages: Channel<string> = channel(capacity: 32);

    routine {                      // routine not yet implemented
        messages.send("hello");
    }

    let msg = await messages.receive();
}
```

**Planned for 1.0**: `await`, `routine { }`, `channel()`, `spawn`.

### Model Execution

```sfn
// model.call() parses today but performs no execution

fn summarize(text: string) -> Summary ![io, model] {
    prompt system { "You are a precise summarizer." }
    prompt user   { "Summarize: {{ text }}" }
    let gen = Summarizer.call();   // planned: executes against model provider
    print(gen.card);               // planned: generation card (provenance metadata)
    return gen.output;             // planned: typed Summary
}
```

**Planned post-1.0**: model execution, generation cards, typed output schemas, evaluators.

### Pipeline Operator

```sfn
// |> is not yet implemented; use function calls

pipeline index_corpus(docs: Vec<string>) ![io, gpu] {
    docs
        |> chunk(by: "semantic", target_tokens: 512)   // planned
        |> embed(with: "e5-large")
        |> upsert(index: "docs_idx");
}
```

### Ownership Enforcement

`Affine<T>` and `Linear<T>` wrappers are parsed today but move/consume rules
are not enforced. `&T`/`&mut T` borrows are parsed but exclusivity is not checked.
Full enforcement is a 1.0 requirement.

### `PII<T>` / `Secret<T>` Enforcement

These wrapper types are parsed as ordinary nominal types today. Runtime taint
tracking, egress guards, and redaction transformers are planned post-1.0.

### Hierarchical Effects

Planned: `io.fs.read`, `io.fs.write`, `net.http`, `net.ws` — fine-grained
sub-effects that compose hierarchically. Currently all sub-effects collapse to
the parent effect token.

### Currency and Time Literals

`$0.05` (currency) and `1s`, `150ms` (duration) are planned literal forms.
Use numeric values with comments until then: `0.05 // USD`, `1000 // ms`.

### Unsafe Enforcement

`unsafe` and `extern` syntax is parsed today but the unsafe capability is not
enforced — unsafe blocks outside `![unsafe]` functions are not rejected.
Full enforcement arrives with the native runtime.
