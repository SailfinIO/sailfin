#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
sfn=$1
action=$2
source=$3
runner="$root/build/rill17"
runner_source="$root/benchmarks/llm/rill17.sfn"

if [ ! -x "$runner" ] || [ "$runner_source" -nt "$runner" ]; then
  "$sfn" build -o "$runner" "$runner_source" >/dev/null
fi

exec "$runner" "$sfn" "$action" "$source"
