#!/usr/bin/env bash
# End-to-end test for the Sailfin-native clock_gettime field-reader
# (#878, epic #763).
#
# `runtime/sfn/clock.sfn` gains `sfn_clock_monotonic_nanos() -> i64`,
# the shared field-reader that #819's `sfn_clock_millis` consumes. It
# stack-allocates a `Timespec`, hands the kernel `& ts`, calls
# `clock_gettime(CLOCK_MONOTONIC, &ts)`, then reads `tv_sec` (offset 0)
# and `tv_nsec` (the second `i64`, reached by a `+ 1` pointer step that
# lowers to a `getelementptr`) back through the
# `sailfin_intrinsic_pointer_read_i64` registry sentinel (#875). The
# sentinel lowers directly to an LLVM `load i64` — there is no C symbol
# behind it.
#
# This test pins the shape against the *real shipped module* (not a
# scratch fixture), and runs the adapter to prove monotonic advance:
#
#   1. typecheck   — `sfn check clock.sfn` reports `ok`.
#   2. fmt         — `sfn fmt --check clock.sfn` is canonical.
#   3. call shape  — emitted IR contains `call i32 @clock_gettime(...)`
#                    and `declare i32 @clock_gettime(...)`.
#   4. two reads   — the adapter body contains >= 2 local-pointer
#                    `load i64, i64* %…` instructions (the field reads).
#   5. STALE-READ GUARD — both `load i64, i64* %…` field reads appear
#                    textually AFTER the `call @clock_gettime`, proving
#                    the kernel's write is observed and no earlier
#                    cached load of the `Timespec` slot is reused.
#   6. gep field   — the second field is reached via
#                    `getelementptr i64, i64* %…` (the `+ 1` step).
#   7. no call/declare sentinel — the pointer-read sentinel never
#                    surfaces as a `call`/`declare` (it must be a load).
#   8. monotonic   — built into the runtime, the adapter returns a
#                    non-decreasing value across two back-to-back calls.

set -euo pipefail

BINARY="${1:?usage: test_clock_gettime_reader.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
CLOCK_SFN="$REPO_ROOT/runtime/sfn/clock.sfn"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-clock-reader-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT
LL="$SCRATCH/clock.ll"
BODY="$SCRATCH/body.ll"

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
    if ! "$BINARY" check "$CLOCK_SFN" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on clock.sfn:"
        cat "$log"
        return 1
    fi
    return 0
}

test_fmt_clean() {
    if ! "$BINARY" fmt --check "$CLOCK_SFN" > /dev/null 2>&1; then
        echo "[test]   $CLOCK_SFN needs formatting (run: sfn fmt --write $CLOCK_SFN)"
        return 1
    fi
    return 0
}

test_emit() {
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$LL" llvm "$CLOCK_SFN" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on clock.sfn:"
        cat "$log"
        return 1
    fi
    # Isolate the adapter body for the ordering-sensitive checks.
    awk '/define i64 @sfn_clock_monotonic_nanos/,/^}/' "$LL" > "$BODY"
    if ! [ -s "$BODY" ]; then
        echo "[test]   could not isolate @sfn_clock_monotonic_nanos body"
        return 1
    fi
    return 0
}

test_clock_gettime_call() {
    if ! grep -qE 'declare i32 @clock_gettime\(' "$LL"; then
        echo "[test]   missing 'declare i32 @clock_gettime(...)'"
        return 1
    fi
    if ! grep -qE 'call i32 @clock_gettime\(' "$BODY"; then
        echo "[test]   missing 'call i32 @clock_gettime(...)' in adapter body"
        return 1
    fi
    return 0
}

test_two_field_loads() {
    # Field reads load through local-temp pointers (`%…`); global
    # constant loads use `@global.…` and are excluded by the `%`.
    local n
    n="$(grep -cE 'load i64, i64\* %' "$BODY" || true)"
    if [ "$n" -lt 2 ]; then
        echo "[test]   expected >= 2 'load i64, i64* %…' field reads, found $n"
        cat "$BODY"
        return 1
    fi
    return 0
}

