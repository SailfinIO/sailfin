#!/usr/bin/env bash
# End-to-end test for the `thread_local` storage-class annotation
# on top-level `let mut` declarations (#730).
#
# Pins the lowering shape: `thread_local let mut x: T = init;`
# must emit `@global.x = internal thread_local global <T> <init>`
# instead of the default `internal global` form. Three branches
# of `_process_one_binding` in
# `compiler/src/llvm/lowering/module_globals.sfn` matter — i64
# (the runtime-driver case), i1 (boolean), and double (float) —
# and the fixture exercises all three.
#
# Also pins the immutable rejection (`thread_local let x = ...`
# without `mut`) as an E0807 diagnostic. The diagnostic is a
# typecheck-level error rather than a parse error so the
# diagnostic carries the symbol name and a fix-it hint; the
# parser accepts the shape so its location info reaches the
# diagnostic emitter.
#
# Usage:
#   compiler/tests/e2e/test_thread_local_lowering.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_thread_local_lowering.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="$SCRIPT_DIR/fixtures/thread_local_basic.sfn"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-thread-local-XXXXXX)"
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

test_lowering_emits_thread_local_qualifier() {
    local ll="$SCRATCH/thread_local_basic.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$FIXTURE" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for thread_local_basic.sfn"
        return 1
    fi

    # i64 branch — the runtime-driver case
    # (`runtime/sfn/exception.sfn`'s frame-head pointer).
    if ! grep -qE '^@global\.head = internal thread_local global i64 0$' "$ll"; then
        echo "[test]   missing '@global.head = internal thread_local global i64 0':"
        grep -E '^@global\.' "$ll" || true
        return 1
    fi

    # i1 (boolean) branch — pins that the branch picks up the TLS
    # qualifier the same way the integer branch does.
    if ! grep -qE '^@global\.flag = internal thread_local global i1 1$' "$ll"; then
        echo "[test]   missing '@global.flag = internal thread_local global i1 1':"
        grep -E '^@global\.' "$ll" || true
        return 1
    fi

    # double (float) branch — pins the third lowering path. The
    # initializer text is whatever `normalise_number_literal`
    # produces for `0.0`, so match permissively on the qualifier
    # and type prefix.
    if ! grep -qE '^@global\.temperature = internal thread_local global double ' "$ll"; then
        echo "[test]   missing '@global.temperature = internal thread_local global double ...':"
        grep -E '^@global\.' "$ll" || true
        return 1
    fi

    return 0
}

test_lowering_load_store_use_same_symbol() {
    # `thread_local` only changes the declaration line; load/store
    # sites still address the global through `@global.<name>`. The
    # scheduler (#321) relies on this invariant.
    local ll="$SCRATCH/thread_local_basic.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_lowering_emits_thread_local_qualifier must run first"
        return 1
    fi
    if ! grep -qE 'load i64, i64\* @global\.head' "$ll"; then
        echo "[test]   missing load against @global.head"
        return 1
    fi
    if ! grep -qE 'store i64 .*, i64\* @global\.head' "$ll"; then
        echo "[test]   missing store against @global.head"
        return 1
    fi
    return 0
}

test_immutable_thread_local_rejected_with_E0807() {
    local src="$SCRATCH/immutable_tls.sfn"
    cat > "$src" <<'EOF'
thread_local let frame: i64 = 0;

fn main() -> i32 {
    return 0;
}
EOF
    local stderr
    stderr="$("$BINARY" check "$src" 2>&1 || true)"
    if ! echo "$stderr" | grep -q "E0807"; then
        echo "[test]   missing E0807 for 'thread_local let' (no mut)"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    if ! echo "$stderr" | grep -q "missing \`mut\`"; then
        echo "[test]   E0807 missing 'missing \`mut\`' hint"
        echo "         stderr was: $stderr" | head -5
        return 1
    fi
    return 0
}

test_mutable_thread_local_accepted() {
    # Sanity check that the same source minus the missing `mut`
    # passes — guards against an overzealous diagnostic that fires
    # on every thread_local declaration.
    local src="$SCRATCH/mutable_tls.sfn"
    cat > "$src" <<'EOF'
thread_local let mut frame: i64 = 0;

fn main() -> i32 {
    return 0;
}
EOF
    if ! "$BINARY" check "$src" > /dev/null 2>&1; then
        echo "[test]   'thread_local let mut' check failed (should be accepted)"
        "$BINARY" check "$src" 2>&1 | head -10
        return 1
    fi
    return 0
}

