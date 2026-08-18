# Design note — SFN-923: the resolved build target must reach every emit child

- **Issue:** SFN-923 (`sfn build --target=<triple>` lowers per-module capsule IR
  for the **host**, not the requested target)
- **Related:** SFN-774 / SFEP-0068 §3.1–§3.2 (the triple axis and the `--target`
  process cell), SFN-549 (the COFF comdat leg), SFN-647 (the Windows `_setjmp`
  leg), SFN-925 (duplicate-keyed envp resolves first-match), SFN-677 / SFN-617
  (target folded into cache keys)
- **Author:** agent:compiler-architect
- **Status:** Draft (single-issue design gate; not a new SFEP)
- **Date:** 2026-08-17
- **Compiler read:** working tree at `main` 095ead33; probes run against
  `build/bin/sfn` in-tree

---

## 0. Corrections after empirical follow-up (2026-08-17)

Two claims below were tested after this note was written. One was refuted; one
was confirmed against a contradicting measurement. Corrected here rather than
edited away, so the reasoning stays legible.

**§2.3 — "Nothing here needs a cache change" is REFUTED. The fix needs a
cache-key bump.** The key does fold the triple under `tgt2:`, but it folds the
**parent**-resolved triple (`compile.sfn:320` → `cache_key_for` →
`build_cache.sfn:1248`, marker `:1318`) while the artifact stored under it was
emitted by a **host**-flavoured child. So a Windows-keyed entry legitimately
holds Linux IR. Those entries never self-heal — they invalidate only when
`cache_compiler_identity` changes, which does not happen for a fixed released
seed. Anyone who attempted a cross build before the fix carries poisoned entries
that will silently defeat it afterwards. **Bump `tgt2:` → `tgt3:` as part of the
fix.**

This also explains a contradiction that looked, for a while, like a second
propagation defect: a cross build with `SAILFIN_TARGET_OS`/`SAILFIN_TARGET_TRIPLE`
exported still produced host-flavoured capsule IR. That was a poisoned cache
being served, not a transport failure. The measurement that "ruled out" a cache
hit used a fresh working *directory* and artifact mtimes — but the cache is
**global** (`$XDG_CACHE_HOME/sailfin` or `$HOME/.cache/sailfin`,
`build_cache.sfn:687-693`), and a cache restore **rewrites the file**, so a fresh
mtime cannot distinguish a miss from a hit. Use `SAILFIN_CACHE_TRACE=1`.

**§2.1's central claim is CONFIRMED, and the recommendation stands.** With a
genuinely isolated cache the child-side lowering is correct once told, the
transport gap is the only defect on this axis, and the `--target` flag is the
right route precisely because it does not depend on ambient state. Measured with
`XDG_CACHE_HOME` at an empty dir: `p256.ll` 10 comdat groups, `mod.ll` 86, **zero
duplicate-symbol errors**, and the link produces a `PE32+ executable (console)
x86-64` — the first HTTPS-capable Windows binary cross-built from Linux.

Reproducing that link needs one undocumented detail: `LIB` must be
**semicolon**-separated with **POSIX** paths. clang's MSVC driver parses `LIB` as
a Windows variable but resolves entries through the Linux filesystem, so
`C:\...`-style entries silently fail to open and colon-separation is not
recognised.

**Out of scope but worth knowing before anyone claims this unblocks Windows
networking:** the resulting binary still cannot make network calls at all — plain
`http://` fails as well as `https://` (SFN-927), while the trust store works
(47 anchors from the system ROOT store). That is a runtime defect below TLS and
independent of this note, but it means SFN-923 alone does not deliver a working
`sfn toolchain install` on Windows.

