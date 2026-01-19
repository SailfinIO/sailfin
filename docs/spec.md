# Sailfin Language Specification

Version: 0.2.1 (design preview)
Date: October 2025

Sailfin is an AI-native, expression-oriented programming language that combines
Rust-grade safety, Swift-like ergonomics, and runtime observability. This
specification documents the current compiler behavior and the design direction
for planned features.

This specification is organised into two parts:

- **Part A — Current Language** documents the behavior available today and
  should stay in sync with `docs/status.md`.
- **Part B — Design Preview** records planned extensions and references active
  proposals under `docs/proposals/`. Treat the preview as informative until the
  status document marks the feature as shipped.

For an at-a-glance summary of what is implemented today, consult
`docs/status.md`.

NOTE: Diagrams and directory trees showing a unified fleet layout (with
`fleet.toml`, `std/`, `runtime/`, etc.) represent the target architecture, not
the current on-disk structure.

## Part A — Current Language

## 1. Lexical Structure

- **Identifiers** begin with a letter and may contain ASCII letters, digits, or
  `_`. Identifiers are case-sensitive.
- **Keywords** are listed in `docs/keywords.md`. They include traditional
  control-flow terms (`fn`, `async`, `await`, `match`, …) and AI-first syntax
  such as `model`, `prompt`, `pipeline`, `test`, and the implemented `assert`
  statement (see §8).
- **Literals**:
  - Numeric literals support integers (`42`) and decimals (`3.14`). Currency
    literals (e.g. `$0.05`) are **not yet parsed** by the compiler;
    use a numeric literal plus a trailing comment for monetary values, e.g.
    `0.05 // USD`.
  - String literals use double quotes, support escapes, and recognise
    `{{ expression }}` interpolation (see §9).
  - Boolean literals are `true` and `false`.
  - `null` denotes the absence of a value.
- **Comments** use `//` for single-line comments and `/* … */` for multi-line
  comments.

### 1.1 Effect Annotation

Functions, pipelines, tests, and tools may declare required capabilities with
`![effect, ...]` syntax appended to the signature:

```sfn
fn fetch_order(id: OrderId) -> Order ![io, net] { ... }
```

Current status: the parser records effect lists and the compiler validator
(`compiler/src/effect_checker.sfn`) enforces coverage for prompts, console I/O,
filesystem/HTTP/WebSocket helpers, `spawn`/`serve`, `sleep`, and decorators that
imply `io`. See the Effect System section below for details.

## 2. Modules, Imports, and Capabilities

Source files compile independently. Imports use ES-module style syntax and
canonical Sailfin-branded paths:

```sfn
import { Channel, channel } from "sfn/async";
```

Modules may re-export their own declarations or items from other modules via
`export` statements. Specifiers support aliasing for both imports and exports:

```sfn
export { substring, find_char as locate } from "./string_utils";
```

Capsules declare their required capabilities in `sail.toml`; multi-capsule
workspaces centralise shared policies in `fleet.toml`. When self-hosted,
invoking an undeclared capability (e.g. sending a network request) that is not
listed in the manifest or function effect set results in a compile-time error.

## 3. Declarations

### 3.1 Variables

Variables default to immutability and are introduced with `let`. Add `mut` to
allow reassignment.

```sfn
let name -> string = "Sailfin";
let mut counter -> number = 0;
```

Type annotations are optional; the current compiler performs limited
inference. Initialisers may be omitted; the compiler emits `null` when a
binding lacks an explicit expression.

### 3.2 Functions and Methods

`fn` declares functions. Parameters accept optional type annotations and default
values. Return types use `->`.

```sfn
fn add(x -> number, y -> number) -> number {
    return x + y;
}
```

`async fn` enables `await` inside the body. Decorators (`@identifier`) are
parsed and captured as metadata for later semantic passes.

Self-hosted status: the Sailfin parser now captures generic type parameter
clauses (`fn map<T>(...)`) on both top-level functions and struct methods, so
later semantic passes can mirror the current compiler's metadata.
Function bodies preserve explicit `return` and expression statements, allowing
the Sailfin-native code generator to emit runnable output instead of stub
comments.

#### 3.2.1 Effect Signatures

`![...]` after a signature lists the effects the body may perform. The canonical
set is `io`, `net`, `model`, `gpu`, `rand`, and `clock`. Custom effects may be
introduced via manifests.

```sfn
fn issue_refund(order: Order) -> Refund ![io, model, net] {
    let decision = RiskAssessor.call(order);
    payments.refund(order.payment_id);
    decision.into_refund();
}
```

Current enforcement requires routines that invoke console helpers or timers to
declare matching effects. Calling `print.info(...)` or `console.error(...)`
(both aliases for `runtime.console`) needs the `io` effect, while `sleep(ms)`
or `runtime.sleep(ms)` requires the `clock` effect. The runtime prelude exposes
capability helper entry points in `runtime/prelude.sfn` to centralize effect
checks and adapter routing.

#### 3.2.2 Linear and Affine Types

Sailfin distinguishes between ordinary types and ownership-aware wrappers that
model linear (must be consumed) or affine (may be dropped, not duplicated)
resources. Borrowing and moves are evolving; the compiler records annotations
for diagnostics in areas that are still being enforced.

```sfn
fn ingest(batch: Affine<Vector<1024>>) ![gpu] {
    let view = borrow(batch);
    gpu.stream(view);
}
```

#### 3.2.3 Policy-Tracked Types

