#!/usr/bin/env bash
# Fingerprint the *module layout* of the Sailfin workspace: the sorted set of
# member `.sfn` paths plus explicit manifest/bootstrap/runtime-IR paths,
# deliberately WITHOUT their contents. Explicit root arguments retain the
# original `.sfn`-only v1 behavior.
#
# This is the CI build-cache counterpart to `sfn dev bootstrap fingerprint`
# (SFN-679 retired the former `compiler_source_fingerprint.sh` shell
# implementation), which hashes paths AND bytes. The two answer different
# questions:
#
#   sfn dev bootstrap fingerprint   "did anything that feeds the build change?"
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
    hash_file() { shasum -a 256 "$1" | awk '{print $1}'; }
elif command -v sha256sum >/dev/null 2>&1; then
    hash_stdin() { sha256sum; }
    hash_file() { sha256sum "$1" | awk '{print $1}'; }
else
    echo "module_layout_fingerprint: need shasum or sha256sum" >&2
    exit 2
fi

mode=layout
if [ "${1:-}" = "--freshness" ]; then
    mode=freshness
    shift
    if [ "$#" -ne 0 ]; then
        echo "module_layout_fingerprint: --freshness accepts no source roots" >&2
        exit 2
    fi
fi

# Explicit roots retain the original path-only v1 contract used by focused
# tests and callers fingerprinting an arbitrary scratch tree.
if [ "$#" -gt 0 ]; then
    for root in "$@"; do
        if [ ! -d "$root" ]; then
            echo "module_layout_fingerprint: missing source root: $root" >&2
            exit 2
        fi
    done
    LC_ALL=C find "$@" -type f -name '*.sfn' -print \
        | LC_ALL=C sort \
        | hash_stdin \
        | awk '{print $1}'
    exit 0
fi

# Default mode is bootstrap-safe: CI invokes this before the checkout's
# compiler exists, so this deliberately implements only the workspace syntax
# the native resolver accepts today (literal members and a trailing `/*`).
if [ ! -f workspace.toml ]; then
    echo "module_layout_fingerprint: missing workspace.toml" >&2
    exit 2
fi

tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/sailfin-layout.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT
members_raw="$tmp_dir/members.raw"
members="$tmp_dir/members"
excludes="$tmp_dir/excludes"
paths="$tmp_dir/paths"
freshness_paths="$tmp_dir/freshness-paths"
names="$tmp_dir/names"

extract_workspace_array() {
    local key="$1"
    awk -v wanted="$key" '
        BEGIN { in_workspace = 0; active = 0 }
        /^[[:space:]]*\[/ {
            in_workspace = ($0 ~ /^[[:space:]]*\[workspace\][[:space:]]*$/)
        }
        in_workspace && $0 ~ "^[[:space:]]*" wanted "[[:space:]]*=" { active = 1 }
        active {
            line = $0
            while (match(line, /"[^"]+"/)) {
                print substr(line, RSTART + 1, RLENGTH - 2)
                line = substr(line, RSTART + RLENGTH)
            }
            if ($0 ~ /]/) { active = 0 }
        }
    ' workspace.toml
}

extract_workspace_array members > "$members_raw"
extract_workspace_array exclude > "$excludes"
if [ ! -s "$members_raw" ]; then
    echo "module_layout_fingerprint: workspace has no members" >&2
    exit 2
fi

