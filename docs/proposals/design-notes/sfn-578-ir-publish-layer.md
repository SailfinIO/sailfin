# SFN-578 — Which layer publishes emitted IR

> Single-issue design note (no SFEP number). Adjudicates whether tmp-file +
> atomic-rename publishing for emitted IR belongs in the runtime writer
> (`sfn_fs_write_lines`) or at the compiler's two emit call sites. Prior art:
> #1011 / #1034 (the staging + cache publish this reuses), SFN-490 (the shared
> mint/publish helpers), SFN-542 (the unlink mitigation this narrows).

## 1. Decision

**Publish at the compiler layer**, through one new exported helper
`_publish_lines_atomic(path, lines) -> boolean ![io]` in
`compiler/src/build/fs.sfn`, beside the `_mktemp_sibling_cmd` /
`_atomic_rename_into_place` primitives it composes. Both production
`fs.writeLines` call sites delegate to it:

| Site | Artifact |
|---|---|
| `compiler/src/emit_native.sfn:204-210` `emit_native_text_to_file_with_module_name` | `.sfn-asm` |
| `compiler/src/llvm/lowering/lowering_io.sfn:136-149` `write_llvm_lines_chunked` | `.ll` |

`runtime/sfn/adapters/filesystem.sfn::sfn_fs_write_lines` keeps its in-place
`fopen("wb")` and keeps all three SFN-542 `unlink` sites. Its edits are
**comments only**.

Rejected: publishing inside `sfn_fs_write_lines`. §3.

## 2. Why the compiler layer

Three independent arguments, any one of which is sufficient.

**(a) A runtime-layer rename changes public `fs.writeLines` semantics — the
exact change SFN-578 scoped out for `fs.writeFile`.** Rename-publishing replaces
the destination inode rather than writing through it: a symlink destination is
clobbered instead of followed, a hardlink is broken, and the published file
carries `mkstemp`'s `0600` rather than the destination's prior mode. The issue
declines that semantics pass for `writeFile`'s ~45 general-purpose call sites
(`fmt --write`, `-o`, `--csv`) and for good reason. `fs.writeLines` is the same
kind of public runtime API; it merely happens to have only compiler-internal
callers *today*. Putting the rename at the runtime layer smuggles the deferred
semantics change in through the door labelled "chokepoint coverage."

**(b) `-> void` makes a runtime-layer publish failure unreportable, and both
call sites already have a `boolean` to carry it.** The descriptor rows at
`compiler/src/llvm/runtime_helpers.sfn:1036,1039` pin `return_type: "void"`, and
changing the descriptor table is hard-out-of-scope. A `rename` that fails inside
a `void` function is silent. Meanwhile both call sites return
`fs.exists(<dst>)` — so a *retained prior complete* `.ll` reads as success and
links a binary built from stale source. That hazard is real, not theoretical:
`program.ll` is a **fixed reused path** whose collision risk
`compiler/src/build/cache.sfn:173-177` already documents. Stale-links-cleanly is
worse than SFN-542's loud `undefined reference to 'main'`.

Publishing at the compiler layer fixes both halves at once. The publish status is
returned, and it is already threaded end-to-end with no signature changes:
`emit_native_text_to_file_with_module_name` → `write_native_text_file_with_module`
(`main.sfn:749`) → `write_native_text_file_with_module_gated` → CLI exit code;
`write_llvm_lines_chunked` → `compile_native_text_to_llvm_file`
(`lowering_core.sfn:781`) / `write_llvm_ir` (`entrypoints.sfn:339`) →
`compile_to_llvm_file_with_module` (`main.sfn:810`) → `cli/commands/build.sfn:406`,
which prints and returns 1. Callers stop consuming `fs.exists` as the
completeness check, which is what retires the stale-reads-as-success hazard —
*not* the rename.

**(c) The runtime cannot reuse the existing helpers, so a runtime-layer publish
necessarily invents a second implementation.** `runtime/sfn/` cannot import
`compiler/src/`, and `filesystem.sfn` cannot even import
`runtime/sfn/platform/libc.sfn` — it inlines its externs per the documented #306
cross-module-extern workaround (`filesystem.sfn:129-139`). So the runtime option
requires new inline `rename`/`mkstemp`/`close` externs plus duplicated `_dirname`
and temp-mint logic (~60 lines), which is precisely what the issue's "reuse or
lift, don't invent a second one" criterion forbids. The compiler option adds one
function that calls two existing ones and zero new externs anywhere.

A fourth, secondary cost of the runtime option: `mkstemp`/`close` are POSIX
spellings the MSVC UCRT does not export, so each declaration site owes a
`runtime/ir/windows_stubs.ll` entry on the SFEP-0021 M7 native-Windows leg
(`build/fs.sfn:24-29`). `filesystem.ll` is compiled *once* for Linux, macOS
arm64 and the Windows cross target (`filesystem.sfn:86-90`), so that obligation
would be harder to discharge there than in compiler source, not easier.

