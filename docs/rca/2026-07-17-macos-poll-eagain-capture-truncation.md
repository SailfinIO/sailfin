# RCA: macOS `poll(2)` EAGAIN Silently Truncated Captured Subprocess Output

- **Date:** 2026-07-17
- **Author:** Opus (with Michael Curtis)
- **Severity:** Low — a rare, non-deterministic e2e flake on macos-arm64; no shipped-binary miscompile, no self-hosting break. But the underlying defect is a genuine data-loss bug in the capture runtime.
- **Affected surface:** `process.run_capture` (and the `io.poll_readable` / `io.poll_any` helpers) on Darwin under memory pressure.
- **Resolved by:** SFN-391 — `_poll_err_retryable` treats Darwin's `poll` `EAGAIN` as retryable alongside `EINTR` in `runtime/sfn/process.sfn`.
- **Status:** Closed.

## TL;DR

`_drain_two_pipes` (`runtime/sfn/process.sfn`) drains a captured child's
stdout/stderr pipes with a `poll(2)` multiplex loop, then reaps the child with
`wait4`. The loop retried only on `EINTR`; **any other `poll` error `break`ed
out of the loop**, and the loop epilogue then closed both pipe read-ends *with
the child's bytes still buffered in the pipe*. `_growbuf_take` handed back a
zero-length buffer, and because `wait4` still reaped the cleanly-exited child,
`_run_capture_impl` returned exit `0`. Net effect: **`run_exit == 0` with an
empty/truncated capture** — exactly the observed symptom.

Darwin's `poll(2)` documents an error Linux's `poll` never returns:

> `[EAGAIN]` The allocation of internal data structures fails. A subsequent
> request may succeed.

Under whole-suite memory pressure this transient error fires occasionally. The
macos-arm64 `e2e-c` shard runs a full nested `sfn build` (clang + `llvm-link` +
linker, multi-GB RSS) per build-and-run test, and the test runner caps Darwin
concurrency at 2 (`compiler/src/cli/commands/test.sfn`), so two heavyweight
compiles peak together — precisely the window where the kernel can fail a
transient poll-table allocation. On Linux the errno never occurs, so Linux is
always green.

## Symptom

`compiler/tests/e2e/runtime_io_print_test.sfn` → test
`"io print: prefixes + fd routing are byte-exact end-to-end"`, observed on
PR #2405 (CI run 29582689307, macos-arm64 / e2e-c):

- The shard reported `passed: 249, failed: 1`, then `make: *** [test-shard] Error 134` (SIGABRT).
- Line 82 (`assert exit == 0`) **passed** — the probe built, ran, and exited 0.
- Line 90 (`assert find(out, "[info] alpha\n", 0) >= 0`) **failed** — the
  captured stdout, round-tripped through the marker file, was empty/truncated.
- `rerun_failed_jobs` went green; the PR merged. A flake, not a stable failure.

## Investigation

Three of the issue's candidate mechanisms were eliminated before the root cause
was found:

1. **Child stdio buffering — ruled out.** The probe's `print.*` path in
   `runtime/sfn/io.sfn` is raw unbuffered `write(2)` (`_sfn_write_all`,
   `_sfn_print_line`) with no userspace buffer and no atexit flush — every byte
   is synchronously in the pipe before the call returns. A prebuilt-probe repro
   harness looping `run_capture` + `capture_take_*` ~36,000 times (sequential
   and 8-way concurrent), plus 6,000 iterations with the marker
   `writeFile`/`readFile` round-trip, produced **zero** truncations.

2. **A race in the isolated drain logic — not reproducible.** See above; the
   capture is byte-exact under heavy looping in isolation, because the failure
   is a property of system-wide memory pressure at the instant of the `poll`
   call, not of the capture logic in isolation.

3. **A cross-test module-global race on `sfn_capture_stdout_addr` — impossible
   here.** `sfn test --jobs N` runs each test *file* as a separate child
   process (`compiler/src/cli/commands/test.sfn`; Darwin caps jobs at 2), and
   within a file tests run single-threaded, so the capture globals are never
   shared across concurrent captures.

That left the one code path that turns a transient kernel condition into silent
data loss: the `poll`-error arm of `_drain_two_pipes`.

## Root Cause

`_drain_two_pipes` retried only `EINTR`:

```sfn
let pr: i32 = poll(pbuf, 2 as usize, -1);
if pr < 0 {
    let err: i32 = ...errno...;
    if err == SFN_EINTR {
        // Interrupted — re-arm and poll again.
    } else { break; }   // <-- abandons the drain with data still unread
}
```

