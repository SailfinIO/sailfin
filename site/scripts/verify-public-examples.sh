#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
compiler="${SFN_BIN:-$repo_root/build/toolchains/seed/bin/sfn}"
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT
expected_version="$(
  awk '
    /^\[[^]]+\]/ { section=$0 }
    section == "[seed]" && /^version[[:space:]]*=/ {
      gsub(/"/, "", $3)
      print $3
      exit
    }
  ' "$repo_root/bootstrap.toml"
)"

if [[ -z "$expected_version" ]]; then
  echo "public example verification could not resolve bootstrap.toml [seed].version" >&2
  exit 1
fi

if [[ ! -x "$compiler" ]]; then
  echo "public example verification requires the released compiler at $compiler" >&2
  echo "run 'sfn dev bootstrap fetch' or set SFN_BIN" >&2
  exit 1
fi

version="$($compiler --version)"
if [[ "$version" != "sfn $expected_version" ]]; then
  echo "public examples must be verified with sfn $expected_version (found: $version)" >&2
  exit 1
fi

# Per-step wall-clock budget for a single `sfn` invocation. Raised above the
# original 60s because a public-example build intermittently stalled just past 60s on
# a loaded shared runner and was killed (exit 124), reddening unrelated PRs
# (SFN-485). Kept finite so a genuine hang is still caught, not masked.
step_timeout="${PUBLIC_EXAMPLE_STEP_TIMEOUT:-${HERO_STEP_TIMEOUT:-120}}"

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
      echo "public examples: '$label' timed out after ${step_timeout}s (attempt 1); retrying once" >&2
      continue
    fi
    if [[ "$status" -eq 124 ]]; then
      echo "public examples: '$label' timed out after ${step_timeout}s on both attempts — treating as a real hang" >&2
    else
      echo "public examples: '$label' failed (exit $status)" >&2
    fi
    return "$status"
  done
}

verify_positive() {
  local label="$1"
  local source="$2"
  local expected_output="$3"
  local output="$scratch/${label//[^a-zA-Z0-9]/_}"

  (
    cd "$scratch"
    run_step "check $label" "$compiler" check "$source"
    run_step "build $label" "$compiler" build -o "$output" "$source"
  )
  actual_output="$("$output")"
  if [[ "$actual_output" != "$expected_output" ]]; then
    printf 'public examples: unexpected %s output: %q\n' "$label" "$actual_output" >&2
    exit 1
  fi
}

verify_negative() {
  local label="$1"
  local source="$2"
  local diagnostic_fragment="$3"
  local log="$scratch/${label//[^a-zA-Z0-9]/_}.log"
  local status=0

  # A negative fixture must FAIL to compile. Capture the exit code explicitly
  # so a timeout cannot be mistaken for the expected diagnostic (SFN-485).
  (cd "$scratch" && timeout "$step_timeout" "$compiler" check "$source") \
    >"$log" 2>&1 || status=$?
  if [[ "$status" -eq 0 ]]; then
    echo "public examples: $label unexpectedly passed" >&2
    exit 1
  fi
  if [[ "$status" -eq 124 ]]; then
    echo "public examples: $label timed out after ${step_timeout}s" >&2
    exit 1
  fi
  if ! grep -q 'E0400' "$log"; then
    echo "public examples: $label did not emit stable diagnostic E0400" >&2
    sed -n '1,80p' "$log" >&2
    exit 1
  fi
  if ! grep -Fq "$diagnostic_fragment" "$log"; then
    echo "public examples: $label did not mention '$diagnostic_fragment'" >&2
    sed -n '1,80p' "$log" >&2
    exit 1
  fi
}

verify_positive \
  "homepage hero" \
  "$repo_root/site/examples/hero-effects/hello.sfn" \
  "Hello, Sailfin!"
verify_negative \
  "homepage missing-effect fixture" \
  "$repo_root/site/examples/hero-effects/hello_missing_effect.sfn" \
  "missing required effects: ![io.console]"

verify_positive \
  "first-run hello world" \
  "$repo_root/site/examples/getting-started/hello-world.sfn" \
  "Hello, World!"
verify_negative \
  "first-run missing-effect fixture" \
  "$repo_root/site/examples/getting-started/hello-world_missing_effect.sfn" \
  "missing required effects: ![io.console]"

echo "public examples verified with sfn $expected_version"
