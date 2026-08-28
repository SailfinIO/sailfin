# SFN-1006 — `spawn <named_fn>()` lowering

Single-issue implementation design gate. **Design only — no compiler code
written here.** Not an SFEP: this fixes one broken lowering branch and adds one
fail-closed frontend diagnostic, which `.claude/rules/proposals.md` puts below
the SFEP bar (it is the "single-issue design gate" genre → `design-notes/`).

Issue: `SFN-1006` — "spawn of a named function ICEs at link when its handle
enters a `Task<T>[]` array — invalid cast i64 to ptr" (type:bug, area:compiler,
High, 3 points, cycle-current, `In Progress`).

**Could not verify empirically:** `build/bin/sfn` was mid-self-host for the
whole session, so nothing below was run. Every claim is from source reading;
§7 lists exactly which claims an implementer must confirm with a binary in
hand, and which test is the cheapest confirmation of each.

---

## 0. Executive summary — the five decisions

| Ask | Decision |
|---|---|
| **A. Where the spawn kind is resolved** | **Not in analysis, and no AST stamping.** Resolve it in the LLVM lowering from the native function table (`find_function_by_name_or_import`), exactly as `emission_async.sfn:98` already resolves the `async fn` spawn family. That table is strictly richer than anything emit can see: it includes **imported** functions with their `return_type` (`lowering_phase_imports.sfn`), which the emit-side AST does not. The AST-stamping precedent does exist (§2.1.2) and is named; it is rejected with reasons. |
| **B. Can `lower_spawn_typed_expression` take the operand as-is** | **No — not as `worker()`.** Its operand-shape branch (`:612-649`) lowers the operand as a *value*, so a call operand yields the callee's return value. It would work verbatim on the bare name `worker` (the fn-reference tail at `core_expression_tail.sfn:382-412` already lowers a bare fn name to `bitcast <ret> ()* @worker to i8*`), but reaching it requires an operand-text rewrite that reintroduces a shadowing hazard. **Emit the three instructions directly in `lower_spawn_expression`** instead; §2.2 gives the exact IR. |
| **C. Argument scope** | **Zero-arg only.** `spawn worker(1, 2)` is rejected at check with a new **`E0842`**. The `_ctx` runtime family passes exactly **one** `*u8` and the trampoline calls `entry(user_ctx)` — marshalling N call arguments needs a synthesized thunk, i.e. the lambda-lift machinery, run *after* capture analysis has already keyed its records. That is a feature, not a 3-point bug fix. |
| **D. What the untyped path becomes** | It **becomes** the named zero-arg-call spawn lowering. Everything it does not recognise stops emitting `@sfn_spawn_task` + the illegal cast and instead raises a fail-closed **`E1010`** (`lowering_error_diag`, severity `error` → IR write refused, build exits non-zero). `@sfn_spawn_task` loses its last emitter. |
| **E. Scope check** | **No scope growth; do not pause.** `E0842` is the new internal fail-closed code criterion 4 explicitly expects. The one thing worth naming out loud: making the repro *work* necessarily makes `spawn <zero-arg named fn>()` a **documented, shipped surface** (Stage1 readiness ⇒ `docs/status.md` + the preview chapter), because criterion 1 requires it to compile and run. That is a consequence of the issue's own acceptance bar, not an addition to it. |

---

## 1. Current state

### 1.1 The chain (confirmed by reading, matches the brief)

| Stage | File:line | Behaviour on `spawn worker()` |
|---|---|---|
| Parse | `compiler/capsules/syntax/src/parser/expressions/prefix.sfn:128-147` | `Spawn { operand: Call, kind: "", return_type: null }` — `return_type` is copied only from a `Lambda` operand (`:135-137`). |
| Typecheck | `compiler/capsules/analyzer/src/typecheck/expression_walk.sfn:432-437` | Recurses into the operand; `check_spawn_expression` is invoked **only** for a `Lambda` operand, so no spawn rule fires. `sfn check` is green. |
| Kind derivation | `.../typecheck/concurrency_rules.sfn:33-48` (`analyze_spawn_expression`) → `.../typecheck_types/expr_type_rules.sfn:204-221` (`spawn_future_kind`) | Purely syntactic over the node; with `return_type == null` the kind stays `""`. |
| Emit | `compiler/capsules/codegen/src/emit_native_format.sfn:358-373` | `kind.length > 0` → `spawn:<kind> <operand>`; otherwise the bare `spawn <operand>` — here `spawn worker()`. |
| Dispatch | `.../codegen-llvm/src/expression_lowering/native/core_expression.sfn:236-245` | `spawn:` → `lower_spawn_typed_expression` (works); `spawn ` → `lower_spawn_expression` (broken). |
| **Bug site** | `.../native/core_concurrency_lowering.sfn:673-730` (`lower_spawn_expression`) | Lowers `"worker()"` with the generic expression lowerer (`:683`) → `call i64 @worker()` (**evaluates the callee synchronously — wrong semantics, not merely a bad cast**), then `:690` sees `llvm_type != "i8*"` and emits `bitcast i64 %t0 to i8*` → the reported ICE. |

