---
sfep: 0056
title: aarch64-Linux Target Support (Raspberry Pi Install + On-Device Self-Host)
status: Implemented
type: runtime
created: 2026-07-24
updated: 2026-08-10
author: "agent:compiler-architect"
tracking: [SFN-471, SFN-472, SFN-473, SFN-474, SFN-475, SFN-476, SFN-579, SFN-580, SFN-581, SFN-644, SFN-798, SFN-799, SFN-826]
supersedes:
superseded-by:
graduates-to: site/src/content/docs/docs/getting-started/install.md
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
edge/IoT/hobbyist on-ramp for a capability-secure systems language. When this
proposal was written, that on-ramp was **broken and, worse, falsely advertised**:

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

CI then built exactly three triples from a 2-entry matrix (`macos-26 →
macos-arm64`, `ubuntu-24.04 → linux-x86_64`, plus a windows cross-build on the
linux leg), mirrored across `release-tag.yml`, `release-branches.yml`, `ci.yml`,
`nightly-selfhost.yml`, `seed-test-bin.yml`, `benchmark.yml`, `perf-history.yml`,
and `build-quality.yml`. No aarch64-Linux leg existed at proposal time.

Two concrete on-device correctness hazards make "it's Linux, it'll just work"
false:

1. **`jmp_buf` buffer overrun.** *(Resolved — both halves now reserve 512.)* As
   written, `runtime/sfn/exception.sfn` malloc'd a **fixed 256-byte** buffer per
   exception frame, sized for x86_64 (200) / macOS-arm64 (192). The compiler
   also emits its own **stack** `jmp_buf` allocas — one per `try` and one in
   each `@main` wrapper — in `llvm/lowering/`, and it is those stack allocas,
   not the heap buffer, that compiler-emitted `try` actually executes. glibc
   **aarch64** `jmp_buf` is larger (`__jmpbuf[22]` longs + saved sigset ≈ 312
   bytes) → `setjmp` overruns the buffer. Hard blocker for any `try`/`throw` on
   a native aarch64 binary. SFN-471 raised the heap buffer to 512; SFN-644
   raised the three stack allocas, which that first fix left at 256 because the
   heap path is dead for compiler-emitted `try`.
2. **`struct stat` `st_mode` offset.** `lowering_debug_state.sfn`'s
   `stat_st_mode_offset_value()` originally keyed the offset on **OS only**
   (Linux → 24).
   glibc aarch64 reorders `struct stat` so `st_mode` is at offset **16**, not
   24, so the `fs_get_perms` sentinel reads the wrong field. The explicit LLVM
   provider context therefore needs an architecture dimension alongside its
   resolved target OS.

## 3. Design

### 3.1 Scope

**In:** aarch64-Linux (`ubuntu-24.04-arm` in CI; 64-bit Raspberry Pi OS as the
user target) — native build, native self-host, published seed asset, installer
support, advisory→blocking CI tier. **Out (explicit non-goal):**
32-bit Pi OS (armv7/armhf), rejected at `install.sh` arch detection — it needs
a whole 32-bit ABI/`long`-width/pointer story and its own epic. This SFEP does
not touch macOS arm64 or Windows.

### 3.2 The arch-detection seam (resolves deliverable (a))

The compiler already de-shelled host-OS detection (SFN-49):
`build/target.sfn` probes filesystem markers instead of shelling `uname -s`, so
a single binary bakes the correct platform legs on whatever host it runs on, and
a `SAILFIN_TARGET_OS` override wins first for cross-emit. The driver snapshots
that result into the explicit LLVM provider context. **We add the arch dimension
to that same snapshot.**

Resolve the provider's target architecture in
`build/llvm_provider_context.sfn`, using a filesystem-marker probe — the
aarch64 dynamic loader is at a well-known path — with x86_64 as the dominant
default (never wrong on the existing Tier-1 host):

