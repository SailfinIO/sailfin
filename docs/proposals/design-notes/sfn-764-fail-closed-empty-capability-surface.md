# SFN-764 — an explicit `required = []` must deny, not disable

Single-issue implementation design gate. **Design only — no compiler code
written.** Not an SFEP: this restores an enforcement rule that
SFEP-0008 §4.6 already specifies and that spec §7 item 5 already documents; it
adds no language feature, no ABI, and no toolchain surface.
`.claude/rules/proposals.md` puts that below the SFEP bar. The in-tree
precedent for the genre is exact —
[`1627-fail-closed-raw-unknown-effects.md`](./1627-fail-closed-raw-unknown-effects.md),
a fail-closed flip of an effect-checker escape hatch, extending SFEP-0008,
recorded here rather than as a new SFEP.

- **Issue:** `SFN-764` — should `[capabilities] required = []` mean "requires no
  capabilities" (fail-closed) or "skip the cross-check" (fail-open)?
- **Design record extended:** SFEP-0008 (`../0008-effect-validation.md`) §4.6,
  §6.6; forward-referenced by SFEP-0016 (`../0016-capability-sealed-runtime.md`)
  §3.2.
- **Author:** agent:compiler-architect
- **Status:** Accepted — design gate passed 2026-08-21; implemented under SFN-764
- **Date:** 2026-08-21

**Could not verify:** the Linear issue body. No `mcp__Linear__*` tool was
reachable from this session (`mcp__Linear__get_issue` and
`mcp__linear-server__get_issue` both resolved to "No such tool available").
Every statement attributed to SFN-764 below comes from the triage brief, not
from Linear directly. The two source facts the brief cites were independently
re-verified against the working tree and are quoted with line numbers in §1.

---

## 1. Current state

### 1.1 The early return

`compiler/capsules/analyzer/src/effect_checker/validations.sfn:17-19`:

```
fn validate_capsule_capabilities(program: Program, capabilities_required: string[]) -> CapabilityViolation[] {
    let mut violations: CapabilityViolation[] = [];
    if capabilities_required.length == 0 { return violations; }
```

`compiler/capsules/analyzer/src/effect_checker/mod.sfn:31-33` is now a thin
re-export facade; the brief's citation of `compiler/src/effect_checker/` is the
pre-decomposition path.

### 1.2 The overloaded sentinel

`compiler/src/toml_parser.sfn:680-697` documents the collapse explicitly:

> An empty list means either: the manifest declares `required = []` (no
> capabilities granted); the manifest has no `[capabilities]` section at all;
> the input text isn't a capsule manifest […] All three resolve to the same
> caller behaviour: skip the capability cross-check.

`string[]` is doing two jobs — *the surface* and *whether a surface exists*.
Every downstream consumer inherits the ambiguity because every one of them
carries only the list. That is the whole bug; everything else in this note
follows from separating the two.

Two more callers hard-code the same reading in prose that must change with the
code: `compiler/src/effect_gate.sfn:111-119` and
`compiler/capsules/analyzer/src/effect_checker/scope.sfn:319-329`.

### 1.3 What the specification already says

SFEP-0008 §4.6 states the rule with **no** empty-list carve-out:

> Read `[capabilities] required`. For each function declaration in the capsule,
> ensure `signature.effects ⊆ capabilities.required`.

Spec §7 item 5
(`site/src/content/docs/docs/reference/spec/07-effects.md:34`) grants exactly
one exemption, and it is the *absent* case:

> Empty surface (**no `[capabilities]` section**, or standalone .sfn outside any
> capsule) skips the cross-check so pre-Phase-F projects keep building.

Neither document exempts an explicit `required = []`. The fail-open behaviour
for the explicit-empty case is an implementation shortcut that overshot the
documented rule, not a designed exemption. `sfn/sync`'s manifest comment shows
authors already read it the specified way:

> Empty by design: this capsule has no code, so it needs no capability. A
> manifest that over-claims on an empty capsule undercuts the Reach pillar's
> claim that Sailfin manifests are tight (SFEP-0063 Phase 0).

That capsule is asking for an enforcement the compiler silently declines to
perform.

### 1.4 Where the check actually runs

Three live paths, all fed from one anchor:

