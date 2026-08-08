#!/usr/bin/env bash
# detect_test_jobs.sh — Pick a sensible TEST_JOBS default for the current host.
#
# Heuristic: min(cores, (mem_mb * 66%) / 4096), floor 1, cap 16; macOS
# caps at 2.
#
# SFN-547: the budget is sized for the HEAVIEST test child, not the common
# one. The previous 384 MB-per-job divisor was sized for the light majority
# (a typical unit/integration child is ~50–80 MB RSS), which is true and
# irrelevant: the pool's peak is set by the build-and-run class, where a
# child spawning a nested `sfn build`/`sfn run`/`sfn emit` reaches the same
# weight as a compiler-module emit — the heaviest, `llvm/runtime_helpers.sfn`,
# peaks at 1.55 GB RSS (SFN-626; docs/baselines/compile-0.8.4-linux-x86_64.csv).
# Budgeting the light majority handed a 14 GB host 16 jobs and killed it
# outright. Sizing for the heavy tail costs parallelism on small hosts and
# is the only setting that cannot OOM them.
#
# The compiler's 8 GB RLIMIT_AS self-cap does NOT bound this: it caps each
# process, so N children multiply it. See .claude/rules/compiler-safety.md.
#
# 4096 MB/job is the measured cold peak of a pooled test child (3.2-4.1 GB),
# NOT the emit fan-out's figure. The reserve was 2560 MB, matched to
# `_cr_ram_budget_jobs` in compiler/src/capsule_emit_parallel.sfn on the
# reasoning that a test child can spawn exactly that emit. It can — but it
# also compiles the whole compiler dep closure in-process first, which the
# emit worker never does. Measured: `backend_failure_banner` 3,604 MB,
# `dev_det_sweep` 4,142 MB in-pool, against the 1.55 GB emit worker SFN-626
# sized 2560 from. At 2560 a 16 GB CI runner took 4 jobs and demanded
# ~20.5 GB of a 15.7 GB host, losing the VM with no OOM line (GitHub issue
# #2817); at 4096 it takes 2, measured peak 11.7 GB.
#
# Leave `_cr_ram_budget_jobs` at 2.5 GB — emit workers really are 1.55 GB.
# The twin to keep in lockstep is `_test_jobs_budget` in
# compiler/src/cli/commands/test/arg_and_jobs.sfn, which models the same
# workload as this script and carries the identical constants.
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

# Sanitize: a non-numeric or zero result falls back to safe defaults. The
# 1536 MB assumption is below one job's reserve, so an unmeasurable host
# floors to serial — matching `_test_jobs_budget`'s fail-closed branch.
[ "$cores" -gt 0 ] 2>/dev/null || cores=1
[ "$mem_mb" -gt 0 ] 2>/dev/null || mem_mb=1536

# Apply the per-job memory budget: 4096 MB per job out of a 66% slice of
# physical RAM. See the header comment for the RSS data these are sized
# against and for the native twin they must stay in lockstep with.
by_mem=$(((mem_mb * 66 / 100) / 4096))
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