Sensitive data flows through wrappers such as `PII<T>`, `Secret<T>`, and
`Policy<T, Rule>`. Attempting to pass a `PII<Text>` to a `net` or `model`
effect without an attached policy causes a compile-time error.

```sfn
fn render_invoice(user: PII<User>) -> Html ![io] {
    redact(user).into_html();
}
```

### 3.3 Structs and Interfaces

Structs group fields and methods. Fields are immutable unless declared with
`mut`. Methods are declared with `fn` inside the struct body and may reference a
`self` parameter explicitly. Interfaces provide trait-style method signatures.

Current status: the Sailfin compiler emits structured `StructDeclaration` and
`InterfaceDeclaration` nodes with explicit field/member lists and captured type
parameters.

```sfn
interface Greeter {
    fn greet(self) -> string;
}

struct User implements Greeter {
    id -> number;
    mut name -> string;

  fn greet(self) -> string {
    return "Hello, {{ self.name }}!";
    }
}
```

When a struct implements a generic interface, the `implements` clause must
specify type arguments that match the interface declaration. For example,
`struct Document implements Formatter<string>` is valid when `Formatter<T>` is
declared, while omitting the `<string>` argument results in a type checker
diagnostic.

Struct literals use `Type { field: expression }` syntax. Method calls follow the
`instance.method(args)` form.

### 3.4 Enums and Algebraic Data Types

Enums mirror algebraic data types (ADTs). Variants may include payloads.

Current status: enum declarations are represented as `EnumDeclaration` nodes
with per-variant payload fields, enabling downstream passes to reuse the same
analysis pipeline.

```sfn
enum Response {
    Ok,
    Error { message -> string },
}
```

### 3.5 Type Aliases and Generics

Type aliases provide named shortcuts. Generics are parsed throughout the
language; the current compiler treats them as metadata for code generation.

Self-hosted status: `TypeAliasDeclaration` nodes retain generic parameter
clauses and the aliased type text for parity with current compiler.

```sfn
type Result<T> = Response | T;
```

### 3.6 Model Declarations

Models are first-class program artefacts. A `model` block declares metadata,
versions, schemas, and evaluator suites, producing a `Model<Input, Output>`
value.

```sfn
model Summarizer : Model<Text, Summary> {
  engine      = "gpt-foo@2.3.1";
  schema      = Summary;
  max_tok     = 2000;
  cost_cap    = 0.05; // USD (currency literal support forthcoming)
  evaluators  = [ Faithfulness, LatencyBudget(150ms) ];
}
```

Calling a model requires the `model` effect, returns a typed output, and yields
a signed **generation card** containing provenance (engine, params, seeds,
input hashes, latency, cost).

### 3.6.1 Model Block Schema

| Property      | Type                                            | Required | Description                                             |
| ------------- | ----------------------------------------------- | -------- | ------------------------------------------------------- | --------------------------------------------------- |
| `engine`      | string                                          | Yes      | Provider + version tag (e.g. `gpt-foo@2.3.1`)           |
| `schema`      | Type                                            | Yes      | Output validation / shaping type                        |
| `max_tok`     | number                                          | No       | Maximum output tokens (advisory; enforced per provider) |
| `cost_cap`    | number (monetary; currency literal forthcoming) | No       | Maximum spend for a single call (enforced at runtime)   |
| `evaluators`  | Array<Identifier                                | Call>    | No                                                      | Quality/guardrail evaluators applied to generations |
| `temperature` | number (0–2)                                    | No       | Stochastic sampling parameter                           |
| `top_p`       | number (0–1)                                    | No       | Nucleus sampling parameter                              |
| `seed`        | number                                          | No       | Deterministic seed for reproducible generations         |
| `notes`       | string                                          | No       | Free-form provenance / intent rationale                 |

Note: The parser accepts any identifier keys within a `model` block and stores
them verbatim in a plain object. Keys listed above are the canonical set;
unknown keys are preserved but not validated yet.

Additional provider-specific keys MAY appear but MUST NOT change semantics of
declared standard keys. Unknown keys are preserved in generation cards for
observability.

### 3.7 Prompt Blocks

`prompt` blocks compose multi-part instructions. Channels are parsed as
identifiers and commonly use `system`, `user`, `assistant`, and `tool`. The
compiler does not yet enforce the channel vocabulary.

Evaluation order: prompt blocks execute in source order. A typical sequence is
`system` → `user` → `assistant` → `tool`. The current backend preserves the
declared order when generating code and effect-checks against the presence of
any prompt block.

Current status: prompt blocks emit dedicated `PromptStatement` nodes inside
block bodies, enabling effect analysis to reason about prompts without falling
back to token scanning.

```sfn
fn summarize_doc(doc: Text) -> Summary ![model] {
  prompt system { "You are a concise technical summarizer." }
  prompt user   { "Summarise:\n{{ doc }}" }
  Summarizer.call()
}
Typed prompts (planned):

The design includes typed prompt channels to validate shape, e.g. `prompt
user<SummaryRequest> { ... }`. This syntax is not accepted by the compiler and
appears here as a forward-looking example.

```

### 3.8 Pipelines and Dataflow

Note: `pipeline` declarations parse and emit as plain functions. The `|>`
operator shown below is a planned feature and not implemented in the current
parser.

`pipeline` declarations express ETL-style dataflows with zero-copy semantics and
compile-time shape checks.