| Path | Surface source |
|---|---|
| `sfn build` / `sfn run` | `compiler/src/capsule_resolver/dedupe.sfn:446` — root project manifest, guarded by `fs.exists` |
| `sfn check` | `compiler/src/check/engine.sfn:383` — per-group, groups partitioned by `(project_root, workspace_root)` |
| `sfn test` | `compiler/src/cli/commands/test/discovery.sfn:432` → `single_process_run.sfn:286` → `main.sfn:607` |

A fourth path, `workspace_member_capability_gate`
(`compiler/src/capsule_resolver/capability.sfn:42`), runs the same check over
every workspace **implicit provider**. It is **dormant in this tree**: no live
`capsule.toml` declares `[build] implicit = true` (only
`compiler/tests/unit/fixtures/repository_topology/target/stdlib/prelude/`
does). This matters for blast radius — it means `make compile` does not today
apply any capsule's ceiling except the root `compiler` capsule's.

Severity is env-graded through `SAILFIN_EFFECT_ENFORCE`
(`effect_gate.sfn:60-70`, default `error`), so `=warning` is an existing
downstream escape valve for any project this change surprises. Note
`capability.sfn:60` hard-codes `severity = "error"` and bypasses that contract —
an inconsistency worth fixing when the implicit-provider gate goes live, out of
scope here.

---

## 2. Recommendation

**Fail-closed for an explicit `[capabilities]` section; fail-open only when no
section exists.** Split the overloaded `string[]` into a declared-flag plus the
list, and let the flag — not the length — decide whether the check runs.

**The main tradeoff, plainly:** fail-closed costs exactly **two manifest edits**
today (`runtime/capsule.toml`, `capsules/sfn/crypto/capsule.toml`) and buys the
Reach pillar its completeness claim; fail-open costs nothing today and makes the
claim false the moment SFEP-0016 derives a syscall mask from a manifest that can
silently mean "everything." The cost side is a one-PR number, not a migration,
because the survey in §4 found only one under-declared library and one
under-declared runtime. That asymmetry is what decides it.

The `capsule.toml` schema does not change. Neither does the diagnostic code
(`E0403`) or its rendering — a deny-all surface renders as
`outside capsule capability surface ![]`, which reads correctly.

---

## 3. The three states, resolved

The question "should absent, explicit-empty, and unparseable be three distinct
behaviours?" resolves to **two enforcement modes plus one hard error**, because
"unparseable" is not a state the parser can observe at the granularity the
question assumes.

| Manifest state | Meaning | Behaviour |
|---|---|---|
| No `capsule.toml` in scope (`sfn check foo.sfn`, standalone file) | undeclared | skip — unchanged |
| `capsule.toml` present, no `[capabilities]` section | undeclared | skip — unchanged in this change; see §7.1 |
| `[capabilities]` present, `required = []` | **declared empty** | **fail-closed** — every declared effect is `E0403` |
| `[capabilities]` present, `required` key absent | **declared empty** | **fail-closed** — same as above |
| `[capabilities]` present, `required = [...]` non-empty | declared | unchanged |
| `capsule.toml` present but not parseable as a capsule manifest | broken | **hard error `E0407`** — never "allow everything" |

### 3.1 Why "unparseable" mostly is not a separate case

`toml_parser.sfn` is a hand-rolled line scanner, not a validating parser. There
is no "unparseable" verdict to read; there is only "the scanner did or did not
find what it was looking for." Concretely:

- **`[capabilities]` header not found** — indistinguishable from "absent," and
  correctly so. The new `declared` flag keys on exactly this.
- **Header found, `required` malformed** (unterminated array, wrong quoting,
  a value the array parser cannot split) — `_toml_parse_string_array` yields a
  short or empty list. Under fail-open that silently authorizes everything;
  under fail-closed it produces a **storm of `E0403`s naming every effect the
  author expected to be granted**. That is loud, immediately diagnosable, and
  fails in the safe direction. It needs no new machinery — fail-closed *is* the
  fix for this case.
- **Section misspelled** (`[capsule.capabilities]`, `[capability]`) — today,
  silent full authority. After the change, the section is absent so the check is
  skipped and the author's `required` list has no effect. **This is the one edge
  the declared-flag alone does not close**, and it is the reason for `E0407`
  below.

### 3.2 The residual hole, and `E0407`

