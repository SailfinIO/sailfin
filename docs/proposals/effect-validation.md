# Proposal: Effect Validation as Build Gate

Status: Approved for implementation (gating decisions §7.1, §7.2, §7.4 resolved 2026-04-26 by repo owner)
Date: April 26, 2026 (drafted) · 2026-04-26 (gating decisions locked)
Authors: compiler-architect (drafted via `/architect` invocation)
Parent: [docs/proposals/build-architecture.md](./build-architecture.md), [docs/proposals/check-architecture.md](./check-architecture.md)
Related spec: [`site/src/content/docs/docs/reference/spec/07-effects.md`](../../site/src/content/docs/docs/reference/spec/07-effects.md)

## Summary

Effect validation is Sailfin's flagship safety guarantee — the compile-time
proof that a function declares every capability it actually uses. Today the
checker (`compiler/src/effect_checker.sfn`) exists, has 559 lines of
implementation, and is wired into `sfn check` via
`compiler/src/tools/check.sfn:229`. **It is not wired into the build path**:
`make compile`, `sfn build`, `sfn run`, and `sfn test` all bypass it.
Roughly 8% of compiler functions carry `![effect]` annotations; the remaining
92% have never been audited because no compile run has ever forced them to be.
This proposal lays out a seven-phase migration that turns effect validation
from a soft hint emitted by an opt-in tool into the language's primary
compile-time safety gate. Phases A–F ship pre-1.0 and end with the compiler
self-hosting under strict effect enforcement plus capability cross-checking
against `capsule.toml`. Phase G (effect polymorphism + name-resolution-driven
detection) is post-1.0.

## Implementation Status

**What exists today:**

- `validate_effects(program: Program) -> EffectViolation[]` at
  `compiler/src/effect_checker.sfn:31`. Walks `Program.statements`, handles
  `FunctionDeclaration`, `TestDeclaration`, and `StructDeclaration` (method
  bodies). Recursion into nested blocks, lambdas, and decorator-implied
  effects is implemented.
- `EffectViolation { routine_name: string, missing_effects: string[],
  requirements: EffectRequirement[] }` at `effect_checker.sfn:23`. **No
  Token field** — diagnostics ship with `primary: null`.
- `EffectRequirement { effect: string, description: string }` at
  `effect_checker.sfn:18`.
- Body-effect detection is text-pattern based:
  `collect_effects_from_text` at `effect_checker.sfn:364` greps for `fs.`,
  `print(`, `print.`, `console.`, `http.`, `websocket.`, `spawn(`, `serve(`,
  `sleep(`. Comment at line 367 explicitly disclaims soundness:
  > "Keep this conservative: false positives are worse than missing a hint.
  > This checker exists to produce friendly diagnostics, not enforce soundness."
- Decorator-implied effects: `@trace`, `@logExecution` synthetically add
  `![io]` to declared effects (`analyze_routine` at `effect_checker.sfn:78`).
- Diagnostic codes: `E0400` (missing effect), `E0401` (decorator-implied
  effect missing). `E0402` (transitive cross-module) is reserved but unused.
- Single call site in the compiler:
  `compiler/src/tools/check.sfn:229` (inside `check_source_with_imports`).
- `NativeFunction` in `compiler/src/native_ir.sfn:75` already carries an
  `effects: string[]` field, copied through `typecheck_imports.sfn:114`.
  The wire format already supports cross-module effect propagation; the
  checker just doesn't read it.

**What does not exist today:**

- Any call to `validate_effects` from `main.sfn`'s build entry points
  (`compile_to_llvm`, `compile_to_llvm_with_module`,
  `compile_to_llvm_file_with_module`, etc.).
- Source spans on `EffectViolation` (acknowledged tech debt in
  `docs/proposals/check-architecture.md` §3).
