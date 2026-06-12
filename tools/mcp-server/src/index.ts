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
//   - sailfin_fmt_write       — reformat in place (canonical)
//   - sailfin_build           — build a .sfn file / capsule to a binary
//   - sailfin_test            — run a targeted suite or single test
//
// Every tool goes through runSailfin(), which enforces the timeout
// and keeps invocations inside the workspace.
//
// Design rule: every tool is a *pure passthrough* to a single `sailfin`
// subcommand. No build/test orchestration lives here — e.g. compiler
// self-host (seed resolution + extern pre-staging) stays in `make
// compile`, and sailfin_build deliberately does not replicate it.

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

const buildFileSchema = z
  .string()
  .min(1)
  .optional()
  .describe(
    "Path to a single .sfn file to build, relative to the workspace root. Mutually exclusive with `project`.",
  );

const projectSchema = z
  .string()
  .min(1)
  .optional()
  .describe(
    "Path to a Sailfin capsule directory (containing capsule.toml), relative to the workspace root. Built via `-p`. Mutually exclusive with `path`.",
  );

const testPathSchema = z
  .string()
  .min(1)
  .describe(
    "Path to a test suite directory (e.g. compiler/tests/unit) or a single _test.sfn file, relative to the workspace root. Required — target one file or one suite, not the whole tree.",
  );

const nameFilterSchema = z
  .string()
  .min(1)
  .optional()
  .describe(
    "Only run tests whose name contains this substring (maps to `-k`). Use to run a single named test.",
  );

const jobsSchema = z
  .number()
  .int()
  .min(1)
  .max(256)
  .optional()
  .describe(
    "Max concurrent per-file test children (maps to `--jobs`). Each child is a full compiler invocation under its own 8 GiB cap, so size to available RAM. Defaults to serial (1).",
  );

const jsonSchema = z
  .boolean()
  .optional()
  .describe("Emit machine-readable output instead of human text (--json).");

const fmtWritePathSchema = z
  .string()
  .min(1)
  .describe(
    "Path to a .sfn file or directory to reformat in place, relative to the workspace root.",
  );

// Cold builds (especially macOS) and broad test suites take minutes, not
// seconds — give them headroom over runSailfin's 60s default. Both block
// the MCP channel for their duration, which is why sailfin_test requires a
// path (no accidental whole-tree run) and sailfin_build is per-target.
const BUILD_TIMEOUT_MS = 600_000; // 10 min
const TEST_TIMEOUT_MS = 600_000; // 10 min
const FMT_WRITE_TIMEOUT_MS = 120_000; // 2 min — dir-wide fmt touches many files

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

server.registerTool(
  "sailfin_fmt_write",
  {
    title: "Format-write a .sfn file or directory",
    description:
      "Run `sailfin fmt --write` against a .sfn file or directory, reformatting in place. Formatting is canonical and zero-config. Pair with sailfin_fmt_check: run this to fix the drift the check reports before committing (CI runs `fmt --check` and fails on unformatted files).",
    inputSchema: { path: fmtWritePathSchema },
  },
  async ({ path: userPath }) => {
    const out = await withResolvedPath(userPath, async (abs) => {
      const result = await runSailfin(["fmt", "--write", abs], {
        timeoutMs: FMT_WRITE_TIMEOUT_MS,
      });
      return formatResult("sailfin fmt --write", result);
    });
    return out as ToolResult;
  },
);

server.registerTool(
  "sailfin_build",
  {
    title: "Build a Sailfin file or capsule to a binary",
    description:
      "Compile a Sailfin source file or capsule to a native binary via `sailfin build`. Provide exactly one of `path` (a single .sfn file) or `project` (a capsule directory, built via -p). Optionally `json` for machine-readable output. Pure passthrough — this does NOT self-host the compiler itself: the self-host build needs seed resolution + extern pre-staging that lives in `make compile`, and this tool deliberately does not replicate it. Runs under a 10-minute timeout (cold builds take minutes).",
    inputSchema: { path: buildFileSchema, project: projectSchema, json: jsonSchema },
  },
  async ({ path: userPath, project, json }) => {
    const hasPath = typeof userPath === "string" && userPath.length > 0;
    const hasProject = typeof project === "string" && project.length > 0;
    if (hasPath === hasProject) {
      return errorResult(
        "sailfin_build: provide exactly one of `path` (a .sfn file) or `project` (a capsule directory).",
      );
    }
    const target = (hasPath ? userPath : project) as string;
    const out = await withResolvedPath(target, async (abs) => {
      const args = hasProject ? ["build", "-p", abs] : ["build", abs];
      if (json) {
        args.push("--json");
      }
      const result = await runSailfin(args, { timeoutMs: BUILD_TIMEOUT_MS });
      return formatResult("sailfin build", result);
    });
    return out as ToolResult;
  },
);

server.registerTool(
  "sailfin_test",
  {
    title: "Run a targeted Sailfin test suite or single test",
    description:
      "Run a Sailfin test suite directory (e.g. compiler/tests/unit) or a single _test.sfn file via `sailfin test <path>`. Optionally pass `name` to run only tests whose name contains it (-k), `jobs` for parallelism (--jobs), and `json` for the jsonl event stream (--json). `path` is required so an agent targets one file or one suite — the broad suites (compiler/tests/integration, compiler/tests/e2e) can take many minutes, and the full serial suite is intentionally not exposed as one call. Runs under a 10-minute timeout.",
    inputSchema: {
      path: testPathSchema,
      name: nameFilterSchema,
      jobs: jobsSchema,
      json: jsonSchema,
    },
  },
  async ({ path: userPath, name, jobs, json }) => {
    const out = await withResolvedPath(userPath, async (abs) => {
      const args = ["test", abs];
      if (typeof name === "string" && name.length > 0) {
        args.push("-k", name);
      }
      if (typeof jobs === "number") {
        args.push("--jobs", String(jobs));
      }
      if (json) {
        args.push("--json");
      }
      const result = await runSailfin(args, { timeoutMs: TEST_TIMEOUT_MS });
      return formatResult("sailfin test", result);
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
