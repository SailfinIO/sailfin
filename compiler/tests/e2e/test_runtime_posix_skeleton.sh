#!/usr/bin/env bash
# End-to-end test for the runtime/sfn/platform/posix.sfn skeleton.
#
# Companion to test_runtime_libc_skeleton.sh — proves the extern-fn
# pipeline works on the POSIX surface used by the v0 process /
# clock / sleep adapters (see `docs/runtime_architecture.md`
# §2.7.4 "Clock Adapter" and the §2.7 process adapter). posix is
# the third platform skeleton; it exercises shapes the libc
# skeleton does not (primitive-pointer out-parameters `* i32`
# alongside opaque-struct pointers and `* * u8` argv/envp).
#
# Acceptance:
#   - `sfn check runtime/sfn/platform/posix.sfn` exits 0.
#   - `sfn fmt --check runtime/sfn/platform/posix.sfn` exits 0.
#   - `sfn emit llvm` produces a `declare` directive for every
#     extern in the skeleton.
#
# Usage:
#   compiler/tests/e2e/test_runtime_posix_skeleton.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_posix_skeleton.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/platform/posix.sfn"

SCRATCH="$(mktemp -d -t sfn-posix-skeleton-XXXXXX)"
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

# ---- Test: sfn check passes cleanly ----
test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on posix.sfn:"
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

# ---- Test: sfn fmt --check is clean ----
test_fmt_clean() {
    if ! "$BINARY" fmt --check "$SKELETON" > /dev/null 2>&1; then
        echo "[test]   $SKELETON needs formatting (run: sfn fmt --write $SKELETON)"
        return 1
    fi
    return 0
}

# ---- Test: every extern lowers to an LLVM declare directive ----
test_emit_declares() {
    local ll="$SCRATCH/posix.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed on posix.sfn"
        return 1
    fi
    # The 4 declarations expected today.
    local missing=0
    for sym in posix_spawnp waitpid clock_gettime nanosleep; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in emitted IR"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

run_test "sfn check runtime/sfn/platform/posix.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/platform/posix.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces declare for every extern" test_emit_declares

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
