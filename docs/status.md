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
  `runtime_support.py`.
- Self-hosted prototype: Produces Python scaffolding with block stubs; emitter
  coverage is expanding iteratively and now lowers simple lambda expressions to
  Python `lambda` literals (multi-statement lambdas still fall back to stubs).

**Package Manager (`sfn`)**
- Bootstrap: Not implemented yet.
- Self-hosted prototype: Not implemented; behaviour lives in
  `docs/proposals/package-management.md`.

## Validation Coverage

- `make bootstrap-test` runs unit tests for lexer, parser, effect checker,
  code generation smoke tests, and executes every example under
  `examples/`.
- Compiler smoke tests ensure Sailfin sources under `compiler/src/` can be
  parsed by the bootstrap compiler and emitted to Python.
- No automated tests exist yet for registry interactions or CLI workflow
  beyond the bootstrap scripts.

## Active Workstreams

1. **Parser & AST parity** — close gaps between bootstrap and Sailfin
   parsers to unlock full round-trip coverage (see `compiler/src/parser.sfn`).
2. **Effect system expansion** — extend validators to recognize filesystem
   and network helpers beyond `fs/http/websocket`, and carry capability data
  from manifests when available.
3. **Registry integration** — wire manifest parsing and publish/resolve
   commands against `registry.sailfin.dev`.
4. **Native runtime** — replace mocked I/O with effect-aware adapters and
   async scheduling in Sailfin code.

Track detailed milestones and sequencing in `docs/roadmap.md`. When a
feature graduates from prototype into stage0, update the table above and
trim related “planned” callouts from the spec and examples.
