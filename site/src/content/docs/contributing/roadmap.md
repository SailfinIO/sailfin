---
title: Roadmap
description: Sailfin's development roadmap toward 1.0 and beyond.
section: contributing
order: 4
---

## Overview

The roadmap covers what is needed for the 1.0 release and the work planned after launch. The canonical source is [`docs/roadmap.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/roadmap.md) in the repository.

Status icons: `✅` Done, `🔄` In Progress, `📋` Planned

---

## Release 1.0 Priorities

### 1. Compiler Stabilization (Build Pipeline)

- 📋 Eliminate the Python fixup script (`scripts/selfhost_native.py`) — every fixup must become a compiler fix in `compiler/src/*.sfn`
- 📋 Make `scripts/build.sh` the sole clean build path with no post-processing
- 📋 Pass `make check` using the shell driver with no Python fallbacks
- 📋 Stabilize control-flow LLVM lowering (`.loop` / `.if` / `.break` headers currently produce broken loop headers that unconditionally enter the body with no exit condition)

### 2. Language Feature Completeness

- 📋 `await` expression parsing and lowering
- 📋 `routine { }` block parsing and lowering
- 📋 `channel()` as the core concurrency primitive
- 📋 `spawn` expression
- 📋 Complete generic type inference
- 📋 Interface conformance validation with variance checks
- 📋 `Affine<T>` / `Linear<T>` move and consume enforcement (currently parsed but not enforced)
- 📋 Richer diagnostics — multi-span, severity levels, fix-it hints
- 📋 `--fix` workflow for automatically inserting missing effect annotations
- 📋 `gpu` and `rand` effect enforcement (currently parsed only)
- 📋 Hierarchical effect enforcement (`io.fs.read`, `net.http`, etc.)

### 3. Sailfin-Native Runtime (Hard 1.0 Prerequisite)

The C runtime under `runtime/native/` must be fully replaced before the 1.0 release.

- 📋 Execute the runtime migration plan (`docs/runtime_audit.md`)
- 📋 Finalize the Sailfin-native ABI spec (`docs/runtime_abi.md`)
- 📋 Port core runtime helpers: strings, arrays, exceptions, and type metadata
- 📋 Remove the C runtime once parity and performance gates are satisfied
- 📋 Ship Sailfin-native filesystem, HTTP, and clock adapters

### 4. Tooling and Developer Workflow

- 📋 Replace the `sfn` shell wrapper with a Sailfin-native CLI binary
- 📋 Remove Python tooling and scripts from the release pipeline
- ✅ Remove Python runtime shims

### 5. Release Pipeline Hardening

- 📋 Signed checksums and provenance metadata shipped with release artifacts
- 📋 Installer CI that validates `install.sh` against staging artifacts
- 📋 Only self-hosted compiler artifacts in build and release workflows

### 6. Documentation

- ✅ Align README, status, roadmap, and spec with compiler reality
- 🔄 Expand site docs to production-quality coverage
- 📋 Remove legacy compiler-stage references from docs and examples

---

## Post-1.0 — AI / Model Execution

AI-native features are fully designed and specified; they ship after 1.0 as the first major milestone once a stable self-hosted toolchain is in place.

- 📋 Model runtime — `Model<I,O>.call()` execution with provider adapters
- 📋 Generation cards — signed provenance metadata for every model call (input hashes, cost, latency, seed)
- 📋 Prompt dispatch pipeline (`system` → `user` → `assistant` → `tool`)
- 📋 Tool dispatcher with capability and taint enforcement
- 📋 Typed prompt channels (`prompt user<SummaryRequest> { }`)
- 📋 Evaluators (`Faithfulness`, `LatencyBudget(150ms)`, etc.)
- 📋 `PII<T>` / `Secret<T>` runtime taint tracking and egress guards
- 📋 Model evaluators, replay, and golden tests
- 📋 Sailfin-native model adapters (HTTP / gRPC for model providers)

---

## Post-1.0 — Platform and Ecosystem

- 📋 Async runtime — Sailfin-native event loop, task scheduler, and channels
- 📋 Runtime diagnostics — structured tracing and allocation telemetry
- 📋 Package registry workflow — `sfn init`, `sfn add`, `sfn publish`, registry auth and artifact signing
- 📋 Native test framework — golden, adversarial, and replay test types in `sfn test`
- 📋 Tensor / GPU effects — `Vector<N>`, `Tensor<Shape, DType>`, GPU batching
- 📋 `|>` pipeline operator with async and lazy semantics

---

## Exploration Backlog

Items in the backlog are under consideration but have no committed milestone.

- 📋 WebAssembly emission
- 📋 `unsafe` capability enforcement
- 📋 Currency literals (`$0.05`) and time literals (`1s`, `150ms`)
- 📋 Notebook, LSP, and interactive tooling with cost and latency overlays
- 📋 Training workflow (see `docs/proposals/model-engines-and-training.md`)

---

## How to Contribute to the Roadmap

Open an issue or start a discussion in a pull request. Tag it with the appropriate milestone label so it can be triaged against the 1.0 scope. Major design changes that affect the language or ABI should reference a written proposal in `docs/proposals/` before implementation begins. This keeps design decisions traceable and reviewable independently of the code changes that follow.
