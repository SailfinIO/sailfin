# Sailfin Roadmap

Updated: October 22, 2025  
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. Each section is designed so an agent can pull the next
actionable item, mark it complete, and move to the following bucket; creating new items as needed - this means that active workstreams need to be upated regularly.

## Active Workstreams (Do Now)

1. **Stage2 Production Launch**

_Near-term (flip to a self-hosted release pipeline and prep GA)_

- [ ] Self-hosted release pipeline

  - [ ] Promote the Stage2 bootstrap job to the primary release workflow so every merge runs the Stage2->Stage2 rebuild and archives the native artifacts.
  - [ ] Add a `stage2-build.yml` GitHub workflow that builds universal macOS (arm64 + x86_64) and Linux binaries, runs the Stage2 smoke suite, and uploads artifacts for downstream jobs.
    - [x] Initial workflow scaffolds Stage2 bootstrap/tests on macOS arm64, macOS x86_64, and Linux x86_64 runners and publishes packaged LLVM artifacts via `tools/package_stage2.py`.
  - [ ] Wire the workflow into `semantic-release` so version bumps publish Stage2 binaries, provenance metadata, and changelog entries in one pass.
  - [ ] Keep pytest-driven harnesses in CI while the Stage2 native test harness is rewritten; document the temporary dual-runtime strategy in `docs/status.md`.

- [ ] Installer and distribution hardening

  - [ ] Replace `scripts/install_stage1.py` with a curl-able `scripts/install.sh` that detects OS/arch, downloads the matching Stage2 binary, verifies checksums, and installs to `/usr/local/bin` (with override support).
  - [ ] Publish signed checksums alongside release artifacts and add a CI job that runs the installer against staging builds.
  - [ ] Update `README.md` and `docs/status.md` with new install flow, fallback guidance for contributors, and troubleshooting for unsupported platforms.

- [ ] Stage1 sunset guardrails

  - [ ] Keep `make compile-stage1` and the existing stage1 bootstrap only for bisecting until two consecutive Stage2 releases ship green; gate all other workflows on Stage2 self-host completion.
  - [ ] Add telemetry in CI to assert no release job invokes Stage1 binaries; fail the pipeline if Python codegen executes.
  - [ ] Once guardrails stay green for two release cycles, remove Stage1 workflows, archive docs to `Legacy/stage0/`, and update `docs/spec.md` + `docs/roadmap.md` to mark Stage1 deprecated.

- [ ] CI gating and signals

  - [ ] Add `.github/workflows/stage2-self-hosted.yml` that rebuilds the compiler with Stage2, runs the Stage2 smoke suite on every PR, and blocks merge on failure while Stage1 stays informational.
  - [ ] Update `.github/workflows/test.yml` (or successor) to fan out Stage1 + Stage2 jobs during transition, promoting Stage2 to required once parity holds for two release cycles.
  - [ ] Publish CI status badges in `README.md` that distinguish Stage2 self-hosting from legacy Stage1 coverage.
  - [ ] Configure branch protection to require the Stage2 self-hosted job and release workflow before tagging versions.

- [ ] Distribution packaging

  - [x] Introduce `tools/package_stage2.py` to package Stage2 LLVM artifacts with per-target metadata (tarballs for macOS arm64/x86_64 and Linux x86_64).
  - [x] Emit checksum and manifest sidecars (SHA256 + JSON) for Stage2 tarballs so release automation can verify downloads.
  - [ ] Extend packaging tooling to emit Stage2-native release bundles per platform (macOS arm64/x86_64, Linux x86_64) with runtime adapters and prelude modules.
  - [ ] Update the release workflow to build Stage2 artifacts, run full regression suites, generate signed SHA256 checksums, and attach provenance metadata.
  - [ ] Ensure the curl-able installer consumes the new artifact layout and fails fast when unsupported platforms request binaries.
  - [ ] Document artifact structure, supported platforms, and upgrade expectations in `docs/README.md` and `docs/status.md`.

- [ ] **Extend suspension-conflict tracking to coroutines** — Once `async fn` and generator support lands, extend borrow lifetime checks to reject mutable borrows held across `yield`/resume boundaries in coroutine frames.

  - [ ] Add coroutine/generator lowering infrastructure (tracked separately in "Async & Concurrency Substrate" roadmap item; this subtask assumes that work is complete).
  - [ ] Extend `compiler/src/native_llvm_lowering.sfn` suspension tracking to recognize `yield` instructions and treat them like `await` for borrow conflict analysis.
  - [ ] Implement resumable frame lifetime analysis that tracks which locals survive across suspension points and rejects mutable borrows that would be live at `yield` sites.
  - [ ] Add diagnostics for generator yield conflicts mirroring the existing `await` suspension diagnostics (cite both the borrow initializer and the yield site with source spans).
  - [ ] Add test coverage in `compiler/tests/test_native_llvm_execution.py`:
    - [ ] `test_native_llvm_rejects_mutable_borrow_across_yield` — generator holding `&mut` across yield emits diagnostic.
    - [ ] `test_native_llvm_allows_yield_without_mutable_borrow` — generator yielding after borrow release compiles successfully.
  - [ ] Document coroutine borrow rules and suspension lattice (`!mut ⊄ !async` extended to generators) in `docs/spec.md` and update `docs/status.md` with coverage.

- [x] **Bootstrap Stage2 self-hosting** — Compile the Sailfin compiler with Stage2 native backend, execute the resulting binary end-to-end, and lock self-hosted compilation as a CI gate.

  - [x] Create self-hosting compilation script in `scripts/bootstrap_stage2.py` that compiles all `compiler/src/*.sfn` modules using Stage2 LLVM backend with full capability grants.
  - [x] Add `make bootstrap-stage2` Makefile target that runs the full self-hosting pipeline and reports success/failure.
  - [x] Add smoke tests in `compiler/tests/test_stage2_bootstrap.py` that validate the self-hosted compiler modules are generated correctly with valid LLVM IR.
  - [x] Document self-hosting compilation flow, capability requirements, and validation steps in `docs/self-hosting.md`.
  - [x] Extend `tools/compile_with_stage1.py` to optionally target Stage2 executable output and link all compiler modules into a standalone binary.
  - [x] Add execution validation tests that run self-hosted compiler on simple inputs (e.g., `examples/basics/hello-world.sfn`).
    - [x] `compiler/tests/test_stage2_self_hosted_compiler.py::test_stage2_compile_to_sailfin_roundtrip` boots the Stage2-generated compiler in-process via `Stage2Runner`, compiles the hello-world example, and asserts the output matches the Stage1 reference implementation.
  - [x] Validate the self-hosted compiler binary can parse and compile a minimal Sailfin program and generate valid `.sfn-asm` IR and LLVM modules.
  - [x] Execute compiled programs through Stage2Runner with matching output to Stage1.

2. **Runtime & FFI Foundations**

- [ ] **Native capability adapter implementation** — Replace `runtime_support.py` Python implementations with native Sailfin modules for filesystem, HTTP, and model adapters.

  - [ ] Create `runtime/adapters/fs.sfn` implementing filesystem operations (`read_file`, `write_file`, `list_directory`, `delete_file`, `create_directory`) using platform-specific system calls via `unsafe extern` declarations.
  - [ ] Create `runtime/adapters/http.sfn` implementing HTTP client (`get`, `post`, `put`, `delete`) using native networking primitives or FFI bindings to libcurl/platform APIs.
  - [ ] Create `runtime/adapters/model.sfn` implementing model invocation adapter that routes to registered engine implementations (OpenAI API, local inference, etc.).
  - [ ] Compile adapter modules to LLVM and link them into Stage2 runtime library.
  - [ ] Update Stage2Runner to load native adapter implementations instead of `runtime_support.py` shims.
  - [ ] Add regression tests validating native adapters match Python adapter behavior for all existing examples in `examples/io/` and `examples/ai/`.
  - [ ] Document native adapter FFI contracts and platform-specific requirements in `docs/runtime_audit.md`.

- [ ] **Port async runtime glue to Sailfin** — Reimplement `asyncio`-based helpers (`spawn`, `channel`, `serve`) as native Sailfin modules with capability enforcement.

  - [ ] Create `runtime/async_runtime.sfn` implementing:
    - [ ] Event loop abstraction compatible with native coroutine lowering.
    - [ ] Task scheduler for `spawn` with named task tracking.
    - [ ] Channel implementation (bounded/unbounded queues) for inter-task communication.
  - [ ] Create `runtime/server.sfn` implementing HTTP/WebSocket server handler dispatch for `serve`.
  - [ ] Integrate async runtime with Stage2 coroutine lowering once generator/async support lands (depends on mid-term suspension work).
  - [ ] Add smoke tests in `compiler/tests/test_native_llvm_execution.py` exercising:
    - [ ] Native spawn with channel communication (validate task executes and channel send/receive works).
    - [ ] Native serve with mock request handling (validate handler registration and dispatch).
  - [ ] Convert `examples/concurrency/*.sfn` to use native async runtime and validate all examples execute correctly.

5. **Toolchain De-Pythonisation**

- [ ] **Native emission milestone** — Switch default compilation target from Python codegen to Stage2 LLVM executable backend.

  - [ ] Update `compiler/src/main.sfn` to default `--backend` flag to `native` instead of `python`, with explicit `--backend=python` option for fallback.
  - [ ] Ensure all compiler modules compile cleanly with Stage2 backend and pass existing test suite.
  - [ ] Update Makefile targets:
    - [ ] `make compile` defaults to Stage2 LLVM backend.
    - [ ] Add `make compile-python` for explicit Python fallback.
    - [ ] Keep Stage1 Python artifacts available for bisecting regressions.
  - [ ] Validate that `examples/` suite compiles and executes with Stage2 as default backend (regression coverage via `make test`).
  - [ ] Document backend selection, fallback strategy, and known Stage2 limitations in `docs/README.md`.

