When a change depends on a compiler-source capability that must be present in the
**pinned seed**: **bundle the capability with its single consumer by default;
split only when it has multiple consumers or is genuinely independent.** This is
the single source of truth for that call — cite it, don't re-derive it. Design
record: SFEP-0026 (`docs/proposals/0026-delivery-process.md`) WS-B.

**Why bundling is the default — the seed-cut tax.** `sfn dev bootstrap build` self-hosts
against the binary pinned by `bootstrap.toml [seed].version`, not against `main`.
A compiler-source capability (lowering, parse, typecheck, intrinsic, or
runtime-prelude change that alters the compiler binary's behaviour) landing in a
*separate* PR from its consumer cannot self-host until it reaches the pinned
seed — forcing a seed cut between the two merges. Bundled in one PR,
`sfn dev bootstrap build` builds the new compiler from the *old* seed and that
fresh compiler
compiles the consumer in the same pass: no seed cut, no `/pin-seed`. **Splitting
a capability from its only consumer manufactures a release cycle that bundling
would not need.**

**When you do split** (multiple consumers, genuinely independent, or large blast
radius): file the capability as a standalone predecessor labelled `seed-blocker`;
the consumer carries `## Required in pinned seed: #<predecessor>`. A split
discovered mid-flight is a **pause-and-present** moment, not a silent fan-out
into a predecessor → groom → separate-PR → seed-cut → re-pickup chain (the #1088
failure mode).

**The one carve-out: a capability consumed by *runtime* source.** Bundling works
because `sfn dev bootstrap build` builds the new compiler from the old seed, and that fresh
compiler then compiles the consumer. That chain breaks when the consumer is
runtime source: the **pinned seed** compiles the working-tree runtime
(`runtime/capsule.toml` `sfn-sources`, via `_compile_runtime_sfn_sources` in
`compiler/src/build/runtime_objs.sfn`), so a compiler capability that runtime
source *calls* — a new builtin or intrinsic — must exist in the **seed**, not
merely in the freshly built compiler. Bundling does not help; the old seed is the
one doing the work. Precedent, recorded verbatim in `runtime/sfn/string.sfn`:
"seed 0.7.0-alpha.41 carries the `load_byte` builtin."

Such a capability lands **alone**, `seed-blocker`, with consumers carrying
`## Required in pinned seed: #<predecessor>`. Since the gate is unavoidable,
cross it **once**: land the complete capability family in that single PR rather
than trickling it per consumer and paying a seed cut each time. This is a
structural exception, not a judgement call — cite it rather than re-deriving it,
and note it does **not** extend to runtime source that merely *changes*; only to
runtime source that calls a compiler capability the seed lacks.

**Split-forced seed cuts queue; they do not trigger a reactive cut.** The advance
batches onto the next scheduled cadence seed bump (SFEP-0026 WS-C); the
`needs-seed-cut` label means "queued," not "cut now." The only thing that breaks
the batch is a *release-critical* need — one that unblocks a current release hard
gate, has no bundle path, and would slip committed scope (bar: SFEP-0026 §3.3).
