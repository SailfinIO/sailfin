#!/usr/bin/env bash
# End-to-end test for runtime/sfn/memory/mem.sfn — the Sailfin-defined
# narrow memory primitives (`sfn_mem_get_field` / `_copy_bytes` /
# `_bounds_check` / `_free`) shipped into the compiler binary
# alongside the C runtime (issue #927, sub-issue of #390, tracker
# #821). Mirrors test_runtime_memory_rc.sh / test_runtime_memory_arena.sh:
#
#   1. typecheck — `sfn check runtime/sfn/memory/mem.sfn` reports `ok`.
#   2. fmt       — `sfn fmt --check runtime/sfn/memory/mem.sfn` canonical.
#   3. emit shape — emitted IR carries a `define` for each of the four
#                   `sfn_mem_*` exports plus `declare`s for the inlined
#                   libc externs the bodies route through.
#   4. coexistence — the four `sfn_mem_*` names are net-new (no bare
#                    `sailfin_runtime_*` collision), but assert the
#                    module does NOT emit the legacy C names so a
#                    future accidental rename surfaces here.
#   5. roundtrip — link the emitted `.ll` against a C harness that
#                  exercises copy_bytes (byte-exact copy + null/zero
#                  no-ops), bounds_check (in-range passes; the abort
#                  path is checked via a forked subprocess), get_field
#                  (returns a stable non-null zeroed buffer), and free
#                  (null-safe; non-null forwards to libc free in
#                  non-arena mode).

set -euo pipefail

BINARY="${1:?usage: test_runtime_memory_mem.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/memory/mem.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-mem-XXXXXX)"
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

test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on mem.sfn:"
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
    if ! "$BINARY" fmt --check "$SKELETON" > /dev/null 2>&1; then
        echo "[test]   $SKELETON needs formatting (run: sfn fmt --write $SKELETON)"
        return 1
    fi
    return 0
}

