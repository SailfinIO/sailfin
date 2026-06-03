#!/usr/bin/env bash
# End-to-end test for the host-aware clock-monotonic clk_id sentinel
# (#908, epic #763).
#
# `sailfin_intrinsic_clock_monotonic_id` is a registry sentinel whose
# lowering branch (`core_call_emission.sfn`) emits a bare `i32` immediate
# — `1` on Linux/glibc, `6` on Darwin/macOS — chosen at emit time from
# `SAILFIN_TARGET_OS` (cross-compile target override) or the `uname -s`
# host probe. Unlike the errno sentinel (a `call`) and the pointer-read
# sentinel (a `load`), it lowers to NO symbol and NO runtime call: the
# constant flows straight into the consuming `clock_gettime` call as its
# `clk_id` argument. This is the seed-gated replacement for the runtime
# clk_id probe shipped in #905/#819.
#
# The test is host-independent: it forces both platform paths via a
# `uname` shim on PATH (and the `SAILFIN_TARGET_OS` override), so it
# asserts the same thing whether CI runs it on Linux or macOS hardware.
# For each forced platform it pins:
#
#   1. typecheck      — `sfn check <fixture>` reports `ok` (the sentinel
#                       is seeded into the resolution scope; no extern
#                       needed for it).
#   2. clk_id immediate — emitted IR contains
#                       `call i32 @clock_gettime(i32 1,` on Linux and
#                       `call i32 @clock_gettime(i32 6,` on Darwin.
#   3. no sentinel leak — no `call`/`declare` targets the sentinel name
#                       (`sailfin_intrinsic_clock_monotonic_id`); it must
#                       vanish into the inline immediate.

set -euo pipefail

BINARY="${1:?usage: test_clock_monotonic_id_sentinel.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-clock-clkid-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

# Fixture mirrors the future consumer shape (clock.sfn after the
# seed-gated swap): feed the clk_id sentinel straight into
# `clock_gettime` as the first argument, exactly where the runtime probe
# constant sits today.
FIXTURE="$SCRATCH/clock_clkid.sfn"
cat > "$FIXTURE" <<'EOF'
struct Timespec {
    tv_sec: i64,
    tv_nsec: i64
}

extern fn clock_gettime(clk_id: i32, ts: * Timespec) -> i32;

fn read_clock() -> i32 {
    let mut ts: Timespec = Timespec { tv_sec: 0, tv_nsec: 0 };
    let ts_ptr: * Timespec = & ts;
    return clock_gettime(sailfin_intrinsic_clock_monotonic_id(), ts_ptr);
}

fn main() -> void {
    let r: i32 = read_clock();
}
EOF

# A `uname` shim that reports the requested OS for `-s` and delegates
# every other invocation to the real binary, so the compiler's
# `uname -s` probe resolves to our forced platform.
make_uname_shim() {
    local dir="$1" os="$2"
    mkdir -p "$dir"
    cat > "$dir/uname" <<SHIM
#!/bin/sh
if [ "\$1" = "-s" ]; then echo "$os"; exit 0; fi
exec /usr/bin/uname "\$@"
SHIM
    chmod +x "$dir/uname"
}

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
    return 0
}

# Emit IR with `uname -s` forced to $1 ("Linux" | "Darwin"); writes to $2.
emit_for_os() {
    local os="$1" out="$2"
    local shimdir="$SCRATCH/shim-$os"
    local log="$SCRATCH/emit-$os.log"
    make_uname_shim "$shimdir" "$os"
    if ! PATH="$shimdir:$PATH" "$BINARY" emit -o "$out" llvm "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed (uname=$os):"
        cat "$log"
        return 1
    fi
    return 0
}

LL_LINUX="$SCRATCH/clock_linux.ll"
LL_DARWIN="$SCRATCH/clock_darwin.ll"

test_emit_linux() { emit_for_os "Linux" "$LL_LINUX"; }
test_emit_darwin() { emit_for_os "Darwin" "$LL_DARWIN"; }

# --- Linux path: clk_id immediate is 1 ---

test_linux_clkid() {
    if ! grep -qE 'call i32 @clock_gettime\(i32 1,' "$LL_LINUX"; then
        echo "[test]   missing 'call i32 @clock_gettime(i32 1,' on the Linux path"
        grep -nE '@clock_gettime' "$LL_LINUX" || true
        return 1
    fi
    return 0
}

test_linux_no_darwin_clkid() {
    if grep -qE 'call i32 @clock_gettime\(i32 6,' "$LL_LINUX"; then
        echo "[test]   unexpected Darwin clk_id (6) in Linux-path IR:"
        grep -nE 'call i32 @clock_gettime\(i32 6,' "$LL_LINUX"
        return 1
    fi
    return 0
}

# --- Darwin path: clk_id immediate is 6 ---

test_darwin_clkid() {
    if ! grep -qE 'call i32 @clock_gettime\(i32 6,' "$LL_DARWIN"; then
        echo "[test]   missing 'call i32 @clock_gettime(i32 6,' on the Darwin path"
        grep -nE '@clock_gettime' "$LL_DARWIN" || true
        return 1
    fi
    return 0
}

test_darwin_no_linux_clkid() {
    if grep -qE 'call i32 @clock_gettime\(i32 1,' "$LL_DARWIN"; then
        echo "[test]   unexpected Linux clk_id (1) in Darwin-path IR:"
        grep -nE 'call i32 @clock_gettime\(i32 1,' "$LL_DARWIN"
        return 1
    fi
    return 0
}

# --- The sentinel name must never appear as a real symbol ---

test_no_sentinel_leak() {
    local n
    n="$(grep -cE '(call|declare) .*@sailfin_intrinsic_clock_monotonic_id' "$LL_LINUX" "$LL_DARWIN" 2>/dev/null | awk -F: '{s+=$2} END {print s+0}')"
    if [ "$n" != "0" ]; then
        echo "[test]   expected 0 call/declare of the sentinel symbol, found $n:"
        grep -nE '(call|declare) .*@sailfin_intrinsic_clock_monotonic_id' "$LL_LINUX" "$LL_DARWIN" || true
        return 1
    fi
    return 0
}

run_test "sfn check passes on the clk_id fixture" test_check_clean
run_test "sfn emit llvm produces IR (uname=Linux)" test_emit_linux
run_test "sfn emit llvm produces IR (uname=Darwin)" test_emit_darwin
run_test "Linux path feeds clk_id immediate 1" test_linux_clkid
run_test "Linux path omits clk_id 6" test_linux_no_darwin_clkid
run_test "Darwin path feeds clk_id immediate 6" test_darwin_clkid
run_test "Darwin path omits clk_id 1" test_darwin_no_linux_clkid
run_test "sentinel symbol never emitted as call/declare" test_no_sentinel_leak

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
