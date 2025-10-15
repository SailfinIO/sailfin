# Sailfin Language Specification

Version: 0.2.1 (design preview)
Date: October 2025

Sailfin is an AI-native, expression-oriented programming language that combines
Rust-grade safety, Swift-like ergonomics, and runtime observability. The Python
bootstrap compiler implements a pragmatic subset while the self-hosted
implementation matures. This document captures the behaviour of the bootstrap
subset and describes the design direction for forthcoming features.

This specification is organised into two parts:

- **Part A — Bootstrap Reference** documents only the behaviour available in the
  Python stage0 toolchain and should stay in sync with `docs/status.md`.
- **Part B — Design Preview** records planned extensions and references active
  proposals under `docs/proposals/`. Treat the preview as informative until the
  status document marks the feature as shipped.

For an at-a-glance summary of what is implemented today, consult
`docs/status.md`.

NOTE: The repository currently contains a `bootstrap/` Python stage0 and early
`compiler/` Sailfin sources. Diagrams and directory trees showing a unified
fleet layout (with `fleet.toml`, `std/`, `runtime/`, etc.) represent the target
self-hosted architecture, not the current on-disk structure.

## Part A — Bootstrap Reference

## 1. Lexical Structure

- **Identifiers** begin with a letter and may contain ASCII letters, digits, or
  `_`. Identifiers are case-sensitive.
- **Keywords** are listed in `docs/keywords.md`. They include traditional
  control-flow terms (`fn`, `async`, `await`, `match`, …) and AI-first syntax
  such as `model`, `prompt`, `pipeline`, `test`, and the implemented `assert`
  statement (see §8).
- **Literals**:
  - Numeric literals support integers (`42`) and decimals (`3.14`). Currency
    literals (e.g. `$0.05`) are **not yet parsed** in the bootstrap subset;
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

Bootstrap status: the parser records effect lists and a conservative validator
(`bootstrap/effect_checker.py`) enforces a subset today. Stage1 ships with its
own Sailfin-written checker (`compiler/src/effect_checker.sfn`) that mirrors the
bootstrap coverage for prompts, console I/O, filesystem/HTTP/WebSocket helpers,
`spawn`/`serve`, `sleep`, and decorators that imply `io`. See Effect System
section below for details.

## 2. Modules, Imports, and Capabilities

Source files compile independently. Imports use ES-module style syntax and
canonical Sailfin-branded paths:

