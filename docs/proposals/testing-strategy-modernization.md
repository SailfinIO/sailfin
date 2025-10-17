# Sailfin Proposal: Testing Strategy Modernization

Status: Draft Proposal  
Author: Sailfin Core Team  
Date: October 16, 2025  
Applies to: Compiler, Runtime, Docs, CI

Goal: Shrink end-to-end feedback loops and prepare Stage2 for CI by restructuring
the Sailfin test harness, introducing deterministic build caching, and defining a
tiered strategy for Python- and Sailfin-native validation.

---

## 1. Context

- `make test` invokes `pytest` inside the Conda `sailfin` environment (`Makefile`
  target `test`). The last full run on a developer laptop took **14m23s**.
- Stage1-focused tests depend on the function-scoped `stage1_environment`
  fixture, which recompiles the compiler into a temporary directory on every
  test invocation (`compiler/tests/conftest.py:15`). The suite currently touches
  this fixture 22 times across modules such as
  `compiler/tests/test_stage1_pipeline.py`.
- Heavy regressions (packaging with PyInstaller, LLVM lowering/execution) run in
  the default suite. Only the Stage1 artifact test is marked `integration`, so
  the fast loop and CI exercise the same heavyweight code paths.
- Python module caching issues forced the test harness to invalidate
  `compiler.build` imports aggressively (`compiler/tests/conftest.py:35`), which
  trades correctness for throughput.
- Stage2 lowering is landing quickly, but the suite does not yet distinguish
  Stage1 vs Stage2 expectations or provide native-only smoke tests beyond
  `compiler/tests/test_native_llvm_execution.py`.

## 2. Pain Points

- **Repeated Stage1 rebuilds** – Every test that uses `stage1_environment`
  triggers a fresh Sailfin→Python lowering even when no sources changed. On the
  current tree, Stage1 recompiles more than twenty times per `pytest -q`, which
  dominates runtime.
- **Cache invalidation by temp path** – Tests side-step stale `.pyc` files by
  compiling into unique temp directories each time. This avoids Python cache
  bugs but prevents reuse of successful builds and bloats I/O.
- **Mixed import strategies** – Some modules import `compiler.build` eagerly at
  module import (`compiler/tests/test_native_llvm_execution.py:7`), while others
  rely on the fixture. This split complicates cache design and makes it unclear
  which artifacts are under test.
- **Undifferentiated suite** – Heavy flows (artifact packaging,
  LLVM execution, self-host checks) run alongside quick unit assertions. No
  guardrails guide contributors toward `unit`, `integration`, `e2e` markers even
  though the project guidelines call for them.
- **Stage2 blind spots** – LLVM lowering is validated through a handful of IR
  smoke tests; there is no plan for differential checking (Stage1 vs Stage2) or
  coverage of future capsules and runtime adapters.
- **Limited observability** – CI does not report per-test durations or Stage1
  rebuild counts, making it hard to spot regressions or justify optimisations.

## 3. Objectives

1. Reduce the default `make test` wall clock under 7 minutes on developer
   hardware without sacrificing coverage.
2. Provide deterministic, content-addressed caching for Stage1 and (later)
   Stage2 builds so repeated runs re-use verified artifacts safely.
3. Establish clearly tiered test groups (`unit`, `integration`, `e2e`, `stage2`)
   with matching `make` targets and documentation so contributors can choose the
   right loop.
4. Expand Stage2 validation to cover LLVM IR generation, runtime bridges, and
   execution, gating the backend roadmap with actionable signals.
5. Maintain alignment with `docs/status.md` and `docs/roadmap.md` by describing
   new test expectations as they ship.

## 4. Workstream Overview

### 4.1 Phase 0 — Baseline Instrumentation

- Add `pytest --durations=20` and Stage1 rebuild counters to CI logs to track
  hotspots.
- Extend the test fixture to emit debug logging when cache misses occur (guarded
  behind `PYTEST_STAGE1_DEBUG=1`) so developers can diagnose cold-starts.
- Document the current timings in `docs/status.md` as the starting baseline.

### 4.2 Phase 1 — Deterministic Stage1 Build Cache

- Introduce a content-addressed cache (e.g., `.pytest-stage1/<hash>/compiler`) in
  `tools/compile_with_stage1.py`. Hash `compiler/src/**/*.sfn`, `runtime/**/*.sfn`,
  and the lowering pipeline version to derive the cache key.
- Refactor `stage1_environment` into a session-scoped fixture that reuses the
  cached build, invalidating only when the hash changes. Maintain an opt-out via
  `PYTEST_STAGE1_NO_CACHE=1` for debugging.
- Move module invalidation from "per test" to "per build" by clearing
  `compiler.build*` modules only when swapping cache entries. Keep the existing
  `importlib.invalidate_caches()` safeguard.
