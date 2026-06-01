#!/usr/bin/env bash
# End-to-end test for runtime/sfn/exception.sfn — the Sailfin-defined
# exception frame primitives shipped into the compiler binary
# (issue #400, epic #389 M2.7a). Mirrors test_runtime_memory_rc.sh:
#
#   1. typecheck — `sfn check runtime/sfn/exception.sfn` reports `ok`.
#   2. fmt       — `sfn fmt --check runtime/sfn/exception.sfn` is canonical.
#   3. emit shape — emitted IR contains a `define` for each of the
#                   nine exports plus `declare`s for the inlined libc
#                   primitives (malloc, free, memset, setjmp, longjmp,
#                   abort).
#   4. layout    — `%SfnExceptionFrame = type { i64, i64, i64 }` pins
#                  the three-`i64`-slot struct shape per the architect's
#                  layout deviation note in the module header.
#   5. setjmp pin — `sfn_try_enter` carries exactly one
#                   `call i32 @setjmp(...)`. The M2.7b compiler-lowering
#                   migration inlines this call at user code's try-block
#                   entry; pinning the IR here means a regression that
#                   retargets the call onto a different runtime symbol
#                   surfaces in the test instead of at link time.
#   6. longjmp pin — `sfn_throw` carries exactly one
#                    `call void @longjmp(...)` plus the empty-chain
#                    `call void @abort()` safety branch (matches the C
#                    runtime's `sailfin_runtime_throw` abort-on-empty
#                    semantics).
#   7. global pin — `@global.sfn_exception_frame_head_addr = internal
#                   global i64 0` pins the chain-head storage shape.
#                   The TLS upgrade (compiler-side parser in #825;
#                   runtime-side flip queued as a follow-up gated on the
#                   next seed pin) replaces `internal global` with
#                   `internal thread_local global` without touching
#                   callers; this assertion catches a regression that
#                   relocates the storage or drops the zero initializer.
#   8. coexistence — the Sailfin-emitted symbols use canonical
#                    architect names (`sfn_try_enter`, `sfn_throw`,
#                    `sfn_take_exception`, …) which deliberately do NOT
#                    collide with the C runtime's `sailfin_runtime_*`
#                    exception family. The assertion guards against a
#                    future Sailfin export that accidentally redefines
#                    one of the C runtime symbols, which would fail
#                    `make compile` at link time.
#   9. cross-frame roundtrip — a C harness performs inline `setjmp`
#                              on a Sailfin-allocated frame, pushes
#                              it via `sfn_exception_push_frame`, then
#                              calls into a deeper helper that calls
#                              `sfn_throw`. The `longjmp` from
#                              `sfn_throw` transfers control back to
#                              the harness's setjmp call site; the
#                              harness verifies the message via
#                              `sfn_take_exception`. The inline-setjmp
#                              pattern is required because calling
#                              `sfn_try_enter` as a regular function
#                              and then throwing across the boundary
#                              is C11 UB on glibc — the architect's
#                              intent is that M2.7b inlines
#                              `sfn_try_enter` at user code's try-block
#                              entry, where the setjmp save point
#                              stays live across the throw. See the
#                              file-header "Setjmp/longjmp safety"
#                              note in `runtime/sfn/exception.sfn`.

set -euo pipefail

BINARY="${1:?usage: test_runtime_exception_frames.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/exception.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-exception-XXXXXX)"
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
    if ! "$BINARY" check "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on exception.sfn:"
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
    if ! "$BINARY" fmt --check "$MODULE" > /dev/null 2>&1; then
        echo "[test]   $MODULE needs formatting (run: sfn fmt --write $MODULE)"
        return 1
    fi
    return 0
}

