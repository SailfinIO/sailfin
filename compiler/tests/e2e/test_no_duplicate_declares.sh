#!/usr/bin/env bash
# Regression: the emitted LLVM IR for a module must not contain exact-duplicate
# module-scope `declare` lines (PR #1062, issue #1059 follow-up).
#
# The runtime-helper preamble and the imported-function / inline-preamble
# declaration paths could each emit a byte-identical `declare <ret> @<sym>(...)`
# for the same symbol — e.g. `sfn_array_sfn_map`/`filter`/`reduce` are both
# registered runtime helpers AND `runtime/prelude.sfn` imports, so the prelude
# IR carried 28 duplicate declares. LLVM's library merges identical declares,
# but clang's textual-IR parser (`clang -c <module>.ll`, the path the test
# runner uses to build runtime objects via `_emit_runtime_sfn_to_obj`) rejects
# the repeat with "invalid redefinition of function", breaking a cold-clone
# `make test` for every test. The dedup pass in
# `compiler/src/llvm/lowering/lowering_core.sfn` (dedup_module_declare_lines)
# fixes it; this test pins the contract so it can't silently regress.
#
# Contract pinned (for the prelude, the densest declare consumer):
#   1. No exact-duplicate column-0 `declare ` lines in the emitted IR.
#   2. clang accepts the emitted IR (`clang -c` succeeds) — i.e. the textual
#      parser, not just the LLVM library, is happy.

set -euo pipefail

BINARY="${1:?usage: test_no_duplicate_declares.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE_SRC="$REPO_ROOT/runtime/prelude.sfn"
if [ ! -f "$MODULE_SRC" ]; then
    echo "[test] FATAL: missing fixture $MODULE_SRC"
    exit 2
fi

CLANG="${CLANG:-clang}"

SCRATCH="$(mktemp -d -t sfn-dupdecl-XXXXXX)"
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

LL="$SCRATCH/prelude.ll"

emit_prelude_ir() {
    # `emit llvm` lowers the module to a standalone .ll — the exact path
    # `_emit_runtime_sfn_to_obj` (cli_main.sfn) feeds to `clang -c`.
    "$BINARY" emit --module-name runtime/prelude -o "$LL" llvm "$MODULE_SRC" \
        > "$SCRATCH/emit.log" 2>&1
}

no_duplicate_declares() {
    if [ ! -s "$LL" ]; then
        echo "[test]   emit produced no IR:"
        cat "$SCRATCH/emit.log"
        return 1
    fi
    # Column-0 `declare ` lines only — function-body lines are indented and
    # never match. A duplicate is any line appearing more than once.
    local dups
    dups="$(grep '^declare ' "$LL" | LC_ALL=C sort | uniq -d || true)"
    if [ -n "$dups" ]; then
        echo "[test]   duplicate module-scope declares emitted:"
        printf '%s\n' "$dups" | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

clang_accepts_ir() {
    if ! command -v "$CLANG" > /dev/null 2>&1; then
        echo "[test]   (skip) clang not found on PATH — IR-acceptance check skipped"
        return 0
    fi
    if ! "$CLANG" -Wno-override-module -c "$LL" -o "$SCRATCH/prelude.o" \
        > "$SCRATCH/clang.log" 2>&1; then
        echo "[test]   clang rejected the emitted IR:"
        head -20 "$SCRATCH/clang.log" | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

if ! emit_prelude_ir; then
    echo "[test] FAIL: emit runtime/prelude.sfn -> LLVM IR"
    echo "[summary] 0 passed, 1 failed"
    exit 1
fi

run_test "prelude IR has no exact-duplicate module-scope declares" \
    no_duplicate_declares
run_test "clang -c accepts the emitted prelude IR" \
    clang_accepts_ir

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
