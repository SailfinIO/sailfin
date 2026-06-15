#!/usr/bin/env bash
# End-to-end test for runtime/sfn/string.sfn wave 2 — UTF-8 grapheme
# operations and numeric formatting (issue #403, epic #389 M2.5).
#
# Mirrors test_runtime_string_basic.sh's structure: typecheck + fmt
# + emit-shape on the source module, plus a compiled-IR regression
# that the new compiler routes grapheme / char_code / number_to_string
# / string_to_number call sites through the wave-2 `sfn_str_*` /
# `sfn_number_to_str` family instead of the legacy
# `sailfin_runtime_grapheme_*` / `_char_code` / `_string_to_number` /
# `_number_to_string` C entrypoints.
#
# When the M1.A.2 type-mapping flip lets the Sailfin bodies retire
# the C trampolines, the emit-shape assertions stay — they pin the
# migration symbol surface, not the body strategy.

set -euo pipefail

BINARY="${1:?usage: test_runtime_string_utf8_numeric.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/string.sfn"
LIBC_MODULE="$REPO_ROOT/runtime/sfn/platform/libc.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-utf8-numeric-XXXXXX)"
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

# ---- Test: source modules typecheck cleanly ----
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
    if ! "$BINARY" check "$LIBC_MODULE" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on platform/libc.sfn:"
        cat "$log"
        return 1
    fi
    return 0
}

# ---- Test: source modules are fmt-canonical ----
test_fmt_clean() {
    if ! "$BINARY" fmt --check "$MODULE" > /dev/null 2>&1; then
        echo "[test]   $MODULE needs formatting (run: sfn fmt --write $MODULE)"
        return 1
    fi
    if ! "$BINARY" fmt --check "$LIBC_MODULE" > /dev/null 2>&1; then
        echo "[test]   $LIBC_MODULE needs formatting (run: sfn fmt --write $LIBC_MODULE)"
        return 1
    fi
    return 0
}

