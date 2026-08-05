# Archived — SFEP-0010 phased plan and preconditions

> **Not live design.** This is the 2026-05 work-breakdown for the test-infra
> epic — sized issue tables, acceptance criteria, calendar estimates, and the
> six Phase-0 preconditions. All of it has closed or been overtaken. It is
> preserved as the historical record of how the framework was sequenced.
>
> Two specific warnings about the text below. Its **Phase 4** section is
> factually wrong: it asserts that parallel test execution was blocked on the
> `routine`/`spawn` runtime, which was never the reason — see SFEP-0010 §6.5 for
> what was actually true. And every `compiler/src/cli_commands.sfn` path it cites
> is dead; the runner is now `compiler/src/cli/commands/test/`.
>
> The live design record is [`../0010-test-infra.md`](../0010-test-infra.md).

---

# Preconditions (Phase 0)

These six issues must close before Phase 1 starts. Each unblocks one or
more downstream phases. None ship a user-visible framework feature on
its own — they are foundation work the framework will rest on.

## P1 — `sfn test` resolves capsule-relative imports

**Size:** M
**Blocks:** P2, all of Phase 1, all of Phase 2 capsule-self-test work

**Problem.** `compiler/src/cli_commands.sfn:406` calls
`prepare_project_capsules_for_test(..., empty_resolver_consumer(), "")`.
`empty_resolver_consumer()` (`compiler/src/capsule_resolver.sfn:149`)
returns a no-op consumer; the test runner sees no capsule context.
Today this is exactly why
`capsules/sfn/json/tests/json_test.sfn` inlines `JsonValue` rather
than `import { JsonValue } from "../src/mod"`. Until this works,
users cannot test their own capsules.

**Acceptance criteria.**
- A test file at `capsules/sfn/json/tests/json_test.sfn` containing
  `import { stringify } from "../src/mod"` compiles and runs under
  `sfn test capsules/sfn/json/tests`.
