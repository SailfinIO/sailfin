# The aarch64 qemu bootstrap: a bash carve-out and its retirement condition

`scripts/bootstrap-aarch64-linux.sh` is the one bash script the toolchain keeps
that has **no native `sfn` path and no plan to get one**. This note records why,
so its survival past Makefile retirement (SFN-60, done) is a decision on the
record rather than an oversight found later.

It is a **legacy-tag-rebuild fallback**, not a permanent exemption. The
retirement condition is named in "When it retires" below.

## What it is exempt from

Two project rules that would otherwise forbid it:

- **`.claude/rules/no-bash-e2e.md`** — it is not an e2e test, so the `.sh` ban
  does not reach it. Its *regression coverage* is a proper Sailfin test
  (`compiler/tests/e2e/aarch64_binfmt_probe_test.sfn`) driving it through the
  `SAILFIN_BINFMT_PROBE_ONLY=1` seam.
- **Makefile retirement (SFN-60)** — the capability survives the Makefile. As of
  SFN-1078 there was no `make bootstrap-aarch64-linux` target; CI and humans
  invoked the script directly, so deleting the Makefile (now done) cost
  nothing here.

## Why it cannot go native

A genuine chicken-and-egg, and the reason this is a structural exemption rather
than unfinished work: the script runs the pinned **x86_64** seed under
`qemu-x86_64` to produce the *first* aarch64 binary. A native
`sfn dev bootstrap-aarch64` would have to run on the very binary it is
bootstrapping.

The three things it owns have no `sfn` equivalent and would not earn one:

- **qemu-user `binfmt_misc` registration and probing.** Probes by entry name,
  interpreter path, or raw ELF magic, and auto-registers via
  `update-binfmts --enable`. It deliberately never reads the write-only
  `register` node — that node is `S_IWUSR` with no read handler, so a probe
  that pipes the whole directory through one `grep` inherits grep's exit status
  2 and, under `pipefail`, reports "not registered" on every host where
  qemu-x86_64 was already enabled.
- **A `clang` PATH-shadowing wrapper for the x86_64 stage.** The seed resolves
  its C compiler by the bare name `clang` on `PATH`, so the script shadows it
  with a `--target=x86_64-linux-gnu -fuse-ld=lld` wrapper for that stage alone.
  A preflight links a trivial C file through the wrapper and fails immediately
  if the shadowing is not in effect — before spending ~30 minutes of emulated
  build.
- **ELF `e_machine` verification** via `readelf` at three build stages.

Note the *second* item is a shim the build driver could in principle own, and
one day should — but not for this script. See "What this note is not about".

## When it runs

Never in `ci.yml`. The merge-blocking Tier 2 aarch64 legs
(`docs/conventions/target-tiers.md`) do not touch it: `build-aarch64-cross-vehicle`
cross-emits pass-1 on an x86_64 runner and `build-compiler-aarch64-linux` builds
pass-2 natively on `ubuntu-24.04-arm`. No qemu, no `binfmt_misc`, no script.

Its only live trigger is a release leg — `release-tag.yml` or
`release-branches.yml`, through `.github/actions/sailfin-build/action.yml`,
gated on `arm_seed_mode == 'qemu'` — plus manual first bring-up on a host that
cannot fetch a native seed.

`arm_seed_mode` is resolved per run by `scripts/select-aarch64-seed-mode.sh`,
which probes the tag's *own* pinned seed release for both arm64 payloads:
`native` when both are present, `qemu` when both are absent, exit 1 on a half
set (a corrupted release, not a mode choice).

### One fallback, in one place

The qemu default lives in exactly one place — the callers' `Select aarch64 seed
mode` step, which falls back to `qemu` when the checked-out tag predates SFN-580
and therefore carries no probe to run. That fallback is correct and documented
in place: such a tag's pin is one the qemu bootstrap already handled.

Everything downstream of it fails closed instead of defaulting (SFN-1078):

- `action.yml`'s `arm_seed_mode` input has **no default**. An arm64 caller that
  omits it reaches the `Reject unknown aarch64 seed mode` guard and fails
  loudly.
- The release workflows pass `steps.arm_seed.outputs.mode` unmasked. The
  previous `|| 'qemu'` was dead for arm64 legs — that step always sets a mode or
  fails the job — but it would have silently absorbed any future path that
  skipped it, turning a bug into a 30-minute emulated build that still produced
  a correct binary. That is the expensive kind of silence: it does not fail, it
  just costs.

## When it retires

**Condition: the oldest release tag we still support rebuilding pins a seed
≥ v0.9.3.**

Not "when a published aarch64 seed exists" — one already does. Release
publication and cadence seed pinning have required the native + installer arm64
payload pair since **v0.9.3** (SFN-799/SFN-581), enforced by
`scripts/verify-arm64-release-assets.sh`. Every pin from that point forward
resolves `native`, so the script is already unreachable for current tags.

What keeps it alive is only the tail of history: tags pinned below that floor
have no arm64 asset to fetch, and rebuilding one is the sole remaining
execution path. When that tail falls out of support, delete the script, its
`arm_seed_mode == 'qemu'` steps, the emulated-sysroot provisioning steps in both
release workflows, `scripts/select-aarch64-seed-mode.sh`, and
`compiler/tests/e2e/aarch64_binfmt_probe_test.sfn` together.

## What this note is not about

**This is not how Sailfin cross-builds aarch64.** The live cross path is
`build-aarch64-cross-vehicle` in `ci.yml`, and it hand-rolls the same
`clang` PATH-shadow technique *inline in YAML* — twice — because
`target_clang_triple` (`compiler/src/build/target.sfn`) returns `""` for every
non-Windows triple, so the build driver emits no `-target` flag for a Linux
cross build and silently compiles for the host arch.

That is a real defect in the SFEP-0068 target model, tracked as **SFN-1117**,
and it is what should retire the *shim technique*. Retiring this script would
not fix it; fixing it would not retire this script. They are independent.

## References

- SFEP-0056 §3.4 (`docs/proposals/0056-aarch64-linux-target.md`) — the original
  bring-up and the two optimized consumers that replaced it
- `docs/build-aarch64-linux.md` — the executable procedure, host prerequisites,
  and env knobs
- `docs/conventions/target-tiers.md` — why Linux aarch64 is Tier 2 and on what
  evidence
