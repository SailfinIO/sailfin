# Agent Verdict Envelope Schema (`sailfin-run/2`)

Status: shipped, SFEP-0014 (`docs/proposals/0014-agent-output-orchestration.md`)
Phase 7, SFN-726. `sfn dev verify` was the **first producer** of this envelope —
the bash wrapper that previously produced its `make`-hosted predecessor
generation (wired into nine `make` targets) is deleted along with the
`Makefile` wrapping that invoked it. `sfn test`, `sfn build`, and `sfn dev
bootstrap build` now produce the same envelope under an opt-in `--verdict`
flag (SFN-1120); see [The `--verdict` flag](#the---verdict-flag).

`sfn dev verify` ends — on success **and** on failure — by printing a single
greppable verdict block as the **last lines of its output**, so an agent can
classify the outcome from a tail-truncated log without scrolling upthread:

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-run/2","host":"sfn dev verify","target":"verify","status":"fail","failure":"test-failure","phase":"tests-seedcheck","first_error":"tests-seedcheck","report":"build/agent-report.verify.json"}
===END-SAILFIN-RESULT===
```

A consumer greps for `===SAILFIN-RESULT===` and parses the **one JSON line**
that follows.

**Consumers MUST locate the _last_ `===SAILFIN-RESULT===` block in the log**,
not assume the file ends immediately after `===END-SAILFIN-RESULT===`. Two
things can produce more than one occurrence:

- Each phase `sfn dev verify` spawns (`sfn test`, `sfn selfhost --json`, …)
  prints its own output on the way to the supervisor's own verdict. The
  `selfhost` phase in particular prints a *different* envelope
  (`sailfin-selfhost/1`, see [Nesting and sub-envelopes](#nesting-and-sub-envelopes-sailfin-selfhost1))
  that is not this schema at all — a grep for `===SAILFIN-RESULT===` will not
  match it, but a consumer scanning for any JSON-ish trailer should not
  confuse the two.
- If a log somehow contains more than one `===SAILFIN-RESULT===` block (e.g.
  a test prints the delimiter), only the final one is the real verdict.

Reading the last match handles both cases.

## `sfn dev verify` — the original producer

`sfn dev verify [--fast] [--full-pass1] [--json] [--strict] [--jobs N]
[--test-timeout SECS]` (`compiler/src/cli/commands/dev_verify.sfn`, hidden
`dev` namespace) is a native pipeline supervisor: it sequences the pipeline
itself — `compile` → `smoke-pass1` → `tests-pass1` (skipped unless
`--full-pass1`) → `selfhost` → `tests-seedcheck` — and derives the verdict
from each child's exit status and, for `selfhost`, its own `--json`
sub-envelope, rather than screen-scraping human banners. `--fast` runs a
single-phase ledger (`sfn check` over the maintainer source inputs) in place
of the five-phase pipeline.

The envelope core (everything but `complete`, `in_flight`, and `phases[]`) is
rendered by one shared module, `compiler/src/cli/verdict.sfn`, so the trailer
on stdout and the report file on disk can never carry two different
`schema_version` literals.

`sfn dev verify` is the nightly triple-pass gate's driver. The seed builds
the compiler (`sfn dev bootstrap build`) and that freshly built compiler runs
`dev verify`, so a change to the verify orchestration takes effect on the next
nightly rather than waiting for a seed cut — the reason the workflow spends a
separate step on the build instead of letting the seed drive both.

The retired `check` build target sequenced the same pipeline by hand and
emitted no verdict of any kind. `sfn dev verify` writes
`build/agent-report.verify.json` incrementally and emits a per-phase verdict,
so the gate now has a durable ledger it never had before.

## The `--verdict` flag

`sfn test`, `sfn build`, and `sfn dev bootstrap build` each register an
opt-in boolean `--verdict` flag (SFN-1120) that emits the same
`===SAILFIN-RESULT===`-framed, `sailfin-run/2` trailer described above,
rendered by the same shared `compiler/src/cli/verdict.sfn` module — no schema
version bump, since this is a new set of producers rather than a schema
change. Help text on all three: "Emit a machine-readable sailfin-run/2
verdict trailer after the run."

| Command | `host` | `target` | classifier `kind` |
|---|---|---|---|
| `sfn test` | `"sfn test"` | `"test"` | `"test"` |
| `sfn build` | `"sfn build"` | `"build"` | `"build"` |
| `sfn dev bootstrap build` | `"sfn dev bootstrap build"` | `"bootstrap-build"` | `"build"` |

- `status` is `"pass"` when the process exit code is `0`, `"fail"` otherwise.
  `"warn"` is unreachable for these three producers — it exists only for
  `sfn dev verify`'s `nondeterminism` class, which no bare exit code can
  express.
- `failure` is `verdict_classify(<process exit code>, kind)` — the same
  closed enum documented below, unchanged. `null` on exit `0`.
- `phase`, `first_error`, and `report` are **always `null`** for these three:
  none of them runs a phase ledger, and none of them writes a report file
  (`build/agent-report.verify.json` remains `sfn dev verify`-only).
- **Opt-in by design.** Without `--verdict`, all three verbs behave exactly
  as before — no trailer. An unasked-for trailer must never be appended to a
  `--json` stream a caller is teeing straight into a `.json` file, so the flag
  stays off by default.
- **Non-inheriting into spawned children.** The flag is armed per invocation
  (`compiler/src/cli/main.sfn`, `_v2_arm_verdict`, keyed off the parsed
  subcommand path); children receive argv their parent constructs explicitly,
  so `--verdict` never leaks into per-module emit children, pooled test
  children, or a nested `sfn` an e2e test spawns. This is what makes a flag
  the right gate and an env var the wrong one: an env var would reach all of
  them and would need exactly the `SAILFIN_INNER`-style suppression guard
  SFN-726 deleted.
- **Replayed on toolchain dispatch.** The exception to the above, and it is
  deliberate. `sfn test` and `sfn build` re-exec onto a pinned toolchain
  through `toolchain_gate_or_dispatch`, which replays the user's argv
  verbatim — so `--verdict` travels with it. That is correct (the dispatched
  toolchain is the same logical invocation, and exactly one trailer is
  emitted), but it means the trailer requires the **dispatched** toolchain to
  know the flag: against a `[toolchain]` pin older than SFN-1120 the
  invocation is rejected as an unknown flag (exit 2) with no trailer at all.
  `sfn dev bootstrap build --verdict` is unaffected — it spawns the seed with
  a constructed argv, so the flag is never forwarded.

### When there is no trailer

A trailer is guaranteed whenever the command actually **ran**. It is absent
in three reachable cases, all of which share a signature — the invocation was
rejected before dispatch:

| Case | Exit | Why |
|---|---|---|
| `--help` on any of the three | `0` | A help request is a non-ok parse, so nothing is armed. |
| Any usage error (`--jobs abc`, a missing flag value, an unknown sibling flag) | `2` | Arming is gated on a clean parse: on a failed parse `matches` carries only what was consumed before the offending token, so whether `--verdict` was seen would depend on where in argv it sat. |
| Dispatch onto a toolchain predating the flag | `2` | See **Replayed on toolchain dispatch** above. |

So a consumer that passed `--verdict` and got no trailer should read the exit
code rather than assume a crash: exit `2` with no trailer means the command
never started.

## Nesting and sub-envelopes (`sailfin-selfhost/1`)

`sfn dev verify`'s `selfhost` phase runs `sfn selfhost --json`, which emits
its own envelope — `sailfin-selfhost/1`, a **different schema**, not framed by
the `===SAILFIN-RESULT===` delimiters — carrying `stage2`, `seedcheck-smoke`,
`stage3`, and `fixed-point` sub-phase state plus the flat scalars
`failed_phase`, `fixed_point_checked`, `fixed_point`, `binary_match`, and a
nested `determinism` diff. `sfn dev verify` splices that line into its own
report file verbatim (as the `envelope` field of the `selfhost` `phases[]`
entry) and scrapes `failed_phase`/`fixed_point_checked`/`fixed_point` from it
to derive its own `phase`/`failure` fields. `sailfin-selfhost/1` has no
schema-lock doc of its own yet; its shape is exercised by
`compiler/tests/e2e/dev_verify_test.sfn` and `compiler/tests/unit/dev_verify_test.sfn`.

**The disambiguation rule.** Because a supervised run can legitimately print
more than one JSON verdict on the way to its own, a consumer reads the *last*
sentinel **whose `host` field matches the invocation it started**, and treats
a sentinel bearing any other `host` as belonging to a child process it did not
invoke directly. Four `host` values exist today: `"sfn dev verify"`,
`"sfn test"`, `"sfn build"`, and `"sfn dev bootstrap build"` — the field is
what makes this rule mechanical rather than positional now that more than one
producer exists.

## Delimiters

| Delimiter | Meaning |
|---|---|
| `===SAILFIN-RESULT===` | Start marker. The next line is the JSON verdict. |
| `===END-SAILFIN-RESULT===` | End marker, immediately after the JSON line. |

The JSON verdict is exactly one line between the two delimiter lines.

## Versioning

The first field of the verdict is `schema_version`, currently the literal
string `"sailfin-run/2"`. The number is monotonic across the rename from the
envelope's `make`-hosted predecessor generation: a consumer that
has seen the old envelope cannot mistake this one for an earlier generation.
Breaking changes bump this string further (e.g. `"sailfin-run/3"`). Consumers
MUST **hard-fail on unknown `schema_version`** rather than guess at unfamiliar
field shapes. Additive changes (new optional fields) keep the version string.

## Fields

Field order: `schema_version, host, target, status, failure, phase,
first_error, report`.

| Field | Type | Notes |
|---|---|---|
| `schema_version` | string | `"sailfin-run/N"`; consumers hard-fail on unknown `N`. |
| `host` | string | **New in `sailfin-run/2`.** The invocation that produced the verdict — one of `"sfn dev verify"`, `"sfn test"`, `"sfn build"`, `"sfn dev bootstrap build"`. Lets a consumer distinguish its own verdict from a sub-process's (see [Nesting and sub-envelopes](#nesting-and-sub-envelopes-sailfin-selfhost1)). |
| `target` | string | The pipeline that ran: `"verify"` for `sfn dev verify` (`--fast` does not change it), `"test"` for `sfn test --verdict`, `"build"` for `sfn build --verdict`, `"bootstrap-build"` for `sfn dev bootstrap build --verdict`. |
| `status` | string | `pass` \| `warn` \| `fail`. See the closed enum below. |
| `failure` | string \| null | Classification (closed enum below); `null` on `pass`. Set on `warn` too. |
| `phase` | string \| null | The phase `sfn dev verify` was dispatching when it stopped. `null` on `pass`, and always `null` for `sfn test`/`sfn build`/`sfn dev bootstrap build --verdict` — those three run no phase ledger. One of the five-phase (or `--fast` single-phase) ledger below — phase identity is structural, derived from which child the supervisor dispatched, never inferred from log text. |
| `first_error` | string \| null | The failing phase name (`"compile"`, `"smoke-pass1"`, `"tests-pass1"`, `"selfhost"` or `"selfhost/<sub-phase>"`, `"tests-seedcheck"`). `null` on `pass`, and always `null` for `sfn test`/`sfn build`/`sfn dev bootstrap build --verdict`. Precise `file:line` extraction is not implemented — this remains phase-grained, not a scraped source location. |
| `report` | string \| null | Path to the full JSON report file. Always `"build/agent-report.verify.json"` for `sfn dev verify` — unlike the retired `make`-hosted producer, there is no opt-in gate; the report is written unconditionally. Always `null` for `sfn test`/`sfn build`/`sfn dev bootstrap build --verdict` — none of the three writes a report file. See [Report file](#report-file). |

### `status` (closed enum)

| `status` | Meaning | Exit code |
|---|---|---|
| `pass` | The run succeeded. | `0` |
| `warn` | A non-fatal signal that does **not** flip the exit code. `failure` is still set to the classification (today: `nondeterminism`). `sfn dev verify`-only — `sfn test`/`sfn build`/`sfn dev bootstrap build --verdict` derive `status` from the process exit code alone, so `warn` is unreachable for those three. | `0` |
| `fail` | The run failed. | non-zero (the failing child's own exit code) |

### `failure` (closed enum)

`null` on `pass`. Otherwise one of:

| `failure` | Meaning | Agent's correct response |
|---|---|---|
| `compile-error` | `sfn build`/`check` reported diagnostics. | Read diagnostics, fix source — do **not** retry. |
| `test-failure` | One or more tests failed assertions. | Read the failing test's output. |
| `crash` | A child (or the toolchain) died by a hard fault signal — SIGSEGV/SIGBUS/SIGFPE/SIGILL (exit `139`/`135`/`136`/`132`). Distinct from `test-failure` (a clean assertion). Often transient under memory pressure. **SIGABRT (134) is *not* a crash** — a clean `assert` aborts with 134, so a bare 134 stays `test-failure`. | Re-run once; if it reproduces, it is a real crash — escalate to `seed-stabilizer`. |
| `nondeterminism` | stage2 ≠ stage3 fixed-point mismatch, read off `sfn selfhost --json`'s `fixed_point`/`fixed_point_checked` scalars rather than a banner. | Pairs with `status:"warn"`, exit `0`. Re-run once; if it persists, escalate to `seed-stabilizer`. |
| `setup-error` | A child exited `2` (the SFEP-0003 §3.3 point 6 "the tool never ran" convention), or never produced a process at all. | Fix the invocation/env, not the source. |
| `oom` | A child hit the compiler's self-applied 8 GiB memory budget (`RLIMIT_AS`) — exit `137` and not a supervisor-issued deadline. | Escalate (memory regression) — do **not** blind-retry. |
| `timeout` | A supervisor-owned deadline (the pass1 smoke gate's 180s bound, or a per-test-file deadline) tripped, remapped from the child's `137` to `124` before classification so a timeout is never reported as `oom`. | Re-run or escalate per phase. |

`nondeterminism` is the only class that pairs with `status:"warn"`; every other
class pairs with `status:"fail"`.

## Phase ledger

`sfn dev verify` dispatches each phase itself, so `phase` and `first_error`
are structural rather than inferred — a refactor of a phase's human-facing
output cannot desynchronize the ledger. The five phases, in pipeline order:

`compile`, `smoke-pass1`, `tests-pass1`, `selfhost`, `tests-seedcheck`.

- `compile` runs `sfn dev bootstrap build`.
- `smoke-pass1` runs the hello-world example (under a supervisor-owned 180s
  deadline) plus the `sfn/test` capsule gate against the first-pass binary.
- `tests-pass1` is `skipped` unless `--full-pass1` is passed, in which case it
  runs the full suite against the first-pass binary.
- `selfhost` runs `sfn selfhost --json`, splicing its `sailfin-selfhost/1`
  sub-envelope (see [above](#nesting-and-sub-envelopes-sailfin-selfhost1)); a
  fixed-point mismatch reports here as `phase:"selfhost"`,
  `first_error:"selfhost/fixed-point"`.
- `tests-seedcheck` runs the full suite, cold, against the seedcheck binary.

`sfn dev verify --fast` replaces the five-phase pipeline with a single `check`
phase (`sfn check` over the workspace's maintainer source inputs), reported
under the same `target:"verify"`.

## Examples

Passing `sfn dev verify --fast`:

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-run/2","host":"sfn dev verify","target":"verify","status":"pass","failure":null,"phase":null,"first_error":null,"report":"build/agent-report.verify.json"}
===END-SAILFIN-RESULT===
```

A compile-phase failure (e.g. run from a directory with no `bootstrap.toml`):

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-run/2","host":"sfn dev verify","target":"verify","status":"fail","failure":"setup-error","phase":"compile","first_error":"compile","report":"build/agent-report.verify.json"}
===END-SAILFIN-RESULT===
```

Non-deterministic fixed point (exit 0):

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-run/2","host":"sfn dev verify","target":"verify","status":"warn","failure":"nondeterminism","phase":"selfhost","first_error":"selfhost/fixed-point","report":"build/agent-report.verify.json"}
===END-SAILFIN-RESULT===
```

A passing `sfn test --verdict`:

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-run/2","host":"sfn test","target":"test","status":"pass","failure":null,"phase":null,"first_error":null,"report":null}
===END-SAILFIN-RESULT===
```

A crashing `sfn test --verdict`:

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-run/2","host":"sfn test","target":"test","status":"fail","failure":"crash","phase":null,"first_error":null,"report":null}
===END-SAILFIN-RESULT===
```

## Report file

Unlike the retired `make`-hosted producer, the full JSON report is **always
on** for `sfn dev verify` — there is no `JSON=1` / `SAILFIN_AGENT_REPORT=1`
opt-in gate. It is rewritten through a temp file plus atomic rename after
every phase completes, so a reader never sees a torn document and a hard kill
of the supervisor still leaves the last completed phase readable.

**Path.** Always `build/agent-report.verify.json`, fixed rather than
configurable — an agent that gets no sentinel has to know where to look
without having seen the invocation.

**Shape.** The file is the verdict's field core (`schema_version` through
`report`) plus:

| Field | Type | Notes |
|---|---|---|
| `complete` | boolean | `false` until the verdict lands, `true` once it does. A `SIGKILL` of the supervisor leaves the file at its last `complete:false` write. |
| `in_flight` | string \| null | The phase name currently running, while `complete:false`. `null` once `complete:true`. |
| `phases` | array | One entry per phase reached so far, each `{name, status, exit_code, failure, detail, report, envelope}`. `status` is `pass` \| `warn` \| `fail` \| `skipped`. `envelope` carries a spliced child `--json` document verbatim (`sailfin-selfhost/1` for `selfhost`, `sailfin-check/1` under `--fast`) or `null`. |

```json
{"schema_version":"sailfin-run/2","host":"sfn dev verify","target":"verify","status":"fail","failure":"test-failure","phase":"tests-seedcheck","first_error":"tests-seedcheck","report":"build/agent-report.verify.json","complete":true,"in_flight":null,"phases":[{"name":"compile","status":"pass","exit_code":0,"failure":null,"detail":null,"report":null,"envelope":null},{"name":"smoke-pass1","status":"pass","exit_code":0,"failure":null,"detail":null,"report":null,"envelope":null},{"name":"tests-pass1","status":"skipped","exit_code":0,"failure":null,"detail":"pass --full-pass1 to run","report":null,"envelope":null},{"name":"selfhost","status":"pass","exit_code":0,"failure":null,"detail":null,"report":null,"envelope":null},{"name":"tests-seedcheck","status":"fail","exit_code":1,"failure":"test-failure","detail":null,"report":null,"envelope":null}]}
```

## Implementation

- Envelope + classifier: `compiler/src/cli/verdict.sfn` (`VERDICT_SCHEMA`,
  `Verdict`, `verdict_classify`, `verdict_emit`, `verdict_fields`,
  `verdict_arm`, `verdict_funnel_enter`, `verdict_funnel_exit`,
  `verdict_kind_for_target`) — the sole copy of the `"sailfin-run/2"` schema
  literal in the tree.
- Phase ledger + supervisor: `compiler/src/cli/commands/dev_verify.sfn`.
- `--verdict` flag arming for `sfn test`/`sfn build`/`sfn dev bootstrap
  build` (SFN-1120): `compiler/src/cli/main.sfn` (`_v2_arm_verdict`), emitted
  at the CLI's single exit funnel, `sailfin_cli_main_with_paths`.
- Schema-lock coverage: `compiler/tests/e2e/dev_verify_test.sfn` (registration,
  argument contract, verdict block, report file) and
  `compiler/tests/unit/dev_verify_test.sfn` (classifier, sub-envelope
  scraping).
