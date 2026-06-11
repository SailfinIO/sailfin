#!/usr/bin/env bash
# E2E regression test for channel-send / spawn-capture escape promotion
# (issue #1094, M4 follow-up to M1.5.5 / #329).
#
# Drop emission promotes owned heap locals to "rc" only at function-return
# boundaries (M1.5.5). Channel-send and spawn-capture move owned data
# ACROSS threads; without escape promotion at those boundaries the
# sender's scope-exit drop would free data the receiver/worker still
# reads — a cross-thread use-after-free.
#
# Coverage:
#   1. IR: a heap string sent on a channel from inside a loop body (the
#      loop-body scope closes BEFORE the receive) must not be released at
#      the sender's scope exit — the emitted module contains no
#      `call ... @sfn_rc_release` (the declare is unconditional and OK).
#   2. IR: same shape routed through a `channel`-typed *parameter* base
#      (`fn producer(ch: channel)`), the second base form the #1091
#      channel-method resolution accepts.
#   3. Runtime: a producer running on a REAL pthread sends a heap struct
#      through a channel boundary; the consumer dereferences it after the
#      producer's frame (and its drop sites) are gone. Run plain, and —
#      when the host clang has the ASAN runtime — again under
#      `-fsanitize=address`, where any sender-side release would surface
#      as a heap-use-after-free.
#
#      The harness stubs the channel with a single-slot C mailbox and
#      `sfn_rc_release` with `free`. The stubs match the
#      `runtime/sfn/concurrency/channel.sfn` ABI (#1266): send receives
#      a POINTER to the element bytes and returns i64; recv returns a
#      pointer to the stored element bytes. The real runtime would link
#      too (see test_channel_runtime_roundtrip.sh), but the stub keeps
#      this harness hermetic so `sfn_rc_release` can be interposed as
#      `free` — channel SEMANTICS are not under test here, the
#      sender-side drop behaviour is.
#
# The per-rule unit coverage (promotion + consumption + drop suppression,
# spawn-capture text forms, hygiene cases) lives in
# compiler/tests/unit/escape_promotion_boundaries_test.sfn.
#
# Usage:
#   compiler/tests/e2e/test_escape_promotion_boundaries.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_escape_promotion_boundaries.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

# GNU `timeout` on linux CI; `gtimeout` via coreutils on macOS; none → bare.
TIMEOUT_PREFIX=""
if command -v timeout >/dev/null 2>&1; then
    TIMEOUT_PREFIX="timeout 30"
elif command -v gtimeout >/dev/null 2>&1; then
    TIMEOUT_PREFIX="gtimeout 30"
fi

SCRATCH="$(mktemp -d -t sfn-escape-boundaries-XXXXXX)"
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

# Emit LLVM IR for a snippet; assert one symbol IS present (proves the
# boundary actually lowered) and that no `call` to the forbidden symbol
# is emitted (the suppressed sender-side release). The bare `declare` of
# sfn_rc_release is part of the unconditional helper preamble and allowed.
assert_ir_present_and_no_call() {
    local label="$1"
    local source="$2"
    local expected_symbol="$3"
    local forbidden_call="$4"

    local src_path="$SCRATCH/${label}.sfn"
    local out_path="$SCRATCH/${label}.ll"
    local log_path="$SCRATCH/${label}.log"
    printf '%s\n' "$source" > "$src_path"

    local rc=0
    ( cd "$SCRATCH" && ${TIMEOUT_PREFIX} "$BINARY" emit -o "$out_path" llvm "$src_path" ) \
        > "$log_path" 2>&1 || rc=$?

    if [ "$rc" -ne 0 ]; then
        echo "[test]   emit llvm of ${label}.sfn failed (rc=$rc)" >&2
        sed 's/^/[test]     /' "$log_path" >&2
        return 1
    fi

    if ! grep -q "$expected_symbol" "$out_path" 2>/dev/null; then
        echo "[test]   IR for ${label}.sfn does not contain '${expected_symbol}'" >&2
        grep -E "call|declare" "$out_path" | sed 's/^/[test]     /' >&2
        return 1
    fi

    if grep -E "call .*@${forbidden_call}\(" "$out_path" >/dev/null 2>&1; then
        echo "[test]   IR for ${label}.sfn must NOT call '@${forbidden_call}' (sender-side release of an escaped value)" >&2
        grep -E "call .*@${forbidden_call}\(" "$out_path" | sed 's/^/[test]     /' >&2
        return 1
    fi

    return 0
}