- [ ] **Sailfin-native CLI (`sfn`)** — Reimplement compiler launcher, project commands, and package management in Sailfin without Python entrypoints.

  - [ ] Create `cli/main.sfn` implementing:
    - [ ] Command-line argument parsing (using native string utilities).
    - [ ] Subcommand dispatch for `sfn compile`, `sfn run`, `sfn test`, `sfn add`, `sfn publish`.
    - [ ] File I/O for reading source files and writing artifacts (using native `fs` adapter).
    - [ ] Error reporting with formatted diagnostics (using native `console` helpers).
  - [ ] Implement core commands in separate Sailfin modules:
    - [ ] `cli/compile.sfn` — invoke compiler pipeline, handle output paths, emit diagnostics.
    - [ ] `cli/run.sfn` — compile and execute entry point with capability grants.
    - [ ] `cli/test.sfn` — discover test functions, execute them, report results (deferred until native test framework lands).
    - [ ] `cli/add.sfn` — fetch capsule from registry, update fleet.toml (deferred until registry work lands).
    - [ ] `cli/publish.sfn` — package capsule, upload to registry with provenance (deferred until registry work lands).
  - [ ] Compile CLI to native binary via Stage2 LLVM backend and install as `sfn` executable.
  - [ ] Add smoke tests in `compiler/tests/test_native_cli.py`:
    - [ ] `test_sfn_compile_hello_world` — compile and validate output artifact.
    - [ ] `test_sfn_run_hello_world` — compile and execute, check stdout.
    - [ ] `test_sfn_reports_compile_error` — invalid syntax produces diagnostic.
  - [ ] Update README.md with `sfn` CLI usage examples replacing Python `sailfin-stage1` references.

- [ ] **Release pipeline guardrails** — Enforce that CI builds use only Sailfin artifacts, failing if Python runtime shims are invoked.

  - [ ] Add CI job `.github/workflows/python-free-build.yml` that:
    - [ ] Compiles compiler using Stage2 backend without `runtime_support.py` in path.
    - [ ] Compiles all examples using self-hosted compiler.
    - [ ] Executes examples and validates output matches baseline.
    - [ ] Fails if `import runtime_support` or bootstrap script imports are detected in execution traces.
  - [ ] Add runtime instrumentation to detect Python shim usage:
    - [ ] Wrap Stage2Runner to log any fallback calls to Python helpers.
    - [ ] Emit warnings during compilation if Python codegen is invoked.
  - [ ] Update release workflow to require `python-free-build` job passing before artifact publication.
  - [ ] Document Python-free validation strategy and known exceptions (developer tooling, test harness) in `docs/README.md`.

- [ ] **Test harness migration** — Replace pytest-based compiler tests with Sailfin-native test framework.
  - [ ] Design native test framework in `docs/proposals/native-test-framework.md`:
    - [ ] Test discovery (find functions with `#[test]` attribute or `test_*` naming).
    - [ ] Assertion library (`assert_eq`, `assert_ne`, `assert_true`, etc.).
    - [ ] Test execution (sequential/parallel, timeout, fixture support).
    - [ ] Result reporting (pass/fail counts, diagnostic output, timing).
  - [ ] Implement test framework in `runtime/testing.sfn`:
    - [ ] Test discovery via module introspection.
    - [ ] Assertion macros with source location reporting.
    - [ ] Test runner with configurable parallelism.
    - [ ] JUnit XML output for CI integration.
  - [ ] Port high-value test suites to native framework:
    - [ ] `compiler/tests/test_stage1_pipeline.py` → `compiler/tests_native/pipeline.sfn`.
    - [ ] `compiler/tests/test_native_llvm_execution.py` → `compiler/tests_native/llvm_execution.sfn`.
    - [ ] `compiler/tests/test_effect_checker.py` → `compiler/tests_native/effect_checker.sfn`.
  - [ ] Add `make test-native` target that compiles and runs native test suite.
  - [ ] Update CI to run both pytest and native test suites during transition period.
  - [ ] Document test migration strategy and deprecation timeline for pytest in `CONTRIBUTING.md`.

3. **Diagnostics Parity**

- [ ] **Expand typecheck coverage** — Complete type inference for generics, interface conformance, and port remaining stage0 diagnostics.

  - [x] Locked regression coverage for duplicate symbol diagnostics across structs, enums, interfaces, models, and type parameters via `compiler/tests/test_stage1_typecheck_duplicates.py`.
  - [x] Implements clauses now enforce interface type argument counts, rejecting missing or extra generics with coverage in `compiler/tests/test_stage1_typecheck_interfaces.py::test_struct_missing_type_arguments_for_generic_interface_reports_diagnostic` and `compiler/tests/test_stage1_typecheck_interfaces.py::test_struct_mismatched_type_argument_count_reports_diagnostic`.
  - [ ] Generic function type inference — Infer type parameters from call-site arguments when not explicitly provided.
    - [ ] Extend `compiler/src/typecheck.sfn` to collect type parameter constraints from function signature and call arguments.
    - [ ] Implement unification algorithm that solves for type parameters based on argument types.
    - [ ] Add diagnostics for ambiguous type parameter inference with suggestions to add explicit type annotations.
    - [ ] Add tests in `compiler/tests/test_stage1_typecheck_generics.py` covering:
      - [ ] `test_generic_function_infers_type_from_arguments` — `fn identity<T>(x: T) -> T` called with `identity(42)` infers `T = int`.
      - [ ] `test_generic_function_reports_ambiguous_inference` — multiple possible type parameter bindings emit diagnostic.
      - [ ] `test_generic_function_validates_constraints` — interface-constrained type parameters checked at call site.
  - [ ] Generic struct/enum type inference — Infer type parameters from constructor arguments and field assignments.
    - [ ] Extend constructor lowering to propagate type constraints from field initializers.
    - [ ] Add diagnostics for under-constrained type parameters requiring explicit annotations.
    - [ ] Add tests in `compiler/tests/test_stage1_typecheck_generics.py` covering struct literal and enum variant inference.
  - [ ] Interface conformance validation — Verify method signatures match interface requirements with proper variance.
    - [ ] Extend `compiler/src/typecheck.sfn` to check method return types and parameter types match interface declarations (considering covariance/contravariance).
    - [ ] Add diagnostics for signature mismatches citing both the interface declaration and the implementation.
    - [ ] Add tests in `compiler/tests/test_stage1_typecheck_interfaces.py` covering:
      - [ ] `test_struct_method_signature_mismatch_reports_diagnostic` — wrong parameter/return types.
      - [ ] `test_struct_method_effect_mismatch_reports_diagnostic` — missing or extra effects in implementation.
  - [ ] Document generic type inference rules, variance, and interface conformance checking in `docs/spec.md`.

- [ ] **Enhanced diagnostic rendering** — Improve CLI/artifact diagnostic output with multi-line snippets, caret highlights, and suggested fixes.

  - [ ] Extend diagnostic types in `compiler/src/typecheck.sfn` and `compiler/src/effect_checker.sfn` to carry:
    - [ ] Primary span (error location) and secondary spans (related locations like definition sites).
    - [ ] Suggested fixes as text edits (e.g., add `![io]` to signature).
    - [ ] Severity levels (error, warning, note).
  - [ ] Implement rich diagnostic renderer in `compiler/src/diagnostics.sfn`:
    - [ ] Multi-line source context with line numbers.
    - [ ] Caret highlighting (`^^^^^`) under error spans.
    - [ ] Secondary span annotations (e.g., "defined here" notes).
    - [ ] Color-coded severity (red for errors, yellow for warnings).
    - [ ] Suggested fix rendering ("help: add `![io]` to signature").
  - [ ] Wire renderer into Stage1 CLI output (`compiler/src/main.sfn` or native `cli/main.sfn` if that has landed).
  - [ ] Add tests in `compiler/tests/test_stage1_diagnostics.py` validating:
    - [ ] Multi-line error context renders correctly.
    - [ ] Secondary spans appear with proper labels.
    - [ ] Suggested fixes format as expected.
  - [ ] Document diagnostic format and rendering behavior in `docs/spec.md`.

- [ ] **CLI effect fixer** — Implement interactive fix application for missing effect annotations.
  - [ ] Add `--fix` flag to CLI (`compiler/src/main.sfn` or `cli/main.sfn`) that:
    - [ ] Collects diagnostics with suggested fixes during compilation.
    - [ ] Prompts user to accept/reject each fix interactively (or apply all with `--fix=auto`).
    - [ ] Applies accepted fixes by rewriting source files with updated effect annotations.
  - [ ] Implement fix application in `compiler/src/fix_engine.sfn`:
    - [ ] Parse suggested fix text edits from diagnostic metadata.
    - [ ] Apply edits to source files with proper span-to-offset mapping.
    - [ ] Validate that fixed source still parses successfully.
    - [ ] Recompile and verify fixes resolve the original diagnostics.
  - [ ] Add tests in `compiler/tests/test_stage1_cli_fixer.py`:
    - [ ] `test_cli_applies_missing_effect_fix` — function missing `![io]` gets annotation added when accepted.
    - [ ] `test_cli_rejects_fix_leaves_source_unchanged` — declining fix keeps original source.
    - [ ] `test_cli_auto_fix_applies_all_suggestions` — `--fix=auto` mode applies all fixes without prompts.
  - [ ] Document `--fix` flag usage and interactive workflow in README.md and `docs/README.md`.

