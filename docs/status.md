# Sailfin Status

Updated: October 2025

This document is the source of truth for what ships today in the Python
bootstrap toolchain and what exists only in the Sailfin-native
experiments. Use it as the checklist before updating specs, examples, or
roadmaps.

## Stage Overview

- **Bootstrap (stage0)** — Python compiler that parses Sailfin source and
  emits runnable Python. Effect checking is conservative (`model`, `io`,
  `net`). Runtime helpers for `http`, `websocket`, and `fs` are mocked for
  fast feedback.
- **Self-hosted (stage1)** — Sailfin-written lexer, parser, and emitter
  that round-trip common declarations, decorators, and prompts. Code
  generation currently targets Python scaffolding and shares the bootstrap
  runtime prelude.
- **Registry** — `registry.sailfin.dev` serves capsule and model metadata.
  Integration into the bootstrap toolchain is not wired yet; manifests and
  CLI commands are tracked as roadmap work.

## Feature Snapshot

**Parsing & Declarations**
- Bootstrap: Stage0 parses `fn`, `struct`, `enum`, `interface`, `model`, `tool`,
  `pipeline`, `test`, `type`, and `match` declarations.
- Self-hosted prototype: Mirrors the same surface and now recognises
  block-level `if`/`else`, `for` loops, and `match` statements with `case`
  guards captured as expressions plus inline `=>` expression or `return`
  bodies. Common expressions (member access, function calls, unary `!`/`-`,
  binary operators through `&&`/`||`, range operators (`start..end`),
  indexing (`target[index]`), lambda expressions (`fn (...) { ... }`), and
  literal forms like `[x, y]`, `{ key: value }`, and `Type { field: value }`)
  now lower into structured nodes instead of `Raw` placeholders.

**Effect Tracking (`![...]`)**
- Bootstrap: Enforces `model`, `io`, `net`, and `clock` via
  `bootstrap/effect_checker.py`, covering prompt blocks, effectful decorators
  (e.g. `@logExecution`), and runtime helpers such as `fs.*`, `http.*`,
  `websocket.*`, `serve`, `spawn`, `print.*`, and `sleep` (including their
  `runtime.*` aliases).
- Self-hosted prototype: Infers `io` when decorators like `@trace` or
  `@logExecution` appear and scans blocks for prompts, console helpers
  (`print.*`, `console.*`, `runtime.console.*`), runtime timers
  (`sleep`, `runtime.sleep`), and capability helpers such as `fs.*`,
  `runtime.fs.*`, `http.*`, `runtime.http.*`, `websocket.*`,
  `runtime.websocket.*`, `serve`, `runtime.serve`, `spawn`, and
  `runtime.spawn`. Hierarchical effects remain design-stage work.

**Semantic Analysis**
- Bootstrap: Performs symbol collection and effect validation inside the
  Python pipeline; deeper type checking remains future work.
- Self-hosted prototype: `compiler/src/typecheck.sfn` now walks top-level and
  scoped blocks, builds symbol tables for functions/tests, and reports duplicate
  declarations (including parameter and local name clashes). Diagnostics flow
  through `compiler/src/main.sfn` so the bootstrap pipeline surfaces issues
  during round-trips.

**Prompt Blocks**
- Bootstrap: Prompts require the `model` effect; interpolation is handled by the
  runtime helpers.
- Self-hosted prototype: Prompt statements are preserved in the AST and emitted
  as comments; deterministic scopes (`with seed(...)`) parse but have stubbed
  semantics.

**Models, Pipelines, Tools**
- Bootstrap: Emit data holders and plain Python functions; no special pipeline
  operator yet.
- Self-hosted prototype: Uses the same emission strategy while preserving
  properties and effects. The planned `|>` operator remains illustrative only.

**Ownership & Types**
- Bootstrap: Parses `Affine<T>` / `Linear<T>` without enforcement.
- Self-hosted prototype: Carries ownership metadata for future borrow checking.

**Tests**
- Bootstrap: Lowers tests to Python functions executed in the `__main__`
  preamble, enforcing required effects.
- Self-hosted prototype: Generates the same scaffolding.

**Code Generation**
- Bootstrap: Walks the full AST and emits runnable Python against
  `runtime_support.py`. Console helpers now cover `print.info`,
  `print.error`, and `print.warn`, each flagged by the effect checker as
  `io`.
- Self-hosted prototype: Produces Python scaffolding with block stubs; emitter
  coverage now lowers simple lambda expressions to Python `lambda` literals and
  rewrites common postfix helpers (`.map`, `.filter`, `.reduce`, `.concat`,
  `.length`) into the runtime `array_*` shims and `len(...)` calls (multi-
  statement lambdas still fall back to stubs). Block emission now preserves
  local `let` declarations (with optional `mut`), `for` loops, `if`/`else if`/`else`
  chains, and `match` statements so stage1 sources round-trip cleanly through
  the bootstrap parser. The native backend (`emit_native.sfn`) now emits a
  structured `.sfn-asm` textual artifact with entry-point metadata and inline
  annotations for unsupported constructs. Shared parsing in `native_ir.sfn`
  now records parameter metadata so `native_lowering.sfn` can preserve default
  values while emitting executable Python scaffolding (validated by
  `bootstrap/tests/test_compiler_codegen.py::test_lower_native_pipeline_executes_function`).
  A companion prototype (`native_llvm_lowering.sfn`) translates return-only
  functions—including those with numeric parameters—into skeletal LLVM IR
  (see `bootstrap/tests/test_compiler_codegen.py::test_lower_native_to_llvm_emits_ir`
  and `::test_lower_native_handles_parameter_round_trip`), providing the first
  foothold toward real machine-code emission.

**Package Manager (`sfn`)**
- Bootstrap: Not implemented yet.
- Self-hosted prototype: Not implemented; behaviour lives in
  `docs/proposals/package-management.md`.

## Validation Coverage

- `make bootstrap-test` runs unit tests for lexer, parser, effect checker,
  code generation smoke tests, and executes every example under
  `examples/`.
- `examples/README.md` enumerates every runnable sample with its declared
  effects so capability requirements stay in sync with the bootstrap runtime.
- Compiler smoke tests ensure Sailfin sources under `compiler/src/` can be
  parsed by the bootstrap compiler and emitted to Python.
- No automated tests exist yet for registry interactions or CLI workflow
  beyond the bootstrap scripts.

## Active Workstreams

1. **Self-hosted bootstrap loop** — keep the Sailfin compiler sources compiling
  themselves without stage0 assistance while the new passes land (tracked via
  `bootstrap/tests/test_compiler_sources.py`).
2. **Semantic parity & diagnostics** — land name resolution, type analysis, and
  richer error reporting in Sailfin (`compiler/src/typecheck.sfn`, expanded
  `effect_checker.sfn`) so outputs match the Python toolchain.
3. **Native runtime & FFI** — swap the Python runtime stubs with Sailfin
  implementations plus minimal capability-aware bridges for filesystem, HTTP,
  model execution, and concurrency primitives.
4. **Registry integration** — wire manifest parsing and publish/resolve
  commands against `registry.sailfin.dev` once the self-hosted compiler stays
  green.

Track detailed milestones and sequencing in `docs/roadmap.md`. When a
feature graduates from prototype into stage0, update the table above and
trim related “planned” callouts from the spec and examples.