- Capability cross-check against `capsule.toml [capabilities] required`.
- Cross-module effect propagation (caller required to declare imported
  callee's effects).
- Effect polymorphism (`fn map<E>(arr, f: T -> U !E) -> U[] !E`).
- Detection for `model`, `gpu`, `rand` effects (text patterns cover only
  `io`, `net`, `clock`).

## Why Now

Three forcing functions have aligned:

1. **Build performance is no longer the bottleneck.** Selfhost dropped from
   13–45 minutes to ~2 minutes after the parallel-build work landed (see
   `docs/proposals/build-architecture.md`). Iterating on the checker against
   the live compiler tree was previously prohibitive; it now costs two minutes
   per audit pass. This proposal would not have been tractable six months ago.
2. **Effect-as-gate is LLM Adoption Strategy lever #1** in
   [`CLAUDE.md`](../../CLAUDE.md). The marketing claim "compile-time effect
   enforcement" is currently aspirational. The "Don't ship unfinished safety
   claims" rule from the design framework requires we either remove the claim
   or land the gate. Landing the gate is on-roadmap; removing it is not.
3. **Capability-based security is differentiator #2.** The capsule manifest
   already declares `[capabilities] required = [...]` but the compiler
   does not cross-check function annotations against it. Phase F closes that
   loop and turns capability declarations into a compile-time contract
   instead of documentation.

The user's framing of this work was explicit: "It's been on the back burner
since build performance was so abysmal… I'm assuming that since it's not
fully fleshed out or enforced there are probably compiler source files
missing effect annotations as well." This proposal confirms that assumption
and proposes a phased migration.

## Part 1 — Current State

### 1.1 The soft-hint mode

`sfn check` is the only command path that runs effect validation. The flow:

```
check_source_with_imports(source, file_path, imported_interfaces)
  ├── parse_program(source)
  ├── typecheck_diagnostics_with_imports(program, imported_interfaces)
  └── validate_effects(program)        ← effect_checker.sfn:31
        └── for each routine:
              required = collect_effects_from_text(body_text)   ← text patterns
              missing  = required ∖ declared
              if missing: emit EffectViolation { primary: null }
```

Each violation is wrapped via `effect_violation_to_diagnostic`
(`tools/check.sfn:67`) into a `Diagnostic` with `severity: "error"`,
`code: "E0400"` (or `E0401` for decorator-implied), and `primary: null`.
The renderer (`render_diagnostic` at `tools/check.sfn:188`) detects the null
token and falls back to a location-only line (`--> file.sfn`) — no line
number, no column, no caret.

### 1.2 Where it's called

**Called from:**

- `compiler/src/tools/check.sfn:229` — `sfn check` only.

**Not called from:**

- `compiler/src/main.sfn:compile_to_sailfin` (legacy entry; line ~60).
- `compiler/src/main.sfn:compile_to_llvm` (line ~150).
- `compiler/src/main.sfn:compile_to_llvm_with_module` (line ~210).
- `compiler/src/main.sfn:compile_to_llvm_file_with_module` (file-output
  variant used by `make compile`).
- `compiler/src/main.sfn:compile_tests_to_llvm_file_with_module_imports`
  (test compilation; called by `sfn test`).
- The build pipeline orchestrated by `scripts/build.sh`.

This means: every `make compile` run, every `build/native/sailfin run foo.sfn`
invocation, every CI run that doesn't explicitly call `sfn check` ships with
zero effect validation. The compiler tree itself has never seen an enforced
effect-check run.

### 1.3 What the text-pattern detector knows

| Pattern | Effect | Description |
|---|---|---|
| `fs.`     | `io`    | filesystem helper usage |
| `print(`  | `io`    | print helper usage |
| `print.`  | `io`    | print helper usage |
| `console.`| `io`    | console helper usage |
| `http.`   | `net`   | http helper usage |
| `websocket.` | `net` | websocket helper usage |
| `spawn(`  | `io`    | spawn call |
| `serve(`  | `net`   | serve call |
| `sleep(`  | `clock` | sleep call |
| `@trace`, `@logExecution` decorator | `io` | decorator-implied |

The detector does **not** know about: `model` (planned for `sfn/ai`),
`gpu` (parsed only), `rand` (parsed only), `runtime.sleep` (only the bare
`sleep(` is matched), `process.*`, `env.*`, time-of-day reads, atomic
intrinsics. False-negatives are common; false-positives also exist
(any string `"print("` inside a string literal trips the matcher).

### 1.4 What the wire format already supports

`compiler/src/native_ir.sfn` defines:

```
struct NativeFunction {
    name: string;
    parameters: NativeParameter[];
    return_type: string;
    effects: string[];     // ← line 75: already wired
    ...
}
```

`compiler/src/typecheck_imports.sfn:114` copies `native.effects` through
when reconstructing `Statement.InterfaceDeclaration` from staged `.sfn-asm`.
This means **the .sfn-asm artifact format already records and round-trips
effect annotations across capsule boundaries**. Phase E is therefore
plumbing-only — no new file format, no migration of existing artifacts.

### 1.5 Capsule manifest

`compiler/capsule.toml`:

```
[capabilities]
required = ["io"]
```

The capsule resolver (`compiler/src/capsule_resolver.sfn`) reads
`[capabilities] required` for staging but does not feed it to the effect
checker. The checker has no notion of "capsule scope" today — it operates
on a single `Program` AST.

## Part 2 — Problems

### 2.1 The build path bypasses effect validation

The most consequential problem. Every production usage of the compiler —
`sfn build`, `sfn run`, `sfn test`, `make compile`, CI selfhost — produces
artifacts that have not been effect-checked. Effect violations land only in
the small surface area of users who run `sfn check` explicitly. This makes
the marketing claim ("compile-time effect enforcement") technically wrong:
effects are not enforced at compile time on the build path.

### 2.2 Roughly 8% of compiler functions are annotated

Across `compiler/src/*.sfn`, ~118 of ~1414 top-level fn signatures carry
`![effect]` annotations. The unannotated 92% breaks into roughly three
buckets:

- **Pure functions (majority).** Lexer helpers, AST constructors, string
  utilities, IR builders, etc. These are correctly unannotated.
- **Functions transitively calling I/O via `print.err(` for trace logs.**
  These are unannotated bugs — they should declare `![io]`. Estimating
  20–60 such functions across the compiler tree.
- **Functions that do filesystem work** (`fs.exists`, `fs.readFile`,
  `fs.writeFile`) **without annotation.** The compiler tree contains
  several of these in `capsule_resolver.sfn`, `cli_*.sfn`, `tools/*.sfn`.
  Estimating 30–80 across the tree.

The audit phase (Phase C below) is required to produce the actual count;
the estimate above is a lower bound based on the text-pattern detector's
known coverage.

### 2.3 Detection is text-pattern based

`collect_effects_from_text` greps the source bytes of the body. This causes:

- **False positives.** A string literal `"print("`, a comment mentioning
  `http.`, a function named `fs_canonicalize` (matches `fs.` substring) all
  trigger required-effect entries. The current behavior is conservative
  (the comment at line 367 says so explicitly) but it cannot be the basis
  of a hard build gate. Phase C must triage false positives during audit;
  Phase G replaces text patterns with name-resolution-driven detection.
- **False negatives.** Any I/O call that doesn't match a hardcoded prefix
  is invisible. `runtime.sleep(`, `os.getenv(`, `process.exit(`,
  `time.now(`, atomic intrinsics — none are detected. Annotating a
  capsule that uses `time.now()` is currently unenforced.
- **Brittle to refactor.** Renaming `print.info` to `log.info` would silently
  remove all `io` requirement detection across the tree until someone
  updates the pattern list.

### 2.4 No source spans on effect diagnostics

`EffectViolation` lacks a Token. The diagnostic renders without a
line/column pointer:

```
error[E0400]: function `compile_capsule_modules` is missing required effects: ![io]
required by:
  - filesystem helper usage requires ![io]
suggestion: add ![io] to the function signature
  --> compiler/src/capsule_resolver.sfn
  [kind: effect]
```

vs the typecheck diagnostic style for the same file:

```
error[E0210]: ...
  --> compiler/src/capsule_resolver.sfn:412:9
    |
412 |     fs.writeFile(path, data);
    |         ^^^^^^^^^
  [kind: typecheck]
```

This is acknowledged tech debt (`docs/proposals/check-architecture.md` §3).
At soft-hint scale it's tolerable; flipping to a build gate makes it a
blocker — users will face thousands of pointer-less effect errors during
audit.

### 2.5 No capability cross-check

A function can declare `![net]` inside a capsule whose
`capsule.toml [capabilities] required = ["io"]` does not list `net`. Today
the compiler accepts this silently. The capsule manifest is documentation,
not contract. Differentiator #2 (capability-based security) requires this
gap to close.

### 2.6 No cross-module effect propagation

Even if function `A` in capsule `foo` declares `![net]`, a caller `B` in
capsule `bar` that imports and calls `A` is not required to declare `![net]`.
The wire format records `A.effects = ["net"]`, but the checker doesn't read
imported function effects when validating callers. The roadmap calls this
"Call-graph–transitive enforcement (planned but not yet implemented)" and
the spec §7 names it explicitly.

### 2.7 Coverage gaps in the canonical effect list

Spec §7 lists six canonical effects (`io`, `net`, `model`, `clock`, `gpu`,
`rand`). The detector handles three (`io`, `net`, partial `clock`).
`model`/`gpu`/`rand` are unimplemented. `clock` is partial (only `sleep(`
matches; `time.now()` doesn't). This is a documentation/implementation drift
that will widen as the ecosystem grows unless we close it now.

### 2.8 No severity model for soft warnings

Today every effect violation is hardcoded `severity: "error"` (see
`effect_violation_to_diagnostic` at `tools/check.sfn:84`). When we wire the
checker into the build path, we need a phased rollout — warning first, error
second — but the current code path can't express "warning" for an effect
diagnostic. Phase A introduces severity selection; Phase B uses it.

## Part 3 — Design Principles

### 3.1 Boring syntax wins

Sailfin's effect annotation form `![io, net]` after the return type is
already shipped, parsed, and used in 118 functions and the spec. This
proposal does **not** revisit syntax. The annotation grammar stays. We
debate enforcement, not lexicon.

### 3.2 Explicit declaration over inference (pre-1.0)

Sailfin requires explicit `![effect]` annotations on every function that
performs effects, including transitively. We do **not** infer effects from
the body and silently propagate them to the caller's signature. Rationale:

- Inference makes signatures unstable across refactors. Adding a `print.err`
  trace inside a deeply-nested helper would change the signatures of every
  ancestor function on the call stack.
- Inference muddies the contract between caller and callee. The function
  signature is the API surface; what it consumes (effects) belongs in the
  signature, not in the body.
- Inference defeats the LLM Adoption Strategy goal. An LLM looking at a
  signature should see the full capability surface; if effects are
  body-implicit, a model has to read the body and resolve every transitive
  call to know what it touches.

The checker **does** infer effects from the body to decide whether the
declared set is sufficient. That is validation, not inference. The user
writes the annotation; the checker confirms it.

Post-1.0 we may add an `auto` opt-in for inferred effects on private
helpers, but it is out of scope for this proposal.

### 3.3 Capability-first

The capsule manifest's `[capabilities] required` is the outermost contract.
No function in a capsule may declare an effect outside that set. This makes
`required` a real compile-time gate, not documentation. It is the
capability-based-security half of the differentiator story.

### 3.4 No false safety claims

Per the design framework: "parsed but not enforced is worse than not having
the syntax at all." This is the founding rule of this proposal. Every
phase below ends in a state where the language's documented effect behavior
matches the compiler's enforcement. We do not advance a phase until the
spec, `docs/status.md`, and the `llms.txt` reflect what's actually shipped.

### 3.5 The compiler is the first user

The compiler self-hosts. Whatever effect rules we ship apply to
`compiler/src/*.sfn` first. If a rule is too strict to live with, we'll
discover it during the audit phase rather than after release. This also
forces us to keep the audit cost reasonable — if it costs the maintainer
20 hours to annotate the compiler, it costs every downstream user 20 hours
times their codebase ratio.

### 3.6 Severity-graded rollout

Effect violations have three flavors:

- **Hard error.** A function calls a known-effectful helper and does not
  declare the effect. Default at Phase D and beyond.
- **Soft warning.** Phase B's transitional state. Same content; severity
  "warning"; build proceeds. This exists so we can audit the tree without
  turning every PR red.
- **Hint.** Decorator-implied effect that the body doesn't actually use
  (e.g., a function decorated `@logExecution` whose body has no I/O).
  Always a hint — the decorator might be a no-op in this build, the body
  call might be commented out. Never blocks a build.

### 3.7 One source of truth for effects

The canonical effect list lives in **one** file:
`compiler/src/effect_taxonomy.sfn` (new in Phase A). Spec §7 references it.
`docs/status.md` references it. The checker imports it. Adding or removing
an effect requires updating exactly one file plus its tests.

## Part 4 — Production End-State

This is the target the migration phases point toward. Not all of it ships
at 1.0 — Phase G items defer — but the design must accommodate them so we
don't paint ourselves into a corner.

### 4.1 The canonical effect taxonomy (1.0)

Six canonical effects, locked at 1.0:

| Effect | Grants | Detection at 1.0 | Stdlib / runtime sources |
|---|---|---|---|
| `io` | Filesystem, console, stdout/stderr, process I/O, env vars | name-resolution + decorator-implied | `fs.*`, `print.*`, `console.*`, `process.*`, `env.*`, `@trace`, `@logExecution` |
| `net` | TCP/UDP/HTTP/WebSocket, DNS, sockets | name-resolution | `http.*`, `websocket.*`, `serve(`, `net.dial(`, `dns.*` |
| `clock` | Wall-clock reads, monotonic time, `sleep` | name-resolution | `sleep(`, `runtime.sleep(`, `time.now(`, `time.monotonic(` |
| `rand` | Non-deterministic randomness | name-resolution | `rand.*`, `random.*`, secure-random intrinsics |
| `model` | LLM/inference invocation via `sfn/ai` capsule | name-resolution + capsule-imported | `ai.complete(`, `ai.embed(`, `prompt {}` blocks (post-1.0 sugar) |
| `gpu` | Tensor/GPU dispatch | name-resolution | `tensor.*` (when GPU-backed), CUDA/Metal intrinsics |

**Rationale for keeping all six at 1.0:**

- `io`, `net`, `clock`, `rand` are non-negotiable systems effects. Every
  capsule that does anything observable will need at least one.
- `model` is a forward-compatibility commitment. Even if `sfn/ai` is post-1.0,
  reserving `model` at 1.0 means `sfn/ai` can ship as a library without a
  language change. Post-1.0 capsules expecting the effect won't break.
- `gpu` is the same forward-compatibility argument for the tensor work in
  `capsules/sfn/tensor`, `nn`, `losses`. Reserving the keyword means tensor
  ops can opt-in to GPU compilation post-1.0 without language churn.

**Effects we are NOT adding at 1.0** (proposed and rejected):

- `time` distinct from `clock`: redundant. `clock` covers reads.
- `mem` for allocation: too granular and uniformly satisfied by every
  function that uses arrays/strings — would degenerate into a no-op.
- `panic` for fatal errors: covered by `Result<T, E>` work in Phase 1
  of the runtime enablement plan.
- `unsafe` for raw pointer / extern boundary: a separate axis from
  capability-based effects. Reserved as future work but not modeled as
  an effect today.

### 4.2 Effect hierarchy and composition

Effects do **not** form a hierarchy at 1.0. `model` is not a sub-effect of
`net` (even though LLM calls go over HTTPS today) because:

- An on-device model invocation does not require network capability.
- Capsule manifests should be able to grant `model` without granting `net`.
- Hierarchy implies subsumption rules in the checker — extra complexity
  for a benefit only realized once `sfn/ai` matures.

If a function makes an LLM API call **and** opens an outbound HTTPS
connection at the same level of abstraction, it declares `![model, net]`.
If it calls into the `sfn/ai` capsule and that capsule internally makes
HTTPS calls, **the caller declares only `![model]`** — `net` is `sfn/ai`'s
private implementation concern, not the caller's contract surface.

This is the standard "effects are scoped to the capsule's public API"
rule. It mirrors how Haskell / Koka / OCaml-effects treat handler-resolved
effects: an effect that's fully discharged inside a capsule does not
propagate to the caller. Only effects in the capsule's exported function
signatures propagate.

**Composition.** Effects are an unordered set on a function signature.
`![io, net]` ≡ `![net, io]`. The canonical rendering (used in diagnostics
and the spec) sorts alphabetically: `![clock, io, model]`.

### 4.3 Detection model (1.0)

Detection is **name-resolution-driven** at 1.0 plus a small set of
**syntactic triggers**:

1. **Imported callee with declared effects.** When the typechecker resolves
   a call expression `foo(args)`, it reads the callee's `FunctionSignature`
   from the local AST or from imported `NativeInterface` data
   (`typecheck_imports.sfn`). If `callee.effects.length > 0`, every effect
   in `callee.effects` is required of the caller.
2. **Decorator-implied.** `@logExecution` and `@trace` synthetically
   require `![io]` because the decorator's runtime injection emits
   trace logs. This is special-cased in `analyze_routine`.
3. **Syntactic effect anchors.** Some constructs are language-level effects
   not bound to a callable: `prompt { }` blocks (post-1.0 sugar) require
   `![model]`; `spawn { }`, `routine { }`, `await` (post-1.0 concurrency)
   require effects to be defined when concurrency lands. At 1.0 the only
   syntactic anchors are decorators and `prompt` blocks (parsed but not
   yet sugar in 1.0).

**Pattern matching is removed at Phase G.** Pre-1.0, Phases A–F still rely
on the text-pattern detector as a **complement** to name-resolution
(safety net). When the resolver knows about a callee, the resolver wins.
When it doesn't (unresolved name, dynamic dispatch placeholder, parse
recovery edge), the text patterns provide best-effort coverage. Phase G
deletes the pattern code entirely.

### 4.4 Effect polymorphism (post-1.0)

Higher-order functions need effect polymorphism to compose:

```sfn
fn map<T, U, E>(arr: T[], f: (T) -> U !E) -> U[] !E {
    let mut out: U[] = [];
    let mut i = 0;
    loop {
        if i >= arr.length { break; }
        out.push(f(arr[i]));    // ← f's effects propagate to map's effects
        i += 1;
    }
    return out;
}
```

Without polymorphism, `map` either declares no effects (and rejects
effectful callbacks) or pre-declares all six effects (and is overpermissive
for everyone). With polymorphism, `map` declares the effect variable `E`
and the call site instantiates: `map(items, fn(x) -> string ![io] {
print.info(x); return x; })` makes the call-site `map` invocation carry
`![io]`.

This is **post-1.0** because:

- Sailfin generics shipped late; type parameters on functions are still
  young (see roadmap "generic constraints" track).
- Polymorphism requires effect substitution in the typechecker, which is
  a 500–1000 line change touching `typecheck.sfn`.
- The 1.0 stdlib (`array.sfn`, `map.sfn`, etc.) ships overload-style:
  `map`, `map_io`, `map_net`. Ugly but correct, and the migration to
  polymorphic `map` is mechanical when polymorphism lands.

The proposal commits to making polymorphism **non-breaking** when it ships:
the syntax `f: (T) -> U !E` is reserved and the parser will be taught about
`!E` effect-variables as part of Phase G.

### 4.5 Closures, lambdas, and spawn handlers

Closures inherit lexical effect scope at 1.0:

- A closure's body is checked with the **enclosing function's declared
  effects** as the available set. Calling `fs.readFile` inside a closure
  inside a `![io]` function is fine.
- A closure escaping the enclosing function (passed to a callee that may
  invoke it later) carries its captured effects in its function-type.
  This is enforced by the typechecker once polymorphism lands (Phase G);
  pre-1.0, escaping closures are checked syntactically — if the closure
  body uses `print.*` and the **enclosing** function does not declare
  `![io]`, that's an error.

`spawn` blocks (post-1.0 concurrency) require their declared effects to
match the body's needs, identically to function declarations.

### 4.6 Capability cross-check (Phase F)

For each capsule with `capsule.toml`:

- Read `[capabilities] required`.
- For each function declaration in the capsule, ensure
  `signature.effects ⊆ capabilities.required`.
- Diagnostic: `E0403 effect '<x>' not in capsule capability surface
  <required>`.

This is enforced at the capsule boundary: a capsule cannot declare
effects beyond its manifest. Combined with cross-module propagation
(Phase E), this means a downstream consumer of a capsule sees only
the effects the capsule manifest authorized.

There is one subtlety: the **transitive** capability surface. If capsule
`foo` requires `["net"]` and imports capsule `bar` which requires
`["net", "clock"]`, can `foo` call `bar.fetch_with_timeout()`? Yes —
`foo` is consuming a `net` API; `clock` is `bar`'s implementation detail.
But if `bar` exports `fetch_with_timeout(): ... ![net, clock]`, then
`foo`'s call site must declare `![net, clock]`, which means `foo`'s
manifest must include `clock`. The decision to take a `clock`-effecting
dependency is `foo`'s, surfaced at signature time.

### 4.7 Severity model (1.0)

Three severities:

| Severity | When | Build behavior | Code prefix |
|---|---|---|---|
| `error` | Function calls effectful helper without declaring effect | Build fails | `E04xx` |
| `warning` | Phase B transitional state; legacy code being audited | Build proceeds | `W04xx` |
| `hint` | Decorator-implied effect with no body usage | Build proceeds | `H04xx` |

Diagnostic codes:

- `E0400` — missing effect declaration (general)
- `E0401` — decorator-implied effect missing
- `E0402` — transitive cross-module effect not propagated (Phase E)
- `E0403` — effect declared outside capsule capability surface (Phase F)
- `E0404` — closure escaping with effects beyond enclosing function
  (Phase G with polymorphism)
- `W0400`–`W0403` — warning variants used during Phase B
- `H0400` — decorator-implied effect, body has no usage (Phase A)

`SAILFIN_EFFECT_ENFORCE` env var:

- unset (default at Phase B): warning
- `=warning`: warning (explicit)
- `=error` (default at Phase D and beyond): error
- `=off`: skip effect validation entirely (escape hatch for emergency
  builds; does not turn off `sfn check` validation, only the build path)

The env var is **opt-out, not opt-in.** Once the default flips to `error`
in Phase D, builds are gated by default. A user explicitly setting
`SAILFIN_EFFECT_ENFORCE=off` is consciously bypassing the gate and we
emit a single-line stderr notice each invocation so it's visible.

### 4.8 Source spans

Every `EffectViolation` carries a `Token?` pointing at the **specific call
site** that triggered the requirement, not the function signature. Example:

```
error[E0400]: function `compile_capsule_modules` is missing required
              effects: ![io]
  --> compiler/src/capsule_resolver.sfn:412:9
    |
412 |     fs.writeFile(staged_path, contents);
    |     ^^^^^^^^^^^^
required by:
  - filesystem helper usage requires ![io]
suggestion: add ![io] to the function signature at line 398
  [kind: effect]
```

Two tokens are tracked per violation: the **trigger** (call site) and the
**signature** (function-name token in the signature). The renderer points
the caret at the trigger and offers a fix-it at the signature.

### 4.9 Cross-module propagation (Phase E)

When the typechecker resolves a call to an imported function, it reads the
imported function's effects from `Statement.InterfaceDeclaration` (already
populated by `typecheck_imports.sfn:114`). The effect checker's
`collect_effects_from_block` is extended to walk call expressions and look
up resolved callees in the symbol table.

