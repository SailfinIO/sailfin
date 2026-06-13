#!/usr/bin/env bash
# The #1205 determinism regression — the acceptance gate for issue #1217
# (Phase R1 of the memory-safety epic #1209). #1205 is the seed-blocker
# class bug where grow-at-tip on a *possibly-aliased* buffer mutates
# storage another live reference still points at, nondeterministically
# corrupting bytes under heap pressure (it has bitten #890→#892 on the
# emitted `declare`/type-name path).
#
# Phase R1 closes the hazard structurally: the arena's in-place
# grow-at-tip (`sfn_arena_sfn_realloc`, arena.sfn) and the string append
# (`sfn_str_sfn_append`, string.sfn) are reachable from safe code ONLY
# through a unique `OwnedBuf` (consume-and-return move), so the
# ownership checker proves there is no live alias at the in-place
# mutation. This test is the runtime proof of that contract: it drives
# the `OwnedBuf` → `sfn_arena_sfn_realloc` grow-at-tip path and asserts
# (a) the unique-owner in-place grow is byte-correct, (b) when a second
# allocation defeats the tip the relocate+memcpy fallback preserves
# every live buffer's bytes — the case an UNSOUND in-place bump would
# corrupt — and (c) the whole sequence is deterministic across N sweeps
# (the #892 N=30 convention, applied to runtime behavior rather than IR
# text, since the corruption #1205 names is a runtime aliasing bug, not
# an emit-text bug).
#
# Why a clang-linked functional harness and not an IR emit-sweep:
# Phase R1's source change is `unsafe`-boundary annotation + the
# `OwnedBuf` move shape, which emit byte-identical IR — an IR sweep
# would be vacuous. Only a functional harness can reproduce-before /
# pass-after the aliasing corruption.
#
# Phases:
#   1. layout unification — `%OwnedBuf = type { i64, i64, i64, i64 }` is
#      emitted IDENTICALLY by ownedbuf.sfn and string.sfn, so the inline
#      cross-module surface links to one aggregate (issue #1217 risk: a
#      layout drift would mis-unify the boxed-struct ABI at link time).
#   2. grow-at-tip determinism — the clang harness Phases A/B/C below.

set -euo pipefail

BINARY="${1:?usage: test_owned_buf_grow_determinism.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
OWNEDBUF="$REPO_ROOT/runtime/sfn/memory/ownedbuf.sfn"
ARENA="$REPO_ROOT/runtime/sfn/memory/arena.sfn"
STRING="$REPO_ROOT/runtime/sfn/string.sfn"

SCRATCH="$(mktemp -d -t sfn-owned-grow-XXXXXX)"
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

emit_one() {
    local src="$1"
    local out="$2"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$out" llvm "$src" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on $src:"
        cat "$log"
        return 1
    fi
    return 0
}

# 1. The owned-buffer aggregate must be emitted byte-identically by both
#    the defining module (ownedbuf.sfn) and the consuming module
#    (string.sfn, which imports OwnedBuf/Slice). A drift here mis-links
#    the boxed-struct ABI (#1217 architect risk #1).
test_layout_unification() {
    local ob_ll="$SCRATCH/ownedbuf.ll"
    local str_ll="$SCRATCH/string.ll"
    emit_one "$OWNEDBUF" "$ob_ll" || return 1
    emit_one "$STRING" "$str_ll" || return 1
    local shape='%OwnedBuf = type { i64, i64, i64, i64 }'
    if ! grep -qF "$shape" "$ob_ll"; then
        echo "[test]   ownedbuf.sfn did not emit '$shape'"
        return 1
    fi
    if ! grep -qF "$shape" "$str_ll"; then
        echo "[test]   string.sfn did not emit '$shape' — layout drift vs ownedbuf.sfn"
        return 1
    fi
    # The migrated string surface must carry the owned-move return ABI.
    # (`sfn_str_sfn_slice` is NOT migrated — a non-owning `Slice` view over
    # an immediate-codepoint pseudo-pointer is unsound until the C runtime
    # retires that encoding; tracked at #1283. It keeps its `* u8` body.)
    if ! grep -qE '^define %OwnedBuf\* @sfn_str_sfn_append\(%OwnedBuf\* ' "$str_ll"; then
        echo "[test]   string.sfn missing 'define %OwnedBuf* @sfn_str_sfn_append(%OwnedBuf* ...)'"
        return 1
    fi
    if ! grep -qE '^define %OwnedBuf\* @sfn_str_sfn_concat\(' "$str_ll"; then
        echo "[test]   string.sfn missing 'define %OwnedBuf* @sfn_str_sfn_concat(...)'"
        return 1
    fi
    return 0
}

