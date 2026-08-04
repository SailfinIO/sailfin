# Bootstrapping a native aarch64-Linux compiler

The first native aarch64 compiler is bootstrapped on an aarch64 host from the
pinned x86_64 seed. This is the executable procedure for SFEP-0056 §3.4 and
SFN-472; it is intentionally not a CI or release-publishing workflow.

## Host prerequisites

Use Ubuntu 24.04 arm64 (a physical host, VM, or native arm runner) with:

- `qemu-user`/`qemu-user-binfmt` (the script enables the x86_64 registration
  through `update-binfmts` when passwordless privilege is available);
- `clang`, `lld`, `readelf`, and `sha256sum`;
- an x86_64 glibc development sysroot and the x86_64 development libraries
  needed by the compiler link (`libc`, pthread, math, OpenSSL, and crypto),
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

Download the **x86_64 Linux** asset for the exact version in
`bootstrap.toml [seed].version`; do not use the host-architecture selection in
`make fetch-seed`, because no aarch64 seed exists during first bring-up.

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