### 1.2 The two facts that make the fix small

Both were verified by reading and are load-bearing:

1. **`core_expression_tail.sfn:382-412`** — a bare identifier naming a
   top-level or `extern` function already lowers to
   `bitcast <fn-ptr-type> @<symbol> to i8*`, yielding an `i8*` operand, and
   deliberately *not* a `{i8*, i8*}` closure pair. Its own comment says this is
   what lets a Sailfin function reach a C-ABI `start_routine`. So the "bare
   function reference" operand shape `lower_spawn_typed_expression:609` names
   is real and reachable — the untyped path simply never produces it.
2. **`emission_async.sfn:90-136`** — the `async fn` wrapper resolves the spawn
   family *in the backend* from the function's own declared return type
   (`spawn_symbol_for_return_type(fn_return_type)`), and emits exactly the
   instruction sequence this fix needs, including the comment recording why the
   `i8*` bitcast is mandatory (#1193: passing a raw `<ret> ()*` into an `i8*`
   parameter is malformed typed-pointer IR that the backend miscompiles).

### 1.3 Runtime ABI (confirmed, `runtime/sfn/concurrency/future.sfn`)

```
fn sfn_spawn_int(fn_ptr: *u8) -> *u8         // :250
fn _sfn_trampoline_int(ctx: *u8) -> *u8      // :227 — entry: *fn () -> i64; calls entry()
fn sfn_spawn_int_ctx(fn_ptr: *u8, ctx: *u8) -> *u8   // :255 — malloc'd {fn,ctx} pair
fn _sfn_trampoline_int_ctx(ctx: *u8) -> *u8  // :233 — entry: *fn (*u8) -> i64; calls entry(user_ctx)
```

The no-`_ctx` family takes **the address of a zero-argument function** and calls
it with zero arguments. A named zero-arg Sailfin function is exactly that
shape — no thunk, no env, no lift. The `_ctx` family threads exactly **one**
`*u8`; it is an env pointer, not an argument vector (see §2.3).

Declaration side: `runtime_helpers/registry_concurrency.sfn:69` declares
`sfn_spawn_int` with `return_type: "i8*"`, so the call site must be
`call i8* @sfn_spawn_int(i8* …)` followed by a bitcast to the future pointer —
the form `lower_spawn_typed_expression:653-660` already uses.

---

## 2. Design

### 2.1 A — where the kind is resolved

**Decision: in `lower_spawn_expression`, from `NativeFunction.return_type`.**
The `.sfn-asm` text is unchanged (`spawn worker()`); the AST is unchanged; the
analyzer gains a diagnostic and no type stamping.

#### 2.1.1 Why the backend is the right stage here

The `spawn:<kind>` tag exists because a **lifted lambda** operand
(`<closure_pair @sfn_lambda_0 null>`) carries no recoverable link to a declared
return type at the point the tag is consumed. A **named call** is the opposite
case: the operand text *is* the symbol, and the symbol's declared return type is
already in the same `.sfn-asm` module — and, for a cross-module spawn, in the
imported-function table the LLVM stage builds. So the kind is *derivable* from
the IR, not missing from it; the IR stays self-describing either way.

Concretely, at lowering time `functions: NativeFunction[]` contains:

- local `.fn` declarations, and
- imported functions parsed out of the provider's staged `.sfn-asm`, plus
  alias clones (`lowering_phase_imports.sfn:93-125`, which copies
  `return_type: src.return_type` verbatim).

`find_function_by_name_or_import` (`rendering_helpers.sfn:362`) resolves both,
including the mangled `name__<provider>` form.

#### 2.1.2 The AST-stamping alternative, named and rejected

The precedent asked for **does exist**, and if stamping were the right answer
this is exactly where it would go:

- Pass: `lift_non_capturing_lambdas` (`compiler/capsules/codegen/src/lambda_lowering.sfn:131`),
  which runs inside `emit_native_with_module_name` *before* any `.sfn-asm` text
  is generated (`emit_native.sfn:148`).
