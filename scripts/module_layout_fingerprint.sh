#!/usr/bin/env bash
# Fingerprint the *module layout* of the Sailfin source tree: the sorted set
# of `.sfn` paths, deliberately WITHOUT their contents.
#
# This is the CI build-cache counterpart to `compiler_source_fingerprint.sh`,
# which hashes paths AND bytes. The two answer different questions:
#
#   compiler_source_fingerprint.sh  "did anything that feeds the build change?"
#   module_layout_fingerprint.sh    "did the set of modules change?"
#
# Why the second one exists (SFN-661). A module's emitted symbols are mangled
# with the slug of the module that provides each import
# (`<symbol>__<provider_slug>`), and a provider's slug is derived from its
# path. So splitting, moving, or renaming a module re-mangles the call sites
# of dependents whose own bytes never changed. The content-addressed module-IR
# cache key must account for that, and since SFN-661 it does — but that fix
# lives in compiler source, and CI's `make compile` is driven by the *pinned
# seed*, which will not carry it until a seed is cut. Until then a restored
# cache built before a layout change can still serve stale IR to the seed.
#
# Folding this fingerprint into the GitHub cache key AND its restore-keys
# prefix closes that window without depending on the seed: a restore can only
# ever span builds whose module layout is identical. Content-only changes —
# the overwhelmingly common case — keep hitting the warm cache exactly as
# before; a split/add/remove/rename pays one cold build, which is the correct
# price for an unsound reuse.
#
# Once a seed carrying the `cache_key_for` fix is pinned, this becomes
# belt-and-braces rather than the primary guard.
set -euo pipefail

if command -v shasum >/dev/null 2>&1; then
    hash_stdin() { shasum -a 256; }
elif command -v sha256sum >/dev/null 2>&1; then
    hash_stdin() { sha256sum; }
else
    echo "module_layout_fingerprint: need shasum or sha256sum" >&2
    exit 2
fi

if [ "$#" -eq 0 ]; then
    set -- compiler/src runtime
fi

for root in "$@"; do
    if [ ! -d "$root" ]; then
        echo "module_layout_fingerprint: missing source root: $root" >&2
        exit 2
    fi
done

# `LC_ALL=C` pins the sort collation so the same tree fingerprints identically
# on every runner regardless of locale.
LC_ALL=C find "$@" -type f -name '*.sfn' -print \
    | LC_ALL=C sort \
    | hash_stdin \
    | awk '{print $1}'
