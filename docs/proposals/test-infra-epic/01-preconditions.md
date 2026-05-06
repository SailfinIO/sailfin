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
