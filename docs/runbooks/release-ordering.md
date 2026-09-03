# Release ordering runbook

`.github/workflows/release.yml` and `.github/workflows/release-tag.yml`
together cut a Sailfin release. SFN-829 changed the order in which they
mutate the repo, in response to the 0.9.4 incident: the version bump landed
on `main` and the tag was pushed before any release asset had been built,
packaged, or verified. Every asset-side gate lived downstream in
`release-tag.yml`, which ran afterward (`needs: release`). A payload defect
therefore left `main` claiming a version that was never published — the
0.9.4 cut shipped a payload missing the runtime capsule's `sfn/crypto`
dependency closure, every program built against a fresh install failed to
link, the release was deleted, but `main` still carries
`54f3d0e chore(release): 0.9.4` with `compiler/capsule.toml` at `0.9.4` and
no corresponding tag. The version number is burned; the next cut had to
skip straight to `0.9.5`.

This page documents the invariant SFN-829 established, the resulting order
of operations, and how to triage each failure mode.

---

## The invariant

**No release cut mutates `main` and no tag exists until every release
payload has been built, packaged, and passed every asset gate.** Up to the
promotion step, a cut is entirely abandonable — no bump on `main`, no tag,
nothing to roll back. This is deliberate: rolling back a bad bump would mean
force-pushing `main`, which is a worse cure than the disease.

The mechanism is a **staging branch**. The version bump is computed and
committed, but pushed to `release-staging/v<version>` rather than `main`.
Every asset build, package step, and gate runs against that staging branch.
Only after all of it passes does a single atomic, non-force push land the
bump on `main` and create the tag together.

---

## Order of operations

### Stage 1 — `release.yml`, job `release` ("Stage version bump")

No public mutation.

1. Compute the next version from `compiler/capsule.toml` per the `channel`
   and `bump` inputs; guard against no-op bumps and against a tag that
   already exists.
2. Rewrite the version across `compiler/capsule.toml`, every
   `compiler/capsules/*/capsule.toml`, `compiler/src/version.sfn`'s
   `__version_fallback__`, and `llms.txt`'s `> Version:` stamp.
3. Commit `chore(release): <version>` locally.
4. Fetch `origin/main`; apply the `verified_sha` self-host gate (refuse to
   cut if `origin/main` advanced onto compiler/runtime/seed changes the
   green nightly never verified); rebase the bump commit onto
   `origin/main`.
5. Force-push that commit to a staging branch `release-staging/v<version>`
   — not `main`, not a tag. Outputs `staging_ref` and `staging_sha`.

### Stage 2 — `release-tag.yml`, job `build`

Still no public mutation. Called with `ref: <staging_ref>`,
`expect_sha: <staging_sha>`, `promote: true`.

