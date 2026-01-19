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

3. **Runtime stability for 1.0**
   - [ ] Define and document the C runtime surface that will be treated as stable for 1.0.
   - [ ] Audit intrinsic coverage and ensure parity tests exist for strings, arrays, and exceptions.
   - [ ] Document capability adapter behavior and platform requirements in `docs/runtime_audit.md`.

4. **Tooling and developer workflow**
   - [ ] Replace the current `sfn` shell wrapper with a Sailfin-native CLI binary.
   - [ ] Add Python-free CI guardrails that fail when runtime shims are invoked.
   - [ ] Provide a dedicated `make test-native` target and keep `make test` stable for release.

5. **Documentation for public release**
   - [ ] Remove legacy compiler-stage references across docs and examples.
   - [ ] Refresh `docs/spec.md` and `docs/keywords.md` to reflect shipped syntax.
   - [ ] Ensure `docs/status.md` and `README.md` match installer defaults and CLI usage.

## Post-1.0 (Immediate Follow-On)

- [ ] **Native runtime implementation** — Execute the Sailfin runtime migration plan in `docs/runtime_audit.md`.
  - [ ] Implement the Sailfin-native ABI and versioned layouts.
  - [ ] Port core runtime helpers (strings, arrays, exceptions, type metadata).
  - [ ] Remove the C runtime once parity and performance gates are satisfied.
- [ ] **Native capability adapters** — Replace Python adapters with Sailfin-native modules for filesystem, HTTP, and model invocation.
- [ ] **Async runtime** — Ship a Sailfin-native event loop, task scheduler, and channel primitives once coroutine lowering is stable.
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
