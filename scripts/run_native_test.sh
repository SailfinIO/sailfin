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
#      the cleanup trap below removes it on success. The trap
#      preserves the scratch tree on FAILURE so post-mortem tooling
#      can inspect the partial `.ll` outputs, the `test.ll` source,
#      and any resolver dot-files that recorded what went wrong;
#      without that, the only debugging signal would be the
#      truncated `tail -10` of the test runner's combined output.
#      Set `SAILFIN_TEST_KEEP_SCRATCH=1` to preserve the tree even
#      on success (useful when bisecting a green-but-suspicious
#      test that's masking a partial flake).
#
# We still ensure `build/sailfin/` exists for persistent control
# flags (`.trace_test_runner`, `.dump_test_sources`,
# `.test_runner_active`) that callers create against the canonical
# path; `sfn test` reads those from `build/sailfin/` regardless of
# `SAILFIN_TEST_SCRATCH`.
mkdir -p build/sailfin
SAILFIN_TEST_SCRATCH="$(mktemp -d "${TMPDIR:-/tmp}/sfn-test-XXXXXX")"
export SAILFIN_TEST_SCRATCH
_sfn_test_cleanup() {
    rc=$?
    if [ "${SAILFIN_TEST_KEEP_SCRATCH:-0}" = "1" ]; then
        echo "[run_native_test] preserving scratch: $SAILFIN_TEST_SCRATCH (SAILFIN_TEST_KEEP_SCRATCH=1)" >&2
        return
    fi
    if [ "$rc" -ne 0 ]; then
        echo "[run_native_test] preserving scratch on failure: $SAILFIN_TEST_SCRATCH" >&2
        return
    fi
    rm -rf "$SAILFIN_TEST_SCRATCH"
}
trap _sfn_test_cleanup EXIT

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

# Retry policy. Issue #364 deleted the regex-classified retry that
# matched on stdout patterns like "no such file or directory" /
# "link failed" — those patterns are now redundant because the
# structured assert-fail record (see
# `runtime/native/src/sailfin_runtime.c:sailfin_assert_fail` and
# `compiler/src/cli_commands.sfn:_consume_assert_failure_record`)
# gives the runner an exit-code-driven failure path with typed
# attribution; transient I/O flakes still surface as a non-zero
# exit, but masking them via `case "$output"` regexes was hiding
# real compile failures and producing flake-like behavior.
#
# What stays: signal-kill retry (137 OOM, 139 segfault). These are
# transient under sustained CI memory pressure during the
# seedcheck phase of `make check`, and they don't depend on stdout
# inspection. Override with SAILFIN_TEST_RETRY=0 to disable
# retries entirely (useful when diagnosing flake vs real failure
# during perf work).
if [ "${SAILFIN_TEST_RETRY:-1}" != "0" ]; then
    if [ $RC_INNER -eq 137 ] || [ $RC_INNER -eq 139 ]; then
        echo "[test] RETRY: $BASENAME (exit code $RC_INNER, retrying once)"
        _run_once
    fi
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

# Issue #364: pass/fail is decided by exit code alone. The previous
# "grep stdout for fail|panic|error" heuristic produced false
# positives whenever a test legitimately printed those words (e.g. a
# test that prints the literal word "panic" as part of its
# assertions about diagnostic output). The compiler now writes a
# structured AssertFailure record on `assert false`, and the test
# runner inside `compiler/src/cli_commands.sfn` reads it before
# returning a non-zero exit code — so a clean exit IS a clean test.
echo "[test] PASS: $BASENAME"
exit 0
