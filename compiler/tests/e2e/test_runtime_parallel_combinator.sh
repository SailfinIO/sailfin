#!/usr/bin/env bash
# End-to-end test for runtime/sfn/concurrency/parallel.sfn (issue #1093).
#
# `sfn_parallel(fn_ptrs, ctxs, count)` is a pure fan-out/join combinator
# over the existing sfn_spawn / sfn_await surface (future.sfn, #1090): it
# spawns every task onto the shared v0 scheduler, awaits them all, and
# returns their results in INPUT ORDER. It adds no new runtime-helper
# descriptor and no new scheduler primitive — it only calls spawn+await.
#
# Acceptance (mirrors the issue):
#   - `sfn check runtime/sfn/concurrency/parallel.sfn` exits 0.
#   - `sfn fmt --check` on the module is clean.
#   - emitted IR defines @sfn_parallel and drives it through the
#     spawn+await surface only: it calls @sfn_spawn and @sfn_await
#     (declared, not defined here — the combinator owns no primitive),
#     and adds NO `@sfn_*` descriptor of its own.
#   - the empty-input fast path returns null (allocates nothing).
#   - a linked roundtrip (parallel.ll + future.ll + scheduler.ll + a C
#     harness) proves: all tasks spawn, all are awaited, results land in
#     input order even though the pool completes them concurrently, a
#     null `ctxs` array means zero ctx, and `count == 0` returns null.
#
# Usage:
#   compiler/tests/e2e/test_runtime_parallel_combinator.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_parallel_combinator.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
CONC_DIR="$REPO_ROOT/runtime/sfn/concurrency"
PARALLEL="$CONC_DIR/parallel.sfn"
FUTURE="$CONC_DIR/future.sfn"
SCHEDULER="$CONC_DIR/scheduler.sfn"
# future.sfn's sfn_spawn registers each task against the current nursery
# (#1181), so the standalone link must include nursery.sfn to resolve
# sfn_nursery_current / sfn_nursery_register.
NURSERY="$CONC_DIR/nursery.sfn"

SCRATCH="$(mktemp -d -t sfn-parallel-combinator-XXXXXX)"
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
    if ! "$BINARY" check "$PARALLEL" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on parallel.sfn:"
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
    if ! "$BINARY" fmt --check "$PARALLEL" > /dev/null 2>&1; then
        echo "[test]   $PARALLEL needs formatting (run: sfn fmt --write $PARALLEL)"
        return 1
    fi
    return 0
}

