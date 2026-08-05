# Sailfin Enhancement Proposals (SFEPs)

This directory holds **SFEPs** — the design records for Sailfin's language,
runtime, and toolchain. An SFEP captures a forward-looking design decision: the
*why* behind a change, cited from code, commits, and the spec.

- **New to the process?** Read [SFEP-0001 — SFEP Purpose and Process](./0001-sfep-process.md).
- **Writing one?** Copy [`template.md`](./template.md), fill every section, open a PR.
- **What is *not* an SFEP** (conventions, RCAs, runbooks, living trackers): see
  the decision tree in SFEP-0001 §1.

This table is the **registry** — the source of truth for which numbers are taken.
The next number is `max + 1`. Add a row in the same PR that introduces an SFEP.

## Status legend

`Draft` (in review) · `Accepted` (approved, may be partially built) ·
`Implemented` (shipped end-to-end + self-hosting) · `Withdrawn` · `Rejected` ·
`Superseded`. See SFEP-0001 §4 for the full lifecycle and the bar for
`Implemented`.

## Index

| SFEP | Title | Status | Type |
|---|---|---|---|
| [0001](./0001-sfep-process.md) | SFEP Purpose and Process | Accepted | process |
| [0002](./0002-package-management.md) | Capsule Distribution and the Registry Protocol | Accepted | tooling |
| [0003](./0003-tooling.md) | The Toolchain Surface and Its Output Contracts | Accepted | tooling |
| [0004](./0004-check-architecture.md) | `sfn check` — Fast Analysis Without Codegen | Implemented | tooling |
| [0005](./0005-colon-type-annotations.md) | Colon Type Annotations | Implemented | language |
| [0006](./0006-build-architecture.md) | Unified Build Architecture | Implemented | tooling |
| [0007](./0007-fmt-architecture.md) | `sfn fmt` — Canonical Formatter | Implemented | tooling |
| [0008](./0008-effect-validation.md) | Effect Validation as Build Gate | Implemented | language |
| [0009](./0009-cli-modularization-epic.md) | CLI Modularization | Superseded | tooling |
| [0010](./0010-test-infra/00-overview.md) | Sailfin-Native Test Infrastructure | Accepted | tooling |
| [0011](./0011-ci-test-speed.md) | CI Test-Speed Plan | Accepted | tooling |
| [0012](./0012-result-and-question-operator.md) | `Result<T, E>` and the `?` Operator | Implemented | language |
| [0013](./0013-host-aware-exe-path-intrinsic.md) | Host-Aware `exe_path` Intrinsic | Implemented | runtime |
| [0014](./0014-agent-output-orchestration.md) | Agent-Legible Build/Test Output | Accepted | tooling |
| [0015](./0015-llvm-independence.md) | Toolchain Independence — Sailfin-Native Backend | Accepted | runtime |
| [0016](./0016-capability-sealed-runtime.md) | The Capability-Sealed Runtime — Effects Enforced to the Syscall | Accepted | runtime |
| [0017](./0017-hierarchical-effects.md) | Hierarchical Sub-Effects as Subsumption | Implemented | language |
| [0018](./0018-borrow-checking-1.0.md) | Borrow / Ownership Checking for the Native Runtime | Accepted | runtime |
| [0019](./0019-sfn-http-capsule.md) | `sfn/http` — Typed HTTP Surface | Implemented | tooling |
| [0020](./0020-compiler-decomposition.md) | Role-Oriented Compiler Capsules | Accepted | tooling |
| [0021](./0021-windows-native-selfhost.md) | Native Windows Self-Host (MSVC ABI) | Accepted | runtime |
| [0022](./0022-darwin-memory-governor.md) | Darwin (macOS arm64) Memory Governor | Accepted | runtime |
| [0023](./0023-capsule-decorators.md) | Capsule-Defined Decorators | Accepted | language |
| [0024](./0024-model-engines-and-training.md) | Model Engines, Adapters, Tensors, Training | Superseded | informational |
| [0025](./0025-native-runtime-architecture.md) | Native Runtime Architecture | Implemented | runtime |
| [0026](./0026-delivery-process.md) | Delivery Process — Drift-Tolerant Issues, Seed Discovery, Release Cadence | Accepted | process |
| [0027](./0027-cli-rss-modularization.md) | CLI Modularization — Per-Worker RSS Relief First, Then Migration | Implemented | tooling |
| [0028](./0028-typed-array-higher-order-fns.md) | Typed / Generic-Element Array Higher-Order Functions (map / filter / reduce) | Draft | language |
| [0029](./0029-lambda-syntax.md) | Lambda expression syntax for 1.0 — keep, reform, or defer | Implemented | language |
| [0030](./0030-first-class-function-values.md) | First-Class Function Values | Accepted | language |
| [0031](./0031-inline-export-decl.md) | Inline `export <declaration>` syntax | Implemented | language |
| [0032](./0032-untyped-lambda-param-inference.md) | Infer Untyped Lambda Parameter/Return Types from the Call Site | Implemented | language |
| [0033](./0033-string-runtime-length-aware-abi.md) | Length-aware ({i8*, i64}) ABI for query-side string runtime helpers | Implemented | runtime |
| [0034](./0034-is-type-guard.md) | Structured, Enforced `x is T` Type-Guard Operator | Accepted | language |
| [0035](./0035-prelude-mirror-signature-derivation.md) | Deriving Prelude-Mirror Registry Signatures from the Prelude | Implemented | runtime |
| [0036](./0036-tls-runtime.md) | TLS termination + upstream TLS for the native runtime (OpenSSL) | Implemented | runtime |
| [0037](./0037-peer-language-process-adoption.md) | Peer-Language Process Adoption — Merge Queue, ICE Discipline, Perf History, Corpus Runs | Accepted | process |
| [0038](./0038-generic-constraints.md) | Generic Type Parameter Constraints and Monomorphization | Implemented | language |
| [0039](./0039-nominal-object-model.md) | Nominal Object Model — Honest Rejection of TypeScript-Shaped Data Syntax | Implemented | language |
| [0040](./0040-artifact-cache.md) | Global Artifact Cache Store and Garbage Collection | Implemented | tooling |
| [0041](./0041-typeck-expected-type-context.md) | Unified expected-type + typing-environment context for the typecheck walk | Implemented | tooling |
| [0042](./0042-nested-function-declarations.md) | Nested / Local Function Declarations (non-capturing static `fn` items) | Implemented | language |
| [0043](./0043-phase-scoped-arena-reclamation.md) | Phase-scoped arena reclamation to reduce per-module peak RSS | Implemented | runtime |
| [0044](./0044-test-runner-invocation-cache.md) | Invocation-scoped runtime identity + in-process sha256 for the test runner | Implemented | tooling |
| [0045](./0045-shared-frontend-test-runner.md) | Shared-frontend test runner — parent compiles, children only execute | Draft | tooling |
| [0046](./0046-toolchain-pinning.md) | Native Toolchain Version Pinning + Dispatch | Accepted | tooling |
| [0047](./0047-compiler-bootstrap-manifest.md) | Compiler Bootstrap Manifest | Implemented | tooling |
| [0048](./0048-native-crypto.md) | Native Crypto + TLS Stack — Removing the OpenSSL Dependency | Accepted | runtime |
| [0049](./0049-concurrency-effect-transparency.md) | Effect-transparency for concurrency-primitive leaves (spawn / parallel / channel send·receive) | Implemented | language |
| [0050](./0050-streamed-test-ipc.md) | Streamed per-test results over a captured pipe (retiring results.log/fail.bin) | Implemented | tooling |
| [0051](./0051-workspace-manifest.md) | Workspace Manifest — Multi-Capsule Policy and the Capability Envelope | Accepted | tooling |
| [0052](./0052-ml-acceleration-strategy.md) | Accelerated ML — Substrate Interop and Capability-Typed Accelerator Programming | Accepted | informational |
| [0053](./0053-shape-typed-tensor-ir.md) | Shape-Typed Tensor IR and Fusion | Accepted | tooling |
| [0054](./0054-low-precision-numerics.md) | Low-Precision Numeric Substrate | Accepted | language |
| [0055](./0055-typed-task-handles.md) | Typed task handles (`Task<T>`) and ordered multi-await (`join_all`) | Implemented | language |
| [0056](./0056-aarch64-linux-target.md) | aarch64-Linux Target Support (Raspberry Pi Install + On-Device Self-Host) | Accepted | runtime |
| [0057](./0057-string-interpolation-dollar.md) | String Interpolation with `${ }` (migrating off `{{ }}`) | Implemented | language |
| [0058](./0058-sized-integer-types.md) | Sized Integer Types and Overflow Semantics | Accepted | language |
| [0059](./0059-typed-ssa-activation.md) | Typed SSA Activation — Making the Metadata IR Load-Bearing | Accepted | tooling |
| [0060](./0060-owned-syscall-layer.md) | The Owned Syscall Layer (Axis 3, tier-1 Linux x86-64) | Accepted | runtime |
| [0061](./0061-diagnostic-unification.md) | Diagnostic Unification — One Coded, Spanned, Severity-Bearing Diagnostic | Accepted | tooling |
| [0062](./0062-numerical-contracts.md) | Numerical and Behavioural Contracts (the Result Pillar) | Accepted | language |
| [0063](./0063-sync-capsule.md) | `sfn/sync` — scope and blocking predecessor for a synchronization capsule | Accepted | language |
| [0064](./0064-reclamation-seam.md) | Generic resource-reclamation seam | Draft | runtime |
| [0065](./0065-sync-capsule-api.md) | `sfn/sync` — public API surface and semantics | Draft | language |

