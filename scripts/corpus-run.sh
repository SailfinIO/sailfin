#!/usr/bin/env bash
# scripts/corpus-run.sh
#
# Nightly corpus run (SFN-92, SFEP-0037 §3.4). Compiles the in-tree corpus
# (examples/, benchmarks/runtime/, capsules/) with BOTH the candidate
# (freshly self-hosted) compiler and the pinned seed, records per-entry
# verdict triples (check / build / run), and fails on any regression or
# check/build disagreement. Prior art: Rust's crater, Swift's
# source-compatibility suite — whole-program compilation over a real-code
# corpus with the previous compiler as the oracle.
#
# The three failure legs (SFN-92 scope):
#   (a) REGRESSION — the seed accepts an entry at some stage but the
#       candidate rejects it. The seed is the oracle: a stage where
#       seed=pass and candidate=fail is a candidate regression. Language
#       gaps where BOTH fail identically are not regressions (this is why
#       the diff is symmetric rather than an absolute expected-status list).
#   (b) CHECK/BUILD DISAGREEMENT — a candidate entry whose `sfn check` is
#       green but whose `sfn build` is red (the #1386/#1389 invariant,
#       asserted corpus-wide). Static analysis models no codegen/link, so
#       a build-only failure can pass `check` (CLAUDE.md validation ladder).
#       Known frontend-ahead-of-backend entries (examples/README.md) are
#       allowlisted in KNOWN_BUILD_RED, each tied to a tracking issue; a
#       NON-listed disagreement fails, and a listed entry that starts
#       building (XPASS) also fails so the ratchet tightens.
#   (c) FMT INSTABILITY — a corpus file that is not at the candidate
#       formatter's fixed point (`sfn fmt --check` red, i.e. fmt(x) != x).
#       This implies the scope's fmt(fmt(x)) == fmt(x) idempotence and also
#       catches a hand-mangled file.
#
# A machine-readable JSON summary (SUMMARY_JSON, default
# build/corpus-run.json) names the exact entries so a failing run is
# agent-legible (SFEP-0014). No silent skips: every walked entry appears in
# the summary with its classification and the reason a stage was not run.
#
# Memory/timeout discipline (.claude/rules/compiler-safety.md): the compiler
# self-caps memory (8 GiB RLIMIT_AS on Linux) — this script never sets
# SAILFIN_MEM_LIMIT=unlimited. Each compiler invocation is wrapped with
# `timeout $PER_ENTRY_TIMEOUT` (default 60s) as a hang guard.
#
# Usage:
#   scripts/corpus-run.sh                      # full corpus, candidate vs seed
#   SAILFIN_BIN=path SAILFIN_SEED_BIN=path scripts/corpus-run.sh
#   scripts/corpus-run.sh --roots "examples benchmarks/runtime" --capsules capsules
#   scripts/corpus-run.sh --roots /scratch/drill --capsules -   # a scratch drill
#   scripts/corpus-run.sh --no-seed            # skip the regression leg (local)
#   SUMMARY_JSON=out.json scripts/corpus-run.sh --json out.json

set -u

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
SAILFIN_BIN="${SAILFIN_BIN:-build/bin/sfn}"
SAILFIN_SEED_BIN="${SAILFIN_SEED_BIN:-build/toolchains/seed/bin/sfn}"
PER_ENTRY_TIMEOUT="${PER_ENTRY_TIMEOUT:-60}"
SUMMARY_JSON="${SUMMARY_JSON:-build/corpus-run.json}"
CORPUS_ROOTS="${CORPUS_ROOTS:-examples benchmarks/runtime}"
CORPUS_CAPSULES="${CORPUS_CAPSULES:-capsules}"
USE_SEED=1

while [ $# -gt 0 ]; do
    case "$1" in
        --roots) CORPUS_ROOTS="$2"; shift 2 ;;
        --capsules) CORPUS_CAPSULES="$2"; shift 2 ;;
        --json) SUMMARY_JSON="$2"; shift 2 ;;
        --no-seed) USE_SEED=0; shift ;;
        --timeout) PER_ENTRY_TIMEOUT="$2"; shift 2 ;;
        -h|--help) grep -E '^#( |$)' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *) echo "corpus-run: unknown argument '$1'" >&2; exit 2 ;;
    esac
done
[ "$CORPUS_CAPSULES" = "-" ] && CORPUS_CAPSULES=""

