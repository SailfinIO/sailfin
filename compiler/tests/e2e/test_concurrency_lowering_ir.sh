#!/usr/bin/env bash
# E2E golden-IR regression test for the concurrency frontend lowering — issue
# #1085, epic #965 (M4). Verifies that `channel`/`spawn`/`parallel`/`serve`
# lower to the correct runtime-helper call symbols in LLVM IR, with no
# `[fatal]: not yet lowered` diagnostics.
#
# Usage:
#   compiler/tests/e2e/test_concurrency_lowering_ir.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_concurrency_lowering_ir.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-concurrency-ir-XXXXXX)"
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

# Emit LLVM IR for a Sailfin source snippet and check for a symbol.
assert_ir_contains() {
    local label="$1"
    local source="$2"
    local expected_symbol="$3"

    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.ll"
    local log_path="$SCRATCH/${label}.log"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && "$BINARY" emit -o "$out_path" llvm "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -ne 0 ]; then
        echo "[test]   emit llvm of ${label}.sfn failed (rc=$rc)" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "$expected_symbol" "$out_path" 2>/dev/null; then
        echo "[test]   IR for ${label}.sfn does not contain '${expected_symbol}'" >&2
        echo "[test]   IR contents:" >&2
        grep -E "call|declare" "$out_path" | sed 's/^/[test]     /' >&2
        return 1
    fi

    return 0
}

# channel(N) → sfn_channel_create(i32 N) (#1091)
test_channel_lowers_to_channel_create() {
    assert_ir_contains "channel_create_call" \
'fn main() ![io] {
    let ch = channel(4);
}' \
        "sfn_channel_create"
}

# channel_create call carries an i32 capacity argument
test_channel_create_has_i32_cap() {
    assert_ir_contains "channel_create_i32" \
'fn main() ![io] {
    let ch = channel(0);
}' \
        "sfn_channel_create(i32"
}

# spawn:int <lambda> → sfn_spawn_int (#1090 flip)
test_spawn_int_lowers() {
    assert_ir_contains "spawn_int_call" \
'fn main() ![io] {
    let f = spawn fn() -> int { return 1; };
}' \
        "sfn_spawn_int"
}

# parallel [spawn task] → one sfn_spawn_task per task (#1091). The symbol is
# use-driven (only emitted when the construct lowers), so its presence is a
# meaningful signal, not an unconditional declaration.
test_parallel_lowers_to_spawn_task() {
    assert_ir_contains "parallel_spawn_task" \
'fn worker() -> int { return 1; }
fn main() ![io] {
    let p = parallel [spawn worker()];
}' \
        "sfn_spawn_task"
}

# serve(handler, port) → sailfin_adapter_serve_start (use-driven adapter symbol).
test_serve_lowers_to_serve_start() {
    assert_ir_contains "serve_serve_start" \
'fn handler() ![net, io] { }
fn main() ![net, io] {
    serve(handler, 8080);
}' \
        "sailfin_adapter_serve_start"
}

run_test "channel(N) lowers to sfn_channel_create (#1091)" test_channel_lowers_to_channel_create
run_test "channel_create carries i32 capacity argument (#1091)" test_channel_create_has_i32_cap
run_test "spawn:int lowers to sfn_spawn_int (#1090)" test_spawn_int_lowers
run_test "parallel [task] lowers to sfn_spawn_task (#1091)" test_parallel_lowers_to_spawn_task
run_test "serve(handler, port) lowers to sailfin_adapter_serve_start (#1085)" test_serve_lowers_to_serve_start

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
