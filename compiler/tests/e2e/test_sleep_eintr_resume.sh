#!/usr/bin/env bash
# E2E EINTR-resume regression test for sleep() — issue #693.
#
# Pre-#693 shape (`runtime/sfn/clock.sfn` after PR #692): `sfn_sleep`
# called `nanosleep` exactly once. A signal interrupting the call
# (with a handler installed) returned `EINTR` and short-circuited the
# wait, so a user's `sleep(500)` could return in ~150 ms if the
# signal fired ~150 ms in.
#
# Post-#693 shape: the body wraps `nanosleep` in a bounded retry
# loop (cap = 32) that breaks on `ret == 0`. A signal-interrupted
# call returns non-zero, the loop re-passes the same `req`, and the
# next iteration completes the requested duration. Total elapsed
# wall-clock must therefore stay ≥ the requested duration (with a
# small jitter tolerance) even when the sleep is signalled mid-flight.
#
# Why a preload-shim:
#   POSIX `nanosleep` only returns `EINTR` if a signal is *delivered*
#   to a *handler*. Signals whose disposition is `SIG_DFL`-ignore
#   (e.g. `SIGURG`, `SIGWINCH`, `SIGCHLD`) are discarded by the
#   kernel without interrupting the syscall, and signals with no
#   default-ignore disposition (e.g. `SIGALRM`, `SIGUSR1`) terminate
#   the process unless a handler is installed first. The Sailfin
#   runtime installs handlers only for `SIGSEGV` / `SIGABRT`, and
#   Sailfin source code has no `signal()` / `sigaction()` surface yet,
#   so the only way to install a handler in the test program from
#   outside is via a preloaded shared library: a tiny shim whose
#   constructor calls `sigaction(SIGURG, noop, ...)` before `main`
#   runs and forks a child that sends `SIGURG` to the parent after
#   `SIGNAL_DELAY_MS`. The kernel then EINTR's the in-flight
#   `nanosleep` and the loop body re-issues the call.
#
#   Cross-platform shim build/load:
#     Linux  — `cc -shared -fPIC -o eintr_shim.so …`
#              run with `LD_PRELOAD=eintr_shim.so`
#     Darwin — `cc -dynamiclib -o eintr_shim.dylib …`
#              run with `DYLD_INSERT_LIBRARIES=eintr_shim.dylib`
#              and `DYLD_FORCE_FLAT_NAMESPACE=1`
#   Other platforms skip with a clear `SKIP:` line so silent
#   no-injection runs (which would pass vacuously because the
#   sleep completes without interruption) don't masquerade as
#   genuine EINTR-resume coverage.
#
# Pre-#693 verification: a stat-only verification of this shim
# without any compiler change against `build/native/sailfin` shows
# `sleep(500)` returning in ~150 ms (matching the shim's
# `usleep(150_000)`-delay-then-kill), proving the shim does inject
# EINTR. Post-#693 (this PR), the same setup yields ≥ ~500 ms — the
# loop re-issues the same `req` and completes the duration.
#
# Effects: the test program declares `![io, clock]` and runs
# unmodified — the shim is the only thing that changes between
# pre-#693 (would-fail) and post-#693 (passes) verification.
#
# Usage:
#   compiler/tests/e2e/test_sleep_eintr_resume.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_sleep_eintr_resume.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-sleep-eintr-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

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

# Sleep target. `sleep(500)` matches the issue's acceptance criterion
# wording — large enough that signal injection has a comfortable
# arrival window, small enough that the upper bound stays well
# below any CI stall.
SLEEP_MS=500

# Signal arrival relative to the start of `sleep(SLEEP_MS)`. The
# shim's child sleeps for SIGNAL_DELAY_MS then sends `SIGURG` to
# the parent. ~150 ms is far enough in that the elapsed window
# unambiguously distinguishes the pre-#693 short-circuit (~150 ms)
# from the post-#693 loop (≥ ~500 ms after re-issuing the same req).
SIGNAL_DELAY_MS=150

# Lower bound: 450 ms. Matches the issue's acceptance criterion
# (≥ 450 ms with a ~50 ms tolerance against the requested 500 ms).
# The pre-#693 short-circuit reproduces at ~150 ms — 3× below this
# bound — so the gap is huge and the test is non-flaky on jittery
# CI hardware. The post-#693 loop re-passes the same `req`, so the
# next nanosleep iteration completes the full duration.
LOWER_MS=450

# Upper bound: 30 s. Same rationale as `test_sleep_unit_semantics`:
# above any plausible scheduler / GC / CI stall, well below the
# 32 * 500 ms = 16 s the retry cap could produce under a true
# signal storm.
UPPER_MS=30000