4. **Registry & Capsule Workflow**

- [ ] **Finalize manifest schemas** — Define and validate capsule (`sail.toml`) and fleet (`fleet.toml`) formats per package management proposal.

  - [ ] Review and refine manifest format in `docs/proposals/package-management.md`:
    - [ ] Capsule manifest (`sail.toml`) — package name, version, authors, license, dependencies, effect declarations, entry points.
    - [ ] Fleet manifest (`fleet.toml`) — workspace root, member capsules, shared dependencies, dev/build dependencies.
    - [ ] Lockfile format (`fleet.lock`) — resolved dependency graph with version pins and integrity hashes.
  - [ ] Implement manifest parser in `registry/manifest_parser.sfn`:
    - [ ] TOML parsing (or JSON if simpler for bootstrap).
    - [ ] Schema validation with diagnostic reporting for malformed manifests.
    - [ ] Semantic checks (e.g., circular dependencies, version compatibility).
  - [ ] Implement manifest generator in `registry/manifest_generator.sfn`:
    - [ ] Scaffold new `sail.toml` with defaults when running `sfn init`.
    - [ ] Update `fleet.toml` when adding dependencies via `sfn add`.
    - [ ] Generate `fleet.lock` after dependency resolution.
  - [ ] Add tests in `compiler/tests/test_registry_manifests.py`:
    - [ ] Valid manifests parse successfully and extract expected fields.
    - [ ] Invalid manifests report clear diagnostics.
    - [ ] Lockfile generation is deterministic.
  - [ ] Document manifest schemas with field descriptions and examples in `docs/proposals/package-management.md`.

- [ ] **Registry CLI commands** — Implement capsule management commands against `registry.sailfin.dev`.

  - [ ] Implement `sfn init` in `cli/init.sfn`:
    - [ ] Create project directory structure.
    - [ ] Generate default `sail.toml` with template values.
    - [ ] Create initial `src/main.sfn` with hello-world template.
  - [ ] Implement `sfn add <capsule>` in `cli/add.sfn`:
    - [ ] Query registry API for capsule metadata and version resolution.
    - [ ] Download capsule archive (tarball or zip) with integrity verification.
    - [ ] Extract capsule into local cache (`~/.sailfin/capsules/`).
    - [ ] Update `fleet.toml` dependencies and regenerate lockfile.
  - [ ] Implement `sfn run [target]` in `cli/run.sfn`:
    - [ ] Resolve entry point from `sail.toml` or command-line argument.
    - [ ] Compile capsule with all dependencies.
    - [ ] Execute entry point with capability grants from manifest.
  - [ ] Implement `sfn publish` in `cli/publish.sfn`:
    - [ ] Validate capsule manifest and ensure all files are tracked.
    - [ ] Package capsule into archive (excluding `target/`, `build/`, etc.).
    - [ ] Generate provenance metadata (build timestamp, compiler version, capability manifest).
    - [ ] Upload to registry API with authentication.
    - [ ] Verify publication and display registry URL.
  - [ ] Add smoke tests in `compiler/tests/test_registry_cli.py`:
    - [ ] `test_sfn_init_creates_project` — validate directory structure and manifest.
    - [ ] `test_sfn_add_downloads_capsule` — mock registry and verify download/extract.
    - [ ] `test_sfn_run_executes_entry_point` — compile and run simple capsule.
    - [ ] `test_sfn_publish_uploads_capsule` — mock registry and verify package upload.
  - [ ] Document CLI commands with usage examples in README.md.

- [ ] **Provenance channels** — Surface model generation metadata with cost/latency tracking in pipeline outputs.
  - [ ] Define provenance card schema in `docs/proposals/package-management.md`:
    - [ ] Model invocation details (prompt tokens, completion tokens, model name/version).
    - [ ] Cost tracking (token cost, API charges, compute time).
    - [ ] Latency metrics (request time, first-token time, total duration).
    - [ ] Generation metadata (temperature, top-p, seed, timestamp).
  - [ ] Implement provenance tracking in model adapter (`runtime/adapters/model.sfn`):
    - [ ] Wrap model invocations with timing instrumentation.
    - [ ] Extract token counts and cost from API responses.
    - [ ] Generate provenance card JSON for each invocation.
    - [ ] Attach provenance cards to pipeline outputs (as metadata or sidecar files).
  - [ ] Expose provenance query API in `runtime/prelude.sfn`:
    - [ ] `get_generation_provenance(value) -> ProvenanceCard` — retrieve metadata for model-generated values.
    - [ ] `pipeline_provenance_summary() -> ProvenanceSummary` — aggregate cost/latency across entire pipeline.
  - [ ] Add tests in `compiler/tests/test_provenance_tracking.py`:
    - [ ] Model invocation records cost and latency correctly.
    - [ ] Provenance cards serialize to valid JSON.
    - [ ] Pipeline summary aggregates multiple invocations.
  - [ ] Document provenance card format and tracking API in `docs/proposals/model-engines-and-training.md`.

## Ready Next (Pull When Active Stream Clears)

- [ ] Stage2 general availability launch plan — Finalise GA criteria, support policy, and release communications once the self-hosted pipeline holds green for multiple iterations.
- [ ] `sfn` package manager release plan — Define rollout steps once CLI integration lands.
- [ ] Registry authentication & signing — Add capability manifests and signed provenance to registry flows.
- [ ] Prototype WebAssembly emission from `.sfn-asm` once the LLVM backend is feature-complete, reusing the existing smoke harness for validation.

## Exploration Backlog (Research / Design)

- [ ] Introduce an `unsafe` capability in the stage2 runtime, lowering `unsafe extern` declarations (e.g., `malloc`) and gating raw pointer dereference to lexical `unsafe {}` blocks.
- Model engines & training — Continue design in `docs/proposals/model-engines-and-training.md`; merge into Active once registry workflows exist.
- Tensor and GPU effects — Define `Tensor<T>` primitives and effect propagation for GPU workloads.
- Notebook & LSP tooling — Prototype interactive editing, effect-aware debugging, provenance overlays.

## Completed Items

Move checked tasks here with links to PRs / status updates for traceability.