```sfn
// build/llvm_provider_context.sfn — driver-owned context resolution.
// SAILFIN_TARGET_ARCH override wins first (cross-emit + e2e hook), else a
// non-shelling loader-path probe. "aarch64" | "x86_64" (uname -m style).
fn _resolve_llvm_target_arch() -> string ![io] {
    let override = _get_env_cmd("SAILFIN_TARGET_ARCH");
    if override.length > 0 { return override; }
    if fs.exists("/lib/ld-linux-aarch64.so.1") { return "aarch64"; }
    return "x86_64";
}
```

Why a loader-path probe (not a new runtime primitive): it is the same
filesystem-marker mechanism host-OS resolution and
`rlimit.sfn`/`sizes_linux.sfn` already use, needs
no new FFI (`uname(2)` binding), and stays correct under emulation — a
qemu-user x86_64 process on an aarch64 host sees the aarch64 host filesystem and
probes `aarch64`, which is exactly what the bootstrap needs (§3.4). The
`SAILFIN_TARGET_ARCH` override parallels `SAILFIN_TARGET_OS`: it is the
cross-emit hook and — critically — the **e2e test hook** that lets x86_64 CI
verify the aarch64 leg without an arm runner.

The seam has exactly **one** compiler-baked consumer: key
`stat_st_mode_offset_value()` on the `(os, arch)` pair — `Darwin → 4`,
`Linux + aarch64 → 16`, else `24`. Every other target-baked immediate is
arch-invariant on glibc and needs **no** change (verified §3.3).

### 3.3 The full arch-sensitive surface (resolves deliverables (d))

An audit of every target-divergent value the compiler bakes or the runtime
allocates:

| Value | Source | x86_64-Linux | aarch64-Linux | Action |
|---|---|---|---|---|
| `st_mode` offset in `struct stat` | `lowering_debug_state.sfn` `stat_st_mode_offset_value` | 24 | **16** | Key on the provider context's `(os, arch)`. |
| `jmp_buf` frame buffer size | `runtime/sfn/exception.sfn` (was 256, now 512); `llvm/lowering/instructions_try.sfn`, `llvm/lowering/emission.sfn`, and `llvm/lowering/lowering_core/test_harness.sfn` stack allocas (was 256, now 512) | 200 fits | **~312 overruns** | **Done.** Over-allocated to **512** on both the heap buffer (SFN-471) and the three stack allocas (SFN-644) — covers all three targets, needs **no** arch seam; the stack allocas also carry `align 16` for MSVC's `_JUMP_BUFFER` (SFN-549). |
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

Chicken-and-egg: the first native aarch64 self-host needed an aarch64 compiler,
but the pinned seed was x86_64 and could not execute natively on the ARM runner.
SFN-472 crossed that first wall by running the x86_64 seed under qemu-user on
`ubuntu-24.04-arm`, building an arch-aware compiler A, emitting native pass-1,
then using pass-1 to build pass-2 and asserting their fixed point. That path is
preserved for rebuilding legacy tags whose pinned release predates ARM assets.

The shipped steady state has two optimized consumers of that proof:

1. **Source PR and merge-queue CI.** `build-compiler-linux` first builds an
   arch-aware x86_64 compiler. `build-aarch64-cross-vehicle` uses an aarch64
   sysroot and `SAILFIN_TARGET_ARCH=aarch64` to cross-emit native pass-1 on the
   x86_64 runner. `build-compiler-aarch64-linux` runs pass-1 natively, builds
   pass-2, asserts the pass-1/pass-2 fixed point, and runs the smoke probe. This
   replaced a full qemu compiler build after live CI showed every frontend
   worker running under TCG without completing compiler A in the useful budget.
2. **Release builds and on-device self-host.** Once a release contains both the
   native and installer ARM64 payloads, the ARM release leg fetches that native
   seed and follows the ordinary `make rebuild` path. v0.9.3 carries the pair,
   and SFN-799 requires it before release publication or cadence seed pinning.
   `scripts/select-aarch64-seed-mode.sh` selects qemu only when rebuilding a
   legacy tag whose pinned release contains neither ARM payload.

