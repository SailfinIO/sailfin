#!/usr/bin/env bash
# End-to-end test for function-reference → address lowering (issue #1146).
#
# A defined Sailfin function used in value position via `<fn> as * u8` must
# lower to a real code pointer — `bitcast <fnty> @<symbol> to i8*` — not the
# silent `null` the frontend emitted before #1146. The load-bearing proof is
# a linked round-trip: the fixture takes `sfn_fnref_worker as * u8`, hands it
# to `pthread_create` as the start_routine, joins the thread, and the worker
# writes a sentinel the C harness then checks. If the address were null,
# pthread_create would crash / return EINVAL and the sentinel would stay 0.
#
# Acceptance:
#   - `sfn check fixtures/fn_reference_pthread.sfn` exits 0.
#   - `sfn fmt --check fixtures/fn_reference_pthread.sfn` exits 0.
#   - emitted IR contains `bitcast <fnty> @sfn_fnref_worker... to i8*` and
#     does NOT drop the reference to `store i8* null`.
#   - emitted IR does NOT build a `{i8*, i8*}` closure pair or a `__closure__`
#     sentinel for the bare function reference.
#   - a linked pthread round-trip runs and observes the worker executed.
#
# Usage:
#   compiler/tests/e2e/test_fn_reference_pthread.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_fn_reference_pthread.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
FIXTURE="$REPO_ROOT/compiler/tests/e2e/fixtures/fn_reference_pthread.sfn"

SCRATCH="$(mktemp -d -t sfn-fnref-pthread-XXXXXX)"
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

# ---- Test: sfn check passes cleanly ----
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

# ---- Test: sfn fmt --check is clean ----
test_fmt_clean() {
    if ! "$BINARY" fmt --check "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   $FIXTURE needs formatting (run: sfn fmt --write $FIXTURE)"
        return 1
    fi
    return 0
}

# ---- Test: emitted IR shape ----
test_emit_shape() {
    local ll="$SCRATCH/fnref.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on fixture:"
        cat "$log"
        return 1
    fi

    local missing=0

    # The reference must materialize a real address: a bitcast of the
    # worker's typed fn-pointer symbol to i8*. Match on the symbol +
    # `bitcast ... to i8*` rather than exact spacing.
    if ! grep -qE "bitcast .*@sfn_fnref_worker.* to i8\*" "$ll"; then
        echo "[test]   missing 'bitcast <fnty> @sfn_fnref_worker... to i8*' (fn-ref not materialized)"
        grep -nE "sfn_fnref_worker" "$ll" || true
        missing=$((missing + 1))
    fi

    # Extern (C) references must materialize the BARE symbol — the mangling
    # post-pass touches only defined-fn names, so `@malloc` reaches the
    # linker unmodified. A `@malloc__<slug>` here would mean an extern got
    # wrongly mangled and the link would fail.
    if ! grep -qE "bitcast .*@malloc to i8\*" "$ll"; then
        echo "[test]   missing 'bitcast <fnty> @malloc to i8*' (extern fn-ref not materialized bare)"
        grep -nE "@malloc" "$ll" || true
        missing=$((missing + 1))
    fi

    # Scope to the @sfn_fnref_spawn_join body: the `start` slot must NOT be
    # fed a null — that is exactly the silent-null regression #1146 fixes.
    # The symbol carries a module-mangled suffix (`__<path-slug>`), so match
    # the prefix up to the `(` rather than an exact name.
    local body="$SCRATCH/spawn.body"
    awk '/^define .* @sfn_fnref_spawn_join[^(]*\(/,/^}/' "$ll" > "$body"
    if [ ! -s "$body" ]; then
        echo "[test]   could not extract @sfn_fnref_spawn_join body"
        missing=$((missing + 1))
    elif grep -qE "store i8\* null" "$body"; then
        echo "[test]   @sfn_fnref_spawn_join stores i8* null (fn-ref dropped to null):"
        cat "$body"
        missing=$((missing + 1))
    fi

    # A bare top-level function reference must NOT engage the closure-pair
    # path: no {i8*, i8*} aggregate, no __closure__ sentinel for this ref.
    if grep -qE "\{i8\*, i8\*\}" "$body"; then
        echo "[test]   @sfn_fnref_spawn_join builds a {i8*, i8*} closure pair for a bare fn-ref:"
        cat "$body"
        missing=$((missing + 1))
    fi
    if grep -q "__closure__" "$body"; then
        echo "[test]   @sfn_fnref_spawn_join emits a __closure__ sentinel for a bare fn-ref"
        missing=$((missing + 1))
    fi

    return "$missing"
}

