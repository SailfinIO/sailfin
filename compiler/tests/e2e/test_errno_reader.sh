#!/usr/bin/env bash
# End-to-end test for the Sailfin-native errno() reader (#876, epic #763).
#
# `runtime/sfn/platform/errno.sfn` declares `__errno_location() -> * i32`
# (glibc's thread-local errno locator) and an `errno() -> i32` helper that
# dereferences the returned pointer via the `sailfin_intrinsic_pointer_read_i32`
# registry sentinel (#875). The sentinel lowers directly to an LLVM `load i32`
# — there is no C symbol behind it. This test pins that shape against the
# *real shipped module* (not a scratch fixture):
#
#   1. typecheck  — `sfn check errno.sfn` reports `ok`. The bare intrinsic
#                   call resolves because its name is a runtime-helper call
#                   name seeded into the E0420 resolution scope; the extern
#                   passes the C-ABI accept-list (E0801–E0805).
#   2. locator    — emitted IR declares + calls `i32* @__errno_location()`.
#   3. load i32   — emitted IR contains `load i32, i32* %…` (the deref).
#   4. no call    — no `call` instruction targets the pointer-read sentinel.
#   5. no declare — no `declare …@sailfin_intrinsic_pointer_read_i32` line,
#                   so the sentinel never links to a nonexistent symbol.

set -euo pipefail

BINARY="${1:?usage: test_errno_reader.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
ERRNO_SFN="$REPO_ROOT/runtime/sfn/platform/errno.sfn"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-errno-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT
LL="$SCRATCH/errno.ll"

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
    if ! "$BINARY" check "$ERRNO_SFN" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on errno.sfn:"
        cat "$log"
        return 1
    fi
    return 0
}

test_emit() {
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$LL" llvm "$ERRNO_SFN" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on errno.sfn:"
        cat "$log"
        return 1
    fi
    return 0
}

test_locator_call() {
    if ! grep -qE 'call i32\* @__errno_location\(\)' "$LL"; then
        echo "[test]   missing 'call i32* @__errno_location()' in emitted IR"
        return 1
    fi
    return 0
}

test_load_i32() {
    if ! grep -qE 'load i32, i32\* %' "$LL"; then
        echo "[test]   missing 'load i32, i32* %…' (the errno deref) in emitted IR"
        return 1
    fi
    return 0
}

test_no_call_sentinel() {
    if grep -qE 'call .*@sailfin_intrinsic_pointer_read_i32' "$LL"; then
        echo "[test]   pointer-read sentinel was emitted as a 'call' rather than a 'load':"
        grep -nE 'call .*@sailfin_intrinsic_pointer_read_i32' "$LL"
        return 1
    fi
    return 0
}

test_no_declare_sentinel() {
    local n
    n="$(grep -cE 'declare .*@sailfin_intrinsic_pointer_read_i32' "$LL" || true)"
    if [ "$n" != "0" ]; then
        echo "[test]   expected 0 'declare …@sailfin_intrinsic_pointer_read_i32' lines, found $n:"
        grep -nE 'declare .*@sailfin_intrinsic_pointer_read_i32' "$LL"
        return 1
    fi
    return 0
}

run_test "sfn check passes on runtime/sfn/platform/errno.sfn" test_check_clean
run_test "sfn emit llvm produces IR" test_emit
run_test "errno() calls i32* @__errno_location()" test_locator_call
run_test "the deref lowers to 'load i32'" test_load_i32
run_test "pointer-read sentinel is not emitted as 'call'" test_no_call_sentinel
run_test "no 'declare' for the pointer-read sentinel" test_no_declare_sentinel

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
