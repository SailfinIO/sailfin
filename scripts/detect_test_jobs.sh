#!/usr/bin/env bash
# detect_test_jobs.sh — Pick a sensible TEST_JOBS default for the current host.
#
# Heuristic: min(cores, mem_mb / 384), floor 1, cap 16.
#
# The 384 MB-per-job budget is sized for test-runner child processes, not
# compiler-module builds. Measured child-process peak at the time of #1998:
#   * typical unit/integration test child   : ~50–80 MB RSS
#   * e2e test that spawns a nested compiler : ~150 MB RSS (heaviest class)
# The 384 MB budget gives ~2.5× headroom over the heaviest class to
# absorb e2e tests that fork nested compiler+clang trees without
# overcommitting the runner.
#
# This deliberately differs from detect_build_jobs.sh's ~2 GB-per-job budget,
# which is sized for per-module emit (heaviest module: ~1.76 GB peak RSS).
# Using BUILD_JOBS' budget for test children would under-report parallelism
# by ~5×: a 7 GB macOS runner that allows BUILD_JOBS=2 allows TEST_JOBS≈18,
# bounded further by core count.
#
# No macOS-specific ceiling: the 2-job cap in detect_build_jobs.sh exists
# because two concurrent 1.6 GB module builds overcommit a 7 GB runner.
# Test children are ~10× lighter, so the memory budget alone protects
# the macOS CI runner (7168 / 384 ≈ 18 → naturally bounded by the 3-4
# core count and the global cap of 16 anyway).
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

# Windows: xargs -P parallelism is unreliable under MSYS/Cygwin/Git Bash.
case "$uname_s" in
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