# ---- Test: linked pthread round-trip ----
test_pthread_roundtrip() {
    local ll="$SCRATCH/fnref.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_shape must run first"
        return 1
    fi

    local host_os
    host_os="$(uname -s)"
    if [ "$host_os" != "Linux" ]; then
        echo "[test]   host is $host_os, not Linux — skipping executing round-trip"
        echo "[test]   (fixture models pthread_t as pointer-sized usize for Linux x86_64)"
        return 0
    fi

    # The emitted entry symbol carries a module-mangled suffix; extract it
    # from the .ll so the harness links against the real name. (That the
    # bitcast reference at the use site mangles to the *same* slug as the
    # define is itself part of what this test proves.)
    local spawn_sym
    spawn_sym="$(grep -oE '@sfn_fnref_spawn_join[A-Za-z0-9_]*' "$ll" | head -n 1 | sed 's/^@//')"
    if [ -z "$spawn_sym" ]; then
        echo "[test]   could not find @sfn_fnref_spawn_join symbol in emitted IR"
        return 1
    fi

    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
/* Linked round-trip harness for fn-reference → address lowering (#1146).
 * Calls the Sailfin spawn-join entry (name injected via -DSPAWN_JOIN to
 * match the module-mangled symbol), which takes `sfn_fnref_worker as * u8`
 * and hands it to pthread_create. If the reference had lowered to null,
 * pthread_create would fail/crash and `flag` would stay 0.
 *
 * No-op stubs mirror the arena/scheduler harnesses: the seed installs a
 * persistent-pointer hook and a type-registration ctor; stubbing them
 * keeps the link self-contained. */
#include <stdint.h>
#include <stdio.h>

extern int SPAWN_JOIN(void *arg);

void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }
void sfn_type_register(void *desc) { (void)desc; }

int main(void) {
    long flag = 0;
    int rc = SPAWN_JOIN(&flag);
    if (rc != 0) {
        fprintf(stderr, "spawn_join returned rc=%d (expected 0)\n", rc);
        return 1;
    }
    if (flag != 42) {
        fprintf(stderr, "worker did not run: flag=%ld (expected 42)\n", flag);
        return 2;
    }
    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping pthread round-trip"
        return 0
    fi
    # `-Wno-override-module` because the emitted .ll carries a target triple
    # that may not match the host clang default. `-lpthread` binds the
    # pthread externs; `-lm` mirrors the arena/scheduler harnesses.
    local bin="$SCRATCH/roundtrip"
    if ! "$clang_bin" -Wno-override-module "-DSPAWN_JOIN=$spawn_sym" "$harness" "$ll" -o "$bin" -lpthread -lm 2>"$SCRATCH/clang.log"; then
        echo "[test]   clang failed to link pthread harness:"
        cat "$SCRATCH/clang.log"
        return 1
    fi
    if ! "$bin"; then
        local rc=$?
        echo "[test]   pthread round-trip binary exited non-zero (rc=$rc)"
        return 1
    fi
    return 0
}

run_test "sfn check fixtures/fn_reference_pthread.sfn passes" test_check_clean
run_test "sfn fmt --check fixtures/fn_reference_pthread.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm materializes the fn-ref as a bitcast to i8*" test_emit_shape
run_test "linked pthread_create round-trip runs the Sailfin worker" test_pthread_roundtrip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
