# Manage a Sailfin Enhancement Proposal (SFEP)

Create and transition SFEPs — the design records under `docs/proposals/` — in a
standardized, repeatable way. The governing process is
`docs/proposals/0001-sfep-process.md`; the always-loaded rule is
`.claude/rules/proposals.md`.

## Invocation: `/sfep $ARGUMENTS`

The first token of `$ARGUMENTS` selects the mode:

| Mode | Form | Purpose |
|---|---|---|
| `new` | `/sfep new <slug> [type]` | Scaffold a Draft proposal from the template |
| `status` | `/sfep status <N> <state>` | Transition lifecycle + sync the registry |
| `graduate` | `/sfep graduate <N>` | Mark Implemented + wire spec/preview + status.md |
| `list` | `/sfep list [status]` | Print the registry, optionally filtered |

If `$ARGUMENTS` is empty, default to `list`.

---

## Mode: `new <slug> [type]`

Scaffold a new proposal for authoring. `type` is one of `language` (default
when the slug implies syntax/semantics), `runtime`, `tooling`, `process`,
`informational`.

1. **Pick a slug** — short, kebab-case, descriptive (e.g. `typed-channels`).
2. **Scaffold from the template** (stays `draft-` until merge; the number is
   assigned then):
   ```bash
   cp docs/proposals/template.md docs/proposals/draft-<slug>.md
   ```
3. **Read the registry to know the next number** (informational at this stage):
   ```bash
   grep -oE '^\| \[?[0-9]{4}' docs/proposals/README.md | grep -oE '[0-9]{4}' | sort -n | tail -1
   ```
   The next number is that value `+ 1`. Record it in your head; do not claim it
   in the file yet (`sfep: TBD` avoids collisions between concurrent drafts).
4. **Fill the front-matter and every required section.** Set `status: Draft`,
   `type`, `created`/`updated` to today, and `author` (use an `agent:<role>`
   prefix for agent-drafted work — see SFEP-0001 §7). All nine sections are
   required; an incomplete proposal stays Draft.
5. Report the draft path and the number it will take at merge. Do **not** add the
   registry row yet — that happens when the proposal is accepted/merged
   (`/sfep status <N> Accepted`).

---

## Mode: `status <N> <state>`

Transition an existing proposal. `<state>` ∈
`Draft|Accepted|Implemented|Withdrawn|Rejected|Superseded`. `<N>` is the SFEP
number (or, for a not-yet-numbered draft, the slug).

1. **Locate the file**: `docs/proposals/<NNNN>-*.md` (or `draft-<slug>.md`).
2. **Assigning the number** (first transition off a `draft-`): confirm the next
   free number from the registry (`max + 1`), set `sfep:` in the front-matter,
   and rename:
   ```bash
   git mv docs/proposals/draft-<slug>.md docs/proposals/<NNNN>-<slug>.md
   ```
3. **Apply the gates** for the target state:
   - **Accepted** — design gate passed (user/owner approval). Update the front-matter.
   - **Implemented** — only if the work clears the `CLAUDE.md` Stage1 Readiness
     Checklist end-to-end and self-hosts. "Parsed but not enforced" is **not**
     Implemented; keep it Accepted. Prefer `/sfep graduate <N>` for this — it
     also wires the spec/preview + status.md.
   - **Superseded** — set `superseded-by: <new SFEP>` and move the file to
     `docs/proposals/archive/` (`git mv`).
   - **Withdrawn / Rejected** — move to `docs/proposals/archive/`.
4. **Edit the front-matter**: set `status:`, bump `updated:` to today, and set
   any `superseded-by:` / `tracking:` fields the transition implies. Do not also
   maintain a free-form prose `**Status:**` line — front-matter is authoritative.
5. **Sync the registry** (`docs/proposals/README.md`): update this proposal's
   row (Status column), or add the row on first acceptance. Keep the index sorted
   by number.
6. Report the old → new state and the registry update.

---

## Mode: `graduate <N>`

Promote an Accepted proposal to **Implemented** once its feature ships. This is
the `status … Implemented` transition plus the user-facing doc wiring.

1. **Verify the Stage1 bar** is actually met (parses → type/effect-checks →
   emits `.sfn-asm` → lowers → regression coverage → self-hosts → `sfn fmt
   --check` → documented). If any item is unmet, stop — it stays Accepted.
2. Set `status: Implemented`, bump `updated:`, and ensure `graduates-to:` points
   at the shipped chapter under `site/src/content/docs/docs/reference/` (a
   `spec/NN-*.md` chapter once shipped; `preview/*.md` while still planned).
3. Hand off the user-facing docs to **docs-updater** (status.md → spec → roadmap)
   so the spec chapter and `docs/status.md` reflect the shipped feature.
4. Update the registry row to `Implemented`.
5. Report what graduated and the spec destination.

---

## Mode: `list [status]`

Print the registry from `docs/proposals/README.md`. With a `status` argument
(`Draft`, `Accepted`, `Implemented`, …), filter to matching rows. Use this to
find the design record behind an issue, or to audit which proposals are
Accepted-but-not-yet-Implemented.

```bash
sed -n '/^| SFEP/,/^$/p' docs/proposals/README.md
```

---

## Constraints

- **The registry table in `docs/proposals/README.md` is the number authority.**
  Never reuse a number; next = `max + 1`. Add the row in the same PR that merges
  the proposal.
- **Front-matter is the single source of truth for status** — bump `updated:` on
  every transition; do not leave a conflicting prose status line.
- **Never mark Implemented before end-to-end enforcement + self-host.** "Parsed
  but not enforced" stays Accepted (this is the same bar as the rest of the
  project — see `CLAUDE.md` Stage1 Readiness).
- **Don't duplicate the design into issues.** Issues cite the SFEP
  (`Design: SFEP-NNNN`); the SFEP's `tracking:` lists the issues.
- **SFEP files are Markdown, not `.sfn`** — no `sfn fmt`, no self-host gate.
  Editing them does not require `make compile`.
- **Scope discipline:** only design decisions become SFEPs. Conventions, RCAs,
  runbooks, living trackers, and single-issue design gates keep their own homes
  (see `.claude/rules/proposals.md` and SFEP-0001 §1).
