# Demand-driven runtime `sfn-sources` selection

Design gate for the "deeper lever" named in
`docs/proposals/design-notes/sfn-860-runtime-retain-root-scope.md` §10.3.
**Design only — no compiler code written.** RCA:
`docs/rca/2026-08-13-e2e-shard-time-doubling-runtime-crypto-retain-roots.md`.
Project: Compiler Hardening.

This is **not** SFN-860. SFN-860 scopes the *retain-root set* and changes only
`link_flags`; its own §10.1 states it "does not narrow the emitted closure by
one module." This note changes **which modules get compiled**. The two are
independent, land in either order, and compose.

---

## 0. Implementation corrections (SFN-882)

Five claims below were contradicted during implementation. They are corrected
here rather than edited in place, so the reasoning that produced them stays
readable.

1. **`![net.http]` and `![net.ws]`, not `![net]` — §4.1 was unsound as
   written.** The `net`-rooted intrinsics are declared as *sub-effects*
   (SFEP-0017 D1): `http.get`/`http.post`/`http.download` require `![net.http]`,
   the five `websocket.*` entries require `![net.ws]`, and only `serve` requires
   bare `![net]` (`compiler/capsules/ir/src/intrinsic_effects.sfn:56-128`).
   §4.1's demand set is "every effect token appearing inside an `![ … ]` list",
   matched against gate keys — which are canonical roots. A program declaring
   `![net.http]` would contribute the token `net.http`, match no `net` gate,
   close the gate, and fail the link on an undefined `sfn_http_get`. **Every
   scanned token must be normalized through `effect_root()`**
   (`analyzer/src/effect_taxonomy.sfn:65`, already exported). The same applies
   to `[capabilities] required` entries.

