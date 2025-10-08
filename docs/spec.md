# Sailfin Language Specification

Version: 0.2.0 (design preview)
Date: October 2025

Sailfin is an AI-native, expression-oriented programming language that combines
Rust-grade safety, Swift-like ergonomics, and runtime observability. The Python
bootstrap compiler implements a pragmatic subset while the self-hosted
implementation matures. This document captures the behaviour of the bootstrap
subset and describes the design direction for forthcoming features.

## 1. Lexical Structure

- **Identifiers** begin with a letter and may contain ASCII letters, digits, or
  `_`. Identifiers are case-sensitive.
- **Keywords** are listed in `docs/keywords.md`. They include traditional
  control-flow terms (`fn`, `async`, `await`, `match`, …) and AI-first syntax
  such as `model`, `prompt`, `pipeline`, and `test`.
- **Literals**:
  - Numeric literals support integers (`42`) and decimals (`3.14`).
  - String literals use double quotes, support escapes, and recognise
    `{{ expression }}` interpolation (see §9).
  - Boolean literals are `true` and `false`.
  - `null` denotes the absence of a value.
- **Comments** use `//` for single-line comments and `/* … */` for multi-line
  comments.

### 1.1 Effect Annotation

Functions, pipelines, tests, and tools may declare required capabilities with
`![effect, ...]` syntax appended to the signature:

```sail
fn fetch_order(id: OrderId) -> Order ![io,net] { ... }
```

The bootstrap parser records the effect list; the self-hosted compiler enforces
that all effectful operations inside the body belong to the declared set.

## 2. Modules, Imports, and Capabilities

Source files compile independently. Imports use ES-module style syntax:

```sail
import { Channel, channel } from "sail/async";
```

Packages declare their required capabilities in the manifest (`sail.json`). When
self-hosted, invoking a capability (e.g. sending a network request) that is not
listed in the manifest or function effect set results in a compile-time error.

## 3. Declarations

### 3.1 Variables and Constants

Variables default to immutability and are introduced with `let`. Add `mut` to
allow reassignment.

```sail
let name -> string = "Sailfin";
let mut counter -> number = 0;
```

Type annotations are optional; the bootstrap compiler performs limited
inference. Constants use `const` and require initialisers.

### 3.2 Functions and Methods

`fn` declares functions. Parameters accept optional type annotations and default
values. Return types use `->`.

```sail
fn add(x -> number, y -> number) -> number {
    return x + y;
}
```

`async fn` enables `await` inside the body. Decorators (`@identifier`) are
parsed but ignored by code generation during bootstrapping.

#### 3.2.1 Effect Signatures

`![...]` after a signature lists the effects the body may perform. The canonical
set is `io`, `net`, `model`, `gpu`, `rand`, and `clock`. Custom effects may be
introduced via manifests.

```sail
fn issue_refund(order: Order) -> Refund ![io,net,model] {
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

```sail
fn ingest(batch: Affine<Vector<1024>>) ![gpu] {
    let view = borrow(batch);
    gpu.stream(view);
}
```

#### 3.2.3 Policy-Tracked Types

Sensitive data flows through wrappers such as `PII<T>`, `Secret<T>`, and
`Policy<T, Rule>`. Attempting to pass a `PII<Text>` to a `net` or `model`
effect without an attached policy causes a compile-time error.

```sail
fn render_invoice(user: PII<User>) -> Html ![io] {
    redact(user).into_html();
}
```

### 3.3 Structs and Interfaces

Structs group fields and methods. Fields are immutable unless declared with
`mut`. Methods are declared with `fn` inside the struct body and may reference a
`self` parameter explicitly. Interfaces provide trait-style method signatures.

```sail
interface Greeter {
    fn greet(self) -> string;
}

struct User implements Greeter {
    id -> number;
    mut name -> string;

