# SFN-350 decision protocol

Status: **pre-registration incomplete; language decision not yet authorized**.

This protocol operationalizes the decision gate in Linear SFN-350 and the
Notion “Experiment Plan — Earn the Commitment”. The benchmark must be capable
of disproving the Sailfin thesis. Results from harness development and task
tuning are pilots, not confirmatory evidence.

## Decision rule

The confirmatory run uses the same model, sampling policy, system prompt,
repair budget, task specification, hidden tests, and fresh-attempt count for
every language arm.

- **GO:** Sailfin exceeds the Scala 3 + TACIT arm by at least 15 percentage
  points in one-shot success, matches or improves iterations-to-green, has no
  worse false-friction rate, and beats Python. The advantage must repeat in two
  model families and its paired 95% bootstrap interval must exclude zero.
- **NO:** Sailfin is no better than Scala on ergonomics, or is no better than
  Python, in both model families.
- **MURKY:** neither boundary is reached. This is not permission to call the
  language a GO.

Capability-trap outcomes are reported separately from ordinary task success.
A trap is successful when the type system rejects an unauthorized capability
use before execution. Trap tasks do not inflate the one-shot denominator.

## Confirmatory design

Freeze 10 task templates before collecting confirmatory outputs, with three to
five non-textbook instances per template (30–50 task instances in total). This
reconciles the Notion plan's 8–12-task scope with SFN-350's 30–50-task gate:

1. Two pure logic/data-transformation tasks.
2. Two parsing or CLI-contract tasks.
3. One filesystem task with an honest declared capability.
4. One deterministic local-HTTP task with an honest declared capability.
5. One structured-concurrency task.
6. One standard-package task.
7. One local refactor/edit task.
8. One capability-violation trap with an independently verified rejection
   oracle.

Use hidden edge cases and generated fixtures so passing is not equivalent to
copying a textbook implementation. Keep starter completeness and quick-reference
token counts within a predeclared band. The Scala security arm must execute
against TACIT's safe capability wrappers; `language.experimental.safe` around
direct global stdin/stdout is not a valid substitute.

Run a minimum of five fresh attempts per task template, arm, and model family,
balanced across its frozen instances. Before a
GO can be declared, expand the run until there are at least 100 paired
ordinary-task observations per arm and model family. Report paired task-level
bootstrap intervals and preserve every request, response, emitted source file,
compiler diagnostic, and test output.

Primary metrics:

- one-shot success;
- iterations-to-green, counting the first emission as iteration 1;
- false-friction rate on non-trap tasks;
- capability-violation catch rate on trap tasks.

Secondary metrics:

- input and output tokens separately;
- elapsed time to green, with toolchain warm-up excluded from scored runs;
- emitted source size and diff size for edit tasks;
- provider/model identity, sampling policy, compiler versions, and API errors;
- human interventions (confirmatory runs require zero).

## 2026-07-15 Sonnet 5 harness pilot

This pilot used `claude-sonnet-5`, three seed tasks, one fresh attempt, three
arms, and up to three repair iterations. It is a harness check only: two tasks
counted toward ergonomics and the nominal trap did not provoke a capability
violation.

| Arm | Ordinary one-shot | Mean iterations | Input tokens, all 3 | Output tokens, all 3 | Trap rejection |
| --- | ---: | ---: | ---: | ---: | ---: |
| Sailfin | 2/2 (100%) | 1.0 | 2,461 | 3,787 | 0/1 |
| Scala capture checking | 2/2 (100%) | 1.0 | 1,714 | 588 | 0/1 |
| Python | 2/2 (100%) | 1.0 | 1,430 | 389 | 0/1 |

Observed facts:

- Every arm passed every seed task on the first emission, producing a ceiling
  effect and a zero-point Sailfin advantage.
- Sailfin consumed about 3.4 times Python's total tokens and 2.7 times Scala's
  total tokens in this pilot. Most of the difference was Sailfin output.
