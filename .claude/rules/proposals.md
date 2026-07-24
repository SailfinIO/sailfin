Design decisions are recorded as **SFEPs** under `docs/proposals/`. Full process:
`docs/proposals/0001-sfep-process.md`. Use `/sfep new|status|list|graduate` to
create and transition them.

**When one is required:** a new or changed language feature, a runtime/ABI
design, a toolchain design, or the design behind a roadmap epic before it is
groomed. Small or mechanical work needs no SFEP — the issue body is enough.

**Don't force an SFEP onto adjacent genres.** A rule we already follow →
`docs/conventions/`; a post-incident analysis → `docs/rca/`; an operational
playbook → `docs/runbooks/`; a living tracker → root `docs/*.md`; a single-issue
design gate → `docs/proposals/design-notes/`.

**Lifecycle:** `Draft → Accepted → Implemented`, plus terminal `Withdrawn` /
`Rejected` / `Superseded`. The SFEP's own `status:` front-matter is the source of
truth, mirrored by the implementing Linear issue's status — never by a GitHub
label.

- **Accepted** only once the design gate is passed (owner approval).
- **Implemented** only once the work clears Stage1 readiness end-to-end and
  self-hosts. **"Parsed but not enforced" stays `Accepted`.**
- Never advance a status without bumping `updated:` and the registry row in
  `docs/proposals/README.md`.

**Linking.** The SFEP is the durable *why*; the issue is the session-sized
*what*. An implementing issue cites `Design: SFEP-NNNN` rather than duplicating
the design, and the SFEP's `tracking:` front-matter lists the issues. SFEPs are
Markdown — not subject to `sfn fmt` or the self-host gate.
