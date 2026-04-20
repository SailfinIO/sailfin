---
applyTo: "docs/**"
---

# Documentation Instructions

When working in the docs directory:

- `docs/status.md` is the source of truth for feature implementation status. Update it first.
- The language spec lives on the docs site under `site/src/content/docs/docs/reference/spec/` (chapter files §1–§11 for current language) and `.../reference/preview/` (planned features). Align terminology with those files (capsule, fleet, provenance card, generation card).
- The [roadmap](https://sailfin.dev/roadmap) (`site/src/pages/roadmap.astro`) tracks active workstreams and sequencing.
- `docs/proposals/` holds future-facing designs — leave them there until `status.md` marks them shipped.
- Keep documentation authoritative and concise — no speculative content.
