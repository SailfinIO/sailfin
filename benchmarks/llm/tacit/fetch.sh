#!/usr/bin/env bash
set -euo pipefail

readonly version="0.2.1"
readonly expected="5985f69fd13437ccf43d8c8c613a4681f71c574d7b84ca239aa33385f98e5462"
readonly root="$(git rev-parse --show-toplevel)"
readonly dest="$root/build/toolchains/tacit/$version/TACIT-library.jar"
readonly url="https://github.com/lampepfl/tacit/releases/download/$version/TACIT-library.jar"

mkdir -p "$(dirname "$dest")"
if [[ ! -f "$dest" ]]; then
  curl -fL "$url" -o "$dest.tmp"
  mv "$dest.tmp" "$dest"
fi

actual="$(shasum -a 256 "$dest" | awk '{print $1}')"
if [[ "$actual" != "$expected" ]]; then
  echo "TACIT library digest mismatch: got $actual, want $expected" >&2
  exit 1
fi

echo "$dest"
