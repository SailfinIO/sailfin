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
member_name=""
case "${1:-}" in
    --freshness|--ci-freshness|--layout-inputs|--freshness-inputs|--ci-freshness-inputs|--compiler-sources|--maintainer-sources|--member-roots|--member-records|--compiler-manifests|--public-members)
        mode=${1#--}
        shift
        ;;
    --member-manifest)
        mode="member-manifest"
        shift
        member_name=${1:-}
        if [ -z "$member_name" ]; then
            echo "module_layout_fingerprint: --member-manifest requires a canonical capsule name" >&2
            exit 2
        fi
        shift
        ;;
esac
if [ "$mode" != "layout" ] && [ "$#" -ne 0 ]; then
    echo "module_layout_fingerprint: --${mode} accepts no source roots" >&2
    exit 2
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
ci_freshness_paths="$tmp_dir/ci-freshness-paths"
names="$tmp_dir/names"
compiler_source_inputs="$tmp_dir/compiler-source-inputs"
maintainer_source_inputs="$tmp_dir/maintainer-source-inputs"
member_roots="$tmp_dir/member-roots"
member_records="$tmp_dir/member-records"
compiler_manifests="$tmp_dir/compiler-manifests"
public_members="$tmp_dir/public-members"
member_source_inputs="$tmp_dir/member-source-inputs"
member_dependencies="$tmp_dir/member-dependencies"
selfhost_members="$tmp_dir/selfhost-members"
selfhost_next="$tmp_dir/selfhost-next"

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
: > "$ci_freshness_paths"
: > "$names"
: > "$compiler_source_inputs"
: > "$maintainer_source_inputs"
: > "$member_roots"
: > "$member_records"
: > "$compiler_manifests"
: > "$public_members"
: > "$member_source_inputs"
: > "$member_dependencies"
: > "$selfhost_members"
: > "$selfhost_next"
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
    printf '%s\n' "$member" >> "$member_roots"

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
    publish=$(awk '
        /^[[:space:]]*\[/ { in_capsule = ($0 ~ /^[[:space:]]*\[capsule\][[:space:]]*$/) }
        in_capsule && /^[[:space:]]*publish[[:space:]]*=/ {
            value = $0
            sub(/^[^=]*=[[:space:]]*/, "", value)
            sub(/[[:space:]#].*$/, "", value)
            print value
            exit
        }
    ' "$manifest")
    if [ -z "$publish" ]; then publish=true; fi
    if [ "$publish" != "true" ] && [ "$publish" != "false" ]; then
        echo "module_layout_fingerprint: invalid [capsule] publish policy in $manifest" >&2
        exit 2
    fi
    printf '%s\t%s\t%s\t%s\n' "$name" "$member" "$kind" "$publish" >> "$member_records"
    awk -v owner="$name" '
        /^[[:space:]]*\[/ { in_dependencies = ($0 ~ /^[[:space:]]*\[dependencies\][[:space:]]*$/) }
        in_dependencies && match($0, /^[[:space:]]*"[^"]+"[[:space:]]*=/) {
            dependency = substr($0, RSTART, RLENGTH)
            sub(/^[[:space:]]*"/, "", dependency)
            sub(/"[[:space:]]*=$/, "", dependency)
            print owner "\t" dependency
        }
    ' "$manifest" >> "$member_dependencies"
    is_public=0
    if [ "$is_compiler" -eq 1 ]; then
        printf '%s\n' "$manifest" >> "$compiler_manifests"
    elif [ "$kind" = "library" ] && [ "$publish" != "false" ]; then
        is_public=1
    fi

    source_count=0
    external_entry=""
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
        printf '%s\troot\t%s\n' "$name" "$source_root" >> "$member_source_inputs"
        if [ "$is_compiler" -eq 1 ]; then printf '%s\n' "$source_root" >> "$compiler_source_inputs"; fi
        if [ "$is_maintainer" -eq 1 ]; then
            LC_ALL=C find "$source_root" -type f -name '*.sfn' -print >> "$freshness_paths"
            printf '%s\n' "$source_root" >> "$maintainer_source_inputs"
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
        case "$entry_path" in
            "$source_root"/*) entry_is_covered=1 ;;
            *) entry_is_covered=0 ;;
        esac
        if [ "$entry_is_covered" -eq 0 ]; then
            external_entry="$entry_path"
            printf '%s\tfile\t%s\n' "$name" "$entry_path" >> "$member_source_inputs"
            if [ "$is_compiler" -eq 1 ]; then printf '%s\n' "$entry_path" >> "$compiler_source_inputs"; fi
            if [ "$is_maintainer" -eq 1 ]; then printf '%s\n' "$entry_path" >> "$maintainer_source_inputs"; fi
        fi
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
        printf '%s\tfile\t%s\n' "$name" "$prelude_path" >> "$member_source_inputs"
        case "$prelude_path" in
            "$source_root"/*) ;;
            *) printf '%s\n' "$prelude_path" >> "$maintainer_source_inputs" ;;
        esac
        source_count=1
    fi
    if [ "$source_count" -eq 0 ]; then
        echo "module_layout_fingerprint: member has no Sailfin source input: $member" >&2
        exit 2
    fi
    if [ "$is_public" -eq 1 ]; then
        if [ -n "$external_entry" ]; then
            printf '%s\t%s\t%s\n' "$name" "$member" "$external_entry" >> "$public_members"
        else
            printf '%s\t%s\n' "$name" "$member" >> "$public_members"
        fi
    fi
    if [ "$is_runtime" -eq 1 ] && [ -d "$member/ir" ]; then
        LC_ALL=C find "$member/ir" -type f -name '*.ll' -print >> "$paths"
        LC_ALL=C find "$member/ir" -type f -name '*.ll' -print >> "$freshness_paths"
    fi
done < "$members"

# CI/release freshness is broader than the local maintainer fingerprint: the
# self-hosted compiler and runtime link workspace library dependencies, so
# their transitive source closure must invalidate caches and nightly ancestry.
cp "$freshness_paths" "$ci_freshness_paths"
awk -F '\t' '
    $1 ~ /^sfn\/(compiler|syntax|analyzer|ir|codegen|codegen-llvm)$/ || $3 == "runtime" { print $1 }
' "$member_records" > "$selfhost_members"
while :; do
    LC_ALL=C sort -u "$selfhost_members" > "$selfhost_next"
    before_count=$(awk 'END { print NR }' "$selfhost_next")
    : > "$selfhost_members"
    awk -F '\t' '
        NR == FNR { selected[$1] = 1; next }
        selected[$1] { print $2 }
    ' "$selfhost_next" "$member_dependencies" >> "$selfhost_members"
    LC_ALL=C sort -u "$selfhost_next" "$selfhost_members" -o "$selfhost_members"
    after_count=$(awk 'END { print NR }' "$selfhost_members")
    if [ "$after_count" -eq "$before_count" ]; then break; fi
done
awk -F '\t' '
    NR == FNR { selected[$1] = 1; next }
    selected[$1] { print $2 "\t" $3 }
' "$selfhost_members" "$member_source_inputs" | while IFS=$'\t' read -r input_kind input_path; do
    if [ "$input_kind" = "root" ]; then
        LC_ALL=C find "$input_path" -type f -name '*.sfn' -print >> "$ci_freshness_paths"
    else
        printf '%s\n' "$input_path" >> "$ci_freshness_paths"
    fi
done

case "$mode" in
    layout-inputs) LC_ALL=C sort -u "$paths"; exit 0 ;;
    freshness-inputs) LC_ALL=C sort -u "$freshness_paths"; exit 0 ;;
    ci-freshness-inputs) LC_ALL=C sort -u "$ci_freshness_paths"; exit 0 ;;
    compiler-sources) LC_ALL=C sort -u "$compiler_source_inputs"; exit 0 ;;
    maintainer-sources) LC_ALL=C sort -u "$maintainer_source_inputs"; exit 0 ;;
    member-roots) LC_ALL=C sort -u "$member_roots"; exit 0 ;;
    member-records) LC_ALL=C sort -u "$member_records"; exit 0 ;;
    compiler-manifests)
        compiler_count=$(LC_ALL=C sort -u "$compiler_manifests" | awk 'END { print NR }')
        if [ "$compiler_count" -ne 6 ]; then
            echo "module_layout_fingerprint: expected six canonical compiler-role manifests, found $compiler_count" >&2
            exit 2
        fi
        if awk -F '\t' '$1 ~ /^sfn\/(compiler|syntax|analyzer|ir|codegen|codegen-llvm)$/ && $4 != "false" { print $1 }' "$member_records" | grep -q .; then
            echo "module_layout_fingerprint: every canonical compiler-role manifest must set publish = false" >&2
            exit 2
        fi
        LC_ALL=C sort -u "$compiler_manifests"
        exit 0
        ;;
    public-members) LC_ALL=C sort -u "$public_members"; exit 0 ;;
    member-manifest)
        manifest_path=$(awk -F '\t' -v wanted="$member_name" '$1 == wanted { print $2 "/capsule.toml" }' "$member_records")
        manifest_count=$(printf '%s\n' "$manifest_path" | awk 'NF { count += 1 } END { print count + 0 }')
        if [ "$manifest_count" -ne 1 ]; then
            echo "module_layout_fingerprint: expected one workspace member named $member_name, found $manifest_count" >&2
            exit 2
        fi
        printf '%s\n' "$manifest_path"
        exit 0
        ;;
esac

if [ "$mode" = "freshness" ] || [ "$mode" = "ci-freshness" ]; then
    fingerprint_paths="$freshness_paths"
    schema=v2
    if [ "$mode" = "ci-freshness" ]; then
        fingerprint_paths="$ci_freshness_paths"
        schema=v3
    fi
    while IFS= read -r path; do
        if [ ! -f "$path" ]; then
            echo "module_layout_fingerprint: missing freshness input: $path" >&2
            exit 2
        fi
        printf '%s\t%s\n' "$(hash_file "$path")" "$path"
    done < <(LC_ALL=C sort -u "$fingerprint_paths") \
        | hash_stdin \
        | awk -v schema="$schema" '{print schema "-" $1}'
    exit 0
fi

digest=$(LC_ALL=C sort -u "$paths" | hash_stdin | awk '{print $1}')
printf 'v2-%s\n' "$digest"
