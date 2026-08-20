# Windows native self-host runbook

`.github/workflows/windows-native-selfhost.yml` is SFN-55 (SFEP-0021 M9)
**tier B**: the unconditional backstop to `ci.yml`'s path-filtered
`build-compiler-windows` (tier A). It runs on every `push` to `main`, once
nightly at 08:00 UTC, and on manual `workflow_dispatch`, with no path
filter — that asymmetry is deliberate (SFN-55 §4.3): tier A only fires on
PRs whose changed paths match the Windows glob, so tier B is what catches a
false negative in that filter, at up to 24h latency instead of never.

It proves two things in sequence:

1. **The native MSVC build itself** — `cross-seed` (ubuntu) rebuilds the
   mingw-cross bootstrap seed, `native-build` (windows-2025) stages it and
   runs the SFN-53 diagnostic ladder plus the boot / check / run / R1
   (try-throw) / R3 (struct-channel) ABI gates via the shared
   `.github/actions/sailfin-build-windows` composite.
2. **The self-host fixed point** (M8/SFN-54) — the native compiler rebuilds
   itself twice, and pass-2 must be byte-identical to pass-1.

When either job fails, or either job is cancelled after it started (a
`timeout-minutes` expiry, not an expected concurrency supersede — see
§2 below), the `notify-failure` job opens a deduplicated regression issue
labeled `area:architecture` and `windows-native-regression`. The issue title
suffix is the failing gate: `windows-native-build` (anything through the ABI
gates) or `windows-fixed-point` (the determinism step itself). If the
failing event is `push: main`, the merging PR also gets a comment linking
the regression issue and the failing run.

This page is the triage runbook for those regressions.

---

## 1. Reproduce locally

The native MSVC build and the fixed point both require a `windows-2025`-
equivalent host (MSVC + UCRT + `lld-link`) — they cannot be reproduced on
Linux or macOS. On a Windows host with the toolchain from
`ilammy/msvc-dev-cmd@v1` on `PATH`:

```bash
# Stage a bootstrap seed (mingw-cross, per SFEP-0021 §4.3 — there is no
# released native seed yet; that is M11/SFN-57).
make ci-cross-windows        # on Linux, produces dist/installer-windows-x86_64.tar.gz
# copy/extract that archive onto the Windows host as SEED_EXE

SAILFIN_TARGET_OS=Windows "$SEED_EXE" build -p compiler
NATIVE_SFN=<path to the resulting compiler.exe / sfn.exe under build/>

# Fixed point: two isolated passes, `--no-cache` on both.
SAILFIN_TEST_SCRATCH=build/selfhost/native-w1/scratch \
  "$NATIVE_SFN" build --no-cache -p compiler \
    --work-dir build/selfhost/native-w1 -o build/selfhost/fp1/sfn-selfhost1.exe
SAILFIN_TEST_SCRATCH=build/selfhost/native-w2/scratch \
  build/selfhost/fp1/sfn-selfhost1.exe build --no-cache -p compiler \
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
  90-minute job timeout, and the fixed-point step inside `native-build` its
  own 30-minute step timeout — a step-level timeout surfaces as `failure`,
  not `cancelled` (see §1's "either job fails"). If this run is still the
  newest of its event type/ref and shows `cancelled`, it hit one of the
  job-level caps. Check the job log for where it stopped — the Linux
  self-host/`make ci-cross-windows` step in `cross-seed`, or a heartbeat gap
  in `native-build`'s Stage 2 build step — and treat it as a build-setup
  regression (SFN-55 §2's measured budget: ~13m30s build+boot+ABI, ~14m27s
  for both fixed-point passes; a run running meaningfully longer than that on
  a warm-cache run is itself the finding).

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
- `seed-blocker` if the fix must land before the next seed cut (M11/SFN-57
  native seed publication is explicitly blocked on tier B staying green —
  see the design note's §8)

Set the fix issue's Linear-native priority per severity (a Windows-only
regression does not block the Linux/macOS release train, but a persistent
one erodes the tier the note staged this work at — see §9 below).

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
