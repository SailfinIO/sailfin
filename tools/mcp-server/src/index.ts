#!/usr/bin/env node
//
// Sailfin MCP server.
//
// Exposes the self-hosted Sailfin compiler as tool calls over stdio MCP:
//   - sailfin_version         — compiler version string
//   - sailfin_check           — type + effect check (human stderr)
//   - sailfin_diagnostics     — same analysis, machine-readable JSON
//   - sailfin_emit_native     — emit .sfn-asm IR
//   - sailfin_emit_llvm       — emit LLVM IR
//   - sailfin_fmt_check       — formatting diagnostics (no rewrite)
//
// Every tool goes through runSailfin(), which enforces ulimit + timeout
// and keeps invocations inside the workspace.

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

import {
  resolveInsideWorkspace,
  runSailfin,
  SailfinError,
  workspaceRoot,
} from "./sailfin.js";

const server = new McpServer({
  name: "sailfin",
  version: "0.1.0",
});

type ToolResult = {
  content: Array<{ type: "text"; text: string }>;
  isError?: boolean;
  structuredContent?: Record<string, unknown>;
};

function formatResult(
  label: string,
  result: {
    exit: number;
    stdout: string;
    stderr: string;
    durationMs: number;
    timedOut: boolean;
  },
): ToolResult {
  const ok = result.exit === 0;
  const header =
    `${label}: ${ok ? "ok" : "FAIL"} (exit=${result.exit}, ${result.durationMs}ms` +
    `${result.timedOut ? ", timed out" : ""})`;

  const body = [
    header,
    result.stdout.length > 0 ? `--- stdout ---\n${result.stdout}` : "",
    result.stderr.length > 0 ? `--- stderr ---\n${result.stderr}` : "",
  ]
    .filter(Boolean)
    .join("\n\n");

  return {
    isError: !ok,
    content: [{ type: "text", text: body }],
    structuredContent: {
      exit: result.exit,
      duration_ms: result.durationMs,
      timed_out: result.timedOut,
      stdout: result.stdout,
      stderr: result.stderr,
    },
  };
}

function errorResult(message: string): ToolResult {
  return {
    isError: true,
    content: [{ type: "text", text: message }],
  };
}

async function withResolvedPath<T>(
  userPath: string,
  fn: (absPath: string) => Promise<T>,
): Promise<T | ToolResult> {
  try {
    const abs = resolveInsideWorkspace(userPath);
    return await fn(abs);
  } catch (err) {
    if (err instanceof SailfinError) {
      return errorResult(err.message);
    }
    throw err;
  }
}

const pathSchema = z
  .string()
  .min(1)
  .describe("Path to a .sfn file, relative to the Sailfin workspace root.");

server.registerTool(
  "sailfin_version",
  {
    title: "Sailfin compiler version",
    description:
      "Return the version string of the locally built Sailfin compiler. Useful as a smoke test — if this fails, the compiler isn't built.",
    inputSchema: {},
  },
  async () => {
    try {
      const result = await runSailfin(["version"], { timeoutMs: 10_000 });
      return formatResult("sailfin version", result);
    } catch (err) {
      return errorResult(
        err instanceof SailfinError ? err.message : String(err),
      );
    }
  },
);

server.registerTool(
  "sailfin_check",
  {
    title: "Type + effect check a .sfn file",
    description:
      "Run the Sailfin compiler's type and effect checker on a single .sfn file. Returns diagnostics without emitting IR. Use this for fast feedback loops during edits.",
    inputSchema: { path: pathSchema },
  },
  async ({ path: userPath }) => {
    const out = await withResolvedPath(userPath, async (abs) => {
      const result = await runSailfin(["check", abs]);
      return formatResult("sailfin check", result);
    });
    return out as ToolResult;
  },
);