- Mechanism: `build_fn_signature_table(program)` →
  `LiftContext.signatures: FnSigEntry[]`
  (`lambda_param_inference.sfn:251-275`), consumed by the existing type-stamping
  helpers `backfill_call_argument` (`:576`) and
  `backfill_lambda_return_from_body`, which write resolved type *text* onto AST
  nodes. The `Spawn` arm at `lambda_lowering.sfn:921-937` already rebuilds the
  node and would only need to fill `return_type`.

Rejected for four reasons, in descending weight:

1. **Import blindness.** `build_fn_signature_table` walks
   `program.statements` only. `spawn imported_worker()` would silently fail to
   stamp and fall through to the untyped path — i.e. a `check`-green program
   that fails at build, *recreating the #1389 divergence class this issue is
   filed under*. The backend has no such gap.
2. **`FnSigEntry` carries no return type** (`param_type_texts` only), so the
   struct needs a new appended field plus a new lookup, for a fact the next
   stage already holds.
3. **The operand-text rewrite is a hazard.** To reuse
   `lower_spawn_typed_expression` the emitted operand must become the bare name
   `worker` (its branch lowers the operand as a value). A local or parameter
   named `worker` then resolves *before* the fn-reference tail and the spawn
   silently takes a data value as a code address. Emitting the bitcast directly
   from the resolved `NativeFunction` removes the class.
4. **Test churn for nothing.** `compiler/tests/unit/concurrency_emit_test.sfn:34`
   pins "spawn of a call renders without a kind qualifier"; stamping inverts it.
   The backend fix leaves emit — and that test — untouched.

**What would flip this decision:** if a future consumer of `.sfn-asm` other than
the LLVM lowering needs the future kind of a named spawn without a function
table (a second backend, or a typed-`.sfn-asm` verifier), stamp it then, in the
lift pass, and additionally teach it about imports.

Note the analyzer boundary is respected either way: `analyzer/src/mod.sfn` stays
a pure analyzed-program facade; the only analyzer change in this design is a
diagnostic rule (§2.3), which is what that module is for.

### 2.2 B — the IR to emit

For `fn worker() -> int` and `let hs: Task<int>[] = [spawn worker()];`:

```llvm
  %t0 = bitcast i64 ()* @worker to i8*
  %t1 = call i8* @sfn_spawn_int(i8* %t0)
  %t2 = bitcast i8* %t1 to %SailfinFutureInt*
```

`%t2` (type `%SailfinFutureInt*`) is the returned `LLVMOperand`. It matches the
`Task<int>[]` element slot type that `type_mapping.sfn:472` resolves via
`future_pointer_type_for_return_type`, so the array-literal store and the
`.push` store both take the existing pointer-width path, and `await hs[0]`
selects `sfn_await_int` from the slot type through
`await_symbol_for_future_pointer_type` — no await-side change.

The three text pieces come from helpers that already exist and are already
reachable from this file without a new import cycle:

| Piece | Source |
|---|---|
| `i64 ()*` (bitcast source) | `map_return_type(context, callee.return_type) + " ()*"` — `map_return_type` is already imported into `core_concurrency_lowering.sfn` from `../../type_mapping`. |
| `@worker` | `"@" + callee.name` — the resolved `NativeFunction.name`, bare; the module mangling post-pass rewrites defined-fn names and leaves `extern` names alone (documented at `core_expression_tail.sfn:360-371`). |
| `sfn_spawn_int` | `spawn_symbol_for_return_type(callee.return_type)` — `compiler/capsules/codegen-llvm/src/type_mapping.sfn:995`. |
| `%SailfinFutureInt*` | `future_pointer_type_for_return_type(callee.return_type)` — `type_mapping.sfn:969`. |

Both spawn/future mappers must be **added to the existing import from
`../../type_mapping`** in `core_concurrency_lowering.sfn:11`. `type_mapping.sfn`
imports only `./symbols`, `./types`, `./utils` and `sfn/strings`, so this adds
no cycle. Do **not** import them from
`expression_lowering/native/statement_suspension.sfn` (the copies
`emission_async.sfn` uses): that module imports `./core`, which imports this
file.

For a `void` callee the same shape yields
`bitcast void ()* @w to i8*` / `@sfn_spawn_void` / `%SailfinFutureVoid*`.

### 2.3 C — argument scope: zero-arg only, `E0842` for the rest