# 2. The grow-at-tip determinism harness.
test_grow_determinism() {
    local ob_ll="$SCRATCH/ownedbuf.ll"
    local arena_ll="$SCRATCH/arena.ll"
    emit_one "$OWNEDBUF" "$ob_ll" || return 1
    emit_one "$ARENA" "$arena_ll" || return 1

    local harness="$SCRATCH/grow_harness.c"
    cat > "$harness" <<'CHARNESS'
/* #1205 determinism gate for issue #1217. Links the emitted
 * ownedbuf.ll + arena.ll and drives the OwnedBuf grow-at-tip path under
 * arena pressure. Boxed-struct ABI: by-value OwnedBuf params/returns
 * ride opaque pointers; *_addr params carry raw addresses.
 */
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern void *sfn_arena_sfn_create(size_t default_page_size);
extern void sfn_arena_sfn_destroy(void *arena);

extern void *owned_buf_new(int64_t arena_addr, int64_t initial_cap);
extern void *owned_buf_append(void *self, int64_t suffix_addr, int64_t suffix_len);
extern int64_t owned_buf_len(void *self);
extern int64_t owned_buf_byte_at(void *self, int64_t index);

/* Runtime stubs the emitted IR references (same set as
 * test_owned_buf_roundtrip.sh). sfn_alloc_struct backs the boxed-struct
 * returns; plain malloc suffices because every box is fully initialized
 * by a whole-aggregate store before use.
 *
 * #1309: sfn_arena_enabled / sfn_arena_global are now defined in arena.ll
 * (linked below), so stubbing them here would collide; the real defs
 * reference sfn_alloc_struct, satisfied by the stub. */
void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }
void sfn_type_register(void *desc) { (void)desc; }
void *sfn_alloc_struct(int64_t size) { return malloc((size_t)size); }

/* Read back the whole buffer and compare to expect[0..n). */
static int check_bytes(void *buf, const char *expect, int64_t n, const char *tag) {
    if (owned_buf_len(buf) != n) {
        fprintf(stderr, "%s: len %lld (expected %lld)\n", tag,
                (long long)owned_buf_len(buf), (long long)n);
        return 1;
    }
    for (int64_t i = 0; i < n; i++) {
        if (owned_buf_byte_at(buf, i) != (unsigned char)expect[i]) {
            fprintf(stderr, "%s: byte_at(%lld)=%lld (expected '%c')\n", tag,
                    (long long)i, (long long)owned_buf_byte_at(buf, i), expect[i]);
            return 1;
        }
    }
    return 0;
}

/* Phase A: a single unique owner grown in place at the arena tip across
 * many appends. With no other allocation between appends the buffer
 * stays at the bump tip, so every grow hits the in-place grow-at-tip
 * fast path (`sfn_arena_sfn_realloc` :345). The accumulated content
 * must be byte-exact — the sound unique-owner grow. Returns a malloc'd
 * copy of the final bytes (caller frees) or NULL on mismatch. */
