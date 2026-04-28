#!/usr/bin/env bash
# End-to-end test for `sfn build --json` schema (Stage C PR1f).
#
# Verifies that:
#   - `--json` emits a single line of valid JSON to stdout
#   - the schema version is locked to "1"
#   - the cache stats reflect actual build behaviour (cold → warm)
#   - top-level fields the MCP / LSP / CI consumers depend on
#     (`exit_code`, `kind`, `input`, `out`, `compiler_version`,
#     `deps.count`, `cache.enabled`) are present
#   - no human "built: ..." or "[cache] ..." lines leak through
#     (would break consumers that line-parse stdout)
#   - `--json` and `--no-cache` compose: cache fields are still
#     emitted, with hits/misses/stores all zero
#
# If any of these schema fields drift, downstream consumers
# silently misinterpret the output — this test catches it.
#
# Usage:
#   compiler/tests/e2e/test_build_json_schema.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_build_json_schema.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

if ! command -v jq >/dev/null 2>&1; then
    echo "[test] SKIP: jq not installed (required for --json schema validation)" >&2
    exit 0
fi

SCRATCH="$(mktemp -d -t sfn-build-json-XXXXXX)"
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

mkdir -p "$SCRATCH/src"
ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "build-json-test"
version = "0.1.0"
description = "E2E test for sfn build --json"

[dependencies]
"sfn/math" = "0.1.0"

[capabilities]
required = ["io"]

[build]
entry = "src/main.sfn"
EOF

cat > "$SCRATCH/src/main.sfn" <<'EOF'
import { abs } from "sfn/math";
fn main() ![io] { print("abs=" + number_to_string(abs(-7))); }
EOF

CACHE_DIR="$SCRATCH/cache"

# ---- Test 1: cold build emits valid JSON ----
test_cold_build_emits_json() {
    cd "$SCRATCH" || return 1
    SAILFIN_BUILD_CACHE_DIR="$CACHE_DIR" "$BINARY" build --json -o build/program src/main.sfn \
        > "$SCRATCH/cold.json" 2> "$SCRATCH/cold.err"
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build --json exited with code $rc; stderr:" >&2
        cat "$SCRATCH/cold.err" >&2
        return $rc
    fi
    jq . "$SCRATCH/cold.json" > /dev/null 2>&1
}
run_test "sfn build --json emits valid JSON" test_cold_build_emits_json

# ---- Test 2: schema_version is "1" ----
test_schema_version_locked() {
    [ "$(jq -r .schema_version "$SCRATCH/cold.json")" = "1" ]
}
run_test "schema_version is '1'" test_schema_version_locked

# ---- Test 3: top-level fields present ----
test_top_level_fields() {
    [ "$(jq -r .command "$SCRATCH/cold.json")" = "build" ] || return 1
    [ "$(jq -r .kind "$SCRATCH/cold.json")" = "binary" ] || return 1
    [ "$(jq -r .exit_code "$SCRATCH/cold.json")" = "0" ] || return 1
    [ "$(jq -r .input "$SCRATCH/cold.json")" = "src/main.sfn" ] || return 1
    [ -n "$(jq -r .compiler_version "$SCRATCH/cold.json")" ] || return 1
}
run_test "top-level fields present (command/kind/exit_code/input/version)" test_top_level_fields

# ---- Test 4: cold build cache stats are miss + store ----
test_cold_cache_stats() {
    [ "$(jq -r .cache.hits "$SCRATCH/cold.json")" = "0" ] || return 1
    [ "$(jq -r .cache.misses "$SCRATCH/cold.json")" = "1" ] || return 1
    [ "$(jq -r .cache.stores "$SCRATCH/cold.json")" = "1" ] || return 1
    [ "$(jq -r .cache.enabled "$SCRATCH/cold.json")" = "true" ] || return 1
    [ -n "$(jq -r .cache.root "$SCRATCH/cold.json")" ] || return 1
}
run_test "cold build cache stats: hits=0 misses=1 stores=1 enabled=true" test_cold_cache_stats