```sfn
import { Channel, channel } from "sailfin/async";
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

Type annotations are optional; the bootstrap compiler performs limited
inference. Initialisers may be omitted; the bootstrap emits `null` when a
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

Self-hosted runtime stub: the repository now includes `runtime/prelude.sfn`,
which defines the minimal runtime surface expected by Sailfin-generated code
during bootstrap. The prelude forwards logging, channels, and async helpers as
no-op stubs so that Sailfin-to-Sailfin compilation can round-trip without
depending on Python at emission time.
parsed but ignored by code generation during bootstrapping.

Self-hosted status: the Sailfin parser now captures generic type parameter
clauses (`fn map<T>(...)`) on both top-level functions and struct methods, so
later semantic passes can mirror the bootstrap compiler's metadata.
Function bodies preserve explicit `return` and expression statements, allowing
the Sailfin-native code generator to emit runnable Python blocks instead of
stub comments.

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

Bootstrap enforcement today requires routines that invoke console helpers or
timers to declare matching effects. Calling `print.info(...)` or
`console.error(...)` (both aliases for `runtime.console`) needs the `io`
effect, while `sleep(ms)` or `runtime.sleep(ms)` requires the `clock` effect.
Self-hosted builds expose `capability_grant`, `fs_bridge`, `http_bridge`, and
`model_bridge` helpers in `runtime/prelude.sfn`; the bridges enforce runtime
permissions while delegating to the bootstrap Python shims until native
backends replace them.

#### 3.2.2 Linear and Affine Types

Sailfin distinguishes between ordinary types and ownership-aware wrappers that
model linear (must be consumed) or affine (may be dropped, not duplicated)
resources. Borrowing and moves are forthcoming in the self-hosted compiler; the
bootstrap toolchain records annotations for diagnostics only.

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

Self-hosted status: the Sailfin compiler now emits structured `StructDeclaration`
and `InterfaceDeclaration` nodes with explicit field/member lists and captured
type parameters, mirroring the bootstrap AST for diffability.

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

Struct literals use `Type { field: expression }` syntax. Method calls follow the
`instance.method(args)` form.

### 3.4 Enums and Algebraic Data Types

Enums mirror algebraic data types (ADTs). Variants may include payloads.

Self-hosted status: enum declarations are represented as `EnumDeclaration`
nodes with per-variant payload fields, enabling downstream passes to reuse the
bootstrap analysis.

```sfn
enum Response {
    Ok,
    Error { message -> string },
}
```

### 3.5 Type Aliases and Generics

Type aliases provide named shortcuts. Generics are parsed throughout the
language; the bootstrap compiler treats them as metadata for code generation.

Self-hosted status: `TypeAliasDeclaration` nodes retain generic parameter
clauses and the aliased type text for parity with stage0.

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

| Property     | Type                    | Required | Description |
|--------------|-------------------------|----------|-------------|
| `engine`     | string                  | Yes      | Provider + version tag (e.g. `gpt-foo@2.3.1`) |
| `schema`     | Type                    | Yes      | Output validation / shaping type |
| `max_tok`    | number                  | No       | Maximum output tokens (advisory; enforced per provider) |
| `cost_cap`   | number (monetary; currency literal forthcoming) | No       | Maximum spend for a single call (enforced at runtime) |
| `evaluators` | Array<Identifier|Call>  | No       | Quality/guardrail evaluators applied to generations |
| `temperature`| number (0–2)            | No       | Stochastic sampling parameter |
| `top_p`      | number (0–1)            | No       | Nucleus sampling parameter |
| `seed`       | number                  | No       | Deterministic seed for reproducible generations |
| `notes`      | string                  | No       | Free-form provenance / intent rationale |

Bootstrap note: The parser accepts any identifier keys within a `model` block
and the bootstrap code generator stores them verbatim in a plain object. Keys
listed above are the canonical set; unknown keys are preserved but not
validated by the bootstrap toolchain.

Additional provider-specific keys MAY appear but MUST NOT change semantics of
declared standard keys. Unknown keys are preserved in generation cards for
observability.

### 3.7 Prompt Blocks

`prompt` blocks compose multi-part instructions. Channels in the bootstrap are
parsed as identifiers and commonly use `system`, `user`, `assistant`, and `tool`.
The bootstrap does not currently enforce the channel vocabulary; the
self-hosted target will.

Evaluation order: prompt blocks execute in source order. A typical sequence is
`system` → `user` → `assistant` → `tool`. The bootstrap backend preserves the
declared order when generating code and effect-checks against the presence of
any prompt block.

Self-hosted status: prompt blocks are now emitted as dedicated
`PromptStatement` nodes inside block bodies, enabling effect analysis to reason
about prompts without falling back to token scanning.

```sfn
fn summarize_doc(doc: Text) -> Summary ![model] {
  prompt system { "You are a concise technical summarizer." }
  prompt user   { "Summarise:\n{{ doc }}" }
  Summarizer.call()
}
Typed prompts (planned):

The design includes typed prompt channels to validate shape, e.g. `prompt
user<SummaryRequest> { ... }`. This syntax is not accepted by the bootstrap
parser and appears here as a forward-looking example.

