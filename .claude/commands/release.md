# Release a new Sailfin version

Trigger a new Sailfin compiler release via the GitHub Actions `release.yml`
workflow.

## How releases work

Sailfin uses a manually-triggered release workflow instead of auto-releasing on
every merge.  The canonical version lives in `compiler/capsule.toml` and is
mirrored in `compiler/src/version.sfn`.

The workflow accepts two inputs:
- **channel**: `alpha` | `beta` | `rc` | `stable`
- **bump**: `prerelease` | `patch` | `minor` | `major`

## Release tracking (curated cuts)

Some cuts are **uncurated** — they take whatever happens to be on `main`:

- `channel=alpha bump=prerelease` (the routine daily bump)

Some cuts are **curated** — they gate on `release:*` labels and a tracking issue:

- Any `bump=minor` or `bump=major`
- Any channel promotion: `alpha → beta`, `beta → rc`, `rc → stable`, anything to `stable`

For curated cuts, look for a tracking issue titled exactly
`Release: vX.Y.Z` (e.g. `Release: v0.6.0`) and the matching `release:*` label
set:

| Cut | Label that must be empty (no open issues) |
|---|---|
| `bump=minor` (any channel) | `release:next-minor` |
| `channel=beta` promotion | `release:beta` |
| `channel=rc` promotion | `release:rc` |
| `channel=stable` promotion (or any stable cut) | `release:stable` |

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

If the cut is curated (per the table above), do all of these before
dispatching:

a. **List open issues holding the gating label.** Use the GitHub MCP tools:

   ```
   mcp__github__search_issues query="repo:SailfinIO/sailfin is:open label:release:<gate>"
   ```

   where `<gate>` is `next-minor` | `beta` | `rc` | `stable`. For a stable
   promotion, also check `release:rc`. For 1.0, also check `release:1.0`.

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
     - #NNN <title> (size:_, priority:_)
     - ...
   ```

d. **Require explicit override if anything is open.** Ask the user:
   "N items are still open under `release:<gate>`. Cut anyway, or wait?"
   Do not dispatch unless the user explicitly says cut anyway. If they
   wait, stop and surface the open list — don't try to fix anything.

For uncurated cuts (`channel=alpha bump=prerelease`), skip the gate entirely
and proceed to dispatch.

### 5. Dispatch the workflow

```bash
gh workflow run release.yml \
  -f channel=<channel> \
  -f bump=<bump>
```

Or for a dry run first:
```bash
gh workflow run release.yml \
  -f channel=<channel> \
  -f bump=<bump> \
  -f dry_run=true
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