- Sailfin emitted 3,450 characters for the two ordinary solutions, compared
  with 808 for Scala and 715 for Python.
- No effect/capability rejection occurred. The current stable-hash task tests
  deterministic implementation behavior, not an attempted authority escape.
- The checked-in Scala starter originally enabled safe mode while calling
  global stdin/stdout. Scala 3.8.4 rejects that scaffold independently of model
  quality. The pilot therefore used capture checking without TACIT safe-mode
  wrappers and cannot satisfy SFN-350's decisive baseline.

Interpretation: **MURKY, with negative ergonomic signals; no language GO/NO is
justified.** The immediate NO-GO applies to the current benchmark design, not
to Sailfin itself. Running more repetitions of these three tasks would measure
the same ceiling effect rather than answer SFN-350.

## 2026-07-15 balanced-pilot correction

The first balanced pilot paired `claude-sonnet-5` with `gpt-4.1`. Its OpenAI
half is excluded from the language decision because GPT-4.1 predates Sonnet 5
by more than a year and is not a contemporary replication family. The
internally controlled Sonnet 5 observations remain directional pilot evidence:
Sailfin reached 33.3% one-shot success across nine ordinary templates, versus
88.8% for Scala + TACIT and 100% for Python, but one attempt per template is
not enough to authorize GO or NO.

The replacement OpenAI family is `gpt-5.6-terra`, selected as the current
strong intelligence/cost tier closest to Sonnet. Its Chat Completions request
freezes reasoning effort at `medium`, uses `max_completion_tokens`, and omits
temperature. Historical GPT-4.1 artifacts remain pilot history and must not be
pooled with the replacement run.

Fresh non-scored schema probes passed for the rotated credentials and exact
model IDs `gpt-5.6-terra` and `claude-sonnet-5` on 2026-07-15.

These probes validate response shape only; they do not prove that the account
is authorized for full task requests or repair turns. The bounded paid
three-arm probe is the authorization gate. An authentication/permission or
quota/billing failure invalidates the run for GO/NO use, preserves the failed
attempt and provider artifacts, and stops further paid observations.

Status remains **MURKY with negative Sonnet signals; language decision not yet
authorized**.

## Remaining pre-registration gates

- Merge the Terra request schema, credential-transport hardening, corrected
  `sfn/strings` guidance, and the updated model freeze.
- Run one non-confirmatory paid task per arm with Terra, then a fresh balanced
  10-template Terra pilot with zero human intervention.
- Compare Terra with the preserved Sonnet 5 pilot. Only schedule the
  confirmatory repetitions after the paired model families are technically
  valid and the benchmark is frozen on a clean commit.
- Resolver prerequisite satisfied by SFN-352 (`f073fb1f`); future runs must be
  based on `f073fb1f` or later.

## 2026-07-15 `sfn/strings` follow-up

The local-helper guidance was retested after resolver fix `64457e5d` (SFN-348).
The result is cwd-dependent:

- From the repository root, a standalone source under `build/` importing
  `trim`, `split`, and `join` passes check, build, direct execution, and
  `sfn run`. The dedicated SFN-348 regression also passes.
- From inside the isolated task directory—the cwd used by the benchmark
  grader—the same source passes `sfn check` but `sfn run` fails LLVM lowering
  because the imported callee signatures are unknown.

A discarded Sonnet 5 probe with the workaround removed reduced the logic
submission from the prior pilot's 1,649 source characters and 2,695 total
tokens to 814 source characters and 1,503 tokens. The I/O submission fell from
1,801 characters and 2,332 tokens to 532 characters and 1,012 tokens. However,
both failed at runtime compilation, as did the otherwise unchanged trap after
the model opportunistically imported `trim`. This supports the token-overhead
hypothesis but does not improve ergonomics until the isolated-cwd resolver path
is fixed or the benchmark adopts an explicit project compilation model.

Resolution: SFN-352 merged as `f073fb1f`; the frozen corpus and future model
runs must use that commit or later.
