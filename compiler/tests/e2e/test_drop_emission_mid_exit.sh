#!/usr/bin/env bash
# End-to-end test for the M1.5.3 mid-function-exit drop seam (issue
# #327). Each `return` statement (and every other terminator covered by
# M1.5.3 — break / continue / loop-body close / match-arm close /
# block close) gets its own `call void @sfn_rc_release(...)` site
# whenever an owned RC local is in scope.
#
# What this script pins, end-to-end:
#
#   1. The compiler still emits `declare void @sfn_rc_release(i8*)` in
#      the module preamble (the M1.5.2 ABI seam survives).
#   2. A function with one explicit return emits exactly one release
#      call for the rc-promoted local.
#   3. A function with two explicit returns of the same heap-typed
#      local emits two release calls (the per-call temp suffix
#      guarantees uniqueness — no `%lN.drop` re-definition).
#   4. A `return` nested inside an `if-then` block also emits a release
#      site (i.e., the mid-exit path is hit, not just the tail return).
#
# Acceptance criterion #11 from issue #327: "greps the IR for the
# expected call sites on a forced-rc fixture." This script is that grep.
#
# Usage:
#   compiler/tests/e2e/test_drop_emission_mid_exit.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_drop_emission_mid_exit.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/drop_emission_mid_exit.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-mid-exit-XXXXXX)"
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

emit_ir() {
    local out="$1"
    "$BINARY" emit -o "$out" llvm "$FIXTURE" > /dev/null 2>&1
}

# Count release calls in the body of a single function. Walks until the
# closing `}` so sibling functions don't bleed into the count.
count_releases_in_function() {
    local ll="$1"
    local fn_pattern="$2"
    awk -v pat="$fn_pattern" '
        $0 ~ pat { flag=1 }
        flag { print }
        /^\}/ { if (flag) flag=0 }
    ' "$ll" | grep -cE 'call void @sfn_rc_release' || true
}

# ---- (1) declare line is still present ----
test_declare_line_present() {
    local ll="$SCRATCH/mid_exit.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed for drop_emission_mid_exit.sfn"
        return 1
    fi
    if ! grep -qE '^declare void @sfn_rc_release\(i8\*\)' "$ll"; then
        echo "[test]   missing 'declare void @sfn_rc_release(i8*)' in emitted IR"
        return 1
    fi
    return 0
}

# ---- (2) tail_return: exactly one release call ----
test_tail_return_one_release() {
    local ll="$SCRATCH/mid_exit_tail.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (tail_return case)"
        return 1
    fi
    local hits
    hits="$(count_releases_in_function "$ll" '^define i8\* @tail_return')"
    if [ "${hits:-0}" -ne 1 ]; then
        echo "[test]   tail_return expected 1 release call, got $hits"
        return 1
    fi
    return 0
}

# ---- (3) two_returns: two release calls (one per terminator) ----
test_two_returns_two_releases() {
    local ll="$SCRATCH/mid_exit_two.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (two_returns case)"
        return 1
    fi
    local hits
    hits="$(count_releases_in_function "$ll" '^define i8\* @two_returns')"
    if [ "${hits:-0}" -ne 2 ]; then
        echo "[test]   two_returns expected 2 release calls, got $hits "
        echo "         — one per explicit terminator (mid-exit + tail)"
        return 1
    fi
    return 0
}

# ---- (4) nested_if_return: two release calls (mid-exit + tail) ----
test_nested_if_return_two_releases() {
    local ll="$SCRATCH/mid_exit_nested.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (nested_if_return case)"
        return 1
    fi
    local hits
    hits="$(count_releases_in_function "$ll" '^define i8\* @nested_if_return')"
    if [ "${hits:-0}" -ne 2 ]; then
        echo "[test]   nested_if_return expected 2 release calls "
        echo "         (one inside the if-then, one at the tail), got $hits"
        return 1
    fi
    return 0
}

# ---- (5) drop temp names are uniquely suffixed ----
# Per M1.5.3, a function with multiple drop sites must NOT produce
# duplicate `%lN.drop` definitions — each call site appends a per-call
# counter (`%lN.drop.<temp_index>`). This is what unblocks LLVM's
# "unique value name per function" rule when the same scope closes at
# more than one terminator.
test_unique_drop_temp_names() {
    local ll="$SCRATCH/mid_exit_unique.ll"
    if ! emit_ir "$ll"; then
        echo "[test]   sfn emit llvm failed (unique-temps case)"
        return 1
    fi
    # Every drop temp must match the suffixed shape `%<slot>.drop.<n>`
    # (or `.drop_raw.<n>` for the bitcast variant). A bare `%lN.drop`
    # without the `.<n>` suffix would be the regression we're guarding.
    if grep -E '%l[0-9]+\.drop[[:space:]]*=' "$ll" > /dev/null; then
        echo "[test]   found a drop temp without a counter suffix — "
        echo "         M1.5.3 requires every drop to use '%<slot>.drop.<n>' so "
        echo "         multi-site drops do not collide."
        grep -E '%l[0-9]+\.drop[[:space:]]*=' "$ll" | head -3
        return 1
    fi
    # Confirm the suffixed form is in fact used (a fixture with no rc
    # locals would produce zero matches and silently pass — the
    # functions in this fixture all promote to rc).
    if ! grep -qE '%l[0-9]+\.drop\.[0-9]+[[:space:]]*=' "$ll"; then
        echo "[test]   no '%<slot>.drop.<n>' temps were emitted — "
        echo "         escape promotion or the M1.5.3 hooks are not firing"
        return 1
    fi
    return 0
}

# ---- (6) self-host smoke: hello-world.sfn still compiles cleanly ----
# A regression in the M1.5.3 hooks is most likely to surface as malformed
# IR — clang would reject it and the linker step in `run` would fail.
# `emit llvm` alone catches malformed-IR-vs-LLVM-textual-grammar
# failures; that's enough to catch the duplicate-name bug class.
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
    if ! grep -qE '^declare void @sfn_rc_release\(i8\*\)' "$ll"; then
        echo "[test]   hello-world.ll missing the runtime ABI declare"
        return 1
    fi
    return 0
}

run_test "compiler emits declare void @sfn_rc_release(i8*) for the fixture" \
    test_declare_line_present
run_test "tail_return emits exactly one release call" \
    test_tail_return_one_release
run_test "two_returns emits one release call per terminator" \
    test_two_returns_two_releases
run_test "nested_if_return emits a release at the mid-exit AND the tail" \
    test_nested_if_return_two_releases
run_test "drop temps use the '%<slot>.drop.<n>' suffix (no name collisions)" \
    test_unique_drop_temp_names
run_test "hello-world.sfn still compiles cleanly through the new hooks" \
    test_hello_world_smoke

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
