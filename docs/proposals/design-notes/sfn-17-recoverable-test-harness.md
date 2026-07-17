# SFN-17 — Recoverable test harness: per-test isolation + hook fail/error classification

Status: Draft (single-issue implementation design gate — `.claude/rules/proposals.md`)
Author: agent:compiler-architect
Issue: SFN-17
Date: 2026-07-17

## Problem

The synthesized `@main` test harness
(`compiler/src/llvm/lowering/lowering_core.sfn:153-374`) is a flat, branchless
sequence of `call void @sym()`. A failing `assert` runs
`runtime_assert_fail_fn` → `sailfin_assert_fail` (`runtime/sfn/assert.sfn:128`)
→ `sfn_raise_value_error` (`runtime/sfn/exception.sfn:472`) → libc `abort()`
(exit 134), killing the whole file's suite process on the first failure. A
failing lifecycle hook (`before_all`/`before_each`/`after_each`/`after_all`)
aborts identically and is misattributed to the first test (hooks are excluded
from `TestEntry`, so the runner's index-inference in `test_runner_json.sfn` /
`_emit_file_test_events` pins the failure to test 0).

## Decision: Option B — in-process setjmp/longjmp recovery in the harness

The harness wraps every hook/test call in a Sailfin-level exception frame at
synthesis time, reusing the proven inline-`setjmp` + branch shape that
`instructions_try.sfn` already emits for `try`/`catch`. The assert path is
rewired so that, **only when a frame is on the chain**, it routes through
`sfn_throw` (longjmp back to the harness) instead of `abort()`. The harness
catches, records a per-test/hook result to a results log, and continues. The
existing **file-level child-process boundary** (`_is_signal_exit`,
`_emit_crash_diagnostic`, `crash_attribution_test.sfn`) is retained unchanged as
the backstop for genuine crashes (SIGSEGV/SIGKILL) — Option B recovers the
assertion/hook-failure path only, which is exactly the AC surface.

### Why not Option A (per-test child re-exec)

- **Build cost is decisive.** The compiler's own suite runs through this harness
  during `make check` (the slow gate). Per-test re-exec multiplies process
  spawns by test count (and `-k` filtering recompiles per test, since it filters
  `TestDeclaration`s at compile time in `main.sfn::_filter_program_tests` —
  changing the binary and its cache key). Option B is single-process-per-file,
  zero added spawns, one cheap `setjmp` per test.
- **`before_all`/`after_all` semantics break.** Per-test re-exec runs `before_all`
  once *per test* (each child is a fresh process). Option B keeps them once per
  file naturally (they stay outside the per-test loop).
- **Crashes are already handled at file granularity.** Option A's only real edge
  over B is hard crashes, which the retained file-level boundary already covers.

### Why the assert-path rewire is self-host-safe

`make compile` (self-host) never exercises the assert runtime path — the
compiler folds its own asserts (`runtime/sfn/assert.sfn` header). The rewire is
gated on `sfn_exception_frame_head() != null`: with no frame on the chain
(every non-harness assert, every user program, and any old-seed-built harness
that pushes no frames) behavior is **byte-identical to today** (`fd2` message +
`abort()` + exit 134). Only a frame-pushing harness observes the catchable path.

## Design

### Runtime (`runtime/sfn/assert.sfn`)

1. A process global phase slot `sfn_test_phase: i64` (0=before_all, 1=before_each,
   2=test, 3=after_each, 4=after_all) and a failure counter `sfn_test_fail_count:
   i64`. New helpers reuse the existing `_assert_write_lit` / `_assert_write_stripped`
   fwrite discipline (no `string + i64`):
   - `sfn_test_set_phase(phase: i32) -> void`
   - `sfn_test_report_pass(name: * u8) -> void ![io]` — append `T\tpass\t<name>`.
   - `sfn_test_report_caught(name: * u8, msg: * u8) -> void ![io]` — read the
     phase slot and append the classified record; increment `sfn_test_fail_count`.
   - `sfn_test_report_skipped(name: * u8) -> void ![io]` — append a
     `before_all`-cascade failure record for one test; increment the counter.
   - `sfn_test_failures() -> i32` — return `sfn_test_fail_count` (for `@main`'s
     exit code).
