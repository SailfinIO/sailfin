# Bootstrapping a native aarch64-Linux compiler

> This document is the **procedure**. For why the qemu fallback still exists,
> what it is exempt from, and the condition that retires it, see
> [`conventions/aarch64-qemu-bootstrap.md`](conventions/aarch64-qemu-bootstrap.md).

Two paths produce a native aarch64-Linux compiler for a release leg, and
`release-tag.yml` / `release-branches.yml` choose between them automatically
per pinned seed (SFN-580):

- **Native-seed self-host — the steady state.** Once a release publishes both
  `sailfin-native-linux-arm64-<version>.tar.gz` and
  `sailfin_<version>_linux_arm64.tar.gz`, an aarch64 leg fetches the seed
  with the shared seed-fetch step in
  `.github/actions/sailfin-build/action.yml` (`./install.sh`, driven by the
  `SEED_VERSION`/`INSTALL_BASE`/`GLOBAL_BIN_DIR` overrides) and self-hosts
  with `sfn dev bootstrap build --force`, exactly like every other target —
  nothing aarch64-specific to run by hand.
  (That step installs the `sailfin_<version>_linux_arm64.tar.gz`
  installer asset; the probe below requires the `sailfin-native-…` tarball to
  be present too because a release publishes the pair both-or-neither, so a
  half set means a corrupted release rather than a buildable one.) This is
  SFEP-0056 §3.4 Stage 4 realized for release legs: every release from
  **v0.9.3** forward publishes both assets — SFN-799 gates publication and
  cadence seed pinning on the pair — so this is the path a current-tag release
  build takes. Read the pin from `bootstrap.toml [seed].version` rather than
  from a version quoted in prose here. See "Release-leg seed selection" below
  for how the mode is chosen and verified.
- **x86_64-seed-under-qemu bootstrap — the fallback.** Rebuilding a tag whose
  pinned seed predates arm64 release assets has no native seed to fetch, so
  the leg falls back to the original SFEP-0056 §3.4 / SFN-472 bring-up: the
  pinned x86_64 seed runs under `qemu-user` and cross-links a native aarch64
  compiler. This is also the documented procedure for manual first bring-up
  on a host that cannot fetch a native seed. It is not deprecated and not
  removed — the rest of this document describes it.

## Release-leg seed selection

