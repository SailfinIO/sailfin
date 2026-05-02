#!/usr/bin/env bash
# End-to-end test for the runtime/sfn/platform/libc.sfn skeleton.
#
# This is the headline smoke test for the post-#281 follow-up that
# proves the full extern-fn pipeline works on a realistic file —
# the first file in the path toward a pure-Sailfin runtime (see
# `docs/runtime_architecture.md` §2.9 "Platform Extern Declarations").
#
# Acceptance:
#   - `sfn check runtime/sfn/platform/libc.sfn` exits 0 (zero
#     diagnostics — every declaration must satisfy the C-ABI
#     accept-list enforced by E0801–E0805).
#   - `sfn fmt --check runtime/sfn/platform/libc.sfn` exits 0
#     (the file is canonical-formatted; the CI fmt step at
#     `.github/workflows/ci.yml:113` already covers `runtime/`,
#     but pinning it here means a regression surfaces in
#     `make test-e2e` before it reaches CI).
#   - `sfn emit llvm` produces a `declare` directive for every
#     extern in the skeleton. This is the architect's M1 fast-fail
#     criterion (§3.6) made executable.
#
# When this skeleton grows into a real imported module (M2),
# this test stays useful as a regression for the LLVM `declare`
# emission path.
#
# Usage:
#   compiler/tests/e2e/test_runtime_libc_skeleton.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_libc_skeleton.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/platform/libc.sfn"

# Use a single per-invocation scratch dir + named files inside it.
# `mktemp --suffix=.ll` is a GNU-only flag (BSD mktemp on macOS does
# not implement it); the `mktemp -d -t prefix-XXXXXX` form below is
# the portable pattern used elsewhere in `compiler/tests/e2e/`.
SCRATCH="$(mktemp -d -t sfn-libc-skeleton-XXXXXX)"
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
        echo "[test]   sfn check exited non-zero on libc.sfn:"
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
    local ll="$SCRATCH/libc.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed on libc.sfn"
        return 1
    fi
    # The 12 declarations expected today. When the skeleton grows,
    # extend this list — the goal is to catch a regression where an
    # extern silently stops emitting a `declare` directive (e.g. a
    # signature accidentally falls into a path that emits nothing).
    #
    # We anchor each match on the literal `(` that always follows
    # the symbol in an LLVM `declare` line (`declare i64 @write(`).
    # `\b` word-boundaries are GNU-only in ERE — BSD/macOS `grep -E`
    # treats `\b` as a backspace and would silently skip every
    # match — so anchoring on `(` keeps the regex portable without
    # giving up the false-positive guard (a partial-name match like
    # `@write_log(` cannot collide because the symbol-followed-by-`(`
    # form is unambiguous in LLVM IR).
    local missing=0
    for sym in malloc free realloc memcpy memcmp write read fopen fclose fread fwrite getenv; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in emitted IR"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

run_test "sfn check runtime/sfn/platform/libc.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/platform/libc.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces declare for every extern" test_emit_declares

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