: > "$members"
while IFS= read -r spec; do
    case "$spec" in
        */\*)
            base=${spec%/\*}
            if [ ! -d "$base" ]; then
                echo "module_layout_fingerprint: missing member glob root: $base" >&2
                exit 2
            fi
            for child in "$base"/*; do
                if [ -f "$child/capsule.toml" ] && ! grep -Fxq "$child" "$excludes" 2>/dev/null; then
                    printf '%s\n' "$child"
                fi
            done
            ;;
        *) printf '%s\n' "$spec" ;;
    esac
done < "$members_raw" | LC_ALL=C sort -u > "$members"

: > "$paths"
: > "$freshness_paths"
: > "$names"
printf '%s\n' workspace.toml >> "$paths"
printf '%s\n' workspace.toml >> "$freshness_paths"
if [ -f bootstrap.toml ]; then
    printf '%s\n' bootstrap.toml >> "$paths"
    printf '%s\n' bootstrap.toml >> "$freshness_paths"
fi

while IFS= read -r member; do
    manifest="$member/capsule.toml"
    if [ ! -f "$manifest" ]; then
        echo "module_layout_fingerprint: missing member manifest: $manifest" >&2
        exit 2
    fi
    name=$(awk '
        /^[[:space:]]*\[/ { in_capsule = ($0 ~ /^[[:space:]]*\[capsule\][[:space:]]*$/) }
        in_capsule && /^[[:space:]]*name[[:space:]]*=/ {
            if (match($0, /"[^"]+"/)) { print substr($0, RSTART + 1, RLENGTH - 2); exit }
        }
    ' "$manifest")
    if [ -z "$name" ]; then
        echo "module_layout_fingerprint: unnamed member manifest: $manifest" >&2
        exit 2
    fi
    if grep -Fxq "$name" "$names" 2>/dev/null; then
        echo "module_layout_fingerprint: duplicate workspace capsule name: $name" >&2
        exit 2
    fi
    printf '%s\n' "$name" >> "$names"
    printf '%s\n' "$manifest" >> "$paths"
    printf '%s\n' "$manifest" >> "$freshness_paths"

    kind=$(awk '
        /^[[:space:]]*\[/ { in_build = ($0 ~ /^[[:space:]]*\[build\][[:space:]]*$/) }
        in_build && /^[[:space:]]*kind[[:space:]]*=/ {
            if (match($0, /"[^"]+"/)) { print substr($0, RSTART + 1, RLENGTH - 2); exit }
        }
    ' "$manifest")
    is_runtime=0
    if [ "$kind" = "runtime" ]; then is_runtime=1; fi
    is_compiler=0
    case "$name" in
        sfn/compiler|sfn/syntax|sfn/analyzer|sfn/ir|sfn/codegen|sfn/codegen-llvm) is_compiler=1 ;;
    esac
    is_maintainer=0
    if [ "$is_compiler" -eq 1 ] || [ "$is_runtime" -eq 1 ]; then is_maintainer=1; fi

    source_count=0
    source_root="$member/src"
    custom_root=$(awk '
        /^[[:space:]]*\[/ { in_build = ($0 ~ /^[[:space:]]*\[build\][[:space:]]*$/) }
        in_build && /^[[:space:]]*sfn-source-root[[:space:]]*=/ {
            if (match($0, /"[^"]+"/)) { print substr($0, RSTART + 1, RLENGTH - 2); exit }
        }
    ' "$manifest")
    if [ -n "$custom_root" ]; then source_root="$member/$custom_root"; fi
    if [ -d "$source_root" ]; then
        LC_ALL=C find "$source_root" -type f -name '*.sfn' -print >> "$paths"
        if [ "$is_maintainer" -eq 1 ]; then
            LC_ALL=C find "$source_root" -type f -name '*.sfn' -print >> "$freshness_paths"
        fi
        source_count=1
    fi

    entry=$(awk '
        /^[[:space:]]*\[/ { in_build = ($0 ~ /^[[:space:]]*\[build\][[:space:]]*$/) }
        in_build && /^[[:space:]]*entry[[:space:]]*=/ {
            if (match($0, /"[^"]+"/)) { print substr($0, RSTART + 1, RLENGTH - 2); exit }
        }
    ' "$manifest")
    if [ -n "$entry" ]; then
        if [ ! -f "$member/$entry" ]; then
            echo "module_layout_fingerprint: missing declared entry: $member/$entry" >&2
            exit 2
        fi
        entry_dir=$(cd "$(dirname "$member/$entry")" && pwd -P)
        entry_path="$entry_dir/$(basename "$entry")"
        repo_root=$(pwd -P)
        case "$entry_path" in "$repo_root"/*) entry_path=${entry_path#"$repo_root"/} ;; esac
        printf '%s\n' "$entry_path" >> "$paths"
        if [ "$is_maintainer" -eq 1 ]; then printf '%s\n' "$entry_path" >> "$freshness_paths"; fi
        source_count=1
    fi
    prelude=$(awk '
        /^[[:space:]]*\[/ { in_build = ($0 ~ /^[[:space:]]*\[build\][[:space:]]*$/) }
        in_build && /^[[:space:]]*prelude-entry[[:space:]]*=/ {
            if (match($0, /"[^"]+"/)) { print substr($0, RSTART + 1, RLENGTH - 2); exit }
        }
    ' "$manifest")
    if [ "$is_runtime" -eq 1 ] && [ -n "$prelude" ]; then
        if [ ! -f "$member/$prelude" ]; then
            echo "module_layout_fingerprint: missing prelude input: $member/$prelude" >&2
            exit 2
        fi
        prelude_dir=$(cd "$(dirname "$member/$prelude")" && pwd -P)
        prelude_path="$prelude_dir/$(basename "$prelude")"
        repo_root=$(pwd -P)
        case "$prelude_path" in "$repo_root"/*) prelude_path=${prelude_path#"$repo_root"/} ;; esac
        printf '%s\n' "$prelude_path" >> "$paths"
        printf '%s\n' "$prelude_path" >> "$freshness_paths"
        source_count=1
    fi
    if [ "$source_count" -eq 0 ]; then
        echo "module_layout_fingerprint: member has no Sailfin source input: $member" >&2
        exit 2
    fi
    if [ "$is_runtime" -eq 1 ] && [ -d "$member/ir" ]; then
        LC_ALL=C find "$member/ir" -type f -name '*.ll' -print >> "$paths"
        LC_ALL=C find "$member/ir" -type f -name '*.ll' -print >> "$freshness_paths"
    fi
done < "$members"

if [ "$mode" = "freshness" ]; then
    while IFS= read -r path; do
        if [ ! -f "$path" ]; then
            echo "module_layout_fingerprint: missing freshness input: $path" >&2
            exit 2
        fi
        printf '%s\t%s\n' "$(hash_file "$path")" "$path"
    done < <(LC_ALL=C sort -u "$freshness_paths") \
        | hash_stdin \
        | awk '{print "v2-" $1}'
    exit 0
fi

digest=$(LC_ALL=C sort -u "$paths" | hash_stdin | awk '{print $1}')
printf 'v2-%s\n' "$digest"
