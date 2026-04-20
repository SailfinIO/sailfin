// Wrapper around `build/native/sailfin` invocations.
//
// Every call from the MCP server funnels through `runSailfin` so the
// memory cap, timeout, and workspace-path check live in exactly one place.

import { spawn } from "node:child_process";
import { existsSync } from "node:fs";
import { realpathSync } from "node:fs";
import path from "node:path";

const MEMORY_CAP_KB = 8 * 1024 * 1024; // 8 GB virtual memory
const DEFAULT_TIMEOUT_MS = 60_000;

export interface SailfinResult {
  exit: number;
  stdout: string;
  stderr: string;
  durationMs: number;
  timedOut: boolean;
}

export interface SailfinRunOptions {
  timeoutMs?: number;
  cwd?: string;
}

export class SailfinError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "SailfinError";
  }
}

export function workspaceRoot(): string {
  // MCP server is always started with the project as cwd (see .mcp.json).
  // If env override is set, prefer that — matches Claude Code's
  // $CLAUDE_PROJECT_DIR convention.
  return process.env.CLAUDE_PROJECT_DIR ?? process.cwd();
}

export function compilerPath(): string {
  return path.join(workspaceRoot(), "build", "native", "sailfin");
}

export function assertCompilerExists(): void {
  const bin = compilerPath();
  if (!existsSync(bin)) {
    throw new SailfinError(
      `build/native/sailfin not found at ${bin}. Run \`make compile\` first.`,
    );
  }
}

/**
 * Resolve a user-supplied path inside the workspace. Refuses paths that
 * resolve outside the project root — prevents a misconfigured MCP client
 * from asking the server to compile /etc/passwd.
 */
export function resolveInsideWorkspace(userPath: string): string {
  const root = realpathSync(workspaceRoot());
  const candidate = path.resolve(root, userPath);
  let resolved: string;
  try {
    resolved = realpathSync(candidate);
  } catch {
    // File may not exist yet (e.g., new test fixture); fall back to the
    // logical candidate. The compiler will emit its own "no such file"
    // diagnostic.
    resolved = candidate;
  }
  if (!resolved.startsWith(root + path.sep) && resolved !== root) {
    throw new SailfinError(
      `Refusing path outside workspace: ${userPath} -> ${resolved}`,
    );
  }
  return resolved;
}

/**
 * Invoke the Sailfin compiler with a memory cap and timeout. Never throws
 * on non-zero exit — the caller inspects the exit code.
 */
export async function runSailfin(
  args: string[],
  opts: SailfinRunOptions = {},
): Promise<SailfinResult> {
  assertCompilerExists();

  const timeout = opts.timeoutMs ?? DEFAULT_TIMEOUT_MS;
  const cwd = opts.cwd ?? workspaceRoot();
  const bin = compilerPath();

  // We use `/usr/bin/env bash -lc` so we can set `ulimit -v` before exec.
  // Node's child_process doesn't support rlimits directly.
  const cmd = [
    `ulimit -v ${MEMORY_CAP_KB}`,
    `exec ${shellEscape(bin)} ${args.map(shellEscape).join(" ")}`,
  ].join(" && ");

  const started = Date.now();
  return new Promise<SailfinResult>((resolve) => {
    const child = spawn("/usr/bin/env", ["bash", "-lc", cmd], {
      cwd,
      stdio: ["ignore", "pipe", "pipe"],
    });

    let stdout = "";
    let stderr = "";
    child.stdout.setEncoding("utf8");
    child.stderr.setEncoding("utf8");
    child.stdout.on("data", (chunk) => {
      stdout += chunk;
    });
    child.stderr.on("data", (chunk) => {
      stderr += chunk;
    });

    let timedOut = false;
    const timer = setTimeout(() => {
      timedOut = true;
      child.kill("SIGKILL");
    }, timeout);

    child.on("close", (code, signal) => {
      clearTimeout(timer);
      const durationMs = Date.now() - started;
      resolve({
        exit: code ?? (signal === "SIGKILL" ? 137 : 1),
        stdout,
        stderr,
        durationMs,
        timedOut,
      });
    });

    child.on("error", (err) => {
      clearTimeout(timer);
      resolve({
        exit: 1,
        stdout,
        stderr: stderr + `\n[sailfin-mcp] spawn error: ${String(err)}`,
        durationMs: Date.now() - started,
        timedOut: false,
      });
    });
  });
}

function shellEscape(s: string): string {
  // Single-quote wrap and escape any embedded single quotes.
  return `'${s.replace(/'/g, `'\\''`)}'`;
}
