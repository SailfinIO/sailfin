#!/usr/bin/env bash
# scripts/check-examples.sh
#
# Examples regression sweep (epic #549). Runs every runnable `.sfn` under
# examples/ through `sfn check` and `sfn run`, capturing stdout/stderr/exit
# separately so "exits 0 but prints nothing" is distinguishable from a real
# pass. Prints a per-file table and a summary.
#
# CI ratchet: the KNOWN_FAILING list below enumerates runnable examples that
# do not PASS yet (each tied to its tracking issue). Epic #549 — which restored
# this sweep and fixed the compiler bugs it surfaced — is closed; the entries
# that remain are gated on unshipped language features, not open #549 bugs, and
# are tracked in #1883. The script gates CI as follows:
#   - a NON-listed runnable example that fails  -> REGRESSION -> exit 1
#   - a listed example that now PASSES          -> XPASS      -> exit 1
#     (a good problem: the gate landed; remove it from KNOWN_FAILING)
#   - a listed example that still fails          -> XFAIL      -> tolerated
# This keeps the marketed example surface guarded now, while the remaining
# gated examples graduate one at a time as their features ship (#1883).
#
# Two files are intentionally not run:
#   - basics/tests.sfn  — no `main`; exercised by `sfn test`.
#   - the blocking-server web examples — `sfn run` never returns (Category 8
#     in #549); they need a spawn/probe/kill harness, tracked separately.
#
# Usage:
#   scripts/check-examples.sh            # sweep, human-readable table
#   SAILFIN_BIN=path scripts/check-examples.sh
#   scripts/check-examples.sh --tsv      # machine-readable TSV to stdout

set -u

SAILFIN_BIN="${SAILFIN_BIN:-build/bin/sfn}"
TIMEOUT="${SAILFIN_EXAMPLES_TIMEOUT:-25}"
TSV=0
[ "${1:-}" = "--tsv" ] && TSV=1

if [ ! -x "$SAILFIN_BIN" ]; then
    echo "error: compiler not found at $SAILFIN_BIN (run 'make compile')" >&2
    exit 2
fi

# Files that have no `main` or block forever — not runnable via `sfn run`.
SKIP_RUN=(
    "examples/basics/tests.sfn"
    "examples/web/http-server.sfn"
    "examples/web/rest-api.sfn"
    "examples/web/websocket-chat.sfn"
    "examples/advanced/web-server-with-concurrency.sfn"
    # Non-terminating: an infinite `loop { await buffer.receive() }` consumer,
    # so `sfn run` never returns (like the blocking servers). A bounded rewrite
    # returns it to the runnable set — tracked in #1946 (epic #1883).
    "examples/concurrency/producer-consumer.sfn"
)

# Runnable examples that fail today on a feature that is not yet shipped — NOT a
# #549 compiler bug (all of those closed via #1835–#1839). Tracked in #1883;
# remove each entry when its gate lands (it will flip to XPASS and the ratchet
# will flag it).
KNOWN_FAILING=(
    "examples/advanced/generic-structures.sfn"         # static-ctor monomorphization landed (SFN-110); still gated on SFN-342 (Type<Args>{} literal) + SFN-343 (int|null interp) — epic #1883
    "examples/advanced/matrix-multiplication.sfn"      # int[]-element mappers + range HOFs — #1943 then #1945 (epic #1883)
)

in_list() {
    local needle="$1"; shift
    for x in "$@"; do [ "$needle" = "$x" ] && return 0; done
    return 1
}

pass=0 skipped=0 xfail=0
regressions=() xpasses=()

[ "$TSV" -eq 1 ] && printf "file\tstatus\tdetail\n"

emit() { # file status detail
    if [ "$TSV" -eq 1 ]; then printf "%s\t%s\t%s\n" "$1" "$2" "$3"
    else printf "  %-11s %-52s %s\n" "$2" "$1" "$3"; fi
}