- Teach `make test` to pre-warm the Stage1 cache (optional `make test CACHE=warm`)
  so CI and local loops avoid first-test compilation spikes.
- Update `docs/status.md` with the new behaviour and troubleshooting steps for
  cache busting (e.g., `rm -rf .pytest-stage1`).

### 4.3 Phase 2 — Tiered Suites & Developer Ergonomics

- Adopt explicit `@pytest.mark.unit`, `@pytest.mark.integration`,
  `@pytest.mark.e2e`, and introduce `@pytest.mark.stage2` for native backend
  checks. Retrofit existing tests accordingly (e.g., mark
  `compiler/tests/test_stage1_artifact.py:17` as `integration`, Stage2 exec
  tests as `stage2`).
- Split Make targets: `make test-unit` (default `-m "unit and not stage2"`),
  `make test-integration`, `make test-stage2`, preserving `make test` as the
  union for CI.
- Guard slow flows (`package_stage1`, LLVM execution) behind integration/stage2
  markers so ad-hoc runs can skip them unless requested.
- Update contributor docs to explain when to run each target and how the suite
  maps to roadmap items.

### 4.4 Phase 3 — Stage2 Validation Harness

- Create a `stage2_environment` fixture that compiles Sailfin→LLVM once per run,
  mirroring the Stage1 cache contract.
- Add golden Sailfin-native IR snapshots (e.g., `.sfn-asm`, LLVM textual IR)
  for representative programs: capability manifests, interface dispatch, enum
  layouts, coroutine lowering. Validate them with diff-friendly assertions.
- Introduce differential tests that compile selected programs through Stage1
  Python and Stage2 LLVM backends, then compare observable behaviour (e.g.,
  diagnostics, struct metadata, effect manifests).
- Add runtime smoke binaries that execute Stage2 outputs via `llvmlite` or a
  lightweight runner, covering capability enforcement and runtime prelude calls.
- Wire Stage2 coverage expectations into `docs/status.md` so behaviour changes
  flag documentation updates.

### 4.5 Phase 4 — Toward Sailfin-Native Harness

- Begin porting high-confidence unit coverage into Sailfin modules, executed via
  Stage2-generated binaries or a Sailfin-native test runner.
- Plan the eventual deprecation path for the Python test harness (mirrors the
  roadmap’s “Test harness migration” item), including CI gating once Sailfin
  tests reach parity.
- Provide migration guides and sample Sailfin-based fixtures (e.g., wrappers for
  hashed build caches, runtime prelude checks).

## 5. Tooling & Infrastructure Updates

- Evaluate adding `pytest-xdist` once Stage1 caching is in place; document
  thread-safety requirements for cached artifacts.
- Surface cache statistics and durations in CI artifacts (e.g., JSON summary) to
  enable trend tracking over time.
- Add pre-push hooks or a lightweight `scripts/validate_tests.py` to ensure new
  tests declare markers and avoid accidental fixture misuse.
- Ensure `docs/README.md` and `docs/roadmap.md` reference the new targets so the
  navigation guide remains accurate.

## 6. Risks & Mitigations

- **Cache masking regressions** – Mitigate by hashing all inputs (including
  compiler version) and providing an easy `--no-cache` escape hatch. Add smoke
  tests that force recompilation on CI nightly to detect hash bugs.
- **Concurrent writers** – Address by writing caches into temp directories and
  atomically renaming them into place once compilation succeeds.
- **Developer friction** – Document environment variables and add `make`
  shortcuts to invalidate caches or run full suites so contributors are not
  surprised by behaviour changes.
- **Stage2 volatility** – Keep early Stage2 tests optional (behind markers) until
  the backend stabilises, then ratchet expectations in CI.

## 7. Success Metrics

- Default `make test` completes in under 7 minutes on an M3-class laptop with a
  warm cache; Stage1 rebuild count ≤2 per run.
- `make test-unit` finishes in under 90 seconds, enabling tight TDD loops.
- Stage2 suite covers capability metadata, enum layouts, interface dispatch, and
  emits LLVM IR snapshots for at least five representative programs.
- CI dashboards show per-test durations and cache hit rates, with alerts when
  regressions exceed agreed thresholds (e.g., +15% runtime).
- Documentation (status + roadmap) references the new targets and is updated as
  Stage2 coverage evolves.

## 8. Open Questions

- Where should persistent caches live when running inside CI or ephemeral dev
  environments (`/tmp`, repository-local, Conda env)?
- Should we disable `.pyc` emission (`PYTHONDONTWRITEBYTECODE=1`) while Stage1
  compiles caches, or rely solely on hashing for consistency?
- How do we validate Stage2 outputs on platforms without `llvmlite` (e.g.,
  Windows builders) — via WASM lowering or a mock backend?
- Do we need a Sailfin-native benchmarking harness to track compile latency as
  the language grows, or can pytest instrumentation suffice for now?
