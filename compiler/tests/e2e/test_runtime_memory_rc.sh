#!/usr/bin/env bash
# End-to-end test for runtime/sfn/memory/rc.sfn — the Sailfin-defined
# atomic reference counting primitive shipped into the compiler binary
# (issue #395, epic #389 M2.3). Mirrors test_runtime_memory_arena.sh:
#
#   1. typecheck — `sfn check runtime/sfn/memory/rc.sfn` reports `ok`.
#   2. fmt       — `sfn fmt --check runtime/sfn/memory/rc.sfn` is canonical.
#   3. emit shape — emitted IR contains a `define` for each of the
#                   three `sfn_rc_sfn_*` exports plus `declare`s for the
#                   inlined `malloc` / `free` externs the bodies trampoline
#                   through.
#   4. atomicrmw — `sfn_rc_sfn_retain` carries exactly one
#                  `atomicrmw add ptr ... seq_cst` and `sfn_rc_sfn_release`
#                  carries exactly one `atomicrmw sub ptr ... seq_cst`.
#                  Pins the IR shape the architect spec
#                  (`docs/runtime_architecture.md` §2.1.2) demands —
#                  a regression that re-routes through a runtime call
#                  surfaces here instead of at link time.
#   5. coexistence — the Sailfin-emitted symbols use the `sfn_rc_sfn_*`
#                    namespace so the C runtime's existing
#                    `sfn_rc_release` no-op stub
#                    (`runtime/native/src/sailfin_runtime.c:1885`)
#                    survives side-by-side at link time. Any future
#                    patch that flips a Sailfin export to a bare
#                    `sfn_rc_release` name (which would collide with
#                    the C stub) trips this assertion.
#   6. roundtrip — alloc → retain → release → release is byte-checked
#                  via the emitted IR's instrumentation: refcount
#                  starts at 1, retain bumps to 2, the first release
#                  drops to 1 without invoking free, the second
#                  release drops to 0 and triggers a single free.
#                  We exercise this functionally by linking the
#                  emitted `.ll` against a minimal C harness that
#                  counts `free` calls and asserts exactly one.

set -euo pipefail

BINARY="${1:?usage: test_runtime_memory_rc.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/memory/rc.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-rc-XXXXXX)"
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
        echo "[test]   sfn check exited non-zero on rc.sfn:"
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
    local ll="$SCRATCH/rc.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/memory/rc.sfn:"
        cat "$log"
        return 1
    fi

    local missing=0
    # Each `sfn_rc_sfn_*` export must produce exactly one `define`
    # in the emitted module — anchored at line start so a `call`
    # site does not satisfy the assertion. Signatures are pinned
    # so a regression that mangles parameter types (e.g. i64→i32)
    # surfaces here instead of at link time.
    if ! grep -qE "^define i8\* @sfn_rc_sfn_alloc\(i64 " "$ll"; then
        echo "[test]   missing 'define i8* @sfn_rc_sfn_alloc(i64 ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_rc_sfn_retain\(i8\* " "$ll"; then
        echo "[test]   missing 'define void @sfn_rc_sfn_retain(i8* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_rc_sfn_release\(i8\* " "$ll"; then
        echo "[test]   missing 'define void @sfn_rc_sfn_release(i8* ...)'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_emit_libc_declares() {
    local ll="$SCRATCH/rc.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # The libc primitives the bodies trampoline through must each
    # produce a `declare` line. Anchored at line start so a `call`
    # site does not satisfy the assertion.
    local missing=0
    for sym in malloc free; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in rc.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

