// Smoke tests for the Sailfin MCP server.
//
// Drives the server over stdio JSON-RPC using a stub compiler binary so
// we exercise the `formatResult()` success path (not just error paths),
// and verify that `structuredContent` survives SDK serialization.
//
// Run with: npm test

import { spawn, type ChildProcess } from "node:child_process";
import { mkdirSync, mkdtempSync, writeFileSync, chmodSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { tmpdir } from "node:os";
import { test } from "node:test";
import assert from "node:assert/strict";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
// Layout: tsc emits src/*.ts -> dist-test/src/*.js and this file to
// dist-test/test/smoke.test.js, so the server is one dir up and over.
const SERVER = path.resolve(__dirname, "../src/index.js");

interface Rpc {
  jsonrpc: "2.0";
  id?: number;
  method?: string;
  params?: unknown;
  result?: unknown;
  error?: unknown;
}

/**
 * Create a temporary workspace containing a stub compiler at
 * build/native/sailfin. The stub echoes a predictable payload on stdout
 * so tests can assert on the MCP response shape.
 */
function makeStubWorkspace(opts: {
  exitCode?: number;
  stdoutBody?: string;
  stderrBody?: string;
} = {}): string {
  const exit = opts.exitCode ?? 0;
  const stdoutBody = opts.stdoutBody ?? "sailfin 0.0.0-stub";
  const stderrBody = opts.stderrBody ?? "";

  const root = mkdtempSync(path.join(tmpdir(), "sailfin-mcp-test-"));
  mkdirSync(path.join(root, "build", "native"), { recursive: true });

  const stub = `#!/usr/bin/env bash
# Stub compiler for MCP smoke tests.
printf '%s' ${JSON.stringify(stdoutBody)}
>&2 printf '%s' ${JSON.stringify(stderrBody)}
exit ${exit}
`;
  const stubPath = path.join(root, "build", "native", "sailfin");
  writeFileSync(stubPath, stub);
  chmodSync(stubPath, 0o755);
  return root;
}

class McpClient {
  private buf = "";
  private pending = new Map<number, (r: Rpc) => void>();
  private nextId = 1;

  constructor(private child: ChildProcess) {
    child.stdout!.setEncoding("utf8");
    child.stdout!.on("data", (chunk: string) => this.onStdout(chunk));
  }

  private onStdout(chunk: string): void {
    this.buf += chunk;
    for (;;) {
      const nl = this.buf.indexOf("\n");
      if (nl < 0) return;
      const line = this.buf.slice(0, nl).trim();
      this.buf = this.buf.slice(nl + 1);
      if (!line) continue;
      let msg: Rpc;
      try {
        msg = JSON.parse(line);
      } catch {
        continue;
      }
      if (typeof msg.id === "number" && this.pending.has(msg.id)) {
        const resolver = this.pending.get(msg.id)!;
        this.pending.delete(msg.id);
        resolver(msg);
      }
    }
  }

  async request(method: string, params?: unknown): Promise<Rpc> {
    const id = this.nextId++;
    const msg: Rpc = { jsonrpc: "2.0", id, method, params };
    const promise = new Promise<Rpc>((resolve) => {
      this.pending.set(id, resolve);
    });
    this.child.stdin!.write(JSON.stringify(msg) + "\n");
    return promise;
  }

  notify(method: string, params?: unknown): void {
    this.child.stdin!.write(
      JSON.stringify({ jsonrpc: "2.0", method, params }) + "\n",
    );
  }

  close(): void {
    this.child.stdin!.end();
  }
}

async function withServer<T>(
  workspace: string,
  fn: (client: McpClient) => Promise<T>,
): Promise<T> {
  const child = spawn("node", [SERVER], {
    env: { ...process.env, CLAUDE_PROJECT_DIR: workspace },
    stdio: ["pipe", "pipe", "pipe"],
  });
  const client = new McpClient(child);

  const init = await client.request("initialize", {
    protocolVersion: "2024-11-05",
    capabilities: {},
    clientInfo: { name: "smoke", version: "0" },
  });
  assert.equal(init.error, undefined, "initialize must not error");
  client.notify("notifications/initialized");

  try {
    return await fn(client);
  } finally {
    client.close();
    await new Promise<void>((resolve) => child.once("exit", () => resolve()));
  }
}

test("tools/list exposes all five tools with correct names", async () => {
  const workspace = makeStubWorkspace();
  await withServer(workspace, async (client) => {
    const resp = await client.request("tools/list");
    const result = resp.result as { tools: Array<{ name: string }> };
    const names = result.tools.map((t) => t.name).sort();
    assert.deepEqual(names, [
      "sailfin_check",
      "sailfin_emit_llvm",
      "sailfin_emit_native",
      "sailfin_fmt_check",
      "sailfin_version",
    ]);
  });
});

test("sailfin_version returns structured content on success", async () => {
  const workspace = makeStubWorkspace({ stdoutBody: "sailfin 0.5.7-stub" });
  await withServer(workspace, async (client) => {
    const resp = await client.request("tools/call", {
      name: "sailfin_version",
      arguments: {},
    });
    const result = resp.result as {
      content: Array<{ type: string; text: string }>;
      isError?: boolean;
      structuredContent?: {
        exit: number;
        stdout: string;
        duration_ms: number;
      };
    };
    assert.notEqual(
      result.isError,
      true,
      "version should not be flagged as an error",
    );
    assert.ok(
      result.content[0].text.includes("sailfin 0.5.7-stub"),
      "text body carries compiler stdout",
    );
    // The review asked us to verify structuredContent round-trips.
    assert.ok(
      result.structuredContent,
      "structuredContent must be present on success",
    );
    assert.equal(result.structuredContent!.exit, 0);
    assert.equal(result.structuredContent!.stdout, "sailfin 0.5.7-stub");
    assert.equal(typeof result.structuredContent!.duration_ms, "number");
  });
});

test("sailfin_check surfaces non-zero exit as isError with stderr", async () => {
  const workspace = makeStubWorkspace({
    exitCode: 1,
    stdoutBody: "",
    stderrBody: "type error at foo.sfn:3",
  });
  await writeStubSfn(workspace, "foo.sfn");
  await withServer(workspace, async (client) => {
    const resp = await client.request("tools/call", {
      name: "sailfin_check",
      arguments: { path: "foo.sfn" },
    });
    const result = resp.result as {
      content: Array<{ type: string; text: string }>;
      isError?: boolean;
      structuredContent?: { exit: number; stderr: string };
    };
    assert.equal(result.isError, true, "non-zero exit surfaces as isError");
    assert.ok(
      result.content[0].text.includes("type error at foo.sfn:3"),
      "stderr payload visible in text body",
    );
    assert.equal(result.structuredContent!.exit, 1);
    assert.equal(
      result.structuredContent!.stderr,
      "type error at foo.sfn:3",
    );
  });
});

test("workspace-boundary guard rejects /etc/passwd before invoking the compiler", async () => {
  const workspace = makeStubWorkspace();
  await withServer(workspace, async (client) => {
    const resp = await client.request("tools/call", {
      name: "sailfin_check",
      arguments: { path: "/etc/passwd" },
    });
    const result = resp.result as {
      content: Array<{ type: string; text: string }>;
      isError?: boolean;
    };
    assert.equal(result.isError, true);
    assert.ok(
      result.content[0].text.includes("Refusing path outside workspace"),
    );
  });
});

test("missing compiler binary returns a clean actionable error", async () => {
  // Fresh temp dir with no build/native/sailfin stub.
  const empty = mkdtempSync(path.join(tmpdir(), "sailfin-mcp-empty-"));
  await withServer(empty, async (client) => {
    const resp = await client.request("tools/call", {
      name: "sailfin_version",
      arguments: {},
    });
    const result = resp.result as {
      content: Array<{ type: string; text: string }>;
      isError?: boolean;
    };
    assert.equal(result.isError, true);
    assert.ok(
      result.content[0].text.includes("Run `make compile` first"),
      `expected actionable hint, got: ${result.content[0].text}`,
    );
  });
});

test("bad CLAUDE_PROJECT_DIR surfaces as a clean tool error, not a crash", async () => {
  const missing = path.join(tmpdir(), "sailfin-mcp-does-not-exist-xyz");
  await withServer(missing, async (client) => {
    const resp = await client.request("tools/call", {
      name: "sailfin_check",
      arguments: { path: "foo.sfn" },
    });
    const result = resp.result as {
      content: Array<{ type: string; text: string }>;
      isError?: boolean;
    };
    assert.equal(result.isError, true);
    assert.ok(
      result.content[0].text.includes("Workspace root does not exist"),
      `expected workspace-missing error, got: ${result.content[0].text}`,
    );
  });
});

async function writeStubSfn(root: string, name: string): Promise<void> {
  writeFileSync(path.join(root, name), "fn main() {}\n", "utf8");
}
