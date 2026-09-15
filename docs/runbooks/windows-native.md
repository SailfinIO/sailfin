# Windows native self-host runbook

`.github/workflows/windows-native-selfhost.yml` is the unconditional deep
backstop to the merge-blocking native Windows build and eight-shard suite in
`ci.yml`. It runs nightly at 08:00 UTC and on manual `workflow_dispatch`.
Pull requests get fast, owned shard coverage; this workflow adds the strict
fixed point and complete uncached suite.

It proves two things in sequence:

1. **The native MSVC build itself** — `native-build` (windows-2025) fetches
   the PUBLISHED native MSVC seed named by `bootstrap.toml [seed].version`,
   verifies it (ed25519 signature over `SHA256SUMS`, then the archive's
   SHA-256, against the committed key at
   `.github/release-signing/ed25519-release.pub.pem` — SFN-994), stages it,
   and runs the SFN-53 diagnostic ladder plus the boot / check / run / R1
   (try-throw) / R3 (struct-channel) ABI gates via the shared
   `.github/actions/sailfin-build-windows` composite. Verification uses the
   PowerShell verifier's embedded Ed25519 implementation and fails closed on a
   missing/404 asset, bad signature, or bad digest, with no fallback artifact
   (§1b).
2. **The self-host fixed point** (M8/SFN-54) — the native compiler rebuilds
   itself twice, and pass-2 must be byte-identical to pass-1.

When the job fails, or is cancelled after it started (a
`timeout-minutes` expiry, not an expected concurrency supersede — see
§2 below), the `notify-failure` job opens a deduplicated regression issue
labeled `area:architecture` and `windows-native-regression`. The issue title
suffix names the failing gate — four values, checked most-specific first in
the `Identify failed gate` step:

- `windows-selfhost-passes` — the native compiler itself failed to complete
  either self-host pass (the `Self-host pass 1 + pass 2 (native MSVC)` step).
- `windows-fixed-point` — both passes completed but pass-2 was not
  byte-identical to pass-1 (a genuine determinism break).
- `windows-native-package` — the fixed point held but the installer step
  failed: either `sfn package --installer` itself, or the subsequent
  `actions/upload-artifact` step (`if-no-files-found: error`, or a transient
  5xx). Either way the compiler is proven good and the installer is what's
  missing — triage the packaging/upload step, not the self-host passes.
- `windows-native-build` — the fallback for anything not matched by the
  values above: seed staging (including a seed-fetch/verification failure —
  see §1b), the SFN-53 diagnostic ladder, the Stage 2 build, or an R1/R3 ABI
  gate.

This page is the triage runbook for those regressions.

---

## 1. Reproduce locally

The native MSVC build and the fixed point both require a `windows-2025`-
equivalent host (MSVC + UCRT + `lld-link`) — they cannot be reproduced on
Linux or macOS. On a Windows host with the toolchain from
`ilammy/msvc-dev-cmd@v1` on `PATH`:

```bash
# Fetch + verify the published native MSVC seed (SFN-994). The PowerShell
# verifier has no OpenSSL dependency. $ver is `bootstrap.toml [seed].version`.
ver=<bootstrap.toml [seed].version>
pwsh -File .github/actions/sailfin-build-windows/verify-release-seed.ps1 -Version "$ver"
mkdir -p seed
tar -xzf "seed-dl/sailfin_${ver}_windows_x86_64-msvc.tar.gz" -C seed
SEED_EXE="$(find "$PWD/seed" -name sailfin.exe | head -1)"

SAILFIN_TARGET_OS=Windows "$SEED_EXE" build -p compiler
NATIVE_SFN=<path to the resulting compiler.exe / sfn.exe under build/>

# Fixed point: two isolated passes, `--no-cache` on both, with
# `SAILFIN_BOOTSTRAP=off` (SFN-1035). On a `chore(release): X` commit,
# `compiler/capsule.toml` is ahead of `bootstrap.toml [seed].version` until
# the cadence seed-pin PR lands, so without the override
# `bootstrap_gate_or_dispatch` sees running != pin and dispatches both passes
# to the *previous* release's seed instead of testing `$NATIVE_SFN` itself —
# reproducing the wrong compiler, not the one this gate exists to check.
SAILFIN_TEST_SCRATCH=build/selfhost/native-w1/scratch \
  SAILFIN_BOOTSTRAP=off "$NATIVE_SFN" build --no-cache -p compiler \
    --work-dir build/selfhost/native-w1 -o build/selfhost/fp1/sfn-selfhost1.exe
SAILFIN_TEST_SCRATCH=build/selfhost/native-w2/scratch \
  SAILFIN_BOOTSTRAP=off build/selfhost/fp1/sfn-selfhost1.exe build --no-cache -p compiler \
    --work-dir build/selfhost/native-w2 -o build/selfhost/fp2/sfn-selfhost2.exe

cmp build/selfhost/fp1/sfn-selfhost1.exe build/selfhost/fp2/sfn-selfhost2.exe
```

