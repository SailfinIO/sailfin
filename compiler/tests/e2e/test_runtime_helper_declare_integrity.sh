#!/usr/bin/env bash
# Regression coverage for #892 — residual non-deterministic heap corruption
# in the runtime-helper collection → `declare` emission path (a residual of
# #740, surfaced by PR #890).
#
# Root cause (see runtime/native/src/sailfin_runtime.c sfn_str_eq): string
# `==` lowers to `call i1 @sfn_str_eq` (core_operands.sfn:125), an exported
# runtime boundary that was NOT bumping `_runtime_call_seq` at entry. The
# concat-reuse optimizer appends the next `+` in place into the previous
# concat's buffer while `_concat_reuse_seq == _runtime_call_seq`. The
# declare-line builder (rendering.sfn) chains concats interleaved with
# `string_array_contains` equality scans (utils.sfn:466). Because the
# equality check did not bump the sequence counter, the in-place reuse
# window survived across it, so a later concat could stomp a buffer a live
# `string[]` declare-target element still pointed at — clobbering the `@`
# byte (0x40) of an UNRELATED helper's declare with a stray byte (0xE7 in
# the CI failure on `@sailfin_runtime_is_void`).
#
# This test pins two invariants on the emitted IR:
#
#   1. declare integrity — EVERY emitted `declare` line carries a
#      well-formed `@<identifier>` function name. The clobber replaces the
#      `@` (or the first name byte) with a non-identifier byte, so a strict
#      regex over the declare block catches the exact corruption signature
#      regardless of WHICH helper got hit.
#
#   2. determinism under sweep — N back-to-back `emit llvm` runs on a
#      helper-declare-heavy module produce byte-identical IR. The bug is
#      heap-layout/timing dependent (passes in isolation, fails under
#      `make check` pressure), so a multi-sweep byte-compare is the
#      load-independent proxy: any in-place stomp perturbs the bytes.
#
# Modules chosen to maximize the runtime-helper declare block AND the
# equality-scan interleaving: `lowering_helpers.sfn` is the declare-loop
# consumer itself (~280 declares) and `parser/expressions.sfn` is a heavy
# expression module (the existing #399 emit-sweep target). The #890 trigger
# was `runtime_helper_abi_coercion_test.sfn`, but that unit imports
# compiler-internal symbols and is not emittable standalone — its `declare`
# block is the same one these modules emit, so the integrity + sweep
# assertions cover the identical code path without the cross-module
# signature-resolution noise.

set -euo pipefail

BINARY="${1:?usage: test_runtime_helper_declare_integrity.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
# The declare-loop consumer itself (collect_runtime_helper_targets_from_lines
# + the declare loop live here) — emits the largest runtime-helper declare
# block of any single module.
DECLARE_HEAVY="$REPO_ROOT/compiler/src/llvm/lowering/lowering_helpers.sfn"
# Heavy expression module (existing #399 emit-sweep target).
HEAVY="$REPO_ROOT/compiler/src/parser/expressions.sfn"
SWEEPS=30

SCRATCH="$(mktemp -d -t sfn-helper-declare-XXXXXX)"
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

# Assert every `declare` line in $1 has a well-formed `@<identifier>(` name.
# A clobbered `@` byte (e.g. `declare i1 <E7>sailfin_runtime_is_void(i8*)`)
# fails this because the name no longer starts with `@` + identifier-start.
assert_declares_wellformed() {
    local ll="$1"
    local bad
    # Match the negation: a `declare` line whose name token is NOT a clean
    # `@[A-Za-z_][A-Za-z0-9_.]*(`. grep -P for the well-formed shape, then
    # invert by counting declares that fail it.
    local total
    total="$(grep -c '^declare ' "$ll" || true)"
    if [ "${total:-0}" -eq 0 ]; then
        echo "[test]   no declare lines emitted in $ll (expected runtime helpers)"
        return 1
    fi
    # A well-formed declare: `declare <ret-and-attrs> @name(`.
    bad="$(grep '^declare ' "$ll" | grep -vE ' @[A-Za-z_][A-Za-z0-9_.]*\(' || true)"
    if [ -n "$bad" ]; then
        echo "[test]   malformed declare line(s) — clobbered function name:"
        printf '%s\n' "$bad" | head -10
        return 1
    fi
    return 0
}

emit_one() {
    local src="$1"
    local out="$2"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$out" llvm "$src" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on $src:"
        cat "$log"
        return 1
    fi
    return 0
}

# Emit $src $SWEEPS times; assert every sweep is byte-identical to the first
# AND every declare line is well-formed in each sweep.
sweep_byte_identical() {
    local src="$1"
    local tag="$2"
    local base="$SCRATCH/${tag}_base.ll"
    emit_one "$src" "$base" || return 1
    assert_declares_wellformed "$base" || return 1
    local i=0
    while [ "$i" -lt "$SWEEPS" ]; do
        local next="$SCRATCH/${tag}_${i}.ll"
        emit_one "$src" "$next" || return 1
        if ! assert_declares_wellformed "$next"; then
            echo "[test]   $tag sweep $i produced a clobbered declare"
            return 1
        fi
        if ! cmp -s "$base" "$next"; then
            echo "[test]   non-deterministic IR: $tag sweep $i differs from baseline"
            diff "$base" "$next" | head -20
            return 1
        fi
        i=$((i + 1))
    done
    return 0
}

# 1. Declare integrity on the declare-loop consumer module (largest block).
test_declare_consumer_wellformed() {
    local ll="$SCRATCH/consumer.ll"
    emit_one "$DECLARE_HEAVY" "$ll" || return 1
    assert_declares_wellformed "$ll" || return 1
    return 0
}

# 2. Declare integrity on the heavy expression module.
test_heavy_declares_wellformed() {
    local ll="$SCRATCH/heavy.ll"
    emit_one "$HEAVY" "$ll" || return 1
    assert_declares_wellformed "$ll" || return 1
    return 0
}

# 3. N-sweep byte-identical emit on the declare-loop consumer module.
test_consumer_sweep_byte_identical() {
    sweep_byte_identical "$DECLARE_HEAVY" "consumer"
}

# 4. N-sweep byte-identical emit on the heavy expression module.
test_heavy_sweep_byte_identical() {
    sweep_byte_identical "$HEAVY" "heavy"
}

run_test "declare-loop consumer module emits only well-formed declares" test_declare_consumer_wellformed
run_test "heavy expression module emits only well-formed declares" test_heavy_declares_wellformed
run_test "${SWEEPS}x declare-consumer emit-sweep is byte-identical with clean declares" test_consumer_sweep_byte_identical
run_test "${SWEEPS}x heavy-module emit-sweep is byte-identical with clean declares" test_heavy_sweep_byte_identical

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
