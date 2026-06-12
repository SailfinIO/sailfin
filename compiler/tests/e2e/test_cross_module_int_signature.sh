#!/usr/bin/env bash
# Pins the LLVM declare/call shape for cross-module `: int` exports
# (issue #633).
#
# A `target == symbol` mirror row in `compiler/src/llvm/runtime_helpers.sfn`
# (e.g. the `number_to_string` entry with
# `parameter_types: ["double"], return_type: "i8*"`) used to override
# the imported function's parameter types in `resolve_call_signature`
# and the imported declare was skipped by
# `render_imported_function_declarations` in favor of the registry's
# `(double)` declare. After mangling, the cross-module declare/call
# landed as `@sym__<mod>(double)` against an `i64`-typed `define` —
# silent ABI mismatch.
#
# This test compiles a two-file fixture (one defines `: int` exports
# AND a deliberately-colliding `number_to_string`, the other imports +
# calls them) and asserts that the importer's IR carries `(i64)`
# declares and call sites with the full parameter list pinned. If the
# bug regresses, grep for `(double)` will find a hit and this test
# fails.
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

# Module suffix used by the mangling phase for the shared fixture.
# Hard-coding it keeps the assertions surgical: any drift in the
# mangling scheme breaks this test loudly, which is the right outcome.
MOD_SUFFIX="fixtures__cross_module_int_signature_shared"

