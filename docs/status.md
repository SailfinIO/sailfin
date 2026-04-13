# Status

Updated: April 12, 2026

This document tracks what works today and what is in progress. It is the source
of truth — consult it before editing docs, examples, or making claims about
feature availability.

## Build Pipeline (Current)

- CI pins to `v0.1.1` as the seed compiler. Releases past that version are built
  with the Python stabilization script (`scripts/selfhost_native.py`) and are
  pre-stabilization artifacts with known issues.
- `scripts/selfhost_native.py` (~13,000 lines) applies post-processing fixups to
  generated LLVM IR to work around current compiler bugs. This is build debt.
- `scripts/build.sh` is the clean target — no fixups. It does not yet succeed;
  eliminating the Python script is a hard 1.0 requirement.
- `make compile` (default `BUILD_DRIVER=py`) uses the Python script. `make check`
  validates the seedcheck binary can run `hello-world.sfn` and pass the test suite.

## Compiler Pipeline (Current)

- The self-hosted native compiler in `compiler/src/` is the primary toolchain;
  `make compile` produces `build/native/sailfin`.
- Pipeline: Lexer → Parser → Type Checker → Effect Checker → Native Emitter
  (`.sfn-asm` IR) → LLVM Lowering.
- Experimental LLVM JIT execution is available for targeted backend coverage.
- CI uses the native build workflow (`.github/workflows/ci.yml`) to build, test,
  and attach release assets.
- Native compiler tests live in `compiler/tests/{unit,integration,e2e}` and run
  via `sfn test` or `make test-unit`, `make test-integration`, `make test-e2e`.

## Feature Matrix

| Feature | Status | Notes |
|---|---|---|
| `let` / `let mut` variables | Shipped | Type annotations optional; limited inference |
| Functions (`fn`) | Shipped | Including generics, default params, decorators |
| `async fn` | Parsed | `await` is **not** parsed; async is structural only |
| Structs | Shipped | Including generic params, `implements` clause |
| Interfaces | Shipped | Trait-style method signatures |
| Enums / ADTs | Shipped | Variants with payloads |
| Type aliases | Shipped | Including generic params |
| `if`/`else` | Shipped | |
| `for` / `while` loops | Shipped | |
| `match` | Shipped | Literals, `_` wildcard, guards; destructuring enum variants |
| `try`/`catch`/`finally` | Shipped | Maps to runtime exceptions |
| String interpolation (`{{ }}`) | Shipped | |
| Pattern matching exhaustiveness | Partial | Runtime backstop via `match_exhaustive_failed` |
| Effect annotations (`![...]`) | Shipped | Parsing and declaration |
| Effect enforcement — `io` | Shipped | `print.*`, `console.*`, `fs.*`, `@logExecution` |
| Effect enforcement — `net` | Shipped | `http.*`, `websocket.*`, `serve` |
| Effect enforcement — `model` | Shipped | Required for any `prompt` block |
| Effect enforcement — `clock` | Partial | `sleep`/`runtime.sleep` checked; hierarchical names not enforced |
| Effect enforcement — `gpu`, `rand` | Parsed only | Accepted syntactically; not validated |
| Generic type inference | Partial | Type params captured; inference coverage is limited |
| Interface conformance validation | Partial | Basic checks; variance not yet enforced |
| `Affine<T>` / `Linear<T>` | Parsed only | Ownership wrappers accepted; move/consume rules not enforced |
| `&T` / `&mut T` borrows | Parsed only | Accepted syntactically; exclusivity not checked |
| `PII<T>` / `Secret<T>` | Parsed only | Parsed as nominal types; no taint enforcement |
| `model` declarations | Parsed + IR | Emits `.model` directive in `.sfn-asm`; **no runtime execution** |
| `prompt` blocks | Parsed + IR | Emits `.prompt` directive; **no runtime execution** |
| `pipeline` declarations | Parsed + IR | Parsed as plain functions; `\|>` operator **not implemented** |
| `tool` declarations | Parsed + IR | Recorded as metadata; no dispatcher |
| `routine { }` blocks | **Not implemented** | Not parsed |
| `await` | **Not implemented** | Not parsed |
| `channel()` concurrency | **Not implemented** | Not parsed as concurrency primitive |
| `spawn` | **Not implemented** | Not parsed |
| Model execution (`.call()`) | **Not implemented** | Parses as method call; no model runtime |
| Generation cards / provenance | **Not implemented** | Planned alongside model execution |
| Typed prompt channels | **Not implemented** | `prompt user<T> { }` is design-stage syntax |
| `\|>` pipeline operator | **Not implemented** | |
| Currency literals (`$0.05`) | **Not implemented** | Use numeric literal + comment |
| Time literals (`1s`, `150ms`) | **Not implemented** | Use numeric literals |
| `scope.with_timeout(...)` | **Not implemented** | |
| `unsafe` / `extern` | Parsed only | Syntax accepted; enforcement not active |
| Policy decorators (`@policy(...)`) | Parsed only | No compiler or runtime effect |
| LSP / notebook support | Not started | Post-1.0 |
| Package registry (`sfn add/publish`) | Not started | Post-1.0 |

