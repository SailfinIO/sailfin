#!/usr/bin/env bash
# End-to-end test for runtime/sfn/concurrency/scheduler.sfn.
#
# Companion to test_runtime_pthread_skeleton.sh. The module pins the
# struct byte layouts for the v0 fixed thread pool (see
# `docs/runtime_architecture.md` §2.6.1 "Fixed Thread Pool, Not
# Work-Stealing") — `Scheduler`, `Task`, `TaskQueue`, and the opaque
# `PthreadMutex`/`PthreadCond` byte-storage types — and now also
# implements the shared MPMC task queue surface
# (`sfn_taskqueue_create/enqueue/dequeue/destroy/count`, issue #1087):
# a mutex-guarded ring buffer with not-empty / not-full condition
# variables for blocking dequeue/enqueue. It also implements the fixed
# worker pool (`sfn_scheduler_create/shutdown/...`, issue #1088):
# `pthread_create` spin-up sized to `min(cores, 4)` / `SAILFIN_THREADS`,
# a queue-pulling worker loop, and atomic draining shutdown that joins
# all workers. The spawn/await surface that imports this module lands in
# a follow-up M4 issue, so `make compile`/`make test` would not
# otherwise typecheck or exercise it; this script keeps it from
# bitrotting.
#
# Acceptance:
#   - `sfn check runtime/sfn/concurrency/scheduler.sfn` exits 0.
#   - `sfn fmt --check runtime/sfn/concurrency/scheduler.sfn` exits 0.
#   - emitted IR defines the five `sfn_taskqueue_*` entry points over
#     an inline `%TaskQueue` aggregate, with `seq_cst` atomic ring
#     slots and the pthread mutex/cond calls (including the blocking
#     `pthread_cond_wait` in both enqueue and dequeue).
#   - a linked single-thread roundtrip proves FIFO ordering, ring
#     wraparound, the create(0) capacity clamp, and null-safety.
#   - emitted IR defines the `sfn_scheduler_*` worker-pool surface,
#     materializes the worker entry's address as a real code pointer
#     (`bitcast ... @sfn_scheduler_worker ... to i8*`, #1146 — not a
#     silent null), and emits pthread_create/join/cond_broadcast,
#     sysconf, and an atomic `store atomic i64 1` shutdown publish.
#   - a linked multi-threaded roundtrip spins up the pool, honors
#     SAILFIN_THREADS, drains 100 tasks through a capacity-8 ring under
#     contention, joins cleanly (no leak, no deadlock), and verifies
#     default `min(cores, 4)` sizing plus null-safety.
#
# Usage:
#   compiler/tests/e2e/test_runtime_scheduler_skeleton.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_scheduler_skeleton.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/concurrency/scheduler.sfn"

SCRATCH="$(mktemp -d -t sfn-scheduler-skeleton-XXXXXX)"
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
    if ! "$BINARY" check "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on scheduler.sfn:"
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
    if ! "$BINARY" fmt --check "$SKELETON" > /dev/null 2>&1; then
        echo "[test]   $SKELETON needs formatting (run: sfn fmt --write $SKELETON)"
        return 1
    fi
    return 0
}

