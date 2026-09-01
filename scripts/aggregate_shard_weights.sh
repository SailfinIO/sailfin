#!/usr/bin/env bash
# Aggregate the per-shard JSONL timing sidecars into a `shard_weights.tsv`
# candidate for the time-weighted CI shard map (SFN-863).
#
# Input is the directory `actions/download-artifact` unpacks the
# `ci-test-timing-<target>-<shard>` artifacts into: one subdirectory per
# artifact, each holding `agent-test.shard-<shard>.jsonl`.
#
# The weight is a SHARE, not a duration:
#
#   weight = round(1e6 * max over targets of (file_elapsed / suite_total))
#
# Normalising by each target's own suite total is what lets one table serve
# macos-arm64 and linux-arm64 despite their different absolute speeds; a
# raw-milliseconds table would mis-partition the slower one. The generated
# header prints each target's measured suite total so the gap is re-derived
# every refresh rather than quoted from memory (it was 1.68x on run
# 33407348555, not the ~2.4x this comment asserted for a year). Preserve the
# normalisation if you touch the formula.
#
# It does NOT make a file's weight target-invariant, and SFN-863's original
# "target-neutral by construction" wording overstated it. Measured on run
# 33407348555 (SFN-1223), the same file's share differs between the two
# targets by p10-p90 = 0.83x-1.66x, so `max over targets` selects whichever
# target gave that file the larger share of its OWN suite -- not whichever
# host is slower, which is exactly what the normalisation cancels. The
# weights are a ranking signal, not a per-file cost model -- see
# docs/measurements/e2e-shard-weights-2026-08-31.md.
#
# Each sidecar `test` row carries two distinct duration fields (SFN-1222):
#
#   duration_ms      the row's even-distribution per-test slice — the
#                     file's elapsed time divided by its test count, so it
#                     is a FRACTION of the file's cost, not the file's cost.
#   file_elapsed_ms  the file's whole elapsed wall time, stamped identically
#                     on every row belonging to that file.
#
# This script needs per-FILE cost, so it reads `file_elapsed_ms` and dedupes
# rows by path (deduping is correct precisely because the field really is
# per-file). Reading `duration_ms` here — the original bug — records one
# Nth of each file's true cost and silently produces a plausible-looking
# wrong table.
#
# Usage: aggregate_shard_weights.sh <artifacts-dir> [output-tsv]
set -euo pipefail

art_dir="${1:-}"
out="${2:-/dev/stdout}"

if [ -z "$art_dir" ] || [ ! -d "$art_dir" ]; then
    echo "usage: $0 <artifacts-dir> [output-tsv]" >&2
    exit 2
fi

# Targets are matched against a fixed list rather than split on "-", because
# both halves of `ci-test-timing-linux-arm64-e2e-a` contain dashes and a
# positional split silently mis-attributes every row.
known_targets="linux-x86_64 linux-arm64 macos-arm64"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
pairs="$tmp/pairs.tsv"
: > "$pairs"

shopt -s nullglob
found_any=0
for d in "$art_dir"/ci-test-timing-*; do
    [ -d "$d" ] || continue
    base="$(basename "$d")"
    rest="${base#ci-test-timing-}"
    target=""
    for t in $known_targets; do
        case "$rest" in
            "$t"-*) target="$t"; break ;;
        esac
    done
    if [ -z "$target" ]; then
        echo "warn: skipping artifact with unrecognized target: $base" >&2
        continue
    fi
    for f in "$d"/agent-test.shard-*.jsonl; do
        [ -f "$f" ] || continue
        found_any=1
        # One (target, path, file_elapsed_ms) row per test row; deduped below.
        sed -n 's/.*"file":"\([^"]*\)".*"file_elapsed_ms":\([0-9][0-9]*\).*/\1\t\2/p' \
            "$f" | awk -v t="$target" -F'\t' '{print t"\t"$1"\t"$2}' >> "$pairs"
    done
done

if [ "$found_any" -eq 0 ]; then
    echo "error: no timing sidecars found under $art_dir" >&2
    exit 1
fi

if [ ! -s "$pairs" ]; then
    echo "error: sidecars parsed but yielded no (target, path, file_elapsed_ms)" \
        "rows — likely cause: sidecars generated before SFN-1222 carry no" \
        "file_elapsed_ms field" >&2
    exit 1
fi

awk -F'\t' '
{
    key = $1 SUBSEP $2
    if (!((key) in seen)) {          # per-file duration, not per-test: dedupe
        seen[key] = 1
        dur[key]  = $3
        total[$1] += $3
        files[$2]  = 1
        tcount[$1]++
    }
}
END {
    for (t in total) {
        if (total[t] <= 0) {
            print "error: zero suite total for target " t " -- no tab-separated" \
                  " (path, file_elapsed_ms) rows parsed. A sed that does not" \
                  " expand backslash-t in the replacement produces this, and" \
                  " would otherwise emit a valid table with every weight 1." > "/dev/stderr"
            exit 1
        }
    }
    for (k in dur) {
        split(k, p, SUBSEP)
        t = p[1]; f = p[2]
        if (total[t] > 0) {
            share = dur[k] / total[t]
            if (share > best[f]) best[f] = share
        }
    }
    n = 0
    for (f in files) { n++; w = int(1e6 * best[f] + 0.5); if (w < 1) w = 1; out[f] = w }

    printf("# Per-file shard weights for the time-weighted CI shard map (SFN-863).\n")
    printf("# weight = round(1e6 * max over targets of (file_elapsed / suite_total)).\n")
    printf("# A share, not a duration, so one table serves macos-arm64 and linux-arm64\n")
    printf("# at different absolute speeds -- see the measured suite totals below.\n")
    printf("# NOT target-invariant per file: a given file can score differently on\n")
    printf("# each target (SFN-1223), and max-over-targets takes the larger own-suite\n")
    printf("# share. A ranking signal, not a per-file cost model.\n")
    printf("# Generated by scripts/aggregate_shard_weights.sh from ci-test-timing-* artifacts.\n")
    printf("# Targets contributing:")
    for (t in tcount) printf(" %s(%d files, %ds)", t, tcount[t], int(total[t] / 1000 + 0.5))
    printf("\n")
    printf("# An unlisted file gets the median of this table, derived at load\n")
    printf("# time by _shard_default_weight() in\n")
    printf("# compiler/src/cli/commands/test/arg_and_jobs.sfn (SFN-1224). A\n")
    printf("# missing/unparseable table falls back to the alphabetical stride.\n")
    printf("# Never fails a build.\n")
    printf("path\tweight\n")

    m = 0
    for (f in out) paths[++m] = f
    asort_n = m
    # Simple insertion sort: the table is ~900 rows and gawk asort() is not
    # guaranteed present on every runner image.
    for (i = 2; i <= asort_n; i++) {
        v = paths[i]; j = i - 1
        while (j > 0 && paths[j] > v) { paths[j+1] = paths[j]; j-- }
        paths[j+1] = v
    }
    for (i = 1; i <= asort_n; i++) printf("%s\t%d\n", paths[i], out[paths[i]])
}
' "$pairs" > "$out"
