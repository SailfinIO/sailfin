import { existsSync, readdirSync, readFileSync } from "node:fs";
import { extname, join, relative } from "node:path";
import { fileURLToPath } from "node:url";

const dist = fileURLToPath(new URL("../dist/", import.meta.url));
const htmlFiles = [];

function visit(dir) {
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    const path = join(dir, entry.name);
    if (entry.isDirectory()) visit(path);
    else if (extname(entry.name) === ".html") htmlFiles.push(path);
  }
}

function targetExists(pathname) {
  const clean = decodeURIComponent(pathname).replace(/^\/+|\/+$/g, "");
  if (clean === "") return existsSync(join(dist, "index.html"));

  return (
    existsSync(join(dist, clean)) ||
    existsSync(join(dist, `${clean}.html`)) ||
    existsSync(join(dist, clean, "index.html"))
  );
}

visit(dist);
const failures = [];

for (const file of htmlFiles) {
  const html = readFileSync(file, "utf8");
  for (const match of html.matchAll(/\bhref=(["'])(\/[^"'?#]*)(?:[?#][^"']*)?\1/g)) {
    if (!targetExists(match[2])) {
      failures.push(`${relative(dist, file)} -> ${match[2]}`);
    }
  }
}

if (failures.length > 0) {
  console.error("Broken generated internal links:");
  for (const failure of [...new Set(failures)].sort()) console.error(`- ${failure}`);
  process.exit(1);
}

console.log(`Checked internal links in ${htmlFiles.length} generated HTML files.`);
