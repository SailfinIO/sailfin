`docs/style-guide.md` is the source of truth for coding conventions. This is the
always-loaded summary of the parts most often got wrong.

**Comments.** One syntax: `//` — there is no `///` doc-comment form. Comments
explain *why*; never narrate the line below. Cite only durable references
(`(#1234)`, `SFEP-NNNN`, an RCA path) — never "this commit"/"this PR", which the
reader cannot see. No `TODO`/`FIXME` (file an issue and cite it), no
commented-out code. A workaround comment states its concrete removal condition,
and the PR that satisfies it deletes both.

**Naming.** `snake_case` functions/locals/files; `PascalCase` types and enum
variants; `_underscore` module-private helpers; `SCREAMING_SNAKE_CASE` constants.
Acronyms are words: `LlvmOperand`, not `LLVMOperand`. Tests are
`test "<area>: <behavior>"` — never encode the tier in the name.

**Effects & errors.** Effect lists are alphabetical: `![io, net]`, never
`![net, io]`. User-source errors are a `Diagnostic` with an `E0xxx` code and
span — core passes never `panic()` on user input. New internal fallible code
returns `Result<T, E>` + `?`. E-code ranges are owned; grep the range in
`docs/style-guide.md` before allocating one.

**Shape.** `let` by default, `let mut` only when reassigned. Early returns over
nesting. Guard counters on input-driven loops. ~1,500-line soft budget per
`compiler/src` module — split into a folder + `mod.sfn` (`parser/` is the model)
rather than growing a grandfathered giant.