if [ ! -x "$SAILFIN_BIN" ]; then
    echo "corpus-run: candidate compiler not found at $SAILFIN_BIN (run 'make compile')" >&2
    exit 2
fi
if [ "$USE_SEED" -eq 1 ] && [ ! -x "$SAILFIN_SEED_BIN" ]; then
    echo "corpus-run: seed compiler not found at $SAILFIN_SEED_BIN (run 'make fetch-seed'); pass --no-seed to skip the regression leg" >&2
    exit 2
fi

# ---------------------------------------------------------------------------
# Classification lists (mirrors scripts/check-examples.sh, the reviewed
# corpus classifier). Keep the two in sync when the runnable set changes.
# ---------------------------------------------------------------------------

# Entries with a `main` that must NOT be run (never terminate, or need a
# network/socket the runner lacks). They are still built; only the run leg
# is skipped, with the reason recorded.
NO_RUN=(
    "examples/basics/tests.sfn"                          # no main-style entry; exercised by `sfn test`
    "examples/web/http-server.sfn"                       # blocking server (`serve` never returns)
    "examples/web/rest-api.sfn"                          # blocking server
    "examples/web/websocket-chat.sfn"                    # blocking server
    "examples/web/async.sfn"                             # net handler; no bound run in CI
    "examples/web/fetch-data.sfn"                        # net client; no network in CI
    "examples/advanced/web-server-with-concurrency.sfn"  # blocking server + net
    "examples/concurrency/producer-consumer.sfn"         # non-terminating consumer loop (#1946)
)

# Frontend-ahead-of-backend: `sfn check` passes but `sfn build` fails today
# because LLVM lowering cannot resolve a callee return type for a method call
# on a range/collection or a net response — the backend abstraction is still
# pending (generic collection methods over ranges, first-class HOFs, typed
# net-response methods; draft-generic-constraints.md, epic #1609). This is the
# expected, tolerated check-green/build-red set (examples/README.md
# "Frontend-ahead-of-backend"). Each is a stable language gap, not a compiler
# regression (the seed fails identically, so leg (a) stays silent); tracked in
# epic #1883. The list is calibrated to the candidate's actual build verdicts,
# not README prose — remove an entry when its gate lands (it flips to XPASS and
# the ratchet flags it). Keep it in sync with scripts/check-examples.sh.
KNOWN_BUILD_RED=(
    "examples/advanced/web-server-with-concurrency.sfn"  # net response method lowering — epic #1883
    "examples/concurrency/dynamic-task-scheduling.sfn"   # typed channel then live await — #1942/#1944
    "examples/web/rest-api.sfn"                          # `res.send` return-type lowering — epic #1883
)

# Pre-existing non-canonical corpus files: not at the candidate formatter's
# fixed point (`sfn fmt --check` red). CI's fmt gate only covers compiler/src/
# and runtime/ (.github/workflows/ci.yml), so the corpus was never held to the
# fixed point and accumulated drift. The whole in-tree corpus was brought to the
# fixed point in SFN-379 — which also fixed the formatter's pointer/range
# spacing quirk (`*u8` was emitted as `* u8`, `0..4` as `0 .. 4`) so the
# design-stage pointer examples format canonically. The one remaining entry
# exposes a *separate* formatter bug (SFN-434): a generic type-argument list
# containing a function type — `Channel<fn() -> void>` — is not recognized as a
# generic, so `sfn fmt --write` mis-spaces it and fuses the close `>` with the
# following `=` into `>=` (the #900 miscompile class), which no longer builds.
# The file is kept in its correct hand-written form and tolerated here until
# SFN-434 lands; then this list empties. Any *other* dirty file (a new mangle or
# a newly-added unformatted entry) still fails, and this entry becoming clean
# (XPASS) also fails so the ratchet tightens when SFN-434 ships.
KNOWN_FMT_DIRTY=(
    "examples/concurrency/dynamic-task-scheduling.sfn"
)

in_list() { local n="$1"; shift; for x in "$@"; do [ "$n" = "$x" ] && return 0; done; return 1; }

# ---------------------------------------------------------------------------
# Per-invocation scratch: build outputs and a JSONL accumulator.
# ---------------------------------------------------------------------------
scratch="$(mktemp -d "${TMPDIR:-/tmp}/sfn_corpus.XXXXXX")" || { echo "corpus-run: mktemp failed" >&2; exit 2; }
records="$scratch/records.jsonl"
: > "$records"
trap 'rm -rf "$scratch"' EXIT

