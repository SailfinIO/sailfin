#!/usr/bin/env bash
# Content fingerprint for every Sailfin source that feeds `make compile`.
# Paths participate as well as bytes so additions, removals, and renames bust
# the stamp. Unlike an mtime probe, restoring older content with a preserved or
# coarse timestamp cannot make a changed tree look current (SFN-564).
set -euo pipefail

if command -v shasum >/dev/null 2>&1; then
    hash_file() { shasum -a 256 "$1"; }
elif command -v sha256sum >/dev/null 2>&1; then
    hash_file() { sha256sum "$1"; }
else
    echo "compiler_source_fingerprint: need shasum or sha256sum" >&2
    exit 2
fi

if [ "$#" -eq 0 ]; then
    set -- compiler/src runtime
fi

for root in "$@"; do
    if [ ! -d "$root" ]; then
        echo "compiler_source_fingerprint: missing source root: $root" >&2
        exit 2
    fi
done

paths="$(mktemp "${TMPDIR:-/tmp}/sailfin-source-paths.XXXXXX")"
hashes="$(mktemp "${TMPDIR:-/tmp}/sailfin-source-hashes.XXXXXX")"
manifest="$(mktemp "${TMPDIR:-/tmp}/sailfin-source-fingerprint.XXXXXX")"
trap 'rm -f "$paths" "$hashes" "$manifest"' EXIT

LC_ALL=C find "$@" -type f -name '*.sfn' -print | LC_ALL=C sort > "$paths"
# Hash all blobs in one Git process. Spawning a portable SHA utility once per
# module adds about ten seconds to every no-op `make compile` on this tree.
git hash-object --stdin-paths < "$paths" > "$hashes"
paste "$hashes" "$paths" > "$manifest"

hash_file "$manifest" | awk '{print $1}'
