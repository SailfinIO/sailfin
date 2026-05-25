#!/usr/bin/env bash
# End-to-end test for the bare-file CLI dispatch added in M5.4 (#472).
#
# Pins `sailfin <file.sfn>` (no subcommand) → routes through the
# Sailfin CLI's catch-all positional handler, which compiles and
# runs the file as if `sailfin run <file.sfn>` had been invoked.
#
# This replaces the legacy C-driver fallback (the pre-M5.4
# `--emit MODE file.sfn` path that called `compile_to_sailfin` /
# `compile_to_llvm` directly from `native_driver.c`). Without an
# explicit regression test, future CLI refactors could silently
# break this user-visible form — common enough that `python
# script.py` / `node script.js` set the expectation.

set -euo pipefail

BINARY="${1:?usage: test_cli_bare_file_dispatch.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
HELLO="$REPO_ROOT/examples/basics/hello-world.sfn"
if [ ! -f "$HELLO" ]; then
    echo "[test] FATAL: missing fixture $HELLO"
    exit 2
fi

SCRATCH="$(mktemp -d -t sfn-cli-bare-file-XXXXXX)"
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

test_bare_file_runs_hello_world() {
    local out_log="$SCRATCH/bare-out.log"
    local err_log="$SCRATCH/bare-err.log"
    local rc=0
    (cd "$REPO_ROOT" && "$BINARY" examples/basics/hello-world.sfn) \
        > "$out_log" 2> "$err_log" || rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   bare-file invocation exited with code $rc (expected 0)"
        echo "[test]   stdout:"
        cat "$out_log"
        echo "[test]   stderr:"
        cat "$err_log"
        return 1
    fi
    if ! grep -qx "Hello, Sailfin!" "$out_log"; then
        echo "[test]   stdout did not contain expected 'Hello, Sailfin!' line:"
        cat "$out_log"
        return 1
    fi
    return 0
}

test_bare_file_rejects_unknown_extension() {
    # Sanity check: bare-file dispatch only triggers on `.sfn` extension.
    # An unrelated single positional must still hit the "unknown command"
    # branch and exit non-zero, NOT silently invoke `run` on a non-Sailfin
    # path.
    local out_log="$SCRATCH/unknown-out.log"
    local err_log="$SCRATCH/unknown-err.log"
    local rc=0
    "$BINARY" not-a-known-subcommand > "$out_log" 2> "$err_log" || rc=$?
    if [ "$rc" -eq 0 ]; then
        echo "[test]   expected non-zero exit for unknown command, got 0"
        echo "[test]   stdout:"
        cat "$out_log"
        return 1
    fi
    if ! grep -q "unknown command" "$out_log" "$err_log" 2>/dev/null; then
        echo "[test]   expected 'unknown command' diagnostic, got:"
        echo "[test]   stdout:"
        cat "$out_log"
        echo "[test]   stderr:"
        cat "$err_log"
        return 1
    fi
    return 0
}

run_test "bare-file 'sailfin <file.sfn>' compiles and runs (prints expected output)" \
    test_bare_file_runs_hello_world
run_test "single non-.sfn positional still falls through to 'unknown command'" \
    test_bare_file_rejects_unknown_extension

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