The flow becomes:

```
analyze_routine(signature, body, ...)
  ├── resolved_callees = collect_resolved_calls(body, symbol_table)
  ├── required_from_calls = union(c.effects for c in resolved_callees)
  ├── required_from_text  = collect_effects_from_text(body)   ← legacy fallback
  ├── required = required_from_calls ∪ required_from_text
  ├── declared = signature.effects ∪ decorator_effects
  └── missing  = required ∖ declared
```

The `symbol_table` parameter is new — it threads through from `validate_effects`
which now takes `(program, imported_interfaces)` matching `typecheck`'s shape.

## Part 5 — Migration Phases

Each phase ships as one PR. Each phase ends with the compiler self-hosting.
The work branch is `effect-validation` cut from `main`. Phases A–F land
pre-1.0 in this order; Phase G is post-1.0.

The phases are designed so each phase produces user-visible value
independently:

- **Phase A** is the diagnostic-quality fix that has been deferred since
  `sfn check` shipped — useful regardless of any other work.
- **Phase B** turns on the gate as a warning — the compiler tree
  immediately surfaces every violation it has accumulated.
- **Phase C** is the audit — the compiler annotates itself.
- **Phase D** flips the default to `error` — the gate is now real.
- **Phase E** closes the cross-module loop.
- **Phase F** closes the capsule-manifest loop.
- **Phase G** (post-1.0) replaces text patterns with semantic detection
  and adds polymorphism.