```sfn
pipeline index_corpus(docs: Seq<Text>) ![io, gpu] {
    docs
      |> chunk(by: "semantic", target_tokens: 512)
      |> embed(with: "e5-large")
      |> upsert(index: "docs_idx");
}
```

Each stage declares effect usage implicitly via the called functions. Pipelines
can be invoked like ordinary functions and integrate with structured
concurrency.

#### 3.8.1 Pipeline Semantics (planned)

- `|>` is left-associative and has lower precedence than all expression
  operators; the right-hand side of each stage parses as a LogicalOr root.
- Stages SHOULD be effect-pure except for declared function calls; side effects
  aggregate into the pipeline's effect list.
- The compiler performs (planned) shape analysis: if a stage's output union is
  not accepted by the next stage's parameter type, a type error is issued.

#### 3.8.2 Failure behaviour and side effects

- Current: Pipelines are ordinary functions. Failures follow standard exception
  semantics; side effects occur as the function executes. There is no
  transactional rollback or stage isolation in the current compiler.
- Planned: Pipelines run with structured scopes. Side effects propagate in
  order; failures within a stage can trigger compensations or retries based on
  policy, and determinism settings are applied per stage.

#### 3.8.3 Async and lazy pipelines (planned)

Pipelines may run lazily or asynchronously, where upstream stages backpressure
downstream consumers. The current compiler does not implement async/lazy
pipelines; use explicit `async fn`, `routine`, and `channel(capacity)` in the
current compiler.

#### 3.8.2 Named Arguments in Stages

Named arguments follow the same grammar as function calls (`identifier: expr`).
They do not participate in overloading; their role is clarity and future
compile-time configuration.

### 3.9 Tools and Capability Contracts

Tools are typed capabilities that models may invoke. They declare their own
effect sets and are subject to the same capability enforcement as user code.

```sfn
tool FetchProfile(id: Id) -> Profile ![net] { ... }
```

Foreign adapters for external runtimes run in sandboxed processes with
copy-on-write buffers; taint wrappers (`PII`, `Secret`) propagate through
adapter boundaries.

#### 3.9.1 Tool Semantics

- Tool declarations mirror functions but are externally invocable by models.
- A tool's effect list is a superset of all effects required by its body.
- Tool calls from model generations are mediated by a dispatcher enforcing
  capability and taint policies before execution.

## 4. Statements and Control Flow

- **Assignment** – arithmetic, logical, and compound assignment operators are
  supported.
- **Conditionals** – `if`/`else` behave as in mainstream languages.
- **Pattern matching** – `match` supports literals, `_` wildcards, guards, and
  destructuring enum constructors.
- **Error handling** – `try`/`catch`/`finally` blocks and `throw` statements map
  onto runtime exceptions.

## 5. Concurrency and Performance

- **Async & routines** – `async fn` enables `await`; `routine { … }` launches a
  concurrent task. The current runtime maps routines to the runtime scheduler.
- **Structured scopes** – The design introduces `scope` values that carry
  cancellation, deadlines, and determinism knobs (`seed`, `temperature`). These
  are partially stubbed today and will be fully enforced in the native runtime.
- **Channels** – In the current runtime, channels are unbounded by default
  unless a capacity is provided. Use `channel(capacity: N)` to enable
  backpressure. The native runtime will prefer bounded channels by default.
- **Accelerators** – Operations requiring GPUs/TPUs must declare the `gpu`
  effect. The runtime batches compatible tensor work automatically.

```sfn
async fn main() ![io, model] {
  // Planned: `1s` time literal and `scope.with_timeout(...)` API.
  let scope = scope.with_timeout(1s);
  let messages -> Channel<number> = channel(capacity: 32);

  routine scope {
    messages.send(42);
  }

  let result = await messages.receive();
  print.info("Received: {{ result }}");
}

```

### 5.1 is operator (type / pattern guard)

The compiler implements a minimal `is`-style check using the `is` token parsed as
a type-test operator in expressions. It lowers to `runtime.check_type`.

```sfn
if value is SomeType { ... }
```

Semantics (current compiler):

1. Evaluate the right-hand side as a nominal type name (no structural typing yet).
2. Perform a runtime instance check analogous to `check_type` in the runtime.
3. Return a boolean; future static versions will narrow the type of `value`
   inside the guarded block (not yet enforced).

_Planned evolution_: `is` will integrate with pattern matching and support
structured destructuring (`if response is Error { ... }`). Until then its use
is limited to ergonomic runtime type guards.

## 6. Type System Overview

| Type      | Description                   |
| --------- | ----------------------------- |
| `number`  | 64-bit floating point numbers |
| `string`  | UTF-8 encoded strings         |
| `boolean` | Truth values                  |
| `void`    | No return value               |
| `null`    | Explicit absence of a value   |

Composite types include structs, enums, generics (e.g. `Vec<T>`, `Seq<T>`),
optionals (`T?`), and unions (`A | B`). The array sugar `Type[]` is deprecated
in favour of explicit generic containers (`Vec<T>`). Function types (`fn(T) -> U`)
are parsed but not emitted by the current backend.

**Vector/Tensor types** – `Vector<N>` and `Tensor<Shape, DType>` are value types
with linear semantics suitable for zero-copy AI workloads.

**Wrapper types** – `PII<T>`, `Secret<T>`, `Policy<T, Rule>`, `Affine<T>`, and
`Linear<T>` compose with all other types and participate in effect enforcement.

### 6.1 Ownership, Moves, and Borrowing

This section describes what the compiler enforces today and what is still planned.

