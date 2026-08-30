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
| Module-private helpers | leading underscore | `_count_newlines`, `_host_is_windows` |
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

- **Cite issues, SFEPs, and RCAs**: `SFN-142`, `SFEP-0027`,
  `docs/rca/...`. These are stable and searchable.
- **Tracked work is Linear-native** (`SFN-NNN`). A bare `#NNN` names a GitHub
  PR or an external-contributor intake issue. Those are durable *history* —
  `(#2711)` as provenance for a decision is fine — but they are not the board,
  so a reader cannot pick one up. Never state a **removal condition** in terms
  of a bare `#NNN`; a workaround whose expiry names a tracker nobody works is a
  workaround that never gets removed.
- **Never write "this commit", "this PR", "this change"** — the reader cannot
  see your diff. `// Phase E (this commit) adds cross-module resolution` reads
  as a PR description that escaped into the tree. Say what the code does now
  and cite the issue for the history.
- **No `TODO`/`FIXME`/`HACK` markers.** The repository convention is
  cite-the-issue: file a Linear issue and reference it —
  `// Fallback until SFN-441 lands proper slice reuse.` An issue is triaged,
  estimated, and visible on the board; a `TODO` is where work goes to die.

### Workaround comments carry their expiry

A comment marking a temporary workaround (seed miscompilation pads,
compatibility shims) must state the **concrete removal condition**, and the PR
that satisfies the condition **must delete both the workaround and the
comment**:

