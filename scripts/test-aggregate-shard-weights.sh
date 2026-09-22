#!/usr/bin/env bash
# Exercise the actual aggregation entry point with both CI sidecar layouts.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$repo_root/scratch"
scratch="$(mktemp -d "$repo_root/scratch/shard-weights.XXXXXX")"
# mktemp creates only beneath the resolved repository scratch directory.
case "$scratch" in "$repo_root"/scratch/shard-weights.*) ;; *) exit 2 ;; esac
trap 'rm -rf -- "$scratch"' EXIT
unix="$scratch/ci-test-timing-linux-arm64-e2e-a"
windows="$scratch/ci-test-timing-windows-x86_64-e2e-a"
mkdir -p "$unix" "$windows"

# Repeated test rows must count once per file. duration_ms deliberately
# disagrees with file_elapsed_ms to catch use of the per-test time slice.
cat > "$unix/agent-test.shard-e2e-a.jsonl" <<'EOF'
{"event":"test","file":"compiler/tests/e2e/a_test.sfn","duration_ms":1,"file_elapsed_ms":100}
{"event":"test","file":"compiler/tests/e2e/a_test.sfn","duration_ms":1,"file_elapsed_ms":100}
{"event":"test","file":"compiler/tests/e2e/b_test.sfn","duration_ms":1,"file_elapsed_ms":300}
EOF
cat > "$windows/windows-e2e-a.jsonl" <<'EOF'
  RUN  mixed human output is not a timing row
{"event":"test","file":"compiler/tests/e2e/a_test.sfn","duration_ms":1,"file_elapsed_ms":900}
{"event":"test","file":"compiler/tests/e2e/b_test.sfn","duration_ms":1,"file_elapsed_ms":100}
{"event":"summary","duration_ms":1000}
{"event":"test","file":"C:/Temp/nested_test.sfn","file_elapsed_ms":999999}
{"event":"test","file":"/tmp/nested_test.sfn","file_elapsed_ms":999999}
EOF
bash "$repo_root/scripts/aggregate_shard_weights.sh" "$scratch" "$scratch/result.tsv"
grep -q 'windows-x86_64(2 files, 1s)' "$scratch/result.tsv"
grep -q 'linux-arm64(2 files, 0s)' "$scratch/result.tsv"
printf 'compiler/tests/e2e/a_test.sfn\t900000\ncompiler/tests/e2e/b_test.sfn\t750000\n' > "$scratch/expected.tsv"
grep '^compiler/tests/' "$scratch/result.tsv" > "$scratch/actual.tsv"
diff -u "$scratch/expected.tsv" "$scratch/actual.tsv"

# Windows-only artifacts must also be usable, not masked by a Unix input.
mkdir -p "$scratch/windows-only"
mv "$windows" "$scratch/windows-only/"
bash "$repo_root/scripts/aggregate_shard_weights.sh" "$scratch/windows-only" "$scratch/windows.tsv"
grep -q 'windows-x86_64(2 files, 1s)' "$scratch/windows.tsv"
echo 'shard-weight aggregation: passed'
