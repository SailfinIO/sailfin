#!/usr/bin/env bash
# End-to-end regression test for the re-export-of-imported-symbol bug.
#
# When `native_ir_utils_text.sfn` was changed to import `starts_with` /
# `strip_prefix` from `./string_utils` and re-export them via its
# `export { ... }` block without a local `.fn` definition, the emitter
# did not produce `.fn` signatures for those symbols in the
# re-exporter's `.sfn-asm`.  Consumers then lost the `i1` return type
# for the boolean helper, the lowering gave up with
# "unable to lower if condition" (emitted to stderr as a non-fatal
# trace diagnostic), and the `if` guard was dropped on the floor.
# `main.sfn` then tried to GEP an opaque `%Diagnostic` and llvm-as
# rejected the module.
#
# This test reproduces the shape at minimum size:
#   fixtures/reexport/origin.sfn  — defines the helpers
#   fixtures/reexport/middle.sfn  — only imports and re-exports them
#   fixtures/reexport/main.sfn    — imports from middle, uses them
#
# If the bug is present, the main binary prints one or more lines
# containing "FAIL" and this test fails.
#
# See docs/rca/2026-04-18-reexport-diagnostic-gep.md.
#
# Usage:
#   compiler/tests/e2e/test_reexport.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_reexport.sh <compiler-binary>}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN="$SCRIPT_DIR/fixtures/reexport/main.sfn"

PASS=0
FAIL=0

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

# Build + run produces output that the `if` branches in main.sfn
# write.  If any branch is mis-lowered the output includes "FAIL".
test_reexport_output() {
    local out_dir exe output
    out_dir="$(mktemp -d)"
    exe="$out_dir/reexport_main"
    # Build from the fixture directory so relative imports resolve.
    if ! (cd "$SCRIPT_DIR/fixtures/reexport" \
            && "$BINARY" build -o "$exe" main.sfn) > "$out_dir/build.log" 2>&1; then
        echo "build failed:"
        tail -40 "$out_dir/build.log"
        rm -rf "$out_dir"
        return 1
    fi
    if ! output="$("$exe")"; then
        echo "binary exited non-zero; output:"
        echo "$output"
        rm -rf "$out_dir"
        return 1
    fi
    rm -rf "$out_dir"
    if echo "$output" | grep -q FAIL; then
        echo "unexpected FAIL lines in output:"
        echo "$output"
        return 1
    fi
    # Sanity: the six expected "ok" lines are all present.
    local expected
    for expected in \
        bool-yes-ok \
        bool-no-ok \
        let-truthy-ok \
        let-falsy-ok \
        string-strip-ok \
        string-unchanged-ok; do
        if ! echo "$output" | grep -qx "$expected"; then
            echo "missing expected line: $expected"
            echo "actual output:"
            echo "$output"
            return 1
        fi
    done
    return 0
}

run_test "reexport: boolean guards survive cross-module re-export" test_reexport_output

echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
