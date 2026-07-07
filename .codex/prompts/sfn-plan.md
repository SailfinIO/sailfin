# Codex Sailfin Planning Prompt

Use this prompt in Codex web or CLI when you want to audit and reorganize
Sailfin Linear Initiatives, Projects, Cycles, priorities, or issue queues.

```text
Use $sfn-plan to audit Sailfin Linear planning state and propose the next
maintenance batch.

Required workflow:
1. Read .codex/skills/sfn-plan/SKILL.md plus the repo convention files it names.
2. Query live Linear state for the Sailfin (SFN) team: Initiatives, Projects,
   Cycles, statuses, labels, and open issues.
3. Ground recommendations in the long-term goal: a production-ready,
   high-performance Sailfin compiler/runtime. Do not use site roadmap files as
   planning source of truth.
4. Review Triage/To triage, Todo, Backlog, Ready, Blocked, unprojected, and
   release-scoped issues. Flag missing Project, priority, estimate, Cycle,
   blocker, design, status, or technical evidence fields.
5. Propose Project/Initiative fixes, session-sized leaf issues, priority and
   estimate fills, status moves, unblock candidates, and release Cycle
   assignments.
6. Wait for my explicit approval before applying bulk Linear writes.
7. After approval, apply changes in small logical batches and report each issue
   changed with old/new field values.

Do not create Linear labels for status, priority, estimate, release/cycle,
blockers, assignee, or Project membership.
```
