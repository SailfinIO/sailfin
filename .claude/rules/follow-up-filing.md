# Follow-up filing: an issue costs more to dispose of than to write

A session working `SFN-<N>` files a **new issue** only when it clears the bar
below. Filing takes a session thirty seconds; disposing of the result takes a
human triage decision, a grooming pass, a session, and a CI run against a pool
sized for one PR at a time (`pr-discipline.md`). Measured 2026-09-02: >250
issues opened against ~165 closed in 14 days; 100 of the 250 most-recent
`Backlog` items under two weeks old; 21 of 25 `Triage` items with no priority —
nearly all of it agent-filed follow-ups from sessions that each opened one to
three. Arrivals outran service, so the queue grew regardless of effort.
Design record: `docs/conventions/linear-workflow.md` § Follow-up filing.

## The bar

File a new issue only if **at least one** holds:

1. **A defect the PR introduced or exposed, with a reproducer** — a failing
   test, a command plus its output, or a miscompiled snippet. "Might be wrong"
   is a comment, not an issue.
2. **Urgent or High** on the Linear scale (`docs/conventions/linear-templates.md`
   § Fields): a release/self-host/seed blocker, a soundness hole (a check that
   fails open), a critical-path break.
3. **A prerequisite the current issue cannot land without** — and then
   `seed-dependency.md` decides bundle-vs-split *first*; the default is bundle,
   which files nothing.

Everything else — a refactor noticed in passing, tech-debt, a naming nit, a
stale comment, "this could be faster", a test that could be tighter — is a
**comment on the issue you are working**, under a `Noticed in passing` heading,
one line each with a file path. It stays searchable and attached to the context
that found it, and it costs nobody a decision. A later session that actually
needs it files it then, with the reproducer it has by that point.

## Where it lands

- **Never `Triage`.** `Triage` answers "should this exist at all?"; a session
  that files an issue has already answered yes. An agent-filed issue lands in
  **`Backlog`** carrying `type:*` + `area:*` labels, a priority, the parent's
  Project, a `related to SFN-<N>` relation, and `Spawned from SFN-<N>` as the
  first line of the body. **No priority means no issue.**
- **One root cause, one issue.** Three symptoms of one defect are one issue with
  a checklist, not three. Before filing, search the parent's existing
  follow-ups and `Backlog` for a sibling — same file, same subsystem, same
  session — and add to it instead. A sibling set is one session and one CI run;
  three issues are three of each.
- **At most two per PR.** A session that wants a third has found an epic or is
  fixing the wrong thing. Stop and say so in the PR summary instead of filing.

## Disposal floor

`/triage age` proposes KILL for any `Backlog` issue at priority Medium or Low
with no Project and no activity for 45 days. Canceling with a one-line reason
does not lose it — Linear search still finds it — but a 300-item backlog loses
everything in it. A human confirms every terminal state; the floor only makes
the proposal standing rather than a fresh judgment each time.