**Key insight (why this avoids an inter-issue seed cut):** the first bring-up
builds the new compiler *from source* on the old seed, so the §3.3 fixes do
**not** need to pre-exist in the pinned seed for the aarch64 bring-up to consume
them. They land in a normal PR (x86_64 self-host stays green, §3.3). The **only**
seed cut is the ordinary release event that first produces the arm64 asset
— and that release is built from `main`, which already contains the fixes.
There is no separate "pin an aarch64 cross seed" step the way Windows needed
one. The current source-CI cross vehicle and the native-seed release path are
later performance/steady-state refinements; neither changes that original
delivery invariant.

### 3.5 Target tier (resolves deliverable (c))

SFEP-0037 §3.10 defines Tier 1 = Linux x86_64 (CI-blocking), Tier 2 = supported
native build and test targets, and Tier 3 = best effort. aarch64-Linux entered
as Tier 3: its result was visible but excluded from `required-ci` while the
native path accumulated evidence.

SFN-476 promoted the target to **Tier 2** after every written gate completed:
SFN-581 proved the published installer, native seed, on-device self-host, and a
complete green post-pin cycle; SFN-826 sharded and cached the source suite and
showed the ARM aggregate finishing before the established merge-critical
matrix; SFN-799 made both ARM64 payloads mandatory for release publication and
seed pinning; and v0.9.3 published the complete pair. Source pull requests and
merge queues now feed the cross vehicle, native fixed point and smoke probe,
shard-cover, and all ARM shards through `aarch64-linux-result` into
`required-ci`. The scheduled workflow separately fails on any cross-emit,
native fixed-point/probe, or cold `--no-test-cache` suite failure. The durable
policy and linked promotion evidence live in
`docs/conventions/target-tiers.md`.

### 3.6 The direct-ld.lld fast path (resolves deliverable (e))

SFN-473 shipped the aarch64 direct-`ld.lld` path. `resolve_direct_ld_lld`
accepts x86_64 or aarch64, reuses the provider target-architecture seam, and
selects the matching dynamic loader, emulation, multiarch library directories,
and GCC CRT directory. A missing target linker or CRT still returns `ok=false`
and falls back cleanly to the clang-driver link, preserving the original
correctness boundary while removing that fallback from configured ARM hosts.

## 4. Effect & capability impact

None. Effects and capability enforcement are arch-invariant; this epic is a
backend/runtime-platform port. The driver-side target-architecture resolver is
an ordinary `![io]` filesystem probe; the LLVM provider consumes only the pure
resolved context. The three pillars (effects, capabilities, concurrency) are
untouched.

## 5. Self-hosting impact

Every change is **additive and arch-gated**, so Linux-x86_64 and macOS-arm64
self-host stay green at every step:

- `build/llvm_provider_context.sfn` resolves `SAILFIN_TARGET_ARCH` and passes it
  into LLVM; `llvm/lowering_debug_state.sfn` keys
  `stat_st_mode_offset_value` on `(os, arch)`. The x86_64 branch returns 24 as
  before → **byte-identical** emitted IR on Tier 1.
- `runtime/sfn/exception.sfn` — the `jmp_buf` buffer constant grew 256 → 512
  (shipped, SFN-471). Plain Sailfin source; the old x86_64 seed compiling the
  new source produces a larger, still-correct allocation. No compiler-baked
  immediate involved.
- `llvm/lowering/instructions_try.sfn`, `llvm/lowering/emission.sfn`, and `llvm/lowering/lowering_core/test_harness.sfn` — the same
  256 → 512 widening for the three compiler-emitted stack `jmp_buf` allocas
  (shipped, SFN-644). This is compiler source, so widening it changes emitted IR — but
  the change is a pure alloca widening with no compiler-baked immediate on the
  consuming side either, so the old seed compiling this new compiler source is
  fine and the self-host invariant still holds by construction.
- `build/target.sfn`, `build/direct_link.sfn`, `build/clang_argv.sfn` — native
  aarch64 builds use clang's host-default triple. SFN-473 added the aarch64
  dynamic loader, emulation, multiarch directories, and GCC CRT probe to the
  direct-`ld.lld` resolver; unsupported or incomplete hosts retain the clang
  fallback.

