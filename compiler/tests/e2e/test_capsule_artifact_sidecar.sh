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

# ---- Test 6: out points at the canonical per-capsule location ----
test_out_canonical() {
    # Stage C2b: `sfn build -p` (no explicit -o) writes to
    # `build/capsules/<scope>/<name>/obj/mod.o` for libraries.
    local expected="build/capsules/demo/widget/obj/mod.o"
    local out
    out=$(jq -r .out "$SIDECAR")
    [ "$out" = "$expected" ] || return 1
    # And the file actually exists on disk.
    [ -f "$SCRATCH/$expected" ]
}
run_test "out points at build/capsules/<scope>/<name>/obj/mod.o (library)" test_out_canonical

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

# ---- Test 8b: every deps.ll_paths entry exists on disk ----
# Stage C2b2 — `dep_ll_paths` strings must point at real `.ll`
# files. Hardens the schema contract without locking the prefix:
# the path shape can drift across stages, but every named entry
# must be a real, on-disk artifact with the `.ll` extension.
test_deps_ll_paths_exist() {
    local missing=0
    while IFS= read -r path; do
        [ -z "$path" ] && continue
        if [ ! -f "$SCRATCH/$path" ]; then
            echo "[test]   missing dep .ll: $path" >&2
            missing=1
        fi
        case "$path" in
            *.ll) ;;
            *)
                echo "[test]   dep_ll_paths entry doesn't end in .ll: $path" >&2
                missing=1
                ;;
        esac
    done < <(jq -r '.deps.ll_paths[]' "$SIDECAR")
    [ "$missing" -eq 0 ]
}
run_test "every deps.ll_paths entry is a real .ll file" test_deps_ll_paths_exist

