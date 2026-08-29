# Toolchain index refresh runbook

The canonical signed toolchain index publishes on the reserved
`toolchain-index-v1` GitHub release and carries an `expires_at`. Until
SFN-1204 the only thing that advanced that expiry was a release cut, so a
release drought longer than the window bricked every network-backed install.
`.github/workflows/toolchain-index-refresh.yml` advances the window on a
schedule, independent of releases.

This page documents the freshness invariant, the refresh job's stages, and
how to recover from an already-expired index.

---

## The invariant

`toolchain_index_verify` (`compiler/src/toolchain/index.sfn`, ~line 720)
refuses an expired index on the cached path as well as the fetched one —
deliberate, per SFEP-0073 §3.7: "expired metadata cannot claim that a user is
current." `toolchain_policy_decide`
(`compiler/src/toolchain/release_policy.sfn`, ~line 222) refuses
unconditionally on `!index.ok`.

So an expired index means every network-backed `sfn toolchain install` and
every project-pin auto-fetch through `dispatch.sfn::_dispatch_exec_target`
fails closed. The bootstrap seed path is exempt (SFN-1069) and is
unaffected. `SAILFIN_TOOLCHAIN=off` governs the version pin, not index
policy — it is **not** an escape hatch for an expired index.

Two producers advance the window, both calling
`scripts/publish-toolchain-index.py`:

- `.github/workflows/release-tag.yml`, job `upload`, step "Build and sign
  canonical toolchain index" — on a release cut. Sets a 35-day window
  (`generated_at` + 35 days).
- `.github/workflows/toolchain-index-refresh.yml` — scheduled Wednesday
  06:00 UTC plus `workflow_dispatch`, independent of releases. Restates the
  highest release already present in the index with a fresh 35-day window.

Both share `concurrency: group: release-publication,
cancel-in-progress: false` — the canonical index has one global monotonic
sequence, and a refresh must never race a release cut. `cancel-in-progress:
false` means a refresh queues behind an in-flight release rather than
cancelling it.

**The subtlety that makes the refresh job necessary.**
`publish-toolchain-index.py`'s `build_index` has an idempotence guard: when
the rebuilt index is semantically identical to the previous one *and* the
previous window has not expired yet (`previous_expiry > now`), it discards
the caller's new `generated_at`/`expires_at`, reuses the previous ones, and
keeps the same `sequence`. That default is correct for a release retry (no
sequence churn, byte-identical output). But it means a plain rerun on a
schedule is a **silent no-op** — the job goes green and the expiry never
moves. The refresh job therefore passes `--refresh-window`, which bypasses
that reuse branch and forces `sequence = previous + 1` with the caller's
window. Anyone editing the refresh job must keep that flag; dropping it
produces a green job that does nothing.

Note the guard's `previous_expiry > now` clause only applies *before*
expiry — it does not prevent one. Weekly cadence against a 35-day window
leaves roughly four missed runs of margin.

---

## Order of operations

Stages of `.github/workflows/toolchain-index-refresh.yml`, job `refresh`:

1. **Fetch the canonical signed index.** Confirms the `toolchain-index-v1`
   release exists and carries a complete `toolchain-index.json` +
   `.sig` pair; fails loudly and refuses to proceed if either is missing —
   a refresh must not bootstrap signed history.
2. **Report current freshness.** Reads `expires_at`/`sequence` from the
   fetched index, computes remaining days, and emits a `::warning::` if
   under `MIN_MARGIN_DAYS` (14).
3. **Resolve the release to restate.** Picks the highest version already
   present in the index's `releases` map, reads the channel that record
   already stores, and downloads that release's `SHA256SUMS` /
   `SHA256SUMS.sig`. The channel is read rather than re-inferred so the
   rebuilt record matches the stored one exactly. Never introduces a new
   release — publishing a release into the index is the release pipeline's
   job, not this one's.