**§4.2 and §9 step 5's `E0615` allocation collided with an independent
concurrent claim and was reassigned to `E0617` during implementation.** This
note's own §4.2 reasoning ("`E0615` is free … which already owns `E0614` … and
`E0616`") checked `docs/style-guide.md`'s registry at the time and found it
empty at that slot — but the registry was incomplete: `E0615` was already
allocated in shipped code (`capsules/sfn/archive/src/error.sfn`, SFEP-0071
§3.6 / SFN-753) without a corresponding style-guide row, so grepping the
registry alone could not surface the collision. The implementation used
`E0617` for the fail-closed target-disagreement guard instead, and added the
missing `E0615` row to close the gap that caused the near-miss. Every `E0615`
reference below (§4.2, the example diagnostic text, §7.2 Test C, §9 step 5) is
stale by that substitution; read it as `E0617`.

---

## 1. Goal

`sfn build --target=<triple>` must produce artifacts for `<triple>` from **every**
producer in the build, not only from the top-level in-process lowering. Where a
producer cannot establish its target, it must fail with a diagnostic rather than
silently lower for the host.

Same-host builds — the overwhelmingly common case — must be byte-identical.

## 2. Current state

### 2.1 The transport gap (root cause, given; verified in source)

`--target` is parsed at `compiler/src/cli/commands/build.sfn:156-158` and stored
in a **process-local cell**, `set_build_target` →
`compiler/src/build/target_state.sfn:38-46`. `build_target_triple()`
(`compiler/src/build/target.sfn:222-229`) reads that cell first, then
`SAILFIN_TARGET_TRIPLE`, then `SAILFIN_TARGET_OS`, then a host probe.

A cell is process-local by construction. Every per-module emit runs in a **child
process**, which starts with an empty cell and falls through to the host probe.
There are six emit-child argv construction sites; none passes a target, and
`emit` has no flag to receive one (`compiler/src/cli/commands/emit.sfn:67-68`):

| Site | Mode | Child env | Target reaches child? |
|---|---|---|---|
| `compiler/src/native_emit_subprocess.sfn:13` | `native` | `process.run` → inherited `environ` | **no** (cell only) |
| `compiler/src/emit_helpers.sfn:236` | `native`/`llvm` | `process.run` → inherited `environ` | **no** (cell only) |
| `compiler/src/capsule_emit_parallel.sfn:352` | `llvm` | `_cr_emit_child_env()` = raw `process.environ()` (`:365`) | **no** (cell only) |
| `compiler/src/build/runtime_objs.sfn:942` | `llvm` | `_runtime_emit_child_env()` (`:818-836`) | **yes** — injects `SAILFIN_TARGET_TRIPLE` |
| `compiler/src/build/runtime_objs.sfn:1190` | `native` | `_runtime_emit_child_env()` | **yes** |
| `compiler/src/cli/commands/bench.sfn:234` | `llvm` | explicit child env | **no** |

SFN-774 already solved this problem — for the **runtime** leg only. The rationale
block at `compiler/src/build/runtime_objs.sfn:802-816` states the mechanism
verbatim: "The cell … is process-local state, so a child spawned via
`run_capture` … would otherwise resolve the plain host default regardless of what
`--target` the parent build was given. `SAILFIN_TARGET_TRIPLE` closes that gap."
That fix was never extended to the capsule/staging legs. **SFN-923 is the
unextended half of SFN-774.**

Empirical confirmation that the child's own resolvers do work once told
(`build/bin/sfn emit --module-name probe -o out.ll llvm probe.sfn`, struct
fixture, counting `comdat any` groups):

| Child invocation | `comdat any` groups |
|---|---|
| no override (Linux host) | 0 |
| `SAILFIN_TARGET_OS=Windows` | 4 |
| `SAILFIN_TARGET_TRIPLE=x86_64-pc-windows-msvc` | 4 |

So the child-side lowering is correct and the **only** defect on this axis is
transport. This also means the reported "the env route was tested and fails"
result does not reproduce at the `sfn emit` boundary: both `process.run`
(`runtime/sfn/process.sfn:399-401`, `envp = get_environ()`) and
`spawn_with_env(process.environ())` inherit. If a parent-level
`SAILFIN_TARGET_OS=Windows` measurably failed to flip a capsule `.ll`, that is a
*second* propagation defect and the fail-closed check in §4 is what surfaces it.
The `--target` flag route is unambiguously broken as described, and is the route
the fix must serve.

### 2.2 The arch axis is broken even in-process

