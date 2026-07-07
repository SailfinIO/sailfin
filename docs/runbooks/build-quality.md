# Build Quality runbook

`.github/workflows/build-quality.yml` enforces two structural contracts
on every `push` to `main` and every nightly cron at 05:00 UTC:

1. **Determinism** — a second self-hosted compile must produce a
   byte-identical binary and identical per-module `cache_key` set
   against the first pass (via `sfn build --check-determinism`).
2. **Cache hit rate** — the warm second pass must keep
   `cache.hit_rate >= 0.95`.

When either gate fails, the `notify-failure` job (issue #782) opens a
deduplicated regression issue labeled `area:architecture` and
`build-quality-regression` (build-quality regressions are inherently
release-critical; priority is set on the Linear mirror at triage — it is no
longer a GitHub label). If the failing event is `push: main`, the merging PR
also gets a comment linking the regression issue and the failing job.

This page is the triage runbook for those regressions.

---

## 1. Reproduce locally

Both gates run inside one second-pass invocation. Reproducing locally
is a single command; everything else is reading its output.

```bash
make compile                             # self-host from the pinned seed

# First pass — warm the cache. Mirrors the workflow.
build/native/sailfin build -p compiler \
  --work-dir build/det-pass1 --json | tee pass1.json

# Second pass — runs determinism check + emits the warm-cache BuildReport.
build/native/sailfin build -p compiler \
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

### Caveat: single-segment capsule name

The compiler self-host's `capsule.toml` declares
`[capsule].name = "sailfin"` — single-segment, so
`_emit_capsule_artifact_sidecar` skips sidecar emission and the
`--check-determinism` flag degrades to a binary-sha256 comparison
only. The `module_diffs` array will be empty even on a real
regression; triage from the printed `binary_sha256_a` /
`binary_sha256_b` and `binary_path_a` / `binary_path_b` fields
instead. Foreign capsules with scope/name form get full per-module
diffs.

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
  build/native/sailfin build -p compiler \
    --work-dir build/det-pass1 --json >/dev/null
  build/native/sailfin build -p compiler \
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