### Phase A — Source-span attribution (1 PR, ~1–2 days)

**Goal.** Effect violations carry source spans so diagnostics render with
file:line:column and a caret pointer, matching typecheck diagnostics.

**Files affected.**

- `compiler/src/effect_checker.sfn`
  - Add `trigger: Token?` and `signature_token: Token?` to `EffectViolation`.
  - `analyze_routine` records the function-name token from `signature.name_span`
    (already plumbed) into `signature_token`.
  - `collect_effects_from_block` is extended to walk the AST in token-aware
    form and emit `(EffectRequirement, Token)` pairs (currently a flat
    array of requirements with no spans). The trigger token is the first
    AST node matching the body-pattern check.
- `compiler/src/effect_taxonomy.sfn` (NEW)
  - Define `CANONICAL_EFFECTS: string[] = ["clock", "gpu", "io", "model",
    "net", "rand"]`.
  - Define `is_canonical_effect(name) -> boolean`.
  - Define `compare_effects(a, b) -> boolean` for sorted rendering.
  - Importable from both `effect_checker.sfn` and `tools/check.sfn`.
- `compiler/src/tools/check.sfn`
  - `effect_violation_to_diagnostic` reads `violation.trigger` and writes
    it to `Diagnostic.primary`.
  - Severity selection: existing hardcoded `"error"` now accepts `"warning"`
    and `"hint"` paths. Severity is a parameter to the helper.
- `compiler/tests/unit/effect_checker_test.sfn` (NEW or extend)
  - Test that `analyze_routine` populates `trigger` for each missing-effect
    violation.
  - Test the canonical effect taxonomy export.

**New types and signatures.**

```
struct EffectViolation {
    routine_name: string;
    missing_effects: string[];
    requirements: EffectRequirement[];
    trigger: Token?;          // NEW
    signature_token: Token?;  // NEW
    severity: string;         // NEW: "error" | "warning" | "hint"
}

fn validate_effects(program: Program) -> EffectViolation[]      // unchanged
fn canonical_effects() -> string[]                              // NEW
fn is_canonical_effect(name: string) -> boolean                 // NEW
```

**Migration risk.**

- `analyze_routine` currently walks body text — it has to switch to AST
  traversal to capture tokens. This is a refactor of `collect_effects_from_block`.
  Self-hosting is preserved because the function signatures stay stable;
  only the internals change.
- The seed compiler does not produce token-bearing `EffectViolation`s.
  This is fine because the seed only uses the checker via `sfn check` if
  at all; the seed binary's own check output is not consumed by anyone
  during selfhost.

**Verification.**

```bash
ulimit -v 8388608 && timeout 180 make compile
ulimit -v 8388608 && timeout 30 build/native/sailfin check compiler/src/main.sfn
# Expect: effect diagnostics now show file:line:column with caret.
ulimit -v 8388608 && timeout 60 make test-unit
```

**Exit criteria.**

- `compiler/tests/unit/effect_checker_test.sfn` passes.
- A hand-crafted `.sfn` file with a known violation renders with caret.
- `make check` (selfhost full pipeline) green.
- `docs/status.md` updated: "effect diagnostics now carry source spans."

### Phase B — Wire validate_effects into the build pipeline (1 PR, ~1 day)

**Goal.** The build path runs effect validation. Default severity is
**warning**; build proceeds. `SAILFIN_EFFECT_ENFORCE=error` flips it to a
gate.

**Files affected.**

- `compiler/src/main.sfn`
  - New helper `_validate_and_render_effects(program, file_path) -> number`
    (returns error count). Calls `validate_effects`, renders each violation
    via the same path used by `tools/check.sfn`, returns count.
  - Call sites:
    - `compile_to_llvm` (line ~150)
    - `compile_to_llvm_with_module` (line ~210)
    - `compile_to_llvm_file_with_module` (in the same file)
    - `compile_tests_to_llvm_file_with_module_imports` (in the same file)
  - Read `SAILFIN_EFFECT_ENFORCE` via existing env-var helper. Severity
    selection:
    - `=off` → skip validation entirely, emit notice line.
    - `=warning` or unset → severity "warning", build proceeds.
    - `=error` → severity "error", build fails on first violation.
