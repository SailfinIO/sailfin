#!/usr/bin/env bash
# End-to-end test for the runtime C-object cache invalidation fix (#632).
#
# Before this fix, the runtime C-object cache keyed each `.o` purely
# on source basename + opt flag and gated reuse on `fs.exists`, so a
# content edit to a tracked `runtime/native/src/*.c` source left a
# stale cached object the linker silently reused. The fix mixes the
# source content SHA-256 into a sidecar `<obj>.key` and only reuses
# the `.o` when the recorded key matches the current source.
#
# This test pins the two halves of the contract on a real build:
#   1. A pure mtime `touch` (content unchanged) MUST still cache-hit
#      — the cache is content-addressed, not mtime-addressed.
#   2. A content edit MUST produce a cache miss — the `.o` is
#      recompiled and its mtime advances.
#
# Since #940 a plain `sfn build <file.sfn>` (no `[dependencies]`)
# resolves `runtime/native/capsule.toml` as an implicit runtime
# capsule and compiles its `c-sources` via
# `_clang_compile_runtime_capsule_objects`, which shares the same
# `_runtime_obj_cache_hit` / `runtime_object_cache_key` (#632) gate the
# retired `_clang_compile_runtime_objects` path used. The object name
# is now capsule-prefixed (`sfn__runtime-native__<basename>-<opt>.o`).
# This test still edits the exact source the cache keys on
# (`runtime/native/src/sailfin_runtime.c`). Driving a one-line program
# keeps the test to seconds rather than three full `sfn build -p
# compiler` rebuilds; the key contract is also covered by
# `compiler/tests/unit/build_cache_c_source_test.sfn`.
#
# Usage:
#   compiler/tests/e2e/test_runtime_c_cache_invalidates.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_c_cache_invalidates.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$REPO_ROOT"

PASS=0
FAIL=0
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

C_SRC="runtime/native/src/sailfin_runtime.c"
SCRATCH="$(mktemp -d -t sfn-c-cache-XXXXXX)"
BAK="$(mktemp)"
cp "$C_SRC" "$BAK"
cleanup() { cp "$BAK" "$C_SRC"; rm -rf "$SCRATCH" "$BAK"; }
trap cleanup EXIT

WORK="$SCRATCH/work"
mkdir -p "$WORK"

cat > "$SCRATCH/hello.sfn" <<'EOF'
fn main() -> int {
    return 0;
}
EOF

# Portable mtime reader (Linux coreutils first, macOS BSD stat fallback).
mtime_of() { stat -c %Y "$1" 2>/dev/null || stat -f %m "$1"; }

# `timeout` is GNU coreutils — present on linux-x86_64 CI, absent on
# macos-arm64. Use it when available; otherwise invoke the binary
# directly. (`ulimit -v` is likewise Linux-only — macos-arm64 rejects
# it with "cannot modify limit" — so it's applied best-effort below.)
TIMEOUT_PREFIX=""
if command -v timeout >/dev/null 2>&1; then TIMEOUT_PREFIX="timeout 120"; fi

# Build the one-line program into the isolated work-dir so runtime
# objects land under "$WORK/sailfin/" instead of the repo's
# build/sailfin/.
do_build() {
    ( ulimit -v 8388608 2>/dev/null || true
      ${TIMEOUT_PREFIX} "$BINARY" build "$SCRATCH/hello.sfn" \
        -o "$SCRATCH/hello" --work-dir "$WORK" ) >"$SCRATCH/build.log" 2>&1
}

# The runtime-capsule object compiled from sailfin_runtime.c at -O2.
# Name shape: `_runtime_obj_prefix("sfn/runtime-native")` +
# `_path_basename("sailfin_runtime.c")` + opt + ".o".
RUNTIME_OBJ="$WORK/sailfin/sfn__runtime-native__sailfin_runtime.c-O2.o"

# ---- Build 1: populate the cache ----
if ! do_build; then
    echo "[test] FATAL: initial build failed" >&2
    cat "$SCRATCH/build.log" >&2
    exit 1
fi

