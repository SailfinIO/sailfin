#!/usr/bin/env bash
# Decides whether an aarch64-Linux release leg should self-host on a native
# linux-arm64 seed or fall back to the SFN-472 x86_64-under-qemu bootstrap
# (SFN-580). Prints exactly one word to stdout: `native` or `qemu`.
#
# A release's seed pin predates native arm64 assets until the release-train
# publishes them, so this has to be probed per seed_version rather than
# assumed from the toolchain version alone.
set -euo pipefail

SEED_REPO="${SEED_REPO:-SailfinIO/sailfin}"
# Keep in sync with the seed_repo input default in
# .github/actions/sailfin-build/action.yml — a caller overriding one but not
# the other would probe one repo and fetch from another.

if [ -z "${SEED_VERSION:-}" ] || [ "${SEED_VERSION}" = "latest" ]; then
    echo "[arm-seed][error] SEED_VERSION must be a concrete version (no leading 'v', not 'latest')" >&2
    exit 1
fi

native_asset="sailfin-native-linux-arm64-${SEED_VERSION}.tar.gz"
installer_asset="sailfin_${SEED_VERSION}_linux_arm64.tar.gz"

# Test seam: consult a newline-delimited asset list instead of the network.
# Lets the decision matrix (both/neither/partial/invalid) be exercised
# hermetically in compiler/tests/e2e/aarch64_seed_mode_test.sfn.
if [ -n "${SAILFIN_SEED_ASSET_LIST:-}" ]; then
    if [ ! -r "${SAILFIN_SEED_ASSET_LIST}" ]; then
        echo "[arm-seed][error] SAILFIN_SEED_ASSET_LIST is set but not readable: ${SAILFIN_SEED_ASSET_LIST}" >&2
        exit 1
    fi
    native_present=0
    installer_present=0
    if grep -Fxq "${native_asset}" "${SAILFIN_SEED_ASSET_LIST}"; then
        native_present=1
    fi
    if grep -Fxq "${installer_asset}" "${SAILFIN_SEED_ASSET_LIST}"; then
        installer_present=1
    fi
else
    auth=()
    if [ -n "${GITHUB_TOKEN:-}" ]; then
        auth=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
    fi

    _asset_present() {
        local asset="$1"
        local url="https://github.com/${SEED_REPO}/releases/download/v${SEED_VERSION}/${asset}"
        # Only a 404 means "absent". Collapsing every non-2xx into absent
        # would silently downgrade a native-capable pin to the emulated
        # path (an expired token's 401 is indistinguishable from a missing
        # asset), or invent a phantom partial-asset error when one of the
        # two probes blips. The `${a[@]+"${a[@]}"}` guard is for bash 3.2
        # (still /bin/bash on macOS), where expanding an empty array under
        # `set -u` is an unbound-variable error; install.sh uses the same
        # idiom. Reachable off-CI: the docs point developers at this script
        # to predict which path a given pin will take.
        # `-w` already prints 000 when curl never got a response, so the
        # non-zero exit only needs swallowing under `set -e`, not a second
        # sentinel — appending one reports a nonsense "HTTP 000000".
        # A release-download URL 302s to a presigned objects.githubusercontent.com
        # URL that is signed for GET only, so HEAD gets rejected there (401)
        # and can never be a reliable existence probe. A one-byte ranged GET
        # asks the same question the way the URL is actually signed to
        # answer it (SFN-798).
        local code
        if [ -n "${SAILFIN_SEED_PROBE_HTTP_CODE:-}" ]; then
            # Test seam: forces the branch below without any network access,
            # so the non-200/404 fail-closed path is testable hermetically
            # (compiler/tests/e2e/aarch64_seed_mode_test.sfn). Guarded by a
            # three-digit-status shape check because, unlike its sibling seam
            # SAILFIN_SEED_ASSET_LIST (self-guarding on a readable-file
            # check), a bare hand-typed "200" or "206" here would silently
            # bypass the network and print a confident wrong answer for a
            # seed with no arm64 assets.
            case "${SAILFIN_SEED_PROBE_HTTP_CODE}" in
                [0-9][0-9][0-9]) ;;
                *)
                    echo "[arm-seed][error] SAILFIN_SEED_PROBE_HTTP_CODE must be a three-digit HTTP status, got: ${SAILFIN_SEED_PROBE_HTTP_CODE}" >&2
                    exit 1
                    ;;
            esac
            echo "[arm-seed][warn] probe seam active (SAILFIN_SEED_PROBE_HTTP_CODE=${SAILFIN_SEED_PROBE_HTTP_CODE}): no network probe performed" >&2
            code="${SAILFIN_SEED_PROBE_HTTP_CODE}"
        else
            code="$(curl --silent --location --range 0-0 \
                --retry 3 --retry-all-errors --max-time 30 \
                -o /dev/null -w '%{http_code}' \
                ${auth[@]+"${auth[@]}"} "${url}" || true)"
        fi
        case "${code}" in
            200 | 206) return 0 ;;
            404) return 1 ;;
            *)
                echo "[arm-seed][error] probing ${asset} returned HTTP ${code}; refusing to guess whether the asset exists" >&2
                exit 1
                ;;
        esac
    }

    native_present=0
    installer_present=0
    if _asset_present "${native_asset}"; then
        native_present=1
    fi
    if _asset_present "${installer_asset}"; then
        installer_present=1
    fi
fi

echo "[arm-seed] probing seed ${SEED_VERSION}: native=${native_present} installer=${installer_present}" >&2

if [ "${native_present}" -eq 1 ] && [ "${installer_present}" -eq 1 ]; then
    echo "native"
    exit 0
fi

if [ "${native_present}" -eq 0 ] && [ "${installer_present}" -eq 0 ]; then
    echo "qemu"
    exit 0
fi

# A half set means a corrupted release, not a mode choice:
# .github/workflows/release-tag.yml refuses to publish a partial arm64
# payload set (native+installer are both-or-neither).
if [ "${native_present}" -eq 0 ]; then
    echo "[arm-seed][error] seed ${SEED_VERSION} has ${installer_asset} but not ${native_asset} — refusing to build against a release with an inconsistent arm64 asset set (release-tag.yml publishes them both-or-neither)" >&2
else
    echo "[arm-seed][error] seed ${SEED_VERSION} has ${native_asset} but not ${installer_asset} — refusing to build against a release with an inconsistent arm64 asset set (release-tag.yml publishes them both-or-neither)" >&2
fi
exit 1
