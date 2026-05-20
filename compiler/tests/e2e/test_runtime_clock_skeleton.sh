#!/usr/bin/env bash
# End-to-end test for runtime/sfn/clock.sfn.
#
# Pinned shape after PR 2 of the sleep migration (issue #397):
#
#   1. typecheck   — `sfn check runtime/sfn/clock.sfn` reports `ok`.
#   2. fmt         — `sfn fmt --check runtime/sfn/clock.sfn` is canonical.
#   3. define shape — emitted IR contains `define void @sfn_sleep(...)`
#                     whose body calls `@nanosleep` directly.
#   4. declare shape — emitted IR contains `declare i32 @nanosleep(...)`
#                     at line start.
#   5. no sailfin_runtime_sleep — the pre-PR2 C trampoline is gone;
#                     neither the import declaration nor the call
#                     site may resurface.

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
    # PR 2 (#397) rewired the body to call `nanosleep` directly.
    # The Sailfin struct lowering passes the `req` argument as a
    # `%Timespec*` and the optional `rem` as `%Timespec* null`.
    if ! grep -qE "call i32 @nanosleep\(" "$ll"; then
        echo "[test]   missing call to @nanosleep in @sfn_sleep body"
        echo "[test]   --- nanosleep mentions in emitted IR ---"
        grep -nE 'nanosleep' "$ll" || echo "[test]   (no @nanosleep references at all)"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_emit_declare_shape() {
    local ll="$SCRATCH/clock.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_wrapper_shape must run first to produce it"
        return 1
    fi
    # Anchored to line start so the call site (`call i32 @nanosleep(...)`)
    # does not accidentally satisfy this assertion. The declare is the
    # extern-fn lowering of `runtime/sfn/platform/posix.sfn::nanosleep`.
    if ! grep -qE "^declare i32 @nanosleep\(" "$ll"; then
        echo "[test]   missing imported nanosleep declaration: declare i32 @nanosleep(...)"
        echo "[test]   --- declare lines mentioning nanosleep ---"
        grep -nE '^declare.*@nanosleep' "$ll" || true
        return 1
    fi
    return 0
}

test_no_sailfin_runtime_sleep() {
    local ll="$SCRATCH/clock.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_wrapper_shape must run first to produce it"
        return 1
    fi
    # The pre-PR2 C trampoline is gone. Neither the wrapper body
    # nor the helper preamble may declare or call it — finding
    # either signals a partial revert.
    if grep -qE "@sailfin_runtime_sleep" "$ll"; then
        echo "[test]   stale reference to deleted @sailfin_runtime_sleep symbol:"
        grep -nE '@sailfin_runtime_sleep' "$ll"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/clock.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/clock.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces sfn_sleep wrapper over @nanosleep" test_emit_wrapper_shape
run_test "sfn emit llvm declares the nanosleep import" test_emit_declare_shape
run_test "sailfin_runtime_sleep is fully retired from clock.sfn emission" test_no_sailfin_runtime_sleep

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