If a `windows-native-build` regression does not reproduce with the exact
seed and target from the failing run, the regression is environment-specific
— attach the failing run's log excerpt to the issue and request a
maintainer rerun before bisecting.

If a `windows-fixed-point` regression does not reproduce, check SFN-920
first (`/Brepro` threaded through `lld-link`): its absence makes the byte
compare flaky at PE byte 129 regardless of genuine compiler determinism.

### 1a. Validating ordinary Windows codegen/runtime changes without a Windows host

§1's fixed point and the native MSVC build genuinely need a `windows-2025`
host — but that is not the only way to validate a change to Windows-leg
codegen or a `platform/*_windows.sfn` runtime sibling. An ordinary MSVC
**cross-build + interop** run works from this Linux host whenever a Visual
Studio Build Tools + Windows SDK layout is mounted (as it is here), and WSL's
`binfmt_misc` execs the resulting PE directly — no `cmd.exe` wrapper, no
Windows host at all:

```bash
VC="/mnt/c/Program Files (x86)/Microsoft Visual Studio/18/BuildTools/VC/Tools/MSVC/14.51.36231"
SDK="/mnt/c/Program Files (x86)/Windows Kits/10"; SDKVER="10.0.26100.0"
export LIB="$VC/lib/x64;$SDK/Lib/$SDKVER/ucrt/x64;$SDK/Lib/$SDKVER/um/x64"
export INCLUDE="$VC/include;$SDK/Include/$SDKVER/ucrt;$SDK/Include/$SDKVER/um;$SDK/Include/$SDKVER/shared"
export SAILFIN_TARGET_TRIPLE=x86_64-pc-windows-msvc
export CC=clang-18          # NOT bare `clang` — that resolves to a different, older clang
build/bin/sfn build probe.sfn -o probe.exe
./probe.exe                 # WSL binfmt_misc execs PE directly
```

This proves the codegen emits correct IR for the target, that MSVC/`lld-link`
accept it, and that the compiled behavior is right — the same class of bug
(a per-target sentinel silently stubbed `false`) that this exact recipe
caught for SFN-993's `fs.mkdtemp`. It is genuinely useful signal, not a
placebo.

**What it does NOT cover**, and where those still require the real thing:

- **The native MinGW target link** (`sfn build
  --target=x86_64-w64-mingw32`) — a separate toolchain (mingw-w64, not
  MSVC). Runtime policy is shared through `runtime/capsule.toml`, but the
  actual CRT/import libraries still differ, so run this command whenever a
  change touches `platform/*_windows.sfn`.
- **The native-MSVC self-host fixed point** (§1 above) — the pass-1/pass-2
  byte-identity proof only exists on the real `windows-2025` host, since it
  needs a compiler binary that itself already runs on Windows.

### 1b. A seed-fetch or verification failure is not a compiler regression

