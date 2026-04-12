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

## What to do

1. Read the current version from `compiler/capsule.toml`.

2. Ask the user what kind of release they want if not already clear from
   context.  Common scenarios:
   - "cut an alpha" → channel=alpha, bump=prerelease
   - "new patch alpha" → channel=alpha, bump=patch
   - "promote to beta" → channel=beta, bump=prerelease
   - "promote to rc" → channel=rc, bump=prerelease
   - "ship it" / "GA release" → channel=stable, bump=prerelease
   - "minor release" → channel=alpha, bump=minor (or ask which channel)

3. Show the user what the version transition will be:
   ```
   Current: X.Y.Z-channel.N
   Next:    X.Y.Z-channel.M
   ```

4. Once confirmed, dispatch the workflow:
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

5. After dispatching, let the user know:
   - The workflow has been triggered
   - They can monitor it at: https://github.com/SailfinIO/sailfin/actions/workflows/release.yml
   - The release-notes agentic workflow will post a structured changelog
     comment on the release once it's published (supplementing the
     auto-generated notes)

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
