#!/usr/bin/env bash
# Issue #1121: `sfn test <dir> --json` over a MULTI-FILE directory.
#
# Regression guard for the segfault that blocked wiring `JSON=1` through
# the Makefile test targets. Before the fix, `--json` forced every
# discovered test file through ONE in-process resolver pass (the
# `test_files.length > 1 && !json_output` guard in
# `cli_commands.sfn:handle_test_command` skipped the per-file subprocess
# isolation whenever `--json` was set). On the real suite (132 unit
# files) that single-process path OOM/segfaulted under the 8 GB cap and
# hit the resolver-union conflicts per-file isolation exists to avoid,
# so the tee'd jsonl came out empty.
#
# The fix routes multi-file `--json` runs through the same per-file
# subprocess path the human path uses, but the parent aggregates the
# per-file results back into ONE coherent jsonl document so the
# documented single-frame contract (one `start`, every per-test event,
# one `summary`) holds regardless of how many files ran. Children run in
# sub-frame mode: they forward only per-test events on the shared stdout
# and hand their counts to the parent via `_subframe_summary.json`. This
# test pins:
#
#   1. A 2-file `--json` run exits 0 and every non-blank stdout line is
#      valid JSON (no crash, no empty/garbled stream).
#   2. The stream carries `schema_version` 1 (on the `start` event).
#   3. Single-frame contract: exactly one `start` and one `summary` for
#      the whole run (not one pair per file).
#   4. The single `start.total` and `summary.passed` are run-level
#      aggregates across all files.
#   5. A failing test still propagates a non-zero exit, stays single-frame
#      and valid jsonl, and records the failure in the aggregate summary.
#
# Usage:
#   compiler/tests/e2e/test_runner_json_multifile.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runner_json_multifile.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

if ! command -v jq >/dev/null 2>&1; then
    echo "[test] SKIP: jq not installed (required for --json validation)" >&2
    exit 0
fi

SCRATCH="$(mktemp -d -t sfn-runner-json-mf-XXXXXX)"
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

# ---- Fixtures: two passing test files (multi-file directory) ----
mkdir -p "$SCRATCH/pass"
cat > "$SCRATCH/pass/alpha_test.sfn" <<'EOF'
test "alpha: one" { assert 1 + 1 == 2; }
test "alpha: two" { assert 2 * 3 == 6; }
EOF
cat > "$SCRATCH/pass/beta_test.sfn" <<'EOF'
test "beta: one" { assert 4 - 1 == 3; }
EOF

# ---- Test 1: multi-file --json exits 0, stream is valid jsonl ----
test_multifile_json_runs() {
    pushd "$SCRATCH/pass" >/dev/null
    # `errexit` is disabled around the invocation: the failure this test
    # guards (a multi-file `--json` segfault) would otherwise abort the
    # script before `rc` is captured and the diagnostic is printed.
    set +e
    "$BINARY" test "$SCRATCH/pass" --json \
        > "$SCRATCH/pass.jsonl" 2> "$SCRATCH/pass.err"
    local rc=$?
    set -e
    popd >/dev/null
    if [ "$rc" -ne 0 ]; then
        echo "[test]   multi-file --json exited $rc (regression: pre-#1121 segfault); stderr:" >&2
        cat "$SCRATCH/pass.err" >&2
        return "$rc"
    fi
    all_lines_json "$SCRATCH/pass.jsonl"
}
run_test "multi-file 'sfn test <dir> --json' exits 0 with valid jsonl" test_multifile_json_runs

# ---- Test 2: schema_version 1 is present on the start event ----
test_schema_version_present() {
    local n
    n=$(jq -s '[.[] | select(.schema_version == 1)] | length' "$SCRATCH/pass.jsonl")
    [ "$n" -ge 1 ]
}
run_test "stream carries schema_version 1 events" test_schema_version_present

