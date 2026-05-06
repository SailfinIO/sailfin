# Phased implementation

Each phase leaves the tree green and self-hosting. Phases 1-3 are
pre-1.0; Phase 4 is post-1.0 polish that depends on `routine`/`spawn`.

## Phase 1 — Test-runner extraction & assertion core

Goal: `sfn test` becomes a thin dispatcher; the assertion library
handles structured failures. The compiler still owns test discovery
and per-test compile/link.

| Issue | Size | Files | Acceptance | Blocked by |
|---|---|---|---|---|
| **1.1** Move pass/fail policy from `run_native_test.sh` into `handle_test_command` | M | `compiler/src/cli_commands.sfn:312-510`; delete retry+grep blocks at `scripts/run_native_test.sh:95-196` | `sfn test path/x_test.sfn` returns non-zero on assertion failure with no bash post-processing. The two retry classes (signal-kill 137/139, I/O-pressure regex) move into `cli_commands.sfn` as a typed `RetryPolicy` enum. | P2 |
| **1.2** Replace `Makefile` test-* loops with one `sfn test` invocation | S | `Makefile:144-291` collapses to ~10 lines | `make test` shells out exactly once. The four `═══ unit: N/M passed ═══` banners produced by Makefile shell loops move into `sfn test` itself. `test-unit`/`test-integration`/`test-e2e`/`test-capsules` keep their names but become aliases passing different paths to one runner. | 1.1 |
| **1.3** De-duplicate helpers in `sfn/test` | XS | `capsules/sfn/test/src/mod.sfn:13-50, 136-148` import from `sfn/strings`+`sfn/fmt` | `_number_to_string` and `_find_in_string` deleted (~40 LOC). The capsule depends on `sfn/strings` and `sfn/fmt` instead of inlining. Round-trip `make compile && make test` passes. | (none) |
| **1.4** `expect(value)` fluent builder + `Matcher<T>` interface | S | `capsules/sfn/test/src/expect.sfn` (new), `capsules/sfn/test/src/matcher.sfn` (new), `capsules/sfn/test/src/mod.sfn` re-exports | `expect(x).to_be(y)`, `.to_contain(s)`, `.to_throw()`, `.to_throw_with(pat)` compile and run. Legacy `assert_*` helpers stay (deprecation in 3.3). | P2, P3 |
| **1.5** Structured failure record + `--json` event stream | M | `compiler/src/cli_commands.sfn:312-510`, new `compiler/src/test_runner_json.sfn` | `sfn test --json` emits jsonl matching the schema in `01-preconditions.md` P6. CI consumers parse failures programmatically. | 1.1, P6 |
| **1.6** Test discovery filtering (`-k`, `--tag`) | S | `compiler/src/cli_commands.sfn:_collect_test_files_cmd`; new in-test filter pass over `TestDeclaration.name` and decorators | `sfn test -k auth` runs only tests whose name contains `auth`. `--tag slow` runs tests carrying `@tag("slow")` decorator (decorators already exist; see `compiler/src/decorator_semantics.sfn`). | 1.1 |

**End-of-phase state.** Bash run-script deleted. `make test` is one
invocation. `sfn/test` is DRY. JSON output works. Filtering works.
Tests still serial.

---

## Phase 2 — Lifecycle, fixtures, and capsule self-test ergonomics

| Issue | Size | Files | Acceptance | Blocked by |
|---|---|---|---|---|
| **2.1** Lifecycle hooks (`before_each`/`after_each`/`before_all`/`after_all`) | M | `capsules/sfn/test/src/lifecycle.sfn` (new), `compiler/src/emit_native.sfn:394-405` (`emit_test` wraps body with hook calls), `compiler/src/ast.sfn:132` (TestDeclaration gains `hook_kind`) | A test file declaring `before_each fn() ![io] { ... }` runs that block before every `test`. Hooks compose across imported capsules. | P1, 1.4 |
| **2.2** `with_tmp_dir`, `with_env`, `with_cwd` scoped fixtures | S | `capsules/sfn/test/src/fixtures.sfn` (new) | Closure-scoped resource setup: `with_tmp_dir(\|d\| { ... })` creates tmpdir, runs body, recursively removes on scope exit. Replaces ~20 ad-hoc `mktemp -d` invocations in shell tests. Requires closures-with-capture (existing 1.0 critical path Phase 2 prereq). | P5, 1.4, closures-with-capture |
| **2.3** Collection + struct equality matchers | S | `capsules/sfn/test/src/matcher.sfn` extends with `to_equal_array`, `to_equal_record` | `expect([1,2,3]).to_equal_array([1,2,3])` produces a unified diff on mismatch. Struct equality requires one new helper `_struct_eq` in `runtime/prelude.sfn` (not a generic). | 1.4 |
| **2.4** Snapshot/golden tests | S | `capsules/sfn/test/src/snapshot.sfn` (new); `compiler/src/cli_commands.sfn` adds `--update-snapshots` flag | `expect(out).to_match_snapshot("ir-shape")` writes `tests/__snapshots__/ir-shape.snap` on first run, compares thereafter. Replaces ~8 IR-grep e2e shells (e.g. `test_struct_field_separator.sh`, `test_runtime_*_skeleton.sh`). | 1.4, 2.2 |
| **2.5** `Equatable<T>` interface stub for matchers | S | `capsules/sfn/test/src/mod.sfn` declares `interface Equatable<T> { fn equals(self: T, other: T) -> boolean; }`; helpers gain `<T: Equatable>` constraints where parser supports | API uses generics where supported, falls back to per-type fan-out where not. Shim removed when generic constraints land (1.0 critical path Phase 2). | generic-type-constraints |
| **2.6** `assert_compiles` / `assert_does_not_compile` | M | `capsules/sfn/test/src/compile_assert.sfn` (new); shells out via `process.run_capture` to a freshly-built `sfn check --json` | `expect_compiles("fn x() { print.info(\"hi\"); }", { effects: ["io"] })` succeeds; missing-effect produces structured failure. Replaces ~6 bash scripts that grep `sfn check` stderr (`test_check_*.sh`). | P4, P6, planned `sfn check --json` |