```

### 3.8 Pipelines and Dataflow

Bootstrap note: `pipeline` declarations parse and emit as plain functions.
The `|>` operator shown below is a planned feature and not implemented in the
bootstrap parser.

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

- Bootstrap: Pipelines are ordinary functions. Failures follow standard
  exception semantics; side effects occur as the function executes. There is no
  transactional rollback or stage isolation in stage0.
- Planned: Pipelines run with structured scopes. Side effects propagate in
  order; failures within a stage can trigger compensations or retries based on
  policy, and determinism settings are applied per stage.

#### 3.8.3 Async and lazy pipelines (planned)

Pipelines may run lazily or asynchronously, where upstream stages backpressure
downstream consumers. The bootstrap compiler does not implement async/lazy
pipelines; use explicit `async fn`, `routine`, and `channel(capacity)` in
stage0.

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

Foreign adapters for Python/JavaScript run in sandboxed processes with copy-on-
write buffers; taint wrappers (`PII`, `Secret`) propagate through adapter
boundaries.

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
  onto Python exceptions in the bootstrap runtime.

## 5. Concurrency and Performance

- **Async & routines** – `async fn` enables `await`; `routine { … }` launches a
  concurrent task. The bootstrap runtime maps routines to Python tasks.
- **Structured scopes** – The design introduces `scope` values that carry
  cancellation, deadlines, and determinism knobs (`seed`, `temperature`). These
  are partially stubbed in the bootstrap runtime and fully enforced in the
  self-hosted implementation.
- **Channels** – In the bootstrap runtime, channels are unbounded by default
  unless a capacity is provided. Use `channel(capacity: N)` to enable
  backpressure. The self-hosted runtime will prefer bounded channels by
  default.
- **Accelerators** – Operations requiring GPUs/TPUs must declare the `gpu`
  effect. The runtime batches compatible tensor work automatically.

```sfn
async fn main() ![io, model] {
  // Future-only in bootstrap: `1s` time literal and `scope.with_timeout(...)` API.
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

Bootstrap implements a minimal `is`-style check using the `is` token parsed as
a type-test operator in expressions. It lowers to `runtime.check_type`.

```sfn
if value is SomeType { ... }
```

Semantics (bootstrap stage0):
1. Evaluate the right-hand side as a nominal type name (no structural typing yet).
2. Perform a runtime instance check analogous to `check_type` in the runtime.
3. Return a boolean; future static versions will narrow the type of `value`
  inside the guarded block (not yet enforced in bootstrap).

*Planned evolution*: `is` will integrate with pattern matching and support
structured destructuring (`if response is Error { ... }`). Until then its use
is limited to ergonomic runtime type guards.

## 6. Type System Overview

| Type        | Description                                          |
|-------------|------------------------------------------------------|
| `number`    | 64-bit floating point numbers                        |
| `string`    | UTF-8 encoded strings                                |
| `boolean`   | Truth values                                         |
| `void`      | No return value                                      |
| `null`      | Explicit absence of a value                          |

Composite types include structs, enums, generics (e.g. `Vec<T>`, `Seq<T>`),
optionals (`T?`), and unions (`A | B`). The array sugar `Type[]` is deprecated
in favour of explicit generic containers (`Vec<T>`). Function types (`fn(T) -> U`)
are parsed but not emitted by the bootstrap backend.

**Vector/Tensor types** – `Vector<N>` and `Tensor<Shape, DType>` are value types
with linear semantics suitable for zero-copy AI workloads.

**Wrapper types** – `PII<T>`, `Secret<T>`, `Policy<T, Rule>`, `Affine<T>`, and
`Linear<T>` compose with all other types and participate in effect enforcement.

### 6.1 Ownership, Moves, and Borrowing

This section describes what the bootstrap enforces today and what the self-hosted compiler will enforce.

> Design principle: Sailfin relies on ownership plus references—general-purpose raw pointers are intentionally absent from the safe core. Forthcoming lowering layers will provide reference-friendly representations that map cleanly onto LLVM and WASM without exposing unchecked pointer arithmetic.

#### 6.1.1 Current (bootstrap) reality

Affine<T> and Linear<T> type wrappers are accepted syntactically and carried through the pipeline for diagnostics and documentation. The bootstrap backend does not enforce move/consume rules; aliasing and duplication are possible.

Reference types &T and &mut T are accepted syntactically (see below) but are treated as ordinary nominal types by the bootstrap. The bootstrap does not enforce exclusivity or lifetime checks.

The expression forms &x and borrow(x) are accepted. They construct a reference value but carry no static guarantees in bootstrap builds.

Warning (bootstrap): Ownership wrappers and borrows are diagnostics-only. The bootstrap backend will not prevent aliasing, duplication, use-after-move, or early drops of Affine<T>/Linear<T>/&mut T values.

#### 6.1.2 Planned (self-hosted) semantics

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

See `examples/basics/borrowing.sfn` for a runnable Stage2 design sample that illustrates the ownership rules described above. The sample shows how

- bindings move by default (`let mut counter = Counter { ... };`),
- shared borrows are constructed with `&counter` and `borrow(counter)`,
- mutable borrows use `&mut counter` and can be reborrowed as shared references inside `snapshot`, and
- ending the scope of a mutable borrow allows new borrows to be taken later in the program.

The bootstrap pipeline currently accepts these forms without enforcing exclusivity; the example documents the semantics the Stage2 checker will apply.

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

Async safety: borrow effects cannot cross suspension points unless the reference is proven `'static` or cloned into an owned value. Expressed as a lattice rule, `!mut` is not a subset of `!async`. The Stage2 checker will reject `await` and routine yields that would extend a borrow beyond its lifetime.

#### 6.1.5 Unsafe capability and extern interop

Low-level interop lives behind an explicit `unsafe` capability. Unsafe declarations surface the risk while keeping safe code pointer-free:

```
unsafe extern fn malloc(size -> usize) -> *u8;

fn allocate_buffer(bytes -> usize) ![unsafe] -> *u8 {
  unsafe {
    let ptr = malloc(bytes);
    // Dereferencing raw pointers is only legal inside this block.
    return ptr;
  }
}
```

Inside an `unsafe` block you may dereference raw pointers (`*ptr`) or call other unsafe routines; outside, only reference-typed values (`&T`, `&mut T`) are available. Capability manifests must opt into `unsafe` before such code can run.

## 7. Capability-Based Security

- Capsules declare capabilities in `sail.toml`; fleets coordinate shared
  policies in `fleet.toml`. Modules may not escalate at runtime.
- Secrets cannot be logged, hashed, or serialised without explicit policies.
- Runtime egress guards prevent `PII` from leaving the trust boundary unless a
  redaction or consent transformer is applied.
- Policies are declarative DSLs that compile to runtime transformers; they can
  be embedded inline or sourced from policy bundles shipped with the binary.

### 7.1 Data wrappers and policies (bootstrap reality)

- Wrappers such as `PII<T>` and `Secret<T>` exist in the type system design to
  model taint and secrecy. In the bootstrap toolchain, they are parsed as
  ordinary nominal types and carry no enforcement; the bootstrap runtime does
  not provide concrete `PII`/`Secret` classes.
- Policy annotations via decorators (e.g. `@policy(Redact(PII))`) are part of
  the planned self-hosted semantics. While the bootstrap parser supports
  decorators syntactically, policy decorators have no effect in stage0 and
  should be treated as documentation only.

Planned example (not valid under bootstrap runtime):

```sfn
@policy(Redact(PII))
fn summarize(user: PII<Text>) -> Summary ![model] {
  // ...
}
```

## 8. Testing, Evaluators, and Replay

Tests are first-class declarations introduced with `test`. They may declare
effects and determinism scopes.

```sfn
test "extracts totals reliably" ![model] {
  with seed(42), temperature(0.2) {
    let out = Parser.call(invoice_text);
    // Future-only in bootstrap: `~=` tolerance and `+/-` margin operators in asserts.
    // Use ordinary boolean checks in stage0.
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

## 9. String Interpolation

String literals support inline expressions using `{{ expression }}` with
mandatory double braces. Whitespace inside braces is ignored at the edges, so
`{{name}}` and `{{ name }}` are equivalent. Stage1 lowers interpolated strings
into segment arrays and calls `runtime.format_interpolated`, evaluating each
embedded expression directly without relying on Python `eval`. Legacy Stage0
paths still reference `runtime.format_string` until the bootstrap toolchain is
fully retired.

## 10. Runtime Semantics

The bootstrap compiler lowers Sailfin programs into Python code backed by
`bootstrap/runtime_support.py`. The helper module currently exposes:

- `runtime.console.info` – backing implementation for source-level `print.info`.
- `runtime.channel`, `runtime.spawn`, `runtime.enum_type`, `runtime.enum_define_variant`,
  `runtime.enum_instantiate` – concurrency and enum primitives. Invoking `spawn`
  requires the `io` effect; routing through
  `serve` requires `net`.
- `runtime.format_interpolated` – interpolated string support for the
  self-hosted pipeline; Stage0 still exposes `runtime.format_string` as a
  compatibility shim.
- `runtime.check_type` – descriptor-based runtime type testing used by the `is`
  operator. The Sailfin prelude now parses descriptors (`string`, unions,
  intersections, arrays, optionals) directly and calls into lightweight Python
  bridges only to resolve concrete runtime types.
- Control flow constructs (`if`/`else`, `for`, `match`) in Sailfin sources lower
  to descriptive Python scaffolding in the bootstrap runtime today.

Bootstrap stubs:
- Model declarations (`model ... { ... }`) are parsed and emitted as plain data
  objects. There is no `Model.call(...)` in the bootstrap backend.
- `prompt` blocks are parsed and annotated for effect checking but do not send
  messages to a model during code generation.

The Sailfin runtime prelude (`runtime/prelude.sfn`) implements most of these
helpers natively for stage1; remaining capability bridges (`console`, `fs`,
`http`, `websocket`, `spawn`, `serve`, `channel`, `sleep`, `logExecution`, and
type resolution via `runtime.resolve_runtime_type`) still delegate to the Python
runtime until the capability workstream lands. Track the current state in
`docs/runtime_audit.md`.

Additional stubs:
- Pipelines are emitted as plain functions; there is no special dataflow or
  operator support in stage0. The pipeline operator `|>` shown in examples is
  a self-hosted target and not accepted by the bootstrap parser.

The self-hosted runtime layers on:

1. Capability enforcement across effects and packages.
2. Policy engine for taint-tracked values.
3. Determinism controls (`seed`, `temperature`, per-call randomness budgets).
4. Telemetry: latency, cost, token counts, GPU metrics, and lineage traces.

### 10.1 Printing and Logging

Source code should use `print.info(...)` for standard output and `print.error(...)` for errors. In the bootstrap backend, the code generator injects `print = runtime.console`, so these calls are implemented by `runtime.console.info` and `runtime.console.error` respectively. The identifier `console` is not automatically in scope for Sailfin source; using `console.info(...)` in Sailfin code will not compile correctly under the bootstrap backend.

Supported today:
- `print.info(value)` – prints a value or interpolated string.
- `print.error(value)` – prints a value or interpolated string to error channel (same sink in bootstrap; may diverge later).
- `print.warn(value)` – emits a warning-level message. The bootstrap runtime prefixes output with `[warn]`.

Not supported yet:
- `print.debug` or structured logging levels. These may be added in the self-hosted runtime.

### 10.2 String Utilities

The Sailfin runtime prelude (`runtime/prelude.sfn`) surfaces common string helpers that the stage1 compiler and downstream capsules may import via `import { substring, find_char, grapheme_count, grapheme_at, char_code } from "runtime/prelude";`. These helpers mirror the Python bootstrap behaviour while remaining embeddable in Sailfin-native code.

- `substring(text: string, start: number, end: number) -> string`
  - Clamps `start`/`end` to the source string bounds, returns `""` when the range is empty, and builds the slice without allocating intermediate Python strings.
  - Negative indices are treated as `0`; indices past the string length are clamped to the end of the string.
- `find_char(text: string, character: string, start: number = 0) -> number`
  - Scans from `start` (clamped to the string bounds) and returns the index of the first matching code unit or `-1` when the character cannot be found.
  - Recognises the common escape sequences `\n`, `\r`, and `\t` so callers can search for newline, carriage return, or tab literals without manually unescaping first.
- `grapheme_count(text: string) -> number`
  - Returns the number of user-perceived characters (Unicode grapheme clusters), coalescing combining marks, emoji modifiers, and zero-width joiner sequences.
  - Delegates segmentation to the shared runtime helpers so both the stage1 compiler and downstream capsules agree on cluster boundaries even for complex emoji (family sequences, pride flags) and accent chains.
  - Inputs are not normalized automatically; visually distinct-but-equivalent sequences remain distinct if Unicode assigns separate clusters.
- `grapheme_at(text: string, index: number) -> string`
  - Retrieves the grapheme cluster at `index`, returning `""` for out-of-range access. The helper respects the same segmentation rules as `grapheme_count`.
- `char_code(character: string) -> number`
  - Returns ASCII code points for digits, uppercase/lowercase Latin letters, and a curated set of punctuation (`space`, newline, carriage return, tab, double quote, backslash, underscore`).
  - Decodes UTF-8 sequences up to four bytes wide directly in Sailfin, covering Latin-1, BMP, and common astral-plane glyphs (emoji, symbols) without invoking the bootstrap runtime.
  - Returns `-1` for empty input, code units longer than four bytes, or invalid continuation bytes so callers can detect malformed data.