test_pthread_isolation_roundtrip() {
    # End-to-end thread-isolation check for `thread_local let mut`
    # (#825 / issue #730 criterion #4). Two pthreads each increment
    # the fixture's `head` (a `thread_local let mut: i64`) N times
    # via `bump_n(N)`; with TLS each thread sees exactly N as the
    # final value, regardless of what the sibling is doing. Without
    # TLS, sibling increments leak in and the return value exceeds
    # N on at least one thread.
    #
    # This fixture-driven roundtrip is the smaller-surface unit-level
    # pin: it exercises the `thread_local` lowering in isolation
    # without dragging in exception.sfn's struct-init constructor or
    # type_meta linkage. The exception.sfn-driven companion below
    # (test_exception_tls_isolation_roundtrip, #827) proves the same
    # isolation against the real runtime chain head now that the flip
    # has landed; this one stays as the lighter regression gate.
    #
    # Skipped when `clang` or pthread linkage is unavailable —
    # mirrors the cross-frame roundtrip skip in
    # test_runtime_exception_frames.sh; the IR-shape assertions
    # above still pin the contract.
    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping pthread roundtrip"
        return 0
    fi

    local ll="$SCRATCH/thread_local_basic.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_lowering_emits_thread_local_qualifier must run first"
        return 1
    fi

    # Sailfin mangles top-level function symbols by appending the
    # source-path components. Look up the actual mangled names so
    # the test survives a rename of the fixture without a manual
    # bump (the global `@global.head` is not mangled and is reached
    # only from Sailfin code in the fixture).
    local bump_sym
    bump_sym="$(grep -oE 'define i64 @bump_n[A-Za-z0-9_]*' "$ll" | head -1 | awk '{print $3}' | sed 's/^@//')"
    local read_sym
    read_sym="$(grep -oE 'define i64 @read_head[A-Za-z0-9_]*' "$ll" | head -1 | awk '{print $3}' | sed 's/^@//')"
    if [ -z "$bump_sym" ] || [ -z "$read_sym" ]; then
        echo "[test]   could not resolve bump_n/read_head mangled symbols in $ll"
        grep -E "^define i64" "$ll" || true
        return 1
    fi

    local harness="$SCRATCH/pthread_harness.c"
    cat > "$harness" <<CHARNESS
/* Thread-isolation harness for \`thread_local let mut\` (#825 /
 * issue #730 criterion #4). Each pthread calls \`bump_n(N)\` on a
 * Sailfin fixture whose \`head\` is a \`thread_local let mut: i64\`.
 * Under TLS each thread's \`head\` starts at 0 and ends at N. Under
 * a process-global \`let mut\` the threads' increments interleave
 * and at least one thread's final read exceeds N.
 */
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <pthread.h>
#include <sched.h>

extern int64_t ${bump_sym}(int64_t count);
extern int64_t ${read_sym}(void);

void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }

struct WorkerArgs {
    int id;
    int64_t bump_count;
    int64_t observed_head;
};

static void *worker(void *raw) {
    struct WorkerArgs *args = (struct WorkerArgs *)raw;
    /* Yield once before and once mid-flight to give the scheduler
     * a window to interleave the sibling thread's increments. */
    sched_yield();
    int64_t mid = ${bump_sym}(args->bump_count / 2);
    sched_yield();
    int64_t final_head = ${bump_sym}(args->bump_count - args->bump_count / 2);
    (void)mid;
    args->observed_head = final_head;
    /* One more read after the increments to catch any post-write
     * interleaving — under TLS this still equals bump_count. */
    sched_yield();
    args->observed_head = ${read_sym}();
    return NULL;
}