**End-of-phase state.** Capsule authors write expressive tests.
Snapshots replace IR-grep bash. ~14 of the 38 e2e bash scripts already
obsolete.

---

## Phase 3 — Migrate the bash, deprecate `assert`, runner-as-capsule seam

| Issue | Size | Files | Acceptance | Blocked by |
|---|---|---|---|---|
| **3.1** Migrate the 24 collapsible e2e shell scripts | M | `compiler/tests/e2e/*.sh` → `compiler/tests/e2e/*_test.sfn` (1:1); delete `.sh` originals; `Makefile:269-276` test-e2e drops the `find -name 'test_*.sh'` branch | The migration table in `04-bash-collapse.md` closes. CI green. Net LOC drops by ~5000. | 2.4, 2.6, P4, P5 |
| **3.2** Carve out `_test_runner.sfn` callable as `sfn/test` entry point | M | New `capsules/sfn/test/src/runner.sfn` exporting `fn run_tests(files: string[], opts: RunnerOptions) -> RunnerResult ![io]`; `compiler/src/cli_commands.sfn:312-510` shrinks to ~30-line dispatcher | The runner is embeddable by an external tool (e.g. `sailfin_test_runner` MCP tool) that imports `sfn/test`. The compiler still owns test-source compile/link via an injected callback (`compile_test_to_exe: fn(string) -> string`) so the runner itself stays toolchain-agnostic. | 1.5, P1 |
| **3.3** Soft-deprecate bare `assert` inside `test` blocks | S | Compiler unchanged. `compiler/src/parser.sfn` warning hook emits `W0210: prefer expect()` for `assert false`/`assert <expr>` inside `test` blocks (opt-out: `--allow-bare-assert`). Spec at `site/src/content/docs/docs/reference/spec/§9-tests.md` documents the deprecation. | New tests use `expect`. Existing `assert false` keeps working. Removal scheduled post-1.0. | 1.4 |
| **3.4** `sfn test --watch` (file-mtime poller) | S | `compiler/src/cli_commands.sfn` adds a watch loop calling the runner periodically; interval `--watch-interval-ms` default 500ms. No fs-notify dep. | `sfn test --watch tests/` re-runs on `.sfn` mtime changes within the watch interval. | 1.1 |
| **3.5** Spec + `llms.txt` documentation | S | New chapter `site/src/content/docs/docs/reference/spec/§9-tests.md`; preview chapter `…/preview/tests-future.md`; `llms.txt` gains a "Testing your capsule" section. | `sailfin.dev/docs/reference/spec/9-tests` renders. `llms.txt` covers `expect`, lifecycle, JSON output, CLI flags. | 3.1, 3.2 |

**End-of-phase state.** Bash test surface ≈ 3 scripts (the unmigrated
hold-outs in `04-bash-collapse.md`). `sfn/test` is a real consumable
capsule. Spec documents the framework. `llms.txt` makes it
AI-discoverable. Runner is separable for the MCP server.

---

## Phase 4 — Parallelism (post-1.0, gated on structured concurrency)

Sketched only — do not start until `routine`/`spawn` and the work-queue
runtime exist (1.0 critical path Phase 4 in `CLAUDE.md`).

- **4.1** `sfn test --jobs N` runs N processes in parallel; each gets
  its own `SAILFIN_TEST_SCRATCH`. Output buffered per-test, flushed in
  deterministic order by submission index. Requires `process.spawn`
  (P4) returning a handle.
- **4.2** Per-test wall-clock + memory budget enforced inside the
  runner via `routine` cancellation; the outer `timeout 180` shell
  wrapper goes away.
- **4.3** Property/replay/adversarial tests — the second half of the
  current roadmap line `site/src/pages/roadmap.astro:163`. Stays a
  separate roadmap row, retitled to *"Test framework — Phase 4"*.

---

## Sequencing summary

| Phase | Calendar weeks | Concurrent agents | Blockers |
|---|---|---|---|
| 0 (preconditions) | 2 | 3 | none |
| 1 (assertion core) | 3 | 2 | Phase 0 |
| 2 (lifecycle/fixtures) | 4 | 3 | Phase 1, closures-with-capture |
| 3 (migrate bash, deprecate) | 3 | 2 | Phase 2 |
| 4 (parallelism) | post-1.0 | — | `routine`/`spawn` runtime |

Total pre-1.0 footprint: ~12 calendar weeks at 3 agents, comparable to
the runtime-enablement Phase 1+2 in `CLAUDE.md`. The two epics can run
in parallel because the test framework needs P4/P5 stdlib gap-fills
that runtime enablement also needs.
