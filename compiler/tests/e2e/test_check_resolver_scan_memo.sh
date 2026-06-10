#!/usr/bin/env bash
# Memory-bound regression test for #1247: the resolver's relative-import
# scan memo.
#
# `_cr_resolve_and_dedupe` walks relative imports once per entry path.
# Before #1247 each per-entry walk re-read and re-scanned every source
# in that entry's import closure through the allocation-heavy
# `collect_relative_import_specs` state machine — O(entries x closure)
# full-source scans whose arena garbage is allocated BEFORE the
# per-file loop's Phase 5a mark in `cli_check.sfn`, so the per-file
# rewind could never reclaim it. On the warm whole-tree
# `sfn check compiler/src/` this grew peak RSS by ~25MB per entry
# (~4.0GB across 158 files). The fix memoizes the per-unique-file scan
# (and the entry-independent dep CapsuleSource) across all entries of
# one resolution pass, making the resolver's arena footprint a
# function of the unique closure, not of the entry count.
#
# This test pins the bound with a synthetic project: a 10-module
# import chain of comment-padded (~48KB) modules, plus 40 tiny entry
# files that each import the head of the chain. It compares the
# arena page count (via SAILFIN_DUMP_ARENA_STATS) between a warm
# 5-entry check and a warm 40-entry check:
#
#   - pre-#1247: the extra 35 entries re-scan the 10-module chain
#     once each (~350MB of pre-mark arena, ~85 extra 4MiB pages).
#   - post-#1247: the chain is scanned once per run regardless of
#     entry count (delta is a handful of pages of per-entry BFS
#     bookkeeping + unchanged per-file analysis scratch).
#
# The threshold (24 pages = 96MB) sits ~3.5x away from both sides.
# NOTE: the bound is calibrated against the 4MiB default arena page
# size (`_init_global_arena` in runtime/native/src/sailfin_arena.c);
# if `SfnArenaPage` capacity changes, recalibrate the bound.
# A synthetic tree keeps this orders of magnitude cheaper than a
# second full-tree `sfn check compiler/src/` invocation (see the
# cost-discipline note in test_check_compiler_src.sh).
#
# Usage:
#   compiler/tests/e2e/test_check_resolver_scan_memo.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_check_resolver_scan_memo.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# Cap memory like every other compiler invocation in this repo. The
# pre-fix failure mode is a few hundred extra MB on this synthetic
# tree — well under the cap — so the cap only guards against runaway
# regressions, it never fires on the expected paths.
ulimit -v 8388608 2> /dev/null || true

SCRATCH="$(mktemp -d -t sfn-check-scan-memo-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

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

# ---- Setup: synthetic capsule with a shared 10-module import chain ----
mkdir -p "$SCRATCH/src"

# Stop discover_workspace_root from walking up into the live tree.
cat > "$SCRATCH/workspace.toml" <<'EOF'
[workspace]
members = []
EOF

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "check-scan-memo-test"
version = "0.1.0"
description = "E2E memory-bound test for the resolver scan memo (#1247)"

[capabilities]
required = []

[build]
entry = "src/entry_00.sfn"
EOF

# 600 comment lines (~48KB) of padding per chain module. The
# relative-import scanner walks every byte (comments included), so
# padding makes a redundant re-scan measurable in arena pages.
PADDING="$SCRATCH/padding.txt"
for i in $(seq 1 600); do
    printf '// padding line %04d: abcdefghijklmnopqrstuvwxyz0123456789 padding padding\n' "$i"
done > "$PADDING"

# Chain: common_00 -> common_01 -> ... -> common_09.
for i in $(seq 0 9); do
    idx="$(printf '%02d' "$i")"
    f="$SCRATCH/src/common_${idx}.sfn"
    if [ "$i" -lt 9 ]; then
        next="$(printf '%02d' $((i + 1)))"
        {
            printf 'import { chain_%s } from "./common_%s";\n\n' "$next" "$next"
            printf 'fn chain_%s() -> number { return chain_%s() + 1; }\n\n' "$idx" "$next"
            printf 'export { chain_%s };\n' "$idx"
            cat "$PADDING"
        } > "$f"
    else
        {
            printf 'fn chain_%s() -> number { return 9; }\n\n' "$idx"
            printf 'export { chain_%s };\n' "$idx"
            cat "$PADDING"
        } > "$f"
    fi
