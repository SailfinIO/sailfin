---
sfep: 1
title: SFEP Purpose and Process
status: Accepted
type: process
created: 2026-06-26
updated: 2026-06-26
author: "agent:Sailbot (drafted); project owner (direction + decisions)"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0001 — SFEP Purpose and Process

**SFEP** stands for **Sailfin Enhancement Proposal.** This document defines what
an SFEP is, when to write one, how it is numbered and reviewed, and the bar every
proposal must clear — regardless of whether a human or an agent drafted it.

It is deliberately lighter than Python's PEP process or Rust's RFC process.
Sailfin is a small, self-hosting project moving fast toward 1.0; the proposal
system exists to give design decisions a **consistent shape, a stable citable
identifier, and an honest status** — not to add ceremony. Proposals live in this
repo (`docs/proposals/`) rather than an external repository: the design is close
to the code it governs, and the same PR can change both.

---

## 1. What an SFEP is (and is not)

An SFEP captures a **forward-looking design decision** for the language, runtime,
or toolchain — something with enough surface area or longevity that the *why*
deserves to be written down and cited from code and commits.

Write an SFEP for:

- A new or changed **language feature** (syntax, semantics, the effect system).
- A **runtime / ABI** design (memory model, ownership floor, concurrency,
  backend, syscall surface).
- A **toolchain** design (build pipeline, `sfn check`/`fmt`/`test`, package
  management, CLI architecture).
- A cross-cutting **process or informational** decision that future contributors
  will need the rationale for.

An SFEP is **not** the right home for several adjacent genres, which keep their
existing locations:

| If the document is… | It belongs in… |
|---|---|
| A rule we already follow (import style, test envelope) | `docs/conventions/` |
| A post-incident root-cause analysis | `docs/rca/` |
| An operational playbook | `docs/runbooks/` |
| A living migration/architecture tracker | root `docs/*.md` (e.g. `runtime_audit.md`) |
| A single-issue implementation design gate | `docs/proposals/design-notes/` (see §9) |
| User-facing reference for a *shipped* feature | `site/.../reference/spec/` |
| User-facing preview of a *planned* feature | `site/.../reference/preview/` |
| Strategic market positioning | `docs/strategy/` |

**Decision tree:** *design decision* → SFEP · *rule we follow* → convention ·
*incident* → rca · *living tracker* → root audit · *one-issue design gate* →
design-note.

---

## 2. Identifier and filename

- Every SFEP has a number: **`SFEP-NNNN`**, zero-padded to four digits
  (`SFEP-0017`). This is the citable identifier — use it in commits, issues,
  spec chapters, and code comments.
- The file is named **`NNNN-kebab-slug.md`** and lives in `docs/proposals/`.
  A multi-file proposal may instead be a directory `NNNN-kebab-slug/` whose
  `00-overview.md` is the canonical entry point.
- **`SFEP-0001` is reserved** for this process document.
- The **registry is `docs/proposals/README.md`** — a table of every SFEP with its
  status and type. It is the source of truth for which numbers are taken.

### Allocating a number

The next number is `max(existing) + 1`, read from the registry table. To avoid
two in-flight drafts claiming the same number:

- While a proposal is a **Draft in review**, it may carry `sfep: TBD` in its
  front-matter and a temporary `draft-<slug>.md` filename.
- The number is **fixed when the proposal merges**: assign the next free number,
  rename the file to `NNNN-<slug>.md`, and add its row to the registry in the
  same PR.

For low-volume periods, allocating the number up front (and updating the
registry in the PR) is fine — the registry merge is the arbiter if two PRs race.

---

## 3. Front-matter schema

Every SFEP begins with a YAML front-matter block so the registry and tooling can
read status without parsing prose:

```yaml
---
sfep: 17                      # integer, or TBD while drafting
title: Hierarchical Effects
status: Accepted              # see §4
type: language                # see §5
created: 2026-06-07           # YYYY-MM-DD, first drafted
updated: 2026-06-26           # YYYY-MM-DD, last substantive change
author: "agent:compiler-architect; human review"   # see §7
tracking: "#1180, #1466"      # related issue/epic numbers (optional)
supersedes:                   # SFEP-N this replaces (optional)
superseded-by:                # SFEP-N that replaced this (optional)
graduates-to: reference/preview/hierarchical-effects.md   # spec/preview home (optional)
---
```

The prose body follows. The front-matter is the authoritative, machine-readable
status; new SFEPs must not also carry a free-form `**Status:** … **Date:** …`
header block. Proposals migrated into this system may still contain a legacy prose
header beneath the front-matter — when one is next edited, trim the redundant
prose so the front-matter is the single source of truth.

---

## 4. Lifecycle

```
Draft ──▶ Accepted ──▶ Implemented
  │           │
  ├──▶ Withdrawn (author/owner abandons)
  ├──▶ Rejected (considered and declined)
  └──▶ Superseded (replaced by a newer SFEP; set superseded-by)
```

| Status | Meaning |
|---|---|
| **Draft** | Under authoring or review. Not yet approved for implementation. |
| **Accepted** | Design approved; cleared to implement. May be partially built. |
| **Implemented** | Shipped end-to-end and self-hosting (see the bar below). |
| **Withdrawn** | Abandoned before acceptance. |
| **Rejected** | Considered and declined. Kept for the record. |
| **Superseded** | Replaced by a newer SFEP. Set `superseded-by`. |

**Mapping to issue labels** (see `docs/conventions/issue-naming.md`):
`needs-design` → Draft · `design-approved` → Accepted · Stage1-readiness met →
Implemented.

