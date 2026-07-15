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

## Remaining pre-registration gates

- Implement and freeze the 10 templates, 30–50 instances, and hidden graders.
- Integrate the installed TACIT 0.2.1 capability library/server as the Scala
  security baseline.
- Add a second model family credential/adapter or an equivalent independently
  served model family.
- Add repeat/seed orchestration and paired statistical analysis.
- Blind code-quality review and publish the full failure corpus.

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
