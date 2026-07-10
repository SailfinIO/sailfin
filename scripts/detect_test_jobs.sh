#!/usr/bin/env bash
# detect_test_jobs.sh — Pick a sensible TEST_JOBS default for the current host.
#
# Heuristic: min(cores, mem_mb / 384), floor 1, cap 16; macOS caps at 2.
#
# The 384 MB-per-job budget is sized for the common test-runner child
# process, not compiler-module builds. Measured child-process peak at the
# time of #1998:
#   * typical unit/integration test child   : ~50–80 MB RSS
# The 384 MB budget gives ample headroom over that common class.
#
# This deliberately differs from detect_build_jobs.sh's ~2 GB-per-job budget,
# which is sized for per-module emit (heaviest module: ~1.76 GB peak RSS).
# Using BUILD_JOBS' budget for every test child would under-report
# parallelism by ~5× for the light majority.
#
# macOS additionally caps at 2 jobs, mirroring detect_build_jobs.sh. The
# 384 MB budget is right for the light majority but wrong for the
# build-and-run e2e class: an e2e test that spawns a nested cold
# `sfn build`/`sfn run`/`sfn emit` peaks ~1.3–1.8 GB RSS while that nested
# compile runs — the same weight class as a module build, not the ~150 MB
# once assumed here. On the memory-constrained macOS runner (~7 GB) the
# memory budget alone lets enough of those heavy children coincide to tip
# the pool into OOM: the macOS-arm64 nightly self-host check kept aborting
# with exit 134 / SIGABRT in the e2e phase, the victim test roaming run to
# run (SFN-87). A flat 2-job cap bounds the concurrent-heavy-compile peak
# the same way BUILD_JOBS=2 does; Linux is unaffected and an explicit
# TEST_JOBS=N still wins.
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

set -eu

uname_s="$(uname -s 2>/dev/null || echo unknown)"
cores=1
mem_mb=0

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

# Sanitize: a non-numeric or zero result falls back to safe defaults.
[ "$cores" -gt 0 ] 2>/dev/null || cores=1
[ "$mem_mb" -gt 0 ] 2>/dev/null || mem_mb=1536

# Apply the per-job memory budget. 384 MB per job; see the header comment
# for the per-child RSS data this divisor is sized against.
by_mem=$((mem_mb / 384))
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
