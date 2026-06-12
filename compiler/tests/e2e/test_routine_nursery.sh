#!/usr/bin/env bash
# End-to-end test for `routine { }` structured-concurrency nursery
# semantics — issue #1181, epic #965 (M4).
#
# Background. `routine { }` used to lower to a v0 transparent-scope shim
# (`.routine`/`.endroutine` → always-true `.if 1 > 0`/`.endif`) that
# provided no structured-concurrency guarantee. This issue replaces the
# shim with a real nursery: the lowering emits `sfn_nursery_enter` at
# scope entry and `sfn_nursery_exit` (a structured-join barrier) at exit,
# and `sfn_spawn` (runtime/sfn/concurrency/future.sfn) registers every
# task it creates against the per-thread current nursery. The structured
# guarantee: no task spawned while a nursery is current on the executing
# thread outlives that nursery's scope.
#
# Acceptance (issue #1181):
#   - `routine { }` no longer lowers to the `.if 1 > 0` shim — it brackets
#     its body with `@sfn_nursery_enter` / `@sfn_nursery_exit`.
#   - structured join, by OBSERVATION: a nursery that spawns N tasks
#     observes all N side effects after `sfn_nursery_exit` returns (the
#     join blocked until every child completed). Proven with a linked
#     C harness over the real runtime modules.
#   - defined, tested child-fault behavior: a child whose body returns an
#     error sentinel is still joined to completion (v0 join-all; no
#     deadlock, no silent drop), and a clean nursery reports fault code 0.
#   - non-local exit (`return`/`throw`/`break`/`continue`) out of a
#     `routine` is rejected at lowering with a fatal diagnostic (v0
#     fail-closed: such an exit would skip the join and leak tasks).
#
# Usage:
#   compiler/tests/e2e/test_routine_nursery.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_routine_nursery.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
NURSERY="$REPO_ROOT/runtime/sfn/concurrency/nursery.sfn"
SCHEDULER="$REPO_ROOT/runtime/sfn/concurrency/scheduler.sfn"
FUTURE="$REPO_ROOT/runtime/sfn/concurrency/future.sfn"

SCRATCH="$(mktemp -d -t sfn-routine-nursery-XXXXXX)"
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

# ---- Test: nursery.sfn passes sfn check / fmt ----
test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$NURSERY" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on nursery.sfn:"
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
    if ! "$BINARY" fmt --check "$NURSERY" > /dev/null 2>&1; then
        echo "[test]   $NURSERY needs formatting (run: sfn fmt --write $NURSERY)"
        return 1
    fi
    return 0
}

# ---- Test: nursery.sfn emits the runtime surface ----
test_nursery_emit_shape() {
    local ll="$SCRATCH/nursery.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$NURSERY" > "$SCRATCH/nursery_emit.log" 2>&1; then
        echo "[test]   sfn emit llvm failed on nursery.sfn:"
        cat "$SCRATCH/nursery_emit.log"
        return 1
    fi
    local missing=0
    local fn
    for fn in enter register exit current; do
        if ! grep -qE "^define .*@sfn_nursery_${fn}\(" "$ll"; then
            echo "[test]   missing definition: @sfn_nursery_${fn}"
            missing=$((missing + 1))
        fi
    done
    # The current-nursery register must be a genuine per-thread TLS global,
    # not a process-global (two threads in routines must not clobber it).
    if ! grep -qE "@global\._sfn_g_current_nursery = .*thread_local" "$ll"; then
        echo "[test]   _sfn_g_current_nursery is not a thread_local global"
        missing=$((missing + 1))
    fi
    [ "$missing" -eq 0 ]
}

