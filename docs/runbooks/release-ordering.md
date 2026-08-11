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

### Stage 3 — `release-tag.yml`, job `upload` ("Verify, promote & publish")

6. Download every leg's artifacts, normalize the layout, rename installers
   to their final `sailfin_<version>_<os>_<arch>.tar.gz` names.
7. Verify expected platform payloads are all present
   (`scripts/verify-release-payloads.sh`).
8. Verify the dependency closure inside every platform tarball
   (`scripts/verify-payload-dep-closure.sh`).
9. Sign the `SHA256SUMS` manifest (`scripts/sign-release-manifest.sh`),
   which self-verifies against the committed public key.
10. **Promote** — the first and only mutation of `main`. A single
    `git push --atomic` pushes both `<staging_sha>:refs/heads/main` and the
    annotated tag, non-force. Atomic means `main` and the tag land together
    or not at all; non-force means the push is rejected outright if `main`
    advanced during the build.
11. Publish the GitHub Release atomically via `gh release create
    --verify-tag` (creates a draft internally, uploads every asset,
    publishes only once all uploads succeed).

### Stage 4 — `release.yml`, job `cleanup-staging`

Deletes `release-staging/v<version>` when the run succeeded. On failure the
branch is deliberately left in place for inspection, with the delete
command printed in the run log.

---

## Failure modes

**A payload gate fails (stages 2–3, steps 6–9).** `main` is unbumped, no
tag exists, no release was created. Fix the packaging defect and re-run the
release; the version number is not burned. This is the case SFN-829 exists
to produce.

**The promotion push is rejected (step 10).** `main` advanced while
payloads were building, so the staged bump is no longer a fast-forward.
Nothing was mutated — re-run the release workflow; the next attempt rebases
onto the newer `main`. This is the accepted cost of tagging exactly the
commit that was built: the tag's tree is always byte-identical to what
produced the published binaries, never a rebased approximation. The window
is the full build duration (up to 240 minutes on the `linux-arm64` leg), so
a cut racing an active merge stream can lose the race. `concurrency: group:
release` only serialises releases against each other — it does not
serialise a release against ordinary merges to `main`.

**Publication fails after promotion (step 11).** `main` is bumped and the
tag exists, but no public release was published — the one residual window,
now narrowed to the `gh release create` call itself. Remediate by
re-running `release-tag.yml` via `workflow_dispatch` against the existing
tag (`ref` blank → builds the tag; `promote` is not available on the
dispatch path, so a manual rebuild can never mutate `main`).

**A stale `release-staging/*` branch is left behind.** Expected after any
failed cut (stage 4 only deletes on success). Harmless — no workflow
triggers on that branch pattern, and the next cut for the same version
force-pushes over it. Delete manually with:

```bash
git push origin --delete release-staging/v<version>
```

---

## Also

- **Retroactive rebuild is unchanged.** `release-tag.yml` dispatched
  manually with a `tag` input and blank `ref` checks out the tag itself,
  exactly as before SFN-829, and cannot promote.
- **Dry runs are unchanged.** `release.yml` with `dry_run: true` computes
  and reports the version only — no file rewrite, no commit, no staging
  branch, no asset build.

---

## References

- SFN-829 — this invariant.
- SFN-799 — the required-leg-per-platform policy stage 2 relies on.
- `.github/workflows/release.yml` — stages 1 and 4.
- `.github/workflows/release-tag.yml` — stages 2 and 3.
- `.claude/commands/release.md` — the `/release` dispatch playbook.