The counter-argument for the runtime layer — chokepoint coverage of all future
callers — buys little: there are exactly two callers, both compiler-internal
build-artifact writers, and (a) says a third, non-build caller would be *harmed*
by the coverage.

## 3. Seed-dependency posture: no gate either way

Per `.claude/rules/seed-dependency.md`, runtime source is compiled by the
**pinned seed**, so a compiler capability runtime source *calls* must exist in
the seed. **That carve-out does not engage under either option**, and it is worth
recording why so it is not re-litigated:

- The chosen design introduces no new builtin, no new intrinsic, no new registry
  row, no descriptor-table change, and no new `extern`. Its runtime edit is
  comments only. Nothing about the working-tree runtime's behaviour changes under
  the pinned seed.
- The *rejected* design would not have tripped the carve-out either. A plain
  `extern fn` over a libc symbol is not a compiler capability — it lowers to a
  `declare` + `call` on any seed, which is `build/fs.sfn`'s own stated reason
  (lines 10-17) for choosing externs over builtins. Seed dependency therefore
  does **not** decide this question; §2 does.

Consequence: **one PR, no `seed-blocker`, no seed cut, no `/pin-seed`.** Helper,
both call sites, comment rewrites and tests land together.

## 4. Same-filesystem requirement

`rename(2)` is atomic only within one filesystem. `_mktemp_sibling_cmd(dst)`
derives its template from `_dirname_cmd(dst)`, so the temp is always a sibling of
the destination and the requirement holds by construction; a `/tmp` temp would
degrade the publish to a non-atomic cross-device copy and reintroduce the torn
read. This is already gated by
`compiler/tests/unit/cli_path_normalization_test.sfn:147-178`. The destination's
directory must exist — when it does not, `mkstemp` fails, the mint returns `""`,
and the degrade path's `fopen` fails too, so the helper reports `false` rather
than silently producing nothing.

## 5. Interaction with the cache and with #1011 staging — no collision

Three publishers now mint `.sfn_stage.XXXXXX` siblings. None can collide, and the
one place they compose is well-defined.

**Directories are disjoint in a normal build.** Cache publish temps are minted in
the cache entry dir, `<root>/<xx>/<digest>/` (`_cache_entry_dir` →
`_cache_atomic_copy`, `build_cache.sfn:744-755`). Emit publish temps are minted
beside the emit destination — `build/sailfin/` for `program.ll`,
`build/sailfin/capsules/` for per-capsule artifacts, or wherever `-o` points. A
cache entry dir is only ever a rename *destination* for a `_copy_file`-staged
copy, never an emit `-o` target.

**Even sharing a directory, collision is impossible.** Both publishers mint
through `_mktemp_from_template_cmd` → libc `mkstemp(3)`, which creates
`O_CREAT|O_EXCL` and retries internally until it lands a name that did not
exist. The kernel arbitrates; two concurrent minters cannot receive the same
name. Sharing the `.sfn_stage.` prefix is therefore a litter-*attribution*
question, not a correctness one, and keeping the shared prefix keeps the existing
residue greps (`build_cache_test.sfn:708,736`) meaningful.

**Double-staging is intentional and cheap.** The build's per-module emit already
hands the *child* a parent-minted temp as its `-o`
(`emit_helpers.sfn:301-303`, `capsule_emit_parallel.sfn:474-476`,
`:555-557`). After this change the child mints a second temp beside it and
renames onto the parent's temp — `rename(2)` atomically replaces an existing
same-directory destination, so this is well-defined. Cost: one extra `mkstemp` +
one extra `rename` per module, negligible against a multi-megabyte IR write.
Benefit: the parent's `fs.exists(target)` + non-empty probe
(`emit_helpers.sfn:319-330`, `capsule_emit_parallel.sfn:493-500`) becomes
*structurally* sound instead of depending on the child's `unlink` having
succeeded — and the `native` round is not `validate_llvm_ir`'d
(`capsule_emit_parallel.sfn:451-454`), so that probe is the only thing standing
between a torn `.sfn-asm` and the `cannot resolve return type for call to <X>`
fatal of #1011.

**File mode is not a new exposure.** Published artifacts inherit `mkstemp`'s
`0600`. Cache artifacts and parallel-emit outputs already do
(`_cache_atomic_copy`, `capsule_emit_parallel.sfn`); this extends it to
`program.ll` and the in-process `.sfn-asm`, which are same-user build
intermediates.

## 6. The SFN-542 `unlink` is narrowed, not retired — and cannot be retired

All three `unlink` sites in `sfn_fs_write_lines` stay
(`filesystem.sfn:~1000`, `~1018`, `~1071`), including both corrupted-handle early
returns. Their comments are rewritten to state the new role.