build_eintr_shim() {
    # The shim runs in the Sailfin process before main():
    #   1. Constructor installs a SIGURG handler (noop body) so the
    #      kernel actually delivers SIGURG instead of discarding it
    #      under the default-ignore disposition.
    #   2. The constructor also forks a child that sleeps
    #      SIGNAL_DELAY_MS and then sends `SIGURG` to its parent
    #      (the Sailfin process). The child exits immediately after.
    # The Sailfin process inherits the handler, calls sleep(500),
    # and gets the SIGURG mid-syscall — that's the EINTR-resume
    # exercise.
    cat > "$SCRATCH/eintr_shim.c" <<EOF
#define _GNU_SOURCE
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdlib.h>
#include <stdio.h>

static void _noop_handler(int sig) { (void)sig; }

__attribute__((constructor))
static void _install_handler_and_arm(void) {
    struct sigaction sa;
    sa.sa_handler = _noop_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;  /* No SA_RESTART -> nanosleep will return EINTR. */
    if (sigaction(SIGURG, &sa, NULL) != 0) {
        fprintf(stderr, "[eintr-shim] sigaction failed\n");
        _exit(127);
    }
    pid_t parent = getpid();
    pid_t child = fork();
    if (child < 0) {
        fprintf(stderr, "[eintr-shim] fork failed\n");
        _exit(127);
    }
    if (child == 0) {
        /* Detach so we don't show up in the parent's wait. */
        usleep(${SIGNAL_DELAY_MS} * 1000);
        kill(parent, SIGURG);
        _exit(0);
    }
}
EOF
    local cc_flags
    case "$(uname -s)" in
        Linux)
            SHIM_PATH="$SCRATCH/eintr_shim.so"
            cc_flags="-shared -fPIC"
            ;;
        Darwin)
            # macOS uses Mach-O bundles loaded via DYLD_INSERT_LIBRARIES;
            # `-dynamiclib` is the canonical clang flag (Apple's `-shared`
            # silently produces a bundle, which works but the explicit
            # flag is clearer about intent).
            SHIM_PATH="$SCRATCH/eintr_shim.dylib"
            cc_flags="-dynamiclib"
            ;;
        *)
            return 2
            ;;
    esac
    # `-O0` keeps the constructor body intact (some compilers strip
    # observably-unused branches at higher optimization levels). The
    # shim is microscopic so the size cost is irrelevant.
    if ! cc $cc_flags -O0 -o "$SHIM_PATH" "$SCRATCH/eintr_shim.c" 2> "$SCRATCH/cc.log"; then
        echo "[test]   failed to build eintr shim:" >&2
        cat "$SCRATCH/cc.log" >&2
        return 1
    fi
    return 0
}

test_sleep_resumes_after_signal() {
    SHIM_PATH=""
    local build_rc
    build_eintr_shim
    build_rc=$?
    if [ "$build_rc" -eq 2 ]; then
        echo "[test] SKIP: sleep(N) resumes after EINTR (issue #693) — unsupported OS: $(uname -s)"
        echo "[test]   the test needs a preloaded shared library to install a SIGURG handler"
        echo "[test]   in the Sailfin process; only Linux (LD_PRELOAD) and Darwin"
        echo "[test]   (DYLD_INSERT_LIBRARIES) are supported. Skipping rather than"
        echo "[test]   running vacuously (no-injection passes against any sleep impl)."
        return 0
    fi
    if [ "$build_rc" -ne 0 ]; then
        return 1
    fi

    cat > "$SCRATCH/sleep_eintr.sfn" <<EOF
fn main() ![io, clock] {
    let start = monotonic_millis();
    sleep(${SLEEP_MS});
    let elapsed = monotonic_millis() - start;
    print("ELAPSED_MS={{elapsed}}");
}
EOF

    # Pre-compile so the start-marker arrives without compile latency
    # bleeding into the signal-timing window — `sfn run` would
    # compile on every invocation and the shim's `usleep` clock
    # would overlap with compilation, not the sleep itself.
    local exe="$SCRATCH/sleep_eintr"
    local build_log="$SCRATCH/build.log"
    if ! "$BINARY" build "$SCRATCH/sleep_eintr.sfn" -o "$exe" > "$build_log" 2>&1; then
        echo "[test]   sfn build sleep_eintr.sfn failed:" >&2
        cat "$build_log" >&2
        return 1
    fi

    local log="$SCRATCH/run.log"
    local -a preload_env
    case "$(uname -s)" in
        Linux)
            preload_env=("LD_PRELOAD=$SHIM_PATH")
            ;;
        Darwin)
            # DYLD_FORCE_FLAT_NAMESPACE=1 is required to let the
            # shim's constructor run reliably under macOS's two-level
            # namespace; without it, dyld may decline to load the
            # bundle into binaries that weren't built with
            # `-flat_namespace`.
            preload_env=(
                "DYLD_INSERT_LIBRARIES=$SHIM_PATH"
                "DYLD_FORCE_FLAT_NAMESPACE=1"
            )
            ;;
    esac
    if ! env "${preload_env[@]}" "$exe" > "$log" 2>&1; then
        echo "[test]   sleep_eintr binary exited non-zero (shim may have killed it):" >&2
        cat "$log" >&2
        return 1
    fi

    local line
    line="$(grep -E '^ELAPSED_MS=' "$log" || true)"
    if [ -z "$line" ]; then
        echo "[test]   program did not print ELAPSED_MS marker:" >&2
        cat "$log" >&2
        return 1
    fi

    local elapsed
    elapsed="${line#ELAPSED_MS=}"
    elapsed="${elapsed%%.*}"
    elapsed="${elapsed%%[eE]*}"
    if ! [[ "$elapsed" =~ ^[0-9]+$ ]]; then
        echo "[test]   ELAPSED_MS value is not an integer: '$elapsed'" >&2
        cat "$log" >&2
        return 1
    fi

    if [ "$elapsed" -lt "$LOWER_MS" ]; then
        echo "[test]   sleep(${SLEEP_MS}) returned after only ${elapsed} ms despite EINTR injection" >&2
        echo "[test]   expected ≥ ${LOWER_MS} ms — EINTR-resume loop appears broken (#693 regression)" >&2
        return 1
    fi
    if [ "$elapsed" -ge "$UPPER_MS" ]; then
        echo "[test]   sleep(${SLEEP_MS}) took ${elapsed} ms — far above upper bound, retry loop may be spinning" >&2
        return 1
    fi

    echo "[test]   sleep(${SLEEP_MS}) survived SIGURG (injected ~${SIGNAL_DELAY_MS} ms in); wall window: ${elapsed} ms"
    return 0
}

run_test "sleep(N) resumes after EINTR (issue #693)" test_sleep_resumes_after_signal

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