- `match_exhaustive_failed(value: any) -> never`
  - Emits a ValueError with a message mirroring the bootstrap behaviour (`"Non-exhaustive match for value …"`).
  - Serves as the runtime backstop when the compiler cannot prove match-expression exhaustiveness; once the Sailfin-native diagnostics improve this helper lets the stage1 runtime stay self-hosted.

Struct support:
- `struct_field(name: string, value: any) -> StructField`
  - Wraps a single field/value pair for consumption by struct formatting helpers.
- `struct_repr(name: string, fields: StructField[]) -> string`
  - Produces `name(field=value, …)` strings without invoking the bootstrap runtime. Strings use plain concatenation for now; downstream call sites may format values for debugging needs.

These helpers participate in the `runtime` module re-export surface, so stage1-compiled sources receive the same behaviour when targeting the Python backend today and the upcoming LLVM/WASM backends later.


## Part B — Design Preview

The sections below describe the direction of the self-hosted compiler and
adjacent tooling. They complement the roadmap (`docs/roadmap.md`) and proposals
under `docs/proposals/`.

## 11. Roadmap

Upcoming milestones include:

1. Full type-checking and inference, including linear/affine tracking.
2. Exhaustive pattern matching with guards and destructuring.
3. Native package manager integration for models and code (`sfn`, capsules,
   fleets, provenance locking).
