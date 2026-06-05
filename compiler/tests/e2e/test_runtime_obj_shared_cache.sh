#!/usr/bin/env bash
# End-to-end test for the shared runtime-object cache fix (#1096).
#
# Before this fix, runtime C/LL/sfn objects were cached only in the
# per-build work-dir (a sidecar `<obj>.o.key` next to the `<obj>.o`
# under `<work-dir>/sailfin/`), never in the shared content-addressed
# cache root (`build/cache/v1`) the `.ll` module cache uses. A second
# build into a *sibling* work-dir therefore always missed every runtime
# object, even with an identical source tree and a warm shared cache.
#
# The build-quality gate (`build-quality.yml`) builds the compiler into
# two sibling work-dirs (`det-pass1` -> `det-pass2`) sharing one cache
# root and asserts `cache.hit_rate >= 0.95` on the warm second pass.
# Once #1075 folded runtime objects into that summary, the work-dir-
# local runtime cache dragged the rate to 0.90 (issue #1096): the 17
# runtime objects missed on pass2 while the 155 `.ll` modules hit.
#
# This test pins the contract that the warm sibling pass now hits the
# runtime objects from the shared cache:
#   1. Build A (cold shared cache) misses + stores the runtime objects.
#   2. Build B into a SIBLING work-dir, same shared cache root, MUST
#      cache-hit every runtime object: the `[cache]` summary reports
#      misses=0 with hits>=1.
#   3. The shared cache root holds `runtime-obj` entries after build A.
#
# A one-line program keeps this to seconds (it has no `.ll` module-
# cache deps of its own, so the `[cache]` summary reflects only the
# runtime objects).
#
# Usage:
#   compiler/tests/e2e/test_runtime_obj_shared_cache.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_obj_shared_cache.sh <compiler-binary>}"
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

SCRATCH="$(mktemp -d -t sfn-rt-shared-XXXXXX)"
cleanup() { rm -rf "$SCRATCH"; }
trap cleanup EXIT

# Dedicated shared cache root so the test never touches the repo's
# build/cache/ tree (and starts genuinely cold).
SHARED_CACHE="$SCRATCH/cache"
WORK_A="$SCRATCH/passA"
WORK_B="$SCRATCH/passB"

cat > "$SCRATCH/hello.sfn" <<'EOF'
fn main() -> int {
    return 0;
}
EOF

# `timeout` / `ulimit -v` are Linux-only; apply best-effort so the
# test also runs on macos-arm64 (matching the #632 e2e test).
TIMEOUT_PREFIX=""
if command -v timeout >/dev/null 2>&1; then TIMEOUT_PREFIX="timeout 120"; fi

# Build hello.sfn into work-dir $1, sharing $SHARED_CACHE. The cache
# summary (`[cache] ...`) prints to stderr (#915); 2>&1 captures it.
do_build() {
    local work="$1" log="$2"
    ( ulimit -v 8388608 2>/dev/null || true
      SAILFIN_BUILD_CACHE_DIR="$SHARED_CACHE" \
        ${TIMEOUT_PREFIX} "$BINARY" build "$SCRATCH/hello.sfn" \
        -o "$SCRATCH/hello-$(basename "$work")" --work-dir "$work" ) >"$log" 2>&1
}

summary_field() {
    # summary_field <log> <field> -> integer (or "" if no summary line)
    sed -nE "s/.*\[cache\] .*${2}=([0-9]+).*/\1/p" "$1" | tail -n1
}

# ---- Build A: cold shared cache -> runtime objects miss + store ----
if ! do_build "$WORK_A" "$SCRATCH/buildA.log"; then
    echo "[test] FATAL: build A failed" >&2
    cat "$SCRATCH/buildA.log" >&2
    exit 1
fi

check_buildA_stores_runtime_objs() {
    local misses stores
    misses="$(summary_field "$SCRATCH/buildA.log" misses)"
    stores="$(summary_field "$SCRATCH/buildA.log" stores)"
    if [ -z "$misses" ]; then
        echo "  expected a [cache] summary on cold build A, found none" >&2
        cat "$SCRATCH/buildA.log" >&2
        return 1
    fi
    if [ "${misses:-0}" -lt 1 ]; then
        echo "  expected runtime-object misses>=1 on cold build A, got misses=$misses" >&2
        return 1
    fi
    if [ "${stores:-0}" -lt 1 ]; then
        echo "  expected runtime-object stores>=1 on cold build A, got stores=$stores" >&2
        return 1
    fi
    return 0
}
run_test "cold build A misses + stores runtime objects" \
    check_buildA_stores_runtime_objs

# The shared cache root must now hold runtime-obj artifacts (filename
# `runtime.o` per build_cache.sfn::_filename_for_kind).
check_shared_cache_populated() {
    if ! find "$SHARED_CACHE" -name 'runtime.o' -print -quit | grep -q .; then
        echo "  expected runtime.o artifacts under $SHARED_CACHE after build A" >&2
        find "$SHARED_CACHE" -type f >&2 || true
        return 1
    fi
    return 0
}
run_test "shared cache root holds runtime-obj entries (#1096)" \
    check_shared_cache_populated

# ---- Build B: sibling work-dir, warm shared cache -> all hits ----
if ! do_build "$WORK_B" "$SCRATCH/buildB.log"; then
    echo "[test] FATAL: build B failed" >&2
    cat "$SCRATCH/buildB.log" >&2
    exit 1
fi

# This is the regression assertion. Pre-#1096, build B's fresh work-dir
# held no runtime `.o` sidecars, so every runtime object missed
# (misses>=1) despite the warm shared cache. Post-fix they are served
# from the shared cache: misses=0, hits>=1.
check_buildB_warm_hits() {
    local hits misses
    hits="$(summary_field "$SCRATCH/buildB.log" hits)"
    misses="$(summary_field "$SCRATCH/buildB.log" misses)"
    if [ -z "$hits" ]; then
        echo "  expected a [cache] summary on warm sibling build B, found none" >&2
        cat "$SCRATCH/buildB.log" >&2
        return 1
    fi
    if [ "${hits:-0}" -lt 1 ]; then
        echo "  expected runtime-object hits>=1 on warm sibling build B, got hits=$hits" >&2
        cat "$SCRATCH/buildB.log" >&2
        return 1
    fi
    if [ "${misses:-0}" -ne 0 ]; then
        echo "  expected misses=0 on warm sibling build B (shared cache should serve" >&2
        echo "  every runtime object across work-dirs), got misses=$misses" >&2
        cat "$SCRATCH/buildB.log" >&2
        return 1
    fi
    return 0
}
run_test "warm sibling build B hits runtime objects from shared cache (#1096)" \
    check_buildB_warm_hits

echo "[test] runtime-object shared cache: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