> Design principle: Sailfin relies on ownership plus references—general-purpose raw pointers are intentionally absent from the safe core. Forthcoming lowering layers will provide reference-friendly representations that map cleanly onto LLVM and WASM without exposing unchecked pointer arithmetic.

#### 6.1.1 Current reality

Affine<T> and Linear<T> type wrappers are accepted syntactically and carried through the pipeline for diagnostics and documentation. The current backend does not enforce move/consume rules; aliasing and duplication are possible.

Reference types &T and &mut T are accepted syntactically (see below) but are
treated as ordinary nominal types today. The compiler does not yet enforce
exclusivity or lifetime checks.

The expression forms &x and borrow(x) are accepted. They construct a reference
value but carry no static guarantees in current builds.

Warning: Ownership wrappers and borrows are diagnostics-only in areas not yet
enforced. The current backend will not prevent aliasing, duplication,
use-after-move, or early drops of Affine<T>/Linear<T>/&mut T values. The native
LLVM lowering now threads ownership metadata through `.sfn-asm`, rejects
conflicting borrows (multiple `&mut` aliases or mixing `&mut` with shared
borrows), and flags use-after-move when a consumed local or parameter is reused
after control-flow merges. Lifetime analysis and borrow-region inference remain
future work.

#### 6.1.2 Planned semantics

Sailfin uses a move-by-default model with explicit borrowing:

Moves: let y = x moves x into y unless T is Copy. Using x after a move is a compile-time error. Use clone(x) for an explicit deep/semantic copy (if implemented by T).

Shared borrows (&T): created with &expr (or borrow(expr)), allow read-only access. Many shared borrows to the same value may coexist.

Mutable borrows (&mut T): created with &mut expr, grant exclusive, mutable access. While a &mut borrow is live, no other borrows (shared or mutable) to the same value may exist.

Reborrows: A &mut T can be reborrowed as &T (read-only) for a narrower region when needed.

Lifetimes: The compiler performs lifetime inference (lexical with non-lexical use-sites permitted). A borrow may not outlive its referent. In generic code, lifetime parameters are elided unless ambiguity requires annotation (annotation syntax will be introduced alongside generic region constraints).

Auto-deref & field access: Field/method access through references is implicitly dereferenced. Explicit dereference operators are not required; a deref(x) intrinsic may be provided for clarity.

Copy types: Primitive scalars and explicitly Copy types duplicate on assignment; all others move.

Intersections vs address-of: The & token serves as both (1) the type intersection operator A & B in type position and (2) the borrow operator &x in expression position. The grammar is context-sensitive here but unambiguous: intersection appears only between type terms; unary & appears only before expressions. (See EBNF notes below.)

Unsafe/raw memory: Raw pointers and pointer arithmetic are not part of the safe core. For FFI and low-level interop, `unsafe` + `extern` declarations expose raw pointer forms (e.g., `*u8`) behind explicit capability gates. Dereferencing a raw pointer (`*ptr`) is only legal inside an `unsafe` block.

#### 6.1.3 Examples

See `examples/basics/borrowing.sfn` for a runnable native-compiler design sample that illustrates the ownership rules described above. The sample shows how

- bindings move by default (`let mut counter = Counter { ... };`),
- shared borrows are constructed with `&counter` and `borrow(counter)`,
- mutable borrows use `&mut counter` and can be reborrowed as shared references inside `snapshot`, and
- ending the scope of a mutable borrow allows new borrows to be taken later in the program.

The current pipeline accepts these forms without enforcing exclusivity; the
example documents the semantics the compiler will apply once enforcement lands.

#### 6.1.4 Borrow-specific effects

Borrowing integrates with the effect lattice so the compiler (and downstream agents) can reason about aliasing guarantees:

- `&T` introduces a shared-borrow effect written `!read`. Callers must permit read-only access to the borrowed region.
- `&mut T` introduces an exclusive-borrow effect written `!mut`. Callers must prove they hold the sole mutable reference during the call.
- Owned values (moves) carry no borrow effect—they already own the data.

Effects appear in function signatures even when inferred:

```
fn push!(values -> &mut Vec<T>, item -> T) ![mut] {
  values.push(item);
}

fn peek(values -> &Vec<T>) ![read] -> T? {
  if values.is_empty() {
    return null;
  }
  return values[values.length - 1];
}
```

Borrow effects compose with other capability requirements. For example:

```
fn update_cache!(cache -> &mut Map<string, string>) ![mut, io.fs.read, io.fs.write] {
  let data = read_file!("data.txt");
  cache.insert("data", data);
}
```

Here the compiler derives the composite effect list `![mut, io.fs.read, io.fs.write]` by combining the borrow requirement with filesystem I/O.

Async safety: borrow effects cannot cross suspension points unless the reference is proven `'static` or cloned into an owned value. Expressed as a lattice rule, `!mut` is not a subset of `!async`. The native compiler rejects `await` and routine yields that would extend a mutable borrow beyond its lifetime, emitting diagnostics that identify the active borrow and the offending suspension site.

#### 6.1.5 Unsafe capability and extern interop

Low-level interop lives behind an explicit `unsafe` capability. Unsafe declarations surface the risk while keeping safe code pointer-free.

**Bootstrap status**: The parser accepts `unsafe`, `extern`, and raw pointer syntax (`*T`, `*mut T`). The current compiler does not enforce unsafe semantics. The native compiler will enforce all rules described below.