- [x] Stage2 enum array metadata — Array literals containing enum variants now emit `#element:EnumName` metadata during stage1 compilation. Updated `compiler/src/emit_native.sfn::infer_expression_type` to recognize both `Struct` (for payload variants like `Color.Red { ... }`) and `Member` (for unit variants like `Color.Red`) expression variants, extracting the enum type name for metadata tagging. LLVM lowering already supported enum type resolution via the existing `map_primitive_type` → `map_enum_type_annotation` chain, so enum array metadata flows through without additional changes. Stage2 `.for` loops can now iterate over enum arrays and match on variant tags without Python fallbacks. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_tags_enum_array_literals_with_metadata`, `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_enum_arrays`, and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_mixed_enum_arrays`; behaviour documented in `docs/status.md`.
- [x] Extend `.layout` inference to cover optional fields, nested enums, and recursive aggregates so Stage2 no longer defaults compiler AST structs to pointer layouts (silencing the `defaulting to pointer layout` warnings). Regression coverage: `compiler/tests/test_stage1_pipeline.py::test_native_backend_infers_recursive_layouts`.
- [x] Bridge Sailfin runtime helpers (console + `sleep`) as callable LLVM symbols so stage2 programs can invoke the existing runtime prelude. (Regression coverage: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_invokes_runtime_console`.)
- [x] Emit LLVM struct layouts and method bodies from the recorded descriptors, covering field access, struct literals, and method calls. (Regression coverage: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_calls_struct_methods`.)
- [x] Stage2 lifetime region metadata — LLVM lowering now publishes borrow lifetime scopes via `LoweredLLVMResult.lifetime_regions`, carrying binding names, mutability, scope identifiers, and source spans so diagnostics and future analyses can reason about scope exits without re-scanning `.sfn-asm`. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_lifetime_regions`; behaviour documented in `docs/status.md`.
- [x] Stage2 borrow lifetime enforcement — LLVM lowering now cross-checks recorded lifetime regions against their base scopes and emits `llvm lowering: borrow ... escapes lifetime ...` diagnostics when borrows would outlive their owners. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_borrow_lifetime_violation`; behaviour documented in `docs/status.md`.
- [x] Stage1 diagnostic snippets — Stage1 CLI output and native lowering diagnostics now render caret-highlighted source snippets alongside messages. Validation: `compiler/tests/test_stage1_diagnostics.py::test_missing_effect_diagnostic_includes_source_snippet`; behaviour documented in `docs/status.md`.
- [x] Struct interface conformance — Stage1 type checking now verifies that structs implement every interface member they claim, including generic instantiations. Validation: `compiler/tests/test_stage1_typecheck_interfaces.py::test_struct_missing_interface_member_reports_diagnostic`, `compiler/tests/test_stage1_typecheck_interfaces.py::test_struct_missing_generic_interface_member_reports_diagnostic`; behaviour documented in `docs/status.md`.
- [x] Stage2 move diagnostics spans — `.sfn-asm` now carries source-span metadata through the native IR and LLVM lowering so use-after-move errors surface line/column ranges in diagnostics. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move_for_affine_array` assert span strings.
- [x] Stage2 parameter span metadata — `.param` entries now emit source spans so suspension diagnostics cite mutable borrow parameters alongside suspension sites. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_emits_parameter_spans` locks emission, while `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await` asserts the diagnostics. Behaviour documented in `docs/status.md`.
- [x] Stage2 suspension-conflict spans — LLVM lowering threads borrow initializer spans and suspension instruction spans into mutable-borrow suspension diagnostics so both sites show up in error messages. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await`; behaviour documented in `docs/status.md`.
- [x] Stage2 suspension conflict diagnostics — LLVM lowering now enforces the `!mut ⊄ !async` lattice rule by rejecting `await`/`yield` sites that keep mutable borrows or parameters alive. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_allows_await_without_mutable_borrow`; behaviour documented in `docs/status.md` and `docs/spec.md`.
- [x] Stage2 capability manifest aggregation — Stage2 lowering now merges borrow effects with declared capabilities and publishes the combined requirements via `LoweredLLVMResult.capability_manifest`. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_capability_manifest_propagates_composite_effects`; behaviour documented in `docs/status.md`.
- [x] Stage2 capability manifest enforcement — `runtime.stage2_runner.Stage2Runner` now consumes the manifest before executing entry points, issuing capability grants and raising `PermissionError` when native helpers exercise effects not present in the grant. Validation: `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_applies_capability_manifest` and `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_denies_missing_capabilities`; behaviour documented in `docs/status.md`.
- [x] Stage2 move-out diagnostics — Ownership metadata now ships use-after-move errors for locals and parameters, including non-copy aggregates; regression coverage lives in `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move_for_affine_array`, with behaviour documented in `docs/status.md`.
- [x] Extend `.sfn-asm` lowering to emit runnable LLVM IR modules and execute smoke binaries via CI. (Coverage: `compiler/tests/test_native_llvm_execution.py` runs the emitted IR through `llvmlite`.)
- [x] Lower loops and `match` dispatch into LLVM branch/merge blocks so structured control flow executes under the stage2 backend. (Regression: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program` now covers loop + match execution.)
- [x] Lower `.for` loops over sequence iterables (arrays, comprehensions) into LLVM index loops so collection iteration executes without Python fallbacks. (Local bindings and inline literals without annotations now lower in `native_llvm_lowering.sfn`; validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_array_bindings_without_annotations`.)
- [x] Tag `.sfn-asm` array literals with element-type metadata so Stage2 lowering can skip per-literal inference and extend typed iteration to struct and enum aggregates. (Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_tags_array_literals_with_metadata`.)
- [x] Extend primitive coverage beyond `number` so boolean and integer values lower into native LLVM types and flow through conditions without double coercions. (Covered by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_supports_boolean_and_integer_primitives`.)
- [x] Emit struct and enum layout descriptors in `.sfn-asm` (field order, sizes, and payload encoding) so Stage2 lowering can materialise aggregate storage without guessing. Document the format in `docs/spec.md` and cover it with a regression in `compiler/tests/test_stage1_pipeline.py`.
- [x] Thread parsed interface metadata into `native_llvm_lowering.sfn`, emitting placeholder descriptors so upcoming trait-object work has concrete data; exercise the plumbing with a focused regression in `compiler/tests/test_native_llvm_execution.py`.
- [x] Lower borrow expressions (`&`, `&mut`, `borrow(...)`) and reference types into the native IR and LLVM backend, representing borrows as explicit pointer values and covering them with a regression in `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_borrow_expressions`.
- [x] Stage2 borrow conflict diagnostics — `.sfn-asm` now carries ownership metadata into LLVM lowering, rejecting conflicting borrows (mutable vs mutable/shared) during Stage2 codegen. Validation lives in `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_conflicting_mut_borrows` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_conflicting_shared_borrows`; the behaviour is documented in `docs/spec.md` and surfaced via `docs/status.md`.
- [x] Stage2 interface metadata — `native_ir.sfn` now records interface declarations and struct `implements` lists so trait membership is available to LLVM lowering. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_records_interface_metadata`.
- [x] Stage2 trait descriptors — `native_llvm_lowering.sfn` now threads interface metadata into `LoweredLLVMResult`, exposing structured descriptors for interfaces and their implementers. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_interface_metadata` asserts the metadata and comment emission.
- [x] Stage2 struct member access — LLVM lowering now maps `self.field` expressions through struct layout metadata so field loads emit without fallback diagnostics. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_interface_metadata`.
- [x] Stage2 struct literal lowering — LLVM lowering now assembles struct literals with `insertvalue`, so Stage2 functions can construct, return, and pass user-defined aggregates without Python fallbacks. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_struct_literals`; behaviour documented in `docs/status.md`.
- [x] Stage2 loop & match lowering — Stage2 LLVM emission now handles `loop` (`break`/`continue`) and `match` dispatch. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program` exercises loop control and case dispatch end-to-end.
- [x] Stage2 primitive array iteration — `.for` lowering now preserves element types for `boolean[]` and `int[]` literals and parameters, so non-number sequences execute without Python fallbacks. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_non_number_arrays`.
- [x] Support `.for` range strides (descending and custom step) so Stage2 matches Stage1 range semantics. (Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_supports_range_strides`.)
- [x] Stage2 range `.for` lowering — Numeric range-driven `for` loops (with `break`/`continue`) now lower to LLVM without Python fallbacks. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program` includes the `sum_for` iteration case.
- [x] Stage2 range stride lowering — Stage2 `.for` loops now honour explicit stride expressions (positive or negative) and flag zero literal steps. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_supports_range_strides`.
- [x] Stage2 sequence `.for` locals — Inline `let` bindings and array literals without annotations now lower to LLVM index loops instead of falling back to Python. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_array_bindings_without_annotations` covers both parameter aliases and literal bindings.
- [x] Stage2 array literal metadata — `.sfn-asm` now prefixes array literals with `#element:<type>` hints so Stage2 lowering can bypass runtime inference and prep struct/enum iteration. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_tags_array_literals_with_metadata` covers emission; existing native execution tests guard primitive iteration.
- [x] Stage2 struct array iteration — LLVM lowering now reads the embedded array metadata to recover struct element types, so `.for` loops can iterate over `Pair[]` (and other user-defined aggregates) without falling back to opaque pointer loads. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_struct_arrays`; behaviour documented in `docs/status.md`.
- [x] Grapheme segmentation — Stage1 runtime prelude now embeds the Unicode extend tables so `grapheme_count` and `grapheme_at` execute without Python `unicodedata`. Validation: `compiler/tests/test_string_utils.py` covers combining-mark accents, regional-indicator flags, and the transgender flag sequence.
- [x] Effect annotation hints — Stage1 missing-effect diagnostics now surface `![effect]` signature suggestions and reference the CLI fix prompt. Validation: `compiler/tests/test_stage1_typecheck_effects.py::test_typecheck_reports_missing_effects_with_spans` asserts the new guidance.
- [x] Hierarchical effect propagation — Stage1 `effect_checker.sfn` now walks nested blocks, lambdas, and spawned thunks so capability requirements bubble up to the declaring routine. Validation: `compiler/tests/test_effect_checker.py::test_effect_checker_propagates_model_from_nested_lambda` and `compiler/tests/test_effect_checker.py::test_spawn_prompt_requires_io_and_model` lock the coverage.
- [x] Effect origin tracing — Stage1 effect diagnostics now attach prompt and helper call spans, and the typechecker surfaces missing-effect errors with structured context. Validation: `compiler/tests/test_effect_checker.py::test_effect_checker_propagates_model_from_nested_lambda`, `compiler/tests/test_effect_checker.py::test_spawn_prompt_requires_io_and_model`, and `compiler/tests/test_stage1_typecheck_effects.py::test_typecheck_reports_missing_effects_with_spans`.
- [x] Effect enforcement — Extended stage0 effect checks to cover runtime helpers (`fs`, `http`, `websocket`, `serve`, `spawn`, `print`, `sleep`). Validation: `bootstrap/tests/test_unit_effects.py` exercises missing-effect errors for `spawn`, `serve`, console IO, and timer usage.
- [x] Self-hosted control flow — Added structured `if`/`else`, `for`, and `match` support to the Sailfin parser and emitter. Validation: `bootstrap/tests/test_compiler_sources.py` asserts the new AST nodes and generated scaffolding.
- [x] Decorator parity — Self-hosted effect inference now recognises `@logExecution` alongside `@trace`. Validation: `bootstrap/tests/test_compiler_sources.py::test_self_hosted_decorator_logexecution_infers_io` ensures inferred `io` effects.
- [x] Runtime core parity — Moved collection/string helpers, enum & struct repr, descriptor-backed `check_type`, and interpolation lowering into Sailfin’s runtime prelude; regression coverage in `compiler/tests/test_runtime_prelude.py`, `compiler/tests/test_string_utils.py`, and `compiler/tests/test_string_interpolation.py`.
- [x] Self-hosted effect helpers — Added console IO, `sleep`, and `runtime.*` helper detection (`runtime.fs`, `runtime.http`, `runtime.spawn`, `runtime.serve`) to the Sailfin effect checker. Validation: `bootstrap/tests/test_compiler_sources.py` covers missing `io`/`net`/`clock` enforcement.
- [x] Literal coverage — Array, object, and struct literals now emit structured AST nodes and generate Python via `runtime.make_object`/type constructors. Validation: `bootstrap/tests/test_compiler_sources.py` exercises literal parsing and generation.
- [x] Expression normalisation — Pratt parser covers member access, calls, unary `!`/`-`, and common binary operators, replacing `Raw` placeholders. Validation: `bootstrap/tests/test_compiler_sources.py` asserts structured guard and inline match expressions, plus member-call lowering within loop bodies.
- [x] Parser parity — Self-hosted match arms now preserve guards and inline `=>` expression/`return` bodies, matching stage0 behaviour. Validation: `bootstrap/tests/test_compiler_sources.py` exercises guard, expression, and return cases.
- [x] Lambda lowering — Sailfin lambdas now produce structured AST nodes and round-trip through the self-hosted emitter with inlined Python lambdas. Validation: `bootstrap/tests/test_compiler_sources.py::test_compile_compiler_source` checks both Sailfin and Python outputs.
- [x] Postfix foundations — Indexing (`values[i]`) and range (`start..end`) expressions round-trip through the Sailfin parser and emitter. Validation: `bootstrap/tests/test_compiler_sources.py::test_compile_compiler_source` covers bracket access and `start..end` ranges.
- [x] Postfix expressions — Chained member/call/index sequences now round-trip through the Sailfin parser and emitter, and code generation rewrites `.map`, `.filter`, `.reduce`, `.concat`, and `.length` into runtime helpers. Validation: `bootstrap/tests/test_compiler_sources.py::test_compile_compiler_source` asserts Sailfin emission and Python lowering for the helper chain.
- [x] Example hardening — Annotated every runnable example with declared effects, wrapped ad-hoc top-level statements in `main`, and removed undefined helper stubs. Validation: `examples/README.md` capability index plus `make test` ensures samples compile and execute under the stage1 suite.
- [x] Stage1 closed loop — Stage1 now recompiles the compiler end-to-end, replaces stage0 in CI, and ships as the release artifact. Validation: `compiler/tests/test_stage1_artifact.py`, `.github/workflows/stage1-release.yml`.
- [x] Stage1 installer — Added `scripts/install_stage1.py` and README docs so releases can be fetched with a PAT and installed system-wide.
- [x] Runtime string helpers — Promoted `compiler/src/string_utils.sfn` into the shared runtime prelude so downstream projects and the stage1 compiler reference a single implementation. Validation: `compiler/tests/test_runtime_prelude.py`, `compiler/tests/test_string_utils.py`.
- [x] Module re-export support — Parser, emitter, native lowering, and Python bridge now preserve aliased `import`/`export` specifiers so runtime helpers can be re-exported directly. Validation: `compiler/tests/test_stage1_pipeline.py::test_import_export_alias_round_trip`.
- [x] Capability bridges — Introduced runtime capability grants and filesystem/HTTP/model bridge helpers that enforce permissions while delegating to bootstrap shims. Validation: `compiler/tests/test_runtime_prelude.py::test_runtime_capability_bridges`.
- [x] Stage2 conditionals — `native_llvm_lowering.sfn` now lowers local assignments and structured `if`/`else` blocks into LLVM IR. Validation: `compiler/tests/test_native_llvm_execution.py` exercises branching via `choose`.
- [x] Share layout descriptors across modules — Native backend now emits `.layout-manifest` artifacts containing struct and enum layout descriptors alongside `.sfn-asm` modules, and `native_ir.sfn` can parse manifests to reconstruct layout metadata. This infrastructure enables future cross-module type resolution without recompilation. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_emits_layout_manifest` and `compiler/tests/test_stage1_pipeline.py::test_native_backend_parses_layout_manifest`; behaviour documented in `docs/status.md`.
- [x] Cross-module layout regression coverage — Added comprehensive end-to-end tests that validate the layout manifest infrastructure through both stage1 pipeline and stage2 LLVM execution. Created multi-module fixtures (`compiler/tests/data/cross_module/shared_types.sfn` defining Point, Rectangle, Color, and Shape types with payload variants; `consumer.sfn` importing and using those types in local bindings, function calls, and match expressions). The stage1 test (`compiler/tests/test_stage1_pipeline.py::test_native_backend_cross_module_layout_resolution`) verifies manifest emission and parsing for the types module and confirms the consumer compiles without fatal errors. The stage2 test (`compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_cross_module_layout_resolution`) validates that both modules lower to LLVM IR with proper type definitions. These tests lock the manifest generation, parsing, and type context building infrastructure that will enable full cross-module resolution once automatic dependency tracking is implemented. Behaviour documented in `docs/status.md`.
- [x] Stage2 string literal lowering — String literals now fully lower to LLVM global constants, enabling functions and interface methods to return string values without Python fallbacks. The compiler unescapes standard sequences (`\n`, `\t`, `\"`, `\\`), generates deterministic global constant names (`@.str.len{length}.h{hash}` derived from literal length and a djb2-style hash), and emits private unnamed_addr constant declarations in the module preamble. String constants are automatically deduplicated via `merge_string_constants`, which tracks content to global name mappings, ensuring identical literals reuse the same global constant. The implementation threads string constants through all instruction types (`.let`, inline let expressions, expression statements, return statements) and control flow structures, collecting them via `lower_expression` → `lower_string_literal` and merging them at the module level before emission. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_string_literal`, `test_native_llvm_execution_deduplicates_string_constants`, and `test_native_llvm_execution_returns_string_from_method`; behaviour documented in `docs/status.md`.
- [x] Stage2 self parameter type resolution — Struct method `self` parameters are now properly typed when implementing interface methods. When a method name contains `::` (e.g., `Person::format`), the compiler extracts the struct name from the qualified function name and infers the `self` parameter type as a pointer to that struct (`%Person*`). This enables member access expressions like `self.field` to compile correctly without "missing type annotation" or "member access base lacks struct metadata" diagnostics, allowing interface methods to access struct fields and return computed values. The implementation modifies `prepare_parameters` in `compiler/src/native_llvm_lowering.sfn` to detect `self` parameters at index 0 with missing type annotations, parse the function name for `::`, extract the struct name, resolve it via `map_struct_type_annotation`, and inject the proper struct pointer type. The existing `lower_member_access` machinery already handles member access correctly once `self` is properly typed. Validation: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_multiple_vtables` confirms that methods with `return self.field` compile and execute correctly; behaviour documented in `docs/status.md`.
- [x] Stage2 array `.length` member access — Array `.length` member access now fully lowers to LLVM, enabling loop conditions, bounds checks, and array size queries to compile without fallbacks. The `lower_member_access` function recognizes when a member access expression targets the `length` field on an array type (identified by the `{ element_type*, i64 }*` LLVM representation where field 1 stores the length as `i64`). For array parameters and locals (e.g., `items.length` where `items` has type `number[]`), the compiler loads the array struct pointer, extracts the length field via `extractvalue` on field index 1, and returns an `i64` operand. This enables common patterns like `if index >= array.length` in loop conditions, `return items.length` for array size queries, and comparisons between array lengths (`first.length == second.length`) without emitting "member access base `{ ..., i64 }*` lacks struct metadata" diagnostics. The implementation added a `contains_text` helper function to check for the `{ ..., i64 }` pattern in type strings, which is used during type analysis in the lowering phase. Validation: `compiler/tests/test_array_length.py` covers conditions, returns, comparisons, loop termination, empty arrays, and struct arrays; behaviour documented in `docs/status.md`.
- [x] Track borrow lifetimes across control-flow merges so Stage2 can release borrows at scope exits, accept reborrows that shorten lifetime regions, and reject borrows that would outlive their owners. Covered by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_allows_scoped_reborrow` and `...::test_native_llvm_execution_reports_borrow_lifetime_violation`.
- [x] Insert SSA merges / `phi` nodes for locals that span `if`/`match` merges and loop bodies to keep generated IR valid under aggressive optimisation.
  - [x] Mutation capture: extend `BlockLoweringResult` and `LocalBinding` plumbing in `compiler/src/native_llvm_lowering.sfn` to return a `LocalMutation` list (`{name, llvm_type, value_name, span, originating_label}`) from `lower_instruction_range`; populate it in `lower_let_instruction` and the reassignment path in `lower_expression_statement`. Add a lightweight stage2 lowering unit test that builds a synthetic block and asserts the recorded mutations without touching emitted IR.
  - [x] Metadata propagation: thread the mutation list through `lower_if_instruction`, `lower_loop_instruction`, `lower_for_instruction`, and `lower_match_instruction` so each structure advertises the locals it mutates and the label that last defined them. Ensure collectors (`collect_if_structure`, `collect_loop_structure`, `collect_match_structure`) leave the metadata intact. Validated by `compiler/tests/test_stage2_mutation_capture.py::test_mutations_propagate_through_if_then`, `test_mutations_propagate_through_if_else`, `test_mutations_propagate_through_loop`, and `test_mutations_propagate_through_match`.
  - [x] Straight-line `if` joins: introduce an `emit_phi_merges` helper invoked after the merge label when an `if` without `else` falls through. Generate `phi` nodes for each mutated local, using the base block and the `then` exit label recorded in metadata, then store the phi result back through the local pointer. Validated by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_straight_line_if` which confirms phi nodes are emitted, LLVM IR verifies, and behavior is correct for both conditional branches.
  - [x] Full `if`/`else` merges: re-use the helper to union mutations from both arms, skip terminated branches, and emit two-input phis. Add coverage for a function where both arms mutate a shared local (and another unique local) before reconverging, confirming the right value is observed after the merge. Validated by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_if_else` which exercises both shared mutations (where both branches modify the same local) and partial mutations (where each branch modifies unique locals), ensuring phi nodes correctly merge values from both branches.
  - [x] Loop header phis: restructured `lower_loop_instruction` to create explicit preheader, header, body, latch, and exit labels. For each local mutated in the body and live on exit, emit header phis fed by the preheader definition and the latch definition while ensuring `continue` jumps target the latch. The `lower_for_instruction` already had the proper structure (header, body, increment/latch, exit) and `continue` targeting. Regression coverage: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program` includes both `loop_and_match` (which mutates `total` and `current` accumulator locals) and `sum_for` (which mutates `total` accumulator local in a for loop with `continue`/`break`).
  - [x] Match merges: in `lower_match_instruction`, accumulate mutations per arm (including guards) with their terminating label, then emit a multi-input phi for each live-out local at the shared merge label. Terminated arms are ignored. Covered by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_match` with match expressions where different arms assign distinct values before falling through (both shared mutations across all arms and partial mutations unique to specific arms).
  - [x] Consolidation and docs: factored shared phi assembly helpers (`find_preloaded_value`, `collect_mutation_names`, `find_mutation_for_name`, `join_strings`, `build_phi_and_store`) into `compiler/src/native_llvm_lowering.sfn` and refactored all three phi emission functions (`emit_phi_merges_for_straight_if`, `emit_phi_merges_for_if_else`, `emit_phi_merges_for_match`) to use the common helpers while ensuring LLVM's requirement that phi nodes are grouped at the top of basic blocks. Stage2 suite (`make test-stage2`) confirms all 40 tests pass. Behaviour documented in `docs/status.md` with references to execution fixtures `test_native_llvm_execution_emits_phi_for_straight_line_if`, `test_native_llvm_execution_emits_phi_for_if_else`, and `test_native_llvm_execution_emits_phi_for_match`.
- [x] Lower enum aggregates (including payload storage) into LLVM so runtime helpers can consume native values without Python bridges.
  - [x] Define the tagged-union LLVM layout (tag + payload pointer/inline storage) and thread it through the type context.
  - [x] Emit enum constructors that populate the tag field; unit variants (no payload) fully work, payload variants insert tags but full field storage needs bitcast/store operations (deferred to follow-on work).
  - [x] Extend match lowering to destructure enum operands without falling back to Python, with execution coverage in `compiler/tests/test_native_llvm_execution.py`. Match expressions now extract enum tags via `extractvalue` and compare against variant tag values, enabling native enum dispatch in Stage2. Unit variants fully work; payload field destructuring emits diagnostics indicating follow-on work is needed. Validated by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_matches_enum_variants` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_matches_mixed_enum_variants`.
- [x] Lower enum payload storage (including recursive variants) into LLVM so Stage2 can materialise compiler AST enums without Python fallbacks.
  - [x] Support inline payload emission for primitives/struct references and validate via struct-enum fixtures. Enum literals with payload fields now allocate the enum on the stack, store the tag, then use `getelementptr` and `bitcast` to store each field at its correct byte offset within the payload byte array, finally loading the complete enum value. Field offsets use the metadata from `EnumVariantInfo.fields[].offset` relative to the variant's base offset. Match expressions can discriminate payload variants by tag, enabling control flow routing without field binding (field extraction deferred to follow-on work). Validated by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_stores_enum_payload_fields` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_matches_payload_enum_by_tag`.
  - [x] Implement payload field extraction and binding in match patterns so variant fields can be used in match arm bodies without Python fallbacks. Match patterns now support shorthand field binding syntax (e.g., `Shape.Circle { radius }` extracts the `radius` field into a local variable). Implementation allocates the subject enum on stack, extracts payload fields using GEP with correct byte offsets (field offset minus variant offset), and creates scoped local bindings for each extracted field. Validated by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_extracts_enum_payload_fields_in_match`. Behaviour documented in `docs/status.md`.
  - [x] Implement heap-indirected payload support for recursive/self-referential variants by boxing aggregate operands into heap allocations when lowering pointer-shaped payload slots, avoiding fallback diagnostics.
  - [x] Add regression tests covering mixed recursive/non-recursive variants and ensure heap boxing executes, via `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_allocates_recursive_enum_payloads`.
- [x] Introduce interface trait objects (data pointer + vtable) and emit vtables for each `implements` pair so interface values can be passed to functions and stored in locals.
  - [x] Define the trait-object ABI (data pointer layout + vtable schema) and emit descriptors during native lowering. Trait objects are represented as `{ i8*, i8* }` (data pointer + vtable pointer). Vtables are type-specific structs containing function pointers for each interface method.
  - [x] Generate vtable structs for every concrete `implements` declaration and write them into the module data section. Each struct-interface pair generates a vtable type definition (e.g., `%vtable.User.Greeter`) and a global constant containing bitcast function pointers to the struct's method implementations.
  - [x] Add unit coverage ensuring interface types and vtables emit correctly. Validated by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_vtable_type_definitions`, `test_native_llvm_execution_emits_vtable_constants`, and `test_native_llvm_execution_emits_multiple_vtables`. Behaviour documented in `docs/status.md`.
- [x] Lower method dispatch through interface values (boxing on assignment, indirect calls on `.method()`), with regression coverage using `examples/basics/interfaces.sfn` in the LLVM suite.
  - [x] Box concrete values into trait objects when assigning to interface-typed locals/parameters.
  - [x] Modify call lowering to route `.method()` through the vtable slot, passing the data pointer as the implicit receiver.
  - [x] Extend the LLVM execution suite with the interface example to validate dynamic dispatch end-to-end. Validated by `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_boxes_struct_into_trait_object` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_dispatches_through_trait_object`. Behaviour documented in `docs/status.md`.
- [x] Surface enum array metadata in LLVM lowering once layout descriptors exist, enabling typed iteration over tagged aggregates.
  - [x] Emit array element descriptors for enum element types during module lowering. Updated `compiler/src/emit_native.sfn::infer_expression_type` to recognize both `Struct` and `Member` expression variants representing enum literals, returning the enum type name (not variant name) for metadata tagging. Validated by `compiler/tests/test_stage1_pipeline.py::test_native_backend_tags_enum_array_literals_with_metadata`.
  - [x] Teach the native runner to expose the metadata to runtime helpers without pointer fallbacks. The existing `map_metadata_annotation` function already handles enum types via `map_primitive_type` → `map_enum_type_annotation`, so enum array metadata flows through the LLVM lowering pipeline without modifications.
  - [x] Add smoke tests iterating over enum arrays to verify metadata-driven access. Added `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_enum_arrays` and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_mixed_enum_arrays` to validate that enum arrays emit proper type definitions and iteration/match lowering works correctly. Behaviour documented in `docs/status.md`.
- [x] Share layout descriptors across modules by emitting/importing per-unit layout manifests so Stage2 can resolve referenced structs/enums defined in dependencies without pointer fallbacks.
  - [x] Emit layout manifests alongside each module artifact and persist them in the build output. Layout manifests now ship as `module.layout-manifest` files containing struct and enum layout descriptors in the same textual format as `.sfn-asm` `.layout` directives. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_emits_layout_manifest`.
  - [x] Load and merge dependency manifests during lowering so cross-module references have concrete layouts. The `parse_layout_manifest` function in `compiler/src/native_ir.sfn` reconstructs `NativeStruct` and `NativeEnum` definitions from manifest text, and the existing `build_type_context` function in `compiler/src/native_llvm_lowering.sfn` accepts these layout-enriched definitions regardless of origin. Full dependency resolution (automatic manifest loading for imports) remains roadmap work. Validation: `compiler/tests/test_stage1_pipeline.py::test_native_backend_parses_layout_manifest`.
  - [x] Cover cross-module struct/enum usage with a stage1 + stage2 regression harness. Regression coverage validates manifest generation, parsing, and the type context building infrastructure. Behaviour documented in `docs/status.md`.
- [x] Canonicalise ABI metadata for builtin/runtime types (`Token`, parser state, `runtime.StructField`, etc.) and surface it to the native emitter so bootstrap helpers stop returning pointer-layout warnings. Validation: `compiler/tests/test_stage1_pipeline.py::test_stage1_builtin_ast_layouts_do_not_warn`, `compiler/tests/test_runtime_prelude.py::test_runtime_prelude_collection_helpers`.
  - [x] Inventory builtin/runtime types used by the compiler and define canonical ABI descriptors.
  - [x] Teach the native emitter to consume the canonical descriptors before defaulting to pointer layouts.
  - [x] Update diagnostics/tests to assert the absence of pointer-layout fallbacks for the covered types.
- [x] Add cross-module layout regression coverage (stage1 pipeline + stage2 LLVM execution) to lock the merged-manifest behaviour and guard against future pointer fallback regressions.

  - [x] Build a minimal multi-module fixture that exercises shared structs/enums through both pipelines.
  - [x] Wire the fixture into `make test` (stage1) and the native LLVM execution suite.
  - [x] Document the coverage expectations in `docs/status.md` once the suite lands.

- [x] **Capability-aware intrinsics for native backend** — Introduce intrinsic declarations that preserve effect annotations through LLVM codegen so Stage2 binaries enforce capability requirements at the IR level.

  - [x] Define intrinsic signatures for core capability operations (`io_print`, `io_read`, `model_invoke`, `net_request`) in `compiler/src/native_ir.sfn` with effect metadata that survives lowering.
  - [x] Extend `compiler/src/native_llvm_lowering.sfn` to emit LLVM function declarations for intrinsics, annotating them with capability metadata in IR comments.
  - [x] Wire intrinsic calls through `lower_call_expression` so Stage2 routes `console.info`, `fs.*`, `http.*`, `prompt` to the declared intrinsics instead of Python fallbacks.
  - [x] Add unit tests in `compiler/tests/test_native_llvm_execution.py` that validate intrinsic declarations emit, capability metadata propagates, and simple IO/model/net calls compile without diagnostics.
  - [x] Document intrinsic ABI and capability metadata format in `docs/spec.md` and update `docs/status.md` with coverage references.

- [x] **Bridge capability adapters into Stage2 lowering** — Expose `fs`, `http`, `serve`, `spawn`, and channel primitives as callable symbols in Stage2 LLVM modules so runtime helpers can be invoked from native code.

  - [x] Declare adapter function signatures in `compiler/src/native_llvm_lowering.sfn` for filesystem operations (`fs_read_file`, `fs_write_file`, `fs_list_directory`), HTTP (`http_get`, `http_post`), model (`model_invoke_with_prompt`), serving (`serve_start`, `serve_handler_dispatch`), concurrency (`spawn_task`, `channel_create`, `channel_send`, `channel_receive`). Adapter signatures added to `runtime_helper_descriptors()` function with appropriate effect annotations and LLVM symbol names.
  - [x] Implement adapter lowering in `compiler/src/native_llvm_lowering.sfn` that emits external function declarations and routes Sailfin runtime helper calls to the corresponding adapter symbols. Adapter calls route through existing `find_runtime_helper` infrastructure, ensuring proper symbol resolution via the `symbol` field and automatic capability metadata propagation.
  - [x] Add smoke tests in `compiler/tests/test_native_llvm_execution.py` for each adapter category:
    - [x] `test_native_llvm_execution_calls_fs_adapter` — validates filesystem read/write/list declarations emit with capability metadata.
    - [x] `test_native_llvm_execution_calls_http_adapter` — validates HTTP get/post declarations emit with capability metadata.
    - [x] `test_native_llvm_execution_calls_model_adapter` — validates model invoke declaration emits with capability metadata.
    - [x] `test_native_llvm_execution_calls_serve_adapter` — validates serve start/handler declarations emit with capability metadata.
    - [x] `test_native_llvm_execution_calls_spawn_adapter` — validates spawn/channel declarations emit with capability metadata.
  - [x] Ensure adapter calls propagate capability requirements into the module's capability manifest. Validated by existing manifest tests plus new adapter-specific coverage showing effects (`io`, `net`, `model`, `spawn`, `channel`) flow through declaration comments.

- [x] **Register capability adapters in Stage2 runner** — Extend `runtime/stage2_runner.py` to bind adapter implementations to LLVM symbols and enforce capability grants before native code executes.

  - [x] Implement adapter registration in `Stage2Runner.__init__` that maps adapter symbol names to Python callback implementations (reusing existing `runtime_support.py` helpers for `fs`, `http`, `model`, `serve`, `spawn`, `channel`).
  - [x] Extend `Stage2Runner.execute_entry_point` to check the capability manifest before execution and raise `PermissionError` if native code attempts IO/model/net operations without grants (leveraging existing manifest enforcement from completed work).
  - [x] Add bridge implementations for each adapter that translate LLVM ABI calls to Python runtime helpers:
    - [x] Filesystem adapters — `fs_read_file`, `fs_write_file`, `fs_list_directory` bridging to `runtime_support.fs.*` with path validation and error handling.
    - [x] HTTP adapters — `http_get`, `http_post` bridging to `runtime_support.http.*` with request/response marshalling.
    - [x] Model adapters — `model_invoke_with_prompt` bridging to `runtime_support.prompt` with capability check and result marshalling.
    - [x] Serve adapters — `serve_start`, `serve_handler_dispatch` bridging to `runtime_support.serve` with handler registration and request routing.
    - [x] Concurrency adapters — `spawn_task` bridging to `runtime_support.spawn`, channel creation/send/receive bridging to `runtime_support.channel` with asyncio integration.
  - [x] Add end-to-end runtime smoke tests in `compiler/tests/test_native_llvm_execution.py` that compile Sailfin programs calling adapters, execute them via Stage2Runner, and validate behavior:
    - [x] `test_stage2_runner_executes_fs_operations` — write/read file round-trip.
    - [x] `test_stage2_runner_executes_http_request` — mock HTTP get with stub adapter.
    - [x] `test_stage2_runner_executes_model_prompt` — mock prompt invocation with stub adapter.
    - [x] `test_stage2_runner_executes_serve_handler` — register handler and dispatch mock request.
    - [x] `test_stage2_runner_executes_spawn_and_channel` — spawn task, send/receive via channel.
    - [x] `test_stage2_runner_enforces_capability_restrictions` — validates `PermissionError` when capabilities are missing.
  - [x] Document adapter ABI, registration flow, and capability enforcement in `docs/runtime_audit.md` and update `docs/status.md` with coverage.

- [x] **Complete string literal lowering in LLVM backend** — Emit global string constants so method returns and expressions can use string literals without Python fallbacks.

  - [x] Implement `lower_string_literal` in `compiler/src/native_llvm_lowering.sfn` to create LLVM global constants for string literals:
    - [x] Parse string literal content and unescape sequences (`\n`, `\t`, `\"`, etc.).
    - [x] Generate deterministic global constant names (`@.str.len{length}.h{hash}`) and track them in lowering context.
    - [x] Emit `@.str.lenX.hY = private unnamed_addr constant [length x i8] c"content\00"` declarations in module preamble.
    - [x] Return operand with `i8*` type pointing to `getelementptr inbounds ([length x i8], [length x i8]* @.str.lenX.hY, i32 0, i32 0)`.
  - [x] Add string constant deduplication to avoid duplicate globals for identical literals (via `merge_string_constants` function that tracks content → global name).
  - [x] Add tests in `compiler/tests/test_native_llvm_execution.py`:
    - [x] `test_native_llvm_execution_lowers_string_literal` — simple function returning string literal compiles and executes.
    - [x] `test_native_llvm_execution_deduplicates_string_constants` — function using same string twice reuses global constant.
    - [x] `test_native_llvm_execution_returns_string_from_method` — interface method returning string literal works without diagnostics.
  - [x] Update existing interface/vtable tests (`test_native_llvm_execution_emits_multiple_vtables`, `test_native_llvm_execution_boxes_struct_into_trait_object`, `test_native_llvm_execution_dispatches_through_trait_object`) confirmed to not produce "unhandled return expression" diagnostics with the fixes in place.
  - [x] Document string literal lowering strategy and global constant layout in `docs/status.md`.

- [x] **Fix self parameter type resolution in interface methods** — Ensure interface method bodies can access struct fields via `self` without "missing type annotation" diagnostics.

  - [x] Extend interface method lowering in `compiler/src/native_llvm_lowering.sfn` to inject implicit `self` type annotation:
    - [x] When lowering struct method implementing interface, resolve struct type from function qualified name (e.g., `Person::format` → `Person`).
    - [x] Create parameter binding for `self` with resolved struct type and appropriate LLVM pointer type (`%StructName*`).
    - [x] Thread struct layout metadata through to member access lowering so `self.field` can generate GEP instructions.
  - [x] `lower_member_access` in `compiler/src/native_llvm_lowering.sfn` already handles `self` parameter correctly once properly typed:
    - [x] Checks if base expression resolves to parameter binding with struct pointer type.
    - [x] Looks up struct layout metadata in type context to get field offsets.
    - [x] Generates `getelementptr` instructions using struct layout (field index, not byte offset).
    - [x] Loads field value through the computed pointer.
  - [x] Test coverage inherited from existing interface tests:
    - [x] `test_native_llvm_execution_emits_multiple_vtables` — method body with `return self.age` compiles and executes correctly.
    - [x] Interface tests no longer produce "parameter `self` missing type annotation" or "member access base" errors for properly qualified methods.
  - [x] Document self parameter resolution and member access lowering for interface methods in `docs/status.md`.

- [x] **Add regression coverage for method return expressions** — Validate that interface methods can return all expression types to prevent regressions before self-hosting.

  - [x] Create comprehensive method return test suite in `compiler/tests/test_native_llvm_execution.py`:
    - [x] `test_native_llvm_execution_method_returns_string_literal` — validates `return "text"` works end-to-end.
    - [x] `test_native_llvm_execution_method_returns_field_access` — validates `return self.field` works.
    - [x] `test_native_llvm_execution_method_returns_computed_value` — validates `return self.x + self.y` works.
    - [x] `test_native_llvm_execution_method_returns_call_result` — validates `return helper(self.value)` works.
  - [x] Document expression coverage expectations in `docs/status.md`.

- [x] **Complete Stage2 LLVM lowering for warning-free self-compilation** — Implement missing language features in LLVM backend so the compiler can compile itself without diagnostic warnings, achieving full Stage2 feature parity.

  - [x] **Fix complex type lowering fallbacks** — Address cases where complex types (arrays, enums, structs) are incorrectly lowered as `double` due to missing type resolution.

    - [x] Investigate type resolution failures in `lower_expression` that cause `{ %DecoratorInfo*, i64 }*` and similar complex types to fallback to `double` primitive.
    - [x] Ensure `resolve_struct_info_for_literal`, `resolve_enum_info_for_literal`, and array type resolution correctly propagate through all expression contexts.
    - [x] Fix parameter type resolution in decorator evaluation functions (`evaluate_decorators`, `evaluate_arguments`, `evaluate_expression`) where `Decorator[]`, `DecoratorArgument[]`, and `Expression` parameters lose type metadata.
    - [x] Add unit tests in `compiler/tests/test_complex_parameter_types.py` validating complex parameter types compile without "`double` lacks struct metadata" warnings:
      - [x] `test_native_llvm_function_with_struct_array_parameter` — function accepting struct array compiles cleanly.
      - [x] `test_native_llvm_function_with_enum_array_parameter` — function accepting enum array compiles cleanly.
      - [x] `test_native_llvm_function_with_nested_struct_parameter` — function with nested struct parameter compiles cleanly.
      - [x] `test_native_llvm_function_with_unresolved_import_type_uses_pointer_fallback` — unresolved types use i8\* fallback instead of double.
    - [x] Target diagnostics: eliminated "unsupported parameter type" warnings and "double lacks struct metadata" warnings from bootstrap output. Remaining "i8* lacks struct metadata" and "{ i8\*\*, i64 }* lacks struct metadata" warnings are expected for operations on opaque pointer types (require cross-module type resolution, roadmap work).

  - [x] **Implement array indexing in LLVM lowering** — Support `array[index]` expressions so compiler internals can access AST node fields, token arrays, and decorator lists.

    - [x] Add `lower_index_expression` function in `compiler/src/native_llvm_lowering.sfn` that:
      - [x] Recognizes `base[index]` syntax and splits into base expression and index expression.
      - [x] Lowers base expression to get array operand with `{ element_type*, i64 }` or `[N x element_type]` LLVM type.
      - [x] Lowers index expression to get `i64` index value.

  - [x] Emits bounds check (compare index against array length) and routes failures through the `sailfin_runtime_bounds_check` helper to raise `IndexError` on out-of-bounds access.

    - [x] Generates `getelementptr` to compute element address.
    - [x] Loads element value and returns operand with correct element type.
    - [x] Integrate index expression recognition into `lower_expression` after member access but before fallback.
    - [x] Handle both heap-allocated arrays (`{ element_type*, i64 }*`) and stack arrays (`[N x element_type]`).
    - [x] Add tests validating array indexing compiles and executes correctly:
      - [x] `test_native_llvm_execution_indexes_primitive_array` — access elements of `number[]`.
      - [x] `test_native_llvm_execution_indexes_struct_array` — access elements of `Token[]`, `Decorator[]`.
      - [x] `test_native_llvm_execution_checks_array_bounds` — out-of-bounds access traps or returns error.
    - [x] Target diagnostics: eliminate "unsupported expression `array[index]`", "unsupported expression `decorators[index]`", "unsupported expression `text[0]`" warnings.

  - [x] **Fix string indexing and character operations** — Support `string[index]` access and character comparison so lexer/parser string utilities work natively.

    - [x] Extend `lower_index_expression` to recognize string base types (`i8*` LLVM representation).
    - [x] Generate `getelementptr` for character access returning `i8` value.
    - [x] Implement `is_whitespace_char`, `is_digit_char`, `is_alpha_char` as native helpers or inline comparisons.
    - [x] Add tests for string character access:
      - [x] `test_native_llvm_execution_indexes_string_character` — `"hello"[0]` returns correct character.
      - [x] `test_native_llvm_execution_compares_string_characters` — `text[i] == 'a'` works correctly.
      - [x] `test_native_llvm_execution_validates_character_classes` — whitespace/digit checks work.
    - [x] Target diagnostics: eliminate "member access base `i8*` lacks struct metadata", "unsupported expression `value[start]`", "unsupported expression `text[0]`" warnings.

  - [x] **Implement compound assignment operators** — Support `+=`, `-=`, `*=`, `/=` operators so mutation-heavy compiler code (loop counters, accumulators) lowers without fallbacks.

    - [x] Recognize compound assignment syntax in `lower_expression_statement`.
    - [x] Desugar `variable += expression` into `variable = variable + expression` during lowering.
    - [x] Ensure desugared form uses existing local binding infrastructure and mutation tracking.
    - [x] Add tests for compound assignments:
      - [x] `test_native_llvm_execution_compound_add_assignment` — `count += 1` in loop compiles and executes.
      - [x] `test_native_llvm_execution_compound_subtract_assignment` — `total -= value` works.
      - [x] `test_native_llvm_execution_compound_multiply_divide` — `product *= factor` and `quotient /= divisor` work.
    - [x] Target diagnostics: eliminate "assignment to unknown local `index +`", "unsupported expression `= 1`" warnings.

  - [x] **Fix logical operator lowering** — Support `&&`, `||` operators with short-circuit evaluation so conditional expressions in compiler logic compile correctly.

    - [x] Implement `lower_logical_and` and `lower_logical_or` in `compiler/src/native_llvm_lowering.sfn`:
      - [x] For `a && b`: evaluate `a`, branch to short-circuit exit if false, otherwise evaluate `b`.
      - [x] For `a || b`: evaluate `a`, branch to short-circuit exit if true, otherwise evaluate `b`.
      - [x] Emit phi node at merge point to produce final boolean result.
    - [x] Recognize `&&` and `||` in `lower_expression` before additive operators.
    - [x] Add tests for logical operators:
      - [x] `test_native_llvm_execution_logical_and_short_circuits` — second operand not evaluated if first is false.
      - [x] `test_native_llvm_execution_logical_or_short_circuits` — second operand not evaluated if first is true.
      - [x] `test_native_llvm_execution_nested_logical_operators` — `a && b || c && d` compiles correctly.
      - [x] `test_native_llvm_execution_logical_operators_with_comparisons` — `x > 0.0 && x < 100.0` compiles correctly.
    - [x] Target diagnostics: eliminate "call to unknown function `requires_io && !contains_effect`" warnings.

  - [x] **Support conditional expression ternary operator** — Implement `condition ? true_value : false_value` so inline conditionals in compiler code compile without fallback.

    - [x] Recognize ternary syntax in `lower_expression`.
    - [x] Lower condition expression, branch to `then`/`else` labels, evaluate corresponding expression, emit phi merge.
    - [x] Add tests:
      - [x] `test_native_llvm_execution_ternary_operator` — `let result = x > 0 ? x : -x` compiles and executes.
      - [x] `test_native_llvm_execution_nested_ternary` — nested ternary expressions work.
    - [x] Target diagnostics: eliminate conditional expression fallback warnings (if any).

  - [x] **Fix if-statement condition lowering failures** — Address cases where if/match conditions produce no value due to type coercion issues.

    - [x] Audit `lower_condition_to_i1` in `compiler/src/native_llvm_lowering.sfn` to ensure all boolean-producing expressions return operands.
    - [x] Handle cases where complex expressions (member access, calls) need type coercion to `i1` for branch conditions.
    - [x] Extend `comparison_predicate_for_symbol` to support `i8` (character) comparisons with full ordering (`==`, `!=`, `<`, `<=`, `>`, `>=`) and `i8*` (string pointer) equality comparisons (`==`, `!=`).
    - [x] Add `i8` to `i64` coercion via sign-extend (`sext`) instruction in `coerce_operand_to_type`.
    - [x] Update `dominant_type` to recognize `i8` as narrower than `i64` for automatic type harmonization.
    - [x] Add tests for complex conditions:
      - [x] `test_native_llvm_execution_compares_string_characters` — `text[i] == 'a'` character comparisons work correctly.
      - [x] `test_native_llvm_execution_if_with_complex_condition` — `if struct.field > threshold` works with member access.
    - [x] Target diagnostics: eliminate "unsupported comparison operator `==` for type `i8`", "unsupported comparison operator `!=` for type `i8`", and "unsupported comparison operator `==` for type `i8*`" warnings. All "unsupported comparison operator" warnings eliminated from bootstrap output.

  - [x] **Implement unsupported expression fallback handlers** — Add lowering support for remaining expression types used in compiler source.

    - [x] **Unary negation operator** — Implement `!` operator lowering using `xor i1 <value>, 1` instruction. Eliminates all "call to unknown function `!...`" warnings (e.g., `!contains_effect`, `!starts_with`). Tests: `compiler/tests/test_negation_operator.py`.
    - [x] **Null literal support** — Implement `null` keyword lowering as `i8* null` pointer. Enables struct fields with optional types (e.g., `primary: null` in Diagnostic structs) to compile without "unsupported expression `null`" warnings. Eliminates ~50+ bootstrap warnings. Tests: `compiler/tests/test_null_literal.py`.
    - [x] **Character literal support** — Single-character string literals (e.g., `"a"`, `"t"`, `"\n"`) now lower to `i8` type instead of `i8*`, enabling direct character comparisons without type coercion errors. Implemented `is_character_literal` and `get_character_literal_value` helpers that detect single-char strings and escape sequences, returning ASCII values for LLVM lowering. Eliminates "unable to convert right operand from `i8*` to `i8`" warnings in character comparison contexts. Tests: `compiler/tests/test_string_lowering_improvements.py::test_character_literal_lowering`, `test_character_comparison`, `test_escape_sequence_character_literals`.
    - [x] **String utility runtime helpers** — Registered `substring`, `is_whitespace_char`, `is_decimal_digit`, `is_alpha_char` as runtime helper descriptors with LLVM symbols (`sailfin_runtime_substring`, `sailfin_runtime_is_whitespace_char`, `sailfin_runtime_is_decimal_digit`, `sailfin_runtime_is_alpha_char`). These functions are now recognized during call lowering and emit proper external function declarations with correct signatures (`substring` takes `i8*, i64, i64` and returns `i8*`; character classification helpers take `i8` and return `i1`). Eliminates "call to unknown function `substring`" and "call to unknown function `is_whitespace_char`" warnings. Tests: `compiler/tests/test_string_lowering_improvements.py::test_substring_runtime_helper_registered`, `test_character_classification_helpers_registered`.

## Coordination Notes

- Every roadmap item should cite its status source (tests, docs, or prototypes).
- When a task moves from roadmap to implementation, update `docs/status.md` and
  prune “planned” callouts in the spec / examples.
- Proposals live under `docs/proposals/`; reference them instead of duplicating
  detail here.
