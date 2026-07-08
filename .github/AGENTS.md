# Retired GitHub Agentic Workflows

Sailfin no longer runs GitHub Agentic Workflows (`gh-aw`) from this
repository. The former `.github/workflows/*.md` sources and generated
`*.lock.yml` files were removed because the issue/PR automation had been
cost-paused since 2026-05-08, and the remaining release-notes workflow
duplicated `gh release create --generate-notes` while relying on an
unsupported release-comment safe output.

Current automation under `.github/workflows/` is plain GitHub Actions unless a
future file explicitly says otherwise. Do not regenerate gh-aw lockfiles or
reintroduce gh-aw workflow sources without a new design decision.

For issue execution, use Linear plus the repo-local Codex/Claude workflows:

- groom and prioritize work in Linear — workflow status (Triage → Backlog →
  Ready → In Progress → In Review → Done, plus native blocked-by relations),
  priority, and estimate are Linear-native fields, not GitHub labels;
- the `claude-ready`, `in-progress`, and `blocked` labels are retired;
  `needs-grooming` and `needs-design` survive only as public triage hints on
  GitHub intake, not as workflow state;
- external GitHub issues mirror into the Linear SFN team's Triage for
  maintainers to classify and groom;
- use the repository prompts and skills under `.codex/` and `.claude/` for
  interactive pickup and implementation against Linear `Ready` work, and for
  PR handoff.