## Drafts under review (numbers assigned at merge)

Per SFEP-0001 §2, a draft keeps its `draft-<slug>.md` name and `sfep: TBD`
front-matter until it merges, at which point it claims `max + 1` and gets an
Index row. Two slates are in review.

**Language gaps surfaced by the 2026-07 grammar/object-model audit:**

| Draft | Title | Type |
|---|---|---|
| [`draft-generic-collections`](./draft-generic-collections.md) | Generic Collections — Map, Set, and Tuple | language |
| [`draft-interface-signature-conformance`](./draft-interface-signature-conformance.md) | Signature-Checked Interface Conformance | language |
| [`draft-exhaustive-match`](./draft-exhaustive-match.md) | Compile-Time Match Exhaustiveness Checking | language |
| [`draft-derive`](./draft-derive.md) | Derivable Interface Implementations (`@derive`) | language |
| [`draft-nullable-access-operators`](./draft-nullable-access-operators.md) | Nullable Access Operators (`?.` and `??`) | language |
| [`draft-import-surface-compaction`](./draft-import-surface-compaction.md) | Import-surface compaction across the phase rewind to cut emit peak RSS | runtime |
| [`draft-concurrency-cancellation`](./draft-concurrency-cancellation.md) | Concurrency runtime maturity — cancel-on-fault and async I/O | runtime |

