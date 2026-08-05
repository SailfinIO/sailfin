---
sfep: 14
title: Agent-Legible Build/Test Output
status: Accepted
type: tooling
created: 2026-06-05
updated: 2026-08-05
author: "agent:compiler-architect (original sketch); agent:Sailbot (2026-08 rewrite); human review"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0014 — Agent-Legible Build/Test Output

> **Amendment (2026-08-05) — rehosted from `make` onto `sfn`; the phase ledger
> recorded as regressed rather than delivered.** This SFEP was one of the original
> architecture sketches folded into the SFEP system at its founding and was never
> revised against the tree it describes. Four things had gone wrong.
>
> First, it named the wrong host as durable. Its keystone is a bash wrapper around
> `make`, and it justified that with "the Makefile is explicitly sanctioned
> orchestration" — a claim SFEP-0006 Stage D contradicts by *deleting* the Makefile
> ([§3.4](#34-the-host-is-being-deleted)). Its envelope is named `sailfin-make/1`
> after a host with a scheduled end date.
>
> Second, its headline deliverable has silently regressed to non-functional. The
> phase ledger — "`make check` reports which of its seven phases failed" — is
> listed among this document's success metrics as achieved. It is not: all six
> phase detectors miss, and the sole `warn` path is unreachable
> ([§3.3](#33-the-regression-the-phase-ledger-is-dead)). CI does not catch it
> because the guarding test replays the 2026-06 banners as `echo` stubs.
>
> Third, its inventory is stale in specifics that matter to an implementer: the
> test envelope is `schema_version 2`, not 1; the memory cap is the compiler's
> self-applied `RLIMIT_AS`, not a caller-side `ulimit -v`; the report path settled
> per-target, resolving Open Question 3 in the direction this document only leaned
> toward; and the seven-phase ledger it specifies is now **misordered** against the
> pipeline it models.
>
> Fourth, it recorded Phases 1–3 as design rather than as shipped code, so a reader
> could not tell what remained. The body below is a rewrite, not a patch. The legacy
> prose `Status:/Date:/Author:/Parent:` header is deleted per SFEP-0001 §3; the
> parent relationships it asserted (SFEP-0006 §4.11, SFEP-0010) survive in
> [§9](#9-references).

## 1. Summary

An agent driving this repo must answer three questions from a failed build — **what
failed, where, and is a retry worth it** — and a truncated tail of interleaved
banners answers none of them. The fix, shipped since 2026-06, is a **delimited,
versioned verdict block emitted as the final lines of every agent-facing target**,
plus a per-target JSON report and a closed failure taxonomy that maps each class to
a distinct correct response.

That contract is right and is in use. Its **mechanism** is the defect. The verdict
is assembled by `scripts/agent_report.sh`, which reconstructs pipeline state by
grepping another process's *human* output. When `#1502` moved the self-host stages
out of Makefile shell into `sfn selfhost`, the banners changed and the ledger died
without a single test going red.

This rewrite keeps the contract and moves the host. The verdict becomes something
`sfn` **produces** rather than something bash **infers**: a new maintainer verb
`sfn dev verify` owns the multi-phase pipeline, emits phase results from the
children's own `--json` envelopes, and derives classification from exit status and
signals instead of regexes. The envelope is renamed `sailfin-run/2` to retire the
`make` in its name alongside the Makefile. The bash detector gets one interim
repair so the window before the seed carries the native verb is not a blind one,
then is deleted with its host.

## 2. Problem

### 2.1 The original problem, unchanged

An agent invoking the toolchain sees a tail-truncated stream of interleaved shell
banners and compiler text, and cannot reliably determine:

1. **What failed?** A compile error, a test assertion, a non-deterministic IR
   mismatch, a setup error, an OOM, or a timeout — each demands a *different*
   response, and they look alike in a truncated tail.
2. **Where?** Which phase, which file, which line. The full self-host pipeline runs
   five top-level phases with four sub-phases inside `selfhost`; a nonzero exit
   names none of them.
3. **Is a retry worth it?** An OOM under the 8 GiB cap or a known non-determinism
   flake should escalate or re-run; a real compile error must not be retried blind.

This framing is sound and is retained verbatim in intent. It is why the taxonomy in
[§3.7](#37-classification-becomes-producer-emitted) is the load-bearing part of the
design rather than the JSON shape.

### 2.2 The problem this rewrite adds

**A verdict layer that reads its inputs by screen-scraping cannot survive
refactoring of the thing it scrapes, and its tests will not tell you.** The
regression in [§3.3](#33-the-regression-the-phase-ledger-is-dead) is not a stale
regex to be corrected once. It is the predictable consequence of siting the
reporter outside the process that holds the facts, coupled to a test that
manufactures its own inputs. Repairing the regexes restores the feature; it does
not remove the failure mode.

## 3. Design

### 3.1 Scope boundary — what this SFEP does not restate

| Territory | Owner |
|---|---|
| The `sfn check` JSON envelope (`sailfin-check/1`), passes, incremental design | SFEP-0004 |
| `BuildReport` and `--check-determinism`; the build driver; Stage D Makefile retirement | SFEP-0006 |
| Test-runner architecture, `--json` jsonl schema, harness↔runner IPC | SFEP-0010, SFEP-0011, SFEP-0044, SFEP-0050 |
| The `Diag`/`Span` type, severity model, fix-it structure | SFEP-0061 |
| The toolchain inventory and the envelope pattern as a cross-cutting rule | SFEP-0003 |
| Per-job RAM budgeting and the `RLIMIT_AS` self-cap | `.claude/rules/compiler-safety.md` |
| `sfn build --target=` cross-compilation (which retires `ci-cross-windows`) | SFEP-0021 |

This SFEP owns exactly one thing: **the orchestration-layer verdict** — the
composite result of a multi-phase run, its failure classification, and the contract
by which an agent reads it. Each tool's own envelope is an input it composes, never
a schema it redefines.

### 3.2 Shipped baseline

Phases 1–3 landed as code, not as design. Recorded here because an accurate
inventory is the precondition for the rest of this document.

| Surface | State | Location |
|---|---|---|
| `===SAILFIN-RESULT===` verdict block | Shipped | `scripts/agent_report.sh:504-512`, emitted from `trap emit_verdict EXIT` (`:518`) |
| Wrapping of agent-facing targets | Shipped, 9 targets | `$(AGENT_REPORT) --target <t> -- $(MAKE) <t>-impl`: `Makefile:269,352,373,393,416,612,651,749,886` |
| Nesting guard | Shipped | `SAILFIN_INNER` (`agent_report.sh:64-72`) — suppresses the inner sentinel when `check` invokes `make test` |
| Schema document | Shipped | `docs/reference/make-result-schema.md` |
| Schema-lock tests | Shipped | `compiler/tests/e2e/make_result_contract_test.sfn`, `make_report_contract_test.sfn` |
| Per-target report file | Shipped | `build/agent-report.<target>.json` (`write_report_file`, `:462-475`) |
| Failure taxonomy | Shipped, **7** classes | `classify()` (`:144-221`) — added `crash` beyond the six proposed, for signal-killed test children |
| `JSON=1` / `SAILFIN_AGENT_REPORT=1` passthrough | Shipped | `Makefile:955-981` (compile tees `BuildReport`), `:360-425` (test), `:758-767` (check-fast) |
| Phase ledger for `check` | **Regressed — see §3.3** | `detect_check_phase()` (`:121-134`), `compose_check_phases()` (`:335-352`) |
| Agent-facing surfacing (Phase 4) | **Not started** | no `SAILFIN-RESULT` reference under `.claude/` or in `CLAUDE.md`; no `sailfin_make` MCP tool |

Two corrections to this document's own record:

- **Open Question 3 is resolved.** The report path is per-target
  (`build/agent-report.<target>.json`), not the single `build/agent-report.json`
  the original text proposed, so concurrent CI shards do not clobber. The
  implementation chose correctly; the design text was never updated.
- **Open Question 1 is resolved.** The verdict block is always on; the report file
  is gated behind `JSON=1`. CI has run this shape since 2026-06 without objection.

### 3.3 The regression: the phase ledger is dead

`#1502` (design note `docs/proposals/design-notes/1502-selfhost-check.md`) moved the
stage2/stage3 build, viability smoke, and fixed-point diff out of ~90 lines of
Makefile shell into `sfn selfhost` (`compiler/src/cli_selfhost.sfn`). The new verb
prints its own `[selfhost]`-prefixed banners. `agent_report.sh` still greps the
strings the Makefile printed in June.

| `agent_report.sh` expects | Emitted today | Match |
|---|---|---|
| `[check] running test suite on first-pass binary` | `[check] pass1 smoke gate: hello-world + sfn/test capsule tests` (`Makefile:686`); `running full suite on first-pass binary` only under `CHECK_FULL_PASS1=1` (`:683`) | no |
| `proceeding to seedcheck build` \| `verifying seed selfhost (stage2)` | `[check] pass1 smoke passed — validating self-host (stage2/stage3 fixed point)` (`:699`); `[selfhost] building stage2 (seedcheck)...` (`cli_selfhost.sfn:578`) | no |
| `validating seedcheck binary can run programs` | `[selfhost] validating seedcheck binary runs hello-world...` (`:610`) | no |
| `running test suite with seedcheck binary` | `[check] running full test suite with seedcheck binary (cold backstop, ...)` (`Makefile:731`) | no |
| `building stage3 for fixed-point` | `[selfhost] building stage3 (driven by seedcheck) for fixed-point check...` (`cli_selfhost.sfn:621`) | no |
| `comparing stage2 vs stage3` | never printed | no |
| `[check][WARN] stage2 != stage3` | `[selfhost] stage2 != stage3: compiler output is not yet a fixed point` (`:668`) | no |

Consequences, all live on `main`:

- `detect_check_phase()` always falls through to its `"compile"` default
  (`agent_report.sh:132`), so **every** `check` failure is attributed to the first
  phase regardless of where it occurred.
- `compose_check_phases()` marks the other six phases `skipped`, so the report file
  asserts a run that did not happen.
- `status: "warn"` / `failure: "nondeterminism"` is **unreachable**. The
  `[check][WARN] stage2 != stage3` literal is its only trigger (`:147-149`) and no
  longer exists in any producer.

**Why CI is green.** `compiler/tests/e2e/check_phase_ledger_test.sfn:94-114` drives
`agent_report.sh` with `echo` stubs that reproduce the June banners verbatim. The
test validates the classifier against a fossil of its own assumptions, so drift
between the classifier and the pipeline is structurally untestable. This is the
defect to fix first, ahead of the regexes: a test that manufactures its inputs
cannot detect that its inputs are wrong.

**The ledger is also misordered.** Independent of the string drift, the seven-phase
sequence this document specifies — `… seedcheck-tests, stage3-build, fixed-point` —
does not match the pipeline. `sfn selfhost` runs stage2 → smoke → stage3 →
fixed-point compare → promote as one internal chain (`cli_selfhost.sfn:578,610,621,664`),
and only *then* does `check` run the seedcheck test suite (`Makefile:731-732`). The
default pass1 step is a smoke gate, not the full suite, and the ledger has no entry
for it at all.

### 3.4 The host is being deleted

This document asserted that "the Makefile is explicitly sanctioned orchestration;
reporting is orchestration." That was true when written and is now the opposite of
the plan of record:

- **SFEP-0006 Stage D** states "the Makefile is **deleted** (or shrunk to a 5-line
  convenience wrapper)" (`0006:1509`), with retirement explicitly deferred out of
  the Stage D PR that shipped everything else (`:1533`). Its design principle §2 is
  titled "No orchestration layer above `sfn`" (`:597-600`).
- The **Makefile Retirement** roadmap epic carries this at the `later` horizon
  (`site/src/data/roadmap.json:278-284`), and `SFN-60` is the removal condition
  cited inline by every transitional shim in the tree (`Makefile:531,562`,
  `compiler/src/cli/commands/dev_arena.sfn:7`).
- **The native surface has already won on the merits.** `sfn selfhost`,
  `sfn dev bootstrap fetch|build|check|pin|fingerprint|install`,
  `sfn dev clean|arena|shard|determinism-sweep`, and `sfn test|check|bench|package`
  cover nearly every target. What remains in the Makefile is sequencing, seed
  acquisition, and `ci-cross-windows`.

Only **two** genuine capability gaps stand between the tree and Stage D. One is
`sfn build --target=x86_64-w64-mingw32`, which SFEP-0021 owns and which
`Makefile:1113` already names as `ci-cross-windows`'s removal condition. The other
is **this SFEP's**: nothing native sequences `compile → smoke → test → selfhost →
test`. That gap is why the verdict layer is still bash, so closing it and rehosting
the verdict are the same piece of work.

### 3.5 The target host: `sfn dev verify`

A new leaf in the maintainer-only `dev` namespace — hidden from `sfn --help`,
alongside `dev bootstrap|shard|arena|determinism-sweep|clean`. `sfn check` is taken
by the typechecker and must not be overloaded; `selfhost` keeps its current narrow
meaning as the inner fixed-point validator this verb calls.

```
sfn dev verify [--fast] [--full-pass1] [--json]
```

The phase ledger, corrected to the pipeline as it actually runs:

| Phase | Delegates to | Result source |
|---|---|---|
| `compile` | `sfn dev bootstrap build` | `BuildReport` |
| `smoke-pass1` | hello-world + `sfn/test` capsule gate | test jsonl |
| `tests-pass1` | `sfn test` — `skipped` unless `--full-pass1` | test jsonl |
| `selfhost` | `sfn selfhost --json` | composite; splices that verb's sub-envelope (`stage2`, `seedcheck-smoke`, `stage3`, `fixed-point`) |
| `tests-seedcheck` | `sfn test` against the seedcheck binary | test jsonl |

`--fast` maps to today's `check-fast` (`sfn check compiler/src/ runtime/`) and emits
a single-phase ledger.

Two properties follow from siting this in `sfn`, and they are the whole point:

1. **Phase identity is structural, not textual.** The verb dispatches each phase, so
   it knows which one is running without inferring it. The `#1502` class of drift
   becomes impossible — a refactor that renames a banner cannot desynchronize a
   ledger that never read the banner.
2. **Sub-phases compose rather than flatten.** `sfn selfhost --json` emits its own
   envelope; `verify` splices it in. Each producer describes only what it owns,
   which is the SFEP-0003 §3.3 envelope pattern applied recursively instead of a
   supervisor re-deriving four phases it does not run.

**Composition, not reimplementation.** `verify` spawns the same children the
Makefile does today and adds no compilation logic. This keeps it inside the
observability carve-out in [§4](#4-non-goals) and out of
`.claude/rules/selfhost-invariant.md`'s prohibition on build-driver fixups.

### 3.6 The envelope: `sailfin-run/2`

`sailfin-make/1` is renamed and bumped in one coordinated break.

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-run/2","host":"sfn dev verify","target":"verify","status":"fail","failure":"test-failure","phase":"tests-seedcheck","first_error":"compiler/tests/unit/foo_test.sfn:42","report":"build/agent-report.verify.json"}
===END-SAILFIN-RESULT===
```

| Field | Change from `sailfin-make/1` |
|---|---|
| `schema_version` | `"sailfin-run/2"`. Renamed; **the number stays monotonic across the rename** so a consumer that has seen `sailfin-make/1` cannot mistake `sailfin-run/2` for an earlier generation. |
| `host` | **New.** The invocation that produced the verdict (`sfn dev verify`, or `make check` during the transition). Lets one consumer read both hosts across the cutover. |
| `target`, `status`, `failure`, `phase`, `first_error`, `report` | Unchanged in meaning. `phase` now draws from the corrected ledger in [§3.5](#35-the-target-host-sfn-dev-verify). |

Consumers requiring coordination: `docs/reference/make-result-schema.md` (renamed to
`run-result-schema.md`), `make_result_contract_test.sfn`,
`make_report_contract_test.sfn`, `check_phase_ledger_test.sfn`, and SFEP-0003's
five-envelope inventory (`0003:42,235`). SFEP-0003 is accurate *today* and should be
amended at cutover, not ahead of it.

Rename rather than freeze, because the shape genuinely changes: phases become
producer-emitted, `first_error` becomes structured, and `host` is added. The pattern
requires consumers to hard-fail on an unknown version (SFEP-0003 §3.3 point 4),
which is exactly the mechanism for making that visible.

### 3.7 Classification becomes producer-emitted

The closed set is the reason this SFEP exists — distinct classes drive distinct
responses. The taxonomy is unchanged from what shipped; what changes is that every
class stops being inferred from text.

| `failure` | `status` | Derived natively from | Agent's correct response |
|---|---|---|---|
| `compile-error` | `fail` | `BuildReport` / `sailfin-check/1` diagnostics, in-process | Read diagnostics, fix source — **do not retry** |
| `test-failure` | `fail` | test jsonl `summary.failed > 0` | Read the failing test's event |
| `nondeterminism` | `warn` | `sfn selfhost` fixed-point result — a return value, not a banner | Re-run once; if it persists, `seed-stabilizer` |
| `setup-error` | `fail` | child exit `2`, per the SFEP-0003 §3.3 point 6 convention | Fix invocation/env, not source |
| `oom` | `fail` | child killed at the `RLIMIT_AS` self-cap; exit `137` / signal | Escalate as a memory regression — **do not blind-retry** |
| `timeout` | `fail` | supervisor-owned deadline; exit `124` | Re-run or escalate per phase |
| `crash` | `fail` | fatal signal (`139`/`135`/`136`/`132`), excluding `134` — a clean `assert` also aborts `134` | Escalate; a fault is never a flake |

`nondeterminism` remains the sole class paired with `status: "warn"` and exit `0`,
because a stage2 ≠ stage3 mismatch is a signal the pipeline deliberately does not
treat as fatal. The verdict must surface it without flipping the exit code.

Every row's source is a number or a struct field. That is the substantive
improvement: exit status and signals are *already* structured data that the current
design throws away in favour of grepping for `Segmentation fault` in a log.

### 3.8 Durability — who reports when the reporter dies

The one real merit of the bash wrapper: as an outer process, it survives the death
of the tool it wraps. Moving the verdict inside `sfn` must not lose that.

- **A phase child dying is strictly better handled natively.** `verify` is a thin
  supervisor spawning each phase as a child (the architecture `sfn selfhost` already
  uses at `cli_selfhost.sfn:444`, and the test pool uses via the SFN-402 process
  handles). A child hitting the 8 GiB cap or taking a signal is *reported* to the
  supervisor as an exit status — the case [§3.7](#37-classification-becomes-producer-emitted)
  now reads structurally instead of by regex.
- **The supervisor's own death is the residual case,** and only from the host OOM
  killer, since the supervisor's footprint is small and its `RLIMIT_AS` is
  per-process. This is unanswerable in-process, so the report file becomes the
  durable record: **`build/agent-report.<target>.json` is written incrementally**,
  appending each phase result as it completes, with `"complete": false` until the
  verdict lands. An agent that gets no sentinel reads the file and sees the last
  completed phase plus the one in flight.

This is a net gain over today, where `write_report_file` is called only from inside
the `EXIT` trap (`agent_report.sh:498`), so a `SIGKILL` of the process group loses
the verdict *and* the report together.

### 3.9 Relationship to the SFEP-0003 envelope pattern

SFEP-0003 §3.3 point 3 requires a human rendering and a machine envelope to be
**mutually exclusive** under `--json`. The verdict block is deliberately *additive*
— always printed, including in human mode. This is not a violation, and the
distinction is worth stating so nobody reads it as one:

- The mutual-exclusivity rule governs a tool's **primary output document**, which
  must be parseable as a whole. `sfn dev verify --json` obeys it.
- The verdict block is a **framed trailer**, delimited precisely so it can coexist
  with arbitrary preceding output. Consumers read the *last* occurrence of the
  sentinel. Its value comes from surviving truncation, which requires it to be
  present in human mode — the mode agents actually get when a phase fails noisily.

## 4. Non-goals

- **Changing any compiler-correctness behaviour.** Reporting only.
- **Redesigning the per-tool `--json` schemas.** `sailfin-check/1`, `BuildReport`,
  and the test jsonl are inputs to compose, owned elsewhere ([§3.1](#31-scope-boundary--what-this-sfep-does-not-restate)).
- **Replacing human output.** Banners stay; the verdict is additive and last.
- **Retiring the Makefile.** That is SFEP-0006 Stage D. This SFEP closes one of its
  two remaining capability gaps and must not grow into the sweep itself.
- **`ci-cross-windows`.** Waits on `sfn build --target=` (SFEP-0021).
- **A public `sfn verify`.** The phases (`seedcheck`, `fixed-point`) are meaningless
  outside this repo; a downstream-facing verification gate is a separate question.

## 5. Phasing

Phases 1–3 are historical and shipped except where noted. Phase 4 is deliberately
**resequenced behind the cutover**: telling every agent to read a sentinel whose
host and schema version are about to change would teach one contract in order to
retract it.

| Phase | Size | Status | Scope | Deliverable |
|---|---|---|---|---|
| **1 — keystone** | S | **Shipped** | `Makefile`, `scripts/agent_report.sh`, `docs/reference/make-result-schema.md` | Always-last `===SAILFIN-RESULT===` block on 9 targets, with `status` + `failure` |
| **2 — full report** | M | **Shipped** | `JSON=1` passthrough; per-target report composition | `build/agent-report.<target>.json` with a `phases[]` array |
| **3 — taxonomy + first-error** | S | **Partial** | `classify()`; schema lock | Taxonomy shipped (7 classes). **Phase ledger regressed — [§3.3](#33-the-regression-the-phase-ledger-is-dead)** |
| **5 — interim ledger repair** | S | Not started | `check_phase_ledger_test.sfn` first, then `agent_report.sh` detectors | **Fix the test before the regexes.** Replace the `echo`-stub fixtures with a *marker-presence assertion*: every literal the detectors grep must appear verbatim in a producer (`Makefile` or `cli_selfhost.sfn`). Static, milliseconds, and it would have failed on `#1502` — where driving a real 15–20 min `make check` from a test is unaffordable and a recorded transcript would become the next fossil. Then re-sync detectors to the `[selfhost]` banners and the corrected phase *order*, restoring the `nondeterminism` warn path. Closes the blind window before a seed carries Phase 6. |
| **6 — native verb** | M | Not started | new `cli/commands/dev_verify.sfn`; `sfn selfhost --json` sub-envelope; incremental report writes | `sfn dev verify [--fast] [--full-pass1] [--json]` runs the pipeline and emits the verdict from child envelopes and exit status. Ledger and classification per [§3.5](#35-the-target-host-sfn-dev-verify)/[§3.7](#37-classification-becomes-producer-emitted). Ships with the Phase 5 test repointed at the native verb. |
| **7 — cutover** | M | Not started | rename schema doc; bump tests; delete `agent_report.sh` and the `$(AGENT_REPORT)` wrapping; amend SFEP-0003 §3.2 | `sailfin-run/2` is the sole envelope. `make check` becomes a wrapper over `sfn dev verify` or is deleted with the Makefile, whichever Stage D reaches first. |
| **4 — surfacing** | S | Not started, gated on 7 | `CLAUDE.md` + `.claude/agents/*`; `sailfin_verify` MCP tool; `llms.txt` | Agents are told to read the sentinel. MCP clients get it as `structuredContent` — which also closes the gap where `sailfin_build` and `sailfin_test` pass `--json` through as raw text (`tools/mcp-server/src/index.ts:388-447`) while `sailfin_diagnostics` parses it properly. |

**Phase 6 is seed-gated.** Like SFN-679 and SFN-680, `sfn dev verify` is executed
*by* the pinned seed, so it is only exercisable once a seed carrying it is pinned
(`docs/status.md:124-129,150-152`). It is a compiler-source capability with a
consumer in the same tree, so per `.claude/rules/seed-dependency.md` it bundles with
its consumer and does **not** justify an off-cadence seed cut. Phase 5 exists
precisely so the intervening window is observable.

## 6. Risks

- **(medium) Phase 5 looks like wasted effort on a doomed layer.** It is one small
  diff, and its durable half is the *test* — repointing
  `check_phase_ledger_test.sfn` at real output is what makes Phase 6 verifiable and
  is not thrown away at cutover. Without it, the tree has no working phase ledger
  for the whole seed-cadence window, and no test capable of noticing.
- **(medium) `verify` accretes build logic.** A supervisor that starts "fixing up" a
  phase becomes the build-driver fixup `.claude/rules/selfhost-invariant.md`
  forbids. Mitigation: `verify` may only spawn children, read their envelopes, and
  report. Any behaviour change belongs in the phase's own command.
- **(low) Envelope rename churn.** Five consumers, all in-tree, all schema-locked —
  so a missed one fails CI rather than silently degrading. SFEP-0003 is amended at
  cutover, not before.
- **(low) Sentinel collision.** A test printing the sentinel would confuse a naive
  grep. Consumers read the *last* occurrence; the schema-lock test guards the exact
  delimiter.
- **(low) Double-counting nested runs.** `SAILFIN_INNER` handles this today for
  `check` → `make test`; the native verb must carry the equivalent guard so a
  spawned `sfn test` does not emit its own top-level verdict.
- **(none) Self-hosting.** Phases 1–3 and 5 touch no `compiler/src`. Phase 6 does,
  and clears the full Stage1 readiness gate like any other compiler change.

## 7. Success metrics

Falsifiable, and stated so the [§3.3](#33-the-regression-the-phase-ledger-is-dead)
failure could not be recorded as success:

- An agent determines `{host, target, status, failure, phase, first_error}` for any
  agent-facing invocation from the **last 5 lines** of output, with zero upthread
  scrolling.
- `failure` distinguishes all seven classes, and each maps to a distinct documented
  response.
- **A failing phase is named correctly**, and never verified by replaying expected
  banners into the classifier. The guard is tiered to what each host can afford:
  Phase 5 asserts every grepped marker exists verbatim in a producer (static, and
  sufficient to catch the `#1502` drift); Phase 6 injects a real failure into each
  of the five phases and asserts the reported `phase` matches — which is affordable
  precisely because the native verb dispatches the phases it reports on.
- **A refactor of a phase's human output cannot change the reported `phase`.** This
  is the invariant `#1502` violated, and it is the one metric the bash mechanism
  cannot satisfy at any level of regex care.
- A hard kill of the supervisor still leaves the last completed phase readable in
  `build/agent-report.<target>.json`.
- Zero `compiler/src` change in Phases 1–3 and 5.

## 8. Open questions

1. **Does `make check` become a wrapper or disappear?** Phase 7 can leave a 3-line
   `check: ; sfn dev verify` shim for muscle memory, or delete the target and update
   `CLAUDE.md`'s validation ladder to name `sfn dev verify` at rung 4. Depends on
   how much of the Makefile survives Stage D; defer to the cutover PR.
2. **Should the CI shard legs consume `sailfin-run/2` directly?**
   `build-quality.yml` already gates on `BuildReport`'s `cache.hit_rate`
   (`.github/workflows/build-quality.yml:250-256`). A composed run envelope could
   replace several bespoke log greps in CI, but that is a CI refactor with its own
   blast radius, not part of this SFEP.
3. **Does `--fast` belong on `verify` at all,** or does `check-fast` simply become
   the already-sufficient `sfn check compiler/src/ runtime/` with no wrapper? The
   verdict block is the only thing the wrapper adds; if `sfn check` grows the
   sentinel itself, `--fast` is unnecessary.
4. **Where does the residual shell surface go?** `scripts/check-examples.sh` and
   `scripts/corpus-run.sh` both emit ad-hoc machine-readable summaries
   (`corpus-run.sh:33` cites this SFEP as its pattern) and both need an XFAIL/XPASS
   ratchet concept no native command has. Candidate follow-on, explicitly out of
   scope here.

## 9. References

- `docs/proposals/0003-tooling.md` — the toolchain surface; the envelope pattern
  (§3.3) and the five-envelope inventory this SFEP's rename touches
- `docs/proposals/0006-build-architecture.md` — §4.11 structured link diagnostics
  (this SFEP's original parent); Stage D Makefile retirement (`:1509,1533`);
  "No orchestration layer above `sfn`" (`:597-600`)
- `docs/proposals/0010-test-infra/00-overview.md` — test-runner architecture
- `docs/proposals/0021-windows-native-selfhost.md` — `sfn build --target=`, which
  retires `ci-cross-windows`
- `docs/proposals/0050-streamed-test-ipc.md` — harness↔runner IPC; the `--json` v2
  schema is unchanged by it
- `docs/proposals/design-notes/1502-selfhost-check.md` — the refactor that broke the
  ledger
- `docs/reference/make-result-schema.md` — the shipped `sailfin-make/1` contract,
  renamed at Phase 7
- `.claude/rules/seed-dependency.md` — why Phase 6 bundles rather than splits
- `.claude/rules/compiler-safety.md` — the `RLIMIT_AS` self-cap behind the `oom`
  class
