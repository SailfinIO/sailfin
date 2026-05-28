#!/usr/bin/env bash
# End-to-end test for the pointer-read intrinsics (#875, epic #763).
#
# `sailfin_intrinsic_pointer_read_i32` / `_i64` are registry sentinels that
# lower directly to an LLVM `load` of the matching width — there is no C
# symbol behind them. This test pins that shape:
#
#   1. typecheck   — `sfn check <fixture>` reports `ok` (the intrinsics are
#                    declared as plain `extern fn`; no accept-list change).
#   2. load i32    — emitted IR contains `load i32, i32* %…` for the i32 read.
#   3. load i64    — emitted IR contains `load i64, i64* %…` for the i64 read.
#   4. no call     — no `call` instruction targets either sentinel symbol.
#   5. no declare  — no `declare …@sailfin_intrinsic_pointer_read_*` line, so
#                    the sentinel never links to a nonexistent symbol.
#   6. bitcast     — an `i8*` operand is bitcast to the matching pointer type
#                    before the load (the conditional-bitcast edge).

set -euo pipefail

BINARY="${1:?usage: test_pointer_read_intrinsic.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-pointer-read-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

FIXTURE="$SCRATCH/pointer_read.sfn"
# The intrinsics are called bare (no `extern fn`) — like the arena-mark
# prior art in `cli_check.sfn`. A bare call leaves no function entry, so the
# lowering fallback resolves it against the runtime-helper registry and the
# load-not-call branch fires. Declaring them `extern fn` would instead route
# the call through normal extern resolution and emit a stray `declare`.
cat > "$FIXTURE" <<'EOF'
extern fn malloc(size: usize) -> * u8;

fn read_i32(p: * u8) -> i32 {
    return sailfin_intrinsic_pointer_read_i32(p);
}

fn read_i64(p: * u8) -> i64 {
    return sailfin_intrinsic_pointer_read_i64(p);
}

fn main() -> void {
    let p: * u8 = malloc(8 as usize);
    let a: i32 = read_i32(p);
    let b: i64 = read_i64(p);
}
EOF

LL="$SCRATCH/pointer_read.ll"

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
    if ! "$BINARY" check "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on fixture:"
        cat "$log"
        return 1
    fi
    return 0
}

test_emit() {
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$LL" llvm "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on fixture:"
        cat "$log"
        return 1
    fi
    return 0
}

test_load_i32() {
    if ! grep -qE 'load i32, i32\* %' "$LL"; then
        echo "[test]   missing 'load i32, i32* %…' in emitted IR"
        return 1
    fi
    return 0
}

test_load_i64() {
    if ! grep -qE 'load i64, i64\* %' "$LL"; then
        echo "[test]   missing 'load i64, i64* %…' in emitted IR"
        return 1
    fi
    return 0
}

test_no_call() {
    if grep -qE 'call .*@sailfin_intrinsic_pointer_read_(i32|i64)' "$LL"; then
        echo "[test]   sentinel was emitted as a 'call' rather than a 'load':"
        grep -nE 'call .*@sailfin_intrinsic_pointer_read_(i32|i64)' "$LL"
        return 1
    fi
    return 0
}

test_no_declare() {
    local n
    n="$(grep -cE 'declare .*@sailfin_intrinsic_pointer_read_(i32|i64)' "$LL" || true)"
    if [ "$n" != "0" ]; then
        echo "[test]   expected 0 'declare …@sailfin_intrinsic_pointer_read_*' lines, found $n:"
        grep -nE 'declare .*@sailfin_intrinsic_pointer_read_(i32|i64)' "$LL"
        return 1
    fi
    return 0
}

test_bitcast_i8ptr() {
    # The i8* operand must be bitcast to the matching pointer type before
    # the load.
    if ! grep -qE 'bitcast i8\* %.* to i32\*' "$LL"; then
        echo "[test]   missing 'bitcast i8* … to i32*' for the i8* operand"
        return 1
    fi
    if ! grep -qE 'bitcast i8\* %.* to i64\*' "$LL"; then
        echo "[test]   missing 'bitcast i8* … to i64*' for the i8* operand"
        return 1
    fi
    return 0
}

run_test "sfn check passes on the pointer-read fixture" test_check_clean
run_test "sfn emit llvm produces IR" test_emit
run_test "i32 read lowers to 'load i32'" test_load_i32
run_test "i64 read lowers to 'load i64'" test_load_i64
run_test "sentinels are not emitted as 'call'" test_no_call
run_test "no 'declare' for the pointer-read sentinels" test_no_declare
run_test "i8* operand is bitcast to the matching pointer type" test_bitcast_i8ptr

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