Each matrix leg (`macos-arm64`, `linux-x86_64`, `linux-arm64`; Windows is
cross-built inside the `linux-x86_64` leg) checks out the staging branch,
asserts `HEAD` equals `expect_sha`, then builds, packages, and runs the
per-leg gates: hello-world smoke, compiler-version-matches-tag, installer
payload version, installer payload dependency closure (and the Windows
tarball's closure on the `linux-x86_64` leg). All matrix legs are required
— `fail-fast: false` plus a required-leg policy means a failed
`linux-arm64` withholds publication rather than shipping an incomplete
platform set (SFN-799).

**`native-windows-cross-seed` + `native-windows-build` (SFEP-0021 M11 /
SFN-57), running parallel to the matrix above, not sequenced after it.**
Builds a native MSVC compiler on `windows-2025` (mirroring
`windows-native-selfhost.yml`'s own `cross-seed` + `native-build` jobs: its
own mingw-cross bootstrap seed, the `sailfin-build-windows` composite, then
`sfn package --installer --target windows-x86_64-msvc`), producing
`sailfin_<version>_windows_x86_64-msvc.tar.gz` alongside the mingw-cross
`sailfin_<version>_windows_x86_64.tar.gz` asset the matrix already produces.
It does **not** run the self-host fixed point — deliberately, and in the same
shape as the other three platform legs, none of which run one in the release
path either (`release-tag.yml:630-645`). Determinism is
`nightly-selfhost.yml`'s and `windows-native-selfhost.yml`'s job, on every
push to `main` and daily, so the commit being released has already been
fixed-point-verified before this leg builds it again. Its job-level result is
still not checked by `upload`'s `needs:` (below), but as of SFN-1024 its
artifact is a required release payload (`scripts/verify-release-payloads.sh`),
so a failed or missing native leg now blocks publishing via that payload gate
rather than via `needs:`. A failure/cancellation is also reported via the
release Slack webhook (`notify-slack-failure`). See the accepted-latency note
under **Also** below for why it runs in parallel rather than after the
matrix.

### Stage 3 — `release-tag.yml`, job `upload` ("Verify, promote & publish")

`needs: [build, native-windows-build]`, with
`if: !cancelled() && needs.build.result == 'success'` — a cancelled or
failed `native-windows-build` cannot hard-skip this job (which a bare
`needs:` without that override would otherwise do), and its result is
deliberately not checked directly here. That no longer means the native
leg's failures go unenforced: as of SFN-1024 its payload is required by
`scripts/verify-release-payloads.sh` (step 7 below), so a failed or missing
native leg still blocks publication — via the payload gate, not this `if:`.

6. Download every leg's artifacts, normalize the layout, rename installers
   to their final `sailfin_<version>_<os>_<arch>.tar.gz` names (the MSVC
   asset gets its own `-msvc` variant suffix via a `*windows-x86_64-msvc*`
   classifier arm ordered before the broader `*windows-x86_64*` one — first
   match wins, and the mingw pattern also matches the msvc filename).
7. Verify expected platform payloads are all present
   (`scripts/verify-release-payloads.sh`).
8. Verify the dependency closure inside every platform tarball
   (`scripts/verify-payload-dep-closure.sh`).
9. Sign the `SHA256SUMS` manifest (`scripts/sign-release-manifest.sh`),
   which self-verifies against the committed public key.
10. Fetch the canonical, preserved, and complete versioned toolchain-index
    pairs; authenticate them, require equal-sequence byte identity, select the
    globally highest sequence, and validate/advance it from the final assets
    and `SHA256SUMS`,
    then sign and self-verify canonical `toolchain-index.json` bytes. This is
    still pre-promotion and fails closed on expiry, rollback, host/digest,
    release-state, signature, or key-transition errors.
11. **Promote** — the first and only mutation of `main`. A single
    `git push --atomic` pushes both `<staging_sha>:refs/heads/main` and the
    annotated tag, non-force. Atomic means `main` and the tag land together
    or not at all; non-force means the push is rejected outright if `main`
    advanced during the build.
12. Publish the GitHub Release atomically via `gh release create
    --verify-tag` (creates a draft internally, uploads every asset,
    including the signed index pair, and publishes only once all uploads
    succeed).
13. Preserve the last authenticated pair as
    `toolchain-index.previous.json{,.sig}`, then replace the public signed pair
    under the reserved `toolchain-index-v1` release-base path. The reserved
    release stays draft while both public assets are replaced, then becomes
    public and non-latest again.

### Stage 4 — `release.yml`, job `cleanup-staging`

Deletes `release-staging/v<version>` when the run succeeded. On failure the
branch is deliberately left in place for inspection, with the delete
command printed in the run log.

---

## Failure modes

**A payload/index gate fails (stages 2–3, steps 6–10).** `main` is unbumped, no
tag exists, no release was created. Fix the packaging defect and re-run the
release; the version number is not burned. This is the case SFN-829 exists
to produce.

**The promotion push is rejected (step 11).** `main` advanced while
payloads were building, so the staged bump is no longer a fast-forward.
Nothing was mutated — re-run the release workflow; the next attempt rebases
onto the newer `main`. This is the accepted cost of tagging exactly the
commit that was built: the tag's tree is always byte-identical to what
produced the published binaries, never a rebased approximation. The window
is the full build duration (up to 240 minutes on the `linux-arm64` leg), so
a cut racing an active merge stream can lose the race. The parent `release`
group serialises cuts, and `release-publication` also serialises direct tag
repairs so index sequences cannot race; neither group serialises a release
against ordinary merges to `main`.

**Versioned publication fails after promotion (step 12).** `main` is bumped and the
tag exists, but no public release was published — the one residual window,
now narrowed to the `gh release create` call itself. Remediate by
re-running `release-tag.yml` via `workflow_dispatch` against the existing
tag (`ref` blank → builds the tag; `promote` is not available on the
dispatch path, so a manual rebuild can never mutate `main`).

**Canonical index replacement fails (step 13).** The versioned release still
carries the newly signed index pair, but the stable discovery endpoint is left
unchanged or draft. Re-run `release-tag.yml` for the exact existing tag. The
producer selects the globally highest authenticated canonical, preserved, or
versioned candidate, republishes identical versioned assets, and then repairs
the reserved endpoint. An incomplete preserved backup is ignored and replaced
from an authenticated candidate. Do not hand-edit the payload or upload only
one member of the pair.

**The reserved index tag is missing.** Ordinary releases fail instead of
inferring a new sequence-1 history. For the very first publication only,
manually run `release.yml` (or `release-tag.yml` for an existing tag) with
`bootstrap_index: true`; the workflow also proves that no versioned release
has published either toolchain-index asset and that the reserved Git tag does
not already exist. When complete versioned pairs
exist, the workflow authenticates all of them and restores from the globally
highest sequence regardless of which release tag was dispatched. Never use
bootstrap to repair a deleted endpoint.

The same recovery applies when the reserved Git tag still exists but its
GitHub Release object was deleted: the workflow detects the missing release
object through the API and recreates it against the existing verified tag.

**`bootstrap_index` is out of the release train's reach, by design.**
`release-train.yml` dispatches `release.yml` with `channel`, `bump`, `dry_run`
and `verified_sha` only. Withholding `bootstrap_index` is deliberate
authorization scoping, not an oversight (SFN-1123): it is the one input that
resets the canonical index's monotonic signed history to sequence 1, that reset
has no undo, and a scheduled, unattended job must not hold that authority. The
first publication is a once-ever operator act on a manual `release.yml` or
`release-tag.yml` run.

This does **not** constrain repair. The gate demands `bootstrap_index` only when
no complete candidate pair exists anywhere — no canonical release object *and*
no versioned release carrying both `toolchain-index.json` and its `.sig`.
(Presence, not authenticity: a complete-but-unverifiable pair clears this shell
gate and fails later inside `publish-toolchain-index.py`.)
Restoring a deleted canonical release object while versioned pairs survive takes
the recovery branch above and needs no authorization, so it runs through the
automatic train unchanged.

Because the train cannot supply the input, it **preflights** the condition
before dispatching: if no canonical release object exists and no versioned
release carries a complete pair, the train refuses to dispatch, names
`bootstrap_index` in the failure, and posts the same reason to the cadence
comment and Slack. Previously that state was only discovered inside
`release-tag.yml`, after four green platform builds. A blocked train is an
operator task, not a retry: perform the manual bootstrap once, then re-run the
train.

One trap before that bootstrap. The gate's `prior_index_asset` check matches
**either** index member, while candidate selection requires **both** — so a
versioned release left carrying a single stray `toolchain-index.json` or
`.sig` (the "versioned publication fails after promotion" mode above) is not a
candidate, yet still trips the bootstrap anti-footgun with *"a versioned
release already carries a signed index"*. Delete the stray asset before running
with `bootstrap_index: true`, or the manual cut burns a second full matrix to
report it. The train's preflight names this explicitly when it detects one.

This remediation does **not** work for tags before v0.10.3. A re-run checks
out the tag's own tree, which predates
`.github/actions/sailfin-build-windows`, so `native-windows-build` fails,
no msvc artifact is produced, and — since SFN-1024 made that payload
required — the payload gate fails before promotion. Those tags are no
longer re-publishable through this workflow; attach assets with
`gh release upload` instead. Recent tags re-run normally, because the leg
rebuilds from a tree that contains it.

**A stale `release-staging/*` branch is left behind.** Expected after any
failed cut (stage 4 only deletes on success). Harmless — no workflow
triggers on that branch pattern, and the next cut for the same version
force-pushes over it. Delete manually with:

```bash
git push origin --delete release-staging/v<version>
```

**`native-windows-build` fails or is cancelled.** As of SFN-1024, this now
blocks the release: its artifact is a required payload
(`scripts/verify-release-payloads.sh`), so a missing or broken MSVC asset
fails the "verify expected platform payloads" gate (stage 3, step 7) before
promotion, the same as any other missing platform payload — see **A payload
gate fails** above. `notify-slack-failure` still fires in this case too.
Re-run is a plain re-run of the release once the native leg is fixed; nothing
mutated `main`.

---

## Also

- **Retroactive rebuild is unchanged.** `release-tag.yml` dispatched
  manually with a `tag` input and blank `ref` checks out the tag itself,
  exactly as before SFN-829, and cannot promote.
- **Dry runs are unchanged.** `release.yml` with `dry_run: true` computes
  and reports the version only — no file rewrite, no commit, no staging
  branch, no asset build.
- **The native Windows leg's accepted latency cost.** Measured release
  durations (the 0.10.1 cut) put the matrix's own critical path around
  10 minutes (`macos-arm64`, its slowest leg) and the whole run at roughly
  12 minutes end to end. `native-windows-cross-seed` +
  `native-windows-build` run in parallel with the matrix rather than after
  it specifically to avoid stacking their own ~45-75 minute chain (bootstrap
  seed + staircase + Stage 2 self-host + fixed point + packaging) on top of
  that — but `upload` still `needs:` the native leg to finish (even though
  it ignores the result), so a slow-but-not-failing run can still stretch
  the pre-`Promote` window well past the ~12-minute baseline. Every added
  minute in that window raises the odds of the non-force `git push
  --atomic` in step 11 being rejected because `main` advanced during the
  build — accepted deliberately (SFEP-0021 M11 / SFN-57) rather than
  discovered as a surprise regression.

---

## References

- SFN-829 — this invariant.
- SFN-799 — the required-leg-per-platform policy stage 2 relies on.
- SFN-57 / SFEP-0021 M11 — the native MSVC Windows leg.
- `.github/workflows/release.yml` — stages 1 and 4.
- `.github/workflows/release-tag.yml` — stages 2 and 3.
- `.github/workflows/windows-native-selfhost.yml` — the nightly job the
  native leg's `cross-seed`/`native-build` shape is modelled on.
- `.claude/commands/release.md` — the `/release` dispatch playbook.
