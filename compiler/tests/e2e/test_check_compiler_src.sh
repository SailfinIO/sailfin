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
#   - Directory walk visits every .sfn file under compiler/src/.
#
# Cost discipline: a single `sfn check compiler/src/` invocation
# runs the full 132-file analysis loop (~130s local, ~2-3 min CI).
# The test runs the canonical scenario exactly ONCE and reuses the
# captured exit code + summary line for every assertion. Earlier
# drafts re-invoked twice (once per slash form) and added ~2 min
# to PR CI; the trailing-slash regression is now covered cheaply
# by the unit test in compiler/tests/unit/cli_path_normalization_test.sfn.
# Do not re-introduce a second full-tree invocation.
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

# Phase 5a needs the arena enabled to actually reclaim memory.
# Arena is now default-on at runtime (post Phase 5a default-on
# flip), so this test runs in the canonical end-user configuration
# without exporting `SAILFIN_USE_ARENA=1`. We explicitly UNSET the
# env var to defend against a parent shell that might have set it
# to "0" or empty (which would silently disable the arena and
# either fail with SIGSEGV — `=0` — or succeed but fail the
# regression check we're actually trying to do).
unset SAILFIN_USE_ARENA

# ---- Single canonical run ----
# Capture stdout+stderr and the exit code; every assertion below
# operates on these captured artifacts. ONE invocation total —
# the trailing-slash regression is covered by a unit test on
# `_collect_sfn_files_cmd` (see header).
LOG="/tmp/sfn-check-compiler-src.log"

RC=0
"$BINARY" check "$SRC_DIR" > "$LOG" 2>&1 || RC=$?

# ---- Test: run completes (no SIGSEGV) ----
test_completes() {
    if [ "$RC" -eq 139 ]; then
        echo "[test]   SIGSEGV (rc=139) — Phase 5a regression"
        tail -5 "$LOG"
        return 1
    fi
    if [ "$RC" -ne 0 ] && [ "$RC" -ne 1 ]; then
        echo "[test]   unexpected exit $RC (expected 0 or 1)"
        tail -5 "$LOG"
        return 1
    fi
    if ! grep -q "^checked.*files" "$LOG"; then
        echo "[test]   no summary line — process did not complete cleanly"
        tail -5 "$LOG"
        return 1
    fi
    return 0
}
run_test "sfn check compiler/src completes (no SIGSEGV)" test_completes

# ---- Test: file count matches `find` ----
# Sanity check that the directory walk visits every .sfn file.
# Uses numeric comparison (`-ne`) rather than string comparison:
# macOS BSD `wc -l` left-pads its output (`     132`) while Linux
# GNU `wc -l` doesn't (`132`), and a string-equality test would
# treat the same count as a divergence. PR #251 first revision
# tripped this on macOS arm64.
test_file_count() {
    local expected; expected=$(find "$SRC_DIR" -name '*.sfn' | wc -l | tr -d '[:space:]')
    local actual; actual=$(grep -oE 'checked [0-9]+ files' "$LOG" | grep -oE '[0-9]+' | head -1)
    if [ "$actual" -ne "$expected" ] 2>/dev/null; then
        echo "[test]   file count mismatch: find=$expected, sfn check reported=$actual"
        return 1
    fi
    if [ -z "$actual" ] || [ -z "$expected" ]; then
        echo "[test]   file count empty: find='$expected', sfn check reported='$actual'"
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
