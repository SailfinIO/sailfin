# Sailfin Roadmap

Updated: January 19, 2026  
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. The focus is the 1.0 public release and the immediate
work after launch. Legacy compiler stages are no longer tracked in this plan.

## Release 1.0 Priorities (Do Now)

1. **Release pipeline and distribution hardening**
   - [ ] Publish signed checksums and provenance metadata alongside release artifacts.
   - [ ] Add installer CI that validates `install.sh` against staging artifacts.
   - [ ] Document artifact layout, supported platforms, and upgrade expectations in `docs/README.md`.
   - [ ] Verify build/release workflows only use self-hosted compiler artifacts.

2. **Compiler stability and diagnostics**
   - [ ] Complete generic type inference for functions, structs, and enums.
   - [ ] Finish interface conformance validation, including variance checks.
   - [ ] Implement richer diagnostics (multi-span snippets, severity, suggested fixes).
   - [ ] Add `--fix` workflow for missing effect annotations with safe rewrite guards.

3. **Sailfin-native runtime for 1.0**
   - [ ] Execute the Sailfin runtime migration plan in `docs/runtime_audit.md`.
   - [ ] Finalize the Sailfin-native ABI spec in `docs/runtime_abi.md`.
   - [ ] Implement the Sailfin-native ABI and versioned layouts.
   - [ ] Define the runtime ownership/memory model and update lowering to match.
   - [ ] Port core runtime helpers (strings, arrays, exceptions, type metadata).
   - [ ] Replace the current exception plumbing with a structured model supported by the native runtime.
   - [ ] Remove the C runtime once parity and performance gates are satisfied.
   - [ ] Ship Sailfin-native filesystem, HTTP, and model adapters.
   - [ ] Document capability adapter behavior and platform requirements in `docs/runtime_audit.md`.

4. **Tooling and developer workflow**
   - [ ] Replace the current `sfn` shell wrapper with a Sailfin-native CLI binary.
   - [ ] Replace the C `native_driver` with a Sailfin-native CLI entrypoint.
   - [ ] Remove Python tooling/scripts from the release pipeline and developer entrypoints.
   - [x] Remove Python runtime shims (`runtime/runtime_support.py`, `runtime/native_runner*.py`).
   - [ ] Remove Python-generated compiler artifacts (`compiler/build/**`) from the 1.0 toolchain.

5. **Documentation for public release**
   - [ ] Remove legacy compiler-stage references across docs and examples.
   - [ ] Refresh `docs/spec.md` and `docs/keywords.md` to reflect shipped syntax.
   - [ ] Ensure `docs/status.md` and `README.md` match installer defaults and CLI usage.

## Post-1.0 (Immediate Follow-On)

- [ ] **Async runtime** — Ship a Sailfin-native event loop, task scheduler, and channel primitives once coroutine lowering is stable.
- [ ] **Runtime diagnostics** — Add structured tracing, allocation telemetry, and performance profiling hooks.
- [ ] **Package registry workflow** — Finalize manifests, implement `sfn init/add/publish`, and stand up registry auth/signing.
- [ ] **Native test framework** — Replace pytest suites with Sailfin-native tests and CI reporting.

## Exploration Backlog (Research / Design)

- [ ] WebAssembly emission once LLVM backend coverage is complete.
- [ ] `unsafe` capability design for explicit FFI boundaries.
- [ ] Model engines & training workflow (see `docs/proposals/model-engines-and-training.md`).
- [ ] Tensor/GPU effects and `Tensor<T>` primitives.
- [ ] Notebook, LSP, and interactive tooling.

## Completed Items

Completed work is tracked in `docs/status.md` and release notes in `CHANGELOG.md`.
