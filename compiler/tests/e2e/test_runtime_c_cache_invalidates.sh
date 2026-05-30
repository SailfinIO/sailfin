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
# It drives the legacy `_clang_compile_runtime_objects` path (a plain
# `sfn build <file.sfn>`), which compiles the exact source the issue
# edits (`runtime/native/src/sailfin_runtime.c`) and shares the
# `_runtime_obj_cache_hit` gate with the runtime-capsule path that
# the compiler self-build uses. Driving a one-line program keeps the
# test to seconds rather than three full `sfn build -p compiler`
# rebuilds; the capsule-path object name shape and the key contract
# are covered by `compiler/tests/unit/build_cache_c_source_test.sfn`.
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

# The legacy runtime object compiled from sailfin_runtime.c at -O2.
RUNTIME_OBJ="$WORK/sailfin/sailfin_runtime-O2.o"

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

echo "[test] runtime C-object cache: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
