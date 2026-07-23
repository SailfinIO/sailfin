# RCA: Nightly Self-Host `make check` — Roaming `print` Corruption from Immediate-Codepoint Misclassification

- **Date:** 2026-07-23
- **Author:** Michael Curtis
- **Severity:** Medium-High — three consecutive nightly `make check` failures
  (2026-07-21 through 2026-07-23). A latent runtime miscompile-under-load in
  the print path that can corrupt the output of *any* program printing a
  string, under concurrency — not a codegen or self-hosting break, but a real
  correctness bug in the shipped runtime.
- **Affected surface:** `sfn_print_*` in `runtime/sfn/io.sfn` (every
  `print.*`/`console.*` string output), surfacing via the parallel e2e pool in
  `nightly-selfhost.yml`.
- **Resolved by:** deleting the unsound 4 GiB-aligned-pointer clause in
  `_sfn_is_immediate` (`runtime/sfn/io.sfn`), branch
  `claude/nightly-selfhost-oom-governor`.
- **Status:** Closed.

## TL;DR

`sfn_print_*` classifies its argument with a legacy heuristic,
`_sfn_is_immediate`, meant to detect a pre-#822 "immediate codepoint" pseudo-
pointer. One clause returned `true` for **any real heap string pointer whose
low 32 bits are zero** (a 4 GiB-aligned allocation). When it fired, print took
a dead codepoint path that **ignores the string length** and emits
`pointer >> 32` as a single character — printing a control byte
(`\x04`/`\x05`/…) or nothing instead of the real string. The immediate
encoding was retired in #822, so codegen never produces one; the heuristic
could only ever produce false positives. Under concurrent-compile load the
arena's `malloc` page base occasionally lands on a 4 GiB boundary (ASLR / VM
churn), so a string pointer trips the clause ~1/80 at 8-wide concurrency —
idle it effectively never fires. Because the victim is whatever program
happened to print a 4 GiB-aligned string at that moment, the failure roamed
across unrelated e2e tests and both platforms, and survived every
cache/atomicity/env-isolation audit.

## Symptom

Last green nightly 2026-07-20, then red three nights, a different test each
night, alternating legs:

| Night | Failing test | Leg |
|---|---|---|
| 07-21 | `effectful_lambda_no_return_type_test.sfn:78` | macos-arm64 |
| 07-22 | `union_match_null_arm_test.sfn:60` + `concurrent_runtime_objkey_race_test.sfn:140` | macos-arm64 |
| 07-23 | `bench_compiler_test.sfn:36` | linux-x86_64 |

