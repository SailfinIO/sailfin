# Sailfin Roadmap

Updated: April 11, 2026
Owners: Sailfin Core Team

This roadmap pairs with `docs/status.md`. Update status first, then record
strategy changes here. The focus is the 1.0 public release and the work after
launch. Legacy compiler stage references are no longer tracked in this plan.

## Release 1.0 Priorities (Do Now)

The 1.0 release requires a **fully self-hosted toolchain with no Python scripts
or C runtime**. All items below are hard requirements, not stretch goals.

0. **Syntax reform (breaking, do first)**

   These changes alter surface syntax and must land before 1.0 to avoid breaking
   a public API. They are cheaper to make now with zero external users than after
   launch. Each item is independent and can be shipped incrementally.

   - [x] **Colon type annotations** — replace `->` in parameter and variable
         type positions with `:`. Function return types keep `->`.
         Before: `fn add(x -> number, y -> number) -> number`
         After:  `fn add(x: number, y: number) -> number`
         Rationale: `->` for "has type" conflicts with its universal meaning of
         "returns/maps-to." Every mainstream typed language (TypeScript, Rust,
         Python, Kotlin, Swift, Zig) uses `:` for annotations. The current
         syntax is the single most likely reason a new user bounces.
         Source migration complete (compiler, runtime, capsules, tests,
         examples, docs). Emitter update (Phase 5) and parser split
         (Phase 6) complete — the parser now enforces `:` for annotations
         and `->` for return types. See
         `docs/proposals/colon-type-annotations.md`.
   - [ ] **String interpolation delimiters** — replace `{{ expr }}` with
         `${ expr }`.
         Before: `"Hello, {{ name }}!"`
         After:  `"Hello, ${ name }!"`
         Rationale: `{{ }}` universally means "escape interpolation / literal
         braces" (Jinja2, Handlebars, Mustache, Angular, Rust `format!`). Using
         it for the opposite meaning guarantees confusion for humans and will
         cause systematic errors in LLM-generated code, since models are trained
         on billions of lines where `{{ }}` means "don't interpolate."
   - [ ] **Integer numeric types** — introduce `int` (default signed 64-bit
         integer) alongside `float` (64-bit IEEE 754). Keep `number` as an alias
         for `float` for backward compatibility, but make `int` the default for
         integer literals and array indexing.
         Rationale: a single `number` (f64) type causes precision loss above
         2^53, makes bit operations unreliable, makes array indexing semantically
         wrong, and is the root cause of the "double-encoded pointers" fixup
         category (~12 of ~69 compiler fixups). This is JavaScript's worst
         design decision; a compiled systems language must not inherit it.
   - [ ] **Error handling reform** — add `Result<T, E>` to the type system and
         a `?` propagation operator. Complement (don't replace) `try`/`catch`
         for truly exceptional cases.
         Rationale: current error handling is invisible in function signatures.
         Union return types (`number | DivisionError`) require manual `match` at
         every call site with no compiler enforcement. `Result<T, E>` + `?` is
         the industry standard for typed error propagation (Rust, Swift `throws`,
         even Go's explicit `if err`). This pairs naturally with the effect system.
   - [ ] **Closures with capture** — ensure lambdas can capture variables from
         enclosing scopes. This is table-stakes for idiomatic `.map()`,
         `.filter()`, `.reduce()` usage and functional patterns.

   **Migration**: update the parser, EBNF, spec, examples, and compiler source
   for each item. Track each as a separate PR so progress is visible.

1. **Compiler stabilization (build pipeline)**
   - [x] Eliminate the Python fixup script (`scripts/selfhost_native.py`) as a
         build requirement. Removed after v0.5.0-alpha.22 reached clean LLVM IR.
   - [x] Make `scripts/build.sh` the sole clean build path (no post-processing).
   - [ ] Pass `make check` using the shell driver: seedcheck binary compiles
         `examples/basics/hello-world.sfn` and passes the full test suite with no
         Python fallbacks.
   - [ ] Stabilize control-flow LLVM lowering (`.loop` / `.if` / `.break`
         headers) so the seedcheck binary does not hang.

2. **Language feature completeness**
   - [ ] Implement `await` expression parsing and lowering.
   - [ ] Implement `routine { }` block parsing and lowering (concurrent tasks).
   - [ ] Implement `channel()` as a concurrency primitive (not just prompt syntax).
   - [ ] Implement `spawn` expression.
   - [ ] Complete generic type inference for functions, structs, and enums.
   - [ ] Finish interface conformance validation, including variance checks.
   - [ ] Implement generic trait/interface constraints (`fn sort<T: Comparable>`).
   - [ ] Enforce `Affine<T>` / `Linear<T>` move and consume rules — or remove the
         syntax if enforcement won't land by 1.0. Claiming Rust-grade safety with
         parse-only ownership is a credibility issue.
   - [ ] Implement richer diagnostics (multi-span snippets, severity, suggested fixes).
   - [ ] Add `--fix` workflow for missing effect annotations with safe rewrite guards.
   - [ ] Enforce `gpu`, `rand`, and hierarchical effect names (`io.fs`, `net.http`).
   - [ ] Add destructuring assignments (`let { name, age } = user;`).
   - [ ] Add enum methods (associated functions on enum types).

3. **Sailfin-native runtime (hard 1.0 prerequisite)**
   - The C runtime (`runtime/native/`) must be replaced by a Sailfin-native
     runtime before 1.0. This is a breaking change and the right moment to make
     it is at 1.0, not after.
   - [ ] Execute the Sailfin runtime migration plan in `docs/runtime_audit.md`.
   - [ ] Finalize the Sailfin-native ABI spec in `docs/runtime_abi.md`.
   - [ ] Implement the Sailfin-native ABI and versioned layouts.
   - [ ] Define the runtime ownership/memory model and update lowering to match.
   - [ ] Port core runtime helpers (strings, arrays, exceptions, type metadata).
   - [ ] Replace exception plumbing with a structured model in the native runtime.
   - [ ] Remove the C runtime once parity and performance gates are satisfied.
   - [ ] Ship Sailfin-native filesystem, HTTP, and clock adapters.
   - [ ] Document capability adapter behavior and platform requirements in
         `docs/runtime_audit.md`.

4. **Tooling and developer workflow**
   - [ ] Replace the current `sfn` shell wrapper with a Sailfin-native CLI binary.
   - [ ] Replace the C `native_driver` with a Sailfin-native CLI entrypoint.
   - [ ] Remove Python tooling/scripts from the release pipeline and developer
         entrypoints entirely.
   - [x] Remove Python runtime shims (`runtime/runtime_support.py`,
         `runtime/native_runner*.py`).
   - [ ] Remove Python-generated compiler artifacts from the 1.0 toolchain.
   - [ ] Build tooling features on top of the richer diagnostics work tracked in
         **2. Language feature completeness** (multi-span snippets, severity,
         suggested fixes).
   - [ ] Implement `sfn fmt` — canonical token-stream formatter, no configuration.
         Format compiler source and add CI enforcement.
   - [ ] Implement `sfn check` — fast typecheck + effect check without codegen.
   - [ ] Implement `sfn vet` — static analyzer with initial rule set (unused
         imports/vars, dead code, missing effects, redundant mut).
   - [ ] Implement `sfn lsp` Phase 1 — diagnostics on save, go-to-definition,
         hover types (replaces prototype TypeScript LSP).
   - [ ] Implement `sfn doc` — documentation generator from `///` doc comments.
   - [ ] Implement `sfn fix` — automated rewriter from diagnostic suggestions.

   See `docs/proposals/tooling.md` for the full design and rationale.

5. **Release pipeline and distribution hardening**
   - [ ] Publish signed checksums and provenance metadata alongside release artifacts.
   - [ ] Add installer CI that validates `install.sh` against staging artifacts.
   - [ ] Document artifact layout, supported platforms, and upgrade expectations.
   - [ ] Verify build/release workflows only use self-hosted compiler artifacts.

6. **Capsule and workspace manifest system (hard 1.0 prerequisite)**

   The capsule manifest (`capsule.toml`) and workspace manifest (`workspace.toml`)
   are the foundation of Sailfin's packaging, dependency resolution, and
   capability-based security model. All three of Sailfin's differentiators —
   the effect system, capability-based security, and structured concurrency —
   depend on capsules being the unit of trust and compilation. Shipping 1.0
   without this means shipping without the security story.

   **Capsule manifests** — every Sailfin project (including the compiler itself)
   must be described by a `capsule.toml` that declares its name, version,
   dependencies, required capabilities, and build entry point.

   **Workspace manifests** — multi-capsule projects (like the Sailfin repo itself,
   which contains the compiler and 19 stdlib capsules) use a root `workspace.toml`
   to coordinate shared dependency resolution and enforce capability policies
   across member capsules. This is analogous to `go.work`, Cargo workspaces, or
   npm workspaces.

   **The compiler as a capsule** — the compiler (`compiler/src/`) must get its own
   `capsule.toml` as an application capsule. This validates the manifest format at
   scale and eliminates the special-case build path. The compiler's version
   (currently in `compiler/src/version.sfn`) should be sourced from or synchronized
   with its `capsule.toml` manifest.

   - [ ] Add `capsule.toml` to the compiler (`compiler/`) as an application
         capsule with `entry = "src/main.sfn"` and `required = ["io"]`.
   - [ ] Add `workspace.toml` at the repository root listing the compiler and all
         stdlib capsules as workspace members.
   - [ ] Implement `[policies.<capability>]` enforcement in workspace builds —
         reject capsules that declare capabilities not allowed by workspace policy.
   - [ ] Wire the build system to read `capsule.toml` entry points and version
         instead of hardcoding paths in `build.sh`.
   - [ ] Implement capsule-scoped capability auditing — the compiler rejects
         capsule builds that use effects not listed in `[capabilities] required`.
   - [ ] Implement `workspace.toml` parsing in the compiler (extend `toml_parser.sfn`).
   - [ ] Implement intra-workspace `path` dependency resolution
         (`"core" = { path = "../core" }`).
   - [ ] Implement `[shared-dependencies]` version pinning across workspace members.
   - [ ] Finalize `sfn init`, `sfn add`, and `sfn publish` CLI commands.
   - [ ] Stand up registry auth/signing for `registry.sailfin.dev`.
   - [ ] Source the compiler version from `capsule.toml` (retire standalone
         `version.sfn` or generate it from the manifest).

7. **Documentation for public release**
   - [ ] Remove legacy compiler-stage references across docs and examples.
   - [ ] Refresh `docs/spec.md` and `docs/keywords.md` to reflect shipped syntax.
   - [ ] Ensure `docs/status.md` and `README.md` match installer defaults and CLI usage.

## Post-1.0 — AI / Model Execution (First Major Follow-On)

The AI-native features are central to Sailfin's long-term vision but ship after
1.0. This is a deliberate prioritization, not a concession:

- **Ship what works first.** No one adopts a language for features that don't
  work yet. They adopt it for features that work *better* than alternatives.
  The effect system + capability model is that feature for Sailfin.
- **Language constructs vs. library constructs.** `model`, `prompt`, `pipeline`,
  and `tool` keywords bake API-level details (token limits, temperature, engine
  names) into the language grammar. These details change monthly as AI providers
  update their APIs. Consider whether these should be **standard library
  capsules** rather than grammar-level keywords — language constructs should be
  reserved for things that genuinely can't be expressed as libraries. Keep the
  `![model]` effect annotation (that's valuable); provide AI capabilities via
  `sfn/model`, `sfn/prompt` capsules.
- **Competitive reality.** Every major language now has excellent typed AI SDKs.
  The bar for "what does a language keyword give me that a library can't?" is
  high. Earn the right to add keywords by shipping a library first and finding
  the pain points that only syntax can solve.

- [ ] **Model runtime** — implement `Model<I, O>.call()` execution; wire `model`
      blocks to provider adapters (OpenAI-compatible, local, etc.).
- [ ] **Generation cards** — produce signed provenance metadata (engine, params,
      seeds, input hashes, latency, cost) for every model call.
- [ ] **Prompt dispatch** — implement the prompt channel execution pipeline
      (`system` → `user` → `assistant` → `tool`).
- [ ] **Tool dispatcher** — implement model-invocable typed capabilities with
      capability and taint policy enforcement before execution.
- [ ] **Typed prompt channels** — `prompt user<SummaryRequest> { }` with
      shape-checked prompts.
- [ ] **Evaluators** — `Faithfulness`, `LatencyBudget(...)`, and the evaluator
      suite framework.
- [ ] **`PII<T>` / `Secret<T>` enforcement** — runtime taint tracking, egress
      guards, and redaction transformers.
- [ ] **Model evaluators and replay** — golden tests, adversarial suites,
      generation card replay.
- [ ] **Sailfin-native model adapters** — HTTP/gRPC adapters for model providers.

## Post-1.0 — Platform and Ecosystem

- [ ] **Async runtime** — ship a Sailfin-native event loop, task scheduler, and
      channel primitives once coroutine lowering is stable (builds on the 1.0
      concurrency work).
- [ ] **Runtime diagnostics** — structured tracing, allocation telemetry, and
      performance profiling hooks.
- [ ] **Native test framework** — golden/adversarial/replay workflows in
      `sfn test`; CI reporting.
- [ ] **Tensor/GPU effects** — `Vector<N>`, `Tensor<Shape, DType>`, GPU batching,
      and the `gpu` effect runtime.
- [ ] **`|>` pipeline operator** — implement parsing and lowering of the pipe
      operator; enable async/lazy pipelines with backpressure.
- [ ] **`sfn lsp` Phase 2** — completions, cross-file navigation, workspace-wide
      rename, quick fixes, signature help. Extract compiler front-end into
      `sfn/compiler` library capsule for standalone LSP binary.
- [ ] **`sfn bench` framework** — first-class benchmarking with `bench` blocks,
      statistical analysis, and regression tracking.

## Exploration Backlog (Research / Design)

- [ ] WebAssembly emission once LLVM backend coverage is complete.
- [ ] `unsafe` capability enforcement for explicit FFI boundaries.
- [ ] Currency literals (`$0.05`) and time literals (`1s`, `150ms`).
- [ ] Notebook and interactive tooling with live cost/latency overlays.
- [ ] Training workflow (see `docs/proposals/model-engines-and-training.md`).

## Design Principles (Pre-1.0 Decision Framework)

When evaluating features, apply these filters:

1. **Pick 3 differentiators, ship those well.** Sailfin's top 3 are: (1) the
   effect system, (2) capability-based security, (3) structured concurrency.
   Everything else is a nice-to-have that should not block or dilute these.
2. **Boring syntax wins.** Every deviation from mainstream conventions (`:` for
   types, `${}` for interpolation) adds learning curve with zero expressiveness
   gain. Make the syntax boring and familiar so the *semantics* can be novel.
3. **Don't ship unfinished safety claims.** "Parsed but not enforced" ownership
   is worse than no ownership syntax — it teaches users to ignore the feature.
   Either enforce it or remove the syntax until enforcement lands.
4. **AI agents are users too.** LLMs have zero training data for `.sfn` files.
   Conventional syntax reduces LLM error rates. Unusual choices (`{{ }}` for
   interpolation) cause systematic failures in generated code.
5. **Language keywords are expensive.** A keyword can never become a variable
   name. Only add keywords for constructs that genuinely can't be expressed as
   library functions. `model { engine = "..." }` can be a library; `![io]` on
   function signatures cannot.
6. **Fix the type system foundation first.** Integer vs float distinction, proper
   `Result<T, E>`, and generic constraints are prerequisites for everything else.
   Building AI constructs on a type system that encodes pointers as doubles is
   building on sand.

## Completed Items

Completed work is tracked in `docs/status.md` and release notes in `CHANGELOG.md`.
