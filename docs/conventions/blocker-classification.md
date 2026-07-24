# Blocker classification: hard vs prose

The rule `/sweep` (Phase 2) and `/triage` (Phase 3 → UNBLOCK) share for deciding
whether a `Blocked` Linear issue may be flipped to `Ready`. It lives here so the
two commands cite one definition instead of mirroring edits between them.

Read the issue's blocked-by relations (`get_issue includeRelations=true`) and any
`## Blocked by` prose in the body, then classify each blocker:

- **Hard reference** — a Linear blocked-by relation, or an explicit `SFN-N` /
  `#N`. Closed means resolved; open means still blocking. An agent can verify
  this mechanically.
- **Prose reference** — "Slice E", "the M4 runtime port", "a fresh seed cut". An
  agent cannot decide when prose is satisfied, so its **presence** blocks the
  flip regardless of what else is resolved.

**Flip to `Ready` only when every hard reference is closed AND no prose gate
remains.** Never auto-flip on prose alone. When flipping, drop the resolved
relations in the same call:

```
mcp__Linear__save_issue id="SFN-<N>" state="Ready" removeBlockedBy=["SFN-<resolved>"]
```

and leave a comment naming the blockers that cleared.

If a just-unblocked issue is still incomplete against the issue contract, fold it
through the grooming guard rather than landing it in `Ready` half-baked.