# ---- Test: emitted IR shape ----
test_emit_shape() {
    local ll="$SCRATCH/scheduler.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on scheduler.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0

    # TaskQueue embeds the mutex/cond handles by value — the LLVM
    # aggregate must list `%PthreadMutex` / `%PthreadCond` inline,
    # not as pointers. A boxed layout (`%PthreadMutex*`) would mean
    # the handles were never allocated and `pthread_*_init` writes
    # into garbage. Match on the field sequence rather than exact
    # spacing so a future change to the type-printer's separators
    # does not break this assertion spuriously.
    local tq_line
    tq_line="$(grep -E "^%TaskQueue = type" "$ll" | head -n 1)"
    if [ -z "$tq_line" ]; then
        echo "[test]   no %TaskQueue type emitted"
        missing=$((missing + 1))
    elif echo "$tq_line" | grep -qE "%PthreadMutex\*|%PthreadCond\*"; then
        echo "[test]   %TaskQueue boxes a sync handle as a pointer (not embedded by value):"
        echo "[test]   $tq_line"
        missing=$((missing + 1))
    elif ! echo "$tq_line" | grep -qE "%PthreadMutex.*%PthreadCond.*%PthreadCond"; then
        echo "[test]   %TaskQueue does not embed mutex + two conds inline:"
        echo "[test]   $tq_line"
        missing=$((missing + 1))
    fi

    local fn
    for fn in create enqueue dequeue destroy count; do
        if ! grep -qE "^define .*@sfn_taskqueue_${fn}\(" "$ll"; then
            echo "[test]   missing definition: @sfn_taskqueue_${fn}"
            missing=$((missing + 1))
        fi
    done

    # Ring slots are written/read through the atomic builtins.
    if ! grep -qE "store atomic i64 .* seq_cst" "$ll"; then
        echo "[test]   missing 'store atomic i64 ... seq_cst' ring write"
        missing=$((missing + 1))
    fi
    if ! grep -qE "load atomic i64, i64\* .* seq_cst" "$ll"; then
        echo "[test]   missing 'load atomic i64 ... seq_cst' ring read"
        missing=$((missing + 1))
    fi

    # Mutex + cond pairing: init on create, blocking wait + signal on
    # both producer and consumer paths.
    if ! grep -qE "call i32 @pthread_mutex_init\(%PthreadMutex\*" "$ll"; then
        echo "[test]   missing pthread_mutex_init call"
        missing=$((missing + 1))
    fi
    if ! grep -qE "call i32 @pthread_cond_wait\(%PthreadCond\*, ?%PthreadMutex\*|call i32 @pthread_cond_wait\(%PthreadCond\* %[a-z0-9]+, %PthreadMutex\*" "$ll"; then
        echo "[test]   missing blocking pthread_cond_wait(cond, mutex) call"
        grep -nE "pthread_cond_wait" "$ll" || true
        missing=$((missing + 1))
    fi
    if ! grep -qE "call i32 @pthread_cond_signal\(%PthreadCond\*" "$ll"; then
        echo "[test]   missing pthread_cond_signal call"
        missing=$((missing + 1))
    fi

    return "$missing"
}

# ---- Test: blocking dequeue waits on a condition under the mutex ----
test_dequeue_blocks_on_cond() {
    local ll="$SCRATCH/scheduler.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_shape must run first"
        return 1
    fi
    # Scope to the @sfn_taskqueue_dequeue body: the empty-ring wait
    # must lower to a `pthread_cond_wait` *inside* dequeue, not merely
    # somewhere else in the module. A non-blocking dequeue (the
    # lost-wakeup bug class) would have no cond_wait in this body.
    local body="$SCRATCH/dequeue.body"
    awk '/^define i8\* @sfn_taskqueue_dequeue\(/,/^}/' "$ll" > "$body"
    if [ ! -s "$body" ]; then
        echo "[test]   could not extract @sfn_taskqueue_dequeue body"
        return 1
    fi
    if ! grep -qE "call i32 @pthread_cond_wait\(" "$body"; then
        echo "[test]   @sfn_taskqueue_dequeue does not block on pthread_cond_wait:"
        cat "$body"
        return 1
    fi
    # And it must signal the producer side (not_full) after consuming.
    if ! grep -qE "call i32 @pthread_cond_signal\(" "$body"; then
        echo "[test]   @sfn_taskqueue_dequeue does not signal not_full after dequeue"
        return 1
    fi
    return 0
}

