#!/usr/bin/env node
/*
 * Generate the social OG card at site/public/images/og_card.png.
 *
 * 1200 × 630, near-black surface with the Sailfin violet→magenta radial
 * spotlight, Guillermo (the sailfin lizard mark) on the right, wordmark
 * + tagline on the left. Colors and layout are inlined in the composed
 * SVG below — if brand tokens shift in site/src/styles/tokens.css, mirror
 * the new values here by hand and re-run the script.
 *
 * Re-run with `node site/scripts/build-og.mjs` whenever the brand or
 * tagline changes.
 */
import { readFile, writeFile, mkdir } from "node:fs/promises";
import { existsSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import sharp from "sharp";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const publicDir = path.resolve(__dirname, "../public");
const outPath = path.join(publicDir, "images/og_card.png");
const logoPath = path.join(publicDir, "images/sfn_lang_logo_256.svg");

if (!existsSync(logoPath)) {
  console.error(`missing logo at ${logoPath}`);
  process.exit(1);
}

const logoSvg = await readFile(logoPath, "utf8");
// Inline the logo by extracting its root <svg>…</svg> and re-wrapping it into
// a sub-SVG with a viewBox so we can position it precisely.
const innerMatch = logoSvg.match(/<svg[^>]*>([\s\S]*?)<\/svg>/i);
if (!innerMatch) {
  console.error("could not parse logo svg");
  process.exit(1);
}
const logoInner = innerMatch[1];
// Grab the viewBox from the source so geometry scales correctly.
const vbMatch = logoSvg.match(/viewBox="([^"]+)"/);
const logoViewBox = vbMatch ? vbMatch[1] : "0 0 256 256";

const W = 1200;
const H = 630;

const composedSvg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}" viewBox="0 0 ${W} ${H}">
  <defs>
    <radialGradient id="spot" cx="30%" cy="30%" r="80%">
      <stop offset="0%" stop-color="#fb48b8" stop-opacity="0.55" />
      <stop offset="35%" stop-color="#a000ff" stop-opacity="0.45" />
      <stop offset="75%" stop-color="#5a0090" stop-opacity="0.35" />
      <stop offset="100%" stop-color="#0e0b14" stop-opacity="0" />
    </radialGradient>
    <linearGradient id="accent" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#5a0090" />
      <stop offset="45%" stop-color="#a000ff" />
      <stop offset="100%" stop-color="#fb48b8" />
    </linearGradient>
  </defs>
  <rect width="${W}" height="${H}" fill="#0e0b14" />
  <rect width="${W}" height="${H}" fill="url(#spot)" />
  <!-- hairline border -->
  <rect x="0.5" y="0.5" width="${W - 1}" height="${H - 1}" fill="none" stroke="rgba(255,255,255,0.06)" />

  <!-- Effect-annotation motif in the corner, a wink for the visual vocabulary -->
  <g font-family="'JetBrains Mono', ui-monospace, monospace" font-size="20" fill="#cfc4e0" opacity="0.75">
    <text x="72" y="88">![io, net, clock]</text>
  </g>

  <!-- Wordmark -->
  <g font-family="'Inter', -apple-system, 'Segoe UI', sans-serif" fill="#f4eefb">
    <text x="72" y="240" font-size="128" font-weight="800" letter-spacing="-5">sfn</text>
    <text x="72" y="290" font-size="22" font-weight="600" letter-spacing="8" fill="#cfc4e0">SAILFIN</text>
  </g>

  <!-- Tagline -->
  <g font-family="'Inter', -apple-system, 'Segoe UI', sans-serif" fill="#f4eefb">
    <text x="72" y="420" font-size="44" font-weight="700" letter-spacing="-1">Know what your code can do</text>
    <text x="72" y="472" font-size="44" font-weight="700" letter-spacing="-1" fill="url(#accent)">before it runs.</text>
    <text x="72" y="548" font-size="22" font-weight="500" fill="#cfc4e0">A compiled systems language with compile-time effect checking.</text>
  </g>

  <!-- Guillermo, placed on the right. The source viewBox is ${logoViewBox}; we
       embed it as a nested <svg> with preserveAspectRatio so it scales cleanly. -->
  <svg x="780" y="115" width="380" height="380" viewBox="${logoViewBox}" preserveAspectRatio="xMidYMid meet">
    ${logoInner}
  </svg>
</svg>`;

await mkdir(path.dirname(outPath), { recursive: true });
await sharp(Buffer.from(composedSvg)).png({ compressionLevel: 9 }).toFile(outPath);
console.log(`wrote ${path.relative(process.cwd(), outPath)} (${W}x${H})`);

// Keep the source SVG alongside so it is easy to iterate on.
const svgOut = outPath.replace(/\.png$/, ".svg");
await writeFile(svgOut, composedSvg);
console.log(`wrote ${path.relative(process.cwd(), svgOut)}`);
