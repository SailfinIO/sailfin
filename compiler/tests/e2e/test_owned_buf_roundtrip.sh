#!/usr/bin/env bash
# End-to-end test for runtime/sfn/memory/ownedbuf.sfn — the OwnedBuf /
# Slice owned-buffer type family SURFACE (issue #1212, E3 of the
# ownership epic #1209). The module ships the type pair + API only;
# move semantics (E5/E6) and view lifetimes (E8) are not enforced yet,
# so this test pins the surface: parse/typecheck/fmt, the LLVM
# aggregate layout, the nine-function define shape, the four inlined
# extern declares, and a clang-linked functional roundtrip.
#
# Phases:
#
#   1. typecheck — `sfn check runtime/sfn/memory/ownedbuf.sfn` reports `ok`.
#   2. fmt       — `sfn fmt --check runtime/sfn/memory/ownedbuf.sfn` is canonical.
#   3. emit shape — emitted IR contains the pinned aggregates
#                   (`%OwnedBuf = type { i64, i64, i64, i64 }`,
#                   `%Slice = type { i64, i64 }`) and a `define` for
#                   each of the nine functions (eight public + the
#                   `_owned_buf_load_byte` word-load helper).
#   4. extern declares — `declare`s for the four inlined externs the
#                   bodies route through (`malloc` / `memcpy` /
#                   `sfn_arena_sfn_alloc` / `sfn_arena_sfn_realloc`).
#   5. roundtrip — link the emitted `.ll` (alongside the arena `.ll`,
#                   since append grows through `sfn_arena_sfn_realloc`)
#                   against a clang harness that exercises
#                   new → append "hello" → len/byte_at → append " world"
#                   (forces the grow-at-tip realloc path past the
#                   initial capacity) → slice(0, 5) → slice_len /
#                   slice_byte_at, plus the libc-backed
#                   (`arena_addr == 0`) fallback. Mirrors
#                   `test_runtime_memory_arena.sh`'s functional cherry
#                   on top of the IR-shape assertions.

set -euo pipefail

BINARY="${1:?usage: test_owned_buf_roundtrip.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/memory/ownedbuf.sfn"
ARENA="$REPO_ROOT/runtime/sfn/memory/arena.sfn"

SCRATCH="$(mktemp -d -t sfn-owned-buf-XXXXXX)"
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
        echo "[test]   sfn check exited non-zero on ownedbuf.sfn:"
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