test_emit_define_shape() {
    local ll="$SCRATCH/exception.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/exception.sfn:"
        cat "$log"
        return 1
    fi

    # Every export gets exactly one `define` in the module — anchored
    # at line start so a `call` site does not satisfy the assertion.
    # Parameter and return types are pinned: a regression that
    # accidentally flips a struct-typed parameter to `i8*` (which
    # would route through the typechecker's bare-pointer accept-list
    # rather than the named-struct path) surfaces here.
    local missing=0
    if ! grep -qE "^define %SfnExceptionFrame\* @sfn_exception_alloc_frame\(\) " "$ll"; then
        echo "[test]   missing 'define %SfnExceptionFrame* @sfn_exception_alloc_frame()'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_exception_free_frame\(%SfnExceptionFrame\* %frame\) " "$ll"; then
        echo "[test]   missing 'define void @sfn_exception_free_frame(%SfnExceptionFrame* %frame)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define %SfnExceptionFrame\* @sfn_exception_frame_head\(\) " "$ll"; then
        echo "[test]   missing 'define %SfnExceptionFrame* @sfn_exception_frame_head()'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_exception_push_frame\(%SfnExceptionFrame\* %frame\) " "$ll"; then
        echo "[test]   missing 'define void @sfn_exception_push_frame(%SfnExceptionFrame* %frame)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_exception_pop_frame\(%SfnExceptionFrame\* %frame\) " "$ll"; then
        echo "[test]   missing 'define void @sfn_exception_pop_frame(%SfnExceptionFrame* %frame)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define i32 @sfn_try_enter\(%SfnExceptionFrame\* %frame\) " "$ll"; then
        echo "[test]   missing 'define i32 @sfn_try_enter(%SfnExceptionFrame* %frame)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_try_leave\(%SfnExceptionFrame\* %frame\) " "$ll"; then
        echo "[test]   missing 'define void @sfn_try_leave(%SfnExceptionFrame* %frame)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define void @sfn_throw\(i8\* %message\) " "$ll"; then
        echo "[test]   missing 'define void @sfn_throw(i8* %message)'"
        missing=$((missing + 1))
    fi
    if ! grep -qE "^define i8\* @sfn_take_exception\(%SfnExceptionFrame\* %frame\) " "$ll"; then
        echo "[test]   missing 'define i8* @sfn_take_exception(%SfnExceptionFrame* %frame)'"
        missing=$((missing + 1))
    fi
    return "$missing"
}

