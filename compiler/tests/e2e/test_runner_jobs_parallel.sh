#!/usr/bin/env bash
# Issue #1236: `sfn test <dir> --jobs N` — parallel multi-file runner.
#
# The multi-file runner's per-file children run concurrently through a
# bounded `process.spawn_with_env` worker pool when `--jobs N` (N > 1)
# is passed; `--jobs 1` (the default) keeps the serial `process.run`
# loop byte-identical to the pre-#1236 runner. This test pins the
# equivalence contract from the issue's acceptance criteria:
#
#   1. `--jobs 4` yields the SAME pass/fail tally and the same coherent
#      single-frame `--json` document as `--jobs 1` (one `start`, one
#      `summary`, run-level aggregate totals, valid jsonl throughout).
#   2. Human-mode banners agree between `--jobs 1` and `--jobs 4`.
#   3. A failing file still propagates a non-zero exit under `--jobs 2`,
#      stays single-frame, and records the failure in the aggregate.
#   4. Invalid `--jobs` values (0, garbage, missing) are usage errors
#      (exit 2), not silent serial fallbacks.
#
# Children stay isolated via per-file `sub-<i>` scratch dirs (unchanged
# from the serial path), and the parent re-emits each child's captured
# output grouped per file, so the jsonl stream stays pure.
#
# Usage:
#   compiler/tests/e2e/test_runner_jobs_parallel.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runner_jobs_parallel.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-runner-jobs-XXXXXX)"
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

# Assert every non-blank line of $1 parses as JSON.
all_lines_json() {
    local file="$1"
    local line
    while IFS= read -r line; do
        [ -z "$line" ] && continue
        echo "$line" | jq -e . >/dev/null 2>&1 || {
            echo "[test]   non-JSON line in stream: $line" >&2
            return 1
        }
    done < "$file"
    return 0
}

# ---- Fixtures: four passing test files (multi-file directory) ----
mkdir -p "$SCRATCH/pass"
cat > "$SCRATCH/pass/alpha_test.sfn" <<'EOF'
test "alpha: one" { assert 1 + 1 == 2; }
test "alpha: two" { assert 2 * 3 == 6; }
EOF
cat > "$SCRATCH/pass/beta_test.sfn" <<'EOF'
test "beta: one" { assert 4 - 1 == 3; }
EOF
cat > "$SCRATCH/pass/gamma_test.sfn" <<'EOF'
test "gamma: one" { assert 10 / 2 == 5; }
test "gamma: two" { assert 7 - 7 == 0; }
EOF
cat > "$SCRATCH/pass/delta_test.sfn" <<'EOF'
test "delta: one" { assert 9 == 9; }
EOF

# ---- Test 1: human mode — --jobs 4 banner tally matches --jobs 1 ----
test_human_equivalence() {
    pushd "$SCRATCH/pass" >/dev/null
    set +e
    "$BINARY" test "$SCRATCH/pass" \
        > "$SCRATCH/serial.out" 2> "$SCRATCH/serial.err"
    local rc_serial=$?
    "$BINARY" test "$SCRATCH/pass" --jobs 4 \
        > "$SCRATCH/pool.out" 2> "$SCRATCH/pool.err"
    local rc_pool=$?
    set -e
    popd >/dev/null
    if [ "$rc_serial" -ne 0 ]; then
        echo "[test]   serial run exited $rc_serial; stderr:" >&2
        cat "$SCRATCH/serial.err" >&2
        return 1
    fi
    if [ "$rc_pool" -ne 0 ]; then
        echo "[test]   --jobs 4 run exited $rc_pool; stderr:" >&2
        cat "$SCRATCH/pool.err" >&2
        return 1
    fi
    # The end-of-run suite banner must agree between the two modes.
    local banner_serial banner_pool
    banner_serial=$(grep -E '═══.*passed.*═══' "$SCRATCH/serial.out" || true)
    banner_pool=$(grep -E '═══.*passed.*═══' "$SCRATCH/pool.out" || true)
    if [ -z "$banner_pool" ]; then
        echo "[test]   --jobs 4 produced no suite banner" >&2
        return 1
    fi
    if [ "$banner_serial" != "$banner_pool" ]; then
        echo "[test]   banner mismatch:" >&2
        echo "[test]     serial: $banner_serial" >&2
        echo "[test]     pool:   $banner_pool" >&2
        return 1
    fi
    return 0
}
run_test "human mode: --jobs 4 banner tally matches --jobs 1" test_human_equivalence

