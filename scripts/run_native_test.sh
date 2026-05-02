#!/usr/bin/env bash
# Run a single Sailfin native test file.
#
# The compiler binary must be able to run tests directly.
# No fallbacks — if the binary can't run the test, it fails.
#
# Usage:
#   scripts/run_native_test.sh <compiler-binary> <test-file.sfn>

set -euo pipefail

COMPILER="$1"
TEST_FILE="$2"
BASENAME="$(basename "$TEST_FILE")"

# Per-invocation scratch dir, exported via `SAILFIN_TEST_SCRATCH` so
# the test command + capsule resolver write `test.ll`, the linked
# test exe, and per-module `capsules/<slug>.ll` under a path nobody
# else can touch. Two motivations:
#   1. Concurrent invocations no longer race on
#      `build/sailfin/capsules/<slug>.ll`. Pre-fix, two parallel
#      `sfn test` runs of the same test produced
#      `clang: error: no such file or directory: build/sailfin/capsules/parser__mod.ll`
#      ~50% of the time because each invocation's `rm -rf
#      build/sailfin` at the head of this script clobbered the
#      other's resolver output mid-flight.
#   2. Sequential test runs no longer need a destructive `rm -rf`
#      to guarantee isolation — each test owns its own tree, and
#      the cleanup trap below removes it on exit. That keeps the
#      previous test's artifacts available for post-mortem if the
#      *current* test fails (the compiler still writes its
#      diagnostics into the now-isolated scratch).
#
# We still ensure `build/sailfin/` exists for persistent control
# flags (`.trace_test_runner`, `.dump_test_sources`,
# `.test_runner_active`) that callers create against the canonical
# path; `sfn test` reads those from `build/sailfin/` regardless of
# `SAILFIN_TEST_SCRATCH`.
mkdir -p build/sailfin
SAILFIN_TEST_SCRATCH="$(mktemp -d "${TMPDIR:-/tmp}/sfn-test-XXXXXX")"
export SAILFIN_TEST_SCRATCH
trap 'rm -rf "$SAILFIN_TEST_SCRATCH"' EXIT

# Per-test wall-clock budget. Tight enough that hung binaries fail fast,
# loose enough that legitimate compiles don't get clipped on CI under
# memory pressure or with cold filesystem caches.
#
# History:
#   - 60s was the original bound when the compiler emitted IR via
#     fewer phases and front-end imports were textual.
#   - Stage B (April 2026) routed `sfn test` through the unified
#     resolver: each test now compiles its imported capsules to
#     LLVM IR before linking the test binary. For tests anchored on
#     subsystems with deep import graphs (effect_checker.sfn pulled
#     in by effect_*_test.sfn, gate_test.sfn) that work pushes
#     wall-clock into the 60–110s band locally and higher on CI.
#   - Effect-validation Phase A–F (April 2026) and Track B's B1
#     widened EffectRequirement / Expression variants, growing the
#     dependent-emission cost another ~15–25%.
#
# 180s is the working budget post-B1 — verified locally with
# effect_gate_test at ~100s and effect_imports_test at ~60s. The
# overrun caps at the test runner level (`compiler/src/main.sfn`
# enforces its own per-phase cap), so this just bounds the outer
# shell wait. Override with `SAILFIN_TEST_TIMEOUT=<seconds>` for
# investigations or perf work.
TIMEOUT="${SAILFIN_TEST_TIMEOUT:-180}"

# macOS doesn't ship `timeout`; use gtimeout (coreutils) if available, else fallback
if command -v timeout &>/dev/null; then
    TIMEOUT_CMD="timeout"
elif command -v gtimeout &>/dev/null; then
    TIMEOUT_CMD="gtimeout"
else
    TIMEOUT_CMD=""
fi

_run_once() {
    if [ -n "$TIMEOUT_CMD" ]; then
        output=$("$TIMEOUT_CMD" "$TIMEOUT" "$COMPILER" test "$TEST_FILE" 2>&1) && RC_INNER=0 || RC_INNER=$?
    else
        output=$("$COMPILER" test "$TEST_FILE" 2>&1) && RC_INNER=0 || RC_INNER=$?
    fi
}

_run_once

