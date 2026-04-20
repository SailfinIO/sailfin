---
description: |
  Shared pre-agent step that builds the Sailfin MCP server
  (`tools/mcp-server/dist/index.js`) before the Claude engine boots.

  The repo-root `.mcp.json` registers the `sailfin` MCP for interactive
  Claude Code sessions. The gh-aw Claude engine also reads that file and
  tries to launch the server at boot, so if `dist/index.js` does not exist
  (fresh runner; not in git) the launch fails and the agent job exits
  non-zero even if the agent itself does useful work.

  This component is imported by every agentic workflow. ~30s per run to
  npm install + tsc. Can be optimized later with a cache layer keyed on
  `tools/mcp-server/package-lock.json` if this becomes a hot path.

steps:
  - uses: actions/checkout@v4
    with:
      # strict mode: prevent the GitHub token from being persisted in
      # .git/config where the agent could read it.
      persist-credentials: false
  - uses: actions/setup-node@v4
    with:
      node-version: "20"
  - name: Build Sailfin MCP server
    run: make mcp-server
---

Shared component only. No `on:` trigger — this file is never compiled
to a lock file on its own. It is merged into a host workflow via
`imports: [shared/build-mcp-server.md]` in the host's frontmatter.