The genuinely dangerous residue is *"a file exists at `capsule.toml`, the
resolver treats it as a capsule manifest, and the scanner extracted nothing
meaningful from it."* Today that degrades to "no capabilities declared, allow
everything." A truncated write, a merge conflict marker, a YAML file, or a
misspelled section header all land here.

Close it at the root rather than in the capability path: **if
`<project_root>/capsule.toml` exists but `toml_get_name(text)` is empty, that is
a hard error, not a manifest with no capabilities.** A capsule whose manifest
cannot be read is not a capsule.

- New code **`E0407`** — "capsule manifest at `<path>` is present but not
  parseable (`[capsule] name` missing)". `E0407` is free; the `E04xx` range
  ledger is `docs/style-guide.md:223` and must be updated in the same PR.
- Emitted from the root-manifest read in
  `compiler/src/capsule_resolver/dedupe.sfn:434-447`, where `fs.exists` already
  guards.
- `load_workspace_members` (`capsule_resolver/workspace.sfn:245-250`) already
  prints a similar message and *skips the member*, which is the same fail-open
  shape one level up. Converting that skip into `E0407` too is a small, obvious
  extension; it is in scope for this PR only if it is free, otherwise record it
  as a follow-up. Do not let it grow the diff.

This is the sharpest edge the brief identified, and it is worth closing in the
same PR: the two changes share one anchor point and one test file, and splitting
them would ship a fail-closed capability rule with a fail-open way to bypass it.

---

## 4. Blast radius (surveyed 2026-08-21, working tree at `8a3acb16`)

Method: every `capsule.toml` outside `.claude/worktrees/`, `build/`, `dist/`;
effect-declaring routines counted as lines matching
`^\s*(export )?(async )?fn ` or `^\s*test "` that also contain `![`.

### 4.1 Capsules declaring an explicit `required = []` — 15

**Conforming already (13). Zero effect-declaring routines; gain real
enforcement at zero cost:**

`capsules/sfn/json`, `capsules/sfn/losses`, `capsules/sfn/math`,
`capsules/sfn/path`, `capsules/sfn/strings`, `capsules/sfn/sync`,
`capsules/sfn/toml`, `compiler/capsules/analyzer`,
`compiler/capsules/codegen`, `compiler/capsules/codegen-llvm`,
`compiler/capsules/ir`, `compiler/capsules/syntax`,
`compiler/tests/fixtures/p1_user_capsule`.

(Two resolver-topology fixtures under
`compiler/tests/unit/fixtures/repository_topology/` also declare `required = []`
and contain no compiled `.sfn`; they are inert.)

**Newly failing (2):**

| Capsule | Effect-declaring routines | Required edit |
|---|---|---|
| `runtime/` | **213** functions in `runtime/sfn/` (146 `![io]`, 47 `![net]`, 7 `![clock]`, 5 `![net, io]`, 4 `![rand]`, 4 mixed) plus 4 in `runtime/prelude.sfn` | `required = ["clock", "io", "net", "rand"]` |
| `capsules/sfn/crypto/` | 4 functions (`trust_store.sfn:244,324,355` `![io]`; `rand.sfn:35` `![rand]`) and 13 `test` blocks (`![clock]`, `![io]`, `![rand]`) | `required = ["clock", "io", "rand"]` |

### 4.2 Capsules with no `[capabilities]` section — 13 live + resolver fixtures

All 13 are `compiler/tests/e2e/fixtures/*/`, and **each has exactly one
effect-declaring routine** (`fn main() ![io]`, e.g.
`compiler/tests/e2e/fixtures/export_from/main.sfn:15`). They are unaffected iff
absent stays distinct from explicit-empty — which is precisely why §3 keeps them
distinct. Treating absent as fail-closed would break all 13 *and* every user
program that has not yet written a `[capabilities]` block, for no security gain
this cycle.

### 4.3 Which commands break before the manifest fix

- `make check-fast` — runs `sfn check` over `compiler/src/ compiler/capsules/
  runtime/` (`Makefile:761`). Groups partition by project root, so `runtime/`
  is checked against `runtime/capsule.toml`. **Fails on 213 functions** until
  the manifest is fixed.
- `sfn test capsules/sfn/crypto` — **fails on 17 routines** until fixed.
- `make compile` — **unaffected.** Root is `compiler`, whose surface is
  `["clock", "io", "net"]` and unchanged; the implicit-provider gate is dormant
  (§1.4).
