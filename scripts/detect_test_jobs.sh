#!/usr/bin/env bash
# detect_test_jobs.sh — Pick a sensible TEST_JOBS default for the current host.
#
# Heuristic: min(cores, ((mem_mb * 80%) - 5120) / 3072), floor 1, cap 16;
# macOS caps at 2.
#
# SFN-547: the budget is sized for the HEAVIEST test child, not the common
# one. The previous 384 MB-per-job divisor was sized for the light majority
# (a typical unit/integration child is ~50–80 MB RSS), which is true and
# irrelevant: the pool's peak is set by the build-and-run class. Budgeting
# the light majority handed a 14 GB host 16 jobs and killed it outright.
# Sizing for the heavy tail costs parallelism on small hosts and is the only
# setting that cannot OOM them.
#
# The compiler's 8 GB RLIMIT_AS self-cap does NOT bound this: it caps each
# process, so N children multiply it. See .claude/rules/compiler-safety.md.
#
# SFN-781 fixed two defects in the previous "2560 MB out of a 66% slice"
# form, which prescribed 4 jobs on a 16 GB / 4-core host and peaked at
# 17.26 GB tree RSS before the OOM killer took the parent:
#
#   1. 2560 MB/job was borrowed from the emit fan-out (`_cr_ram_budget_jobs`,
#      compiler/src/capsule_emit_parallel.sfn) on the theory that a test
#      child's peak is the nested emit it spawns. It is not — a pooled
#      `--no-test-cache` test child measures 2.63–3.08 GB steady-state
#      against the 1.55 GB emit worker SFN-626 sized that figure from.
#      The divisor is now 3072 MB, the top of the measured band.
#   2. The parent runner was not a term at all — only implicitly covered by
#      the 34% remainder, which also had to absorb clang/llvm-link and the
#      OS. It is the largest single process in the tree (3.65–4.85 GB) and
#      so always the OOM victim: `_run_multi_file` compiles the whole
#      dependency closure in-process before fanning out. It is now an
#      explicit 5120 MB subtrahend.
#
# The slice rose 66% -> 80% *because* the parent became explicit; keeping 66%
# would double-count it and prescribe serial on a host that comfortably runs
# two jobs. The remaining 20% covers the grandchildren, the OS, and page
# cache.
#
# These constants are therefore deliberately NO LONGER equal to the emit
# fan-out's, and must not be re-unified — they are sized against different
# workloads, and SFN-781 scoped `_cr_ram_budget_jobs` explicitly out.
# `_test_jobs_budget` in compiler/src/cli/commands/test/arg_and_jobs.sfn is
# the native twin of this script and carries the identical constants; keep
# the two in lockstep.
#
# That lockstep is exact only because of how these particular constants land.
# The native twin divides bytes; this script divides whole MB, so the two
# agree at every input only while both reserves are whole MiB *and* the slice
# maps them onto whole-MiB thresholds — at 80%, the job-N threshold is
# (6400 + 3840N) MiB exactly, so this script's truncation loses nothing.
# Change the slice to 75%, or a reserve to 4.5 GiB, and the two forms
# separate, silently disagreeing by one job in narrow RAM windows.
# Re-derive that boundary before editing either constant — SFN-794's
# compiler/tests/integration/test_jobs_budget_parity_test.sfn drives both
# forms over one shared table and fails on a one-sided edit, and pins the
# exact-MiB step points that make this script's truncation lossless.
#
# macOS additionally caps at 2 jobs, mirroring detect_build_jobs.sh. On the
# memory-constrained macOS runner (~7 GB) the memory budget alone let enough
# heavy children coincide to tip the pool into OOM: the macOS-arm64 nightly
# self-host check kept aborting with exit 134 / SIGABRT in the e2e phase,
# the victim test roaming run to run (SFN-87). A flat 2-job cap bounds the
# concurrent-heavy-compile peak the same way BUILD_JOBS=2 does; Linux is
# unaffected and an explicit TEST_JOBS=N still wins.
#
# Cap 16: the runner's --jobs parameter accepts [1, 256] but the
# sliding-window pool has diminishing returns past core count; 16 matches
# the workflow cap used elsewhere in CI.
#
# Falls back to 1 on:
#   - hosts where nproc / sysctl / /proc/meminfo are not readable
#   - Windows (MSYS / Cygwin / Git Bash) — xargs -P parallelism is unreliable
#     under the various Windows shell wrappers
#
# Override by exporting TEST_JOBS=N before invoking make. The Makefile
# honours `TEST_JOBS ?=` so an explicit env value always wins.
# See #1998 and docs/proposals/0044-test-runner-invocation-cache.md.
#
# SFN-794: host values may be injected so the lockstep above is enforced by a
# test rather than by review. The no-argument form probes the real host and is
# the only form the Makefile uses; the two- and three-argument forms feed the
# same budget arithmetic from a caller-supplied table.
#
#   detect_test_jobs.sh                            # probe this host
#   detect_test_jobs.sh <mem_mb> <cores>           # inject, assume Linux
#   detect_test_jobs.sh <mem_mb> <cores> <uname_s> # inject, incl. platform
#
# Injected values run through the identical sanitize-and-budget path below, so
# the cross-check in compiler/tests/integration/test_jobs_budget_parity_test.sfn
# exercises what the Makefile actually gets.

