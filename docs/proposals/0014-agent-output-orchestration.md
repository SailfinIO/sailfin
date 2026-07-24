---
sfep: 14
title: Agent-Legible Build/Test Output
status: Accepted
type: tooling
created: 2026-06-05
updated: 2026-07-24
author: "agent:compiler-architect"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# Proposal: Agent-legible build/test output orchestration

Status: proposed (planning only — no code in this PR)
Date: 2026-06-05
Author: Sailbot (main-session orchestrator)
Parent: [docs/proposals/0006-build-architecture.md](./0006-build-architecture.md) §4.11 (structured link diagnostics),
[docs/proposals/0010-test-infra/00-overview.md](./0010-test-infra/00-overview.md)

## Problem

Agents working this repo invoke the toolchain almost exclusively through
`make` — `make compile`, `make check`, `make test`, `make check-fast`.
When one of those fails, the agent sees a **tail-truncated stream of
interleaved shell banners and compiler text** and cannot reliably answer
the only three questions that decide its next move:

1. **What failed?** A compile error, a test assertion, a non-deterministic
   IR mismatch, a setup error, an OOM, or a timeout — each demands a
   *different* response, and they all look alike in a truncated tail.
2. **Where?** Which phase, which file, which line. `make check` runs
   seven phases (`Makefile:424-525`) — compile, first-pass tests,
   seedcheck build, the seedcheck hello-world viability smoke
   (`Makefile:459-473`, which fails *independently* of the build and
   test phases), seedcheck tests, stage3 build, and the fixed-point hash
   diff; a nonzero exit names none of them.
3. **Is a retry worth it?** An OOM under the 8 GB cap or a known
   non-determinism flake should escalate or re-run; a real compile error
   should not be retried blind. Agents currently retry everything.

The observed failure mode is exactly what the user reported: agents
"see the tail and don't understand if a compile failed or a test
failed," then "continually retry different results because the output
didn't have what they needed."

## What already exists (and why it doesn't help yet)

The structured-output work is ~80% complete **at the tool layer** and
~0% wired **at the Makefile layer** — the layer agents actually call.