2. `sailfin_assert_fail` (`:128`) unchanged through the SFAF write; then:
   ```
   if sfn_exception_frame_head() != null { sfn_throw(raise_msg); }
   else { sfn_raise_value_error(raise_msg); }   // unchanged fd2 + abort
   ```
   (`sfn_exception_frame_head` / `sfn_throw` already exported from
   `runtime/sfn/exception.sfn:228,347`.)

### Results-log wire format (`${SAILFIN_TEST_SCRATCH}/results.log`, append)

One record per line, tab-separated, values stripped of tab/newline by the writer:

```
T \t pass \t <test-name>
T \t fail \t <test-name> \t <message>
H \t fail \t <hook-kind> \t <test-name-or-empty> \t <message>
```

Phase → record (composed inside `sfn_test_report_caught`):

| phase | record |
|---|---|
| before_each (1) | `T fail <name> "hook before_each failed: <msg>"` (AC1) |
| test (2) | `T fail <name> <msg>` |
| after_each (3) | `H fail after_each <name> <msg>` (AC3) |
| before_all (0) | `H fail before_all "" <msg>` + per-test `T fail <name> "hook before_all failed"` via `sfn_test_report_skipped` |
| after_all (4) | `H fail after_all "" <msg>` (AC3) |

SFAF `fail.bin` is retained (append) for file:line:col enrichment of the JSON
`assertion` object; the runner zips the ordered SFAF records with the ordered
`T fail` records (exactly one assert fires per failed test — the first throw
unwinds).

### Harness synthesis (`lowering_core.sfn`) — per-region setjmp template

The harness is **fully unrolled** (one static block group per test/hook), so no
harness local is live across `setjmp` — the C11 "locals indeterminate after
longjmp" hazard does not arise. A single reused `frame`/`jmpbuf` alloca pair
(re-init + re-push per region, as `instructions_try.sfn` does per try) backs
every region.

Per test `i` (with optional `before_each`/`after_each`):
```
; RUN line (existing stderr marker)
; re-init frame slot 1 = jmpbuf addr, slot 2 (message) = 0
call void @sfn_exception_push_frame(i8* %frame.i8)
%sj = call i32 @setjmp(i8* %jmpbuf.i8)
%first = icmp eq i32 %sj, 0
br i1 %first, label %run_i, label %caught_i
run_i:
  call void @sfn_test_set_phase(i32 1)   ; before_each
  call void @<before_each_sym>()
  call void @sfn_test_set_phase(i32 2)   ; test
  call void @<test_sym>()
  call void @sfn_test_report_pass(i8* @.trn.i)   ; test body passed
  call void @sfn_test_set_phase(i32 3)   ; after_each
  call void @<after_each_sym>()
  call void @sfn_exception_pop_frame(i8* %frame.i8)
  br label %join_i
caught_i:
  %msg = call i8* @sfn_take_exception(i8* %frame.i8)   ; frame already popped by sfn_throw
  call void @sfn_test_report_caught(i8* @.trn.i, i8* %msg)
  br label %join_i
join_i:
```

`before_all` / `after_all` each get their own region. On `before_all` catch:
report the hook failure (phase 0), then branch to a cold `tests_skipped` block
that emits `sfn_test_report_skipped` for every test name, then jumps to the
`after_all` region — every test is attributed, the process never aborts.

`@main` epilogue returns a non-zero exit when anything failed (so the runner's
exit-code path still fires — recovery no longer implies exit 0):
```
%f = call i32 @sfn_test_failures()
%nz = icmp ne i32 %f, 0
%rc = select i1 %nz, i32 1, i32 0
ret i32 %rc
```

Declares: the harness must emit `declare` lines for `@setjmp`,
`@sfn_exception_push_frame`, `@sfn_exception_pop_frame`, `@sfn_take_exception`,
`@sfn_throw`, and the new `@sfn_test_*` symbols — **deduped** against declares
the base module already emitted (a test using `try`/`catch` already declares
`@setjmp`; a duplicate textual `declare` is an LL parse error). Scan `base.lines`
for each symbol before adding.

### Runner (`compiler/src/test.sfn` + new `test_results.sfn` + `test_runner_json.sfn`)