# Isolate the candidate and seed dependency build caches. Both compilers key
# their content-addressed cache (SFEP-0040) off a CWD-relative build stamp that
# resolves identically no matter which binary runs, and the binary SHA is mixed
# in only for `.dirty` stamps — so from the repo root they would SHARE a store
# and the seed oracle could be built from candidate-emitted dependency
# artifacts, masking a dependency-codegen regression (or manufacturing a
# spurious one). Distinct per-run $SAILFIN_BUILD_CACHE_DIR roots (the documented
# CI/sandbox override, build_cache.sfn) keep the oracle honest.
CACHE_CAND="$scratch/cache-candidate"
CACHE_SEED="$scratch/cache-seed"
mkdir -p "$CACHE_CAND" "$CACHE_SEED"

json_str() { # escape a string for JSON embedding
    local s="$1"
    s="${s//\\/\\\\}"; s="${s//\"/\\\"}"
    s="${s//$'\n'/ }"; s="${s//$'\t'/ }"; s="${s//$'\r'/}"
    printf '%s' "$s"
}

# Plain sentinel for a stage that was not attempted. Kept unquoted so the
# verdict comparisons below are exact; `jv` re-quotes it for JSON emission.
NA="n/a"

# Emit a stage verdict as a JSON value: a bare number for an exit code, or a
# quoted "n/a" for a stage that was not attempted.
jv() { case "$1" in ''|*[!0-9]*) printf '"%s"' "$1" ;; *) printf '%s' "$1" ;; esac; }

# Run one compiler subcommand under the hang-guard timeout; echo the exit
# code, discard output (verdicts are exit codes only — output-diffing is
# out of scope for SFN-92).
verdict() { # bin subcommand file [extra-args...]
    local bin="$1"; shift
    local cache="$CACHE_CAND"
    [ "$bin" = "$SAILFIN_SEED_BIN" ] && cache="$CACHE_SEED"
    SAILFIN_BUILD_CACHE_DIR="$cache" timeout "$PER_ENTRY_TIMEOUT" "$bin" "$@" >/dev/null 2>&1
    printf '%s' "$?"
}

# Emit one JSON record line for an entry.
emit_record() { # path class cand_check cand_build cand_run seed_check seed_build seed_run reason
    printf '{"path":"%s","class":"%s","candidate":{"check":%s,"build":%s,"run":%s},"seed":{"check":%s,"build":%s,"run":%s},"reason":"%s"}\n' \
        "$(json_str "$1")" "$2" "$(jv "$3")" "$(jv "$4")" "$(jv "$5")" "$(jv "$6")" "$(jv "$7")" "$(jv "$8")" "$(json_str "$9")" >> "$records"
}

# ---------------------------------------------------------------------------
# Failure accumulators
# ---------------------------------------------------------------------------
regressions=()      # seed pass, candidate fail (path:stage)
check_build_red=()  # candidate check-green/build-red, not allowlisted
xpasses=()          # allowlisted build-red that now builds green
fmt_unstable=()     # candidate `fmt --check` red, not allowlisted
fmt_xpasses=()      # allowlisted fmt-dirty that is now clean
n_entries=0 n_pass=0 n_norun=0 n_xfail=0 n_fmt_xfail=0