The **capability-seal critical path** designs graduated out of this slate on
2026-07-25 and now hold Index rows: SFEP-0059 (typed SSA activation) and
SFEP-0060 (the owned syscall layer). Both are implementation designs under
SFEP-0015 (*what*) and SFEP-0016 (*why*), and both amended their parents rather
than standing alone — SFEP-0059 §3.3–3.4 closed two gaps in the normative
SFEP-0015 §9 contract (no conversion instruction; no producer input for
capability atoms), and SFEP-0060 §2.2 named three holes now recorded as
SFEP-0016 §8.1 (`getaddrinfo`, `popen`, and OpenSSL's own syscall paths).

SFEP-0038 (`0038-generic-constraints.md`, Implemented) is the root foundation:
`draft-generic-collections`, `draft-derive`, and SFEP-0028 all depend on it. Draft diagnostic codes are
pre-deconflicted (`E0303`; `E0711`–`E0715`; `E0820`–`E0822`; `E0823`/`W0823`;
`E0824`–`E0825`; `E0836`–`E0838` — typed task handles, SFEP-0055).
`E0826` is allocated (shipped) — bare function-type annotation rejection
(#1845, SFEP-0030) — so drafts must skip it.

SFEP-0062 (numerical contracts) opens a **new `E11xx` range** —
`E1100`–`E1114` — rather than extending `E09xx`. `E09xx` is owned by
ownership/affine types with `E0910`–`E0915` already reserved by SFEP-0054, and
`E08xx` is nearly exhausted (`E0801`–`E0838`). A repo-wide
`rg -o --no-filename '[EW][0-9]{4}' compiler runtime docs site | sort -u` found
`E1001` and `E1003` as the only `E1xxx` codes in use, so `E11xx` is entirely
free and gets its own home, `compiler/src/contract/`. Drafts must skip
`E1100`–`E1114`.

## Subdirectories

- [`design-notes/`](./design-notes/) — single-issue implementation design gates.
  Not SFEPs; kept for the record (see SFEP-0001 §9).
- [`archive/`](./archive/) — superseded, rejected, or stale historical notes.
  Nothing here is a live SFEP.
