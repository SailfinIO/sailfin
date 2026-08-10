#!/usr/bin/env bash
# Verifies that a single installer tarball's staged runtime dependency
# closure (declared in runtime/capsule.toml [dependencies]) is present at
# <root>/capsules/<scope>/<name>/src -- the layout
# locate_runtime_dep_capsule_src resolves at install time. A payload missing
# part of that closure link-fails *every* user program on a fresh install,
# not just ones touching the missing dependency.
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

tar -xzf "${tarball}" -C "${extract_dir}"

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

deps="$(awk '/^\[[^]]+\]/ { section=$0 } section == "[dependencies]" && /^"/ { gsub(/"/, "", $1); print $1 }' "${root_dir}/runtime/capsule.toml")"
if [ -z "${deps}" ]; then
    echo "[payload-dep-closure] ${tarball}: runtime/capsule.toml declares no dependencies; nothing to verify"
    exit 0
fi

verified=()
while IFS= read -r dep; do
    scope="${dep%%/*}"
    name="${dep#*/}"
    src_dir="${root_dir}/capsules/${scope}/${name}/src"
    if [ ! -d "${src_dir}" ]; then
        echo "[payload-dep-closure][error] installer payload missing dependency '${dep}': expected directory '${src_dir}' (tarball: ${tarball})" >&2
        exit 1
    fi
    found="$(find "${src_dir}" -name '*.sfn' -print -quit)"
    if [ -z "${found}" ]; then
        echo "[payload-dep-closure][error] installer payload dependency '${dep}' has no .sfn sources in '${src_dir}' (tarball: ${tarball})" >&2
        exit 1
    fi
    verified+=("${dep}")
done <<< "${deps}"

echo "[payload-dep-closure] ${tarball}: verified dependency closure: ${verified[*]}"