# ---- Test: linked single-thread FIFO roundtrip ----
test_roundtrip_fifo() {
    local ll="$SCRATCH/scheduler.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_shape must run first"
        return 1
    fi

    # The embedded PthreadMutex/PthreadCond storage in scheduler.sfn is
    # sized for Linux x86_64 (glibc): pthread_mutex_t = 40 B,
    # pthread_cond_t = 48 B. macOS arm64 needs a 64-byte
    # pthread_mutex_t, so executing the real `pthread_mutex_init`
    # against the 40-byte embedded field would overflow into the
    # adjacent cond storage. Platform-conditional sizing of the opaque
    # handles is deferred (docs/runtime_architecture.md §2.9 Q7), so
    # the *executing* roundtrip runs only where the static sizing is
    # correct. The IR-shape assertions above still pin the contract on
    # every platform (the emitted .ll is target-independent).
    local host_os
    host_os="$(uname -s)"
    if [ "$host_os" != "Linux" ]; then
        echo "[test]   host is $host_os, not Linux — skipping executing roundtrip"
        echo "[test]   (scheduler.sfn sizes pthread handles for Linux x86_64; §2.9 Q7)"
        return 0
    fi

    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
/* Single-thread correctness harness for the runtime/sfn MPMC task
 * queue (issue #1087). Drives the public surface and asserts FIFO
 * ordering, ring wraparound, the create(0) capacity clamp, and
 * null-safety. Single-threaded by design: enqueue never overruns
 * capacity and dequeue never reads an empty ring, so the blocking
 * cond_wait paths (which would deadlock without a second thread) are
 * never taken — they are pinned by the IR-shape assertions instead.
 * Contention is the worker pool's job (next M4 issue).
 *
 * Stubs mirror test_runtime_memory_arena.sh: the seed installs a
 * persistent-pointer hook on heap returns and a type-registration
 * ctor for named structs; no-op stubs keep the link self-contained.
 */
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

extern void *sfn_taskqueue_create(long capacity);
extern void sfn_taskqueue_destroy(void *q);
extern void sfn_taskqueue_enqueue(void *q, void *task);
extern void *sfn_taskqueue_dequeue(void *q);
extern long sfn_taskqueue_count(void *q);

void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }
void sfn_type_register(void *desc) { (void)desc; }
/* String literals (the SAILFIN_THREADS env name in
 * sfn_scheduler_resolve_thread_count) lower to @sfn_alloc_struct; stub
 * it with a plain allocator so the standalone link resolves. */
void *sfn_alloc_struct(long n) { return calloc(1, (size_t)n); }

