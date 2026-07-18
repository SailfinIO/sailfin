# SFN-400 — Pop the exception frame on early exit from a `try` body

Status: Draft (single-issue implementation design gate — `.claude/rules/proposals.md`)
Author: agent:compiler-architect
Issue: SFN-400
Date: 2026-07-18

## Problem

`try` lowering (`compiler/src/llvm/lowering/instructions_try.sfn`,
`lower_try_instruction`) pushes a per-`try` `SfnExceptionFrame` (a `[3 x i64]`
alloca holding a live `jmp_buf`) onto the per-thread chain via
`sfn_exception_push_frame`, then lowers the body. The matching
`sfn_exception_pop_frame` is emitted only on the *normal* fall-through exit
(`instructions_try.sfn:408`, guarded by `if !try_result.terminated`). When the
body **terminates via `return`** the guard is false, so the pop is skipped and a
dangling frame with a stale `jmp_buf` is left on the chain. `break` / `continue`
crossing a `try` scope leak identically. A later `throw` that reaches this stale
frame `longjmp`s into a stack frame that has already been popped — undefined
behaviour / memory corruption.

The canonical trigger is already in-tree: `with_tmp_dir`
(`capsules/sfn/test/src/fixtures.sfn:59-66`) is a `try { …; return result; }
catch (e) { … }`. Every e2e test using it leaks a frame today.

`throw` is **not** affected — `lower_throw_instruction` routes through
`sfn_throw` / `sfn_throw_frame`, and the runtime `sfn_throw`
(`runtime/sfn/exception.sfn:360`) pops the chain head *before* `longjmp`. This
note verifies that path; it changes only the compiler.

## Decision

Thread a `TryFrameContext[]` stack of the exact same shape as the existing
`LoopContext[]` (`loop_stack`) through `lower_instruction_range` and every
dispatch sibling. `lower_try_instruction` pushes a `TryFrameContext` (carrying
the frame's `i8*` SSA operand and the try's enclosing scope id) before lowering
its **body** (not its catch/finally — those run after the frame is already off
the chain). At every early-exit terminator we emit the missing
`sfn_exception_pop_frame` calls before the `ret` / `br`:

- **`return`** exits the whole function → pop **all** frames on the stack,
  innermost-to-outermost, before the `ret`.
- **`break` / `continue`** exit one loop → pop only the frames opened *inside*
  that loop, using the same scope-boundary that the existing RC-drop sweep
  already uses (`loop_context.outer_scope_id`).

The pop is purely additive: on paths that previously exited correctly (normal
fall-through), nothing changes; the new pops fire only on paths that previously
leaked. `sfn_exception_pop_frame` is null-safe, idempotent, and O(1) when the
argument is the chain head (`runtime/sfn/exception.sfn:253`), so an extra pop can
never corrupt an already-correct chain.

### Why mirror `LoopContext`, not invent new machinery

`loop_stack` is the proven precedent for a "stack of active enclosing X"
threaded through `lower_instruction_range` and forwarded by every sibling
lowerer. `break`/`continue` already read `last_loop_context(...).outer_scope_id`
to bound their RC-drop sweep. Reusing that exact shape (a) keeps the change
mechanical, (b) makes the break/continue scope-boundary fall out of the same
`is_scope_descendant` helper the drop sweep uses, and (c) requires no new
control-flow analysis.

### Return: pop order vs. the RC-drop sweep

`lower_return_instruction` already walks the scope chain and emits
`sfn_rc_release` for every owned RC local before the `ret`
(`statement.sfn:754`). The frame pops go **after** that drop sweep and
**immediately before** the `ret`. Order is not load-bearing for correctness:
`sfn_rc_release` frees owned buffers and never touches the exception chain;
`sfn_exception_pop_frame` only unlinks the chain head and never frees user
buffers or `longjmp`s — neither can observe the other's effect. We pick
drops-then-pops-then-`ret` purely to keep the diff additive (the existing drop
emission is left byte-identical; pops are appended before the terminator) and
because unlinking the frame as late as possible keeps the chain head valid for
the longest window (tidy, not required).

### Break / continue: the scope boundary

