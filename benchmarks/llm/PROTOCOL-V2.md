# Sailfin agent benchmark protocol v2

Protocol ID: `sfn-agent-benchmark/v2.7.0`

Status: **frozen and unexecuted. Version 2.7.0 enforces the Anthropic answer
headroom in the request schema before any paid execution. The preceding v2.6
batch is audit-only — it stopped on provider quota and Anthropic response-budget
invalidations and produced no complete valid paired output**.

The resumed v2.6 bounded batch demonstrated that the recorded 2,048-token
Anthropic answer headroom was descriptive rather than enforced: a repair turn
returned `stop_reason=max_tokens` with 8,191 thinking tokens, no text, and an
8,192-token total allowance. SFN-383 raises the request schema to enforce the
headroom (section 2), bumps the protocol/corpus minor version, and freezes a
completely fresh balanced batch under v2.7.0. No v2.6 observation is eligible
for selection, rerun, or pooling into that successor, and no successor paid
batch may start before v2.7.0 is frozen.

Version 2.7.0 makes the Anthropic answer headroom enforced rather than
descriptive. The request now sets `thinking.budget_tokens` to 6,144 —
`max_tokens` (8,192) minus the 2,048-token reserved answer headroom — so
extended thinking cannot allocate the entire output allowance and leaves room
for answer text on both initial and repair turns. The run manifest records the
enforced `thinking_budget_tokens` under `anthropic_response_budget`. Because
this changes a request setting, it starts a fresh pilot and corpus ID
`sfn-agent-benchmark-corpus/v2.7.0`; no v2.6.0 attempt, success, or failure may
be reused, rerun, or pooled into the corrected run, which is a fresh balanced
batch across every arm and model family. The estimands, prompts, tasks, arms,
attempt counts, graders, thresholds, model families, and every other stopping
rule are unchanged.

Version 2.6.0 freezes symmetric transient-provider handling after the v2.5.0
Anthropic schema probe returned `overloaded_error`. Curl failures, timeouts,
rate limits, overloads, and service-unavailable responses are classified as
`transport_transient` for every provider path. Each logical request permits
three total provider attempts with 1,000 ms and 2,000 ms backoffs. Every raw
request, response, and retry decision is preserved. Exhaustion stops the
balanced batch and never enters a language denominator. This request and
stopping-policy change starts a fresh pilot and corpus ID
`sfn-agent-benchmark-corpus/v2.6.0`; v2.5.0 produced no scored output.

Version 2.5.0 applies the frozen structured-concurrency requirement to both
Track B arms before semantic execution. Sailfin-B requires `routine`,
`spawn fn() -> T { ... }`, and `await`; translated Rill-17 requires the
isomorphic `routine`, `spawn craft() -> T { ... }`, and `await` forms. Their
known-good fixtures retain the required structure, while output-equivalent
sequential fixtures fail with `missing_concurrency`. Correcting the Track B
grader starts a fresh pilot and corpus ID
`sfn-agent-benchmark-corpus/v2.5.0`; v2.4.0 produced no scored output.

Version 2.4.0 corrects the structured-concurrency treatment and grader. The
Sailfin arm now teaches the shipped `routine { ... }`,
`spawn fn() -> T { ... }`, and `await` surface; Scala and Python receive
equivalent scoped spawn/join guidance. Before semantic cases run, the grader
requires each Track A arm's frozen spawn/join structure. Its known-good fixtures
spawn and join work in input order, while output-equivalent sequential fixtures
fail with a distinct missing-concurrency diagnostic. This material and grader
change starts a fresh pilot and corpus ID
`sfn-agent-benchmark-corpus/v2.4.0`. Every v2.1.0 structured-concurrency
observation is ineligible for selection, rerun, or pooling; v2.2.0 and v2.3.0
produced no scored output.

Version 2.3.0 replaced aliased task clones with four independently allocated
prompts and hidden fixture sets per template. Each prompt has exactly one
instance marker, and the corpus manifest records distinct prompt and hidden-
fixture SHA-256 identities within every template. That corpus validity repair
started a fresh pilot. No v2.1.0 observation may be selected, rerun, or pooled
with a corrected corpus.

Version 2.1.0 replaced the unusable OpenAI Chat Completions transport with the
Responses API before any scored output was collected. The v2.0.0 preflight is
invalid setup evidence only and cannot be pooled with v2.1.0.

