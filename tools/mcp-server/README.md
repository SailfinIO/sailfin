# `@sailfin/mcp-server`

Model Context Protocol server that exposes the self-hosted Sailfin compiler as tool calls, so agentic clients (Claude Code, Claude Desktop, Inspector) can compile, check, and iterate on `.sfn` files without shelling out through `make`.

Part of the "AI agents are users" strategy described in [`CLAUDE.md`](../../CLAUDE.md) — checks off item #4 (MCP server) in the LLM & Agent Adoption Strategy track.

## Tools

| Tool | Compiler invocation | Purpose |
|---|---|---|
| `sailfin_version` | `sailfin version` | Smoke test — returns the compiler version. Fails loudly if `build/native/sailfin` is missing. |
| `sailfin_check` | `sailfin check <path>` | Type + effect check a single `.sfn` file. Fast feedback during edits. |
| `sailfin_emit_native` | `sailfin emit native <path>` | Emit `.sfn-asm` intermediate representation. Use for emit-stage diagnosis. |
| `sailfin_emit_llvm` | `sailfin emit llvm <path>` | Emit LLVM IR. Use for lowering-stage or linker diagnosis. |
| `sailfin_fmt_check` | `sailfin fmt --check <path>` | Report formatting differences without rewriting. |

Every tool runs under `ulimit -v 8388608` + a 60-second timeout (same safety envelope as the [`compiler-safety` rule](../../.claude/rules/compiler-safety.md)), and refuses paths that resolve outside the workspace root.

## Build

```bash
cd tools/mcp-server
npm install
npm run build
```

Artifacts land in `dist/`.

## Register with a client

### Claude Code (this repo)

`.mcp.json` at the repo root already registers this server. Claude Code will pick it up on next session start — no extra configuration needed. Verify with `/mcp` inside Claude Code.

### Claude Desktop / other clients

Point the client at `node /abs/path/to/tools/mcp-server/dist/index.js` with stdio transport. Set `CLAUDE_PROJECT_DIR` to the Sailfin workspace root if the server is not started with `cwd` inside it.

### Inspector smoke test

```bash
npx @modelcontextprotocol/inspector node tools/mcp-server/dist/index.js
```

## Contract

- Tools **never throw** on compiler non-zero exit — they return `isError: true` with structured `{exit, stdout, stderr, duration_ms, timed_out}` so the caller can iterate on diagnostics.
- If `build/native/sailfin` is missing, every tool returns a clean error telling the caller to run `make compile`.
- Paths outside the workspace (e.g. `/etc/passwd`, `../../elsewhere`) are rejected before invocation.

## Roadmap

Future tools to consider as the compiler grows:

- `sailfin_diagnostics` — once the compiler emits `--json` diagnostics, expose a structured form that agents can parse and act on without text scraping.
- `sailfin_effect_trace` — return the transitive effect set for a function, so agents can auto-complete `![...]` annotations.
- `sailfin_test` — invoke focused tests. Currently deferred to the `test-runner` subagent for safety.
- `sailfin_run` — capability-gated program execution. Requires the capability-manifest plumbing to ship first.
