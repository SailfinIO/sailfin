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

(
  cd "$scratch"
  timeout 60 "$compiler" check "$fixture_dir/hello.sfn"
  timeout 60 "$compiler" build -o "$scratch/hello" "$fixture_dir/hello.sfn"
)
actual_output="$($scratch/hello)"
[[ "$actual_output" == "Hello, Sailfin!" ]] || {
  printf 'unexpected hero output: %q\n' "$actual_output" >&2
  exit 1
}

if (cd "$scratch" && timeout 60 "$compiler" check "$fixture_dir/hello_missing_effect.sfn") >"$scratch/negative.log" 2>&1; then
  echo "missing-effect fixture unexpectedly passed" >&2
  exit 1
fi
grep -q 'E0400' "$scratch/negative.log"
grep -q 'missing required effects: !\[io.console\]' "$scratch/negative.log"

echo "hero example verified with sfn 0.8.0"
