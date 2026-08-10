# SFN-428 — Design note: the `![gpu]` capability gate and its dispatch primitive

Single-issue implementation design gate for SFN-428. Design brief: SFEP-0052
§3.2/§4 (Track B, first enforcement). This note is the *what and why*; the issue
body is the session-sized *what*.

## 1. Goal

Make `![gpu]` a real, enforced capability gate by shipping the first
user-reachable device-dispatch surface that carries it — without asserting a GPU
backend that does not exist, and without retroactively requiring `![gpu]` of any
existing CPU-only capsule.

## 2. Current state (verified 2026-07-24)

- `gpu` is in `canonical_effects()` (`compiler/src/effect_taxonomy.sfn:30`) and
  flows through `is_canonical_effect` / `effect_root` / `is_recognized_effect` /
  `effect_subsumes`. It has **zero** other mentions in `compiler/src` or
  `runtime/` — no special-casing, no suppression.
- Every shipped detector is registry-driven:
  `effects_for_callee_target(target)` (`compiler/src/llvm/runtime_helpers.sfn:1778`)
  resolves an exact `RuntimeHelperDescriptor` row first, then namespace-unions.
  The `"Member"` branch of `collect_effects_from_expression`
  (`compiler/src/effect_checker.sfn:1480-1521`) feeds `root + "." + member` into
  it, so a `ns.method()` builtin needs no `effect_checker.sfn` edit.
- Cross-module propagation is signature-driven
  (`compiler/src/effect_imports.sfn`, `_propagate_imported_callee_effects` at
  `effect_checker.sfn:1272`); `E0400` in-module, `E0402` cross-module, `E0403`
  manifest, `E0404` unrecognized root. The structured fix-it
  (`_suggestion_for_missing_effect`, `diagnostics_render.sfn:154-169`) and the
  `suggestion: add ![...] to the function signature` message line are generic
  over the effect name.