int main(void) {
    void *q = sfn_taskqueue_create(4);
    if (!q) {
        fprintf(stderr, "create(4) returned NULL\n");
        return 1;
    }
    if (sfn_taskqueue_count(q) != 0) {
        fprintf(stderr, "fresh queue count = %ld, want 0\n", sfn_taskqueue_count(q));
        return 2;
    }

    /* Phase 1: FIFO. Three distinct sentinel addresses must come back
     * in insertion order. */
    void *a = (void *)0x1001, *b = (void *)0x2002, *c = (void *)0x3003;
    sfn_taskqueue_enqueue(q, a);
    sfn_taskqueue_enqueue(q, b);
    sfn_taskqueue_enqueue(q, c);
    if (sfn_taskqueue_count(q) != 3) {
        fprintf(stderr, "count after 3 enqueue = %ld, want 3\n", sfn_taskqueue_count(q));
        return 3;
    }
    void *d1 = sfn_taskqueue_dequeue(q);
    void *d2 = sfn_taskqueue_dequeue(q);
    void *d3 = sfn_taskqueue_dequeue(q);
    if (d1 != a || d2 != b || d3 != c) {
        fprintf(stderr, "FIFO violated: got %p %p %p, want %p %p %p\n",
                d1, d2, d3, a, b, c);
        return 4;
    }
    if (sfn_taskqueue_count(q) != 0) {
        fprintf(stderr, "count after drain = %ld, want 0\n", sfn_taskqueue_count(q));
        return 5;
    }

    /* Phase 2: ring wraparound. Capacity 4; 10 enqueue/dequeue pairs
     * force head and tail to wrap past the end of the buffer multiple
     * times. Each value must round-trip exactly. */
    for (long i = 0; i < 10; i++) {
        void *t = (void *)(uintptr_t)(0x4000 + i);
        sfn_taskqueue_enqueue(q, t);
        void *got = sfn_taskqueue_dequeue(q);
        if (got != t) {
            fprintf(stderr, "wrap roundtrip i=%ld got=%p want=%p\n", i, got, t);
            return 6;
        }
    }
    if (sfn_taskqueue_count(q) != 0) {
        fprintf(stderr, "count after wrap loop = %ld, want 0\n", sfn_taskqueue_count(q));
        return 7;
    }

    /* Phase 3: fill to capacity, then drain — exercises a full tail
     * wrap with the ring at peak occupancy. */
    void *e0 = (void *)0x5000, *e1 = (void *)0x5001;
    void *e2 = (void *)0x5002, *e3 = (void *)0x5003;
    sfn_taskqueue_enqueue(q, e0);
    sfn_taskqueue_enqueue(q, e1);
    sfn_taskqueue_enqueue(q, e2);
    sfn_taskqueue_enqueue(q, e3);
    if (sfn_taskqueue_count(q) != 4) {
        fprintf(stderr, "full-ring count = %ld, want 4\n", sfn_taskqueue_count(q));
        return 8;
    }
    if (sfn_taskqueue_dequeue(q) != e0) return 9;
    if (sfn_taskqueue_dequeue(q) != e1) return 10;
    if (sfn_taskqueue_dequeue(q) != e2) return 11;
    if (sfn_taskqueue_dequeue(q) != e3) return 12;

    /* Phase 4: create(0) clamps to capacity 1 (usable, not a crash). */
    void *q0 = sfn_taskqueue_create(0);
    if (!q0) {
        fprintf(stderr, "create(0) returned NULL — capacity clamp broken\n");
        return 13;
    }
    sfn_taskqueue_enqueue(q0, a);
    if (sfn_taskqueue_dequeue(q0) != a) {
        fprintf(stderr, "create(0) queue did not round-trip a single task\n");
        return 14;
    }
    sfn_taskqueue_destroy(q0);

    /* Phase 5: null-safety. */
    sfn_taskqueue_destroy(NULL);
    if (sfn_taskqueue_dequeue(NULL) != NULL) {
        fprintf(stderr, "dequeue(NULL) did not return NULL\n");
        return 15;
    }
    if (sfn_taskqueue_count(NULL) != 0) {
        fprintf(stderr, "count(NULL) did not return 0\n");
        return 16;
    }

    sfn_taskqueue_destroy(q);
    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping FIFO roundtrip"
        # Skip rather than fail on clang-less systems; the IR-shape
        # assertions above still pin the contract.
        return 0
    fi
    # `Wno-override-module` because the emitted .ll carries a target
    # triple that may not match the host clang default. `-lpthread`
    # binds the mutex/cond externs; `-lm` mirrors the arena harness
    # (the seed can leave libm references from integer-literal
    # lowering).
    local bin="$SCRATCH/roundtrip"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" -o "$bin" -lpthread -lm 2>"$SCRATCH/clang.log"; then
        echo "[test]   clang failed to link FIFO harness:"
        cat "$SCRATCH/clang.log"
        return 1
    fi
    if ! "$bin"; then
        local rc=$?
        echo "[test]   FIFO roundtrip binary exited non-zero (rc=$rc)"
        return 1
    fi
    return 0
}

