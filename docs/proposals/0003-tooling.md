---
sfep: 3
title: The Toolchain Surface and Its Output Contracts
status: Accepted
type: tooling
created: 2026-04-14
updated: 2026-08-05
author: "Core Team (original sketch); agent:Sailbot (2026-08 rewrite); human review"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0003 — The Toolchain Surface and Its Output Contracts

> **Amendment (2026-08-05) — reframed around the shipped surface; `sfn vet`
> retracted as a command; per-tool designs ceded to their owners.** This SFEP was
> one of the original architecture sketches folded into the SFEP system at its
> founding (#1652) and was never edited afterwards. Four things had gone wrong.
> First, its inventory was falsified in both directions: `sfn bench` shipped
> (listed here as `P3 / Post-1.0`), while `sfn vet`, `sfn doc`, `sfn fix`, and
> `sfn lsp` are absent from the tree entirely — no file, no dispatch, no stub.
> Second, the prerequisite it declared blocking for three of those four —
> "Diagnostic Infrastructure Enhancement" — has largely shipped under SFEP-0061;
> the blocker it named is discharged. Third, its central architectural question
> ("where does tooling live?") was answered by a mechanism none of its three
> options contemplated ([§3.3](#33-the-host-question-answered-by-a-fourth-option)).
> Fourth, roughly a third of it restated designs that SFEP-0004, SFEP-0007, and
> SFEP-0061 now own, and its schedule vocabulary — a `Ships` column, an "Impact on
> the 1.0 Critical Path" table, a roadmap checkbox slot, and a cost estimate in
> "implementation sessions" — priced work against a release boundary rather than
> naming gates. The body below is a rewrite, not a patch. The legacy prose
> `Status:/Date:/Authors:` header is deleted per SFEP-0001 §3.

## 1. Summary

Sailfin's developer tooling ships as **subcommands of one `sfn` binary**, and the
durable interface each one exposes is not its terminal rendering but a
**versioned, locked, machine-readable output envelope**. Five such envelopes exist
today — `sailfin-check/1`, `sailfin.bench/v1`, `sailfin-symbols/1`,
`sailfin-make/1`, and `sfn build --json`'s `BuildReport` — each guarded by a
schema-lock test that fails CI when its field set drifts. Four of the five also
have a schema document under `docs/reference/`; `BuildReport` does not, which is
the one live violation of the contract [§3.3](#33-the-host-question-answered-by-a-fourth-option)
states.

This SFEP owns two things and cedes the rest. It owns (a) the **inventory** — what
the toolchain surface is, what contract each command exposes, and what is
genuinely absent — and (b) the **cross-cutting design** that no descendant
proposal holds: the envelope pattern itself, the host model for tools, and the
question of where lint lives. Per-tool design belongs to SFEP-0004 (`check`),
SFEP-0007 (`fmt`), SFEP-0061 (diagnostics), SFEP-0006 (`bench`), and SFEP-0014
(agent-legible output); [§3.1](#31-scope-boundary--what-this-sfep-does-not-restate)
makes each cede explicit.

The shipped surface is larger than this document has ever admitted: 22 dispatched
commands in seed 0.9.1, including `fmt`, `check`, `bench`, `symbols`,
`capabilities audit`, and `completion`. Three of those — `symbols`,
`capabilities audit`, `completion` — postdate the original sketch and appear
nowhere in it.

What is absent is a coherent story for **three** gaps, not four.
[§3.5](#35-gap-editor-integration) covers editor integration, whose real gate is
resident incremental analysis that no proposal currently owns — and which SFEP-0004
and this document have until now deferred to each other in a circle.
[§3.6](#36-gap-api-documentation-without-doc-comments) covers API documentation,
which cannot be built as originally designed because the `///` doc-comment syntax
it assumed does not exist and the lexer cannot represent it.
[§3.7](#37-gap-applying-fixes) covers autofix, which is the smallest unblocked
item on the board: the `FixSuggestion`/`TextEdit` machinery already ships and only
an applier is missing. The fourth gap, `sfn vet`, is **retracted** — lint shipped
inside `sfn check` as the `W02xx` range, and the style guide has already codified
that home ([§2.1](#21-retracted-scope--sfn-vet-as-a-command)).

## 2. Motivation

The original motivation — "languages that ship with built-in tooling achieve
faster adoption" — is true and insufficient. It justifies *having* tools without
saying anything about what shape they should take, which is why the sketch it
introduced produced a per-tool design catalogue and a priority column rather than
an architecture.

The sharper motivation comes from the three pillars. Each pillar claims a *proof*:
the compiler derives a complete capability manifest (Reach), the same program
yields the same bits (Result), and this schedule hits these numerics at this
measured throughput (Cost). The externally honest phrasing in
`docs/strategy/decision-brief.md` is "gradeable by a stranger" — and a stranger
does not read our terminal output. **A proof that cannot leave the compiler in a
form someone else's tooling can consume is not a proof; it is a log line.**

That reframes the toolchain surface as the delivery mechanism for all three
pillars rather than as developer convenience:

| Pillar | The tool that carries it | The artifact that leaves the compiler |
|---|---|---|
| Reach | `sfn check` (effect derivation, `E04xx`), `sfn capabilities audit` (SFEP-0051) | `sailfin-check/1` envelope; the required-vs-effective drift table, exit non-zero on drift (`docs/status.md:753`) |
| Result | `sfn check` (numerics contract rejects, `E11xx`, `contract/`, SFEP-0062) | diagnostics with codes and spans a third party can diff |
| Cost | `sfn bench` (SFEP-0006 Stage C5) | `sailfin.bench/v1` envelope; `--budget-time`/`--budget-mem` with **exit 2** on violation — a cost claim that fails CI |

`sfn bench`'s budget flags are the clearest instance. They turn "this is fast" from
a sentence in a README into a gate a stranger can run. That is why the original
`P3 / Post-1.0` classification was not merely stale but backwards: budget
enforcement is load-bearing for the Cost pillar, and it shipped for that reason.

There is a second motivation the sketch stated correctly and then mislocated.
"AI agents are users" is real — Sailfin has no `.sfn` training data, so agents
hallucinate API names, import paths, and signatures. The sketch concluded that an
LSP was therefore the priority. What actually happened is that the
highest-leverage agent surface turned out to be **a locked JSON index, not a
language server**: `sfn symbols --json` (SFN-444) lets an agent answer "does this
symbol exist, and how do I import and call it?" without grepping, and
`tools/mcp-server/` exposes ten commands to agents as pure passthroughs
(`tools/mcp-server/README.md:11-22`). The MCP server got there first, and it got
there *because the envelope existed* — it needs no editor protocol, no resident
process, and no incremental engine. The lesson generalizes into this SFEP's
ordering principle: **lock the envelope; consumers follow.**

### 2.1 Retracted scope — `sfn vet` as a command

The original sketch proposed `sfn vet [--rules ...]` as a separate static
analyzer with sixteen rules across two priority tiers (`0003:244-302`, in the
pre-rewrite text). **The command is retracted.** Two independent lines of
evidence:

**The lint channel already exists inside `sfn check`, and the style guide owns
that decision.** `docs/style-guide.md:230` assigns the `W02xx` range to "Lint
(warning severity, never fails a build)" with home `tools/check.sfn`. Two codes
are populated: `W0210` (bare `assert` in a test, carrying a `FixSuggestion`,
`compiler/src/bare_assert_check.sfn` collected and emitted at
`compiler/src/analyzer.sfn:162`, suppressible with `--allow-bare-assert`) and
`W0211` (deprecated built-in decorator, emitted at `analyzer.sfn:178`, with the
detection helper and rationale at `compiler/src/typecheck/mod.sfn:168-190`).
`W0212` is retired. Two more warnings serve import-context load failures
(`W0001`/`W0002`, `compiler/src/check/engine.sfn:118` and `:132`, with a second
pair at `:531`/`:547`). The range is documented in-tree at
`compiler/src/diagnostics_json.sfn:253`. A separate `vet`
verb would now have to either duplicate `check/engine.sfn`'s staging and
import-context resolution or shell into it, and would split one diagnostic
surface into two for no gain a user can name.

**Most of the proposed rules were never lints.** Nine of the sixteen landed, or
belong, as hard errors in ranges owned elsewhere. Restating them as advisory
`vet` rules would have been a downgrade:

| Proposed `vet` rule | Where it actually belongs | State |
|---|---|---|
| `missing-effect` | `E04xx`, `effect_checker.sfn` | Shipped as an error |
| `capsule-capability-mismatch` | `E0405`/`E0406`, workspace capability envelope (SFEP-0051) | Shipped as an error |
| `effect-escalation` | `E0405` member declared-effect drift; surfaced by `sfn capabilities audit` | Shipped |
| `unchecked-result` | `E08xx`, `Result`/`?` domain (SFEP-0012) | Range owned |
| `borrow-escape` | `E09xx`, `ownership_checker.sfn` (SFEP-0018) | Range owned |
| `match-exhaustiveness` | `docs/proposals/draft-exhaustive-match.md` | Draft |
| `unreachable-match-arm` | `docs/proposals/design-notes/sfn-565-fallthrough-reachability.md` | Design note |
| `dead-code` | Reachability analysis, same home as above | Design note |
| `deprecated-api` | `W0211` pattern, already shipped for decorators | Shipped |

**What survives is the rule backlog, not the command.** Seven rules are genuinely
unhomed advisory lint with no owner: `unused-import`, `unused-variable`,
`unused-parameter`, `empty-block`, `shadowed-builtin`, `redundant-mut`,
`infinite-loop`. Each is a new `W02xx` code in `tools/check.sfn`, filed as an
ordinary issue — none needs a proposal, and none is a prerequisite for anything in
§3. `unused-import` is the highest-value member of the set, because it is the one
whose absence actively degrades the codebase: import lists grow monotonically and
nothing flags the residue.

**Also retracted: the `[vet]` configuration section** in `capsule.toml` (Open
Question 4 in the pre-rewrite text). It presupposed a command that no longer
exists, and per-project suppression of a warning range is a different design
question — whether `sfn check` should accept rule-level suppression at all —
which nothing currently needs.

**Downstream cleanup, performed with this retraction.** Five artifacts presented
`sfn vet` as current direction. All but the last are corrected in the same change
as this rewrite, so no reader is left following a retracted design:

- `docs/proposals/0004-check-architecture.md` — the `sfn vet` design section is
  marked retracted with its original text preserved for provenance; the
  "tomorrow `sfn vet` adds W02xx" prediction at `:1113` is corrected (`check`
  added them); the `sfn vet` row in the Track B consumer table is struck; and the
  `check → {vet, lsp, fix}` fan-out diagram is redrawn to show the lint range
  in-process and the editor branch's real gate.
- `docs/status.md` — the single `| sfn vet / sfn lsp / sfn doc / sfn fix | Planned |`
  row is split into four rows carrying each verb's actual state and gate, with
  `vet` marked **Retracted**.
- `docs/proposals/0002-package-management.md` — the cede row drops `vet` and now
  names the toolchain surface and its envelope contract.
- `docs/proposals/0023-capsule-decorators.md` — the `Related:` citation was
  **inverted** (it credited this SFEP for the deprecated-api lint that SFEP-0023
  itself shipped as `W0211`) and now points at [§3.4](#34-where-lint-lives). It is
  the cleanest confirmation of that section: the single deprecated-api lint that
  exists was delivered by the proposal owning the deprecated construct, not by a
  general-purpose linter.
- `docs/proposals/0009-cli-modularization-epic.md:990-992` proposes a "`sfn vet`
  security audit subcommand." SFEP-0009 is `Superseded` by SFEP-0027, so this
  needs no edit — noted only to prevent it being re-discovered as live intent.
  Its substance shipped as `sfn capabilities audit` (SFEP-0051 Phase 4c).

### 2.2 Retracted scope — schedule and cost vocabulary

The pre-rewrite text priced this work against a release boundary in four places:
a `Ships` column reading `Pre-1.0 / 1.0 / Post-1.0`, a `P0`–`P3` priority column,
a section titled "Impact on the 1.0 Critical Path" mapped to roadmap items 0–6
that no longer exist, a roadmap checkbox slot, and a cost estimate totalling
"~6700-10400 lines across 13-20 sessions" against a "~14,300 lines across 120
files" compiler.

All of it is retracted. 1.0 is a maturity boundary, not a schedule to load work
onto, and every estimate above was falsified — `compiler/src` is now 357 modules,
and the two tools the sketch priced most confidently were delivered by different
proposals than the ones it named. Ordering in this document is expressed the way
SFEP-0002 expresses it: as a **named gate, or the explicit absence of one**
([§3.8](#38-ordering)). Decision-brief §6 holds that "an item with no named gate
is a planning defect"; an item nobody has committed to is recorded here as a known
omission rather than dressed as a schedule.

The roadmap checkbox slot is separately wrong on process grounds: planning state
is Linear-native, and `docs/status.md` is authoritative for what ships (SFEP-0001
§10). An SFEP mirroring a roadmap is guaranteed to drift from both.

## 3. Design

### 3.1 Scope boundary — what this SFEP does *not* restate

Modeled on SFEP-0002 §3.1. Each line is a hard cede; this SFEP cites these rather
than redesigning them. The pre-rewrite text restated the first three at length,
which is the drift mechanism this boundary exists to stop.

| Territory | Owner |
|---|---|
| `sfn check` — passes, tracks, `--json`, incremental design, parse diagnostics | SFEP-0004 (`Implemented`) |
| `sfn fmt` — token-stream formatter, rules, `--check`/`--write` | SFEP-0007 (`Implemented`) |
| The `Diag`/`Span` type, severity model, fix-it structure, migration | SFEP-0061 (`Accepted`) |
| `sfn bench` — command design, budget flags, both modes | SFEP-0006 Stage C5; `sfn/bench` capsule per `docs/status.md:786` |
| Agent-legible build/test output, failure taxonomy, `build/agent-report.json` | SFEP-0014 (`Accepted`) |
| Compiler decomposition into role-oriented capsules; the analyzer boundary | SFEP-0020 (`Accepted`) |
| CLI structure, `Command` tree, subcommand modularization | SFEP-0027 (supersedes SFEP-0009) |
| Test/hook syntax and the `sfn/test` capsule contract | SFEP-0010 |
| Test-artifact caching and suite partitioning | SFEP-0011 |
| Runner performance internals | SFEP-0044 |
| Runner architecture | SFEP-0045 (`Draft`) |
| Harness↔runner IPC | SFEP-0050 |
| Capsule distribution, registry protocol, `publish`/`add`/`lock` | SFEP-0002 |
| Workspace capability envelope, `sfn capabilities audit` | SFEP-0051 |
| `sfn symbols --json` schema and rationale | `docs/proposals/design-notes/sfn-444-symbols-json-index.md` + `docs/reference/symbols-json-schema.md` |

Four corrections to inbound cross-references, all applied in the same change as
this rewrite:

- **SFEP-0004** and **SFEP-0007** each named this document as `Parent:` inside a
  legacy prose `Status:`/`Date:`/`Parent:` header block — the shape SFEP-0001 §3
  says to trim on next edit, and which in SFEP-0007's case read `Status: In
  Progress` beneath a front-matter `status: Implemented`. Both blocks are replaced
  by a dated amendment note that preserves the parent relationship (real, and it
  survives this rewrite) and drops the contradicting status prose.
- **SFEP-0006** stated that "`sfn check`, `sfn doc`, `sfn fix` all depend on the
  in-process driver landing in Stage C" and that "`sfn lsp` specifically benefits
  from the Stage G sub-capsule decomposition." The `sfn check` half is discharged
  — it shipped. The `sfn lsp` half is superseded by SFEP-0020, which made the
  sub-capsules `publish = false`
  ([§3.3](#33-the-host-question-answered-by-a-fourth-option)). Its reference bullet
  now records both, and that `bench` is owned there rather than here.
- **SFEP-0006** owns `sfn bench`, which the pre-rewrite text of this SFEP claimed.
  The claim is withdrawn; `bench` appears in [§3.2](#32-shipped-baseline) as
  inventory, not as this document's design.
- **SFEP-0046** cited this SFEP as "the built-in tooling surface (`sfn
  init/build/run/check/test`)" — the old title, plus distribution commands this
  SFEP cedes to SFEP-0002. Its bullet now names the toolchain surface and splits
  the command list correctly.
- The territory table's "Test-runner architecture and performance" row named
  SFEP-0010, SFEP-0011, SFEP-0044, and SFEP-0045 undifferentiated. SFEP-0010's
  2026-08 rewrite states the actual boundary in its §3.5; this table now mirrors
  it with five rows instead of one, and adds SFEP-0050 (harness↔runner IPC),
  which the old row omitted.

### 3.2 Shipped baseline

Recorded here because the inventory *is* this SFEP's product, and because no other
design document states it whole. `docs/status.md` is authoritative for shipping
status (SFEP-0001 §10); `site/src/content/docs/docs/reference/cli.md` is the
normative user-facing reference for most commands, with `reference/bench.md`
holding `sfn bench` on its own page. This table is the map, with the owning design
named for each entry.

Dispatch is a single `Command` tree in `compiler/src/cli/main.sfn`
(`sailfin_cli_main_v2`; registration at `:237-259`, dispatch arms at `:291-724`).

**Analysis and formatting**

| Command | Impl | Output contract | Design |
|---|---|---|---|
| `sfn check [path...]` | `cli/commands/check.sfn` → `check/engine.sfn::handle_check_command` (579 lines) → `tools/check.sfn` (147) | `sailfin-check/1`, locked; `docs/reference/check-json-schema.md`; exit `0`/`1`/`2` | SFEP-0004 |
| `sfn fmt [path...]` | `cli/commands/fmt.sfn` → `tools/fmt/` (7 modules, ~1,787 lines) + `tools/fmt_rules.sfn` | exit status only (`--check`) | SFEP-0007 |
| `sfn symbols` | `cli/commands/symbols.sfn` | `sailfin-symbols/1`, byte-stable, totally ordered; `docs/reference/symbols-json-schema.md` | design-note SFN-444 |
| `sfn capabilities audit` | `cli/commands/capabilities.sfn` | required-vs-effective table, non-zero on drift | SFEP-0051 Phase 4c |

**Build, run, measure**

| Command | Impl | Output contract | Design |
|---|---|---|---|
| `sfn build` | `cli/commands/build.sfn` | `BuildReport` via `--json` (#259), lock-tested but **undocumented** in `docs/reference/`; `--check-determinism` | SFEP-0006 |
| `sfn run` | `cli/commands/run.sfn` | — | SFEP-0006 |
| `sfn test [suite...]` | `cli/commands/test/` (9 modules) | `--json`; streamed IPC | SFEP-0010/0011/0044/0050 |
| `sfn bench` | `cli/commands/bench.sfn` + `bench_json.sfn` | `sailfin.bench/v1`; `docs/reference/bench-json-schema.md`; **exit 2** on `--budget-time`/`--budget-mem` violation | SFEP-0006 Stage C5 |
| `sfn emit <llvm\|sailfin\|native>` | `cli/commands/emit.sfn` | textual IR | SFEP-0015 |

**Distribution, configuration, environment** — all SFEP-0002 / SFEP-0046 /
SFEP-0040 territory, listed for completeness: `init`, `add`, `publish`, `lock`,
`package`, `login`, `config`, `cache`, `toolchain install`, `completion`.

**Maintainer-only**, hidden from `sfn --help`: `dev bootstrap|shard|arena|
determinism-sweep|clean` (`cli/commands/dev*.sfn`), and `selfhost`, which is not
a registered `Command` at all but a fallthrough handled by
`cli_selfhost.sfn::handle_selfhost_command` — the fixed-point validator `make
check` and CI drive. Plus `guillermo`, an easter egg.

**The diagnostic substrate.** Two layered representations, not the single minimal
one the pre-rewrite text described:

- `compiler/src/diagnostic.sfn:31` — the canonical, backend-agnostic `Diag`:
  `code`, `severity`, `message`, `file_path`, `span: Span?`, `stage`,
  `suggestion: FixSuggestion?`. `TextEdit` (`:8`) carries concrete
  machine-applicable replacements.
- `compiler/src/typecheck_types/mod.sfn:13` — the frontend `Diagnostic`, converted
  at the sink boundary by `diagnostic_to_diag`.

`secondary` spans are the one field still unpopulated:
`compiler/src/diagnostics_json.sfn:164` emits a hardcoded `"secondary": "[]"`. The
related `label` slot is reserved on the same grounds per the comment at `:132-137`
— both wait on the same secondary-source-location work. This is SFEP-0061's
remaining work, not a gap this SFEP owns.

**The consumer that already exists.** `tools/mcp-server/` is a shipped TypeScript
MCP server exposing ten commands to agents — `sailfin_version`, `sailfin_check`,
`sailfin_diagnostics`, `sailfin_emit_native`, `sailfin_emit_llvm`,
`sailfin_fmt_check`, `sailfin_fmt_write`, `sailfin_build`, `sailfin_test`,
`sailfin_bench` — where "every tool is a *pure passthrough* to one `sailfin`
subcommand" (`tools/mcp-server/README.md:22`). Not yet built there:
`sailfin_effect_trace`, `sailfin_run` (`:64-65`).

### 3.3 The host question, answered by a fourth option

The pre-rewrite text framed the central architectural question as three options —
(A) subcommands in the compiler binary, (B) separate binaries with duplicated
parsers, (C) extract the front-end into an `sfn/compiler` library capsule that
tool binaries import — and recommended "A now, C later," with C arriving as a
published library capsule.

**A won, and C as specified is foreclosed.** SFEP-0020 decomposes the compiler
into six role-oriented capsules (`sfn/syntax`, `sfn/analyzer`, `sfn/ir`,
`sfn/codegen`, `sfn/codegen-llvm`, `sfn/compiler`) that are all
**workspace-private, `publish = false`** (`0020:29-31`), and in which
`sfn/compiler` is *the binary*, not the library. The naming collision is worth
stating plainly so nobody reads the old plan as live: the identifier this SFEP
once proposed as a public library is now the private capsule holding the driver.

What actually discharged the need was neither A nor C but a **pure analyzer
boundary**: `compiler/src/analyzer.sfn` exposes an authority-free
`AnalyzerInput -> AnalyzerResult` contract over parsed syntax that produces
diagnostics without importing the driver, codegen, or LLVM modules (SFN-713,
SFEP-0020 §3.5 item 6 at `0020:233-237`, the spelling `docs/status.md:266` gives as
"§3.5.6"). That gives every tool the shared
analysis Option C was reaching for, in-process, without a published artifact,
without cross-capsule version skew, and without the capsule system having to
mature first. Option C's stated cost — "requires capsule system and cross-capsule
imports to be solid" — was real; the boundary sidestepped it rather than paying
it.

**The realized pattern, stated as design.** A Sailfin tool is:

1. a subcommand registered in the `compiler/src/cli/main.sfn` `Command` tree;
2. an implementation under `cli/commands/` that delegates analysis to the analyzer
   boundary or to `tools/`;
3. a human rendering on stderr **and** a machine envelope on stdout under
   `--json`, mutually exclusive;
4. a `schema_version` string as the envelope's first field, with consumers
   required to hard-fail on unknown versions;
5. a schema document in `docs/reference/` and a schema-lock test that fails CI if
   the field set drifts;
6. exit codes with fixed meaning — by convention `0` clean, `1` findings, `2`
   setup or budget failure.

Point 3's mutual exclusivity and point 6's `2` are not incidental. `sfn bench`
uses exit `2` for budget violation and `sfn check` for setup error; a consumer
distinguishes "the tool ran and disagreed with you" from "the tool never ran."
The `bench` schema doc records the sharp edge that follows: pre-flight config
errors emit **no envelope** at all, so a `--json` consumer must treat
empty-stdout-with-nonzero-exit as a setup error rather than assuming every
invocation yields a document.

**What would still force a separate binary.** One thing only: a **resident**
process. Every tool above is batch — start, analyze, print, exit — which is why
they compose as subcommands. A language server is not batch, and the compiler's
memory model is built for the batch shape (`docs/proposals/archive/phase-5a-arena-reset.md:55`
records the constraint as "API must extrapolate to LSP," with `:217-219`
sketching mark-per-request/rewind-on-response). That is the real content of
[§3.5](#35-gap-editor-integration), and it is a runtime-shape question, not a
packaging one. Option B remains rejected on its original merits: a duplicated
parser drifts.

### 3.4 Where lint lives

Settled, and recorded here because it is a decision the tree made without a
proposal: **lint is a severity range inside `sfn check`, not a command.** See
[§2.1](#21-retracted-scope--sfn-vet-as-a-command) for the evidence and the rule
reassignment audit. The consequences worth carrying forward:

- A new advisory check is a new `W02xx` code in `tools/check.sfn`, an issue, and a
  regression test. It needs no proposal.
- `W02xx` never fails a build (`docs/style-guide.md:230`). A check that *should*
  fail a build is an `Exxxx` code in whichever range owns its domain — and the
  choice between the two is the substantive design decision, not which binary it
  ships in.
- Retired codes are never reused (`W0212`, killed with `{{ }}` interpolation in
  SFEP-0057/SFN-483).
- Suppression exists per-code where a real migration needed it
  (`--allow-bare-assert`), not as a general configuration surface.

### 3.5 Gap: editor integration

*Gated on: resident incremental analysis, which no proposal currently owns. This
section names the gate; it does not close it.*

**What exists.** A real VS Code extension, `SailfinIO.sfn`, ships on the
Marketplace and is the recommended integration
(`site/src/content/docs/docs/getting-started/editor-setup.md:9-15`). Its published
capability table (`:41-51`) is honest: highlighting, effect-annotation
recognition, bracket matching, comment toggling, and snippets are Available;
diagnostics, go-to-definition, hovers, and completion are Planned and require a
language server. The documented interim workaround is real — a `tasks.json`
`problemMatcher` scraping `^error\[.*\]: (.*)$` (`:111-170`). Separately,
`site/src/grammars/sailfin.tmLanguage.json` is a **site asset** feeding Shiki for
docs code blocks via `site/astro.config.mjs`; it is not an editor plugin, and no
tree-sitter grammar exists.

**The circular deferral, broken.** SFEP-0004 defers watch mode and incremental
checking to `sfn lsp` — "Defer to `sfn lsp` which provides this functionality"
(`0004:1010-1012`) — while the pre-rewrite text of this SFEP made `sfn lsp`
depend on `sfn check`'s infrastructure. Each pointed at the other. Neither owns
the thing actually missing, which is **analysis that survives between requests**:
a resident process, a file cache with content hashing, invalidation on edit, and
an arena discipline that reclaims per request rather than per process. The batch
tools need none of it; a language server is nothing but it.

So the honest statement is not "the LSP is planned" but: *the LSP is one consumer
of an incremental analysis engine nobody has designed, and the engine is the
work.* Naming it here converts a dangling deferral into a known omission. It is a
`runtime`-and-`tooling`-shaped proposal of its own when someone wants it, and its
prerequisites are already partly in hand — the analyzer boundary (§3.3) is
authority-free and therefore re-entrant-friendly, and `sailfin-check/1` already
gives an editor client a diagnostic wire format so the protocol layer needs no
new schema design.

**Documentation defect — resolved on the docs side; the horizon label is not this
rewrite's call.** Two public statements of when this arrives disagreed.
`site/src/data/roadmap.json` lists an "sfn LSP & IDE Integration" epic at
`"horizon": "1.0"`, while `site/.../getting-started/editor-setup.md` said the
language server "is planned for development after the 1.0 compiler release" — a
reader could see both. This rewrite fixes the docs page: its four `Planned
(post-1.0)` cells now read `Planned (requires a language server)`, and the
release-relative sentence is replaced by the actual gate (analysis that survives
between requests). That removes the contradiction without asserting a horizon,
since `docs/conventions/public-roadmap.md` states that `horizon:*` is a Linear
publication label, that changing one "requires explicit owner approval," and that
agents "must not infer ... a horizon from ... an SFEP." `roadmap.json` is a
generated snapshot (`npm run sync:roadmap`), so editing it directly would be
overwritten on the next sync regardless. If the owner wants the epic outside the
current boundary, the change belongs on the Linear label; the `horizon:1.0`
reading — "work inside the stable-1.0 maturity boundary," explicitly "not a
release date" — is not contradicted by anything this SFEP says.

**Second defect, same area.** Twelve source comments name a future language server
as a consumer of a data structure — eleven as `sfn lsp`, one
(`diagnostics_json.sfn:171`) as "the LSP". The locations:
`compiler/src/build_report.sfn:7`,
`diagnostics_json.sfn:13` and `:171`, `capsule_artifact.sfn:14`/`:69`/`:108`,
`llvm/lowering/lowering_phase_render.sfn:185`,
`llvm/expression_lowering/native/core_strings.sfn:35`, `typecheck/mod.sfn:82`,
`build/cache.sfn:72` and `:149`, `check/engine.sfn:108`. `.claude/rules/code-style.md`
requires a comment's removal condition to name an `SFN-NNN`; these name a command
with no issue and no owner, so none of them can ever be discharged. They should
either cite a real issue once one exists or drop the forward reference. Not fixed
here.

### 3.6 Gap: API documentation without doc comments

*Gated on: a decision about where API prose lives. Not gated on the lexer.*

The original design cannot be built as written. It specified `///` doc comments
parsed into a doc AST, and asked the lexer to "preserve `///` doc comments as
tokens." But `.claude/rules/code-style.md` is unambiguous — "One syntax: `//` —
there is no `///` doc-comment form" — and `compiler/src/lexer.sfn:74-109` matches
`/` followed by `/` generically, so `//`, `///`, and `////` all produce an
identical `TokenKind.Comment()`. There is no `DocComment` kind, no attachment to
declarations, and `sfn fmt` treats `///` as an ordinary comment (`0007:353`). The
pre-rewrite Open Question 3 — "`///` or `/** */`?" — relitigated a settled
decision, and the answer to both options is "neither."

**What this changes.** A documentation generator for Sailfin cannot be a
comment-extraction tool. But the machine-readable half of API documentation
already ships: `sfn symbols --json` emits canonical name, kind, rendered
signature, structured parameters and return type, **known effects**, canonical
import path, and call form for the public callable surface. That is most of what a
reference page contains, and it is derived from the compiler rather than from
prose that can rot.

So the real question is narrow and is a *product* question, not a compiler one:
**where does hand-written API prose live?** Two coherent answers, and this SFEP
recommends neither until someone wants the feature:

- **Nowhere in source.** Reference pages are authored in
  `site/src/content/docs/`, and `sfn doc` becomes a renderer over
  `sailfin-symbols/1` plus the capsule manifest — signatures, effects, and imports
  generated; explanation written by hand alongside. This is the cheaper path and
  it is consistent with the language having no doc-comment syntax. Its cost is
  that prose and signature drift independently, with no compiler-enforced link.
- **In source, behind new syntax.** A doc-comment form is added to the language
  (a lexer token kind, an AST attachment, a `fmt` rule, and a spec chapter). This
  is a `language`-type proposal, not a tooling one, and it should be justified as
  a language change against the boring-syntax bar — not smuggled in as a
  prerequisite for a tool.

There is also a Reach-pillar angle that makes the first option more attractive
than it first looks. SFEP-0002 §3.5 plans to publish the derived capability
manifest into the registry index. If `sfn doc` renders from `symbols --json` plus
that manifest, then a capsule's published documentation states *what it can
reach*, derived and complete, rather than what its author remembered to write
down. That is a documentation generator with a pillar attached, and it is a
materially better reason to build one than "Rust has `rustdoc`."

### 3.7 Gap: applying fixes

*No gate. The machinery ships; only the applier is missing.*

This is the smallest unblocked item in the document, and the pre-rewrite text got
it wrong by declaring it blocked. The stated prerequisite — extend `Diagnostic`
with structured fix-its — is discharged: `FixSuggestion { message, edits:
TextEdit[] }` and `TextEdit { start_line, start_column, end_line, end_column,
replacement }` exist in `compiler/src/diagnostic.sfn`, and effect diagnostics
already populate them (`docs/status.md:296`, SFEP-0004 B3). `W0210` carries one
today.

What is missing is three things, none of them deep:

1. **An edit applier** — read the file, sort edits in reverse source order,
   splice, write. The reverse-order requirement is the only correctness subtlety,
   and it is the one the original sketch identified correctly.
2. **Producer coverage** — how many diagnostics actually carry a suggestion.
   Today: `E04xx` and `W0210`. This grows one diagnostic at a time and needs no
   design.
3. **A conflict rule** — what happens when two suggestions touch overlapping
   ranges. The safe answer is to apply non-overlapping edits and re-run, iterating
   to a fixed point with a guard counter, which matches the compiler's existing
   convention for input-driven loops.

The consumer story is already better than it was: `sailfin-check/1` renders edits
in the envelope, so an agent driving `sfn check --json` through
`tools/mcp-server/` can apply fixes itself without a `sfn fix` command existing at
all. That is worth knowing before building the command — the command's value is
convenience for humans at a terminal, and the envelope already serves the agent
case this document's motivation section cares most about.

### 3.8 Ordering

No phase numbers, because these are independent and none blocks another. Stated as
gates, per [§2.2](#22-retracted-scope--schedule-and-cost-vocabulary):

| Item | Gate | Notes |
|---|---|---|
| `W02xx` lint backlog (7 rules, §2.1) | **No gate.** Each is an issue against `tools/check.sfn` | `unused-import` first — it is the one whose absence compounds |
| `secondary` spans populated | SFEP-0061's remaining work | Schema slot already reserved; not this SFEP's |
| `sfn fix` (§3.7) | **No gate.** Applier + conflict rule | Agents can already apply edits from the envelope |
| `sfn doc` (§3.6) | Gated on the prose-location decision, which is a product call | Machine half already ships as `symbols --json`; better with SFEP-0002 §3.5 |
| Editor integration (§3.5) | Gated on resident incremental analysis — **unowned; needs its own proposal** | The engine is the work; the LSP is one consumer |
| `sailfin_effect_trace`, `sailfin_run` MCP tools | **No gate** beyond the MCP server's own backlog | `tools/mcp-server/README.md:64-65` |
| A schema doc for `BuildReport` | **No gate.** The envelope and its lock test already exist | The only shipped envelope missing the §3.3 point-5 document |

The one ordering *preference*: a new envelope should be locked with its schema doc
and schema-lock test in the same change that introduces it. Retrofitting a version
string onto a shipped output is a breaking change for every consumer that guessed
at the unversioned shape — and `tools/mcp-server/` is now a real consumer, so the
guess is no longer hypothetical.

## 4. Effect & capability impact

No new effects, and no change to the taxonomy. Tooling is a **consumer** of the
effect system, not a participant in it:

- `sfn check` and `sfn capabilities audit` *report* effect facts (`E04xx`,
  `E0405`/`E0406`); they do not extend what an effect means.
- Every tool that reads or writes files or spawns a process declares `![io]`
  transitively like any other Sailfin code, and effect enforcement of the
  compiler's own source is what `make check` validates.
- The Reach pillar's tooling obligation is *surfacing* the derived manifest, not
  deriving it. `sfn symbols --json` already carries known effects per symbol,
  which is the smallest useful version of that: a stranger can read a capsule's
  reach without compiling it.

One genuine interaction worth recording: a resident language server (§3.5) would
hold analysis state across requests, and the capability question it raises is not
about the analyzed program but about the **server process** — a long-running `sfn`
holding `![io]` over a workspace, driven by an editor. The authority-free analyzer
boundary (§3.3) is the right shape for that, since it produces diagnostics without
holding driver or codegen authority. Anyone designing the engine should treat that
as a requirement rather than an accident.

## 5. Self-hosting impact

None from this document — it is a design record with no code change.

The standing constraint the original text stated correctly, and which survives:
every tool is written in Sailfin, compiles with the self-hosted compiler, and must
pass `make compile`. The observation that tools are therefore additional
self-hosting validation is sound and has been borne out — CI enforces `sfn fmt
--check` across all 357 modules of `compiler/src/` and 52 of `runtime/`, so a
formatter regression that changed program meaning would surface as a self-host
failure rather than as a cosmetic diff.

Two corrections. The original text's list of language limitations ("no `await`, no
`Result<T, E>`, no closures-with-capture, `number` as the only numeric type") is
obsolete on every item: `Result<T, E>` shipped (SFEP-0012), sized integer types
shipped (SFEP-0058), first-class function values shipped (SFEP-0030), and
concurrency has its own proposal family. And the source layout it described —
`cli_main.sfn`, `cli_commands.sfn`, a flat `tools/` with `vet.sfn` and `fix.sfn` —
does not exist; see [§3.2](#32-shipped-baseline) for the real one.

The seed-dependency rule is worth naming for whoever builds the §3.5 engine: per
`.claude/rules/seed-dependency.md`, a compiler capability bundles with its single
consumer by default, and the carve-out is a capability that *runtime* source
calls. A tool is an ordinary consumer, so tool work bundles — it does not force a
seed cut.

## 6. Alternatives considered

**Retire this SFEP as `Superseded` and write a fresh one.** Rejected, on the same
grounds SFEP-0002 §6 used. Seven artifacts cite `0003` — SFEP-0002:180,
SFEP-0004:19 (as `Parent:`) and `:1831`, SFEP-0006:1787-1789, SFEP-0007:19 (as
`Parent:`), SFEP-0023:22, SFEP-0046:479, and `docs/status.md:747` — and SFEP-0001
§8 keeps a load-bearing file in place. Rewriting preserves the citable identifier;
the amendment banner carries the honesty about what changed. Note that the retitle
breaks nothing: every inbound citation references this document by path or number,
and no file in the tree cites it by its former title.

**Keep `type: informational`.** Rejected. SFEP-0001 §5 defines `informational` as
"strategy input, design surveys, guidance with no single shipping artifact," and
says it does not gate a release. That would be defensible for a pure map — but
this document retains ownership of three real gaps, prescribes the envelope
contract that new tools must satisfy (§3.3), and rules on where lint lives (§3.4).
Those change what ships, which is the `tooling` standards track. The registry's
precedent also argues against: of three `informational` SFEPs, one (0024) was
retired by the decision brief precisely for being an unimplemented document a
reader would mistake for current direction.

**Reduce this to a pure inventory and let `docs/status.md` hold everything.**
Rejected, narrowly. Status genuinely belongs in `docs/status.md` (SFEP-0001 §10),
and this document should not mirror it. But the envelope pattern, the host-model
answer, and the lint decision are *design* with no other home, and `status.md` is
the wrong genre for design. The compromise adopted: §3.2 records the surface as a
map with owners rather than as status claims, and defers to `status.md` for what
ships.

**Narrow to the output-contract design alone and cede the inventory.** Rejected
because the inventory is what the seven inbound citations actually want from this
number, and because the gaps in §3.5–§3.7 would then have no owner at all — which
is how the circular deferral in §3.5 arose in the first place.

**Keep `sfn vet` as a planned command.** Rejected; see
[§2.1](#21-retracted-scope--sfn-vet-as-a-command). The short form: the lint
channel exists and is populated inside `check`, the style guide has assigned the
range a home, nine of sixteen proposed rules are hard errors in other ranges, and
a second verb would duplicate `check/engine.sfn`'s staging for no user-visible
gain.

**Build the LSP as the next tooling investment.** Rejected as an ordering claim,
not as a goal. The MCP server demonstrated that agent-facing consumption needs no
editor protocol, and the LSP's real prerequisite — resident incremental analysis —
is a larger unowned piece of work than the LSP itself. Ordering it first would
mean starting with the consumer and discovering the engine.

## 7. Stage1 readiness mapping

`Accepted`, not `Implemented`. Most of the surface this SFEP maps has shipped, but
this SFEP itself is `Accepted` because it retains three open gaps and one
prescriptive contract, and SFEP-0001 §4 reserves `Implemented` for work that
clears the readiness ladder end-to-end. The per-tool `Implemented` claims live on
SFEP-0004 and SFEP-0007, which hold them correctly.

Rendered as a state ledger rather than the template's checkbox list, following
SFEP-0002 §7 — the checklist assumes a single language feature, and this is an
umbrella:

| Slice | State |
|---|---|
| `sfn check`, `sfn fmt` | **Shipped**, `Implemented` under SFEP-0004 / SFEP-0007 |
| `sfn bench`, `sfn symbols`, `sfn capabilities audit` | **Shipped** under SFEP-0006 / SFN-444 / SFEP-0051 |
| The envelope contract (§3.3, six points) | **Shipped as practice, newly written down.** Five envelopes conform on versioning and lock-testing, four on documentation; this is the first document to state the rule new tools must follow |
| Lint home (§3.4) | **Shipped as practice**, codified at `docs/style-guide.md:230`; recorded as design here |
| `W02xx` lint backlog (7 rules) | **Pending** — no gate; each is an ordinary issue |
| `sfn fix` | **Pending** — no gate; applier + conflict rule |
| `sfn doc` | **Deferred** — gated on the prose-location decision (§3.6) |
| Editor integration / language server | **Deferred** — gated on resident incremental analysis, which is **unowned** and needs its own proposal (§3.5) |
| `sfn vet` | **Retracted** (§2.1) |
| The 1.0 schedule, priority tiers, and cost estimates | **Retracted** (§2.2) |

The last two rows say "retracted," not "deferred," deliberately — per
decision-brief §6, an item with no named gate is a planning defect, so scope
nobody is committed to is recorded as a withdrawal rather than dressed as a
schedule.

An implementer's warning, in the spirit of SFEP-0002 §7: the cheap-looking items
above are cheap in their *logic* and not in their *plumbing*. `sfn fix` is a
hundred lines of splicing and an unbounded amount of producer coverage, since
every diagnostic that should carry a suggestion is a separate small change to a
separate pass. Budget for the coverage, not the applier.

## 8. Test plan

This SFEP ships no code, so the plan below is the standing bar a tool must clear
rather than a suite to write now.

**For any new or changed envelope.** A schema-lock test that fails CI when the
field set drifts. The pattern is established and uniform — every envelope above is
guarded by a Sailfin `*_test.sfn` using the `sfn/test` capsule
(`check_json_schema_test.sfn`, `bench_json_schema_test.sfn`,
`symbols_json_test.sfn`, `build_json_schema_test.sfn`,
`make_result_contract_test.sfn`, `make_report_contract_test.sfn`, plus unit-level
counterparts). `compiler/tests/e2e/` contains **zero** `.sh` files, so the
migration `.claude/rules/no-bash-e2e.md` describes is complete and there is no
legacy surface to extend. A guard asserts three things: the `schema_version`
literal, the exact field set, and that the unknown-version consumer contract is
documented.

> **Documentation defect — the reference docs are fixed here; the systemic case is
> not.** The `.sh` → `.sfn` e2e migration (#842/#840) renamed every test without
> updating the citations pointing at them, leaving roughly **73 files** citing
> `compiler/tests/e2e/*.sh` paths that no longer exist — 10 under `docs/`, 19 across
> `runtime/**.sfn` and `compiler/src/**.sfn`, and 44 in `compiler/tests/` itself.
> This rewrite corrects the three in the consumer-facing schema references
> (`docs/reference/check-json-schema.md`, `docs/reference/make-result-schema.md`),
> because a schema doc that misdirects a reader about what locks the contract is
> the most damaging instance. The remaining ~70 are a standalone mechanical sweep:
> they touch compiler and runtime source, so they carry the self-host gate for zero
> functional benefit and do not belong in a documentation change. Worth noting the
> sweep is not purely cosmetic — `.claude/rules/code-style.md` requires a comment's
> references to be durable, and a citation to a deleted file is unresolvable by the
> reader it was written for.

**For any new tool.** Regression coverage that a `--json` invocation and its human
rendering agree on findings; that stdout carries no human text under `--json`; and
that each documented exit code is reachable. `sfn bench`'s pre-flight behaviour is
the case worth copying deliberately — the setup-error path emits empty stdout with
a non-zero exit, and a test should pin that rather than let a future change start
emitting a partial envelope.

**For the `W02xx` backlog.** One test per rule, each asserting the code, the span,
and that the diagnostic does not fail a build (severity is warning). The
build-does-not-fail assertion is the one that matters, because it is the invariant
`docs/style-guide.md:230` states and the one a future contributor is most likely
to break by promoting a lint to an error without moving it to an `Exxxx` range.

**For `sfn fix`.** Idempotence (applying twice equals applying once), reverse-order
splicing correctness on multi-edit files, and a fixed-point guard-counter test on
overlapping suggestions.

**Anti-test.** Do not add tests asserting that `sfn vet`, `sfn doc`, or `sfn lsp`
are absent. Absence is not a behaviour to pin.

## 9. References

**Proposals this SFEP cedes to or corrects**

- `docs/proposals/0004-check-architecture.md` — `sfn check`; also `:781-786`,
  `:1113`, `:1836` (stale `sfn vet`), `:1010-1012` (the deferral broken in §3.5)
- `docs/proposals/0007-fmt-architecture.md` — `sfn fmt`; `:353` (`///` treated as
  `//`), `:823-826` (LSP-gated formatting features)
- `docs/proposals/0061-diagnostic-unification.md` — the `Diag`/`Span` type;
  supersedes this SFEP's former "Diagnostic Infrastructure Enhancement" section
- `docs/proposals/0006-build-architecture.md` — `sfn bench` (Stage C5);
  `:1787-1789` (inbound dependency, partly discharged, partly superseded)
- `docs/proposals/0020-compiler-decomposition.md` — role-oriented capsules,
  `publish = false` (`:25-30`); the analyzer boundary (§3.5 item 6, `:233-237`)
- `docs/proposals/0014-agent-output-orchestration.md` — agent-legible output
- `docs/proposals/0051-workspace-manifest.md` — `sfn capabilities audit`
- `docs/proposals/0002-package-management.md` — `:180` (the cede this rewrite
  partly dangles); §3.5 (manifest in the registry index, relevant to §3.6)
- `docs/proposals/design-notes/sfn-444-symbols-json-index.md` — `sfn symbols
  --json`

**Locked output contracts**

- `docs/reference/check-json-schema.md` — `sailfin-check/1`
- `docs/reference/bench-json-schema.md` — `sailfin.bench/v1`
- `docs/reference/symbols-json-schema.md` — `sailfin-symbols/1`
- `docs/reference/make-result-schema.md` — `make` agent-result envelope

**Source of truth for what ships**

- `docs/status.md:742` (`fmt`), `:743` (`check`), `:745` (`bench`), `:747` (the
  planned verbs), `:786` (`sfn/bench` capsule), `:262-271` (structured output and
  the analyzer boundary), `:289-314` (diagnostics), `:753` (`capabilities audit`)
- `site/src/content/docs/docs/reference/cli.md` — normative CLI reference;
  `reference/bench.md` for `sfn bench`
- `site/src/content/docs/docs/getting-started/editor-setup.md` — editor state

**Conventions this SFEP relies on**

- `docs/style-guide.md:230` — the `W02xx` lint range and its home
- `.claude/rules/code-style.md` — no `///` form; comment removal conditions
- `.claude/rules/no-bash-e2e.md` — new schema guards are `*_test.sfn`
- `.claude/rules/seed-dependency.md` — tool work bundles; no seed cut
- `docs/strategy/decision-brief.md` — the three pillars; §6 on unnamed gates
- `docs/conventions/public-roadmap.md` — where the §3.5 horizon conflict resolves

**Implementation anchors**

- `compiler/src/cli/main.sfn` — the `Command` tree (`:237-259`, `:291-724`)
- `compiler/src/analyzer.sfn` — `AnalyzerInput -> AnalyzerResult`
- `compiler/src/diagnostic.sfn:31` — `Diag`; `:8` — `TextEdit`
- `compiler/src/diagnostics_json.sfn:164` — the reserved `secondary` slot
- `compiler/src/tools/` — `check.sfn`, `fmt/`, `fmt_rules.sfn`
- `compiler/src/lexer.sfn:74-109` — why `///` cannot be distinguished
- `tools/mcp-server/README.md` — the ten passthrough tools (`:11-22`, `:64-65`)