# ---- Test 3: single-frame contract — exactly one start + one summary ----
# A multi-file `--json` invocation must emit ONE coherent document: one
# `start` and one `summary` for the whole run (not one pair per file).
# The parent aggregates the per-file subprocess results back into a
# single frame, so consumers never special-case dir-vs-file.
test_single_frame() {
    local starts summaries
    starts=$(jq -s '[.[] | select(.event == "start")] | length' "$SCRATCH/pass.jsonl")
    summaries=$(jq -s '[.[] | select(.event == "summary")] | length' "$SCRATCH/pass.jsonl")
    if [ "$starts" -ne 1 ]; then
        echo "[test]   expected exactly 1 start event for the run, got $starts" >&2
        return 1
    fi
    if [ "$summaries" -ne 1 ]; then
        echo "[test]   expected exactly 1 summary event for the run, got $summaries" >&2
        return 1
    fi
    return 0
}
run_test "single-frame: exactly 1 start + 1 summary for a multi-file run" test_single_frame

# ---- Test 4: aggregate totals on the single start/summary ----
# start.total and summary.passed are run-level aggregates: alpha (2) +
# beta (1) = 3 tests, all passing.
test_aggregate_totals() {
    local total passed
    total=$(jq -s '[.[] | select(.event == "start") | .total] | add' "$SCRATCH/pass.jsonl")
    passed=$(jq -s '[.[] | select(.event == "summary") | .passed] | add' "$SCRATCH/pass.jsonl")
    if [ "$total" != "3" ]; then
        echo "[test]   expected aggregate start.total == 3, got $total" >&2
        return 1
    fi
    if [ "$passed" != "3" ]; then
        echo "[test]   expected aggregate summary.passed == 3, got $passed" >&2
        return 1
    fi
    return 0
}
run_test "single start.total and summary.passed are run-level aggregates (3)" test_aggregate_totals

# ---- Test 5: a failing test propagates non-zero AND stays valid jsonl ----
mkdir -p "$SCRATCH/fail"
cat > "$SCRATCH/fail/ok_test.sfn" <<'EOF'
test "ok: passes" { assert 1 == 1; }
EOF
cat > "$SCRATCH/fail/bad_test.sfn" <<'EOF'
test "bad: fails" { assert 1 == 2; }
EOF
test_failure_propagates_valid_jsonl() {
    pushd "$SCRATCH/fail" >/dev/null
    set +e
    "$BINARY" test "$SCRATCH/fail" --json \
        > "$SCRATCH/fail.jsonl" 2> "$SCRATCH/fail.err"
    local rc=$?
    set -e
    popd >/dev/null
    if [ "$rc" -eq 0 ]; then
        echo "[test]   expected non-zero exit for a failing test, got 0" >&2
        return 1
    fi
    # The stream must still be well-formed jsonl — a crash would leave it
    # empty or truncated mid-line.
    all_lines_json "$SCRATCH/fail.jsonl" || return 1
    # Still a single frame even when a file fails.
    local starts summaries
    starts=$(jq -s '[.[] | select(.event == "start")] | length' "$SCRATCH/fail.jsonl")
    summaries=$(jq -s '[.[] | select(.event == "summary")] | length' "$SCRATCH/fail.jsonl")
    [ "$starts" -eq 1 ] || { echo "[test]   expected 1 start, got $starts" >&2; return 1; }
    [ "$summaries" -eq 1 ] || { echo "[test]   expected 1 summary, got $summaries" >&2; return 1; }
    # The aggregate summary records the failure, and a test event reports
    # a non-pass status.
    local agg_failed nonpass
    agg_failed=$(jq -s '[.[] | select(.event == "summary") | .failed] | add' "$SCRATCH/fail.jsonl")
    [ "$agg_failed" -ge 1 ] || { echo "[test]   expected summary.failed >= 1, got $agg_failed" >&2; return 1; }
    nonpass=$(jq -s '[.[] | select(.event == "test" and .status != "pass")] | length' "$SCRATCH/fail.jsonl")
    [ "$nonpass" -ge 1 ]
}
run_test "failing test: non-zero exit, stream stays valid jsonl" test_failure_propagates_valid_jsonl

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
