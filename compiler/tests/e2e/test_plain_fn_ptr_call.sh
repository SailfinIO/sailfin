#!/usr/bin/env bash
# End-to-end test for the plain C-ABI function-pointer indirect call
# (issue #1089).
#
# A local/parameter typed `* fn (A) -> R` is a bare code pointer. Calling
# it must lower to an env-LESS indirect call — `bitcast` the stored pointer
# to the typed function-pointer LLVM type, then `call <ret> <fnptr>(<args>)`
# with NO hidden environment argument. This is the env-less sibling of the
# closure-dispatch path (which extractvalues a `{i8*, i8*}` env pair). The
# scheduler's task invocation (`runtime/sfn/concurrency/scheduler.sfn`) is
# the first consumer; this fixture pins the primitive standalone.
#
# Acceptance:
#   - `sfn check fixtures/plain_fn_ptr_call.sfn` exits 0.
#   - `sfn fmt --check fixtures/plain_fn_ptr_call.sfn` exits 0.
#   - emitted IR for @invoke_self contains a typed-fn-ptr bitcast and an
#     env-less indirect `call i8* %tmp(i8* ...)`, and does NOT engage the
#     closure path (no `extractvalue {i8*, i8*}`).
#   - the program runs and exits 42 (worker(41) == 42, forwarded as the
#     process exit code) — proving an indirect call actually executed.
#
# Usage:
#   compiler/tests/e2e/test_plain_fn_ptr_call.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_plain_fn_ptr_call.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
FIXTURE_SRC="$REPO_ROOT/compiler/tests/e2e/fixtures/plain_fn_ptr_call.sfn"

SCRATCH="$(mktemp -d -t sfn-plain-fnptr-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT
# Run from an isolated scratch dir so project-root discovery does not pick
# up compiler/capsule.toml.
FIXTURE="$SCRATCH/plain_fn_ptr_call.sfn"
cp "$FIXTURE_SRC" "$FIXTURE"

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

test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on fixture:"
        cat "$log"
        return 1
    fi
    if ! grep -q "checked .* ok" "$log"; then
        echo "[test]   sfn check did not report 'ok':"
        cat "$log"
        return 1
    fi
    return 0
}

test_fmt_clean() {
    if ! "$BINARY" fmt --check "$FIXTURE_SRC" > /dev/null 2>&1; then
        echo "[test]   $FIXTURE_SRC needs formatting (run: sfn fmt --write $FIXTURE_SRC)"
        return 1
    fi
    return 0
}

test_emit_shape() {
    local ll="$SCRATCH/plain.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on fixture:"
        cat "$log"
        return 1
    fi

    local body="$SCRATCH/invoke.body"
    awk '/^define .* @invoke_self[^(]*\(/,/^}/' "$ll" > "$body"
    if [ ! -s "$body" ]; then
        echo "[test]   could not extract @invoke_self body"
        return 1
    fi

    local missing=0
    # Typed function-pointer bitcast for the call target.
    if ! grep -qE "bitcast .* to i8\* \(i8\*\)\*" "$body"; then
        echo "[test]   @invoke_self missing typed plain-fn-ptr bitcast (i8* (i8*)*):"
        cat "$body"
        missing=$((missing + 1))
    fi
    # Env-less indirect call: call through an SSA temp with a single user arg.
    if ! grep -qE "call i8\* %[a-z0-9]+\(i8\* " "$body"; then
        echo "[test]   @invoke_self missing env-less indirect call 'call i8* %tmp(i8* ...)':"
        cat "$body"
        missing=$((missing + 1))
    fi
    # Must NOT engage the closure-pair path.
    if grep -qE "extractvalue \{i8\*, i8\*\}" "$body"; then
        echo "[test]   @invoke_self unexpectedly unpacks a closure env (extractvalue):"
        cat "$body"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_run_exit_code() {
    set +e
    "$BINARY" run "$FIXTURE" > "$SCRATCH/run.log" 2>&1
    local rc=$?
    set -e
    if [ "$rc" -ne 42 ]; then
        echo "[test]   program exit code = $rc, want 42 (indirect call did not run / wrong result):"
        cat "$SCRATCH/run.log"
        return 1
    fi
    return 0
}

run_test "sfn check fixtures/plain_fn_ptr_call.sfn passes" test_check_clean
run_test "sfn fmt --check fixtures/plain_fn_ptr_call.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces an env-less indirect call" test_emit_shape
run_test "linked program runs the indirect call and exits 42" test_run_exit_code

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