test_emit_type_shape() {
    local ll="$SCRATCH/ownedbuf.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/memory/ownedbuf.sfn:"
        cat "$log"
        return 1
    fi

    # The aggregate layouts are the E3 contract: OwnedBuf is four i64
    # slots (`ptr_addr`, `len`, `cap`, `arena_addr`) and Slice is two
    # (`ptr_addr`, `len`). The `_addr` fields ride as i64 (arena.sfn
    # discipline) — a regression that types one as a pointer changes
    # these lines and must surface here.
    local missing=0
    if ! grep -qF '%OwnedBuf = type { i64, i64, i64, i64 }' "$ll"; then
        echo "[test]   missing '%OwnedBuf = type { i64, i64, i64, i64 }'"
        missing=$((missing + 1))
    fi
    if ! grep -qF '%Slice = type { i64, i64 }' "$ll"; then
        echo "[test]   missing '%Slice = type { i64, i64 }'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_emit_define_shape() {
    local ll="$SCRATCH/ownedbuf.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_type_shape must run first"
        return 1
    fi
    # Each function must produce exactly one `define` in the emitted
    # module — anchored at line start so a `call` site does not
    # satisfy the assertion. The signatures are pinned: struct
    # params/returns ride the boxed-struct ABI (`%OwnedBuf*` /
    # `%Slice*`), so a regression that flips a by-value struct to a
    # different ABI surfaces here instead of at link time.
    local missing=0
    if ! grep -qE '^define %OwnedBuf\* @owned_buf_new\(i64 ' "$ll"; then
        echo "[test]   missing 'define %OwnedBuf* @owned_buf_new(i64 ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define %OwnedBuf\* @owned_buf_append\(%OwnedBuf\* ' "$ll"; then
        echo "[test]   missing 'define %OwnedBuf* @owned_buf_append(%OwnedBuf* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i64 @owned_buf_len\(%OwnedBuf\* ' "$ll"; then
        echo "[test]   missing 'define i64 @owned_buf_len(%OwnedBuf* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i64 @owned_buf_cap\(%OwnedBuf\* ' "$ll"; then
        echo "[test]   missing 'define i64 @owned_buf_cap(%OwnedBuf* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i64 @owned_buf_byte_at\(%OwnedBuf\* ' "$ll"; then
        echo "[test]   missing 'define i64 @owned_buf_byte_at(%OwnedBuf* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define %Slice\* @owned_buf_slice\(%OwnedBuf\* ' "$ll"; then
        echo "[test]   missing 'define %Slice* @owned_buf_slice(%OwnedBuf* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i64 @slice_len\(%Slice\* ' "$ll"; then
        echo "[test]   missing 'define i64 @slice_len(%Slice* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i64 @slice_byte_at\(%Slice\* ' "$ll"; then
        echo "[test]   missing 'define i64 @slice_byte_at(%Slice* ...)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE '^define i64 @_owned_buf_load_byte\(i64 ' "$ll"; then
        echo "[test]   missing 'define i64 @_owned_buf_load_byte(i64 ...)'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_emit_extern_declares() {
    local ll="$SCRATCH/ownedbuf.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_type_shape must run first"
        return 1
    fi
    # The four inlined externs the bodies route through must each
    # produce a `declare` line. Anchored at line start so a `call`
    # site does not satisfy the assertion. The arena pair matches the
    # export signatures in runtime/sfn/memory/arena.sfn — append's
    # grow path is a cross-module call resolved at link time.
    local missing=0
    for sym in malloc memcpy sfn_arena_sfn_alloc sfn_arena_sfn_realloc; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in ownedbuf.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

test_roundtrip() {
    # Functional roundtrip: link the emitted `.ll` (plus the arena
    # `.ll`, which defines the `sfn_arena_sfn_alloc` /
    # `sfn_arena_sfn_realloc` bodies append grows through) against a
    # clang harness that exercises the whole public surface.
    local ll="$SCRATCH/ownedbuf.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_type_shape must run first"
        return 1
    fi

    local arena_ll="$SCRATCH/arena.ll"
    local log="$SCRATCH/emit-arena.log"
    if ! "$BINARY" emit -o "$arena_ll" llvm "$ARENA" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/memory/arena.sfn:"
        cat "$log"
        return 1
    fi

    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
/* Roundtrip harness for runtime/sfn/memory/ownedbuf.sfn (E3 surface,
 * issue #1212). Links against the emitted ownedbuf.ll + arena.ll and
 * drives the eight public entry points end-to-end.
 *
 * ABI notes: by-value `OwnedBuf` / `Slice` params and returns ride
 * the boxed-struct ABI, so the C side sees opaque pointers. The
 * `int64_t` `*_addr` params carry raw addresses (the module's `_addr`
 * discipline).
 *
 * The initial capacity is 8 so the second append (5 + 6 = 11 bytes)
 * overflows and forces the `sfn_arena_sfn_realloc` grow path — with
 * the buffer at the arena's bump tip this is the grow-at-tip case.
 */
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

extern void *sfn_arena_sfn_create(size_t default_page_size);
extern void sfn_arena_sfn_destroy(void *arena);

extern void *owned_buf_new(int64_t arena_addr, int64_t initial_cap);
extern void *owned_buf_append(void *self, int64_t suffix_addr, int64_t suffix_len);
extern int64_t owned_buf_len(void *self);
extern int64_t owned_buf_cap(void *self);
extern int64_t owned_buf_byte_at(void *self, int64_t index);
extern void *owned_buf_slice(void *self, int64_t start, int64_t end);
extern int64_t slice_len(void *slice);
extern int64_t slice_byte_at(void *slice, int64_t index);

/* Stub the runtime symbols the emitted IR references so the link is
 * self-contained against the bare `.ll` pair (same pattern as
 * test_runtime_memory_arena.sh — see its harness header for the
 * rationale on each). `sfn_alloc_struct` backs the boxed-struct
 * returns; a plain malloc suffices because every box is fully
 * initialized by a whole-aggregate store before use.
 *
 * #1309: `sfn_arena_enabled` / `sfn_arena_global` are now DEFINED in
 * arena.ll (they replaced the removed C namesakes), so stubbing them
 * here would be a duplicate-symbol link error — the linked arena.ll
 * provides them. They pull in `sfn_alloc_struct` (their probe literals)
 * which the stub below satisfies. */
void sailfin_runtime_mark_persistent(void *ptr) {
    (void)ptr;
}

void sfn_type_register(void *desc) {
    (void)desc;
}

void *sfn_alloc_struct(int64_t size) {
    return malloc((size_t)size);
}

int main(void) {
    /* Phase 1: arena + empty buffer. cap 8 (already a multiple of 8)
     * so the second append must grow. */
    void *arena = sfn_arena_sfn_create(0);
    if (!arena) {
        fprintf(stderr, "sfn_arena_sfn_create(0) returned NULL\n");
        return 1;
    }
    void *buf = owned_buf_new((int64_t)(intptr_t)arena, 8);
    if (!buf) {
        fprintf(stderr, "owned_buf_new returned NULL\n");
        return 2;
    }
    if (owned_buf_len(buf) != 0) {
        fprintf(stderr, "fresh buffer len != 0\n");
        return 3;
    }
    if (owned_buf_cap(buf) != 8) {
        fprintf(stderr, "fresh buffer cap != 8 (got %lld)\n",
                (long long)owned_buf_cap(buf));
        return 4;
    }

    /* Phase 2: append "hello" (fits in place) + byte reads. */
    void *buf2 = owned_buf_append(buf, (int64_t)(intptr_t)"hello", 5);
    if (owned_buf_len(buf2) != 5) {
        fprintf(stderr, "len after \"hello\": %lld (expected 5)\n",
                (long long)owned_buf_len(buf2));
        return 5;
    }
    if (owned_buf_byte_at(buf2, 0) != 'h') {
        fprintf(stderr, "byte_at(0): %lld (expected 'h')\n",
                (long long)owned_buf_byte_at(buf2, 0));
        return 6;
    }
    if (owned_buf_byte_at(buf2, 4) != 'o') {
        fprintf(stderr, "byte_at(4): %lld (expected 'o')\n",
                (long long)owned_buf_byte_at(buf2, 4));
        return 7;
    }
    if (owned_buf_byte_at(buf2, 5) != -1) {
        fprintf(stderr, "byte_at(5) out-of-bounds did not return -1\n");
        return 8;
    }
    if (owned_buf_byte_at(buf2, -1) != -1) {
        fprintf(stderr, "byte_at(-1) did not return -1\n");
        return 9;
    }

    /* Phase 3: append " world" — 11 bytes total overflows cap 8 and
     * exercises the sfn_arena_sfn_realloc grow path. Every byte must
     * survive the relocation. */
    void *buf3 = owned_buf_append(buf2, (int64_t)(intptr_t)" world", 6);
    if (owned_buf_len(buf3) != 11) {
        fprintf(stderr, "len after \" world\": %lld (expected 11)\n",
                (long long)owned_buf_len(buf3));
        return 10;
    }
    if (owned_buf_cap(buf3) < 11) {
        fprintf(stderr, "cap after grow: %lld (expected >= 11)\n",
                (long long)owned_buf_cap(buf3));
        return 11;
    }
    const char *expect = "hello world";
    for (int64_t i = 0; i < 11; i++) {
        if (owned_buf_byte_at(buf3, i) != expect[i]) {
            fprintf(stderr, "byte_at(%lld): %lld (expected '%c')\n",
                    (long long)i, (long long)owned_buf_byte_at(buf3, i),
                    expect[i]);
            return 12;
        }
    }

    /* Phase 4: non-owning view over the first five bytes. */
    void *slice = owned_buf_slice(buf3, 0, 5);
    if (slice_len(slice) != 5) {
        fprintf(stderr, "slice_len: %lld (expected 5)\n",
                (long long)slice_len(slice));
        return 13;
    }
    if (slice_byte_at(slice, 0) != 'h') {
        fprintf(stderr, "slice_byte_at(0): %lld (expected 'h')\n",
                (long long)slice_byte_at(slice, 0));
        return 14;
    }
    if (slice_byte_at(slice, 4) != 'o') {
        fprintf(stderr, "slice_byte_at(4): %lld (expected 'o')\n",
                (long long)slice_byte_at(slice, 4));
        return 15;
    }
    if (slice_byte_at(slice, 5) != -1) {
        fprintf(stderr, "slice_byte_at(5) out-of-bounds did not return -1\n");
        return 16;
    }

    /* Phase 5: libc-backed fallback (arena_addr == 0) — first append
     * allocates via malloc. */
    void *mbuf = owned_buf_new(0, 0);
    mbuf = owned_buf_append(mbuf, (int64_t)(intptr_t)"abc", 3);
    if (owned_buf_len(mbuf) != 3) {
        fprintf(stderr, "libc-backed len: %lld (expected 3)\n",
                (long long)owned_buf_len(mbuf));
        return 17;
    }
    if (owned_buf_byte_at(mbuf, 2) != 'c') {
        fprintf(stderr, "libc-backed byte_at(2): %lld (expected 'c')\n",
                (long long)owned_buf_byte_at(mbuf, 2));
        return 18;
    }

    sfn_arena_sfn_destroy(arena);
    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping roundtrip"
        # Skip rather than fail so the test passes on systems without
        # clang. The IR-shape assertions above still pin the contract;
        # the roundtrip is the functional cherry on top.
        return 0
    fi
    # `Wno-override-module` + `-lm`: same rationale as
    # test_runtime_memory_arena.sh (emitted target triple may not
    # match the host clang default; integer literals lower through
    # libm `round`).
    local bin="$SCRATCH/roundtrip"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" "$arena_ll" -o "$bin" -lm 2>"$SCRATCH/clang.log"; then
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

run_test "sfn check runtime/sfn/memory/ownedbuf.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/memory/ownedbuf.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm pins the OwnedBuf/Slice aggregate layouts" test_emit_type_shape
run_test "sfn emit llvm produces define for every owned-buf function" test_emit_define_shape
run_test "sfn emit llvm declares the four inlined externs" test_emit_extern_declares
run_test "new → append → byte_at → grow → slice roundtrip" test_roundtrip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