# ---- Test 8c: dep .ll lives under the per-capsule tree ----
# Stage C2b2: `sfn/math` is a manifest-declared dep, so its `.ll`
# must land at `build/capsules/sfn/math/ir/mod.ll` rather than the
# legacy `build/sailfin/capsules/sfn__math__mod.ll`. Locks the
# per-capsule routing in the sidecar's view of the world.
test_dep_ll_under_per_capsule_tree() {
    local found=0
    while IFS= read -r path; do
        case "$path" in
            build/capsules/sfn/math/ir/*.ll) found=1 ;;
        esac
    done < <(jq -r '.deps.ll_paths[]' "$SIDECAR")
    [ "$found" -eq 1 ]
}
run_test "dep .ll routes under build/capsules/sfn/math/ir/ (Stage C2b2)" test_dep_ll_under_per_capsule_tree

# ---- Test 8d: modules array present + matches deps.count ----
# Stage C2c: every dep `.ll` the build produced should appear as a
# `{slug, ir_path, cache_key}` entry under `modules`. The array is
# the per-source detail companion to the aggregate `deps.ll_paths`.
test_modules_array_present() {
    local mods_count
    mods_count=$(jq -r '.modules | length' "$SIDECAR")
    [ "$mods_count" -ge 1 ] || return 1
    # Every entry must have the three locked fields as strings.
    local malformed
    malformed=$(jq -r '[.modules[] | select((.slug|type) != "string" or (.ir_path|type) != "string" or (.cache_key|type) != "string")] | length' "$SIDECAR")
    [ "$malformed" = "0" ]
}
run_test "modules array present with locked {slug, ir_path, cache_key} fields" test_modules_array_present

# ---- Test 8e: modules ir_path values exist on disk ----
# Same hardening as `dep_ll_paths` but on the per-module list:
# every `ir_path` must point at a real `.ll` file. Catches stale
# entries that name a path the build never produced.
test_modules_ir_paths_exist() {
    local missing=0
    while IFS= read -r path; do
        [ -z "$path" ] && continue
        if [ ! -f "$SCRATCH/$path" ]; then
            echo "[test]   missing module ir_path: $path" >&2
            missing=1
        fi
        case "$path" in
            *.ll) ;;
            *)
                echo "[test]   module ir_path doesn't end in .ll: $path" >&2
                missing=1
                ;;
        esac
    done < <(jq -r '.modules[].ir_path' "$SIDECAR")
    [ "$missing" -eq 0 ]
}
run_test "every modules[].ir_path is a real .ll file" test_modules_ir_paths_exist

# ---- Test 8f: modules slug uniqueness ----
# Slug collisions are detected at resolve time but a regression in
# event accumulation could produce duplicate entries here. Lock
# uniqueness so a future change can't silently double-emit.
test_modules_slugs_unique() {
    local total uniq
    total=$(jq -r '.modules | length' "$SIDECAR")
    uniq=$(jq -r '[.modules[].slug] | unique | length' "$SIDECAR")
    [ "$total" = "$uniq" ]
}
run_test "modules[].slug values are unique" test_modules_slugs_unique

# ---- Test 8g: cache_key is non-empty after a fresh cache build ----
# The default fixture build runs without `--no-cache`, so each
# module either hit or stored in the cache. Either way the digest
# is a valid sha256 hex string (non-empty). `--no-cache` is
# tested separately below.
test_modules_cache_keys_populated() {
    local empties
    empties=$(jq -r '[.modules[].cache_key | select(. == "")] | length' "$SIDECAR")
    [ "$empties" = "0" ]
}
run_test "modules[].cache_key is non-empty after a default (cached) build" test_modules_cache_keys_populated

# ---- Test 9b: -o EXPLICIT overrides the canonical default ----
test_explicit_o_wins() {
    cd "$SCRATCH" || return 1
    local explicit="$SCRATCH/build/explicit.o"
    rm -f "$explicit"
    "$BINARY" build -p . -o "$explicit" \
        > "$SCRATCH/explicit.stdout" 2>&1
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        cat "$SCRATCH/explicit.stdout" >&2
        return $rc
    fi
    # The user's explicit path wins for the actual artifact AND
    # for the sidecar's `out` field.
    [ -f "$explicit" ] || return 1
    local sidecar_out
    sidecar_out=$(jq -r .out "$SIDECAR")
    [ "$sidecar_out" = "$explicit" ]
}
run_test "-o EXPLICIT overrides the canonical default" test_explicit_o_wins

# ---- Test 10: positional `sfn build` does NOT write a sidecar ----
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

# ---- Test 11: kind = "binary" lands at <dir>/bin/<bin-name> ----
# Stage C2b1 covers BOTH library and binary canonical paths; the
# library coverage is in tests 6 + 9b above. This block exercises
# the binary path: a `[build].kind = "binary"` capsule built via
# `sfn build -p .` (no `-o`) must produce `<dir>/bin/<bin-name>`
# AND the sidecar's `out` field must point at that same path.
BIN_SCRATCH="$(mktemp -d -t sfn-capsule-artifact-bin-XXXXXX)"
# Same-shell trap: unconditionally remove BIN_SCRATCH when this
# script exits, in addition to the SCRATCH cleanup at the top.
trap 'rm -rf "$SCRATCH" "$BIN_SCRATCH"' EXIT

mkdir -p "$BIN_SCRATCH/src"
ln -s "$REPO_ROOT/capsules" "$BIN_SCRATCH/capsules"

cat > "$BIN_SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "demo/widgetcli"
version = "0.5.1"
description = "E2E fixture for the binary canonical path"

[capabilities]
required = ["io"]

[build]
kind = "binary"
entry = "src/main.sfn"
EOF

cat > "$BIN_SCRATCH/src/main.sfn" <<'EOF'
fn main() ![io] {
    print("widgetcli ok");
}
EOF

BIN_SIDECAR="$BIN_SCRATCH/build/capsules/demo/widgetcli/manifest.json"
BIN_EXPECTED_OUT="build/capsules/demo/widgetcli/bin/widgetcli"

test_binary_canonical_out() {
    cd "$BIN_SCRATCH" || return 1
    "$BINARY" build -p . > "$BIN_SCRATCH/build.stdout" 2>&1
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build -p (binary) exited with code $rc; output:" >&2
        cat "$BIN_SCRATCH/build.stdout" >&2
        return $rc
    fi
    [ -f "$BIN_SIDECAR" ] || return 1
    [ -x "$BIN_SCRATCH/$BIN_EXPECTED_OUT" ] || return 1
    [ "$(jq -r .out "$BIN_SIDECAR")" = "$BIN_EXPECTED_OUT" ] || return 1
    [ "$(jq -r .kind "$BIN_SIDECAR")" = "binary" ]
}
run_test "kind=binary lands at build/capsules/<scope>/<name>/bin/<bin-name>" test_binary_canonical_out

# ---- Test 12: produced binary actually runs ----
# Confirms the binary path isn't just metadata — clang link
# produced an executable that starts and prints the expected
# marker. Catches a future regression where the canonical path
# is reported but no real binary lands there.
test_binary_runs() {
    cd "$BIN_SCRATCH" || return 1
    [ -x "$BIN_EXPECTED_OUT" ] || return 1
    "$BIN_SCRATCH/$BIN_EXPECTED_OUT" > "$BIN_SCRATCH/run.stdout" 2>&1 || return 1
    grep -q "^widgetcli ok$" "$BIN_SCRATCH/run.stdout"
}
run_test "binary at canonical path runs and prints expected marker" test_binary_runs

echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
