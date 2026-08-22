# Windows native self-host runbook

`.github/workflows/windows-native-selfhost.yml` is SFN-55 (SFEP-0021 M9)
**tier B**: the unconditional backstop to `ci.yml`'s path-filtered
`build-compiler-windows` (tier A). It runs on every `push` to `main`, once
nightly at 08:00 UTC, and on manual `workflow_dispatch`, with no path
filter — that asymmetry is deliberate (SFN-55 §4.3): tier A only fires on
PRs whose changed paths match the Windows glob, so tier B is what catches a
false negative in that filter, at up to 24h latency instead of never.

It proves two things in sequence:

1. **The native MSVC build itself** — `native-build` (windows-2025) fetches
   the PUBLISHED native MSVC seed named by `bootstrap.toml [seed].version`,
   verifies it (ed25519 signature over `SHA256SUMS`, then the archive's
   SHA-256, against the committed key at
   `.github/release-signing/ed25519-release.pub.pem` — SFN-994), stages it,
   and runs the SFN-53 diagnostic ladder plus the boot / check / run / R1
   (try-throw) / R3 (struct-channel) ABI gates via the shared
   `.github/actions/sailfin-build-windows` composite. Verification fails
   closed: a missing/404 asset, a bad signature, a bad digest, or missing
   OpenSSL all abort the job, with no fallback to the mingw asset (§1b).
2. **The self-host fixed point** (M8/SFN-54) — the native compiler rebuilds
   itself twice, and pass-2 must be byte-identical to pass-1.

`cross-seed` (ubuntu) still runs, but no longer feeds `native-build`
(SFN-994 dropped `needs: cross-seed`, so the two jobs now run in parallel).
It stays for two reasons: to keep `make ci-cross-windows` exercised
nightly, and to keep the `seed_source: cross` escape hatch on the shared
composite proven, in case a bad release seed ever ships. SFN-58 deletes
both jobs together once the release-seed path has soaked.

When either job fails, or either job is cancelled after it started (a
`timeout-minutes` expiry, not an expected concurrency supersede — see
§2 below), the `notify-failure` job opens a deduplicated regression issue
labeled `area:architecture` and `windows-native-regression`. The issue title
suffix names the failing gate — five values now. Four are checked
most-specific first in the `Identify failed gate` step, scoped to the
`native-build` job (`windows-native-selfhost.yml:390-411`); the fifth is
checked ahead of those four, directly in the `notify-failure` job's
`GATE_NAME` env expression (`windows-native-selfhost.yml:470-477`), since it
needs visibility into `cross-seed`'s result that `identify_gate` does not
have:

- `windows-cross-seed` — `cross-seed` failed or was cancelled while
  `native-build` did not itself fail or get cancelled. This is the Linux job
  that rebuilds the mingw-cross bootstrap seed breaking, not the Windows
  native compiler — triage `make ci-cross-windows`, not the compiler.
  Reachable only since SFN-994 made the two jobs run in parallel; before
  that, a `cross-seed` failure left `native-build` skipped, and the title
  fell through to the `windows-native-build` fallback below — misleadingly,
  since nothing about the Windows build had broken.
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

If the failing event is `push: main`, the merging PR also gets a comment
linking the regression issue and the failing run.

This page is the triage runbook for those regressions.

---

## 1. Reproduce locally

The native MSVC build and the fixed point both require a `windows-2025`-
equivalent host (MSVC + UCRT + `lld-link`) — they cannot be reproduced on
Linux or macOS. On a Windows host with the toolchain from
`ilammy/msvc-dev-cmd@v1` on `PATH`:

