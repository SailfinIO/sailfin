---
applyTo: "site/**"
---

# Documentation Site Instructions

When working on the documentation website:

- Built with Astro 6.x (static site generator) and TypeScript.
- Package manager: npm (see `site/package.json`).
- Deployed via Cloudflare Workers (wrangler).
- Keep content aligned with `docs/` source-of-truth documents.
- Images are processed with Sharp — optimize for web delivery.
