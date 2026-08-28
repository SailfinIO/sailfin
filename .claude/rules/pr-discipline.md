# PR discipline: push once, when the work is done

A session picks up an issue, implements it, validates it, gets it reviewed, and
**then** pushes and opens the PR. Pushing intermediate state to a branch that
already has a PR on it is not "showing progress" — on this repo it is a
throughput regression that lands on somebody else's PR.

## What actually costs runners

**Pushing a branch is free.** `ci.yml` triggers on `pull_request`,
`merge_group`, `schedule` and `workflow_dispatch` — there is no `push:` trigger
for `claude/*` branches, and `release-branches.yml` watches only `rc`/`beta`.
Committing and pushing work-in-progress to a branch with no PR runs nothing.

**Opening the PR starts the meter, and every later push restarts it.** macOS
runner concurrency is **5**, account-wide, and cannot be raised on the current
GitHub plan. One in-scope PR asks for six macOS job-slots —
`build-compiler-macos` plus the five grouped `build-macos` legs (the SFN-873
comment in `.github/workflows/ci.yml` explains why the eight shards are packed
into exactly five). **The pool is sized for one PR at a time.**

`ci.yml` sets `cancel-in-progress: true`, so a push to an open PR does not queue
a second run — it **kills the in-flight one and restarts from zero**. The
cancelled run is not free: it held its runners for its whole elapsed lifetime,
produced nothing, and skipped its post-job cache save, so the retry starts
colder.

Measured on 2026-08-28: six of twelve consecutive `ci.yml` runs were
`cancelled`, all on one branch being pushed to during an active session,
together occupying the pool for ~356 minutes of elapsed run time and producing
no usable result. In the same window, run `33190689012` — a *different*,
finished PR — had its `Build compiler [macos-arm64]` wait **136.2 minutes** to
start an 11.9-minute build, and took 202.4 minutes end to end.

## The rule

1. **Do the whole issue first.** Implement, then clear the validation ladder
   (`CLAUDE.md`) — `sfn check`, `sfn dev bootstrap build`, targeted tests — then
   get the change reviewed.
2. **Commit and push freely while you work.** It costs nothing and it protects
   the work: sessions run in ephemeral containers, so unpushed commits are lost
   when one is reclaimed.
3. **Open the PR only when the change is finished and reviewed.** That is the
   step that starts consuming the pool.
4. **Open it ready for review, not as a draft.** A draft defers CI rather than
   running it (below), so a draft PR is a parking spot, not a workspace.
5. **After the PR is open, push for review feedback and red CI** — the things a
   push is supposed to be for. That loop is governed by the PR-driving rules;
   this rule only covers getting there.

## How the draft gate behaves

A draft PR does not save CI by being a draft — `pull_request` fires on
`opened`/`synchronize` regardless of draft state. What saves CI is `ci-scope`'s
`ready` output: while a PR is a draft it forces every scope output false, so the
**entire** heavy matrix defers — macOS, Linux, Windows and aarch64 alike. Only
`ci-scope`, `linear-branch-claim` and `required-ci` run, and `required-ci` fails
closed with a "deferred" message so a draft can never advertise a green gate it
did not earn. `installer-smoke.yml` gates its installer matrix on the same
condition.

Two consequences worth knowing:

- **A red `Required CI gate` on a draft is expected**, not a failure to fix. It
  clears when you mark the PR ready.
- **Un-parking is not free.** `ready_for_review` reruns the full matrix even
  when the head SHA already has a complete green run, so toggling a PR between
  draft and ready costs a full re-run each time it comes back. Park a PR
  because it genuinely is not ready, not as a review-queue tactic.
