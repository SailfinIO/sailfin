# Bluesky announcements

Sailfin publishes deterministic release and blog announcements through the
official `@sfn.dev` Bluesky account. GitHub release notes and `sailfin.dev`
articles remain canonical; each social post contains a shortened summary, a
byte-accurate link facet, and an external card populated from Open Graph data.

## Repository configuration

Configure these in **Settings → Secrets and variables → Actions**:

| Type | Name | Value |
| --- | --- | --- |
| Repository variable | `BLUESKY_HANDLE` | `sfn.dev` |
| Repository secret | `BLUESKY_APP_PASSWORD` | A dedicated app password for `@sfn.dev` |

Never store or use the account's primary password. The publisher defaults to
`https://bsky.social`; a self-hosted PDS can be selected with the optional
`BLUESKY_PDS_URL` environment variable when running locally. The workflows
have only `contents: read` permission.

Rotate the credential by creating a new app password in Bluesky, replacing the
GitHub secret, exercising a dry run and smoke test, and then revoking the old
app password. GitHub masks the secret, and the publisher never prints session
tokens or request bodies.

## Triggers and manual use

Publishing a GitHub Release triggers `bluesky-release.yml`, which forwards the
release title, canonical GitHub URL, and release notes to the shared
`bluesky-post.yml` workflow. The publisher enforces Bluesky's 300-grapheme
budget and truncates only summary text at a Unicode grapheme boundary. It never
truncates the canonical URL.

For a published blog article, open **Actions → Publish Bluesky announcement →
Run workflow**, select `blog`, and supply its title, canonical
`https://sailfin.dev` URL, and a short factual summary from the article. Leave
**dry_run** enabled to preview the exact text, facet offsets, and link-card
metadata. Disable it only after reviewing the preview. Other workflows can call
the same workflow with `workflow_call` and the same five inputs.

For a local, non-posting preview:

```sh
node tools/bluesky/post.mjs \
  --kind blog \
  --title "Article title" \
  --summary "A factual summary from the article." \
  --url "https://sailfin.dev/blog/example" \
  --dry-run
```

The dry run fetches public Open Graph metadata but does not authenticate and
does not require either credential.

## Idempotency and failures

Each canonical URL maps to a deterministic AT Protocol record key. Before
posting, the publisher checks that key in the account repository; a retry or
redelivered release event reports `Already announced` and succeeds without a
second post. Changing a title or summary does not bypass duplicate protection.

Missing configuration, invalid inputs, metadata-fetch failures, authentication
errors, and API errors fail the job with an actionable message. Error messages
contain the XRPC method and HTTP status but never credentials or tokens.

To disable all announcements without deleting credentials, disable both
workflows in GitHub Actions. To disable only automatic releases, disable
**Announce published release on Bluesky**; manual blog previews and posts remain
available through the shared workflow.

## One-time post-merge smoke test

After the variable and secret are configured on the default branch:

1. Manually run **Publish Bluesky announcement** with `kind: blog`, an existing
   canonical Sailfin article, summary `SFN-574 Bluesky integration smoke test`,
   and `dry_run: true`.
2. Review the rendered text and external-card metadata in the job log.
3. Re-run with `dry_run: false`. Confirm that the text, link, and card render on
   `@sfn.dev`.
4. Re-run the same inputs and confirm the job reports `Already announced`
   without creating a second post.
5. Delete the recognizable smoke-test post from Bluesky.
