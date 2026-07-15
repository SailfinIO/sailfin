#!/usr/bin/env bash
set -euo pipefail

readonly root="$(git rev-parse --show-toplevel)"
readonly pins="$root/benchmarks/llm/tacit/versions.json"
version="$(python3 -c 'import json, sys; print(json.load(open(sys.argv[1]))[sys.argv[2]])' "$pins" tacit_version)"
expected="$(python3 -c 'import json, sys; print(json.load(open(sys.argv[1]))[sys.argv[2]])' "$pins" tacit_library_sha256)"
url="$(python3 -c 'import json, sys; print(json.load(open(sys.argv[1]))[sys.argv[2]])' "$pins" tacit_library_url)"
readonly version expected url
readonly dest="$root/build/toolchains/tacit/$version/TACIT-library.jar"

mkdir -p "$(dirname "$dest")"
if [[ ! -f "$dest" ]]; then
  curl -fL "$url" -o "$dest.tmp"
  mv "$dest.tmp" "$dest"
fi

if command -v sha256sum >/dev/null 2>&1; then
  actual="$(sha256sum "$dest" | awk '{print $1}')"
elif command -v shasum >/dev/null 2>&1; then
  actual="$(shasum -a 256 "$dest" | awk '{print $1}')"
else
  echo "TACIT verification requires sha256sum or shasum" >&2
  exit 2
fi
if [[ "$actual" != "$expected" ]]; then
  echo "TACIT library digest mismatch: got $actual, want $expected" >&2
  exit 1
fi

echo "$dest"
