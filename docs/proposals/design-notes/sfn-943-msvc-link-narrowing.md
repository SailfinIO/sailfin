# SFN-943 — Make the msvc link narrow correctly

Design gate for SFN-943, re-scoped, **now implemented** — see §1a for the
implementation outcome and its deviations from the plan below. Evidence: the
native-Windows e2e run captured in `.wintest/e2e_full_new.log`. Related:
SFN-882 (shipped, design note `runtime-demand-driven-sources.md`), SFN-860
(design note only, not implemented), SFEP-0021
(`0021-windows-native-selfhost.md`), SFEP-0068
(`0068-native-cross-target-build.md`).

SFN-943's prior scope was narrower than this note — it read as "msvc
dead-strip is `/OPT:REF`, so the POSIX dead-strip guards do not apply."
That is true but is a consequence, not the problem. The problem is that
the effect gate **fails open on msvc**, and this note re-scopes the issue
to that.

---

## 1. Decision

**Narrow the msvc link properly. Defer it out of the in-flight Windows
sweep; land it under this issue as its own change.**

Rejected: giving msvc a dead-strip flag equivalent. `/OPT:REF` is already
on (§3.1) — the flag is a no-op that documents intent, and it is not what
is broken.

Rejected: accepting the full-runtime cost on msvc and growing
msvc-specific expectations into the five failing tests (§8).

Deferred to a successor: `/INCLUDE:` retain roots on msvc (§6). Orthogonal
— it changes binary *contents*, not link success.

**Disposition:** implemented. All six tests (§2) now pass — see §1a.

---

## 1a. Implementation outcome

SFN-943 is implemented. All six e2e tests named in §2 now pass, and
`SAILFIN_TRACE_RUNTIME_GATES=1` on a `![io]`-only hello-world, measured on a
native Windows host, prints `demand: io rand clock` — not `*`.

Four deviations from the plan in §4.2 and §7, recorded plainly:

1. **§4.2 and §7 Step 1's recommendation to move `sailfin_runtime_serve`
   into ungated `runtime/sfn/concurrency/scheduler.sfn` was tried and is
   NOT where it ended up.** It did not work: `scheduler.sfn` is itself an
   `sfn-sources` member, and the minimal-runtime fixtures under
   `compiler/tests/e2e/` hand-write a much shorter `sfn-sources` list that
   omits it. The undefined symbol simply moved from `serve.sfn` to
   `scheduler.sfn`, and `runtime_sfn_sources_link_consumer_test.sfn` still
   failed with `lld-link: error: undefined symbol: sailfin_runtime_serve`.
   The definition now lives in `runtime/prelude.sfn` itself — it now
   DEFINES the `sailfin_runtime_serve` no-op directly, and
   `runtime/sfn/concurrency/serve.sfn` no longer defines it — so reference
   and definition land in the same object on every target. See §4.2 for
   the superseded reasoning and why it was sound but rested on a false
   premise.

   The durable, generalized lesson: **the prelude constraint is stronger
   than "the prelude may not reference a GATED module".** A runtime
   capsule chooses its own `sfn-sources`, so a prelude reference into ANY
   `sfn-sources` member is only as sound as the weakest runtime that must
   satisfy it. §2, §3.3, and §4's framing treats gatedness as the whole
   problem; it is not.

2. **§2 undercounted the failing tests as five. There were six.**
   `compiler/tests/e2e/workspace_capability_gate_test.sfn` was also a
   casualty of the same fail-open — its failure log carries the identical
   signature (`capsule-resolver: could not locate source for "sfn/strings"`
   followed by `lld-link: error: undefined symbol:
   int_to_string__sfn__strings__mod` referenced from
   `der_oid_string__sfn__crypto__der`). It now passes, 9/9. See §2's
   updated count below.

3. **Step 2's new "Windows-conditioned source set" invariant case (§7 Step
   2) found a real classification gap.**
   `target_condition_runtime_sfn_sources` swaps gated
   `platform/socket_ops.sfn` and `platform/cert_roots.sfn` for `*_windows.sfn`
   siblings, but the gate table lists only the POSIX spelling, so a naive
   membership test reads the swapped name as ungated. The real pipeline
   never hits this because selection runs before conditioning (§4.1's last
   bullet); the test had to undo the swap itself to check the post-swap
   name against the gate table.

