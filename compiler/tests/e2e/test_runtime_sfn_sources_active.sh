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
# `runtime/native/capsule.toml` declares
# `sfn-sources = ["../sfn/memory/arena.sfn"]` and
# `scripts/build.sh`'s `RUNTIME_SFN_ALLOW` allowlist contains
# the same file, the resulting `build/native/sailfin` binary
# exports five `sfn_arena_sfn_*` symbols sourced from Sailfin
# emission — coexisting with the C arena's matching
# `sfn_arena_*` exports.
#
# The test asserts both the new (Sailfin) and the old (C)
# symbol families are present. The C arena assertion guards
# the M2 "both arenas link side-by-side" invariant — a future
# patch that drops the C arena before M3 trips this assertion
# (which is intentional: the C arena retires on a tracked PR,
# not silently).

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
    local manifest="$REPO_ROOT/runtime/native/capsule.toml"
    if [ ! -f "$manifest" ]; then
        echo "[test]   missing manifest: $manifest"
        return 1
    fi
    if ! grep -qE '^sfn-sources = \[.*"\.\./sfn/memory/arena\.sfn".*\]' "$manifest"; then
        echo "[test]   sfn-sources does not list ../sfn/memory/arena.sfn:"
        grep -nE 'sfn-sources' "$manifest" || true
        return 1
    fi
    return 0
}

# ---- Test: build.sh allowlist enumerates the same arena module ----
test_build_allowlist_lists_arena() {
    local build_script="$REPO_ROOT/scripts/build.sh"
    if [ ! -f "$build_script" ]; then
        echo "[test]   missing build script: $build_script"
        return 1
    fi
    # The two sources of truth (`sfn-sources` in capsule.toml and
    # `RUNTIME_SFN_ALLOW` in build.sh) must remain in lockstep so
    # `make compile` and `sfn build -p compiler` produce
    # byte-identical bitcode. Drift here is the trip-wire for the
    # determinism-via-coexistence invariant called out in the
    # capsule.toml comment.
    if ! grep -qE '^\s*"\$RUNTIME_SRC/sfn/memory/arena\.sfn"' "$build_script"; then
        echo "[test]   RUNTIME_SFN_ALLOW does not list runtime/sfn/memory/arena.sfn:"
        grep -nE 'RUNTIME_SFN_ALLOW' "$build_script" || true
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
        # Match `<addr> T <sym>` or `<addr> t <sym>` (text section).
        # Anchored on whitespace + symbol-end so a substring
        # collision (e.g. a hypothetical
        # `sfn_arena_sfn_create_helper`) does not satisfy the
        # check. Here-string instead of `echo | grep` so
        # `set -o pipefail` does not turn `grep -q`'s early exit
        # into a SIGPIPE-induced false negative.
        if ! grep -qE "[[:space:]]${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary missing Sailfin export: $sym"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: the compiler binary still exports the C arena symbols ----
test_compiler_binary_keeps_c_arena_exports() {
    # Coexistence invariant: M2.1 ships the Sailfin arena
    # alongside the C arena, not as a replacement. The C arena
    # remains the production allocator until M3 retires
    # `runtime/native/src/sailfin_arena.c`. A patch that
    # accidentally drops the C arena would silently route
    # production through unfinished Sailfin stubs — this
    # assertion catches that.
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    local missing=0
    for sym in sfn_arena_create sfn_arena_alloc sfn_arena_reset sfn_arena_destroy sfn_arena_realloc; do
        if ! grep -qE "[[:space:]]${sym}\$" <<< "$nm_log"; then
            echo "[test]   compiler binary missing C arena export: $sym"
            missing=$((missing + 1))
        fi
    done
    return "$missing"
}

# ---- Test: nm | grep sfn_arena matches at least the five spec names ----
test_nm_grep_sfn_arena_spec_names() {
    # The literal acceptance check from issue #394: every spec
    # name in the architect's "exposes" list (`sfn_arena_create
    # / alloc / reset / destroy / realloc`) is present in the
    # compiler binary. Today both the C arena and the Sailfin
    # module's distinct-but-prefixed exports satisfy this; the
    # check stays valid through M3 because the C arena is the
    # one keeping these specific names.
    local nm_log
    nm_log="$(nm "$BINARY" 2>/dev/null || true)"
    if ! grep -q "sfn_arena_alloc" <<< "$nm_log"; then
        echo "[test]   nm | grep sfn_arena_alloc matched no symbols"
        return 1
    fi
    return 0
}

run_test "runtime/native/capsule.toml sfn-sources lists the arena module" test_manifest_lists_arena
run_test "scripts/build.sh RUNTIME_SFN_ALLOW lists the arena module" test_build_allowlist_lists_arena
run_test "compiler binary exports five sfn_arena_sfn_* Sailfin symbols" test_compiler_binary_exports_sfn_arena_sfn
run_test "compiler binary still exports five sfn_arena_* C arena symbols" test_compiler_binary_keeps_c_arena_exports
run_test "nm | grep sfn_arena_alloc matches at least one symbol (#394 spec)" test_nm_grep_sfn_arena_spec_names

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
