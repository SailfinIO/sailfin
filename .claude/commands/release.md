# Release a new Sailfin version

Trigger a new Sailfin compiler release via the GitHub Actions `release.yml`
workflow.

## How releases work

Sailfin uses a manually-triggered release workflow instead of auto-releasing on
every merge.  The canonical version lives in `compiler/capsule.toml` and is
mirrored in `compiler/src/version.sfn`.

The public minor-alpha train is automated separately by
`.github/workflows/release-train.yml`: on the 2-week Monday cadence, a scheduled
train run dispatches `release.yml` with `channel=alpha bump=minor` when the
latest nightly self-host check on `main` is green. Manual `/release` remains the
path for routine alpha prereleases, hotfix/off-cadence cuts, and stable
promotion.

The workflow accepts two inputs:
- **channel**: `alpha` | `beta` | `rc` | `stable`
- **bump**: `prerelease` | `patch` | `minor` | `major`

## Release tracking (curated vs uncurated cuts)

Exactly one combination is **uncurated** — it takes whatever is on `main`
without any pre-flight checks:

- `channel=alpha bump=prerelease` (the routine daily alpha bump)

**Every other combination is curated.** That includes any `bump=patch`,
`bump=minor`, `bump=major`, and any channel that isn't `alpha` (i.e. any
promotion to `beta`, `rc`, or `stable`).

For curated cuts, look up the tracking issue titled exactly
`Release: vX.Y.Z` (e.g. `Release: v0.6.0`) and check the matching
`release:*` label set:

| Curated cut | Hard gate label | Soft gate (mention but don't block) |
|---|---|---|
| `bump=patch` (any channel) | (none — confirm intent) | open `release:next-minor` items will roll forward to the next patch |
| `bump=minor` (any channel) | `release:next-minor` | open `release:1.0` items |
| `bump=major` | `release:1.0` (when target is 1.0.0) | — |
| Promotion to `channel=beta` | `release:beta` | open `release:next-minor` items |
| Promotion to `channel=rc` | `release:rc` | open `release:beta` items |
| Promotion to `channel=stable` | `release:stable` | open `release:rc` items |

A "hard gate" means: list every open issue holding the label and require
explicit override before dispatch. A "soft gate" means: mention as context
but don't ask twice. The gate is always advisory — the human can always
override.

See `docs/conventions/issue-naming.md` "Release tracking" for the convention.

## What to do

### 1. Read the current version

```bash
sed -n 's/^version *= *"\([^"]*\)"/\1/p' compiler/capsule.toml
```

### 2. Confirm the user's intent

Ask the user what kind of release they want if not already clear from
context.  Common scenarios:
- "cut an alpha" → `channel=alpha bump=prerelease` (uncurated)
- "new patch alpha" → `channel=alpha bump=patch` (curated — `bump=patch`)
- "promote to beta" → `channel=beta bump=prerelease` (curated — promotion)
- "promote to rc" → `channel=rc bump=prerelease` (curated — promotion)
- "ship it" / "GA release" → `channel=stable bump=prerelease` (curated — promotion)
- "minor release" → `channel=alpha bump=minor` (curated — minor) or ask which channel

### 3. Compute the target version

Apply the version math from the workflow (see "Version math reference" below)
to derive the target. State the transition explicitly:

```
Current: X.Y.Z-channel.N
Next:    X.Y.Z-channel.M
```

### 4. Run the release-tracking gate (curated cuts only)

If the cut is curated (per the table above — i.e. anything other than
`channel=alpha bump=prerelease`), do all of these before dispatching:

a. **List open issues holding the hard-gate label.** Use the GitHub MCP tools:

   ```
   mcp__github__search_issues query="repo:SailfinIO/sailfin is:open label:release:<gate>"
   ```

   where `<gate>` is `next-minor` | `beta` | `rc` | `stable` | `1.0`. Also
   list the soft-gate label as advisory context (per the table above).

b. **Look up the tracking issue.** Search for the exact title:

   ```
   mcp__github__search_issues query="repo:SailfinIO/sailfin is:issue in:title \"Release: v<X.Y.Z>\""
   ```

   If the tracking issue exists, link it in the dispatch summary. If it
   doesn't exist for a curated cut, point that out — usually it should.
   Don't auto-create it; that's a human-or-`/groom` decision.

c. **Surface the gap to the user.** Present a short list:

   ```
   Curated cut: vX.Y.Z (channel=<c> bump=<b>)
   Tracking issue: Release: vX.Y.Z (#NNN)  [or: not found]
   Open `release:<gate>` items (N):
     - #NNN <title>
     - ...
   ```

   Estimate/priority are Linear-native fields, not GitHub labels — if the
   user wants them, read them off the issue's Linear mirror
   (`mcp__Linear__*`) rather than a `size:_`/`priority:_` label.

d. **Require explicit override if anything is open.** Ask the user:
   "N items are still open under `release:<gate>`. Cut anyway, or wait?"
   Do not dispatch unless the user explicitly says cut anyway. If they
   wait, stop and surface the open list — don't try to fix anything.

For uncurated cuts (`channel=alpha bump=prerelease`), skip the gate entirely
and proceed to dispatch.

### 5. Dispatch the workflow

Use the GitHub MCP tool to dispatch `release.yml` on `main`:

```
mcp__github__actions_run_trigger
  owner=SailfinIO repo=sailfin workflow_id=release.yml ref=main
  inputs={"channel": "<channel>", "bump": "<bump>"}
```

Or for a dry run first:

```
mcp__github__actions_run_trigger
  owner=SailfinIO repo=sailfin workflow_id=release.yml ref=main
  inputs={"channel": "<channel>", "bump": "<bump>", "dry_run": "true"}
```

### 6. After dispatching

Tell the user:
- The workflow has been triggered.
- They can monitor it at: https://github.com/SailfinIO/sailfin/actions/workflows/release.yml
- The release-notes agentic workflow (`release-notes.md`) will post a
  structured changelog comment on the release once it's published.

If a tracking issue exists for the target version and this cut is curated,
post a brief comment on the tracking issue (use
`mcp__github__add_issue_comment`):

```
Cutting **vX.Y.Z** now (channel=<c> bump=<b>).
Workflow: <run URL once available>
Compare: https://github.com/SailfinIO/sailfin/compare/<prev_tag>...v<X.Y.Z>
```

If the cut is `bump=minor` or any `channel=stable` promotion, also remind
the user to consider closing the tracking issue once the release publishes
successfully (the release-notes generator can do this in a follow-up; don't
auto-close from the skill).

### 7. Suggest `/pin-seed` if the cut warrants it

After the dispatch summary, suggest running `/pin-seed` as a follow-up
when **any** of these is true:

- The cut is `bump=patch` (almost always implies a hotfix-pin).
- A `seed-blocker` issue closed since the current seed pin was set:
  ```bash
  last_pin_at="$(git log -1 --format=%cI bootstrap.toml)"
  ```
  ```
  mcp__github__search_issues query='repo:SailfinIO/sailfin is:issue is:closed label:seed-blocker closed:>=<last_pin_at>'
  ```
- The cut is a non-alpha promotion (beta/rc/stable) — usually the
  pin should advance to the promoted version.

When suggesting, mention that `/pin-seed` should be run **after**
`release-tag.yml` finishes uploading binaries (a few minutes), and
that the pin is its own PR off `main` — not a piggyback on the cut
commit. See `docs/conventions/issue-naming.md` "Seed pinning" for
the convention.

## Version math reference

Given current version `0.5.0-alpha.22`:

| Command | Result |
|---------|--------|
| channel=alpha, bump=prerelease | `0.5.0-alpha.23` |
| channel=alpha, bump=patch | `0.5.1-alpha.1` |
| channel=alpha, bump=minor | `0.6.0-alpha.1` |
| channel=alpha, bump=major | `1.0.0-alpha.1` |
| channel=beta, bump=prerelease | `0.5.0-beta.1` |
| channel=rc, bump=prerelease | `0.5.0-rc.1` |
| channel=stable, bump=prerelease | `0.5.0` |

## Notes

- Demotions are not allowed (e.g., rc → alpha). Bump major/minor/patch to
  start a new cycle.
- The workflow requires the `RELEASE_PAT` secret to be configured.
- Release assets (platform binaries, installers) are built automatically by
  `release-tag.yml` after the tag is created.
- An agentic workflow (`release-notes.md`) generates structured release notes
  once the GitHub Release is published.
- The release-tracking gate is intentionally a soft gate — `/release` will
  list open items and ask, but never refuse to dispatch. The human always
  has the final call.