## Print API (Current)

- `print(value)` is the canonical output builtin (stdout, no prefix).
- `print.err(value)` writes to stderr.
- `print.info`/`print.warn`/`print.error` are deprecated legacy variants kept for
  backward compatibility; new code should use `print()` and `print.err()`.
- The `sfn/log` capsule provides structured logging (`log.info`, `log.warn`,
  `log.error`, `log.debug`) with named loggers and fields. `log.warn` and
  `log.error` route to stderr via `print.err()`.

## Standard Library Capsules (Current)

The following capsules ship as part of the Sailfin standard library under
`capsules/sfn/`. Users import them by bare name (e.g. `from "fmt"`).

| Capsule | Import | Status | Effects | Description |
|---------|--------|--------|---------|-------------|
| `sfn/fmt` | `"fmt"` | Shipped | None | String formatting, trim, case conversion, split/join |
| `sfn/json` | `"json"` | Shipped | None | JSON parsing, serialization, pretty-print |
| `sfn/crypto` | `"crypto"` | Shipped | None | SHA-256, base64 encode (via C runtime) |
| `sfn/math` | `"math"` | Shipped | None | abs, min/max, clamp, floor/ceil/round, pow, sum/mean |
| `sfn/path` | `"path"` | Shipped | None | Path join, dirname, basename, ext, normalize |
| `sfn/toml` | `"toml"` | Shipped | None | TOML v1.0 parsing, serialization, dotted-path access |
| `sfn/fs` | `"fs"` | Shipped | `io` | File read/write/append, exists, mkdir, read_dir |
| `sfn/os` | `"os"` | Shipped | `io` | Env vars, home dir, exec, exit |
| `sfn/log` | `"log"` | Shipped | `io`, `clock` | Structured leveled logging with named loggers |
| `sfn/time` | `"time"` | Shipped | `clock` | Sleep, monotonic timing, elapsed |
| `sfn/http` | `"http"` | Partial | `net`, `io` | GET/POST client (via C runtime); server stubbed |
| `sfn/sync` | `"sync"` | Stubbed | `io` | channel/parallel/spawn API (pending concurrency runtime) |
| `sfn/net` | `"net"` | Stubbed | `net`, `io` | TCP/UDP socket API (pending runtime intrinsics) |
| `sfn/tensor` | `"tensor"` | Shipped (CPU) | `gpu` (planned) | Tensor ops, matmul, transpose; GPU dispatch not yet implemented |
| `sfn/layers` | `"layers"` | Shipped (CPU) | `gpu` (planned) | Linear layers, ReLU, sequential models |
| `sfn/nn` | `"nn"` | Shipped (CPU) | `gpu` (planned) | Activations, normalization, argmax, one_hot |
| `sfn/losses` | `"losses"` | Shipped | None | MSE, MAE, Huber, hinge loss functions |
| `sfn/cli` | `"cli"` | Shipped | `io` | CLI arg parsing, subcommands, help generation, terminal styling |

## Runtime (Current)

- The runtime is implemented in C under `runtime/native/` and linked into the
  native compiler binary.
- The native CLI locates a bundled runtime next to the executable (override with
  `SAILFIN_RUNTIME_ROOT`).
- Legacy Python runtime shims have been removed; the toolchain does not rely on
  `runtime/*.py` helpers.
- The native filesystem adapter supports `readFile`, `writeFile`, `appendFile`,
  `writeLines`, and directory helpers.
- **String concat optimization (`string_append`)**: The LLVM lowering emits
  `sailfin_runtime_string_append` (realloc-based in-place extend) for intermediate
  results in chained `+` concat chains instead of `sailfin_runtime_string_concat`
  (malloc+copy). This eliminates 2 dead intermediate allocations per 4-way concat
  and is estimated to reduce per-module peak memory 30-50% for string-heavy
  compilation paths. Pure lowering optimization — no user-visible syntax change.
  Implemented in `compiler/src/llvm/expression_lowering/native/core_strings.sfn`
  and `core_ops_lowering.sfn`; runtime entry point in
  `runtime/native/src/sailfin_runtime.c`.
