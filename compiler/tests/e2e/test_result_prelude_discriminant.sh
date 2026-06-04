#!/usr/bin/env bash
# End-to-end IR guard for prelude `Result` lowering (#1022, epic #371 R.2).
#
# Drives `sfn emit llvm` against a bare-prelude-`Result` fixture (no in-file
# enum, no import) and asserts the emitted IR carries a REAL discriminant:
# a `%Result` named type, an `icmp eq` tag test, a conditional `br i1`, and a
# payload `load`. This fails on the pre-#1021 (PR #1027) shape documented in
# #1020 — an unconditional `matchcase0 → matchmerge` chain with no `icmp`,
# no `%Result` type, and an `i8*` subject — directly catching the
# elision / no-discriminant miscompilation class.
#
# It is the IR-level companion to the runtime assertions in
# compiler/tests/unit/result_prelude_test.sfn. Kept as an e2e shell test (not a
# unit test) because importing the LLVM-lowering stack into a `_test.sfn` blows
# the per-test CI budget — see compiler/tests/unit/atomic_load_store_test.sfn.
#
# Usage:
#   compiler/tests/e2e/test_result_prelude_discriminant.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_result_prelude_discriminant.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/result_prelude_discriminant.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-result-prelude-XXXXXX)"
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

# ---- Prelude Result match lowers to a real discriminant + payload load ----
test_prelude_result_match_emits_discriminant() {
    local ll="$SCRATCH/result_prelude.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for result_prelude_discriminant.sfn"
        return 1
    fi

    local missing=0
    # A `%Result` layout must be emitted (pre-#1021: absent; subject was i8*).
    if ! grep -qE "%Result = type" "$ll"; then
        echo "[test]   missing '%Result = type' — prelude Result not registered in type context"
        missing=$((missing + 1))
    fi
    # The match must test the discriminant tag (pre-#1021: no icmp at all).
    if ! grep -qE "icmp eq" "$ll"; then
        echo "[test]   missing 'icmp eq' discriminant test (pre-#1021 matchcase→matchmerge shape)"
        missing=$((missing + 1))
    fi
    # The discriminant must drive a conditional branch (pre-#1021: unconditional br).
    if ! grep -qE "br i1 " "$ll"; then
        echo "[test]   missing conditional 'br i1' — match arms not selected by the tag"
        missing=$((missing + 1))
    fi
    # The payload must be read by value (pre-#1021: no payload load).
    if ! grep -qE "getelementptr" "$ll"; then
        echo "[test]   missing 'getelementptr' — no payload addressing emitted"
        missing=$((missing + 1))
    fi
    if ! grep -qE "load i64" "$ll"; then
        echo "[test]   missing 'load i64' payload read"
        missing=$((missing + 1))
    fi
    return "$missing"
}

# ---- Defence against the exact pre-#1021 degenerate shape ----
# Pre-#1021 the @unwrap_or body was an unconditional `matchcase0 → matchcase2
# → matchmerge` chain with no discriminant. Assert the function carries at
# least one `icmp` so a regression to the no-discriminant shape is caught even
# if some other module in the IR happens to contain an `icmp`.
test_unwrap_or_body_has_discriminant() {
    local ll="$SCRATCH/result_prelude_body.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for unwrap_or body check"
        return 1
    fi
    # Extract the @unwrap_or function body and assert it contains an icmp.
    # The emitter mangles the symbol (e.g. @unwrap_or__compiler__tests__...),
    # so match @unwrap_or as a prefix rather than requiring a trailing `(`.
    local body
    body="$(awk '/define .*@unwrap_or/{f=1} f{print} f&&/^}/{exit}' "$ll")"
    if [ -z "$body" ]; then
        echo "[test]   could not locate @unwrap_or in emitted IR"
        return 1
    fi
    if ! echo "$body" | grep -qE "icmp eq"; then
        echo "[test]   @unwrap_or has no 'icmp eq' — regressed to the pre-#1021 no-discriminant shape"
        echo "$body" | head -20
        return 1
    fi
    return 0
}

run_test "prelude Result match emits %Result + icmp discriminant + payload load" \
    test_prelude_result_match_emits_discriminant
run_test "@unwrap_or body carries a real discriminant icmp" \
    test_unwrap_or_body_has_discriminant

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