- **`rand` is the shipped precedent for exactly this problem.** `![rand]` was
  flipped from reserved to Enforced with *no* compiler change: the effect is
  declared on one public capsule function (`capsules/sfn/crypto/src/rand.sfn:40`,
  `fn random_bytes(n: int) -> int[] ![rand]`), the raw runtime primitive is an
  effect-free `extern`, and existing propagation does the rest. Pinned by
  `compiler/tests/e2e/rand_effect_gate_test.sfn`. `docs/status.md:504` documents
  the honest scope ("only `random_bytes` carries the effect — there is still no
  auto call-name detector").
- Tensor IR (`compiler/capsules/ir/src/tensor_ir.sfn`, SFN-427) exists but is **unreachable
  from the pipeline**: `main.sfn` never imports it, `typed_ssa.sfn` only mentions
  it in comments, and `tensor_ir_link_harness.sfn` is test-only. No AST construct
  produces a `TensorFunction`.
- `capsules/sfn/{tensor,nn}/capsule.toml` declare `required = ["gpu"]`
  aspirationally; no function in either declares an effect.
  `validate_capsule_capabilities` (`effect_checker.sfn:567`) treats `required` as
  a *ceiling* (skip when empty), so those manifests are currently inert.

## 3. Decisions

### D1 — Dispatch surface: an `![gpu]`-annotated export of a new `sfn/device` capsule

Rejected: **a `device.*` builtin namespace** registered in
`runtime_helper_descriptors()`. Three reasons, in priority order:

1. **False positives.** The Member branch is *not* scope-resolved (see the #1184
   comment at `effect_checker.sfn:1409-1419`): the detector keys on the literal
   object identifier. `device` is a highly plausible user variable name
   (`let device = open(...); device.close()`), so a builtin `device` namespace
   would demand `![gpu]` of unrelated user code. `fs`/`http`/`websocket` got away
   with this; `device` will not.
2. **"Libraries over keywords."** A builtin namespace root is nearly a keyword —
   it can never be a call-site receiver name again. The eventual device surface
   must be a *typed* API (device handles, streams, memory), which is a library,
   not a global namespace.
3. **It is the wrong long-term seam.** When the Track-A tensor frontend lands,
   tensor ops will be typed capsule functions; the effect will ride on their
   declarations and propagate. A builtin namespace would be a second, parallel
   mechanism to reconcile later.

Chosen: a new `sfn/device` capsule whose dispatch entry points declare `![gpu]`.
Enforcement rides on the existing cross-module propagation — the same mechanism,
tests, diagnostics, and fix-it that made `rand` enforced. **This requires zero
`compiler/src` changes.**

### D2 — Runtime backing: a real CPU reference kernel, honestly labelled

The backend is CPU-only (SFEP-0052 §2.1). The dispatch entry point therefore runs
a **pure-Sailfin CPU reference kernel** inside the capsule. No `extern`, no
runtime symbol, no descriptor row, no LLVM lowering — so there is nothing that
can claim a device exists.

The honesty is carried by the API itself, not only by prose: `sfn/device` exports
`backends() -> ["cpu"]` and `has_accelerator() -> false`, so a program can
*observe* at runtime that no accelerator is present. `![gpu]` is documented as
**the capability to dispatch work to a device backend**, not a claim that an
accelerator exists.

The load-bearing justification for gating now rather than later: `gpu` was
reserved in the taxonomy precisely so the effect surface stays stable
(`effect_taxonomy.sfn:14-15`). If the gate lands *after* a CUDA backend, every ML
program written in between needs an annotation migration. Gating a CPU-reference
backend is a deliberate over-approximation — the safe direction for a capability
system, and the same direction the checker's namespace-union fallback already
takes.

`sfn/device` must **not** be depended on by `sfn/tensor`/`sfn/nn`/`sfn/layers`.
Those stay CPU-only and effect-free. The layering is `tensor → device` in the
future, never `device → tensor`, so `sfn/device` carries its own kernel.

Rejected: a higher-order `dispatch<T>(work: fn() -> T) ![gpu]` placement scope.
Effect polymorphism is not shipped, so `work`'s own effects would be silently
dropped — an unfinished safety claim.

### D3 — Tensor-IR device axis: speculative, do NOT add

A `Device` field on `TensorOp`/`TensorFunction` is **not load-bearing** for any
SFN-428 acceptance criterion. The criteria are about the effect diagnostic; the
diagnostic is produced by an AST-level walk, and no AST construct reaches
`tensor_ir.sfn` today. A device axis added now would be dead metadata that
constrains SFEP-0053's design before its frontend exists. Add it when a tensor
frontend and a second backend make placement observable.

### D4 — Hard constraints

| Constraint | Status |
|---|---|
| No retroactive `![gpu]` on `sfn/tensor`/`sfn/nn`/`sfn/layers` | Satisfied — they are untouched and gain no dependency on `sfn/device`. |
| `make compile` self-hosts; compiler stays non-`![gpu]` | Satisfied — zero `compiler/src` changes; the compiler never imports `sfn/device`. |
| Effect lists alphabetical | Satisfied — every new annotation is the single effect `![gpu]`. |
| No new E-code from a used range | Satisfied — **no new E-code**. Reuses `E0400` (in-module transitive) / `E0402` (cross-module import) / `E0403` (manifest). |
| `![model]` out of scope | Satisfied — not touched. The mechanism generalizes verbatim: `sfn/ai` will declare `![model]` on its engine entry points post-1.0. |

## 4. Consequence for the seed

Zero `compiler/src` changes ⇒ **no seed dependency and no seed cut**. The
capability and its consumer are the same PR by construction.

## 5. References

- SFEP-0052 §3.2, §4 — Track B, first enforcement.
- SFEP-0017 — hierarchical sub-effects (a future `gpu.cuda` refines under `gpu`
  by subsumption; no taxonomy change needed).
- `compiler/tests/e2e/rand_effect_gate_test.sfn` — the precedent test shape.
- `docs/status.md:504` — the precedent status wording.
