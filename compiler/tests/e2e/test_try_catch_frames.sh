#!/usr/bin/env bash
# End-to-end test for M2.7b frame-based try/catch compiler emission
# (issue #404, epic #389). Pins both the inline IR shape and the runtime
# catch behavior — the latter guards the silent-no-op failure mode that
# IR pinning alone cannot detect (see the file-header "Setjmp/longjmp
# safety" note in `runtime/sfn/exception.sfn`).
#
# What the M2.7b PR ships, end-to-end:
#
#   1. inline IR shape — every compiler-emitted `try { ... }` block
#      contains, inside the user function's `define`:
#        (a) `call void @sfn_exception_push_frame(i8* %frame)` at try entry
#        (b) `call i32 @setjmp(i8* %jmp_buf)` immediately after, whose
#            return value is branched on (0 → try body, non-zero → catch)
#        (c) `call void @sfn_exception_pop_frame(i8* %frame)` on the
#            normal try-exit edge (suppressed when the body terminates
#            via `throw` or `return` — those paths unwind through
#            longjmp or the function epilogue)
#      The IR must NOT contain `call i32 @sfn_try_enter(...)` — calling
#      that as a regular function is C11 UB (glibc silently no-ops the
#      longjmp). The runtime symbol stays exported for ABI completeness;
#      only compiler-emitted try sites are constrained.
#
#   2. runtime catch behavior — `try { throw "boom"; } catch (e) { print(e); }`
#      compiles, links, runs, prints `boom`, and exits 0. This guards
#      the silent-no-op failure mode that a regression dropping the
#      inline emission (e.g. reverting to `call i32 @sfn_try_enter`)
#      would surface here instead of at link time.
#
# Usage:
#   compiler/tests/e2e/test_try_catch_frames.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_try_catch_frames.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-try-catch-frames-XXXXXX)"
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

# Fixture: a single function with try/catch that throws and prints the
# caught message. Used by both the IR-shape pins and the runtime test.
FIXTURE="$SCRATCH/try_catch_runtime.sfn"
cat > "$FIXTURE" <<'SFN'
fn main() ![io] {
    try {
        throw "boom";
    } catch (e) {
        print(e);
    }
}
SFN

emit_runtime_ir() {
    local out="$1"
    "$BINARY" emit -o "$out" llvm "$FIXTURE" > /dev/null 2>&1
}

