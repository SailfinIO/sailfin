#!/usr/bin/env bash
# detect_build_jobs.sh — Pick a sensible BUILD_JOBS default for the current host.
#
# Heuristic: min(nproc, total_ram_gb / 2). The ~2 GB-per-job budget reflects
# the post-split heaviest modules:
#   * lowering_core.sfn        : 1594 MB peak RSS (was 4700 MB pre-arena,
#                                2350 MB post-arena pre-split)
#   * parser/declarations.sfn  : 1759 MB peak RSS (next-worst, unsplit)
#   * lowering_helpers.sfn     : 1292 MB peak RSS (post seed-default-runtime
#                                helpers extraction)
# At 2 GB-per-job, two concurrent worst-case modules peak at ~3.5 GB, which
# fits comfortably under the 7 GB total RAM ceiling on the macOS GitHub
# runner (M1) with the OS + Actions agent overhead.
#
# Pre-April-25 the divisor was 5 GB-per-job, sized to fit the pre-split
# 4.7 GB lowering_core peak. That gave macOS 7/5 → BUILD_JOBS=1 (no
# parallelism). The April 25 lowering_core split (commits 072bea1 +
# cd34d14) cleared the per-module gate; this script's divisor change is
# what actually flips macOS to BUILD_JOBS=2 in CI.
#
# macOS additionally caps at 2 jobs because anything higher would still
# overcommit the 7 GB total RAM ceiling once you account for compile +
# clang + link overhead and the parent xargs process tree.
#
# Falls back to 1 on:
#   - hosts where nproc / sysctl / /proc/meminfo are not readable
#   - Windows (MSYS / Cygwin / Git Bash) — xargs -P parallelism is unreliable
#     under the various Windows shell wrappers
#
# Override at the call site by exporting BUILD_JOBS=N before invoking make.
# See docs/build-performance.md → Phase 6 for rationale.

set -eu

uname_s="$(uname -s 2>/dev/null || echo unknown)"
cores=1
mem_gb=0

case "$uname_s" in
    Linux*)
        cores=$(nproc 2>/dev/null || getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)
        mem_kb=$(awk '/^MemTotal:/ {print $2; exit}' /proc/meminfo 2>/dev/null || echo 0)
        mem_gb=$((mem_kb / 1024 / 1024))
        ;;
    Darwin*)
        cores=$(sysctl -n hw.ncpu 2>/dev/null || echo 1)
        mem_b=$(sysctl -n hw.memsize 2>/dev/null || echo 0)
        mem_gb=$((mem_b / 1024 / 1024 / 1024))
        ;;
esac

# Sanitize: a non-numeric or zero result falls back to safe defaults.
[ "$cores" -gt 0 ] 2>/dev/null || cores=1
[ "$mem_gb" -gt 0 ] 2>/dev/null || mem_gb=4

# Apply the per-job memory budget. ~2 GB per job; see the header comment
# for the per-module RSS data this divisor is sized against.
by_mem=$((mem_gb / 2))
[ "$by_mem" -lt 1 ] && by_mem=1

jobs=$cores
[ "$by_mem" -lt "$jobs" ] && jobs=$by_mem

# Per-platform ceilings.
case "$uname_s" in
    Darwin*)
        [ "$jobs" -gt 2 ] && jobs=2
        ;;
    MINGW*|MSYS*|CYGWIN*)
        jobs=1
        ;;
esac

# Global upper bound. Matches the [1, 8] contract documented in
# docs/build-performance.md → Phase 6. Without this, a 32-core / 256 GB
# workstation would emit 32 — well past the point of diminishing returns
# for a 121-module build, and risks I/O contention plus llvm-link
# memory pressure dominating wall-time.
[ "$jobs" -gt 8 ] && jobs=8

[ "$jobs" -lt 1 ] && jobs=1

echo "$jobs"