set -eu

usage() {
    echo "usage: detect_test_jobs.sh [mem_mb cores [uname_s]]" >&2
    exit 2
}

uname_s=unknown
cores=1
mem_mb=0

case "$#" in
    0)
        uname_s="$(uname -s 2>/dev/null || echo unknown)"
        case "$uname_s" in
            Linux*)
                cores=$(nproc 2>/dev/null || getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)
                mem_kb=$(awk '/^MemTotal:/ {print $2; exit}' /proc/meminfo 2>/dev/null || echo 0)
                mem_mb=$((mem_kb / 1024))
                ;;
            Darwin*)
                cores=$(sysctl -n hw.ncpu 2>/dev/null || echo 1)
                mem_b=$(sysctl -n hw.memsize 2>/dev/null || echo 0)
                mem_mb=$((mem_b / 1024 / 1024))
                ;;
        esac
        ;;
    2)
        mem_mb=$1
        cores=$2
        uname_s=Linux
        ;;
    3)
        mem_mb=$1
        cores=$2
        uname_s=$3
        ;;
    *) usage ;;
esac

# Sanitize: a non-numeric or zero result falls back to safe defaults. The
# 1536 MB assumption is below the parent runner's own reserve, so an
# unmeasurable host floors to serial — matching `_test_jobs_budget`'s
# fail-closed branch.
[ "$cores" -gt 0 ] 2>/dev/null || cores=1
[ "$mem_mb" -gt 0 ] 2>/dev/null || mem_mb=1536

# Apply the memory budget: reserve the parent runner off the top of an 80%
# slice of physical RAM, then divide what is left at 3072 MB per pooled
# child. See the header comment for the RSS data these are sized against and
# for the native twin they must stay in lockstep with.
usable=$((mem_mb * 80 / 100))
parent_reserve=5120
# A host that cannot seat the parent alone has no budget to divide. Mirrors
# `_test_jobs_budget`'s early return so the twins agree on small hosts.
if [ "$usable" -le "$parent_reserve" ]; then
    by_mem=1
else
    by_mem=$(((usable - parent_reserve) / 3072))
fi
[ "$by_mem" -lt 1 ] && by_mem=1

jobs=$cores
[ "$by_mem" -lt "$jobs" ] && jobs=$by_mem

# macOS caps at 2 (see header: bounds the concurrent build-and-run e2e
# peak on the ~7 GB runner, SFN-87). Windows: xargs -P parallelism is
# unreliable under MSYS/Cygwin/Git Bash.
case "$uname_s" in
    Darwin*)
        [ "$jobs" -gt 2 ] && jobs=2
        ;;
    MINGW*|MSYS*|CYGWIN*)
        jobs=1
        ;;
esac

# Global upper bound. 16 matches the workflow cap used elsewhere in CI.
# The sliding-window pool has diminishing returns past core count, and
# 16 exceeds all current CI runner core counts (Linux 4 vCPU, macOS 3).
[ "$jobs" -gt 16 ] && jobs=16

[ "$jobs" -lt 1 ] && jobs=1

echo "$jobs"