##### 6.1.5.1 Foreign Function Declarations

External functions from C libraries are declared using `unsafe extern fn`:

```sfn
unsafe extern fn malloc(size -> usize) -> *u8;
unsafe extern fn free(ptr -> *u8) -> void;
unsafe extern fn memcpy(dest -> *u8, src -> *u8, n -> usize) -> *u8;
```

Key properties:

- Follows the C ABI calling convention by default
- Cannot be called without an active `![unsafe]` capability
- May accept and return raw pointer types
- Must be linked against the appropriate native library at build time

##### 6.1.5.2 Raw Pointer Types

Sailfin provides two raw pointer types for FFI:

| Type      | Description                              |
| --------- | ---------------------------------------- |
| `*T`      | Read-only raw pointer to type `T`        |
| `*mut T`  | Mutable raw pointer to type `T`          |
| `*opaque` | Opaque pointer to foreign-managed memory |

Raw pointers differ from references:

- No lifetime tracking or borrow checking
- No automatic null safety
- May be cast between compatible types
- Support pointer arithmetic via `ptr + offset`

##### 6.1.5.3 Unsafe Blocks

The `unsafe { ... }` block is a lexical scope where raw pointer operations are legal:

```sfn
fn allocate_buffer(bytes -> usize) ![unsafe] -> *u8 {
  unsafe {
    let ptr = malloc(bytes);
    // Dereferencing raw pointers is only legal inside this block.
    return ptr;
  }
}
```

Operations restricted to unsafe blocks:

- **Pointer dereference**: `*ptr` to read, `*ptr = value` to write
- **Pointer arithmetic**: `ptr + offset`, `ptr - offset`
- **Pointer casting**: `ptr as *OtherType`
- **Calling unsafe extern functions**: Direct calls to FFI bindings
- **Taking raw pointers**: `&raw value` to obtain a raw pointer from a value

The unsafe effect propagates: any function containing an unsafe block must declare `![unsafe]`.

##### 6.1.5.4 Safe Wrappers Pattern

The recommended pattern is to encapsulate unsafe operations behind safe abstractions:

```sfn
// Unsafe internals wrapped in a safe API
struct ManagedBuffer {
    ptr -> *u8;
    capacity -> usize;
    length -> usize;
}

// Safe allocation with Linear wrapper for cleanup enforcement
fn allocate_buffer(size -> usize) ![unsafe] -> UnsafeResult<Linear<ManagedBuffer>> {
    unsafe {
        let ptr = malloc(size);
        if ptr == null {
            return UnsafeResult.Err { code: -1, message: "allocation failed" };
        }
        memset(ptr, 0, size);
        return UnsafeResult.Ok {
            value: Linear(ManagedBuffer { ptr: ptr, capacity: size, length: 0 })
        };
    }
}

// Safe deallocation consuming the Linear wrapper
fn free_buffer(buffer -> Linear<ManagedBuffer>) ![unsafe] -> void {
    unsafe {
        let inner = consume(buffer);
        if inner.ptr != null {
            free(inner.ptr);
        }
    }
}
```

The `Linear<T>` wrapper ensures the buffer is consumed exactly once, preventing leaks.

##### 6.1.5.5 Capability Manifest Requirements

The `unsafe` capability must be declared in the capsule manifest before any unsafe code can compile:

```toml
# sail.toml
[package]
name = "my-native-lib"
version = "0.1.0"

[capabilities]
required = ["io", "unsafe"]
```

Fleet-level policies can restrict which capsules may request `unsafe`:

```toml
# fleet.toml
[policies.unsafe]
# Only allow unsafe in specific capsules
allowed_capsules = ["runtime-adapters", "native-bindings"]
# Require security review annotation
require_annotation = "@security-reviewed"
```

##### 6.1.5.6 Pointer Arithmetic and Casting

Inside unsafe blocks, pointer arithmetic follows C semantics:

```sfn
fn pointer_example() ![unsafe] -> void {
    unsafe {
        let arr = malloc(10 * 4) as *i32;  // Cast to typed pointer

        for i in 0..10 {
            let element_ptr = arr + i;  // Pointer + offset (scaled by element size)
            *element_ptr = i * i;       // Write through pointer
        }

        let third = *(arr + 2);  // Read third element

        free(arr as *u8);  // Cast back for free
    }
}
```

Supported operations:

- `ptr + n` — Advance by `n` elements (not bytes)
- `ptr - n` — Retreat by `n` elements
- `ptr as *OtherType` — Reinterpret pointer type
- `ptr == null` / `ptr != null` — Null checks

##### 6.1.5.7 FFI Type Mappings

Sailfin types map to C types as follows:

| Sailfin   | C                 | LLVM                       |
| --------- | ----------------- | -------------------------- |
| `i8`      | `int8_t` / `char` | `i8`                       |
| `i16`     | `int16_t`         | `i16`                      |
| `i32`     | `int32_t`         | `i32`                      |
| `i64`     | `int64_t`         | `i64`                      |
| `u8`      | `uint8_t`         | `i8`                       |
| `u16`     | `uint16_t`        | `i16`                      |
| `u32`     | `uint32_t`        | `i32`                      |
| `u64`     | `uint64_t`        | `i64`                      |
| `usize`   | `size_t`          | `i64` (platform-dependent) |
| `isize`   | `ssize_t`         | `i64` (platform-dependent) |
| `f32`     | `float`           | `float`                    |
| `f64`     | `double`          | `double`                   |
| `bool`    | `_Bool` / `bool`  | `i1`                       |
| `*T`      | `const T*`        | `T*`                       |
| `*mut T`  | `T*`              | `T*`                       |
| `*opaque` | `void*`           | `i8*`                      |

