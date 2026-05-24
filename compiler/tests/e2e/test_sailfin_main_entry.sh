#!/usr/bin/env bash
# End-to-end test for the M5.3 `@main` lowering's argv pass-through
# (#471). Builds the fixture at
# `compiler/tests/e2e/fixtures/sailfin_main_entry_probe.sfn`, runs
# it with a known argument, and asserts the user-visible `argv[1]`
# round-trips through the synthesized `@main(argc, argv)` prologue's
# `sailfin_runtime_argv_to_string_array` call into the user body.
#
# Pinned shape:
#
#   1. exit code   — the fixture returns 0 on success; verifies
#                    the wrapper's `fptosi double 0.0 to i32` cast
#                    lands on a clean exit status.
#   2. argv pass-  — stdout contains the second argv element (the
#      through        first user argument); confirms argv[0] (program
#                    name) is preserved and argv[1] (user arg) is
#                    readable from inside user main.
#
# The fixture is copied into a scratch directory before building
# so `sfn build` falls through to `_clang_compile_runtime_objects`
# (which does NOT compile `native_driver.c`, whose `main` would
# otherwise collide with the emitted `@main` at link time).

set -euo pipefail

BINARY="${1:?usage: test_sailfin_main_entry.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
FIXTURE="$REPO_ROOT/compiler/tests/e2e/fixtures/sailfin_main_entry_probe.sfn"
if [ ! -f "$FIXTURE" ]; then
    echo "[test] FATAL: missing fixture $FIXTURE"
    exit 2
fi

SCRATCH="$(mktemp -d -t sfn-main-entry-XXXXXX)"
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

# Build the fixture into a scratch directory. See file header for
# why the source must be copied out of the repo tree before build.
FIXTURE_COPY="$SCRATCH/sailfin_main_entry_probe.sfn"
PROBE_BIN="$SCRATCH/sailfin_main_entry_probe"
BUILD_LOG="$SCRATCH/build.log"

cp "$FIXTURE" "$FIXTURE_COPY"

build_fixture() {
    if ! "$BINARY" build -o "$PROBE_BIN" "$FIXTURE_COPY" > "$BUILD_LOG" 2>&1; then
        echo "[test]   sfn build failed on $FIXTURE_COPY:"
        cat "$BUILD_LOG"
        return 1
    fi
    if [ ! -x "$PROBE_BIN" ]; then
        echo "[test]   expected executable at $PROBE_BIN not produced"
        return 1
    fi
    return 0
}

test_argv_pass_through() {
    if ! build_fixture; then
        return 1
    fi
    local out_log="$SCRATCH/run-out.log"
    local err_log="$SCRATCH/run-err.log"
    local rc=0
    "$PROBE_BIN" "sentinel-token" > "$out_log" 2> "$err_log" || rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   fixture exited with code $rc (expected 0)"
        echo "[test]   stdout:"
        cat "$out_log"
        echo "[test]   stderr:"
        cat "$err_log"
        return 1
    fi
    if ! grep -qx "sentinel-token" "$out_log"; then
        echo "[test]   stdout did not echo argv[1] verbatim:"
        cat "$out_log"
        return 1
    fi
    return 0
}

test_missing_arg_exit_two() {
    if ! build_fixture; then
        return 1
    fi
    local out_log="$SCRATCH/missing-out.log"
    local err_log="$SCRATCH/missing-err.log"
    local rc=0
    "$PROBE_BIN" > "$out_log" 2> "$err_log" || rc=$?
    if [ "$rc" -ne 2 ]; then
        echo "[test]   fixture exited with code $rc (expected 2 from explicit return 2)"
        echo "[test]   stdout:"
        cat "$out_log"
        return 1
    fi
    if ! grep -qx "missing-arg" "$out_log"; then
        echo "[test]   stdout did not produce 'missing-arg' diagnostic:"
        cat "$out_log"
        return 1
    fi
    return 0
}

run_test "argv[1] round-trips through @main wrapper into user main" \
    test_argv_pass_through
run_test "user-supplied non-zero exit code propagates through fptosi cast" \
    test_missing_arg_exit_two

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
