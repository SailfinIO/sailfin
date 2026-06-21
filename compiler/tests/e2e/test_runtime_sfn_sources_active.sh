#!/usr/bin/env bash
# End-to-end test for issue #394 (M2.1+M2.2): the
# `runtime/sfn/memory/arena.sfn` Sailfin module's `sfn_arena_sfn_*`
# exports actually link into the compiler binary built by
# `make compile`.
#
# This is the "active manifest" companion to
# `test_runtime_sfn_sources_link_consumer.sh`, which exercises
# `_compile_runtime_sfn_sources` against a synthetic workspace.
# This test instead pins the production link path: when
# `runtime/capsule.toml` declares
# `sfn-sources = ["sfn/memory/arena.sfn"]`, the resulting
# `build/native/sailfin` binary exports five `sfn_arena_sfn_*`
# symbols sourced from Sailfin emission — coexisting with the C
# arena's matching `sfn_arena_*` exports.
#
# Historical note: the prior `scripts/build.sh`'s
# `RUNTIME_SFN_ALLOW` allowlist (since retired in Stage E PR7 /
# #383) was a second source of truth kept in lockstep with the
# manifest. With build.sh retired, the manifest is the sole
# source of truth and the allowlist drift-check below is gone.
#
# The test asserts the Sailfin `sfn_arena_sfn_*` infix family, the
# bare arena-core exports that #1309 moved into Sailfin
# (`sfn_arena_create`/`alloc`/`global`/`enabled`), and the remaining C
# arena symbols (`reset`/`destroy`/`realloc`/`print_stats`/`mark`/
# `rewind`) are all present. The remaining-C assertion guards the
# "C arena still links for the not-yet-ported entry points" invariant —
# a patch that drops them before #822 trips it (intentional: the C arena
# retires on a tracked PR, not silently).

set -euo pipefail

BINARY="${1:?usage: test_runtime_sfn_sources_active.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

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

# ---- Test: the manifest declares the Sailfin arena module ----
test_manifest_lists_arena() {
    local manifest="$REPO_ROOT/runtime/capsule.toml"
    if [ ! -f "$manifest" ]; then
        echo "[test]   missing manifest: $manifest"
        return 1
    fi
    if ! grep -qE '^sfn-sources = \[.*"sfn/memory/arena\.sfn".*\]' "$manifest"; then
        echo "[test]   sfn-sources does not list sfn/memory/arena.sfn:"
        grep -nE 'sfn-sources' "$manifest" || true
        return 1
    fi
    return 0
}

# ---- Test: the compiler binary exports all five Sailfin arena symbols ----
test_compiler_binary_exports_sfn_arena_sfn() {
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    if [ -z "$nm_log" ]; then
        echo "[test]   nm produced no output for $BINARY (stripped binary?)"
        return 1
    fi
    local missing=0
    for sym in sfn_arena_sfn_create sfn_arena_sfn_alloc sfn_arena_sfn_reset sfn_arena_sfn_destroy sfn_arena_sfn_realloc; do
        # Require a defined text symbol (` T ` or ` t `) — an
        # undefined-reference line (`U sfn_arena_sfn_create`)
        # would otherwise satisfy a permissive end-of-line match
        # and falsely report the binary as exporting the symbol
        # while it actually only declares it. Anchored on
        # symbol-end so a substring collision
        # (`sfn_arena_sfn_create_helper`) does not satisfy the
        # check. The optional `_` prefix accommodates macOS
        # Mach-O `nm` output, which prepends an underscore to
        # every C symbol (`T _sfn_arena_sfn_create`); Linux ELF
        # `nm` emits the bare name. Here-string instead of `echo
        # | grep` so `set -o pipefail` does not turn `grep -q`'s
        # early exit into a SIGPIPE-induced false negative.
        if ! grep -qE "[[:space:]][Tt][[:space:]]_?${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary missing Sailfin export: $sym (looked for ' T|t [_]${sym}' in nm output)"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: the surviving bare arena forwarders stay exported (#1309) ----
test_compiler_binary_keeps_c_arena_exports() {
    # #1309 deleted `runtime/native/src/sailfin_arena.c`. `sfn_arena_reset` /
    # `sfn_arena_destroy` and the struct-returning `sfn_arena_mark` /
    # `sfn_arena_rewind` are GONE (reset/destroy had zero callers; mark/rewind
    # were only reached by the deleted C intrinsic wrappers, and emitted code
    # routes those intrinsics to the Sailfin `sfn_arena_sfn_mark` / `_rewind`).
    # Only `sfn_arena_realloc` and `sfn_arena_print_stats` survive — as bare
    # Sailfin forwarders (arena.sfn) that the C-internal `sailfin_runtime.c`
    # callers + the atexit telemetry path bind to by name. Assert those two
    # remain exported; a regression dropping them breaks that link. The full
    # C-arena retirement (and this whole file's deletion) is #822.
    # Same defined-text-symbol regex as the Sailfin-export assertion above
    # (` T ` / ` t `, optional macOS `_` prefix).
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    local missing=0
    for sym in sfn_arena_realloc sfn_arena_print_stats; do
        if ! grep -qE "[[:space:]][Tt][[:space:]]_?${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary missing bare arena forwarder: $sym (looked for ' T|t [_]${sym}' in nm output)"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: the bare arena-core exports are Sailfin-owned (#1309) ----
test_compiler_binary_exports_bare_arena_core() {
    # #1309 headline: the bare `sfn_arena_create` / `sfn_arena_alloc` /
    # `sfn_arena_global` / `sfn_arena_enabled` are now DEFINED by the
    # Sailfin arena module (the C namesakes were removed), so the linker
    # binds every caller — `sailfin_runtime.c`'s bare call sites and the
    # `mem.sfn` externs — to the Sailfin definitions. They must be
    # present as defined text symbols; a regression that fails to emit
    # them (or re-adds the C defs as duplicates) breaks the link this
    # asserts. Same defined-text-symbol regex as the other export checks.
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    local missing=0
    for sym in sfn_arena_create sfn_arena_alloc sfn_arena_global sfn_arena_enabled; do
        if ! grep -qE "[[:space:]][Tt][[:space:]]_?${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary missing Sailfin arena-core export: $sym"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: nm | grep sfn_arena matches at least the spec name ----
test_nm_grep_sfn_arena_spec_names() {
    # The literal acceptance check from issue #394: the spec name
    # `sfn_arena_alloc` is present in the compiler binary. Post-#1309 it
    # is the Sailfin bare export that satisfies this (the C namesake was
    # removed); the check stays valid through #822.
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    if ! grep -q "sfn_arena_alloc" <<< "$nm_log"; then
        echo "[test]   nm | grep sfn_arena_alloc matched no symbols"
        return 1
    fi
    return 0
}

run_test "runtime/capsule.toml sfn-sources lists the arena module" test_manifest_lists_arena
run_test "compiler binary exports five sfn_arena_sfn_* Sailfin symbols" test_compiler_binary_exports_sfn_arena_sfn
run_test "compiler binary exports bare arena-core (create/alloc/global/enabled) from Sailfin" test_compiler_binary_exports_bare_arena_core
run_test "compiler binary exports surviving bare arena forwarders (realloc/print_stats)" test_compiler_binary_keeps_c_arena_exports
run_test "nm | grep sfn_arena_alloc matches at least one symbol (#394 spec)" test_nm_grep_sfn_arena_spec_names

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
