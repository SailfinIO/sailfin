#!/usr/bin/env node

import { createHash } from "node:crypto";
import { pathToFileURL } from "node:url";

const DEFAULT_PDS_URL = "https://bsky.social";
const MAX_GRAPHEMES = 300;
const TID_ALPHABET = "234567abcdefghijklmnopqrstuvwxyz";
const TID_VALUE_MASK = (1n << 63n) - 1n;
const segmenter = new Intl.Segmenter("en", { granularity: "grapheme" });

function graphemes(value) {
  return [...segmenter.segment(value)].map(({ segment }) => segment);
}

function validateCanonicalUrl(kind, value) {
  const url = new URL(value);
  if (url.protocol !== "https:") throw new Error("Canonical URL must use https");
  if (url.username || url.password) throw new Error("Canonical URL must not contain credentials");
  if (kind === "blog" && !["sailfin.dev", "www.sailfin.dev"].includes(url.hostname)) {
    throw new Error("Blog canonical URL must be on sailfin.dev");
  }
  if (kind === "release" && (url.hostname !== "github.com" || !url.pathname.includes("/releases/tag/"))) {
    throw new Error("Release canonical URL must be a github.com release tag URL");
  }
  return url.href;
}

export function formatPost({ kind, title, summary, url }) {
  if (!['release', 'blog'].includes(kind)) throw new Error("Kind must be 'release' or 'blog'");
  const cleanTitle = title.trim();
  const cleanSummary = summary.replace(/\s+/gu, " ").trim();
  if (!cleanTitle) throw new Error("Title is required");
  if (!cleanSummary) throw new Error("Summary is required");
  const canonicalUrl = validateCanonicalUrl(kind, url);
  const heading = kind === "release" ? `Sailfin release: ${cleanTitle}` : `New on the Sailfin blog: ${cleanTitle}`;
  const suffix = `\n\n${canonicalUrl}`;
  const fixedCount = graphemes(heading + "\n\n" + suffix).length;
  if (fixedCount > MAX_GRAPHEMES) {
    throw new Error("Title and canonical URL leave no room for announcement text within 300 graphemes");
  }

  const available = MAX_GRAPHEMES - fixedCount;
  const summaryParts = graphemes(cleanSummary);
  let renderedSummary = cleanSummary;
  if (summaryParts.length > available) {
    if (available < 2) throw new Error("Announcement has no room to truncate its summary safely");
    renderedSummary = summaryParts.slice(0, available - 1).join("").trimEnd() + "…";
  }
  const text = `${heading}\n\n${renderedSummary}${suffix}`;
  const byteStart = Buffer.byteLength(text.slice(0, text.lastIndexOf(canonicalUrl)), "utf8");
  const byteEnd = byteStart + Buffer.byteLength(canonicalUrl, "utf8");
  return {
    text,
    facets: [{ index: { byteStart, byteEnd }, features: [{ $type: "app.bsky.richtext.facet#link", uri: canonicalUrl }] }],
    graphemeCount: graphemes(text).length,
    canonicalUrl,
  };
}