**Ruling: the fix covers `spawn worker()` with zero arguments. Every other
spawn operand that is not a `Lambda` is rejected at check with `E0842`.**

Justification (the `_ctx` question, asked explicitly):

`sfn_spawn_<kind>_ctx(fn_ptr, ctx)` mallocs a 16-byte `{fn, ctx}` pair and the
trampoline calls `entry(user_ctx)` — a **single** `*u8`. It is an environment
pointer, and the only producer of a matching worker is the lambda lift, which
synthesizes `fn(i8* env) -> T` and an env struct from a `LambdaCaptureRecord`.
Reusing it for `spawn worker(1, 2)` means synthesizing a thunk that unpacks a
heap env and calls `worker(a, b)` — that is `spawn worker(a,b)` ≡
`spawn fn() -> T { return worker(a,b); }`, i.e. desugaring to a lambda. That
desugar cannot be done in the lift pass, because capture analysis has already
run and keys its records by the lambda body's opening `{` token
(`lambda_lowering.sfn:_find_capture_record`); a synthesized lambda has no
record and takes the no-record branch. Doing it properly means running the
desugar before capture analysis — a frontend feature, not a codegen bug fix.

The user-facing escape hatch is one line and already ships:
`spawn fn() -> int { return worker(1, 2); }`. The diagnostic says so.

#### `E0842` — allocated from the `E08xx` range

Range table row: `docs/style-guide.md:226` — `E08xx` already owns the
concurrency-handle frontend rejects (`E0836` heterogeneous handle push,
`E0837` double-await, `E0838` nursery escape), so a spawn-target reject belongs
there. `E0839`/`E0840`/`E0841` are taken (SFN-667, SFN-901); **`E0842` is
free** (verified by grepping `E08[0-9][0-9]` across `compiler/`, `docs/`,
`site/`).

Factory to add next to `make_spawn_handle_kind_mismatch_diagnostic` in
`compiler/capsules/analyzer/src/typecheck_types/expr_type_rules.sfn` (after
`:466`), following the shape of its neighbours (`code`/`severity: "error"`/
`primary: token_from_name("spawn", span)`/`suggestion: null`):

```
fn make_spawn_unsupported_target_diagnostic(detail: string, span: SourceSpan?) -> Diagnostic
```

Message = `"cannot spawn " + detail + ": `spawn` accepts an inline `fn` literal
(`spawn fn() -> T { ... }`) or a call to a zero-argument named function
(`spawn worker()`). Wrap anything else in a task lambda: `spawn fn() -> T {
return <expr>; }`."`

`detail` per case, all `E0842`:

| Operand shape | `detail` |
|---|---|
| `Call`, `arguments.length > 0` | ``"`" + name + "` with arguments"`` |
| `Call`, callee is not an `Identifier` (`obj.m()`) | `"a method or computed callee"` |
| `Call`, `Identifier` that is not a declared function or import | ``"`" + name + "`, which is not a declared function"`` |
| any other variant (`Identifier`, `Binary`, literal, …) | `"an expression that is not a function call or `fn` literal"` |

Rule function, in `compiler/capsules/analyzer/src/typecheck/concurrency_rules.sfn`
(where every other spawn rule lives), replacing nothing:

```
fn check_spawn_target(expression: Expression, ctx: TypeckCtx) -> Diagnostic[]
```

Order: operand `null` → `[]` (the parser already reported); `Lambda` →
delegate to the existing `check_spawn_expression` (keeps `E0813` exactly as
today); `Call` → the four-way table above, using
`resolve_call_signature(name, ctx).known` (`typecheck/call_signature.sfn:131`)
as the "is a declared function or import" test — it consults
`_find_proven_call_symbol(ctx.bindings, …)` then
`lookup_imported_function(ctx.imports, …)`, which is the frontend twin of the
backend's `find_function_by_name_or_import`; anything else → `E0842`.

New imports in `concurrency_rules.sfn`: `TypeckCtx` from `./context`,
`resolve_call_signature` from `./call_signature`. Neither imports
`concurrency_rules`, so no cycle. If the implementer prefers to keep this module
ctx-free (its other rules take a bare `SymbolEntry[]`), the equivalent is to pass
`bindings` + `imports` and inline the two lookups — same behaviour, one more
parameter.

Wiring: `compiler/capsules/analyzer/src/typecheck/expression_walk.sfn:432-437`
— keep the operand recursion, and replace

```
if expression.operand.variant == "Lambda" { … check_spawn_expression … }
```