- `compiler/src/tools/check.sfn`
  - Extract the violation-to-diagnostic and rendering paths into helpers
    that `main.sfn` can import. (Effectively: split `check.sfn` so the
    rendering primitives live in a sibling module.)
  - Concretely: move `_join_effects`, `_code_for_missing_effect`,
    `effect_violation_to_diagnostic`, and rendering helpers into a new
    `compiler/src/diagnostics_render.sfn` module. `tools/check.sfn` and
    `main.sfn` both import from it. Single source of truth.
- `compiler/src/diagnostics_render.sfn` (NEW)
  - Move-only refactor; no behavior change.

**Migration risk.**

- The compiler self-host build will immediately surface every effect
  violation in the compiler tree. Estimated 50–150 warning lines on
  stderr per build. This is loud but informational, and the build still
  succeeds (severity = warning).
- If a refactor in `tools/check.sfn` accidentally changes diagnostic
  output, `compiler/tests/unit/check_tool_test.sfn` (21 tests, per
  `check-architecture.md` §A3) will catch it.
- Performance: effect validation is O(N) across function bodies and
  doesn't recurse into LLVM lowering. Estimated <2% selfhost overhead
  per the existing `sfn check` runtime numbers.

**Verification.**

```bash
ulimit -v 8388608 && timeout 240 make compile 2>&1 | tee build/effect-warnings.log
grep -c '\[effect\]' build/effect-warnings.log
# Expect: positive count (the audit work for Phase C).
SAILFIN_EFFECT_ENFORCE=error ulimit -v 8388608 && timeout 240 make compile
# Expect: build fails on first violation. Reset env after testing.
ulimit -v 8388608 && timeout 600 make check
# Expect: full selfhost still green at default severity.
```

**Exit criteria.**

- Default `make compile` produces effect warnings but exits 0.
- `SAILFIN_EFFECT_ENFORCE=error make compile` produces effect errors and
  exits non-zero.
- Number of warnings observed during selfhost is recorded in the PR
  description as the Phase C baseline.
- `docs/status.md` updated.

### Phase C — Audit + fix the compiler tree (1–3 PRs, 3–6 hours total)

**Goal.** The compiler tree has zero effect warnings under the soft-mode
gate from Phase B.

**Approach.**

1. Run `SAILFIN_EFFECT_ENFORCE=warning make compile 2>&1 | grep '\[effect\]'`
   → categorize.
2. Group violations by file. Fix bottom-up: leaves first
   (`string_utils.sfn`, `token.sfn`, ...), `main.sfn` last.
3. For each violation, the fix is one of:
   - Add the right `![effect]` annotation to the function signature.
   - If the function genuinely shouldn't have the effect, remove the
     effectful call (e.g., remove a stale `print.err` trace).
   - If the violation is a false positive (text-pattern hit on a string
     literal or an identifier name), file an issue against Phase G
     and silence the violation locally with a comment annotation
     (`// effect-ok: false-positive on <pattern>`). Phase G removes
     this need.
4. Re-run `make compile` after each file. The build must remain green.

**Files affected.** Likely candidates (estimate based on grep of
effectful patterns vs declared annotations):

- `compiler/src/cli_*.sfn` — most CLI entry points run I/O without
  declaring it.
- `compiler/src/capsule_resolver.sfn` — heavy `fs.*` user.
- `compiler/src/tools/*.sfn` — `sfn check`, `sfn fmt`, `sfn fix` adapters.
- `compiler/src/main.sfn` — uses `print.err` for tracing.
- `compiler/src/native_driver*.sfn` — process spawning.

**Migration risk.**

- A function that becomes `![io]` requires its callers to also be `![io]`.
  This cascades up the call graph. The audit must propagate up — a single
  bottom-up pass should converge but may take 3–4 iterations on the
  compiler tree.
- If the cascade reaches `main()`, that's correct: `main` is the entry
  point and should declare every effect the program needs.
- A function that genuinely shouldn't have I/O but currently has a stray
  `print.err` trace should drop the trace, not propagate the effect. The
  audit is a chance to clean up debug stragglers.

**PR strategy.**

- Sub-PR C1: Annotate leaf modules (`string_utils`, `token`, `lexer`,
  parser internals).
- Sub-PR C2: Annotate mid-tier modules (typecheck, AST, IR builders).
- Sub-PR C3: Annotate top-tier modules (CLI, tools, main).

Each sub-PR self-hosts independently. The grouping prevents one giant
PR that's painful to review.

**Verification.**

```bash
ulimit -v 8388608 && timeout 240 make compile 2>&1 | grep -c '\[effect\]'
# After each sub-PR, expect the count to decrease monotonically.
# Final state after C3: zero.
ulimit -v 8388608 && timeout 600 make check
```

**Exit criteria.**

- `make compile 2>&1 | grep '\[effect\]'` produces no output at default
  severity.
- `SAILFIN_EFFECT_ENFORCE=error make compile` succeeds — the compiler
  builds itself under strict effect enforcement.
- `make check` green.

### Phase D — Flip the gate to error (1 PR, ~half-day)

**Goal.** `SAILFIN_EFFECT_ENFORCE` defaults to `error`. Missing effect
declarations now fail the build by default.

**Files affected.**

- `compiler/src/main.sfn`
  - Change the env-var default branch in `_validate_and_render_effects`
    from "warning" to "error".
  - Document the `=warning` and `=off` overrides in the env-var help.
- `site/src/content/docs/docs/reference/spec/07-effects.md`
  - Remove "planned but not yet implemented" caveats.
  - Remove the "Enforced Today" column row entries that say "No (planned)"
    or "Partial" — by Phase D those rows are all "Yes" for the canonical
    six.
- `docs/status.md`
  - Move "effect enforcement" from "partial" to "shipped."
- `llms.txt`
  - Update the effects section to say enforcement is on by default at
    build time.
- `examples/`
  - Audit example files for effect annotations. The examples are
    user-facing reference material; they need to compile under strict
    enforcement.

**Migration risk.**

- Any user with `.sfn` code that currently builds via `sfn build` will
  see new errors after upgrading. We document the `SAILFIN_EFFECT_ENFORCE=warning`
  override in the release notes for at least one alpha release before
  shipping the default flip.
- The compiler itself is already clean from Phase C, so selfhost is fine.
- Existing examples must be audited (probably 5–20 files need annotations
  added). This is part of the PR.

**Verification.**

```bash
ulimit -v 8388608 && timeout 240 make compile
# Expect: succeeds without env override.
ulimit -v 8388608 && timeout 30 build/native/sailfin run examples/basics/hello-world.sfn
# Expect: example still runs; main has correct ![io].
ulimit -v 8388608 && timeout 600 make check
ulimit -v 8388608 && timeout 60 make test-integration
```

**Exit criteria.**

- `make compile` and `make check` succeed at the new default.
- All `examples/*.sfn` build and run under strict enforcement.
- Spec, status.md, and llms.txt reflect the new state.
- Release notes for the next alpha (after this PR) call out the
  enforcement default change as a breaking-by-default behavior.

### Phase E — Cross-module effect propagation (1 PR, 2–4 days)

**Goal.** A caller that imports and calls a function from another module/
capsule must declare the imported callee's effects. Diagnostic code
`E0402`.

**Files affected.**

- `compiler/src/effect_checker.sfn`
  - `validate_effects` gains an `imported_interfaces: Statement[]`
    parameter, mirroring `typecheck_diagnostics_with_imports`. The
    legacy `validate_effects(program)` becomes a one-line wrapper
    that passes `[]`.
  - New helper `build_import_symbol_table(imported_interfaces) -> SymbolTable`
    extracts callable signatures (with effects) from the imported
    interface declarations.
  - `analyze_routine` gains a `symbol_table` parameter.
  - `collect_effects_from_block` is extended:
    - Walk call expressions in the AST.
    - For each callable identifier, look up in the symbol table.
    - If found and `callee.effects.length > 0`, emit a requirement with
      the call-site token and a description "imported `<callee>` requires
      `<effect>`".
- `compiler/src/typecheck_imports.sfn`
  - Already populates `effects` on import-derived `Statement.InterfaceDeclaration`
    (line 114). Verify the propagation is complete (no field drops in
    the conversion).
