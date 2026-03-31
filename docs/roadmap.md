# Sailfin Roadmap

Updated: March 31, 2026
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. The focus is the 1.0 public release and the work after
launch. Legacy compiler stage references are no longer tracked in this plan.

## Release 1.0 Priorities (Do Now)

The 1.0 release requires a **fully self-hosted toolchain with no Python scripts
or C runtime**. All items below are hard requirements, not stretch goals.

1. **Compiler stabilization (build pipeline)**
   - [ ] Eliminate the Python fixup script (`scripts/selfhost_native.py`) as a
         build requirement. Every fixup it applies must become a compiler fix in
         `compiler/src/*.sfn`.
   - [ ] Make `scripts/build.sh` the sole clean build path (no post-processing).
   - [ ] Pass `make check` using the shell driver: seedcheck binary compiles
         `examples/basics/hello-world.sfn` and passes the full test suite with no
         Python fallbacks.
   - [ ] Stabilize control-flow LLVM lowering (`.loop` / `.if` / `.break`
         headers) so the seedcheck binary does not hang.

2. **Language feature completeness**
   - [ ] Implement `await` expression parsing and lowering.
   - [ ] Implement `routine { }` block parsing and lowering (concurrent tasks).
   - [ ] Implement `channel()` as a concurrency primitive (not just prompt syntax).
   - [ ] Implement `spawn` expression.
   - [ ] Complete generic type inference for functions, structs, and enums.
   - [ ] Finish interface conformance validation, including variance checks.
   - [ ] Enforce `Affine<T>` / `Linear<T>` move and consume rules.
   - [ ] Implement richer diagnostics (multi-span snippets, severity, suggested fixes).
   - [ ] Add `--fix` workflow for missing effect annotations with safe rewrite guards.
   - [ ] Enforce `gpu`, `rand`, and hierarchical effect names (`io.fs`, `net.http`).

3. **Sailfin-native runtime (hard 1.0 prerequisite)**
   - The C runtime (`runtime/native/`) must be replaced by a Sailfin-native
     runtime before 1.0. This is a breaking change and the right moment to make
     it is at 1.0, not after.
   - [ ] Execute the Sailfin runtime migration plan in `docs/runtime_audit.md`.
   - [ ] Finalize the Sailfin-native ABI spec in `docs/runtime_abi.md`.
   - [ ] Implement the Sailfin-native ABI and versioned layouts.
   - [ ] Define the runtime ownership/memory model and update lowering to match.
   - [ ] Port core runtime helpers (strings, arrays, exceptions, type metadata).
   - [ ] Replace exception plumbing with a structured model in the native runtime.
   - [ ] Remove the C runtime once parity and performance gates are satisfied.
   - [ ] Ship Sailfin-native filesystem, HTTP, and clock adapters.
   - [ ] Document capability adapter behavior and platform requirements in
         `docs/runtime_audit.md`.

4. **Tooling and developer workflow**
   - [ ] Replace the current `sfn` shell wrapper with a Sailfin-native CLI binary.
   - [ ] Replace the C `native_driver` with a Sailfin-native CLI entrypoint.
   - [ ] Remove Python tooling/scripts from the release pipeline and developer
         entrypoints entirely.
   - [x] Remove Python runtime shims (`runtime/runtime_support.py`,
         `runtime/native_runner*.py`).
   - [ ] Remove Python-generated compiler artifacts from the 1.0 toolchain.

5. **Release pipeline and distribution hardening**
   - [ ] Publish signed checksums and provenance metadata alongside release artifacts.
   - [ ] Add installer CI that validates `install.sh` against staging artifacts.
   - [ ] Document artifact layout, supported platforms, and upgrade expectations.
   - [ ] Verify build/release workflows only use self-hosted compiler artifacts.

6. **Documentation for public release**
   - [ ] Remove legacy compiler-stage references across docs and examples.
   - [ ] Refresh `docs/spec.md` and `docs/keywords.md` to reflect shipped syntax.
   - [ ] Ensure `docs/status.md` and `README.md` match installer defaults and CLI usage.

## Post-1.0 — AI / Model Execution (First Major Follow-On)

The AI-native features are central to Sailfin's design and fully specified, but
require a stable self-hosted runtime and toolchain as a foundation. They ship
after 1.0 as the first major milestone.

- [ ] **Model runtime** — implement `Model<I, O>.call()` execution; wire `model`
      blocks to provider adapters (OpenAI-compatible, local, etc.).
- [ ] **Generation cards** — produce signed provenance metadata (engine, params,
      seeds, input hashes, latency, cost) for every model call.
- [ ] **Prompt dispatch** — implement the prompt channel execution pipeline
      (`system` → `user` → `assistant` → `tool`).
- [ ] **Tool dispatcher** — implement model-invocable typed capabilities with
      capability and taint policy enforcement before execution.
- [ ] **Typed prompt channels** — `prompt user<SummaryRequest> { }` with
      shape-checked prompts.
- [ ] **Evaluators** — `Faithfulness`, `LatencyBudget(...)`, and the evaluator
      suite framework.
- [ ] **`PII<T>` / `Secret<T>` enforcement** — runtime taint tracking, egress
      guards, and redaction transformers.
- [ ] **Model evaluators and replay** — golden tests, adversarial suites,
      generation card replay.
- [ ] **Sailfin-native model adapters** — HTTP/gRPC adapters for model providers.

## Post-1.0 — Platform and Ecosystem

- [ ] **Async runtime** — ship a Sailfin-native event loop, task scheduler, and
      channel primitives once coroutine lowering is stable (builds on the 1.0
      concurrency work).
- [ ] **Runtime diagnostics** — structured tracing, allocation telemetry, and
      performance profiling hooks.
- [ ] **Package registry workflow** — finalize manifests, implement
      `sfn init/add/publish`, and stand up registry auth/signing.
- [ ] **Native test framework** — golden/adversarial/replay workflows in
      `sfn test`; CI reporting.
- [ ] **Tensor/GPU effects** — `Vector<N>`, `Tensor<Shape, DType>`, GPU batching,
      and the `gpu` effect runtime.
- [ ] **`|>` pipeline operator** — implement parsing and lowering of the pipe
      operator; enable async/lazy pipelines with backpressure.

## Exploration Backlog (Research / Design)

- [ ] WebAssembly emission once LLVM backend coverage is complete.
- [ ] `unsafe` capability enforcement for explicit FFI boundaries.
- [ ] Currency literals (`$0.05`) and time literals (`1s`, `150ms`).
- [ ] Notebook, LSP, and interactive tooling with live cost/latency overlays.
- [ ] Training workflow (see `docs/proposals/model-engines-and-training.md`).

## Completed Items

Completed work is tracked in `docs/status.md` and release notes in `CHANGELOG.md`.
