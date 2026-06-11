#!/usr/bin/env bash
# E2E runtime round-trip test for the Sailfin-native channel runtime
# (issue #1266, epic #965 M4).
#
# Unlike test_channel_producer_consumer_ir.sh (which only inspects the
# emitted IR), this test actually RUNS producer/consumer programs via
# `sailfin run`, so it proves the emitted channel ABI links against
# `runtime/sfn/concurrency/channel.sfn` (no `undefined symbol:
# sfn_channel_recv` at link) and that payloads survive the round trip:
#
#   1. int payloads — two sends, two typed receives, arithmetic on the
#      received values.
#   2. pointer payloads — a string and a struct round-trip through the
#      by-pointer element contract (send spills the value to a slot;
#      recv loads it back out of the runtime's malloc'd copy).
#   3. closed-channel drain — `receive()` on a closed+empty channel
#      returns the null-guarded default instead of crashing.
#
# Everything is single-threaded: the buffered channel does not block
# while count < capacity, so a send-then-receive sequence on one thread
# is deterministic and cannot deadlock. Real cross-thread execution is
# covered by test_escape_promotion_boundaries.sh.
#
# Usage:
#   compiler/tests/e2e/test_channel_runtime_roundtrip.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_channel_runtime_roundtrip.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# GNU `timeout` on linux CI; `gtimeout` via coreutils on macOS; none → bare.
TIMEOUT_PREFIX=""
if command -v timeout >/dev/null 2>&1; then
    TIMEOUT_PREFIX="timeout 60"
elif command -v gtimeout >/dev/null 2>&1; then
    TIMEOUT_PREFIX="gtimeout 60"
fi

SCRATCH="$(mktemp -d -t sfn-channel-roundtrip-XXXXXX)"
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

# Compile + run a source snippet via `sailfin run` and assert that an
# expected line appears on stdout.
run_and_expect() {
    local label="$1"
    local source="$2"
    local expected="$3"

    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.out"
    local err_path="$SCRATCH/${label}.err"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && ${TIMEOUT_PREFIX} "$BINARY" run "$src_path" ) \
        > "$out_path" 2> "$err_path" || rc=$?

    if [ "$rc" -ne 0 ]; then
        echo "[test]   run of ${label}.sfn failed (rc=$rc)" >&2
        echo "[test]   stderr:" >&2
        sed 's/^/[test]     /' "$err_path" >&2
        return 1
    fi

    if ! grep -qF "$expected" "$out_path" 2>/dev/null; then
        echo "[test]   ${label}.sfn output does not contain '${expected}'" >&2
        echo "[test]   stdout:" >&2
        sed 's/^/[test]     /' "$out_path" >&2
        return 1
    fi

    return 0
}

# ── (1) int payloads round-trip through the channel buffer ───────────
test_int_roundtrip() {
    run_and_expect "int_roundtrip" \
'fn main() ![io] {
    let ch = channel(4);
    ch.send(41);
    ch.send(1);
    let a: int = ch.receive();
    let b: int = ch.receive();
    let sum: int = a + b;
    print.info("int sum: {{sum}}");
    ch.close();
}' \
        "int sum: 42"
}

# ── (2a) string payloads survive the by-pointer element contract ─────
test_string_roundtrip() {
    run_and_expect "string_roundtrip" \
'fn main() ![io] {
    let ch = channel(2);
    ch.send("hello channel");
    let got: string = ch.receive();
    print.info("str got: {{got}}");
    ch.close();
}' \
        "str got: hello channel"
}

# ── (2b) struct payloads through a producer/consumer function pair ───
test_struct_roundtrip_across_functions() {
    run_and_expect "struct_roundtrip" \
'struct Payload {
    x: int;
    y: int;
}

fn produce(ch: channel) ![io] {
    let p = Payload { x: 6, y: 7 };
    ch.send(p);
}

fn consume(ch: channel) -> int ![io] {
    let got: Payload = ch.receive();
    return got.x * got.y;
}

fn main() ![io] {
    let ch = channel(2);
    produce(ch);
    let prod: int = consume(ch);
    print.info("struct prod: {{prod}}");
    ch.close();
}' \
        "struct prod: 42"
}

# ── (3) closed + drained channel yields the null-guarded default ─────
test_closed_channel_drain() {
    run_and_expect "closed_drain" \
'fn main() ![io] {
    let ch = channel(2);
    ch.close();
    let after: int = ch.receive();
    print.info("after close: {{after}}");
}' \
        "after close: 0"
}

# ── Run ───────────────────────────────────────────────────────────────
run_test "runtime: int payloads round-trip via sailfin run (#1266)" test_int_roundtrip
run_test "runtime: string payload survives the by-pointer contract (#1266)" test_string_roundtrip
run_test "runtime: struct payload round-trips across producer/consumer fns (#1266)" test_struct_roundtrip_across_functions
run_test "runtime: receive on a closed+empty channel returns the default (#1266)" test_closed_channel_drain

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