# ---- JSON equivalence tests (need jq) ----
if command -v jq >/dev/null 2>&1; then
    # ---- Test 2: --json equivalence between --jobs 1 and --jobs 4 ----
    test_json_equivalence() {
        pushd "$SCRATCH/pass" >/dev/null
        set +e
        "$BINARY" test "$SCRATCH/pass" --json \
            > "$SCRATCH/serial.jsonl" 2> "$SCRATCH/serial-json.err"
        local rc_serial=$?
        "$BINARY" test "$SCRATCH/pass" --jobs 4 --json \
            > "$SCRATCH/pool.jsonl" 2> "$SCRATCH/pool-json.err"
        local rc_pool=$?
        set -e
        popd >/dev/null
        [ "$rc_serial" -eq 0 ] || { echo "[test]   serial --json exited $rc_serial" >&2; return 1; }
        [ "$rc_pool" -eq 0 ] || { echo "[test]   --jobs 4 --json exited $rc_pool" >&2; return 1; }
        all_lines_json "$SCRATCH/pool.jsonl" || return 1
        # Single-frame contract holds under the pool: exactly one
        # start + one summary for the whole run.
        local starts summaries
        starts=$(jq -s '[.[] | select(.event == "start")] | length' "$SCRATCH/pool.jsonl")
        summaries=$(jq -s '[.[] | select(.event == "summary")] | length' "$SCRATCH/pool.jsonl")
        [ "$starts" -eq 1 ] || { echo "[test]   expected 1 start, got $starts" >&2; return 1; }
        [ "$summaries" -eq 1 ] || { echo "[test]   expected 1 summary, got $summaries" >&2; return 1; }
        # Aggregate totals agree with the serial run.
        local f
        for f in total passed failed skipped; do
            local field_serial field_pool
            case "$f" in
                total)
                    field_serial=$(jq -s '[.[] | select(.event == "start") | .total] | add' "$SCRATCH/serial.jsonl")
                    field_pool=$(jq -s '[.[] | select(.event == "start") | .total] | add' "$SCRATCH/pool.jsonl")
                    ;;
                *)
                    field_serial=$(jq -s "[.[] | select(.event == \"summary\") | .$f] | add" "$SCRATCH/serial.jsonl")
                    field_pool=$(jq -s "[.[] | select(.event == \"summary\") | .$f] | add" "$SCRATCH/pool.jsonl")
                    ;;
            esac
            if [ "$field_serial" != "$field_pool" ]; then
                echo "[test]   $f mismatch: serial=$field_serial pool=$field_pool" >&2
                return 1
            fi
        done
        # Per-test event count agrees too (children forward every event).
        local events_serial events_pool
        events_serial=$(jq -s '[.[] | select(.event == "test")] | length' "$SCRATCH/serial.jsonl")
        events_pool=$(jq -s '[.[] | select(.event == "test")] | length' "$SCRATCH/pool.jsonl")
        [ "$events_serial" = "$events_pool" ] || {
            echo "[test]   test-event count mismatch: serial=$events_serial pool=$events_pool" >&2
            return 1
        }
        return 0
    }
    run_test "--json: --jobs 4 aggregates match --jobs 1 (single frame)" test_json_equivalence

    # ---- Test 3: failing file propagates non-zero under --jobs 2 ----
    mkdir -p "$SCRATCH/fail"
    cat > "$SCRATCH/fail/ok_test.sfn" <<'EOF'
test "ok: passes" { assert 1 == 1; }
EOF
    cat > "$SCRATCH/fail/bad_test.sfn" <<'EOF'
test "bad: fails" { assert 1 == 2; }
EOF
    cat > "$SCRATCH/fail/also_ok_test.sfn" <<'EOF'
test "also-ok: passes" { assert 2 == 2; }
EOF
    test_failure_propagates_pool() {
        pushd "$SCRATCH/fail" >/dev/null
        set +e
        "$BINARY" test "$SCRATCH/fail" --jobs 2 --json \
            > "$SCRATCH/fail.jsonl" 2> "$SCRATCH/fail.err"
        local rc=$?
        set -e
        popd >/dev/null
        if [ "$rc" -eq 0 ]; then
            echo "[test]   expected non-zero exit for a failing test, got 0" >&2
            return 1
        fi
        all_lines_json "$SCRATCH/fail.jsonl" || return 1
        local starts summaries agg_failed
        starts=$(jq -s '[.[] | select(.event == "start")] | length' "$SCRATCH/fail.jsonl")
        summaries=$(jq -s '[.[] | select(.event == "summary")] | length' "$SCRATCH/fail.jsonl")
        [ "$starts" -eq 1 ] || { echo "[test]   expected 1 start, got $starts" >&2; return 1; }
        [ "$summaries" -eq 1 ] || { echo "[test]   expected 1 summary, got $summaries" >&2; return 1; }
        agg_failed=$(jq -s '[.[] | select(.event == "summary") | .failed] | add' "$SCRATCH/fail.jsonl")
        [ "$agg_failed" -ge 1 ]
    }
    run_test "--jobs 2: failing file propagates non-zero, single frame" test_failure_propagates_pool
else
    echo "[test] SKIP: jq not installed (json equivalence checks skipped)" >&2
fi

# ---- Test 4: invalid --jobs values are usage errors (exit 2) ----
test_invalid_jobs_rejected() {
    local v rc
    for v in 0 -1 garbage 4x 257; do
        set +e
        "$BINARY" test "$SCRATCH/pass" --jobs "$v" >/dev/null 2>&1
        rc=$?
        set -e
        if [ "$rc" -ne 2 ]; then
            echo "[test]   --jobs $v: expected exit 2, got $rc" >&2
            return 1
        fi
    done
    # Missing value is also a usage error.
    set +e
    "$BINARY" test "$SCRATCH/pass" --jobs >/dev/null 2>&1
    rc=$?
    set -e
    if [ "$rc" -ne 2 ]; then
        echo "[test]   --jobs (missing value): expected exit 2, got $rc" >&2
        return 1
    fi
    return 0
}
run_test "invalid --jobs values are usage errors (exit 2)" test_invalid_jobs_rejected

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