# ---- Test 5: deps.count matches deps.ll_paths.length ----
test_deps_consistency() {
    local count
    count=$(jq -r .deps.count "$SCRATCH/cold.json")
    local len
    len=$(jq -r '.deps.ll_paths | length' "$SCRATCH/cold.json")
    [ "$count" = "$len" ] && [ "$count" -ge 1 ]
}
run_test "deps.count matches deps.ll_paths.length (>= 1)" test_deps_consistency

# ---- Test 5b: every deps.ll_paths entry exists on disk ----
# Hardens the schema test against future path-shape drift without
# locking the prefix: any path the report names must be a real
# `.ll` file the linker actually saw. Catches both stale path
# strings and dropped-but-listed dep regressions. Stage C2b2.
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
    done < <(jq -r '.deps.ll_paths[]' "$SCRATCH/cold.json")
    [ "$missing" -eq 0 ]
}
run_test "every deps.ll_paths entry is a real .ll file" test_deps_ll_paths_exist

# ---- Test 6: diagnostics is empty array (reserved for §4.11) ----
test_diagnostics_reserved() {
    [ "$(jq -r '.diagnostics | length' "$SCRATCH/cold.json")" = "0" ]
}
run_test "diagnostics array is empty (reserved slot)" test_diagnostics_reserved

# ---- Test 7: no human output leaks through stdout ----
test_no_human_output() {
    # `[cache] ...` and `built: ...` are the human-mode lines —
    # neither must appear in the JSON-mode stdout.
    if grep -qE '^\[cache\]' "$SCRATCH/cold.json"; then return 1; fi
    if grep -qE '^built:' "$SCRATCH/cold.json"; then return 1; fi
    return 0
}
run_test "no '[cache]' or 'built:' lines leak into JSON stdout" test_no_human_output

# ---- Test 8: warm build reflects cache hit ----
test_warm_cache_hit() {
    cd "$SCRATCH" || return 1
    SAILFIN_BUILD_CACHE_DIR="$CACHE_DIR" "$BINARY" build --json -o build/program src/main.sfn \
        > "$SCRATCH/warm.json" 2> "$SCRATCH/warm.err"
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        cat "$SCRATCH/warm.err" >&2
        return $rc
    fi
    jq . "$SCRATCH/warm.json" > /dev/null 2>&1 || return 1
    [ "$(jq -r .cache.hits "$SCRATCH/warm.json")" = "1" ] || return 1
    [ "$(jq -r .cache.misses "$SCRATCH/warm.json")" = "0" ] || return 1
}
run_test "warm build cache.hits=1 misses=0" test_warm_cache_hit

# ---- Test 9: --no-cache + --json composes ----
test_json_with_no_cache() {
    cd "$SCRATCH" || return 1
    SAILFIN_BUILD_CACHE_DIR="$CACHE_DIR" "$BINARY" build --json --no-cache -o build/program src/main.sfn \
        > "$SCRATCH/no_cache.json" 2> "$SCRATCH/no_cache.err"
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        cat "$SCRATCH/no_cache.err" >&2
        return $rc
    fi
    jq . "$SCRATCH/no_cache.json" > /dev/null 2>&1 || return 1
    # All cache counters should be zero — `--no-cache` skips both
    # lookup and store. `enabled` reports the runtime state.
    [ "$(jq -r .cache.hits "$SCRATCH/no_cache.json")" = "0" ] || return 1
    [ "$(jq -r .cache.misses "$SCRATCH/no_cache.json")" = "0" ] || return 1
    [ "$(jq -r .cache.stores "$SCRATCH/no_cache.json")" = "0" ] || return 1
    [ "$(jq -r .cache.enabled "$SCRATCH/no_cache.json")" = "false" ] || return 1
}
run_test "sfn build --json --no-cache: counters all zero, enabled=false" test_json_with_no_cache

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