# ---- Test: worker-pool emitted IR shape (issue #1088) ----
test_pool_emit_shape() {
    local ll="$SCRATCH/scheduler.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_shape must run first"
        return 1
    fi

    local missing=0

    # The worker-pool surface must be defined.
    local fn
    for fn in create shutdown worker next_task thread_count processed resolve_thread_count; do
        if ! grep -qE "^define .*@sfn_scheduler_${fn}\(" "$ll"; then
            echo "[test]   missing definition: @sfn_scheduler_${fn}"
            missing=$((missing + 1))
        fi
    done

    # The worker entry's address must materialize as a real code pointer
    # (the #1146 fn-reference → address lowering) — NOT the silent null
    # the frontend emitted before #1146. This is the whole reason the
    # first pickup of #1088 halted.
    if ! grep -qE "bitcast .*@sfn_scheduler_worker.* to i8\*" "$ll"; then
        echo "[test]   missing 'bitcast <fnty> @sfn_scheduler_worker... to i8*' (worker fn-ref not materialized)"
        grep -nE "sfn_scheduler_worker" "$ll" || true
        missing=$((missing + 1))
    fi

    # Scope to the @sfn_scheduler_create body: the start_routine slot
    # handed to pthread_create must NOT be a null — the #1146 regression.
    local body="$SCRATCH/create.body"
    awk '/^define .* @sfn_scheduler_create[^(]*\(/,/^}/' "$ll" > "$body"
    if [ ! -s "$body" ]; then
        echo "[test]   could not extract @sfn_scheduler_create body"
        missing=$((missing + 1))
    elif grep -qE "store i8\* null" "$body"; then
        echo "[test]   @sfn_scheduler_create stores i8* null (worker fn-ref dropped to null):"
        cat "$body"
        missing=$((missing + 1))
    fi

    # pthread lifecycle: spawn, join, and the broadcast that wakes parked
    # workers on shutdown.
    if ! grep -qE "call i32 @pthread_create\(" "$ll"; then
        echo "[test]   missing pthread_create call"
        missing=$((missing + 1))
    fi
    if ! grep -qE "call i32 @pthread_join\(" "$ll"; then
        echo "[test]   missing pthread_join call"
        missing=$((missing + 1))
    fi
    if ! grep -qE "call i32 @pthread_cond_broadcast\(" "$ll"; then
        echo "[test]   missing pthread_cond_broadcast (shutdown wakeup) call"
        missing=$((missing + 1))
    fi

    # Pool sizing queries the online CPU count via sysconf.
    if ! grep -qE "call i64 @sysconf\(" "$ll"; then
        echo "[test]   missing sysconf (core count) call"
        missing=$((missing + 1))
    fi

    # The atomic shutdown flag: set to 1 atomically. The ring slots store
    # task-address *registers*, so a literal `store atomic i64 1` is
    # specific to the shutdown publish.
    if ! grep -qE "store atomic i64 1," "$ll"; then
        echo "[test]   missing 'store atomic i64 1' (atomic shutdown flag publish)"
        missing=$((missing + 1))
    fi

    return "$missing"
}

# ---- Test: multi-threaded pool spin-up / drain / join round-trip ----
test_pool_roundtrip() {
    local ll="$SCRATCH/scheduler.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_shape must run first"
        return 1
    fi

    # Same Linux-x86_64-only guard as the FIFO roundtrip: the embedded
    # pthread handle storage is sized for glibc.
    local host_os
    host_os="$(uname -s)"
    if [ "$host_os" != "Linux" ]; then
        echo "[test]   host is $host_os, not Linux — skipping executing pool roundtrip"
        return 0
    fi

    local harness="$SCRATCH/pool_harness.c"
    cat > "$harness" <<'CHARNESS'
/* Multi-threaded round-trip harness for the fixed worker pool
 * (issue #1088). Spins up a real pthread pool, enqueues many sentinel
 * tasks, requests an atomic draining shutdown, and asserts every task
 * was pulled (no leak, no deadlock) and the SAILFIN_THREADS override is
 * honored. Tasks are bare non-null sentinel addresses: task INVOCATION
 * is the next M4 issue, so the worker only pulls + drains here.
 *
 * No-op stubs mirror the FIFO harness: the seed installs a
 * persistent-pointer hook and a type-registration ctor.
 */
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

extern void *sfn_taskqueue_create(long capacity);
extern void sfn_taskqueue_destroy(void *q);
extern void sfn_taskqueue_enqueue(void *q, void *task);
extern long sfn_taskqueue_count(void *q);

extern void *sfn_scheduler_create(void *queue);
extern void sfn_scheduler_shutdown(void *scheduler);
extern long sfn_scheduler_thread_count(void *scheduler);
extern long sfn_scheduler_processed(void *scheduler);

void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }
void sfn_type_register(void *desc) { (void)desc; }
/* SAILFIN_THREADS string literal lowers to @sfn_alloc_struct. */
void *sfn_alloc_struct(long n) { return calloc(1, (size_t)n); }

