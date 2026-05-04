#!/usr/bin/env bash
# End-to-end test for the first Sailfin-native runtime service module.
#
# `runtime/sfn/platform/libc.sfn` proves standalone extern declarations
# emit LLVM `declare`s. This test proves a sibling runtime module can
# import those declarations and lower an actual call site against them.

set -euo pipefail

BINARY="${1:?usage: test_runtime_io_skeleton.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/io.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-io-XXXXXX)"
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
        echo "[test]   sfn check exited non-zero on io.sfn:"
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

test_emit_imported_extern_call() {
    local ll="$SCRATCH/io.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/io.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0
    if ! grep -qE "^declare .* @write\(" "$ll"; then
        echo "[test]   missing imported extern declaration for write"
        missing=$((missing + 1))
    fi
    if ! grep -qE "call i64 @write\(" "$ll"; then
        echo "[test]   missing imported extern call to write"
        missing=$((missing + 1))
    fi
    return "$missing"
}

run_test "sfn check runtime/sfn/io.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/io.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm lowers imported libc write call" test_emit_imported_extern_call

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