# ---- Test: routine lowers to a nursery scope (not the .if 1>0 shim) ----
test_routine_lowers_to_nursery() {
    local src="$SCRATCH/routine_spawn.sfn"
    cat > "$src" <<'SFN'
fn work() -> int { return 1; }

fn main() -> void ![io] {
    routine {
        let f = spawn work();
    }
}
SFN
    local ll="$SCRATCH/routine_spawn.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$src" > "$SCRATCH/routine_emit.log" 2>&1; then
        echo "[test]   sfn emit llvm failed on routine fixture:"
        cat "$SCRATCH/routine_emit.log"
        return 1
    fi

    local missing=0
    # The nursery surface is declared and the routine brackets its body.
    grep -qE "call i64 @sfn_nursery_enter\(\)" "$ll" || {
        echo "[test]   no @sfn_nursery_enter call (routine did not open a nursery)"; missing=$((missing + 1)); }
    grep -qE "call i64 @sfn_nursery_exit\(i64 " "$ll" || {
        echo "[test]   no @sfn_nursery_exit call (routine did not close the nursery)"; missing=$((missing + 1)); }
    grep -qE "call i8\* @sfn_spawn_task\(" "$ll" || {
        echo "[test]   no spawn call inside the routine"; missing=$((missing + 1)); }

    # Structured ordering: enter < spawn < exit (the spawn is bracketed).
    local enter_ln spawn_ln exit_ln
    enter_ln="$(grep -nE "call i64 @sfn_nursery_enter\(\)" "$ll" | head -n1 | cut -d: -f1)"
    spawn_ln="$(grep -nE "call i8\* @sfn_spawn_task\(" "$ll" | head -n1 | cut -d: -f1)"
    exit_ln="$(grep -nE "call i64 @sfn_nursery_exit\(i64 " "$ll" | head -n1 | cut -d: -f1)"
    if [ -n "$enter_ln" ] && [ -n "$spawn_ln" ] && [ -n "$exit_ln" ]; then
        if ! { [ "$enter_ln" -lt "$spawn_ln" ] && [ "$spawn_ln" -lt "$exit_ln" ]; }; then
            echo "[test]   nursery calls not ordered enter<spawn<exit ($enter_ln/$spawn_ln/$exit_ln)"
            missing=$((missing + 1))
        fi
    fi
    [ "$missing" -eq 0 ]
}

# ---- Test: non-local exit out of a routine is rejected (fail-closed) ----
test_rejects_nonlocal_exit() {
    local src="$SCRATCH/routine_return.sfn"
    cat > "$src" <<'SFN'
fn pick() -> int ![io] {
    routine {
        return 1;
    }
    return 0;
}

fn main() -> void ![io] {
    print.info(number_to_string(pick()));
}
SFN
    local log="$SCRATCH/routine_return.log"
    # Must FAIL (a `return` crossing the routine boundary would skip the join).
    if "$BINARY" emit -o /dev/null llvm "$src" > "$log" 2>&1; then
        echo "[test]   routine { return; } compiled — expected a fatal rejection"
        cat "$log"
        return 1
    fi
    if ! grep -qiE "non-local exit|issue #1181" "$log"; then
        echo "[test]   rejection diagnostic missing the #1181 explanation:"
        cat "$log"
        return 1
    fi
    return 0
}

# ---- Test: behavioral structured join + child-fault (linked harness) ----
# Links the real runtime modules (scheduler + future + nursery) against a
# C driver that exercises enter → sfn_spawn(...) → exit and observes the
# join. `sfn_spawn` registers each task against the current nursery, so
# `sfn_nursery_exit` must block until every child has run.
test_behavioral_join() {
    local host_os
    host_os="$(uname -s)"
    if [ "$host_os" != "Linux" ]; then
        echo "[test]   host is $host_os, not Linux — skipping executing join roundtrip"
        return 0
    fi
    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping behavioral join roundtrip"
        return 0
    fi

    local sched_ll="$SCRATCH/scheduler.ll"
    local future_ll="$SCRATCH/future.ll"
    local nursery_ll="$SCRATCH/nursery.ll"
    "$BINARY" emit -o "$sched_ll" llvm "$SCHEDULER" > /dev/null 2>&1
    "$BINARY" emit -o "$future_ll" llvm "$FUTURE" > /dev/null 2>&1
    "$BINARY" emit -o "$nursery_ll" llvm "$NURSERY" > /dev/null 2>&1

    local harness="$SCRATCH/nursery_harness.c"
    cat > "$harness" <<'CHARNESS'
/* Structured-join + child-fault harness for the routine nursery (#1181).
 *
 * Drives the real runtime: open a nursery (sfn_nursery_enter), spawn many
 * tasks through the base sfn_spawn (which registers each against the
 * current nursery and boots the worker pool), then close the nursery
 * (sfn_nursery_exit). After exit returns, EVERY task body must have run —
 * the join barrier blocked until all children completed. A subset of the
 * children are "faulting": their body returns a non-null error sentinel,
 * which in v0 still completes (sets done) and is joined to completion
 * (join-all, no deadlock, no silent drop) — exit then reports fault 0.
 *
 * No-op stubs mirror the scheduler harness: the seed installs a
 * persistent-pointer hook + a type-registration ctor, and string literals
 * lower to @sfn_alloc_struct. sfn_str_to_number is referenced by a
 * future.ll trampoline this path never invokes. */
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

extern long sfn_nursery_enter(void);
extern long sfn_nursery_exit(long n);
extern void *sfn_spawn(long fn_ptr, long ctx, long result_size);

void sailfin_runtime_mark_persistent(void *p) { (void)p; }
void sfn_type_register(void *d) { (void)d; }
void *sfn_alloc_struct(long n) { return calloc(1, (size_t)n); }
double sfn_str_to_number(void *s) { (void)s; return 0; }

static long g_counter = 0;

/* Normal child: records its side effect and returns cleanly. */
static void *worker_ok(void *ctx) {
    (void)ctx;
    __sync_fetch_and_add(&g_counter, 1);
    return NULL;
}

/* "Faulting" child: records its side effect but returns an error
 * sentinel. In v0 a task body cannot throw across the worker boundary,
 * so it still completes — the nursery joins it to completion. */
static void *worker_fault(void *ctx) {
    (void)ctx;
    __sync_fetch_and_add(&g_counter, 1);
    return (void *)(intptr_t)0xBAD;
}

int main(void) {
    const long N_OK = 40;
    const long N_FAULT = 10;
    const long N = N_OK + N_FAULT;

    long nur = sfn_nursery_enter();
    if (!nur) { fprintf(stderr, "nursery_enter failed\n"); return 2; }

    for (long i = 0; i < N_OK; i++) {
        if (!sfn_spawn((long)(intptr_t)&worker_ok, 0, 8)) {
            fprintf(stderr, "spawn(ok) failed at %ld\n", i);
            return 3;
        }
    }
    for (long i = 0; i < N_FAULT; i++) {
        if (!sfn_spawn((long)(intptr_t)&worker_fault, 0, 8)) {
            fprintf(stderr, "spawn(fault) failed at %ld\n", i);
            return 4;
        }
    }

    /* The structured-join barrier: must block until ALL N children ran. */
    long fault = sfn_nursery_exit(nur);

    if (g_counter != N) {
        fprintf(stderr, "after exit g_counter=%ld, want %ld — join did NOT "
                "wait for every child\n", g_counter, N);
        return 1;
    }
    /* Clean nursery (no registration OOM) reports fault 0 even though some
     * children returned an error sentinel — join-all completed. */
    if (fault != 0) {
        fprintf(stderr, "nursery_exit reported fault=%ld on a clean run\n", fault);
        return 5;
    }

    printf("OK nursery join: %ld/%ld children observed, fault=%ld\n",
           g_counter, N, fault);
    return 0;
}
CHARNESS

    local bin="$SCRATCH/nursery_harness"
    if ! "$clang_bin" -Wno-override-module "$harness" "$sched_ll" "$future_ll" "$nursery_ll" \
            -o "$bin" -lpthread -lm 2>"$SCRATCH/nursery_clang.log"; then
        echo "[test]   clang failed to link nursery harness:"
        cat "$SCRATCH/nursery_clang.log"
        return 1
    fi
    if ! "$bin" > "$SCRATCH/nursery_run.log" 2>&1; then
        local rc=$?
        echo "[test]   nursery join harness exited non-zero (rc=$rc):"
        cat "$SCRATCH/nursery_run.log"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/concurrency/nursery.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/concurrency/nursery.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces the sfn_nursery_* surface + TLS register" test_nursery_emit_shape
run_test "routine lowers to a nursery scope bracketing its spawns (#1181)" test_routine_lowers_to_nursery
run_test "non-local exit out of a routine is rejected fail-closed (#1181)" test_rejects_nonlocal_exit
run_test "nursery joins all spawned children before exit; faults defined (#1181)" test_behavioral_join

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