int main(void) {
    /* Phase 1: SAILFIN_THREADS override is honored. */
    setenv("SAILFIN_THREADS", "3", 1);
    void *q = sfn_taskqueue_create(8);
    if (!q) { fprintf(stderr, "queue create failed\n"); return 1; }

    void *sched = sfn_scheduler_create(q);
    if (!sched) { fprintf(stderr, "scheduler create failed\n"); return 2; }
    if (sfn_scheduler_thread_count(sched) != 3) {
        fprintf(stderr, "SAILFIN_THREADS=3 not honored: thread_count=%ld\n",
                sfn_scheduler_thread_count(sched));
        return 3;
    }

    /* Enqueue more tasks than the ring holds (capacity 8, N=100): the
     * producer blocks on a full ring while the 3 workers drain it,
     * exercising concurrent enqueue/dequeue without deadlock. */
    const long N = 100;
    for (long i = 0; i < N; i++) {
        sfn_taskqueue_enqueue(q, (void *)(uintptr_t)(0x1000 + i));
    }

    /* Atomic draining shutdown: must pull every queued task, then join
     * all workers. Hangs here would mean a lost wakeup / deadlock. */
    sfn_scheduler_shutdown(sched);

    if (sfn_taskqueue_count(q) != 0) {
        fprintf(stderr, "queue not drained: count=%ld\n", sfn_taskqueue_count(q));
        return 4;
    }
    if (sfn_scheduler_processed(sched) != N) {
        fprintf(stderr, "pool pulled %ld tasks, want %ld\n",
                sfn_scheduler_processed(sched), N);
        return 5;
    }
    sfn_taskqueue_destroy(q);

    /* Phase 2: default sizing = min(cores, 4) when no override. */
    unsetenv("SAILFIN_THREADS");
    void *q2 = sfn_taskqueue_create(4);
    void *sched2 = sfn_scheduler_create(q2);
    if (!sched2) { fprintf(stderr, "default scheduler create failed\n"); return 6; }
    long tc = sfn_scheduler_thread_count(sched2);
    if (tc < 1 || tc > 4) {
        fprintf(stderr, "default thread_count=%ld, want 1..4\n", tc);
        return 7;
    }
    sfn_scheduler_shutdown(sched2);
    sfn_taskqueue_destroy(q2);

    /* Phase 3: null-safety. */
    sfn_scheduler_shutdown(NULL);
    if (sfn_scheduler_thread_count(NULL) != 0) {
        fprintf(stderr, "thread_count(NULL) != 0\n");
        return 8;
    }
    if (sfn_scheduler_processed(NULL) != 0) {
        fprintf(stderr, "processed(NULL) != 0\n");
        return 9;
    }

    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping pool roundtrip"
        return 0
    fi
    local bin="$SCRATCH/pool_roundtrip"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" -o "$bin" -lpthread -lm 2>"$SCRATCH/pool_clang.log"; then
        echo "[test]   clang failed to link pool harness:"
        cat "$SCRATCH/pool_clang.log"
        return 1
    fi
    if ! "$bin"; then
        local rc=$?
        echo "[test]   pool roundtrip binary exited non-zero (rc=$rc)"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/concurrency/scheduler.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/concurrency/scheduler.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces the sfn_taskqueue_* surface" test_emit_shape
run_test "blocking dequeue waits on a condition under the mutex" test_dequeue_blocks_on_cond
run_test "single-thread enqueue/dequeue is FIFO with ring wraparound" test_roundtrip_fifo
run_test "sfn emit llvm produces the worker-pool surface (#1088)" test_pool_emit_shape
run_test "multi-threaded pool spin-up drains the queue and joins (#1088)" test_pool_roundtrip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