The recurring `undefined reference to 'main'` ICE on a `sub-NNN/program.ll`
under `[capsule-artifact-sidecar build]` was a separate, tolerated diagnostic
(the sidecar test's positional build, not asserted) and a red herring.

## Investigation

The rotating victim ruled out a deterministic codegen bug. Successive
hypotheses were tested and discarded by controlled reproduction:

1. **Memory/OOM (SFN-87 recurrence):** disproved — the failure reproduces
   deterministically enough at `--jobs 2` on a 16 GB host with retries off;
   parallelism-degree-independent.
2. **Env-leak cross-contamination:** several e2e tests do pass raw
   `process.environ()` into nested `sfn` runners (a real
   `.claude/rules/no-bash-e2e.md` violation), and this initially correlated
   (clean+clean 0/8 vs leaker+clean 1/8). But the "leaker" in that control was
   also the *burster* (`concurrent_runtime_objkey_race_test.sfn` runs multiple
   concurrent cold compiles), so the true variable was **concurrent-compile
   load**, not the env leak.
3. **Runtime-object cache race:** disproved — reproduces with the shared cache
   fully disabled (`SAILFIN_NO_CACHE=1`, private per-child scratch) at the same
   rate (no-cache 1/80 ≈ with-cache 1/80). All cache writes are atomic or
   miss-only-safe.

The captured corruption was `[info] \x04` / `\x05` / `\x06` / empty in place of
the expected marker string. Dissecting the artifact was decisive: the failing
binary is **byte-identical to a known-good one and re-runs correctly 5/5 in
isolation** (so not a baked-in miscompile), and the known-good binary itself
**flakes under heavy concurrent-compile load** (7 corruptions vs 48/48 clean
idle). That pins it to a runtime execution-time fault whose trigger is a
pointer *value*, not the program bytes.

`print.info("X")` lowers to a real heap `{ptr, len}` string
(`sfn_alloc_struct` + `store` + `{ptr, 1}`); no immediate is ever emitted
(#822). Yet `sfn_print_info` ran `_sfn_is_immediate` on the pointer, whose
clause `raw != 0 && (raw & 0xFFFFFFFF) == 0` returns `true` for a 4 GiB-aligned
heap pointer, routing to `_sfn_print_immediate`, which ignores `len` and prints
`raw >> 32` as one codepoint (the pointer's high bits → a small control value).

## Root Cause

`runtime/sfn/io.sfn` — `_sfn_is_immediate` misclassifies a real, 4 GiB-aligned
heap string pointer as a legacy immediate-codepoint pseudo-pointer, sending
`sfn_print_*` down a length-ignoring path (`_sfn_print_immediate`) that emits
`pointer >> 32` instead of the string. The immediate encoding is retired
(#822), so the heuristic produces only false positives; the fault is
load-dependent because the arena page `malloc` base only occasionally lands on
a 4 GiB boundary under ASLR/VM churn.

## Fix

Delete the unsound clause in `_sfn_is_immediate` (`runtime/sfn/io.sfn`):

```
    if raw != 0 && (raw & 4294967295) == 0 { return true; }   // removed
```

A real heap string pointer now always takes the correct `{ptr, len}` path. The
NULL/near-null guard (`raw <= 127`) is retained (harmless for real pointers;
preserves the historical NULL-string no-op). Runtime source, so `make compile`
rebuilds the runtime — a genuine "fix the runtime, not the build" fix.

## Verification (FAIL→PASS; requires `make compile`)

Reproduce against the concurrent-compile-load path (the pointer lottery only
fires under load):

```
# 8 concurrent cold `sfn run`s of distinct-string fixtures loading the host,
# while repeatedly re-running a known-good `print.info("MARK")` binary and
# grepping its output:
#   BEFORE: several "[info] \x0N" (or empty) corruptions
#   AFTER:  0
# Pool form (~4 iters):
SAILFIN_TEST_RETRY=0 build/bin/sfn test \
  compiler/tests/e2e/union_match_null_arm_test.sfn \
  compiler/tests/e2e/effectful_lambda_no_return_type_test.sfn \
  compiler/tests/e2e/concurrent_runtime_objkey_race_test.sfn --jobs 3
#   BEFORE: intermittent marker corruption;  AFTER: 0 failures
```

## Follow-ups (open)

- **Concurrent-compile main-less IR (separate bug, NOT fixed here):** under
  forced high concurrency (`--jobs 3`+), compiling a source file intermittently
  emits IR with no `@main` (`test.ll`/`program.ll`), so the link fails with
  `undefined reference to 'main'` and the enclosing test fails on its
  `exit == 0` assertion. This is distinct from the `\x04` runtime bug fixed
  here (it is a compile/link failure, not corrupted print output) and also
  contributed to the nightly (`union_match_null_arm_test.sfn:60`,
  `bench_compiler_test.sfn:36` are `exit == 0` checks). It is pre-existing on
  `main`. Root cause not yet determined — either a genuine emit race or a
  build-path isolation gap (the failing `test.ll` sits at the outer test
  scratch, not a per-child sub-dir). Needs its own investigation; tracked
  separately.
- **Retire the dead immediate path entirely:** `_sfn_is_immediate` and
  `_sfn_print_immediate` are dead since #822; fold all `sfn_print_*` onto
  `_sfn_print_line` directly and delete both, removing the whole false-positive
  class (the retained near-null guard included). Deferred as a focused cleanup
  because it touches the self-host-critical print hot path.
- **Test-isolation hygiene (orthogonal):** convert the e2e tests that feed raw
  `process.environ()` into a nested `sfn` runner over to
  `clean_runner_env(nested_runner_scratch(...))` per `.claude/rules/no-bash-e2e.md`.
  Not a cause of this incident, but a standing rule violation worth closing.

## Links

- Immediate-encoding retirement: #822
- Prior (unrelated) incident in the same suite: SFN-87 / #1726
- Fix branch: `claude/nightly-selfhost-oom-governor`
- Files: `runtime/sfn/io.sfn` (`_sfn_is_immediate`, `_sfn_print_immediate`),
  `runtime/sfn/memory/arena.sfn` (`_sfn_arena_page_create` — the `malloc` page
  base whose alignment triggers the misclassification)
