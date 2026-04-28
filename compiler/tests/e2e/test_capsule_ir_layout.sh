#!/usr/bin/env bash
# End-to-end test for the per-capsule `.ll` layout (Stage C2b2).
#
# Verifies that `sfn build -p <capsule>` routes module `.ll`
# outputs into the canonical per-capsule tree from proposal §4.4:
#
#   build/capsules/<dep-scope>/<dep-name>/ir/<rel>.ll
#       — for sources of manifest-declared deps
#   build/capsules/<consumer-scope>/<consumer-name>/ir/<rel>.ll
#       — for intra-capsule (relative-import) sources of a `-p`
#         consumer with a safe scope/name
#   build/sailfin/capsules/<mangled>.ll
#       — legacy fallback (positional builds, single-segment names)
#
# Also re-confirms that the build_report.sfn `dep_ll_paths` and
# capsule_artifact.sfn sidecar reflect the new paths.
#
# Schema bumps are explicitly NOT happening for path drift inside
# `dep_ll_paths` — see capsule_artifact.sfn / build_report.sfn for
# the rationale. This test locks the new path shape; if it ever
# regresses to the legacy flat form for manifest deps, downstream
# tooling that walks the per-capsule tree breaks.
#
# Usage:
#   compiler/tests/e2e/test_capsule_ir_layout.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_capsule_ir_layout.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

if ! command -v jq >/dev/null 2>&1; then
    echo "[test] SKIP: jq not installed (required for sidecar/report parsing)" >&2
    exit 0
fi

SCRATCH="$(mktemp -d -t sfn-capsule-ir-layout-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

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

# ---- Setup: a `demo/widget` library with a relative import + dep ----
# - `src/mod.sfn` imports from a manifest dep (sfn/math) AND a
#   relative sibling (./util) so we exercise BOTH routing rules.
# - `src/util.sfn` is the relative-import target; under C2b2 its
#   `.ll` lands under the consumer's tree, NOT the dep tree.
mkdir -p "$SCRATCH/src"
ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "demo/widget"
version = "0.1.0"
description = "E2E fixture for the Stage C2b2 per-capsule .ll layout"

[dependencies]
"sfn/math" = "0.1.0"

[capabilities]
required = ["io"]

[build]
kind = "library"
entry = "src/mod.sfn"
EOF

cat > "$SCRATCH/src/mod.sfn" <<'EOF'
import { abs } from "sfn/math";
import { double } from "./util";

fn widget_compute(n: number) -> number {
    return double(abs(n));
}
EOF

cat > "$SCRATCH/src/util.sfn" <<'EOF'
fn double(n: number) -> number {
    return n * 2;
}
EOF

# ---- Test 1: build succeeds ----
test_build_succeeds() {
    cd "$SCRATCH" || return 1
    "$BINARY" build -p . --json > "$SCRATCH/build.json" 2> "$SCRATCH/build.err"
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build -p exited with code $rc; stderr:" >&2
        cat "$SCRATCH/build.err" >&2
        return $rc
    fi
    jq . "$SCRATCH/build.json" > /dev/null 2>&1
}
run_test "sfn build -p succeeds with --json" test_build_succeeds

SIDECAR="$SCRATCH/build/capsules/demo/widget/manifest.json"

# ---- Test 2: manifest dep .ll lives under the dep's tree ----
test_dep_ll_under_dep_tree() {
    [ -f "$SCRATCH/build/capsules/sfn/math/ir/mod.ll" ]
}
run_test "manifest dep .ll lands at build/capsules/sfn/math/ir/mod.ll" test_dep_ll_under_dep_tree

# ---- Test 3: relative-import .ll lives under the consumer's tree ----
# The slug for `./util` from `src/mod.sfn` is computed by
# `module_name_from_path` and lands at `<project_root>/src/util`
# (path-shaped). Stage C2b2 strips the discovered project_root
# prefix before routing, so the .ll lands at
# `build/capsules/<consumer>/ir/src/util.ll` — mirroring the
# source layout under the capsule's own ir/ tree.
test_relative_ll_under_consumer_tree() {
    [ -f "$SCRATCH/build/capsules/demo/widget/ir/src/util.ll" ]
}
run_test "relative-import .ll lands at build/capsules/demo/widget/ir/src/util.ll" test_relative_ll_under_consumer_tree

# ---- Test 4: legacy mangled paths are NOT written for manifest deps ----
# Defends against double-emission regressions: if both paths exist,
# the linker could end up consuming stale or duplicate copies.
test_no_legacy_dep_path() {
    ! [ -f "$SCRATCH/build/sailfin/capsules/sfn__math__mod.ll" ]
}
run_test "legacy build/sailfin/capsules/sfn__math__mod.ll is not written" test_no_legacy_dep_path

# ---- Test 5: legacy mangled paths are NOT written for relative imports ----
# The pre-C2b2 mangling of the project_root-rooted slug
# (`<project_root>/src/util` → `<...>__src__util`) must no longer
# appear under `build/sailfin/capsules/`.
test_no_legacy_relative_path() {
    # No file at any well-known mangled name for `./util`.
    ! [ -f "$SCRATCH/build/sailfin/capsules/src__util.ll" ] || return 1
    ! [ -f "$SCRATCH/build/sailfin/capsules/util.ll" ]
}
run_test "no legacy build/sailfin/capsules/...util.ll is written" test_no_legacy_relative_path

# ---- Test 6: build_report dep_ll_paths reflects per-capsule tree ----
test_report_paths_canonical() {
    local report="$SCRATCH/build.json"
    local found_dep=0 found_rel=0 missing=0
    while IFS= read -r path; do
        [ -z "$path" ] && continue
        if [ ! -f "$SCRATCH/$path" ]; then
            echo "[test]   missing report dep .ll: $path" >&2
            missing=1
        fi
        case "$path" in
            build/capsules/sfn/math/ir/*.ll) found_dep=1 ;;
            build/capsules/demo/widget/ir/*.ll) found_rel=1 ;;
        esac
    done < <(jq -r '.deps.ll_paths[]' "$report")
    [ "$missing" -eq 0 ] && [ "$found_dep" -eq 1 ] && [ "$found_rel" -eq 1 ]
}
run_test "build report dep_ll_paths covers both dep + relative tree" test_report_paths_canonical

# ---- Test 7: sidecar dep_ll_paths reflects per-capsule tree ----
test_sidecar_paths_canonical() {
    [ -f "$SIDECAR" ] || return 1
    local found_dep=0 found_rel=0 missing=0
    while IFS= read -r path; do
        [ -z "$path" ] && continue
        if [ ! -f "$SCRATCH/$path" ]; then
            echo "[test]   missing sidecar dep .ll: $path" >&2
            missing=1
        fi
        case "$path" in
            build/capsules/sfn/math/ir/*.ll) found_dep=1 ;;
            build/capsules/demo/widget/ir/*.ll) found_rel=1 ;;
        esac
    done < <(jq -r '.deps.ll_paths[]' "$SIDECAR")
    [ "$missing" -eq 0 ] && [ "$found_dep" -eq 1 ] && [ "$found_rel" -eq 1 ]
}
run_test "sidecar dep_ll_paths covers both dep + relative tree" test_sidecar_paths_canonical

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
