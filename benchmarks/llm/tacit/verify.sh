#!/usr/bin/env bash
set -euo pipefail

readonly root="$(git rev-parse --show-toplevel)"
readonly here="$root/benchmarks/llm/tacit"
readonly scala_version="3.10.0-RC1-bin-20260616-4733954-NIGHTLY"
readonly jar="${TACIT_LIBRARY_JAR:-$root/build/toolchains/tacit/0.2.1/TACIT-library.jar}"
readonly out="$root/build/sfn350-tacit-smoke"

if [[ ! -f "$jar" ]]; then
  echo "missing TACIT 0.2.1 library: run benchmarks/llm/tacit/fetch.sh" >&2
  exit 2
fi

mkdir -p "$out"
cp "$here/nums.txt" "$out/nums.txt"
common=(--server=false --scala "$scala_version" --scalac-option -experimental --jar "$jar")
if [[ "${SFN350_SCALA_OFFLINE:-0}" == "1" ]]; then
  common+=(--power --offline)
fi

scala-cli compile "${common[@]}" "$here/Scaffold.scala" "$here/HonestIO.scala"
honest="$(cd "$out" && scala-cli run "${common[@]}" "$here/Scaffold.scala" "$here/HonestIO.scala")"
if [[ "$honest" != "12" ]]; then
  echo "TACIT honest-I/O smoke returned '$honest', want '12'" >&2
  exit 1
fi

if scala-cli compile "${common[@]}" "$here/Scaffold.scala" "$here/CapabilityLeak.scala" >"$out/trap.stdout" 2>"$out/trap.stderr"; then
  echo "TACIT capability leak compiled unexpectedly" >&2
  exit 1
fi
if ! grep -Eq "outlives its scope|leaks into outer capture set" "$out/trap.stderr"; then
  echo "TACIT trap failed outside the capture boundary" >&2
  cat "$out/trap.stderr" >&2
  exit 1
fi

echo "TACIT 0.2.1 honest I/O and capture-leak oracle passed"
