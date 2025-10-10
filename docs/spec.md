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
(`bootstrap/effect_checker.py`) enforces a subset today. See Effect System
section below for details.

## 2. Modules, Imports, and Capabilities

Source files compile independently. Imports use ES-module style syntax and
canonical Sailfin-branded paths:

```sfn
import { Channel, channel } from "sailfin/async";
```

Capsules declare their required capabilities in `sail.toml`; multi-capsule
workspaces centralise shared policies in `fleet.toml`. When self-hosted,
invoking an undeclared capability (e.g. sending a network request) that is not
listed in the manifest or function effect set results in a compile-time error.

## 3. Declarations

### 3.1 Variables and Constants

Variables default to immutability and are introduced with `let`. Add `mut` to
allow reassignment.

```sfn
let name -> string = "Sailfin";
let mut counter -> number = 0;
```

Type annotations are optional; the bootstrap compiler performs limited
inference. Constants use `const` and require initialisers.

### 3.2 Functions and Methods

`fn` declares functions. Parameters accept optional type annotations and default
values. Return types use `->`.

```sfn
fn add(x -> number, y -> number) -> number {
    return x + y;
}
```

`async fn` enables `await` inside the body. Decorators (`@identifier`) are

Self-hosted runtime stub: the repository now includes `compiler/runtime/prelude.sfn`,
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

### 6.1 Ownership & Linear Types (bootstrap reality)

- `Affine<T>` and `Linear<T>` are accepted syntactically as ordinary nominal
  types. The bootstrap toolchain does not enforce move/consume rules; they are
  carried as annotations for diagnostics and documentation only.
- Borrowing is a planned feature in the self-hosted compiler. The tentative
  surface syntax will include a function-style borrow `borrow(x)` and may also
  explore a unary borrow operator `&x`. The latter is not parsed today (the `&`
  token is currently used for type intersections, e.g. `A & B`).

> Warning (bootstrap): Ownership wrappers and borrows are diagnostics-only.
> The bootstrap backend will not prevent aliasing, duplication, or drops of
> `Affine<T>`/`Linear<T>` values.

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
`{{name}}` and `{{ name }}` are equivalent. The bootstrap runtime invokes
`runtime.format_string` to evaluate expressions against the current scope.
Failures leave the placeholder intact for debugging.

## 10. Runtime Semantics

The bootstrap compiler lowers Sailfin programs into Python code backed by
`bootstrap/runtime_support.py`. The helper module currently exposes:

- `runtime.console.info` – backing implementation for source-level `print.info`.
- `runtime.channel`, `runtime.spawn`, `runtime.EnumType` – concurrency and enum
  primitives. Invoking `spawn` requires the `io` effect; routing through
  `serve` requires `net`.
- `runtime.format_string` – interpolated string support.
- Control flow constructs (`if`/`else`, `for`, `match`) in Sailfin sources lower
  to descriptive Python scaffolding in the bootstrap runtime today.

Bootstrap stubs:
- Model declarations (`model ... { ... }`) are parsed and emitted as plain data
  objects. There is no `Model.call(...)` in the bootstrap backend.
- `prompt` blocks are parsed and annotated for effect checking but do not send
  messages to a model during code generation.

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

Not supported yet:
- `print.warn`, `print.debug`, or structured logging levels. These may be added in the self-hosted runtime.


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