- `compiler/src/main.sfn`
  - Update `_validate_and_render_effects` signature: takes
    `imported_interfaces: Statement[]` and threads it through. Build
    pipeline already loads imports for typechecking; reuse the loaded
    set.
- `compiler/src/tools/check.sfn`
  - `check_source_with_imports` already has `imported_interfaces`; pass
    it to `validate_effects`.
- `compiler/tests/unit/effect_checker_test.sfn`
  - Add tests for cross-module propagation: a synthetic program that
    imports a fn declaring `![net]` and calls it without declaring
    `![net]` produces `E0402`.

**Diagnostic example:**

```
error[E0402]: function `serve_orders` does not propagate effect ![net]
              from imported callee
  --> capsules/myapp/src/server.sfn:24:5
    |
 24 |     http.serve(8080, handler);
    |     ^^^^^^^^^^
required by:
  - imported `http.serve` declares ![net]
suggestion: add ![net] to the function signature at line 18
  [kind: effect]
```

**Migration risk.**

- This is the largest single phase. The AST-walking call-resolution code
  is new. We should land a Phase E1 (skeleton — symbol table loading,
  diagnostic emission for one common case) followed by Phase E2 (full
  AST coverage). Treat these as separate PRs if E balloons.
- The audit may expose additional violations in the compiler tree
  (transitive effects not currently propagated because the text-pattern
  detector missed them). Treat this as a continuation of Phase C — fix
  signatures, don't weaken the checker.
- Performance: now O(N * avg_imports) instead of O(N). Should still be
  sub-second even for the compiler tree. Watch the bench.

**Verification.**

```bash
ulimit -v 8388608 && timeout 240 make compile
ulimit -v 8388608 && timeout 600 make check
ulimit -v 8388608 && timeout 60 make test-integration
ulimit -v 8388608 && timeout 60 make bench
# Expect: bench numbers within 5% of pre-Phase-E baseline.
```

**Exit criteria.**

- A test fixture demonstrates cross-module propagation enforcement.
- Compiler tree compiles under strict cross-module checks (any new
  violations exposed during this phase are fixed inline).
- Spec §7 updated: "Call-graph–transitive enforcement" moves to
  "Yes" status.
- `docs/status.md` updated.

### Phase F — Capability cross-check against capsule.toml (1 PR, 2–3 days)

**Goal.** No function in a capsule may declare an effect outside the
capsule's `[capabilities] required` set. Diagnostic code `E0403`.

**Files affected.**

- `compiler/src/capsule_resolver.sfn`
  - `prepare_project_capsules_for_check` and `prepare_project_capsules`
    return capsule metadata that includes the parsed `capabilities.required`.
    Already loaded for staging — surface it.
- `compiler/src/effect_checker.sfn`
  - New entry point `validate_capsule_capabilities(program: Program,
    capsule_required: string[]) -> EffectViolation[]` (or extend
    existing `validate_effects` to take capsule context).
  - For each function, check `signature.effects ⊆ capsule_required`.
    Each unauthorized effect emits a violation with code `E0403`.
- `compiler/src/main.sfn`
  - Wire capsule metadata through to the effect checker for build-path
    invocations.
- `compiler/src/tools/check.sfn`
  - `sfn check` should respect capsule context too — already loads it
    via `prepare_project_capsules_for_check`. Plumb to `validate_effects`.
- `compiler/capsule.toml`
  - Audit: confirm `required = ["io"]` is sufficient for the compiler
    after Phase C–E. If not, expand. The compiler binary uses no `net`
    (the runtime is C), no `clock` (no time reads), no `rand`. `io` only.
  - If audit says we need to expand, do so transparently.
- All `capsules/sfn/*/capsule.toml`
  - Audit for correctness. `http`, `net`, `websocket` capsules need
    `["net"]`. `time` needs `["clock"]`. `rand` needs `["rand"]`. etc.
- `docs/status.md`, spec §7, `llms.txt` — update status.

**Diagnostic example:**

```
error[E0403]: function `fetch_orders` declares effect ![net] outside
              capsule capability surface
  --> capsules/myapp/src/orders.sfn:42:1
    |
 42 | fn fetch_orders() -> Order[] ![net] {
    |                              ^^^^^^
note: capsule `myapp` declares capabilities = ["io"]
suggestion: add "net" to capsule.toml [capabilities] required, or remove
              ![net] from this function
  [kind: effect]
```

**Migration risk.**

- This is the capability-based-security claim's enforcement. Once it
  ships, every capsule's manifest is a real contract. Existing
  capsules may have under-declared manifests; the audit during this
  phase fixes them.
- Capsule manifests are user-edited; we cannot mass-rewrite them. We
  emit `E0403` with a clear fix suggestion ("add 'net' to capsule.toml")
  and let users update.
- For the alpha release immediately after this PR, default to a
  warning-only mode for `E0403` and flip to error in the *next* alpha
  — gives downstream users one cycle to update their capsule.toml
  files. (Mirror Phase B → D pattern.)

**Verification.**

```bash
ulimit -v 8388608 && timeout 240 make compile
# Expect: passes; compiler/capsule.toml is correct.
ulimit -v 8388608 && timeout 600 make check
# Hand-craft a capsule with a function declaring an effect outside
# its required set; verify E0403 fires.
```

**Exit criteria.**

- `compiler/capsule.toml` and all `capsules/sfn/*/capsule.toml` audited
  and fixed.
- A regression test demonstrates `E0403` for a capsule violating its
  capability surface.
- Capability-based-security marketing claim is now backed by enforcement.
- Spec, status, llms.txt updated.

### Phase G — Effect polymorphism + name-resolution detection (post-1.0)

**Goal.** Replace text-pattern detection with semantic name-resolution.
Add effect polymorphism for HOFs.

This phase is post-1.0. The proposal sketches it for forward-compatibility
only; the implementation is a separate workstream.

**Sub-phases.**

- **G1 — Name-resolution-driven detection.** Replace
  `collect_effects_from_text` with `collect_effects_from_calls`:
  walk the AST, resolve every call expression's target through the
  symbol table (local + imported), and require its declared effects.
  Delete `collect_effects_from_text`. Pattern-matching disappears.
- **G2 — Effect-variable parser support.** Teach the parser
  `!E` for effect variables in function signatures and function-type
  positions (`(T) -> U !E`). Reserved syntax already; just enable.
- **G3 — Effect substitution in typechecker.** When a polymorphic
  function is instantiated, substitute the caller's effect set for `E`
  and propagate to the call site's effects.
- **G4 — Stdlib polymorphic HOFs.** Migrate `Array.map`, `Array.filter`,
  `Array.reduce`, `Iterator.*`, `Result.map`, etc. from overload-style
  to polymorphic-style.

**Files affected (sketch).** `parser.sfn`, `typecheck.sfn`,
`effect_checker.sfn`, `runtime/prelude.sfn`, all stdlib capsules using HOFs.

**Migration risk (post-1.0).** This is a typechecker change touching
substitution rules — it has the bug-surface of typeclass / type-parameter
work. Plan for 4–8 weeks of stabilization.

**Exit criteria (post-1.0).**

- `collect_effects_from_text` removed.
- `(T) -> U !E` accepted in parser and typechecker.
- Stdlib HOFs polymorphic; `map_io` overloads removed.

## Part 6 — Risk Register

### 6.1 Audit cascade explosion (Phase C)

**Risk.** Annotating one leaf function with `![io]` requires every caller
to also declare `![io]`, which requires every caller of those callers, and
so on up to `main`. In a deeply call-chained codebase the cascade is
quadratic in human time.

**Mitigation.**

- Bottom-up audit: leaves first, `main` last.
- Sub-PR splitting (C1/C2/C3) keeps each PR reviewable.
- The bench from `make compile` after each fix tells you whether you've
  fully converged. The Phase B warning count is the audit's progress bar.
- The compiler tree is ~120 files; expected total audit time is 3–6 hours
  if the cascade behaves and 8–12 hours if it doesn't.

**Detection.** If a sub-PR's diff approaches 30+ files, the cascade is
out of control — split further or pause and re-evaluate.

### 6.2 Text-pattern false positives slow the audit (Phase C)

**Risk.** A function legitimately doesn't have effects but the pattern
detector hits a string literal or identifier substring. Audit churn
on phantom violations.

**Mitigation.**

