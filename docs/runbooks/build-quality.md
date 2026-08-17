# Build Quality runbook

`.github/workflows/build-quality.yml` enforces two structural contracts
on every `push` to `main` and every nightly cron at 05:00 UTC:

1. **Determinism** — a second self-hosted compile must produce a
   byte-identical binary and identical per-module `cache_key` set
   against the first pass (via `sfn build --check-determinism`).
2. **Cache hit rate** — the warm second pass must keep
   `cache.hit_rate >= 0.95`.

It also runs a third, non-gate job, `test-bin-baseline` (the **test-bin
cache warmer**), which builds the default-branch per-test-binary cache PR
CI restores. It is not a correctness gate, but a warmer that stops
producing its cache is a trackable regression in its own right — so a
warmer failure or timeout is reported through the same path (SFN-430).
Closely spaced pushes may replace an older queued warmer with the latest
one; this expected coalescing is not reported because an active warmer is
left running and the latest-main warmer remains queued to refresh the cache
(SFN-583).

When any of these fails — either gate, or the warmer — the `notify-failure`
job (issue #782) opens a deduplicated regression issue labeled
`area:architecture` and `build-quality-regression` (build-quality
regressions are inherently release-critical; priority is set on the Linear
mirror at triage — it is no longer a GitHub label). The issue title suffix
identifies the failing path: `determinism`, `cache-hit-rate`,
`build-setup`, or `test-bin-warmer`. If the failing event is `push: main`,
the merging PR also gets a comment linking the regression issue and the
failing job.

This page is the triage runbook for those regressions.

---

## 1. Reproduce locally

Both gates run inside one second-pass invocation. Reproducing locally
is a single command; everything else is reading its output.

```bash
make compile                             # self-host from the pinned seed

# First pass — warm the cache. Mirrors the workflow.
build/bin/sfn build -p compiler \
  --work-dir build/det-pass1 --json | tee pass1.json

# Second pass — runs determinism check + emits the warm-cache BuildReport.
build/bin/sfn build -p compiler \
  --check-determinism \
  --work-dir build/det-pass2 --json | tee pass2.json

# Determinism diff (second JSON object in pass2.json):
jq -s '.[] | select(.check == "determinism")' pass2.json

# Cache stats:
jq -s '.[0].cache' pass2.json
```

If both passes succeed locally with `cache.hit_rate >= 0.95` and an
empty determinism diff, the regression is environment-specific —
attach `pass1.json` + `pass2.json` from the failing CI run (kept for
14 days as the `build-quality-passes` artifact) to the regression
issue and request a maintainer rerun before bisecting.

### Scoped compiler sidecar

The compiler self-host declares `[capsule].name = "sfn/compiler"`, so it emits
`build/capsules/sfn/compiler/manifest.json` and `--check-determinism` compares
both per-module cache identities and the linked binary. A non-empty
`module_diffs` array identifies the affected module directly; a binary-only
divergence still reports `binary_sha256_a` / `binary_sha256_b` and the two
binary paths.

---

## 2. Bisect

Determinism regressions are almost always introduced by a single
commit that lands a non-canonical artifact in the emit pipeline. The
canonical bisect harness is `make compile` + the two passes above;
mark a commit good when both passes match, bad when they diverge.

```bash
git bisect start
git bisect bad <failing-sha-from-issue>
git bisect good <known-good-sha>          # last successful build-quality.yml run

git bisect run bash -c '
  set -euo pipefail
  make compile >/dev/null 2>&1 || exit 125    # 125 = skip (build broken here)
  build/bin/sfn build -p compiler \
    --work-dir build/det-pass1 --json >/dev/null
  build/bin/sfn build -p compiler \
    --check-determinism --work-dir build/det-pass2 --json > pass2.json
  jq -se ".[] | select(.check == \"determinism\") | .matches" pass2.json | grep -q true
'
```

Cache-hit-rate regressions usually have a wider blast radius (cache
key drift from any new sidecar dependency), so bisect with the same
harness but assert `cache.hit_rate >= 0.95` in the check expression.

Use `git bisect skip` (or exit 125) for commits where the build itself
is broken — bisecting a build break is a different runbook.

---

## 3. File a fix issue

Once the offending commit is identified, file a fix issue with these
labels:

- `type:bug`
- `area:compiler` (for emit-pipeline / lowering regressions),
  `area:build` (for cache-key drift), or `area:runtime` (rare —
  runtime-shape changes that perturb emitted IR).
- `seed-blocker` — gates the next seed cut. Adding this label causes
  `/release` to refuse to cut anything beyond an alpha prerelease
  until the issue closes (see `docs/conventions/issue-naming.md` →
  "Release tracking" + "Seed pinning").

Then set the fix issue's **Linear-native priority to Urgent** on its mirror
(priority is a Linear field, not a GitHub label).

The fix issue's body should `Closes` the regression issue
(`build-quality regression: <gate>`) so the dedup anchor closes
automatically on merge. If multiple regressions traced to the same
root cause, link them all in the fix-issue body — closing the fix
issue won't auto-close them, but the linkage makes the cleanup pass
easy.

---

## 4. Artifacts

Every failing `build-quality.yml` run uploads `pass1.json` +
`pass2.json` as the `build-quality-passes` artifact (14-day
retention). When the regression issue's diff excerpt is truncated
(the embedded JSON is capped at ~50 lines by scope of #782), the full
diff is in those artifacts. The regression-issue body always links
the failing run, and the run page links the artifact.

---

## 5. test-bin warmer failure or timeout

A regression issue with the `test-bin-warmer` title suffix is **not** a
determinism or cache-hit-rate gate failure. It means the
`test-bin-baseline` job — `Warm test-bin cache (linux-x86_64)` — either
failed the full suite twice (attempt + retry) or was cancelled after it
started, normally because it hit its `timeout-minutes` cap. There is no
`pass1.json` / `pass2.json` artifact for this path; triage from the
`Warm test-bin cache` job log in the failing run.

- **`cancelled` after steps started → reportable cancellation/timeout.** The warmer runs
  `concurrency: cancel-in-progress: false`, so GitHub never cancels the
  active job to start a newer one (SFN-395). A burst of pushes can still
  replace an older **queued** job before it starts; `notify-failure`
  recognizes the empty step list and skips that expected coalescing, while
  the active warmer finishes and the latest queued warmer runs next
  (SFN-583). A cancellation after steps have started remains reportable;
  when it occurs at the job's wall-time cap, it is a `timeout-minutes`
  expiry. The cold full suite on
  the 4-core `ubuntu-24.04` runner has repeatedly crept toward the cap
  (run-1010 overran the old 60-min cap; PR #2492 raised it to 90 min). If
  the warm step is still running when the job is killed, the complete
  `Save test-bin cache for PR CI` step never lands; since SFN-797 the
  `Save partial test-bin cache` step publishes what was built under a
  `-partial-<run_id>-<run_attempt>` key, so PRs keep a warm-ish cache
  instead of falling back to an ever-older baseline. Expect the next run's
  `test_bin_hit_rate` to be materially above zero — if it is not, check
  that the partial save actually landed in the killed job's log.
  Confirm the wall-time trend and, if the suite has genuinely outgrown the
  cap, raise `timeout-minutes` or split the warmer (the incremental-restore
  follow-up); do **not** just re-run and hope.
- **`failure` conclusion → suite failure.** The suite failed twice (the
  retry-once #892 flake mitigation did not clear it). Treat it as a real
  test regression: reproduce with `make test` locally, bisect the offending
  commit, and file a `type:bug` fix issue that `Closes` the
  `build-quality regression: test-bin-warmer` dedup anchor.

A warmer regression does not by itself block a seed cut, but a persistently
stale test-bin cache slows every PR — treat it with the same urgency as a
gate failure until the warmer is green again.