##### 6.1.5.8 Struct Layout for FFI

When passing structs across FFI boundaries, layout must match C expectations:

```sfn
// Explicit layout annotation for C ABI compatibility
@repr(C)
struct Point {
    x -> f64;
    y -> f64;
}

unsafe extern fn distance(p1 -> *Point, p2 -> *Point) -> f64;
```

The `@repr(C)` decorator ensures C-compatible field ordering and alignment.

##### 6.1.5.9 Error Handling Across FFI

Foreign functions typically signal errors via return codes or errno. Safe wrappers should translate these:

```sfn
enum PosixResult<T> {
    Ok { value -> T },
    Err { errno -> i32 },
}

unsafe extern fn c_open(path -> *u8, flags -> i32) -> i32;
unsafe extern fn c_errno() -> i32;

fn open_file(path -> string, flags -> i32) ![unsafe, io] -> PosixResult<i32> {
    unsafe {
        let fd = c_open(path.as_c_str(), flags);
        if fd < 0 {
            return PosixResult.Err { errno: c_errno() };
        }
        return PosixResult.Ok { value: fd };
    }
}
```

##### 6.1.5.10 Example Reference

See `examples/advanced/` for unsafe/extern examples:

- `unsafe-extern-interop.sfn` — External function declarations and unsafe blocks
- `pointer-arithmetic.sfn` — Pointer arithmetic with malloc/free
- `raw-pointers.sfn` — Raw pointer creation with `&raw` and dereference

## 7. Capability-Based Security

- Capsules declare capabilities in `sail.toml`; fleets coordinate shared
  policies in `fleet.toml`. Modules may not escalate at runtime.
- Secrets cannot be logged, hashed, or serialised without explicit policies.
- Runtime egress guards prevent `PII` from leaving the trust boundary unless a
  redaction or consent transformer is applied.
- Policies are declarative DSLs that compile to runtime transformers; they can
  be embedded inline or sourced from policy bundles shipped with the binary.

### 7.1 Data wrappers and policies (current reality)

- Wrappers such as `PII<T>` and `Secret<T>` exist in the type system design to
  model taint and secrecy. In the current toolchain, they are parsed as
  ordinary nominal types and carry no enforcement; the current runtime does
  not provide concrete `PII`/`Secret` classes.
- Policy annotations via decorators (e.g. `@policy(Redact(PII))`) are part of
  the planned semantics. While the current parser supports decorators
  syntactically, policy decorators have no effect in the compiler and should be
  treated as documentation only.

Planned example (not valid under current runtime):

```sfn
@policy(Redact(PII))
fn summarize(user: PII<Text>) -> Summary ![model] {
  // ...
}
```

### 7.2 Runtime Intrinsics and Native Capability ABI

The native LLVM backend exposes capability-gated operations as **runtime intrinsics**—
declared external functions that preserve their effect requirements through the native
compilation pipeline.

#### 7.2.1 Intrinsic Declarations

Intrinsics are declared in `compiler/src/native_llvm_lowering.sfn` via the
`RuntimeHelperDescriptor` structure, which associates each intrinsic with:

- **Name** — the symbol used in the `.sfn-asm` intermediate representation
  (e.g., `console.info`, `fs.read`, `http.get`).
- **Mangled symbol** — the LLVM function name (e.g., `sailfin_intrinsic_io_print`,
  `sailfin_intrinsic_fs_read`, `sailfin_intrinsic_http_get`).
- **Signature** — parameter types and return type in LLVM terms (e.g., `(i8*) -> void`,
  `(i8*) -> i8*`, `(i8*, i8*) -> i8*`).
- **Effects** — the capability requirements (e.g., `["io"]`, `["net"]`, `["model"]`).

When the LLVM lowering pipeline emits IR, it generates `declare` statements for each
intrinsic, prefixed with a capability metadata comment:

```llvm
; intrinsic sailfin_intrinsic_io_print requires capabilities: ![io]
declare void @sailfin_intrinsic_io_print(i8*)

; intrinsic sailfin_intrinsic_http_get requires capabilities: ![net]
declare i8* @sailfin_intrinsic_http_get(i8*)

; intrinsic sailfin_intrinsic_model_invoke requires capabilities: ![model]
declare i8* @sailfin_intrinsic_model_invoke(i8*, i8*)
```

#### 7.2.2 Intrinsic Call Routing

Calls to runtime helpers in Sailfin source (e.g., `console.info(message)`,
`fs.read(path)`, `http.get(url)`, `prompt(system, user)`) are automatically routed
to their corresponding intrinsics during LLVM lowering. The effect requirements
declared in the intrinsic descriptor propagate into the calling function's effect
set and ultimately into the capability manifest for entry points.

#### 7.2.3 Current Intrinsics

