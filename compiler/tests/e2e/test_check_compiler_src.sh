#!/usr/bin/env bash
# End-to-end test for `sfn check` over the full compiler/src/ tree.
#
# This is the headline test for Phase 5a (`docs/proposals/phase-5a-arena-reset.md`)
# — the runtime arena mark/rewind primitive plus the path-normalization
# fix in `_collect_sfn_files_cmd` make the in-process multi-module
# loop reclaimable.
#
# Pre-Phase-5a, `sfn check compiler/src/` SIGSEGVed at ~120s on the
# 132-file tree: each `check_source_with_imports` call accumulated
# arena allocations (strings, AST nodes, typecheck tables) that
# never got freed. The seed compiler eventually walked off the
# allocator's edge.
#
# Acceptance:
#   - Exits 0 (clean) or 1 (diagnostics found). Never 139 (SIGSEGV).
#   - Completes in <300s wall under SAILFIN_USE_ARENA=1.
#   - Same exit code with and without a trailing slash on the
#     directory argument (regression for the path-normalization
#     fix).
#
# Usage:
#   compiler/tests/e2e/test_check_compiler_src.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_check_compiler_src.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SRC_DIR="$REPO_ROOT/compiler/src"

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

# Phase 5a needs the arena enabled to actually reclaim memory. The
# default-on flip is a separate workstream; until it lands, this
# test exports the env var explicitly so the headline scenario
# uses Phase 5a as designed.
export SAILFIN_USE_ARENA=1

# ---- Test 1: directory walk, no trailing slash ----
test_no_trailing_slash() {
    local rc=0
    if "$BINARY" check "$SRC_DIR" > /tmp/sfn-check-compiler-src-1.log 2>&1; then
        rc=0
    else
        rc=$?
    fi
    if [ "$rc" -eq 139 ]; then
        echo "[test]   SIGSEGV (rc=139) — Phase 5a regression"
        tail -5 /tmp/sfn-check-compiler-src-1.log
        return 1
    fi
    if [ "$rc" -ne 0 ] && [ "$rc" -ne 1 ]; then
        echo "[test]   unexpected exit $rc (expected 0 or 1)"
        tail -5 /tmp/sfn-check-compiler-src-1.log
        return 1
    fi
    if ! grep -q "^checked.*files" /tmp/sfn-check-compiler-src-1.log; then
        echo "[test]   no summary line — process did not complete cleanly"
        tail -5 /tmp/sfn-check-compiler-src-1.log
        return 1
    fi
    return 0
}
run_test "sfn check compiler/src (no trailing slash) completes" test_no_trailing_slash

# ---- Test 2: directory walk, trailing slash ----
# Regression-guard the path-normalization fix in `_collect_sfn_files_cmd`.
# Pre-fix, a trailing slash produced double-slashed paths
# (`compiler/src//ast.sfn`) that tripped downstream resolver
# logic into a SIGSEGV during the cross-iteration burst.
test_trailing_slash() {
    local rc=0
    if "$BINARY" check "$SRC_DIR/" > /tmp/sfn-check-compiler-src-2.log 2>&1; then
        rc=0
    else
        rc=$?
    fi
    if [ "$rc" -eq 139 ]; then
        echo "[test]   SIGSEGV (rc=139) — trailing-slash regression"
        tail -5 /tmp/sfn-check-compiler-src-2.log
        return 1
    fi
    if [ "$rc" -ne 0 ] && [ "$rc" -ne 1 ]; then
        echo "[test]   unexpected exit $rc (expected 0 or 1)"
        tail -5 /tmp/sfn-check-compiler-src-2.log
        return 1
    fi
    if ! grep -q "^checked.*files" /tmp/sfn-check-compiler-src-2.log; then
        echo "[test]   no summary line — process did not complete cleanly"
        tail -5 /tmp/sfn-check-compiler-src-2.log
        return 1
    fi
    return 0
}
run_test "sfn check compiler/src/ (trailing slash) completes" test_trailing_slash

# ---- Test 3: same-tree exit code parity ----
# Exit codes must match between the two forms — both are checking
# the same source tree. If they diverge, something path-dependent
# is in the analysis chain.
test_exit_code_parity() {
    local rc1=0
    if "$BINARY" check "$SRC_DIR" > /dev/null 2>&1; then
        rc1=0
    else
        rc1=$?
    fi
    local rc2=0
    if "$BINARY" check "$SRC_DIR/" > /dev/null 2>&1; then
        rc2=0
    else
        rc2=$?
    fi
    if [ "$rc1" -ne "$rc2" ]; then
        echo "[test]   no-slash exit=$rc1 vs trailing-slash exit=$rc2"
        return 1
    fi
    return 0
}
run_test "exit code matches with/without trailing slash" test_exit_code_parity

# ---- Test 4: file count matches the find ----
# Sanity check that the directory walk visits every .sfn file.
test_file_count() {
    local expected; expected=$(find "$SRC_DIR" -name '*.sfn' | wc -l)
    local actual; actual=$(grep -oE 'checked [0-9]+ files' /tmp/sfn-check-compiler-src-1.log | grep -oE '[0-9]+' | head -1)
    if [ "$actual" != "$expected" ]; then
        echo "[test]   file count mismatch: find=$expected, sfn check reported=$actual"
        return 1
    fi
    return 0
}
run_test "directory walk visits every .sfn file under compiler/src" test_file_count

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -ne 0 ]; then
    exit 1
fi
exit 0