2. **The blocking §5.4 investigation passed; the E-code is `E0400`.** A bare
   `serve(...)` with no `net` effect *is* rejected — the bespoke lowering does
   not escape enforcement. The diagnostic is `E0400` ("function `main` is
   missing required effects"), not the `E0402` predicted in §3, §4.2, §5.4 and
   §10.3.7. Every `E0402` in this note referring to a *missing effect
   declaration* should read `E0400`.

3. **`sfn-sources` has 35 entries, not 34.** The count is wrong everywhere it
   appears (§2.1, §2.3, §8.2, §8.4, §9.1). 26 ungated + 10 gated names, of which
   9 are present in the POSIX list (`cert_roots_windows.sfn` and
   `socket_ops_windows.sfn` are conditioning-appended and absent) → 35 − 9 = 26
   ungated. Pinned by `runtime_source_gates_test.sfn`.

4. **`CapsuleResolution` is not a real type.** §4.4 and §7 name it; the tree has
   `CheckCapsuleResolution` (`capsule_resolver/types.sfn:246-257`) and
   `TestCapsuleResolution` (`:269-283`) — two distinct structs. Neither needed
   the field: `sfn check` never links, and the test-link path takes the
   fail-open default (see 5). The demand rides on `ResolverDedupeResult` and
   `ProjectCapsuleResult` instead.

5. **`sfn_source_gates` is a record list, not a parallel array.** §4.3 specifies
   an array parallel to `sfn_sources`. That breaks:
   `target_condition_runtime_sfn_sources` substitutes and *appends* platform
   siblings, so any positional alignment is stale the moment conditioning runs.
   The field holds `"<effect>\t<absolute-path>"` records, making the lookup
   independent of order and length — which is what actually lets §4.7's
   select-then-condition composition hold.

6. **C1 does not work without also fixing the filter's fail-open guard — §9.1's
   "crypto → 0" is unreachable as designed.** This was found by measurement, not
   review: with everything else implemented, the demand set computed correctly
   (`[runtime-gates] demand: io rand clock`) and the gate closed, yet all 33
   crypto modules were still compiled and peak RSS landed at 455 MB — exactly
   the "gated sources only, dep edge left in place" datapoint from §2.4, not the
   361 MB the full design predicts.

   The cause is `_cr_filter_reachable_sources`' own `retained.length == 0`
   guard. On a positional build the runtime roots were the **only** root class
   that ever produced edges: `root_source_paths` is empty because the project
   contributed no capsule sources, and `tls.sfn` naming `sfn/crypto` is how the
   crypto capsule entered the retained set at all. Close the `net` gate and
   every root class goes empty, the guard concludes "root discrimination is
   wrong for this shape", and it retains the **unfiltered** set — silently
   restoring all 33 modules. The design's own fail-open posture defeats its
   largest win.

   The fix distinguishes *well-defined and empty* from *never derived*:
   `_cr_selected_runtime_root_count` reports how many runtime sources selection
   left to seed from, and a zero edge set is authoritative only when that count
   is non-zero. This is safe because `_cr_seed_entry_roots` reads the entry file
   and seeds its edges (`reachability.sfn:344-355`), so a project that genuinely
   imports a capsule still derives roots; `retained == 0` with a live runtime
   root means nothing in `sources` is referenced by anything.

   **Generalisable lesson:** a fail-open guard written for one cause silently
   swallows a second cause introduced later. §11's risk table anticipated the
   link contract (§6) as the sharpest hazard and was right that it fails
   *loudly*; this one fails **silently**, as a change that merely does nothing.
   The only reason it was caught is that §10.4 makes measurement a required
   deliverable rather than a nice-to-have.

7. **"Either consumer may fail open independently" is FALSE, and it was the
   §6 landmine in disguise.** The scope reduction below originally left the
   `sfn test` link path unnarrowed, reasoning that a link site without a demand
   set should fail open. Review caught it and measurement confirmed it: `sfn
   test` threads a non-empty `runtime_root` into every `ResolverConsumer`, so
   **C1 has already narrowed** the capsule closure by the time control reaches
   the link. Re-widening the runtime capsule there asks the contract to require
   `sfn/crypto` reach a link that no longer compiles it. The same divergence
   exists in `build/tensor_ir_link_harness.sfn`, whose fallback the code
   comments describe as *always* firing. Confirmed live:

   ```
   link-contract: the runtime capsule declares 1 [dependencies] entry
   with no compiled module reaching the link:
     - sfn/crypto
   ```

   The correct invariant is **"C1 and the link site must use the same demand
   set"** — fail-open is a property of how that *one* set is computed, never a
   licence for two consumers to derive it separately. `runtime_demand` is
   therefore threaded onto `TestCapsuleResolution` and `TestGroup` and into
   `_clang_link_test_cmd_with_deps`, as §4.4 originally specified; the harness
   narrows its fallback with `dep_result.runtime_demand`.

   Note what this says about test design: the e2e suite passed 7/7 while both
   paths were broken, because every one of its fixtures drives `sfn build`.
   A build-only acceptance suite cannot see a defect that lives on the test-link
   and harness paths.

8. **The scan must tolerate `! [net]`.** `parse_effect_list` matches `!`, then
   `parser_advance_raw`, then `skip_trivia`, then `consume_symbol("[")`, so
   whitespace between the two is grammatical and effect-checks normally.
   Requiring literal `![` adjacency would drop the effect from the demand set
   and break the link on unformatted user source. `sfn fmt` canonicalises to the
   tight form, so no in-tree source exercises it.

9. **§4.8 is wrong: the prelude IS in scope, by symbol reference.** The note
   argues the prelude is safe because "everything the prelude imports is
   ungated", and mechanises that as unit test 10.2.3 (an *import* disjointness
   check). Imports are the wrong relation. `runtime/prelude.sfn:90` binds
   `runtime_serve_fn = runtime.serve` and `:621` defines a `serve()` wrapper
   over it, giving the always-compiled prelude a reference to
   `sailfin_runtime_serve` in **gated** `serve.sfn`. Nested `sfn test` fails:

   ```
   ld.lld: error: undefined symbol: sailfin_runtime_serve
   >>> referenced by prelude.sfn
   ```

   The closure does not stop there, and this is the part that forecloses the
   obvious fix. `serve.sfn` and `http.sfn` have **no imports at all**, yet both
   call the bare `tls_*` API (`tls_client_ctx`, `tls_read`, `tls_write`) in
   `tls.sfn` — which imports `sfn/crypto`. So "just ungate what the prelude
   reaches" ungates serve → http → tls → crypto and erases the entire win. An
   import-only audit reports a clean bill of health on all of it.

   The actual resolution is that the reference is **dead-strippable**: the
   prelude's `serve` wrapper does not match the `sfn*` retain-root pattern, so
   `--gc-sections` removes it from any binary that never calls `serve`, and a
   binary that does call it must declare `![net]`, opening the gate. `sfn build`
   was therefore never broken. Only the test-link path, which does not
   dead-strip, retains the wrapper — so `sfn test` opts out of selection on both
   sides (correction 7's invariant), and the gate stays intact everywhere else.

   §10.2.4's symbol-family grep also cannot catch this: it matches prefixes like
   `sfn_serve`, and the symbol is `sailfin_runtime_serve`. The test now derives
   each gated module's actual public `fn` names and searches for those, over the
   ungated sources **and the prelude**. Guessing prefixes is what let two
   separate defects through.

One scope reduction, deliberate: the `sfn test` link path
(`cli/commands/test/link.sfn`) takes the fail-open `"*"` default rather than
threading a demand set — the pooled runner already amortises its runtime objects
and the capsule-closure win is paid by the nested builds e2e tests spawn, which
go through `build.sfn`/`run.sfn`. And `_stage_runtime_sfn_import_context`'s dep
guard (§4.5) and the link contract (§6) share one helper,
`runtime_demanded_dep_specs`, as §6 requires.

---

## 1. Decision

**Compile a runtime `sfn-source` only when the build's declared effect surface
can reach it.**

The demand signal is the **effect annotation** — `![net]`, `![gpu]`, … — and
the project manifest's `[capabilities] required`. `runtime/capsule.toml` grows
a last-in-file `[sfn-source-gates]` table keyed by canonical effect name; a
source listed under `net` is compiled only when `net` is demanded. **A source
named in no gate is always compiled** — the default is today's behaviour, so
adding a runtime module is safe by construction and this is a whitelist of
gateable modules, not a denylist of heavy ones.

One demand set is computed once per build in the resolver and threaded to
three consumers:

| # | Consumer | File | What narrows |
|---|---|---|---|
| C1 | Capsule-closure root seeding | `compiler/src/capsule_resolver/reachability.sfn:372-411` | `sfn/crypto`'s 33 modules stop being reachable at all |
| C2 | Runtime import-context staging | `compiler/src/build/runtime_objs.sfn:1359-1455` | 8 runtime `.sfn-asm` + the whole dep-capsule staging loop |
| C3 | Runtime object compile | `compiler/src/build/runtime_objs.sfn:1613-1632` | 8 runtime `.ll`+`.o` emits |

Rejected alternatives are in §3. The seed/bundling verdict is §8 — **it
bundles, one PR, no `seed-blocker`** — and the reasoning there is the single
most load-bearing part of this note.

---

## 2. Current state, measured on this tree

### 2.1 The 69 modules, attributed exactly

`build/sailfin/rt-import-context/` on this checkout holds **69** `.sfn-asm`
files. They decompose with no ambiguity:

```
36  runtime/…   = 34 `sfn-sources` + `platform/posix` + one further
                  platform extern staged by `_stage_imported_platform_externs`
33  sfn/crypto/… = every `.sfn` under `capsules/sfn/crypto/src/`
```

A **second, disjoint** 33 modules live in `build/capsules/sfn/crypto/ir/` —
the capsule-resolver path's full LLVM emit, each with a `.layout-manifest` and
a `.o`. So the crypto capsule is compiled **twice** per build: once as native
`.sfn-asm` staging for the runtime emit context, once as real IR for the link.
The task brief's "38 of 69 are crypto/TLS" counts only the staging side.

### 2.2 The three independent over-approximations

**(A) `runtime/capsule.toml:46-82` declares 34 unconditional `sfn-sources`.**
`_compile_runtime_sfn_sources` (`compiler/src/build/runtime_objs.sfn:1613-1632`)
iterates the list verbatim:

```
        let mut si: int = 0;
        loop {
            if si >= cap.sfn_sources.length { break; }
            let src = cap.sfn_sources[si];
            let plan = _prepare_runtime_sfn_object(self_path, cap_prefix, src, …);
```

There is no filter anywhere between the manifest array and this loop. The only
existing gate is all-or-nothing: `SAILFIN_DISABLE_RUNTIME_SFN_SOURCES`
(`:1561`).

**(B) `_stage_runtime_sfn_import_context`'s dep-capsule loop
(`runtime_objs.sfn:1397-1435`) stages every source of every declared runtime
dependency**, driven off the manifest declaration rather than off whether any
runtime source actually imports it:

```
            let dep_files = _collect_sfn_files_cmd(located.src_dir, 16);
            …
                if !_stage_one_runtime_sfn_import_context(self_path, dep_src, dep_slug, …) {
```

`located.src_dir` is `capsules/sfn/crypto/src`; `_collect_sfn_files_cmd` is a
flat directory walk. All 33 are staged for `print("hi")`.

**(C) `_cr_seed_runtime_roots` (`reachability.sfn:372-411`) seeds the capsule
closure from *every* runtime `sfn-source`**:

```
        let rt_sources = capsules[ci].sfn_sources;
        …
                let edges = _cr_reach_edge_slugs_for_text(text, path, sources);
```

`runtime/sfn/platform/tls.sfn:37-80` carries `} from "sfn/crypto";`. That one
edge resolves to the barrel `sfn/crypto/mod`, whose `export … from` chain
re-exports essentially the whole capsule — which is precisely why
`docs/status.md:345-367` records the SFN-833 filter as producing "no change in
`modules_staged`, ctor count, or binary size."

**The single edge `runtime/sfn/platform/tls.sfn → sfn/crypto` is load-bearing
for all of (B) and (C).** `capsules/sfn/crypto` has exactly one other importer
in the tree that matters here: `compiler/src/cli/commands/toolchain.sfn:31`
(`import { ed25519_verify_utf8 } from "sfn/crypto";`), which keeps crypto in
`-p compiler` builds independently — see §5.3.

### 2.3 What the 34 actually cost

Cold `sfn run examples/basics/hello-world.sfn` = **58.99 s** / 69 staged
modules, against a pre-regression baseline of **~12 s** / 33.
`examples/basics/hello-world.sfn` in full:

```
fn main() ![io] { print("Hello, Sailfin!"); }
```

It declares `![io]`. It cannot reach TLS, HTTP, WebSocket, sockets, or
`serve`, and the compiler already knows that — `E0402`/`E0403` would reject it
if it tried.

### 2.4 Measured, not inferred — the win is 2.9x, not 4x

§10.4 asked for the emit-pipeline attribution as a PR deliverable. It was
instead run up front, because the point estimate decides whether the 5 points
are worth spending. Method: stash `build/sailfin` and `build/capsules` (the two
per-build artifact trees that persist *outside* `SAILFIN_BUILD_CACHE_DIR`),
point the cache root at an empty directory, and time
`sfn run examples/basics/hello-world.sfn`. 4 vCPU / 15 GiB Linux, the
ubuntu-24.04 runner shape.

Overriding `SAILFIN_BUILD_CACHE_DIR` alone does **not** produce a cold build —
`build/sailfin` and `build/capsules` still serve the dominant artifacts, and a
run that skips the stash measures 7.8 s regardless of configuration. Any future
attempt to reproduce these numbers must stash both trees or it will measure
noise and conclude, wrongly, that the change does nothing.

| configuration | modules | crypto | wall | peak RSS |
|---|---|---|---|---|
| control — today's tree | 69 | 38 | **58.32 s** | 1,915 MB |
| gated sources only, dep edge left in place | 62 | 33 | 39.86 s | 455 MB |
| gated sources + crypto unseeded (≈ this design) | **29** | **0** | **20.32 s** | **361 MB** |

Three things follow, and two of them correct §10.4:

1. **The estimate of 11–15 s was optimistic.** The real figure is **20.32 s, a
   2.87x reduction** — large, and below the 33-module pre-regression baseline
   on module count, but not 4x. Size the issue against 2.9x.
2. **Gating the sources without unseeding the capsule recovers under a third of
   the available win** (58.32 → 39.86 s, with all 33 crypto modules still
   emitted). The `[dependencies] "sfn/crypto"` edge unions into every
   resolution independently of who imports it, so a change that narrows
   `sfn-sources` and stops there is not a partial version of this design — it is
   the cheap two-thirds of the cost left on the floor. The
   `_cr_seed_runtime_roots` narrowing in §4.4 is the load-bearing half.
3. **Peak RSS falls 5.3x, 1,915 MB → 361 MB.** Unlooked-for and arguably worth
   more than the wall time: `_test_jobs_budget`
   (`compiler/src/cli/commands/test/arg_and_jobs.sfn`) reserves 3 GiB per test
   job, and that reservation is what pins the macOS nightly leg to `TEST_JOBS=1`
   and forced Linux from 4 to 2 (SFN-781). A 5.3x smaller per-child peak is the
   only thing on the table that could move those budgets back up. Re-derive
   both budgets against a measured post-change child before touching them —
   the constants encode an OOM history (SFN-87, exit 134), not a guess.

---

## 3. Mechanism selection

### 3.1 SFN-833's filter is not reusable, and the reason is structural

The coordinator's trace is correct and I confirm the sharper reason: **the
runtime's inter-module edges are not import edges.** Across `runtime/sfn/`
there are exactly **six** relative `import` statements between runtime modules
(`clock.sfn:69`, `channel.sfn:39`, `nursery.sfn:55`, `scheduler.sfn:60`,
`secretbuf.sfn:90`, `string.sfn:55`, plus `pthread_windows.sfn:27`). Every
other cross-module runtime edge is a C-ABI `extern fn sfn_*` declaration —
23 modules carry between 1 and 10 of them — and a third class of edge has no
source-level marker at all: the descriptor registry
(`compiler/capsules/codegen-llvm/src/runtime_helpers/registry_*.sfn`) lowers
`print`, `fs.exists`, `http.get`, string concatenation and array push straight
to `@sfn_*` call sites with no `import` anywhere.

So option (a) from the coordinator's message — reshaping `sfn_sources` into
`CapsuleSource[]` and running `_cr_filter_reachable_sources` over it — would
compute an import closure that retains roughly **8 of 34 modules and breaks
every build**, because `io.sfn`, `arena.sfn`, `type_meta.sfn` and the rest have
no inbound import edge. Import reachability is the *wrong relation* for this
list, not merely an inconveniently-shaped one.

**Option (b) is taken.** A small, purpose-built selector over the manifest
array, reusing from `compiler/src/capsule_import_scan.sfn` only the pure text
scanners and their `_cr_byte_at` / `_cr_is_ident_char` / `_cr_word_matches`
character-walk primitives (`:50-97`). No `CapsuleSource`, no BFS, no dedupe.

### 3.2 Why effects, and not a symbol closure

The obvious alternative is a symbol-level closure: scan the already-emitted
`ll_paths` for referenced `@sfn_*` symbols, map symbol → defining module, close
transitively. It is precise and it is sound at the link. It fails on **timing**:
`ll_paths` do not exist until after emission, and consumer **C1** — the one
that kills 33 crypto capsule modules, the largest single cost — runs during
*resolution*, before anything is emitted. A signal that only exists at link
time can narrow C2 and C3 and leaves C1 untouched, recovering less than half
the regression.

Effects are available from source text at resolution time, and they are the
**machine-checked contract** that already governs exactly this surface.
`compiler/capsules/ir/src/intrinsic_effects.sfn:56-128` is the authoritative
table:

```
    table = append_intrinsic_effects(table, "http.get", ["net.http"]);
    table = append_intrinsic_effects(table, "websocket.connect", ["net.ws"]);
    table = append_intrinsic_effects(table, "serve", ["io", "net"]);
```

and `effect_checker/collector.sfn:423-465` resolves member calls through it
("`fs.exists`, `http.get`, `http.download` -> `[net, io]`"), with
`websocket.*` registry-derived since #1601 and the Call-form `serve(…)` handled
at `:340-362, 612-632`. Every entry point into the eight modules this note
gates is `net`-rooted in that table, and the effect checker propagates
transitively to `fn main`.

That makes the gate **an application of the Reach pillar to the build**: the
compiler already proves what the program can reach; this spends that proof.

### 3.3 Why not a subsystem denylist in the driver

SFN-860 §3.1 rejects "exclude the networking/TLS objects" for the retain-root
set on the grounds that it is a denylist keyed on today's subsystem names with
nothing structurally coupling it to `runtime/capsule.toml`, and that the next
heavy dependency re-introduces the regression silently. That argument transfers
verbatim. The gate table lives **in `runtime/capsule.toml`, three lines below
the `sfn-sources` array it partitions**, with a checked-in test asserting every
gate member names a real `sfn-sources` entry (§10.2). Adding an ungated source
keeps today's behaviour; gating one is a deliberate, reviewed manifest edit next
to the list it modifies.

---

## 4. Design

### 4.1 The demand set

```
demand : string[]   // canonical effect names, or the sentinel "*"
```

`"*"` means "retain everything" and is the **default for any caller that has
not computed a real set** (§4.6). Otherwise `demand` is the union of:

1. `resolved.capabilities_required` — already computed
   (`capsule_resolver/dedupe.sfn:332`, threaded to
   `reachability.sfn:596`), read from the project manifest's
   `[capabilities] required`.
2. Every effect token appearing inside an `![ … ]` list in the text of any
   source in the **unfiltered** deduped set (`resolved.sources`) or any
   `entry_paths` member.

New scanner, in `compiler/src/capsule_import_scan.sfn` beside
`collect_scoped_import_specs` (`:339`):

```
fn collect_effect_tokens(source: string) -> string[]
```

Deliberately a **raw** scan: it does **not** skip strings or comments, unlike
its neighbours. An e2e test that embeds a fixture program as a string literal,
or a comment reading "`(http.download, ![io, net])`"
(`compiler/src/cli/commands/toolchain.sfn:15`), over-retains. Over-retention is
free correctness; a comment-state bug that *missed* a real annotation is a link
break. Bound the scan window after `![` to 128 bytes so a stray `![` in prose
cannot run away.

**Why the unfiltered set.** Scanning the *filtered* closure would be circular —
the closure depends on the runtime roots, which depend on the demand set. One
pass over the unfiltered set breaks the cycle at the cost of over-approximation.
Measured on this tree that costs nothing: hello-world's unfiltered set is
`sfn/crypto` ∪ `sfn/strings` ∪ `sfn/prelude`, and
`grep -rl '!\[[a-z, ]*net' capsules/sfn/crypto/` returns **0 files**; so does
`capsules/sfn/test/`, which is what every e2e test binary resolves. Only
`capsules/sfn/http/` and `capsules/sfn/net/` (3 files each) declare `net`, and
those only enter the set when a project actually depends on them. The scan
reads ~40 files of text once per build; the sources are already read by
`_cr_reach_module_edge_slugs` (`reachability.sfn:229-234`), so memoise the
reads and the marginal cost is a second pass over in-memory strings.

### 4.2 The gate table

Appended as the **last section** of `runtime/capsule.toml`, after
`[dependencies]`:

```toml
# Demand-driven `sfn-sources` selection. A source listed under an effect
# name is compiled only when the build's declared effect surface demands
# that effect; a source named in NO gate is always compiled. Keys are
# canonical effect names
# (`analyzer/src/effect_taxonomy.sfn::canonical_effects()`).
#
# `net` covers the TLS 1.3 stack, the socket/HTTP/WebSocket adapters and
# the server loop. Every entry point into these modules is `net`-rooted in
# `compiler/capsules/ir/src/intrinsic_effects.sfn`, so a program that can
# call one must declare `![net]` transitively to `fn main` or fail E0402.
[sfn-source-gates]
net = [
    "sfn/platform/tls.sfn",
    "sfn/platform/tls_record.sfn",
    "sfn/platform/cert_roots.sfn",
    "sfn/platform/cert_roots_windows.sfn",
    "sfn/platform/socket_ops.sfn",
    "sfn/platform/socket_ops_windows.sfn",
    "sfn/adapters/http.sfn",
    "sfn/adapters/websocket.sfn",
    "sfn/adapters/net.sfn",
    "sfn/concurrency/serve.sfn",
]
```

Eight members are present in the POSIX list; the two `_windows` spellings are
appended by `target_condition_runtime_sfn_sources`
(`compiler/src/build/target.sfn:423+`) and are named here so the gate composes
with that substitution (§4.7). Naming a source that is never present is inert.

**Placement is load-bearing.** `runtime/capsule.toml:27-32` already warns that
these arrays are read by the *pinned seed's* baked-in TOML parser during
`make compile`. `toml_get_string_array(text, section, key)`
(`compiler/src/toml_parser.sfn:589`) scans forward from a `[section]` header to
the next header, so a new section inserted **before** `[build]`'s array block
would truncate `sfn-sources` under the old seed and break `make compile`
outright. Last-in-file, flat-array form only.

**No section-enumeration API is needed.** The driver looks up
`toml_get_string_array(text, "sfn-source-gates", e)` once per `e` in
`canonical_effects()` — six fixed lookups (`clock`, `gpu`, `io`, `model`,
`net`, `rand`). An absent key returns empty. New gate keys need no parser work,
only a manifest edit.

### 4.3 The selector

New module `compiler/src/build/runtime_selection.sfn`. Pure except for the
manifest read; no `![io]` beyond `fs.readFile`.

```
fn runtime_source_gate_effect(gates: RuntimeSourceGates, src_rel: string) -> string
fn select_runtime_sfn_sources(caps: RuntimeCapsuleArtifacts[], demand: string[])
    -> RuntimeCapsuleArtifacts[]
```

`select_runtime_sfn_sources` rebuilds each `RuntimeCapsuleArtifacts` with
`sfn_sources` narrowed; every other field passes through. Retention rule per
source, in order:

1. `demand` contains `"*"` → retain.
2. The source is in no gate list → retain.
3. The source's gate effect ∈ `demand` → retain.
4. Otherwise drop.

Matching is on the manifest-relative spelling with a basename fallback, because
`RuntimeCapsuleArtifacts.sfn_sources` holds **absolute, normalised** paths
(`runtime_capsule_resolver.sfn:507`, `_rcr_resolve_paths`) while the gate table
holds manifest-relative ones. Resolve the gate list through the same
`_rcr_resolve_paths(manifest_dir, …)` at parse time so the comparison is
absolute-to-absolute and cannot drift on a relocated `SAILFIN_RUNTIME_ROOT`
(the defect class `_runtime_module_slug`'s SFN-146 header documents).

`RuntimeCapsuleArtifacts` (`runtime_capsule_resolver.sfn:63-78`) gains one
field, `sfn_source_gates: string[]` — parallel to `sfn_sources`, `""` for
ungated. Parallel-array rather than a map because the codebase has no map type
in this layer and `_condition_runtime_capsules` already reconstructs the struct
by field list. **Every construction site must set it**; there are three
(`_rcr_artifacts_from_manifest:503-511`, `_condition_runtime_capsules`
`runtime_objs.sfn:1661-1663`, and the empty/default constructor).

### 4.4 Threading — single-list discipline

SFEP-0070 §3.5 layer 2 is the governing precedent: "build-path callers swap
`_cr_resolve_and_dedupe` for this wrapper wholesale rather than filtering at
each use site." Same here — the demand set is computed **once** and carried,
never recomputed per consumer.

- `ResolverDedupeResult` (`capsule_resolver/dedupe.sfn:56`) and
  `CapsuleResolution` (`capsule_resolver/types.sfn:256, 282`) gain
  `runtime_demand: string[]`, populated in `_cr_resolve_dedupe_filtered`
  (`reachability.sfn:589-601`) and passed through the ~12 existing
  `capabilities_required:` threading points verbatim beside it (they are
  already enumerated in the grep at `capsule_resolver/{check,mod,dedupe}.sfn`).
- `_cr_filter_reachable_sources` (`reachability.sfn:436`) computes it before
  seeding, and hands it to `_cr_seed_runtime_roots` (**C1**).
- `cli/commands/build.sfn:525`, `cli/commands/run.sfn:173` and
  `cli/commands/test/link.sfn:89` apply
  `select_runtime_sfn_sources(caps, resolution.runtime_demand)` at the point
  they already materialise `runtime_capsules`, before handing them to the link.

`link.sfn` and `runtime_objs.sfn` therefore need **no new parameter**: they
receive an already-narrowed `RuntimeCapsuleArtifacts[]` and C2/C3 fall out of
the existing loops unchanged. That is the whole reason to narrow at the call
site rather than inside `_compile_runtime_sfn_sources`.

### 4.5 C2's dep-capsule loop needs one further change

Narrowing `sfn_sources` alone does not stop
`_stage_runtime_sfn_import_context`'s dep loop (`runtime_objs.sfn:1397-1435`):
it iterates `cap2.capsule_deps`, which still contains `"sfn/crypto"` from the
manifest. Add a guard before `locate_runtime_dep_capsule_src`: stage a dep
capsule only when at least one **selected** source in `cap2.sfn_sources`
scoped-imports it, via `collect_scoped_import_specs` +
`_cr_scope_name_prefix`-equivalent matching over the already-read source text.

Keep the existing fail-closed behaviour for a dep that *is* demanded and cannot
be located (`:1408-1415`). A dep that no selected source imports is simply not
staged — that is the intended outcome, not a failure.

### 4.6 Fail-open, stated as a property

Same posture as `reachability.sfn:13-25`, and for the same reason. Concretely:

- **The selector may only ever REMOVE sources.** It never adds one and never
  reorders; `select_runtime_sfn_sources` with `demand = ["*"]` returns the
  input list element-for-element.
- **Any uncertainty widens.** A gate key that is not a canonical effect name is
  ignored (the sources stay). A gate list naming a source not in
  `sfn_sources` is ignored. An unreadable source during the demand scan
  contributes no tokens but **also** forces `demand = ["*"]` for that build —
  distinct from the reachability filter, where an unreadable source safely
  contributes no edges; here a missed annotation is a link break, so a read
  failure must escalate rather than degrade.
- **`sfn check` is untouched by runtime-source selection.** It never links and
  passes an empty runtime root, so this design's demand-driven selector has no
  check-path consumer. SFN-894 separately applies dependency-capsule
  reachability filtering to check, rooted in the explicitly requested files;
  SFEP-0070 §3.6 therefore requires per-command closure completeness rather
  than cross-command set inclusion.
- **Operator escape hatch:** `SAILFIN_RUNTIME_SOURCE_GATES=off` (also `0` /
  `false`) forces `demand = ["*"]`, reproducing today's artifact set exactly —
  the bisect handle, mirroring `SAILFIN_CAPSULE_FILTER`
  (`reachability.sfn:271-279`). `SAILFIN_TRACE_RUNTIME_GATES=1` prints the
  demand set and the dropped source list to stderr, mirroring
  `SAILFIN_TRACE_CAPSULE_FILTER`.

There is deliberately **no `fault` mode**. The reachability filter needs one
because it has a closure invariant to violate; this selector has no fixed point
to verify — its output is a direct function of a declared table.

### 4.7 Composition with `_condition_runtime_capsules` and the disable flag

`_condition_runtime_capsules` (`runtime_objs.sfn:1654-1667`) runs **inside**
`assemble_runtime_capsule_link_inputs` (`:1679`), i.e. *after* the call-site
selection in §4.4. Order is therefore: **select → condition**. That is the
correct order for two reasons:

1. Selection at the call site is what C1 also consumes, and SFEP-0070 §3.2
   mandates the un-target-conditioned list for root seeding ("over-approximating
   roots retains more, which is the safe direction"). One decision, both
   consumers, no divergence.
2. Conditioning only ever *substitutes* or *appends* platform siblings of
   sources already present. Since no gated source is substituted
   (`target.sfn:451-459` explicitly passes `tls.sfn` through unchanged; only
   `process`/`rlimit`/`terminal`/`rand`/`fs_exec_mode` are swapped, none gated),
   dropping a gated source before conditioning cannot orphan a substitution.

The **append** half is the one to watch: conditioning appends
`socket_ops_windows.sfn` and `cert_roots_windows.sfn` anchored off
`platform_dir`, which is discovered from whichever of a named set is present
(`target.sfn:426-431`). Dropping the whole `net` group could remove the anchor.
Two mitigations, both required: (i) the anchor set includes `rlimit.sfn`,
`terminal.sfn`, `rand.sfn`, `fs_exec_mode.sfn`, `exec.sfn` — all ungated, so an
anchor always survives; (ii) the Windows spellings are named in the gate table
so a conditioned-in `socket_ops_windows.sfn` is dropped by the same rule if
`net` is absent. **A Windows-target e2e leg is a required acceptance item**
(§10.3).

`SAILFIN_DISABLE_RUNTIME_SFN_SOURCES` (`:1561`) is orthogonal and unchanged: it
short-circuits before any iteration and therefore before any selection.

### 4.8 The prelude is out of scope

`runtime/prelude.sfn` is compiled from the separate call site at
`runtime_objs.sfn:1718-1769`, deliberately outside `_compile_runtime_sfn_sources`
so the disable flag cannot gate it (`:1707-1717`). It is not a member of
`sfn-sources` and the selector never sees it. It is **always compiled**,
unchanged.

That is only safe because everything the prelude imports is ungated.
`runtime/prelude.sfn:50-60` imports `./sfn/array`, `./sfn/clock`,
`./sfn/exception`, `./sfn/io`, `./sfn/process`, `./sfn/string`,
`./sfn/type_meta` — none in the `net` gate. **Assert this mechanically**
(§10.2) rather than leaving it to inspection: a future gate that captures a
prelude import would produce an undefined symbol in every binary.

---

## 5. Correctness boundary

The failure mode of an over-narrow selection is an **undefined symbol at
link** — `ld: undefined reference to 'sfn_http_get'` — not a silent runtime
crash, because every runtime helper reaches user code through a direct
`call @sfn_*` emitted by the descriptor registry, and the link happens before
the program ever runs. That is the good failure mode, and it is why this design
is defensible at all. The enumeration below is what keeps it from happening.

### 5.1 Modules reachable by something other than a static import

| Reach class | Modules | Kept by |
|---|---|---|
| Descriptor-registry lowering (`print`, `fs.*`, string concat, array push, `substring`, `number.to_string`) | `io`, `string`, `array`, `adapters/filesystem`, `memory/*` | **Ungated** — no gate names them |
| `.init_array` type registration (`@__sfn_module_type_init__` → `sfn_type_register`) | `type_meta` | **Ungated** |
| Exception/unwind (`try`/`throw` → `sfn_throw`) | `exception`, `assert` | **Ungated** |
| Scheduler / nursery / channel ctors and task entry (`spawn_task`, `parallel`) | `concurrency/{scheduler,nursery,future,channel,parallel}` | **Ungated** |
| Process self-cap at startup (`fn main` → `RLIMIT_AS`) | `platform/rlimit`, `platform/exec`, `process` | **Ungated** |
| `@runtime` global, still emitted by the pinned seed in every module | `runtime_globals` | **Ungated** |
| Descriptor-registry lowering of `http_get`/`websocket.*`/`serve`/`serve_tls` | the 8 gated modules | **Gated on `net`** — and every one of those targets is `net`-rooted in `intrinsic_effects.sfn:56-128`, enforced by `effect_checker/collector.sfn` |

**26 of 34 sources are ungated.** The gate covers exactly the eight whose
entire externally-callable surface is `net`-rooted.

### 5.2 No ungated module references a gated module's symbols

Verified by symbol family. The gated modules define disjoint, prefix-clean
families:

```
tls_record.sfn   sfn_tls_record_*        (18)
cert_roots.sfn   sfn_cert_roots_blob
socket_ops.sfn   sfn_socket_open|close
adapters/http    sfn_http_*              (8)
adapters/websocket sfn_websocket_*       (5)
adapters/net     sfn_net_*               (9)
concurrency/serve sfn_serve*             (5)
platform/tls     (no `fn sfn_*` — Sailfin-level API consumed by the above)
```

Grepping those families across all of `runtime/` outside the gate yields
exactly one hit: `runtime/sfn/concurrency/scheduler.sfn:569`, and it is a
**comment** ("Used by `sfn_serve`'s …"). No code edge. The same grep across
`runtime/prelude.sfn` yields nothing.

`memory/secretbuf.sfn` is deliberately left **ungated** despite being
TLS-adjacent: it defines no `sfn_*` symbol and has no in-tree user, so gating
it buys one module and adds a reasoning burden.

### 5.3 A program that genuinely uses TLS still links

Three independent retention paths, any one sufficient:

1. **`![net]` on the program.** `http.get`/`websocket.*`/`serve` require it via
   `intrinsic_effects.sfn`; the effect checker propagates to `fn main`; the
   scan sees it; the gate opens. This is the ordinary path.
2. **`[capabilities] required = ["net"]`** in the project manifest, folded in
   at `dedupe.sfn:332`.
3. **A dependency on `sfn/http` or `sfn/net`**, whose sources declare `![net]`
   (3 files each) and are in the scanned unfiltered set.

The compiler's own build hits path 1 twice over —
`compiler/src/cli/entry.sfn:150` is `fn main(argv: string[]) -> int
![clock, io, net]`, and `cli/commands/toolchain.sfn:31` imports `sfn/crypto`
directly — so `-p compiler` retains the full 34 and the whole crypto capsule
by the demand signal alone. §8 adds a manifest belt-and-braces on top.

### 5.4 The residual hole, named

If a program can reach a `net`-rooted intrinsic **without** any `net` token
appearing in the scanned text, the gate closes wrongly and the link fails. The
only way that happens is an effect-checker gap — a lowering path that emits an
`@sfn_http_*`/`@sfn_serve*` call site whose effect row the collector does not
consult. `collector.sfn:340-362` documents exactly this shape for `serve`:
a *bare Call-form* `serve(...)` that resolves to no user-defined `serve` falls
through to the registry, which yields `["io", "net"]`. Good. But
`runtime_helpers/registry_services.sfn:112-115, 173` notes that "the bespoke
`serve` lowering in `expression_lowering/native/core.sfn` emits the
`@sfn_serve` call site directly (it does not consult this row)."

**Acceptance requires pinning that** with a test that a bare `serve(...)`
program without `![net]` is rejected by `sfn check` (`E0402`). If it is *not*
rejected, that is a pre-existing effect-enforcement hole this design would
convert from "unenforced annotation" into "link break" — and the correct
response is to fix the hole, in this PR or as a named predecessor, not to
un-gate `serve.sfn`. This is the one investigation item that must happen before
implementation starts.

Note also `.claude/rules/compiler-safety.md`'s companion caveat: effect
enforcement is "real on Linux x86_64, partial on macOS arm64 (#613)". The gate
does not *depend* on per-platform enforcement — the demand scan is textual and
platform-independent — but a macOS-only enforcement gap could let a program
compile locally that the gate then fails to link. The scan is the same on both,
so the risk is a *source* that would have been rejected on Linux, which CI
catches.

---

## 6. The link contract must be relaxed — this is the sharpest hazard

**Yes, narrowing breaks `missing_runtime_dep_specs`, and it breaks it into a
hard build failure.** This is the single most likely way to land this change and
have every hello-world build stop working.

`missing_runtime_dep_specs` (`compiler/src/build/link_contract.sfn:40-67`)
iterates `runtime_capsules[ci].capsule_deps` — the raw manifest declaration —
and requires each to have contributed a path to `ll_paths`:

```
                    let needle = capsule_artifact_ir_dir(parts.scope, parts.name) + "/";
                    if !_lc_ll_paths_cover(ll_paths, needle) {
                        missing.push(spec);
                    }
```

Once C1 stops seeding `tls.sfn`'s edges, `sfn/crypto` is unreachable, the
SFN-833 filter drops all 33 modules, `build/capsules/sfn/crypto/ir/` contributes
nothing to `ll_paths`, and this preflight prints
`link-contract: the runtime capsule declares 1 [dependencies] entry with no
compiled module reaching the link: sfn/crypto` and returns
`_failed_link_result()`. Every gated build fails before the backend runs.

**The fix, in the same PR:** the contract's real content is "a resolver pass
that *dropped* a needed dep is caught." A dep no selected runtime source
imports was never needed. So the predicate becomes conditional on demand:

```
fn missing_runtime_dep_specs(runtime_capsules, ll_paths, demanded_specs: string[]) -> string[]
```

where `demanded_specs` is the set of scoped-import specs appearing in the
**selected** `sfn_sources` — computed by the same helper C2 uses in §4.5, so the
staging decision and the contract decision are one function and cannot diverge.
A spec in `capsule_deps` but not in `demanded_specs` is skipped, exactly as an
unsafe-shaped spec already is (`:36-39`). A spec in both must still cover.

**Ordering.** The preflight runs at `link.sfn:273`, *before*
`assemble_runtime_capsule_link_inputs` at `:278`. Since selection now happens at
the *call site* (§4.4), `runtime_capsules` arriving at `_clang_link_multi_with_opt`
is already narrowed and both lines see the same list — no hoisting needed. The
twin call at `cli/commands/test/link.sfn:116` needs the identical treatment;
its `runtime_caps` comes from `runtime_capsule_from_root(runtime_root)` at
`:89` and must be narrowed there.

Update the module header at `link_contract.sfn:5-23`, which currently asserts
"the runtime's `sfn-sources` land in every binary" — that premise is what this
change retires.

---

## 7. Files affected

| Stage | File (line anchors) | Change |
|---|---|---|
| Manifest | `runtime/capsule.toml` (append after `:107-108`) | New last-in-file `[sfn-source-gates]` with the `net` list. **Must be last** — §4.2. |
| Manifest | `compiler/capsule.toml` `[build]` | `full-runtime = true` (§8). Comment on its own line — `toml_get_string` returns the raw remainder after `=`. |
| Manifest schema | `compiler/src/toml_parser.sfn` (beside `toml_get_sfn_sources:503`) | `toml_get_sfn_source_gate(text, effect) -> string[]`, body delegating to `toml_get_string_array(text, "sfn-source-gates", effect)`; and `toml_get_build_full_runtime(text) -> boolean` beside `toml_get_build_implicit`. Export both. |
| Runtime resolver | `compiler/src/runtime_capsule_resolver.sfn:63-78, 503-511` | `RuntimeCapsuleArtifacts` gains `sfn_source_gates: string[]`, resolved to absolute paths through `_rcr_resolve_paths` at parse time. Update every construction site. |
| Scanner | `compiler/src/capsule_import_scan.sfn` (beside `:339`) | `collect_effect_tokens(source) -> string[]`; raw scan, 128-byte window after `![`. Export. |
| **New** selector | `compiler/src/build/runtime_selection.sfn` | `compute_runtime_demand`, `select_runtime_sfn_sources`, `runtime_demanded_dep_specs`, the env toggles. ~200 lines. |
| Resolver (C1) | `compiler/src/capsule_resolver/reachability.sfn:372-411, 436-444, 589-601` | `_cr_seed_runtime_roots` takes `demand` and iterates the selected list; `_cr_filter_reachable_sources` computes the demand set before seeding; `_cr_resolve_dedupe_filtered` returns it. |
| Resolver types | `compiler/src/capsule_resolver/dedupe.sfn:56, 181, 485, 520, 605`; `capsule_resolver/types.sfn:256, 282`; `capsule_resolver/{check,mod}.sfn` (the ~12 `capabilities_required:` sites) | Add `runtime_demand: string[]` alongside, threaded verbatim. |
| Link contract | `compiler/src/build/link_contract.sfn:5-23, 40-67` | Third parameter `demanded_specs`; skip undemanded specs; rewrite the header premise. |
| Link (C2/C3) | `compiler/src/build/runtime_objs.sfn:1397-1435` | Dep-capsule staging loop gated on "a selected source scoped-imports this spec." `:1613-1632` and `:1661-1663` need **no logic change** (narrowed list arrives); `_condition_runtime_capsules` must carry the new field. |
| Call site | `compiler/src/cli/commands/build.sfn:522-527, 553` | Apply `select_runtime_sfn_sources` to `build_runtime_caps`. |
| Call site | `compiler/src/cli/commands/run.sfn:173-183` | Same for `run_runtime_caps`. |
| Call site | `compiler/src/cli/commands/test/link.sfn:89, 116, 125` | Same for `runtime_caps`; thread `runtime_demand` from the caller's resolution and into `missing_runtime_dep_specs`. |
| Tests | new `compiler/tests/e2e/runtime_demand_driven_sources_test.sfn` | §10.3. |
| Tests | new `compiler/tests/unit/runtime_source_gates_test.sfn` | §10.2 invariants. |
| Tests | `compiler/tests/e2e/runtime_sfn_sources_link_consumer_test.sfn` | §10.1 — audit, likely a fixture manifest addition, not an assertion change. |
| Docs | `docs/status.md` (beside `:336-359`) | Row describing demand-driven runtime selection, the gate table, and both env toggles. |
| Docs | `site/src/content/docs/docs/advanced/capsules.md` | `[sfn-source-gates]` row in the runtime-capsule field table. |
| RCA | `docs/rca/2026-08-13-…-retain-roots.md` tracked-work table | Add the row; SFN-860 §10.3 already flags it as issue-less. |

Not touched, deliberately: `compiler/src/capsule_resolver/discovery.sfn:414-453`
(the dep union stays — it is cheap directory discovery; the *filter* is what
removes the modules), `compiler/src/build/link.sfn`'s flag block (that is
SFN-860's territory), and any file under `runtime/sfn/`.

---

## 8. Self-hosting and the seed call

**This bundles. One PR, no `seed-blocker` predecessor, no seed cut.** Citing
`.claude/rules/seed-dependency.md`.

### 8.1 The carve-out does not apply

The rule's one structural exception is "a capability consumed by *runtime*
source" — a new builtin or intrinsic that runtime source **calls**, which must
be in the seed because the pinned seed compiles the working-tree runtime.
This change adds **no compiler capability and touches no runtime source**. Not
one line under `runtime/sfn/` changes; `runtime/capsule.toml` gains *data*, and
the seed's TOML parser reads that data with no new primitive. The default rule
therefore governs: bundle.

### 8.2 What actually happens during `make compile` — the question in full

`make compile` is `<pinned seed 0.9.5> build -p compiler`. The seed is the
process that (i) parses `runtime/capsule.toml`, (ii) runs `_cr_seed_runtime_roots`,
(iii) runs `_compile_runtime_sfn_sources`, and (iv) spawns `self_path emit`
children — where `self_path` is **itself**. So during `make compile`, a checkout
carrying this change **does not get the narrower closure.** The seed knows
nothing of `[sfn-source-gates]`, so:

- `toml_get_string_array` on a section the seed never queries is simply never
  called. There is no unknown-key or unknown-section validation anywhere in
  `compiler/src/toml_parser.sfn`.
- `toml_get_sfn_sources` (`:503`) still returns all 34, because the new section
  is **after** `[dependencies]` and cannot truncate `[build]`'s scan (§4.2).
- The seed compiles all 34 runtime sources plus the full crypto capsule, links
  `build/bin/sfn`, and every `nm build/bin/sfn` assertion holds unchanged.

**This is the desired outcome, not a limitation.** The compiler binary is the
one artifact that should carry the whole runtime surface.

**Where the fix is effective on merge:** everything the *freshly built* compiler
then builds — the 1,285 nested `sfn build`/`run`/`test` spawn sites across 308
of 325 e2e files, `make check`'s suite, and every user build. That is the entire
CI regression surface. The win lands at merge, before any re-pin.

### 8.3 The post-pin transition — the part that must not be missed

After the next cadence seed pin, `make compile`'s runtime compile *is* performed
by a seed that understands the gates. At that moment the compiler's own build
must still retain everything, or the six `nm build/bin/sfn` migration tests
(SFN-860 §2.4: `runtime_sfn_sources_active_test.sfn:109-134`,
`runtime_type_meta_test.sfn:228-237`,
`runtime_adapter_filesystem_test.sfn:268-275`,
`runtime_string_basic_test.sfn:204-210`,
`runtime_string_utf8_numeric_test.sfn:159-160`,
`runtime_string_allocating_test.sfn:155-156`) change behaviour under a seed bump
that touched no source.

Two guarantees, both required, both landing in **this** PR:

1. **Demand-derived.** `compiler/src/cli/entry.sfn:150` declares
   `fn main(argv: string[]) -> int ![clock, io, net]`, and 17 compiler source
   files carry a `net` effect list. The scan finds `net`; the gate opens.
2. **Manifest belt-and-braces.** `compiler/capsule.toml` `[build]` gains
   `full-runtime = true`, which forces `demand = ["*"]`. This must land in the
   same PR as the selector, so the post-pin `make compile` is a no-op by
   construction and does not rest on guarantee 1 continuing to hold if
   `entry.sfn`'s signature is ever narrowed.

None of the six migration tests assert a `sfn_tls_*`/`sfn_http_*`/`sfn_net_*`
symbol, so even guarantee 1 alone would suffice — but a size/symbol invariant
that changes on a seed bump is exactly the class of surprise the pin cadence
should never produce, and a manifest key costs three lines.

**Convergence note.** If SFN-860 lands first it introduces
`[build] retain-runtime-symbols = true` on the same manifest with the same
meaning ("this artifact is the runtime provider surface"). Whichever lands
second should collapse the two into one key rather than shipping both. This
note does not depend on SFN-860 in either direction; `full-runtime` is
self-contained.

### 8.4 `sfn selfhost` and the fixed point

`compiler/src/cli_selfhost.sfn:321` shells `build --no-cache -p compiler` for
stage2 and stage3. Both carry `full-runtime = true`, both retain all 34, both
compile the full crypto capsule, and the stage2/stage3 `.ll` hash-diff compares
identical module sets. **The fixed point is unaffected.** `--check-determinism`
likewise: the compiler's own artifact set does not change under this design in
either the pre- or post-pin world.

### 8.5 Independence from SFN-834

**Independent, and this is one PR.** SFN-834 (re-export name narrowing) exists
because a bare `import … from "sfn/crypto"` resolves to the barrel and the
barrel re-exports its whole surface, so the SFN-833 filter retains all 33
(`docs/status.md:345-367`). This design removes the *importer* rather than
narrowing the *import*: with `tls.sfn` unselected, no seeded root names
`sfn/crypto` at all, `_cr_reach_edge_slugs_for_text` never produces the
`sfn/crypto/mod` edge, and the existing filter drops all 33 with the machinery
already merged in 2ca8b18. SFN-834 remains valuable for a build that *does*
demand `net` (it would narrow crypto's 33 to the subset TLS 1.3 actually uses)
and for user capsules generally — but nothing here waits on it.

---

## 9. Expected win — and what it is not

### 9.1 Module counts

| | today | after | note |
|---|---|---|---|
| runtime `sfn-sources` compiled | 34 | **26** | 8 gated on `net` |
| `.sfn-asm` in `rt-import-context` | 69 | **~28** | 26 runtime + 2 platform externs + 0 crypto |
| crypto capsule modules in `build/capsules/sfn/crypto/ir/` | 33 | **0** | C1 |
| `.layout-manifest` | 34 | **~1** | follows the capsule closure |
| link objects | 35 | **~27** | |

Pre-regression baseline was 33 staged modules. This lands at ~28 — **below**
the pre-regression tree, because the pre-regression tree also compiled all 33
runtime sources unconditionally.

### 9.2 Wall time — estimate, with the honest caveats

Cold `sfn run examples/basics/hello-world.sfn`: **58.99 s → an estimated
11–15 s** (~4x). The crypto capsule's 33 modules are removed from *both*
pipelines — the native staging emit and the full LLVM emit + `.layout-manifest`
+ `clang -c` — and those files (`bignum`, `p384`, `rsa`, `x509`, `aes`) are the
largest in the set. I am **not** claiming the pre-regression 11.96 s exactly;
26 runtime modules still compile, and the `-O2` `clang` and `llvm-link` legs are
unchanged.

Three caveats that make the realised win smaller than a naive 69→28 ratio:

1. **Warm builds win less.** The runtime `.o` and `.sfn-asm` caches are
   content-addressed with a shared store (SFN-861, `runtime_objs.sfn:242-264`).
   A warm work-dir already skips the emits; what it still pays is the
   *hashing and cache probing* of 69 entries, plus the crypto capsule's
   `assemble_link_inputs` and link. The headline number is a cold build.
2. **The pooled `sfn test` path is partly pre-amortised.** `test/link.sfn:70-78`
   warms the runtime once per invocation into `SAILFIN_TEST_RUNTIME_OBJDIR` and
   every child cache-hits, so the runtime-object half of the win is already
   amortised across a pooled run. The **capsule-closure** half (C1) is not: each
   nested build in its own `SAILFIN_TEST_SCRATCH` recompiles crypto's 33
   modules into its own `build/capsules/`. That is where the e2e 2.45x came
   from and where it goes.
3. **The measured 58.99 s was not attributed between C1 and C2/C3 on this
   machine.** Do that attribution first (§10.4) — if C1 turns out to be ≥70% of
   it, a narrower change is available and this note's scope could shrink.

### 9.3 What this does not do

- **Binary size.** The gated modules were already dead-strippable; they are
  retained today only by `_runtime_retain_root_flags`. That is SFN-860. This
  change removes them from the link line, which helps, but the ~300 KB of
  retained crypto is a *root-policy* number, not a *selection* number.
- **The compiler's own build.** By design, `-p compiler` retains everything.
  `make compile` gets no faster.
- **The `sfn check` path.** Unchanged by construction.

---

## 10. Test plan

Per `.claude/rules/no-bash-e2e.md`: Sailfin `*_test.sfn` only, driving `_sfn_bin()`
(never a seed path — during the pre-pin window the seed applies no gates),
`clean_runner_env(nested_runner_scratch("<label>"))` for every nested runner,
and `SAILFIN_TEST_SCRATCH` + `PATH` threaded so concurrent builds do not
overwrite `program.ll`.

### 10.1 Existing tests to audit

- **`compiler/tests/e2e/runtime_sfn_sources_link_consumer_test.sfn`** — the
  named regression test for the `sfn-sources` list. It builds a consumer
  against a relocated runtime and asserts the canonical `%Timespec*` staging
  form and the linked symbol set. If its fixture program declares no `![net]`,
  the gated modules stop being compiled for it. Expect **no assertion change**
  (nothing it checks is in the gate), but it must be run early and read
  carefully; if it does assert a `sfn_net_*`/`sfn_socket_*` symbol, add
  `![net]` to the fixture rather than un-gating.
- **The six `nm build/bin/sfn` migration tests** (§8.3) — zero changes; the
  compiler opts in. Add a one-line pointer comment in
  `runtime_sfn_sources_active_test.sfn` naming `[build] full-runtime`, so a
  future reader knows why this binary keeps a family ordinary binaries do not.
- **`compiler/tests/e2e/capsule_reachability_filter_test.sfn`** — should now
  observe a *larger* drop set on any fixture that does not demand `net`. Verify
  its assertions are stated as "these specific slugs absent", not "exactly N
  retained".
- **`compiler/tests/e2e/runtime_tls_anchor_cache_test.sfn`,
  `runtime_tls_verify_failure_test.sfn`, `runtime_adapter_http_test.sfn`,
  `runtime_http_chunked_decode_test.sfn`** — the end-to-end backstop for
  "a program that genuinely uses TLS still links and runs." All four must pass
  untouched. If one of their fixtures links today without declaring `![net]`,
  that fixture is evidence for §5.4 and must be triaged, not patched.
- **`compiler/tests/e2e/workspace_capability_gate_test.sfn`,
  `check_effect_try_block_escape_test.sfn`** — both reference `http.get`; they
  exercise the effect-enforcement path the gate now depends on.

### 10.2 New unit: `compiler/tests/unit/runtime_source_gates_test.sfn`

Pure invariants over `runtime/capsule.toml`, no build:

1. **Every gate member names a real source.** Each entry under every key of
   `[sfn-source-gates]` either appears in `sfn-sources` or is a known
   conditioning-appended Windows sibling. Catches a rename drift that would
   silently un-gate a module.
2. **Every gate key is a canonical effect.** Cross-checked against
   `canonical_effects()`.
3. **No gate member is imported by the prelude.** Parse
   `runtime/prelude.sfn`'s relative imports and assert disjointness from the
   union of all gate lists — the §4.8 obligation, mechanised.
4. **No ungated source names a gated module's symbol family.** Regex the
   `sfn_tls_|sfn_http_|sfn_websocket_|sfn_net_|sfn_serve|sfn_socket_|sfn_cert_roots`
   families across the ungated sources; the only permitted hit is inside a
   comment. This is the §5.2 audit turned into a standing check, and it is what
   makes adding a gate member safe in future.
5. **`select_runtime_sfn_sources(caps, ["*"])` is the identity** on the real
   manifest, element-for-element.
6. **The manifest section is last.** Assert `toml_get_sfn_sources` on the real
   file still returns 34 — the §4.2 seed-parser footgun, pinned.

### 10.3 New e2e: `compiler/tests/e2e/runtime_demand_driven_sources_test.sfn`

1. **Negative — hello-world emits no crypto.** Build a `fn main() ![io] {
   print("hi"); }` fixture in an isolated scratch. Assert: exit 0; the binary
   runs and prints; `<scratch>/build/capsules/sfn/crypto/ir/` does not exist or
   is empty; `<scratch>/sailfin/rt-import-context/sfn/crypto/` is absent; no
   `sfn__runtime-native__tls.sfn-*.o` in the objdir; `nm` shows zero defined
   `sfn_http_*`/`sfn_tls_record_*`. **This is the primary acceptance gate.**
2. **Module-count ceiling.** Count `.sfn-asm` under the scratch's
   `rt-import-context`; assert `<= 32`. A ceiling, not a band — an exact count
   is a cross-platform flake generator.
3. **Positive — a TLS program still links and runs.** A second fixture whose
   `main` declares `![net]` and calls into the TLS/HTTPS surface (no network
   I/O needed; a call that forces the symbols onto the graph and fails cleanly
   is enough). Assert exit 0 from the build, the binary runs, `nm` shows
   `sfn_tls_record_*` **present**, and `build/capsules/sfn/crypto/ir/` is
   populated. Paired with test 1 this asserts the real property — the one no
   count alone expresses.
4. **Positive via manifest capability.** A third fixture with no `![net]`
   anywhere but `[capabilities] required = ["net"]` in its `capsule.toml`;
   assert the gate opens. Proves path 2 of §5.3 independently.
5. **Ctor / dynamic-reach survival under the narrow set.** Extend fixture 1's
   `main` to exercise `type_of`/`instance_of`, a `try`/`throw` round trip, a
   `spawn`+nursery join, and an `fs.exists` call, and assert the expected
   output. All four reach the runtime by something other than an import edge;
   this pins §5.1 end to end rather than by inference.
6. **Escape hatch.** With `SAILFIN_RUNTIME_SOURCE_GATES=off`, fixture 1
   reproduces today's artifact set — assert `sfn/crypto` is back and the
   `.sfn-asm` count returns to its unfiltered value. The bisect handle, proved.
7. **`serve` effect enforcement.** `sfn check` on a bare `serve(...)` program
   with no `![net]` must emit `E0402`. If this fails, §5.4 is live and
   implementation stops.
8. **Windows conditioning.** Cross-target `--target=x86_64-pc-windows-gnu` on
   fixture 1 (build only, no run): assert the build succeeds and that dropping
   the `net` group did not orphan the `platform_dir` anchor
   (`target.sfn:426-431`) — §4.7.

### 10.4 Measurement, required before and after

Reproduce the RCA's method — same seed, same trivial program, `SAILFIN_RUNTIME_ROOT`
pinned — and record, in the PR body:

```
build/bin/sfn run examples/basics/hello-world.sfn         # cold, timed
find <scratch>/sailfin/rt-import-context -name '*.sfn-asm' | wc -l
ls <scratch>/build/capsules/sfn/crypto/ir/ | wc -l
```

**Also record the attribution** the estimate in §9.2 rests on: run once with C1
disabled and C2/C3 enabled, and once with the reverse, so the split between
"crypto capsule closure" and "runtime staging" is a measured number rather than
this note's inference.

### 10.5 Commands

```
make clean-build                 # structural: new module, new struct field
make compile
build/bin/sfn fmt --write  <every touched .sfn>
build/bin/sfn fmt --check  <every touched .sfn>
build/bin/sfn test compiler/tests/unit/runtime_source_gates_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_demand_driven_sources_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_sfn_sources_link_consumer_test.sfn
build/bin/sfn test compiler/tests/e2e/capsule_reachability_filter_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_tls_anchor_cache_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_adapter_http_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_sfn_sources_active_test.sfn
build/bin/sfn selfhost                # stage2/stage3 fixed point
make check                            # required — resolver + link blast radius
```

---

## 11. Risks

| Risk | Assessment / mitigation |
|---|---|
| **`missing_runtime_dep_specs` fails every gated build** (§6) | Highest-probability way to land this broken. It is a hard `_failed_link_result()` before the backend, on *every* build, so it fails loudly and immediately — but only if the implementer runs a nested build, not `sfn check`. The §6 relaxation is mandatory and must land in the same commit as C1. Two call sites: `link.sfn:273`, `test/link.sfn:116`. |
| **An effect-enforcement gap makes the gate unsound** (§5.4) | The named candidate is the bespoke `serve` lowering in `expression_lowering/native/core.sfn`, which `registry_services.sfn:173` documents as not consulting the effect row. Failure mode is a loud undefined symbol at link, never a silent miscompilation. Test 10.3.7 is a **blocking** acceptance item; if it fails, fix the enforcement hole first. |
| **A gated module reached by a path §5.1 missed** | The enumeration is grounded in the descriptor registry plus a symbol-family grep with exactly one comment-only hit. Test 10.2.4 turns that grep into a standing check so a future edge fails a test rather than a link. Blast radius is wide; the detector is `make check`, already mandated. |
| **New manifest section truncates `[build]` under the pinned seed** | Would break `make compile` outright on the first build — the loudest possible failure. Mitigated by last-in-file placement (§4.2) and pinned by test 10.2.6. |
| **Post-pin `make compile` narrows the compiler's own runtime** | Guarded twice (§8.3): the compiler declares `![net]` in 17 files including `fn main`, *and* `[build] full-runtime = true`. The key must land in this PR, not the pin PR. |
| **`RuntimeCapsuleArtifacts` field addition misses a construction site** | Three sites, one of them (`_condition_runtime_capsules`, `runtime_objs.sfn:1661-1663`) a bare field-list literal that fails to compile if missed — a compile error, not a silent default. Acceptable. |
| **Demand-scan false positives erase the win** | Measured zero on `sfn/crypto`, `sfn/strings`, `sfn/test` — the sets that actually appear in hello-world and e2e test builds. Trace toggle (`SAILFIN_TRACE_RUNTIME_GATES=1`) exists to diagnose a regression in this. |
| **Windows conditioning orphans an anchor** (§4.7) | Anchor set is 9 modules, none gated. Test 10.3.8 covers the cross-target build. |
| **Interaction with SFN-861's shared cache keys** | The gates change *which* modules are compiled, not any module's content key — `runtime_object_cache_key_with_identity` / `runtime_asm_cache_key` are untouched, so a cached artifact from a `net`-demanding build is still valid for a gated one. No cache-key bump needed. Confirm no stale `.o` from a wider build reaches a narrower link: it cannot, because the link consumes freshly-computed object paths (`clean_runtime_object_cache`'s header, `:1820-1827`). |
| **Divergence between the staging decision and the contract decision** | Both derive `demanded_specs` from one function (§6). Do not let them be two. |

---

## 12. Flags — what makes this harder than it looks

Five, in descending order of how much they matter to whoever picks this up.

1. **The link contract is a build-breaking landmine, not a footnote.** §6.
   Every design conversation about this change so far has framed it as "narrow
   the source list"; the *first* thing narrowing does is trip
   `missing_runtime_dep_specs` and refuse to link. Read §6 before writing a
   line. The distinctive feature is that `sfn check` will not catch it — this is
   exactly the #1389 class ("a build-only failure can still pass `check`").

2. **This is not one clean filter, it is one decision with three consumers in
   two phases.** C1 lives in the *resolver*, before emission; C2 and C3 live in
   the *link driver*, after it. The reason the design threads a demand set
   rather than computing reachability where it is needed is that no single
   signal is available in both phases — the precise one (emitted IR symbols)
   does not exist at resolution time, and C1 is where the largest win is.
   Anyone who "simplifies" this by computing demand at the link site will
   recover less than half the regression and will not notice, because the
   module-count assertion in 10.3.2 only counts the staging side.

3. **The win is bigger than 69 → 28 and this note deliberately does not claim
   the whole of it.** The crypto capsule is compiled twice per build — 33
   `.sfn-asm` in `rt-import-context` (counted in the 69) *and* 33 full
   `.ll`+`.layout-manifest`+`.o` under `build/capsules/sfn/crypto/ir/` (not
   counted). Both go. But the 58.99 s has never been attributed between the two
   on this hardware, so §9.2's 11–15 s is an inference, not a measurement.
   §10.4 makes the attribution a required deliverable. If the reviewer wants a
   number they can defend, that measurement is the thing to insist on.

4. **The design rests on an effect-enforcement claim that has one known soft
   spot.** `serve(...)` lowers through a bespoke path that
   `registry_services.sfn:173` says does not consult the registry row. If a
   bare `serve` program compiles today without `![net]`, then gating
   `serve.sfn` converts an unenforced annotation into a link break for real
   users. That is a *correctness* argument for fixing the enforcement gap, but
   it is a *scheduling* risk for this issue: discovering it mid-implementation
   is a pause-and-present moment, not a silent fan-out. Probe it first
   (§10.3.7) — it is a five-minute `sfn check` on a three-line fixture.

5. **Scope creep to resist.** Three invitations, none of which belong here:
   (a) generalising `[sfn-source-gates]` into a full conditional-compilation
   feature system for capsules; (b) narrowing *within* a demanded dep capsule —
   that is SFN-834 and it is genuinely independent (§8.5); (c) unifying
   `full-runtime` with SFN-860's `retain-runtime-symbols` before SFN-860 has
   landed. Take (c) only as a follow-up by whichever issue lands second.

Estimate: **5 points.** The selector itself is small; the cost is the
`runtime_demand` threading through ~14 resolver sites, the link-contract
relaxation with its two call sites, the eight-case e2e, and `make check`
(15–20 min) plus a `selfhost` fixed-point run on the critical path.
