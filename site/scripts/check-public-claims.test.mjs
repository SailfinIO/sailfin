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
