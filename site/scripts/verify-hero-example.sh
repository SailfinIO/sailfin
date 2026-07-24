#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
compiler="${SFN_BIN:-$repo_root/build/toolchains/seed/bin/sfn}"
fixture_dir="$repo_root/site/examples/hero-effects"
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT

if [[ ! -x "$compiler" ]]; then
  echo "hero example verification requires the released compiler at $compiler" >&2
  echo "run 'make fetch-seed' or set SFN_BIN" >&2
  exit 1
fi

version="$($compiler --version)"
if [[ "$version" != "sfn 0.8.0" ]]; then
  echo "hero example must be verified with sfn 0.8.0 (found: $version)" >&2
  exit 1
fi

# Per-step wall-clock budget for a single `sfn` invocation. Raised above the
# original 60s because the hero build intermittently stalled just past 60s on
# a loaded shared runner and was killed (exit 124), reddening unrelated PRs
# (SFN-485). Kept finite so a genuine hang is still caught, not masked.
step_timeout="${HERO_STEP_TIMEOUT:-120}"

# Run one `sfn` invocation under a wall-clock timeout, retrying once when the
# first attempt is killed by `timeout` (exit 124). The single retry absorbs the
# intermittent runner-load stall (SFN-485); a reproducible hang still fails,
# because it times out on both attempts and this returns non-zero. Any non-124
# failure (a real compile/link error) is fatal immediately, never retried.
run_step() {
  local label="$1"
  shift
  local attempt status
  for attempt in 1 2; do
    # `|| status=$?` captures the real exit code: an `if timeout ...; then` with
    # no else would report the compound's status (0) on failure, masking a hang.
    status=0
    timeout "$step_timeout" "$@" || status=$?
    if [[ "$status" -eq 0 ]]; then
      return 0
    fi
    if [[ "$status" -eq 124 && "$attempt" -eq 1 ]]; then
      echo "hero example: '$label' timed out after ${step_timeout}s (attempt 1); retrying once" >&2
      continue
    fi
    if [[ "$status" -eq 124 ]]; then
      echo "hero example: '$label' timed out after ${step_timeout}s on both attempts — treating as a real hang" >&2
    else
      echo "hero example: '$label' failed (exit $status)" >&2
    fi
    return "$status"
  done
}

(
  cd "$scratch"
  run_step "check hero fixture" "$compiler" check "$fixture_dir/hello.sfn"
  run_step "build hero fixture" "$compiler" build -o "$scratch/hello" "$fixture_dir/hello.sfn"
)
actual_output="$($scratch/hello)"
[[ "$actual_output" == "Hello, Sailfin!" ]] || {
  printf 'unexpected hero output: %q\n' "$actual_output" >&2
  exit 1
}

# The negative fixture must FAIL to compile, so `check` returning non-zero is
# the success path here. Capture the exit code explicitly to distinguish the
# expected diagnostic failure from a timeout (exit 124): a hang must surface as
# a clear failure, not be mistaken for the expected compile error (SFN-485).
negative_status=0
(cd "$scratch" && timeout "$step_timeout" "$compiler" check "$fixture_dir/hello_missing_effect.sfn") \
  >"$scratch/negative.log" 2>&1 || negative_status=$?
if [[ "$negative_status" -eq 0 ]]; then
  echo "missing-effect fixture unexpectedly passed" >&2
  exit 1
fi
if [[ "$negative_status" -eq 124 ]]; then
  echo "hero example: negative fixture check timed out after ${step_timeout}s" >&2
  exit 1
fi
grep -q 'E0400' "$scratch/negative.log"
grep -q 'missing required effects: !\[io.console\]' "$scratch/negative.log"

echo "hero example verified with sfn 0.8.0"
