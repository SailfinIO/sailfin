#!/usr/bin/env bash
# End-to-end test for runtime/sfn/string.sfn — the first wave of
# Sailfin-defined SfnString operations linked into the compiler
# binary (issue #396, epic #389 M2.4a).
#
# Mirrors test_runtime_memory_arena.sh's structure: typecheck +
# fmt + emit-shape on the source module, plus a compiled-IR
# regression that the new compiler routes string `==`, `s.length`,
# and substring/length-coercion call sites through the
# `sfn_str_*` family instead of the legacy
# `sailfin_runtime_string_length` / `strings_equal` /
# `substring_unchecked` C entrypoints.
#
# When M2.4b retires the trampoline bodies and ships the real
# arena-backed concat/append helpers, the emit-shape assertions
# stay — they pin the migration symbol surface, not the body
# strategy.

set -euo pipefail

BINARY="${1:?usage: test_runtime_string_basic.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MODULE="$REPO_ROOT/runtime/sfn/string.sfn"

SCRATCH="$(mktemp -d -t sfn-runtime-string-XXXXXX)"
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

# ---- Test: emitted IR carries a `define` for every sfn_str_sfn_* export ----
#
# The Sailfin module exports the `_sfn_` infix family
# (`sfn_str_sfn_len`, ...) so its definitions coexist with the C
# trampolines that own the bare `sfn_str_*` namespace —
# `runtime/native/src/sailfin_runtime.c` defines those for the
# new compiler emission and the test linker. M2.4b retires the C
# trampolines and renames these exports to the bare form.
test_emit_define_shape() {
    local ll="$SCRATCH/string.ll"
    local log="$SCRATCH/emit.log"
    if ! "$BINARY" emit -o "$ll" llvm "$MODULE" > "$log" 2>&1; then
        echo "[test]   sfn emit llvm failed on runtime/sfn/string.sfn:"
        cat "$log"
        return 1
    fi
    local missing=0
    # Still-façade `_sfn_` infix exports (bare names remain C-owned until
    # their own migration). `sfn_str_sfn_{len,eq,slice}` retired in #1372 —
    # those bodies are now bare Sailfin defines (see the BARE list below).
    for sym in sfn_str_sfn_to_cstr sfn_str_sfn_from_cstr; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in string.ll"
            missing=$((missing + 1))
        fi
    done
    # #1372 (len/eq/slice): now Sailfin-defined at the BARE name (the C defs
    # are `static`), so the real body emits a bare `define`.
    for sym in sfn_str_len sfn_str_eq sfn_str_slice; do
        if ! grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'define ... @${sym}(' in string.ll (expected after #1372)"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: emitted IR does NOT collide with C trampolines ----
#
# Coexistence regression: a regression that flips a Sailfin export
# to a bare `sfn_str_*` define would collide with the C trampoline
# at link time and break `make compile`. Pin the `_sfn_` infix as
# the marker until M2.4b removes the C trampolines.
test_no_bare_sfn_str_define() {
    local ll="$SCRATCH/string.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    # #1372: `sfn_str_{len,eq,slice}` retired from this list (real bare Sailfin
    # bodies). #1308: `sfn_str_to_cstr` flipped to a bare Sailfin identity body
    # (so a bare `define` is now expected, asserted by the export test below) and
    # `sfn_str_from_cstr` was deleted (dead). The still-C bridges string.sfn must
    # NOT bare-define are `read_byte` / `grapheme_byte` (sub-word load the seed
    # can't lower; called as externs → `declare`, not `define`). Retire at #822.
    local found=0
    for sym in sfn_str_read_byte sfn_str_grapheme_byte; do
        if grep -qE "^define .* @${sym}\(" "$ll"; then
            echo "[test]   collision risk: string.sfn emits 'define ... @${sym}(', conflicts with C trampoline"
            found=$((found + 1))
        fi
    done
    return "$found"
}

# ---- Test: emitted IR declares the libc/runtime trampolines bodies use ----
test_emit_libc_declares() {
    local ll="$SCRATCH/string.ll"
    if [ ! -f "$ll" ]; then
        echo "[test]   $ll missing — test_emit_define_shape must run first"
        return 1
    fi
    local missing=0
    # `memchr` is the new libc declaration this PR adds (used by
    # the architect-spec body of sfn_str_from_cstr in M2.4b).
    # `memcmp` is already in libc.sfn and rides alongside.
    for sym in memcmp memchr; do
        if ! grep -qE "^declare .* @${sym}\(" "$ll"; then
            echo "[test]   missing 'declare ... @${sym}(' in string.ll"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: compiled hello-world IR no longer references the legacy C symbols ----
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
    # Legacy descriptor symbols match `runtime_helpers.sfn` exactly:
    # `string.length` → `sailfin_runtime_string_length`, `substring`
    # → `substring`, `substring_unchecked` → `substring_unchecked`,
    # `strings_equal` → `strings_equal`. `\b` treats `_` as a word
    # char, so `@substring\b` matches the bare symbol but not
    # `@substring_unchecked` (no boundary between `g` and `_`),
    # which means each entry below is a tight, non-overlapping
    # regression target.
    for sym in sailfin_runtime_string_length substring substring_unchecked strings_equal; do
        if grep -qE "@${sym}\b" "$ll"; then
            echo "[test]   user emission still references @${sym} (expected the sfn_str_* flip)"
            grep -nE "@${sym}\b" "$ll" | head -3
            found=$((found + 1))
        fi
    done
    return "$found"
}

# ---- Test: compiler binary exports both name families ----
#
# The C trampolines (`sailfin_runtime.c`) own the canonical
# `sfn_str_*` names — those are what the new compiler emission
# calls and what the test linker resolves against. The Sailfin
# module owns the `sfn_str_sfn_*` infix family — proof of life
# for the migration. Both must show up as defined text symbols.
test_compiler_binary_exports_sfn_str() {
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    if [ -z "$nm_log" ]; then
        echo "[test]   nm produced no output for $BINARY (stripped binary?)"
        return 1
    fi
    local missing=0
    # Bare `sfn_str_{len,eq,slice}` are now Sailfin-defined (#1372); the C
    # namesakes are `static`. #1308: `sfn_str_to_cstr` is now Sailfin-defined
    # too (bare identity body); `sfn_str_from_cstr` was deleted (dead, no caller)
    # so it is dropped here. The Sailfin `sfn_str_sfn_{to_cstr,from_cstr}` infix
    # proof-of-life bodies stay. The `sfn_str_sfn_{len,eq,slice}` infix exports
    # retired with the #1372 flip.
    for sym in sfn_str_len sfn_str_eq sfn_str_slice sfn_str_to_cstr sfn_str_sfn_to_cstr sfn_str_sfn_from_cstr; do
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

# ---- Test: capsule.toml lists the new module ----
test_manifest_lists_string() {
    local manifest="$REPO_ROOT/runtime/native/capsule.toml"
    if ! grep -qE '^sfn-sources = \[.*"\.\./sfn/string\.sfn".*\]' "$manifest"; then
        echo "[test]   sfn-sources does not list ../sfn/string.sfn:"
        grep -nE 'sfn-sources' "$manifest" || true
        return 1
    fi
    return 0
}

# (Historical: the prior `scripts/build.sh`'s `RUNTIME_SFN_ALLOW`
# allowlist was a second source of truth kept in lockstep with the
# manifest. With the script retired in Stage E PR7 / #383, the
# manifest is the sole source of truth and the allowlist drift-
# check is gone.)

run_test "sfn check runtime/sfn/string.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/string.sfn is canonical" test_fmt_clean
run_test "sfn emit llvm produces define for every sfn_str_sfn_* export" test_emit_define_shape
run_test "sfn emit llvm does not collide with C trampoline sfn_str_* names" test_no_bare_sfn_str_define
run_test "sfn emit llvm declares memcmp and memchr trampolines" test_emit_libc_declares
run_test "user emission no longer calls @sailfin_runtime_string_length / @substring / @substring_unchecked / @strings_equal" test_user_emission_is_flipped
run_test "compiler binary exports defined sfn_str_* and sfn_str_sfn_* symbols" test_compiler_binary_exports_sfn_str
run_test "runtime/native/capsule.toml sfn-sources lists the string module" test_manifest_lists_string

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
