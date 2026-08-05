---
name: sailfin-pickup
description: Pick up a ready Sailfin Linear or GitHub issue and drive it through branch creation, implementation, verification, and PR handoff.
---

# Sailfin Pickup Skill

Use this skill when asked to pick up an issue, work the next task, or drive an issue to completion.

## Select and claim

- `SFN-123` selects that Linear issue. A bare number selects that GitHub issue and its Linear mirror when one exists.
- Claim the issue in Linear, assign it to the active user, and create branch `gemini/sfn-123-<slug>` (or `gemini/<slug>` for non-issue work).

## Execute

- Read the complete issue, cited SFEP, and design notes.
- Implement the smallest cohesive change that satisfies the acceptance criteria.
- Follow code style guidelines in `docs/style-guide.md` and rules in `AGENTS.md` / `GEMINI.md`.
- Run formatting: `sfn fmt --write <files>` and verify `sfn fmt --check <files>`.
- Self-host if compiler files were modified: `make compile`.
- Run targeted tests: `build/bin/sfn test <path> [-k <name>]`.

## Verify and Handoff

- Verify all acceptance criteria.
- Commit changes using conventional commit format (`feat(compiler): ...`, `fix(runtime): ...`).
- Open a PR citing `Fixes SFN-123` (or `Closes #N`).
- Update status in `docs/status.md` if behavior or feature readiness changed.
