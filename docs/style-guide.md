# Sailfin Style & Layout Guide

This guide is the **single source of truth** for coding conventions in this
repository: naming, comments, effect annotations, error handling, file
organization, and where new work should land. Other documents
(`CONTRIBUTING.md`, `AGENTS.md`, `.github/copilot-instructions.md`,
`.claude/rules/code-style.md`) link here rather than restating rules — if a
pointer disagrees with this guide, this guide wins.

Sailfin's design principle is **boring syntax wins**, and the same applies to
style: where Go or Rust already settled a convention and nothing about Sailfin
demands otherwise, we adopt the settled answer. Contributors — human and agent
alike — should never have to guess.

Two layers of authority:

1. **`sfn fmt` decides mechanics.** Indentation, brace placement, spacing,
   blank lines, import sorting. Never hand-tune these (see below).
2. **This guide decides everything the formatter can't.** Naming, comment
   content, effect ordering, error-handling idiom, decomposition.

## Code Formatting

All `.sfn` files are formatted with `sfn fmt`; CI enforces this on every pull
request. There is one canonical style with **no configuration**.

```bash
sfn fmt --write compiler/src/   # format files in place
sfn fmt --check compiler/src/   # verify formatting (CI mode)
```

The formatter owns (see SFEP-0007, `docs/proposals/0007-fmt-architecture.md`,
for the full rule set): 4-space indentation, K&R braces, operator/punctuation
spacing, blank-line normalization, import grouping and alphabetization,
trailing whitespace, and EOF newline. It deliberately does **not** wrap long
expressions, reorder match arms, or touch comment content — those stay the
author's responsibility, governed by this guide.

Do not manually adjust anything the formatter owns. If you disagree with its
output, file an issue against the formatter rather than overriding it.

## Naming

| Item | Convention | Example |
|---|---|---|
| Functions | `snake_case` | `parse_program`, `collect_direct_function_effects` |
| Types (struct/enum/interface) | `PascalCase` | `Program`, `SourceSpan`, `EffectViolation` |
| Enum variants | `PascalCase` | `Identifier`, `NumberLiteral`, `TryOperator` |
| Module-private helpers | leading underscore | `_count_newlines`, `_sfn_bin` |
| Module-level constants | `SCREAMING_SNAKE_CASE` | `let STDOUT_FD: i32 = 1;` |
| Locals and parameters | `snake_case` | `let mut entries: Entry[] = [];` |
| Files | `snake_case.sfn` | `effect_checker.sfn` |
| Effects | lowercase, alphabetical in `![...]` | `![clock, io]` |
| Test names | `"<area>: <behavior>"` | `test "publish: too many args shows usage"` |

Additional rules:

- **Private means underscore.** A function or module-level value not exported
  from the file gets a leading underscore. In large modules, add a short
  module tag to avoid collisions across the flattened import namespace:
  `_cr_*` in `capsule_resolver.sfn`, `_dj_*` in `diagnostics_json.sfn`.
- **Treat acronyms as words** in new PascalCase names: `LlvmOperand`,
  `JsonEvent`, `CliContext` — not `LLVMOperand` or `JSONEvent`. (Existing
  all-caps names are grandfathered; do not rename them in unrelated PRs.)
- **Booleans read as predicates.** Prefer `is_`, `has_`, `needs_` prefixes for
  boolean-returning functions and boolean fields (`is_effectful`,
  `has_explicit_return`).
- **Type parameters** are single capital letters, `T` first, `E` for error
  types — matching `Result<T, E>`. (Generic constraints are still landing;
  this is the convention for the surface that exists.)

## Comments

Sailfin has one comment syntax: `//`. There is no `///` doc-comment form,
and block comments (`/* */`) are not used — write `//` line comments
exclusively.

The prime directive, borrowed from Go and Rust practice: **comments explain
*why*, code explains *what*.** A comment that restates the line below it is
noise; a comment that explains a non-obvious invariant, a subtle ordering
constraint, or the reason a simpler approach fails is gold.

### File headers

Every `.sfn` file opens with a header docblock:

```sfn
// compiler/src/effect_checker.sfn
//
// Effect validation for the Sailfin self-hosted compiler. Scans routine
// bodies for constructs that require explicit `![effect]` declarations.
```

- First line: the repo-relative path.
- Then 1–5 sentences: what the module does and, if non-obvious, why it exists
  as a separate module.
- **No changelog.** Phase histories ("Phase E adds…"), milestone codes,
  rollout plans, and wave-by-wave migration narratives do **not** belong in
  the header. That history lives in git, in the issue tracker, and in SFEPs —
  link the SFEP or epic (`See SFEP-0026 / #1639.`) instead of transcribing it.
  A header that needs more than ~15 lines is a design document trying to
  escape; move it to `docs/proposals/` and cite it.