- **The C runtime will be replaced by a Sailfin-native runtime before 1.0.** This
  is a hard prerequisite for the 1.0 release, not a post-1.0 item. See
  `docs/roadmap.md` and `docs/runtime_audit.md`.

## Installer (Current)

- The installer defaults to `~/.local/bin` on all platforms (override with
  `GLOBAL_BIN_DIR`).
- Pinned stable version for development: `v0.1.1-alpha.135`.

## Known Design Issues (Pre-1.0 Syntax Reform)

The following design issues have been identified through external review and must
be resolved before 1.0 to avoid breaking a public API. Each is tracked in
`docs/roadmap.md` §0 (Syntax Reform). This section records the *problem*; the
roadmap records the *plan*.

### Type annotation syntax (`->` vs `:`)

**Problem**: `->` is used for both "has type" (parameters, variables) and
"returns" (function return type). This conflicts with the universal meaning of
`->` as "maps to / returns" in every typed language (Rust, TypeScript, Haskell,
Kotlin, Swift, Python).

```sfn
// Current — three arrows, two meanings
fn add(x -> number, y -> number) -> number { ... }
// Target
fn add(x: number, y: number) -> number { ... }
```

**Impact**: High. This is the first syntax new users see. It will cause
immediate confusion and is the most likely reason someone trying the language
will stop.

**Status**: Parser already accepts `:` as `TypeSep` alongside `->` (see EBNF
`TypeSep = "->" | ":"`). Migration: deprecate `->` in type positions, then
remove.

### String interpolation (`{{ }}` vs `${ }`)

**Problem**: `{{ }}` universally means "escape interpolation" in template
languages (Jinja2, Handlebars, Mustache, Angular) and "literal braces" in
Rust's `format!`. Sailfin uses it for the *opposite* meaning.

**Impact**: Medium-high. Every developer will be confused. LLM code generators
trained on billions of lines of `{{ }}` = "literal braces" will systematically
produce wrong Sailfin code.

### Numeric type system (`number` = f64 only)

**Problem**: The sole numeric type is `number` (64-bit float). This causes:
- Precision loss for integers above 2^53
- Semantically wrong array indexing (floats as indices)
- Unreliable bit operations
- The "double-encoded pointers" fixup category (~12 of ~69 compiler fixups) —
  pointers are encoded as doubles because that's what `number` compiles to

**Impact**: High. This is a systems language targeting LLVM. JavaScript made
this choice and added BigInt 25 years later to compensate. Don't repeat it.

### Error handling gaps

**Problem**: Errors are invisible in function signatures. `try`/`catch` is the
only structured mechanism, supplemented by ad-hoc union return types
(`number | DivisionError`) with no propagation operator.

**Impact**: Medium. No `Result<T, E>` or `?` operator means every error-handling
call site requires manual `match`. Error types proliferate across module
boundaries with no composition mechanism.

### Unfinished safety claims

**Problem**: `Affine<T>`, `Linear<T>`, `&T`, `&mut T`, `PII<T>`, `Secret<T>`
are all parsed but not enforced. Claiming "Rust-grade safety" or
"ownership-aware" in marketing materials while these are purely syntactic is a
credibility risk.

**Impact**: Medium. Users who come for the safety story will discover it doesn't
work and leave. Better to remove unfinished syntax than to advertise unenforced
guarantees.

### Scope creep risk

**Problem**: The spec describes Rust-grade ownership, Swift-like ergonomics,
AI-native constructs, effect types, capability security, taint tracking, GPU
acceleration, structured concurrency, policy DSLs, generation cards, and tensor
types. This is a feature list for five different languages.

**Recommendation**: Pick 3 differentiators (effect system, capability security,
structured concurrency) and ship those well. Defer everything else ruthlessly.

## AI / Model Features (Design Preview)

The following features are central to Sailfin's AI-native vision and are fully
designed. They are tracked in the spec (`docs/spec.md` Part B) and proposals
(`docs/proposals/`) but are **not yet functional** in the current compiler or
runtime:

- `model` blocks declare metadata and are emitted to `.sfn-asm`, but `.call()`
  performs no actual model invocation.
- `prompt` blocks emit IR directives but do not dispatch to any model API.
- Generation cards (provenance metadata: engine, params, seeds, input hashes,
  latency, cost) are not yet produced.
- Model evaluators (`Faithfulness`, `LatencyBudget(...)`) are design-stage.
- `tool` dispatcher (model-invocable typed capabilities) is not yet implemented.
- Tensor/GPU workloads (`Vector<N>`, `Tensor<Shape, DType>`, GPU batching) are
  not yet implemented.

These features are tracked as a post-1.0 milestone. The design is preserved in
`docs/spec.md` §3.6–§3.9 and `docs/proposals/model-engines-and-training.md`.
