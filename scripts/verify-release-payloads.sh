#!/usr/bin/env bash
# Verifies that the final release directory contains every publishable
# platform payload, including the required native+installer ARM64 pair.
set -euo pipefail

payload_dir="${1:-dist}"
release_tag="${RELEASE_TAG:-}"
version="${2:-${release_tag#v}}"

if [ -z "${version}" ]; then
    echo "[release-payloads][error] release version is empty" >&2
    exit 1
fi
if [ ! -d "${payload_dir}" ]; then
    echo "[release-payloads][error] payload directory does not exist: ${payload_dir}" >&2
    exit 1
fi

# Both Windows ABIs are required (SFN-1024). The native MSVC payload was
# previously presence-optional, on the reasoning that a missing optional asset
# is a lost signal rather than a broken release. That reasoning expired once
# the asset became seed-consumed: `seed_source: 'release'`
# (.github/actions/sailfin-build-windows/verify-release-seed.ps1) bootstraps
# Windows CI from `sailfin_<version>_windows_x86_64-msvc.tar.gz` and fails
# closed with no mingw fallback, and SFN-1037 stalls the cadence seed pin when
# the asset is absent. A release without it now degrades Windows CI silently.
# The legacy mingw payload stays required until its own leg retires (SFN-58);
# installers still fall back to it for pre-v0.10.3 tags and for arm64.
required=(
    "sailfin-native-linux-x86_64-${version}.tar.gz"
    "sailfin_${version}_linux_x86_64.tar.gz"
    "sailfin-native-linux-arm64-${version}.tar.gz"
    "sailfin_${version}_linux_arm64.tar.gz"
    "sailfin-native-macos-arm64-${version}.tar.gz"
    "sailfin_${version}_macos_arm64.tar.gz"
    "sailfin_${version}_windows_x86_64.tar.gz"
    "sailfin_${version}_windows_x86_64-msvc.tar.gz"
)

missing=()
for asset in "${required[@]}"; do
    if [ ! -f "${payload_dir}/${asset}" ]; then
        missing+=("${asset}")
    fi
done

if [ "${#missing[@]}" -ne 0 ]; then
    printf '[release-payloads][error] required release payload missing: %s\n' "${missing[@]}" >&2
    exit 1
fi

echo "[release-payloads] verified ${#required[@]} required payloads for ${version}"
