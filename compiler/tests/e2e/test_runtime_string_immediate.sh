#!/usr/bin/env bash
# End-to-end test for issue #716 — immediate-codepoint pseudo-pointer
# safety across the `sfn_str_*` C trampoline family.
#
# `char_at(text, i)` (and other single-grapheme readers) can return a
# codepoint *tagged into the pointer itself* — the legacy
# `(codepoint << 32)` encoding plus a near-null ASCII form, both
# classified by `_is_immediate_codepoint_string` in
# `runtime/native/src/sailfin_runtime.c`. A trampoline that dereferences
# its operand directly (rather than routing through a legacy
# `sailfin_runtime_*` entry that already decodes) SIGSEGVs on such a
# value — exactly the `0x6800000000` crash that #714 hit on
# `sfn_str_concat`.
#
# This test compiles the real C runtime (`sailfin_runtime.c` +
# `sailfin_arena.c`) against a small harness that feeds each `sfn_str_*`
# helper BOTH immediate encodings and asserts no crash + correct values.
# It is a C-level fixture rather than a Sailfin `.sfn` program because the
# immediate-codepoint tagging is non-deterministic from the language
# surface, whereas the harness constructs the exact pseudo-pointers the
# guards must survive.
#
# The first positional arg (the compiler binary) is accepted for
# parity with the rest of the e2e suite but is unused — this fixture
# exercises the C runtime directly.

set -euo pipefail

PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
RUNTIME_SRC="$REPO_ROOT/runtime/native/src"
RUNTIME_INC="$REPO_ROOT/runtime/native/include"

SCRATCH="$(mktemp -d -t sfn-runtime-immediate-XXXXXX)"
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

# Pick a C compiler. Honour $CC, then fall back to cc/clang/gcc.
CC_BIN=""
for cand in "${CC:-}" cc clang gcc; do
    [ -z "$cand" ] && continue
    if command -v "$cand" > /dev/null 2>&1; then
        CC_BIN="$cand"
        break
    fi
done

# ---- Harness source ----
HARNESS="$SCRATCH/immediate_harness.c"
cat > "$HARNESS" <<'EOF'
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

/* Canonical sfn_str_* trampoline ABI (runtime/native/src/sailfin_runtime.c). */
extern int64_t sfn_str_len(const char *s);
extern bool sfn_str_eq(const char *a, const char *b);
extern char *sfn_str_slice(const char *text, double start, double end);
extern const char *sfn_str_to_cstr(const char *s);
extern const char *sfn_str_from_cstr(const char *s);
extern double sfn_str_grapheme_count(const char *s);
extern char *sfn_str_grapheme_at(const char *s, double idx);
extern int64_t sfn_str_byte_at(const char *s, int64_t idx);
extern int64_t sfn_str_find_byte(const char *s, int64_t byte_value, int64_t start_index);
extern double sfn_str_codepoint(const char *s);
extern double sfn_str_to_number(const char *s);

static int failures = 0;

static void check(const char *label, int cond)
{
    if (cond)
    {
        printf("[c-test] PASS: %s\n", label);
    }
    else
    {
        printf("[c-test] FAIL: %s\n", label);
        failures++;
    }
}

/* Upper-32-bit immediate encoding: (codepoint << 32). This is the form
 * `_safe_strlen_asan` does NOT defend against — the #714 crash shape. */
static const char *imm_upper(uint32_t cp)
{
    return (const char *)(uintptr_t)((uint64_t)cp << 32);
}

/* Near-null ASCII immediate encoding (e.g. 0x2e for '.'). */
static const char *imm_ascii(uint32_t cp)
{
    return (const char *)(uintptr_t)cp;
}