test_emit_libc_declares() {
    local ll="$SCRATCH/exception.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # Each libc trampoline must produce a `declare` line. The
    # opaque-pointee rule lowers `* JmpBuf` and `* u8` both to
    # `i8*`; the assertions match on the i8* signature shape.
    local missing=0
    for sym in malloc free memset setjmp longjmp abort; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in exception.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

test_struct_layout() {
    local ll="$SCRATCH/exception.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # Pin the SfnExceptionFrame layout. A regression that adds or
    # drops a field (e.g. a future i64 cleanup_handlers_addr slot
    # for option-B drop callbacks) surfaces here and bumps the
    # `sfn_exception_alloc_frame` malloc literal in lockstep.
    if ! grep -qE "^%SfnExceptionFrame = type \{ i64, i64, i64 \}$" "$ll"; then
        echo "[test]   missing '%SfnExceptionFrame = type { i64, i64, i64 }' layout pin"
        echo "[test]   layout candidates in IR:"
        grep -E "^%SfnExceptionFrame" "$ll" || true
        return 1
    fi
    return 0
}

test_setjmp_shape() {
    local ll="$SCRATCH/exception.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # Scope the assertion to sfn_try_enter via a sed range so a
    # stray setjmp call elsewhere can't satisfy it. Count is
    # exactly one — a regression that accidentally double-emits
    # the setjmp (e.g. an inlined helper that also calls setjmp)
    # silently passes a `grep -q` check, so the `-c == 1` form
    # guards that direction too.
    local try_block
    try_block="$(sed -n '/^define i32 @sfn_try_enter(/,/^}/p' "$ll")"
    local setjmp_count
    setjmp_count="$(echo "$try_block" | grep -cE "call i32 @setjmp\(i8\* ")"
    if [ "$setjmp_count" -ne 1 ]; then
        echo "[test]   sfn_try_enter expected exactly 1 'call i32 @setjmp(i8* ', got $setjmp_count:"
        echo "$try_block"
        return 1
    fi
    # sfn_try_enter must also push the frame BEFORE setjmp so the
    # save point lands on the chain head. A regression that swaps
    # the order would still pass the setjmp-count check above but
    # break sfn_throw's frame lookup; pin the relative ordering.
    if ! echo "$try_block" | grep -qE "call void @sfn_exception_push_frame\("; then
        echo "[test]   sfn_try_enter missing 'call void @sfn_exception_push_frame(' before setjmp:"
        echo "$try_block"
        return 1
    fi
    local push_line setjmp_line
    push_line="$(echo "$try_block" | grep -n "call void @sfn_exception_push_frame" | head -1 | cut -d: -f1)"
    setjmp_line="$(echo "$try_block" | grep -n "call i32 @setjmp" | head -1 | cut -d: -f1)"
    if [ -z "$push_line" ] || [ -z "$setjmp_line" ] || [ "$push_line" -ge "$setjmp_line" ]; then
        echo "[test]   sfn_try_enter must call push_frame BEFORE setjmp"
        echo "$try_block"
        return 1
    fi
    return 0
}

test_longjmp_shape() {
    local ll="$SCRATCH/exception.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    local throw_block
    throw_block="$(sed -n '/^define void @sfn_throw(/,/^}/p' "$ll")"
    local longjmp_count
    longjmp_count="$(echo "$throw_block" | grep -cE "call void @longjmp\(i8\* .*, i32 1\)")"
    if [ "$longjmp_count" -ne 1 ]; then
        echo "[test]   sfn_throw expected exactly 1 'call void @longjmp(i8* ..., i32 1)', got $longjmp_count:"
        echo "$throw_block"
        return 1
    fi
    # The empty-chain safety branch must call abort — pinning this
    # ensures an uncaught throw terminates the process (matches the
    # C runtime's sailfin_runtime_throw behavior). A regression that
    # silently returns instead would let user code observe a
    # never-firing throw.
    if ! echo "$throw_block" | grep -qE "call void @abort\(\)"; then
        echo "[test]   sfn_throw missing 'call void @abort()' on empty-chain branch:"
        echo "$throw_block"
        return 1
    fi
    # Architect §2.4.2: throw must pop the frame BEFORE longjmp so
    # a rethrow from inside the catch handler targets the next
    # outer frame, not the one we just unwound. The body must
    # write a fresh value into @global.sfn_exception_frame_head_addr
    # before the longjmp call. Pin both the store and the relative
    # ordering — without the ordering check, a buggy emission that
    # stored AFTER longjmp (dead code) would still pass.
    if ! echo "$throw_block" | grep -qE "store i64 .*, i64\* @global\.sfn_exception_frame_head_addr"; then
        echo "[test]   sfn_throw missing pop-before-longjmp 'store i64 ..., i64* @global.sfn_exception_frame_head_addr':"
        echo "$throw_block"
        return 1
    fi
    local pop_line longjmp_line
    pop_line="$(echo "$throw_block" | grep -n "store i64 .*@global\.sfn_exception_frame_head_addr" | tail -1 | cut -d: -f1)"
    longjmp_line="$(echo "$throw_block" | grep -n "call void @longjmp" | head -1 | cut -d: -f1)"
    if [ -z "$pop_line" ] || [ -z "$longjmp_line" ] || [ "$pop_line" -ge "$longjmp_line" ]; then
        echo "[test]   sfn_throw must pop frame head BEFORE longjmp (pop=$pop_line, longjmp=$longjmp_line)"
        echo "$throw_block"
        return 1
    fi
    return 0
}

test_take_clears_slot() {
    local ll="$SCRATCH/exception.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # Architect §2.4.2 (matched by legacy C
    # sailfin_runtime_take_exception): "take" consumes the message
    # — a subsequent take on the same frame reads null. Pin the
    # store-zero to the message_addr slot (field index 2 of
    # SfnExceptionFrame).
    local take_block
    take_block="$(sed -n '/^define i8\* @sfn_take_exception(/,/^}/p' "$ll")"
    if ! echo "$take_block" | grep -qE "store i64 0, i64\* %t[0-9]+$"; then
        echo "[test]   sfn_take_exception missing 'store i64 0, i64* %tN' clear-on-take:"
        echo "$take_block"
        return 1
    fi
    # The clear must target the message_addr slot — getelementptr
    # with field index `i32 2` (third field of SfnExceptionFrame).
    # Anchor on the GEP→store sequence so a regression that
    # accidentally clears prev_addr or jmp_buf_addr fails here.
    if ! echo "$take_block" | grep -qE "getelementptr %SfnExceptionFrame, %SfnExceptionFrame\* %frame, i32 0, i32 2"; then
        echo "[test]   sfn_take_exception missing 'getelementptr ... i32 0, i32 2' to message_addr:"
        echo "$take_block"
        return 1
    fi
    return 0
}

test_pop_frame_null_safe() {
    local ll="$SCRATCH/exception.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # Architect: sfn_exception_pop_frame must be idempotent on a
    # null frame (mirrors C sailfin_runtime_try_leave). The body
    # must compare the frame_addr to 0 and early-return without
    # dereferencing.
    local pop_block
    pop_block="$(sed -n '/^define void @sfn_exception_pop_frame(/,/^}/p' "$ll")"
    if ! echo "$pop_block" | grep -qE "icmp eq i64 %t[0-9]+, 0"; then
        echo "[test]   sfn_exception_pop_frame missing 'icmp eq i64 %tN, 0' null guard:"
        echo "$pop_block"
        return 1
    fi
    return 0
}

test_frame_head_global() {
    local ll="$SCRATCH/exception.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # The TLS upgrade (compiler-side parser in #825; runtime-side flip
    # queued as a follow-up gated on the next seed pin) replaces
    # `internal global` with `internal thread_local global` without
    # touching callers. Pin the current shape so the follow-up is the
    # advertised one-line audit-able diff.
    if ! grep -qE "^@global\.sfn_exception_frame_head_addr = internal global i64 0$" "$ll"; then
        echo "[test]   missing '@global.sfn_exception_frame_head_addr = internal global i64 0':"
        grep -E "^@global\." "$ll" || true
        return 1
    fi
    return 0
}

test_no_runtime_symbol_collision() {
    local ll="$SCRATCH/exception.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # The Sailfin module must NOT define any of the C runtime's
    # exception-family symbols — those still live in
    # runtime/native/src/sailfin_runtime.c and serve the legacy
    # TLS-polling path during the M2.7 transition. A collision
    # would fail `make compile` at link time. M2.7c retires the C
    # symbols and this assertion goes away.
    local found=0
    for sym in sailfin_runtime_try_enter sailfin_runtime_try_leave \
               sailfin_runtime_throw sailfin_runtime_set_exception \
               sailfin_runtime_clear_exception sailfin_runtime_has_exception \
               sailfin_runtime_take_exception; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: exception.sfn emits 'define ... @${sym}(', conflicts with C runtime"
            found=$((found + 1))
        fi
    done
    return "$found"
}

test_cross_frame_roundtrip() {
    # Functional roundtrip: link the emitted `.ll` against a tiny C
    # harness that does inline `setjmp` on a Sailfin-allocated
    # frame's jmp_buf, pushes the frame onto the Sailfin chain, then
    # calls a deeper helper that calls `sfn_throw`. The longjmp from
    # `sfn_throw` returns control to the harness's setjmp call site,
    # and `sfn_take_exception` reads the message back. The inline-
    # setjmp pattern is required (see the file-header note in
    # `runtime/sfn/exception.sfn` and the M2.7b migration plan in
    # `docs/runtime_architecture.md` §2.4).
    local ll="$SCRATCH/exception.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi

    local harness="$SCRATCH/harness.c"
    cat > "$harness" <<'CHARNESS'
/* Cross-frame unwinding harness for runtime/sfn/exception.sfn.
 *
 * The architect's `sfn_try_enter` function form carries the
 * canonical setjmp call site (IR-pinning surface) but is C11 UB
 * when called as a regular function and then thrown across the
 * boundary — glibc's pointer-mangled longjmp silently no-ops on
 * a returned-frame setjmp. This harness mirrors what the M2.7b
 * compiler-lowering migration will emit at user code's try-block
 * entry: inline setjmp on a frame's jmp_buf, push the frame onto
 * the Sailfin chain, then throw from a deeper helper. The
 * longjmp transfers control back to the inline setjmp, and the
 * caught message is read via sfn_take_exception.
 *
 * The struct layout matches `%SfnExceptionFrame = type { i64,
 * i64, i64 }` — three i64 slots: prev_addr, jmp_buf_addr,
 * message_addr. We read jmp_buf_addr as a void* for the inline
 * setjmp call.
 */
#include <stdio.h>
#include <setjmp.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

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
extern void sfn_throw(const char *message);
extern char *sfn_take_exception(struct SfnExceptionFrame *frame);

/* Sailfin's heap-return marker. The emitted IR calls this on the
 * pointer returned by `sfn_exception_alloc_frame` (Sailfin's seed-
 * compiler heap-return bookkeeping). We provide a no-op stub so
 * the standalone link path doesn't pull in the C runtime. */
void sailfin_runtime_mark_persistent(void *ptr) { (void)ptr; }

/* Deeper-frame helper. Calling sfn_throw from here forces the
 * longjmp to cross at least one stack boundary back to main's
 * inline setjmp call site. */
static void provoke(const char *msg) {
    sfn_throw(msg);
    /* unreachable on success — longjmp transfers control */
}

int main(void) {
    /* Pre-flight: null-safe pop on an empty chain should be a
     * no-op (Architect: idempotent; matches C sailfin_runtime_
     * try_leave null-handle behavior). */
    sfn_exception_pop_frame(NULL);
    if (sfn_exception_frame_head() != NULL) {
        fprintf(stderr, "pop_frame(NULL) on empty chain corrupted head\n");
        return 1;
    }

    struct SfnExceptionFrame *frame = sfn_exception_alloc_frame();
    if (!frame) {
        fprintf(stderr, "alloc_frame returned NULL\n");
        return 2;
    }
    sfn_exception_push_frame(frame);
    if (sfn_exception_frame_head() != frame) {
        fprintf(stderr, "push_frame did not update head\n");
        return 3;
    }

    /* Inline setjmp on the frame's jmp_buf. Equivalent to the
     * M2.7b compiler-inline emission of sfn_try_enter. */
    int rc = setjmp((void *)frame->jmp_buf_addr);
    if (rc == 0) {
        /* First-call branch: throw across a deeper frame. */
        provoke("boom");
        fprintf(stderr, "UNREACHABLE: provoke returned without longjmp\n");
        return 4;
    }

    /* Longjmp returned here. Verify the message round-tripped. */
    if (rc != 1) {
        fprintf(stderr, "setjmp returned %d on longjmp, expected 1\n", rc);
        return 5;
    }

    /* Architect §2.4.2: throw pops the frame before longjmp. The
     * chain head must reflect the unwound state. */
    if (sfn_exception_frame_head() != NULL) {
        fprintf(stderr, "sfn_throw did not pop frame before longjmp (head=%p, expected NULL)\n",
                (void *)sfn_exception_frame_head());
        return 6;
    }

    char *msg = sfn_take_exception(frame);
    if (!msg) {
        fprintf(stderr, "take_exception returned NULL after throw\n");
        return 7;
    }
    if (strcmp(msg, "boom") != 0) {
        fprintf(stderr, "take_exception returned '%s', expected 'boom'\n", msg);
        return 8;
    }

    /* Architect (matches legacy C sailfin_runtime_take_exception):
     * "take" consumes the message — a second call must return
     * NULL, not the stale pointer. */
    char *msg2 = sfn_take_exception(frame);
    if (msg2 != NULL) {
        fprintf(stderr, "second take_exception returned non-NULL '%s' (slot not cleared)\n", msg2);
        return 9;
    }

    /* Idempotent: pop a frame that is no longer on the chain. */
    sfn_exception_pop_frame(frame);
    sfn_exception_free_frame(frame);
    return 0;
}
CHARNESS

    local clang_bin
    clang_bin="${CLANG:-clang}"
    if ! command -v "$clang_bin" >/dev/null 2>&1; then
        echo "[test]   clang not available — skipping roundtrip"
        # Skip rather than fail (mirrors rc.sfn test). The earlier
        # IR-shape assertions still pin the contract.
        return 0
    fi
    # `-Wno-override-module` because the .ll's target triple may
    # not match the host clang's default. `-lm` because the seed
    # compiler lowers integer literals through `round(double)` +
    # `fptosi` and leaves libm references in the .ll (same as the
    # rc.sfn test note). `type_meta.o` because M2.10 (#402) emits
    # an `@__sfn_module_type_init__*` constructor in every module
    # with named structs/enums/interfaces — exception.sfn defines
    # `SfnExceptionFrame`, so the constructor calls
    # `@sfn_type_register` and the unresolved reference fails
    # link unless the staged `runtime/sfn/type_meta.sfn` object
    # rides along. Skip if absent (the IR-shape assertions still
    # pin the contract; this round-trip is a smoke test on top).
    local bin="$SCRATCH/roundtrip"
    # #941: the Makefile no longer stages `build/native/obj/runtime/*.o`
    # (every link path now emits the runtime from source). Emit
    # `type_meta` from `runtime/sfn/type_meta.sfn` on the fly so the
    # `@__sfn_module_type_init__*` constructor's `@sfn_type_register`
    # call resolves at link. If that object can't be produced, skip the
    # roundtrip (the IR-shape assertions above still pin the contract).
    local type_meta_ll="$SCRATCH/type_meta.ll"
    local type_meta_o="$SCRATCH/type_meta.o"
    local extra_o=()
    if "$BINARY" emit -o "$type_meta_ll" llvm "$REPO_ROOT/runtime/sfn/type_meta.sfn" >/dev/null 2>&1 \
        && "$clang_bin" -Wno-override-module -c "$type_meta_ll" -o "$type_meta_o" 2>/dev/null; then
        extra_o+=("$type_meta_o")
    else
        echo "[test]   could not emit type_meta object — skipping roundtrip"
        return 0
    fi
    if ! "$clang_bin" -Wno-override-module "$harness" "$ll" "${extra_o[@]}" -o "$bin" -lm 2>"$SCRATCH/clang.log"; then
        echo "[test]   clang failed to link roundtrip harness:"
        cat "$SCRATCH/clang.log"
        return 1
    fi
    if ! "$bin" > "$SCRATCH/run.log" 2>&1; then
        local rc=$?
        echo "[test]   roundtrip binary exited non-zero (rc=$rc):"
        cat "$SCRATCH/run.log"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/exception.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/exception.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every export" test_emit_define_shape
run_test "sfn emit llvm declares libc malloc/free/memset/setjmp/longjmp/abort" test_emit_libc_declares
run_test "sfn emit llvm pins SfnExceptionFrame layout" test_struct_layout
run_test "sfn emit llvm pins setjmp call in sfn_try_enter after push_frame" test_setjmp_shape
run_test "sfn emit llvm pins longjmp + empty-chain abort + pop-before-longjmp in sfn_throw" test_longjmp_shape
run_test "sfn emit llvm pins clear-on-take in sfn_take_exception" test_take_clears_slot
run_test "sfn emit llvm pins null guard in sfn_exception_pop_frame" test_pop_frame_null_safe
run_test "sfn emit llvm pins frame-head global storage" test_frame_head_global
run_test "sfn emit llvm does not collide with C runtime exception family" test_no_runtime_symbol_collision
run_test "cross-frame unwind: inline setjmp + sfn_throw round-trips message" test_cross_frame_roundtrip

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