// Machine-readable counterpart to `sailfin_check`. Returns the
// `sailfin-check/1` envelope (documented at
// `docs/reference/check-json-schema.md`) parsed into
// `structuredContent` so MCP clients can act on diagnostics
// programmatically. Falls back to surfacing the raw stdout on parse
// failure — that path also signals isError so the client knows the
// envelope was unusable rather than empty.
server.registerTool(
  "sailfin_diagnostics",
  {
    title: "Type + effect check (JSON envelope)",
    description:
      "Run the Sailfin compiler's type and effect checker on a single .sfn file and return the sailfin-check/1 JSON envelope (events array + summary). Use this for programmatic consumption — events carry code, severity, producer, file_path, message, and primary source location. Schema is documented at docs/reference/check-json-schema.md.",
    inputSchema: { path: pathSchema },
  },
  async ({ path: userPath }) => {
    const out = await withResolvedPath(userPath, async (abs) => {
      const result = await runSailfin(["check", "--json", abs]);
      // sfn check exits 0 (clean) or 1 (diagnostics found); both are
      // expected outcomes that produce a valid envelope. Exit 2 is
      // a setup error — the envelope may not be present.
      if (result.exit !== 0 && result.exit !== 1) {
        return formatResult("sailfin diagnostics", result);
      }
      let envelope: Record<string, unknown> | null = null;
      let parseError: string | null = null;
      try {
        envelope = JSON.parse(result.stdout) as Record<string, unknown>;
      } catch (err) {
        parseError =
          err instanceof Error ? err.message : String(err);
      }
      const ok = envelope !== null;
      const header = ok
        ? `sailfin diagnostics: ok (exit=${result.exit}, ${result.durationMs}ms)`
        : `sailfin diagnostics: FAIL (envelope did not parse as JSON: ${parseError})`;
      const body = [
        header,
        ok ? "" : `--- raw stdout ---\n${result.stdout}`,
        result.stderr.length > 0 ? `--- stderr ---\n${result.stderr}` : "",
      ]
        .filter(Boolean)
        .join("\n\n");
      const structured: Record<string, unknown> = ok && envelope !== null
        ? envelope
        : {
            exit: result.exit,
            duration_ms: result.durationMs,
            parse_error: parseError ?? "",
            raw_stdout: result.stdout,
            raw_stderr: result.stderr,
          };
      return {
        isError: !ok,
        content: [{ type: "text", text: body }],
        structuredContent: structured,
      } satisfies ToolResult;
    });
    return out as ToolResult;
  },
);

server.registerTool(
  "sailfin_emit_native",
  {
    title: "Emit .sfn-asm for a .sfn file",
    description:
      "Run the Sailfin compiler's native emitter on a single .sfn file and return the .sfn-asm intermediate representation. Use when diagnosing emit-stage bugs or diffing against a known-good module.",
    inputSchema: { path: pathSchema },
  },
  async ({ path: userPath }) => {
    const out = await withResolvedPath(userPath, async (abs) => {
      const result = await runSailfin(["emit", "native", abs]);
      return formatResult("sailfin emit native", result);
    });
    return out as ToolResult;
  },
);

server.registerTool(
  "sailfin_emit_llvm",
  {
    title: "Emit LLVM IR for a .sfn file",
    description:
      "Run the Sailfin compiler's LLVM lowering on a single .sfn file and return the generated LLVM IR (.ll). Use when diagnosing lowering-stage bugs or linker failures.",
    inputSchema: { path: pathSchema },
  },
  async ({ path: userPath }) => {
    const out = await withResolvedPath(userPath, async (abs) => {
      const result = await runSailfin(["emit", "llvm", abs]);
      return formatResult("sailfin emit llvm", result);
    });
    return out as ToolResult;
  },
);

server.registerTool(
  "sailfin_fmt_check",
  {
    title: "Format-check a .sfn file",
    description:
      "Run `sailfin fmt --check` against a single .sfn file. Reports formatting differences without rewriting the file.",
    inputSchema: { path: pathSchema },
  },
  async ({ path: userPath }) => {
    const out = await withResolvedPath(userPath, async (abs) => {
      const result = await runSailfin(["fmt", "--check", abs]);
      return formatResult("sailfin fmt --check", result);
    });
    return out as ToolResult;
  },
);

async function main(): Promise<void> {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  // Emit a single startup breadcrumb on stderr so integrators can tell
  // the server came up. MCP stdio transport reserves stdout for the
  // protocol itself.
  process.stderr.write(
    `[sailfin-mcp] ready. workspace=${workspaceRoot()}\n`,
  );
}

main().catch((err) => {
  process.stderr.write(`[sailfin-mcp] fatal: ${String(err)}\n`);
  process.exit(1);
});