4. Notebook and LSP support with live cost/latency overlays.
5. Transition to the self-hosted compiler and runtime.

This specification will evolve with the implementation. Refer to `enbf.md` and
`bootstrap/tests/` for executable examples of the language.

Note (planned): Engines, adapters, tensors, and training are specified in a draft proposal under `docs/proposals/model-engines-and-training.md`. Until merged into the core spec, treat that document as design guidance rather than normative semantics.

### Native Backend Layout Descriptors

Stage2 emits a textual `.sfn-asm` artefact (`sailfin-native-text`) before LLVM
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

These descriptors are consumed by future LLVM/WASM backends and the interim
Python lowering to guarantee struct field access, enum payload extraction, and
aggregate literals share the same ABI.

### Bootstrap vs Self-Hosted Feature Matrix

See `docs/status.md` for the canonical feature table and implementation notes.

`registry.sailfin.dev` is live, but the bootstrap toolchain does not yet expose
publish/resolve commands; integration work tracks on the roadmap.

## Effect System (Bootstrap reality and planned)

Canonical effects today: io, net, model, gpu, rand, clock.

Bootstrap enforcement status (see `bootstrap/effect_checker.py`):
- model: required when a routine includes any `prompt ... { ... }` block.
- io: required when calling filesystem helpers via `fs.*`.
- net: required when using network helpers (`http.*`, `websocket.*`, or `serve`).

Currently parsed but not yet enforced: gpu, rand, clock, and hierarchical effect
names (e.g. `io.fs`, `net.http`). These are accepted by the parser and recorded
on declarations but are not validated in the bootstrap checker.

Planned (self-hosted target):
- Hierarchical, composable effects with scoping (e.g. `io.fs.read`, `net.http`).
- Cross-manifest capability gates (capsule/fleet manifests) for compilation and runtime.
- Flow-sensitive effect inference and minimal annotations.

Cross-reference: enforcement logic lives in `bootstrap/effect_checker.py` and is
invoked from the code generator prior to emission.

## Compatibility notes (examples)

Examples under `examples/` are curated to compile under the bootstrap toolchain.
If an example uses future syntax (such as currency literals `$0.05` or
`scope.with_timeout(1s)`), it is marked in comments as future feature; replace
with numeric literals and stub helpers when running with the bootstrap compiler.
