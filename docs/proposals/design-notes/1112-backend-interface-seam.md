# #1112 — Backend interface seam (SFEP-15 Stage 0)

Design doc for the design gate of #1112. **Stage 0 of the toolchain-independence
arc** — the *design record* is SFEP-15 (`../0015-llvm-independence.md` §6/§8/§11);
this note is the single-issue implementation gate, so it carries no SFEP number.
Unblocks #347 (LLVM C-API backend) and #1640 (seal-sufficient native backend).

---

## Summary

Introduce a single `Backend` seam that hides every `process.run(["clang", …])`
codegen/link call site behind one module (`compiler/src/backend.sfn`), with
today's textual-LLVM-IR + clang path as its sole implementation
(`LlvmTextBackend`). **Zero behavior change** — emitted `.o`/binary byte-identical,
`--check-determinism` passes with no rebaseline. This is SFEP-15 §8 Stage 0 and
the prerequisite seam for #347 and #1640 to plug in cleanly rather than
re-hardcoding LLVM across the driver.

## Motivation

Per SFEP-15 §3/§6: the clang dependency is co-located in the driver but spread
across several call sites wearing four hats (compile runtime C, assemble
`.ll`→`.o`, link the final binary, pull in libc). There is no seam to slot an
alternative backend into. Stage 0 creates that seam mechanically, with no
semantic change, so #347 lands as "a faster LLVM backend impl" and the native
backend (#1640) arrives as a second impl.

## Design

### Decision: concrete struct, not trait-object dispatch

`compiler/src/` contains **zero** uses of `interface`/`impl`/`implements`-typed
*values* — the compiler has never dynamically dispatched through a trait object
in its own source, even though the LLVM backend *can* lower one. The seam is a
**concrete struct `LlvmTextBackend` with methods**, with the `Backend` interface
declared for documentation/conformance but **not** used as a dynamic value type.
The backend is selected by direct construction at the driver call sites
(`let backend = LlvmTextBackend {};`) — the issue's "hard-wired, no flag/env"
scope. When #347/#1640 add a second impl, the selection point becomes a small
factory returning the concrete struct chosen by build mode.

### The real call-site inventory (grounded)

Actual `process.run` clang invocations that are **codegen/link** (routed through
the seam):

1. `cli_main.sfn` `_clang_compile_runtime_capsule_objects` — runtime **c-source**
   compile (`clang <opt> -Wno-override-module -ffunction-sections -fdata-sections
   [-I…] -c <src> -o <obj>`) → `backend.assemble`.
2. same fn — runtime **ll-source** assemble → `backend.assemble`.
3. `_emit_runtime_sfn_to_obj` — runtime **sfn-source** `.ll`→`.o` → `backend.assemble`.
   (The sibling `process.run(["sh","-c", …])` child *emit* is a compiler
   subprocess, not clang — stays out of the seam.)
4. `_clang_link_multi_with_opt` — the **final program link** → `backend.link`
   (program layout). **Program/capsule `.ll`→`.o` is *not* a separate clang
   call** — those `.ll` inputs are compiled inline by this same link invocation.
5. `--no-link` **library build** object emit (`clang -O2 … -c <ll> -o <out>`) →
   `backend.assemble`.
6. `cli/commands/test.sfn` `_clang_link_test_cmd_with_deps` — the **`sfn test`
   link** → routes through `cli_main::link_test_objects` → `backend.link` (test
   layout). It does **not** import `backend` directly; see the cross-dir
   self-host note below.

Clang invocations that are **validation, not codegen/link** — left **out** of the
Stage-0 seam (the issue scopes the seam to lower+link): the
`llvm-as`/`clang -c -emit-llvm` validator cascade (`emit_helpers.sfn`,
`capsule_emit_parallel.sfn`), invoked via `sh -c`. Folding them in expands blast
radius for no Stage-0 benefit; a future `Backend.validate(ll) -> bool` is a clean
optional add once a second backend exists.

### Interface + types (final shapes wrapping today's behavior verbatim)

The SFEP-15 sketch (`lower(module: NativeModule) -> ObjectArtifact`,
`link(objects, out, libs)`) does not match what actually flows: the driver never
hands the backend a `NativeModule`, and program/capsule `.ll`s are assembled
*inline by the linker*, not pre-lowered to objects. The implemented shapes:

```sfn
// compiler/src/backend.sfn

// Reserved object-file handle for later stages (#347/#1640 produce these
// in-process); Stage 0 returns the clang exit code directly.
struct ObjectArtifact { path: string; }

// Semantic link inputs computed by the driver; `test_mode` selects which
// of the two byte-distinct clang argv layouts LlvmTextBackend reproduces.
struct LinkPlan {
    objects: string[];          // prebuilt runtime .o
    ir_inputs: string[];        // .ll compiled inline (program+capsule, or test+deps)
    out_path: string;
    opt_flag: string;           // "-O2" build/run, "-O0" test
    link_flags: string[];       // program layout only: linker-sel/section/dead-strip/retain
    libs: string[];             // runtime link-libs (+ test's -lm/-pthread backstop)
    test_mode: boolean;         // false = program/build layout, true = `sfn test` layout
}

interface Backend {
    fn assemble(self, src: string, out: string, opt_flag: string,
                include_flags: string[]) -> int ![io];
    fn link(self, plan: LinkPlan) -> int ![io];
}

struct LlvmTextBackend { /* stateless; methods delegate to free fns (see below) */ }
```

**Why `test_mode`, not a single template (a correction to the original sketch).**
The two link sites do **not** emit the same argv shape, so the original "map the
test link onto the same `LinkPlan` with `linker_flag=""`, `extra_flags=[]`" plan
would have *reordered* the test link's clang inputs and risked non-byte-identical
output — violating the zero-rebaseline gate. Grounded in the source:
- **Program/build** (`_clang_link_multi_with_opt`): `clang <opt> -Wno-override-module
  <link_flags…> <runtime .o…> <program/capsule .ll…> -o <out> <libs…>` — `-o` at the
  **end**, objects **before** IR, with section/dead-strip/linker flags.
- **`sfn test`** (`_clang_link_test_cmd_with_deps`): `clang -O0 -Wno-override-module
  -o <out> <test .ll> <dep .ll…> <runtime .o…> <libs…>` — `-o` **early** (before
  inputs), IR **before** objects, **no** section/strip/linker flags.
Reordering `.ll`/`.o` inputs to a linker can change section/symbol layout and thus
output bytes, so the seam must preserve each layout exactly. `test_mode` is the
discriminator; the impl branches on it. A native backend implements both branches
trivially (it ignores `link_flags` and links `objects`+`ir_inputs` directly).

Threading notes (verbatim-preservation):
- `assemble` keeps the **exact argv order** of each call site: `["clang", opt_flag,
  "-Wno-override-module", "-ffunction-sections", "-fdata-sections", <includes>,
  "-c", src, "-o", out]`. Runtime objects pass `[-I…]`, library builds pass none.
- For the program link the driver continues to *compute* the linker selection, the
  section flags, the dead-strip-safe gate (incl. its diagnostic) and retain-root
  enumeration into `link_flags`, and the runtime `libs` — exactly as now. The
  backend only owns the final `process.run(argv)`, keeping determinism-sensitive
  flag *computation* in the driver and byte-stable.
- `ObjectArtifact` is the named return wrapper reserved for #347/#1640; Stage 0
  keeps `assemble`/`link` returning `int` (the clang exit code callers already
  consume) to avoid disturbing `LinkResult`/`RuntimeLinkInputs` plumbing.

### Placement & selection

- New module `compiler/src/backend.sfn` holds `ObjectArtifact`, `LinkPlan`,
  `Backend`, `LlvmTextBackend`, and the argv-builder free functions.
- **Import-cycle safety:** `backend.sfn` calls `process.run` only — it imports
  nothing from the driver. The driver imports `backend.sfn`; no back-edge, no new
  cycle.
- Selection is direct construction (`LlvmTextBackend {}`) at each call site — no
  flag, no env, no factory this issue.

## Effect & capability impact

Both interface methods carry `![io]` (they spawn subprocesses) — matching the
effect on every function they replace (`_clang_*` are all `![io]`). No new effect;
call sites are already `![io]`, so effect-checking is unchanged. Conformance is
checked structurally; because the concrete struct is constructed directly (no
trait-object value), conformance is the only interface machinery exercised.

## Self-hosting impact

- The new `backend.sfn` uses **only** constructs the compiler already self-hosts,
  so the **old seed compiles the new compiler** with no seed dependency (same-seed,
  in-tree refactor; no `/pin-seed`, no seed-cut tax). The seam and its sole
  consumer (the driver) land in **one PR** (seed-dependency rule: bundle).

Two build-only failures surfaced during implementation — both **#1389-class**
(`sfn check` green, `make compile` red) and worth recording because #347/#1640
will grow this surface:

1. **`.push` inside a struct method body does not lower.** The first cut put the
   argv-assembly loops directly in the `LlvmTextBackend.assemble`/`link` **method
   bodies**. `sfn check` accepted it; the self-host emit failed at LLVM lowering:
   `cannot resolve return type for call to 'args.push' — callee signature is not
   known to the compiler`. Every working `.push` in the driver is in a *free
   function*. **Fix:** the argv builders are module-level free functions
   (`_llvm_text_assemble_argv` / `_llvm_text_link_test_argv` /
   `_llvm_text_link_program_argv`) and the methods are thin delegators
   (`return process.run(_llvm_text_*_argv(...))`).
2. **Cross-dir import of a method-bearing struct under `--import-context`.** After
   fix 1, the self-host still failed to lower `cli/commands/test` (named only under
   serial emit, `SAILFIN_BUILD_JOBS=1`). The module's **standalone** emit succeeded
   (904 KB IR, exit 0) and `cli_main.sfn` (same-dir `./backend` import, identical
   `LinkPlan` construction + `backend.link` call) lowered fine — the failure is
   specific to the **cross-dir `../../backend` import** of the method-bearing
   `LlvmTextBackend` **combined with the build's `--import-context`** staging
   (standalone emit lacks that context and passes; `make clean-build` did **not**
   fix it, ruling out staleness). **Fix for Stage 0:** keep all backend usage in
   `cli_main.sfn` (sibling of `backend.sfn`) and have `cli/commands/test.sfn`
   delegate its link through a `cli_main` entry point (`link_test_objects`) — which
   it already imports from. The `Backend` seam is unaffected (every clang
   codegen/link path still routes through it); only the *call site* moved up one
   module. The lowering gap itself is a **follow-up compiler issue** (cross-dir
   import-context lowering of interface/method-bearing structs), out of scope for
   the mechanical Stage 0 seam.

## Alternatives

1. **Trait-object dynamic dispatch** (the SFEP-15 sketch literally). Rejected for
   Stage 0: exercises codegen the compiler has never run on *itself*, risking a
   self-host regression for zero Stage-0 value. Adopt when a second impl needs
   runtime selection.
2. **Free functions in a `backend` namespace, no interface.** Loses the conformance
   contract #347/#1640 cite; the interface declaration is cheap and documents the
   seam.
3. **Fold validation into the seam now.** Out of issue scope, larger blast radius,
   and a native backend's validation differs; defer to `validate()`.

## Stage1 readiness mapping

Pure refactor (no new surface syntax): parses (existing interface/struct grammar),
typechecks (conformance), emits/lowers (existing struct-method + free-fn path),
regression = existing suite + `--check-determinism` (no new behavior beyond
byte-identity), self-hosts (`make compile` green), `sfn fmt --check` clean. Not a
user-facing feature → no spec chapter; `docs/status.md` notes the seam.

## Test plan

The gate is *zero behavior change*, so verification is the existing suite plus:
- `make compile` green (self-host with the seam). ✅
- `grep -rn 'process.run(\["clang"' compiler/src/ | grep -v backend.sfn` → empty. ✅
- `sfn fmt --check` clean on every touched file (canonical self-hosted binary). ✅
- hello-world builds+runs (program link), one unit test builds+runs (`sfn test`
  link). ✅
- `make check` + `--check-determinism` (no rebaseline) — CI on the PR.

## References

- SFEP-15 `../0015-llvm-independence.md` §6, §8 (Stage 0), §11.
- #347 (LLVM C-API backend), #1640 (seal-sufficient native backend).
- Touched: `compiler/src/backend.sfn` (new), `compiler/src/cli_main.sfn`,
  `compiler/src/cli/commands/test.sfn`, `docs/status.md`.
