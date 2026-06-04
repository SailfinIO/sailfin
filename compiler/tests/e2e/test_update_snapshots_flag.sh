#!/usr/bin/env bash
# Issue #977: `sfn test --update-snapshots` threads `SAILFIN_UPDATE_SNAPSHOTS=1`
# to each compiled test binary so `sfn/test::expect_snapshot` re-baselines
# instead of comparing. This pins the additivity guarantee end to end:
#
#   - with the flag, the env var reaches the test process (probe PASSES)
#   - without it, the var is unset (probe FAILS) — proving a non-snapshot
#     run does NOT gain the variable
#
# Covered paths: the single-file leaf exec (a `.sfn` positional) and the
# multi-file child-runner path (a directory positional, which forks a
# `<self> test <file>` child that must inherit the variable through its
# own `env` prefix). The probe reads the var directly via `env.get`, so
# the assertion outcome is a faithful proxy for "the binary saw the var".

set -uo pipefail

BINARY="${1:?usage: test_update_snapshots_flag.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-update-snap-XXXXXX)"
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

write_probe() {
    mkdir -p "$SCRATCH/proj"
    cat > "$SCRATCH/proj/probe_test.sfn" <<'EOF'
// The runner exports SAILFIN_UPDATE_SNAPSHOTS=1 iff `--update-snapshots`
// was passed; this assertion fails (non-zero exit) when the var is unset.
test "update-snapshots flag reaches the test binary" ![io] {
    assert env.get("SAILFIN_UPDATE_SNAPSHOTS") == "1";
}
EOF
}

# Single-file leaf exec, flag present -> var set -> probe passes.
test_single_file_flag_present() {
    write_probe
    local log="$SCRATCH/proj/single_on.log"
    if ! "$BINARY" test --update-snapshots "$SCRATCH/proj/probe_test.sfn" > "$log" 2>&1; then
        echo "[test]   expected PASS with --update-snapshots:"
        cat "$log"
        return 1
    fi
    return 0
}

# Single-file leaf exec, flag absent -> var unset -> probe fails. This is
# the additivity guarantee: a plain `sfn test` must not set the variable.
test_single_file_flag_absent() {
    write_probe
    local log="$SCRATCH/proj/single_off.log"
    if "$BINARY" test "$SCRATCH/proj/probe_test.sfn" > "$log" 2>&1; then
        echo "[test]   expected FAIL without --update-snapshots (var must be unset):"
        cat "$log"
        return 1
    fi
    return 0
}

# Multi-file child-runner path (directory positional): the child process
# must inherit SAILFIN_UPDATE_SNAPSHOTS=1 via its `env` prefix.
test_multi_file_flag_present() {
    write_probe
    local log="$SCRATCH/proj/multi_on.log"
    if ! "$BINARY" test --update-snapshots "$SCRATCH/proj" > "$log" 2>&1; then
        echo "[test]   expected PASS with --update-snapshots (directory/multi-file path):"
        cat "$log"
        return 1
    fi
    return 0
}

run_test "single-file: --update-snapshots threads SAILFIN_UPDATE_SNAPSHOTS=1" test_single_file_flag_present
run_test "single-file: no flag leaves SAILFIN_UPDATE_SNAPSHOTS unset (additive)" test_single_file_flag_absent
run_test "multi-file: --update-snapshots propagates to the child runner" test_multi_file_flag_present

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
exit 0
