# GitHub surface: `mcp__github__*` vs `gh`

Sailfin sessions run in more than one environment, and **the GitHub surface is
not the same in each**. Neither tool is guaranteed. Detect, don't assume.

| Environment | `gh` CLI | `mcp__github__*` |
|---|---|---|
| Local (a `claude` session on a dev machine) | usually present | often **not** connected |
| Cloud / headless (scheduled runs, remote agents) | **absent** | present |

An instruction that names only one of these strands the other environment. This
file is the rule the slash commands and agent definitions inherit rather than
each restating it.

## The rule

1. **Prefer `mcp__github__*` when the server is connected.** It is the portable
   spelling and the one the command files use, so a command reads the same in
   both environments.
2. **Fall back to `gh` when the MCP tools are not present.** This is sanctioned,
   not a workaround. Where a command says `mcp__github__create_pull_request` and
   that tool does not exist in the session, `gh pr create` is the correct
   equivalent.
3. **If neither is available, stop and say so.** Do not improvise a third path —
   no raw `curl` against the REST API, no pushing a branch and asking the user to
   open the PR by hand as though that were the normal flow. Report which surfaces
   you checked and what you were trying to do.

## Detecting

The MCP tools are deferred, so their absence is not visible until you look.
`ToolSearch` for the specific tool you need — an empty result means the server
is not connected in this session:

```
ToolSearch  query="select:mcp__github__create_pull_request"
```

For the CLI:

```bash
command -v gh >/dev/null 2>&1 && echo "gh available"
```

Check **before** you need it, not after a failed call — the failure mode of
guessing wrong is a half-finished operation (a pushed branch with no PR, a
merged PR with no comment) rather than a clean error.

## Why the command files still name `mcp__github__*` only

`/pickup`, `/release`, `/release-plan`, and `/pin-seed` spell every GitHub call
as `mcp__github__*`. That is deliberate: one canonical spelling per operation
keeps the commands readable, and duplicating each call site with an `or gh …`
alternative would roughly double their GitHub sections for no gain in either
environment. Those spellings mean *"this operation"*, not *"this exact tool"* —
resolve them through the rule above.

`git` itself is always available for branches, commits, and pushes. Only the
GitHub-API-shaped operations (PRs, reviews, Actions, issue comments, releases)
need this indirection.