4. **Build and sign the refreshed index** via
   `scripts/publish-toolchain-index.py --refresh-window`, with a fresh
   `generated_at` and `expires_at` = `generated_at` + `REFRESH_WINDOW_DAYS`
   (35, kept in step with `release-tag.yml`'s window).
5. **Assert the refresh cleared the margin.** Fails if the new sequence did
   not advance past the old one, if the new expiry is not later than the
   old one, or if the new expiry is still under `MIN_MARGIN_DAYS`.
6. **Publish**, same ordering as `release-tag.yml`: preserve the last
   authenticated pair as `toolchain-index.previous.json{,.sig}` first (so a
   failed public upload is repairable from the backup), draft the
   `toolchain-index-v1` release, upload the new pair, then undraft it
   (`--prerelease --latest=false`).

`workflow_dispatch` accepts `dry_run: true`, which runs steps 1-5 and skips
step 6.

`dry_run` is only reachable through `workflow_dispatch`; a scheduled run
always publishes. Any non-success result for the `refresh` job triggers
`notify-slack-failure`, posting to `SLACK_RELEASE_WEBHOOK_URL`.

---

## Recovery from an already-expired index

This is the direct remediation for a lapsed `expires_at` — no compiler
change, no release cut, and no client-side override is required or
available.

1. Dispatch the refresh job manually:

   ```bash
   gh workflow run toolchain-index-refresh.yml
   ```

2. Once the index has actually expired, the producer's idempotence guard
   no longer applies — its `previous_expiry > now` clause is false, so the
   `else` branch runs and the sequence advances (`previous["sequence"] + 1`)
   *even without* `--refresh-window`. The job passes the flag regardless,
   so a single manual dispatch is the only action needed; no special
   "post-expiry" mode exists or is required.
3. Confirm recovery once the run completes:

   ```bash
   gh release view toolchain-index-v1 --json assets
   gh release download toolchain-index-v1 --pattern toolchain-index.json --dir /tmp --clobber
   jq '.expires_at, .sequence' /tmp/toolchain-index.json
   ```

   `expires_at` should be roughly `REFRESH_WINDOW_DAYS` (35) days out from
   the dispatch time, and `sequence` should be one higher than the expired
   index's.

If the manual dispatch itself fails, work the **Failure modes** below —
the two most likely causes post-expiry are a missing canonical release pair
(bootstrap territory, not refresh territory) or a rotated signing key that
predates the release being restated.

---

## Failure modes

- **Canonical release absent or public pair incomplete.** The job fails
  deliberately at step 1 — a refresh must not bootstrap signed history.
  Repair through the release path (`release-tag.yml`), not this workflow.
- **Signing key rotated since the restated release was cut.**
  `parse_manifest` in `scripts/publish-toolchain-index.py` verifies the
  release manifest against the *active* signing key, so restating a release
  predating the rotation fails. Cut or restate a release signed by the
  current key instead.
- **Refresh racing a release cut.** Prevented by the shared
  `release-publication` concurrency group; a refresh queues rather than
  cancelling.
- **`--refresh-window` accidentally dropped from the workflow.** Green job,
  no window movement, silent regression toward expiry — because the
  producer's idempotence guard treats the rebuilt index as a no-op. This is
  the one to watch for in review of any change to
  `.github/workflows/toolchain-index-refresh.yml`.
- **Missing `SAILFIN_RELEASE_SIGNING_KEY` secret.** The build step fails
  before publication; nothing is uploaded.

---

## References

- SFN-1204 — this job.
- SFEP-0073 §3.6-§3.7 (`docs/proposals/0073-toolchain-lifecycle.md`) —
  release discovery and trust, the expired-metadata invariant.
- `.github/workflows/toolchain-index-refresh.yml` — the refresh job.
- `.github/workflows/release-tag.yml` — the release-cut producer.
- `scripts/publish-toolchain-index.py` — shared index builder/signer and its
  idempotence guard.
- `compiler/src/toolchain/index.sfn` — `toolchain_index_verify`.
- `compiler/src/toolchain/release_policy.sfn` — `toolchain_policy_decide`.
- SFN-1069 / SFN-1062 — the originating bootstrap-seed-exemption and
  toolchain-lifecycle work.
