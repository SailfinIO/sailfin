# PR discipline: push once, when the work is done

A session picks up an issue, implements it, validates it, gets it reviewed, and
**then** pushes and opens the PR. Pushing intermediate state to a branch that
has a PR on it is not "showing progress" — on this repo it is a throughput
regression that lands on somebody else's PR.

## Why this is a rule and not a preference

macOS runner concurrency is **5**, account-wide, and cannot be raised on the
current GitHub plan. One in-scope PR already asks for six macOS job-slots:
`build-compiler-macos` plus the five grouped `build-macos` legs
(`.github/workflows/ci.yml`, and the SFN-873 grouping comment there explains
why the eight shards are packed into exactly five). **The pool is sized for one
PR at a time.**

`ci.yml` sets `cancel-in-progress: true`, so a mid-work push does not queue a
second run — it **kills the in-flight one and restarts from zero**, discarding
every macOS minute already spent and skipping the post-job cache save, so the
retry starts colder. A branch pushed six times over a session costs roughly six
times the runner-hours of the same branch pushed once, and every one of those
runs occupies the pool that a finished PR is waiting on.

This is measured, not theoretical. In one afternoon, six of twelve consecutive
`ci.yml` runs were `cancelled` — all on a single branch being pushed to during
an active session — and a different, finished PR's `Build compiler [macos-arm64]`
waited **136 minutes** to start an 11.9-minute build, because the pool was held
by runs that were all subsequently thrown away.

## The rule

1. **Do the whole issue first.** Implement, then clear the validation ladder
   (`CLAUDE.md`) — `sfn check`, `sfn dev bootstrap build`, targeted tests — then
   get the change reviewed.
2. **First push is the finished change.** Not a checkpoint, not a WIP commit.
   Local commits are free; make as many as the history deserves and push them
   together.
3. **Open the PR ready for review.** A draft PR does not save CI by itself —
   `pull_request` fires on `opened`/`synchronize` regardless of draft state.
   What saves CI is `ci-scope`'s `ready` output, which defers every heavy leg
   while the PR is a draft and fails `Required CI gate` closed until it is
   marked ready. A draft is therefore a valid parking spot, not a workspace:
   parking one costs nothing, but pushing to it repeatedly still burns the
   Linux, Windows and aarch64 legs.
4. **After the PR is open, pushes are for review feedback and red CI** — the
   things a push is supposed to be for. That is the loop the PR-driving rules
   already describe; this rule only governs getting there.

## When you genuinely need CI before you are done

Say so and push once, deliberately — do not drip. If a change can only be
validated on a runner (a macOS-only failure, a Windows path bug), push the
smallest tree that reproduces it, let one run complete, and read it. A run you
cancel two minutes later taught you nothing and cost the pool ~154 macOS
runner-minutes of eviction.