# Retry policy. Three classes of transient failure justify a retry:
#
#   1. Signal-kill (137 OOM, 139 segfault) — transient under CI memory
#      pressure. Original retry case.
#   2. Transient compile-emit failures — exit 1 with telltale patterns
#      indicating the compiler couldn't durably emit a capsule .ll
#      file or clang couldn't find one at link time. These manifest
#      under sustained memory/IO pressure during the seedcheck phase
#      of `make check` after the seedcheck binary has just consumed
#      ~5–10 minutes of resources building itself. Each test in
#      isolation passes; the same test in the long sequential loop
#      sometimes silently emits an empty/partial .ll that clang then
#      can't link. This is the same class of flake that
#      `scripts/build.sh` mitigates via `EMIT_RETRIES=3` for the seed
#      compile path. The patterns we match here are I/O-shaped, not
#      assertion-shaped, so we never mask real test-logic failures —
#      a missing-effect or wrong-line assertion failure would bubble
#      up as an `assertion failed` line that none of these patterns
#      catch.
#   3. Future: timeouts (124) — currently fail loud so we can spot
#      genuine compile-time regressions instead of papering over
#      them. Extend if/when needed.
#
# Override with SAILFIN_TEST_RETRY=0 to disable retries entirely
# (useful for diagnosing flakes vs real failures during perf work).
_should_retry_on_io_pressure() {
    if [ "${SAILFIN_TEST_RETRY:-1}" = "0" ]; then return 1; fi
    if [ $RC_INNER -ne 1 ]; then return 1; fi
    case "$output" in
        *"no such file or directory"*) return 0 ;;
        *"link failed"*) return 0 ;;
        *"fs.writeLines failed"*) return 0 ;;
        *"capsule-resolver: failed to lower"*) return 0 ;;
        *"empty llvm output"*) return 0 ;;
        *"emit-llvm-file:"*) return 0 ;;
    esac
    return 1
}

if [ $RC_INNER -eq 137 ] || [ $RC_INNER -eq 139 ]; then
    echo "[test] RETRY: $BASENAME (exit code $RC_INNER, retrying once)"
    _run_once
elif _should_retry_on_io_pressure; then
    echo "[test] RETRY: $BASENAME (transient I/O-pressure failure, retrying once)"
    _run_once
fi

if [ $RC_INNER -ne 0 ]; then
    echo "[test] FAIL: $BASENAME (exit code $RC_INNER, timeout=$TIMEOUT)"
    # When a test fails, the error of interest is rarely in the last 10 lines
    # — link errors land 100+ lines back, behind a wall of clang's
    # `-Woverride-module` warnings. Surface every line that smells like an
    # error or signal-shaped cause (clang/ld diagnostics, resolver retries,
    # missing files, OOM/abort), bounded to keep the CI log readable. The
    # tail of the output still prints last so failure summaries that rely
    # on the final lines (e.g. assertion messages) are not lost.
    diag="$(grep -nE '^(clang(-[0-9]+)?|sh|/usr/bin/ld|ld)\.?: |error:|undefined reference| no such file|Killed|Aborted|abort\(\)|munmap_chunk|capsule-resolver:|\[emit retry\]|\[cache (copy-failed|store-failed|invalid-key)\]|test runner: compile failed|link failed|test failed:' <<< "$output" | head -40)"
    if [ -n "$diag" ]; then
        echo "[test] -- diagnostic excerpt --"
        echo "$diag"
        echo "[test] -- /diagnostic excerpt --"
    fi
    echo "[test] -- last 10 lines of output --"
    echo "$output" | tail -10
    exit 1
fi

# The binary must produce SOME output — a silent exit is not a pass
if [ -z "$output" ]; then
    echo "[test] FAIL: $BASENAME (no output — binary is non-functional)"
    exit 1
fi

# Check for test pass indicators
if grep -qiE "pass|ok|success" <<< "$output"; then
    echo "[test] PASS: $BASENAME"
    exit 0
fi

# If there's output but no pass indicator, check for explicit failures.
# Use identifier-safe boundary matching to avoid false positives from
# identifiers like "runtime_raise_value_error_fn" in debug trace output.
# Avoids grep -P (PCRE) since BSD grep on macOS doesn't support it.
if grep -qiE '(^|[^[:alnum:]_])(fail(ed|ure)?|error|panic|abort)([^[:alnum:]_]|$)' <<< "$output"; then
    echo "[test] FAIL: $BASENAME"
    echo "$output" | tail -5
    exit 1
fi

# Output exists but no clear pass/fail — treat as pass (test ran without error)
echo "[test] PASS: $BASENAME"
exit 0
