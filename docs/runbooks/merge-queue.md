# Merge Queue enablement runbook

This runbook covers protecting `main` with a GitHub merge queue
(SFEP-0037 §3.1 — Rust's bors "not rocket science" rule): once enabled,
a PR lands only after CI passes on the **speculative merge commit
against the `main` tip at landing time**, serialized through a queue. A
merge result that went stale while other PRs landed is re-tested, never
assumed. Until the owner completes §1, `main` is not yet queue-protected
— the in-tree trigger alone changes nothing.

The in-tree half is done: `.github/workflows/ci.yml` triggers on
`merge_group`, computes PR path scope inside the workflow, and reports a
single always-present `Required CI gate` job for repository rulesets. In
queue context the scope is forced on, so the full PR-gating surface
(build legs, the 16 shard legs, shard-cover lint, effect-gate smoke,
Windows smoke) runs against the speculative merge commit. This page is
the **owner-side half**: the repository-settings steps, which are not
committable.

`build-quality.yml` (determinism + cache hit-rate) deliberately stays
**out** of the queue — it is the post-merge structural backstop and is
too slow for queue latency. See `docs/runbooks/build-quality.md`.

---

## 1. Enablement steps (repository owner)

1. **Settings → Branches → Branch protection rules → `main`** (or the
   equivalent ruleset under Settings → Rules → Rulesets).
2. Enable **Require merge queue**.
   - Merge method: **squash** (matches current repo practice).
   - Build concurrency / queue sizing: defaults are fine at current PR
     volume; revisit if the queue backs up.
3. Under **Require status checks to pass**, add the check names in §2.
   Check names are the **job `name:` values**, not the workflow name.
4. Save. From this point PRs merge via **Merge when ready**, which queues
   the PR; the queue creates the speculative merge commit, fires the
   `merge_group` run of `ci.yml`, and lands the PR only if the required
   checks pass on that commit.

## 2. Required check names

From `.github/workflows/ci.yml`:

- `Required CI gate`

Do **not** require the individual build, shard, or smoke-test job names.
Those jobs intentionally skip on docs/site-only PRs, and requiring a job
that was never created leaves GitHub waiting on an "Expected" check. The
aggregate gate is always created on PRs and merge groups; it passes
docs/site-only PRs after `CI scope` marks compiler CI out of scope, and
fails any in-scope PR where a compiler build, shard, shard-cover,
fast-check, or Windows smoke job does not succeed.

The effect-gate smoke and fmt gates are steps *inside* the primary
`unit-a` legs, so they are covered by `Required CI gate` through those
legs' aggregate result.

## 3. Behavior notes

- **Required checks move to the merge group.** With merge queue required,
  branch protection evaluates the required checks on the `merge_group`
  run (the speculative merge commit), not on the PR head. The
  `pull_request` run remains the early signal reviewers see.
- **Path filtering lives inside the workflow.** `ci.yml` runs on every
  pull request so `Required CI gate` always exists. The `CI scope` job
  skips the heavy compiler surface for PRs that do not touch compiler,
  runtime, capsule, build-script, Makefile, seed-pin, CI-workflow, or
  composite-action paths. `merge_group` supports no `paths:` filter, so
  queue runs are always marked in-scope and run full CI. Deliberate: the
  merge result is tested before landing.
- **Queue-context refs.** `merge_group` runs see
  `github.ref = refs/heads/gh-readonly-queue/main/...`, so the
  `ci-pr-${{ github.ref }}` concurrency group stays unique per queue
  entry, and the fixed-point rebuild steps (gated to
  `refs/heads/main|rc`) stay off in the queue, exactly as in PR context.

## 4. Verification (done-bar from SFEP-0037 §3.1)

Two PRs that individually pass CI but conflict semantically cannot both
land: queue both; the first lands, the second's `merge_group` run is
re-tested against the new `main` tip and fails in the queue — `main`
stays green. Tracking issue: #1806.
