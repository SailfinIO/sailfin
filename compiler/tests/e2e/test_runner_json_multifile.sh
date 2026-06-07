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
# subprocess path the human path uses, passing `--json` to each child.
# Each child emits its own ordered jsonl document to the shared stdout,
# so the stream is PER-FILE FRAMED: one `start`/…/`summary` block per
# file. This test pins:
#
#   1. A 2-file `--json` run exits 0 and every non-blank stdout line is
#      valid JSON (no crash, no empty/garbled stream).
#   2. The stream carries `schema_version` 1 (on the `start` events).
#   3. Per-file framing: one `start` and one `summary` event per file
#      (proves the subprocess-isolation path ran, not the single-process
#      path that produced a single framed document).
#   4. A failing test still propagates a non-zero exit AND keeps the
#      stream valid jsonl (the crash path must not return).
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
    "$BINARY" test "$SCRATCH/pass" --json \
        > "$SCRATCH/pass.jsonl" 2> "$SCRATCH/pass.err"
    local rc=$?
    popd >/dev/null
    if [ "$rc" -ne 0 ]; then
        echo "[test]   multi-file --json exited $rc (regression: pre-#1121 segfault); stderr:" >&2
        cat "$SCRATCH/pass.err" >&2
        return "$rc"
    fi
    all_lines_json "$SCRATCH/pass.jsonl"
}
run_test "multi-file 'sfn test <dir> --json' exits 0 with valid jsonl" test_multifile_json_runs

# ---- Test 2: schema_version 1 is present on the start event(s) ----
test_schema_version_present() {
    local n
    n=$(jq -s '[.[] | select(.schema_version == 1)] | length' "$SCRATCH/pass.jsonl")
    [ "$n" -ge 1 ]
}
run_test "stream carries schema_version 1 events" test_schema_version_present

# ---- Test 3: per-file framing — one start + one summary per file ----
# Two files => two `start` and two `summary` events. This is the
# observable signature of the subprocess-isolation path (the fix); the
# old single-process path emitted exactly one of each.
test_per_file_framing() {
    local starts summaries
    starts=$(jq -s '[.[] | select(.event == "start")] | length' "$SCRATCH/pass.jsonl")
    summaries=$(jq -s '[.[] | select(.event == "summary")] | length' "$SCRATCH/pass.jsonl")
    if [ "$starts" -ne 2 ]; then
        echo "[test]   expected 2 start events (one per file), got $starts" >&2
        return 1
    fi
    if [ "$summaries" -ne 2 ]; then
        echo "[test]   expected 2 summary events (one per file), got $summaries" >&2
        return 1
    fi
    return 0
}
run_test "per-file framing: 2 start + 2 summary events for 2 files" test_per_file_framing

# ---- Test 4: aggregate pass count across the per-file summaries ----
test_aggregate_passed() {
    local total
    total=$(jq -s '[.[] | select(.event == "summary") | .passed] | add' "$SCRATCH/pass.jsonl")
    # alpha (2) + beta (1) = 3 passing tests.
    [ "$total" = "3" ]
}
run_test "summed per-file summaries report 3 passed tests" test_aggregate_passed

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
    # At least one test event reports a non-pass status.
    local failed
    failed=$(jq -s '[.[] | select(.event == "test" and .status != "pass")] | length' "$SCRATCH/fail.jsonl")
    [ "$failed" -ge 1 ]
}
run_test "failing test: non-zero exit, stream stays valid jsonl" test_failure_propagates_valid_jsonl

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