```bash
# Fetch + verify the published native MSVC seed (mirrors CI's
# `seed_source: release`, SFN-994) — requires `pwsh` and OpenSSL 3.0+, both
# present on the `windows-2025` runner image. $ver is
# `bootstrap.toml [seed].version`.
ver=<bootstrap.toml [seed].version>
pwsh -File .github/actions/sailfin-build-windows/verify-release-seed.ps1 -Version "$ver"
mkdir -p seed
tar -xzf "seed-dl/sailfin_${ver}_windows_x86_64-msvc.tar.gz" -C seed
SEED_EXE="$(find "$PWD/seed" -name sailfin.exe | head -1)"

# Fallback (`seed_source: cross` on the composite): the mingw-cross
# bootstrap seed, still the escape hatch until SFN-58 retires the path.
#   make ci-cross-windows   # on Linux, produces dist/installer-windows-x86_64.tar.gz
#   # copy/extract that archive onto the Windows host as SEED_EXE instead

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

- **The mingw cross-bridge link** (`make ci-cross-windows`) — a separate
  toolchain (mingw-w64, not MSVC) and a separate, hand-maintained
  `RUNTIME_MODS` module list (`Makefile`). A symbol present in one bridge can
  be absent from the other (e.g. `libmingwex.a` lacks `mkdtemp` even though
  MSVC's UCRT link has no such gap) — always also run `make ci-cross-windows`
  when a change touches `platform/*_windows.sfn`.
- **The native-MSVC self-host fixed point** (§1 above) — the pass-1/pass-2
  byte-identity proof only exists on the real `windows-2025` host, since it
  needs a compiler binary that itself already runs on Windows.

### 1b. A seed-fetch or verification failure is not a compiler regression

Since SFN-994, `native-build` bootstraps from a fetched, signed artifact
instead of a same-run build, so it can now fail for reasons that predate
this checkout's compiler ever running. All three fail during the `Fetch and
verify the native release seed` / `Stage the release seed` steps
(`.github/actions/sailfin-build-windows/action.yml`, driving
`verify-release-seed.ps1`) — before the SFN-53 ladder, the Stage 2 build, or
the fixed point — so they land under the `windows-native-build` catch-all
gate, whose name reads as a compiler problem when it is not one:

- **404 on the seed asset.** The release named by `bootstrap.toml
  [seed].version` never published a native MSVC asset. `release-tag.yml`'s
  msvc leg is best-effort (SFN-1024), and `cadence-seed-pin.yml` advances
  the pin without requiring that asset to exist first, so the pin can name a
  release with no msvc archive. `verify-release-seed.ps1` says so directly
  in its thrown error — it spells out that this is "NOT a regression in this
  checkout" and to "fix the release or the pin." Do that; do not add a
  mingw fallback to the verifier — the script's own comment rules it out by
  design.
- **Signature or digest mismatch.** The `SHA256SUMS` ed25519 signature
  failed to verify against `.github/release-signing/ed25519-release.pub.pem`,
  or the archive's SHA-256 does not match the signed manifest. Treat this as
  a release-infrastructure incident — a corrupted or tampered asset, or a
  signing-key mismatch — and escalate immediately rather than working
  around it: the verifier has no downgrade path or override knob, by design.
- **OpenSSL missing or too old.** The verifier requires OpenSSL 3.0+
  (`pkeyutl -rawin` needs it) and fails closed if it is absent or older. The
  pinned `windows-2025` image is expected to carry it; if this fires, the
  runner image changed under the pin — a CI-infrastructure regression, not a
  compiler one.

All three are outside `compiler/src/` and `compiler/capsules/` — do not
bisect commits under §3 for a failure that happened before the compiler
under test ever ran.

---

## 2. Cancelled vs. failed

Either `cross-seed` or `native-build` can end up `cancelled`, for two
different reasons, and only one of them is a regression:

- **Expected concurrency coalescing.** `push: main` and `workflow_dispatch`
  share one concurrency group per event type with `cancel-in-progress:
  true` (SFN-55 review A1) — landing a merge every ~20 minutes against a
  ~45-60 minute job means an older in-flight `push` run is routinely
  cancelled by a newer one, taking both jobs down together. `notify-failure`'s
  classify step checks whether a newer run of the same event type (and, for
  `workflow_dispatch`, the same ref) has since started; if so, it skips
  notification.
- **A genuine timeout.** `cross-seed` and `native-build` each carry a
  90-minute job timeout; within `native-build`, the `Self-host pass 1 + pass
  2 (native MSVC)` step carries its own 30-minute step timeout, and the
  downstream `Gate — self-host fixed point (pass-2 == pass-1)` comparison
  step carries a separate 5-minute step timeout — a step-level timeout
  surfaces as `failure`, not `cancelled` (see §1's "either job fails"). If
  this run is still the newest of its event type/ref and shows `cancelled`,
  it hit one of the job-level caps. Check the job log for where it stopped —
  the Linux self-host/`make ci-cross-windows` step in `cross-seed`, or a
  heartbeat gap in `native-build`'s Stage 2 build step — and treat it as a
  build-setup regression (SFN-55 §2's measured budget: ~13m30s
  build+boot+ABI, ~14m27s for both fixed-point passes; a run running
  meaningfully longer than that on a warm-cache run is itself the finding).

`schedule` runs never cancel each other or a `push` run — the concurrency
group is keyed by `github.event_name`, not just `github.ref`
(SFN-55 review A1).

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

Per the design note (`docs/proposals/design-notes/sfn-55-windows-ci.md` §6):
an open `windows-native-regression` issue older than one week means the
Windows leg is rotting again. The corrective action at that point is to
**drop tier A's path filter** (promote `build-compiler-windows` to
unconditional `source` scope in `ci.yml`), not to keep widening the filter's
globs — a filter that is silently wrong is worse than no filter, because it
reads as coverage that is not there.