check_obj_and_sidecar_exist() {
    [ -f "$RUNTIME_OBJ" ] || { echo "  missing runtime object $RUNTIME_OBJ" >&2; return 1; }
    [ -f "$RUNTIME_OBJ.key" ] || { echo "  missing content-key sidecar $RUNTIME_OBJ.key" >&2; return 1; }
    return 0
}
run_test "runtime object + content-key sidecar produced on first build" \
    check_obj_and_sidecar_exist

T1="$(mtime_of "$RUNTIME_OBJ")"

# The `[cache]` summary line `_print_cache_summary` emits to stderr
# (#915); `build.log` still captures it because `do_build` redirects
# `2>&1`. Since #915 the runtime C/LL/sfn object cache folds its
# hits/misses into this same line, so the counts below are
# attributable to the runtime objects (the one-line program has no
# `.ll` module-cache deps of its own). Helpers parse the
# `hits=`/`misses=` fields out of the most recent build's log.
summary_field() {
    # summary_field <field-name> -> integer value (or "" if no line)
    sed -nE "s/.*\[cache\] .*${1}=([0-9]+).*/\1/p" "$SCRATCH/build.log" | tail -n1
}

# ---- Pure mtime touch: content unchanged MUST cache-hit ----
# Sleep 1s so any recompile would produce a strictly newer mtime
# (filesystem mtime granularity is 1s in the worst case).
sleep 1
touch "$C_SRC"
check_touch_is_cache_hit() {
    do_build || { echo "  build after touch failed" >&2; return 1; }
    local t2; t2="$(mtime_of "$RUNTIME_OBJ")"
    if [ "$t2" != "$T1" ]; then
        echo "  expected cache HIT after pure touch, but object mtime advanced ($T1 -> $t2)" >&2
        return 1
    fi
    return 0
}
run_test "pure mtime touch (content unchanged) cache-hits" \
    check_touch_is_cache_hit

# #915: a no-op rebuild reports the runtime objects as cache hits,
# with zero misses, in the `[cache]` summary line.
check_noop_rebuild_summary_hits() {
    local hits misses
    hits="$(summary_field hits)"
    misses="$(summary_field misses)"
    if [ -z "$hits" ]; then
        echo "  expected a [cache] summary line after no-op rebuild, found none" >&2
        cat "$SCRATCH/build.log" >&2
        return 1
    fi
    if [ "$hits" -lt 1 ]; then
        echo "  expected runtime-object cache hits>=1 on no-op rebuild, got hits=$hits" >&2
        return 1
    fi
    if [ "${misses:-0}" -ne 0 ]; then
        echo "  expected misses=0 on no-op rebuild, got misses=$misses" >&2
        return 1
    fi
    return 0
}
run_test "no-op rebuild summary reports runtime hits (misses=0) (#915)" \
    check_noop_rebuild_summary_hits

# ---- Content edit MUST cache-miss (the regression this fixes) ----
sleep 1
printf '\n/* #632 runtime C-object cache invalidation probe */\n' >> "$C_SRC"
check_content_edit_is_cache_miss() {
    do_build || { echo "  build after content edit failed" >&2; cat "$SCRATCH/build.log" >&2; return 1; }
    local t3; t3="$(mtime_of "$RUNTIME_OBJ")"
    if [ "$t3" = "$T1" ]; then
        echo "  expected cache MISS after content edit, but object was NOT recompiled (mtime $t3 unchanged)" >&2
        return 1
    fi
    return 0
}
run_test "content edit busts the cache (object recompiled)" \
    check_content_edit_is_cache_miss

# #915: the same content-edit rebuild surfaces >=1 miss in the
# `[cache]` summary — the observability gap #632 deferred. Before
# this fix the line read `misses=0` even though the `.o` recompiled.
check_content_edit_summary_miss() {
    local misses
    misses="$(summary_field misses)"
    if [ -z "$misses" ]; then
        echo "  expected a [cache] summary line after content edit, found none" >&2
        cat "$SCRATCH/build.log" >&2
        return 1
    fi
    if [ "$misses" -lt 1 ]; then
        echo "  expected runtime-object cache misses>=1 after content edit, got misses=$misses" >&2
        cat "$SCRATCH/build.log" >&2
        return 1
    fi
    return 0
}
run_test "content edit surfaces a miss in the [cache] summary (#915)" \
    check_content_edit_summary_miss

echo "[test] runtime C-object cache: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