- `make check` — passes once the two manifests are fixed.

### 4.4 Verdict

**One PR, not a migration.** Two manifest edits, both honest improvements to
manifests that are currently wrong.

---

## 5. Design

### 5.1 Separate the flag from the list

Add `capabilities_declared: boolean` alongside every existing
`capabilities_required: string[]`, computed once at the manifest read and
threaded on the identical path. `validate_capsule_capabilities` keys its
early return on the flag, not on `.length`.

Two alternatives were considered and rejected:

- **Nullable list (`string[]?`, `null` = undeclared).** More elegant and it
  makes the invariant unmissable, but it changes the shape of a field on
  `AnalyzerInput`, which crosses the analyzer capsule's `.sfn-asm` interface
  boundary. Nullable-array support through that boundary in the pinned seed is
  an unnecessary risk for a semantics fix. A sibling boolean is additive and
  boring; boring wins.
- **A magic sentinel in the list** (resolver returns `["pure"]` for
  declared-empty, so the list is non-empty and `pure` authorizes nothing). A
  one-line change, and wrong: the same `string[]` is read by
  `compute_runtime_demand` (`build/runtime_selection.sfn:213-221`, which would
  call `effect_root("pure")`), by `_cr_union_effects` in the workspace drift
  audit (which would then report `pure` as drift against every `allow` list),
  and by `sfn add` (`cli/commands/add.sfn:403-405`, which would write
  `required = ["pure"]` into consumer manifests). A sentinel smuggled through a
  shared value type leaks into every consumer.

### 5.2 The check itself

`validations.sfn:17-19` becomes:

```
fn validate_capsule_capabilities(program, capabilities_required, capabilities_declared) {
    let mut violations = [];
    if !capabilities_declared { return violations; }
    // ... unchanged walk
}
```

`_analyze_routine_capabilities` needs **no change**. Its `pure`-standalone
carve-out (`validations.sfn:94-99`) already lets `![pure]` through regardless of
the surface, which is the correct behaviour under a deny-all ceiling: `pure` is
the empty effect set, not a capability. Verify this with a test rather than
assuming it.

### 5.3 Manifest fixes, same PR

**`runtime/capsule.toml`** — replace the current comment (which claims the
runtime "carries no Sailfin-effect surface," now demonstrably false) with
`required = ["clock", "io", "net", "rand"]` and a comment stating the honest
position: the runtime is the trusted computing base, its ceiling is the full
canonical taxonomy by construction, and SFEP-0016 §3.4 class 2 already treats
owned runtime objects as a distinct provenance class rather than something the
capsule ceiling confines. A ceiling equal to the taxonomy constrains nothing —
say so, rather than letting a reader infer tightness that is not there.

**`capsules/sfn/crypto/capsule.toml`** — `required = ["clock", "io", "rand"]`.
`io` is real (`trust_store` reads a CA bundle from disk); `rand` is real
(`random_bytes` over `getentropy`). **`clock` is test-only** — six timing-budget
and X.509-validity `test` blocks — and the comment must say so and cite the
follow-up in §7.2. This is the one place where fail-closed inflates a shipped
manifest, and it should be visible in the manifest rather than buried here.

### 5.4 Comments that encode the old rule

Three prose blocks state the fail-open rule and become wrong; update them in
the same PR or they will be cited as authority later:

- `compiler/src/toml_parser.sfn:680-694`
- `compiler/src/effect_gate.sfn:111-119` and `:154-155`
- `compiler/capsules/analyzer/src/effect_checker/scope.sfn:319-329`

---

## 6. Files affected, by pipeline stage

**Manifest parsing**
- `compiler/src/toml_parser.sfn` — new `toml_has_capabilities_section(text) ->
  boolean` (or `toml_capabilities_declared`); rewrite the `:680-694` comment.

**Resolver / driver**
- `compiler/src/capsule_resolver/dedupe.sfn` — `:409` local, `:434-447` read
  site (also the `E0407` emit point), `:600`, `:637`, `:783` construction sites.
- `compiler/src/capsule_resolver/types.sfn:288,315` — add the field to both
  resolved-project structs.
