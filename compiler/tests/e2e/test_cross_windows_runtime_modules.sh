#!/usr/bin/env bash
# Guard test (#941, Risk R4): the `ci-cross-windows` Make target emits +
# links a hardcoded list of runtime Sailfin modules (`RUNTIME_MODS`).
# That list is a copy of `runtime/native/capsule.toml`'s `sfn-sources`
# array plus its `prelude-entry`, MINUS `process.sfn` (Windows resolves
# `@sfn_process_run` from the `_WIN32` C wrapper in `sailfin_runtime.c`,
# so linking the Sailfin object too would duplicate the symbol) and MINUS
# the `concurrency/*` modules (scheduler/future/channel, M4 Wave 2): they
# depend on POSIX `pthread` (`-lpthread`) which has no native Windows
# equivalent, so they are excluded from the cross-windows bridge until a
# Windows threading backend exists.
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
# minus process.sfn, the pthread-dependent concurrency/* modules, and
# platform/rlimit.sfn (its getrlimit/setrlimit libc externs do not
# exist under mingw; Windows resolves @apply_default_mem_limit from
# the strong no-op stub in runtime/native/ir/windows_stubs.ll, which
# only the cross-windows link consumes), normalized to repo-relative
# paths.
expected="$( { echo "$prelude_val"; echo "$sfn_vals"; } \
    | norm \
    | grep -v '^runtime/sfn/process\.sfn$' \
    | grep -v '^runtime/sfn/concurrency/' \
    | grep -v '^runtime/sfn/platform/rlimit\.sfn$' \
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

# The rlimit.sfn exclusion must stay meaningful too: in the manifest
# (so Linux/macOS get the real self-cap), NOT in RUNTIME_MODS (mingw
# cannot resolve its getrlimit/setrlimit externs), and the strong
# Windows stub must exist in windows_stubs.ll — which in turn must
# stay OUT of the manifest's ll-sources (it would duplicate the real
# definition on Linux/macOS).
if echo "$sfn_vals" | norm | grep -q '^runtime/sfn/platform/rlimit\.sfn$'; then
    ok "rlimit.sfn present in manifest sfn-sources (exclusion is meaningful)"
else
    fail "rlimit.sfn no longer in manifest — revisit the cross-windows exclusion"
fi
if echo "$actual" | grep -q '^runtime/sfn/platform/rlimit\.sfn$'; then
    fail "rlimit.sfn is in RUNTIME_MODS — getrlimit/setrlimit cannot resolve under mingw"
else
    ok "rlimit.sfn excluded from cross-windows RUNTIME_MODS"
fi
if grep -q 'define i32 @apply_default_mem_limit' "$REPO_ROOT/runtime/native/ir/windows_stubs.ll"; then
    ok "strong @apply_default_mem_limit stub present in windows_stubs.ll"
else
    fail "missing @apply_default_mem_limit stub in windows_stubs.ll — Windows link would break"
fi
# serve.sfn (concurrency/) is excluded from RUNTIME_MODS like the rest
# of concurrency/, but #1308 moved the legacy `sailfin_runtime_serve`
# no-op off the C runtime and into serve.sfn, so `prelude.o`'s
# reference needs the strong Windows stub. (The real typed-serve server
# `sfn_serve` is unaffected — it is never linked into cross-windows.)
if echo "$sfn_vals" | norm | grep -q '^runtime/sfn/concurrency/serve\.sfn$'; then
    ok "serve.sfn present in manifest sfn-sources (exclusion is meaningful)"
else
    fail "serve.sfn no longer in manifest — revisit the cross-windows serve stub"
fi
if echo "$actual" | grep -q '^runtime/sfn/concurrency/serve\.sfn$'; then
    fail "serve.sfn is in RUNTIME_MODS — pulls socket/scheduler externs mingw cannot resolve"
else
    ok "serve.sfn excluded from cross-windows RUNTIME_MODS"
fi
if grep -q 'define void @sailfin_runtime_serve' "$REPO_ROOT/runtime/native/ir/windows_stubs.ll"; then
    ok "strong @sailfin_runtime_serve stub present in windows_stubs.ll"
else
    fail "missing @sailfin_runtime_serve stub in windows_stubs.ll — Windows link would break (#1308)"
fi
ll_line="$(grep -E '^ll-sources[[:space:]]*=' "$MANIFEST" | head -n1 || true)"
if echo "$ll_line" | grep -q 'windows_stubs'; then
    fail "windows_stubs.ll is in ll-sources — would duplicate @apply_default_mem_limit on Linux/macOS"
else
    ok "windows_stubs.ll absent from ll-sources (cross-windows-only object)"
fi
if grep -q 'windows_stubs\.ll' "$MAKEFILE"; then
    ok "windows_stubs.ll wired into the Makefile cross-windows link"
else
    fail "windows_stubs.ll not referenced by the Makefile — Windows link would break"
fi

echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