# ---------------------------------------------------------------------------
# Process one program entry (a .sfn with a resolvable compile unit).
#   kind: "program" (has main -> check+build[+run]) | "check-only"
# ---------------------------------------------------------------------------
process_entry() { # path kind
    local f="$1" kind="$2"
    n_entries=$((n_entries + 1))

    local cc cb cr sc sb sr reason=""
    cc="$(verdict "$SAILFIN_BIN" check "$f")"
    [ "$USE_SEED" -eq 1 ] && sc="$(verdict "$SAILFIN_SEED_BIN" check "$f")" || sc="$NA"
    cb="$NA"; cr="$NA"; sb="$NA"; sr="$NA"

    if [ "$kind" = "check-only" ]; then
        reason="check-only (no main / library entry)"
    else
        local cbin="$scratch/cand.bin" sbin="$scratch/seed.bin"
        cb="$(verdict "$SAILFIN_BIN" build -o "$cbin" "$f")"
        [ "$USE_SEED" -eq 1 ] && sb="$(verdict "$SAILFIN_SEED_BIN" build -o "$sbin" "$f")" || sb="$NA"

        # (b) candidate check-green / build-red invariant.
        if [ "$cc" = "0" ] && [ "$cb" != "0" ]; then
            if in_list "$f" "${KNOWN_BUILD_RED[@]}"; then
                n_xfail=$((n_xfail + 1)); reason="XFAIL check-green/build-red (known frontend-ahead, epic #1883)"
            else
                check_build_red+=("$f"); reason="check-green/build-red (NOT allowlisted)"
            fi
        elif [ "$cc" = "0" ] && [ "$cb" = "0" ] && in_list "$f" "${KNOWN_BUILD_RED[@]}"; then
            xpasses+=("$f"); reason="XPASS now builds — remove from KNOWN_BUILD_RED"
        fi

        # run leg: only for a candidate that built and is in the runnable set.
        if [ "$cb" = "0" ] && ! in_list "$f" "${NO_RUN[@]}"; then
            cr="$(verdict "$SAILFIN_BIN" run "$f")"
            if [ "$USE_SEED" -eq 1 ] && [ "$sb" = "0" ]; then sr="$(verdict "$SAILFIN_SEED_BIN" run "$f")"; fi
            [ -z "$reason" ] && reason="runnable"
        elif in_list "$f" "${NO_RUN[@]}"; then
            n_norun=$((n_norun + 1)); [ -z "$reason" ] && reason="build-only (blocking server / net / no bound run)"
        else
            [ -z "$reason" ] && reason="build attempted"
        fi
    fi

    # (a) regression leg: seed pass -> candidate fail, per attempted stage. A
    # stage not attempted carries the NA sentinel on both sides, so the
    # `seed==0` guard alone excludes it; the `candidate!=0 && candidate!=NA`
    # pair then suppresses a spurious run-regression when the candidate build
    # failed (cr stays NA) and only the seed reached the run stage.
    if [ "$USE_SEED" -eq 1 ]; then
        [ "$sc" = "0" ] && [ "$cc" != "0" ] && [ "$cc" != "$NA" ] && regressions+=("$f:check")
        [ "$sb" = "0" ] && [ "$cb" != "0" ] && [ "$cb" != "$NA" ] && regressions+=("$f:build")
        [ "$sr" = "0" ] && [ "$cr" != "0" ] && [ "$cr" != "$NA" ] && regressions+=("$f:run")
    fi

    [ -z "$reason" ] && reason="ok"
    [ "$cc" = "0" ] && { [ "$cb" = "0" ] || [ "$cb" = "$NA" ]; } && n_pass=$((n_pass + 1))
    emit_record "$f" "$kind" "$cc" "$cb" "$cr" "$sc" "$sb" "$sr" "$reason"
}

# A program entry declares `main` — optionally `pub` and/or `async` (the
# concurrency examples use `async fn main`). Missing `async` here silently
# classified those as check-only and never built them (a coverage false green).
has_main() { grep -qE '^[[:space:]]*(pub[[:space:]]+)?(async[[:space:]]+)?fn[[:space:]]+main[[:space:]]*\(' "$1"; }

# (c) fmt fixed-point leg. Applied to EVERY corpus .sfn file (not just the
# compile units the verdict diff walks — the scope is "any corpus file"), so
# it covers capsule internals and tests too. `fmt --check` red means the file
# is not at the formatter's fixed point (fmt(x) != x), which implies the
# scope's fmt(fmt(x)) == fmt(x) idempotence and also catches a hand-mangled
# file. Pre-existing drift is tolerated via KNOWN_FMT_DIRTY (SFN-379 ratchet).
fmt_check_file() { # path
    local f="$1"
    if [ "$(verdict "$SAILFIN_BIN" fmt --check "$f")" != "0" ]; then
        if in_list "$f" "${KNOWN_FMT_DIRTY[@]:-}"; then n_fmt_xfail=$((n_fmt_xfail + 1))
        else fmt_unstable+=("$f"); fi
    elif in_list "$f" "${KNOWN_FMT_DIRTY[@]:-}"; then
        fmt_xpasses+=("$f")
    fi
}

# ---------------------------------------------------------------------------
# Walk the corpus
# ---------------------------------------------------------------------------
echo "== corpus-run: candidate=$SAILFIN_BIN seed=$([ "$USE_SEED" -eq 1 ] && echo "$SAILFIN_SEED_BIN" || echo '(none)') =="
echo "== roots: $CORPUS_ROOTS  capsules: ${CORPUS_CAPSULES:-(none)} =="

