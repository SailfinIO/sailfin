#!/usr/bin/env bash
# End-to-end test for the per-test binary cache (#1230, Lever 2 of
# docs/proposals/ci-test-speed.md).
#
# Proves the cross-invocation behaviors the native unit/integration
# tests cannot observe (those cover the cache-key correctness hinge and
# the JSON shape in-process). Here we run the `sfn test` binary multiple
# times and diff the `cache.test_bin_hit_rate` field in the `--json`
# summary:
#
#   1. Cold run  → every test misses (hit_rate 0.0000), and the binary
#      cache is populated.
#   2. Warm rerun (no source change) → every test hits (hit_rate 1.0000);
#      lower+link is skipped for each unchanged test.
#   3. `--no-test-cache` → both counters zero (hit_rate 0.0000); the
#      cache is neither read nor written.
#   4. Editing the test source → the next run misses again (a changed
#      source content-busts the key, so a stale binary is never served).
#
# Cache state is isolated under a scratch `SAILFIN_BUILD_CACHE_DIR` so
# the run starts genuinely cold and never pollutes the repo cache.
#
# Usage:
#   compiler/tests/e2e/test_test_bin_cache.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_test_bin_cache.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

if ! command -v jq >/dev/null 2>&1; then
    echo "[test] SKIP: jq not installed (required for --json validation)" >&2
    echo "═══ test-bin-cache: 0/0 passed, 0 failed (skipped) ═══"
    exit 0
fi

SCRATCH="$(mktemp -d -t sfn-test-bin-cache-XXXXXX)"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

# Test 5 rewrites build/native/.build-stamp to simulate a different
# commit. Capture the original bytes and restore them on exit (alongside
# the scratch cleanup) so a local dev tree's stamp is never poisoned.
STAMP_FILE="$REPO_ROOT/build/native/.build-stamp"
ORIG_STAMP=""
[ -f "$STAMP_FILE" ] && ORIG_STAMP="$(cat "$STAMP_FILE")"
restore_stamp() { [ -n "$ORIG_STAMP" ] && printf '%s\n' "$ORIG_STAMP" > "$STAMP_FILE"; }
trap 'rm -rf "$SCRATCH"; restore_stamp' EXIT

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

# ---- Setup: a standalone test directory (no capsule, no imports) ----
# A single test file keeps the runner on the in-process leaf path
# (test_files.length == 1, no per-file subprocess fan-out) so the cache
# read/write and the `cache` summary object are exercised directly.
TESTDIR="$SCRATCH/tests"
mkdir -p "$TESTDIR"
cat > "$TESTDIR/cache_fixture_test.sfn" <<'EOF'
test "trivial truth" {
    assert 1 == 1;
}
EOF

CACHE_DIR="$SCRATCH/cache"

# Run the suite under the isolated cache root and emit the summary line.
# The runtime root is resolved relative to the repo (the C driver injects
# --runtime-root for the in-tree `runtime/`), so cd into the repo root.
run_suite() {
    local extra="$1"
    cd "$REPO_ROOT" || return 1
    SAILFIN_BUILD_CACHE_DIR="$CACHE_DIR" \
        "$BINARY" test "$TESTDIR" --json $extra 2>/dev/null \
        | jq -c 'select(.event == "summary")'
}

# ---- Test 1: cold run misses, hit_rate 0.0000 ----
test_cold_miss() {
    local summary
    summary="$(run_suite "")" || return 1
    echo "[test]   cold summary: $summary" >&2
    [ "$(echo "$summary" | jq -r '.cache.test_bin_hits')" = "0" ] || return 1
    [ "$(echo "$summary" | jq -r '.cache.test_bin_misses')" -ge 1 ] || return 1
    [ "$(echo "$summary" | jq -r '.cache.test_bin_hit_rate == 0')" = "true" ] || return 1
    # The test itself must pass — a hit must serve a runnable binary.
    [ "$(echo "$summary" | jq -r '.passed')" -ge 1 ] || return 1
    return 0
}
run_test "cold run: every test misses, hit_rate 0.0000" test_cold_miss

