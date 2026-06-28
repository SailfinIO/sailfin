# Codex SFEP Prompt

```text
Manage a Sailfin Enhancement Proposal (SFEP).

Follow AGENTS.md, docs/proposals/0001-sfep-process.md, docs/proposals/template.md, docs/proposals/README.md, and the SFEP workflow summarized here.

Modes:
- `new <slug> [type]`: copy docs/proposals/template.md to docs/proposals/draft-<slug>.md, keep `sfep: TBD`, fill all required sections, and report the next likely number from the registry without claiming it.
- `status <N-or-draft-slug> <Draft|Accepted|Implemented|Withdrawn|Rejected|Superseded>`: locate the proposal, assign/rename a draft only when it leaves draft status, update front matter and `updated:`, move terminal proposals to archive when required, and sync docs/proposals/README.md.
- `graduate <N>`: only after Stage1 readiness is met end-to-end and self-hosts, set `Implemented`, wire `graduates-to`, update docs/status.md and the relevant spec/preview page, and sync the registry.
- `list [status]`: print/filter the registry from docs/proposals/README.md.

Never mark a proposal Implemented for parsed-but-unenforced behavior. SFEP Markdown is not subject to `sfn fmt` or the self-host gate unless code changes accompany it.
```