# ---- Test: emitted IR carries a `define` for each wave-2 export ----
#
# Two families coexist as the migration proceeds:
#   * Still-façade exports keep the `_sfn_` infix
#     (`sfn_str_sfn_from_codepoint`, `sfn_str_sfn_to_number`) — the bare
#     `sfn_str_*` names they front are still C trampolines (#1318 / #822).
#   * #1315 (C4 of epic #1308): the accessor family
#     (`grapheme_count` / `grapheme_at` / `byte_at` / `find_byte` /
#     `codepoint`) is now a real Sailfin body at the BARE name — the C
#     defs are `static`, so string.sfn emits the bare `define` and owns
#     the symbol (mirrors #1314's number/int flip). Their `_sfn_` infix
#     proof-of-life wrappers are retired.
test_emit_define_shape() {
    local ll="$SCRATCH/string.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/string.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    # Still-façade `_sfn_` infix exports (bare names remain C until #1318).
    for sym in \
        sfn_str_sfn_from_codepoint \
        sfn_str_sfn_to_number; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in string.ll"
            missing=$((missing + 1))
        fi
    done
    # #1315: the accessor family is now Sailfin-defined at the BARE name.
    for sym in \
        sfn_str_grapheme_count \
        sfn_str_grapheme_at \
        sfn_str_byte_at \
        sfn_str_find_byte \
        sfn_str_codepoint; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in string.ll (expected after #1315)"
            missing=$((missing + 1))
        fi
    done
    # #1314: the numeric formatters' real bodies live at the bare
    # `sfn_number_to_str` / `sfn_int_to_str` names (asserted by the wave-2
    # export test below), so the `_sfn` infix forms are intentionally absent.
    return "$missing"
}

# ---- Test: emitted IR does NOT collide with the still-C trampolines ----
#
# Coexistence regression: a regression that flips a still-façade Sailfin
# export to a bare wave-2 name would collide with the C trampoline at
# link time and break `make compile`. Pin the `_sfn_` infix as the marker
# until each C trampoline retires. NOTE: `sfn_number_to_str` /
# `sfn_int_to_str` (as of #1314) and the accessor family
# `sfn_str_{grapheme_count,grapheme_at,byte_at,find_byte,codepoint}` (as
# of #1315) are deliberately ABSENT from this list — their bare bodies are
# now real Sailfin (string.sfn) and the C namesakes are `static`, so a
# bare `define` for them is expected, not a collision. Only the still-C
# allocating/encode ops (retired in #1318 / #822) stay here.
test_no_bare_sfn_str_define() {
    local ll="$SCRATCH/string.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    local found=0
    for sym in \
        sfn_str_from_codepoint \
        sfn_str_to_number; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: string.sfn emits 'define ... @${sym}(', conflicts with C trampoline"
            found=$((found + 1))
        fi
    done
    return "$found"
}

# ---- Test: emitted IR declares strtod ----
#
# The proof-of-life body of `sfn_str_sfn_to_number` calls `strtod`
# directly (the architect-spec body's `extern fn`), so the module
# must `declare` it. `strtod` is the new libc declaration this PR
# adds.
test_emit_libc_declares() {
    local ll="$SCRATCH/string.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    if ! grep -qE "^declare .* @strtod\(" "$ll"; then
        echo "[test]   missing 'declare ... @strtod(' in string.ll"
        return 1
    fi
    return 0
}

# ---- Test: compiled hello-world IR no longer references the legacy C symbols ----
#
# Acceptance criterion #1 from issue #403: the seven legacy
# `sailfin_runtime_*` symbols become unreferenced in user emission.
# `\b` treats `_` as a word char, so each entry below is a tight,
# non-overlapping regression target.
test_user_emission_is_flipped() {
    local hello="$REPO_ROOT/examples/basics/hello-world.sfn"
    local ll="$SCRATCH/hello.ll"
    local log="$SCRATCH/hello-emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$hello" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on hello-world.sfn:"
        cat "$log"
        return 1
    fi
    local found=0
    for sym in \
        sailfin_runtime_grapheme_count \
        sailfin_runtime_grapheme_at \
        sailfin_runtime_byte_at \
        sailfin_runtime_find_byte_index \
        sailfin_runtime_char_code \
        sailfin_runtime_string_to_number \
        sailfin_runtime_number_to_string; do
        if grep -qE "@${sym}\b" "$ll"; then
            echo "[test]   user emission still references @${sym} (expected the wave-2 flip)"
            grep -nE "@${sym}\b" "$ll" | head -3
            found=$((found + 1))
        fi
    done
    return "$found"
}

# ---- Test: compiler binary exports both name families ----
#
# The C trampolines (`sailfin_runtime.c`) own the canonical wave-2
# names — those are what the new compiler emission calls and what
# the test linker resolves against. The Sailfin module owns the
# `_sfn_` infix (and `_sfn` suffix) family — proof of life for the
# migration. Both must show up as defined text symbols.
test_compiler_binary_exports_wave2() {
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    if [ -z "$nm_log" ]; then
        echo "[test]   nm produced no output for $BINARY (stripped binary?)"
        return 1
    fi
    local missing=0
    for sym in \
        sfn_str_grapheme_count \
        sfn_str_grapheme_at \
        sfn_str_byte_at \
        sfn_str_find_byte \
        sfn_str_codepoint \
        sfn_str_from_codepoint \
        sfn_str_to_number \
        sfn_number_to_str \
        sfn_int_to_str \
        sfn_str_sfn_from_codepoint \
        sfn_str_sfn_to_number; do
        # #1315: the accessor `_sfn_` infixes
        # (`sfn_str_sfn_{grapheme_count,grapheme_at,byte_at,find_byte,codepoint}`)
        # are retired — their real bodies are the bare `sfn_str_*` accessors
        # above (Sailfin-defined; the C namesakes are now `static`), exactly
        # as #1314 did for the numeric formatters below.
        # #1314: `sfn_number_to_str_sfn` / `sfn_int_to_str_sfn` retired —
        # the real bodies are the bare `sfn_number_to_str` / `sfn_int_to_str`
        # above (Sailfin-defined; the C namesakes are now `static`).
        # Require a defined text symbol (` T ` / ` t `). The optional
        # `_` prefix accommodates macOS Mach-O while staying tight
        # against substring collisions. A here-string avoids the
        # `echo | grep -q` SIGPIPE-under-pipefail trap that fires
        # when grep -q closes stdin after the first match.
        if ! grep -qE "[[:space:]][Tt][[:space:]]_?${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary does not export defined symbol ${sym}"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: hand-rolled `sfn_int_to_str` matches the architect-spec format ----
#
# Acceptance criterion #2: integer formatting is exact. The trampoline
# body in `sailfin_runtime.c` writes into a 21-byte stack buffer
# (sign + 20 digits + NUL = worst-case INT64_MIN width). We can't
# call the C symbol directly from bash, but we can compile a small
# Sailfin program that exercises the path indirectly via
# `number_to_string` (which now flips to `@sfn_number_to_str`) and
# confirm the round-trip.
test_number_to_str_roundtrip() {
    local prog="$SCRATCH/roundtrip.sfn"
    local out="$SCRATCH/roundtrip.out"
    cat > "$prog" <<'EOF'
fn main() ![io] {
    print.info("42:" + number_to_string(42));
    print.info("0:" + number_to_string(0));
    print.info("neg:" + number_to_string(-7));
    print.info("frac:" + number_to_string(3.14));
}
EOF
    if ! "$BINARY" run "$prog" > "$out" 2>&1; then
        echo "[test]   sfn run failed on $prog:"
        cat "$out"
        return 1
    fi
    local missing=0
    for token in "42:42" "0:0" "neg:-7" "frac:3.14"; do
        if ! grep -qF "$token" "$out"; then
            echo "[test]   expected '$token' in output:"
            cat "$out"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: immediate-codepoint hack is no longer reached by user IR ----
#
# Acceptance criterion #3 from issue #403: the immediate-codepoint
# tagged-pointer hack lives only in `sailfin_runtime_grapheme_at` /
# `_char_code`. With both flipped to `sfn_str_grapheme_at` /
# `sfn_str_codepoint`, no user emission can trigger the hack via the
# descriptor path. (The C trampolines still forward through the
# legacy bodies today; the hack itself retires when the Sailfin
# bodies move past trampoline status.)
test_immediate_codepoint_hack_unreachable() {
    local ll="$SCRATCH/hello.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_user_emission_is_flipped must run first"
        return 1
    fi
    if grep -qE "@sailfin_runtime_grapheme_at\b|@sailfin_runtime_char_code\b" "$ll"; then
        echo "[test]   user emission still references the immediate-codepoint legacy entrypoints"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/string.sfn + libc.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/string.sfn + libc.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every wave-2 sfn_str_sfn_* / sfn_*_sfn export" test_emit_define_shape
run_test "sfn emit llvm does not collide with C trampoline wave-2 sfn_str_* / sfn_*_to_str names" test_no_bare_sfn_str_define
run_test "sfn emit llvm declares strtod" test_emit_libc_declares
run_test "user emission no longer calls the seven legacy C symbols from issue #403 AC #1" test_user_emission_is_flipped
run_test "compiler binary exports defined wave-2 sfn_str_* / sfn_*_to_str and _sfn_* / _sfn symbols" test_compiler_binary_exports_wave2
run_test "number_to_string still round-trips via the flipped @sfn_number_to_str path" test_number_to_str_roundtrip
run_test "immediate-codepoint tagged-pointer hack is no longer reachable from user IR" test_immediate_codepoint_hack_unreachable

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
