#!/usr/bin/env bash
# End-to-end test for runtime/sfn/clock.sfn.
#
# Mirrors test_runtime_io_skeleton.sh — runs four assertions against
# the clock wrapper:
#
#   1. typecheck   — `sfn check runtime/sfn/clock.sfn` reports `ok`.
#   2. fmt         — `sfn fmt --check runtime/sfn/clock.sfn` is canonical.
#   3. define shape — emitted IR contains `define void @sfn_sleep(...)`
#                     and `call void @sailfin_runtime_sleep(...)` in
#                     the wrapper body (matching the void-typed declare).
#   4. declare shape — emitted IR contains `declare void
#                     @sailfin_runtime_sleep(double)` at line start.
#                     The declare is currently produced by the helper
#                     preamble workaround in
#                     `compiler/src/llvm/lowering/lowering_helpers.sfn`
#                     (the `sailfin_runtime_sleep` entry); without
#                     this assertion, removing that entry would
#                     silently emit invalid IR.
#
# When the libc-direct rewrite (PR 2) ships, the define/declare/call
# assertions update to expect `call void @nanosleep(...)` and the
# trampoline declaration disappears.

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
    # The wrapper body must reference the imported trampoline with
    # the correct `void` return type matching the `declare void
    # @sailfin_runtime_sleep(double)` line. Pre-issue #306, the
    # silent `i8*` default for unresolvable callees produced
    # `call i8* @sailfin_runtime_sleep(...)` against the void
    # declare — structurally invalid IR that clang tolerated only
    # because the result was unused. The Phase A fix promotes the
    # silent default to a hard error, so this assertion now pins
    # the typed shape (`call void`), not just the symbol presence.
    if ! grep -qE "call void @sailfin_runtime_sleep\(" "$ll"; then
        echo "[test]   missing typed call to imported trampoline: call void @sailfin_runtime_sleep(...)"
        echo "[test]   --- call lines mentioning sailfin_runtime_sleep ---"
        grep -nE 'call.*@sailfin_runtime_sleep' "$ll" || true
        missing=$((missing + 1))
    fi
    # Belt-and-suspenders: explicitly forbid the pre-fix
    # `call i8*` shape from regressing.
    if grep -qE "call i8\* @sailfin_runtime_sleep\(" "$ll"; then
        echo "[test]   found pre-#306 'call i8* @sailfin_runtime_sleep(...)' shape — silent i8* default regressed:"
        grep -nE 'call.*@sailfin_runtime_sleep' "$ll" || true
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
    # Anchored to line start so the call site (`call void
    # @sailfin_runtime_sleep(...)`) does not accidentally satisfy
    # this assertion. The declare is currently emitted via the
    # `sailfin_runtime_sleep` entry in `seed_default_runtime_helpers`
    # (compiler/src/llvm/lowering/lowering_helpers.sfn); removing
    # that entry must trip this check, not pass it.
    if ! grep -qE "^declare void @sailfin_runtime_sleep\(double\)" "$ll"; then
        echo "[test]   missing imported trampoline declaration: declare void @sailfin_runtime_sleep(double)"
        echo "[test]   --- declare lines mentioning sailfin_runtime_sleep ---"
        grep -nE '^declare.*@sailfin_runtime_sleep' "$ll" || true
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/clock.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/clock.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces sfn_sleep wrapper over imported sleep trampoline" test_emit_wrapper_shape
run_test "sfn emit llvm declares sailfin_runtime_sleep trampoline" test_emit_declare_shape

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