The self-host invariant is preserved by construction: the first bring-up built
the new compiler from source via qemu; source CI now cross-emits native pass-1
from an arch-aware compiler and proves pass-1/pass-2 identity on ARM; release
builds use the published native seed, with qemu retained only for legacy tags.
None of these paths requires the aarch fixes to pre-exist in the original
x86_64 seed. Every milestone that could touch Tier-1 code paths was gated by
`make check` on Linux x86_64 before merge.

## 6. Alternatives considered

- **Compile-time arch constants / a `cfg`-style split** (per SFEP-0025 §2.9 Q7's
  per-target `.sfn` files). Rejected for now: Sailfin has no conditional
  compilation, and a runtime filesystem-marker probe (matching the shipped
  host-OS seam) keeps a single binary correct on every host with no new
  machinery — exactly the trade SFN-49 already made for host-OS.
- **A `uname(2)`/`GetNativeSystemInfo` runtime primitive** for arch. Rejected as
  overkill: it adds an FFI binding for a value a loader-path probe already yields,
  and the syscall form does not survive emulation-vs-native reasoning as cleanly
  as a host-filesystem probe.
- **Arch-aware `jmp_buf` sizing** (a per-arch constant) instead of a flat
  over-allocation. Rejected: the heap buffer is malloc'd per frame, so
  over-allocating it to 512 is harmless, but the compiler-emitted stack
  allocas (SFN-644) put those same 512 bytes on every `try`'s frame — a
  frame-size cost, not a free one. Still the right trade: it needs no arch
  seam and removes an entire arch branch from a hot exception path.
- **Cross-emit-from-x86_64 as the only bootstrap.** Rejected for first bring-up
  because it required an aarch64 sysroot + CRT before the native path had been
  proven. After SFN-472 established that proof, CI adopted cross-emission as the
  faster source-validation vehicle. Release and on-device self-host instead use
  the published native seed, while qemu remains the compatibility fallback for
  pre-ARM release tags.
- **Enter directly as Tier 2 (blocking CI).** Rejected: an aarch64-only
  miscompile or emulation flake would red-gate `main` before the leg has proven
  stable. Tier 3 → earned Tier 2 mirrors the Windows precedent and SFEP-0037's
  own policy.
- **Include armv7/armhf (32-bit).** Rejected as a non-goal: 32-bit needs a
  distinct pointer-width/`long`/ABI story; it is a separate epic.

## 7. Stage1 readiness mapping

This epic ports an existing pipeline to a new target rather than adding a
language construct; the checklist maps to the port surface:

- [x] Parses — n/a (no new syntax)
- [x] Type-checks / effect-checks — driver target resolvers are ordinary
      `![io]` fns and provider decisions are pure; `sfn check` clean
- [x] Emits valid `.sfn-asm` — n/a (arch-neutral IR unchanged)
- [x] Lowers to LLVM IR — `st_mode` offset re-keyed; verified by a forced-arch
      snapshot (§8)
- [x] Regression coverage — arch-seam snapshot (x86_64 CI) + aarch64 self-host +
      suite on `ubuntu-24.04-arm`
- [x] Self-hosts — native pass-1/pass-2 fixed point plus post-pin on-device
      self-host evidence (SFN-472, SFN-581)
- [x] `sfn fmt --check` clean — on every touched `.sfn`
- [x] Documented — `docs/status.md` tier row, `install.md` made truthful,
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
  `compiler/src/llvm/lowering_debug_state.sfn` (`stat_st_mode_offset_value`,
  errno/clock/nproc decisions), `compiler/src/build/llvm_provider_context.sfn`,
  `compiler/src/build/target.sfn` /
  `direct_link.sfn` / `clang_argv.sfn`, `compiler/src/cli/commands/package.sfn`
  and `toolchain.sfn` (client arch maps), `.github/workflows/release-tag.yml` /
  `release-branches.yml` / `ci.yml`, `site/.../getting-started/install.md`,
  `site/src/pages/dl.astro`.