with an unconditional `check_spawn_target(expression, ctx)`. Update the stale
comment at `:425-431` (it says a spawn of a named-fn call "needs expression-type
inference (#829)"; after this change it needs only the callee's declared return
type, which the resolver already has).

**The `builtin` caveat.** `resolve_call_signature` returns `known: true` for the
fixed builtin envelope (`print`, `sleep`, …). `spawn print()` would therefore
pass the frontend and then fail closed in lowering (`E1010`, no `@print` in the
function table). Accept it: it is a nonsense program that fails with a real code
either way. Do not add a builtin carve-out — the divergence is one diagnostic
code on a program nobody writes, and the extra rule is a false-positive surface
on any user `fn print`.

### 2.4 D — the untyped path's new role

`lower_spawn_expression` (`core_concurrency_lowering.sfn:673-730`) is rewritten
as a **recogniser**, not a generic lowerer. It stays reachable: it is the arm
`core_expression.sfn:242-245` dispatches every bare `spawn ` to, which after
this change is exactly the named-call form (emit still renders no kind tag for
it, §2.1).

Algorithm (replaces the whole body; the existing `lines`/`temp`/`diag`
threading and the `ExpressionResult` construction are preserved verbatim):

1. `spawn_op_text = trim_text(substring(stripped, 6, stripped.length))` —
   unchanged.
2. Reject unless it is a zero-arg call: `ends_with(spawn_op_text, ")")`, let
   `paren = index_of(spawn_op_text, "(")`, require `paren > 0`, require
   `trim_text(substring(spawn_op_text, paren + 1, spawn_op_text.length - 1))`
   to be empty, and require
   `is_simple_identifier(trim_text(substring(spawn_op_text, 0, paren)))`.
   (`ends_with` joins the existing `../../utils` import; `is_simple_identifier`,
   `index_of`, `trim_text`, `substring` are already imported.)
3. **Shadow guard** — reject if `find_local_binding(locals, name) != null` or
   `find_parameter_binding(bindings, name) != null`. A same-named local means
   the source call was a closure call, not a direct call; taking the top-level
   function's address there would be a silent miscompile. Both helpers are
   already imported.
4. `let callee = find_function_by_name_or_import(functions, name)` — **new
   import** from `../../rendering_helpers` (the same edge `core_expression.sfn:9`
   already has). Reject if null.
5. Emit the three lines of §2.2 and return the future-pointer operand.
6. **Every rejection above** falls into one shared tail: push
   `lowering_error_diag("E1010", message, null)` plus the legacy
   `"llvm lowering [fatal]: " + message` string, and return `operand: null`.
   `error` severity is what `lowering_core/diagnostics.sfn:has_error_diag`
   checks, so IR writes are skipped and the build exits non-zero — the pattern
   `core_expression.sfn:196-221` documents for `E1010`.

   Message: `"spawn: `" + spawn_op_text + "` is not a spawnable target — only a
   call to a zero-argument named function or an inline `fn` literal can be
   spawned (see E0842)"`.

**Do not allocate a new lowering code.** `docs/style-guide.md:228` assigns
`E1010` to "concurrency lowering"; this is that.

`@sfn_spawn_task` loses its only emitter. Leave
`runtime/sfn/concurrency/channel.sfn:369` in place — deleting an exported
runtime symbol is a separate, seed-sensitive change (`.claude/rules/seed-dependency.md`
carve-out territory) and is not needed for this fix. Note it in `docs/status.md`
as unreferenced, and file a follow-up for removal.

---

## 3. Files affected, by pipeline stage

**Syntax:** none. The parser is correct — leaving `return_type: null` for a
non-lambda operand is the right call for a pass with no symbol table
(`prefix.sfn:130-137`, SFN-708).

**Analyzer (typecheck):**

| File | Change |
|---|---|
| `compiler/capsules/analyzer/src/typecheck_types/expr_type_rules.sfn` | Add `make_spawn_unsupported_target_diagnostic` (`E0842`) after `:466`; add it to the module's export list. |
| `compiler/capsules/analyzer/src/typecheck/concurrency_rules.sfn` | Add `check_spawn_target`; import `TypeckCtx`, `resolve_call_signature`, the new factory. Update the module header comment `:21-32` (it asserts the only live rule is the lambda one). Leave `check_spawn_expression` and `analyze_spawn_expression` untouched — `emit_native_format.sfn` calls the latter and its behaviour must not change. |
| `compiler/capsules/analyzer/src/typecheck/expression_walk.sfn` | `:432-437` call `check_spawn_target` unconditionally; refresh the `:425-431` comment. |

**Emit (`.sfn-asm`):** none.

**LLVM lowering:**

| File | Change |
|---|---|
| `.../codegen-llvm/src/expression_lowering/native/core_concurrency_lowering.sfn` | Rewrite `lower_spawn_expression` (`:673-730`) per §2.4. Add `spawn_symbol_for_return_type` + `future_pointer_type_for_return_type` to the `../../type_mapping` import (`:11`), `ends_with` to the `../../utils` import (`:22-27`), and a new `find_function_by_name_or_import` import from `../../rendering_helpers`. Replace the function's doc comment — "Uses the generic `spawn_task` adapter" is about to be false. |

**Runtime:** none. No new intrinsic, no new builtin, no runtime-source consumer
of a new compiler capability.

**Docs:** `docs/status.md` (`spawn` / `await` row: the zero-arg named-fn form
ships, args are `E0842`, `sfn_spawn_task` is now unreferenced),
`site/src/content/docs/docs/reference/preview/concurrency.md` (same, one
paragraph), `docs/style-guide.md:226` (append the `E0842` row entry:
`` `spawn` target not a zero-argument named function or `fn` literal (`E0842`, SFN-1006) ``).

---

## 4. Tests

### 4.1 New — e2e behavioural (acceptance criteria 1 and 2)

`compiler/tests/e2e/spawn_named_fn_test.sfn`. Model it on
`compiler/tests/e2e/task_join_all_test.sfn:13-60` — reuse its
`clean_runner_env(env.get("SAILFIN_TEST_SCRATCH"))` child env, `mkdtemp`
fixture dir, `_build_and_run`, and `_check_output` helper shapes verbatim
(`.claude/rules/no-bash-e2e.md`: `SAILFIN_TEST_SCRATCH` isolation is
pool-mandatory, and `clean_runner_env` is mandatory for a nested `sfn`).

1. `"spawn named fn: array-literal handle runs and awaits"` — the issue's
   six-line repro verbatim; assert `exit == 0` and `find(output, "v=7") >= 0`.
2. `"spawn named fn: pushed handle runs and awaits"` — same program with
   `let mut hs: Task<int>[] = []; hs.push(spawn worker());`.
3. `"spawn named fn: void target spawns"` — `fn tick() -> void { }` plus
   `let h: Task<void> = spawn tick();`, asserting a clean build. Pins the
   non-`int` kind selection. *(If `Task<void>` is not an accepted annotation,
   fall back to an unbound statement `spawn tick();` inside a `routine { }` and
   assert exit 0 — see §7.4.)*
4. `"spawn named fn: arguments are rejected at check"` — `spawn worker(1)`;
   assert `sfn check` exits non-zero and its combined output contains `E0842`.
5. `"spawn named fn: method-call target is rejected at check"` —
   `spawn obj.work()`; same assertions.

### 4.2 New — the `check_build_agree_*` guard (criterion 5)

`compiler/tests/e2e/check_build_agree_spawn_named_fn_test.sfn`, modelled on
`compiler/tests/e2e/check_build_agree_module_global_test.sfn` including its
contract-note header (check is not a build oracle) and its `with_tmp_dir`
build isolation. Two agreements, both directions:

- **Green agreement:** the repro — `check_exit == 0`, `build_exit == 0`,
  `check_exit == build_exit`. This is the exact false-green the issue reports.
- **Red agreement:** `spawn worker(1)` — `check_exit != 0` **and**
  `build_exit != 0`. Asserting both directions is what makes this a divergence
  guard rather than a happy-path test.

### 4.3 New — unit

- `compiler/tests/unit/concurrency_typecheck_test.sfn` (it already imports
  `analyze_spawn_expression` and the kind resolver): add `E0842` cases for the
  four `detail` branches of §2.3, and a negative case proving a zero-arg call to
  a declared function produces **no** diagnostic. Parse-driven, following the
  file's existing `:179` pattern.
- `compiler/tests/unit/concurrency_lowering_test.sfn`: add one IR-shape test —
  `fn worker() -> int { return 7; } fn main() ![io] { let f = spawn worker(); }`
  lowers to `@sfn_spawn_int` and contains **no** `bitcast i64` into `i8*` and no
  `@sfn_spawn_task`. Honour the file's header rule: **exactly one**
  `lower_to_llvm_ir_from_text_with_provider_context` call per test (arena OOM).

### 4.4 Modified

- **`compiler/tests/unit/routine_nursery_test.sfn` (criterion 3).** Two edits:
  - `:13-17` — the stale claim. Replace with: the body uses the
    `spawn <fn>()` call form, which lowers through the typed
    `sfn_spawn_<kind>` family (SFN-1006); the inline-lambda spawn surface is
    **shipped** (#1474) and is exercised by
    `compiler/tests/e2e/spawn_await_concurrent_execution_test.sfn` — the old
    "separate, still-incomplete codegen path" wording is what steered SFN-974's
    design onto the broken form. Also drop the reference to
    `compiler/tests/e2e/test_routine_nursery.sh` (the `.sh` e2e surface is
    retired, `.claude/rules/no-bash-e2e.md`) and point at the `.sfn` e2e
    instead.
  - `:44` and `:53` — `@sfn_spawn_task` → `@sfn_spawn_int` (`fn work() -> int`).
    The enter < spawn < exit ordering assertions are unchanged. Note in the test
    comment that the symbol change is itself the fix: `sfn_spawn_task` allocated
    a Task and never enqueued or nursery-registered it, so the routine bracketed
    a task that never ran; `sfn_spawn_int` → `sfn_spawn`
    (`runtime/sfn/concurrency/future.sfn:144-172`) registers with the current
    nursery **before** enqueue.
- **`compiler/tests/unit/create_exclusive_race_test.sfn:8-21`** — the shape note
  says the named-function form "does not lower". Correct it to record that
  SFN-1006 fixed it and that the lambda form is retained here deliberately
  (the test still needs a body, not a bare call). Do **not** rewrite the test
  itself; that is SFN-974's file and a behaviour-neutral rewrite is scope creep.
- **`compiler/tests/unit/concurrency_emit_test.sfn:34-38`** — verify only. Under
  this design emit is unchanged, so `"spawn worker()"` must still be asserted.
  If it fails, the implementer has drifted into the rejected §2.1.2 design.

---

## 5. Migration / self-hosting

- No syntax change, no seed dependency. Compiler source and runtime source use
  **no** `spawn` surface at all (grepped: only comments and `process.spawn_*`
  identifiers), so the compiler cannot be affected by its own change.
- `.claude/rules/seed-dependency.md`: **bundles in one PR — confirmed.** The
  new capability is compiler-source only; nothing in `runtime/` calls a new
  builtin or intrinsic, so the runtime carve-out does not apply.
  `sfn dev bootstrap build` builds the new compiler from the old seed and that
  fresh compiler compiles everything else in the same pass. **No seed cut, no
  `/pin-seed`.**
- Every intermediate step is a valid self-hosting compiler. Suggested landing
  order inside the single PR (each self-hosts on its own if the implementer
  wants intermediate checkpoints):
  1. Lowering rewrite (§2.4) — makes the repro build and run.
  2. Frontend `E0842` (§2.3) — closes the check/build divergence on the
     excluded forms.
  3. Tests + doc sync.

---

## 6. Verification

```
# 1. cheapest rung, after each edit
sfn fmt --write <touched files> && sfn fmt --check <touched files>
sfn check compiler/capsules/analyzer/src/typecheck/concurrency_rules.sfn \
          compiler/capsules/analyzer/src/typecheck/expression_walk.sfn \
          compiler/capsules/codegen-llvm/src/expression_lowering/native/core_concurrency_lowering.sfn

# 2. the repro, by hand, before touching tests (write it to a scratch file)
timeout 60 build/bin/sfn run /tmp/sfn-1006-repro.sfn      # expect: v=7

# 3. self-host — MANDATORY before any targeted test run
sfn dev bootstrap build

# 4. targeted
build/bin/sfn test compiler/tests/e2e/spawn_named_fn_test.sfn
build/bin/sfn test compiler/tests/e2e/check_build_agree_spawn_named_fn_test.sfn
build/bin/sfn test compiler/tests/unit/routine_nursery_test.sfn
build/bin/sfn test compiler/tests/unit/concurrency_lowering_test.sfn
build/bin/sfn test compiler/tests/unit/concurrency_typecheck_test.sfn
build/bin/sfn test compiler/tests/unit/concurrency_emit_test.sfn
build/bin/sfn test compiler/tests/e2e/spawn_await_concurrent_execution_test.sfn
build/bin/sfn test compiler/tests/e2e/task_join_all_test.sfn
build/bin/sfn test compiler/tests/e2e/routine_spawn_channel_exec_test.sfn
build/bin/sfn test compiler/tests/unit/create_exclusive_race_test.sfn

# 5. before shipping
sfn dev verify
```

Rung 3 is not optional: `.claude/rules/selfhost-invariant.md` requires a rebuild
before targeted tests so they do not run against a stale binary. This change is
not structural (no new modules, no file splits), so `sfn dev clean build` is not
required — but run it if the `import` edits are rejected in a way that smells
like stale module metadata.

---

## 7. Risks and unverified claims

Nothing below was executed; each item names its cheapest confirmation.

1. **The bare-name fn-reference type text.** §2.2 builds the bitcast source as
   `map_return_type(context, ret) + " ()*"`, whereas
   `core_expression_tail.sfn:398` uses the module-private
   `_compute_function_pointer_type` (which also renders parameters). For a
   zero-argument callee these agree; the source type is immediately bitcast to
   `i8*`, and that file's own comment states the source pointee is irrelevant
   for a code address. *Confirm:* §4.3's IR-shape test plus a clang link.
2. **String-returning spawn targets.** `map_return_type("string")` and the
   `sfn_spawn_string` trampoline (`*fn () -> *u8`) may disagree with the
   `{i8*, i64}` SfnString aggregate return ABI. **This hazard is identical for
   the already-shipped lambda form**, so it is not introduced here — but do not
   add a `spawn worker() -> string` case to the acceptance tests without first
   confirming the lambda twin works. If it does not, file it separately; do not
   absorb it.
3. **Declaration order in the frontend rule.** §2.3 assumes `ctx.bindings` /
   `ctx.top_level` are hoisted, so `fn main` textually *before* `fn worker`
   still resolves. *Confirm:* add that ordering to one §4.3 unit case; if it
   fails, the fix is to consult `ctx.declarations` rather than to weaken the
   rule.
4. **`Task<void>` as a written annotation.** §4.1 test 3 assumes it parses.
   *Confirm:* `sfn check` on a two-line fixture; the fallback is already
   specced inline.
5. **`parallel [spawn a()]` is not fixed and not made worse.** Today that form
   ICEs identically (`bitcast i64` → `i8*`); after this change
   `lower_parallel_expression:944-966` will receive a `%SailfinFutureInt*` and
   `ptrtoint` it as a function address — garbage, though now type-legal IR,
   which is *worse* in one respect: it fails silently instead of loudly.
   **Mitigation, in scope because it prevents a new silent miscompile:** in
   `lower_parallel_expression`, reject a task operand whose `llvm_type` starts
   with `%SailfinFuture` with a fail-closed `E1010` ("a `spawn` handle is not a
   `parallel` task — pass the task directly: `parallel [fn() -> T { … }]`").
   Roughly six lines in the `else` branch at `:944`. Do not attempt to make
   `parallel [spawn …]` *work*; that is a separate issue.
6. **Effect checking is unaffected.** `effect_checker/collector.sfn:574-583`
   walks the `Spawn` operand as an ordinary `Call`, so effect transparency
   (SFEP-0049) is computed on the AST before emit and does not see the IR text.
   *Confirm:* `compiler/tests/unit/effect_checker_test.sfn` (which builds
   `spawn worker()` ASTs directly) must stay green unmodified.
7. **`E0842` over-rejection.** Every in-repo `spawn` outside comments is the
   lambda form (grepped across `compiler/`, `runtime/`, `examples/`,
   `benchmarks/`), so the new rule should reject nothing that exists today.
   `compiler/tests/unit/concurrency_emit_test.sfn:35` spawns an *undeclared*
   `worker()` but never runs typecheck, so it is unaffected. *Confirm:* the
   full unit tier.

---

## 8. Deliberately out of scope (file separately if wanted)

- `spawn worker(a, b)` — argument marshalling. Needs a pre-capture-analysis
  desugar to `spawn fn() -> T { return worker(a, b); }` (§2.3).
- `let h = spawn worker(); await h;` unannotated — the pre-existing `E1002`
  "did not lower" gap the issue explicitly separates out. This fix may
  incidentally improve it (the initializer now produces a typed future
  operand); **do not assert on it either way** in the acceptance tests.
- Making `parallel [spawn …]` meaningful (§7.5 only makes it fail loudly).
- Deleting the now-unreferenced `sfn_spawn_task`
  (`runtime/sfn/concurrency/channel.sfn:369`).
- The seventh copy of the six-kind spawn table. This design adds none, but
  `spawn_future_kind`, `spawn_symbol_for_kind`, `spawn_symbol_for_return_type`,
  `future_type_for_spawn_kind`, and the two `future_pointer_type_for_return_type`
  duplicates are one table wearing six hats.
