#!/usr/bin/env bash
# Verifies that a single installer tarball's staged runtime dependency
# closure (declared transitively from runtime/capsule.toml [dependencies],
# and from there each dependency's own capsule.toml) is present at
# <root>/capsules/<scope>/<name>/src -- the layout
# locate_runtime_dep_capsule_src resolves at install time. Each dependency's
# capsule.toml must also be staged alongside its src/, since an installed
# toolchain reads that manifest to discover the next hop in the closure
# (compiler/src/capsule_resolver/discovery.sfn). A payload missing part of
# that closure link-fails *every* user program on a fresh install, not just
# ones touching the missing dependency.
set -euo pipefail

tarball="${1:-}"
if [ -z "${tarball}" ]; then
    echo "[payload-dep-closure][error] usage: verify-payload-dep-closure.sh <tarball>" >&2
    exit 1
fi
if [ ! -f "${tarball}" ]; then
    echo "[payload-dep-closure][error] tarball does not exist: ${tarball}" >&2
    exit 1
fi

extract_dir="$(mktemp -d)"
cleanup() {
    rm -rf "${extract_dir}"
}
trap cleanup EXIT

# GNU tar reads an `X:` drive-letter prefix on the archive-file argument as
# `[user@]host:path` remote-archive syntax and refuses to open it locally --
# fatal for every `SAILFIN_TEST_SCRATCH`-derived tarball path on a native
# Windows host. `--force-local` disables that parse but is a GNU extension
# bsdtar (macOS) does not reliably carry, so no flag is safe on every host;
# running from the tarball's own directory with a bare basename argument
# removes the ambiguity everywhere instead (mirrors
# `sfn_package_test.sfn::_tar_list`, same rationale).
tarball_dir="$(dirname -- "${tarball}")"
tarball_base="$(basename -- "${tarball}")"
(cd "${tarball_dir}" && tar -xzf "${tarball_base}" -C "${extract_dir}")

root_dir="${extract_dir}"
if [ ! -d "${extract_dir}/runtime" ]; then
    first_dir="$(find "${extract_dir}" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
    dir_count="$(find "${extract_dir}" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
    if [ -n "${first_dir}" ] && [ "${dir_count}" -eq 1 ]; then
        root_dir="${first_dir}"
    fi
fi

if [ ! -f "${root_dir}/runtime/capsule.toml" ]; then
    echo "[payload-dep-closure][error] ${root_dir}/runtime/capsule.toml missing; installer payload has no runtime manifest (tarball: ${tarball})" >&2
    exit 1
fi

# Emit each `[dependencies]` key from a capsule manifest, one per line.
#
# `sub(/\r$/, "")` is load-bearing, not defensive tidying. `sfn package` on a
# Windows runner stages manifests with CRLF endings, so without it `section`
# holds "[dependencies]\r", never equals "[dependencies]", and the walk below
# reports "nothing to verify" and exits 0 — passing a payload it never looked
# at. That is what the native MSVC payload did from the day it started
# shipping until SFN-1024: verified against the published v0.10.4 tarball,
# whose staged `runtime/capsule.toml` carries 182 CRs and declares
# `sfn/crypto` the parser could not see.
#
# Factored out of the two call sites rather than fixed twice: the duplicate
# awk is why the defect existed in both the top-level and nested walks.
_capsule_deps() {
    awk '{ sub(/\r$/, "") }
         /^\[[^]]+\]/ { section = $0 }
         section == "[dependencies]" && /^"/ { gsub(/"/, "", $1); print $1 }' "$1"
}

deps="$(_capsule_deps "${root_dir}/runtime/capsule.toml")"
if [ -z "${deps}" ]; then
    echo "[payload-dep-closure] ${tarball}: runtime/capsule.toml declares no dependencies; nothing to verify"
    exit 0
fi

# Transitive worklist walk: each dependency's own capsule.toml may declare
# further dependencies, so a single-level check would pass a payload that
# ships sfn/crypto without its own sfn/strings dependency.
# Bash 3.2 compatible throughout: macOS ships 3.2 and this script runs on the
# macos-arm64 release leg. So no associative arrays, and the worklist is walked
# with an index rather than by slicing off the head -- `"${a[@]:1}"` on a
# one-element array trips `set -u` under 3.2. This mirrors the index-based walk
# the compiler's own resolver uses.
worklist=()
while IFS= read -r dep; do
    worklist+=("${dep}")
done <<< "${deps}"

visited=" "
verified=""
qi=0
max_iterations=4096

while [ "${qi}" -lt "${#worklist[@]}" ]; do
    if [ "${qi}" -ge "${max_iterations}" ]; then
        echo "[payload-dep-closure][error] dependency closure walk exceeded ${max_iterations} iterations (tarball: ${tarball})" >&2
        exit 1
    fi

    dep="${worklist[${qi}]}"
    qi=$((qi + 1))

    case "${visited}" in
        *" ${dep} "*) continue ;;
    esac
    visited="${visited}${dep} "

    scope="${dep%%/*}"
    name="${dep#*/}"
    src_dir="${root_dir}/capsules/${scope}/${name}/src"
    manifest="${root_dir}/capsules/${scope}/${name}/capsule.toml"

    if [ ! -d "${src_dir}" ]; then
        echo "[payload-dep-closure][error] installer payload missing dependency '${dep}': expected directory '${src_dir}' (tarball: ${tarball})" >&2
        exit 1
    fi
    found="$(find "${src_dir}" -name '*.sfn' -print -quit)"
    if [ -z "${found}" ]; then
        echo "[payload-dep-closure][error] installer payload dependency '${dep}' has no .sfn sources in '${src_dir}' (tarball: ${tarball})" >&2
        exit 1
    fi
    if [ ! -f "${manifest}" ]; then
        echo "[payload-dep-closure][error] installer payload dependency '${dep}' missing manifest: expected file '${manifest}' (tarball: ${tarball})" >&2
        exit 1
    fi

    verified="${verified}${dep} "

    nested_deps="$(_capsule_deps "${manifest}")"
    if [ -n "${nested_deps}" ]; then
        while IFS= read -r nested_dep; do
            worklist+=("${nested_dep}")
        done <<< "${nested_deps}"
    fi
done

echo "[payload-dep-closure] ${tarball}: verified dependency closure: ${verified% }"
