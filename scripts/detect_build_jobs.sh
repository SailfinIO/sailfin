#!/usr/bin/env bash
# detect_build_jobs.sh — Pick a sensible BUILD_JOBS default for the current host.
#
# Heuristic: min(nproc, total_ram_gb / 5). The 5 GB-per-job budget reflects the
# heaviest module (`lowering_core`) peaking at ~4.7 GB RSS under the arena
# allocator, plus ~300 MB headroom for staging temp files. macOS additionally
# caps at 2 jobs because the GitHub `macos-latest` runner ships with 7 GB total
# RAM (M1) — anything higher OOMs the heaviest module pair.
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

# Apply the per-job memory budget.
by_mem=$((mem_gb / 5))
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