| Sailfin Name    | LLVM Symbol                      | Signature            | Effects    |
| --------------- | -------------------------------- | -------------------- | ---------- |
| `console.info`  | `sailfin_intrinsic_io_print`     | `(i8*) -> void`      | `![io]`    |
| `console.log`   | `sailfin_intrinsic_io_print`     | `(i8*) -> void`      | `![io]`    |
| `console.error` | `sailfin_intrinsic_io_print`     | `(i8*) -> void`      | `![io]`    |
| `fs.read`       | `sailfin_intrinsic_fs_read`      | `(i8*) -> i8*`       | `![io]`    |
| `fs.write`      | `sailfin_intrinsic_fs_write`     | `(i8*, i8*) -> void` | `![io]`    |
| `fs.exists`     | `sailfin_intrinsic_fs_exists`    | `(i8*) -> i1`        | `![io]`    |
| `http.get`      | `sailfin_intrinsic_http_get`     | `(i8*) -> i8*`       | `![net]`   |
| `http.post`     | `sailfin_intrinsic_http_post`    | `(i8*, i8*) -> i8*`  | `![net]`   |
| `prompt`        | `sailfin_intrinsic_model_invoke` | `(i8*, i8*) -> i8*`  | `![model]` |
| `model_invoke`  | `sailfin_intrinsic_model_invoke` | `(i8*, i8*) -> i8*`  | `![model]` |

**Status**: Coverage for intrinsic declaration emission, capability metadata propagation,
and manifest integration is provided by
`compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_intrinsic_declarations`,
`compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_intrinsic_calls_compile`,
and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_capability_manifest_includes_intrinsic_effects`.

## 8. Testing, Evaluators, and Replay

Tests are first-class declarations introduced with `test`. They may declare
effects and determinism scopes.

```sfn
test "extracts totals reliably" ![model] {
  with seed(42), temperature(0.2) {
    let out = Parser.call(invoice_text);
    // Planned: `~=` tolerance and `+/-` margin operators in asserts.
    // Use ordinary boolean checks in current compiler.
    assert(out.total ~= 199.99 +/- 0.01);
  }
}
```

Test runners support:

- **Golden tests** – compare model output against stored expectations with
  tolerances for drift.
- **Adversarial suites** – evaluate prompt-injection, jailbreak, and PII leak
  resilience.
- **Replay** – use generation cards to re-run model calls exactly as captured
  during production incidents.

Current CLI note: the native compiler CLI exposes `sfn test [path]`.
The installer ships stable entrypoints (`sfn`, `sailfin`).
Today it discovers Sailfin test files by filename convention (`*_test.sfn`) under
`path` (recursively), compiles each file with a synthesized test harness `main`,
and executes it. This is an initial bridge while the native test runner grows;
it does not yet implement golden/adversarial/replay workflows.

## 9. String Interpolation

String literals support inline expressions using `{{ expression }}` with
mandatory double braces. Whitespace inside braces is ignored at the edges, so
`{{name}}` and `{{ name }}` are equivalent. The compiler lowers interpolated
strings into segment arrays and calls `runtime.format_interpolated`, evaluating
each embedded expression directly.

## 10. Runtime Semantics

The runtime surface is defined by `runtime/prelude.sfn` and the native runtime
implementation. Core helpers include console output, channels/spawn/serve,
model invocation, type checks (`runtime.check_type`), and string formatting.
See `docs/runtime_audit.md` and `docs/status.md` for the current coverage.

The runtime layers on:

1. Capability enforcement across effects and packages.
2. Policy engine for taint-tracked values.
3. Determinism controls (`seed`, `temperature`, per-call randomness budgets).
4. Telemetry: latency, cost, token counts, GPU metrics, and lineage traces.

### 10.1 Printing and Logging

Source code should use `print.info(...)` for standard output and `print.error(...)`
for errors. The compiler injects `print = runtime.console`, so these calls are
implemented by `runtime.console.info` and `runtime.console.error`
respectively. The identifier `console` is not automatically in scope for
Sailfin source; use `print.*` from code.

Supported today:

- `print.info(value)` – prints a value or interpolated string.
- `print.error(value)` – prints a value or interpolated string to error channel.
- `print.warn(value)` – emits a warning-level message. The current runtime prefixes output with `[warn]`.

Not supported yet:

- `print.debug` or structured logging levels. These may be added in the self-hosted runtime.

### 10.2 String Utilities

The Sailfin runtime prelude (`runtime/prelude.sfn`) surfaces common string
helpers that the current compiler and downstream capsules may import via
`import { substring, find_char, grapheme_count, grapheme_at, char_code } from "runtime/prelude";`.

- `substring(text: string, start: number, end: number) -> string`
  - Clamps `start`/`end` to the source string bounds, returns `""` when the
    range is empty, and builds the slice without allocating intermediate
    strings.
  - Negative indices are treated as `0`; indices past the string length are clamped to the end of the string.
- `find_char(text: string, character: string, start: number = 0) -> number`
  - Scans from `start` (clamped to the string bounds) and returns the index of the first matching code unit or `-1` when the character cannot be found.
  - Recognises the common escape sequences `\n`, `\r`, and `\t` so callers can search for newline, carriage return, or tab literals without manually unescaping first.
- `grapheme_count(text: string) -> number`
  - Returns the number of user-perceived characters (Unicode grapheme clusters), coalescing combining marks, emoji modifiers, and zero-width joiner sequences.
  - Delegates segmentation to the shared runtime helpers so both the compiler and downstream capsules agree on cluster boundaries even for complex emoji (family sequences, pride flags) and accent chains.
  - Inputs are not normalized automatically; visually distinct-but-equivalent sequences remain distinct if Unicode assigns separate clusters.
- `grapheme_at(text: string, index: number) -> string`
  - Retrieves the grapheme cluster at `index`, returning `""` for out-of-range access. The helper respects the same segmentation rules as `grapheme_count`.
- `char_code(character: string) -> number`
  - Returns ASCII code points for digits, uppercase/lowercase Latin letters, and a curated set of punctuation (`space`, newline, carriage return, tab, double quote, backslash, underscore`).
  - Decodes UTF-8 sequences up to four bytes wide directly in Sailfin, covering Latin-1, BMP, and common astral-plane glyphs (emoji, symbols) without invoking the current runtime.
  - Returns `-1` for empty input, code units longer than four bytes, or invalid continuation bytes so callers can detect malformed data.