# Private stderr scratch file for `run` capture — mktemp (not a predictable
# /tmp/$$ name) avoids symlink races and cross-run collisions; cleaned on exit.
err_tmp="$(mktemp "${TMPDIR:-/tmp}/sfn_ex_err.XXXXXX")" || {
    echo "error: mktemp failed" >&2; exit 2; }
trap 'rm -f "$err_tmp"' EXIT

# First non-empty line of stdin, capped — the fallback when no error/fatal line
# matched (a timeout, a missing `timeout` binary, or another wrapper failure),
# so a regression is still actionable from CI logs.
first_line() { grep -m1 . | head -c 160; }

while IFS= read -r f; do
    known=0; in_list "$f" "${KNOWN_FAILING[@]}" && known=1

    check_out="$(timeout "$TIMEOUT" "$SAILFIN_BIN" check "$f" 2>&1)"
    if [ $? -ne 0 ]; then
        detail="$(printf '%s' "$check_out" | grep -m1 -E 'error|fatal' | head -c 160)"
        [ -z "$detail" ] && detail="$(printf '%s' "$check_out" | first_line)"
        [ -z "$detail" ] && detail="check exited non-zero with no output (timeout?)"
        if [ "$known" -eq 1 ]; then xfail=$((xfail + 1)); emit "$f" "XFAIL" "check: $detail"
        else regressions+=("$f"); emit "$f" "CHECK_FAIL" "$detail"; fi
        continue
    fi

    if in_list "$f" "${SKIP_RUN[@]}"; then
        skipped=$((skipped + 1)); emit "$f" "SKIP_RUN" "check-only (no main / blocking server)"; continue
    fi

    run_out="$(timeout "$TIMEOUT" "$SAILFIN_BIN" run "$f" 2>"$err_tmp")"
    run_rc=$?
    run_err="$(cat "$err_tmp" 2>/dev/null)"

    status="PASS"; detail=""
    if [ $run_rc -ne 0 ]; then
        status="RUN_FAIL"
        detail="$(printf '%s' "$run_err" | grep -m1 -E 'error|fatal|verifier' | head -c 160)"
        [ -z "$detail" ] && detail="$(printf '%s' "$run_err" | first_line)"
        [ -z "$detail" ] && detail="exit $run_rc"
    elif [ -z "$run_out" ]; then
        status="EMPTY_OUT"; detail="exit 0 but no stdout"
    else
        detail="$(printf '%s' "$run_out" | head -1 | head -c 60)"
    fi

    if [ "$status" = "PASS" ]; then
        if [ "$known" -eq 1 ]; then xpasses+=("$f"); emit "$f" "XPASS" "now passes — remove from KNOWN_FAILING: $detail"
        else pass=$((pass + 1)); emit "$f" "PASS" "$detail"; fi
    else
        if [ "$known" -eq 1 ]; then xfail=$((xfail + 1)); emit "$f" "XFAIL" "$detail"
        else regressions+=("$f"); emit "$f" "$status" "$detail"; fi
    fi
done < <(find examples -name '*.sfn' | sort)

if [ "$TSV" -eq 0 ]; then
    echo ""
    echo "  summary: $pass PASS / ${#regressions[@]} REGRESSION / ${#xpasses[@]} XPASS / $xfail XFAIL(gated #1883) / $skipped SKIP_RUN"
fi

rc=0
if [ "${#regressions[@]}" -gt 0 ]; then
    echo "  REGRESSION: these runnable examples newly fail — fix or add to KNOWN_FAILING with an issue:" >&2
    for r in "${regressions[@]}"; do echo "    - $r" >&2; done
    rc=1
fi
if [ "${#xpasses[@]}" -gt 0 ]; then
    echo "  XPASS: these now pass — remove them from KNOWN_FAILING (the ratchet tightens):" >&2
    for x in "${xpasses[@]}"; do echo "    - $x" >&2; done
    rc=1
fi
exit $rc