    fn greet(self) -> string {
        return "Hello, {{self.name}}!";
    }
}
```

Struct literals use `Type { field: expression }` syntax. Method calls follow the
`instance.method(args)` form.

### 3.4 Enums and Algebraic Data Types

Enums mirror algebraic data types (ADTs). Variants may include payloads.

```sail
enum Response {
    Ok,
    Error { message -> string },
}
```

### 3.5 Type Aliases and Generics

Type aliases provide named shortcuts. Generics are parsed throughout the
language; the bootstrap compiler treats them as metadata for code generation.

```sail
type Result<T> = Response | T;
```

### 3.6 Model Declarations

Models are first-class program artefacts. A `model` block declares metadata,
versions, schemas, and evaluator suites, producing a `Model<Input, Output>`
value.

```sail
model Summarizer : Model<Text, Summary> {
    engine    = "gpt-foo@2.3.1";
    schema    = Summary;
    max_tok   = 2000;
    cost_cap  = $0.05;
    evals     = [ Faithfulness, LatencyBudget(150ms) ];
}
```

Calling a model requires the `model` effect, returns a typed output, and yields
a signed **generation card** containing provenance (engine, params, seeds,
input hashes, latency, cost).

### 3.7 Prompt Blocks

`prompt` blocks compose multi-part instructions. Supported channels are
`system`, `user`, `assistant`, and `tool`. Interpolated identifiers are checked
statically.

```sail
fn summarize_doc(doc: Text) -> Summary ![model] {
    prompt system { "You are a concise technical summarizer." }
    prompt user   { "Summarise:\n{doc}" }
    Summarizer.call()
}
```

### 3.8 Pipelines and Dataflow

`pipeline` declarations express ETL-style dataflows with zero-copy semantics and
compile-time shape checks.

```sail
pipeline index_corpus(docs: Seq<Text>) ![io,gpu] {
    docs
      |> chunk(by: "semantic", target_tokens: 512)
      |> embed(with: "e5-large")
      |> upsert(index: "docs_idx");
}
```

Each stage declares effect usage implicitly via the called functions. Pipelines
can be invoked like ordinary functions and integrate with structured
concurrency.

### 3.9 Tools and Capability Contracts

Tools are typed capabilities that models may invoke. They declare their own
effect sets and are subject to the same capability enforcement as user code.

```sail
tool FetchProfile(id: Id) -> Profile ![net] { ... }
```

Foreign adapters for Python/JavaScript run in sandboxed processes with copy-on-
write buffers; taint wrappers (`PII`, `Secret`) propagate through adapter
boundaries.

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
- **Channels** – Channels are bounded by default, providing backpressure for
  model pipelines.
- **Accelerators** – Operations requiring GPUs/TPUs must declare the `gpu`
  effect. The runtime batches compatible tensor work automatically.

```sail
async fn main() ![io,model] {
    let scope = scope.with_timeout(1s);
    let messages -> Channel<number> = channel(capacity: 32);

    routine scope {
        messages.send(42);
    }

    let result = await messages.receive();
    print.info("Received: {{result}}");
}
```

## 6. Type System Overview

| Type        | Description                                          |
|-------------|------------------------------------------------------|
| `number`    | 64-bit floating point numbers                        |
| `string`    | UTF-8 encoded strings                                |
| `boolean`   | Truth values                                         |
| `void`      | No return value                                      |
| `null`      | Explicit absence of a value                          |

Composite types include structs, enums, arrays (`Type[]`), optionals (`Type?`),
and unions (`A | B`). Function types (`fn(T) -> U`) are parsed but not emitted
by the bootstrap backend.

**Vector/Tensor types** – `Vector<N>` and `Tensor<Shape, DType>` are value types
with linear semantics suitable for zero-copy AI workloads.

**Wrapper types** – `PII<T>`, `Secret<T>`, `Policy<T, Rule>`, `Affine<T>`, and
`Linear<T>` compose with all other types and participate in effect enforcement.

## 7. Capability-Based Security

- Imports declare capabilities in `sail.json`; modules may not escalate at
  runtime.
- Secrets cannot be logged, hashed, or serialised without explicit policies.
- Runtime egress guards prevent `PII` from leaving the trust boundary unless a
  redaction or consent transformer is applied.
- Policies are declarative DSLs that compile to runtime transformers; they can
  be embedded inline or sourced from policy bundles shipped with the binary.

## 8. Testing, Evals, and Replay

Tests are first-class declarations introduced with `test`. They may declare
effects and determinism scopes.

```sail
test "extracts totals reliably" ![model] {
    with seed(42), temperature(0.2) {
        let out = Parser.call(invoice_text);
        assert out.total ~= 199.99 +/- 0.01;
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

String literals support inline expressions using `{{ expression }}`. The
bootstrap runtime invokes `runtime.format_string` to evaluate expressions
against the current scope. Failures leave the placeholder intact for debugging.

## 10. Runtime Semantics

The bootstrap compiler lowers Sailfin programs into Python code backed by
`bootstrap/runtime_support.py`. The helper module currently exposes:

- `runtime.console.info` – implements the `print.info` convention.
- `runtime.channel`, `runtime.spawn`, `runtime.EnumType` – concurrency and enum
  primitives.
- `runtime.models.call_model` – placeholder for model invocations; currently
  simulates responses.
- `runtime.format_string` – interpolated string support.

The self-hosted runtime layers on:

1. Capability enforcement across effects and packages.
2. Policy engine for taint-tracked values.
3. Determinism controls (`seed`, `temperature`, per-call randomness budgets).
4. Telemetry: latency, cost, token counts, GPU metrics, and lineage traces.

## 11. Roadmap

Upcoming milestones include:

1. Full type-checking and inference, including linear/affine tracking.
2. Exhaustive pattern matching with guards and destructuring.
3. Native package manager integration for models and code.
4. Notebook and LSP support with live cost/latency overlays.
5. Transition to the self-hosted compiler and runtime.

This specification will evolve with the implementation. Refer to `enbf.md` and
`bootstrap/tests/` for executable examples of the language.