# ---- Test: emitted IR shape ----
test_emit_shape() {
    local ll="$SCRATCH/parallel.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$PARALLEL" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on parallel.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0

    # The combinator itself must be defined.
    if ! grep -qE "^define .*@sfn_parallel\(" "$ll"; then
        echo "[test]   missing definition: @sfn_parallel"
        missing=$((missing + 1))
    fi

    # It must drive the existing spawn+await surface — and only DECLARE
    # it (the primitives live in future.sfn). A `define @sfn_spawn`/
    # `define @sfn_await` here would mean the combinator grew its own
    # primitive, violating "no new descriptor".
    if ! grep -qE "^declare .*@sfn_spawn\(" "$ll"; then
        echo "[test]   @sfn_spawn is not declared (combinator must call spawn)"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^declare .*@sfn_await\(" "$ll"; then
        echo "[test]   @sfn_await is not declared (combinator must call await)"
        missing=$((missing + 1))
    fi
    if grep -qE "^define .*@sfn_spawn\(|^define .*@sfn_await\(" "$ll"; then
        echo "[test]   parallel.sfn DEFINES a spawn/await primitive (should only call them)"
        missing=$((missing + 1))
    fi

    # Scope to the @sfn_parallel body: it must actually CALL spawn then
    # await (fan-out then join), not merely reference the symbols.
    local body="$SCRATCH/parallel.body"
    awk '/^define i8\* @sfn_parallel\(/,/^}/' "$ll" > "$body"
    if [ ! -s "$body" ]; then
        echo "[test]   could not extract @sfn_parallel body"
        missing=$((missing + 1))
    else
        if ! grep -qE "call i8\* @sfn_spawn\(" "$body"; then
            echo "[test]   @sfn_parallel does not call @sfn_spawn (no fan-out)"
            missing=$((missing + 1))
        fi
        if ! grep -qE "call i8\* @sfn_await\(" "$body"; then
            echo "[test]   @sfn_parallel does not call @sfn_await (no join)"
            missing=$((missing + 1))
        fi
        # The empty-input fast path: a `count <= 0` compare guarding an
        # early `ret i8* null` (empty input → empty output, no alloc).
        if ! grep -qE "icmp sle i64 %count, 0" "$body"; then
            echo "[test]   @sfn_parallel missing the 'count <= 0' empty-input guard"
            missing=$((missing + 1))
        fi
    fi

    return "$missing"
}

# ---- Test: linked fan-out/join roundtrip (Linux x86_64 only) ----
test_roundtrip() {
    local pll="$SCRATCH/parallel.ll"
    if [ ! -f "$pll" ]; then
        echo "[test]   $pll missing — test_emit_shape must run first"
        return 1
    fi

    # Same Linux-x86_64-only guard as the scheduler/FIFO roundtrips: the
    # embedded pthread handle storage in scheduler.sfn is sized for glibc
    # (pthread_mutex_t = 40 B, pthread_cond_t = 48 B). Executing the real
    # pthread calls against that layout is only correct on Linux x86_64
    # (docs/runtime_architecture.md §2.9 Q7). The IR-shape assertions
    # above pin the contract on every platform.
    local host_os
    host_os="$(uname -s)"
    if [ "$host_os" != "Linux" ]; then
        echo "[test]   host is $host_os, not Linux — skipping executing roundtrip"
        return 0
    fi

    local fll="$SCRATCH/future.ll"
    local sll="$SCRATCH/scheduler.ll"
    if ! "$BINARY" emit -o "$fll" llvm "$FUTURE" > "$SCRATCH/future_emit.log" 2>&1; then
        echo "[test]   sfn emit llvm failed on future.sfn:"
        cat "$SCRATCH/future_emit.log"
        return 1
    fi
    if ! "$BINARY" emit -o "$sll" llvm "$SCHEDULER" > "$SCRATCH/sched_emit.log" 2>&1; then
        echo "[test]   sfn emit llvm failed on scheduler.sfn:"
        cat "$SCRATCH/sched_emit.log"
        return 1
    fi
    local nll="$SCRATCH/nursery.ll"
    if ! "$BINARY" emit -o "$nll" llvm "$NURSERY" > "$SCRATCH/nursery_emit.log" 2>&1; then
        echo "[test]   sfn emit llvm failed on nursery.sfn:"
        cat "$SCRATCH/nursery_emit.log"
        return 1
    fi

    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
/* Fan-out/join roundtrip for sfn_parallel (issue #1093). Drives the
 * combinator against the real spawn/await/scheduler stack and asserts:
 *   - every task runs and its result lands in INPUT ORDER (results are
 *     index-dependent, and the pool finishes them out of order under
 *     contention, so a wrong slot mapping is observable);
 *   - a null ctxs array delivers a zero ctx to every task;
 *   - count == 0 returns NULL (empty input → empty output).
 *
 * No-op stubs mirror the scheduler harness: the seed installs a
 * persistent-pointer hook and a type-registration ctor; string literals
 * (SAILFIN_THREADS in the pool sizer) lower to @sfn_alloc_struct.
 */
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

extern void *sfn_parallel(void *fn_ptrs, void *ctxs, long count);

void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }
void sfn_type_register(void *desc) { (void)desc; }
void *sfn_alloc_struct(long n) { return calloc(1, (size_t)n); }
/* future.sfn's f64/number trampolines reference this string→number
 * runtime helper through their `as`-cast lowering. Those trampolines are
 * dead on this harness (the worker returns a pointer-sized value), but
 * the symbol must resolve at link time; a no-op stub suffices. */
double sfn_str_to_number(void *s) { (void)s; return 0; }

/* Worker entry the combinator invokes via sfn_spawn. The scheduler runs
 * it as fn(ctx) -> result; result is returned as an opaque pointer-sized
 * value (#1089's `* u8`). ctx*ctx + 7 makes each result a distinct,
 * order-sensitive function of the input index. */
static void *task_body(void *ctx) {
    long c = (long)ctx;
    return (void *)(c * c + 7);
}

int main(void) {
    const long N = 64;
    long fns[64];
    long ctxs[64];
    for (long i = 0; i < N; i++) {
        fns[i] = (long)(intptr_t)&task_body;
        ctxs[i] = i;
    }

    /* Phase 1: fan-out N tasks, join, results in input order. */
    long *res = (long *)sfn_parallel((void *)fns, (void *)ctxs, N);
    if (!res) {
        fprintf(stderr, "sfn_parallel returned NULL for N=%ld\n", N);
        return 1;
    }
    for (long i = 0; i < N; i++) {
        long want = i * i + 7;
        if (res[i] != want) {
            fprintf(stderr, "result[%ld] = %ld, want %ld (order violated or task dropped)\n",
                    i, res[i], want);
            return 2;
        }
    }
    free(res);

    /* Phase 2: null ctxs → every task receives ctx 0 → task_body(0) = 7. */
    long *res0 = (long *)sfn_parallel((void *)fns, NULL, 8);
    if (!res0) {
        fprintf(stderr, "sfn_parallel with null ctxs returned NULL\n");
        return 3;
    }
    for (long i = 0; i < 8; i++) {
        if (res0[i] != 7) {
            fprintf(stderr, "null-ctx result[%ld] = %ld, want 7\n", i, res0[i]);
            return 4;
        }
    }
    free(res0);

    /* Phase 3: empty input returns NULL (allocates nothing). */
    if (sfn_parallel(NULL, NULL, 0) != NULL) {
        fprintf(stderr, "sfn_parallel(_, _, 0) did not return NULL\n");
        return 5;
    }
    /* Negative count is treated as empty too. */
    if (sfn_parallel((void *)fns, (void *)ctxs, -3) != NULL) {
        fprintf(stderr, "sfn_parallel(_, _, -3) did not return NULL\n");
        return 6;
    }

    /* Phase 4: a non-empty fan-out with a null fn_ptrs array is rejected
     * (returns null) rather than dereferencing near-null. A null ctxs
     * stays valid (Phase 2), so only fn_ptrs is guarded. */
    if (sfn_parallel(NULL, (void *)ctxs, 4) != NULL) {
        fprintf(stderr, "sfn_parallel(NULL, ctxs, 4) did not return NULL\n");
        return 7;
    }

    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping roundtrip (IR-shape still pins the contract)"
        return 0
    fi
    # `-Wno-override-module` because the emitted .ll carries a target
    # triple that may not match the host clang default. `-lpthread` binds
    # the scheduler's mutex/cond externs; `-lm` mirrors the scheduler
    # harness (integer-literal lowering can leave libm references).
    local bin="$SCRATCH/roundtrip"
    if ! "$clang_bin" -Wno-override-module "$harness" "$pll" "$fll" "$sll" "$nll" \
            -o "$bin" -lpthread -lm 2>"$SCRATCH/clang.log"; then
        echo "[test]   clang failed to link parallel roundtrip:"
        cat "$SCRATCH/clang.log"
        return 1
    fi
    if ! "$bin"; then
        local rc=$?
        echo "[test]   parallel roundtrip binary exited non-zero (rc=$rc)"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/concurrency/parallel.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/concurrency/parallel.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm: @sfn_parallel drives spawn+await, no new descriptor" test_emit_shape
run_test "linked fan-out/join: all tasks run, results in input order, empty→null" test_roundtrip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