static char *phase_a(void *arena, int64_t *out_len) {
    void *buf = owned_buf_new((int64_t)(intptr_t)arena, 8);
    if (!buf) return NULL;
    /* 64 appends of a 3-byte cycle → 192 bytes, far past the initial
     * cap, forcing repeated in-place grow-at-tip bumps. */
    char expect[192];
    const char *cyc = "xyz";
    int64_t total = 0;
    for (int k = 0; k < 64; k++) {
        char chunk[3] = { cyc[0], cyc[1], cyc[2] };
        buf = owned_buf_append(buf, (int64_t)(intptr_t)chunk, 3);
        if (!buf) return NULL;
        memcpy(expect + total, chunk, 3);
        total += 3;
    }
    if (check_bytes(buf, expect, total, "phaseA")) return NULL;
    char *copy = (char *)malloc((size_t)total);
    memcpy(copy, expect, (size_t)total);
    *out_len = total;
    return copy;
}

/* Phase B: the structural #1205 reproduction. `buf` is allocated, then
 * a SECOND buffer `other` is allocated on the same arena — now `buf` is
 * no longer at the bump tip. Growing `buf` must therefore take the
 * relocate+memcpy fallback, NOT an in-place bump: an unsound in-place
 * grow-at-tip here would extend `buf` into `other`'s storage and the
 * append memcpy would clobber `other`'s bytes. Asserts BOTH buffers'
 * bytes survive. Returns 0 on success. */
static int phase_b(void *arena) {
    void *buf = owned_buf_new((int64_t)(intptr_t)arena, 8);
    buf = owned_buf_append(buf, (int64_t)(intptr_t)"AAAA", 4);
    void *other = owned_buf_new((int64_t)(intptr_t)arena, 8);
    other = owned_buf_append(other, (int64_t)(intptr_t)"BBBB", 4);
    /* buf is no longer at the tip; this 16-byte append overflows cap 8
     * and must relocate rather than bump into other's region. */
    buf = owned_buf_append(buf, (int64_t)(intptr_t)"0123456789abcdef", 16);
    if (check_bytes(buf, "AAAA0123456789abcdef", 20, "phaseB.buf")) return 1;
    if (check_bytes(other, "BBBB", 4, "phaseB.other")) return 1;
    return 0;
}

int main(void) {
    /* Phase C: repeat A+B N=30 times (fresh arena each sweep) and assert
     * the Phase A byte vector is identical every sweep — the bug is
     * heap-timing dependent, so a multi-sweep identity check is the
     * load-independent proxy for determinism. */
    const int SWEEPS = 30;
    char *baseline = NULL;
    int64_t baseline_len = 0;
    for (int s = 0; s < SWEEPS; s++) {
        void *arena = sfn_arena_sfn_create(0);
        if (!arena) { fprintf(stderr, "sweep %d: arena create failed\n", s); return 2; }
        int64_t len = 0;
        char *bytes = phase_a(arena, &len);
        if (!bytes) { fprintf(stderr, "sweep %d: phase A failed\n", s); return 3; }
        if (phase_b(arena) != 0) { fprintf(stderr, "sweep %d: phase B failed\n", s); return 4; }
        if (s == 0) {
            baseline = bytes;
            baseline_len = len;
        } else {
            if (len != baseline_len || memcmp(bytes, baseline, (size_t)len) != 0) {
                fprintf(stderr, "sweep %d: non-deterministic phase A bytes\n", s);
                return 5;
            }
            free(bytes);
        }
        sfn_arena_sfn_destroy(arena);
    }
    free(baseline);
    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping grow-determinism harness"
        # Skip rather than fail (no clang on the host). The layout
        # unification assertion above still pins the link contract.
        return 0
    fi
    local bin="$SCRATCH/grow"
    if ! "$clang_bin" -Wno-override-module "$harness" "$ob_ll" "$arena_ll" -o "$bin" -lm 2>"$SCRATCH/clang.log"; then
        echo "[test]   clang failed to link grow-determinism harness:"
        cat "$SCRATCH/clang.log"
        return 1
    fi
    if ! "$bin"; then
        local rc=$?
        echo "[test]   grow-determinism binary exited non-zero (rc=$rc)"
        return 1
    fi
    return 0
}

run_test "OwnedBuf aggregate unifies across ownedbuf.sfn and string.sfn" test_layout_unification
run_test "grow-at-tip unique-owner + relocate-on-alias is byte-correct and deterministic" test_grow_determinism

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