Darwin's transient `poll` `EAGAIN` (35 on Darwin; Linux's `poll` never returns
it) took the `else { break; }` branch. The epilogue closed both still-open read
ends, discarding the buffered bytes, and `_growbuf_take` returned empty. `wait4`
independently reaped the exit-0 child, so the exit code was correct while the
capture was empty.

The identical `EINTR`-only pattern existed in the two sibling poll loops,
`sfn_io_poll_readable` and `sfn_io_poll_any` (backing `io.poll_readable` /
`io.poll_any`), which would drop readiness on the same transient error.

### On the "co-occurring SIGABRT" (Error 134) — it is the failed assertion, not a second crash

The issue read the shard-level `Error 134` as evidence of a separate SIGABRT
(`128 + 6`). It is not a distinct failure: **exit 134 is the ordinary exit code
of a failed Sailfin assertion.** A failed `assert` calls
`sailfin_assert_fail` → `sfn_raise_value_error` (`runtime/sfn/assert.sfn:164`),
whose emission is `write(2) + abort()` (`runtime/sfn/exception.sfn`, cited at
`runtime/sfn/string.sfn:230`) — so every assertion failure terminates the test
process with `SIGABRT` → 134. The test runner special-cases exactly this
(`compiler/src/cli/commands/test.sfn:851/918/971`: "the ordinary exit code of a
failed assertion or abort()").

So the chain is a single failure:

```
poll EAGAIN drops buffered bytes → empty capture
  → assert find(out, "[info] alpha\n") >= 0  fails (line 90)
  → sfn_raise_value_error → abort()
  → exit 134   (the shard's "Error 134 / SIGABRT")
```

Removing the empty capture removes the assertion failure, which removes the
abort. There is no separate heap-corruption bug to chase: `libmalloc` aborts on
invalid-free, but the capture path's buffer arithmetic is bounds-correct
(`_growbuf_read_from` pre-grows to `cap >= len + 4097` before a ≤4096 read;
`_growbuf_take`'s terminator is always in-bounds) and no live double-free was
demonstrable on the two-`run_capture` sequence this test executes. (An earlier
hypothesis that the 134 came from a *different* concurrent test child is
superseded by this finding — the assertion's own abort is the simpler and
correct explanation.)

## Fix

`runtime/sfn/process.sfn` adds `SFN_EAGAIN_DARWIN` (35) / `SFN_EAGAIN_LINUX`
(11) and a `_poll_err_retryable(err)` helper, and the three `poll`-error arms
(`_drain_two_pipes`, `sfn_io_poll_readable`, `sfn_io_poll_any`) now re-arm and
re-poll on `EINTR` **or** `EAGAIN` instead of abandoning the wait. Accepting
both `EAGAIN` values is portable: the other-platform value can never be returned
by `poll` on a given host (35 = `ENOTEMPTY` / 11 = `EDEADLK` there). The
`read`/`write` `EINTR` retry sites are deliberately left unchanged — `EAGAIN`
there would mean a non-blocking fd, which these blocking pipes never are.

## Why no deterministic regression test

The trigger is a transient kernel allocation failure that cannot be forced from
a `*_test.sfn` without a `poll` fault-injection seam the runtime does not
expose. The existing `runtime_io_print_test.sfn` is the behavioral gate; the fix
is defended by inspection and the reasoning above rather than by a test that
manufactures `EAGAIN`. Adding a `poll`-fault-injection hook to the runtime is a
possible future hardening but is out of scope for a Low-priority de-flake.

## Lessons

- **A `poll`/`read`/`write` retry loop that special-cases `EINTR` must also
  consider `EAGAIN` on Darwin.** The Linux and macOS `poll` error sets differ;
  code that only ever ran green on Linux CI can carry a latent Darwin data-loss
  path. The `_poll_err_retryable` helper centralizes the classification so the
  three loops can't drift.
- **Silent truncation on a "fatal" branch is worse than an error.** The drain
  discarded captured output and still returned exit 0, so the only visible
  signal was a downstream assertion mismatch. A drain that cannot complete
  should surface it, not hand back a plausible-looking empty buffer.

## Links

- Linear: SFN-391
- Fix branch: `claude/sfn-391-deflake-runtime-io-print-capture`
- Discovered during: SFN-45 (PR #2405) pickup
- Files: `runtime/sfn/process.sfn` (`_drain_two_pipes`, `sfn_io_poll_readable`,
  `sfn_io_poll_any`, `_poll_err_retryable`); test
  `compiler/tests/e2e/runtime_io_print_test.sfn`
