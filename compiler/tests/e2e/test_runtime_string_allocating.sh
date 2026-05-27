#!/usr/bin/env bash
# End-to-end test for the M2.4b (#398) string concat / append
# arena-aware wave. Verifies that:
#
#   1. The Sailfin module `runtime/sfn/string.sfn` still
#      typechecks / fmt-checks cleanly after the wave-1b
#      additions.
#   2. The emitted IR for a `let s = a + b` source defines the
#      arena-aware call shape (#715 renamed the symbol from
#      `sfn_str_concat_arena` to the bare canonical name):
#        %t = call {i8*, i64} @sfn_str_concat({i8*, i64} ...,
#                                             {i8*, i64} ...,
#                                             ptr @sfn_default_arena)
#        %p = extractvalue {i8*, i64} %t, 0
#      and no longer emits the legacy 2-arg `@sfn_str_concat(...)`
#      shape, the `_arena`-suffixed transitional name, or any
#      `@sailfin_runtime_string_concat*` form for fresh user emission.
#   3. The global declare `@sfn_default_arena = external global ptr`
#      lands in every emitted module (driven by
#      `lowering_phase_render.sfn`).
#   4. The Sailfin module exports the new `sfn_str_sfn_concat` /
#      `sfn_str_sfn_append` proof-of-life symbols alongside the
#      wave-1a infix family.
#   5. The compiler binary exports the canonical C-side
#      `sfn_str_concat` / `sfn_str_append` text symbols and the
#      `sfn_default_arena` global symbol so the link surface is
#      intact.

set -euo pipefail

BINARY="${1:?usage: test_runtime_string_allocating.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/string.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-string-alloc-XXXXXX)"
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

# ---- Test: source module typechecks cleanly ----
test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on string.sfn:"
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

# ---- Test: source module is fmt-canonical ----
test_fmt_clean() {
    if ! "$BINARY" fmt --check "$MODULE" > /dev/null 2>&1; then
        echo "[test]   $MODULE needs formatting (run: sfn fmt --write $MODULE)"
        return 1
    fi
    return 0
}