for root in $CORPUS_ROOTS; do
    [ -d "$root" ] || { echo "corpus-run: root '$root' not found, skipping" >&2; continue; }
    while IFS= read -r f; do
        fmt_check_file "$f"
        if has_main "$f"; then process_entry "$f" "program"; else process_entry "$f" "check-only"; fi
    done < <(find "$root" -name '*.sfn' | sort)
done

# Capsules: libraries (kind = library, no main). The fmt leg covers EVERY
# capsule .sfn (internals + tests); the verdict diff is per capsule, driven by
# the declared [build] entry (which pulls in the module graph).
if [ -n "$CORPUS_CAPSULES" ] && [ -d "$CORPUS_CAPSULES" ]; then
    while IFS= read -r f; do fmt_check_file "$f"; done < <(find "$CORPUS_CAPSULES" -name '*.sfn' | sort)
    while IFS= read -r toml; do
        dir="$(dirname "$toml")"
        entry="$(awk -F'=' '/^[[:space:]]*entry[[:space:]]*=/{gsub(/[" ]/,"",$2);print $2;exit}' "$toml")"
        [ -z "$entry" ] && entry="src/mod.sfn"
        f="$dir/$entry"
        [ -f "$f" ] || { echo "corpus-run: capsule entry '$f' missing, skipping" >&2; continue; }
        process_entry "$f" "check-only"
    done < <(find "$CORPUS_CAPSULES" -name 'capsule.toml' | sort)
fi

# ---------------------------------------------------------------------------
# Write the machine-readable summary
# ---------------------------------------------------------------------------
mkdir -p "$(dirname "$SUMMARY_JSON")"
{
    printf '{\n'
    printf '  "candidate": "%s",\n' "$(json_str "$SAILFIN_BIN")"
    if [ "$USE_SEED" -eq 1 ]; then printf '  "seed": "%s",\n' "$(json_str "$SAILFIN_SEED_BIN")"
    else printf '  "seed": null,\n'; fi
    printf '  "totals": {"entries": %s, "pass": %s, "no_run": %s, "xfail_build_red": %s, "xfail_fmt_dirty": %s},\n' \
        "$n_entries" "$n_pass" "$n_norun" "$n_xfail" "$n_fmt_xfail"
    for key in regressions check_build_red xpasses fmt_unstable fmt_xpasses; do
        eval "arr=(\"\${$key[@]:-}\")"
        printf '  "%s": [' "$key"
        first=1
        for item in "${arr[@]}"; do
            [ -z "$item" ] && continue
            [ "$first" -eq 1 ] && first=0 || printf ', '
            printf '"%s"' "$(json_str "$item")"
        done
        printf '],\n'
    done
    printf '  "entries": [\n'
    # Comma-separate the JSONL records: a trailing comma on every line but the
    # last, then indent. (`paste -sd` cycles a multi-char delimiter list, which
    # mis-joins — sed keeps it a clean array.)
    [ -s "$records" ] && sed '$!s/$/,/' "$records" | sed 's/^/    /'
    printf '  ]\n}\n'
} > "$SUMMARY_JSON"

# ---------------------------------------------------------------------------
# Report + exit status
# ---------------------------------------------------------------------------
echo ""
echo "  summary: $n_entries entries / $n_pass check-pass / $n_norun build-only / $n_xfail XFAIL(build-red, #1883) / $n_fmt_xfail XFAIL(fmt-dirty, SFN-379)"
echo "  machine-readable summary: $SUMMARY_JSON"

rc=0
report_leg() { # label array...
    local label="$1"; shift
    [ "$#" -gt 0 ] && [ -n "${1:-}" ] || return 0
    echo "  $label:" >&2
    for x in "$@"; do [ -n "$x" ] && echo "    - $x" >&2; done
    rc=1
}
report_leg "REGRESSION (seed accepts, candidate rejects)" "${regressions[@]:-}"
report_leg "CHECK-GREEN/BUILD-RED (not allowlisted — the #1389 invariant)" "${check_build_red[@]:-}"
report_leg "XPASS (allowlisted build-red now builds — remove from KNOWN_BUILD_RED)" "${xpasses[@]:-}"
report_leg "FMT INSTABILITY (fmt --check red — not at formatter fixed point)" "${fmt_unstable[@]:-}"
report_leg "FMT XPASS (allowlisted fmt-dirty now clean — remove from KNOWN_FMT_DIRTY)" "${fmt_xpasses[@]:-}"

[ "$rc" -eq 0 ] && echo "  corpus-run: PASS (no regressions, no disagreements, fmt stable)"
exit $rc