function decodeHtml(value) {
  return value
    .replace(/&amp;/gu, "&")
    .replace(/&quot;/gu, '"')
    .replace(/&#39;|&apos;/gu, "'")
    .replace(/&lt;/gu, "<")
    .replace(/&gt;/gu, ">");
}

function metaContent(html, property) {
  const escaped = property.replace(/[.*+?^${}()|[\]\\]/gu, "\\$&");
  const patterns = [
    new RegExp(`<meta[^>]+(?:property|name)=["']${escaped}["'][^>]+content=["']([^"']*)["'][^>]*>`, "iu"),
    new RegExp(`<meta[^>]+content=["']([^"']*)["'][^>]+(?:property|name)=["']${escaped}["'][^>]*>`, "iu"),
  ];
  for (const pattern of patterns) {
    const match = html.match(pattern);
    if (match) return decodeHtml(match[1].trim());
  }
  return "";
}

export async function fetchCard(canonicalUrl, fetchImpl = fetch) {
  const response = await fetchImpl(canonicalUrl, {
    headers: { "user-agent": "Sailfin Bluesky Publisher/1.0" },
    redirect: "follow",
  });
  if (!response.ok) throw new Error(`Could not fetch link-card metadata (HTTP ${response.status})`);
  const html = await response.text();
  return {
    $type: "app.bsky.embed.external",
    external: {
      uri: canonicalUrl,
      title: metaContent(html, "og:title") || metaContent(html, "twitter:title") || "Sailfin",
      description: metaContent(html, "og:description") || metaContent(html, "description") || "",
    },
  };
}

async function xrpc(fetchImpl, pdsUrl, method, name, { token, body, params } = {}) {
  const endpoint = new URL(`/xrpc/${name}`, pdsUrl);
  for (const [key, value] of Object.entries(params || {})) endpoint.searchParams.set(key, value);
  const response = await fetchImpl(endpoint, {
    method,
    headers: {
      ...(token ? { authorization: `Bearer ${token}` } : {}),
      ...(body ? { "content-type": "application/json" } : {}),
    },
    ...(body ? { body: JSON.stringify(body) } : {}),
  });
  const payload = await response.json().catch(() => ({}));
  if (!response.ok) {
    const detail = typeof payload.message === "string" ? `: ${payload.message}` : "";
    throw new Error(`Bluesky API ${name} failed (HTTP ${response.status})${detail}`);
  }
  return payload;
}

export function recordKey(canonicalUrl) {
  let value = createHash("sha256").update(canonicalUrl).digest().readBigUInt64BE() & TID_VALUE_MASK;
  let rkey = "";
  for (let index = 0; index < 13; index += 1) {
    rkey = TID_ALPHABET[Number(value & 31n)] + rkey;
    value >>= 5n;
  }
  return rkey;
}

export async function publish({ post, card, handle, appPassword, pdsUrl = DEFAULT_PDS_URL, fetchImpl = fetch, now = new Date() }) {
  if (!handle) throw new Error("BLUESKY_HANDLE is required");
  if (!appPassword) throw new Error("BLUESKY_APP_PASSWORD is required; use an app password, not the primary password");
  const session = await xrpc(fetchImpl, pdsUrl, "POST", "com.atproto.server.createSession", {
    body: { identifier: handle, password: appPassword },
  });
  const rkey = recordKey(post.canonicalUrl);
  const lookup = await fetchImpl(new URL(`/xrpc/com.atproto.repo.getRecord?repo=${encodeURIComponent(session.did)}&collection=app.bsky.feed.post&rkey=${rkey}`, pdsUrl), {
    headers: { authorization: `Bearer ${session.accessJwt}` },
  });
  if (lookup.ok) return { status: "duplicate", rkey };
  if (lookup.status !== 400 && lookup.status !== 404) {
    throw new Error(`Bluesky duplicate check failed (HTTP ${lookup.status})`);
  }
  const result = await xrpc(fetchImpl, pdsUrl, "POST", "com.atproto.repo.createRecord", {
    token: session.accessJwt,
    body: {
      repo: session.did,
      collection: "app.bsky.feed.post",
      rkey,
      record: {
        $type: "app.bsky.feed.post",
        text: post.text,
        facets: post.facets,
        embed: card,
        createdAt: now.toISOString(),
      },
    },
  });
  return { status: "posted", rkey, uri: result.uri };
}

function parseArgs(argv) {
  const args = {};
  for (let index = 0; index < argv.length; index += 1) {
    const argument = argv[index];
    if (argument === "--dry-run") args.dryRun = true;
    else if (argument.startsWith("--")) {
      const value = argv[index + 1];
      if (!value || value.startsWith("--")) throw new Error(`Missing value for ${argument}`);
      args[argument.slice(2).replace(/-([a-z])/gu, (_, letter) => letter.toUpperCase())] = value;
      index += 1;
    } else throw new Error(`Unknown argument: ${argument}`);
  }
  return args;
}

export async function main(argv = process.argv.slice(2), env = process.env) {
  const args = parseArgs(argv);
  const post = formatPost(args);
  const card = await fetchCard(post.canonicalUrl);
  if (args.dryRun) {
    console.log(JSON.stringify({ dryRun: true, ...post, embed: card }, null, 2));
    return;
  }
  const result = await publish({
    post,
    card,
    handle: env.BLUESKY_HANDLE,
    appPassword: env.BLUESKY_APP_PASSWORD,
    pdsUrl: env.BLUESKY_PDS_URL || DEFAULT_PDS_URL,
  });
  console.log(result.status === "duplicate" ? `Already announced (${result.rkey}); no post created.` : `Published ${result.uri}`);
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  main().catch((error) => {
    console.error(`Bluesky publisher error: ${error.message}`);
    process.exitCode = 1;
  });
}