int main(void)
{
    const char *h_up = imm_upper('h'); /* 0x6800000000 — the #714 value */
    const char *h_lo = imm_ascii('h'); /* 0x68 */
    const char *digit = imm_upper('5');
    const char *real = "h";

    /* len */
    check("len(immediate 'h' upper) == 1", sfn_str_len(h_up) == 1);
    check("len(immediate 'h' ascii) == 1", sfn_str_len(h_lo) == 1);

    /* eq: immediate vs real, immediate vs immediate, mismatch */
    check("eq(immediate 'h' upper, real \"h\")", sfn_str_eq(h_up, real));
    check("eq(immediate 'h' upper, immediate 'h' ascii)", sfn_str_eq(h_up, h_lo));
    check("eq(immediate 'h', \"x\") is false", !sfn_str_eq(h_up, "x"));

    /* slice: first char of an immediate */
    char *sl = sfn_str_slice(h_up, 0.0, 1.0);
    check("slice(immediate 'h', 0, 1) == \"h\"", sl != NULL && strcmp(sl, "h") == 0);

    /* to_cstr / from_cstr: returned pointer must be deref-safe */
    const char *c1 = sfn_str_to_cstr(h_up);
    check("to_cstr(immediate 'h') is deref-safe \"h\"",
          c1 != NULL && c1[0] == 'h' && c1[1] == '\0');
    const char *c2 = sfn_str_from_cstr(h_lo);
    check("from_cstr(immediate 'h') is deref-safe \"h\"",
          c2 != NULL && c2[0] == 'h' && c2[1] == '\0');
    check("to_cstr(real) is identity", sfn_str_to_cstr(real) == real);
    check("from_cstr(real) is identity", sfn_str_from_cstr(real) == real);

    /* grapheme_count / grapheme_at */
    check("grapheme_count(immediate 'h') == 1", sfn_str_grapheme_count(h_up) == 1.0);
    char *g = sfn_str_grapheme_at(h_up, 0.0);
    check("grapheme_at(immediate 'h', 0) returns non-null", g != NULL);

    /* byte_at: first byte of 'h' is 0x68 */
    check("byte_at(immediate 'h', 0) == 0x68", sfn_str_byte_at(h_up, 0) == 0x68);
    check("byte_at(immediate 'h', 1) == -1", sfn_str_byte_at(h_up, 1) == -1);

    /* find_byte */
    check("find_byte(immediate 'h', 0x68, 0) == 0", sfn_str_find_byte(h_up, 0x68, 0) == 0);
    check("find_byte(immediate 'h', 'x', 0) == -1", sfn_str_find_byte(h_up, 'x', 0) == -1);

    /* codepoint */
    check("codepoint(immediate 'h') == 0x68", sfn_str_codepoint(h_up) == (double)0x68);

    /* to_number: '5' immediate parses to 5.0; non-digit to 0.0 */
    check("to_number(immediate '5') == 5.0", sfn_str_to_number(digit) == 5.0);
    check("to_number(immediate 'h') == 0.0", sfn_str_to_number(h_up) == 0.0);

    if (failures == 0)
    {
        printf("[c-test] ALL PASS\n");
        return 0;
    }
    printf("[c-test] %d FAILURE(S)\n", failures);
    return 1;
}
EOF

BINARY_OUT="$SCRATCH/immediate_harness"

# ---- Test: the C runtime + harness compile and link ----
test_compile() {
    if [ -z "$CC_BIN" ]; then
        echo "[test]   no C compiler found (tried \$CC, cc, clang, gcc)"
        return 1
    fi
    local log="$SCRATCH/compile.log"
    if ! "$CC_BIN" -std=c11 -D_GNU_SOURCE -O0 -g \
        -I "$RUNTIME_INC" \
        "$HARNESS" \
        "$RUNTIME_SRC/sailfin_runtime.c" \
        "$RUNTIME_SRC/sailfin_arena.c" \
        -lpthread -lm \
        -o "$BINARY_OUT" > "$log" 2>&1; then
        echo "[test]   compile/link failed:"
        cat "$log"
        return 1
    fi
    return 0
}

# ---- Test: every sfn_str_* helper survives immediate codepoints ----
test_run_no_crash() {
    if [ ! -x "$BINARY_OUT" ]; then
        echo "[test]   harness binary missing — test_compile must run first"
        return 1
    fi
    local log="$SCRATCH/run.log"
    if ! "$BINARY_OUT" > "$log" 2>&1; then
        echo "[test]   harness exited non-zero (crash or failed assertion):"
        cat "$log"
        return 1
    fi
    if ! grep -q "\[c-test\] ALL PASS" "$log"; then
        echo "[test]   harness did not report ALL PASS:"
        cat "$log"
        return 1
    fi
    if grep -q "\[c-test\] FAIL" "$log"; then
        echo "[test]   harness reported a FAIL line:"
        cat "$log"
        return 1
    fi
    return 0
}

run_test "C runtime + immediate-codepoint harness compile and link" test_compile
run_test "every sfn_str_* helper survives immediate codepoints" test_run_no_crash

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