| Surface | State | Schema | Consumers today |
|---|---|---|---|
| `sfn check --json` | Shipped, locked | `sailfin-check/1` (`docs/reference/check-json-schema.md`) | MCP `sailfin_diagnostics`, planned `sfn lsp` |
| `sfn build --json` | Shipped | BuildReport `schema_version "1"` (`compiler/src/build_report.sfn`) | `build-quality.yml` runbook |
| `sfn test --json` | Shipped (#368, epic #839 Phase 0) | jsonl `schema_version 1` (`compiler/src/test_runner_json.sfn`) | planned MCP `sailfin_test_runner` |

All three tools speak versioned JSON. But **no `make` target passes
`--json`**, and even if it did, the JSON would be interleaved with
`[check]` / `═══ unit: N/M ═══` shell banners and lost to truncation:

- **`make compile` / `rebuild`** (`Makefile:647-720`) parses the seed's
  *text* output and greps for `build/sailfin/program`. On failure the
  real compiler error is hundreds of lines upthread; the tail shows only
  generic `[rebuild][error]` shell lines.
- **`make check`** (`Makefile:424-525`) sequences compile → first-pass
  tests → seedcheck build → seedcheck tests → stage3 → fixed-point hash
  diff. A nonzero exit carries no machine-readable "which phase." Worse,
  a non-fatal `[check][WARN] stage2 != stage3` reads identically to a
  hard failure.
- **`make test`** emits `═══ suite: N/M passed ═══` banners, but only in
  human mode; the `--json` path `cli_commands.sfn:932` already supports
  is never selected by the Makefile.

**The gap nobody owns:** an *orchestration-layer* verdict. The three
JSON surfaces each stop at their own tool boundary. No epic owns "when
an agent runs `make X`, emit one machine-readable result: target, phases
run, pass/fail per phase, failure classification, first-error pointer."

## Non-goals

- Changing any compiler-correctness behavior. This is reporting only.
- New `--json` schemas for `check`/`build`/`test` — they exist; we wire
  them through, we don't redesign them.
- Replacing human output. Human banners stay; the machine verdict is
  *additive* and always-last.
- Anything gated on `routine`/`spawn` (parallel test execution is epic
  #839 Phase 4's concern).

### Compatibility with "fix the compiler, not the build"

`.claude/rules/selfhost-invariant.md` and `CLAUDE.md` forbid adding
*correctness fixups* to the build driver. This proposal adds
**observability**, not fixups: it changes how outcomes are *reported*,
never what is compiled or whether it links. The Makefile is explicitly
sanctioned orchestration; reporting is orchestration. The keystone
(Phase 1) and the make-level wiring (Phase 2–3) touch **no
`compiler/src/*.sfn`**, so there is zero self-hosting risk in the
high-value path.

## Design

Two layers, smallest-blast-radius first.

### 1. The agent-tail contract (keystone)

Every agent-facing `make` target ends — **on success and on failure
alike** — by printing a single delimited, greppable verdict block as the
**last lines of output**, so it survives tail truncation:

```
===SAILFIN-RESULT===
{"schema_version":"sailfin-make/1","target":"check","status":"fail","failure":"test-failure","phase":"seedcheck-tests","first_error":"compiler/tests/unit/foo_test.sfn:42","report":"build/agent-report.json"}
===END-SAILFIN-RESULT===
```

An agent greps for `===SAILFIN-RESULT===` and parses the one JSON line
that follows. Because it is emitted last (via a `trap`/`finally` shell
idiom so it fires even when a phase aborts), it is the one thing a
truncated tail is guaranteed to retain.

Fields (closed set, versioned `sailfin-make/1`):

| Field | Type | Notes |
|---|---|---|
| `schema_version` | string | `"sailfin-make/N"`; consumers hard-fail on unknown N. |
| `target` | string | `compile` \| `rebuild` \| `check` \| `check-fast` \| `test` \| `test-unit` \| … |
| `status` | string | `pass` \| `warn` \| `fail`. `warn` carries a non-fatal signal (e.g. `nondeterminism`) without a nonzero exit — exit code mirrors `make`'s actual status, so `warn` keeps `make check`'s `0`. |
| `failure` | string \| null | Classification (closed set below); `null` on `pass`. Set on `warn` too (e.g. `nondeterminism`), not just `fail`. |
| `phase` | string \| null | Which phase reached failure/warn (`check` has seven; single-phase targets echo the target). |
| `first_error` | string \| null | `file:line` for a compile/test error, else the failing phase name. |
| `report` | string \| null | Path to the full JSON report (Phase 2), else `null`. |

### 2. Failure classification taxonomy

The closed set agents key on (the whole point — distinct classes drive
distinct responses):

| `failure` | Meaning | Agent's correct response |
|---|---|---|
| `compile-error` | `sfn build`/`check` reported diagnostics | Read diagnostics, fix source — **do not retry** |
| `test-failure` | One or more tests failed assertions | Read the failing test's JSON event |
| `nondeterminism` | stage2 ≠ stage3 fixed-point mismatch | Re-run once; if persists, `seed-stabilizer` |

`nondeterminism` is the one class that pairs with `status: "warn"`, not
`"fail"` — `make check` treats `[check][WARN] stage2 != stage3` as
non-fatal (exit 0), so the verdict must surface the signal *without*
flipping the exit code. Every other class pairs with `status: "fail"`.
| `setup-error` | bad path, missing seed, staging failure (exit 2) | Fix invocation/env, not source |
| `oom` | hit the 8 GB `ulimit -v` cap | Escalate (memory regression), **do not blind-retry** |
| `timeout` | wall-clock `timeout` tripped | Re-run or escalate per phase |

`oom` and `timeout` are first-class because an agent that blind-retries
either burns the cycle the user flagged. The cap is load-bearing on
Linux/WSL (`.claude/rules/compiler-safety.md`); surfacing it explicitly
turns a mystery hang into an actionable signal.

### 3. The full report (`build/agent-report.json`)

For agents (or CI) that want more than the one-liner, each `make` run
writes a complete report to a stable path, composed from the
already-shipped tool JSON:

```jsonc
{
  "schema_version": "sailfin-make/1",
  "target": "check",
  "status": "fail",
  "duration_ms": 1843201,
  "phases": [
    {"name": "compile",          "status": "pass", "report": "build/native/.build-report.json"},
    {"name": "first-pass-tests", "status": "pass", "passed": 412, "failed": 0},
    {"name": "seedcheck-build",  "status": "pass"},
    {"name": "seedcheck-smoke",  "status": "pass"},
    {"name": "seedcheck-tests",  "status": "fail", "passed": 411, "failed": 1,
     "failures": [{"file": "compiler/tests/unit/foo_test.sfn", "line": 42, "name": "..."}]},
    {"name": "stage3-build",     "status": "skipped"},
    {"name": "fixed-point",      "status": "skipped"}
  ],
  "failure": "test-failure",
  "first_error": "compiler/tests/unit/foo_test.sfn:42"
}
```

- `make test JSON=1` (which internally invokes `sfn test --json`) feeds
  the jsonl test stream into the `phases` test entries.
- `make compile JSON=1` / `rebuild JSON=1` requests `sfn build --json`
  from the seed and tees the BuildReport (already a documented surface).
- `make check`'s seven-phase ledger — including the `seedcheck-smoke`
  hello-world viability step (`Makefile:459-473`), which can fail
  independently of the build and test phases — is the headline win: it
  is the target with the worst current legibility and the longest
  runtime, so a wrong retry is the most expensive.

### 4. Opt-in vs always-on

Default: human stdout unchanged **plus** the always-last verdict block
(cheap, no file I/O contention). The full `build/agent-report.json` and
`--json` passthrough activate under `JSON=1` (or `SAILFIN_AGENT_REPORT=1`)
so interactive human runs aren't slowed and CI logs aren't bloated. The
verdict block itself is always on — it is one line and is the whole
point.

## Phasing

Each phase leaves the tree green; none requires a new seed. Phases 1–3
touch **no `compiler/src`** (Makefile + a small `scripts/agent_report.sh`
helper + docs/tests).

| Phase | Size | Scope | Deliverable |
|---|---|---|---|
| **1 — keystone** | S | `Makefile` (`compile`, `rebuild`, `check`, `check-fast`, `test*`), new `scripts/agent_report.sh`, `docs/reference/make-result-schema.md` | The `===SAILFIN-RESULT===` always-last verdict block on every agent-facing target, with `status` + `failure` classification. A make-level smoke test asserts the sentinel is present on both a passing and a deliberately-failing run. |
| **2 — full report** | M | `Makefile` `JSON=1` passthrough wiring the existing `check`/`build`/`test` `--json` surfaces; `scripts/agent_report.sh` composes `build/agent-report.json`; seven-phase ledger for `check` (incl. the `seedcheck-smoke` viability step) | `build/agent-report.json` with per-phase status; `make compile JSON=1` tees `sfn build --json`; `make test JSON=1` consumes the jsonl stream. |
| **3 — first-error + taxonomy** | S | `scripts/agent_report.sh` parses tool JSON to populate `first_error`; lock `sailfin-make/1` in `docs/reference/make-result-schema.md`; schema-lock test (mirrors `test_check_json_schema.sh`) | `first_error` resolves to `file:line`; full closed-set `failure` classification; versioned, documented, CI-guarded schema. |
| **4 — surfacing (optional)** | S | `CLAUDE.md` + `.claude/agents/*` note the sentinel contract; optional MCP `sailfin_make` wrapper tool; `llms.txt` entry | Agents are told to read `===SAILFIN-RESULT===`; MCP clients get it as `structuredContent`. |

Phase 1 alone resolves the reported pain: an agent can grep one sentinel
and learn target + pass/fail + failure-class without parsing the tail.
Phases 2–4 are progressive enrichment.

## Risks

- **(low) Sentinel collision.** A test that prints `===SAILFIN-RESULT===`
  would confuse a naive grep. Mitigate: the block is always the *final*
  occurrence; consumers read the last match. Phase 3's schema-lock test
  guards the exact delimiter.
- **(low) `trap` portability.** The always-last guarantee relies on a
  bash `trap`/`EXIT` idiom; the Makefile already forces `SHELL :=
  /bin/bash` (`Makefile:10`), so this is safe. macOS/Windows runners use
  the same recipe shell.
- **(low) Double-counting `check`'s nested `make test`.** `check` invokes
  `make test` internally; the inner invocation must suppress its own
  top-level sentinel (env guard `SAILFIN_INNER=1`) so only the outer
  `check` verdict is emitted. Called out so the implementer scopes it.
- **(none) Self-hosting.** No `compiler/src` change in Phases 1–3.

## Success metrics

- An agent can determine `{target, status, failure-class, first-error}`
  for any `make compile|check|test|check-fast` from the **last 5 lines**
  of output, with zero upthread scrolling.
- `failure` distinguishes `compile-error` / `test-failure` /
  `nondeterminism` / `setup-error` / `oom` / `timeout` — the six classes
  that demand different agent responses.
- `make check` reports *which of its seven phases* failed.
- Zero new `compiler/src` lines; zero self-hosting risk in the keystone.

## Open questions

1. **Always-on vs `JSON=1` for the verdict block.** Proposed: verdict
   block always on (one line, cheap); full report file behind `JSON=1`.
   Confirm CI is fine with one extra sentinel block per target.
2. **MCP `sailfin_make` tool (Phase 4) — in scope for 1.0 tooling, or
   defer?** The sentinel contract works without it; the MCP wrapper is
   pure convenience for MCP-based clients.
3. **Report path.** `build/agent-report.json` (proposed) vs a per-target
   path (`build/agent-report.<target>.json`) so concurrent CI legs don't
   clobber. Lean per-target for CI-shard safety; decide at design time.
