import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { dirname, relative, resolve } from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";

import {
  findCanonicalExampleFailures,
  findRequiredFragmentFailures,
  findRetiredClaimFailures,
  sourceFiles,
} from "./check-public-claims.mjs";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "../..");

const stale = JSON.parse(
  readFileSync(
    fileURLToPath(new URL("./fixtures/public-claims-stale.json", import.meta.url)),
    "utf8",
  ),
);

test("deliberately stale canonical code is rejected", () => {
  const failures = findCanonicalExampleFailures(
    `\`\`\`sfn\n${stale.canonicalExample}\`\`\`\n`,
    [
      {
        source: "stale.md",
        fenceIndex: 0,
        fixture: "canonical.sfn",
        content: 'fn main() ![io] {\n    print("Hello, World!");\n}\n',
      },
    ],
  );
  assert.equal(failures.length, 1);
  assert.equal(failures[0].category, "canonical example");
});

test("deliberately retired wording is rejected", () => {
  const failures = findRetiredClaimFailures([
    { path: "stale.md", content: stale.retiredWording },
  ]);
  assert.ok(failures.some(({ category }) => category === "retired wording"));
});

for (const [id, content] of Object.entries(stale.marketingOverclaims)) {
  test(`marketing overclaim ${id} is rejected`, () => {
    const failures = findRetiredClaimFailures([{ path: "stale.md", content }]);
    assert.ok(
      failures.some((failure) => failure.message.includes(id)),
      `expected ${id} to fire on ${JSON.stringify(content)}, got ${JSON.stringify(failures)}`,
    );
  });
}

// The guard exists to push copy toward candour, so it must never fire on candid
// copy. Each of these is a sentence we actively want someone to be able to write.
for (const content of stale.honestCopyMustPass) {
  test(`honest copy is not flagged: ${content.slice(0, 45)}...`, () => {
    const failures = findRetiredClaimFailures([{ path: "why.astro", content }]);
    assert.deepEqual(
      failures,
      [],
      `guard fired on honest copy: ${JSON.stringify(content)}`,
    );
  });
}

// Rewordings of a claim the guard already rejects in another phrasing. Each of
// these walked past the first version of its pattern.
for (const [id, content] of Object.entries(stale.evasions)) {
  test(`reworded evasion of ${id} is still rejected`, () => {
    const failures = findRetiredClaimFailures([{ path: "stale.md", content }]);
    assert.ok(
      failures.some((failure) => failure.message.includes(id)),
      `evasion slipped past ${id}: ${JSON.stringify(content)}`,
    );
  });
}

test("ships-today claims do not fire on dated design records", () => {
  // A migration SFEP has to be able to name the C runtime it deleted, and a
  // CI-speed SFEP has to be able to cite "2x slower on macOS".
  const content =
    "The former runtime/native/src/sailfin_runtime.c is deleted. " +
    "The suite is the pain; macOS is ~2x slower per-test than Linux.";
  assert.deepEqual(
    findRetiredClaimFailures([{ path: "docs/proposals/0025.md", content, historical: true }]),
    [],
  );
  // The same text in product copy must still fail.
  assert.ok(
    findRetiredClaimFailures([{ path: "README.md", content }]).length >= 2,
    "current-facing copy should still be held to the ships-today rules",
  );
});

test("the wording rule applies to design records too", () => {
  // This is the whole reason SFEPs are scanned: the deferral phrasing leaked from
  // pre-SFEP-process architect docs into the site copy.
  const failures = findRetiredClaimFailures([
    {
      path: "docs/proposals/0018.md",
      content: "Full exclusivity checking is deferred to post-1.0.",
      historical: true,
    },
  ]);
  assert.ok(failures.some((f) => f.message.includes("deferral-without-gate")));
});

test("llms.txt is inside the scanned set", () => {
  // Without this, a clean guard run is equally consistent with llms.txt being
  // scanned and with it being silently skipped -- the state it was in before.
  const files = sourceFiles(repoRoot).map(({ path }) => relative(repoRoot, path));
  assert.ok(
    files.includes("llms.txt"),
    `llms.txt missing from scanned set (${files.length} files scanned)`,
  );
});

test("CI scope covers every public-claim source", () => {
  const workflow = readFileSync(resolve(repoRoot, ".github/workflows/ci.yml"), "utf8");
  const arm = workflow.match(
    /case "\$path" in\s+([^\n]+)\)\s+public_claims=true/,
  );
  assert.ok(arm, "public_claims case arm not found in ci.yml");

  const patterns = arm[1].trim().split("|");
  const covered = (path) =>
    patterns.some((pattern) => {
      const escaped = pattern.replace(/[.+?^${}()|[\]\\]/g, "\\$&");
      return new RegExp(`^${escaped.replaceAll("*", ".*")}$`).test(path);
    });
  const uncovered = sourceFiles(repoRoot)
    .map(({ path }) => relative(repoRoot, path))
    .filter((path) => !covered(path));

  assert.deepEqual(
    uncovered,
    [],
    `public-claim sources missing from CI scope: ${uncovered.join(", ")}`,
  );
});

test("deliberately broken critical link is rejected", () => {
  const failures = findRequiredFragmentFailures(
    [{ path: "stale.md", content: `href="${stale.criticalLink}"` }],
    [{ source: "stale.md", href: "/docs/getting-started/install" }],
    "critical link",
  );
  assert.equal(failures.length, 1);
});

test("deliberately stale release asset template is rejected", () => {
  const failures = findRequiredFragmentFailures(
    [{ path: "stale.md", content: stale.releaseAssetTemplate }],
    [{ source: "stale.md", fragment: "sailfin_${VERSION}_linux_x86_64.tar.gz" }],
    "release asset template",
  );
  assert.equal(failures.length, 1);
});
