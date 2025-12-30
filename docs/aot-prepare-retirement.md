# AOT Prepare Retirement Plan

Purpose: remove `compiler/src/aot_prepare.sfn` by making the compiler and link
pipeline produce link-safe LLVM IR without text rewrites.

Context
- Today, stage2 AOT builds generate per-module LLVM IR, then run a text pass to
  rename duplicate symbols, rename `@main`, and inject missing intrinsic
  declarations.
- This is a stopgap for missing compiler/linker ownership of symbol identity and
  intrinsic emission.

Goals
- All emitted IR is linkable without text rewriting.
- Symbol identity is stable and deterministic across modules.
- Intrinsics used by a module are always declared in that module.

Non-goals
- Changing user-facing language semantics.
- Rewriting the entire codegen backend in one step.

Phases

1) Establish deterministic symbol ownership and namespacing
- Add a module/capsule-aware mangling scheme for functions and globals that are
  intended to be public across modules.
- Ensure local-only items are emitted with internal/private linkage so they do
  not collide at link time.
- Add a compiler flag or debug mode that emits a per-module symbol inventory
  (public vs private) to verify ownership decisions.

2) Make intrinsic declarations a first-class codegen responsibility
- Centralize intrinsic usage tracking in the LLVM emitter.
- Emit required `declare`s in each module that references intrinsics (e.g.
  `@round`) before codegen completes.
- Add tests that compile single modules with intrinsic calls and verify the
  emitted IR has matching `declare`s.

3) Replace text-based merging with proper module linking
- Prefer a single-module compilation path for stage2 AOT (one IR module in
  memory).
- If multi-module output remains necessary, adopt LLVM’s linker (or LTO) to
  merge modules programmatically, preserving linkage/visibility rules.
- Update the AOT pipeline to use the linker output instead of string rewriting.

4) Remove `aot_prepare` from the bootstrap/self-host flows
- Delete `compiler/src/aot_prepare.sfn` and remove calls in:
  - `scripts/bootstrap_stage2.py`
  - `scripts/selfhost_native_stage2.py`
- Update any tests in `compiler/tests/` that reference `aot_prepare`.

Acceptance Criteria
- Stage2 AOT build succeeds without `aot_prepare` in the pipeline.
- No duplicate symbol collisions across the compiler module set.
- Intrinsic calls compile without toolchain-specific errors.

Risks and Mitigations
- Risk: unexpected symbol collisions in third-party or runtime modules.
  Mitigation: add a symbol inventory report and CI checks for duplicates.
- Risk: ABI changes from new mangling scheme.
  Mitigation: scope mangling to internal compiler modules first; document any
  changes needed in `docs/status.md` when behavior shifts.

Suggested Sequencing
- Start with intrinsic declaration hygiene (smallest, most isolated change).
- Implement mangling/linkage rules next (largest behavior surface).
- Switch to linker-based merging, then remove `aot_prepare`.

Documentation Updates
- Update `docs/status.md` once the AOT pipeline no longer uses
  `compiler/src/aot_prepare.sfn`.
- If symbol mangling rules are user-visible, update `docs/spec.md`.