Since SFN-994, `native-build` bootstraps from a fetched, signed artifact
instead of a same-run build, so it can now fail for reasons that predate
this checkout's compiler ever running. Both fail during the `Fetch and
verify the native release seed` / `Stage the release seed` steps
(`.github/actions/sailfin-build-windows/action.yml`, driving
`verify-release-seed.ps1`) — before the SFN-53 ladder, the Stage 2 build, or
the fixed point — so they land under the `windows-native-build` catch-all
gate, whose name reads as a compiler problem when it is not one:

- **404 on the seed asset.** The release named by `bootstrap.toml
  [seed].version` never published a native MSVC asset. As of SFN-1024 the
  msvc payload is required by `scripts/verify-release-payloads.sh`, so this
  can no longer happen for a release cut after that change — but a pin can
  still name a pre-SFN-1024 release, since `cadence-seed-pin.yml` does not
  itself check for the msvc asset's presence. `verify-release-seed.ps1` says
  so directly in its thrown error — it spells out that this is "NOT a
  regression in this checkout" and to "fix the release or the pin." Do
  that; do not add a
  mingw fallback to the verifier — the script's own comment rules it out by
  design.
- **Signature or digest mismatch.** The `SHA256SUMS` ed25519 signature
  failed to verify against `.github/release-signing/ed25519-release.pub.pem`,
  or the archive's SHA-256 does not match the signed manifest. Treat this as
  a release-infrastructure incident — a corrupted or tampered asset, or a
  signing-key mismatch — and escalate immediately rather than working
  around it: the verifier has no downgrade path or override knob, by design.
Both are outside `compiler/src/` and `compiler/capsules/` — do not
bisect commits under §3 for a failure that happened before the compiler
under test ever ran.

---

## 2. Cancelled vs. failed

`native-build` can end up `cancelled` for two different reasons, and only one
of them is a regression:

- **Expected concurrency coalescing.** Manual `workflow_dispatch` runs share
  one concurrency group per ref with `cancel-in-progress: true` (SFN-55
  review A1). A newer dispatch can therefore cancel an older in-flight run.
  `notify-failure`'s classify step checks whether a newer run of the same ref
  has since started; if so, it skips notification.
- **A genuine timeout.** `native-build` carries a 360-minute job timeout;
  within it, the `Self-host pass 1 + pass
  2 (native MSVC)` step carries its own 30-minute step timeout, and the
  downstream `Gate — self-host fixed point (pass-2 == pass-1)` comparison
  step carries a separate 5-minute step timeout — a step-level timeout
  surfaces as `failure`, not `cancelled` (see §1's "either job fails"). If
  this run is still the newest of its event type/ref and shows `cancelled`,
  it hit the job-level cap. Check the job log for where it stopped — typically
  a heartbeat gap in `native-build`'s Stage 2 build step — and treat it as a
  build-setup regression (SFN-55 §2's measured budget: ~13m30s
  build+boot+ABI, ~14m27s for both fixed-point passes; a run running
  meaningfully longer than that on a warm-cache run is itself the finding).

`schedule` runs never cancel each other or a manual run — the concurrency
group is keyed by `github.event_name`, not just `github.ref` (SFN-55 review
A1).

---

## 3. Bisect

Bisecting a native-Windows-only regression requires the Windows host from
§1 for every candidate commit — there is no Linux-reproducible harness for
either the ABI gates or the fixed point. Narrow the range using the failing
run's SHA and the last known-green `windows-native-selfhost.yml` run before
bisecting on-host:

```bash
git bisect start
git bisect bad <failing-sha-from-issue>
git bisect good <known-good-sha>   # last green windows-native-selfhost.yml run
```

Mark a commit `skip` (or exit 125 in a scripted bisect) if the native MSVC
build itself does not complete at that commit — that is a different
regression than an ABI-gate or fixed-point failure at a commit that does
build.

---

## 4. File a fix issue

Once the offending commit is identified, file a fix issue with:

- `type:bug`
- `area:compiler` (ABI-gate / codegen regressions) or `area:build`
  (native-build/link regressions)
- `seed-blocker` if the fix must land before the next seed cut. The design
  note's §8 gates M11/SFN-57 on tier B staying green; that publication has
  since shipped (v0.10.3 was the first release carrying a native msvc
  asset), so the dependency now runs the other way — tier B *consumes* the
  published seed, and a red nightly can mean the release or the pin is at
  fault rather than this checkout. See §1b before reaching for this label.

Set the fix issue's Linear-native priority per severity (a Windows-only
regression does not block the Linux/macOS release train, but a persistent
one erodes the tier the note staged this work at — see §5 below).

The fix issue's body should `Closes` the regression issue
(`windows-native regression: <gate>`) so the dedup anchor closes
automatically on merge.

---

## 5. Escalation

Per the design note (`docs/proposals/design-notes/sfn-55-windows-ci.md` §6), an
open `windows-native-regression` issue older than one week means the Windows
leg is rotting again. The original escalation was to drop the native build's
path filter; that escalation has been completed. Both `build-compiler-windows`
and the eight `build-windows` shards now run for every source-scoped PR, so an
extended regression requires investigation rather than further filter changes.