# ---- Test 2: warm rerun hits, hit_rate 1.0000 ----
test_warm_hit() {
    local summary
    summary="$(run_suite "")" || return 1
    echo "[test]   warm summary: $summary" >&2
    [ "$(echo "$summary" | jq -r '.cache.test_bin_hits')" -ge 1 ] || return 1
    [ "$(echo "$summary" | jq -r '.cache.test_bin_misses')" = "0" ] || return 1
    [ "$(echo "$summary" | jq -r '.cache.test_bin_hit_rate == 1')" = "true" ] || return 1
    # The cached binary is still RUN (variant 2a) — the test still passes.
    [ "$(echo "$summary" | jq -r '.passed')" -ge 1 ] || return 1
    return 0
}
run_test "warm rerun: every test hits, hit_rate 1.0000" test_warm_hit

# ---- Test 5: cross-commit stability (#1233) ----
# The per-test binary cache identity is the commit-STABLE capsule version
# (`resolve_test_bin_identity_for_cache` strips the `+dev.<hash>` build
# metadata), so a `push:main` baseline warms a PR and a second push
# reuses the first's binaries. We can't change the real git hash in a
# hermetic test, so simulate the commit change the way the bug was first
# diagnosed: overwrite build/native/.build-stamp with a DIFFERENT
# `+dev.<hash>` at the SAME capsule version, then assert the warm cache
# (populated under the original stamp in Tests 1-2) still HITS. Before
# the fix this missed (the per-commit hash busted every entry).
test_cross_commit_stable() {
    if [ -z "$ORIG_STAMP" ]; then
        echo "[test]   SKIP: no build/native/.build-stamp to rewrite" >&2
        return 0
    fi
    # Rewrite only the build-metadata: keep everything before the first
    # `+`, append a distinct `+dev.<hash>`. A stamp with no `+` (a tagged
    # release) gets one appended — still a different stamp, same version.
    local base="${ORIG_STAMP%%+*}"
    printf '%s\n' "${base}+dev.deadbee" > "$STAMP_FILE"
    local summary
    summary="$(run_suite "")" || { restore_stamp; return 1; }
    restore_stamp
    echo "[test]   cross-commit summary: $summary" >&2
    # Same capsule version ⇒ same stripped identity ⇒ key unchanged ⇒ HIT.
    [ "$(echo "$summary" | jq -r '.cache.test_bin_hits')" -ge 1 ] || return 1
    [ "$(echo "$summary" | jq -r '.cache.test_bin_misses')" = "0" ] || return 1
    [ "$(echo "$summary" | jq -r '.cache.test_bin_hit_rate == 1')" = "true" ] || return 1
    return 0
}
run_test "different +dev.<hash> stamp, same version: still hits (no commit bust)" test_cross_commit_stable

# ---- Test 3: --no-test-cache bypasses read + write, hit_rate 0.0000 ----
test_no_cache_flag() {
    local summary
    summary="$(run_suite "--no-test-cache")" || return 1
    echo "[test]   no-cache summary: $summary" >&2
    [ "$(echo "$summary" | jq -r '.cache.test_bin_hits')" = "0" ] || return 1
    [ "$(echo "$summary" | jq -r '.cache.test_bin_misses')" = "0" ] || return 1
    [ "$(echo "$summary" | jq -r '.cache.test_bin_hit_rate == 0')" = "true" ] || return 1
    return 0
}
run_test "--no-test-cache: no read or write, hit_rate 0.0000" test_no_cache_flag

# ---- Test 4: editing the source content-busts the key (miss again) ----
test_edit_busts() {
    # Sanity: the unchanged file is warm from Test 2 (Test 3 wrote
    # nothing), so without an edit it would hit. Change the source bytes.
    cat > "$TESTDIR/cache_fixture_test.sfn" <<'EOF'
test "trivial truth" {
    assert 2 == 2;
}
EOF
    local summary
    summary="$(run_suite "")" || return 1
    echo "[test]   post-edit summary: $summary" >&2
    # A changed source → changed key → miss (never a stale-binary hit).
    [ "$(echo "$summary" | jq -r '.cache.test_bin_hits')" = "0" ] || return 1
    [ "$(echo "$summary" | jq -r '.cache.test_bin_misses')" -ge 1 ] || return 1
    return 0
}
run_test "edited source content-busts the key (miss, no stale hit)" test_edit_busts

TOTAL=$((PASS + FAIL))
echo ""
echo "═══ test-bin-cache: $PASS/$TOTAL passed, $FAIL failed ═══"
[ "$FAIL" -eq 0 ]
