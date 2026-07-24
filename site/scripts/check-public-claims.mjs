import { existsSync, readFileSync, readdirSync } from "node:fs";
import { dirname, extname, join, relative, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const scriptPath = fileURLToPath(import.meta.url);
const defaultRepoRoot = resolve(dirname(scriptPath), "../..");

const currentFacingRoots = [
  "README.md",
  "examples/README.md",
  "site/src/components",
  "site/src/content/blog",
  "site/src/content/docs",
  "site/src/pages",
];

const retiredClaims = [
  {
    id: "deleted-c-runtime-source",
    pattern: /runtime\/native\/src\/sailfin_(?:runtime|arena)\.c/giu,
    guidance: "The runtime is Sailfin-native; describe deleted C sources only in historical engineering records.",
  },
  {
    id: "live-c-runtime",
    pattern: /\b(?:uses|links|includes|requires) (?:a |the )?C runtime\b/giu,
    guidance: "Current-facing copy must not present the deleted C runtime as live.",
  },
  {
    id: "legacy-build-driver",
    pattern: /\b(?:run|use|invoke) (?:the )?(?:prior )?`?scripts\/build\.sh`?/giu,
    guidance: "The legacy build script was deleted; direct users to make compile or sfn build.",
  },
  {
    id: "obsolete-installer-trust",
    pattern: /\b(?:TLS-trust only|does not currently verify (?:the )?release signature|do not currently verify `?SHA256SUMS\.sig`?)\b/giu,
    guidance: "Installers verify the signed checksum manifest before extraction.",
  },
  {
    id: "effect-gate-underclaim",
    pattern: /\b(?:once (?:effect )?enforcement ships|wiring it into the compilation gate)\b/giu,
    guidance: "io/net/clock effect enforcement is already a compile-time build gate.",
  },
];

const criticalLinks = [
  {
    source: "site/src/components/Hero.astro",
    href: "/docs/getting-started/install",
    target: "site/src/content/docs/docs/getting-started/install.md",
  },
  {
    source: "site/src/components/SiteHeader.astro",
    href: "/docs/reference/spec/",
    target: "site/src/content/docs/docs/reference/spec/index.md",
  },
  {
    source: "site/src/components/Footer.astro",
    href: "/roadmap",
    target: "site/src/pages/roadmap.astro",
  },
  {
    source: "site/src/components/SiteHeader.astro",
    href: "https://pkg.sfn.dev",
  },
  {
    source: "site/src/content/docs/docs/getting-started/install.md",
    href: "https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh",
    target: "install.sh",
  },
  {
    source: "site/src/pages/dl.astro",
    href: "https://github.com/SailfinIO/sailfin/releases",
  },
];

const releaseAssetTemplates = [
  {
    source: "site/src/pages/dl.astro",
    fragment: "sailfin_${releaseVersion}_linux_x86_64.tar.gz",
  },
  {
    source: "site/src/pages/dl.astro",
    fragment: "sailfin_${releaseVersion}_macos_arm64.tar.gz",
  },
  {
    source: "site/src/pages/dl.astro",
    fragment: "sailfin_${releaseVersion}_windows_x86_64.tar.gz",
  },
  {
    source: "site/src/content/docs/docs/getting-started/install.md",
    fragment: "sailfin_${VERSION}_linux_x86_64.tar.gz",
  },
  {
    source: ".github/workflows/release-tag.yml",
    fragment: 'installer_name="sailfin_${version}_${os}_${arch}.tar.gz"',
  },
];

const publicUrls = [
  "https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh",
  "https://sailfin.dev/docs/getting-started/install/",
  "https://sailfin.dev/docs/reference/spec/",
  "https://sailfin.dev/roadmap",
  "https://pkg.sfn.dev",
];

function sourceFiles(repoRoot) {
  const files = [];

  function visit(path) {
    if (!existsSync(path)) return;
    const entries = readdirSync(path, { withFileTypes: true });
    for (const entry of entries) {
      const child = join(path, entry.name);
      if (entry.isDirectory()) visit(child);
      else if ([".astro", ".md", ".mdx"].includes(extname(entry.name))) files.push(child);
    }
  }

  for (const root of currentFacingRoots) {
    const path = join(repoRoot, root);
    if (!existsSync(path)) continue;
    if (extname(path)) files.push(path);
    else visit(path);
  }
  return files;
}

function lineNumber(content, index) {
  return content.slice(0, index).split("\n").length;
}

export function findRetiredClaimFailures(files) {
  const failures = [];
  for (const { path, content } of files) {
    for (const claim of retiredClaims) {
      claim.pattern.lastIndex = 0;
      for (const match of content.matchAll(claim.pattern)) {
        failures.push({
          category: "retired wording",
          message: `${path}:${lineNumber(content, match.index)} matches ${claim.id}: ${claim.guidance}`,
        });
      }
    }
  }
  return failures;
}

export function findRequiredFragmentFailures(files, requirements, category) {
  const failures = [];
  const byPath = new Map(files.map((file) => [file.path, file.content]));
  for (const requirement of requirements) {
    const content = byPath.get(requirement.source);
    if (content === undefined) {
      failures.push({ category, message: `${requirement.source} is missing` });
      continue;
    }
    const fragment = requirement.href ?? requirement.fragment;
    if (!content.includes(fragment)) {
      failures.push({
        category,
        message: `${requirement.source} must contain ${JSON.stringify(fragment)}`,
      });
    }
  }
  return failures;
}

function extractSfnFences(markdown) {
  return [...markdown.matchAll(/```sfn\n([\s\S]*?)\n```/g)].map((match) => `${match[1]}\n`);
}

export function findCanonicalExampleFailures(markdown, expectedExamples) {
  const actualExamples = extractSfnFences(markdown);
  const failures = [];
  for (const expected of expectedExamples) {
    if (actualExamples[expected.fenceIndex] !== expected.content) {
      failures.push({
        category: "canonical example",
        message: `${expected.source} fence ${expected.fenceIndex + 1} drifted from ${expected.fixture}`,
      });
    }
  }
  return failures;
}

export function runChecks(repoRoot = defaultRepoRoot) {
  const failures = [];
  const files = sourceFiles(repoRoot).map((path) => ({
    path: relative(repoRoot, path),
    content: readFileSync(path, "utf8"),
  }));

  failures.push(...findRetiredClaimFailures(files));
  failures.push(...findRequiredFragmentFailures(files, criticalLinks, "critical link"));

  for (const link of criticalLinks) {
    if (link.target && !existsSync(join(repoRoot, link.target))) {
      failures.push({
        category: "critical link",
        message: `${link.source} points to missing repository target ${link.target}`,
      });
    }
  }

  const assetFiles = [...new Set(releaseAssetTemplates.map(({ source }) => source))].map((path) => ({
    path,
    content: existsSync(join(repoRoot, path)) ? readFileSync(join(repoRoot, path), "utf8") : "",
  }));
  failures.push(
    ...findRequiredFragmentFailures(assetFiles, releaseAssetTemplates, "release asset template"),
  );

  const onboardingPath = join(
    repoRoot,
    "site/src/content/docs/docs/getting-started/hello-world.md",
  );
  const expectedExamples = [
    {
      source: "hello-world.md",
      fenceIndex: 0,
      fixture: "site/examples/getting-started/hello-world.sfn",
      content: readFileSync(
        join(repoRoot, "site/examples/getting-started/hello-world.sfn"),
        "utf8",
      ),
    },
    {
      source: "hello-world.md",
      fenceIndex: 1,
      fixture: "site/examples/getting-started/hello-world_missing_effect.sfn",
      content: readFileSync(
        join(repoRoot, "site/examples/getting-started/hello-world_missing_effect.sfn"),
        "utf8",
      ),
    },
  ];
  failures.push(
    ...findCanonicalExampleFailures(readFileSync(onboardingPath, "utf8"), expectedExamples),
  );

  return failures;
}

async function checkPublicUrls() {
  const failures = [];
  for (const url of publicUrls) {
    try {
      const response = await fetch(url, {
        method: "HEAD",
        redirect: "follow",
        signal: AbortSignal.timeout(10_000),
      });
      if (!response.ok) {
        failures.push({
          category: "public link",
          message: `${url} returned HTTP ${response.status}`,
        });
      }
    } catch (error) {
      failures.push({
        category: "public link",
        message: `${url} could not be reached: ${error.message}`,
      });
    }
  }
  return failures;
}

if (resolve(process.argv[1] ?? "") === scriptPath) {
  const failures = runChecks();
  if (process.env.PUBLIC_CLAIMS_SKIP_NETWORK !== "1") {
    failures.push(...(await checkPublicUrls()));
  }
  if (failures.length > 0) {
    console.error(`Public-claim guard found ${failures.length} failure(s):`);
    for (const failure of failures) {
      console.error(`- [${failure.category}] ${failure.message}`);
    }
    console.error(
      "Update docs/status.md first for behavior changes, then update the fixture and public claim together.",
    );
    process.exit(1);
  }
  console.log("Public wording, canonical examples, critical links, and release templates verified.");
}