- Allow `// effect-ok: <reason>` annotation comments to silence specific
  violations during Phase C.
- Track each suppressed violation as a Phase G test case — when the
  semantic detector lands, every suppression should auto-resolve.
- Cap suppressions: more than 20 in the compiler tree is a smell. If we
  hit that, accelerate Phase G.

**Detection.** Count `effect-ok` comments after Phase C completes. Should
be small.

### 6.3 EffectViolation lacks tokens — Phase A blocks Phase B

**Risk.** Phase B emits effect diagnostics into the build path. If those
diagnostics don't have source spans, the build output is unusable —
hundreds of lines of "function X is missing effects" with no caret.

**Mitigation.**

- Phase A is non-negotiable before Phase B. The PR ordering is enforced:
  no Phase B PR is opened until Phase A is merged.

### 6.4 Seed compiler doesn't know about new diagnostic shape

**Risk.** Adding fields to `EffectViolation` (Phase A) changes a struct
that the seed compiler also defines. The bootstrap must round-trip the
old shape until a new seed cuts.

**Mitigation.**

- `EffectViolation` is an internal type — not serialized to `.sfn-asm`
  and not exposed across capsule boundaries. The seed compiler's
  `EffectViolation` is independent of the new compiler's. No bootstrap
  conflict.
- Verify by running `make compile` (which uses the seed) after the
  Phase A change — it passes if and only if the new compiler source
  type-checks against itself, not against the seed's struct definition.

### 6.5 Cross-module propagation cascade (Phase E)

**Risk.** Phase E surfaces violations in the compiler tree that were
hidden by the text-pattern detector's gaps. The audit work from Phase C
isn't enough; Phase E demands a Phase C2.

**Mitigation.**

- Run Phase E with `SAILFIN_EFFECT_ENFORCE=warning` first to count
  newly-surfaced violations before flipping to error.
- Treat the post-E audit as a continuation of Phase C — same bottom-up
  approach, same sub-PR splitting if large.
- The wire format already supports cross-module effects, so we're not
  inventing data; we're consuming data that already exists. The
  cascade is bounded by what's already declared.

### 6.6 Capsule manifest churn (Phase F)

**Risk.** Phase F enforces `capsule.toml [capabilities] required` against
declared effects. Any capsule with an under-declared manifest will fail
to build. If we have many capsules in `capsules/sfn/`, this is a lot of
manifest edits.

**Mitigation.**

- Audit `capsules/sfn/*/capsule.toml` during the Phase F PR. Fix each
  manifest as we go.
- Phase F ships in two PRs: F1 (warning-only `W0403` so we see the
  scope), F2 (flip to error).
- Document the `capsule.toml [capabilities]` semantics clearly in the
  release notes for the alpha after Phase F.

### 6.7 Performance regression

**Risk.** Effect validation adds work to every selfhost compile. The
goal of "build performance is no longer the bottleneck" should not be
re-broken.

**Mitigation.**

- Phase A through F are pure-AST traversals over an already-parsed
  Program. Per-module cost should be <10ms.
- Run `make bench` before and after each phase. Fail the PR if total
  selfhost time regresses by more than 5%.
- The validation runs in the same module-process as parse+typecheck, so
  no IPC overhead.

**Detection.** `make bench` numbers as part of each phase's PR description.

### 6.8 Reconciliation with libextract / sfn/compiler-lib

**Risk.** A separate proposed workstream (libextract) is reorganizing the
compiler into `sfn/compiler-lib`. If libextract lands first, this
proposal's file paths shift; if this lands first, libextract has to
account for the new effect taxonomy module.

**Mitigation.**

- This proposal lands independently of libextract. The new files
  (`effect_taxonomy.sfn`, `diagnostics_render.sfn`) live under
  `compiler/src/` today and migrate naturally to `sfn/compiler-lib/src/`
  later if libextract proceeds.
- Phases A–F do not require libextract as a prerequisite.
- Effects-as-gate is on the critical path for 1.0 marketing; libextract
  is not. Effects ships first.

**Coordination.** Surface this proposal in the libextract proposal's
"related work" section so the libextract author knows about the new
modules ahead of their migration.

### 6.9 Spec drift between what we ship and what's documented

**Risk.** Spec §7 currently lists six effects but the implementation
covers three. Each phase changes what's enforced; if we don't update
the spec in lockstep, drift compounds.

**Mitigation.**

- Each phase's PR includes a spec update as a checklist item (already
  in each phase's "Files affected" list above).
- `docs/status.md` is the single source of truth; the spec must agree.
- The autonomous docs-updater agent runs after each phase to catch
  drift.

## Part 7 — Open Questions

These require user input before implementation begins. The proposal commits
to a default for each but flags them for review.

### 7.1 Should `clock` be folded into `io`? — **DECIDED: keep separate**

**Decision (2026-04-26):** Keep `clock` distinct from `io`.

**Rationale:** Determinism boundary. A pure-`io` function that reads files
is reproducible; a `clock` function isn't (output depends on wall-time).
Tests, simulators, and post-1.0 deterministic replay tooling assume
`clock` is observable independently of `io`. Folding would have shaved one
effect off the user-facing surface but would have erased a useful
type-level signal that the function's output is non-deterministic.

### 7.2 Should `model` exist before `sfn/ai` ships? — **DECIDED: reserve at 1.0**

**Decision (2026-04-26):** Reserve `model` in the canonical taxonomy at 1.0
even though `sfn/ai` is post-1.0.

**Rationale:** Prevents a language-level breaking change later. The
taxonomy is locked at 1.0; adding `model` post-1.0 would either break old
code (wider effect surface than declared) or quietly subsume existing
effects. Reserving costs ~0 — the parser already accepts `![model]`, and
Phase C adds a regression test exercising a manually-annotated `![model]`
function so the parser/checker paths stay covered until `sfn/ai` ships
real consumers.

### 7.3 What's the env-var name?

**Default:** `SAILFIN_EFFECT_ENFORCE`.

**Alternatives considered:** `SAILFIN_EFFECTS` (too generic), `SFN_EFFECTS_ENFORCE`
(prefix mismatch with other env vars), `SAILFIN_STRICT_EFFECTS` (suggests a
binary on/off rather than the warning/error/off triad we want).

**Recommendation:** `SAILFIN_EFFECT_ENFORCE` with values `warning`, `error`,
`off`. Match `SAILFIN_*` prefix used elsewhere in the codebase.

### 7.4 Should Phase D ship in the same alpha as Phase C, or one alpha later? — **DECIDED: one alpha later**

**Decision (2026-04-26):** Phase D ships **one alpha after Phase C**, giving
the in-tree compiler and any external capsule consumers one full release
cycle of warning-mode telemetry before the gate flips to errors.

**Rationale:** Phase C is a 3-PR audit with the explicit goal "compiler
has zero effect warnings". Even if the in-tree audit lands clean, third-
party capsules built against the alpha that ships Phase B will surface
warnings — those authors deserve a release cycle to react before their
build breaks. The cost is one extra release cycle of "marketing claim is
aspirational"; the architect explicitly framed that as the trade-off.
Owner accepted the cost.

**Implementation note:** Phase D's release-notes entry must call out the
upcoming flip explicitly (one alpha in advance), and `sfn check` should
keep `[effect]` warnings visible at warning severity in the meantime so
contributors see the migration path before the gate trips them.

### 7.5 Phase E2 split: when does the AST-walk for call resolution graduate?

**Default:** Phase E ships as one PR; sub-split internally if the diff
exceeds 800 lines.

**Recommendation:** Decide at Phase E PR-open time. If the symbol-table
loading is non-trivial (extracting callable signatures from imported
interface declarations turns out to need more support code than expected),
split into E1 (loader + diagnostic emission for direct calls) and E2
(method calls, decorator-implied transitive effects, lambda escapes).

### 7.6 What about `prompt {}` blocks?

**Default:** Out of scope for this proposal. `prompt` blocks are
post-1.0 sugar tied to the `sfn/ai` capsule. The current parser accepts
them but emits no `model` effect. Reservation only.

**Recommendation:** When `sfn/ai` lands, the parser teaches `prompt {}`
to lower to a call into `ai.complete()` which carries `![model]`. The
effect propagates naturally without special-casing the block.

### 7.7 Should we require `![effect]` on `main()`?

**Default:** Yes, after Phase D. `main` is a function and follows the
same rules as every other function.

