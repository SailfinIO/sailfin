import { existsSync, readFileSync, readdirSync } from "node:fs";
import { dirname, extname, join, relative, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const scriptPath = fileURLToPath(import.meta.url);
const defaultRepoRoot = resolve(dirname(scriptPath), "../..");

const currentFacingRoots = [
  "README.md",
  "CLAUDE.md",
  "docs/strategy",
  "examples/README.md",
  // Agent-facing framing file, symlinked as site/public/llms.txt. It drifted out of
  // sync with README for exactly as long as it sat outside this guard.
  "llms.txt",
  "site/src/components",
  "site/src/content/blog",
  "site/src/content/docs",
  "site/src/pages",
];

// SFEPs render publicly at /sfep/<slug>, so their prose is public -- but they are a
// different genre from product copy: dated design records that legitimately discuss
// deleted subsystems, historical measurements, and prospective architecture in the
// present tense. Scanning them with the full rule set produces noise (a migration
// SFEP *must* name the C runtime it deleted; a CI-speed SFEP *must* cite "2x slower
// on macOS"), so only the genre-independent rules apply here: the wording rule and
// unfalsifiable superlatives. Claims that assert what ships *today* are scoped to
// `currentFacingRoots` via `scope: "current-facing"` below.
//
// Several SFEPs were migrated from pre-SFEP-process architect documents and carried
// that era's deferral phrasing in with them, which is how "post-1.0" leaked back
// into the site copy in the first place -- hence guarding them at all.
const historicalRoots = [
  "docs/proposals",
  // This dated evidence review records attributed third-party benchmark claims;
  // it is not current Sailfin product copy.
  "docs/strategy/market-evidence-2026-07.md",
];

const retiredClaims = [
  {
    id: "deleted-c-runtime-source",
    scope: "current-facing",
    pattern: /runtime\/native\/src\/sailfin_(?:runtime|arena)\.c/giu,
    guidance: "The runtime is Sailfin-native; describe deleted C sources only in historical engineering records.",
  },
  {
    id: "live-c-runtime",
    scope: "current-facing",
    pattern: /\b(?:uses|links|includes|requires) (?:a |the )?C runtime\b/giu,
    guidance: "Current-facing copy must not present the deleted C runtime as live.",
  },
  {
    id: "legacy-build-driver",
    scope: "current-facing",
    pattern: /\b(?:run|use|invoke) (?:the )?(?:prior )?`?scripts\/build\.sh`?/giu,
    guidance: "The legacy build script was deleted; direct users to sfn dev bootstrap build or sfn build.",
  },
  {
    id: "obsolete-installer-trust",
    scope: "current-facing",
    pattern: /\b(?:TLS-trust only|does not currently verify (?:the )?release signature|do not currently verify `?SHA256SUMS\.sig`?)\b/giu,
    guidance: "Installers verify the signed checksum manifest before extraction.",
  },
  {
    id: "effect-gate-underclaim",
    scope: "current-facing",
    pattern: /\b(?:once (?:effect )?enforcement ships|wiring it into the compilation gate)\b/giu,
    guidance: "io/net/clock effect enforcement is already a compile-time build gate.",
  },
  {
    id: "borrow-checking-tradeoff",
    scope: "current-facing",
    pattern:
      /\btrades? borrow checking for\b|\bcapability safety instead of memory safety\b|\b(?:don't|do not|doesn't|does not) need lifetime annotations\b/giu,
    guidance:
      "Effects do not substitute for memory safety. Moves/aliasing ship as a correctness floor; &T / &mut T exclusivity is parsed but unchecked, specified in SFEP-0018 and not currently prioritized.",
  },
  {
    id: "unbenchmarked-speed-claim",
    scope: "current-facing",
    pattern:
      /\b(?:blazing(?:ly)?[ -]fast|lightning[ -]fast|screaming[ -]fast|fast startup|fast compilation)\b/giu,
    guidance:
      "No published cross-language benchmark backs a speed claim; cite a docs/perf/ measurement or drop the adjective.",
  },
  {
    id: "unfalsifiable-superlative",
    // Several alternatives are deliberately narrowed rather than bare, because the
    // honest register we want trips the bare form: "the unmatched value" is
    // pattern-matching vocabulary, and "Sailfin is not the first language to check
    // effects" is exactly the concession this guard exists to encourage.
    pattern:
      /\bno other (?:\w+ ){0,3}language\b|\b(?<!not )(?:is|are|was|were) the first language to\b|\brevolutionary\b|\bparadigm shift\b|\bunmatched (?:performance|speed|safety|security)\b/giu,
    guidance:
      "Name the real comparison (WASI, Capslock, Koka/Flix/Effekt) and the specific axis instead of an unfalsifiable superlative.",
  },
  {
    id: "review-free-generated-code",
    scope: "current-facing",
    // Requires a positive assertion frame. "Never merge agent output without human
    // review" is correct and desirable copy and must not fail the build.
    pattern:
      /\b(?<!never )(?<!not )(?:ship|merge|deploy|iterate|generate|land)[a-z]*\b[^.\n]{0,40}\bwithout human review\b/giu,
    guidance:
      "Effect checking proves a function's declared capability surface, not that its logic is correct; it narrows review rather than replacing it.",
  },
  {
    id: "model-effect-overclaim",
    scope: "current-facing",
    // Both orders, because the claim is written both ways: "![model] is enforced"
    // and "any function that reaches an AI backend must declare it".
    pattern:
      // Every "must declare" alternative is anchored to model/AI context. An
      // unanchored \bmust declare it\b false-fires on correct sentences about
      // other effects ("greet requires ![io], so this function must declare it
      // too") and about `unsafe` in capsule.toml.
      /!\[model\][^.\n]{0,60}\b(?:is|are) (?:enforced|checked|required)\b|!\[model\][^.\n]{0,60}\b(?:is a compile error|fails the build|will fail)\b|\b(?:must|has to) declare (?:the )?!?\[?model\]?[\]\s]|\b(?:AI backend|model-capable API|inference (?:API|backend))[^.\n]{0,45}\b(?:must|has to) declare\b/giu,
    guidance:
      "![model] is reserved: declarable and propagated, but no detector or runtime API ships (docs/status.md).",
  },
  {
    id: "quantified-speed-claim",
    scope: "current-facing",
    // A fabricated number reads as measured and is worse than a fabricated adjective.
    pattern:
      /\b\d+(?:\.\d+)?\s*(?:x|×)\s+(?:faster|quicker|slower)\b|\bsub-second builds\b|\bnear-zero (?:startup|runtime) overhead\b/giu,
    guidance:
      "The repo publishes no cross-language benchmarks; docs/perf/ is same-host regression instrumentation. Cite a measurement or drop the number.",
  },
  {
    id: "deferral-without-gate",
    // decision-brief.md §156, and it binds: "post-1.0" and "deferred" name a *when*
    // with no unblocking condition, and agents read a status as a standing
    // instruction, so parked work is never re-evaluated. 1.0 is a maturity boundary,
    // not a schedule. Name the gate or the reason instead. The sfn/ai capsule is the
    // one sanctioned exception (a locked CLAUDE.md decision), so bare "post-1.0"
    // is not matched -- only the deferral phrasings that assert a schedule.
    pattern:
      /\bdeferred to post[- ]1\.0\b|\bdeferred (?:until|to) after 1\.0\b|\bscoped out of 1\.0\b|\bpush(?:ed)? (?:this )?(?:off )?(?:to|until) post[- ]1\.0\b/giu,
    guidance:
      "decision-brief.md §156: name the gate (`gated on: <predecessor>`) or the reason it is not prioritized. 1.0 is a maturity boundary, not a schedule.",
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
    fragment: "sailfin_${releaseVersion}_linux_arm64.tar.gz",
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
    source: "site/src/content/docs/docs/getting-started/install.md",
    fragment: "sailfin_${VERSION}_linux_arm64.tar.gz",
  },
  {
    source: ".github/workflows/release-tag.yml",
    fragment: 'installer_name="sailfin_${version}_${os}_${arch}${variant}.tar.gz"',
  },
];

