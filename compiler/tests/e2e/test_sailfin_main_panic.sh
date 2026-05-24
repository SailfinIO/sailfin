#!/usr/bin/env bash
# End-to-end test for the M5.3 `@main` lowering's top-level
# exception frame (#471). Builds a fixture whose `fn main` throws
# an uncaught exception, runs it, and asserts:
#
#   1. exit code 1   — the wrapper's catch landing pad returned
#                      `ret i32 1` instead of bubbling out to
#                      `sfn_throw`'s `abort()` path (which would
#                      exit with SIGABRT, not 1).
#   2. message printed — the wrapper called
#                      `sailfin_runtime_panic_emit(msg)` from the
#                      catch block; stderr carries the thrown
#                      string with a trailing newline.
#   3. no C shim       — `objdump --syms <bin> | grep _user_main_`
#                      returns empty. Confirms the user body was
#                      inlined into `@main` via the `internal` +
#                      `alwaysinline` linkage applied in
#                      `emission.sfn`, with no
#                      `sailfin_user_main__*` symbol surviving the
#                      -O2 link.

set -euo pipefail

BINARY="${1:?usage: test_sailfin_main_panic.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
FIXTURE="$REPO_ROOT/compiler/tests/e2e/fixtures/sailfin_main_panic_probe.sfn"
if [ ! -f "$FIXTURE" ]; then
    echo "[test] FATAL: missing fixture $FIXTURE"
    exit 2
fi

SCRATCH="$(mktemp -d -t sfn-main-panic-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

run_test() {
    local name="$1"
    shift
    if "$@"; then
        echo "[test] PASS: $name"
        PASS=$((PASS + 1))
    else
        echo "[test] FAIL: $name"
        FAIL=$((FAIL + 1))
    fi
}

# Same scratch-build pattern as test_sailfin_main_entry.sh — copy
# the fixture out of the repo tree so `sfn build` does not auto-
# discover `runtime/native/capsule.toml` and pull in native_driver.c's
# colliding `main`.
FIXTURE_COPY="$SCRATCH/sailfin_main_panic_probe.sfn"
PROBE_BIN="$SCRATCH/sailfin_main_panic_probe"
BUILD_LOG="$SCRATCH/build.log"

cp "$FIXTURE" "$FIXTURE_COPY"

build_fixture() {
    if ! "$BINARY" build -o "$PROBE_BIN" "$FIXTURE_COPY" > "$BUILD_LOG" 2>&1; then
        echo "[test]   sfn build failed on $FIXTURE_COPY:"
        cat "$BUILD_LOG"
        return 1
    fi
    if [ ! -x "$PROBE_BIN" ]; then
        echo "[test]   expected executable at $PROBE_BIN not produced"
        return 1
    fi
    return 0
}

test_panic_exit_code_one() {
    if ! build_fixture; then
        return 1
    fi
    local err_log="$SCRATCH/panic-err.log"
    local out_log="$SCRATCH/panic-out.log"
    local rc=0
    "$PROBE_BIN" > "$out_log" 2> "$err_log" || rc=$?
    if [ "$rc" -ne 1 ]; then
        echo "[test]   fixture exited with code $rc (expected 1 from uncaught throw)"
        echo "[test]   stdout:"
        cat "$out_log"
        echo "[test]   stderr:"
        cat "$err_log"
        return 1
    fi
    if ! grep -q "boom" "$err_log"; then
        echo "[test]   stderr did not contain the panic message 'boom':"
        cat "$err_log"
        return 1
    fi
    return 0
}

test_no_user_main_symbol() {
    if ! build_fixture; then
        return 1
    fi
    # Cross-platform: macOS uses `nm`, Linux uses `objdump --syms`.
    # The criterion in the issue body specifies objdump; fall back
    # to nm if objdump is unavailable so the test runs on macOS dev
    # boxes too. (CI is Linux so objdump is the canonical path.)
    local sym_log="$SCRATCH/symbols.log"
    if command -v objdump >/dev/null 2>&1; then
        objdump --syms "$PROBE_BIN" > "$sym_log" 2>&1 || true
    elif command -v nm >/dev/null 2>&1; then
        nm "$PROBE_BIN" > "$sym_log" 2>&1 || true
    else
        echo "[test]   neither objdump nor nm available; skipping symbol check"
        return 0
    fi

    if grep -qE 'sailfin_user_main__' "$sym_log"; then
        echo "[test]   binary still carries the synthesized internal symbol:"
        grep -E 'sailfin_user_main__' "$sym_log" | head -5
        return 1
    fi
    if grep -qE '\b_user_main_\b' "$sym_log"; then
        echo "[test]   binary carries an unexpected '_user_main_' symbol:"
        grep -E '\b_user_main_\b' "$sym_log" | head -5
        return 1
    fi
    return 0
}

run_test "uncaught throw exits with code 1 and stderr carries the message" \
    test_panic_exit_code_one
run_test "no sailfin_user_main__* symbol survives -O2 link" \
    test_no_user_main_symbol

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