**Rationale:** Forcing `main` to declare its full capability surface
makes the program's top-level capability statement visible.

**Counter:** Every program will have `![io]` or worse on `main`, which is
boilerplate for the common case.

**Recommendation:** Require it. The boilerplate cost is one annotation
per program. The clarity benefit is real — a reader sees `fn main() ![io,
net]` and immediately knows what the program needs.

### 7.8 Is `main.sfn`'s timeout under `sfn check` an effect-checker bug?

**Recon note from prompt:** `sfn check compiler/src/main.sfn` timed out.
The timeout is likely an effect-checker performance issue on a 770-line
file, not an output-flooding issue.

**Recommendation:** Investigate during Phase A. If the timeout is in
`collect_effects_from_text` walking long bodies repeatedly, the AST
refactor in Phase A should fix it for free. If the timeout persists
post-Phase-A, file as a bug and treat as a Phase A blocker.

### 7.9 How do we handle effect annotations on `extern fn`?

**Default:** `extern fn` declarations carry effect annotations exactly
like Sailfin functions. `extern fn read_file(path: string) -> string ![io]`
is accepted; calls to this extern require `![io]`.

**Rationale:** `extern fn` is the boundary between Sailfin and the
runtime / FFI. Without effects on extern, every FFI call would be
effect-less from the checker's view, defeating the purpose.

**Recommendation:** Confirm in Phase B that `extern fn` effects propagate
to callers. If not, treat as a Phase B fix.

## Part 8 — Out of Scope

These are explicitly **not** addressed by this proposal. Listed as
follow-up workstreams.

- **Effect inference.** Body-driven derivation of effect annotations.
  Post-1.0, opt-in only.
- **Effect polymorphism implementation.** Phase G. Sketched but not
  implemented in this workstream.
- **`Affine<T>` / `Linear<T>` ownership effects.** Separate workstream
  per CLAUDE.md (deferred to post-1.0).
- **Runtime capability enforcement.** This proposal is compile-time only.
  Runtime sandboxing is a separate post-1.0 layer.
- **PII / Secret taint tracking.** Separate workstream. Not modeled as
  effects.
- **`sfn/ai` capsule.** Post-1.0. We reserve `model` for it; we don't
  ship the capsule.
- **Concurrency runtime (`routine`, `spawn`, `channel`, `await`).**
  Post-1.0. Effects on concurrency primitives ship when concurrency does.
- **`unsafe` boundary as effect.** Reserved as future work; not modeled
  at 1.0.
- **JSON / structured diagnostic output.** LLM Adoption Strategy lever
  #3. Lands in a separate proposal; this proposal makes effect diagnostics
  the same shape as typecheck diagnostics so `--json` covers both.

## Part 9 — Phase Summary

| Phase | PRs | Days | Pre-1.0? | Description |
|---|---|---|---|---|
| A | 1 | 1–2 | yes | Source spans on EffectViolation; severity; canonical taxonomy module |
| B | 1 | 1 | yes | Wire `validate_effects` into build path; warn-by-default |
| C | 3 | 1 | yes | Audit and fix the compiler tree (0 violations) |
| D | 1 | 0.5 | yes | Flip default to `error`; spec/status/llms updates |
| E | 1–2 | 2–4 | yes | Cross-module effect propagation (E0402) |
| F | 2 | 2–3 | yes | Capability cross-check vs capsule.toml (E0403) |
| G | n | n | post-1.0 | Name-resolution detection + polymorphism |

**Pre-1.0 total:** ~9–14 days of work, 9–11 PRs.

## Part 10 — Verification Strategy

Per-phase verification commands are in each phase. End-to-end checks
across phases:

```bash
# After Phase A
ulimit -v 8388608 && timeout 30 build/native/sailfin check compiler/src/main.sfn 2>&1 \
    | grep -E '\[E04(00|01)\]' \
    | head -5
# Expect: each line shows --> file:line:column.

# After Phase B (warning baseline)
ulimit -v 8388608 && timeout 240 make compile 2>&1 \
    | grep -c '\[effect\]'
# Expect: positive count (the audit baseline).

# After Phase C
ulimit -v 8388608 && timeout 240 make compile 2>&1 \
    | grep '\[effect\]' \
    | wc -l
# Expect: 0.

# After Phase D
ulimit -v 8388608 && timeout 240 make compile
# Expect: succeeds without env override.

# After Phase E (synthetic test)
cat > /tmp/test_e0402.sfn <<'TEST'
import { fetch } from "./helpers";  // helpers declares fetch ![net]
fn run() { fetch("http://x"); }     // missing ![net]
TEST
ulimit -v 8388608 && timeout 30 build/native/sailfin check /tmp/test_e0402.sfn
# Expect: E0402 with caret on `fetch`.

# After Phase F (synthetic test)
mkdir -p /tmp/cap_test && cat > /tmp/cap_test/capsule.toml <<'TOML'
[capsule]
name = "capsule_test"
[capabilities]
required = ["io"]
TOML
cat > /tmp/cap_test/src/lib.sfn <<'LIB'
fn fetch() ![net] { ... }
LIB
ulimit -v 8388608 && timeout 30 build/native/sailfin check /tmp/cap_test/
# Expect: E0403 — net outside capability surface.
```

## Part 11 — Cross-References

- [`docs/proposals/build-architecture.md`](./build-architecture.md) — parent
  build infrastructure proposal; effects-as-gate is a downstream consumer
  of its `--json` and parallel-build groundwork.
- [`docs/proposals/check-architecture.md`](./check-architecture.md) — `sfn check`
  design; this proposal generalizes the check-path effect validation to
  the build path. Phase A closes the §3 deferred-token tech debt.
- [`site/src/content/docs/docs/reference/spec/07-effects.md`](../../site/src/content/docs/docs/reference/spec/07-effects.md)
  — current spec language; this proposal updates the "Enforced Today"
  column at each phase boundary.
- [`CLAUDE.md`](../../CLAUDE.md) §"Effect System", §"LLM & Agent Adoption Strategy",
  §"Pre-1.0 Syntax Reform" — effects are differentiator #1 and LLM
  adoption lever #1.
- [`docs/status.md`](../status.md) — feature-status registry; updated each phase.
- [`docs/proposals/build-performance.md`](../build-performance.md) — explains
  why "now" — selfhost is fast enough that the audit work is tractable.
- [`compiler/src/effect_checker.sfn`](../../compiler/src/effect_checker.sfn)
  — current checker source; modified by every pre-1.0 phase.
- [`compiler/src/native_ir.sfn`](../../compiler/src/native_ir.sfn) — wire
  format for `.sfn-asm`; already carries `effects: string[]` (Phase E
  reuses).
- [`compiler/src/typecheck_imports.sfn`](../../compiler/src/typecheck_imports.sfn)
  — already propagates `effects` through import-derived interface
  declarations (Phase E reuses).
- [`compiler/capsule.toml`](../../compiler/capsule.toml) — example of the
  capability manifest Phase F enforces.

---

## Decisions Locked (2026-04-26)

The repo owner reviewed this proposal and signed off on:

- **Canonical effect taxonomy** (Part 4.1) — six effects: `io`, `net`,
  `clock`, `rand`, `model`, `gpu`. `clock` stays distinct from `io`
  (§7.1); `model` is reserved at 1.0 even though `sfn/ai` is post-1.0
  (§7.2).
- **Phase ordering** (Part 5) — A → B → C → D → E → F pre-1.0; G
  post-1.0. **Phase D ships one alpha after Phase C** (§7.4), giving
  in-tree and external capsule consumers one full release cycle of
  warning-mode telemetry before the gate flips to errors.
- **Env-var name** (§7.3, §4.7) — `SAILFIN_EFFECT_ENFORCE` with values
  `warning` (default in Phase B), `error` (default after Phase D), `off`.

Open questions §7.5 (Phase E2 split), §7.6 (`prompt {}` blocks), §7.7
(`main` requires effects), §7.8 (`main.sfn` `sfn check` timeout), and
§7.9 (effects on `extern fn`) remain open and will be resolved in
their respective implementation phases — they don't gate Phase A.

Implementation begins now on `claude/effect-validation-gate` with
Phase A (source-span attribution on `EffectViolation`). Each phase
ships as its own PR; this proposal's status header tracks the rollout.
