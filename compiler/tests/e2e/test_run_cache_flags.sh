#!/usr/bin/env bash
# End-to-end test for `sfn run` cache flag plumbing (Stage C PR1d).
#
# Verifies that `sfn run` honours the same cache contract as
# `sfn build`:
#   - backwards-compat `sfn run <file>` (no flags) still works
#   - `--no-cache` suppresses the cache summary line
#   - `--clean` wipes `<cache_root>/v1/...` before building
#   - `--cache-trace` emits per-module `[cache hit/miss/store]` lines
#   - the cache stats summary fires after a successful run when the
#     cache was consulted
#
# Mirrors the `sfn build` flag surface from PR #256, so the two
# commands stay in lockstep. If either drifts, this test catches it.
#
# Usage:
#   compiler/tests/e2e/test_run_cache_flags.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_run_cache_flags.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-run-cache-flags-XXXXXX)"
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

# ---- Setup: a project depending on sfn/math so cache work happens ----
mkdir -p "$SCRATCH/src"
ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "run-cache-flags-test"
version = "0.1.0"
description = "E2E test for sfn run cache flag plumbing"

[dependencies]
"sfn/math" = "0.1.0"

[capabilities]
required = ["io"]

[build]
entry = "src/main.sfn"
EOF

cat > "$SCRATCH/src/main.sfn" <<'EOF'
import { abs } from "sfn/math";
fn main() ![io] {
    if abs(-7) != 7 { print("FAIL"); } else { print("OK"); }
}
EOF

CACHE_DIR="$SCRATCH/cache"

# ---- Test 1: backwards compat — `sfn run <file>` with no flags ----
test_run_backwards_compat() {
    cd "$SCRATCH" || return 1
    SAILFIN_BUILD_CACHE_DIR="$CACHE_DIR" "$BINARY" run src/main.sfn \
        > "$SCRATCH/run1.stdout" 2>&1
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn run exited with code $rc; output:" >&2
        cat "$SCRATCH/run1.stdout" >&2
        return $rc
    fi
    grep -q "^OK$" "$SCRATCH/run1.stdout"
}
run_test "sfn run <file> still works (no flags)" test_run_backwards_compat

# ---- Test 2: cold run prints summary with miss + store ----
test_first_run_summary() {
    grep -qE '^\[cache\] hits=0 misses=1 stores=1' "$SCRATCH/run1.stdout"
}
run_test "first run prints '[cache] hits=0 misses=1 stores=1'" test_first_run_summary

# ---- Test 3: warm run prints summary with a hit ----
test_warm_run_hit() {
    cd "$SCRATCH" || return 1
    SAILFIN_BUILD_CACHE_DIR="$CACHE_DIR" "$BINARY" run src/main.sfn \
        > "$SCRATCH/run2.stdout" 2>&1
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   warm run exited with code $rc; output:" >&2
        cat "$SCRATCH/run2.stdout" >&2
        return $rc
    fi
    grep -qE '^\[cache\] hits=1 misses=0' "$SCRATCH/run2.stdout"
}
run_test "warm run prints '[cache] hits=1 misses=0'" test_warm_run_hit

# ---- Test 4: --no-cache suppresses the summary line entirely ----
test_no_cache_suppresses_summary() {
    cd "$SCRATCH" || return 1
    SAILFIN_BUILD_CACHE_DIR="$CACHE_DIR" "$BINARY" run --no-cache src/main.sfn \
        > "$SCRATCH/run_no_cache.stdout" 2>&1
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   --no-cache run exited with code $rc; output:" >&2
        cat "$SCRATCH/run_no_cache.stdout" >&2
        return $rc
    fi
    grep -q "^OK$" "$SCRATCH/run_no_cache.stdout" || return 1
    # The summary line must NOT appear; lookup_attempted is false on
    # every module so cache_stats_is_empty short-circuits the print.
    if grep -qE '^\[cache\]' "$SCRATCH/run_no_cache.stdout"; then
        echo "[test]   --no-cache run produced a cache summary; output:" >&2
        cat "$SCRATCH/run_no_cache.stdout" >&2
        return 1
    fi
    return 0
}
run_test "sfn run --no-cache prints no '[cache]' summary" test_no_cache_suppresses_summary

# ---- Test 5: --cache-trace emits per-module trace lines ----
test_cache_trace_lines() {
    cd "$SCRATCH" || return 1
    SAILFIN_BUILD_CACHE_DIR="$CACHE_DIR" "$BINARY" run --cache-trace src/main.sfn \
        > "$SCRATCH/run_trace.stdout" 2>&1
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   --cache-trace run exited with code $rc; output:" >&2
        cat "$SCRATCH/run_trace.stdout" >&2
        return $rc
    fi
    grep -qE '^\[cache hit\] sfn/math/mod' "$SCRATCH/run_trace.stdout"
}
run_test "sfn run --cache-trace prints '[cache hit] sfn/math/mod'" test_cache_trace_lines

# ---- Test 6: --clean wipes cache and forces a fresh miss ----
test_clean_wipes_cache() {
    cd "$SCRATCH" || return 1
    # Sanity: cache_root must exist before --clean (populated by tests 1-2)
    [ -d "$CACHE_DIR/v1" ] || return 1
    SAILFIN_BUILD_CACHE_DIR="$CACHE_DIR" "$BINARY" run --clean src/main.sfn \
        > "$SCRATCH/run_clean.stdout" 2>&1
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   --clean run exited with code $rc; output:" >&2
        cat "$SCRATCH/run_clean.stdout" >&2
        return $rc
    fi
    # After --clean the build path repopulates the cache: miss + store,
    # NOT a hit.
    grep -qE '^\[cache\] hits=0 misses=1 stores=1' "$SCRATCH/run_clean.stdout"
}
run_test "sfn run --clean wipes the cache and rebuilds" test_clean_wipes_cache

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