const publicUrls = [
  "https://raw.githubusercontent.com/SailfinIO/sailfin/main/install.sh",
  "https://sailfin.dev/docs/getting-started/install/",
  "https://sailfin.dev/docs/reference/spec/",
  "https://sailfin.dev/roadmap",
  "https://pkg.sfn.dev",
];

// Exported so a test can assert llms.txt is actually in the scanned set. It is a
// `.txt` in the repo root, so it survives only via the `extname(path)` branch
// below; renaming it extensionless or moving it under a scanned directory would
// silently drop it from the guard, which is how it drifted in the first place.
export function sourceFiles(repoRoot) {
  const files = new Map();

  function collect(roots, historical) {
    function visit(path) {
      if (!existsSync(path)) return;
      const entries = readdirSync(path, { withFileTypes: true });
      for (const entry of entries) {
        const child = join(path, entry.name);
        if (entry.isDirectory()) visit(child);
        else if ([".astro", ".md", ".mdx"].includes(extname(entry.name))) {
          files.set(child, { path: child, historical });
        }
      }
    }

    for (const root of roots) {
      const path = join(repoRoot, root);
      if (!existsSync(path)) continue;
      if (extname(path)) files.set(path, { path, historical });
      else visit(path);
    }
  }

  collect(currentFacingRoots, false);
  collect(historicalRoots, true);
  return [...files.values()];
}

function lineNumber(content, index) {
  return content.slice(0, index).split("\n").length;
}

export function findRetiredClaimFailures(files) {
  const failures = [];
  for (const { path, content, historical = false } of files) {
    for (const claim of retiredClaims) {
      // Claims asserting what ships today don't apply to dated design records --
      // a migration SFEP has to be able to name the subsystem it deleted.
      if (historical && claim.scope === "current-facing") continue;
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
  const files = sourceFiles(repoRoot).map(({ path, historical }) => ({
    path: relative(repoRoot, path),
    content: readFileSync(path, "utf8"),
    historical,
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
