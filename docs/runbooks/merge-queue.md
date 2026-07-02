# Merge Queue enablement runbook

This runbook covers protecting `main` with a GitHub merge queue
(SFEP-0037 §3.1 — Rust's bors "not rocket science" rule): once enabled,
a PR lands only after CI passes on the **speculative merge commit
against the `main` tip at landing time**, serialized through a queue. A
merge result that went stale while other PRs landed is re-tested, never
assumed. Until the owner completes §1, `main` is not yet queue-protected
— the in-tree trigger alone changes nothing.

The in-tree half is done: `.github/workflows/ci.yml` triggers on
`merge_group`, and no job in it is conditioned on `github.event_name`,
so the full PR-gating surface (build legs, the 16 shard legs, shard-cover
lint, effect-gate smoke, Windows smoke) runs in queue context. This page
is the **owner-side half**: the repository-settings steps, which are not
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
   Check names are the **job `name:` values** from `ci.yml` (matrix legs
   expand per shard), not the workflow name.
4. Save. From this point PRs merge via **Merge when ready**, which queues
   the PR; the queue creates the speculative merge commit, fires the
   `merge_group` run of `ci.yml`, and lands the PR only if the required
   checks pass on that commit.

## 2. Required check names

From `.github/workflows/ci.yml`:

- `Shard-cover lint`
- `Build compiler [linux-x86_64]`
- `Build compiler [macos-arm64]`
- `Build + Test [linux-x86_64 / <shard>]` for each shard:
  `unit-a`, `unit-b`, `unit-c`, `int-caps`, `e2e-a`, `e2e-b`, `e2e-c`, `e2e-d`
- `Build + Test [macos-arm64 / <shard>]` for the same eight shards
- `Smoke test [windows-x86_64]`

Optional (not yet required): `Fast static check (sfn check compiler/src/)`
— its in-file comment says to promote it once it has proven stable across
a few cycles. The effect-gate smoke and fmt gates are steps *inside* the
primary `unit-a` legs, so they are covered by those legs' checks.

If a shard is added/renamed in `scripts/test_shards.sh` and the `ci.yml`
matrices, update the required-checks list in the same change — a renamed
job leaves a permanently-"Expected" required check that blocks the queue.

## 3. Behavior notes

- **Required checks move to the merge group.** With merge queue required,
  branch protection evaluates the required checks on the `merge_group`
  run (the speculative merge commit), not on the PR head. The
  `pull_request` run remains the early signal reviewers see.
- **Path filtering does not apply in the queue.** `ci.yml`'s
  `pull_request` trigger is path-filtered (compiler/runtime/build
  surfaces only), but `merge_group` supports no `paths:` filter — every
  queued merge runs full CI. Deliberate: docs-only PRs previously merged
  with no CI at all; through the queue they still land (their required
  checks come from the queue run) but the merge result is now tested.
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