test_emit_define_shape() {
    local ll="$SCRATCH/mem.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/memory/mem.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0
    # Each `sfn_mem_*` export must produce exactly one `define`,
    # anchored at line start so a `call` site does not satisfy the
    # assertion. Parameter lists pinned so a regression that flips a
    # width (i64→i32) or retypes a pointer surfaces here, not at link.
    if ! grep -qE "^define i8\* @sfn_mem_get_field\(i8\* %base, i8\* %field\) " "$ll"; then
        echo "[test]   missing 'define i8* @sfn_mem_get_field(i8* %base, i8* %field)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_mem_copy_bytes\(i8\* %dest, i8\* %src, i64 %length\) " "$ll"; then
        echo "[test]   missing 'define void @sfn_mem_copy_bytes(i8* %dest, i8* %src, i64 %length)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_mem_bounds_check\(i64 %index, i64 %length\) " "$ll"; then
        echo "[test]   missing 'define void @sfn_mem_bounds_check(i64 %index, i64 %length)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_mem_free\(i8\* %ptr\) " "$ll"; then
        echo "[test]   missing 'define void @sfn_mem_free(i8* %ptr)'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_emit_libc_declares() {
    local ll="$SCRATCH/mem.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # The libc/runtime primitives the bodies route through must each
    # produce a `declare` line. Anchored at line start so a `call`
    # site does not satisfy the assertion.
    local missing=0
    for sym in malloc memcpy free write abort sfn_arena_enabled; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in mem.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

test_no_legacy_c_define() {
    local ll="$SCRATCH/mem.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # The Sailfin module must NOT emit a `define` under any legacy C
    # name — those bodies still live in the C runtime and a collision
    # would fail `make compile` at link. The `sfn_mem_*` infix is the
    # marker for the Sailfin-emitted primitives.
    local found=0
    for sym in sailfin_runtime_get_field sailfin_runtime_copy_bytes sailfin_runtime_bounds_check sailfin_runtime_free; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: mem.sfn emits 'define ... @${sym}(', conflicts with C runtime"
            found=$((found + 1))
        fi
    done
    return "$found"
}

test_roundtrip_behaviour() {
    # Functional roundtrip: link the emitted `.ll` against a C harness
    # that exercises every primitive's contract. `sfn_mem_free`'s
    # arena-mode guard reads the C `sfn_arena_enabled()`; the harness
    # stubs it to return 0 (arena off) so free forwards to a counting
    # shim. bounds_check's abort path is verified out-of-process via
    # fork so the abort doesn't kill the harness.
    local ll="$SCRATCH/mem.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi

    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
#include <stddef.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

/* Count free() via link-time interposition; intentionally leak (the
 * process is short-lived and the kernel reclaims on exit). The
 * acceptance criterion is "free called exactly once for the non-null
 * pointer, never for null", not "bytes returned to the allocator". */
static long free_count = 0;
void free(void *ptr) {
    if (ptr) free_count++;
}

/* Arena-mode probe stub: report arena OFF so sfn_mem_free forwards to
 * the counting free() shim above. */
int sfn_arena_enabled(void) { return 0; }

/* Runtime hooks the seed compiler installs in emitted IR that the
 * harness must satisfy at link time but does not exercise:
 *   - `sailfin_runtime_mark_persistent` — persistent-pointer
 *     bookkeeping the seed emits on every heap return (the
 *     get_field malloc'd buffer). No-op stub.
 *   - `sailfin_runtime_alloc_struct` — arena/calloc-backed boxing
 *     the seed emits for the string literal in bounds_check's abort
 *     diagnostic. Forward to calloc so the literal is materialized
 *     correctly when the abort path runs in the forked child. */
void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }
void *sailfin_runtime_alloc_struct(int64_t size) {
    return calloc(1, (size_t)size);
}

extern char *sfn_mem_get_field(char *base, char *field);
extern void  sfn_mem_copy_bytes(char *dest, char *src, int64_t length);
extern void  sfn_mem_bounds_check(int64_t index, int64_t length);
extern void  sfn_mem_free(void *ptr);

int main(void) {
    /* ---- copy_bytes: byte-exact copy ---- */
    char src[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    char dst[8] = {0};
    sfn_mem_copy_bytes(dst, src, 8);
    if (memcmp(src, dst, 8) != 0) {
        fprintf(stderr, "copy_bytes did not copy 8 bytes exactly\n");
        return 1;
    }
    /* null/zero are no-ops (must not crash, must not write) */
    char guard[4] = {9, 9, 9, 9};
    sfn_mem_copy_bytes(guard, NULL, 4);
    sfn_mem_copy_bytes(NULL, src, 4);
    sfn_mem_copy_bytes(guard, src, 0);
    sfn_mem_copy_bytes(guard, src, -1);
    if (guard[0] != 9 || guard[3] != 9) {
        fprintf(stderr, "copy_bytes no-op path wrote to dest\n");
        return 2;
    }

    /* ---- get_field: stable non-null zeroed buffer ---- */
    char *gf1 = sfn_mem_get_field((char *)0x1234, (char *)0x5678);
    char *gf2 = sfn_mem_get_field(NULL, NULL);
    if (!gf1 || !gf2) {
        fprintf(stderr, "get_field returned NULL\n");
        return 3;
    }
    if (gf1 != gf2) {
        fprintf(stderr, "get_field returned non-stable buffer across calls\n");
        return 4;
    }
    /* first bytes read as zero (empty string / zero scalar) */
    for (int i = 0; i < 16; i++) {
        if (gf1[i] != 0) {
            fprintf(stderr, "get_field buffer not zeroed at byte %d\n", i);
            return 5;
        }
    }

    /* ---- free: null-safe, non-null forwards once ---- */
    sfn_mem_free(NULL);
    if (free_count != 0) {
        fprintf(stderr, "free(NULL) unexpectedly called libc free\n");
        return 6;
    }
    /* Pass the get_field buffer (a real heap pointer) so free has
     * something legitimate to forward. */
    sfn_mem_free(gf1);
    if (free_count != 1) {
        fprintf(stderr, "free(non-null) produced free_count=%ld (expected 1)\n", free_count);
        return 7;
    }

    /* ---- bounds_check: in-range passes ---- */
    sfn_mem_bounds_check(0, 4);
    sfn_mem_bounds_check(3, 4);

    /* ---- bounds_check: out-of-range aborts (checked out-of-process) ---- */
    pid_t pid = fork();
    if (pid == 0) {
        /* Child: silence stderr, trigger the abort path. */
        freopen("/dev/null", "w", stderr);
        sfn_mem_bounds_check(4, 4); /* index == length → out of range */
        _exit(0);                   /* should never reach here */
    } else if (pid > 0) {
        int status = 0;
        waitpid(pid, &status, 0);
        if (!WIFSIGNALED(status)) {
            fprintf(stderr, "bounds_check(4,4) did not abort (status=%d)\n", status);
            return 8;
        }
    } else {
        fprintf(stderr, "fork failed\n");
        return 9;
    }

    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping roundtrip"
        return 0
    fi
    # `-Wno-override-module` for the emitted target triple mismatch;
    # `-lm` because the seed lowers integer literals through libm
    # (`round`/`fptosi`). No type_meta.o needed — mem.sfn defines no
    # named structs/enums/interfaces, so no `@__sfn_module_type_init__`
    # constructor is emitted.
    local bin="$SCRATCH/roundtrip"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" -o "$bin" -lm 2>"$SCRATCH/clang.log"; then
        echo "[test]   clang failed to link roundtrip harness:"
        cat "$SCRATCH/clang.log"
        return 1
    fi
    if ! "$bin"; then
        local rc=$?
        echo "[test]   roundtrip binary exited non-zero (rc=$rc)"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/memory/mem.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/memory/mem.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every sfn_mem_* export" test_emit_define_shape
run_test "sfn emit llvm declares libc/runtime trampolines" test_emit_libc_declares
run_test "sfn emit llvm does not collide with legacy C runtime names" test_no_legacy_c_define
run_test "copy_bytes/get_field/free/bounds_check behave per the C contract" test_roundtrip_behaviour

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