4. `runtime_implicit_capsule_link_test.sfn` needed a second, unrelated fix
   beyond SFN-943's scope to pass.

§3.2's ELF-vs-COFF explanation is confirmed again in the implementation
pass, independent of the LLD-source caveat that section still carries:
`llvm-nm` on a linked Windows PE reports `no symbols` and exits `0`, while
the COFF `.o` objects that feed the link carry full symbol tables.

---

## 2. The problem, and why it is one problem

Six e2e tests fail on a native Windows host (§1a deviation 2 — this note
originally undercounted five). They are one root cause, not six bugs. The
chain:

1. `target_uses_gnu_link_gc(triple)` (`compiler/src/build/target.sfn:432-434`)
   is `false` for the msvc ABI.
2. `runtime_link_dead_strips()`
   (`compiler/src/build/runtime_selection.sfn:97-102`) tests that same
   predicate, so it is `false` on msvc.
3. `compute_runtime_demand` (`runtime_selection.sfn:213-216`) therefore
   returns the `"*"` sentinel, and `select_runtime_sfn_sources`
   (`:149-171`) becomes the identity over the runtime's whole base list.
4. `runtime_demanded_dep_specs` (`:258-284`) scans those retained modules
   for scoped imports, finds `runtime/sfn/platform/tls.sfn:82`'s
   `from "sfn/crypto"` — the sole such import in the runtime tree,
   confirmed by grep over `runtime/sfn/` and `runtime/prelude.sfn` — and
   stages the whole `sfn/crypto` capsule into a `print`-only hello-world.
5. `runtime/capsule.toml:249-265` states this failure mode verbatim, in
   advance.

Observed:

- `runtime_sfn_sources_link_consumer_test.sfn`,
  `runtime_sfn_sources_struct_import_test.sfn` — undefined
  `sailfin_runtime_serve`, `sfn_rand_fill`, `sfn_cert_roots_blob`,
  `sfn_fs_exists`, `sfn_fs_read_file`
  (`.wintest/e2e_full_new.log:2133-2149`, `:2191-2207`), referenced from
  `sfn/crypto` objects that only reached the link because of the
  fail-open.
- `runtime_demand_driven_sources_test.sfn` — its `"stages no crypto"` and
  `asm.length <= 40` assertions (`:191-232`) are SFN-882's acceptance
  gate; they fail directly, with 69 modules instead of ~29.
- `runtime_implicit_capsule_link_test.sfn`,
  `standalone_workspace_implicit_import_test.sfn`.
