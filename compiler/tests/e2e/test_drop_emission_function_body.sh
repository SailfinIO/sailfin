#!/usr/bin/env bash
# End-to-end test for the function-body scope-exit drop seam (M1.5.2,
# issue #326). The compiler must:
#
#   1. Always emit `declare void @sfn_rc_release(i8*)` in the module
#      preamble so the runtime ABI is visible to downstream linkers
#      regardless of whether any local has `allocation_kind == "rc"`.
#   2. Emit zero `call void @sfn_rc_release(...)` lines today, because
#      M1.5.5 escape promotion has not yet populated `allocation_kind`
#      for any real binding — the seam is in place but the call sites
#      are inert until the promotion rule flips at least one local.
#
# The unit test (compiler/tests/unit/emit_scope_drops_test.sfn) is the
# load-bearing piece for the helper's per-binding decision logic; this
# script pins the runtime ABI integration end-to-end through the
# compiler driver.
#
# Usage:
#   compiler/tests/e2e/test_drop_emission_function_body.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_drop_emission_function_body.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/drop_emission_function_body.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-drop-emission-XXXXXX)"
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

# ---- (1) declare line is present in compiled IR ----
test_declare_line_present() {
    local ll="$SCRATCH/drop_emission.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for drop_emission_function_body.sfn"
        return 1
    fi
    if ! grep -qE '^declare void @sfn_rc_release\(i8\*\)' "$ll"; then
        echo "[test]   missing 'declare void @sfn_rc_release(i8*)' in emitted IR"
        echo "         (expected from lowering_phase_render.sfn unconditional declare)"
        return 1
    fi
    return 0
}

# ---- (2) zero call sites today (M1.5.2 ships the seam, not the calls) ----
test_zero_call_sites_until_m1_5_5() {
    local ll="$SCRATCH/drop_emission_calls.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for zero-call-sites case"
        return 1
    fi
    local hits
    hits="$(grep -cE 'call void @sfn_rc_release' "$ll" || true)"
    if [ "${hits:-0}" -ne 0 ]; then
        echo "[test]   expected 0 'call void @sfn_rc_release' lines, got $hits"
        echo "         (no local binding has allocation_kind == \"rc\" yet — "
        echo "          M1.5.5 will be the first PR that flips this)"
        return 1
    fi
    return 0
}

# ---- (3) hello-world also gets the declare (smoke check from issue) ----
test_hello_world_smoke() {
    local hello="$SCRIPT_DIR/../../../examples/basics/hello-world.sfn"
    if [ ! -f "$hello" ]; then
        echo "[test]   examples/basics/hello-world.sfn not found at $hello"
        return 1
    fi
    local ll="$SCRATCH/hello_world.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$hello" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for hello-world.sfn"
        return 1
    fi
    local declare_hits
    declare_hits="$(grep -cE '^declare void @sfn_rc_release\(i8\*\)' "$ll" || true)"
    if [ "${declare_hits:-0}" -ne 1 ]; then
        echo "[test]   expected exactly 1 'declare void @sfn_rc_release(i8*)' "
        echo "         in hello-world.ll, got $declare_hits"
        return 1
    fi
    return 0
}

run_test "compiler emits declare void @sfn_rc_release(i8*) for the fixture" \
    test_declare_line_present
run_test "compiler emits zero 'call void @sfn_rc_release' until M1.5.5" \
    test_zero_call_sites_until_m1_5_5
run_test "hello-world.sfn smoke-test exposes the runtime ABI declare" \
    test_hello_world_smoke

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