`_resolve_llvm_target_arch` (`compiler/src/build/llvm_provider_context.sfn:13-18`)
reads `SAILFIN_TARGET_ARCH`, then probes the **host** for
`/lib/ld-linux-aarch64.so.1`. It never consults the triple, and there is no
`triple_target_arch` in `compiler/src/build/target.sfn` (only `triple_target_os`
`:124` and `triple_abi` `:139`). So `--target=aarch64-unknown-linux-gnu` on an
x86_64 host resolves `target_arch = "x86_64"` — in the parent as well as in every
child. `resolve_direct_ld_lld` (`compiler/src/build/direct_link.sfn:140`) and
`_host_default_triple` (`compiler/src/build/target.sfn:201-207`) share the same
host-probe shape; `compiler/src/build/target.sfn:189-193` requires all three to
agree.

### 2.3 What is already correct

- The cache key folds the triple under `tgt2:`
  (`compiler/src/build_cache.sfn:1282-1322`), so a host-lowered artifact cannot
  be served to a cross build. Nothing here needs a cache change.
- `build_target_os()` (`compiler/src/build/target.sfn:85-91`) already derives from
  the triple when `SAILFIN_TARGET_OS` is absent.
- The runtime emit leg is target-correct (§2.1).

## 3. Recommended transport: a `--target=<triple>` flag on `sfn emit`

The child receives the parent's already-resolved triple as an explicit argv flag
and seeds its own SFN-774 cell with it. Because `build_target_triple()` reads the
cell first, **every** ambient target read in the child — OS, ABI, arch, artifact
tag — resolves correctly with no further plumbing.

### 3.1 Rejected alternatives

| Alternative | Rejected because |
|---|---|
| Extend `SAILFIN_TARGET_TRIPLE` injection to the capsule legs (mirror `_runtime_emit_child_env`) | Two of the six sites use `process.run`, which takes **no env argument** (`runtime/sfn/process.sfn:360`); using it there means converting them to `run_capture`/`spawn_with_env` and re-plumbing stdio, a larger diff than the flag for the same effect. |
| An env channel generally | SFN-925: a duplicate-keyed envp resolves first-match through `getenv()`, so an injected value layered over an inherited one is silently shadowed unless every producer scrubs first (`_runtime_emit_child_env` does; a sixth site that forgets would not). An argv flag has no shadowing semantics. |
| Pass `--target-os` (OS only) instead of the triple | Loses the ABI axis (`x86_64-pc-windows-msvc` vs `x86_64-w64-mingw32` are both `"Windows"`) and the arch axis — reintroducing exactly the collision SFEP-0068 §3.6 closed. The model has been triple-first since SFN-774; design with that grain. |
| Emit `target triple = "…"` into each `.ll` and let clang enforce it | `-Wno-override-module` is passed unconditionally (`compiler/src/build/clang_argv.sfn`, asserted at `compiler/tests/unit/target_conditioning_test.sfn:396`), so it would first have to be removed — changing host IR bytes and clang diagnostics for every build. Attractive long-term; too wide for this fix (§8). |
| Stamp the resolved triple into the artifact and verify it in the parent | Verification needs a bounded head-read; `fs` has only whole-file slurp (`runtime/sfn/adapters/filesystem.sfn:798`), and reading every module's `.ll` in the parent is a real cost under the `_cr_ram_budget_jobs` fan-out. A bounded read would be a **new builtin consumed by runtime source** — the standalone `seed-blocker` carve-out in `.claude/rules/seed-dependency.md`. Not worth a seed cut for this bug (§8). |

### 3.2 Flag shape

`--target=<triple>`, same spelling and same closed set as `sfn build --target`
(`triple_is_supported`, `compiler/src/build/target.sfn:112-122`). Boring syntax
wins: one name, one meaning, one validator. It is deliberately *not* the
`sfn package --target` platform-label flag (SFEP-0068 §3.7).

### 3.3 Child-side wiring

`compiler/src/cli/commands/emit.sfn:73` (`run`) has eleven return paths. Do **not**
sprinkle `clear_build_target()` across them — split `run` into a thin wrapper:

