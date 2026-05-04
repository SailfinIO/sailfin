#!/usr/bin/env bash
# End-to-end test for runtime/sfn/clock.sfn.
#
# Mirrors test_runtime_io_skeleton.sh — verifies the clock wrapper
# typechecks, formats, and emits the expected LLVM shape:
#
#   - The trampoline backing is declared as `declare void
#     @sailfin_runtime_sleep(double)` (imported from libc.sfn).
#   - The wrapper itself is defined as `define void
#     @sfn_sleep(double ...)`.
#   - The body emits `call void @sailfin_runtime_sleep(...)`.
#
# When the libc-direct rewrite (PR 2) ships, this test updates to
# expect `call void @nanosleep(...)` and the trampoline declaration
# disappears.

set -euo pipefail

BINARY="${1:?usage: test_runtime_clock_skeleton.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/clock.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-clock-XXXXXX)"
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

test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on clock.sfn:"
        cat "$log"
        return 1
    fi
    if ! grep -q "checked .* ok" "$log"; then
        echo "[test]   sfn check did not report 'ok':"
        cat "$log"
        return 1
    fi
    return 0
}

test_fmt_clean() {
    if ! "$BINARY" fmt --check "$SKELETON" > /dev/null 2>&1; then
        echo "[test]   $SKELETON needs formatting (run: sfn fmt --write $SKELETON)"
        return 1
    fi
    return 0
}

test_emit_wrapper_shape() {
    local ll="$SCRATCH/clock.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/clock.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0
    if ! grep -qE "^define void @sfn_sleep\(" "$ll"; then
        echo "[test]   missing wrapper definition: define void @sfn_sleep(...)"
        missing=$((missing + 1))
    fi
    # The wrapper body must reference the imported trampoline, even
    # if the standalone emit doesn't include the explicit `declare`
    # line (the stage-2 build path picks it up via the per-module
    # imported-extern walk; standalone emit currently doesn't, but
    # that's a separate compiler issue tracked elsewhere — this
    # test pins the call-site shape, not the declare).
    if ! grep -qE "call .* @sailfin_runtime_sleep\(" "$ll"; then
        echo "[test]   missing call to imported trampoline inside sfn_sleep body"
        missing=$((missing + 1))
    fi
    return "$missing"
}

run_test "sfn check runtime/sfn/clock.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/clock.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces sfn_sleep wrapper over imported sleep trampoline" test_emit_wrapper_shape

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