- `compiler/src/capsule_resolver/mod.sfn:612-711` — five exit paths.
- `compiler/src/capsule_resolver/check.sfn:62,75,96,130`.
- `compiler/src/capsule_resolver/reachability.sfn:679`.
- `compiler/src/capsule_resolver/capability.sfn:45,56,339` — the dormant
  implicit-provider gate; thread the flag so it is correct when it wakes.
- `compiler/src/capsule_resolver/workspace.sfn:245-250` — `E0407` extension, if
  free.

**Check / test drivers**
- `compiler/src/check/engine.sfn:75,292,383,452` — `CheckGroup`.
- `compiler/src/tools/check.sfn:50-102` — `analyzer_input_for_check`,
  `check_source_with_imports`; the single-file path at `:92` passes
  `declared = false`.
- `compiler/src/cli/commands/test/discovery.sfn:139,326,432`.
- `compiler/src/cli/commands/test/single_process_run.sfn:286`.

**Effect gate**
- `compiler/src/effect_gate.sfn:105-106,120,155`.
- `compiler/src/main.sfn:573,607`.

**Analyzer**
- `compiler/capsules/analyzer/src/analyzer.sfn:43,111` — `AnalyzerInput`.
- `compiler/capsules/analyzer/src/effect_checker/mod.sfn:31-33` — facade.
- `compiler/capsules/analyzer/src/effect_checker/validations.sfn:17-19` — the
  rule.
- `compiler/capsules/analyzer/src/effect_checker/scope.sfn:319-329` — comment.

**Diagnostics**
- `docs/style-guide.md:223` — register `E0407` in the `E04xx` row.
- `compiler/src/diagnostics_render.sfn` / `capsule_resolver` — `E0407`
  rendering, following the existing `E0406` envelope-diagnostic shape in
  `capsule_resolver/capability.sfn`.

**Manifests**
- `runtime/capsule.toml`, `capsules/sfn/crypto/capsule.toml`.

**Docs**
- `site/src/content/docs/docs/reference/spec/07-effects.md:34` — replace
  "Empty surface … skips the cross-check" with the §3 table.
- `docs/status.md:804,1049` — note that an explicit empty surface denies.
- `docs/proposals/0008-effect-validation.md` §4.6 — annotate that the
  empty-list early return is removed and the specified rule now holds
  unconditionally.