# ---- (1) push_frame at try entry, inside the user function's define ----
test_push_frame_in_user_function() {
    local ll="$SCRATCH/runtime.ll"
    if ! emit_runtime_ir "$ll"; then
        echo "[test]   sfn emit llvm failed for runtime fixture"
        return 1
    fi
    local main_block
    main_block="$(awk '/^define void @sailfin_user_main/{flag=1} flag{print} /^\}/{if(flag){flag=0; exit}}' "$ll")"
    local push_count
    push_count="$(echo "$main_block" | grep -cE 'call void @sfn_exception_push_frame\(i8\* %t[0-9]+\)' || true)"
    if [ "${push_count:-0}" -ne 1 ]; then
        echo "[test]   main: expected 1 'call void @sfn_exception_push_frame(i8* %tN)', got $push_count"
        echo "[test]   main block was:"
        echo "$main_block" | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

# ---- (2) setjmp inline in user function, branched on ----
test_setjmp_inline_branch() {
    local ll="$SCRATCH/runtime.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing"
        return 1
    fi
    local main_block
    main_block="$(awk '/^define void @sailfin_user_main/{flag=1} flag{print} /^\}/{if(flag){flag=0; exit}}' "$ll")"
    # Exactly one inline setjmp call.
    local setjmp_count
    setjmp_count="$(echo "$main_block" | grep -cE 'call i32 @setjmp\(i8\* %t[0-9]+\)' || true)"
    if [ "${setjmp_count:-0}" -ne 1 ]; then
        echo "[test]   main: expected 1 'call i32 @setjmp(i8* %tN)', got $setjmp_count"
        return 1
    fi
    # The result must feed an icmp eq + br to (try, catch).
    if ! echo "$main_block" | grep -qE 'icmp eq i32 %t[0-9]+, 0'; then
        echo "[test]   main: missing 'icmp eq i32 ..., 0' after setjmp"
        return 1
    fi
    if ! echo "$main_block" | grep -qE 'br i1 %t[0-9]+, label %try[0-9]+, label %catch[0-9]+'; then
        echo "[test]   main: missing 'br i1 ..., label %tryN, label %catchN' after icmp"
        return 1
    fi
    return 0
}

# ---- (3) push_frame is immediately followed by setjmp (no intervening calls) ----
test_push_frame_precedes_setjmp() {
    local ll="$SCRATCH/runtime.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing"
        return 1
    fi
    local main_block
    main_block="$(awk '/^define void @sailfin_user_main/{flag=1} flag{print} /^\}/{if(flag){flag=0; exit}}' "$ll")"
    local push_line setjmp_line
    push_line="$(echo "$main_block" | grep -nE 'call void @sfn_exception_push_frame' | head -1 | cut -d: -f1)"
    setjmp_line="$(echo "$main_block" | grep -nE 'call i32 @setjmp' | head -1 | cut -d: -f1)"
    if [ -z "$push_line" ] || [ -z "$setjmp_line" ]; then
        echo "[test]   could not locate push_frame and setjmp in main"
        return 1
    fi
    if [ "$push_line" -ge "$setjmp_line" ]; then
        echo "[test]   push_frame (line=$push_line) must precede setjmp (line=$setjmp_line)"
        return 1
    fi
    # Adjacency: AC #3 spells "immediately followed by" — the only
    # statements allowed between push_frame and setjmp are non-`call`
    # instructions (e.g. operand prep). Any intervening `call` line
    # means an extra side-effecting runtime call snuck into the
    # critical path, which would invalidate the architect's intent
    # that setjmp lands directly after the chain mutation. The
    # current emission inserts nothing between the two; this
    # assertion guards a regression that splices a call between them.
    # Skip the between-range check when setjmp is on the very next
    # line (push_line + 1 == setjmp_line) — sed treats `N,M p` with
    # M < N as "from N onwards", which would falsely include setjmp
    # itself.
    if [ "$setjmp_line" -gt "$((push_line + 1))" ]; then
        local between
        between="$(echo "$main_block" | sed -n "$((push_line + 1)),$((setjmp_line - 1))p")"
        local intervening_calls
        intervening_calls="$(echo "$between" | grep -cE '^\s*(%[a-zA-Z0-9_.]+ = )?call ' || true)"
        if [ "${intervening_calls:-0}" -ne 0 ]; then
            echo "[test]   push_frame must be immediately followed by setjmp; found $intervening_calls intervening 'call' line(s):"
            echo "$between" | sed 's/^/[test]     /'
            return 1
        fi
    fi
    return 0
}

# ---- (4) no legacy sfn_try_enter call site in compiler emission ----
test_no_sfn_try_enter_call_site() {
    local ll="$SCRATCH/runtime.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing"
        return 1
    fi
    # The compiler must not lower a try block as `call i32 @sfn_try_enter(...)`.
    # That pattern is C11 UB — glibc silently no-ops the longjmp on a
    # returned-frame setjmp save point. The runtime symbol is still
    # defined in `runtime/sfn/exception.sfn` for ABI completeness; we
    # just must not call it from generated user code.
    local main_block
    main_block="$(awk '/^define void @sailfin_user_main/{flag=1} flag{print} /^\}/{if(flag){flag=0; exit}}' "$ll")"
    local count
    count="$(echo "$main_block" | grep -cE 'call i32 @sfn_try_enter\(' || true)"
    if [ "${count:-0}" -ne 0 ]; then
        echo "[test]   main contains $count call(s) to @sfn_try_enter — must be inline-emitted instead"
        return 1
    fi
    return 0
}

# ---- (5) catch handler reads message via @sfn_take_exception(frame) ----
test_catch_take_exception_frame() {
    local ll="$SCRATCH/runtime.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing"
        return 1
    fi
    local main_block
    main_block="$(awk '/^define void @sailfin_user_main/{flag=1} flag{print} /^\}/{if(flag){flag=0; exit}}' "$ll")"
    local catch_body
    catch_body="$(echo "$main_block" | awk '/^catch[0-9]+:/{flag=1; next} /^[a-zA-Z0-9._]+:/{flag=0} flag{print}')"
    if ! echo "$catch_body" | grep -qE 'call i8\* @sfn_take_exception\(i8\* %t[0-9]+\)'; then
        echo "[test]   catch handler missing 'call i8* @sfn_take_exception(i8* %tN)'"
        echo "[test]   catch body was:"
        echo "$catch_body" | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

# ---- (6) runtime catch behavior: throw "boom" → catch prints "boom", exit 0 ----
test_runtime_catch_behavior() {
    # Compiles the fixture end-to-end, runs it, and asserts stdout
    # contains "boom" with exit code 0. This is the load-bearing
    # functional assertion that IR pinning alone cannot make — a
    # regression that loses the inline-setjmp distinction (e.g. by
    # accidentally re-emitting `call i32 @sfn_try_enter(...)`) produces
    # IR that links but silently no-ops the longjmp, leaving `main`
    # to fall through past the catch handler with an unset exit code.
    local out_bin="$SCRATCH/runtime.out"
    local build_log="$SCRATCH/build.log"
    if ! "$BINARY" build -o "$out_bin" "$FIXTURE" > "$build_log" 2>&1; then
        echo "[test]   sfn build failed for runtime fixture:"
        cat "$build_log" | sed 's/^/[test]     /'
        return 1
    fi
    if [ ! -x "$out_bin" ]; then
        echo "[test]   build produced no executable at $out_bin"
        return 1
    fi
    local run_log="$SCRATCH/run.log"
    local rc=0
    "$out_bin" > "$run_log" 2>&1 || rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   runtime binary exited non-zero (rc=$rc):"
        cat "$run_log" | sed 's/^/[test]     /'
        return 1
    fi
    if ! grep -q "boom" "$run_log"; then
        echo "[test]   runtime stdout missing 'boom':"
        cat "$run_log" | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

run_test "push_frame fires at try entry inside user function" \
    test_push_frame_in_user_function
run_test "setjmp inline in user function, branched on return value" \
    test_setjmp_inline_branch
run_test "push_frame immediately precedes setjmp" \
    test_push_frame_precedes_setjmp
run_test "no compiler-emitted call to @sfn_try_enter" \
    test_no_sfn_try_enter_call_site
run_test "catch handler reads message via @sfn_take_exception(frame)" \
    test_catch_take_exception_frame
run_test "runtime: try { throw \"boom\" } catch (e) { print(e) } prints boom, exit 0" \
    test_runtime_catch_behavior

# ---- (7) runtime: try { throw "x" } catch + finally runs finally before merge ----
test_runtime_try_catch_finally() {
    # Mirrors the documented try/catch/finally guarantee: even when
    # the try body throws, finally runs after the catch handler.
    # The legacy TLS-polling emission honored this; the M2.7b
    # frame-based emission preserves it by branching catch_body →
    # finally → merge.
    local fixture2="$SCRATCH/try_catch_finally.sfn"
    cat > "$fixture2" <<'SFN'
fn main() ![io] {
    try {
        throw "boom";
    } catch (e) {
        print("caught: " + e);
    } finally {
        print("cleanup");
    }
}
SFN
    local out_bin="$SCRATCH/try_catch_finally.out"
    local build_log="$SCRATCH/tcf_build.log"
    if ! "$BINARY" build -o "$out_bin" "$fixture2" > "$build_log" 2>&1; then
        echo "[test]   sfn build failed for try/catch/finally fixture:"
        cat "$build_log" | sed 's/^/[test]     /'
        return 1
    fi
    local run_log="$SCRATCH/tcf_run.log"
    local rc=0
    "$out_bin" > "$run_log" 2>&1 || rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   try/catch/finally binary exited non-zero (rc=$rc):"
        cat "$run_log" | sed 's/^/[test]     /'
        return 1
    fi
    if ! grep -q "caught: boom" "$run_log"; then
        echo "[test]   missing 'caught: boom' in stdout:"
        cat "$run_log" | sed 's/^/[test]     /'
        return 1
    fi
    if ! grep -q "cleanup" "$run_log"; then
        echo "[test]   missing 'cleanup' from finally block in stdout:"
        cat "$run_log" | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

# ---- (8) runtime: try { throw "x" } finally (no catch) runs finally then propagates ----
test_runtime_try_finally_no_catch() {
    # Per the documented try/finally guarantee, the finally block
    # runs even when the try body throws and there is no catch. The
    # uncaught throw should then propagate to abort() (no outer
    # frame in `main`). This guards the M2.7b regression flagged in
    # PR #733 review: the catch landing pad must route through
    # finally instead of rethrowing immediately.
    local fixture3="$SCRATCH/try_finally_no_catch.sfn"
    cat > "$fixture3" <<'SFN'
fn main() ![io] {
    try {
        throw "boom";
    } finally {
        print("cleanup ran");
    }
}
SFN
    local out_bin="$SCRATCH/try_finally_no_catch.out"
    local build_log="$SCRATCH/tfnc_build.log"
    if ! "$BINARY" build -o "$out_bin" "$fixture3" > "$build_log" 2>&1; then
        echo "[test]   sfn build failed for try/finally fixture:"
        cat "$build_log" | sed 's/^/[test]     /'
        return 1
    fi
    local run_log="$SCRATCH/tfnc_run.log"
    local rc=0
    "$out_bin" > "$run_log" 2>&1 || rc=$?
    # We expect the binary to abort (sfn_throw with empty chain),
    # which on Linux surfaces as a non-zero exit. The functional
    # contract is that "cleanup ran" must appear in stdout BEFORE
    # the process terminates — finally runs even though the
    # exception is unhandled.
    if ! grep -q "cleanup ran" "$run_log"; then
        echo "[test]   finally block did not run before uncaught throw propagated (rc=$rc):"
        cat "$run_log" | sed 's/^/[test]     /'
        return 1
    fi
    if [ "$rc" -eq 0 ]; then
        echo "[test]   expected non-zero exit from uncaught throw after finally, got rc=0:"
        cat "$run_log" | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

run_test "runtime: try { throw } catch + finally runs finally after catch" \
    test_runtime_try_catch_finally
run_test "runtime: try { throw } finally (no catch) runs finally before propagating" \
    test_runtime_try_finally_no_catch

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
