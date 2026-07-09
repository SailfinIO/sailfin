Design decisions for Sailfin are recorded as **SFEPs** (Sailfin Enhancement
Proposals) under `docs/proposals/`. The full process is `docs/proposals/0001-sfep-process.md`
(SFEP-0001); this rule is the always-loaded summary every agent must follow when
producing or touching a design document.

## When an SFEP is required

Write (or update) an SFEP for a **forward-looking design decision** with real
surface area or longevity:

- A new/changed **language** feature (syntax, semantics, the effect system).
- A **runtime/ABI** design (memory model, ownership floor, concurrency, backend,
  syscall surface).
- A **toolchain** design (build pipeline, `check`/`fmt`/`test`, packaging, CLI).
- The design behind a **roadmap epic** before it is groomed into issues.

Do **not** force an SFEP onto adjacent genres — they keep their homes:
a rule we already follow → `docs/conventions/`; a post-incident analysis →
`docs/rca/`; an operational playbook → `docs/runbooks/`; a living
migration/architecture tracker → root `docs/*.md`; a **single-issue**
implementation design gate → `docs/proposals/design-notes/`. Small or mechanical
work (a one-line fix, a localized bug, a routine refactor) needs **no** SFEP —
the issue body is enough. When unsure, see the decision tree in SFEP-0001 §1.

## How to create one

1. Copy `docs/proposals/template.md` to `docs/proposals/draft-<slug>.md`.
2. Fill the YAML front-matter (`status: Draft`) and **every** required section
   (Summary, Motivation, Design, Effect & capability impact, Self-hosting impact,
   Alternatives, Stage1 readiness mapping, Test plan, References). An incomplete
   proposal stays `Draft`.
3. **Number allocation:** the registry table in `docs/proposals/README.md` is the
   source of truth — the next number is `max + 1`. Keep `sfep: TBD` and the
   `draft-<slug>.md` name while in review; fix the number when the proposal
   merges (rename to `NNNN-<slug>.md` and add the registry row in the same PR).

## Lifecycle

`Draft → Accepted → Implemented` (+ terminal `Withdrawn` / `Rejected` /
`Superseded`). The SFEP's own `status:` front-matter is the source of truth,
mirrored by the implementing Linear issue's native status — **not** by GitHub
labels. (The `design-approved` workflow-state label is retired; `needs-design`
survives only as a public GitHub external-intake hint and is never applied to a
Linear-native `SFN-NNN` issue — Linear status carries the design-gate state.)
Loosely: an ungroomed design is `Draft`, a design-gate-passed proposal is
`Accepted`, and Stage1-readiness-met is `Implemented`.

- Move to **Accepted** only when the design gate is passed (user/owner approval).
- Move to **Implemented** only when the work clears the `CLAUDE.md` Stage1
  Readiness Checklist end-to-end and self-hosts. **"Parsed but not enforced" is
  not Implemented** — it stays `Accepted`. Never advance an SFEP's status without
  bumping `updated:` and updating its row in the registry table.

## Linking SFEPs to the work

The SFEP is the durable **design record** (the *why*); issues and PRs are the
**execution**. Keep them cross-linked, do not duplicate the design into issue
bodies:

- An issue implementing an SFEP cites it in its body (e.g. `Design: SFEP-0017`)
  and links the file path. `/pickup` reads the SFEP as the design brief rather
  than redesigning.
- The SFEP's `tracking:` front-matter lists the implementing issue/epic numbers.
- When a feature ships, its SFEP flips to `Implemented` and `graduates-to` points
  at the spec/preview chapter (and `docs/status.md` reflects it).

Use `/sfep new|status|list|graduate` for these steps so they happen the same way
every time. Formatting note: SFEP files are Markdown, not `.sfn` — they are not
subject to `sfn fmt` or the self-host gate.