```sfn
// Seed workaround (SFN-998): the pinned seed folds this allocation away.
// Remove when bootstrap.toml [seed].version contains SFN-998's compiler fix.
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
  (`compiler/capsules/analyzer/src/effect_taxonomy.sfn::canonical_effects()`:
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
   and rendered, not thrown. Core passes (`typecheck/`,
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

**Error codes** are `Exxxx` strings with range ownership (Home paths are
relative to `compiler/src/`):

| Range | Domain | Home |
|---|---|---|
| `E00xx` | Names / generic resolution; unresolved primitive-receiver method call (`E0012`, SFN-385); unresolved type annotation (`E0013`, SFN-555); unresolved value identifier (`E0014`, SFN-675); unresolvable field access on a proven struct or primitive receiver (`E0015`, SFN-543) | `typecheck*.sfn` |
| `E03xx` | Duplicate symbols / type conflicts; mixed `int`/`float` arithmetic operand reject (`E0306`, SFN-385); array/struct arithmetic rejects (`E0307`/`E0308`, SFN-562/SFN-584); proven primitive mismatch (`E0309`, SFN-675) | `typecheck*.sfn` |
| `E04xx` | Effect violations (`E0404` unrecognized effect root, SFEP-0017); workspace capability-envelope policy (`E0405` member declared-effect drift, `E0406` malformed `[workspace.capabilities]` envelope entry, SFEP-0051/SFN-416); value resolution (`E0420` undefined free-function callee, SFN-544; `E0422` void call in value position, `E0423` call arity mismatch, SFN-812); import resolution, relative and capsule specs (`E0430` cannot find module, `E0431` symbol not defined in closure, #1953, SFN-686) | `diagnostics_render.sfn`, `effect_checker.sfn`, `typecheck_types.sfn`, `typecheck/call_signature.sfn`, `capsule_resolver.sfn` |
| `E05xx`–`E06xx` | Build / check tooling; parse diagnostics `E0500` (unrecognized top-level construct), `E0501` (malformed function parameter list), `E0502` (missing variable initializer), `E0503` (missing struct field type); capsule distribution (`E0612` capsule marked unpublishable, SFEP-0002 §3.7 / SFN-714; `E0613` private capsule resolved from a fetched origin, SFEP-0020 §3.6 / SFN-715); `E0614` (`sfn build --target=<triple>` value outside the closed set, SFEP-0068 §3.1 / SFN-774); `E0615` (archive member rejected or archive malformed during toolchain extraction — the CLI-consumer mapping of `sfn/archive`'s `ArchiveError`, SFEP-0071 §3.6 / SFN-753, emitted by `toolchain.sfn` at the `sfn toolchain install` extraction boundary); `E0616` (home directory unresolvable — `HOME`, `USERPROFILE`, and `HOMEDRIVE`+`HOMEPATH` all unset/empty, SFN-856); `E0617` (`sfn emit --target=<triple>` resolved a different triple than requested — a future-precedence guard, SFN-923); `E0618` (installed toolchain entry is corrupt — its recorded install-manifest payload failed verification, SFEP-0073 §3.8 / SFN-1066); `E0619` (installed toolchain entry is a partial install — the payload was never committed, SFEP-0073 §3.4 / SFN-1066); `E0620` (the selected toolchain is not installed — reported by `sfn toolchain active`, SFEP-0073 §3.4 / SFN-1066) | `tools/check.sfn`, `cli/commands/publish.sfn`, `capsule_resolver/provenance.sfn`, `cli/commands/build.sfn`, `cli/commands/emit.sfn`, `cli/commands/login.sfn`, `cli/commands/config.sfn`, `cli/commands/add.sfn`, `cli/commands/toolchain.sfn`, `toolchain/inspect.sfn` |
| `E07xx` | Decorator resolution (SFEP-0023): `E0701` (imported symbol is not a decorator), `E0702` (unknown decorator — not imported, not a built-in) | `decorator_resolver.sfn` |
| `E08xx` | `Result` / `?` operator; extern C-ABI (`E0801`–`E0805`); bare function-type annotation reject (`E0826`); malformed array type spelling reject (`E0830`, SFN-385); interpolation operand not stringifiable (`E0832`, lowering-stage `[fatal]`, SFN-408); uninferable generic-struct static constructor reject (`E0833`, SFN-404); value-position `if` reject (`E0834`, SFN-442); character-literal reject (`E0835`, SFN-442); `Task<T>[]` heterogeneous handle push reject (`E0836`, SFN-441 / SFEP-0055); `Task<T>` double-await / use-after-move (`E0837`, SFN-446); Task or Channel handle nursery escape (`E0838`, SFN-446/SFN-694); named-function value type/effect mismatch (`E0839`, SFN-667); non-pointer-width named-function value ABI (`E0840`, SFN-667); `?`-desugar `value` shadowing (`E0841`, SFN-901); `spawn` target not a zero-argument named function or `fn` literal (`E0842`, SFN-1006) | `typecheck_types.sfn`, `ownership_checker.sfn`, `llvm/expression_lowering/native/core_strings.sfn` |
| `E09xx` | Ownership / affine types | `ownership_checker.sfn` |
| `E10xx` | Lowering / backend (`E1001` unsafe import-symbol mangling, SFN-530; `E1002` fabricated default value, SFN-527; `E1003` dropped or unsupported instruction, SFN-528; `E1004` invalid range-`for`, SFN-533; `E1005` malformed native-IR layout, SFN-532; `E1006` backend invariant failure; `E1007` call resolution/emission; `E1008` runtime dispatch/allocation; `E1009` ABI/coercion; `E1010` concurrency lowering; `E1011` illegal routine escape; `E1012` literal/lambda lowering; `E1013` stringification; `E1014` diagnostic retention under a size guard — the `error`-severity elision note and the `warning`-severity oversized-batch summary, on both the legacy string channel and its structured twin, SFN-529/SFN-540; `E1015` unsupported statement variant, `E1016` decorators on `routine` blocks unsupported, `E1017` `?` operator in an unsupported position, `E1018` native layout pointer-fallback, covering every unsupported/missing field-type case — all four `note`-severity emit-native, SFN-538; `E1019` raw-syscall builtin contract; `E1020` assignment-target store dropped because its value or index did not lower, SFN-812; `E1021` tensor channel: IR verification failure and scalar-oracle invocation-contract failure (input count, input shape/size, missing return value), SFN-537; `E1022` mutable borrow live across a suspension point — `warning` severity, the structured twin of the long-standing untagged `llvm lowering:` advisory, SFN-915; `E1023` match-pattern `field: value` constraint form, rejected in both the enum and union-struct pattern paths because no pass compares the payload against the colon RHS, SFN-1061; `E1024` match arm guard that could not be lowered to a condition, which previously failed open and left the arm matching every value of its pattern, SFN-1168) | `llvm/`, `native_ir_parser_defs.sfn`, `emit_native.sfn`, `emit_native_layout.sfn`, `typecheck_types.sfn`, `capsules/ir/src/tensor_ir_verify.sfn`, `capsules/codegen/src/tensor_ir_lower_scalar.sfn` |
| `E11xx` | Numerical / behavioural contracts; `E1100`–`E1114` allocated (SFEP-0062) | `contract/` |
| `W02xx` | Lint (warning severity, never fails a build): `W0210` (bare assert), `W0211` (decorator deprecation). `W0212` is **retired** — it flagged deprecated `{{ }}` interpolation, removed with the syntax itself (SFEP-0057, SFN-483); do not reuse it | `tools/check.sfn` |

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

The compiler, build driver, and runtime source are Sailfin-native: there is no
C runtime and no Python bootstrap. Platform services remain behind `extern fn`
adapters, and native binaries still lower through LLVM and link via clang plus
the platform linker.
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
// compiler/capsules/syntax/src/parser/mod.sfn
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
  (subprocess driving, shims, env threading) is `docs/conventions/e2e-tests.md`.
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
- **String interpolation**: `${ expr }` is the only interpolation form
  (SFEP-0057); `{{ }}` is literal text, not interpolation.
- **Lambda short form** `fn(x) => expr` is shipped (SFEP-0029) alongside the
  block form `fn(x) -> T { ... }`.