### Public API comments

A `//` block immediately above an exported function, struct, or enum is its
documentation. Start with a complete sentence naming the item's behavior
(Go style):

```sfn
// parse_program lexes and parses `source` into a Program AST. Diagnostics
// are accumulated on the returned Program rather than raised.
fn parse_program(source: string) -> Program ![io] { ... }
```

Field-level rationale comments inside structs (see `ast.sfn`'s `Capture`
fields) are encouraged **when the field encodes a non-obvious invariant** —
that is exactly the *why* comments are for.

### Durable references only

Comments must make sense to a reader with no knowledge of the diff that
introduced them:

- **Cite issues, SFEPs, and RCAs**: `(#1234)`, `SFEP-0027`,
  `docs/rca/...`. These are stable and searchable.
- **Never write "this commit", "this PR", "this change"** — the reader cannot
  see your diff. `// Phase E (this commit) adds cross-module resolution` reads
  as a PR description that escaped into the tree. Say what the code does now
  and cite the issue for the history.
- **No `TODO`/`FIXME`/`HACK` markers.** The repository convention is
  cite-the-issue: file a GitHub issue and reference it —
  `// Fallback until #1441 lands proper slice reuse.` An issue is triaged,
  labeled, and visible on the board; a `TODO` is where work goes to die.

### Workaround comments carry their expiry

A comment marking a temporary workaround (seed miscompilation pads,
compatibility shims) must state the **concrete removal condition**, and the PR
that satisfies the condition **must delete both the workaround and the
comment**:

```sfn
// Seed workaround (#998): 0.5.7 folds this allocation away. Remove when
// bootstrap.toml [seed].version reaches >= 0.5.8.
```

If you bump the seed or complete a migration, grep for comments citing the
thing you just retired — a workaround comment that outlives its expiry is a
bug in the comment. (Reviewers: treat a stale expiry the same as a failing
test.)

### No commented-out code

Delete it. Git remembers. Commented-out code is ambiguous (is it coming back?
was it broken?) and rots silently. The only exception is a short illustrative
snippet inside a *why* comment (e.g. the worked desugaring example in
`emit_native_desugar_try.sfn`), which is prose, not parked code.

### Section banners

`// ==== Section Name ====` banners are fine for navigating large files
(see `llvm/types.sfn`) — use them to group, not to decorate. If a file needs
more than a handful of sections, that is usually a signal to split it (see
File Size below).

### Density heuristic

If the prose above a function is longer than the function, ask whether it is
documenting an invariant (keep it) or narrating history/design (move it to an
SFEP or design note and cite it). Files at >40% comment density are almost
always carrying design documents in disguise.

## Effect Annotations

- **Spell effects explicitly**: `fn fetch(id: Id) -> Order ![io, net]`.
- **Order effect lists alphabetically.** This matches the canonical taxonomy
  order the compiler itself uses for rendered diagnostics
  (`compiler/src/effect_taxonomy.sfn::canonical_effects()`:
  `clock, gpu, io, model, net, rand`). Write `![io, net]`, not `![net, io]`.
  Alphabetical is deterministic and needs no judgment call — the previous
  "most impactful first" rule required one, and practice diverged.
- **Declare what the body needs, transitively.** If a helper calls an
  effectful function, the helper declares the effect and so do its callers.
  Do not add speculative effects a body doesn't use.
- The canonical effect set is `clock`, `gpu`, `io`, `model`, `net`, `rand`.
  The `pure` and `unsafe` markers seen in a few signatures are **not** part of
  the locked taxonomy; treat them as provisional and do not spread them to new
  code without a design ruling (file an issue if you need one).

## Error Handling & Diagnostics

Three tiers, by audience:

1. **User-source errors → diagnostics, never panics.** Errors in the program
   being compiled are reported as structured `Diagnostic` records with an
   error code, a source span, and (where possible) a fix-it hint — collected
   and rendered, not thrown. Core passes (`typecheck.sfn`,
   `effect_checker.sfn`, lowering) must not `panic()` or bare-`assert` on user
   input: a compiler crash on bad input is a compiler bug.
2. **Internal fallible operations → `Result<T, E>` + `?`.** For new code,
   fallible internal operations (I/O, resolution, parsing of tool output)
   should return `Result` and propagate with `?` (SFEP-0012). Adoption in
   older modules is incremental — match the module you're in, but prefer
   `Result` when adding new fallible surface.
