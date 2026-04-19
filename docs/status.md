# Status

Updated: April 17, 2026

This document tracks what works today and what is in progress. It is the source
of truth — consult it before editing docs, examples, or making claims about
feature availability.

## Build Pipeline (Current)

- `scripts/build.sh` is the sole build driver for the compiler's self-build —
  pure shell, no fixups. It stages in-tree capsule sources
  (`capsules/<scope>/<name>/src/`) as import-context artifacts so the seed can
  resolve imports like `from "sfn/cli"` during the bootstrap.
- End-user builds (`sfn build`, `sfn run`) resolve capsule deps via
  `compiler/src/capsule_resolver.sfn` — real separate-compilation of capsule
  modules through the same `build/native/import-context/<slug>.*` path the
  compiler uses on itself. No text-level inlining for declared capsule deps.
- `make compile` builds the compiler from a released seed. `make check`
  validates the seedcheck binary can run `hello-world.sfn` and pass the test suite.
- **Deterministic self-hosting**: the compiler is a verified fixed point —
  stage2 and stage3 produce byte-identical LLVM IR across all modules.
  `make check` enforces this.
- The legacy Python fixup script (`selfhost_native.py`) was removed after the
  compiler reached clean LLVM IR output (v0.5.0-alpha.22+).

## Compiler Pipeline (Current)

- The self-hosted native compiler in `compiler/src/` is the primary toolchain;
  `make compile` produces `build/native/sailfin`.
- Pipeline: Lexer → Parser → Type Checker → Native Emitter
  (`.sfn-asm` IR) → LLVM Lowering.