The reason is structural, not conservative. `_mktemp_sibling_cmd` **pre-creates**
the temp, so `fs.exists(tmp)` is true from the mint onward and is *purely* the
runtime's failure signal — never a "was it written" check. Because
`sfn_fs_write_lines` is `-> void` and the descriptor signature is frozen,
removing its target is the **only** channel this body has to report a failed
write. Retire the `unlink` and `_publish_lines_atomic` loses its ability to
distinguish a complete staged temp from a truncated one, and would publish
truncated IR — strictly worse than today.

What the narrowing does buy is the elimination of the failure mode the current
comment flags as unfixable ("when `unlink` itself fails … a `void` signature
cannot report that"). On POSIX the `unlink` target is now a `mkstemp`-minted file
we own, in a directory the mint just proved writable, so the removal cannot
plausibly fail — ownership satisfies the sticky-bit case and the writable-parent
case is a precondition of the mint. The stated removal condition in that comment
("the structurally complete answer is tmp-file + atomic rename, as
`compiler/src/build/fs.sfn:138-166` already does") is satisfied by this change
and that sentence is deleted.

On a Windows host the mint returns `""`, the helper writes in place, and the
`unlink` target is the destination again — which is why the mitigation is
narrowed rather than deleted, and why the rewritten comment must name that leg.

**Flag to the issue owner.** SFN-578's acceptance text reads "retiring or
narrowing," so narrowing satisfies it literally. If the intent was that the
runtime function stop unlinking at all, that is not deliverable under the
`-> void` constraint and the criterion should be restated as *narrowed to the
staged temp, with the three comments rewritten to state the new role*.

## 7. Residual risk, stated

If the staged write short-writes **and** the `unlink` fails, `fs.exists(tmp)`
stays true and a truncated temp is published. §6 argues the precondition is
unreachable; closing it properly needs a byte count out of the writer, which
means either a reportable `write_lines` variant (a descriptor-table change,
hard-out-of-scope) or a `fs.size`/`fs.stat` primitive to compare against the
in-memory expected length. Recorded as future work rather than absorbed silently.

`_write_llvm_lines_chunked_unused` (`lowering_io.sfn:151-191`) is dead and routes
through `fs.appendFile`, which cannot be published by rename. Out of scope;
delete it in a separate cleanup rather than staging it.

## 8. Layering debt acknowledged

This adds two consumers to helpers SFEP-0020 (§300-307, §386) already flags as
mislayered — `_mktemp_sibling_cmd` / `_atomic_rename_into_place` are generic
`![io]` plumbing sitting in the build backend, and an emit-stage module importing
`build/fs` is a wrong-direction edge. It is not a cycle: `build/fs`'s transitive
closure is `string_utils` → `runtime/prelude`, `build/hash` (no imports),
`build/target` → `build_flags` + `build/paths`, none of which reach
`emit_native.sfn` or `llvm/lowering/`. Inventing a parallel leaf module to dodge
the edge would be the duplication the issue forbids; when SFEP-0020 moves these
into `runtime/prelude.sfn`, the two import paths change mechanically. Watch
`make compile`'s per-module emit time and RSS for `lowering_io` and
`emit_native` — if the new edge measurably regresses either, that is the trigger
to do the SFEP-0020 move rather than to duplicate.

## 9. Test story

The unobservability property cannot be asserted without a real race, so the
tests pin the *mechanism* — the same reasoning `build_cache_test.sfn:676-681`
already records for the cache publish.

- **`compiler/tests/e2e/short_write_truncated_ir_test.sfn` passes unmodified.**
  `ulimit -f` caps the process's writes wherever they land, so under the new
  design the *temp* is what gets truncated: short `fwrite` → the runtime unlinks
  the temp → `_publish_lines_atomic` returns false → `program.ll` is never
  created. The test's assertion is guarded by `if fs.exists(ll_path)`, which is
  not taken, and it deliberately does not assert the build's exit code. Its
  header comment gains a paragraph naming the new mechanism; the body is
  otherwise unchanged, and *that the body needs no change* is itself an
  acceptance criterion.
- **One new assertion in that e2e, and it earns its keep:** after the capped run,
  no entry under `work + "/sailfin"` starts with `.sfn_stage.`, via
  `fs.listDirectory` + `starts_with` from `sfn/strings` (no shell —
  `.claude/rules/no-bash-e2e.md`). This is the only deterministic guard on the
  new code's temp-leak branches, exercised against the exact failure the test
  already induces.
- **Unit tests for the helper** in
  `compiler/tests/unit/cli_path_normalization_test.sfn`, beside the existing
  atomic-publish tests: publish succeeds with exact content and no
  `.sfn_stage.*` residue; publish over an existing destination replaces it with
  no residue; a null/empty array publishes a zero-length file and returns true;
  a destination in a non-existent directory returns **false** (pinning that a
  failed publish is *reported*, which is the whole point of the layer choice).
