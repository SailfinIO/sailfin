#!/usr/bin/env bash
# Issue #689 — end-to-end test for closure call-site dispatch.
#
# Closes the M1.5 closures-with-capture chain by verifying that three
# representative programs compile, link, and run to the expected
# stdout:
#
#   1. The canonical `examples/advanced/lambda-closure.sfn` — a
#      non-capturing two-arg lambda. Historically failed at the
#      call-site dispatch stage with
#      `llvm lowering [fatal]: cannot resolve return type for call`;
#      #689 fixes that exact codepath. Expected output: `7`.
#
#   2. `closure_single_capture.sfn` — a capturing lambda with one
#      `int` capture. Exercises #686's lifting + #687's env-struct
#      alloc/load alongside #689's dispatch. Expected output: `12`.
#
#   3. `closure_higher_order.sfn` — passes a lambda to a function
#      with a `fn(int) -> int` parameter. The parameter's annotation
#      is parsed by #688, mapped to `{i8*, i8*}` by #689, and
#      dispatched via the closure-callee branch. Expected output:
#      `10`.
#
# Usage:
#   compiler/tests/e2e/test_closure_capture.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_closure_capture.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
FIXTURE_DIR="$SCRIPT_DIR/fixtures"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-closure-capture-XXXXXX)"
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

# Compile + run a fixture and compare stdout to an exact expected
# value. The compiler's `run` command compiles, links, and executes
# in one step — exactly the surface a user would exercise.
#
# Two of our fixtures share the basename `main.sfn` because each
# lives in its own capsule directory (see the comment in
# `test_single_int_capture` for why each fixture needs its own
# `capsule.toml`). Deriving the log name from `basename` alone would
# overwrite the first fixture's logs with the second's; we use the
# parent directory + basename instead so post-mortem inspection of a
# failing run preserves the per-fixture diagnostic.
run_fixture() {
    local fixture="$1"
    local expected="$2"
    local fixture_dir_name
    fixture_dir_name="$(basename "$(dirname "$fixture")")"
    local fixture_base
    fixture_base="$(basename "${fixture%.sfn}")"
    local log_prefix="$SCRATCH/${fixture_dir_name}__${fixture_base}"
    local stdout_log="${log_prefix}.out"
    local stderr_log="${log_prefix}.err"
    if ! "$BINARY" run "$fixture" > "$stdout_log" 2> "$stderr_log"; then
        echo "[test]   compile/run failed for $(basename "$fixture")"
        echo "         stderr:"
        sed 's/^/         | /' "$stderr_log"
        return 1
    fi
    local actual
    actual="$(cat "$stdout_log")"
    if [ "$actual" != "$expected" ]; then
        echo "[test]   stdout mismatch for $(basename "$fixture")"
        echo "         expected: $expected"
        echo "         actual:   $actual"
        if [ -s "$stderr_log" ]; then
            echo "         stderr:"
            sed 's/^/         | /' "$stderr_log"
        fi
        return 1
    fi
    return 0
}

# (1) Canonical example — non-capturing two-arg lambda → 7
test_canonical_non_capturing_example() {
    run_fixture "$REPO_ROOT/examples/advanced/lambda-closure.sfn" "7"
}

# (2) Single-int capture → 4 + 8 = 12. The fixture lives in its own
# directory with a minimal `capsule.toml` so `discover_project_root`
# doesn't walk up into `compiler/capsule.toml` and inherit the
# `sfn/runtime-native` dep (which would drag in `native_driver.c`'s
# own `int main` and conflict with the fixture's). Mirrors the
# `fixtures/export_from/` pattern.
test_single_int_capture() {
    run_fixture "$FIXTURE_DIR/closure_single_capture/main.sfn" "12"
}

# (3) Higher-order dispatch via `fn(int) -> int` parameter → 5 + 5 = 10
test_higher_order_dispatch() {
    run_fixture "$FIXTURE_DIR/closure_higher_order/main.sfn" "10"
}

run_test "(1) canonical lambda-closure example prints 7" \
    test_canonical_non_capturing_example
run_test "(2) single-int-capture lambda prints 12" \
    test_single_int_capture
run_test "(3) higher-order dispatch via fn(int) -> int parameter prints 10" \
    test_higher_order_dispatch

echo "[test] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