- **Effect checker status**: `validate_effects()` exists in `effect_checker.sfn`
  but is **not invoked by the compiler or CLI during normal builds** — users will
  not see effect diagnostics during compilation, and effect violations do not
  block compilation. Wiring effect enforcement into the build is the top priority
  in the Effect System Hardening track on the
  [roadmap](https://sailfin.dev/roadmap).
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
| Effect enforcement — `io` | Not enforced | Checker logic exists for `print.*`, `console.*`, `fs.*`, `@logExecution` but is not run during compilation |
| Effect enforcement — `net` | Not enforced | Checker logic exists for `http.*`, `websocket.*`, `serve` but is not run during compilation |
| Effect enforcement — `model` | Not enforced | Checker logic exists for `prompt` blocks but is not run during compilation |
| Effect enforcement — `clock` | Not enforced | Checker logic exists for `sleep`/`runtime.sleep` but is not run during compilation |
| Effect enforcement — `gpu`, `rand` | Parsed only | Accepted syntactically; no checker logic |
| Effect enforcement as compilation gate | **Not yet** | `validate_effects()` exists but is not invoked by the compiler; top priority |
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
| `sfn fmt` (formatter) | **Shipped** | Token-stream formatter: indentation, spacing, inline blocks, unary operator handling, import sorting & specifier reordering, blank line normalization, `--check`/`--write` modes, CI enforcement; see `docs/proposals/fmt-architecture.md` for architecture and known limitations |
| `sfn check` (fast analysis) | **Shipped** | Runs parse + typecheck + effect-check on `.sfn` sources without emitting IR or invoking `clang`. Reports diagnostics to stderr with a summary on stdout. Exits non-zero on findings. See `docs/proposals/check-architecture.md`. |
| `sfn vet` (static analyzer) | Planned | Pre-1.0; see `docs/proposals/tooling.md` |
| `sfn lsp` (language server) | Planned | Phase 1 pre-1.0; see `docs/proposals/tooling.md` |
| `sfn doc` (doc generator) | Planned | 1.0; see `docs/proposals/tooling.md` |
| `sfn fix` (auto-rewriter) | Planned | 1.0; see `docs/proposals/tooling.md` |
| Notebook support | Not started | Post-1.0 |
| Package registry (`sfn init/add/publish`) | Shipped | CLI commands implemented; default registry at `pkg.sfn.dev`; configurable via `sfn config set registry <url>` or `SFN_REGISTRY` env var |

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
- **The C runtime will be replaced by a pure Sailfin runtime before 1.0.** No C
  shim — the entire runtime (~90 ABI functions across strings, arrays, I/O,
  exceptions, crypto, time, and process execution) will be rewritten in Sailfin.
  This is a hard prerequisite for the 1.0 release.

### Runtime Migration Prerequisites

The runtime rewrite depends on compiler features that must ship first. The
[roadmap](https://sailfin.dev/roadmap) sequences these as numbered phases:

| Compiler Feature | Status | Runtime Subsystems It Unblocks |
|---|---|---|
| `extern fn` (LLVM `declare` emission) | In progress (type-checker registration needed) | All — nothing can call `malloc`/`fopen`/`write` without it |
| `int` / `float` numeric types | Planned | Sizes, indices, bitwise ops; fixes f64 precision hazard |
| Raw pointer types (`*T`) enforced | Planned | OS handles (`*FILE`, `*DIR`, `*pthread_t`), buffer pointers |
| `Result<T, E>` + `?` operator | Planned | Every fallible operation (file I/O, allocation, network) |
| Bitwise integer operators | Planned | SHA-256, Base64, flags, enum tag extraction |
| Closures with capture | Planned | `map`/`filter`/`reduce`, spawn handlers, route handlers |
| Generic type constraints | Planned | `Array<T>`, `Slice<T>`, `HashMap<K, V>`, `Channel<T>` |
| Deterministic drop emission | Planned | Memory reclamation — enables `string_drop` and `array_drop` |
| Atomic intrinsics | Planned | Reference counting, task queues, channel implementation |

See `docs/runtime_audit.md` for the full migration plan.

## Installer (Current)

- The installer defaults to `~/.local/bin` on all platforms (override with
  `GLOBAL_BIN_DIR`).
- Pinned stable version for development: `v0.1.1-alpha.135`.

## Known Design Issues (Pre-1.0 Syntax Reform)

The following design issues have been identified through external review and must
be resolved before 1.0 to avoid breaking a public API. Each is tracked in
the [roadmap](https://sailfin.dev/roadmap) and `docs/proposals/colon-type-annotations.md`. This section records the *problem*; the
roadmap records the *plan*.

### Type annotation syntax (`->` vs `:`) — **migrated**

**Resolution**: The compiler source, runtime, capsules, tests, and examples
all use `:` for parameter, variable, and field type annotations. Function
return types continue to use `->`.

```sfn
fn add(x: number, y: number) -> number { ... }
let name: string = "Sailfin";
struct User { id: number; name: string; }
```

**Remaining work**: None — migration complete. The parser now enforces
`:` in annotation positions and `->` in return-type positions.

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

### Unenforced syntax (deferred to post-1.0)

**Decision**: `Affine<T>`, `Linear<T>`, `&T`, `&mut T`, `PII<T>`, `Secret<T>`
are all parsed but not enforced. Rather than marketing unenforced guarantees,
these features are explicitly deferred to post-1.0. Sailfin's safety story is
**effects and capabilities**, not borrow checking or taint tracking — those will
ship when they can be enforced end-to-end.

**Status**: Ownership and taint types remain in the parser for forward
compatibility but are not advertised as shipped features. They will be removed
from marketing materials and the homepage.

### Strategic focus

**Decision**: Sailfin's three differentiators are: (1) effect system,
(2) capability-based security, (3) structured concurrency. All pre-1.0 effort
focuses on making these world-class. AI integration, ownership enforcement,
and taint tracking are post-1.0 library and compiler work.

## AI / Model Constructs (Migration to Library)

The `model`, `prompt`, `tool`, and `pipeline` keywords were originally designed
as language-level syntax. Following a strategic review, these are being migrated
to the `sfn/ai` library capsule for post-1.0 delivery. Rationale:

- AI APIs change faster than language grammars can evolve
- Library-level features can iterate independently of compiler releases
- The `![model]` effect — the capability gate — remains a language-level feature
- Keyword syntax reserved unnecessary grammar surface for features that have
  no runtime behavior today

**Current state**: `model`, `prompt`, `tool`, and `pipeline` blocks are still
parsed and emit metadata to `.sfn-asm`, but perform no runtime execution. They
will be migrated to the `sfn/ai` capsule as library types and functions.

**What stays in the language**: The `![model]` effect annotation, which gates
AI operations through the capability system. The effect checker detects
violations, but enforcement does not yet block compilation (see Effect
System Hardening on the [roadmap](https://sailfin.dev/roadmap)).

Design documents are preserved in `docs/spec.md` §3.6–§3.9 and
`docs/proposals/model-engines-and-training.md`.