```
fn run(matches, ctx) -> int ![io, clock]
    parse + validate --target
    set_build_target(triple)          // no-op when absent
    let code = _run_emit(matches, ctx)
    clear_build_target()
    return code
```

`_run_emit` is today's body, moved verbatim. This is the same lifecycle contract
`build.sfn:148-206` documents, expressed once instead of eleven times.

### 3.4 Parent-side wiring: one shared argv constructor

Today six sites hand-build the emit argv and can drift. Consolidate the
`[exe, "emit", "--module-name", slug, …]` prefix into **one** exported
constructor (natural home: `compiler/src/emit_helpers.sfn`, or a new
`compiler/src/build/emit_child_argv.sfn`) that unconditionally appends
`--target <build_target_triple()>`. Then "a site forgot the target" becomes
structurally impossible rather than merely diagnosed. `capsule_emit_parallel.sfn:345-350`
already documents this intent for two of the six ("ONE construction shared by the
serial branch and the parallel pool, so the two can never drift"); this widens it
to all of them.

**Exclusion — do not touch:** `compiler/src/cli/commands/dev_det_sweep.sfn:213`
spawns `abs_seed emit …`, i.e. the **pinned seed binary**, which will reject an
unknown flag with exit 2 (verified: `sfn emit --bogus-flag` → `rc=2`, usage
printed). It must keep its current argv.
`compiler/src/cli/commands/dev_arena.sfn:171,181` spawns the same-generation
binary but is a host-only arena probe with no `--module-name`; leaving it
unchanged is fine and keeps the diff narrow.

## 4. Fail-closed behaviour

Two child-side gates, both in `compiler/src/cli/commands/emit.sfn`, both before
any lowering runs:

1. **`--target` outside the closed set → `E0614`, exit 2.** Reuse
   `_unsupported_target_diagnostic` (`compiler/src/cli/commands/build.sfn:117-127`)
   — promote it out of `build.sfn` into a shared module so `build` and `emit`
   render byte-identical text. No new code path, no new E-code.

2. **`--target` supplied but the resolved target disagrees → new `E0615`, exit 2.**
   After `set_build_target(triple)`, assert `build_target_triple() == triple`.
   Today the cell wins so this cannot fire; it exists so that any future reorder
   of `build_target_triple()`'s precedence ladder (`target.sfn:222-229`), or any
   future ambient override that outranks the cell, fails loudly at the emit site
   instead of producing host IR that only dies at link. Message shape:

   ```
   error[E0615]: emit child was asked to target "x86_64-pc-windows-msvc"
     but resolved "x86_64-unknown-linux-gnu"
   ```

   Compare **triples, not OS strings.** `build_target_os()` intentionally returns
   an unrecognized `SAILFIN_TARGET_OS` verbatim while `build_target_triple()`
   falls through to the host probe (`target.sfn:68-84`); an OS-level comparison
   would fire on that documented divergence and break
   `compiler/tests/e2e/target_flag_cache_key_test.sfn:160-190`.

`E0615` is free in the `E05xx`–`E06xx` "Build / check tooling" range
(`docs/style-guide.md:224`), which already owns `E0614` (`--target` outside the
closed set) and `E0616`. Register it in that row.

Explicitly **not** proposed: making a missing `--target` an error when
`--module-name` is present. `--module-name` is documented user-facing surface
(`emit.sfn:68`), and `sfn emit --module-name foo llvm x.sfn` must keep working
without a target. The shared constructor of §3.4 is what guarantees the build
never omits it.

## 5. The audit — every `_target_os` / `_target_arch` decision a child gets wrong

Defaults when nothing installs a context: `_target_os = "Linux"`,
`_target_arch = "x86_64"`
(`compiler/capsules/codegen-llvm/src/lowering_debug_state.sfn:18-19`). In a
capsule emit child the context *is* installed — from
`resolve_llvm_provider_context()`
(`compiler/src/build/llvm_provider_context.sfn:20-31`) — but resolved against the
**host**, which is the bug.

| # | Decision | Provider fn (`lowering_debug_state.sfn`) | Consumer | Cross-build status |
|---|---|---|---|---|
| 1 | Type-descriptor comdat groups | `target_uses_comdat` `:103` | `lowering/type_descriptors.sfn:262`, `lowering/lowering_phase_render.sfn:273` | **Fatal.** COFF needs the explicit group to fold `linkonce_odr` `__sfn_type_desc.*`; the link dies on duplicate symbols. SFN-923's presenting failure. |
| 2 | `setjmp` vs `_setjmp` arity | `target_setjmp_symbol/_declare/_call_line` `:115-132` | `lowering/instructions_try.sfn:414`, `lowering/emission.sfn:753`, `lowering/lowering_core/test_harness.sfn:303-305` | **Actively wrong.** Child modules declare/call one-arg `setjmp` while the top-level module uses two-arg `_setjmp` → type conflict at link, or SFN-647's exact defect (garbage `_JUMP_BUFFER.Frame`, first `throw` dies). |
| 3 | errno locator symbol | `errno_locator_symbol` `:73-77` | `expression_lowering/native/core_call_emission/platform_intrinsics.sfn:38` | **Actively wrong.** Emits `@__errno_location` into a module bound for MSVC (`_errno`) → unresolved external. |
| 4 | `exe_path` platform leg | `exe_path_locator` `:89-93` | `platform_intrinsics.sfn:136` | **Actively wrong.** Emits the `linux` `/proc/self/exe` leg instead of the `mingw` leg. |
| 5 | filesystem platform leg | `fs_platform_leg` `:95-99` | `core_call_emission/filesystem_intrinsics.sfn:33,93,151,205,287,440`; `core_call_emission/filesystem_list.sfn:47` | **Actively wrong.** POSIX `stat`/`opendir` legs emitted for a Windows target. |
| 6 | `stat` buffer size / `st_mode` offset | `stat_buf_size_value` `:111`, `stat_st_mode_offset_value` `:105-109` | `filesystem_intrinsics.sfn:232,304-305,483-484` | **Actively wrong on →Darwin and on the aarch64 axis** (the only `_target_arch` consumer outside #10). Subsumed by #5 for →Windows, since that leg is not taken. |
| 7 | `CLOCK_MONOTONIC` id | `clock_monotonic_id_value` `:79-82` | `platform_intrinsics.sfn:70` | **Actively wrong on Linux↔Darwin** (1 vs 6). Latent for →Windows: the Windows clock path is a swapped runtime module, not this constant. |
| 8 | `_SC_NPROCESSORS_ONLN` id | `sc_nprocessors_onln_value` `:84-87` | `platform_intrinsics.sfn:95` | Same shape as #7 — wrong on Linux↔Darwin, latent for →Windows. |
| 9 | mem-footprint leg | `fs_platform_leg` `:95-99` | `expression_lowering/native/mem_footprint_lowering.sfn:18` | **Latent-but-harmless for Linux→Windows** (the test is `!= "darwin"`, so both take the same branch); actively wrong for →Darwin. |
| 10 | Raw-syscall contract gate | `build_target_os` `:38` + `target_arch_for_lowering` `:40` | `syscall.sfn:102` → `syscall_contract_error` `syscall.sfn:49-66` (`E1019`) | **Fails open in the wrong direction.** On a Linux host the child sees Linux/x86_64 and *accepts* `raw_syscall`, emitting an x86-64 `syscall` instruction into a COFF module. Latent today only because `target_condition_runtime_sfn_sources` swaps `syscall_linux.sfn` out for Windows and the gate restricts the builtin to that one module — a fragile pair of accidents, not a guarantee. |
| 11 | LLVM target arch (all of the above, arch half) | `_resolve_llvm_target_arch` (`build/llvm_provider_context.sfn:13-18`) | every arch-keyed row above | **Wrong in the parent too** (§2.2). Independent of the transport fix; must be fixed alongside or `E0615` is only half-meaningful. |
| — | `skip_module_globals`, trace flags, test-runner flags | `:22-24` | — | Not target-keyed; unaffected. |

Rows 1–5 and 10 are the real scope. Rows 6–9 are the Darwin/aarch64 tail that the
same fix closes for free.

## 6. Seed dependency

**Bundle.** Cite `.claude/rules/seed-dependency.md`: the capability (a `--target`
flag on `emit`, a shared argv constructor, `triple_target_arch`) is compiler
source, and its consumers are compiler source in the same PR. Every spawner
resolves its child binary from the running binary's own directory
(`_resolve_self_path`, `compiler/src/build/paths.sfn:172-195`), so the binary that
*builds* the argv is the binary that *parses* it. `make compile` pass 1 runs the
**seed's** driver with the seed's own argv; our new code first executes in pass 2,
against the freshly built compiler. No seed cut, no `seed-blocker`, no
`## Required in pinned seed:`.

The runtime carve-out does **not** apply: nothing here is a builtin or intrinsic
that *runtime source calls*. Runtime `.sfn` files are inputs to the emit children,
not callers of a new compiler capability.

The one thing that would break this call is passing the new flag to a
seed-generation child — hence the `dev_det_sweep.sfn:213` exclusion in §3.4. Treat
that exclusion as load-bearing, not cosmetic.

## 7. Test strategy

Linux CI runner, no Windows host. Three layers.

### 7.1 Unit — `compiler/tests/unit/target_conditioning_test.sfn`

Right home; it already owns the triple decomposers and the cell lifecycle
(`:611-636`). Add pure tests:

- `triple_target_arch` over the closed set, plus `""` for an unrecognized triple
  (mirroring `triple_target_os` `:128-136` and `triple_abi` `:138-144`).
- `_resolve_llvm_target_arch` derives from the triple: with the cell set to
  `aarch64-unknown-linux-gnu`, the resolved arch is `aarch64` on an x86_64 host —
  the §2.2 defect, pinned. Use `set_build_target`/`clear_build_target` exactly as
  `:626-630` does.

This file **cannot** cover the transport: it is in-process, so it never spawns an
emit child. A test added only here would be the vacuous gate to avoid.

### 7.2 E2E, transport — new `compiler/tests/e2e/cross_target_emit_test.sfn`

Sibling of `compiler/tests/e2e/target_flag_cache_key_test.sfn`, same discipline
(`clean_runner_env(nested_runner_scratch("<label>"))`, distinct label per spawn,
`run_capture_cwd`, no bash).

**Test A — the flag reaches `sfn emit` directly.** Contrast pair over one fixture
containing a struct (forces `__sfn_type_desc` emission):

- `sfn emit --module-name probe -o host.ll llvm probe.sfn` → `!contains(host_ll, "comdat any")`
- `sfn emit --module-name probe --target=x86_64-pc-windows-msvc -o win.ll llvm probe.sfn` → `contains(win_ll, "comdat any")`

Both assert `fs.exists` on the output first. This is the transport, pinned at its
narrowest point, with no link and no build — fast, and it fails on today's tree
because the flag does not exist (exit 2).

**Test B — the acceptance criterion: capsule IR agrees with the top-level.**
Reuse the fixture shape of `compiler/tests/e2e/capsule_ir_layout_test.sfn:85-109`
(a `demo/widget` library capsule with `src/mod.sfn` importing a manifest dep and a
relative sibling), materialized inside a `with_tmp_dir` root and built with
`run_capture_cwd` **from that root** — `capsule_artifact_bin_path` hardcodes a
CWD-relative `build/capsules/…` (`compiler/src/capsule_artifact.sfn:195`), so
`--work-dir` does *not* relocate it and cwd isolation is what keeps the pool safe.

Two builds of the same fixture — host (no `--target`) and
`--target=x86_64-pc-windows-msvc`. A `kind = "library"` capsule stops before the
link, so both should exit 0 on a Linux runner; assert that, then:

1. Discover the child-emitted `.ll` paths from the `--json` report's
   `deps.ll_paths` (the `_ll_paths` extractor at
   `capsule_ir_layout_test.sfn:126-150` is directly reusable).
2. `assert ll_paths.length > 0` — **the anti-vacuity guard.** Without it, a
   report shape change silently empties the loop and the test greens.
3. For each path, `assert fs.exists(p)` before reading it.
4. Host run: every capsule `.ll` **and** the top-level `program.ll` contain zero
   `comdat any`.
5. Cross run: every capsule `.ll` **and** `program.ll` contain at least one
   `comdat any`.
6. The invariant that actually names the bug, asserted per artifact:
   `contains(capsule_ll, "comdat any") == contains(program_ll, "comdat any")`.

Step 6 alone fails on today's tree (parent has 2 groups, capsule has 0) and cannot
pass vacuously given steps 2–3. Steps 4–5 are the contrast pair that stops the
assertion from being satisfiable by "always emits comdats".

If the cross build turns out to exit non-zero on the runner, fall back to
enumerating `build/capsules/demo/widget/ir/` under the fixture cwd and assert the
directory is non-empty — never drop step 2's non-emptiness assertion.

**Test C — `E0615` and `E0614` from `emit`.** `--target=bogus-triple` → exit 2 and
`error[E0614]`, mirroring `target_flag_cache_key_test.sfn:57-75`. `E0615` is
unreachable by construction today; assert its *absence* on a well-formed cross
emit rather than fabricating a way to trigger it, and note in the test comment
that it is a future-precedence guard.

### 7.3 Regression surface already in place

`compiler/tests/e2e/target_flag_cache_key_test.sfn:84-190` pins the
`SAILFIN_TARGET_OS` verbatim-override contract and the precedence ladder. Both
must still pass unchanged — that is the check that §3 did not perturb the
documented resolver divergence.

## 8. Risks

- **Same-host regression.** The shared constructor now always passes
  `--target <build_target_triple()>`. On a host build that value equals what the
  child would have probed, so IR is unchanged; it also removes a per-child host
  probe (a marginal win). The risk is a site that resolved its target *differently*
  from `build_target_triple()` — none found, but `make compile` plus
  `target_flag_cache_key_test.sfn` is the gate.
- **`SAILFIN_TARGET_OS` still outranks `--target` on the OS axis** in both parent
  and child (`target.sfn:85-91`, documented at `:68-84`). A cross build run inside
  a shell that exports `SAILFIN_TARGET_OS` for another purpose still resolves that
  OS. Pre-existing and deliberate; out of scope, worth a follow-up issue.
- **Flag surface on `emit`.** Ten flags become eleven. Acceptable: it mirrors
  `build --target` exactly, and `--attempts` / `--no-resolve-gate` set the
  precedent for build-internal `emit` flags (`emit_helpers.sfn:212-217`).
- **Six-site consolidation is the largest part of the diff.** Keep it mechanical:
  move the argv prefix, do not "improve" the surrounding retry/staging logic
  (`.claude/rules/change-discipline.md`).

## 9. Implementation task list

Ordered; each step leaves a self-hosting compiler.

1. **`compiler/src/build/target.sfn`** — add `triple_target_arch(triple) -> string`
   beside `triple_target_os` (`:124`) and `triple_abi` (`:139`). Closed set →
   `x86_64` / `aarch64`; `arm64-apple-darwin` → `"aarch64"` (matching the
   vocabulary `stat_st_mode_offset_value` and `syscall_contract_error` already
   use); unrecognized → `""`. Export it.
2. **`compiler/src/build/llvm_provider_context.sfn:13-18`** — `_resolve_llvm_target_arch`
   becomes: `SAILFIN_TARGET_ARCH` verbatim override → `triple_target_arch(build_target_triple())`
   when non-empty → existing host probe. Same shape as `build_target_os()`
   (`target.sfn:85-91`).
3. **`compiler/src/build/direct_link.sfn:140`** — apply the same derivation, per the
   three-probes-must-agree note at `target.sfn:189-193`.
4. **Shared diagnostic** — move `_unsupported_target_diagnostic`
   (`build.sfn:117-127`) into a module both `build` and `emit` import; `build.sfn`
   keeps calling it. No text change.
5. **`compiler/src/cli/commands/emit.sfn`** — add `flag_value("target", …)` to
   `command_def` (`:67-68`); split `run` (`:73`) into wrapper + `_run_emit` per
   §3.3; validate with `triple_is_supported` → `E0614` exit 2; `set_build_target`
   / `clear_build_target`; add the `E0615` self-consistency assertion of §4.2.
   Update the usage string.
6. **Shared argv constructor** — one exported `emit_child_argv(...)` appending
   `--target <build_target_triple()>`; rewrite
   `native_emit_subprocess.sfn:13`, `emit_helpers.sfn:236`,
   `capsule_emit_parallel.sfn:_cr_emit_child_argv` (`:351-359`),
   `build/runtime_objs.sfn:942`, `build/runtime_objs.sfn:1190`,
   `cli/commands/bench.sfn:234` to call it. **Leave `dev_det_sweep.sfn:213`
   (seed binary) and `dev_arena.sfn:171,181` alone.**
7. **Keep `_runtime_emit_child_env`'s `SAILFIN_TARGET_TRIPLE` injection**
   (`runtime_objs.sfn:834`). It is now redundant with the flag but still serves a
   version-skewed child; removing it is a separate, unnecessary risk.
8. **`docs/style-guide.md:224`** — register `E0615` in the `E05xx`–`E06xx` row.
9. **Tests** — §7.1 additions to `compiler/tests/unit/target_conditioning_test.sfn`;
   new `compiler/tests/e2e/cross_target_emit_test.sfn` with tests A/B/C.
10. **`docs/status.md`** — update the cross-compilation row to reflect that
    `--target` now conditions per-module emit, not only the top-level lowering.

### Verification

```
sfn fmt --write <touched .sfn files> && sfn fmt --check <same>
build/bin/sfn check compiler/src/cli/commands/emit.sfn compiler/src/build/target.sfn \
    compiler/src/build/llvm_provider_context.sfn
make clean-build            # step 6 is structural (new module / moved exports)
make compile
build/bin/sfn test compiler/tests/unit/target_conditioning_test.sfn
build/bin/sfn test compiler/tests/e2e/cross_target_emit_test.sfn
build/bin/sfn test compiler/tests/e2e/target_flag_cache_key_test.sfn
build/bin/sfn test compiler/tests/e2e/capsule_ir_layout_test.sfn
make check                  # before shipping
```

Manual cross-check of the original repro, from a clean tree:

```
sfn build --work-dir /tmp/x923 --target=x86_64-pc-windows-msvc -p <capsule>
grep -c 'comdat any' /tmp/x923/sailfin/program.ll
grep -c 'comdat any' build/capsules/<scope>/<name>/ir/<mod>.ll   # must agree, both > 0
```

## 10. Future considerations

- **Let clang be the verifier.** Emitting a real `target triple = "…"` directive
  into every `.ll` and dropping `-Wno-override-module` from
  `_llvm_text_assemble_argv` would make a host-lowered module in a cross build a
  hard clang error at zero Sailfin cost. It changes host IR bytes and clang
  diagnostics for every build, so it wants its own issue and its own
  byte-identity gate (#1112-style).
- **Bounded file head-read.** A `fs.read_head(path, n)` builtin would unlock the
  artifact-stamp verification rejected in §3.1 and several other cheap
  parent-side gates. It is a runtime-consumed builtin, so it lands alone as a
  `seed-blocker` per `.claude/rules/seed-dependency.md` — worth batching with
  other seed-gated runtime primitives rather than cutting a seed for it.
- **`SAILFIN_TARGET_OS` should stop outranking `--target`.** The precedence at
  `target.sfn:85-91` predates the flag. Inverting it (flag → env → probe) on both
  resolvers would remove the last way an ambient value silently redirects an
  explicit cross build; it needs its own migration for the e2e seams that rely on
  the current order.
- **A single `TargetContext` value** threaded from the driver, retiring the
  ambient cell entirely, is the clean end state (SFEP-0068 §3.2 considered and
  deferred it). This fix does not make that harder — it removes one more ambient
  read per child.
