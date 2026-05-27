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
#
# May 2026 (issue #689): emit_native_extern_test crept up to
# ~250s on the ubuntu-24.04 PR runner — that test imports the
# entire `emit_native` graph (transitively pulling in #686/#687/
# #689's lifting + closure-dispatch code), and is the largest
# deps-import in the unit suite. macOS already absorbs the spread
# because the runner image ships neither `timeout` nor `gtimeout`,
# so the per-test cap silently no-ops there. Linux enforces the
# cap, and three consecutive PR runs wedged at 180s → 240s → still
# 240s+. The fix bumps the default to 300s — five minutes is wide
# enough to absorb the linux runner's I/O variance without masking
# a hung process (the per-phase cap inside `compiler/src/main.sfn`
# trips long before 300s for any genuine infinite loop). A follow-
# up perf workstream should look at why this one test scales so
# poorly on cold-cache linux runners (local: ~20s, CI: ~250s).
TIMEOUT="${SAILFIN_TEST_TIMEOUT:-300}"

# macOS doesn't ship `timeout`; use gtimeout (coreutils) if available, else fallback
if command -v timeout &>/dev/null; then
    TIMEOUT_CMD="timeout"
elif command -v gtimeout &>/dev/null; then
    TIMEOUT_CMD="gtimeout"
else
    TIMEOUT_CMD=""
fi

# Issue #845 (parent epic #840 phase 1.1): the per-test pass/fail
# policy (signal-kill retry, FAIL/PASS banner, exit code) was ported
# from this wrapper into `handle_test_command` in
# `compiler/src/cli_commands.sfn`. The compiler now emits the
# `[test] PASS: <basename>` / `[test] FAIL: <basename> (exit code N)`
# banners directly, honours `SAILFIN_TEST_RETRY=0`, and retries
# 137/139 in-process; the prior `grep -nE ... <<< "$output"`
# diagnostic excerpt is superseded by the compiler's structured
# `test runner: compile failed`, `link failed`, and `test failed:`
# lines, which carry the per-stage attribution the grep heuristic
# was reconstructing post-hoc.
#
# What this wrapper still owns: scratch-dir setup with on-failure
# preservation (lines above), and the outer `timeout` wall-clock
# cap. The whole script is scheduled for deletion in phase 1.7
# after the Makefile loop collapse in 1.2.
if [ -n "$TIMEOUT_CMD" ]; then
    "$TIMEOUT_CMD" "$TIMEOUT" "$COMPILER" test "$TEST_FILE"
else
    "$COMPILER" test "$TEST_FILE"
fi
