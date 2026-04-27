#!/usr/bin/env bash
# End-to-end test: build-path typecheck diagnostics use the unified
# `error[Exxxx]: --> file:line:col` shape, not the legacy `[typecheck]
# --> line N, column N` shape.
#
# Track B B4 (`docs/proposals/check-architecture.md`) deleted the
# in-`main.sfn` renderer chain (`format_typecheck_diagnostic`,
# `report_typecheck_errors`, `split_source_lines`, `build_pointer_line`,
# `join_lines` — ~150 lines) and routed every `compile_to_*` entry's
# 9 typecheck-error sites through `diagnostics_render.render_diagnostic`
# — the same renderer `sfn check` already uses (since A3). This test
# locks the unified shape: a typecheck-error fixture compiled via
# `sfn run` (build path) emits the new format, never the legacy.
#
# Usage:
#   compiler/tests/e2e/test_build_diagnostics_format.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_build_diagnostics_format.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-build-fmt-XXXXXX)"
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

# Fixture with a single typecheck error: duplicate `process` declaration.
# E0001 is the canonical duplicate-symbol diagnostic the `sfn check`
# e2e tests already exercise — using the same code here means both
# surfaces (build-path + check-path) are sharing the renderer.
cat > "$SCRATCH/dup.sfn" <<'EOF'
fn process(x: number) -> number {
    return x;
}

fn process(x: number) -> number {
    return x + 1;
}

fn main() {
    let _ = process(1);
}
EOF

# `sfn run` exercises the full build path (compile_to_llvm_with_module
# →`_emit_typecheck_diagnostics`). It exits non-zero on typecheck
# errors. Capture stderr; assertions run against it.
"$BINARY" run "$SCRATCH/dup.sfn" > "$SCRATCH/run.stdout" 2> "$SCRATCH/run.stderr" || true

# ---- Test 1: stderr carries the new error[Exxxx]: header ----
test_new_format_header_present() {
    if ! grep -qE "^error\[E0001\]:" "$SCRATCH/run.stderr"; then
        echo "[test]   expected 'error[E0001]:' header in stderr"
        echo "[test]   stderr:"
        head -10 "$SCRATCH/run.stderr"
        return 1
    fi
    return 0
}
run_test "build-path uses new error[E0001]: header" test_new_format_header_present

# ---- Test 2: stderr does NOT carry the legacy [typecheck] prefix ----
test_no_legacy_typecheck_prefix() {
    # The legacy `report_typecheck_errors` prefixed every line with
    # `[typecheck] `. Post-B4 the unified renderer instead emits a
    # `[kind: typecheck]` SUFFIX line. Distinguish by anchoring the
    # legacy pattern to start-of-line.
    if grep -qE "^\[typecheck\] " "$SCRATCH/run.stderr"; then
        echo "[test]   legacy '[typecheck] ' line-prefix still present"
        echo "[test]   stderr:"
        head -10 "$SCRATCH/run.stderr"
        return 1
    fi
    return 0
}
run_test "build-path does not emit legacy [typecheck] line-prefix" test_no_legacy_typecheck_prefix

# ---- Test 3: source-location line uses file:line:col, not "line N, column N" ----
test_unified_location_format() {
    # Unified format: `  --> <path>:<line>:<col>`
    # Legacy format:  `  --> line N, column N` (no file path)
    if ! grep -qE "^[[:space:]]*--> .+:[0-9]+:[0-9]+" "$SCRATCH/run.stderr"; then
        echo "[test]   no '--> file:line:col' line found"
        head -10 "$SCRATCH/run.stderr"
        return 1
    fi
    if grep -qE "^[[:space:]]*--> line [0-9]+, column [0-9]+" "$SCRATCH/run.stderr"; then
        echo "[test]   legacy '--> line N, column N' shape still present"
        head -10 "$SCRATCH/run.stderr"
        return 1
    fi
    return 0
}
run_test "build-path source-location uses unified file:line:col" test_unified_location_format

# ---- Test 4: caret line points at the duplicate identifier ----
test_caret_present() {
    # The unified renderer draws a `^^^^^^^` caret under the duplicate
    # identifier. Just assert at least one caret line exists.
    if ! grep -qE "\^\^+" "$SCRATCH/run.stderr"; then
        echo "[test]   no caret line found in stderr"
        head -10 "$SCRATCH/run.stderr"
        return 1
    fi
    return 0
}
run_test "build-path caret diagnostic present" test_caret_present

# ---- Test 5: kind suffix annotates the diagnostic as typecheck ----
test_kind_suffix() {
    if ! grep -qE "\[kind: typecheck\]" "$SCRATCH/run.stderr"; then
        echo "[test]   '[kind: typecheck]' suffix missing"
        head -10 "$SCRATCH/run.stderr"
        return 1
    fi
    return 0
}
run_test "build-path diagnostic carries [kind: typecheck] suffix" test_kind_suffix

# ---- Test 6: negative control — clean fixture produces no error[ header ----
cat > "$SCRATCH/clean.sfn" <<'EOF'
fn add(a: number, b: number) -> number {
    return a + b;
}

fn main() {
    let _ = add(1, 2);
}
EOF
test_clean_no_typecheck_error() {
    "$BINARY" run "$SCRATCH/clean.sfn" > "$SCRATCH/clean.stdout" 2> "$SCRATCH/clean.stderr" || true
    if grep -qE "^error\[E0001\]:" "$SCRATCH/clean.stderr"; then
        echo "[test]   clean fixture should not emit E0001"
        head -10 "$SCRATCH/clean.stderr"
        return 1
    fi
    return 0
}
run_test "negative control: clean fixture produces no E0001" test_clean_no_typecheck_error

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -ne 0 ]; then
    exit 1
fi
exit 0