# Shared fixture's `.sfn-asm` records `: int` parameter annotations
# AND the colliding `number_to_string` export. The producer side is
# already correct upstream of #633; this assertion just pins it so a
# future regression on the emit-native side surfaces here instead of
# as a noisy IR mismatch downstream.
test_shared_asm_declares_int_parameters() {
    emit_shared_asm || return 1
    local int_params
    int_params="$(grep -cE '^\.param value: int' "$SHARED_ASM" || true)"
    if [ "${int_params:-0}" -lt 3 ]; then
        echo "[test]   expected at least three .param entries with type int (identity + double + number_to_string), got ${int_params:-0}"
        sed 's/^/[test]     /' "$SHARED_ASM" | head -30
        return 1
    fi
    if ! grep -qE '^\.fn number_to_string\(value: int\) -> int' "$SHARED_ASM"; then
        echo "[test]   expected number_to_string export header to read `.fn number_to_string(value: int) -> int`"
        grep -E '^\.fn number_to_string' "$SHARED_ASM" | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

# Headline #633 assertion: each cross-module declare carries the
# exact `(i64...)` parameter list — including the two-argument case
# and the colliding `number_to_string` row. Matching the full
# parameter list (not just the prefix) ensures a regression that
# emits `(double)` for any single argument fails this test.
test_importer_declares_int_signatures() {
    emit_importer_ll || return 1
    local missing=0

    # Single i64 parameter (`cross_module_int_double`,
    # `cross_module_int_identity`, and the colliding
    # `number_to_string`).
    local single_i64=( \
        "cross_module_int_double" \
        "cross_module_int_identity" \
        "number_to_string" \
    )
    for sym in "${single_i64[@]}"; do
        local mangled="${sym}__${MOD_SUFFIX}"
        local needle="^declare i64 @${mangled}\\(i64\\)$"
        if ! grep -qE "$needle" "$IMPORTER_LL"; then
            echo "[test]   missing or mismatched declare for ${mangled}: expected 'declare i64 @${mangled}(i64)'"
            grep -E "^declare .* @${mangled}\\(" "$IMPORTER_LL" \
                | sed 's/^/[test]     actual: /' | head -3
            missing=$((missing + 1))
        fi
    done

    # Two i64 parameters (`cross_module_int_sum_pair`).
    local pair_mangled="cross_module_int_sum_pair__${MOD_SUFFIX}"
    local pair_needle="^declare i64 @${pair_mangled}\\(i64, i64\\)$"
    if ! grep -qE "$pair_needle" "$IMPORTER_LL"; then
        echo "[test]   missing or mismatched declare for ${pair_mangled}: expected 'declare i64 @${pair_mangled}(i64, i64)'"
        grep -E "^declare .* @${pair_mangled}\\(" "$IMPORTER_LL" \
            | sed 's/^/[test]     actual: /' | head -3
        missing=$((missing + 1))
    fi

    if [ "$missing" -gt 0 ]; then
        return 1
    fi
    return 0
}

# Importer call sites must also use `(i64 ...)` arguments. A regression
# where the declare is `(i64)` but the call site is `(double ...)`
# would still pass the declare test but produce malformed IR; this
# guard pins both ends.
test_importer_call_sites_use_int() {
    emit_importer_ll || return 1
    local cross_pattern="@(cross_module_int_[a-z_]+|number_to_string)__${MOD_SUFFIX}"

    # No call site may pass `double` to any of our fixtures.
    local double_calls
    double_calls="$(grep -cE "call .* ${cross_pattern}\\(double" "$IMPORTER_LL" || true)"
    if [ "${double_calls:-0}" -gt 0 ]; then
        echo "[test]   regression: $double_calls cross-module call site(s) still use (double ...) instead of (i64 ...)"
        grep -nE "call .* ${cross_pattern}\\(" "$IMPORTER_LL" \
            | sed 's/^/[test]     /' | head -10
        return 1
    fi

    # Headline: the colliding `number_to_string` import must call with
    # `(i64 ...)`. Pinning the literal symbol AND the leading `i64`
    # argument keyword guards against the registry-driven `(double)`
    # regression specifically.
    local nts_int_calls
    nts_int_calls="$(grep -cE "call i64 @number_to_string__${MOD_SUFFIX}\\(i64 " "$IMPORTER_LL" || true)"
    if [ "${nts_int_calls:-0}" -lt 1 ]; then
        echo "[test]   expected at least one (i64 ...) call to the colliding number_to_string import"
        grep -nE "@number_to_string__${MOD_SUFFIX}\\(" "$IMPORTER_LL" \
            | sed 's/^/[test]     /' | head -10
        return 1
    fi

    # Sanity: every cross-module call must use `(i64 ...)` or `(i64,
    # i64 ...)`. The earlier negative grep covers `double`; this
    # positive grep ensures at least one matching call site exists per
    # fixture symbol so the test does not silently degrade if the
    # importer stops emitting calls altogether.
    local int_calls
    int_calls="$(grep -cE "call i64 ${cross_pattern}\\(i64" "$IMPORTER_LL" || true)"
    if [ "${int_calls:-0}" -lt 4 ]; then
        echo "[test]   expected at least four (i64 ...) cross-module call sites, got ${int_calls:-0}"
        grep -nE "call .* ${cross_pattern}\\(" "$IMPORTER_LL" \
            | sed 's/^/[test]     /' | head -10
        return 1
    fi
    return 0
}

# The colliding `number_to_string` import must NOT be shadowed by the
# `target == symbol` registry row's `(double)` declare. Specifically,
# the importer's IR must not contain a bare `declare i8* @number_to_string(double)`
# line. Pre-fix, the registry path emitted that line and the imported
# declare was skipped, producing a declare/define mismatch after
# mangling.
test_importer_does_not_emit_registry_double_declare() {
    emit_importer_ll || return 1
    local stray_double
    stray_double="$(grep -cE '^declare i8\* @number_to_string\(double\)' "$IMPORTER_LL" || true)"
    if [ "${stray_double:-0}" -gt 0 ]; then
        echo "[test]   regression: registry-driven 'declare i8* @number_to_string(double)' leaked into importer IR"
        grep -nE '@number_to_string\(' "$IMPORTER_LL" | sed 's/^/[test]     /' | head -5
        return 1
    fi
    return 0
}

run_test 'shared fixture .sfn-asm declares int parameters (incl. colliding number_to_string)' \
    test_shared_asm_declares_int_parameters
run_test 'importer IR declares cross-module exports with full (i64...) parameter lists' \
    test_importer_declares_int_signatures
run_test 'importer IR call sites use (i64) arguments for cross-module : int exports' \
    test_importer_call_sites_use_int
run_test 'importer IR does not emit the registry-driven (double) declare for colliding number_to_string' \
    test_importer_does_not_emit_registry_double_declare

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
