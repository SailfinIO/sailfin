# `make` Verdict Block Schema (`sailfin-make/1`)

Status: epic #1056 of `docs/proposals/agent-output-orchestration.md`. The
always-last verdict block ships now (Phase 1, #1059). The opt-in per-target
full report file (`build/agent-report.<target>.json`, #1119) carries a composed
`phases[]`: a single entry built from the matching tool JSON for the
single-tool targets (#1123), and the ordered **seven-phase ledger** for
`make check` (#1124). Precise `first_error` extraction is a later phase.

Every agent-facing `make` target ends — on success **and** on failure — by
printing a single greppable verdict block as the **last lines of its output**,
so an agent can classify the outcome from a tail-truncated log without scrolling
upthread:

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-make/1","target":"check","status":"fail","failure":"test-failure","phase":"seedcheck-tests","first_error":"compiler/tests/unit/foo_test.sfn:42","report":null}
===END-SAILFIN-RESULT===
```

A consumer greps for `===SAILFIN-RESULT===` and parses the **one JSON line**
that follows. Because the block is emitted last (via a `trap … EXIT` idiom in
`scripts/agent_report.sh` that fires even when a phase aborts), it is the one
thing a truncated tail is guaranteed to retain.

**Consumers MUST locate the _last_ `===SAILFIN-RESULT===` block in the log**,
not assume the file ends immediately after `===END-SAILFIN-RESULT===`. Two
things can print after the block:

- On a failing target, GNU Make appends its own `make: *** [<target>] Error N`
  line(s) to **stderr** after the recipe exits non-zero. The verdict block is
  the last line of the target's own **stdout**, but under `2>&1` the make-error
  line interleaves after it. (`make compile 2>&1 | tail -5` still captures the
  block — it is within the last few lines.)
- If a log somehow contains more than one block (e.g. a test prints the
  delimiter), only the final one is the real verdict.

Reading the last match handles both cases.

## Wrapped targets

The verdict block is emitted by `scripts/agent_report.sh`, wired into these
`Makefile` targets:

`compile`, `rebuild`, `check`, `check-fast`, `test`, `test-unit`,
`test-integration`, `test-e2e`, `test-capsules`.

Each public target is a thin wrapper over a `<target>-impl` body that holds the
real recipe. The wrapper runs the impl under `agent_report.sh`, which streams
the impl's output through unchanged and appends the verdict block.

### Nested-invocation guard (`SAILFIN_INNER`)

`make check` invokes `make test` (and `make compile`) internally, and `make
test` invokes `make compile`. Only the **outer** target's verdict is printed:
`agent_report.sh` exports `SAILFIN_INNER=1` for the command it runs, and any
wrapped target reached with `SAILFIN_INNER` already set runs transparently and
emits **no** sentinel.

## Delimiters

| Delimiter | Meaning |
|---|---|
| `===SAILFIN-RESULT===` | Start marker. The next line is the JSON verdict. |
| `===END-SAILFIN-RESULT===` | End marker, immediately after the JSON line. |

The JSON verdict is exactly one line between the two delimiter lines.

## Versioning

The first field of the verdict is `schema_version`, currently the literal string
`"sailfin-make/1"`. Breaking changes bump this string (e.g. `"sailfin-make/2"`).
Consumers MUST **hard-fail on unknown `schema_version`** rather than guess at
unfamiliar field shapes. Additive changes (new optional fields) keep the version
string.

## Fields

| Field | Type | Notes |
|---|---|---|
| `schema_version` | string | `"sailfin-make/N"`; consumers hard-fail on unknown `N`. |
| `target` | string | The wrapped target: one of the nine listed above. |
| `status` | string | `pass` \| `warn` \| `fail`. See the closed enum below. |
| `failure` | string \| null | Classification (closed enum below); `null` on `pass`. Set on `warn` too. |
| `phase` | string \| null | Best-effort phase that reached the failure/warn. Single-phase targets echo the target name; `check` resolves one of its seven phases. `null` on `pass`. |
| `first_error` | string \| null | Best-effort `file:line` (or `file:line:col`) pointer when one can be scraped, else the failing phase name, else `null`. Precise extraction is Phase 3. |
| `report` | string \| null | Path to the full JSON report file. `null` unless the report-file gate is active (`JSON=1` / `SAILFIN_AGENT_REPORT=1`), in which case it is the per-target `build/agent-report.<target>.json`. See [Full report file](#full-report-file). |

### `status` (closed enum)

| `status` | Meaning | Exit code |
|---|---|---|
| `pass` | The target succeeded. | `0` |
| `warn` | A non-fatal signal that does **not** flip the exit code. `failure` is still set to the classification (today: `nondeterminism`). | mirrors `make`'s actual exit (so `make check`'s `0` is preserved) |
| `fail` | The target failed. | non-zero |

### `failure` (closed enum)

`null` on `pass`. Otherwise one of:

| `failure` | Meaning | Agent's correct response |
|---|---|---|
| `compile-error` | `sfn build`/`check` reported diagnostics. | Read diagnostics, fix source — do **not** retry. |
| `test-failure` | One or more tests failed assertions. | Read the failing test's output. |
| `crash` | A test child (or the toolchain) died by a hard fault signal — SIGSEGV/SIGBUS/SIGFPE/SIGILL (exit `139`/`135`/`136`/`132`), an explicit `Segmentation fault`/`core dumped` line, or a `child terminated by signal` marker with no assertion attribution. Distinct from `test-failure` (a clean assertion) and `setup-error` (a missing artifact). Often transient under memory pressure (#1205). **SIGABRT (134) is *not* a crash** — a clean `assert` aborts with 134, so a bare 134 stays `test-failure`. | Re-run once; if it reproduces, it is a real crash — capture the failing file (named in the `[test] FAIL:` line) and the in-flight `RUN  <test>` breadcrumb, then escalate to `seed-stabilizer`. |
| `nondeterminism` | stage2 ≠ stage3 fixed-point mismatch (`make check`). | Pairs with `status:"warn"`, exit `0`. Re-run once; if it persists, escalate to `seed-stabilizer`. |
| `setup-error` | Bad path, missing seed, staging/env failure. A bare `No such file or directory` only counts here when it carries a seed/staging context (`seed`, `.seed-version`, `fetch-seed`, `SEED=`); a post-crash artifact-not-found does **not** masquerade as setup. | Fix the invocation/env, not the source. |
| `oom` | Hit the compiler's self-applied 8 GiB memory budget (`RLIMIT_AS`, #1291). | Escalate (memory regression) — do **not** blind-retry. |
| `timeout` | Wall-clock `timeout` tripped (exit 124, or a bare SIGKILL 137 with no crash signature). | Re-run or escalate per phase. |

`nondeterminism` is the only class that pairs with `status:"warn"`; every other
class pairs with `status:"fail"`.

Ordering note: `crash` is classified **above** `timeout` and `setup-error`. A
signal-killed child carries a fault exit code (e.g. `139`) and/or a `child
terminated by signal` line, so it resolves to `crash` before a co-incident
post-crash `No such file or directory` can reach the `setup-error` arm. `oom`
still wins over `crash` for a 137 that carries a memory-exhaustion signature, so
an OOM-kill is never mislabelled a crash.

## `phase` values for `check`

`make check` runs seven phases; on failure `phase` resolves to the latest one
reached (best-effort, from the human banners `check` already prints):

`compile`, `first-pass-tests`, `seedcheck-build`, `seedcheck-smoke`,
`seedcheck-tests`, `stage3-build`, `fixed-point`.

The `seedcheck-smoke` phase (the hello-world viability step) can fail
independently of the build and test phases.

## Examples

Passing `check-fast`:

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-make/1","target":"check-fast","status":"pass","failure":null,"phase":null,"first_error":null,"report":null}
===END-SAILFIN-RESULT===
```

Forced setup failure (`make compile SEED=/nonexistent`):

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-make/1","target":"compile","status":"fail","failure":"setup-error","phase":"compile","first_error":"compile","report":null}
===END-SAILFIN-RESULT===
```

Non-deterministic fixed point (`make check`, exit 0):

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-make/1","target":"check","status":"warn","failure":"nondeterminism","phase":"fixed-point","first_error":null,"report":null}
===END-SAILFIN-RESULT===
```

## Full report file

The verdict block is always-on and intentionally one line. The **full report
file** is the opt-in companion that later phases grow into a per-phase
breakdown. It is gated so default human runs are untouched.

**Activation.** Off by default. Turn it on with either:

- `JSON=1 make <target>` (the Makefile maps `JSON=1` to `SAILFIN_AGENT_REPORT=1`), or
- `SAILFIN_AGENT_REPORT=1` in the environment.

When the gate is off, **no file is written** and the verdict block's `report`
field stays `null`.

**Path.** Per-target: `build/agent-report.<target>.json` (e.g.
`build/agent-report.compile.json`, `build/agent-report.test.json`). The
per-target name keeps parallel CI shards from clobbering each other's report.
When the gate is on, the verdict block's `report` field is exactly this path,
and the report's own `report` field is self-referential (it names its own path).

**Nested runs.** A `SAILFIN_INNER` nested target (e.g. `make check`'s inner
`make test`) runs transparently: it emits no verdict sentinel **and** writes no
report file, even under the gate. Only the outer target produces a report.

**Shape.** The file is a single well-formed JSON object mirroring the verdict
fields, plus a self-referential `report` and a composed `phases` array.

```json
{"schema_version":"sailfin-make/1","target":"compile","status":"pass","failure":null,"phase":null,"first_error":null,"report":"build/agent-report.compile.json","phases":[{"name":"compile","status":"pass","report":"build/native/.build-report.json"}]}
```

### `phases[]`

For the single-tool targets, `phases` carries **one** entry composed from the
tool JSON the Makefile teed under the same `JSON=1` gate. `make check` is the
exception: it carries the ordered **seven-phase ledger** (see below).

| Field | Type | Notes |
|---|---|---|
| `name` | string | The phase name. Single-tool targets echo the target (`compile`, `test-unit`, `check-fast`, …); `check` carries the seven check phases. |
| `status` | string | `pass` \| `warn` \| `fail` \| `skipped`. Mirrors the verdict per phase (see the ledger rules below). For single-tool targets: `fail` when the target failed, else `pass` (a `warn` target ran every phase, so the phase is `pass`). |
| `passed` | number | **Single-tool test targets only.** Count of passing tests, tallied from the `summary` event(s) of the `sfn test --json` jsonl (`build/agent-test.<target>.jsonl`). |
| `failed` | number | **Single-tool test targets only.** Count of failing tests, from the same `summary` tally. |
| `report` | string | Path to the captured tool JSON for this phase: `build/native/.build-report.json` (`compile`/`rebuild`, the `sfn build --json` BuildReport), `build/agent-test.<target>.jsonl` (test targets), or `build/agent-check-fast.json` (`check-fast`, the `sailfin-check/1` envelope). Omitted on the `check` ledger entries, whose per-phase tool artifacts are a later phase. |

**Per-target artifact map.** The composer reads the artifact captured under the
gate by the matching Makefile wiring:

| Target | Tool artifact (`report`) | Schema |
|---|---|---|
| `compile`, `rebuild` | `build/native/.build-report.json` | BuildReport `schema_version "1"` |
| `test`, `test-unit`, `test-integration`, `test-e2e`, `test-capsules` | `build/agent-test.<target>.jsonl` | `sfn test --json` jsonl `schema_version 1` |
| `check-fast` | `build/agent-check-fast.json` | `sailfin-check/1` |
| `check` | — (seven-phase ledger; see below) | — |

**Graceful degradation.** When the expected tool artifact is missing or does
not parse, `phases` degrades to `[]` and the report keeps the verdict-derived
top-level fields — the verdict block and the stream-after-verdict invariant are
never broken by a missing or malformed artifact.

### Seven-phase `check` ledger

`make check` runs seven phases in a fixed pipeline order. Under the report gate,
`build/agent-report.check.json` carries all seven as `phases[]` entries
(`{"name":…,"status":…}`) — observability only; the ledger never alters what
`check-impl` runs or its human output. The phases, in order:

`compile`, `first-pass-tests`, `seedcheck-build`, `seedcheck-smoke`,
`seedcheck-tests`, `stage3-build`, `fixed-point`.

Per-phase status is derived from the human banners `check-impl` prints (the same
marker set the top-level `phase` field keys off):

- A phase the run advanced **past** (a later phase's start banner appeared) is
  `pass` — control reaching a later phase proves the earlier ones completed.
- The **last-reached** phase mirrors the top-level verdict: `fail` on a failure,
  `warn` on the `fixed-point` nondeterminism mismatch, else `pass`.
- Phases that were **never reached** (the run stopped earlier) are `skipped`.

`compile` is the first thing `check-impl` runs, so it is always reached. The
`seedcheck-smoke` phase (the hello-world viability step) can fail
**independently** of the build and test phases — a `seedcheck-smoke` `fail`
marks `seedcheck-tests`, `stage3-build`, and `fixed-point` `skipped`. The
`fixed-point` `stage2 != stage3` mismatch is the lone phase `warn`: it pairs
with top-level `status:"warn"` / `failure:"nondeterminism"` and **exit 0**.

```json
{"schema_version":"sailfin-make/1","target":"check","status":"warn","failure":"nondeterminism","phase":"fixed-point","first_error":null,"report":"build/agent-report.check.json","phases":[{"name":"compile","status":"pass"},{"name":"first-pass-tests","status":"pass"},{"name":"seedcheck-build","status":"pass"},{"name":"seedcheck-smoke","status":"pass"},{"name":"seedcheck-tests","status":"pass"},{"name":"stage3-build","status":"pass"},{"name":"fixed-point","status":"warn"}]}
```

## Implementation

- Emitter + classification: `scripts/agent_report.sh`.
- Makefile wiring: the nine `<target>` / `<target>-impl` pairs.
- Phase 3 will add a schema-lock test (mirroring
  `compiler/tests/e2e/test_check_json_schema.sh`) that guards the exact
  delimiters and the field/enum set.
