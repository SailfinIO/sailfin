import assert from "node:assert/strict";
import test from "node:test";

import { fetchCard, formatPost, publish, recordKey } from "./post.mjs";

const releaseUrl = "https://github.com/SailfinIO/sailfin/releases/tag/v1.2.3";

test("formats a release with a UTF-8 byte-indexed link facet", () => {
  const post = formatPost({ kind: "release", title: "v1.2.3 🐟", summary: "Safer café output.", url: releaseUrl });
  assert.match(post.text, /^Sailfin release: v1\.2\.3 🐟/u);
  assert.equal(post.graphemeCount, [...new Intl.Segmenter("en", { granularity: "grapheme" }).segment(post.text)].length);
  const facet = post.facets[0];
  assert.equal(Buffer.from(post.text).subarray(facet.index.byteStart, facet.index.byteEnd).toString(), releaseUrl);
});

test("formats a blog announcement", () => {
  const url = "https://sailfin.dev/blog/compiler-update";
  const post = formatPost({ kind: "blog", title: "Compiler update", summary: "What changed and why.", url });
  assert.equal(post.text, `New on the Sailfin blog: Compiler update\n\nWhat changed and why.\n\n${url}`);
});

test("truncates only summary text at a grapheme boundary and preserves the URL", () => {
  const family = "👨‍👩‍👧‍👦";
  const post = formatPost({ kind: "release", title: "v1.2.3", summary: family.repeat(400), url: releaseUrl });
  assert.equal(post.graphemeCount, 300);
  assert.ok(post.text.endsWith(`…\n\n${releaseUrl}`));
  assert.ok(!post.text.includes("�"));
});

test("rejects an overlong fixed title instead of damaging the URL", () => {
  assert.throws(() => formatPost({ kind: "release", title: "x".repeat(300), summary: "summary", url: releaseUrl }), /leave no room/u);
});

test("builds a link card from Open Graph metadata", async () => {
  const card = await fetchCard(releaseUrl, async () => new Response('<meta property="og:title" content="Sailfin &amp; friends"><meta content="Release notes" property="og:description">'));
  assert.deepEqual(card.external, { uri: releaseUrl, title: "Sailfin & friends", description: "Release notes" });
});

test("uses a deterministic record key and skips an existing post", async () => {
  const calls = [];
  const fetchImpl = async (url, options = {}) => {
    calls.push({ url: String(url), options });
    if (String(url).endsWith("com.atproto.server.createSession")) {
      return Response.json({ did: "did:plc:sailfin", accessJwt: "token" });
    }
    return Response.json({ value: { text: "existing" } });
  };
  const post = formatPost({ kind: "release", title: "v1.2.3", summary: "Summary", url: releaseUrl });
  const result = await publish({ post, card: {}, handle: "sfn.dev", appPassword: "secret", fetchImpl });
  assert.deepEqual(result, { status: "duplicate", rkey: recordKey(releaseUrl) });
  assert.equal(calls.length, 2);
  assert.ok(!calls.some(({ url }) => url.includes("createRecord")));
});

test("creates a fixed-key record when the canonical URL is new", async () => {
  const requests = [];
  const fetchImpl = async (url, options = {}) => {
    requests.push({ url: String(url), options });
    if (String(url).endsWith("createSession")) return Response.json({ did: "did:plc:sailfin", accessJwt: "token" });
    if (String(url).includes("getRecord")) return new Response("{}", { status: 404 });
    return Response.json({ uri: "at://did:plc:sailfin/app.bsky.feed.post/key" });
  };
  const post = formatPost({ kind: "release", title: "v1.2.3", summary: "Summary", url: releaseUrl });
  const result = await publish({ post, card: { external: {} }, handle: "sfn.dev", appPassword: "app-password", fetchImpl, now: new Date("2026-01-01T00:00:00Z") });
  assert.equal(result.status, "posted");
  const create = requests.find(({ url }) => url.endsWith("createRecord"));
  const body = JSON.parse(create.options.body);
  assert.equal(body.rkey, recordKey(releaseUrl));
  assert.equal(body.record.createdAt, "2026-01-01T00:00:00.000Z");
});
