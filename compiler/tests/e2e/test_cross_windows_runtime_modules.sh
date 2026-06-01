#!/usr/bin/env bash
# Guard test (#941, Risk R4): the `ci-cross-windows` Make target emits +
# links a hardcoded list of runtime Sailfin modules (`RUNTIME_MODS`).
# That list is a copy of `runtime/native/capsule.toml`'s `sfn-sources`
# array plus its `prelude-entry`, MINUS `process.sfn` (Windows resolves
# `@sfn_process_run` from the `_WIN32` C wrapper in `sailfin_runtime.c`,
# so linking the Sailfin object too would duplicate the symbol).
#
# If a future change adds/removes a runtime `sfn-source` in the manifest
# but forgets to update the cross-windows loop, the Windows bridge would
# silently drop (or double-link) a runtime module. This static check
# fails the build the moment the two drift.
#
# Usage: test_cross_windows_runtime_modules.sh <compiler-binary>
#   (the binary arg is accepted for harness uniformity but unused — this
#    is a pure source-consistency check.)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
MANIFEST="$REPO_ROOT/runtime/native/capsule.toml"
MAKEFILE="$REPO_ROOT/Makefile"
PASS=0
FAIL=0

ok() {
    echo "[test] PASS: $1"
    PASS=$((PASS + 1))
}
fail() {
    echo "[test] FAIL: $1"
    FAIL=$((FAIL + 1))
}

[ -f "$MANIFEST" ] || { echo "[test] missing $MANIFEST" >&2; exit 1; }
[ -f "$MAKEFILE" ] || { echo "[test] missing $MAKEFILE" >&2; exit 1; }

# Normalize a manifest-relative path (`../sfn/...`, relative to
# runtime/native/) to a repo-root-relative path (`runtime/sfn/...`).
norm() { sed -E 's#^\.\./#runtime/#'; }

# --- Manifest: sfn-sources (single-line array) + prelude-entry ---
sfn_line="$(grep -E '^sfn-sources[[:space:]]*=' "$MANIFEST" | head -n1 || true)"
prelude_line="$(grep -E '^prelude-entry[[:space:]]*=' "$MANIFEST" | head -n1 || true)"
[ -n "$sfn_line" ] || fail "no sfn-sources line in manifest"
[ -n "$prelude_line" ] || fail "no prelude-entry line in manifest"

sfn_vals="$(echo "$sfn_line" \
    | sed -E 's/^[^[]*\[//; s/\].*$//' \
    | tr ',' '\n' \
    | sed -E 's/[[:space:]]//g; s/"//g' \
    | grep -v '^$' || true)"
prelude_val="$(echo "$prelude_line" \
    | sed -E 's/^[^=]*=//; s/[[:space:]]//g; s/"//g')"

# Expected cross-windows source set: prelude-entry + every sfn-source,
# minus process.sfn, normalized to repo-relative paths.
expected="$( { echo "$prelude_val"; echo "$sfn_vals"; } \
    | norm \
    | grep -v '^runtime/sfn/process\.sfn$' \
    | grep -v '^$' \
    | sort -u )"

# --- Makefile: RUNTIME_MODS source paths (the part after each `:`) ---
mods_line="$(grep -E 'RUNTIME_MODS="' "$MAKEFILE" | head -n1 || true)"
[ -n "$mods_line" ] || fail "no RUNTIME_MODS assignment in Makefile"
mods_val="$(echo "$mods_line" | sed -E 's/^[^"]*"//; s/".*$//')"
actual="$(echo "$mods_val" \
    | tr ' ' '\n' \
    | sed -E 's/^[^:]*://' \
    | grep -v '^$' \
    | sort -u )"

if [ "$expected" = "$actual" ]; then
    ok "cross-windows RUNTIME_MODS matches manifest sfn-sources (+prelude, -process)"
else
    fail "cross-windows RUNTIME_MODS drifted from manifest sfn-sources"
    echo "--- expected (manifest +prelude-entry -process) ---"
    echo "$expected"
    echo "--- actual (Makefile RUNTIME_MODS) ---"
    echo "$actual"
    echo "--- diff (expected vs actual) ---"
    diff <(echo "$expected") <(echo "$actual") || true
fi

# The process.sfn exclusion must stay meaningful: it must be in the
# manifest, and it must NOT be linked by cross-windows.
if echo "$sfn_vals" | norm | grep -q '^runtime/sfn/process\.sfn$'; then
    ok "process.sfn present in manifest sfn-sources (exclusion is meaningful)"
else
    fail "process.sfn no longer in manifest — revisit the cross-windows exclusion"
fi
if echo "$actual" | grep -q '^runtime/sfn/process\.sfn$'; then
    fail "process.sfn is in RUNTIME_MODS — would duplicate the _WIN32 C @sfn_process_run"
else
    ok "process.sfn excluded from cross-windows RUNTIME_MODS"
fi

echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
