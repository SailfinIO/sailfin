#!/usr/bin/env bash
# End-to-end test for `sfn package` (Stage C4).
#
# Exercises both modes:
#   1. Compiler mode (no -p): produces standalone compiler tarball
#      + sha256 + manifest.json. Replaces tools/package.sh's first
#      output.
#   2. User-capsule mode (-p): packages a `demo/widget` library
#      from its C2c sidecar; tarball contains the obj artifact +
#      sidecar + capsule.toml.
#
# Locks the schema and the tarball structure. If `dist_manifest.sfn`
# or `handle_package_command` drift, this test catches it before
# the release workflow consumes a misshapen artifact.
#
# Usage:
#   compiler/tests/e2e/test_sfn_package.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_sfn_package.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

if ! command -v jq >/dev/null 2>&1; then
    echo "[test] SKIP: jq not installed (required for manifest schema validation)" >&2
    exit 0
fi
if ! command -v tar >/dev/null 2>&1; then
    echo "[test] SKIP: tar not installed (required for tarball production)" >&2
    exit 0
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SCRATCH="$(mktemp -d -t sfn-package-XXXXXX)"
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

# ---- Compiler mode: package the running compiler ----
# Run `sfn package` from the repo root so it can find
# `compiler/capsule.toml`. Output goes to a scratch dir to keep
# `dist/` (the canonical release output dir) untouched.
DIST_DIR="$SCRATCH/dist-compiler"
COMPILER_VERSION="$(sed -n 's/^version *= *"\([^"]*\)"/\1/p' "$REPO_ROOT/compiler/capsule.toml")"

test_compiler_package_succeeds() {
    cd "$REPO_ROOT" || return 1
    "$BINARY" package --out "$DIST_DIR" --compiler-bin "$BINARY" \
        > "$SCRATCH/compiler.stdout" 2> "$SCRATCH/compiler.err"
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn package exited with code $rc; stderr:" >&2
        cat "$SCRATCH/compiler.err" >&2
        return $rc
    fi
}
run_test "sfn package (compiler mode) succeeds" test_compiler_package_succeeds

# Discover the produced tarball — target is platform-dependent so
# we glob by stem.
TARBALL="$(ls "$DIST_DIR"/sailfin-native-*-"$COMPILER_VERSION".tar.gz 2>/dev/null | head -n 1)"
TARBALL_STEM="$(basename "${TARBALL%.tar.gz}")"
SHA_FILE="${TARBALL}.sha256"
MANIFEST="$DIST_DIR/${TARBALL_STEM}.manifest.json"

test_artifacts_exist() {
    [ -f "$TARBALL" ] || return 1
    [ -f "$SHA_FILE" ] || return 1
    [ -f "$MANIFEST" ] || return 1
}
run_test "tarball + sha256 + manifest.json all exist" test_artifacts_exist

test_tarball_contents() {
    # Standalone compiler tarball: only bin/sailfin and bin/sfn,
    # nested under `<root>/bin/`. Locks the structure consumers
    # of the release artifact rely on.
    local listing
    listing="$(tar -tzf "$TARBALL")"
    echo "$listing" | grep -qE "/bin/sailfin\$" || return 1
    echo "$listing" | grep -qE "/bin/sfn\$" || return 1
}
run_test "tarball contains bin/sailfin + bin/sfn" test_tarball_contents

test_sha256_sidecar_format() {
    # `.sha256` content is `<hex>\n` only — matches what
    # `tools/package.sh` produces and what the release workflow's
    # `sha256sum -c` expects (after re-attaching the filename).
    local content
    content="$(cat "$SHA_FILE")"
    # 64 hex chars optionally followed by a newline.
    [ "${#content}" -ge 64 ] || return 1
    [ "$(echo "$content" | head -c 64 | tr -d '0-9a-f')" = "" ]
}
run_test "sha256 sidecar is hex-only" test_sha256_sidecar_format

test_sha256_matches_tarball() {
    # The hex in the sidecar must match a fresh sha256 of the tarball.
    local sidecar_hex actual_hex
    sidecar_hex="$(head -c 64 "$SHA_FILE")"
    if command -v sha256sum >/dev/null 2>&1; then
        actual_hex="$(sha256sum "$TARBALL" | awk '{print $1}')"
    else
        actual_hex="$(shasum -a 256 "$TARBALL" | awk '{print $1}')"
    fi
    [ "$sidecar_hex" = "$actual_hex" ]
}
run_test "sha256 sidecar matches actual digest" test_sha256_matches_tarball

test_manifest_schema_v1() {
    # Schema version is the contract for breaking changes.
    [ "$(jq -r .schema_version "$MANIFEST")" = "1" ]
}
run_test "manifest schema_version is '1'" test_manifest_schema_v1

test_manifest_compiler_fields() {
    # Compiler-mode invariants.
    [ "$(jq -r .name "$MANIFEST")" = "sailfin-native" ] || return 1
    [ "$(jq -r .kind "$MANIFEST")" = "compiler" ] || return 1
    [ "$(jq -r .capsule "$MANIFEST")" = "sailfin" ] || return 1
    [ "$(jq -r .version "$MANIFEST")" = "$COMPILER_VERSION" ] || return 1
}
run_test "manifest carries name/kind/capsule/version" test_manifest_compiler_fields

test_manifest_size_fields() {
    # Sizes are JSON numbers > 0 for a real build.
    local bin_size tar_size
    bin_size="$(jq -r .binary_size "$MANIFEST")"
    tar_size="$(jq -r .tarball_size "$MANIFEST")"
    [ "$bin_size" -gt 0 ] || return 1
    [ "$tar_size" -gt 0 ] || return 1
}
run_test "manifest binary_size + tarball_size > 0" test_manifest_size_fields

test_manifest_target_present() {
    local target
    target="$(jq -r .target "$MANIFEST")"
    [ -n "$target" ] && [ "$target" != "null" ]
}
run_test "manifest target is non-empty" test_manifest_target_present

test_manifest_sha256_round_trips() {
    # Manifest's sha256 should match the .sha256 sidecar.
    local manifest_hex sidecar_hex
    manifest_hex="$(jq -r .sha256 "$MANIFEST")"
    sidecar_hex="$(head -c 64 "$SHA_FILE")"
    [ "$manifest_hex" = "$sidecar_hex" ]
}
run_test "manifest sha256 matches .sha256 sidecar" test_manifest_sha256_round_trips

test_manifest_build_date_iso8601() {
    # Coarse format check: YYYY-MM-DDTHH:MM:SSZ.
    local bd
    bd="$(jq -r .build_date "$MANIFEST")"
    echo "$bd" | grep -qE "^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z\$"
}
run_test "manifest build_date matches ISO-8601 UTC" test_manifest_build_date_iso8601

# ---- User-capsule mode: package a demo/widget library ----
# Mirrors the fixture used by `test_capsule_artifact_sidecar.sh`
# so we exercise the same C2c sidecar shape sfn package consumes.
WIDGET_SCRATCH="$SCRATCH/widget-fixture"
mkdir -p "$WIDGET_SCRATCH/src"
ln -s "$REPO_ROOT/capsules" "$WIDGET_SCRATCH/capsules"
cat > "$WIDGET_SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "demo/widget"
version = "0.1.0"
description = "E2E fixture for sfn package"

[dependencies]
"sfn/math" = "0.1.0"

[capabilities]
required = ["io"]

[build]
kind = "library"
entry = "src/mod.sfn"
EOF
cat > "$WIDGET_SCRATCH/src/mod.sfn" <<'EOF'
import { abs } from "sfn/math";
fn widget_abs(n: number) -> number { return abs(n); }
EOF

USER_DIST="$SCRATCH/dist-widget"

test_user_capsule_build_first() {
    cd "$WIDGET_SCRATCH" || return 1
    "$BINARY" build -p . > "$WIDGET_SCRATCH/build.stdout" 2>&1
}
run_test "sfn build -p (precondition for sfn package -p) succeeds" test_user_capsule_build_first

test_user_capsule_package_succeeds() {
    cd "$WIDGET_SCRATCH" || return 1
    "$BINARY" package -p . --out "$USER_DIST" \
        > "$WIDGET_SCRATCH/package.stdout" 2> "$WIDGET_SCRATCH/package.err"
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn package -p exited with code $rc; stderr:" >&2
        cat "$WIDGET_SCRATCH/package.err" >&2
        return $rc
    fi
}
run_test "sfn package -p (user capsule) succeeds" test_user_capsule_package_succeeds

USER_TARBALL="$(ls "$USER_DIST"/demo-widget-*.tar.gz 2>/dev/null | head -n 1)"
USER_TARBALL_STEM="$(basename "${USER_TARBALL%.tar.gz}")"
USER_MANIFEST="$USER_DIST/${USER_TARBALL_STEM}.manifest.json"

test_user_capsule_artifacts_exist() {
    [ -f "$USER_TARBALL" ] || return 1
    [ -f "${USER_TARBALL}.sha256" ] || return 1
    [ -f "$USER_MANIFEST" ] || return 1
}
run_test "user-capsule tarball + sha256 + manifest exist" test_user_capsule_artifacts_exist

test_user_capsule_tarball_contents() {
    # Library-kind tarball: obj/mod.o + manifest.json (the C2c
    # sidecar) + capsule.toml. Self-describing — the consumer can
    # introspect what they got.
    local listing
    listing="$(tar -tzf "$USER_TARBALL")"
    echo "$listing" | grep -qE "/obj/mod\.o\$" || return 1
    echo "$listing" | grep -qE "/manifest\.json\$" || return 1
    echo "$listing" | grep -qE "/capsule\.toml\$" || return 1
}
run_test "user-capsule tarball contains obj/mod.o + manifest.json + capsule.toml" test_user_capsule_tarball_contents

test_user_capsule_manifest_kind() {
    [ "$(jq -r .kind "$USER_MANIFEST")" = "library" ] || return 1
    [ "$(jq -r .capsule "$USER_MANIFEST")" = "demo/widget" ] || return 1
    [ "$(jq -r .name "$USER_MANIFEST")" = "demo-widget" ] || return 1
}
run_test "user-capsule manifest kind=library, capsule=demo/widget, name=demo-widget" test_user_capsule_manifest_kind

# ---- Error cases ----

test_missing_compiler_bin_errors() {
    cd "$REPO_ROOT" || return 1
    set +e
    "$BINARY" package --out "$SCRATCH/dist-missing" \
        --compiler-bin "$SCRATCH/does-not-exist" \
        > "$SCRATCH/missing.stdout" 2> "$SCRATCH/missing.err"
    local rc=$?
    set -e
    [ "$rc" -ne 0 ] || return 1
    grep -q "compiler binary not found" "$SCRATCH/missing.stdout"
}
run_test "missing --compiler-bin fails with clear error" test_missing_compiler_bin_errors

test_user_capsule_missing_sidecar_errors() {
    # Fresh scratch dir — `sfn build` not run, so no sidecar.
    local fresh="$SCRATCH/widget-no-build"
    mkdir -p "$fresh/src"
    cp "$WIDGET_SCRATCH/capsule.toml" "$fresh/capsule.toml"
    cp "$WIDGET_SCRATCH/src/mod.sfn" "$fresh/src/mod.sfn"
    set +e
    "$BINARY" package -p "$fresh" --out "$SCRATCH/dist-nobuild" \
        > "$SCRATCH/nobuild.stdout" 2>&1
    local rc=$?
    set -e
    [ "$rc" -ne 0 ] || return 1
    grep -q "no sidecar" "$SCRATCH/nobuild.stdout"
}
run_test "user-capsule without sidecar fails with clear error" test_user_capsule_missing_sidecar_errors

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