test_stale_read_guard() {
    # The kernel writes the time through the `* Timespec` out-param, so
    # every field read MUST appear after the call. Find the line number
    # of the clock_gettime call, then assert no local-pointer `load i64`
    # precedes it (a pre-call cached load would read stale alloca data).
    local call_line
    call_line="$(grep -nE 'call i32 @clock_gettime\(' "$BODY" | head -1 | cut -d: -f1)"
    if [ -z "$call_line" ]; then
        echo "[test]   no clock_gettime call to anchor the guard"
        return 1
    fi
    # Local-pointer i64 loads strictly before the call would be stale.
    local pre
    pre="$(awk -v c="$call_line" 'NR < c && /load i64, i64\* %/' "$BODY" | wc -l)"
    if [ "$pre" -ne 0 ]; then
        echo "[test]   STALE-READ HAZARD: $pre 'load i64, i64* %…' before the clock_gettime call:"
        awk -v c="$call_line" 'NR < c && /load i64, i64\* %/' "$BODY"
        return 1
    fi
    # And there must be field loads after the call.
    local post
    post="$(awk -v c="$call_line" 'NR > c && /load i64, i64\* %/' "$BODY" | wc -l)"
    if [ "$post" -lt 2 ]; then
        echo "[test]   expected >= 2 field loads after the call, found $post"
        return 1
    fi
    return 0
}

test_gep_second_field() {
    if ! grep -qE 'getelementptr i64, i64\* %' "$BODY"; then
        echo "[test]   missing 'getelementptr i64, i64* %…' for the tv_nsec field step"
        return 1
    fi
    return 0
}

test_no_call_sentinel() {
    if grep -qE 'call .*@sailfin_intrinsic_pointer_read_i64' "$LL"; then
        echo "[test]   pointer-read sentinel emitted as a 'call' rather than a 'load':"
        grep -nE 'call .*@sailfin_intrinsic_pointer_read_i64' "$LL"
        return 1
    fi
    if grep -qE 'declare .*@sailfin_intrinsic_pointer_read_i64' "$LL"; then
        echo "[test]   pointer-read sentinel emitted a 'declare' (links to nothing):"
        grep -nE 'declare .*@sailfin_intrinsic_pointer_read_i64' "$LL"
        return 1
    fi
    return 0
}

test_monotonic_advance() {
    # Linux-only: the adapter passes `CLOCK_MONOTONIC = 1`, which is the
    # Linux x86_64 constant. macOS arm64 spells `CLOCK_MONOTONIC = 6`, so
    # on Darwin `clock_gettime(1, …)` would not read the monotonic clock
    # (and the adapter's error path returns 0). The constant platform-
    # split is deferred under epic #763 (this issue's `Out:` scope), so
    # skip the runtime smoke off-Linux rather than fail the macOS CI
    # matrix. The IR-shape / stale-read / fmt checks above are platform-
    # neutral and still run everywhere.
    if [ "$(uname -s)" != "Linux" ]; then
        echo "[test] SKIP: monotonic advance — CLOCK_MONOTONIC=1 is Linux-only (epic #763); OS=$(uname -s)"
        return 0
    fi

    # `sfn_clock_monotonic_nanos` is compiled into the runtime via
    # `runtime/native/capsule.toml` sfn-sources, so a user program can
    # reach it through an extern declaration (the same linkage path that
    # makes `sfn_sleep` callable). #819 owns the prelude rewire; this
    # check proves the primitive itself advances.
    cat > "$SCRATCH/mono.sfn" <<'EOF'
extern fn sfn_clock_monotonic_nanos() -> i64;

fn main() ![io] {
    let a: i64 = sfn_clock_monotonic_nanos();
    let b: i64 = sfn_clock_monotonic_nanos();
    if b >= a {
        print("MONO_OK");
    } else {
        print("MONO_FAIL");
    }
    if a > 0 {
        print("NONZERO_OK");
    } else {
        print("NONZERO_FAIL");
    }
}
EOF
    local log="$SCRATCH/mono.log"
    if ! "$BINARY" run "$SCRATCH/mono.sfn" > "$log" 2>&1; then
        echo "[test]   sfn run mono.sfn failed:"
        cat "$log"
        return 1
    fi
    if ! grep -q "MONO_OK" "$log"; then
        echo "[test]   adapter did not return a non-decreasing value:"
        cat "$log"
        return 1
    fi
    if ! grep -q "NONZERO_OK" "$log"; then
        echo "[test]   adapter returned a non-positive reading (clock_gettime likely failed):"
        cat "$log"
        return 1
    fi
    return 0
}

run_test "sfn check passes on runtime/sfn/clock.sfn" test_check_clean
run_test "runtime/sfn/clock.sfn is fmt-clean" test_fmt_clean
run_test "sfn emit llvm produces IR + isolates the adapter body" test_emit
run_test "adapter declares + calls i32 @clock_gettime" test_clock_gettime_call
run_test "adapter has >= 2 i64 field reads" test_two_field_loads
run_test "STALE-READ GUARD: field loads only after the call" test_stale_read_guard
run_test "tv_nsec reached via getelementptr i64" test_gep_second_field
run_test "pointer-read sentinel is a load, not a call/declare" test_no_call_sentinel
run_test "adapter returns a monotonically non-decreasing value" test_monotonic_advance

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