**The bar for `Implemented`** is the Stage1 Readiness Checklist in `CLAUDE.md`:
parses → type/effect-checks → emits `.sfn-asm` → lowers to LLVM IR → has
regression coverage → self-hosts → passes `sfn fmt --check` → documented in
`docs/status.md` and the spec. **"Parsed but not enforced" is not Implemented** —
it stays `Accepted`. Do not mark a safety feature Implemented until it is
enforced end-to-end.

---

## 5. Type taxonomy

| Type | Scope |
|---|---|
| **language** | Syntax, semantics, type system, the effect system. |
| **runtime** | Runtime, ABI, memory model, ownership floor, concurrency, backend, syscalls. |
| **tooling** | Build pipeline, `check`/`fmt`/`test`, package management, CLI, diagnostics. |
| **process** | How the project itself operates (this document is one). |
| **informational** | Strategy input, design surveys, guidance with no single shipping artifact. |

`language`, `runtime`, and `tooling` are the standards track (they change what
ships). `process` and `informational` do not gate a release.

---

## 6. Required sections (the standard for every author)

A proposal — drafted by a human or an agent — must contain these sections. This
is the bar an outside contributor must clear; it is also the checklist an agent
fills. Incomplete proposals stay `Draft`.

1. **Summary** — one paragraph: what changes and why it matters.
2. **Motivation** — the problem, who hits it, why the status quo is insufficient.
3. **Design** — the concrete proposal: syntax/semantics/APIs, worked examples.
4. **Effect & capability impact** — how it interacts with the effect system and
   capability enforcement (Sailfin's pillars). State "none" explicitly if so.
5. **Self-hosting impact** — what compiler passes change, and how self-hosting is
   preserved. (See `.claude/rules/selfhost-invariant.md`.)
6. **Alternatives considered** — options weighed and why they lost. A proposal
   with no alternatives section is not ready.
7. **Stage1 readiness mapping** — which checklist items (§4) are done vs. pending.
8. **Test plan** — the regression coverage that will prove it (`compiler/tests/`).
9. **References** — issues/epics, related SFEPs, spec/preview chapters, prior art.

Use `template.md` in this directory as the starting skeleton.

---

## 7. Authorship and provenance

Most Sailfin proposals to date have been **agent-drafted**, and that is expected
to continue. The system records this honestly rather than hiding it:

- The `author` field names the drafter. Use an `agent:<role>` prefix for
  agent-authored drafts (e.g. `agent:compiler-architect`), and add
  `; human review` or a name when a human meaningfully shaped or signed off on it.
- **Provenance is tracked, not gated.** There is no required human "sponsor"
  field. Acceptance authority lives where it already does: PR review plus the
  issue labels (`design-approved`). A human reviewing and approving the PR *is*
  the human gate — we do not add a second one.
- The required sections in §6 are the real quality bar. They apply identically to
  human and agent drafts. A proposal is judged on whether it clears that bar, not
  on who or what wrote it.

This keeps the door open for outside (human) contributors: the standard they must
meet is written down (§6), uniform, and independent of authorship.

---

## 8. Workflow

**Proposing:**

1. Copy `template.md` to `draft-<slug>.md` (or `NNNN-<slug>.md` if claiming a
   number now). Fill the front-matter (`status: Draft`) and the §6 sections.
2. Open a PR. Iterate in review.
3. On acceptance, set `status: Accepted`, assign/confirm the number, rename to
   `NNNN-<slug>.md`, and add the registry row — all in the merging PR.

**Implementing:** land the work behind the proposal; when it clears the Stage1
bar (§4), set `status: Implemented`, bump `updated`, and ensure `graduates-to`
points at the shipped spec chapter (and `docs/status.md` reflects it).

**Graduating to user docs:** a `language`/`runtime` SFEP's user-facing surface
lives on the docs site — `reference/preview/` while planned, moving to
`reference/spec/` once Implemented. The SFEP remains the design record (the
*why*); the spec chapter is the normative reference (the *what*). Cross-link both.

**Retiring:** set `status: Withdrawn`/`Rejected`/`Superseded` and move the file to
`archive/` (§9) if it is no longer load-bearing.

---

## 9. Directory layout

```
docs/proposals/
  README.md              # the registry/index + how-to (the source of truth for numbers)
  template.md            # copy-to-start skeleton
  0001-sfep-process.md   # this document
  NNNN-<slug>.md         # numbered SFEPs (Implemented ones stay here as the record)
  NNNN-<slug>/           # multi-file SFEPs; 00-overview.md is canonical
  design-notes/          # single-issue implementation design gates — NOT SFEPs
  archive/               # superseded / rejected / stale historical notes
```

- **`design-notes/`** holds design docs scoped to one issue/PR that informed an
  implementation but are not enhancement proposals (e.g. an ASAN-gated free
  discipline for one worker path). They keep descriptive slug filenames and need
  no SFEP number.
- **`archive/`** preserves history for proposals and work-notes that are no longer
  current (superseded designs, completed one-off migration audits, old phase
  notes). Nothing in `archive/` is a live SFEP.

---

## 10. Relationship to the roadmap and issues

- The **roadmap** (`site/src/pages/roadmap.astro`) is strategic — epics, not
  proposals. An epic may spawn an SFEP for its design.
- **GitHub issues** are session-sized work. An SFEP's `tracking` field links the
  issue(s)/epic(s) implementing it; issues link back to the SFEP for the *why*.
- An SFEP is the **durable design record**; issues and PRs are the **execution**.
  When they disagree, the SFEP's `status` is authoritative for design intent and
  `docs/status.md` is authoritative for what actually ships today.
