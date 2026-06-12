# Pin the Seed Version

Open a PR bumping `.seed-version` (the repo-root pin file consumed by
`make fetch-seed`, `ci.yml`, `nightly-selfhost.yml`, and
`release-branches.yml`) to a newer Sailfin release.

This is the **manual half** of the release loop. `/release` cuts a new
alpha; `/pin-seed` adopts it as the build seed once the binary is
uploaded. The two are deliberately separate — auto-pinning every
release would force unnecessary CI recompiles. See
`docs/conventions/issue-naming.md` "Seed pinning" for the convention.

## Target: $ARGUMENTS

Parse `$ARGUMENTS` as an optional target version (with or without
leading `v`) plus optional flags:

- `--dry-run` — print intended actions but don't write or push.

If no version arg is given, pick the **most recently published release
tag** (this is the most recent prerelease for the project; not the
"latest stable" non-prerelease that `gh release view --json` would
return).

Examples:
- `/pin-seed` — pin to the most recently published release
- `/pin-seed v0.5.10-alpha.12` — pin to a specific version
- `/pin-seed --dry-run` — preview only

---

## Phase 1: RESOLVE TARGET

1. Read the current pin:
   ```bash
   cat .seed-version
   ```
2. If `$ARGUMENTS` provides a version, use it (strip leading `v`).
   Otherwise, list recent releases and pick the most recent:
   ```
   mcp__github__list_releases owner=SailfinIO repo=sailfin perPage=5
   ```
   Take `items[0].tag_name`, strip the leading `v`. Do not use
   `get_latest_release` — it returns only non-prereleases, which
   doesn't match Sailfin's alpha cadence.
3. Verify the target release has a binary uploaded. The release-tag
   workflow (`release-tag.yml`) takes a few minutes after `release.yml`
   finishes — check that the release has assets:
   ```bash
   gh release view "v<TARGET>" --json assets --jq '.assets | length'
   ```
   If 0 assets, `release-tag.yml` hasn't finished — abort with
   "binaries not yet uploaded for v<TARGET>; retry once
   release-tag.yml completes" and stop. Don't pin against a release
   the seed-fetch can't actually download.
4. If `target == current`: report no-op and stop.

---

## Phase 2: VERIFY THE SEED FETCHES

Before opening the PR, confirm the target binary actually downloads:

```bash
SEED_VERSION="<target>" make fetch-seed
```

This is non-destructive — it installs into `build/seed/versions/` and
doesn't touch `.seed-version`. If the fetch fails (404, checksum,
network), abort. If it succeeds, the binary is on disk and we know the
pin is valid.

If `--dry-run`, skip this phase.

---

## Phase 3: GATHER CONTEXT FOR THE PR BODY

1. **Closed `seed-blocker` issues since the last pin.** Use the
   commit timestamp of the last `.seed-version` change as the
   since-date:
   ```bash
   last_pin_at="$(git log -1 --format=%cI .seed-version)"
   ```
   Then:
   ```
   mcp__github__search_issues query='repo:SailfinIO/sailfin is:issue is:closed label:seed-blocker closed:>=<last_pin_at>'
   ```
   Surface the list — these are usually *why* the pin is being bumped.

2. **Open `seed-blocker` issues.** Note them as "still open after this
   pin" — they may be intentional (their fix lands in a future seed)
   or accidental (the pin is being made before they close, in which
   case ask the user to confirm).

3. **Compare URL.** `https://github.com/SailfinIO/sailfin/compare/v<current>...v<target>`

---

## Phase 4: BRANCH AND COMMIT

The pin commit lives off `main`, not the user's current `claude/*`
working branch — pinning is its own concern, not piggybacked on a
feature.

```bash
git fetch origin main
git checkout -b chore/pin-seed-v<TARGET> origin/main
```

If the branch already exists locally, switch to it instead and rebase
on origin/main.

```bash
echo "<TARGET>" > .seed-version
git add .seed-version
git commit -m "chore: bump seed to v<TARGET>"
```

If `--dry-run`, stop here without committing.

---

## Phase 5: PUSH AND OPEN PR

```bash
git push -u origin chore/pin-seed-v<TARGET>
```

Open the PR (draft):

```
mcp__github__create_pull_request
  owner=SailfinIO repo=sailfin
  head=chore/pin-seed-v<TARGET> base=main
  title='chore: bump seed to v<TARGET>'
  draft=true
  body=<see template below>
```

PR body template:

```markdown
## Summary

Bumps `.seed-version` from `<current>` → `<target>`.

`make fetch-seed` was run locally against the target and succeeded —
the binary downloads cleanly.

## Closed `seed-blocker` issues since the last pin

- #<N> — <title>
- ...

(or "None" if the search returned empty)

## Still open after this pin

- #<N> — <title> (`seed-blocker` open; intentional / will be addressed in a later seed)
- ...

## Comparison

https://github.com/SailfinIO/sailfin/compare/v<current>...v<target>

## Verification

- [ ] `make fetch-seed` succeeded locally
- [ ] CI green on this PR
- [ ] (optional) `make compile` succeeds against the new seed locally

https://claude.ai/code/session_<session-id>
```

---

## Phase 6: SWITCH BACK

After pushing, switch back to the user's prior branch so the rest of
their session isn't on `chore/pin-seed-*`:

```bash
git checkout -
```

Report:
- The PR URL
- "Merge once CI is green; rebase your working branch onto `main`
  afterwards to pick up the new seed."

---

## Constraints

- **Never amend or force-push the pin commit.** If review feedback
  comes in, add a follow-up commit on the branch.
- **Never bump the pin to a version whose binary hasn't uploaded.**
  This breaks `make fetch-seed` for everyone. Phase 1 step 3 enforces
  this.
- **Never auto-merge.** A human must review the pin — even a one-line
  change to `.seed-version` cascades through CI, nightly self-host,
  and the release-branches workflow.
- **Don't bundle other changes.** The pin is its own PR. If the user
  wants to drag in other fixes, they can rebase their feature branch
  on top after merge.
- **In `--dry-run`, make zero writes.** Print intended actions only;
  no branch creation, no commits, no pushes, no PR.
- **Don't pin from a `claude/*` branch onto itself.** Always branch
  off `main`. The current branch is unaffected.

---

## When NOT to run /pin-seed

- The new release is a routine alpha that fixes nothing the working
  set needs.
- A `seed-blocker` issue is still open and the pin would skip past it
  without resolving (unless the user explicitly wants to defer).
- `release-tag.yml` is still running for the target release — wait
  for it.
- The current pin is < 5 alphas behind and CI/nightly are green —
  the pin is doing its job; don't churn it.

## When to run /pin-seed

- A `seed-blocker` issue just closed and the fix shipped in the latest
  alpha.
- Downstream work needs a feature/fix that landed in a recent alpha.
- A `bump=patch` was just cut (almost always implies a hotfix-pin).
- The pin is far enough behind `main` that nightly self-host shows
  drift between seed and trunk.