**Tests**
- `compiler/tests/unit/effect_capabilities_test.sfn:87-99` — these two tests
  currently *pin the fail-open behaviour* ("The fast-path early-return for empty
  `capabilities_required`…"). They must be rewritten, not deleted: one asserts
  `declared = false` still skips, the other asserts `declared = true` with an
  empty list produces `E0403`. Add a third for `![pure]` standing alone under a
  deny-all surface producing no violation.
- `compiler/tests/unit/compiler_capsule_boundary_test.sfn:357` — asserts
  `toml_get_capabilities_required(manifest).length == 0` for some manifest;
  re-read and re-anchor on the declared flag.
- New: an `E0407` unit test over a garbage `capsule.toml`.
- New e2e: a fixture capsule with `required = []` and one `![io]` function must
  fail `sfn build` with `E0403`; the sibling with no `[capabilities]` section
  must still build. Follow `.claude/rules/no-bash-e2e.md` and
  `compiler/tests/e2e/capability_cross_check_test.sfn`.

---

## 7. Interaction with SFEP-0016 and the manifest work

### 7.1 The seal makes fail-closed mandatory — this is "now or later," not "if"

SFEP-0016 §3.2 worked example: *"The resolved manifest is sealed into the
artifact; the syscall stubs consult the **derived mask**."* The mask is derived
from `[capabilities] required`. An empty `required` therefore has to derive
*something*, and there are only two candidates:

- **Empty mask** — the only coherent reading, and it is fail-closed. Every gated
  syscall from that capsule traps.
- **Full mask** — makes the seal vacuous for any capsule that declares nothing,
  i.e. makes the seal opt-in per capsule, which contradicts §3.1's rule that
  "an artifact whose tier cannot be determined is Unsealed."

So the seal forces the explicit-`[]` question closed. Deciding it now costs two
manifest edits; deciding it during SFEP-0016 implementation means discovering
mid-seal that the manifest semantics the mask derives from are fail-open, and
paying the same edits under a much heavier change. **Take it now.**

The **absent-section** case is the one the seal genuinely changes: under the
seal, "no `[capabilities]` section" cannot mean "unconstrained," because there
is no such tier. That flip is a 1.0 gate with a real migration (§4.2: 13
in-tree fixtures plus every user program), and it belongs to SFEP-0016's ladder,
not here. SFEP-0008 §6.6 already sketched the ramp and already allocated the
code: **`W0403`, warning-only, then flip to error.** The natural implementation
is free once §5.1 lands — when `declared == false`, run the same walk and stamp
`severity = "warning"` — so every undeclared capsule gets a preview of exactly
the `required` list it will need. Deliberately **not** in this PR: it puts a
warning on 13 e2e fixtures for no security gain this cycle, and it is a separate
decision with a separate audience.

### 7.2 Test-declared effects inflate the shipped surface

`_analyze_statement_capabilities` (`validations.sfn:33-50`) checks `test`
blocks against the same `required` ceiling as shipped functions. That is why
`sfn/crypto` must claim `clock` for six timing tests it never ships. It directly
contradicts the tightness principle `sfn/sync`'s manifest states, and under the
seal it would widen a real syscall mask on the most security-sensitive capsule
in the tree.

The fix is a `[capabilities] dev-required = [...]` key, unioned into the ceiling
**only** when analyzing a `TestDeclaration` — the exact precedent `sfn add`
already follows for dev-dependencies (`cli/commands/add.sfn:396-399`: *"Dev
dependencies are build/test-time only, so their capabilities are not folded into
the consumer's runtime surface"*). Absent `dev-required` means empty, so no
existing capsule changes behaviour.

**Not in this PR.** It is one effect on one capsule today, and adding manifest
schema ahead of a second instance is exactly the scope manufacture
`.claude/rules/seed-dependency.md` and the grooming discipline warn against.
File it with a concrete trigger: **when a second capsule needs a test-only
effect, or when SFEP-0016 Phase 1 starts deriving masks — whichever comes
first.** The crypto manifest comment must name that follow-up so the
over-declaration is not read as intended.

### 7.3 `sfn add` propagation widens consumers

`cli/commands/add.sfn:403-405` merges a dependency's `required` into the
consumer's manifest. After §5.3, `sfn add sfn/crypto` will stamp
`["clock", "io", "rand"]` onto the consumer, and `sfn/runtime-native` would
stamp the entire taxonomy. This is pre-existing behaviour meeting newly-honest
manifests, and it is in tension with SFEP-0008 §4.6's own statement that a
dependency's `clock` is "`bar`'s implementation detail" — a consumer needs the
effect only if it calls an API that declares it. Note it, do not fix it here;
it is a separate correctness question about `sfn add`.

### 7.4 The workspace envelope's parallel fail-open

`workspace_capability_envelope_active`
(`capsule_resolver/capability.sfn:389-399`) makes the SFEP-0051 Phase 4c
envelope opt-in via a **non-empty `allow`** — structurally the same fail-open
this note closes one tier down. It is deliberate and documented there, and it is
out of scope; but once the capsule tier is fail-closed, the workspace tier is
the remaining hole in the same claim and should be revisited with SFEP-0016.

---

## 8. Migration plan

Every step leaves a self-hosting compiler. **One PR** — the capability change
and the two manifest fixes cannot be split without leaving `make check-fast`
red between merges.

1. **Manifest honesty first, inside the PR.** Update `runtime/capsule.toml` and
   `capsules/sfn/crypto/capsule.toml`. Verified inert under the pinned seed:
   neither manifest's `required` is read on the `make compile` path (root is
   `compiler`; the implicit-provider gate is dormant; `compute_runtime_demand`
   reads the *project's* caps at `dedupe.sfn:777`, not the runtime capsule's).
2. **Parser predicate.** Add `toml_has_capabilities_section`. Additive.
3. **Thread the flag** through resolver → check/test drivers → effect gate →
   analyzer. Mechanical; each site gains one boolean. Compiles green at every
   intermediate point only if done in one pass — treat it as one commit.
4. **Flip the rule** in `validations.sfn`. This is the one line that changes
   behaviour.
5. **`E0407`.** Add the diagnostic and its emit point; register the code.
6. **Tests and docs** per §6.

**Seed impact: none.** This is a compiler-source change whose consumers are
manifest *data*, not source calling a new builtin, so the runtime-source
carve-out in `.claude/rules/seed-dependency.md` does not apply. `make compile`
builds the new compiler from the old seed, and the new compiler's own root
surface (`["clock", "io", "net"]`) is unchanged. **No seed cut, no
`seed-blocker`, no split.**

**Downstream escape valve:** `SAILFIN_EFFECT_ENFORCE=warning` already degrades
`E0403` to a warning (`effect_gate.sfn:60-70`), so any external project
surprised by the flip has a one-env-var ramp. Say so in the release note.

---

## 9. Risks

| Risk | Assessment |
|---|---|
| A capsule outside the survey (external, or added between design and implementation) breaks | Real but bounded: the failure is a clear `E0403` naming the exact effect and the exact manifest key, with an existing `SAILFIN_EFFECT_ENFORCE=warning` ramp. The `E0403` message already emits the fix-it (`effect_diagnostics.sfn:140-144`). |
| The boolean thread is wide (≈14 files) and easy to get half-done | Mitigated by doing it as one mechanical pass and by the type checker: a missing field on a struct literal is a compile error, not a silent `false`. The one place a default *could* silently creep in is a helper with a defaulted parameter — do not give `capabilities_declared` a default value anywhere. |
| `runtime` claiming the full taxonomy looks like capitulation | It is the honest answer for a TCB, and SFEP-0016 §3.4 already models owned runtime objects as their own provenance class. The manifest comment must state this rather than implying a tight ceiling. |
| `sfn/crypto` claiming test-only `clock` | Genuine, small, and recorded as §7.2 with a named trigger. Do not let it block the change; do not let it go unremarked in the manifest. |
| `E0407` misfires on a manifest the scanner reads fine but that has no `[capsule] name` | The resolver already treats a nameless manifest as unusable (`workspace.sfn:245-250` skips the member). Making it an error surfaces an existing failure earlier. Check the e2e and unit fixture manifests for a nameless one before landing. |

---

## 10. Verification

```
# Rung 1 — the inner loop, before anything else.
build/bin/sfn check compiler/src/ compiler/capsules/ runtime/

# Rung 2 — structural change (new module-level fn + struct fields).
make clean-build
make compile

# Rung 3 — targeted.
build/bin/sfn test compiler/tests/unit/effect_capabilities_test.sfn
build/bin/sfn test compiler/tests/unit/toml_dependencies_test.sfn
build/bin/sfn test compiler/tests/unit/compiler_capsule_boundary_test.sfn
build/bin/sfn test compiler/tests/e2e/capability_cross_check_test.sfn

# The two manifests that changed — these are the regression the survey predicts.
build/bin/sfn test capsules/sfn/crypto
make check-fast

# Rung 4 — shipping gate.
sfn fmt --check <touched .sfn files>
make check
```

Acceptance:

- A capsule with `[capabilities] required = []` and one `![io]` function fails
  `sfn build` with `E0403`.
- The same capsule with the `[capabilities]` section deleted builds clean.
- A `capsule.toml` containing garbage fails with `E0407`, not silently.
- `![pure]` standing alone under `required = []` produces no violation.
- `make check-fast` is green over `runtime/`.
- `make check` triple-pass self-hosts.

---

## 11. Future considerations

1. **`W0403` for the absent section, then error** — the 1.0 flip. Owned by
   SFEP-0016's ladder; the implementation is a severity stamp once §5.1 lands
   (§7.1).
2. **`dev-required`** — separate test-time capability from the shipped surface.
   Trigger: a second capsule needing a test-only effect, or SFEP-0016 Phase 1
   (§7.2).
3. **`sfn add` capability propagation** — reconsider merging a dependency's full
   `required` into the consumer, against SFEP-0008 §4.6's own transitive-surface
   reasoning (§7.3).
4. **Workspace-envelope fail-open** — `allow = []` disabling the Phase 4c gate is
   the same hole one tier up (§7.4).
5. **Derive `required` rather than declare it.** `inferred_public_effects`
   already exists and is used by the Phase 4b drift audit
   (`capability.sfn:_cr_member_inferred_effects`). A `sfn capsule caps --fix`
   that writes the inferred union into the manifest would make every future
   fail-closed flip mechanical, and is the natural precursor to the Reach
   pillar's "the compiler *derives* a capability manifest" claim — which today
   the compiler does not do; it checks one the author wrote.
