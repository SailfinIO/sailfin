---
sfep: 0056
title: aarch64-Linux Target Support (Raspberry Pi Install + On-Device Self-Host)
status: Accepted
type: runtime
created: 2026-07-24
updated: 2026-07-24
author: "agent:compiler-architect"
tracking: [SFN-471, SFN-472, SFN-473, SFN-474, SFN-475, SFN-476]
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0056 — aarch64-Linux Target Support (Raspberry Pi Install + On-Device Self-Host)

> Design deliverable for the **aarch64-Linux target support** epic (Build &
> Toolchain initiative, sibling of Native Windows Self-Host / SFEP-0021). No
> compiler code is written here — this enumerates the port surface, the
> arch-detection seam, the bootstrap path, and the ordered, session-sized
> milestones.

## 1. Summary

Make the Sailfin compiler **build, install, and self-host natively on 64-bit
Raspberry Pi OS (aarch64/arm64 Linux)**. The end state: a user runs the
`curl … | sh` installer on a Pi, gets a working `sfn`, and `make compile`
self-hosts on-device from a fetched native aarch64 seed. Because the runtime is
already pure Sailfin and the emitted IR is arch-neutral (macOS arm64 already
ships, proving the AArch64 ABI/codegen path), the work is **not** a codegen
port. It is: (a) a small **host-arch detection seam** feeding the two
arch-sensitive layout constants the compiler bakes/allocates, (b) an **aarch64
bootstrap** (the pinned x86_64 seed cannot run natively on arm64), and (c) **CI
+ release + installer** plumbing to build, gate, and publish an aarch64 seed
asset. Scope is **aarch64-Linux only**; 32-bit Pi OS (armv7/armhf) is an
explicit non-goal.

## 2. Motivation

The Raspberry Pi is the canonical low-cost aarch64-Linux target and a natural
edge/IoT/hobbyist on-ramp for a capability-secure systems language. Today that
on-ramp is **broken and, worse, falsely advertised**:

- `install.sh` already maps `aarch64|arm64 → arm64` and constructs
  `sailfin_<ver>_linux_arm64.tar.gz`, then **dies** because no such asset is
  ever published. `make fetch-seed` routes through `install.sh`, so a Pi cannot
  even fetch a seed.
- `site/.../getting-started/install.md` **already lists "Linux | arm64"** as
  supported — a support claim with no backing asset. `dl.astro` lists only the
  three real assets (linux-x86_64, macos-arm64, windows-x86_64).
- The client-side arch handling is already correct (`package.sfn` maps Linux
  aarch64 → `linux-arm64`; `toolchain.sfn` maps aarch64/arm64 → arm64). Only the
  **producer** side (CI matrices, release legs, the two arch-sensitive runtime
  constants, and a bootstrap) is missing.

CI builds exactly three triples from a 2-entry matrix (`macos-26 →
macos-arm64`, `ubuntu-24.04 → linux-x86_64`, plus a windows cross-build on the
linux leg), mirrored across `release-tag.yml`, `release-branches.yml`, `ci.yml`,
`nightly-selfhost.yml`, `seed-test-bin.yml`, `benchmark.yml`, `perf-history.yml`,
and `build-quality.yml`. No aarch64-Linux leg exists anywhere.

Two concrete on-device correctness hazards make "it's Linux, it'll just work"
false:

1. **`jmp_buf` buffer overrun.** `runtime/sfn/exception.sfn` malloc's a **fixed
   256-byte** buffer per exception frame, sized for x86_64 (200) / macOS-arm64
   (192). glibc **aarch64** `jmp_buf` is larger (`__jmpbuf[22]` longs + saved
   sigset ≈ 312 bytes) → `setjmp` overruns the buffer. Hard blocker for any
   `try`/`throw` on a native aarch64 binary.
2. **`struct stat` `st_mode` offset.** `lowering_debug_state.sfn`'s
   `stat_st_mode_offset_value()` keys the offset on **OS only** (Linux → 24).
   glibc aarch64 reorders `struct stat` so `st_mode` is at offset **16**, not
   24, so the `fs_get_perms` sentinel reads the wrong field. The host-detection
   locators (`_host_os()`) have **no arch dimension** — that is the seam this
   SFEP adds.

## 3. Design

### 3.1 Scope