`scripts/select-aarch64-seed-mode.sh` decides which path a release leg takes
for a given `SEED_VERSION` (the pin from `bootstrap.toml [seed].version`, or
a workflow's `seed_version` override). It probes release `v$SEED_VERSION` for
both arm64 assets with a one-byte ranged GET (a release-download URL
redirects to a presigned object URL signed for GET only, so a `HEAD` probe
gets rejected there and can't be used) and prints exactly one word to
stdout:

- `native` — both `sailfin-native-linux-arm64-<version>.tar.gz` and
  `sailfin_<version>_linux_arm64.tar.gz` are present.
- `qemu` — neither asset is present. Usually the pin predates arm64 release
  assets, but it can also mean a pinned release failed to publish its arm64
  payloads (v0.9.2 did exactly this) — which is a defect to investigate,
  not an expected case.

Any other combination — one asset present, the other missing — is a
corrupted release, not a mode choice, since `release-tag.yml` refuses to
publish a partial arm64 payload. The script fails closed (exit 1) on that
case, and also on a missing or `latest` `SEED_VERSION`: the probe needs a
concrete pinned version to check, never the moving `latest` tag.

Run it by hand to predict which path a given pin will take. The v0.9.3 floor
is the dividing line — a pin below it has no arm64 assets to fetch:

```bash
# The current pin -> `native`.
SEED_VERSION="$(sed -n 's/^version = "\(.*\)"/\1/p' bootstrap.toml | head -1)" \
  scripts/select-aarch64-seed-mode.sh

# A pre-v0.9.3 pin -> `qemu`.
SEED_VERSION=0.9.1 scripts/select-aarch64-seed-mode.sh
```

Env:

- `SEED_VERSION` (required) — the version to probe, without a leading `v`.
- `SEED_REPO` (default `SailfinIO/sailfin`) — repo to query.
- `GITHUB_TOKEN` — optional auth for the asset-presence check.
- `SAILFIN_SEED_ASSET_LIST` — test seam: a newline-delimited file of asset
  names consulted instead of the network. Exercises the full
  both/neither/partial/invalid decision matrix hermetically in
  `compiler/tests/e2e/aarch64_seed_mode_test.sfn`.
- `SAILFIN_SEED_PROBE_HTTP_CODE` — test seam: forces the HTTP status the
  ranged-GET probe sees, bypassing the network, so the non-200/206/404
  fail-closed branch is testable hermetically in
  `compiler/tests/e2e/aarch64_seed_mode_test.sfn`. Never leave that one
  exported: it makes the script report a seed's assets present without ever
  checking.

The two release workflows run this probe in a `Select aarch64 seed mode`
step and feed its output into `.github/actions/sailfin-build/action.yml`'s
`arm_seed_mode` input (`native` | `qemu`, **no default**). That step is the
single place the qemu fallback is chosen: it is also what covers a checkout
predating SFN-580, which has no probe to run. An arm64 caller that passes
nothing reaches the action's `Reject unknown aarch64 seed mode` guard and
fails loudly, rather than silently spending ~30 minutes under emulation
(SFN-1078).

- On `native`, the arm64 leg takes the ordinary `./install.sh` fetch +
  `sfn dev bootstrap build --force` path, then runs a `Verify native aarch64
  seed` step asserting the fetched binary is an AArch64 ELF that reports the
  pinned version — `install.sh`'s SHA256SUMS check proves the
  download is authentic, not that it is the right architecture.
- On `qemu`, the leg fetches the pinned x86_64 seed and runs
  `scripts/bootstrap-aarch64-linux.sh` (below). The `qemu-user`/multiarch apt install
  (the emulated amd64 sysroot) is gated on the same mode output, so the
  native path never installs emulation packages it does not use.

## Fallback: bootstrapping under qemu

The first native aarch64 compiler — and any release-leg rebuild of a tag
whose pin predates arm64 assets — is bootstrapped on an aarch64 host from the
pinned x86_64 seed. This is the executable procedure for SFEP-0056 §3.4 and
SFN-472. Run by hand it is not itself a CI or release-publishing workflow,
but `.github/actions/sailfin-build/action.yml` invokes the same script
directly for the `qemu` mode selected above. There is no `make` target for it:
SFN-1078 removed the wrapper so SFN-60 can delete the Makefile without
deleting this capability.

## Host prerequisites

Use Ubuntu 24.04 arm64 (a physical host, VM, or native arm runner) with:

- `qemu-user`/`qemu-user-binfmt` (the script enables the x86_64 registration
  through `update-binfmts` when passwordless privilege is available);
- `clang`, `lld`, `readelf`, and `sha256sum`;
- an x86_64 glibc development sysroot and the x86_64 development libraries
  needed by the compiler link (`libc`, pthread, and math),
  **including the x86_64 GCC runtime** (`libgcc-*-dev:amd64`). Stage 1 links
  through `clang --target=x86_64-linux-gnu`, which needs `crtbeginS.o`,
  `crtendS.o`, and `libgcc` for that target; `libc6-dev:amd64` alone supplies
  the CRT startup files but not those.

On Ubuntu, register `amd64` as a foreign architecture before installing the
corresponding `:amd64` development packages. Confirm that a downloaded x86_64
Sailfin binary runs with `qemu-x86_64 /path/to/sfn --version`. Dynamic seeds
may also require `QEMU_LD_PREFIX` to name the x86_64 sysroot.

Stage 1 does not read `SAILFIN_CC`. The seed resolves its C compiler by looking
up the bare name `clang` on `PATH`, so the script shadows `clang` with a
`--target=x86_64-linux-gnu -fuse-ld=lld` wrapper on a directory prepended to
`PATH` for that stage alone. Selecting LLD is required because the native GNU
linker on an aarch64 host cannot link x86_64 objects. A preflight compiles and
links a trivial C file through that wrapper and fails immediately if the
shadowing is not in effect, LLD is unavailable, or the amd64 link inputs are
missing, rather than after the ~30-minute emulated build.

Compiler A and native pass-1 report the source tree's version rather than the
pinned seed version. Their pass-1 and pass-2 builds therefore set
`SAILFIN_BOOTSTRAP=off`: these are already the explicit self-host transitions,
and redispatching the ordinary contributor seed gate would incorrectly look
for a native aarch64 asset of the older x86_64 bring-up seed.

Download the **x86_64 Linux** asset for the exact version in
`bootstrap.toml [seed].version`; do not use the host-architecture selection in
`sfn dev bootstrap fetch`, because a manual bring-up on a host with no native
seed available has no aarch64 asset to select.

## Run the bootstrap

From the repository root:

```bash
SEED_X86_64=/path/to/pinned/x86_64/sfn \
  scripts/bootstrap-aarch64-linux.sh
```

`SAILFIN_AARCH64_BOOTSTRAP_DIR` changes the default work directory
(`build/aarch64-bootstrap`), `QEMU_X86_64` selects the emulator, and
`SAILFIN_NATIVE_CC` selects the native clang executable.

Two further knobs exist for the binfmt gate. `SAILFIN_BINFMT_DIR` points the
registration probe somewhere other than `/proc/sys/fs/binfmt_misc`, and
`SAILFIN_BINFMT_PROBE_ONLY=1` runs that probe alone and exits with its verdict
— `0` when a usable x86_64 registration is present, `1` otherwise — without
touching the host or seed checks. Never leave that one exported: it makes the
whole bootstrap a no-op that builds nothing and exits `0`. Together they let
`compiler/tests/e2e/aarch64_binfmt_probe_test.sfn` cover the gate from any
Linux host instead of only from an aarch64 runner with a live binfmt_misc
mount.

The script performs four fail-closed stages:

1. The pinned x86_64 seed runs under qemu and cross-links arch-aware compiler A
   as x86_64. Recursive compiler processes use the registered binfmt handler.
2. Compiler A runs under qemu but invokes native clang to produce a native
   AArch64 pass-1. `SAILFIN_TARGET_ARCH=aarch64` makes the target layout choice
   explicit while compiler A reads the real host filesystem.
3. Native pass-1 reports its version, checks `hello-world.sfn`, builds native
   pass-2, and must compare byte-for-byte equal with pass-2.
4. Pass-1 runs hello world and the on-device probe. The probe combines a struct
   return with `try`/`throw`, then writes a mode-0600 file and reads it through
   `fs.get_perms`; this covers the AArch64 aggregate-return, 512-byte `jmp_buf`,
   and `struct stat.st_mode` offset hazards in one native executable.

The script prints the fixed-point SHA-256 only after every gate succeeds.