- `workspace_capability_gate_test.sfn` — carries the identical signature to
  the previous bullet's `sfn/strings` symptom: `capsule-resolver: could not
  locate source for "sfn/strings"` followed by `lld-link: error: undefined
  symbol: int_to_string__sfn__strings__mod` referenced from
  `der_oid_string__sfn__crypto__der`. Missed in the original sweep (§1a
  deviation 2); now passes, 9/9.

The `standalone_workspace_implicit_import_test` failure carries a
`capsule-resolver: could not locate source for "sfn/strings"` line
(`log:2653-2673`) that reads like a separate symptom. It is not.
`sfn/crypto` imports `sfn/strings` (`capsules/sfn/crypto/src/der.sfn:7`,
`mod.sfn:6`, `x509.sfn:8`, `trust_store.sfn:21`,
`tls13_handshake.sfn:43`), so the fail-open stages crypto, crypto demands
strings, and the fixture's isolated cache has none. The undefined symbols
in that log are all `*__sfn__strings__mod` referenced from
`__sfn__crypto__*` objects, which is consistent with this reading; the
decisive check is that the test passes after the fix.

### 2.1 Why this is a pillar problem, not a test-count problem

CLAUDE.md's **Reach** pillar claims the compiler derives a capability
manifest and proves it **complete**. On msvc today, a program that
declares only `![io]` links the entire TLS 1.3 stack. On that target the
effect gating is decorative and the derived reach is wider than the truth.
`docs/status.md:1430` documents SFN-882 as **Shipped** with no target
qualifier; that row is wrong for msvc.

---

## 3. Findings

### 3.1 `/OPT:REF` is already on, so the flag buys nothing

lld-link enables `/OPT:REF,ICF,LBR` by default unless `/DEBUG` is passed.
The msvc link runs `clang --target=x86_64-pc-windows-msvc -fuse-ld=lld`
with no `-g` (`compiler/src/build/target.sfn:390-409`), so nothing
disables it.

This is recorded in-tree as *measured*, not assumed —
`runtime/sfn/platform/fd_io.sfn:33-40`:

> Measured on a plain `![io]` hello-world with `SAILFIN_TRACE_LINK=1`:
> `socket_ops_windows.sfn`'s object is on the link line, along with every
> other `net`-gated module, and what removes the unreferenced code is the
> linker's dead-strip (`-ffunction-sections` + `/OPT:REF`), not the effect
> system.

`compiler/tests/e2e/capsule_dead_strip_guard_test.sfn:161-163` says the
same. So the counterpart mapping is asymmetric:

| GNU / Mach-O | msvc | changes behaviour? |
|---|---|---|
| `-Wl,--gc-sections` / `-Wl,-dead_strip` | `/OPT:REF` | **No** — already default-on |
| `-Wl,-u,<sym>` | `/INCLUDE:<sym>` | **Yes** — no roots exist on msvc today |

`-Wl,/OPT:REF` would be a no-op documenting intent. `-Wl,/…` passthrough
is proven: `target_reproducible_link_flag` already ships `-Wl,/Brepro` for
msvc (`compiler/src/build/target.sfn:416-420`, SFN-920).

A consequence worth stating: **msvc binaries today are dead-stripped with
zero retain roots** — precisely the end state SFN-860
(`sfn-860-runtime-retain-root-scope.md`) proposes to make the default
everywhere, and that note is *not implemented* (`retain_runtime_symbols`
appears nowhere under `compiler/src/`). msvc has been living in SFN-860's
end state by accident.

### 3.2 The ELF-vs-COFF diagnostic asymmetry — the real finding

**lld-link resolves and reports undefined symbols before it discards
sections.** A reference from a section that GC would drop is still a hard
error on COFF. On ELF it is not.

Evidence, from the log rather than from LLD's source:

- `log:2653-2673` — `/OPT:REF` is on, and lld-link still errors on
  `undefined symbol: int_to_string__sfn__strings__mod`, referenced from
  `der_oid_string__sfn__crypto__der`. That crypto code is unreachable from
  a fixture that only prints. GC would drop it. It errored anyway.
- The sharper A/B, on `sailfin_runtime_serve` (`log:2133`):
  `compiler/tests/e2e/runtime_sfn_sources_link_consumer_test.sfn:130-137`
  builds a fixture whose `sfn-sources` omits `serve.sfn` entirely. The
  prelude's `serve` wrapper is dead in that binary on every platform.
  Linux CI is green on it; Windows fails. Same fixture, same dead
  reference, opposite outcome.

**Caveat, stated rather than smoothed over.** The A/B observation is
solid. The *explanation* — that COFF's `resolveRemainingUndefines`
precedes `markLive`, while ELF's undefined-symbol diagnostics originate in
relocation scanning of *live* sections only — is a reading of LLD's driver
ordering, **not verified against its source**. If the explanation is wrong
the observation still stands and the design is unchanged; anyone relying
on the mechanism for a different purpose should verify it first.

`/FORCE:UNRESOLVED` would "fix" this by downgrading every undefined-symbol
error to a warning. **Rejected outright** — it converts the Reach hole
into a silent miscompile.

### 3.3 What this makes false

`runtime/capsule.toml:249-258` — the PRELUDE CONSTRAINT block — argues:

> That reference is safe ONLY because it is dead-strippable: the prelude's
> `serve` wrapper does not match the `sfn*` retain-root pattern, so
> `--gc-sections` removes it from any binary that never calls `serve` […]

**That safety argument is target-conditional and is currently written as
if universal.** It holds on ELF and Mach-O. It does not hold on COFF,
where the reference is diagnosed regardless of liveness. The comment is
load-bearing — it is what a future reader consults before adding a gate
entry — so it must say which targets it covers. The same argument appears
in `runtime-demand-driven-sources.md:152-157` and inherits the same
qualification.

The engineering consequence: **narrowing on msvc requires the retained
closure to be exact, not merely dead-strippable.** The linker provides no
net there. That is a different problem from the one SFN-882 solved.

### 3.4 The shell helper is a stub on Windows, so the enumeration is dead code

`_runtime_retain_root_flags` (`compiler/src/build/link.sfn:182-208`)
shells `nm … | awk … | sort -u`, and `runtime_link_dead_strips` probes
`command -v nm` (`runtime_selection.sfn:101`). Both route through
`_shell_read_cmd`, which returns `""` unconditionally on a Windows host:
`compiler/src/build/fs.sfn:608-612` opens with
`if host_is_windows() { return ""; }`.

So on Windows the enumeration returns empty **regardless of what is
installed** — this is not a missing-tool problem. (`nm` is in fact absent
on a native Windows host, SFN-1114; `llvm-nm` is present.) Any msvc
retain-root work needs a shell-free enumerator driving `llvm-nm` through
`process.run_capture` with the filter reimplemented in Sailfin.
`capsules/sfn/test/src/tool_probe.sfn:symbol_reader()` is the existing
discovery pattern (`["llvm-nm", "nm", "llvm-nm-18"]`), but it lives in the
test capsule; the compiler needs its own.

### 3.5 The fail-safe does not protect narrowing on msvc

`compiler/src/build/link.sfn:354-368`:

```
if target_uses_gnu_link_gc(gc_triple) {
    let retain_flags = _runtime_retain_root_flags(runtime_objs);
    let strip_safe = runtime_objs.length == 0 || retain_flags.length > 0;
    if strip_safe { link_flags.push(_dead_strip_link_flag(gc_triple)); }
    else { print("sfn: dead-code strip disabled — could not enumerate runtime"); … }
```

The fail-safe works by **withholding the GC flag**. On msvc there is no
flag to withhold — `/OPT:REF` is unconditional. Therefore:

- Its protection covers only the *retain-root* half. It has nothing to say
  about narrowing.
- A naive flip of `target_uses_gnu_link_gc` to `true` for msvc makes this
  block emit `-Wl,--gc-sections` and `-Wl,-u,<sym>` to lld-link, which
  rejects both. Today that is escaped only because §3.4's stub makes
  `retain_flags` empty → `strip_safe` false → the `--gc-sections` push is
  skipped. **It survives by accident**, and breaks the moment the
  enumeration starts working.

The predicate must therefore be **decomposed, not flipped**. Three
questions are conflated in one function:

1. *Does the final link discard unreferenced sections?* — true for gnu,
   mach-o, mingw **and msvc**.
2. *What flag syntax expresses that?* — GNU / Mach-O / (msvc: none
   needed).
3. *Does the linker forgive a dangling reference from a discarded
   section?* — yes on ELF, **no on COFF** (§3.2).

`target_uses_gnu_link_gc` answers (2) correctly and keeps its current
meaning. (1) needs a new predicate. (3) is why (1) alone is not
sufficient, and is what §4 closes.

---

## 4. The one edge that must close first

Under narrowing, exactly one reference from the retained set points into a
gated module: `runtime/prelude.sfn:90`'s
`let runtime_serve_fn = runtime.serve;`, which
`compiler/capsules/codegen-llvm/src/runtime_helpers/registry_concurrency.sfn:278`
lowers to `@sailfin_runtime_serve`, defined in `net`-gated
`runtime/sfn/concurrency/serve.sfn:1246`.

### 4.1 The four candidate classes, cleared

Establishing that it is the *only* one is what makes this plan landable
rather than hopeful.

- **Prelude module-globals** (`runtime/prelude.sfn:69-96`): 28 bindings.
  `runtime_serve_fn` is the only one targeting a gated module.
- **Registry rows resolving to a gated symbol**: sweeping the 62 public
  `fn` names across the eight `net`-gated modules against
  `compiler/capsules/codegen-llvm/src/runtime_helpers/registry_*.sfn`
  yields `runtime_serve_fn` plus the `http.*` and `websocket.*` families.
  Only `runtime_serve_fn` is bound unconditionally; the rest require
  `![net.http]` / `![net.ws]`, which open the gate via `effect_root`
  (`runtime_selection.sfn:182-195`).
- **Source-named cross-references** from ungated modules: already guarded
  by `compiler/tests/unit/runtime_source_gates_test.sfn:218`, which
  derives gated symbols from each gated module's public `fn` names rather
  than guessing prefix families.
- **Windows-conditioned modules**: the eight unconditionally-appended ones
  (`compiler/src/build/target.sfn:666-675`) reference no gated symbol. The
  gated `_windows` siblings (`socket_ops_windows.sfn`,
  `cert_roots_windows.sfn`) are produced only by *swap* from a POSIX
  source that survived selection (`target.sfn:582-624`), and selection
  runs first (`capsule_resolver/mod.sfn:357` →
  `runtime_objs.sfn:1819`), so they never appear in a narrowed set.
  `platform_dir` anchoring survives the narrowing too —
  `rlimit.sfn`/`fd_io.sfn`/`exec.sfn` are ungated.

### 4.2 The fix is a relocation, not a rewrite

**Superseded — see §1a.** The `scheduler.sfn` recommendation below was
tried and did not hold: `scheduler.sfn` is itself an `sfn-sources` member,
and the minimal-runtime e2e fixtures hand-write a shorter `sfn-sources`
list that omits it, so the undefined symbol just moved from `serve.sfn` to
`scheduler.sfn`. The reasoning that follows was sound on its own premise —
it correctly identifies that the target module must be ungated — but that
premise, "ungated implies always-present in `sfn-sources`", is false: a
runtime capsule chooses its own `sfn-sources` per fixture, so gatedness is
not the only axis that matters (§1a deviation 1). The definition landed in
`runtime/prelude.sfn` instead, which is present in every build by
construction. Left as originally written below for the record.

`runtime/sfn/concurrency/serve.sfn:1246` is:

```
fn sailfin_runtime_serve(handler: *u8, config: *u8) -> void { }
```

Its own comment (`:1237-1245`) confirms it "has always been a pure no-op"
— the real HTTP server is the typed `serve(handler, port)` form, routed by
the bespoke `Serve`-node lowering directly to `sfn_serve`. This stub
replaced a deleted C stub; behaviour is no-op → no-op.

**Moving that one function into an ungated module closes the edge with
zero behaviour change on every target.**

`runtime/sfn/concurrency/scheduler.sfn` is the right home: ungated
(`runtime/capsule.toml:82`), already concurrency-core, and — crucially —
**already in `sfn-sources`**, so there is no manifest edit, no seed
dependency, and no change to the "39 entries" assertion at
`runtime_source_gates_test.sfn:294`. A new module would cost all three.

This is a strict improvement on Linux too: it removes the tree's only
known reliance on dead-strip for *link correctness* (as opposed to size).

### 4.3 The resulting predicate

`runtime_link_dead_strips()` for msvc should be **`true` unconditionally —
not conditioned on the symbol reader**. On Linux the `nm` probe is
load-bearing because a failed enumeration withholds `--gc-sections`. On
msvc `/OPT:REF` is a target property, so the host toolchain has no bearing
on whether the link strips. Carrying the probe across would keep the
fail-open alive on Windows permanently.

---

## 5. Blast radius

**The self-host build is not affected by narrowing.**
`compiler/capsule.toml:104` sets `full-runtime = true`, short-circuiting
`compute_runtime_demand` to `"*"` at `runtime_selection.sfn:214` (routed
via `capsule_resolver/dedupe.sfn:447,777`). `docs/status.md:1430` states
it: "`sfn build -p compiler` is deliberately unaffected." `sfn test` opts
out the same way (`cli/commands/test/discovery.sfn:190-236`,
`capsule_resolver/types.sfn:96-104`).

Blast radius is therefore `sfn build` / `sfn run` of **non-compiler
projects on Windows**.

Failure mode of an incomplete narrowing: a Windows build fails at link
with `lld-link: error: undefined symbol: <name>`, naming the referencing
object. Loud, immediate, never silent — COFF's early diagnosis is a
liability for correctness-by-GC and an asset for detection.

Cheapest gate, already written:
`build/bin/sfn test compiler/tests/e2e/runtime_demand_driven_sources_test.sfn`
(ladder rung 3). Its `"stages no crypto"` and `asm.length <= 40`
assertions are exactly the acceptance criteria, and they are what is red
today.

---

## 6. Deferred: `/INCLUDE:` retain roots on msvc

Out of scope for this issue. It changes binary contents, not link
success, and today's rootless msvc link is already SFN-860's proposed end
state (§3.1). A successor needs three things:

1. **A shell-free enumerator** (§3.4).
2. **An answer to the 509-vs-70 root-count divergence.** Running the
   existing filter (`NF >= 3 && $2 ~ /^[A-TV-Z]$/ && $3 ~ /sfn/`) over the
   48 real COFF objects in `build/sailfin/` yields **509 roots and 18,021
   bytes of `/INCLUDE:` argv** — 150 `__sfn_type_desc.*`, 294 `sfn_*`, 65
   `_sfn_*`. `compiler/src/build/link_response.sfn:5-8` records **70**
   `-u` retain-root flags for the Linux self-host link. A 7× divergence
   suggests COFF gives the type-descriptor family external linkage where
   ELF does not, but that is a hypothesis; it should be measured against
   an ELF object set before roots ship, because rooting 150 type
   descriptors is a materially different policy from rooting the
   `sfn_*` provider family.

   Argv length itself is a non-issue: `link_argv_or_response_file`
   (SFN-641) collapses over-cap argv on all three link paths
   (`compiler/src/backend.sfn:429,436,441`).
3. **A Windows verification lever.** There is none today.
   `capsule_dead_strip_guard_test.sfn:161-163` and
   `capsule_reachability_filter_test.sfn:306-308` skip on Windows because
   "the linked PE carries no symbol table for llvm-nm to inspect";
   `runtime_sfn_sources_active_test.sfn:139-177` inspects
   `build/sailfin/*.o`, not the binary, so it does not gate link
   behaviour either. `-Wl,/MAP:<file>` or `/lldmap:<file>` is the likely
   lever — **unverified, not run.**

If SFN-860 lands first, this work shrinks to the compiler's own link.

---

## 7. Plan

Each step independently landable, each leaving a self-hosting compiler.
Rungs are `CLAUDE.md`'s validation ladder.

### Step 1 — close the prelude edge (runtime, target-independent)

Move `sailfin_runtime_serve` from `runtime/sfn/concurrency/serve.sfn:1246`
to `runtime/sfn/concurrency/scheduler.sfn`, carrying its comment and
citing the msvc reason. Rewrite `runtime/capsule.toml:249-258`'s PRELUDE
CONSTRAINT block per §3.3 — the dead-strippability argument is no longer
the safety argument, and where it is still cited it must name its targets.

*Validate:* **rung 1** —
`sfn check runtime/sfn/concurrency/scheduler.sfn runtime/sfn/concurrency/serve.sfn runtime/prelude.sfn`.
Then **rung 3** —
`build/bin/sfn test compiler/tests/e2e/runtime_serve_test.sfn` and
`build/bin/sfn test compiler/tests/unit/runtime_source_gates_test.sfn`.

Behaviour-neutral on Linux and Darwin. Ships alone.

### Step 2 — extend the invariant test to the two blind spots (test-only)

`runtime_source_gates_test.sfn:218` derives its always-compiled set from
`toml_get_sfn_sources(manifest)` plus the prelude, and its gated-symbol
set from `_public_fn_names`. It misses two classes:

- **Intrinsic-lowered names** — the `symbol:` field of the runtime-helper
  registry. This is how `sailfin_runtime_serve` escaped the test for the
  whole of SFN-882's life: the prelude's text is `runtime.serve`, which
  contains no gated `fn` name, and the mapping to `@sailfin_runtime_serve`
  lives in `registry_concurrency.sfn:278`. The test's own comment
  (`:174-183`) records that an earlier prefix-family revision passed while
  the tree was broken on exactly this symbol; the derived revision that
  replaced it still does not see this edge.
- **The Windows-conditioned module set** — `toml_get_sfn_sources` returns
  POSIX names, so the modules that actually compile on a Windows target
  are never scanned.

Add a case that reads `symbol:` values from
`compiler/capsules/codegen-llvm/src/runtime_helpers/registry_*.sfn` and
asserts none resolves into a gated module unless its `target:` is
effect-gated; and a case that runs
`target_condition_runtime_sfn_sources(sources, "Windows")` over the
retained set and re-runs the reference scan.

*Validate:* **rung 3** —
`build/bin/sfn test compiler/tests/unit/runtime_source_gates_test.sfn`.
The intrinsic case must be **red before step 1 and green after**; that
ordering is the proof step 1 was necessary.

### Step 3 — decompose the predicate (compiler, no behaviour change)

In `compiler/src/build/target.sfn`, add
`target_link_dead_strips(triple) -> boolean` — true everywhere including
msvc — alongside the existing `target_uses_gnu_link_gc` at `:432-434`,
which keeps its current meaning (*which flag syntax*), stays false for
msvc, and stays the sole gate on `link.sfn:354`.

*Validate:* **rung 3** —
`build/bin/sfn test compiler/tests/unit/target_conditioning_test.sfn` with
new rows beside `:272-275`. Zero link-argv change on every target; the
#1112 byte-identity gate holds by construction.

### Step 4 — flip narrowing on for msvc (the behavioural step)

`compiler/src/build/runtime_selection.sfn:97-102`:
`if !target_link_dead_strips(t) { return false; }`, then apply the `nm`
probe **only** on the GNU/Mach-O branch. The comment must state that on
msvc `/OPT:REF` is unconditional so the host toolchain is irrelevant, and
that narrowing there rests on closure rather than on GC (§3.2, §4.3).

*Validate on Windows, in this order:*

1. `SAILFIN_TRACE_RUNTIME_GATES=1 build/bin/sfn build -p <hello-world>` —
   read the demand line; expect `io`, not `*`.
2. **rung 3** —
   `build/bin/sfn test compiler/tests/e2e/runtime_demand_driven_sources_test.sfn`
   (the acceptance gate).
3. **rung 3** — the remaining four:
   `runtime_sfn_sources_link_consumer_test.sfn`,
   `runtime_sfn_sources_struct_import_test.sfn`,
   `runtime_implicit_capsule_link_test.sfn`,
   `standalone_workspace_implicit_import_test.sfn`.
4. `SAILFIN_RUNTIME_SOURCE_GATES=off build/bin/sfn build -p <hello-world>`
   — the bisect handle still reproduces the pre-SFN-882 artifact set.
5. **rung 2** — `sfn dev bootstrap build`, required for the
   `compiler/src/` change; confirms `full-runtime = true` kept the
   self-host path unchanged.

Run 4.1 and 4.2 before the other four — they are the cheapest signal that
the closure argument in §4.1 held.

### Files affected, by pipeline stage

Nothing in lex / parse / AST / typecheck / effects / emit / lower /
render. This is entirely **build driver + runtime source**.

| Stage | File | Change |
|---|---|---|
| Runtime source | `runtime/sfn/concurrency/serve.sfn:1237-1246` | remove the no-op stub |
| Runtime source | `runtime/sfn/concurrency/scheduler.sfn` | add it |
| Runtime manifest | `runtime/capsule.toml:249-266` | rewrite the prelude-constraint rationale (comments only — no `sfn-sources` or gate-table change) |
| Build driver | `compiler/src/build/target.sfn:432-434` | add `target_link_dead_strips`; leave `target_uses_gnu_link_gc` semantics intact |
| Build driver | `compiler/src/build/runtime_selection.sfn:97-102` | re-gate; msvc branch skips the `nm` probe |
| Tests | `compiler/tests/unit/runtime_source_gates_test.sfn` | two new cases |
| Tests | `compiler/tests/unit/target_conditioning_test.sfn:272-275` | rows for the new predicate |

### Seed dependency

**None.** Step 1 moves a function between two modules the manifest already
lists, so the pinned seed compiles it unchanged —
`.claude/rules/seed-dependency.md`'s runtime-source carve-out applies only
to runtime source *calling a compiler capability the seed lacks*, and this
calls nothing new. Steps 3–4 are compiler source with no runtime consumer;
bundled, they self-host from the old seed in one pass.

---

## 8. Alternative considered: accept the full-runtime cost on msvc

**The case for it.** Zero compiler risk. Windows is not yet a
release-gating target — SFEP-0068 §3.1
(`0068-native-cross-target-build.md:129`) already tables GNU link GC as
"off" for msvc as a deliberate choice, and SFEP-0021 M7
(`0021-windows-native-selfhost.md:317`) scoped MSVC-native flags out of
the booting-binary milestone on purpose. Windows builds would be slower
and fatter — SFN-882 measured 69→29 modules, 58.32 s→20.32 s, 1,915
MB→361 MB peak RSS on Linux, and msvc forgoes all of it — but nothing
would be *wrong* in the sense of producing bad output. It costs one line
per test.

**Why it is rejected.** The mechanism by which one "accepts" the cost is
rewriting `runtime_demand_driven_sources_test.sfn:191-232` — changing
`assert ! asm_has_crypto` to assert that crypto **is** staged on Windows,
and relaxing `asm.length <= 40`. That encodes the Reach hole as the
specification.

Per CLAUDE.md, Reach claims the compiler derives a manifest and proves it
**complete**. A test asserting that a `![io]`-only program links the TLS
stack is a test asserting the pillar does not hold on that target. That is
worse than a red test: a red test is a bug report, an updated assertion is
a design decision. `docs/status.md:1430`'s unqualified "Shipped" row is
wrong for msvc either way, and the honest options are "fix it" or "qualify
the row" — not "assert the bug."

---

## 9. Interim disposition (historical)

**Historical — describes the deferred period before implementation; see
§1a.** SFN-943 is now implemented and all six tests pass. Left as
originally written below for the record.

While this issue is deferred, the five tests stay **red and documented**.
They are **not** `skip()`ed, and their assertions are **not** relaxed.

The reason is SFN-1101: a skip counts as a *pass*. Skipping would
manufacture a green that lies about coverage — the same failure mode
`.wintest/pr1114.md:126` records for the eleven silent skips in the
baseline, where "the C oracle quietly disabl[ed] itself" and the tests
"reported green while doing nothing." SFN-1130's note that an enumerated
exclusion must be visible **as an exclusion, not folded into a pass
count**, decides it the same way. Honest red beats fake green.

The PR deferring this names each of the five files and cites SFN-943.
`docs/status.md:1430` gets a target qualifier on the SFN-882 row in the
same change: the narrowing does not happen on one of three targets, and
the status row should not claim otherwise.

---

## 10. Risks

1. **No net on msvc.** Once narrowing is on, an unknown dangling edge is a
   hard link failure rather than a silently-stripped section. Mitigated by
   step 2's static invariant and step 4's ordering — but §4.1's closure
   argument is *static*. The empirical check is 4.1/4.2.
2. **The ELF-vs-COFF explanation is unverified.** See §3.2's caveat. The
   observation is solid; the mechanism is a reading.
3. **Windows path handling in the demand scan.** `compute_runtime_demand`
   escalates to `"*"` on any `fs.exists` miss (`:233`). Its
   `source_paths` are unfiltered *project* sources, not runtime paths, so
   separators are not obviously in play — but `demand_paths` construction
   in `capsule_resolver/dedupe.sfn:757-777` was not traced. If step 4.1's
   trace prints `*` on Windows, that is where to look, not at the
   predicate.
4. **`sfn/crypto` is the only observed dep-spec.**
   `runtime_demanded_dep_specs:258-284` scans retained sources for
   `from "sfn/…"`; `runtime/sfn/platform/tls.sfn:82` is the sole hit
   across `runtime/sfn/` and `runtime/prelude.sfn`. A future runtime
   module adding a scoped import reopens the same class of problem, which
   is what step 2's extended invariant is there to catch.

---

## 11. Prior art

- **SFEP-0021 M7** (`0021-windows-native-selfhost.md:317`) is "first
  native MSVC build (booting)". It does not cover dead-strip flags;
  `compiler/src/build/link.sfn:427-428`'s deferral to M7 is an informal
  pointer, not a milestone deliverable. **No accepted SFEP covers this
  work.**
- **SFN-882** shipped (`docs/status.md:1430`); its design note
  `runtime-demand-driven-sources.md:152-157` carries the
  dead-strippability argument that §3.3 qualifies as ELF/Mach-O-only.
- **SFN-860** (`sfn-860-runtime-retain-root-scope.md`) is a design note
  only, not implemented. It would make rootless links the default on all
  targets — where msvc already is.
- **SFN-1114** established that `nm` is absent on a native Windows host
  and moved the test-side symbol reads to `llvm-nm`
  (`capsules/sfn/test/src/tool_probe.sfn`).
