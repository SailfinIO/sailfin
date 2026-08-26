import { createHash } from "node:crypto";
import {
  readFileSync,
  readdirSync,
  writeFileSync,
} from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const BUILD_FINGERPRINT_FILE = ".source-fingerprint";

function packageRoot(): string {
  return path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
}

function sourceFiles(sourceDir: string): string[] {
  const files: string[] = [];

  function visit(dir: string): void {
    for (const entry of readdirSync(dir, { withFileTypes: true })) {
      const absolute = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        visit(absolute);
      } else if (entry.isFile() && entry.name.endsWith(".ts")) {
        files.push(absolute);
      }
    }
  }

  visit(sourceDir);
  return files.sort();
}

export function sourceFingerprint(sourceDir: string): string {
  const hash = createHash("sha256");
  for (const file of sourceFiles(sourceDir)) {
    hash.update(path.relative(sourceDir, file));
    hash.update("\0");
    hash.update(readFileSync(file));
    hash.update("\0");
  }
  return hash.digest("hex");
}

export function writeBuildFingerprint(
  sourceDir = path.join(packageRoot(), "src"),
  manifestPath = path.join(packageRoot(), "dist", BUILD_FINGERPRINT_FILE),
): void {
  writeFileSync(manifestPath, `${sourceFingerprint(sourceDir)}\n`, "utf8");
}

export function assertDistributionFresh(
  sourceDir = path.join(packageRoot(), "src"),
  manifestPath = path.join(packageRoot(), "dist", BUILD_FINGERPRINT_FILE),
): void {
  let builtFingerprint: string;
  try {
    builtFingerprint = readFileSync(manifestPath, "utf8").trim();
  } catch {
    throw new Error(
      `built MCP server has no source fingerprint at ${manifestPath}; run \`npm ci --no-audit --no-fund && npm run build\` in tools/mcp-server`,
    );
  }

  const currentFingerprint = sourceFingerprint(sourceDir);
  if (builtFingerprint !== currentFingerprint) {
    throw new Error(
      "built MCP server is stale relative to tools/mcp-server/src; run `npm run build` in tools/mcp-server",
    );
  }
}
