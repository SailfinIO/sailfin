import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";
import { fileURLToPath } from "node:url";

import {
  findCanonicalExampleFailures,
  findRequiredFragmentFailures,
  findRetiredClaimFailures,
} from "./check-public-claims.mjs";

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

test("pattern-matching vocabulary is not mistaken for a superlative", () => {
  const failures = findRetiredClaimFailures([
    {
      path: "standard-library.md",
      content: "Raises a `ValueError` with a message including the unmatched value.",
    },
  ]);
  assert.deepEqual(failures, []);
});

test("accurate comparison copy is not flagged", () => {
  // The guard must not punish honestly describing what Rust does better than Sailfin.
  const failures = findRetiredClaimFailures([
    {
      path: "why.astro",
      content:
        "Rust's borrow checker gives compile-time memory safety without a garbage collector. " +
        "Sailfin does not match that, and is not attempting to at 1.0.",
    },
  ]);
  assert.deepEqual(failures, []);
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