- A user capsule at `~/code/my-app/tests/x_test.sfn` containing
  `import { my_fn } from "my-app";` (the bare capsule name from the
  capsule's own `capsule.toml`) resolves correctly.
- Workspace-implicit imports continue to work for in-tree tests.
- The pre-existing inlined `JsonValue` is removed from
  `json_test.sfn` (real imports replace it).

**Files affected:** `compiler/src/cli_commands.sfn:312-510`,
`compiler/src/capsule_resolver.sfn:149`, `capsules/sfn/json/tests/json_test.sfn`.

---

## P2 — Structured assertion failure record (replaces stdout grep)

**Size:** S
**Blocks:** 1.1, 1.5

**Problem.** Today `assert false` aborts and `scripts/run_native_test.sh:179-191`
greps stdout for `pass`/`ok`/`success` vs identifier-bounded
`fail`/`error`/`panic`/`abort`. This is fragile — any test that prints
the word "panic" in normal output gets flagged. We need a structured
hook the runtime calls on assertion failure.

**Acceptance criteria.**
- Runtime exposes `sailfin_assert_fail(file: *const u8, line: i64, col: i64, msg: *const u8)` that writes a typed record to a runner-provided fd or scratch file.
- The compiler's test-runner reads the record, not stdout grep.
- `assert false` in user code still aborts the process (no behaviour
  change for non-test callers).
- `run_native_test.sh`'s grep heuristic (lines 178-196) is deleted.

**Files affected:** `runtime/native/src/sailfin_runtime.c` (new helper
+ declare), `runtime/prelude.sfn` (binding), `compiler/src/cli_commands.sfn`,
`scripts/run_native_test.sh` (delete).

---

## P3 — `pure_assert_*` family returning `Result<(), AssertFailure>`

**Size:** XS
**Blocks:** 1.4, all `![pure]` matchers in `03-capsule-api.md`

**Problem.** The current `sfn/test` capsule declares
`required = ["io"]` and every helper is `![io]` because failure prints
to `print.err`. A pure-math test then has to declare `![io]` for no
real reason. Effect polymorphism (row variables) is the long-term
answer but is post-1.0.

**Interim design.** Ship a parallel `pure_assert_*` family that
**returns** `Result<(), AssertFailure>` rather than printing. The
runner catches the result via P2's structured hook and prints diagnostics
itself. Same call-site shape; effect annotations drop to `![pure]`.

**Acceptance criteria.**
- `pure_assert_eq(actual, expected, label) -> Result<(), AssertFailure>`
  exists for `int`, `float`, `string`, `boolean`.
- Effect-polymorphism rollout (post-1.0) folds these back into the
  generic `assert_eq` and `pure_assert_*` becomes an alias deprecated
  in one minor.
- A test calling only `pure_assert_*` (or `expect(...)` once 1.4 ships)
  can stay `![pure]` even though `sfn/test`'s manifest still declares
  `required = ["io"]` — the capsule's `required` describes what the
  capsule's own functions do, not what every caller must declare.
- `capsules/sfn/test/capsule.toml` is **unchanged** by this issue; the
  capsule keeps `required = ["io"]` because the lifecycle/fixture/
  legacy-shim surfaces still use `print.err` and `process.run`.

**Files affected:** `capsules/sfn/test/src/mod.sfn`. (No change to
`capsule.toml` — manifest semantics already permit pure callers.)

---

## P4 — `process.run_capture` and `process.spawn_with_env`

**Size:** S
**Blocks:** 2.6, 3.1 (most bash migrations)

**Problem.** `capsules/sfn/os` and `process.run` (used at
`compiler/src/cli_commands.sfn:155, 490`) return only an exit code.
Bash tests use `$(sfn build … 2>&1)` everywhere because they need the
captured stdout/stderr. Without capture, e2e shell scripts cannot
migrate to Sailfin.

**Acceptance criteria.**
- `process.run_capture(args: string[], env: Env) -> ProcessOutput`
  where `ProcessOutput { stdout: string; stderr: string; exit: int; }`.
- `process.spawn_with_env(args: string[], env: Env) -> ProcessHandle`
  for tests that need to write to the child's stdin or watch streaming
  output.
- `Env` is a typed map struct, not raw string array.

**Files affected:** `capsules/sfn/os/src/mod.sfn`, `runtime/prelude.sfn`,
`runtime/native/` (extern bindings).

---

## P5 — Filesystem stdlib gap-fill

**Size:** S
**Blocks:** 2.2, 3.1 (~12 bash scripts)

**Problem.** `capsules/sfn/fs/src/mod.sfn` exposes only `read`, `write`,
`append`, `exists`, `remove`, `mkdir`, `read_dir` — seven functions.
Bash tests need `chmod`/`stat -c '%a'`/`mktemp -d`/`ln -s` repeatedly.

**Acceptance criteria.** Add to `sfn/fs`:
- `fs.set_perms(path: string, mode: int) -> Result<(), IoError>`
- `fs.get_perms(path: string) -> Result<int, IoError>`
- `fs.mkdtemp(prefix: string) -> Result<string, IoError>` (returns the
  created path, ensures `0700`)
- `fs.is_executable(path: string) -> boolean`
- `fs.symlink(target: string, link: string) -> Result<(), IoError>`

Each function has a corresponding test under
`capsules/sfn/fs/tests/`. Octal mode literals (`0o700`) are accepted
where supported by the parser; otherwise pass as `int` decimal.

**Files affected:** `capsules/sfn/fs/src/mod.sfn`,
`capsules/sfn/fs/tests/fs_test.sfn` (new), `runtime/prelude.sfn`,
`runtime/native/src/sailfin_fs.c` (or wherever the existing fs
externs live).

---

## P6 — `sfn test --json` event stream

**Size:** S
**Blocks:** 1.5, 3.5 (spec doc), the MCP server's `sailfin_test` tool

**Problem.** The roadmap already plans `sfn check --json`
(`site/src/pages/roadmap.astro:119`). Tests need the same: jsonl
output one event per line, schema-versioned.

**Acceptance criteria.**
- `sfn test --json` emits exactly:
  - `{"event":"start","total":N,"schema_version":1}` once at start
  - `{"event":"test","name":...,"file":...,"line":...,"status":"pass"|"fail"|"skip","duration_ms":N,"effects":[...],"assertion":{...}?}` per test
  - `{"event":"summary","passed":N,"failed":N,"skipped":N,"duration_ms":N}` once at end
- Schema documented as a new "Test runner JSON output" section appended to the existing `site/src/content/docs/docs/reference/spec/11-testing.md` chapter (the spec uses numbered filenames `NN-name.md`; testing already lives at chapter §11).
- Schema version is bumped on any breaking change; old consumers see
  `schema_version` and can refuse.

**Files affected:** `compiler/src/cli_commands.sfn:312`, new
`compiler/src/test_runner_json.sfn`,
`site/src/content/docs/docs/reference/spec/11-testing.md` (extend with
a "Test runner JSON output" section).

---

## Dependency graph

```
P5 ─┐
P4 ─┼──► Phase 2 fixtures, Phase 3 bash migrations
P2 ──► P3 ──► Phase 1 matchers
P1 ──► Phase 1 capsule-self-test, Phase 2 lifecycle
P6 ──► 1.5 JSON ──► 3.5 spec
```

Phase 0 is parallelizable across at least three concurrent agents:
P1 + P2 + P5 in week 1, P3 + P4 + P6 in week 2.

---

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
| **1.3** De-duplicate helpers in `sfn/test` | XS | `capsules/sfn/test/src/mod.sfn:13-50, 136-148` import from `sfn/strings` | `_number_to_string` and `_find_in_string` deleted (~40 LOC). `_find_in_string` is replaced by `find` from `sfn/strings`; `_number_to_string` is replaced by the runtime `number_to_string` intrinsic. Round-trip `make compile && make test` passes. | (none) |
| **1.4** `expect(value)` fluent builder + `Matcher<T>` interface | S | `capsules/sfn/test/src/expect.sfn` (new), `capsules/sfn/test/src/matcher.sfn` (new), `capsules/sfn/test/src/mod.sfn` re-exports | **Partially shipped (#847, 2026-06-02) — free-function form only.** `expect_eq_int`, `expect_eq_str`, `expect_eq_bool`, `expect_eq_int_array`, `expect_contains_str`, `expect_contains_int_array`, `expect_to_throw(thunk)`, `expect_to_throw_with(thunk, pattern)` — all `![pure]`, returning `MatchResult`. Caller: `assert expect_eq_int(x, y).ok;`. Covered by `capsules/sfn/test/tests/expect_test.sfn` (19 tests passing). **Deferred:** the fluent `expect(x).to_be(y)` builder form (generic `Expectation<T>` struct + method dispatch) is blocked by (a) no generic-struct monomorphization / `where` clauses and (b) cross-module struct-method dispatch miscompilation (`self` passed incorrectly across a module boundary). The original acceptance criterion (`expect(x).to_be(y)` compiles and runs) remains open; see `03-capsule-api.md` for the surface distinction. | P2, P3 |
| **1.5** Structured failure record + `--json` event stream | M | `compiler/src/cli_commands.sfn:312-510`, new `compiler/src/test_runner_json.sfn` | `sfn test --json` emits jsonl matching the schema in `01-preconditions.md` P6. CI consumers parse failures programmatically. | 1.1, P6 |
| **1.6** Test discovery filtering (`-k`, `--tag`) | S | `compiler/src/cli_commands.sfn:_collect_test_files_cmd`; new in-test filter pass over `TestDeclaration.name` and decorators | `sfn test -k auth` runs only tests whose name contains `auth`. `--tag slow` runs tests carrying `@tag("slow")` decorator (decorators already exist; see `compiler/src/decorator_semantics.sfn`). | 1.1 |

**End-of-phase state.** Bash run-script deleted. `make test` is one
invocation. `sfn/test` is DRY. JSON output works. Filtering works.
Tests still serial.

---

## Phase 2 — Lifecycle, fixtures, and capsule self-test ergonomics

| Issue | Size | Files | Acceptance | Blocked by |
|---|---|---|---|---|
| **2.1** Lifecycle hooks (`before_each`/`after_each`/`before_all`/`after_all`) | M | `compiler/src/ast.sfn` (`TestDeclaration.hook_kind`), `compiler/src/parser/{mod,declarations}.sfn` (block syntax), `compiler/src/emit_native.sfn` (`emit_test` → `hook:<kind>` symbol), `compiler/src/llvm/lowering/lowering_core/test_harness.sfn` (harness wraps test calls); `capsules/sfn/test/tests/lifecycle_test.sfn` (capsule proof) | **Shipped (#975, compiler half + #978, docs/proof).** Lifecycle hooks are **language syntax** (block declarations: `before_each ![io] { ... }`), discovered statically by the harness synthesizer and lowered to **direct calls** — no runtime registry. A test file declaring a `before_each` block runs it before every `test` in that file (file-scoped). **No `capsules/sfn/test/src/lifecycle.sfn`** — a `before_each(hook: fn() ![io])` registration API was rejected (unbuildable without storable fn-values; slower indirect dispatch; non-deterministic order — see `03-capsule-api.md`). **Deferred (post-1.0):** cross-capsule hook composition — if pursued, compile-time in the harness synthesizer, not a runtime registry. | P1, 1.4 |
| **2.2** `with_tmp_dir`, `with_env`, `with_cwd` scoped fixtures | S | `capsules/sfn/test/src/fixtures.sfn` (new) | Closure-scoped resource setup: `with_tmp_dir(\|d\| { ... })` creates tmpdir, runs body, recursively removes on scope exit. Replaces ~20 ad-hoc `mktemp -d` invocations in shell tests. Requires closures-with-capture (existing 1.0 critical path Phase 2 prereq). | P5, 1.4, closures-with-capture |
| **2.3** Collection + struct equality matchers | S | `capsules/sfn/test/src/matcher.sfn` extends with `to_equal_array`, `to_equal_record` | **Shipped (#973) — free-function form.** `expect_eq_str_array` / `expect_eq_bool_array` (extending the existing `expect_eq_int_array`), all `![pure]` returning `MatchResult` with an index-of-first-mismatch (element) vs. length-mismatch diff message. The record-equality helper is the concrete `record_eq_flag_message` in `runtime/prelude.sfn` (boolean discriminator + string message — the `MatchResult` / `AssertFailure` shape the runner needs), registered in `compiler/src/llvm/runtime_helpers.sfn` (`native_signature: null`, no new C) so it resolves cross-module. **Deferred:** a *generic* `_struct_eq` / `to_equal_record` and the fluent `expect(x).to_equal_array(...)` builder — both blocked by generic-struct monomorphization (see 1.4). | 1.4 |
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
| **3.3** Soft-deprecate bare `assert` inside `test` blocks | S | Compiler addition: parser warning hook in `compiler/src/parser.sfn` (or `compiler/src/effect_checker.sfn` if context-tracking is easier there) emits `W0210: prefer expect()` for `assert false`/`assert <expr>` inside `test` blocks; opt-out flag `--allow-bare-assert` in `compiler/src/cli_main.sfn`. Spec change: extend `site/src/content/docs/docs/reference/spec/11-testing.md` with the deprecation. No semantics change for `assert` outside test blocks. | New tests use `expect`. Existing `assert false` keeps working. Removal scheduled post-1.0. | 1.4 |
| **3.4** `sfn test --watch` (file-mtime poller) | S | `compiler/src/cli_commands.sfn` adds a watch loop calling the runner periodically; interval `--watch-interval-ms` default 500ms. No fs-notify dep. | `sfn test --watch tests/` re-runs on `.sfn` mtime changes within the watch interval. | 1.1 |
| **3.5** Spec + `llms.txt` documentation | S | Extend the existing `site/src/content/docs/docs/reference/spec/11-testing.md` chapter with `expect()`, lifecycle, fixtures, snapshots, and CLI flags; the JSON schema section landed in P6. Preview chapter under `…/reference/preview/tests-future.md` covers Phase 4 (parallel/property/fuzz). `llms.txt` gains a "Testing your capsule" section. | `sailfin.dev/docs/reference/spec/11-testing` renders the new sections. `llms.txt` covers `expect`, lifecycle, JSON output, CLI flags. | 3.1, 3.2 |

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