int main(void) {
    pthread_t t1, t2;
    struct WorkerArgs a1 = { .id = 1, .bump_count = 1000, .observed_head = -1 };
    struct WorkerArgs a2 = { .id = 2, .bump_count = 1000, .observed_head = -1 };

    if (pthread_create(&t1, NULL, worker, &a1) != 0) {
        fprintf(stderr, "pthread_create #1 failed\\n");
        return 1;
    }
    if (pthread_create(&t2, NULL, worker, &a2) != 0) {
        fprintf(stderr, "pthread_create #2 failed\\n");
        return 2;
    }
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (a1.observed_head != a1.bump_count) {
        fprintf(stderr,
                "TLS bleed: worker 1 expected head=%lld, got %lld\\n",
                (long long)a1.bump_count, (long long)a1.observed_head);
        return 3;
    }
    if (a2.observed_head != a2.bump_count) {
        fprintf(stderr,
                "TLS bleed: worker 2 expected head=%lld, got %lld\\n",
                (long long)a2.bump_count, (long long)a2.observed_head);
        return 4;
    }
    return 0;
}
CHARNESS

    local bin="$SCRATCH/pthread_roundtrip"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" \
            -o "$bin" -lm -lpthread 2>"$SCRATCH/clang.log"; then
        # No pthread linkage → skip (matches the runtime exception
        # roundtrip's `-lm` fallback policy). The IR-shape pin still
        # carries the contract.
        if grep -q "cannot find -lpthread" "$SCRATCH/clang.log"; then
            echo "[test]   -lpthread unavailable — skipping pthread roundtrip"
            return 0
        fi
        echo "[test]   clang failed to link pthread roundtrip:"
        cat "$SCRATCH/clang.log"
        return 1
    fi

    if ! "$bin" > "$SCRATCH/run.log" 2>&1; then
        local rc=$?
        echo "[test]   pthread roundtrip exited non-zero (rc=$rc):"
        cat "$SCRATCH/run.log"
        return 1
    fi
    return 0
}

test_exception_tls_isolation_roundtrip() {
    # End-to-end TLS-isolation check against the *real* runtime chain
    # head (#827). Mirrors test_pthread_isolation_roundtrip but drives
    # `runtime/sfn/exception.sfn`'s `sfn_exception_push_frame` /
    # `sfn_exception_frame_head` instead of the fixture, proving the
    # `thread_local let mut sfn_exception_frame_head_addr` flip gives
    # each thread its own chain head.
    #
    # Two pthreads each alloc a frame, push it onto the chain, then —
    # after an atomic barrier guarantees BOTH have pushed — read the
    # head back. Under TLS each thread's head is its own frame and the
    # main thread (which never pushed) still sees NULL. Without TLS the
    # global is shared: both workers (and main) observe whichever frame
    # was pushed last, so at least one observed_head != my_frame.
    #
    # Skipped when clang or pthread linkage is unavailable — mirrors
    # the cross-frame roundtrip skip in test_runtime_exception_frames.sh;
    # the IR-shape assertion in that file still pins the contract.
    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping exception TLS roundtrip"
        return 0
    fi

    local repo_root
    repo_root="$(cd "$SCRIPT_DIR/../../.." && pwd)"
    local module="$repo_root/runtime/sfn/exception.sfn"
    local ll="$SCRATCH/exception_tls.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$module" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for exception.sfn"
        return 1
    fi

    # exception.sfn defines the `SfnExceptionFrame` struct, so M2.10
    # (#402) emits an `@__sfn_module_type_init__*` constructor that
    # calls `@sfn_type_register`. Stage a type_meta object so the
    # standalone link resolves it (mirrors the cross-frame roundtrip
    # in test_runtime_exception_frames.sh). Skip if it can't be built.
    local type_meta_ll="$SCRATCH/type_meta.ll"
    local type_meta_o="$SCRATCH/type_meta.o"
    if ! { "$BINARY" emit -o "$type_meta_ll" llvm "$repo_root/runtime/sfn/type_meta.sfn" >/dev/null 2>&1 \
            && "$clang_bin" -Wno-override-module -c "$type_meta_ll" -o "$type_meta_o" 2>/dev/null; }; then
        echo "[test]   could not emit type_meta object — skipping exception TLS roundtrip"
        return 0
    fi

    local harness="$SCRATCH/exception_tls_harness.c"
    cat > "$harness" <<'CHARNESS'
/* TLS-isolation harness for runtime/sfn/exception.sfn's per-thread
 * chain head (#827). Each pthread pushes its own frame and, after an
 * atomic barrier, verifies sfn_exception_frame_head() returns that
 * frame. Under thread_local storage each thread is isolated and the
 * never-pushing main thread still sees NULL. */
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <pthread.h>
#include <sched.h>
#include <stdatomic.h>

struct SfnExceptionFrame {
    int64_t prev_addr;
    int64_t jmp_buf_addr;
    int64_t message_addr;
};

extern struct SfnExceptionFrame *sfn_exception_alloc_frame(void);
extern void sfn_exception_free_frame(struct SfnExceptionFrame *frame);
extern struct SfnExceptionFrame *sfn_exception_frame_head(void);
extern void sfn_exception_push_frame(struct SfnExceptionFrame *frame);

/* Sailfin's heap-return marker — no-op stub so the standalone link
 * doesn't pull in the C runtime (matches the cross-frame harness). */
void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }

