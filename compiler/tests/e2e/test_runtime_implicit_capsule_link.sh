#!/usr/bin/env bash
# Issue #940 (Ra of #939, Phase R of #513): regression test for the
# implicit runtime-capsule link path. After Ra, `sfn build` /
# `sfn run` / `sfn test` of a binary capsule with NO `[dependencies]`
# resolve `runtime/native/capsule.toml` as an *implicit* runtime
# dependency and link via the declarative capsule path
# (c-sources + ll-sources + sfn-sources + prelude-entry), instead of
# the legacy probe ladder over `build/native/obj/runtime/*.o`.
#
# This test proves the implicit path is self-sufficient: it hides the
# Makefile-staged `build/native/obj/runtime` directory (the legacy
# path's only source of prelude/clock/process/.../mem objects) and
# asserts a program exercising fs + http + clock still builds and
# runs. With the legacy `else` branch deleted, a regression that
# stops the implicit capsule from resolving — or from emitting the
# prelude via `prelude-entry` — surfaces here as a link failure.
#
# Shape:
#   1. Hide build/native/obj/runtime (restored on EXIT, even on
#      failure — leaving it hidden would break later builds/tests).
#   2. `sfn build -o <exe>` a scratch program that references
#      fs.writeFile/fs.readFile (filesystem.sfn), sleep (clock.sfn),
#      and http.get_body (http.sfn). The http call is guarded by a
#      runtime-false branch so the symbol is linked but never fired
#      (no network needed); clang cannot prove the branch dead, so
#      the @sfn_http_get reference survives to the link.
#   3. Assert the build succeeded (no seed fallback — `sfn build`,
#      unlike `sfn run`, has none, so a real link failure is fatal).
#   4. Run the binary and assert the marker output.

set -euo pipefail

BINARY="${1:?usage: test_runtime_implicit_capsule_link.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
STAGING="$REPO_ROOT/build/native/obj/runtime"

SCRATCH="$(mktemp -d -t sfn-implicit-cap-XXXXXX)"
HIDDEN=""
restore() {
    # Restore the staging dir if we moved it aside.
    if [ -n "$HIDDEN" ] && [ -d "$HIDDEN/runtime" ]; then
        rm -rf "$STAGING"
        mv "$HIDDEN/runtime" "$STAGING"
    fi
    # Only rm non-empty paths — in the "staging already absent" case
    # HIDDEN stays empty and must not be passed to rm.
    rm -rf "$SCRATCH"
    if [ -n "$HIDDEN" ]; then
        rm -rf "$HIDDEN"
    fi
}
trap restore EXIT

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

PROG="$SCRATCH/implicit_link_prog.sfn"
cat > "$PROG" <<'EOF'
// Touches three Sailfin-native runtime modules so the link must pull
// filesystem.sfn (fs.*), clock.sfn (sleep), and http.sfn (http.*)
// out of the implicit runtime capsule. The http path is guarded by a
// branch clang cannot fold away, so @sfn_http_get is linked but the
// socket call never fires.
fn fetch(url: string) -> string ![net] {
    return http.get_body(url);
}

fn main() -> int ![io, net, clock] {
    let path = "./_sfn_implicit_marker.txt";
    fs.writeFile(path, "implicit-capsule-ok");
    let contents = fs.readFile(path);
    sleep(1);
    if contents == "this-string-never-equals-the-marker" {
        let body = fetch("http://127.0.0.1:9/");
        print(body);
    }
    print(contents);
    return 0;
}
EOF

EXE="$SCRATCH/implicit_link_prog"

hide_staging() {
    if [ ! -d "$STAGING" ]; then
        echo "[test]   no staging dir at $STAGING (already absent — test still valid)"
        return 0
    fi
    HIDDEN="$(mktemp -d -t sfn-implicit-hidden-XXXXXX)"
    mv "$STAGING" "$HIDDEN/runtime"
    return 0
}

test_build_with_staging_hidden() {
    hide_staging
    local log="$SCRATCH/build.log"
    if ! "$BINARY" build -o "$EXE" "$PROG" > "$log" 2>&1; then
        echo "[test]   sfn build failed with staging hidden:"
        cat "$log"
        return 1
    fi
    if [ ! -x "$EXE" ]; then
        echo "[test]   build reported success but no executable at $EXE"
        cat "$log"
        return 1
    fi
    return 0
}

test_run_marker_output() {
    local log="$SCRATCH/run.log"
    if ! (cd "$SCRATCH" && "$EXE" > "$log" 2>&1); then
        echo "[test]   built binary exited non-zero:"
        cat "$log"
        return 1
    fi
    if ! grep -q "implicit-capsule-ok" "$log"; then
        echo "[test]   expected marker 'implicit-capsule-ok' not in output:"
        cat "$log"
        return 1
    fi
    return 0
}

run_test "build links via implicit runtime capsule (staging hidden)" test_build_with_staging_hidden
run_test "implicit-capsule binary runs and prints marker" test_run_marker_output

echo ""
echo "═══ implicit-capsule-link: $PASS/$((PASS + FAIL)) passed, $FAIL failed ═══"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