`TryFrameContext.scope_id` is the try's **enclosing** scope (the `scope_id`
argument to `lower_try_instruction`), the exact analogue of
`LoopContext.outer_scope_id`. At a `break`/`continue`, pop each active frame
`f` where `is_scope_descendant(loop_context.outer_scope_id, f.scope_id)` is
true — i.e. the `try` was opened strictly inside the loop body. Cases:

- `loop { try { … break; } }` — the try's enclosing scope is the loop body
  scope, a strict descendant of `outer_scope_id` → **popped** (correct: the loop
  exit unwinds the inner try).
- `try { loop { break; } }` — the try's enclosing scope is an *ancestor* of the
  loop's `outer_scope_id`, so `is_scope_descendant` is false → **not popped**
  (correct: `break` stays inside the `try`).
- Sibling `{ try {…} loop { break; } }` — the try was fully lowered (and its
  frame already popped on normal exit) before the loop began, so it is never on
  the stack at the `break` site; the boundary test is vacuous here.

Break/continue is folded into this fix (see Alternatives for the defer option);
the leak is identical, the mechanism is identical, and the boundary is exactly
the one the RC-drop sweep already computes.

### Nested `try`

An inner `try` inside an outer `try` body receives `try_stack = [outer]`, pushes
`inner`, and lowers its body with `[outer, inner]`. A `return` in the inner body
iterates the stack from last to first and emits `pop(inner)` then `pop(outer)` —
head-first, each O(1) — matching the LIFO chain order the runtime maintains. A
`return` in the inner **catch** body sees `try_stack = [outer]` (the inner frame
is already off the chain) and pops only `outer` — correct.

## Design

### New type (`compiler/src/llvm/types.sfn`, beside `LoopContext`)

```sfn
struct TryFrameContext {
    // The `i8*` SSA operand of the frame alloca (LLVMOperand{ "i8*", %tN }),
    // captured at the push site; dominates the whole try body, so it is a
    // valid pop argument at any early-exit terminator within the body.
    frame_operand: LLVMOperand;
    // The try's enclosing scope id (the analogue of LoopContext.outer_scope_id),
    // used to bound which frames a break/continue must pop.
    scope_id: string;
}
```

### Threading

`try_stack: TryFrameContext[]` is added to `lower_instruction_range` and every
sibling lowerer, positioned immediately after the existing `loop_stack`
parameter (mirror). `lower_instruction_range` declares
`let mut current_try_stack = try_stack;` and forwards it to every sibling
dispatch. Siblings forward it unchanged to their sub-body
`lower_instruction_range` calls — **except** `lower_try_instruction`, which
forwards `try_stack + [new_ctx]` to its **body** call and the unchanged
`try_stack` to its **catch/finally** calls.

`lower_return_instruction` gains `try_stack` as a trailing parameter (it has no
`loop_stack` today).

### Emit shape (all three sites)

Per frame to pop, in innermost-first order:

```
call void @sfn_exception_pop_frame(i8* <frame_operand.value>)
```

emitted via the existing `emit_runtime_call("sfn_exception_pop_frame",
[frame.frame_operand], empty_runtime_call_overrides(), current_temp,
current_lines)` — byte-identical to the normal-exit pop already at
`instructions_try.sfn:411`.

## Self-hosting impact

**No seed cut; self-host binary unaffected.** Neither `compiler/src/` nor
`runtime/` contains any source-level `try`/`catch`, so `make compile` never
emits the try-frame lowering path — the change to it is dead code during
self-host. The only self-host exposure is the *signature plumbing*: the new
`try_stack` parameter threaded through `lower_instruction_range` and siblings,
defaulting to `[]` at the function-body root (`emission.sfn:529`). That plumbing
must simply compile consistently across all call sites.

The behavioural fix is exercised at **`make check`** time: the e2e `try` tests
and every `with_tmp_dir`-using test link the sfn/test capsule, whose
`with_tmp_dir` is the return-in-try shape. Because the new pops are additive and
`sfn_exception_pop_frame` is idempotent/O(1), the change cannot regress any
currently-correct path. Compiler capability and its (test-capsule + e2e-fixture)
consumers all rebuild from source in one pass — ship in **one PR**.

## Effect & capability impact

None. No new runtime symbol (`sfn_exception_pop_frame` already exists and is
already emitted on the normal path), no effect-checker or capability change.

## Test plan