# ── (1) IR: send from a closing scope — no sender-side release ────────
#
# `msg` is a heap string built inside the loop body; the loop-body scope
# closes (running its drop site) before `ch.receive()`. The escaped value
# must not be released there.
test_channel_send_suppresses_sender_drop_ir() {
    assert_ir_present_and_no_call "send_scope_exit" \
'fn main() ![io] {
    let ch = channel(4);
    let mut i: int = 0;
    loop {
        if i >= 1 { break; }
        let msg = "hello" + " world";
        ch.send(msg);
        i += 1;
    }
    let got = ch.receive();
}' \
        "sfn_channel_send" \
        "sfn_rc_release"
}

# ── (2) IR: channel-typed parameter base — same suppression ──────────
test_channel_param_base_suppresses_sender_drop_ir() {
    assert_ir_present_and_no_call "send_param_base" \
'fn producer(ch: channel) ![io] {
    let msg = "hello" + " world";
    ch.send(msg);
}
fn main() ![io] {
    let ch = channel(4);
    producer(ch);
    let got = ch.receive();
}' \
        "sfn_channel_send" \
        "sfn_rc_release"
}

# ── (3) Runtime: cross-thread round trip (plain + best-effort ASAN) ───
test_cross_thread_round_trip() {
    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping linked roundtrip (IR assertions still pin the contract)"
        return 0
    fi

    local src_path="$SCRATCH/escape_payload.sfn"
    local ll_path="$SCRATCH/escape_payload.ll"
    cat > "$src_path" <<'SAILFIN'
struct Payload {
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
SAILFIN

    # Emit with a RELATIVE source path: the module suffix (and therefore
    # the `produce__escape_payload` symbol names the harness binds to) is
    # derived from the path as given, not the basename.
    local rc=0
    ( cd "$SCRATCH" && ${TIMEOUT_PREFIX} "$BINARY" emit -o escape_payload.ll llvm escape_payload.sfn ) \
        > "$SCRATCH/escape_payload.log" 2>&1 || rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   emit llvm of escape_payload.sfn failed (rc=$rc)" >&2
        sed 's/^/[test]     /' "$SCRATCH/escape_payload.log" >&2
        return 1
    fi

    # Module-suffixed symbol names derive from the fixture basename.
    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
/* Cross-thread no-UAF demonstration for issue #1094.
 *
 * The producer runs on a real pthread: it heap-allocates a Payload
 * (via the ASAN-instrumented sfn_alloc_struct stub below) and sends it
 * across the channel boundary; its frame — and every sender-side drop
 * site — is gone by the time the main thread consumes. If drop emission
 * ever releases the escaped value at the producer's scope exit again,
 * `sfn_rc_release` (stubbed as free) frees the block and the consumer's
 * dereference becomes a heap-use-after-free that ASAN reports (and the
 * plain run computes from freed memory).
 *
 * The single-slot mailbox stands in for the real channel runtime so
 * sfn_rc_release can be interposed as free; it follows the
 * runtime/sfn/concurrency/channel.sfn by-pointer ABI (#1266): send
 * gets a pointer to the element bytes (the emitted code spills the
 * value to a stack slot), recv returns a pointer to the stored bytes
 * (the emitted code loads the element back out). Channel semantics
 * are not under test — sender-side drops are.
 */
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

extern void produce__escape_payload(void *ch);
extern long consume__escape_payload(void *ch);

void sfn_type_register(void *desc) { (void)desc; }
void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }
void *sfn_alloc_struct(long n) { return calloc(1, (size_t)n); }
void sfn_rc_release(void *p) { free(p); }

static void *slot = NULL;
long sfn_channel_send(void *ch, void *elem) { (void)ch; slot = *(void **)elem; return 1; }
void *sfn_channel_recv(void *ch) { (void)ch; return &slot; }

static void *producer_thread(void *ch) {
    produce__escape_payload(ch);
    return NULL;
}

int main(void) {
    void *ch = (void *)0x1;
    pthread_t t;
    if (pthread_create(&t, NULL, producer_thread, ch) != 0) return 90;
    if (pthread_join(t, NULL) != 0) return 91;
    long got = consume__escape_payload(ch);
    if (got != 42) {
        fprintf(stderr, "consumer read %ld, want 42 (payload corrupted or freed)\n", got);
        return 1;
    }
    return 0;
}
CHARNESS

    # Plain link + run — must always work.
    local bin="$SCRATCH/roundtrip"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll_path" \
            -o "$bin" -lpthread 2>"$SCRATCH/clang.log"; then
        echo "[test]   clang failed to link the roundtrip harness:" >&2
        sed 's/^/[test]     /' "$SCRATCH/clang.log" >&2
        return 1
    fi
    if ! ${TIMEOUT_PREFIX} "$bin"; then
        echo "[test]   plain roundtrip failed (payload did not survive the sender's scope exit)" >&2
        return 1
    fi

    # ASAN link + run — best effort, twice over:
    #   - some hosts ship clang without the compiler-rt ASAN archives
    #     (link failure → skip);
    #   - ASAN reserves ~16 TB of VIRTUAL address space for shadow memory
    #     at startup, which is fundamentally incompatible with the
    #     `ulimit -v` cap the repo's test harness runs under
    #     (.claude/rules/compiler-safety.md) — the binary aborts with
    #     "ReserveShadowMemoryRange failed ... Perhaps you're using
    #     ulimit -v" before main() runs. Skip the ASAN leg whenever a
    #     vmem cap is active; the plain roundtrip above still validates.
    # Only an actual ASAN error report (e.g. heap-use-after-free) is a
    # real FAIL — that is the sender-side-release regression signal.
    local vmem_cap
    vmem_cap="$(ulimit -v 2>/dev/null || echo unlimited)"
    if [ "$vmem_cap" != "unlimited" ]; then
        echo "[test]   virtual-memory cap active (ulimit -v ${vmem_cap}) — ASAN shadow reservation cannot run; plain roundtrip still passed"
        return 0
    fi

    local bin_asan="$SCRATCH/roundtrip_asan"
    if "$clang_bin" -fsanitize=address -Wno-override-module "$harness" "$ll_path" \
            -o "$bin_asan" -lpthread 2>"$SCRATCH/clang_asan.log"; then
        local asan_log="$SCRATCH/asan_run.log"
        if ${TIMEOUT_PREFIX} "$bin_asan" > "$asan_log" 2>&1; then
            echo "[test]   ASAN roundtrip clean"
        elif grep -q "ERROR: AddressSanitizer:" "$asan_log"; then
            echo "[test]   ASAN roundtrip failed — sender-side release of the escaped payload" >&2
            sed 's/^/[test]     /' "$asan_log" | head -25 >&2
            return 1
        else
            # Startup/environment failure (shadow mapping, missing
            # runtime .so, etc.) — not a verdict on the escape rule.
            echo "[test]   ASAN could not start on this host — plain roundtrip still passed"
            sed 's/^/[test]     /' "$asan_log" | head -5
        fi
    else
        echo "[test]   ASAN runtime not available on this host — plain roundtrip still passed"
    fi

    return 0
}

# ── Run ───────────────────────────────────────────────────────────────
run_test "IR: channel send from closing scope emits no sender-side rc_release call (#1094)" \
    test_channel_send_suppresses_sender_drop_ir
run_test "IR: channel-typed parameter base also suppresses the sender drop (#1094)" \
    test_channel_param_base_suppresses_sender_drop_ir
run_test "runtime: payload survives the producer thread's scope exit (plain + ASAN best-effort)" \
    test_cross_thread_round_trip

echo "[test] escape-promotion boundaries: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
