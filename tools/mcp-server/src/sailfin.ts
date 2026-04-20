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
const MAX_OUTPUT_BYTES = 8 * 1024 * 1024; // 8 MiB per stream

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
  const suffix = process.platform === "win32" ? ".exe" : "";
  return path.join(workspaceRoot(), "build", "native", `sailfin${suffix}`);
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
  const rawRoot = workspaceRoot();
  let root: string;
  try {
    root = realpathSync(rawRoot);
  } catch (err) {
    throw new SailfinError(
      `Workspace root does not exist or is unreadable: ${rawRoot} (${(err as NodeJS.ErrnoException).code ?? "ERR"}). Set CLAUDE_PROJECT_DIR to a valid Sailfin checkout.`,
    );
  }
  const candidate = path.resolve(root, userPath);
  let resolved: string;
  try {
    resolved = realpathSync(candidate);
  } catch {
    // File may not exist yet (e.g., new test fixture); fall back to the
    // logical candidate. The compiler will emit its own "no such file"
    // diagnostic.
    //
    // Known TOCTOU limitation: symlinks are not resolved on this branch,
    // so a symlink created between this check and the compiler
    // invocation could in principle point outside the workspace.
    // Acceptable for a local stdio MCP server whose client already has
    // full filesystem access; revisit if the server is ever exposed
    // over a remote transport.
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

  // We use `/usr/bin/env bash -lc` so we can set `ulimit -v` before
  // exec. Node's child_process does not support rlimits directly.
  //
  // `-l` sources the user's login profile (~/.bash_profile etc.). This
  // is deliberate — we need the user's PATH so `build/native/sailfin`
  // can locate `clang` and the rest of the toolchain. It does mean a
  // poisoned shell profile can influence the execution environment;
  // acceptable for a local dev tool, revisit if this server ever runs
  // with untrusted callers.
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

    // Bound each stream so a runaway `emit llvm` on a huge module can't
    // exhaust the MCP server's own heap. The compiler process itself is
    // already memory-capped, but its output size is not.
    const stdoutBuf = new BoundedBuffer(MAX_OUTPUT_BYTES, "stdout");
    const stderrBuf = new BoundedBuffer(MAX_OUTPUT_BYTES, "stderr");
    child.stdout.setEncoding("utf8");
    child.stderr.setEncoding("utf8");
    child.stdout.on("data", (chunk: string) => stdoutBuf.append(chunk));
    child.stderr.on("data", (chunk: string) => stderrBuf.append(chunk));

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
        stdout: stdoutBuf.toString(),
        stderr: stderrBuf.toString(),
        durationMs,
        timedOut,
      });
    });

    child.on("error", (err) => {
      clearTimeout(timer);
      stderrBuf.append(`\n[sailfin-mcp] spawn error: ${String(err)}`);
      resolve({
        exit: 1,
        stdout: stdoutBuf.toString(),
        stderr: stderrBuf.toString(),
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

/**
 * Append-only string buffer with a hard byte cap. Once the cap is reached,
 * further writes are discarded and a single truncation marker is appended
 * so the caller can see that output was cut.
 */
class BoundedBuffer {
  private chunks: string[] = [];
  private size = 0;
  private truncated = false;

  constructor(
    private readonly maxBytes: number,
    private readonly label: string,
  ) {}

  append(chunk: string): void {
    if (this.truncated) return;
    const chunkBytes = Buffer.byteLength(chunk, "utf8");
    if (this.size + chunkBytes <= this.maxBytes) {
      this.chunks.push(chunk);
      this.size += chunkBytes;
      return;
    }
    // Keep the prefix that still fits, then mark truncated.
    const remaining = this.maxBytes - this.size;
    if (remaining > 0) {
      this.chunks.push(chunk.slice(0, remaining));
      this.size = this.maxBytes;
    }
    this.truncated = true;
    this.chunks.push(
      `\n[sailfin-mcp] ${this.label} truncated at ${this.maxBytes} bytes\n`,
    );
  }

  toString(): string {
    return this.chunks.join("");
  }
}