done

# 40 tiny entries, each importing the head of the chain.
for i in $(seq 0 39); do
    idx="$(printf '%02d' "$i")"
    f="$SCRATCH/src/entry_${idx}.sfn"
    {
        printf 'import { chain_00 } from "./common_00";\n\n'
        printf 'fn use_%s() -> number { return chain_00(); }\n\n' "$idx"
        printf 'export { use_%s };\n' "$idx"
    } > "$f"
done

cd "$SCRATCH"

# ---- Prime: stage the chain's import-context (cold run) ----
# One small invocation pays the cold staging cost so both measured
# runs below are warm (cache hits, no staging subprocesses).
if ! "$BINARY" check src/entry_00.sfn > "$SCRATCH/prime.out" 2> "$SCRATCH/prime.err"; then
    echo "[test] FATAL: prime run failed" >&2
    cat "$SCRATCH/prime.err" >&2
    exit 2
fi

# Run a warm check over the given entry files and echo the arena page
# count from the SAILFIN_DUMP_ARENA_STATS atexit line.
measure_pages() {
    local out_log="$1"
    local err_log="$2"
    shift 2
    if ! env SAILFIN_USE_ARENA=1 SAILFIN_DUMP_ARENA_STATS=1 \
        "$BINARY" check "$@" > "$out_log" 2> "$err_log"; then
        echo "[test]   check invocation failed:" >&2
        cat "$err_log" >&2
        return 1
    fi
    local pages
    pages="$(sed -n 's/.*\[sailfin-arena\].* pages=\([0-9]*\).*/\1/p' "$err_log" | tail -1)"
    if [ -z "$pages" ]; then
        echo "[test]   no arena-stats line in stderr:" >&2
        cat "$err_log" >&2
        return 1
    fi
    echo "$pages"
}

SMALL_ENTRIES=()
for i in $(seq 0 4); do
    SMALL_ENTRIES+=("src/entry_$(printf '%02d' "$i").sfn")
done
LARGE_ENTRIES=()
for i in $(seq 0 39); do
    LARGE_ENTRIES+=("src/entry_$(printf '%02d' "$i").sfn")
done

test_pages_growth_is_bounded() {
    local pages_small pages_large
    pages_small="$(measure_pages "$SCRATCH/small.out" "$SCRATCH/small.err" "${SMALL_ENTRIES[@]}")" || return 1
    pages_large="$(measure_pages "$SCRATCH/large.out" "$SCRATCH/large.err" "${LARGE_ENTRIES[@]}")" || return 1
    echo "[test]   5-entry pages=$pages_small 40-entry pages=$pages_large"
    if ! grep -q 'checked 5 files: ok' "$SCRATCH/small.out"; then
        echo "[test]   5-entry run did not report 'checked 5 files: ok':" >&2
        cat "$SCRATCH/small.out" >&2
        return 1
    fi
    if ! grep -q 'checked 40 files: ok' "$SCRATCH/large.out"; then
        echo "[test]   40-entry run did not report 'checked 40 files: ok':" >&2
        cat "$SCRATCH/large.out" >&2
        return 1
    fi
    local delta=$((pages_large - pages_small))
    if [ "$delta" -gt 24 ]; then
        echo "[test]   arena grew $delta pages between 5 and 40 entries (bound: 24)" >&2
        echo "[test]   the resolver is likely re-scanning the import closure per entry (#1247)" >&2
        return 1
    fi
    return 0
}
run_test "warm check arena pages grow sub-linearly with entry count" \
    test_pages_growth_is_bounded

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