test_atomicrmw_shape() {
    local ll="$SCRATCH/rc.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # The two retain/release atomics are the M2.3 proof of life.
    # Scope each assertion to its enclosing function via a `sed`
    # range so a stray `atomicrmw` elsewhere can't satisfy the
    # assertion (we own the file, but the scoped check stays honest
    # if a future helper grows an atomic of its own).
    local missing=0
    local retain_block
    retain_block="$(sed -n '/^define void @sfn_rc_sfn_retain(/,/^}/p' "$ll")"
    if ! echo "$retain_block" | grep -qE "atomicrmw add ptr .*, i64 1 seq_cst, align 8"; then
        echo "[test]   sfn_rc_sfn_retain missing 'atomicrmw add ptr ... seq_cst, align 8':"
        echo "$retain_block"
        missing=$((missing + 1))
    fi
    local release_block
    release_block="$(sed -n '/^define void @sfn_rc_sfn_release(/,/^}/p' "$ll")"
    if ! echo "$release_block" | grep -qE "atomicrmw sub ptr .*, i64 1 seq_cst, align 8"; then
        echo "[test]   sfn_rc_sfn_release missing 'atomicrmw sub ptr ... seq_cst, align 8':"
        echo "$release_block"
        missing=$((missing + 1))
    fi
    # The release body must also branch on the `prev == 1` post-decrement
    # check before calling free — without it the function would either
    # double-free (no guard) or never free (wrong guard). Anchored to the
    # release block so an `icmp eq i64 ..., 1` elsewhere can't satisfy it.
    if ! echo "$release_block" | grep -qE "icmp eq i64 .*, 1"; then
        echo "[test]   sfn_rc_sfn_release missing 'icmp eq i64 ..., 1' post-decrement guard:"
        echo "$release_block"
        missing=$((missing + 1))
    fi
    if ! echo "$release_block" | grep -qE "call void @free\("; then
        echo "[test]   sfn_rc_sfn_release missing 'call void @free(' on zero-refcount branch:"
        echo "$release_block"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_no_bare_sfn_rc_define() {
    local ll="$SCRATCH/rc.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # Coexistence regression: the Sailfin module must NOT emit a
    # bare `define ... @sfn_rc_release(` — that name belongs to the
    # C runtime's no-op stub (`runtime/native/src/sailfin_runtime.c`)
    # and a collision would fail `make compile` at link time. The
    # `sfn_rc_sfn_*` infix is the marker for Sailfin-emitted symbols.
    # When M3 retires the C stub, this assertion goes away.
    local found=0
    for sym in sfn_rc_alloc sfn_rc_retain sfn_rc_release; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: rc.sfn emits 'define ... @${sym}(', conflicts with C stub"
            found=$((found + 1))
        fi
    done
    return "$found"
}

test_roundtrip_frees_once() {
    # Functional roundtrip: link the emitted `.ll` against a tiny C
    # harness that intercepts `free` via a counter shim and runs
    # alloc → retain → release → release. Refcount discipline:
    # the second release must invoke `free` exactly once (refcount
    # transitions 1 → 2 → 1 → 0). A regression that double-frees
    # or never frees surfaces here.
    local ll="$SCRATCH/rc.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi

    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
/* Counts libc free() calls via interposition without an extra
 * library. The harness defines its own `free` that bumps a counter
 * and forwards to the real allocator's deallocation entry point —
 * since the rc.ll module emits `declare void @free(i8*)`, the
 * linker binds those references to this shim instead of libc. The
 * shim then calls `__libc_free` (glibc) or `free` from a private
 * dlopen on macOS. Linux glibc exposes `__libc_free` directly;
 * we use it here because the rc CI matrix is Linux x86_64 today.
 * macOS arm64 ships a separate test run that the issue's `Out:`
 * notes (M2 epic #389 ships Linux-first).
 */
#include <stddef.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern void __libc_free(void *ptr);

static long free_count = 0;

void free(void *ptr) {
    if (ptr) {
        free_count++;
        __libc_free(ptr);
    }
}

extern void *sfn_rc_sfn_alloc(int64_t size, void *drop_fn);
extern void sfn_rc_sfn_retain(void *payload);
extern void sfn_rc_sfn_release(void *payload);

/* Stub the runtime hook the emitted IR calls on every heap return.
 * The rc.sfn alloc body emits `call void @sailfin_runtime_mark_persistent`
 * on the returned payload pointer (the persistent-pointer bookkeeping
 * the seed compiler installs for heap returns). The full runtime
 * implementation lives in `runtime/native/src/sailfin_runtime.c`; the
 * harness binds only the symbols the rc roundtrip exercises, so we
 * provide a no-op stub for everything else the IR references. */
void sailfin_runtime_mark_persistent(void *ptr) {
    (void)ptr;
}

int main(void) {
    void *payload = sfn_rc_sfn_alloc(32, NULL);
    if (!payload) {
        fprintf(stderr, "alloc returned NULL\n");
        return 1;
    }

    /* refcount: 1 → 2 */
    sfn_rc_sfn_retain(payload);

    /* refcount: 2 → 1 — must NOT call free */
    sfn_rc_sfn_release(payload);
    if (free_count != 0) {
        fprintf(stderr, "release at refcount=2 unexpectedly freed (count=%ld)\n", free_count);
        return 2;
    }

    /* refcount: 1 → 0 — must call free exactly once */
    sfn_rc_sfn_release(payload);
    if (free_count != 1) {
        fprintf(stderr, "release at refcount=1 produced free_count=%ld (expected 1)\n", free_count);
        return 3;
    }

    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping roundtrip"
        # Skip rather than fail so the test passes on systems
        # without clang. The earlier IR-shape assertions still
        # pin the contract; this roundtrip is the runtime cherry.
        return 0
    fi
    # `Wno-override-module` because the .ll emitted by the Sailfin
    # compiler carries a target triple that may not match the host
    # clang's default (see Makefile.CLANG_WARN_SUPPRESS).
    # `-lm` because the seed compiler lowers integer literals
    # through `round(double)` + `fptosi`, leaving libm references
    # in the emitted `.ll` (verified in /tmp during M2.3 bring-up).
    # Once the literal-coercion path moves to direct `i64` constants
    # the libm dependency retires.
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

run_test "sfn check runtime/sfn/memory/rc.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/memory/rc.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every sfn_rc_sfn_* export" test_emit_define_shape
run_test "sfn emit llvm declares libc malloc/free trampolines" test_emit_libc_declares
run_test "sfn emit llvm pins atomicrmw add/sub seq_cst shape in retain/release" test_atomicrmw_shape
run_test "sfn emit llvm does not collide with C sfn_rc_release stub" test_no_bare_sfn_rc_define
run_test "alloc → retain → release → release frees exactly once" test_roundtrip_frees_once

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
