#!/usr/bin/env bash
# End-to-end test for the per-capsule artifact sidecar (Stage C2a).
#
# Verifies that `sfn build -p <capsule-path>` writes
# `build/capsules/<scope>/<name>/manifest.json` after a successful
# build, with a schema-versioned, jq-parseable shape that downstream
# consumers (sfn package, sfn lsp, MCP tooling) can read.
#
# Schema is locked here. If `capsule_artifact.sfn`'s serializer
# drifts, this test catches it before downstream consumers do.
#
# Usage:
#   compiler/tests/e2e/test_capsule_artifact_sidecar.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_capsule_artifact_sidecar.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

if ! command -v jq >/dev/null 2>&1; then
    echo "[test] SKIP: jq not installed (required for sidecar schema validation)" >&2
    exit 0
fi

SCRATCH="$(mktemp -d -t sfn-capsule-artifact-XXXXXX)"
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

# ---- Setup: a tiny library capsule with a single export ----
# Uses the in-tree `sfn/math` as a synthetic dependency so the
# resolver has at least one dep `.ll` to record in the sidecar's
# `deps.ll_paths`. Symlink placement matches `test_capsule_build.sh`:
# the in-tree `capsules/` lives next to the consuming `capsule.toml`
# so `enumerate_capsule_sources` finds `sfn/math` at
# `<project>/capsules/sfn/math/src/`.
mkdir -p "$SCRATCH/src"
ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "demo/widget"
version = "0.4.2"
description = "E2E fixture for the per-capsule artifact sidecar"

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
fn widget_abs(n: number) -> number { return abs(n); }
EOF

# ---- Test 1: sfn build -p succeeds and writes the sidecar ----
test_sidecar_written() {
    cd "$SCRATCH" || return 1
    "$BINARY" build -p . > "$SCRATCH/build.stdout" 2>&1
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build -p exited with code $rc; output:" >&2
        cat "$SCRATCH/build.stdout" >&2
        return $rc
    fi
    [ -f "$SCRATCH/build/capsules/demo/widget/manifest.json" ]
}
run_test "sfn build -p writes build/capsules/<scope>/<name>/manifest.json" test_sidecar_written

SIDECAR="$SCRATCH/build/capsules/demo/widget/manifest.json"

# ---- Test 2: sidecar is valid JSON ----
test_sidecar_valid_json() {
    jq . "$SIDECAR" > /dev/null 2>&1
}
run_test "sidecar is valid JSON" test_sidecar_valid_json

# ---- Test 3: schema_version locked to "1" ----
test_schema_version_locked() {
    [ "$(jq -r .schema_version "$SIDECAR")" = "1" ]
}
run_test "schema_version is '1'" test_schema_version_locked

# ---- Test 4: capsule + version + kind round-trip from capsule.toml ----
test_capsule_metadata_present() {
    [ "$(jq -r .capsule "$SIDECAR")" = "demo/widget" ] || return 1
    [ "$(jq -r .version "$SIDECAR")" = "0.4.2" ] || return 1
    [ "$(jq -r .kind "$SIDECAR")" = "library" ] || return 1
}
run_test "capsule / version / kind round-trip from capsule.toml" test_capsule_metadata_present

# ---- Test 5: entry path is relative ----
test_entry_relative() {
    [ "$(jq -r .entry "$SIDECAR")" = "src/mod.sfn" ]
}
run_test "entry is relative to capsule.toml's dir" test_entry_relative

# ---- Test 6: out points at the produced object ----
test_out_present() {
    local out
    out=$(jq -r .out "$SIDECAR")
    [ -n "$out" ] || return 1
    # The library build produces a `.o` at the default path today.
    case "$out" in
        *.o) return 0 ;;
        *) return 1 ;;
    esac
}
run_test "out names a file ending in .o (library build)" test_out_present

# ---- Test 7: compiler_version is non-empty ----
test_compiler_version_present() {
    [ -n "$(jq -r .compiler_version "$SIDECAR")" ]
}
run_test "compiler_version is non-empty" test_compiler_version_present

# ---- Test 8: deps.count matches deps.ll_paths length ----
test_deps_consistency() {
    local count len
    count=$(jq -r .deps.count "$SIDECAR")
    len=$(jq -r '.deps.ll_paths | length' "$SIDECAR")
    [ "$count" = "$len" ] && [ "$count" -ge 1 ]
}
run_test "deps.count matches deps.ll_paths.length (>= 1)" test_deps_consistency

# ---- Test 9: positional `sfn build` does NOT write a sidecar ----
# The sidecar is a `-p` opt-in (we don't know the capsule name for
# positional builds). This guards against accidental drive-by sidecars.
test_positional_no_sidecar() {
    rm -rf "$SCRATCH/build/capsules"
    cd "$SCRATCH" || return 1
    "$BINARY" build src/mod.sfn -o "$SCRATCH/build/program.o" \
        > "$SCRATCH/positional.stdout" 2>&1 || true
    # Whether the build itself succeeds depends on having sfn/math
    # workspace-resolvable from this CWD; what we really need to
    # check is "no sidecar was written" regardless.
    [ ! -f "$SCRATCH/build/capsules/demo/widget/manifest.json" ]
}
run_test "positional sfn build writes no sidecar" test_positional_no_sidecar

echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
