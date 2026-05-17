#!/usr/bin/env bash
# Pins the LLVM declare/call shape for cross-module `: int` exports
# (issue #633).
#
# A `target == symbol` mirror row in `compiler/src/llvm/runtime_helpers.sfn`
# (e.g. the pre-fix `number_to_string` entry with
# `parameter_types: ["double"]`) would override the imported function's
# parameter types in `resolve_call_signature` and the imported declare
# would be skipped by `render_imported_function_declarations` in favor
# of the registry's `(double)` declare. After mangling, the cross-module
# declare/call landed as `@sym__<mod>(double)` against an `i64`-typed
# `define` — silent ABI mismatch.
#
# This test compiles a two-file fixture (one defines `: int` exports,
# the other imports + calls them) and asserts that the importer's IR
# carries `(i64)` declares and call sites. If the bug regresses, grep
# for `(double)` will find a hit and this test fails.
#
# Usage:
#   compiler/tests/e2e/test_cross_module_int_signature.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_cross_module_int_signature.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHARED_FIXTURE="$SCRIPT_DIR/fixtures/cross_module_int_signature_shared.sfn"
IMPORTER_FIXTURE="$SCRIPT_DIR/cross_module_int_signature_test.sfn"

if [ ! -f "$SHARED_FIXTURE" ]; then
    echo "[test] FAIL: missing fixture $SHARED_FIXTURE"
    exit 1
fi
if [ ! -f "$IMPORTER_FIXTURE" ]; then
    echo "[test] FAIL: missing importer $IMPORTER_FIXTURE"
    exit 1
fi

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-cross-int-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

# Stage the importer's import-context so `sfn emit llvm` resolves the
# `from "./fixtures/cross_module_int_signature_shared"` declaration.
mkdir -p "$SCRATCH/build/native/import-context/fixtures"
SHARED_ASM="$SCRATCH/build/native/import-context/fixtures/cross_module_int_signature_shared.sfn-asm"
IMPORTER_LL="$SCRATCH/importer.ll"

ulimit -v 8388608 2>/dev/null || true

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

emit_shared_asm() {
    if [ -s "$SHARED_ASM" ]; then return 0; fi
    if ! ( cd "$SCRATCH" && "$BINARY" emit \
            --module-name fixtures/cross_module_int_signature_shared \
            -o "$SHARED_ASM" native "$SHARED_FIXTURE" \
        ) > "$SCRATCH/shared.stderr" 2>&1; then
        echo "[test]   sfn emit native (shared fixture) failed"
        sed 's/^/[test]     /' "$SCRATCH/shared.stderr" | head -20
        return 1
    fi
    return 0
}

emit_importer_ll() {
    if [ -s "$IMPORTER_LL" ]; then return 0; fi
    emit_shared_asm || return 1
    if ! ( cd "$SCRATCH" && "$BINARY" emit \
            --module-name cross_module_int_signature_test \
            -o "$IMPORTER_LL" llvm "$IMPORTER_FIXTURE" \
        ) > "$SCRATCH/importer.stderr" 2>&1; then
        echo "[test]   sfn emit llvm (importer) failed"
        sed 's/^/[test]     /' "$SCRATCH/importer.stderr" | head -20
        return 1
    fi
    return 0
}

# Shared fixture's `.sfn-asm` records `: int` parameter annotations. The
# producer side is already correct upstream of #633; this assertion just
# pins it so a future regression on the emit-native side surfaces here
# instead of as a noisy IR mismatch downstream.
test_shared_asm_declares_int_parameters() {
    emit_shared_asm || return 1
    local hits
    hits="$(grep -cE '^\.param value: int' "$SHARED_ASM" || true)"
    if [ "${hits:-0}" -lt 2 ]; then
        echo "[test]   expected at least two .param entries with type int, got ${hits:-0}"
        sed 's/^/[test]     /' "$SHARED_ASM" | head -20
        return 1
    fi
    return 0
}

# The headline #633 assertion: importer-side declares for `: int`
# exports carry `(i64)` parameters, not `(double)`. The grep checks all
# three fixture symbols at once.
test_importer_declares_int_signatures() {
    emit_importer_ll || return 1
    local symbols=( \
        "cross_module_int_double" \
        "cross_module_int_sum_pair" \
        "cross_module_int_identity" \
    )
    local mod_suffix="fixtures__cross_module_int_signature_shared"
    local missing=0
    for sym in "${symbols[@]}"; do
        local mangled="${sym}__${mod_suffix}"
        local needle="^declare i64 @${mangled}\\("
        if ! grep -qE "$needle" "$IMPORTER_LL"; then
            echo "[test]   missing declare line: ${mangled}"
            missing=$((missing + 1))
        fi
    done
    if [ "$missing" -gt 0 ]; then
        echo "[test]   declares observed in importer IR:"
        grep -E '^declare .* @(cross_module_int_|cross_module_int_)' "$IMPORTER_LL" \
            | sed 's/^/[test]     /' | head -10
        return 1
    fi
    return 0
}

# Call sites must also use `(i64 ...)`. A regression where the declare
# is `(i64)` but the call site is `(double ...)` would still pass the
# previous test but produce a malformed IR; this guard pins both ends.
test_importer_call_sites_use_int() {
    emit_importer_ll || return 1
    local double_calls
    double_calls="$(grep -cE 'call .* @cross_module_int_[a-z_]+__fixtures__cross_module_int_signature_shared\(double' "$IMPORTER_LL" || true)"
    if [ "${double_calls:-0}" -gt 0 ]; then
        echo "[test]   regression: $double_calls cross-module call site(s) still use (double ...) instead of (i64 ...)"
        grep -nE 'call .* @cross_module_int_[a-z_]+__fixtures__cross_module_int_signature_shared\(' "$IMPORTER_LL" \
            | sed 's/^/[test]     /' | head -10
        return 1
    fi
    local int_calls
    int_calls="$(grep -cE 'call i64 @cross_module_int_[a-z_]+__fixtures__cross_module_int_signature_shared\(i64' "$IMPORTER_LL" || true)"
    if [ "${int_calls:-0}" -lt 1 ]; then
        echo "[test]   expected at least one (i64 ...) cross-module call site, got ${int_calls:-0}"
        grep -nE 'call .* @cross_module_int_[a-z_]+__fixtures__cross_module_int_signature_shared\(' "$IMPORTER_LL" \
            | sed 's/^/[test]     /' | head -10
        return 1
    fi
    return 0
}

run_test 'shared fixture .sfn-asm declares int parameters' \
    test_shared_asm_declares_int_parameters
run_test 'importer IR declares cross-module exports with (i64) parameters' \
    test_importer_declares_int_signatures
run_test 'importer IR call sites use (i64) arguments for cross-module : int exports' \
    test_importer_call_sites_use_int

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
