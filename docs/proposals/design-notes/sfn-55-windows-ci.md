# Design note — SFN-55: permanent native-Windows CI

- **Issue:** SFN-55 (`ci`: native Windows `build-compiler-windows` +
  `build-test-windows` jobs) — SFEP-0021 milestone **M9**
- **Design of record:** [SFEP-0021](../0021-windows-native-selfhost.md) §4.4, §4.5, §5
- **Related:** SFN-54 (M8 fixed point, PR #2986), SFN-919 (`_dirname` separator),
  SFN-920 (`lld-link /Brepro`), SFN-57 (M11 native seed), SFN-58 (M12 mingw
  retire), SFN-491 (Windows-host leg on Linux), SFN-668 (nightly triple-pass)
- **Author:** agent:compiler-architect
- **Status:** Draft (single-issue design gate; not a new SFEP)
- **Date:** 2026-08-17
- **Shape:** path-filtered PR gate + unconditional nightly (owner decision)
- **Baseline measured:** run
  [32045072956](https://github.com/SailfinIO/sailfin/actions/runs/32045072956)
  (green end to end, fixed point sha256
  `5c9361ba5e44d69d0a7e1a3fa6b11dd448b5f4a4ff30552f10d67331151be3a7`)

---

## 0. Corrections after implementing tier A′ (2026-08-17)

Three claims below were tested during implementation and did not survive. They
are corrected here rather than edited away, so the reasoning that produced them
stays legible.

**§3.1 — tier A′ costs ~9 minutes, not ~2.** Measured over the eleven seam files
on a warm test-binary cache: 11/11 pass in ~9 min. Only ~57s of that is
assertions; the rest is per-file test-binary compilation. The job restores no
test-bin cache, so CI is colder still. This does not change the recommendation —
the run's critical path is ~26 min (`Build + Test [macos-arm64]`) and the guard
runs in parallel — but it does change the timeouts, and it removes "it is only
two minutes" as an argument. Shipped with a 25-minute step and 40-minute job
budget.

**§9 — tier A′ is NOT SFN-491, and SFN-491 must stay open.** The note claims
"Tier A′ is SFN-491" and recommends bundling. Reading SFN-491 directly (this
note's author had no Linear access and said so), its acceptance criterion is
`SAILFIN_HOST_OS=Windows SAILFIN_TARGET_OS=Linux make rebuild` — a **full
self-host**, explicitly nightly, budgeted at 60–90 min because the leg is
serial. Tier A′ runs twelve test files in ~9 min. Complementary, not equivalent.
Tier A′ ships inside SFN-55; SFN-491 remains its own issue.

**§3.1 — the seam is twelve files, but one of them does not pass.** Turning the
seam on found `compiler/tests/e2e/windows_exe_suffix_test.sfn` already broken
under the override (SFN-925): `clean_runner_env` strips only pool-managed keys,
so the outer `SAILFIN_TARGET_OS` leaks into a nested build as the *first* envp
entry and the test's own pushed override loses to it under `getenv()`'s
first-match rule. Tier A′ therefore ships with eleven files and a cited
exclusion. The wider consequence belongs in this note's risk list: for any seam
file that drives a nested build with a differing override, the child may run
under the outer value and the test can **pass while asserting something else**.
Until SFN-925 lands, a green tier A′ means "the in-process Windows-host branches
hold", not full coverage.

One claim that did survive and is worth keeping: **§3.1's "`grep -rn
SAILFIN_HOST_OS .github/` returns nothing"** was verified independently. Twelve
files' Windows branches had never executed in CI.

**§3.3/§13 — `windows-native-selfhost.yml` keeps its `cross-seed` job; it does
not "have no cross-seed job."** §3.3's body text and acceptance criterion 8
(§13) both say the job should be deleted, on the theory that tier B, like
tier A, can source its bootstrap seed from `ci.yml`'s
`ci-installer-windows-x86_64` artifact. That theory does not survive contact
with the trigger set §3.3 itself specifies: `push: main` and `schedule` have
no sibling `ci.yml` run to download that artifact from (§8 says as much,
recommending "the inline rebuild" — the note contradicts itself between §3.3
and §8 rather than resolving it). Implementation kept `cross-seed`, renamed
its uploaded artifact to `ci-installer-windows-x86_64` so it and tier A's
`build-compiler-linux` feed the same composite-action download step
regardless of which workflow produced the artifact, and left it as the only
way tier B can run un-triggered by a sibling `ci.yml` PR run. Acceptance
criterion 8 and the `:573` file-plan row are stale; this correction
supersedes them.

---

## 1. Goal

Make the now-green exploratory harness
(`.github/workflows/windows-native-selfhost.yml`) permanent and non-rotting,
under the owner's chosen shape: a **path-filtered PR gate plus a nightly full
run**.

The failure this exists to prevent is **rot**: R1/R3 sat at `continue-on-error`
"skipped" for months while their issues read Done. A check nobody's merge
depends on decays into a check nobody reads.

## 2. Cost baseline

One correction to the framing, because it sizes the tiers: `SailfinIO/sailfin`
is **public** (`gh api repos/SailfinIO/sailfin` → `"visibility":"public"`), and
GitHub-hosted standard runners are free with unlimited minutes on public repos —
the 2x Windows multiplier applies only to metered private minutes. The
exploratory workflow's concurrency comment
(`windows-native-selfhost.yml:32-39`) inherited the same assumption. The binding
budgets are **critical-path latency** and **concurrency slots** (20 concurrent
standard jobs; a source run already schedules ~24).

### 2.1 Measured step costs (run 32045072956, cold, no build cache)

| Step | Wall |
|---|---|
| `cross-seed` job (ubuntu, `make ci-cross-windows`) | 2m03s |
| Ladder rungs 1–4 (`:182-214`) | 2m40s |
| Stage-2 native MSVC build of the compiler (`:216`) | 9m14s |
| Boot / `check` / `run` / R1 / R3 gates (`:270-307`) | 1m36s |
| **Subtotal — build + boot + ABI** | **~13m30s** |
| Self-host fixed point, two `--no-cache` passes (`:328`) | 14m27s |
| **Job total** | **28m45s** |

Source-CI run
[32044504912](https://github.com/SailfinIO/sailfin/actions/runs/32044504912) had
a **32m34s** wall, set by `Build + Test [macos-arm64 / e2e-b]` at 26 min. So the
PR-side chain (2 min to the cross artifact + ~13m30s) lands ~16 min under the
critical path; adding the fixed point puts it at ~30 min, at the path with no
margin. **The split point is the fixed-point step**, in every shape.

## 3. Recommendation

Three jobs, two triggers, one filter.

| | Job | Runner | Trigger | Required? |
|---|---|---|---|---|
| **A′** | `windows-host-guard` | ubuntu-24.04 | every source PR — **not** Windows-filtered | **yes** |
| **A** | `build-compiler-windows` | windows-2025 | source PR **matching the Windows filter**; always in `merge_group` | **yes, when in scope** |
| **B** | `windows-native-selfhost` (fixed point) | windows-2025 | push:main + nightly cron — **no filter** | no (nightly-alerting) |

### 3.1 A′ is what makes the filter safe

Tier A′ runs the twelve `SAILFIN_HOST_OS=Windows` seam files on the **Linux**
runner. It costs ~2 minutes on a 1x runner, so it is **deliberately exempt from
the Windows path filter** — it runs on every source PR.

This asymmetry is the load-bearing design move. The largest historical class of
Windows breakage is host-side POSIX shell-out (§4.2: SFN-478/486, SFN-488,
SFN-857, SFN-489), and A′ catches that class on every source PR **regardless of
whether the filter fires**. Filtering a 2-minute Linux job saves nothing and
would reintroduce the false-negative risk for free.

`build_target_os()`/`host_is_windows()` read the `SAILFIN_HOST_OS` override
(`compiler/src/build/target.sfn:37,55`). Twelve files carry a Windows branch
behind it:

```
compiler/tests/e2e/{config,env_value_abi,errno_locator,fn_reference_pthread,login,windows_exe_suffix}_test.sfn
compiler/tests/integration/selfhost_diff_test.sfn
compiler/tests/unit/{dev_bootstrap_alias,fs_tree,toolchain_alias,toolchain_host_detect,windows_build_deshell}_test.sfn
```

`compiler/tests/unit/windows_build_deshell_test.sfn:11-19` gives the invocation
verbatim: `SAILFIN_HOST_OS=Windows SAILFIN_TARGET_OS=Linux build/bin/sfn test
<file>`. The `SAILFIN_TARGET_OS=Linux` half is load-bearing — without it
`build_target_os()` falls back to the host override and the nested
runtime-object link targets Windows on a Linux box (SFN-617, recorded at
`windows_build_deshell_test.sfn:14-17`).

**`grep -rn SAILFIN_HOST_OS .github/` returns nothing.** The Windows branch of
all twelve has never run in CI — the rot this issue targets, already present in
miniature, closable for two minutes.

### 3.2 Tier A — the filtered Windows job

Sibling of `build-compiler-macos` (`ci.yml:509`), placed after `smoke-windows`
(`:2037`):

```yaml
needs: [ci-scope, build-compiler-linux]
if: ${{ needs.ci-scope.outputs.windows == 'true' }}
runs-on: windows-2025            # pinned, not `windows-latest` — Risk R3
timeout-minutes: 45
env:
  SAILFIN_TARGET_OS: Windows
```

Steps lifted from `windows-native-selfhost.yml`, minus the `cross-seed` job:
stage the seed from the `ci-installer-windows-x86_64` artifact (`:115-131`),
`ilammy/msvc-dev-cmd@v1` + LLVM probe (`:133-146`), ladder rungs 1–4 with
`continue-on-error: true` (`:182-214`), `<seed> build -p compiler` with the
heartbeat and `timeout-minutes: 30` (`:216-268`), then the boot / `check` /
`run` / **R1** / **R3** gates (`:270-307`) with **no** `continue-on-error` —
those are the ABI proofs and must be able to fail the job. Upload the native
`.exe` as `ci-build-windows-x86_64`.

Keep the rungs: 2m40s converts an opaque 9-minute Stage-2 failure into a named
one, and the slack affords it.

### 3.3 Tier B — the unconditional nightly

Keep `windows-native-selfhost.yml`; change its triggers and drop its now-dead
parts:

```yaml
name: Windows native self-host (fixed point)
on:
  push:
    branches: [main]
  schedule:
    - cron: "0 8 * * *"          # after nightly-selfhost's 07:00
  workflow_dispatch:
```

Delete the `cross-seed` job (§5) and the dead
`claude/sfn-53-windows-native-runner` push filter (`:28-30`). **No path filter** —
that is the whole point of the nightly. Retain the fixed-point step
(`:328-353`) and the `concurrency` block, whose `cancel-in-progress` rationale
still holds.

Keeping this file rather than folding Tier B into `build-quality.yml`: that
workflow is the right *genre* (determinism, push:main + nightly — its header at
`:19-24` records the same per-PR-wall-time verdict reached here independently)
but is deliberately Linux-only and `make`-driven, and a move would strand ~200
lines of earned rationale. Its own header instruction is "fold into M9", which
changing its triggers satisfies.

## 4. The path filter

### 4.1 What the starting list would have caught

Every traced Windows-only fix, scored against the starting globs
(`compiler/src/build/**`, `runtime/sfn/platform/**`, lowering, the workflow) and
against an evidence-derived widening. Scored on the files each fix commit
actually touched; a filter fires if **any** changed file matches, which is why
multi-file fixes score generously.

| Issue | Fix touched | Starting | Evidence-derived |
|---|---|---|---|
| SFN-919/904 `_dirname` backslash | `build/paths.sfn`, `build/runtime_objs.sfn` | ✅ | ✅ |
| SFN-920 `/Brepro` | `build/target.sfn:311`, `build/link.sfn:324`, workflow | ✅ | ✅ |
| SFN-903 `opendir_windows` (`7364e0a4`) | `build/fs.sfn`, `build/target.sfn`, `platform/opendir_windows.sfn` | ✅ | ✅ |
| SFN-649 emit-child self path | `build/paths.sfn`, `build/tensor_ir_link_harness.sfn`, `capsule_emit_parallel.sfn`, `capsule_resolver/**`, `cli/commands/{build,run}.sfn` | ✅ | ✅ |
| SFN-690 process-handle symbols | `platform/process_windows.sfn` | ✅ | ✅ |
| SFN-671 socket-ops sibling | `build/target.sfn`, `runtime/capsule.toml`, `runtime/sfn/adapters/{http,net,websocket}.sfn` | ✅ | ✅ |
| SFN-720/721 replace running image | `build/fs.sfn`, `build/source_fingerprint.sfn`, `cli_selfhost.sfn`, `platform/rename_ops_windows.sfn` | ✅ | ✅ |
| SFN-478/486 refuse POSIX probes | `build/fs.sfn`, `build_cache.sfn`, `capsule_emit_parallel.sfn`, `emit_helpers.sfn` | ✅ | ✅ |
| SFN-489 de-shell determinism | `build/determinism.sfn` | ✅ | ✅ |
| SFN-617 cache key by target | `build/runtime_objs.sfn`, `build_cache.sfn`, `capsule_resolver/compile.sfn` | ✅ | ✅ |
| SFN-51 `fs_list_dir` sentinel | lowering ×3, `runtime/sfn/adapters/filesystem.sfn` | ✅ | ✅ |
| **SFN-488 de-shell link probe + stamp** | `backend.sfn`, `build_stamp.sfn` | ❌ | ✅ |
| **SFN-857 host-OS detect for `toolchain install`** | `cli/commands/toolchain.sfn` | ❌ | ✅ |
| **SFN-374 flip to `fs_list_dir`** | `runtime/sfn/adapters/filesystem.sfn` | ❌ | ✅ |

**The starting list scores 11/14.** It is better than it looks on paper because
most Windows fixes touch at least one `compiler/src/build/**` file incidentally —
but the three misses are not incidental. `backend.sfn`, `build_stamp.sfn`,
`cli/commands/**`, and `runtime/sfn/adapters/**` are ordinary, frequently-edited
Windows-relevant surfaces that the starting globs simply do not name.

**Widen it.** Recommended filter, as a `case` arm in `ci-scope`:

```
compiler/src/build/*
compiler/src/build_cache.sfn | compiler/src/build_stamp.sfn
compiler/src/backend.sfn | compiler/src/emit_helpers.sfn
compiler/src/capsule_emit_parallel.sfn | compiler/src/cli_selfhost.sfn
compiler/src/native_emit_subprocess.sfn | compiler/src/llvm_validation.sfn
compiler/src/codegen_driver.sfn
compiler/src/capsule_resolver/*
compiler/src/cli/*
compiler/capsules/codegen/* | compiler/capsules/codegen-llvm/*
runtime/*
Makefile | bootstrap.toml
.github/workflows/ci.yml
.github/workflows/windows-native-selfhost.yml
.github/actions/*
```

Note `compiler/src/llvm/**` **no longer exists** — lowering moved to
`compiler/capsules/codegen-llvm/src/lowering/`. Writing the starting list's
"lowering" glob as `compiler/src/llvm/**` would produce a filter arm that can
never match.

### 4.2 What it costs

Measured over the 1,049 source-scoped non-merge commits since 2026-06-01:

| Filter | Windows job runs on | Traced breaks caught |
|---|---|---|
| Starting list | 194 (18.5%) | 11/14 |
| **Recommended (above)** | **454 (43%)** | **14/14** |
| No filter (shape 1) | 1,049 (100%) | 14/14 |

43% is a real saving — a majority of source PRs still skip the Windows leg —
bought at the price of naming every Windows-relevant surface explicitly.

### 4.3 How this bet loses — state it plainly

**The scoring above is methodologically weak, and the note should not pretend
otherwise.** Every row is a *fix* commit for a *latent* gap: the code was always
wrong on Windows and nothing "broke" it; it surfaced the first time a native
build exercised the path. A fix for a Windows bug touches Windows files by
definition, so scoring a filter against fixes is close to circular.

The risk the filter must actually cover is the opposite kind — a **regression**,
where a green Windows path breaks because someone edits a shared file for
unrelated reasons — and **there is no historical sample of that class at all**,
because native Windows has only been green since today (run 32045072956). The
filter is being designed against data of the wrong kind, and no amount of glob
tuning fixes that.

The concrete way the bet loses:

1. **A frontend or analyzer change alters emitted IR in a way only the MSVC
   backend rejects.** `compiler/capsules/{syntax,analyzer,ir}/**` is deliberately
   outside the filter on the theory that lex/parse/typecheck are target-agnostic
   — true of diagnostics, *not* guaranteed of the IR they feed. SFEP-0021 Risk R3
   (struct-by-value under the Microsoft x64 ABI) is exactly this shape: a new
   lowering pattern that is fine under SysV and wrong under MSVC. Nothing in the
   filter fires.
2. **A generic `compiler/src/` refactor that changes behavior on Windows only** —
   e.g. a shared string/path helper that a `build/` caller relies on, edited in a
   file the filter does not name. The recommended list mitigates by naming most
   of `compiler/src/`, but a *new* top-level driver module lands outside every
   glob until someone remembers to add it. Inclusion lists rot silently; that is
   their nature.
3. **A `compiler/tests/**`-only PR** that changes a shared test helper the
   Windows path depends on. Excluded by design (tests are not compiler source),
   correctly for cost, and it is a real hole.

**What the nightly buys back:** class 1 and 2 are caught at **≤24h latency**
instead of never, against a `main` tip, with a bisect range of one day of
commits. That is strictly worse than a PR gate and strictly better than the
status quo, and it is the honest characterization — the nightly does not make
the filter safe, it bounds how long the filter can be wrong.

**What would actually close the hole:** enabling the merge queue.
`docs/runbooks/merge-queue.md:6-9` records that `main` is **not yet
queue-protected** — the in-tree half is done, the owner-side settings half is
not. `merge_group` does not support `paths:`, and `ci-scope` already forces
scope on for queue runs (`ci.yml:30-42`). Design the Windows scope the same way
(§5.2) and enabling the queue converts every false negative from "caught by
tomorrow's nightly" to "cannot land" — because every merge is Windows-verified
on the speculative merge commit regardless of what the PR touched. **This is the
single highest-leverage follow-up to SFN-55 and it is a repository-settings
change, not code.**

## 5. Required vs. advisory, and the skipped-check trap

### 5.1 The trap does not apply here — and the reason is worth being precise about

The usual way path-filtered gates fail is: a job is named directly in branch
protection, the filter skips it, GitHub reports the check as never-arriving, and
the PR (or the merge queue) blocks forever.

**This repo already solved that.** Branch protection names one check —
`Required CI gate` (`ci.yml:2160`) — which runs `if: always()` on ubuntu, takes
every gated job as a `needs:`, and reads their `result` values as strings. A
skipped `needs:` does not block an `always()` job, and `required-ci` already
implements the exact conditional-scope pattern for `public_claims`
(`:2258-2263`): if the scope output is false, print a "skipped by path scope"
row and do not `check` it.

So the mechanism is **not** a new skip-shim — it is one more branch in an
existing one. Recommended over `paths-ignore` inversion or a non-required job,
both of which would either duplicate `ci-scope`'s logic in a second place or
give up the blocking property the owner asked for.

### 5.2 Concrete wiring

In `ci-scope` (`ci.yml:56-130`), add a third output beside `source` and
`public_claims`:

```yaml
outputs:
  source:        ${{ steps.scope.outputs.source }}
  public_claims: ${{ steps.scope.outputs.public_claims }}
  windows:       ${{ steps.scope.outputs.windows }}
```

Compute it in the same `while read path` loop (`:103-116`) with a third `case`
carrying the §4.1 globs. Three defaults matter:

- `pull_request` → `windows=false` until a path matches (the filter).
- `merge_group` → `windows=true`, unconditionally, matching how `source` is
  forced on for queue runs (`:30-42`). **The queue must never land an untested
  combination**, and this is what makes §4.3's mitigation real once the queue is
  enabled.
- `schedule` → `windows=false`; `ci.yml`'s scheduled run is reserved for the
  aarch64 soak (`:80-84`), and the Windows nightly is Tier B in its own workflow.

In `required-ci` (`:2160-2270`): add `build-compiler-windows` and
`windows-host-guard` to `needs:`, add
`WINDOWS_CI: ${{ needs.ci-scope.outputs.windows }}` plus the two result vars to
`env:`, then inside the existing `SOURCE_CI == 'true'` branch:

```bash
check "Windows-host guard [linux-x86_64]" "$WINDOWS_HOST_GUARD"
if [ "${WINDOWS_CI:-}" = "true" ]; then
  check "Build compiler [windows-x86_64]" "$BUILD_COMPILER_WINDOWS"
else
  echo "[required-ci] native Windows CI is out of scope for this PR."
  echo "| Native Windows CI | skipped by path scope |" >> "$GITHUB_STEP_SUMMARY"
fi
```

Add the same fail-closed validation `source` and `public_claims` get
(`:2213-2221`): an unexpected `windows` value fails the gate rather than
silently reading as false. That guard is why a typo in the new `case` arm
cannot quietly disable the Windows leg forever.

**No branch-protection change is required.** `Required CI gate` remains the only
protected check name.

### 5.3 The required set

Blocking:

| Check | Runner | Cost | Scope | Catches |
|---|---|---|---|---|
| `Smoke test [windows-x86_64]` *(existing, `:2009`)* | windows | ~2m | `source` | cross binary stops booting |
| **`Windows-host guard [linux-x86_64]`** *(new)* | ubuntu-24.04 | ~2m | `source` | new `sh -c` / POSIX-only leaf on the host build path |
| **`Build compiler [windows-x86_64]`** *(new)* | windows-2025 | ~14m | **`windows`** | native MSVC self-host break, link/UCRT regression, R1 `setjmp` binding, R3 struct ABI |

Advisory: ladder rungs 1–4 (`continue-on-error`, diagnostics only), and Tier B —
which is not PR-reachable by construction and therefore cannot be a required
check.

## 6. Nightly failure routing

A nightly that fails into a void is the rot mode one level up. **Do not invent a
mechanism — `build-quality.yml` already has the right one**, and it is the same
genre of gate (post-merge structural backstop, push:main + cron).

`notify-failure` (`build-quality.yml:621-860`) does three things Tier B should
reuse verbatim:

1. **Dedupes into one tracking issue** — lists open issues by a marker label and
   matches on exact title (`:786-799`), so a gate that fails ten nights running
   produces one issue with ten comments, not ten issues.
2. **Opens a GitHub issue** via `gh issue create` with a marker label plus
   `area:architecture` (`:825-831`), carrying the run URL, failing SHA, event,
   and a log excerpt. Per CLAUDE.md ## Task tracking, GitHub issues mirror into
   the `SFN` team's `Triage` — so this *is* the Linear-native routing, and no
   direct Linear API call is needed.
3. **Comments on the merging PR** for `push: main` events (`:844-860`) — the
   highest-value half. A push:main Tier B failure names the PR that just landed,
   which for a false-negative-of-the-filter is precisely the PR that should have
   run Windows and did not.

For Tier B, instantiate it with `gate_name` values `windows-fixed-point` /
`windows-native-build` and label `windows-native-regression`. Copy the
`always()`-not-`!cancelled()` reasoning (`:632-638`) — a `timeout-minutes` expiry
on a 45-minute Windows step surfaces as `cancelled`, and `!cancelled()` would
suppress exactly the signal the job exists to report.

Add a triage runbook at `docs/runbooks/windows-native.md` mirroring
`docs/runbooks/build-quality.md`, since the issue body links one.

**Escalation, stated as policy:** an open `windows-native-regression` issue older
than one week means the Windows leg is rotting again. The corrective action at
that point is to drop the filter (promote Tier A to unconditional `source`
scope), not to keep widening globs.

## 7. Rejected alternatives (retained for the record)

| Shape | Why not |
|---|---|
| **1. Full fold into `ci.yml`, everything required on every source PR** | The fixed point's +14m27s puts the Windows chain at ~30 min against a 32m34s critical path, on the least-proven leg, to re-prove a property that moves on a scale of months. *Note:* the build-only half at 43% filter coverage is close enough to this that promoting Tier A to unconditional is the natural escape hatch if §6's escalation fires. |
| **2. Separate workflow, push:main + nightly only, no PR gate** | The R1/R3 failure mode: breakage found after merge, bisected across a day, by whoever reads the nightly. With ~16 min of critical-path slack, declining to block at all is unforced. |
| **Reuse `ci-scope`'s existing `source` output as the Windows filter** | Equivalent to shape 1 — `source` fires on ~100% of the commits that matter. Rejected as not being a filter. |
| **Add a Windows leg to `.github/actions/sailfin-build`** | Every build step in that action is a `make` call (`action.yml:118, 285-292, 396, 438-445, 484`); host `make` on `windows-latest` is GnuWin32 3.81 and the targets are bash-heavy (SFEP-0021 §4.4). A Windows branch forks the action rather than extending it. |

Instead of a Windows branch on `sailfin-build`, extract
**`.github/actions/sailfin-build-windows`**: stage seed → MSVC env → LLVM probe →
ladder → `<seed> build -p compiler` + heartbeat → locate and assert the `.exe`.
SFN-55 instantiates it **twice** (Tier A, Tier B) and SFN-57's release leg is the
third caller — two real callers on day one, not a manufactured abstraction.

## 8. The `cross-seed` job and the SFN-57 seam

**No bootstrapping-order problem.** SFN-57 (publish a native MSVC seed) is
correctly blocked on SFN-55: publishing a Windows seed before the native build is
permanently green would publish an unvalidated seed. The dependency runs one way.

**The `cross-seed` job does not survive** — it is already redundant.
`build-compiler-linux` (`ci.yml:346`) runs `make ci-cross-windows` (`:454-459`)
and uploads `dist/installer-windows-x86_64.tar.gz` as `ci-installer-windows-x86_64`
(`:461-468`), byte-for-byte what the harness's `cross-seed` job produces
(`windows-native-selfhost.yml:88-98`), and `smoke-windows` already consumes it.
The harness needed its own copy only because it is standalone. The cross *path*
survives until SFN-58 / M12, per SFEP-0021 §4.5's coexist-then-replace call.

One wrinkle Tier B must handle: on `push: main` there is no sibling `ci.yml` run
whose artifact Tier B can download, so Tier B rebuilds the cross seed inline
(2m03s on a 1x ubuntu job) or resolves the artifact from the triggering commit's
CI run. Prefer the inline rebuild — fewer cross-workflow assumptions, and it also
keeps `make ci-cross-windows` itself exercised nightly.

To make SFN-57 a small edit, put seed acquisition behind **one named input** on
the new composite:

```yaml
seed_source:
  description: "'cross' = ci-installer-windows-x86_64 artifact (M9);
                'release' = pinned native windows-x86_64 asset (M11/SFN-57)"
  default: "cross"
```

SFN-57 then becomes: publish the asset, teach `install.sh`/`make fetch-seed` the
`.exe` name, flip the default to `release`, drop `needs: build-compiler-linux`.
No step reshuffling, no re-derivation of the MSVC/LLVM/ladder plumbing.

## 9. Boundary against SFN-668 and SFN-491

### SFN-668 (nightly triple-pass matrix, add Windows) — **close as absorbed**

Tier B *is* a nightly Windows self-host fixed point, now unconditional, which is
the decisive half. SFN-668's literal scope is a leg on `nightly-selfhost.yml`,
which runs `make check` (`nightly-selfhost.yml:128`) — blocked on host `make`
3.81. Re-implementing that triple pass in PowerShell duplicates Tier B
step-for-step to add one pass.

The genuine residual delta is two items, neither issue-sized:

- **a third pass** — one more ~7-minute step appended to Tier B;
- **`sfn selfhost` strict module-IR divergence** — the signal
  `nightly-selfhost.yml:51-53,68-71` gates `SELFHOST_STRICT=1` on for Linux and
  macOS.

Fold both into Tier B's acceptance. Comment the absorption on SFN-668 before
closing so the trail survives.

### SFN-491 (Windows-host leg on the Linux runner) — **bundle into SFN-55**

Tier A′ is SFN-491, and under shape 3 it is no longer merely complementary — it
is load-bearing (§3.1), because it is the one Windows signal that survives the
filter skipping. It does not overlap Tier A: different runner, different
mechanism (`SAILFIN_HOST_OS` override vs. a real MSVC host), different failure
class (host-side shell-out vs. ABI/link).

Per `.claude/rules/seed-dependency.md`'s bundle-by-default rule: both are pure
CI-workflow edits with **no compiler-source change and no seed dependency**, so
no seed-cut tax applies either way — but "two artificially-separated S issues are
usually worse than one honest M" does. SFN-491 is ~30 lines of YAML against
twelve test files that already exist and already assert both branches. One PR.

*Caveat:* I could not read SFN-491 in Linear from this session (no
`mcp__Linear__*` tools available); this assumes its scope matches SFEP-0021 §5's
M7.5 row ("a Windows-host regression leg"). If it is already in flight with
someone, keep it separate and land it **first** — Tier A must not ship without
it.

## 10. `build-test-windows` — split, and the scope is unknown

**Do not ship `build-test-windows` in SFN-55.** Nothing in the tree has ever run
`sfn test` on a Windows host — no workflow, no doc, no measurement. Four
independent hard blockers, each citable:

1. **328 of 709** test files hardcode the literal `build/bin/sfn` with no `.exe`
   — e.g. `compiler/tests/e2e/exe_path_reader_test.sfn:29` returns
   `"build/bin/sfn"`. The native build produces `.exe`
   (`windows-native-selfhost.yml:263`).
2. **221 of 336** e2e files carry a `/tmp` or `/bin/sh` literal (mostly the
   `SAILFIN_TEST_SCRATCH`-empty fallback, e.g.
   `compiler/tests/e2e/string_cstr_boundary_test.sfn:53`).
3. `_resolve_auto_test_jobs`
   (`compiler/src/cli/commands/test/arg_and_jobs.sfn:128-146`) returns `1` for
   any host that is not `Linux`/`Darwin` — the Windows suite runs **serial**,
   against a Linux suite needing eight parallel legs at 7–14 min each.
4. `sfn package` cannot complete on a native Windows host
   (`docs/status.md:453-458`: `tar -czf` blocked on SFN-753, `date -u` has no
   epoch→civil formatter).

File a successor whose **first deliverable is a measurement, not a gate**: an
advisory `continue-on-error` job running `<native>.exe test compiler/tests/unit`
that reports pass/fail/skip counts to the step summary. Only then can the real
work — `.exe` resolution across 328 files, a Windows `_resolve_auto_test_jobs`
budget, `skip(reason)` (`capsules/sfn/test/src/skip.sfn:43`) on genuinely
POSIX-only tests — be sized.

**Tier consequence, stated plainly.** SFN-55 leaves Windows x86_64 at **Tier 3**
(`docs/conventions/target-tiers.md:36`). Tier 2 requires "the complete relevant
suite in merge-blocking CI" (`:17-20`). Under shape 3 there is a second reason
Tier 2 is unreachable: Tier 2 says failures "block pull requests", and a
path-filtered gate does not run on every PR. Strengthen the Tier 3 evidence row
from "cross-compiled and frontend-smoke-tested" to "natively self-hosts, with a
path-filtered merge-blocking build + ABI gate and an unconditional nightly fixed
point"; **do not promote the tier** and do not touch public support copy.

## 11. Files affected

Pipeline stage: **none** — entirely CI plumbing. No `.sfn` under
`compiler/src/`, `compiler/capsules/`, or `runtime/` is touched, so no self-host
risk, no `sfn fmt` surface, no seed dependency.

| File | Change |
|---|---|
| `.github/actions/sailfin-build-windows/action.yml` | **new** — `seed_source` (`cross`\|`release`), MSVC env, LLVM probe, ladder, `build -p compiler` + heartbeat, locate/assert the `.exe` |
| `.github/workflows/ci.yml` | `ci-scope`: third output `windows` + `case` arm (§4.1) + fail-closed validation; new `windows-host-guard`; new `build-compiler-windows` after `smoke-windows` (`:2037`); `required-ci` `needs:`/`env:`/conditional-`check` wiring (`:2160-2270`) |
| `.github/workflows/windows-native-selfhost.yml` | drop `cross-seed` + the dead branch filter (`:28-30`); retrigger push:main + cron; call the composite; retain the fixed point (`:328-353`); append pass-3 + `sfn selfhost` strict (SFN-668 absorption); add `notify-failure` |
| `docs/runbooks/windows-native.md` | **new** — triage runbook the regression issue body links |
| `docs/conventions/target-tiers.md:36` | strengthen the Windows Tier 3 evidence row; **no promotion** |
| `docs/status.md` | record the path-filtered Windows build gate + the nightly fixed point |
| `docs/proposals/0021-windows-native-selfhost.md` | mark M9 done; record the `cross-seed` collapse and the deferred `build-test-windows` half |
| `docs/runbooks/merge-queue.md` | note that enabling the queue closes the filter's false-negative window (§4.3) |

## 12. Risks

- **R1 — the filter is a bet with no supporting data.** §4.3. Mitigations: A′ is
  unfiltered, the nightly is unfiltered, `merge_group` forces scope on, and §6
  has an escalation that ends in dropping the filter.
- **R2 — arena-on for the first time.** `ci.yml:11-17` sets
  `SAILFIN_USE_ARENA: "1"` at workflow scope; the harness ran without it. Tier A
  inherits it, so its first run is the first-ever Windows arena build. Land Tier
  A in a PR whose own CI runs it; if it fails, set the variable explicitly on the
  job and file the divergence rather than touching the workflow default.
- **R3 — floating `windows-latest`.** `ci.yml` pins `ubuntu-24.04` and `macos-26`
  deliberately; the macOS comment (`:513-519`) records what an unpinned label
  costs. Pin `windows-2025`, and **verify the label resolves on the first run** —
  I could not confirm runner-label availability from this session.
- **R4 — no memory cap on Windows.** `apply_default_mem_limit` is a stub
  (SFEP-0021 §4.1); the Linux 8 GiB `RLIMIT_AS` is inert there. Only
  `timeout-minutes` bounds a runaway. Every expensive step keeps its own
  (30 build / 45 fixed point, as the harness has). Do not raise the job timeout
  to paper over a regression.
- **R5 — determinism depends on SFN-920.** The byte compare is meaningful only
  because `/Brepro` is threaded through `lld-link`
  (`windows-native-selfhost.yml:317-322`); a revert makes Tier B flake at PE byte
  129. That reasoning stays in the comment above the step.
- **R6 — cold Windows build cache.** Tier A's 9m14s Stage-2 build is cold and
  stays cold: the composite's `actions/cache` restore
  (`sailfin-build/action.yml:215-222`) is not wired for Windows. Deferring is
  safe (the numbers assume it absent); adding it later is a pure win.

## 13. Verification

```sh
# Tier A' locally, before touching any YAML.
SAILFIN_HOST_OS=Windows SAILFIN_TARGET_OS=Linux \
  build/bin/sfn test \
    compiler/tests/unit/windows_build_deshell_test.sfn \
    compiler/tests/unit/toolchain_host_detect_test.sfn \
    compiler/tests/unit/toolchain_alias_test.sfn \
    compiler/tests/unit/dev_bootstrap_alias_test.sfn \
    compiler/tests/unit/fs_tree_test.sfn \
    compiler/tests/integration/selfhost_diff_test.sfn \
    compiler/tests/e2e/windows_exe_suffix_test.sfn \
    compiler/tests/e2e/errno_locator_test.sfn \
    compiler/tests/e2e/env_value_abi_test.sfn \
    compiler/tests/e2e/config_test.sfn \
    compiler/tests/e2e/login_test.sfn \
    compiler/tests/e2e/fn_reference_pthread_test.sfn

# Regression guards that must stay green on the ordinary Linux shards.
build/bin/sfn test compiler/tests/unit/paths_separator_test.sfn \
                   compiler/tests/unit/target_conditioning_test.sfn

# Filter correctness — replay the traced fixes and assert each sets windows=true.
# (Run the new `case` arm against `git show --name-only <sha>` for the commits in
#  the §4.1 table; every row must score CAUGHT.)

# Tier B, on the branch, before merging.
gh workflow run windows-native-selfhost.yml --ref <branch>
```

Acceptance criteria:

1. `ci-scope` emits a `windows` output; an unexpected value fails `required-ci`
   closed, matching the `source`/`public_claims` guards (`ci.yml:2213-2221`).
2. On a PR touching only `compiler/capsules/analyzer/**`: `Build compiler
   [windows-x86_64]` is **skipped**, `Required CI gate` is **green**, and its
   summary shows `| Native Windows CI | skipped by path scope |`.
3. On a PR touching `compiler/src/build/paths.sfn`: the Windows job runs and is
   `check`ed by `required-ci`.
4. `Windows-host guard [linux-x86_64]` runs and is `check`ed on **both** of the
   above.
5. R1 and R3 gates run without `continue-on-error`.
6. A forced Tier B failure opens exactly one labelled GitHub issue and comments
   on the merging PR; a second forced failure appends a comment rather than
   opening a second issue.
7. The Windows chain does not become the run's critical path (compare against
   run 32044504912's 32m34s).
8. `windows-native-selfhost.yml` has no `cross-seed` job and no `claude/sfn-53-*`
   push filter, and its fixed point runs on push:main.
9. `docs/conventions/target-tiers.md` Windows row updated; tier still **3**.

## 14. Future considerations

- **Enable the merge queue** (`docs/runbooks/merge-queue.md` §1). The highest-
  leverage follow-up: it closes the filter's false-negative window entirely, and
  it is a settings change, not code.
- **SFN-57 (M11)** flips `seed_source` to `release` and drops `needs:
  build-compiler-linux` — one input.
- **SFN-58 (M12)** deletes `make ci-cross-windows`, the `RUNTIME_MODS` loop, and
  `build-compiler-linux`'s cross steps (`ci.yml:402-468`). `smoke-windows` then
  loses its input and retires into Tier A.
- **The suite successor** is the only path to Tier 2. Sequence it after SFN-753
  (in-process `.tar.gz`), which also unblocks `sfn package` on Windows and
  therefore a native Windows release leg.
- **Windows build cache (R6)** would take Tier A from ~14 min to a few minutes,
  which is also the precondition for cheaply dropping the filter if §6's
  escalation fires.