static atomic_int pushed_count = 0;

struct WorkerArgs {
    int id;
    struct SfnExceptionFrame *my_frame;
    struct SfnExceptionFrame *observed_head;
};

static void *worker(void *raw) {
    struct WorkerArgs *args = (struct WorkerArgs *)raw;
    struct SfnExceptionFrame *f = sfn_exception_alloc_frame();
    if (!f) {
        args->my_frame = NULL;
        args->observed_head = (struct SfnExceptionFrame *)-1;
        atomic_fetch_add(&pushed_count, 1);
        return NULL;
    }
    args->my_frame = f;
    sfn_exception_push_frame(f);
    /* Barrier: spin until both workers have pushed, so a shared
     * (non-TLS) head is guaranteed to hold the *last* push by the
     * time anyone reads — making the bleed deterministically
     * detectable rather than timing-dependent. */
    atomic_fetch_add(&pushed_count, 1);
    while (atomic_load(&pushed_count) < 2) {
        sched_yield();
    }
    args->observed_head = sfn_exception_frame_head();
    return NULL;
}

int main(void) {
    pthread_t t1, t2;
    struct WorkerArgs a1 = { .id = 1, .my_frame = NULL, .observed_head = NULL };
    struct WorkerArgs a2 = { .id = 2, .my_frame = NULL, .observed_head = NULL };

    if (pthread_create(&t1, NULL, worker, &a1) != 0) {
        fprintf(stderr, "pthread_create #1 failed\n");
        return 1;
    }
    if (pthread_create(&t2, NULL, worker, &a2) != 0) {
        fprintf(stderr, "pthread_create #2 failed\n");
        return 2;
    }
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (a1.my_frame == NULL || a2.my_frame == NULL) {
        fprintf(stderr, "alloc_frame returned NULL in a worker\n");
        return 3;
    }
    if (a1.observed_head != a1.my_frame) {
        fprintf(stderr,
                "TLS bleed: worker 1 expected head=%p, got %p\n",
                (void *)a1.my_frame, (void *)a1.observed_head);
        return 4;
    }
    if (a2.observed_head != a2.my_frame) {
        fprintf(stderr,
                "TLS bleed: worker 2 expected head=%p, got %p\n",
                (void *)a2.my_frame, (void *)a2.observed_head);
        return 5;
    }
    /* The main thread never pushed — under TLS its head is still
     * NULL; a shared global would show a worker's frame here. */
    if (sfn_exception_frame_head() != NULL) {
        fprintf(stderr,
                "TLS bleed: main thread head=%p, expected NULL\n",
                (void *)sfn_exception_frame_head());
        return 6;
    }

    sfn_exception_free_frame(a1.my_frame);
    sfn_exception_free_frame(a2.my_frame);
    return 0;
}
CHARNESS

    local bin="$SCRATCH/exception_tls_roundtrip"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" "$type_meta_o" \
            -o "$bin" -lm -lpthread 2>"$SCRATCH/exc_clang.log"; then
        if grep -q "cannot find -lpthread" "$SCRATCH/exc_clang.log"; then
            echo "[test]   -lpthread unavailable — skipping exception TLS roundtrip"
            return 0
        fi
        echo "[test]   clang failed to link exception TLS roundtrip:"
        cat "$SCRATCH/exc_clang.log"
        return 1
    fi

    if ! "$bin" > "$SCRATCH/exc_run.log" 2>&1; then
        local rc=$?
        echo "[test]   exception TLS roundtrip exited non-zero (rc=$rc):"
        cat "$SCRATCH/exc_run.log"
        return 1
    fi
    return 0
}

run_test "thread_local let mut lowers to 'internal thread_local global'" \
    test_lowering_emits_thread_local_qualifier
run_test "thread_local globals share the @global.<name> symbol at use sites" \
    test_lowering_load_store_use_same_symbol
run_test "thread_local let without mut reports E0807" \
    test_immutable_thread_local_rejected_with_E0807
run_test "thread_local let mut is accepted by typecheck" \
    test_mutable_thread_local_accepted
run_test "two pthreads bumping a thread_local i64 head do not interfere" \
    test_pthread_isolation_roundtrip
run_test "two pthreads pushing exception.sfn frames see isolated chain heads" \
    test_exception_tls_isolation_roundtrip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