Version 2.2.0 freezes the Anthropic response budget (section 2) so extended
thinking cannot consume the entire output allowance, and makes an Anthropic
`stop_reason: max_tokens` response with no answer text an explicit
provider-response invalidation that stops the paid batch immediately (section
6). This changes a request setting and a stopping rule, so it starts a fresh
pilot under a new minor version; no v2.1.0 attempt, success, or failure may be
reused, rerun, or pooled into the corrected run, and the corrected run is a
fresh balanced batch across every arm and model family, not a selective rerun
of the invalidated arms. The estimands, prompts, tasks, arms, attempt counts,
graders, thresholds, model families, and every other stopping rule are
unchanged.

Linear:
[SFN-362](https://linear.app/sailfin/issue/SFN-362/specbench-preregister-v2-adoption-and-controlled-learnability),
[SFN-367](https://linear.app/sailfin/issue/SFN-367/fixbench-stop-sonnet-thinking-exhaustion-from-invalidating-v2-batches),
[SFN-383](https://linear.app/sailfin/issue/SFN-383/fixbench-enforce-anthropic-answer-headroom-on-every-response)

This preregistration separates two questions that the v1 experiment combined:

- **Track A — adoption readiness:** can a capable agent adopt Sailfin
  competitively today, including the real effects of pretrained familiarity,
  documentation, libraries, diagnostics, and toolchain reliability?
- **Track B — controlled learnability:** when prior exposure and supplied
  learning material are controlled as far as practicable, can a capable agent
  learn and use Sailfin's task-relevant design?

No metric in one track is evidence for the other track. Neither track measures
voluntary human adoption, product demand, willingness to pay, or company
viability. Those questions require the later external-adoption test.

SFN-350 and its checked-in [v1 record](EXPERIMENT.md) are historical pilot
evidence only. Their prompts, paid outputs, and scored observations must not be
pooled with, substituted for, or used to tune against v2 confirmatory data.

## 1. Freeze and change control

Every pilot and confirmatory run manifest must record:

- this protocol ID, the repository commit, and the SHA-256 of this file;
- corpus, grader, packet, scaffold, compiler, runtime, comparator, and harness
  versions and hashes;
- exact provider model IDs, API/request settings, model-family labels, and run
  seed;
- every arm, task instance, attempt ID, exclusion, ablation assignment, and
  stopping event.

Real provider execution fails closed when the repository is dirty. The
recorded commit, protocol hash, and harness hash must identify the exact code
used for every setup, pilot, and confirmatory request.

A wording-only correction that cannot change execution or interpretation may
increment the patch version. Any change to an estimand, arm, task, packet,
grader, model, attempt count, exclusion, threshold, or stopping rule increments
the minor version and starts a new pilot. Confirmatory data collected under
different minor versions cannot be pooled. No protocol change may be justified
by inspecting hidden tests or scored outputs from the version it changes.

Paid provider calls are allowed only for the bounded pilot sequence in section
9 until that sequence authorizes confirmatory execution. A schema or
authorization probe is setup validation, not a scored observation.

## 2. Common experimental controls

### Models and attempts

Both tracks use two independently trained contemporary model families:

1. Anthropic: exact model ID `claude-sonnet-5`.
2. OpenAI: exact model ID `gpt-5.6-terra`, reasoning effort `medium`.

The OpenAI family uses `POST /v1/responses`, with the system prompt in
`instructions`, conversation turns in `input`, reasoning effort in
`reasoning.effort`, and no response storage. The Anthropic family uses
`POST /v1/messages`.

The frozen output budget leaves room for answer text after hidden reasoning.
The Anthropic request sets `max_tokens` to 8,192 and caps
`thinking.budget_tokens` at 6,144 — the total minus the 2,048-token reserved
answer headroom — so extended thinking cannot consume the entire allowance; the
run manifest records this enforced policy under `anthropic_response_budget`. The
same cap applies to schema, contamination, unscored, initial scored, and repair
requests, because every Anthropic request is built by the same request schema.
If an Anthropic response still returns `stop_reason: max_tokens` with no answer
text — extended thinking having exhausted its capped budget without emitting an
answer — it is a provider-response invalidation under section 6, not a language
observation, and the paid batch stops immediately. Such a response never enters
any language denominator.

The frozen provider retry policy applies identically to schema probes,
contamination probes, unscored authorization tasks, scored tasks, all arms,
and both provider families. Only `transport_transient` responses are retried:
the initial request plus at most two retries, after 1,000 ms and 2,000 ms.
Authentication/permission, quota/billing, model-response, and response-budget
failures are not retried. Retry exhaustion stops the remaining balanced batch,
preserves every artifact, and cannot enter a language denominator.

The system prompt, sampling policy, output limit, repair limit, timeout policy,
task order randomization, and hidden-test visibility are identical across arms
within a track and model family. Each attempt begins in a fresh provider
conversation and receives no source or diagnostics from another attempt.
There is no human rescue inside an attempt.

The bounded pilot runs one attempt per frozen instance, arm, and model family.
If authorized, the confirmatory schedule runs five attempts per frozen
instance, arm, and model family, including the pilot attempt only when the
pilot caused no protocol, corpus, packet, grader, model, or toolchain change.
Otherwise all confirmatory attempts are fresh. The schedule is generated in
full before the first scored request.

An attempt permits the first emission plus at most four compiler-guided repair
iterations. Iteration 1 is the first emission. The attempt ends at the first
green grade, after iteration 5, or at the common wall-clock deadline, whichever
comes first.

### Task corpus

The corpus has ten templates and four independently allocated, frozen,
non-textbook instances per template. Hidden fixtures vary values and edge cases
without introducing an undeclared language feature or library operation. Every
prompt contains exactly one `[instance:<id>]` marker. Prompt and hidden-fixture
SHA-256 identities are distinct within a template and recorded in
`corpus.json`; the harness fails closed on cumulative markers, duplicate
fixture sets, or cross-instance mutation.

| Template group | Count | Primary purpose |
| --- | ---: | --- |
| Pure logic and data transformation | 2 | Ordinary |
| Parsing and CLI normalization | 2 | Ordinary |
| Honest filesystem and loopback HTTP | 2 | Ordinary capability use |
| Structured concurrency | 1 | Ordinary capability use |
| Standard-package use | 1 | Ordinary library use |
| Local edit/refactor | 1 | Ordinary maintenance |
| Unauthorized capability attempt | 1 | Trap, reported separately |

The same semantic task and hidden cases are used across arms when the arm can
express them. Starter code may differ only where required by the language.
The structured-concurrency template additionally requires frozen, symmetric
spawn/join structure before semantic output cases run. Track A Sailfin requires
`routine` plus `spawn fn() -> T { ... }` plus `await`; Scala requires scoped
executor submission, input-order future joins, and shutdown; Python requires
`asyncio.TaskGroup`, task creation, and input-order result collection. Track B
Sailfin-B requires the same Sailfin forms, while translated Rill-17 requires
`routine` plus `spawn craft() -> T { ... }` plus `await`. Missing structure is
reported separately from semantic output failure. Known-good and known-bad
fixtures must pass the offline grader audit before any provider call; the
concurrency known-bad is deliberately sequential but output-equivalent. A
trap succeeds only when the toolchain rejects unauthorized authority before
execution; trap outcomes never enter ordinary-success denominators.

The existing v1 templates may supply infrastructure, but v2 instance IDs,
prompts, and hashes are a new corpus version. Any v1 instance seen during
harness development is ineligible for v2 confirmation.

### Common recorded outcomes

Every iteration records emitted source, compiler/check/build/run output,
elapsed time, input and output tokens, source/diff size, timeout state, provider
response, and the machine-readable failure classification defined by SFN-364.
Raw artifacts are immutable. Selective reruns and deletion of failed attempts
invalidate the batch.

Provider authentication, permission, quota, billing, malformed-response, and
other setup failures are not language observations. They are excluded from all
language denominators and invalidate the affected scheduled batch; the failed
attempt and raw provider artifacts remain in the record. Transient service
errors after a valid request are reported, never silently retried, and make the
batch incomplete unless the frozen provider retry policy applies equally to
all arms.

## 3. Track A — present-day adoption readiness

### Estimand and arms

The Track A estimand is the paired difference in ordinary-task one-shot success
between Sailfin and each established baseline under realistic present-day
cold-start conditions. The arms are:

- Sailfin with the current public/task scaffold and current compiler/runtime;
- Scala 3 with the pinned TACIT capability wrappers;
- Python with its pinned interpreter and standard library.

Python and Scala keep all pretrained familiarity. That advantage is part of
the adoption condition, not a confound to remove. Sailfin receives realistic
project documentation, but no private tutoring or construct-by-construct
packet unavailable to a new adopter. The task prompt plus quick reference for
each arm must remain inside the predeclared 25% token band already represented
in the corpus manifest. Example counts differ only when an arm's ordinary
public guidance makes an example necessary; counts and token differences are
reported.

### Track A metrics only

Primary:

- paired ordinary-task one-shot success difference, Sailfin minus Python;
- paired ordinary-task one-shot success difference, Sailfin minus Scala/TACIT.

Guardrails:

- iterations to green among all ordinary attempts, with failures assigned 6;
- false-friction rate on ordinary tasks;
- capability catch rate on trap tasks;
- input/output tokens and wall-clock time, reported separately and never used
  to decide Track B.

Intervals are paired 95% bootstrap intervals over frozen task-template
clusters, stratified by model family. A Track A conclusion must hold in each
model family and against both baselines; a pooled result cannot rescue a failed
family or baseline.

For each baseline and family, classify the primary difference as:

- **large Sailfin advantage:** estimate at least +15 percentage points, lower
  interval bound above 0, no worse iterations-to-green, and false friction no
  more than 5 points worse;
- **parity:** the full interval lies inside the equivalence band [-10, +10]
  percentage points;
- **material Sailfin deficit:** estimate at most -15 points and the upper
  interval bound is below 0;
- **inconclusive:** every other result, including intervals too wide to meet a
  boundary.

Track A overall is a large advantage or parity only when that classification
holds against both baselines in both families. It is a material deficit if the
deficit boundary is met against either baseline in both families. Mixed-family
deficits and all other combinations are inconclusive. Guardrail failure
downgrades a nominal large advantage to inconclusive; it does not create a
positive result.

### Defects and exclusions in Track A

A Sailfin compiler rejection of a correct submission, check/build/run
divergence, crash, hang, runtime failure, missing primitive, or misleading
diagnostic is a failed adoption observation. It remains in every Track A
denominator because a present-day adopter experiences it. Equivalent baseline
toolchain failures are treated the same way.

An instance is excluded only when the language-independent task oracle or
hidden grader is proven wrong without reference to comparative arm results.
The entire instance is then excluded from every arm and family, the reason is
published, and the protocol/corpus version is bumped before replacement.

## 4. Track B — controlled learnability

### Estimand and arms

The Track B estimand is the paired difference in ordinary-task one-shot success
between packet-taught Sailfin and an unfamiliar, matched control after removing
observations whose task-relevant rule was absent from the supplied material or
whose known-good program failed in the implementation.

The arms are:

- **Sailfin-B:** the task-relevant Sailfin subset, taught solely by its frozen
  packet and examples;
- **Rill-17:** a nonce synthetic dialect of the same task-relevant semantic
  subset, taught solely by its frozen packet and examples.

Rill-17 is an experimental control, not a product competitor. Its keywords,
delimiters, built-in names, and effect notation are independently generated
and frozen; its types, evaluation rules, available primitives, authority
boundaries, and task expressiveness are isomorphic to Sailfin-B. It may not
gain a shorter solution path, stronger primitive, implicit conversion, hidden
default, or more permissive capability rule. Both arms use the same hidden
semantic oracle and matched known-good/known-bad fixtures.

Python and Scala do not enter the Track B primary contrast: their extensive
training-data and ecosystem advantage cannot be neutralized by equal prompt
tokens. Optional Python/Scala packet runs are labeled calibration only and may
not decide intrinsic learnability.

### Packet and example budget

Each Track B packet has these separately hashed sections:

1. lexical and grammar rules;
2. types, values, mutability, and control flow;
3. functions, errors/options, and effect/authority rules;
4. every task-available primitive with signature and behavior;
5. check/build/run commands and the meaning of permitted feedback;
6. examples and a construct-to-example index.

Packet prose is 1,800 to 2,200 tokenizer-normalized tokens per arm. Each arm
gets exactly six worked examples totaling at most 900 additional tokens. The
two totals must be within 5% after tokenization by each evaluated provider; if
one provider's tokenization violates the band, material is shortened rather
than padding the other arm with irrelevant text. Prompts, starter code, and
repair feedback are budgeted separately and matched within 5%.

Minimum task-relevant completeness is mechanical: for every accepted token,
construct, type rule, effect rule, primitive, command, and diagnostic action
used by a known-good solution, the packet contains a definition and at least
one indexed valid use. It also states every edge behavior tested by hidden
fixtures. A reviewer who has access only to the packet, public task prompt,
starter, and compiler feedback must be able to derive a known-good solution;
no hidden task-relevant syntax, API, convention, or ecosystem knowledge is
allowed.

Before scoring, a packet linter must show complete construct coverage and a
fresh model session must solve one unscored smoke instance per category using
only the packet. Failure means packet incompleteness, not model inability, and
blocks the scored pilot until a new packet/protocol version is frozen.

### Familiarity and ablations

Before showing either packet, each model receives blinded recognition probes
for Sailfin-B and Rill-17: identify the language, explain three surface forms,
and write a trivial program. Exact or substantively correct Rill-17 knowledge
above the chance/control rubric indicates prompt leakage or contamination and
blocks scoring under this version. Sailfin recognition is recorded as residual
pretrained familiarity, not erased.

SFN-364 implements separately randomized, balanced Track B ablations:

- concise packet versus the frozen expanded-example supplement;
- full diagnostics versus normalized minimal diagnostics;
- task primitive versus a packet-documented local implementation.

Ablations estimate documentation and feedback effects only. They are
secondary Track B analyses and cannot be pooled into the primary packet
condition or used to decide Track A.

### Track B metrics only

Primary:

- paired ordinary-task one-shot success difference, Sailfin-B minus Rill-17.

Secondary:

- iterations to green, with failures assigned 6;
- rate of rules present but not applied;
- rate of invented syntax/API and pretrained-language interference;
- ablation contrasts for examples, diagnostics, and primitives;
- packet input tokens and emitted output tokens.

Use the same family-stratified paired task-cluster bootstrap as Track A. For
each family, classify the primary difference as:

- **large Sailfin learnability advantage:** estimate at least +15 points and
  lower interval bound above 0;
- **learnability parity:** full interval inside [-10, +10] points;
- **material Sailfin learnability deficit:** estimate at most -15 points and
  upper interval bound below 0;
- **inconclusive:** every other result.

The Track B overall classification must agree across both model families.
Family disagreement is inconclusive. Secondary metrics explain the primary
result but cannot upgrade it.

### Defects and exclusions in Track B

Every red outcome first remains in the raw success result. Failure attribution
then distinguishes intrinsic use from implementation validity:

- a rule present in the packet but ignored or misapplied is a learnability
  failure and remains in the primary denominator;
- a task-relevant rule absent from the packet is a packet defect; the whole
  instance is invalid for both arms, and scoring stops pending a version bump;
- a correct known-good program rejected by a compiler/interpreter, a
  check/build/run divergence, crash, hang, or runtime defect is an
  implementation defect. The paired instance is excluded from the Track B
  learnability estimand for every arm, reported in a separate implementation
  reliability table, and cannot be replaced without a version bump;
- a missing or excessively awkward primitive is intrinsic when both matched
  subsets intentionally expose that design; it is an implementation defect
  when only one arm violates the frozen isomorphism.

Thus implementation defects count as real failures in Track A but do not
silently become evidence about intrinsic design in Track B.

## 5. Sample size and analysis

With nine ordinary templates, four instances, and five attempts per instance,
confirmation yields 180 ordinary observations per arm and model family. The
trap template yields 20 additional observations reported separately. This
exceeds the v1 minimum of 100 paired ordinary observations without optional
sample-size expansion.

Analysis follows the frozen schedule and reports estimates, intervals, raw
counts, task-cluster distributions, family-specific results, exclusions, and
all failure categories. There is no per-attempt replacement and no peeking to
stop for significance. Missing scheduled observations make the run incomplete;
they do not shrink the denominator opportunistically.

## 6. Stopping rules

Stop the affected batch immediately when any of these occurs:

- provider authorization/setup invalidation or an unfrozen model response,
  including an Anthropic `stop_reason: max_tokens` response with no answer text
  (thinking-only response-budget exhaustion);
- evidence of prompt/hidden-test leakage or Rill-17 contamination;
- a wrong grader, packet-completeness failure, or mismatched arm semantics;
- an unresolved known-good check/build/run divergence;
- loss of artifact capture, attempt identity, or schedule integrity;
- the predeclared paid-call or cost ceiling is reached.

The stop is triggered by the first such event: the remaining scored schedule is
not purchased. Preserve all artifacts and label the batch invalid or
incomplete. Fixing the cause requires the applicable version bump and a fresh
balanced batch across every arm and model family — never a selective rerun of
only the invalidated attempts or arms. Do not continue unaffected arms to
manufacture an unpaired result.

Ordinary provider errors covered by a frozen, arm-independent retry policy do
not trigger a stop. There is no efficacy, futility, or significance stopping
rule. Confirmation runs the complete schedule or remains incomplete.

## 7. Threats to validity

- **Pretrained familiarity:** Python and Scala have a large training-data and
  ecosystem advantage. It is deliberately retained in Track A and is why they
  cannot be intrinsic controls in Track B. Sailfin may also have residual
  public-corpus exposure, measured by recognition probes.
- **Prompt leakage:** public task text, packet material, or prior attempts may
  leak hidden solutions. Fresh conversations, blinded probes, immutable
  artifacts, and non-textbook generated instances reduce but do not eliminate
  this risk.
- **Documentation incompleteness:** a missing rule can masquerade as poor
  learnability. The completeness index, known-good audit, and packet-only smoke
  gate turn it into a protocol defect rather than a scored Track B failure.
- **Synthetic-control fidelity:** Rill-17 may accidentally be easier or harder
  than Sailfin-B. The isomorphism audit, matched primitive inventory, solution
  size comparison, and symmetric graders are required before scoring.
- **Model contamination:** a provider may have seen Sailfin, Rill-17, or v2
  artifacts during training or retrieval. Pre-packet recognition probes are
  recorded, and positive Rill-17 contamination invalidates the version.
- **Benchmark overfitting:** maintainers and prompts may become tuned to the
  frozen corpus. Pilot-tuned instances cannot enter confirmation; hidden
  generated fixtures and a version bump are required after task-level tuning.
- **Model-family dependence:** two families are not the full model population.
  Results are claims about the frozen families, and family disagreement is
  inconclusive.
- **Packet-token equivalence:** equal length does not guarantee equal clarity
  or information density. Construct coverage and matched examples supplement,
  but do not solve, this limitation.
- **Implementation mediation:** compiler/runtime quality is inseparable from
  adoption but separable from the narrower learnability estimand. Both raw and
  attributed tables are therefore mandatory.

## 8. Decision matrix and claims

The technical classifications authorize only these next steps:

| Track A | Track B | Technical interpretation | Next action |
| --- | --- | --- | --- |
| Advantage/parity | Advantage/parity | Present-day technical viability and controlled learnability both supported | Proceed to the external-adoption test; make no product claim yet |
| Material deficit | Advantage/parity | Promising design with a cold-start, distribution, documentation, ecosystem, or implementation problem | Continue only with a credible bootstrap strategy, then rerun Track A before external adoption |
| Advantage/parity | Material deficit | Adoption result may be memorization, prompt, tooling, or ecosystem leverage rather than intrinsic design | Do not claim agent-first design; audit mediation before any external test |
| Material deficit | Material deficit | Agent-first language-product thesis is not supported | Close that thesis; preserve Sailfin as an open-source asset or technical substrate |
| Any inconclusive result | Any | Technical evidence is unresolved | Improve measurement under a new version; do not proceed on a GO narrative |

Even when both technical tracks win, Sailfin is only a candidate for external
adoption testing. A language-product or company claim additionally requires an
unrescued first task by people who did not design Sailfin, voluntary return for
a second task, and concrete economic pull. A technical win without external
pull describes a language project, not yet a business.

## 9. Bounded-pilot authorization gate

Run these steps in order:

1. Pass offline grader fixtures, packet completeness, Rill-17 isomorphism,
   contamination probes, provider schema/authorization gates, timeout tests,
   and manifest/hash checks.
2. Run one unscored provider task per arm and model family.
3. Run Track A once per frozen instance, arm, and family.
4. Run Track B once per frozen instance, arm, and family.
5. Publish both tracks separately with the full failure corpus and exclusions.

The ordinary-task ceiling/floor check is predeclared per track, arm, and model
family. A pilot has useful variance only when ordinary one-shot success is
between 10% and 90% inclusive and at least two task templates contain both a
pass and a failure across attempts/instances. Any arm above 90%, below 10%, or
with fewer than two varying templates triggers a task-difficulty review and a
new corpus/protocol version; repeating the same easy or impossible tasks is
not authorized.

Confirmation is authorized only if both pilots have useful variance, stable
graders, complete paired schedules, zero human rescue, no setup invalidation,
no unresolved known-good toolchain divergence, no packet/isomorphism defect,
and interpretable family-specific results. Authorization freezes the exact
commit and hashes used by the confirmatory schedule. Otherwise the decision is
to reject confirmatory spend under this version.
