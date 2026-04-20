#!/usr/bin/env bash
# Isolate a compilation failure for a single .sfn file.
#
# Runs both `emit native` (.sfn-asm) and `emit llvm` (LLVM IR) on the file,
# captures each to build/debug/<basename>.{asm,ll,stderr}, and prints a
# summary. Always uses ulimit + timeout so a runaway parser can't hang the
# session.

set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <path/to/file.sfn>" >&2
  exit 64
fi

if [[ ! -f "$file" ]]; then
  echo "no such file: $file" >&2
  exit 66
fi

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

if [[ ! -x build/native/sailfin ]]; then
  echo "build/native/sailfin missing — run \`ulimit -v 8388608 && make compile\` first" >&2
  exit 69
fi

mkdir -p build/debug
base=$(basename "$file" .sfn)

asm="build/debug/${base}.asm"
asm_err="build/debug/${base}.asm.stderr"
ll="build/debug/${base}.ll"
ll_err="build/debug/${base}.ll.stderr"

echo "==> emit native -> $asm"
if ulimit -v 8388608 && timeout 60 build/native/sailfin emit native "$file" >"$asm" 2>"$asm_err"; then
  lines=$(wc -l <"$asm")
  echo "    ok ($lines lines of .sfn-asm)"
else
  status=$?
  echo "    FAILED (exit $status); stderr:"
  sed 's/^/      /' "$asm_err"
fi

echo "==> emit llvm  -> $ll"
if ulimit -v 8388608 && timeout 60 build/native/sailfin emit llvm "$file" >"$ll" 2>"$ll_err"; then
  lines=$(wc -l <"$ll")
  echo "    ok ($lines lines of LLVM IR)"
else
  status=$?
  echo "    FAILED (exit $status); stderr:"
  sed 's/^/      /' "$ll_err"
fi

echo
echo "Artifacts:"
printf '  %s\n' "$asm" "$asm_err" "$ll" "$ll_err"
