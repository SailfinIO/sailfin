# `make` Verdict Block Schema (`sailfin-make/1`)

Status: Phase 1 of `docs/proposals/agent-output-orchestration.md` (epic #1056,
issue #1059). The always-last verdict block ships now; the full report file
(`build/agent-report.json`) and precise `first_error` extraction are Phases 2–3.

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
| `report` | string \| null | Path to the full JSON report. Always `null` in Phase 1; populated in Phase 2 (`build/agent-report.json`). |

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
| `nondeterminism` | stage2 ≠ stage3 fixed-point mismatch (`make check`). | Pairs with `status:"warn"`, exit `0`. Re-run once; if it persists, escalate to `seed-stabilizer`. |
| `setup-error` | Bad path, missing seed, staging/env failure. | Fix the invocation/env, not the source. |
| `oom` | Hit the 8 GB `ulimit -v` cap. | Escalate (memory regression) — do **not** blind-retry. |
| `timeout` | Wall-clock `timeout` tripped (exit 124, or SIGKILL 137). | Re-run or escalate per phase. |

`nondeterminism` is the only class that pairs with `status:"warn"`; every other
class pairs with `status:"fail"`.

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

## Implementation

- Emitter + classification: `scripts/agent_report.sh`.
- Makefile wiring: the nine `<target>` / `<target>-impl` pairs.
- Phase 3 will add a schema-lock test (mirroring
  `compiler/tests/e2e/test_check_json_schema.sh`) that guards the exact
  delimiters and the field/enum set.