# ---- Test: emitted IR carries a `define` for every new sfn_str_sfn_* export ----
test_emit_define_shape() {
    local ll="$SCRATCH/string.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/string.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    for sym in sfn_str_sfn_concat sfn_str_sfn_append; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in string.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: a `let s = a + b` source lowers to the arena-aware call shape ----
test_concat_lowers_to_arena_form() {
    local fixture="$SCRATCH/concat_fixture.sfn"
    cat > "$fixture" <<'SAILFIN_EOF'
fn build_greeting() -> string {
    let lhs = "hello, ";
    let rhs = "world";
    let combined = lhs + rhs;
    return combined;
}
SAILFIN_EOF
    local ll="$SCRATCH/concat_fixture.ll"
    local log="$SCRATCH/concat_fixture.log"
    if ! "$BINARY" emit -o "$ll" llvm "$fixture" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on concat fixture:"
        cat "$log"
        return 1
    fi
    # The full call shape must appear verbatim — the `, ptr @sfn_default_arena)`
    # tail is the discriminator that catches a regression to the 2-arg form.
    # We anchor the symbol on the literal `\(` rather than a `\b` word
    # boundary: BSD/macOS `grep -E` treats `\b` as a backspace (see
    # `test_runtime_libc_skeleton.sh` lines 95-102), and the `(` that
    # follows the symbol is unambiguous in LLVM call lines — a regression
    # to `@sfn_str_concat_arena(` cannot collide because the `_arena`
    # bytes appear before the `(`, not after `@sfn_str_concat`.
    if ! grep -qE 'call \{i8\*, i64\} @sfn_str_concat\(\{i8\*, i64\} [^,]+, \{i8\*, i64\} [^,]+, ptr @sfn_default_arena\)' "$ll"; then
        echo "[test]   expected 'call {i8*, i64} @sfn_str_concat(..., ptr @sfn_default_arena)' in emitted IR:"
        grep -nE 'call .* @sfn_str_concat' "$ll" | head -5
        return 1
    fi
    # The extractvalue must follow so downstream `i8*` consumers stay happy.
    # Temp names are `%tN` in the compiler's format_temp_name scheme, but
    # accept any LLVM-valid local identifier to keep the test robust against
    # naming changes.
    if ! grep -qE '= extractvalue \{i8\*, i64\} %[A-Za-z_][A-Za-z0-9_]*, 0' "$ll"; then
        echo "[test]   expected 'extractvalue {i8*, i64} %tN, 0' following the arena call"
        return 1
    fi
    # Defensive regression: no fresh emission should call the legacy
    # 2-arg `@sfn_str_concat`, the `_arena`-suffixed transitional name
    # (#715), or the old `@sailfin_runtime_string_concat*` symbols
    # from a user-level concat expression.
    if grep -qE '= call i8\* @sfn_str_concat\(' "$ll"; then
        echo "[test]   regressed: fresh emission still uses the 2-arg @sfn_str_concat shape"
        grep -nE '= call i8\* @sfn_str_concat\(' "$ll" | head -3
        return 1
    fi
    # Anchor on the literal `(` for portability; `\b` is GNU-only and
    # the BSD/macOS `grep -E` would treat it as a backspace (see
    # `test_runtime_libc_skeleton.sh` lines 95-102).
    if grep -qE '@sfn_str_concat_arena\(' "$ll"; then
        echo "[test]   regressed: fresh emission still uses the transitional @sfn_str_concat_arena name"
        grep -nE '@sfn_str_concat_arena\(' "$ll" | head -3
        return 1
    fi
    if grep -qE '@sailfin_runtime_string_concat' "$ll"; then
        echo "[test]   fresh emission references the legacy @sailfin_runtime_string_concat* family"
        grep -nE '@sailfin_runtime_string_concat' "$ll" | head -3
        return 1
    fi
    return 0
}

# ---- Test: every emitted module declares @sfn_default_arena ----
test_global_declare_present() {
    local fixture="$SCRATCH/concat_fixture.sfn"
    local ll="$SCRATCH/concat_fixture.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_concat_lowers_to_arena_form must run first"
        return 1
    fi
    if ! grep -qE '^@sfn_default_arena = external global ptr$' "$ll"; then
        echo "[test]   expected '@sfn_default_arena = external global ptr' declare in emitted IR"
        return 1
    fi
    if ! grep -qE '^declare \{i8\*, i64\} @sfn_str_concat\(\{i8\*, i64\}, \{i8\*, i64\}, ptr\)' "$ll"; then
        echo "[test]   expected declare for @sfn_str_concat with 3-arg ptr-tail signature"
        grep -nE 'declare .* @sfn_str_concat' "$ll" | head -3
        return 1
    fi
    return 0
}

# ---- Test: the compiler binary exports the new symbols ----
test_compiler_binary_exports_arena_symbols() {
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    if [ -z "$nm_log" ]; then
        echo "[test]   nm produced no output for $BINARY (stripped binary?)"
        return 1
    fi
    local missing=0
    # #715: the canonical names are now bare `sfn_str_concat` /
    # `sfn_str_append`. The `_arena`-suffixed forwarders stay
    # exported one more release cycle so seed-built IR (which still
    # emits the `_arena` suffix) keeps linking through the renamed
    # bodies; this loop pins both name forms until the next seed
    # bump retires the transitional forwarders.
    for sym in sfn_str_concat sfn_str_append sfn_str_concat_arena sfn_str_append_arena; do
        if ! grep -qE "[[:space:]][Tt][[:space:]]_?${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary does not export defined text symbol ${sym}"
            missing=$((missing + 1))
        fi
    done
    # The global arena pointer slot must show up as a data symbol
    # (' D ' / ' d ' / ' B ' / ' b ' / ' S ' / ' s ') — not a text symbol.
    if ! grep -qE "[[:space:]][BbDdSs][[:space:]]_?sfn_default_arena\$" <<< "$nm_log"; then
        echo "[test]   compiler binary does not export defined data symbol sfn_default_arena"
        missing=$((missing + 1))
    fi
    # And the Sailfin-side proof-of-life infix exports.
    for sym in sfn_str_sfn_concat sfn_str_sfn_append; do
        if ! grep -qE "[[:space:]][Tt][[:space:]]_?${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary does not export defined text symbol ${sym}"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

run_test "sfn check runtime/sfn/string.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/string.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every new sfn_str_sfn_* export" test_emit_define_shape
run_test "let s = a + b lowers to arena-aware @sfn_str_concat call" test_concat_lowers_to_arena_form
run_test "emitted IR declares @sfn_default_arena and @sfn_str_concat" test_global_declare_present
run_test "compiler binary exports sfn_str_concat / sfn_str_append (+ transitional _arena forwarders) / sfn_default_arena" test_compiler_binary_exports_arena_symbols

echo ""
echo "[summary] $PASS passed, $FAIL failed"
exit "$FAIL"
