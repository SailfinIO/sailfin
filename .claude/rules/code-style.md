`docs/style-guide.md` is the single source of truth for coding conventions;
this rule is the always-loaded summary of the parts agents most often get
wrong. When in doubt, read the guide — do not improvise style.

## Comments (the most-violated rules)

- One syntax: `//`. There is no `///` doc-comment form; don't invent one.
- Comments explain **why**, code explains **what**. Never narrate the line
  below a comment.
- **Durable references only**: cite `(#1234)`, `SFEP-NNNN`, or an RCA path.
  Never write "this commit", "this PR", or "this change" — the reader can't
  see your diff. Never transcribe phase/wave/milestone history into file
  headers; link the SFEP or epic instead.
- **No `TODO`/`FIXME`** — file an issue and cite it in the comment.
- **No commented-out code** — delete it; git remembers.
- File header = repo-relative path + 1–5 sentences of purpose. Not a
  changelog, not a rollout plan (>~15 lines means it belongs in an SFEP).
- A workaround comment states its concrete removal condition; the PR that
  satisfies the condition deletes the workaround **and** the comment.

## Naming

- `snake_case` functions/locals/files; `PascalCase` types and enum variants;
  `_underscore` prefix for module-private helpers (with a module tag in big
  files: `_cr_*`); `SCREAMING_SNAKE_CASE` module-level constants.
- Treat acronyms as words in new names: `LlvmOperand`, not `LLVMOperand`.
- Test names: `test "<area>: <behavior>"` — never encode the tier.

## Effects & errors

- Effect lists are **alphabetical**: `![io, net]`, never `![net, io]`
  (matches `effect_taxonomy.sfn::canonical_effects()`).
- User-source errors → `Diagnostic` with an `E0xxx` code and span; core
  passes never `panic()` on user input. New internal fallible code →
  `Result<T, E>` + `?`. E-code ranges are owned — see the table in
  `docs/style-guide.md` and grep the range before allocating a code.

## Shape

- `let` by default, `let mut` only when reassigned. Early returns over
  nesting. Guard counters on input-driven loops.
- ~1,500-line soft budget per `compiler/src` module; split into a folder +
  `mod.sfn` (parser/ is the model). Don't grow grandfathered giants.