New e2e file `compiler/tests/e2e/try_return_frame_pop_test.sfn`, mirroring the
structure of `try_catch_frames_test.sfn` (shared `_sfn_bin` / `_child_env` /
`_emit_ir` / `_fn_body` helpers):

1. **IR shape — pop precedes ret on the return path.** Emit LLVM for
   `fn f() -> int ![io] { try { return 7; } catch (e) { return 0; } }`; scope to
   the user function body; assert a `call void @sfn_exception_pop_frame(i8* %t`
   appears, and that its index is **before** the `ret i` of the try-body return
   path (and after the try-body's `setjmp` branch, i.e. inside the try region).
2. **Runtime — return-in-try under an outer frame still catches a later throw.**
   Build+run a fixture: helper `h()` does `try { return "ok"; } catch (e) {
   throw e; }`; `main` does `try { let _ = h(); throw "boom"; } catch (e) {
   print(e); }`. Assert exit 0 and output contains `boom` — proving `h`'s frame
   was popped (otherwise the outer `throw` longjmps into `h`'s dead frame).
3. **Nested return pops both.** IR-assert two
   `call void @sfn_exception_pop_frame` on the inner-return path of a nested
   `try { try { return 1; } catch(a){} } catch(b){}`.
4. **(Break/continue) loop-inside-try does not over-pop.** Build+run
   `try { loop { break; } print("after"); throw "x"; } catch (e) { print(e); }`;
   assert output contains both `after` and `x` and exit 0 — the `break` must
   *not* pop the enclosing try's frame.
5. **Verify throw path unchanged.** Retain/rely on `try_catch_frames_test.sfn`
   (throw is caught, prints `boom`, exit 0) — no change expected.

Env-thread per `.claude/rules/no-bash-e2e.md` (`PATH`, `HOME`, `TMPDIR`,
`SAILFIN_TEST_SCRATCH`).

## Alternatives

- **Return-only, defer break/continue.** Valid (the AC permits it) and lower
  surface, but leaves an identical known leak and a second PR touching the same
  two `break`/`continue` emit sites. Rejected: the boundary is exactly the one
  the existing RC-drop sweep already computes, so folding both in is ~8 lines
  per site with no new analysis.
- **A shared `emit_try_frame_pops` helper.** Rejected as a home in
  `instructions_try.sfn` (would create a `statement → instructions_try →
  instructions → statement` import cycle) and in `instructions_helpers.sfn`
  (would force it to import `runtime_call`, risking a cycle through
  `core_operands`). The pop loop is inlined at each of the two files instead —
  matching the codebase's existing flat, duplicated diagnostics-drain style.
- **Pop in the runtime on `setjmp`-return / at function epilogue.** Rejected:
  the compiler is the only place that knows the frame SSA operand and the
  early-exit control flow; a runtime-side scheme cannot see the `return`.

## Stage1 readiness mapping

Parser/typecheck/effect: unchanged. Emit/lower: `types.sfn` (new struct),
`instructions_try.sfn` (push), `instructions.sfn` (thread + break/continue
pops), `statement.sfn` (return pops), and signature plumbing across the sibling
lowerers. IR: additive `sfn_exception_pop_frame` calls before early-exit
terminators. Tests: e2e above. Self-host: one-PR, no seed cut. Docs:
`docs/status.md` try/catch row note.

## References

- `compiler/src/llvm/lowering/instructions_try.sfn:214,408,411` (try lowering,
  normal-exit pop)
- `compiler/src/llvm/lowering/instructions.sfn:59,324,457,527,553` (dispatch,
  return/try/break/continue)
- `compiler/src/llvm/expression_lowering/native/statement.sfn:406,754,762`
  (return lowering + RC-drop sweep)
- `compiler/src/llvm/types.sfn:589` (`LoopContext` precedent)
- `compiler/src/llvm/lowering/instructions_loops.sfn:99,241,269`
  (`append_loop_context`, push, body call)
- `compiler/src/llvm/lifetime.sfn:947` (`is_scope_descendant`)
- `runtime/sfn/exception.sfn:253,360` (`sfn_exception_pop_frame`, `sfn_throw`)
- `capsules/sfn/test/src/fixtures.sfn:59-66` (`with_tmp_dir` — the live trigger)
- `compiler/tests/e2e/try_catch_frames_test.sfn` (test template)
