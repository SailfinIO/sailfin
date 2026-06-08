#!/usr/bin/env bash
# E2E golden-IR regression test for channel producer/consumer lowering
# (issue #1091, epic #965 M4 Wave 2).  Verifies that channel send/receive
# operations lower to the correct sfn_* symbols in LLVM IR.
#
# All emit-LLVM invocations are wrapped with `timeout` to bound any
# accidental deadlock introduced by a broken channel-lowering path.
# Real thread execution is NOT tested here — this test validates only
# that the IR contains the expected call symbols.
#
# Usage:
#   compiler/tests/e2e/test_channel_producer_consumer_ir.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_channel_producer_consumer_ir.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# `timeout(1)` is GNU coreutils (present on linux-x86_64 CI) and absent on
# macos-arm64, where coreutils provides `gtimeout`. Pick whichever exists
# and fall back to no timeout if neither is available, so the test runs on
# both runners instead of dying with `timeout: command not found`.
TIMEOUT_PREFIX=""
if command -v timeout >/dev/null 2>&1; then
    TIMEOUT_PREFIX="timeout 30"
elif command -v gtimeout >/dev/null 2>&1; then
    TIMEOUT_PREFIX="gtimeout 30"
fi

SCRATCH="$(mktemp -d -t sfn-channel-pc-ir-XXXXXX)"
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

# Emit LLVM IR for a source snippet and check for a symbol.
# All compiler invocations use a 30 s timeout to guard against hangs.
assert_ir_contains() {
    local label="$1"
    local source="$2"
    local expected_symbol="$3"

    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.ll"
    local log_path="$SCRATCH/${label}.log"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && ${TIMEOUT_PREFIX} "$BINARY" emit -o "$out_path" llvm "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -ne 0 ]; then
        echo "[test]   emit llvm of ${label}.sfn failed (rc=$rc)" >&2
        echo "[test]   output:" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "$expected_symbol" "$out_path" 2>/dev/null; then
        echo "[test]   IR for ${label}.sfn does not contain '${expected_symbol}'" >&2
        echo "[test]   IR call/declare lines:" >&2
        grep -E "call|declare" "$out_path" | sed 's/^/[test]     /' >&2
        return 1
    fi

    return 0
}

# ── Tests ──────────────────────────────────────────────────────────

# channel(N) + ch.send() → sfn_channel_create + sfn_channel_send in IR
test_channel_send_lowers() {
    assert_ir_contains "channel_send_call" \
'fn producer(ch: channel) ![io] {
    ch.send(42);
}
fn main() ![io] {
    let ch = channel(4);
    producer(ch);
}' \
        "sfn_channel_send"
}

# channel(N) + ch.receive() → sfn_channel_create + sfn_channel_receive in IR
test_channel_receive_lowers() {
    assert_ir_contains "channel_receive_call" \
'fn consumer(ch: channel) ![io] -> int {
    return ch.receive();
}
fn main() ![io] {
    let ch = channel(4);
    let val = consumer(ch);
}' \
        "sfn_channel_receive"
}

# channel(N) → sfn_channel_create is already covered by
# test_concurrency_lowering_ir.sh; include it here too for self-contained
# validation of the producer/consumer lowering path.
test_channel_create_lowers_in_pc_context() {
    assert_ir_contains "pc_channel_create" \
'fn main() ![io] {
    let ch = channel(8);
    ch.send(1);
    let v = ch.receive();
}' \
        "sfn_channel_create"
}

# A minimal producer/consumer program lowers all three channel symbols.
test_channel_full_producer_consumer_ir() {
    local src_path="$SCRATCH/pc_full.sfn"
    local out_path="$SCRATCH/pc_full.ll"
    local log_path="$SCRATCH/pc_full.log"

    cat > "$src_path" <<'SAILFIN'
fn producer(ch: channel, value: int) ![io] {
    ch.send(value);
}

fn consumer(ch: channel) ![io] -> int {
    return ch.receive();
}

fn main() ![io] {
    let ch = channel(4);
    producer(ch, 99);
    let result = consumer(ch);
}
SAILFIN

    local rc=0
    ( cd "$SCRATCH" && ${TIMEOUT_PREFIX} "$BINARY" emit -o "$out_path" llvm "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -ne 0 ]; then
        echo "[test]   emit llvm of pc_full.sfn failed (rc=$rc)" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    local ok=1
    for sym in sfn_channel_create sfn_channel_send sfn_channel_receive; do
        if ! grep -q "$sym" "$out_path" 2>/dev/null; then
            echo "[test]   pc_full.ll missing symbol: $sym" >&2
            ok=0
        fi
    done
    if [ "$ok" -eq 0 ]; then
        echo "[test]   IR call/declare lines:" >&2
        grep -E "call|declare" "$out_path" | sed 's/^/[test]     /' >&2
        return 1
    fi

    return 0
}

run_test "channel send lowers to sfn_channel_send (#1091)" test_channel_send_lowers
run_test "channel receive lowers to sfn_channel_receive (#1091)" test_channel_receive_lowers
run_test "channel create in producer/consumer context (#1091)" test_channel_create_lowers_in_pc_context
run_test "full producer/consumer program: all three sfn_channel_* symbols (#1091)" test_channel_full_producer_consumer_ir

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