- `match_exhaustive_failed(value: any) -> never`
  - Emits a ValueError with a message (`"Non-exhaustive match for value …"`).
  - Serves as the runtime backstop when the compiler cannot prove match-expression exhaustiveness.

Struct support:

- `struct_field(name: string, value: any) -> StructField`
  - Wraps a single field/value pair for consumption by struct formatting helpers.
- `struct_repr(name: string, fields: StructField[]) -> string`
  - Produces `name(field=value, …)` strings without invoking the current runtime. Strings use plain concatenation for now; downstream call sites may format values for debugging needs.

These helpers participate in the `runtime` module re-export surface so compiled
sources receive the same behavior across runtime targets.

## Part B — Design Preview

The sections below describe the direction of the compiler and adjacent tooling.
They complement the roadmap (`docs/roadmap.md`) and proposals under
`docs/proposals/`.

## 11. Roadmap

Upcoming milestones include:

1. Full type-checking and inference, including linear/affine tracking.
2. Exhaustive pattern matching with guards and destructuring.
3. Native package manager integration for models and code (`sfn`, capsules,
   fleets, provenance locking).
4. Notebook and LSP support with live cost/latency overlays.
5. Complete the Sailfin-native runtime migration.

This specification will evolve with the implementation. Refer to `enbf.md` and
`examples/` for executable examples of the language.

Note (planned): Engines, adapters, tensors, and training are specified in a draft proposal under `docs/proposals/model-engines-and-training.md`. Until merged into the core spec, treat that document as design guidance rather than normative semantics.

### Native Backend Layout Descriptors

The native compiler emits a textual `.sfn-asm` artefact (`sailfin-native-text`) before LLVM
lowering. Structs and enums now include `.layout` directives that describe the
calculated byte layout so downstream passes can materialise storage without
re-computing sizes or alignment.

Struct declarations prepend their `.field` entries with:

```
.layout struct size=<bytes> align=<bytes>
.layout field <name> type=<type> offset=<byteOffset> size=<bytes> align=<bytes>
```

- `size` and `align` capture the aggregate footprint after rounding up to the
  strictest field alignment.
- `offset` values are byte offsets from the start of the struct.
- Primitive numbers (`number`, `int`, `i32`, `i64`) use their natural sizes.
- Strings, arrays, and currently unsupported user-defined types fall back to a
  pointer representation (`size=8`, `align=8`) and surface a diagnostic in the
  compiler output.
- Optional annotations (`Type?`), nested enums, and recursive aggregates now
  resolve to explicit layouts when their definitions are available in the same
  module, avoiding the historical `defaulting to pointer layout` warnings that
  the native compiler surfaced for the compiler AST.

Enum declarations emit:

```
.layout enum size=<bytes> align=<bytes> tag_type=<repr> tag_size=<bytes> tag_align=<bytes>
.layout variant <name> tag=<index> offset=<byteOffset> size=<payloadBytes> align=<payloadAlign>
.layout payload <name>.<field> type=<type> offset=<absoluteByteOffset> size=<bytes> align=<bytes>
```

- `tag_type` records the discriminator representation (currently `i32`).
- Variant `offset` values point to where the payload begins relative to the
  enum base; `size` records just the payload footprint.
- Payload lines provide absolute field offsets so lowering passes can access
  nested members without recalculating struct layouts.
- Variants without payloads omit `.layout payload` entries and report `size=0`.

These descriptors are consumed by LLVM/WASM backends to guarantee struct field
access, enum payload extraction, and aggregate literals share the same ABI.

### Feature Matrix

See `docs/status.md` for the canonical feature table and implementation notes.

`registry.sailfin.dev` is live, but the current toolchain does not yet expose
publish/resolve commands; integration work tracks on the roadmap.

## Effect System (Current and Planned)

Canonical effects today: io, net, model, gpu, rand, clock.

Current enforcement status (see `compiler/src/effect_checker.sfn`):

- model: required when a routine includes any `prompt ... { ... }` block.
- io: required when calling filesystem helpers via `fs.*`.
- net: required when using network helpers (`http.*`, `websocket.*`, or `serve`).

Currently parsed but not yet enforced: gpu, rand, clock, and hierarchical effect
names (e.g. `io.fs`, `net.http`). These are accepted by the parser and recorded
on declarations but are not validated yet.

Planned:

- Hierarchical, composable effects with scoping (e.g. `io.fs.read`, `net.http`).
- Cross-manifest capability gates (capsule/fleet manifests) for compilation and runtime.
- Flow-sensitive effect inference and minimal annotations.

Cross-reference: enforcement logic lives in `compiler/src/effect_checker.sfn`
and is invoked during compilation.

## Compatibility notes (examples)

Examples under `examples/` are curated to compile under the current toolchain.
If an example uses future syntax (such as currency literals `$0.05` or
`scope.with_timeout(1s)`), it is marked in comments as future feature; replace
with numeric literals and stub helpers when running with the current compiler.