**In:** aarch64-Linux (`ubuntu-24.04-arm` in CI; 64-bit Raspberry Pi OS as the
user target) — native build, native self-host, published seed asset, installer
support, advisory→blocking CI tier. **Out (explicit non-goal):**
32-bit Pi OS (armv7/armhf), rejected at `install.sh` arch detection — it needs
a whole 32-bit ABI/`long`-width/pointer story and its own epic. This SFEP does
not touch macOS arm64 or Windows.

### 3.2 The arch-detection seam (resolves deliverable (a))

The compiler already de-shelled host-OS detection (SFN-49): `_host_os()` in
`llvm/lowering_debug_state.sfn` (mirrored by `_build_host_os()` in
`build/target.sfn`) probes filesystem markers instead of shelling `uname -s`, so
a single binary bakes the correct platform legs on whatever host it runs on, and
a `SAILFIN_TARGET_OS` override wins first for cross-emit. **We add the arch
dimension the exact same way.**

Introduce `_host_arch()` beside `_host_os()`, using a filesystem-marker probe —
the aarch64 dynamic loader is at a well-known path — with x86_64 as the dominant
default (never wrong on the existing Tier-1 host):

```sfn
// llvm/lowering_debug_state.sfn — mirrors _host_os() (SFN-49).
// SAILFIN_TARGET_ARCH override wins first (cross-emit + e2e hook), else a
// non-shelling loader-path probe. "aarch64" | "x86_64" (uname -m style).
fn _host_arch() -> string ![io] {
    let override = _get_env_cmd("SAILFIN_TARGET_ARCH");
    if override.length > 0 { return override; }
    if fs.exists("/lib/ld-linux-aarch64.so.1") { return "aarch64"; }
    return "x86_64";
}
```

Why a loader-path probe (not a new runtime primitive): it is byte-for-byte the
same mechanism `_host_os()` and `rlimit.sfn`/`sizes_linux.sfn` already use, needs
no new FFI (`uname(2)` binding), and stays correct under emulation — a
qemu-user x86_64 process on an aarch64 host sees the aarch64 host filesystem and
probes `aarch64`, which is exactly what the bootstrap needs (§3.4). The
`SAILFIN_TARGET_ARCH` override parallels `SAILFIN_TARGET_OS`: it is the
cross-emit hook and — critically — the **e2e test hook** that lets x86_64 CI
verify the aarch64 leg without an arm runner.

The seam has exactly **one** compiler-baked consumer: re-key
`stat_st_mode_offset_value()` on the `(os, arch)` pair — `Darwin → 4`,
`Linux + aarch64 → 16`, else `24`. Every other target-baked immediate is
arch-invariant on glibc and needs **no** change (verified §3.3).

### 3.3 The full arch-sensitive surface (resolves deliverables (d))

An audit of every target-divergent value the compiler bakes or the runtime
allocates:

| Value | Source | x86_64-Linux | aarch64-Linux | Action |
|---|---|---|---|---|
| `st_mode` offset in `struct stat` | `lowering_debug_state.sfn` `stat_st_mode_offset_value` | 24 | **16** | Re-key on `(os, arch)` via `_host_arch()`. |
| `jmp_buf` frame buffer size | `runtime/sfn/exception.sfn` (256) | 200 fits | **~312 overruns** | Over-allocate the fixed buffer to **512** (covers all three targets; heap-malloc'd, so oversizing is harmless and needs **no** arch seam). |
| `errno` locator symbol | `errno_locator_symbol` | `__errno_location` | `__errno_location` (glibc-common) | none |
| `CLOCK_MONOTONIC` id | `clock_monotonic_id_value` | 1 | 1 (glibc-common) | none |
| `_SC_NPROCESSORS_ONLN` | `sc_nprocessors_onln_value` | 84 | 84 (glibc-defined) | none |
| `struct stat` buffer size | `stat_buf_size_value` (160) | 144 | 128 | none (160 over-allocates both) |
| `dirent.d_name` offset | `sizes_linux.sfn` | — | already aarch64-safe | none |
| `pthread_t`/mutex layout | `pthread_layout.sfn` | — | already aarch64-safe | none |
| clang `-target` triple | `build/target.sfn` `target_clang_triple` | "" (host default) | "" (host default) | none — clang's native aarch64 default triple (`aarch64-unknown-linux-gnu`) is correct for a native build |

**Net runtime/compiler surface:** exactly one baked immediate (`st_mode`) needs
the arch seam, and one runtime constant (`jmp_buf`) needs an over-allocation
bump. Both are additive: on x86_64 the arch branch returns 24 (identical to
today), and 512 ≥ 256 is a strictly-larger allocation — so **x86_64 self-host is
byte-identical for `st_mode` and behaviorally unchanged for exceptions.** macOS
arm64 is gated by `Darwin` and is untouched.

### 3.4 The aarch64 bootstrap (resolves deliverable (b))

Chicken-and-egg: native aarch64 self-host needs an aarch64 seed, but the pinned
seed is x86_64 (or macOS arm64) and cannot execute natively on an arm64 runner.
The Windows epic (SFEP-0021 §4.3) solved the analogous wall with a mingw
cross-emit vehicle. Here the cleaner vehicle is **qemu-user emulation on a native
arm64 runner**, because clang on the arm runner is already native aarch64:

**Bootstrap sequence (all on `ubuntu-24.04-arm`):**

1. **Stage 0 — seed under emulation.** Register x86_64 binfmt (`qemu-user`) and
   run the pinned **x86_64 seed** under `qemu-x86_64`. It orchestrates a build;
   the `clang`/linker it spawns are **native aarch64**.
2. **Stage 1 — arch-aware compiler A (x86_64/emulated).** The seed builds the
   new compiler *from source* (which carries §3.2/§3.3). Compiler A is an x86_64
   binary that runs under qemu but **is arch-aware**.
3. **Stage 2 — first native aarch64 compiler B (pass-1).** Compiler A (under
   qemu) builds the compiler from source targeting the native host. Because A is
   arch-aware and its `_host_arch()` probes the **real aarch64 host filesystem**,
   it bakes `st_mode = 16` and the runtime source's 512-byte `jmp_buf` — so
   **pass-1 is already arch-correct**, emitted by an arch-aware compiler. clang
   compiles it to native aarch64.
4. **Stage 3 — native self-host fixed point.** Pass-1 (native) builds pass-2
   (seedcheck); assert `pass-1 == pass-2` and `hello-world` runs. This is the
   self-host proof.
5. **Stage 4 — publish + pin.** The release workflow runs Stages 0–3 on
   `ubuntu-24.04-arm` and publishes a native `sailfin_<ver>_linux_arm64.tar.gz`
   seed. The cadence auto-pin bumps `bootstrap.toml [seed].version`; from that
   release onward a Pi `make fetch-seed` downloads a **native** aarch64 seed and
   on-device self-host no longer needs qemu.

**Key insight (why this avoids an inter-issue seed cut):** the bootstrap builds
the new compiler *from source* on the old seed at Stage 1, so the §3.3 fixes do
**not** need to pre-exist in the pinned seed for the aarch64 bring-up to consume
them. They land in a normal PR (x86_64 self-host stays green, §3.3). The **only**
seed cut is the ordinary release event that first produces the arm64 asset
(Stage 4) — and that release is built from `main`, which already contains the
fixes. There is no separate "pin an aarch64 cross seed" step the way Windows
needed one.

The `SAILFIN_TARGET_ARCH` override (from §3.2) also enables an **alternative**
cross-emit-from-x86_64 bootstrap (build the new compiler on an x86_64 runner,
cross-emit with `SAILFIN_TARGET_ARCH=aarch64` + `clang -target
aarch64-linux-gnu` + an aarch64 sysroot). We prefer the qemu path as primary —
it needs **no** cross sysroot (clang is native on the arm runner) — and keep the
cross-emit path documented as the mechanism a future first-class `sfn build
--target=aarch64-linux-gnu` generalizes to.

### 3.5 Target tier (resolves deliverable (c))

SFEP-0037 §3.10 defines Tier 1 = Linux x86_64 (CI-blocking), Tier 2 = macOS
arm64 (builds+tests in CI), Tier 3 = best-effort (Windows enters here).
aarch64-Linux **enters as Tier 3**: its first CI leg is **advisory**
(`continue-on-error`, non-blocking) so a transient emulation flake or an
aarch64-only miscompile does not red-gate `main`. It **earns promotion to Tier
2** by written criteria — a full green cycle of build + suite + triple-pass
self-host on `ubuntu-24.04-arm` — at which point the leg flips to blocking. The
promotion is a discrete gated event (mirroring Windows' Tier-3→2 path), so it is
its own milestone (§5, Issue 6), not folded into stand-up. Note: SFEP-0037
§3.10's `docs/conventions/target-tiers.md` has **not** landed yet; the promotion
issue creates it (or appends the aarch64 row if it has by then).

### 3.6 The direct-ld.lld fast path (resolves deliverable (e))

`build/direct_link.sfn`'s `resolve_direct_ld_lld` **hard-gates on `arch ==
x86_64`** and hardcodes `/usr/lib/x86_64-linux-gnu` multiarch dirs +
`/lib64/ld-linux-x86-64.so.2`. On aarch64 it returns `ok=false` and the driver
**falls back to the clang-driver link cleanly** — so the fast path is a
performance optimization, **not** a correctness blocker. It is therefore
**deferred, in-scope-but-optional** (§5, Issue 5, `Performance`): teach the arch
gate + `aarch64-linux-gnu` multiarch dirs + `/lib/ld-linux-aarch64.so.1` + an
aarch64 `_gcc_crt_dir` probe, reusing `_host_arch()`. It can land any time after
the seam (Issue 1) and does not gate the seed, the self-host, or the release.

## 4. Effect & capability impact

None. Effects and capability enforcement are arch-invariant; this epic is a
backend/runtime-platform port. `_host_arch()` and the layout resolvers are
ordinary `![io]` filesystem probes, consistent with the existing `_host_os()`
locators. The three pillars (effects, capabilities, concurrency) are untouched.

## 5. Self-hosting impact

Every change is **additive and arch-gated**, so Linux-x86_64 and macOS-arm64
self-host stay green at every step:

- `llvm/lowering_debug_state.sfn` — adds `_host_arch()` + `SAILFIN_TARGET_ARCH`
  and re-keys `stat_st_mode_offset_value` on `(os, arch)`. The x86_64 branch
  returns 24 as before → **byte-identical** emitted IR on Tier 1.
- `runtime/sfn/exception.sfn` — the `jmp_buf` buffer constant grows 256 → 512.
  Plain Sailfin source; the old x86_64 seed compiling the new source produces a
  larger, still-correct allocation. No compiler-baked immediate involved.
- `build/target.sfn`, `build/direct_link.sfn`, `build/clang_argv.sfn` — the
  native aarch64 build uses clang's **host-default** triple, so no `-target`
  work is needed for the native path (unlike Windows). Only the optional
  direct-link fast path (Issue 5) grows an aarch64 arch dimension.

The self-host invariant is preserved by construction: the aarch64 bring-up
builds the new compiler from source via the qemu bootstrap (§3.4), never
requiring the fixes to pre-exist in the pinned seed. Every milestone that could
touch Tier-1 code paths (Issue 1) is gated by `make check` on Linux x86_64
before merge.

## 6. Alternatives considered

- **Compile-time arch constants / a `cfg`-style split** (per SFEP-0025 §2.9 Q7's
  per-target `.sfn` files). Rejected for now: Sailfin has no conditional
  compilation, and a runtime filesystem-marker probe (matching the shipped
  `_host_os()` seam) keeps a single binary correct on every host with no new
  machinery — exactly the trade SFN-49 already made for host-OS.
- **A `uname(2)`/`GetNativeSystemInfo` runtime primitive** for arch. Rejected as
  overkill: it adds an FFI binding for a value a loader-path probe already yields,
  and the syscall form does not survive emulation-vs-native reasoning as cleanly
  as a host-filesystem probe.
- **Arch-aware `jmp_buf` sizing** (a per-arch constant) instead of a flat
  over-allocation. Rejected: the buffer is heap-malloc'd per frame, so
  over-allocating to 512 is harmless, needs no arch seam, and removes an entire
  arch branch from a hot exception path.
- **Cross-emit-from-x86_64 as the primary bootstrap.** Rejected as primary
  (kept as documented alternative): it needs an aarch64 cross sysroot + CRT on
  the x86_64 runner, whereas the qemu path reuses the arm runner's native clang
  with zero sysroot plumbing. Cross-emit remains the shape a future `sfn build
  --target` generalizes.
- **Enter directly as Tier 2 (blocking CI).** Rejected: an aarch64-only
  miscompile or emulation flake would red-gate `main` before the leg has proven
  stable. Tier 3 → earned Tier 2 mirrors the Windows precedent and SFEP-0037's
  own policy.
- **Include armv7/armhf (32-bit).** Rejected as a non-goal: 32-bit needs a
  distinct pointer-width/`long`/ABI story; it is a separate epic.

## 7. Stage1 readiness mapping

This epic ports an existing pipeline to a new target rather than adding a
language construct; the checklist maps to the port surface:

- [ ] Parses — n/a (no new syntax)
- [ ] Type-checks / effect-checks — `_host_arch()` and resolvers are ordinary
      `![io]` fns; `sfn check` clean
- [ ] Emits valid `.sfn-asm` — n/a (arch-neutral IR unchanged)
- [ ] Lowers to LLVM IR — `st_mode` offset re-keyed; verified by a forced-arch
      snapshot (§8)
- [ ] Regression coverage — arch-seam snapshot (x86_64 CI) + aarch64 self-host +
      suite on `ubuntu-24.04-arm`
- [ ] Self-hosts — aarch64 triple-pass fixed point (Issue 2/3)
- [ ] `sfn fmt --check` clean — on every touched `.sfn`
- [ ] Documented — `docs/status.md` tier row, `install.md` made truthful,
      `dl.astro` arm64 row, `target-tiers.md`

## 8. Test plan

- **Arch seam (x86_64 CI, no arm runner needed):** a `compiler/tests/e2e`
  `*_test.sfn` that emits a fixture exercising the `fs_get_perms` sentinel under
  `SAILFIN_TARGET_ARCH=aarch64` and asserts the emitted `.ll` bakes the `st_mode`
  offset **16** (and, unset, still bakes **24**). Proves the arch dimension
  mechanically on Tier-1 CI.
- **`jmp_buf` regression:** existing exception/try-throw e2e coverage runs on the
  aarch64 leg; the 512-byte buffer is exercised by the first native `try`/`throw`.
  A struct-return + try/throw fixture guards the AArch64 aggregate-return
  legalizer hazard (`docs/conventions/runtime-helpers.md`) that no aarch64 CI has
  caught before — a value round-trip equality assert.
- **Native bootstrap + self-host (aarch64 leg):** `--version` and `check
  examples/basics/hello-world.sfn` exit 0; triple-pass `pass-1 == pass-2` fixed
  point; the full suite green under `ubuntu-24.04-arm`.
- **Installer/seed:** on the arm64 asset's first release, `make fetch-seed` on an
  aarch64 host resolves and unpacks `sailfin_<ver>_linux_arm64.tar.gz`; the
  fetched native seed self-hosts on-device.

## 9. References

- SFEP-0021 (Native Windows Self-Host) — the structural template: host-detection
  de-shell (SFN-49), target conditioning (SFN-52), first native build (SFN-53),
  self-host fixed point (SFN-54), CI leg (SFN-55), seed publish + release +
  fetch-seed (SFN-57), bootstrap-vehicle reasoning (§4.3).
- SFEP-0037 §3.10 (target tier policy) — Tier 1/2/3 definitions;
  `docs/conventions/target-tiers.md`.
- SFEP-0025 §2.9 Q7 / §3.8 (native runtime architecture) — platform-conditional
  compilation deferral; the per-target-`.sfn` alternative this SFEP declines.
- SFEP-0026 / `.claude/rules/seed-dependency.md` — bundle-vs-split + seed-cut
  discipline (§3.4).
- Code: `install.sh` (arch detection, already arm64-ready), `Makefile`
  `fetch-seed`, `runtime/sfn/exception.sfn` (`jmp_buf`),
  `compiler/src/llvm/lowering_debug_state.sfn` (`_host_os`, `stat_st_mode_offset_value`,
  errno/clock/nproc locators), `compiler/src/build/target.sfn` /
  `direct_link.sfn` / `clang_argv.sfn`, `compiler/src/cli/commands/package.sfn`
  and `toolchain.sfn` (client arch maps), `.github/workflows/release-tag.yml` /
  `release-branches.yml` / `ci.yml`, `site/.../getting-started/install.md`,
  `site/src/pages/dl.astro`.