- New pure module `compiler/src/test_results.sfn`: `struct TestResultRecord
  { kind, status, name, hook, message }` + `parse_test_results_log(bytes) ->
  TestResultRecord[]` (mirrors `assert_failure.sfn`).
- `test.sfn`: after exec, read+delete `results.log`; classify each `TestEntry`
  from its `T` record by name (source of truth), not index-inference; emit test
  events in record order and a `hook` event per `H` record. `run_rc` still drives
  crash detection; results.log absent ⇒ old exit-code fallback. Human path prints
  a `[test] FAIL` per failed test and a `[test] HOOK FAIL: <kind>` per hook
  record, with correct counts.
- `test_runner_json.sfn`: add `render_hook_event(hook, test, status, message)`
  → `{"event":"hook","hook":...,"test":...,"status":"fail","message":...}`; a
  **new event kind ⇒ bump `TEST_RUNNER_JSON_SCHEMA_VERSION` 1 → 2** (AC4).

## Self-hosting impact

No seed cut. The harness (compiler source) and the report helpers (runtime
source) are both compiled from source in one `make compile` pass by the
compiler built from the old seed; the freshly-built compiler links the
freshly-compiled `assert.sfn`. No new symbol must pre-exist in the pinned seed.
Runtime helpers + harness + runner consumption ship in **one PR** (seed-dependency
bundling rule). `make compile` never emits the new harness (test-file-only path),
so the self-host binary is unaffected; `make check` is the gate for the harness
IR across the whole suite.

## Effect & capability impact

None. New runtime report helpers are `![io]` (file append), consistent with
`sailfin_assert_fail`. No effect-checker or capability change.

## Alternatives

- **Option A (per-test re-exec)** — rejected: recompile/respawn per test,
  `before_all` semantic break, suite slowdown.
- **Option C (hybrid)** — this design *is* B plus the retained file-level crash
  boundary; no new crash machinery is added.
- **Function-pointer runtime dispatcher** — rejected: `setjmp` must be inline in
  `@main` regardless, so a dispatcher wouldn't remove the hand-built IR and would
  add an unproven indirect-call FFI dependency.

## Stage1 readiness mapping

Parser/typecheck/effect: unchanged. Emit/lower: `lowering_core.sfn` harness. IR:
setjmp/branch template above. Tests: e2e (below). Self-host: one-PR bundle.
Docs: `docs/status.md` test-runner row + spec §11 (`sfn test --json` schema v2).

## Test plan (e2e, `compiler/tests/e2e`, extend the `#975` template)

1. **Continue-after-failure ≥2 tests** — fixture: test A asserts false, test B
   asserts true; assert both a fail marker for A and a pass/run marker for B
   appear, and exit code is non-zero.
2. **`before_each` fail classification** — fixture with a failing `before_each`
   and 2 tests; assert each test is failed with "hook before_each failed".
3. **`after_all` fail attribution** — assert the failure is reported against the
   hook (`after_all`), tests still reported.
4. **JSON hook-failure event** — `sfn test --json`; assert a `{"event":"hook",...
   "status":"fail"}` line and `schema_version:2`.

Extend `lifecycle_hook_ordering_test.sfn` / add peers; env-thread per
`.claude/rules/no-bash-e2e.md`.

## Risks

- **Malformed harness IR fails the whole suite** (`make check`). Mitigate:
  model the block template exactly on `instructions_try.sfn`; validate a
  single fixture with `sfn build` before running the suite.
- **Duplicate `declare`** — dedup against `base.lines` (above).
- **Recovery ⇒ exit 0 masking failures** — mitigated by `sfn_test_failures()`
  driving a non-zero `@main` return.
- **134 semantics** — harness asserts now exit 1 with a results.log; the 134
  carve-out (`_is_signal_exit`, SFN-87) remains correct for bare/uncaught aborts.

## References

- `compiler/src/llvm/lowering/lowering_core.sfn:135-374` (harness)
- `compiler/src/llvm/lowering/instructions_try.sfn:214-631` (setjmp template)
- `runtime/sfn/assert.sfn:128-172`, `runtime/sfn/exception.sfn:228,347,472`
- `compiler/src/test_runner_json.sfn`, `compiler/src/assert_failure.sfn`
- `compiler/src/cli/commands/test.sfn:1392-1519,1879-2258,2699-2726`
