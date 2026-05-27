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
    # End-to-end thread-isolation check against the actual driver
    # for #730 — `runtime/sfn/exception.sfn`'s frame-head chain
    # pointer. Two pthreads each push a frame; each verifies that
    # `sfn_exception_frame_head()` returns *its own* frame rather
    # than the sibling thread's. Before #730 (when the chain head
    # was `internal global`), this would corrupt the cross-thread
    # view; after #730 the TLS lowering keeps each thread's chain
    # head isolated.
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

    local repo_root
    repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
    local module="$repo_root/runtime/sfn/exception.sfn"
    local ll="$SCRATCH/exception.ll"
    if ! "$BINARY" emit -o "$ll" llvm "$module" > /dev/null 2>&1; then
        echo "[test]   sfn emit llvm failed for runtime/sfn/exception.sfn"
        return 1
    fi

    local harness="$SCRATCH/pthread_harness.c"
    cat > "$harness" <<'CHARNESS'
/* Thread-isolation harness for the `thread_local` storage class
 * (#730). Spawns two pthreads, each of which allocates and pushes
 * its own SfnExceptionFrame. The thread_local chain head must
 * resolve to the per-thread frame at each read site; if the head
 * is process-global (pre-#730) the two threads race and at least
 * one read returns the sibling's pointer.
 *
 * Synchronization. We don't use a barrier — the threads simply
 * push their frame, spin briefly (`sched_yield` + a small loop
 * that re-reads the head 1024 times), and then verify. The spin
 * gives the OS scheduler a window to interleave the writes; on a
 * pre-#730 binary at least one of those 1024 reads returns the
 * sibling thread's pointer, surfacing the bug deterministically
 * enough to fail CI. On a #730-correct binary every read returns
 * the local frame.
 */
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <pthread.h>
#include <sched.h>

struct SfnExceptionFrame {
    int64_t prev_addr;
    int64_t jmp_buf_addr;
    int64_t message_addr;
};

extern struct SfnExceptionFrame *sfn_exception_alloc_frame(void);
extern void sfn_exception_free_frame(struct SfnExceptionFrame *frame);
extern struct SfnExceptionFrame *sfn_exception_frame_head(void);
extern void sfn_exception_push_frame(struct SfnExceptionFrame *frame);
extern void sfn_exception_pop_frame(struct SfnExceptionFrame *frame);

void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }

struct WorkerArgs {
    int id;
    int leak_count;  /* number of head() reads that didn't match the local frame */
};

static void *worker(void *raw) {
    struct WorkerArgs *args = (struct WorkerArgs *)raw;
    args->leak_count = 0;

    struct SfnExceptionFrame *frame = sfn_exception_alloc_frame();
    if (!frame) {
        args->leak_count = -1;
        return NULL;
    }

    /* Each worker pushes; under TLS the head is its own frame.
     * Under process-global storage the second writer overwrites
     * the first and at least one of the 1024 reads below sees
     * the sibling's pointer. */
    sfn_exception_push_frame(frame);

    for (int i = 0; i < 1024; ++i) {
        if (i % 64 == 0) sched_yield();
        struct SfnExceptionFrame *head = sfn_exception_frame_head();
        if (head != frame) {
            args->leak_count += 1;
        }
    }

    sfn_exception_pop_frame(frame);
    sfn_exception_free_frame(frame);
    return NULL;
}

int main(void) {
    pthread_t t1, t2;
    struct WorkerArgs a1 = { .id = 1, .leak_count = 0 };
    struct WorkerArgs a2 = { .id = 2, .leak_count = 0 };

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

    if (a1.leak_count < 0 || a2.leak_count < 0) {
        fprintf(stderr, "alloc_frame returned NULL in a worker\n");
        return 3;
    }
    if (a1.leak_count != 0 || a2.leak_count != 0) {
        fprintf(stderr,
                "TLS bleed: worker 1 saw %d non-local heads, worker 2 saw %d.\n"
                "The frame-head chain pointer is not thread-local.\n",
                a1.leak_count, a2.leak_count);
        return 4;
    }
    return 0;
}
CHARNESS

    local bin="$SCRATCH/pthread_roundtrip"
    local type_meta_o="$repo_root/build/native/obj/runtime/type_meta.o"
    local extra_o=()
    if [ -f "$type_meta_o" ]; then
        extra_o+=("$type_meta_o")
    fi
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" "${extra_o[@]}" \
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

run_test "thread_local let mut lowers to 'internal thread_local global'" \
    test_lowering_emits_thread_local_qualifier
run_test "thread_local globals share the @global.<name> symbol at use sites" \
    test_lowering_load_store_use_same_symbol
run_test "thread_local let without mut reports E0807" \
    test_immutable_thread_local_rejected_with_E0807
run_test "thread_local let mut is accepted by typecheck" \
    test_mutable_thread_local_accepted
run_test "two pthreads writing to exception.sfn's TLS frame head do not interfere" \
    test_pthread_isolation_roundtrip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