3. **Impossible states → make them unrepresentable first.** Reach for a
   guard + diagnostic over an assertion; the compiler must degrade to an
   error message, not a crash.

**Error codes** are `E0xxx` strings with range ownership (Home paths are
relative to `compiler/src/`):

| Range | Domain | Home |
|---|---|---|
| `E00xx` | Names / generic resolution; unresolved primitive-receiver method call (`E0012`, SFN-385) | `typecheck_types.sfn` |
| `E03xx` | Duplicate symbols / type conflicts; mixed `int`/`float` arithmetic operand reject (`E0306`, SFN-385) | `typecheck*.sfn` |
| `E04xx` | Effect violations (`E0404` unrecognized effect root, SFEP-0017); workspace capability-envelope policy (`E0405` member declared-effect drift, `E0406` malformed `[workspace.capabilities]` envelope entry, SFEP-0051/SFN-416); relative-import resolution (`E0430` cannot find module, `E0431` symbol not defined in closure, #1953) | `diagnostics_render.sfn`, `effect_checker.sfn`, `typecheck_types.sfn`, `capsule_resolver.sfn` |
| `E05xx`–`E06xx` | Build / check tooling; parse diagnostics `E0500` (unrecognized top-level construct), `E0501` (malformed function parameter list), `E0502` (missing variable initializer), `E0503` (missing struct field type) | `tools/check.sfn` |
| `E07xx` | Decorator resolution (SFEP-0023): `E0701` (imported symbol is not a decorator), `E0702` (unknown decorator — not imported, not a built-in) | `decorator_resolver.sfn` |
| `E08xx` | `Result` / `?` operator; extern C-ABI (`E0801`–`E0805`); bare function-type annotation reject (`E0826`); malformed array type spelling reject (`E0830`, SFN-385); interpolation operand not stringifiable (`E0832`, lowering-stage `[fatal]`, SFN-408); uninferable generic-struct static constructor reject (`E0833`, SFN-404); `Task<T>` double-await / use-after-move (`E0834`, reserved, planned SFN-446) and nursery-escape (`E0835`, reserved, planned SFN-446); `Task<T>[]` heterogeneous handle push reject (`E0836`, SFN-441 / SFEP-0055) | `typecheck_types.sfn`, `llvm/expression_lowering/native/core_strings.sfn` |
| `E09xx` | Ownership / affine types | `ownership_checker.sfn` |

New codes go in the matching range at the next free number; grep the range
before allocating. Do not reuse a retired code.

## Immutability & Control Flow

- **Immutable by default.** `let` unless the binding is reassigned; `let mut`
  only when it is. Do not pre-declare `mut` "just in case".
- **Early returns over nesting.** Stack guard clauses
  (`if bad { return ...; }` / `continue`) at the top; keep the happy path at
  the lowest indentation.
- **Guard counters on unbounded loops.** Loops whose termination depends on
  input structure carry a guard counter that breaks with a loud error rather
  than hanging (see `lexer.sfn`'s `guard`/`max_guard` idiom). A hung compiler
  is worse than a failed one.

## Repository Layout (Current)

```
sailfin/
├─ compiler/
│  ├─ capsule.toml               # version source of truth + manifest
│  ├─ src/                       # self-hosted compiler sources (.sfn)
│  │  ├─ main.sfn                # compiler entry point
│  │  ├─ lexer.sfn
│  │  ├─ parser/                 # parser domain (mod.sfn = public API)
│  │  ├─ llvm/                   # native backend lowering
│  │  │  ├─ mod.sfn
│  │  │  ├─ lowering/
│  │  │  └─ expression_lowering/
│  │  ├─ cli/commands/           # one file per CLI subcommand
│  │  └─ ...                     # typecheck, effects, emitters, utilities
│  └─ tests/
│     ├─ unit/
│     ├─ integration/
│     └─ e2e/
├─ runtime/
│  ├─ prelude.sfn                # Sailfin-visible runtime surface
│  ├─ sfn/                       # Sailfin-native runtime modules
│  └─ ir/                        # runtime IR support
├─ docs/
├─ examples/
├─ scripts/
└─ tools/
```

The toolchain is pure Sailfin: there is no C runtime and no Python bootstrap.
If a subsystem grows large, give it its own folder under `compiler/src/` with
a `mod.sfn` and keep cross-module imports going through that `mod.sfn`.

## File Naming Conventions

- Use `snake_case` for filenames and keep them short but descriptive.
- Prefer name + role suffixes that match existing usage:
  - `*_utils.sfn` for helpers (`string_utils.sfn`, `token_utils.sfn`)
  - `*_checker.sfn` for validators (`effect_checker.sfn`)
  - `*_lowering.sfn` for lowering passes (`core_ops_lowering.sfn`)
  - `*_ir.sfn` for IR definitions (`native_ir.sfn`)
  - `*_semantics.sfn` for semantic interpretation (`decorator_semantics.sfn`)
- In multi-file domains, use neutral names like `types.sfn`, `utils.sfn`,
  `expressions.sfn`, and keep the public entry point as `mod.sfn`.
- Test files use the `_test.sfn` suffix and live under the matching test tier.

## File Size & Splitting

Large files are a **memory and build-parallelism cost**, not just a
readability one: per-module working set bounds what `--jobs` can parallelize
(SFEP-0027). `compiler/src/cli_main.sfn` carries a hard 1,500-line regression
budget (`compiler/tests/unit/cli_main_line_budget_test.sfn`).

- Treat **~1,500 lines as the soft budget** for any `compiler/src` module.
  Approaching it, split by concern into a folder with a `mod.sfn` — the
  parser (`parser/{mod,types,expressions,statements,declarations}.sfn`) and
  LLVM lowering trees are the models.
- Existing oversized files (`capsule_resolver.sfn`) are grandfathered — do not
  grow them further; carve pieces out when you touch them substantially.
- Keep public exports near the top of a file; helpers follow below, grouped
  in small sections where it improves scanability.
- Private helpers stay in the file that uses them. Hoist to a shared
  `*_utils.sfn` only when a second module genuinely needs them.

## Module APIs (`mod.sfn`) & Imports

Use `mod.sfn` to re-export the public API of a folder:

```sfn
// compiler/src/parser/mod.sfn
export { parse_declaration } from "./declarations";
export { parse_expression } from "./expressions";
```

- Use relative imports within a folder (`./utils`, `./types`).
- When crossing a domain boundary (e.g. `parser` → `llvm`), import from that
  folder's `mod.sfn` rather than internal files — so internals can move
  freely.
- **But prefer leaf imports over barrels when pulling one or two names**:
  barrel imports are eager and inflate the compile graph. The full rule (and
  the regression that motivated it) is
  [`docs/conventions/barrel-imports.md`](conventions/barrel-imports.md).

## Tests

- Mirror `compiler/src/` paths under `compiler/tests/`; use the `unit/`,
  `integration/`, `e2e/` tiers.
- Test names are `test "<area>: <behavior>" { ... }` — don't encode the tier
  in the name; the folder already says it. Full conventions:
  `compiler/tests/README.md`.
- Unit tests must watch their import closure — importing a "heavy" module
  drags in ~130 modules. See
  [`docs/conventions/unit-test-import-envelope.md`](conventions/unit-test-import-envelope.md).
- E2E tests are Sailfin (`*_test.sfn`), never bash — the pattern catalog
  (subprocess driving, shims, env threading) is `.claude/rules/no-bash-e2e.md`.
- Bare `assert <expr>;` is the house style inside tests; the `expect_*`
  matchers from `sfn/test` are for `![pure]` tests only.
- Keep large fixtures under `compiler/tests/**/data` or `fixtures/`; keep test
  files focused on assertions.

## Documentation Alignment

- Update `docs/status.md` first whenever behavior changes.
- Follow up with the language spec
  (`site/src/content/docs/docs/reference/spec/` for shipped features,
  `.../reference/preview/` for planned) and the
  [roadmap](https://sailfin.dev/roadmap) as needed.
- Record non-trivial designs as SFEPs under `docs/proposals/`
  (`.claude/rules/proposals.md` has the always-loaded summary).
- Narrow, single-topic conventions (usually born from an incident) live under
  `docs/conventions/`; broad, always-relevant style lives **here**. Don't
  create a second general style document.

## Sailfin Language Style — Syntax Reform (Pre-1.0)

The active reforms, for code you write today (rationale:
`docs/proposals/0005-colon-type-annotations.md` and the roadmap):

- **Type annotations use `:`** for parameters, variables, and struct fields;
  return types use `->`. The parser still accepts `->` in annotation positions
  for compatibility, but new code uses `:` exclusively.

  ```sfn
  fn add(x: int, y: int) -> int { return x + y; }
  let name: string = "Sailfin";
  ```

- **Numeric types**: `int` (i64) and `float` (f64) are shipped; `number` is an
  alias for `float`. Use `int`/`float` in new code.
- **String interpolation** is currently `{{ expr }}`; it will become
  `${ expr }` before 1.0 — keep `{{ }}` until the parser change lands.
- **Lambda short form** `fn(x) => expr` is shipped (SFEP-0029) alongside the
  block form `fn(x) -> T { ... }`.
