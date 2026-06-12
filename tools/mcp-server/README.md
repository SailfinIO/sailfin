# `@sailfin/mcp-server`

Model Context Protocol server that exposes the self-hosted Sailfin compiler as tool calls, so agentic clients (Claude Code, Claude Desktop, Inspector) can compile, check, and iterate on `.sfn` files without shelling out through `make`.

Part of the "AI agents are users" strategy described in [`CLAUDE.md`](../../CLAUDE.md) — checks off item #4 (MCP server) in the LLM & Agent Adoption Strategy track.

## Tools

| Tool | Compiler invocation | Purpose |
|---|---|---|
| `sailfin_version` | `sailfin version` | Smoke test — returns the compiler version. Fails loudly if `build/native/sailfin` is missing. |
| `sailfin_check` | `sailfin check <path>` | Type + effect check a single `.sfn` file. Fast feedback during edits. |
| `sailfin_diagnostics` | `sailfin check --json <path>` | Same analysis as `sailfin_check`, returned as the `sailfin-check/1` JSON envelope for programmatic consumption. |
| `sailfin_emit_native` | `sailfin emit native <path>` | Emit `.sfn-asm` intermediate representation. Use for emit-stage diagnosis. |
| `sailfin_emit_llvm` | `sailfin emit llvm <path>` | Emit LLVM IR. Use for lowering-stage or linker diagnosis. |
| `sailfin_fmt_check` | `sailfin fmt --check <path>` | Report formatting differences without rewriting. |
| `sailfin_fmt_write` | `sailfin fmt --write <path>` | Reformat a file or directory in place (canonical). Run before committing to satisfy the CI `fmt --check` gate. |
| `sailfin_build` | `sailfin build <file>` / `-p <capsule>` | Build a single `.sfn` file or a capsule to a native binary. **Not** the compiler self-host (see below). |
| `sailfin_test` | `sailfin test <path> [-k <name>] [--jobs N] [--json]` | Run a targeted suite directory or a single `_test.sfn` file. `path` required. |

**Design rule:** every tool is a *pure passthrough* to one `sailfin` subcommand — no build/test orchestration lives in the server. In particular, `sailfin_build` does **not** self-host the compiler: that build needs seed resolution and extern pre-staging (`make rebuild`), and the tool deliberately does not replicate it. Use `make compile` for the self-host build until that orchestration folds into the driver.

`sailfin_test` requires a `path` on purpose — agents target one file or one suite (e.g. `compiler/tests/unit`) rather than the full serial suite, which can take ~45 min and is intentionally not exposed as a single call. The broad `compiler/tests/integration` and `compiler/tests/e2e` directories can still take several minutes.

Timeouts: `sailfin_build` and `sailfin_test` run under a 10-minute budget, `sailfin_fmt_write` under 2 minutes, and the analysis/emit tools under 60 seconds. The compiler self-applies its 8 GiB memory budget on Linux (see the [`compiler-safety` rule](../../.claude/rules/compiler-safety.md)); paths that resolve outside the workspace root are refused.

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

- `sailfin_effect_trace` — return the transitive effect set for a function, so agents can auto-complete `![...]` annotations.
- `sailfin_run` — capability-gated program execution. Requires the capability-manifest plumbing to ship first; executing a `.sfn` must honor its declared effect manifest, so this is a security surface, not a convenience wrapper.
- A native `sfn mcp` subcommand — bundle this server into the compiler binary so `sfn mcp` Just Works after install, replacing the standalone Node wrapper.

Shipped since the first cut: `sailfin_diagnostics` (`--json` envelope), `sailfin_fmt_write`, `sailfin_build`, and `sailfin_test` (targeted suites + `-k` single-test filter).
