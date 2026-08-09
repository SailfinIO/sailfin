# SFN-341 — Native TLS runtime swap: routing SFEP-0048 Phase D

Implementation design gate (per `.claude/rules/proposals.md`: this routes an
already-Accepted SFEP's remaining phase into deliverable slices — it is not a
new forward-looking design, so no SFEP number). Design record for the chain
that lands SFEP-0048 Phase D.

- **Issues:** SFN-766 (D0, `Done` — unwound by E0), SFN-767 (D1), SFN-768 (D2),
  SFN-769 (D3, **superseded by E0**), SFN-341 (D4)
- **Author:** agent:compiler-architect
- **Status:** design-approved
- **Updated:** 2026-08-07 (amendment: vendoring → capsule dependency edge)
- **Parent SFEP:** SFEP-0048 (`../0048-native-crypto.md`, Accepted) — this note
  routes its Phase D; it does not amend the SFEP's design.
- **Depends on pinned seed:** **yes** — one `seed-blocker` predecessor (E0,
  §3.1.1/§5). This replaces the original "nothing new in the expected path."

> **Amendment, 2026-08-07.** §3.1, §3.7, §5, §6, §7 and §8 are rewritten. The
> original note routed the cold path through **vendoring** ~20 modules /
> 10,146 lines of `capsules/sfn/crypto/src/` into `runtime/sfn/crypto/` behind
> a source-hash drift gate (SFN-769). That route is now **rejected** (§6) and
> replaced by a real `[dependencies]` edge from `runtime/capsule.toml` to
> `sfn/crypto` (§3.1). The reversal rests on three verified findings the
> original §6 never tested, because it evaluated the *`sfn-sources` hack* and
> generalised from it to every form of dependency:
>
> 1. **Vendoring does not save the compile — it duplicates it.**
>    `compiler/capsule.toml:59` already declares `"sfn/crypto" = "*"`, and
>    `_cr_collect_capsule_sources` (`capsule_resolver/discovery.sfn:230+`)
>    walks a declared dep's **entire** `src_dir` with no import-reachability
>    filter. Every module of `capsules/sfn/crypto/src/` is therefore already
>    compiled and re-emitted on every `make compile`. Vendoring pays for it a
>    *second* time — that is the original §3.1's "+8-12% self-host" number, and
>    it buys nothing.
> 2. **The "linked twice" objection was an artifact of vendoring, not of
>    dependency.** Discovery dedups on a spec-keyed `visited` set at dequeue
>    (`discovery.sfn:466-468`) and again at transitive enqueue (`:549-550`);
>    `dedupe.sfn:364-404` dedups a second time on `(slug, source_path)` and
>    hard-errors only on a genuine collision. The duplicate the original note
>    feared exists *only* because vendoring creates a second, unmangled copy
>    alongside the compiler's existing dependency.
> 3. **The `sfn/strings` objection was likewise vendoring-specific.**
>    `capsules/sfn/crypto/capsule.toml:6-10` already declares
>    `"sfn/strings" = "*"`, and `discovery.sfn:542-554` enqueues a dep's own
>    deps transitively. The bare-capsule skip at `runtime_objs.sfn:1192-1204`
>    is specific to runtime `sfn-sources` staging, not to dependency edges.
>
> One objection survives, and it is the price of the new route: the mangling
> bypass at `llvm/lowering/lowering_helpers_mangling.sfn:146-150` must be
> repositioned, and that is a lowering change **runtime source depends on** —
> a forced seed cut under `.claude/rules/seed-dependency.md`'s runtime-consumer
> carve-out (§3.1.1, §5).

## 1. Summary

SFEP-0048 Phase D is recorded as one step: "swap the `tls_*` wrapper bodies
onto the native stack, delete the OpenSSL externs, drop `-lssl`/`-lcrypto`."
That framing was written when Phase B/C were hypothetical. Now that they have
landed, Phase D decomposes into five separable pieces, only one of which is
the swap itself:

1. the **reachability** problem — the native stack is in a `kind = "library"`
   capsule the runtime cannot *yet* import (one lowering pass is skipped for
   runtime modules, §3.1.1), and the runtime links into every binary, so
   whatever it depends on must link into every binary too;
2. the **missing I/O driver** — both handshake state machines and the record
   layer are pure computation; OpenSSL was supplying session allocation,
   record buffering, plaintext framing, handshake defragmentation, alert
   handling, and blocking socket I/O, none of which exists anywhere in-tree;
3. the **peer-authentication gap** — the ClientHello offers only
   `ed25519` in `signature_algorithms` and the CertificateVerify dispatch
   accepts only Ed25519, so the native client cannot complete a handshake with
   any real server, and `parse_certificate` discards intermediates so
   `x509_verify_chain` cannot be driven from handshake state;
4. the **throughput** problem — the record layer is `int[]`-idiom
   (one i64 per byte, bounds-checked, heap-grown), the idiom SFEP-0048 §3.5
   already records collapsing under `-O0`;
5. the **platform** problem — the native stack's server side can sign
   CertificateVerify with Ed25519 only, which narrows `sfn_serve_tls` from
   "any OpenSSL-loadable cert" to "Ed25519 cert."

This SFEP records the route for each and the resulting issue chain. Its
headline conclusions: **depend on the cold path, re-express the hot path**; the
work is **~18 points across four issues**, not three points in one; and the
one-PR property SFEP-0048 §5 requires (swap + link deletion together) survives
— D4 is still a single PR — but it is now **gated behind one seed cut**, not
zero. A capability the runtime *calls* has to be in the seed that compiles the
runtime; that is a structural fact, not a scoping choice (§5).

## 2. Motivation

`runtime/sfn/platform/tls.sfn` is the last OpenSSL consumer in the tree.
`capsules/sfn/crypto/` is confirmed OpenSSL-free (SFN-655);
`runtime/sfn/adapters/websocket.sfn:536-539` re-expressed SHA-1 + base64
natively (SFN-338) and `runtime/sfn/platform/rand.sfn` replaced `RAND_bytes`
(SFN-123). Everything except `tls.sfn`'s 24 externs and the three link-line
edit points is done. SFEP-0016's seal cannot be built while an opaque C TLS
stack issues `connect(2)` the runtime cannot see.

The status quo failure is not "OpenSSL is still linked." It is that the issue
as groomed reads as a body swap, and a body swap is roughly 15% of the work.
Attempting it directly would discover, in order: that the runtime cannot
import a library capsule (and that fixing it is seed-gated); that no runtime
sfn-source has ever used `Result<T, E>` or `match`; that the handshake cannot authenticate any real
peer; that the record layer is ~1000x slower than what it replaces; and that
the server can no longer serve the RSA certificates every existing loopback
e2e generates. Each of those is a stop-and-regroom moment mid-PR.

## 3. Design

### 3.1 Reachability — the dependency edge, and the one compiler change it needs

**Route: declare `"sfn/crypto" = "*"` in `runtime/capsule.toml`'s
`[dependencies]` and `import` it from `runtime/sfn/platform/tls.sfn` like any
other capsule consumer.** No copy, no rename map, no drift gate, one source of
truth. The cold path is `capsules/sfn/crypto/src/` exactly as it stands.

The existence proof that an ordinary consumer edge into this capsule works is
already in the tree: `compiler/capsule.toml:59` declares the dep,
`compiler/src/cli/commands/toolchain.sfn:31` imports `ed25519_verify_utf8` from
`"sfn/crypto"`, and `:340` calls it. Nothing about that path is exotic. What is
new is only that the **runtime** capsule — not a `kind = "binary"` consumer —
is the one declaring it, and the runtime links into every binary.

#### 3.1.1 The one real obstacle: the mangling bypass skips two passes, not one

`apply_module_symbol_mangling`
(`compiler/src/llvm/lowering/lowering_helpers_mangling.sfn:148-150`) returns
early for any module whose slug starts with `runtime/`. The stated rationale is
sound but covers only half of what the early return skips:

- **Step 1** (`:159`) mangles the module's *own* definitions to
  `sym__<module_suffix>`. Runtime modules must keep skipping this: they are
  referenced implicitly, from `runtime/ir/*.ll`, from `extern fn` declarations
  in sibling runtime modules, and from the Windows bridge's stub file. Their
  bare names are a stable ABI. **This is what the comment is defending.**
- **Step 2** (`:189`) rewrites this module's *imported call sites* to the
  provider's mangled symbol, and **2b** (`:319`) does the same for imported
  struct-method references. Neither touches the module's own exported symbols.
  Skipping step 2 is not required by the stable-ABI argument at all — it is
  collateral from the early return sitting above both passes.

Consequence today: an unmangled runtime module physically cannot call a mangled
capsule provider. Its call site stays `@x25519_shared` while the capsule object
defines `@x25519_shared__sfn__crypto__mod`, and the link fails. **That, and
only that, is why the runtime "cannot import a library capsule."**

**The change:** move the `runtime/` early return so it suppresses step 1 (and
the step-1 substitution) while step 2 / 2b still run. Step 2 already does the
right thing for runtime *providers* — `provider_is_runtime` at `:253` keeps
`target_symbol` unmangled, and 2b skips runtime providers outright at `:341` —
so a runtime module importing another runtime module still resolves to the bare
name and the substitution is an identity. Only imports whose provider is a
*capsule* change behaviour.

Two second-order effects of enabling step 2 for ~36 runtime modules that have
never run it, both of which are why E0 is its own PR with a full
`make clean-build` + `make check` behind it:

- **Re-export shims.** Step 2 emits `sym__<this_module_suffix>` forwarding
  shims (`:305-311`) so downstream importers can target this slug. For a
  runtime provider they are dead by construction — every importer of a runtime
  module targets the bare name — and `-ffunction-sections` +
  `--gc-sections` strips them. E0 should suppress shim emission for
  `runtime/`-slugged modules rather than emit-and-strip, but the failure mode
  if it does not is size, not correctness.
- **A new fatal path.** `:290-296` raises `E1001 "import shadows local
  function"` when an imported name collides with a local `define`. Runtime
  modules have never been subject to this check. If any of them shadows, E0
  surfaces it as a hard emit failure. That is a latent bug being found, not a
  regression — but it is discovered at `make clean-build` time, so E0 must run
  one.

**This is the seed-blocker.** `make compile` self-hosts against the binary
pinned by `bootstrap.toml [seed].version`, and *that binary* compiles the
working-tree runtime (`_compile_runtime_sfn_sources`,
`compiler/src/build/runtime_objs.sfn:1278`) and *is* the emit child
(`_prepare_runtime_sfn_object:838` spawns `self_path`, which resolves to the
driving binary). A lowering change that runtime source depends on therefore has
to be in the seed, not merely on `main`. That is the structural carve-out in
`.claude/rules/seed-dependency.md`, verbatim; bundling does not help.

#### 3.1.2 The driver plumbing, and why it is seed-bound too

The same carve-out reasoning applies to the *driver* code that stages and
compiles runtime modules, because the seed executes it. All of the following
must land in E0, before the seed cut:

1. **`dep_specs` on `RuntimeCapsuleArtifacts`**
   (`compiler/src/runtime_capsule_resolver.sfn:62-71`), populated by a
   `toml_get_dependencies` call in `_rcr_artifacts_from_manifest` (`~:431-470`)
   parsed with the existing `_cr_parse_deps` shape. The runtime manifest's
   `[dependencies]` is currently read by nothing.
2. **Import-context staging of the dep closure.** The runtime emit path uses a
   private context root (`_runtime_sfn_ctx_root`, `runtime_objs.sfn:985`), and
   `_stage_runtime_sfn_import_context` (`:1134`) stages only sibling
   `sfn-sources` plus relative platform externs. It must additionally stage
   each resolved dep source at its **canonical spec slug**
   (`sfn/crypto/<stem>`, `sfn/strings/mod`). This needs no new machinery:
   `_stage_one_runtime_sfn_import_context` (`:1010`) takes an arbitrary
   `(src, slug)` pair and its header already records that no
   `.layout-manifest` sidecar is needed on this path — the struct shapes travel
   inside the threaded native text.
3. **`.import-deps` `/mod` fallback.** `_write_runtime_sfn_import_deps`
   (`:1080`) matches `resolve_import_module_slug_for_module`'s output against
   `staged_slugs` by exact equality. A bare `"sfn/crypto"` import resolves to
   slug `sfn/crypto`, but the staged slug is `sfn/crypto/mod`, so the dep is
   silently dropped from the sidecar and the emit loses the provider's
   signatures. Add the `<slug>/mod` fallback that
   `resolve_import_provider_module_name` (`llvm/lowering/lowering_helpers.sfn:384-395`)
   already applies — the two must agree or the sidecar and the mangler
   disagree about who the provider is.
4. **Link scoping** — §3.1.3.
5. **Source availability off-repo** — §3.1.4.

With (2) and (3) in place, the symbol path is the ordinary one: the runtime
module's `.import "sfn/crypto"` resolves to provider `sfn/crypto/mod`, step 2
rewrites the call to `sym__sfn__crypto__mod`, and `mod.sfn`'s own re-export
shim forwards to the defining module — byte-for-byte what `toolchain.sfn`
already does.

#### 3.1.3 Link scoping — the open problem, and its resolution

An ordinary capsule dep is linked only into a binary whose own manifest
declares it: `cli/commands/build.sfn:455-462` folds `capsule_result.ll_paths`
into `all_lls`. The runtime's `sfn-sources`, by contrast, reach **every** binary
via the unconditional fallback at `build.sfn:470-472`. Since
`runtime/sfn/platform/tls.sfn` is an `sfn-source` and constraint (a) below keeps
it one, its calls into `sfn/crypto` are emitted into every binary — and
`--gc-sections` runs *after* symbol resolution, so a hello-world that never
mentions TLS still fails to link unless the crypto definitions are present.

**Decision: union the runtime capsule's dependency closure into the project's
resolved capsule source set, at resolution time.** Concretely,
`enumerate_capsule_sources` (`capsule_resolver/discovery.sfn:~360`) already
calls `enumerate_runtime_capsule_artifacts` to build `runtime_cap_names`
(`:393-417`); once (1) above lands, the same call yields each runtime capsule's
`dep_specs`. Append them to the resolution worklist **after** the project's own
seeds and marked non-direct (`queue_direct = false`), so a project that pins its
own `sfn/crypto` version wins the `visited` race and no spurious "absent from
capsule.lock" hint fires for a dep the user never named.

Why this placement and not the two alternatives:

- **Dedup is free and already proven.** The spec-keyed `visited` set
  (`discovery.sfn:466-468`) collapses the runtime's `sfn/crypto` against the
  compiler's declared one; `dedupe.sfn:364-404` then dedups on
  `(slug, source_path)` and drops exact duplicates silently. The compiler's own
  self-host is therefore **bit-identical** to today: same slugs, same paths,
  same `.ll`s, one compile.
- **Every consumer inherits it at once.** `sfn build`, `sfn run`, and `sfn
  test`'s link path all reach the same `_cr_resolve_and_dedupe`. Assembling the
  dep set at the *link* layer instead would have to be done three times.
- **The rejected alternative — compiling the runtime's deps inside
  `assemble_runtime_capsule_link_inputs` (`runtime_objs.sfn:1444`) alongside
  `sfn-sources`** — is unworkable, and the reason is worth recording: the
  compiler declares `sfn/crypto` itself, so its `.ll`s would arrive via
  `capsule_lls` *and* its `.o`s via the runtime path, both carrying the same
  `__sfn__crypto__*` mangled definitions. That is a hard duplicate-symbol link
  failure, and the link layer does not have the project's dep set available on
  the `sfn test` path to subtract it.

**Gating.** The injection is opt-in per consumer via a new `runtime_root` field
on `ResolverConsumer` (`capsule_resolver/types.sfn:79-84`) — the same shape as
the existing `include_host_as_dep` opt-in. Build / run / test-link set it;
`prepare_project_capsules_for_check` leaves it empty, so `sfn check` on a user
file does not stage 28 crypto/strings modules it has no use for. This does not
widen the `sfn check`-vs-build divergence (#1389): no user-source symbol
resolution depends on the runtime's private deps, only the link does.

**Consequences, stated plainly.**

- **Binary size for a non-TLS hello-world.** `--gc-sections` still strips the
  code: every crypto function is unreferenced once `http.sfn`'s TLS path is
  dead, and `-ffunction-sections -fdata-sections`
  (`build/clang_argv.sfn:53-54`) makes that per-function. What it cannot strip
  is the constructor floor: `type_descriptors.sfn` emits one
  `@__sfn_module_type_init__<module>` per module with named types, wired into
  `@llvm.global_ctors`, and ctors are GC roots. The floor is therefore **one
  ctor plus that module's `linkonce_odr` descriptor + name globals for each of
  the 27 `sfn/crypto` modules and `sfn/strings`** — a few KB and ~N
  `sfn_type_register` calls before `main`. This floor is *not* specific to the
  dependency route: the vendoring route paid the same thing (the original
  §3.1 measured 11 ctors + 29 descriptors for its smaller 20-module subset).
  It is also **not permanent**: it is a direct consequence of
  `_cr_collect_capsule_sources` walking a dep's whole `src/` with no
  import-reachability filter. Adding that filter shrinks this floor to the
  actually-reached modules *and* speeds every build in the tree, including the
  compiler's own self-host. It is the obvious follow-on (§10).
  **D4's acceptance must report a measured hello-world size delta**, not an
  estimate.
- **Cold-build latency for a first hello-world.** A bare `sfn build hello.sfn`
  currently short-circuits before any capsule staging (`mod.sfn:275-288`
  returns early on `resolved.sources.length == 0`). With crypto injected, a
  *cold* first build compiles 28 extra modules. The mitigation already exists
  and needs no new code path: the module cache key
  (`build_cache.sfn:1262-1267`) folds source, dep manifests, compiler identity,
  flags, slug and target — nothing project-specific — so the shared
  content-addressed tier (#1096) serves every subsequent project on the host,
  and `sfn toolchain install` can seed it at install time. D4's acceptance must
  report cold and warm hello-world wall time; if the cold number is
  unacceptable, install-time cache seeding is the fix, not abandoning the route.
- **Symbol collision and ABI stability.** None. Crypto reaches every binary
  under its *mangled* names (`__sfn__crypto__<module>`), which is exactly the
  namespace the scheme exists to keep collision-free; the flat unmangled
  runtime namespace — and its 13 collision instances under vendoring — is never
  entered. Nothing in the crypto capsule is referenced implicitly or by bare
  name, so it acquires no ABI obligations. The one shared surface is
  `sfn_type_register`, which already coalesces `linkonce_odr` descriptors
  across modules by design.
- **Does this make `sfn/crypto` a second privileged capsule?** No — the
  mechanism privileges *the runtime capsule's dependency closure*, whatever it
  contains, which is the same status its `sfn-sources` and `link-libs` already
  have. `sfn/crypto` is simply the first entry. That is the right generality:
  the alternative (a hardcoded allowlist, or a bespoke `runtime-deps` key) is
  the same privilege with more surface and less honesty. The invariant to write
  down and enforce in review is: **adding a `[dependencies]` entry to
  `runtime/capsule.toml` is a size-floor and supply-chain decision on every
  Sailfin binary ever produced, reviewed with the same weight as adding an
  `sfn-source`.** A narrower mechanism only becomes worth building if the
  runtime's dep closure grows past one or two entries — see §10.

#### 3.1.4 Source availability off-repo

`_cr_locate_capsule_src` (`discovery.sfn:131-170`) resolves a spec from
`<project_root>/capsules/<scope>/<name>/src` or from
`~/.sfn/cache/.../<version>/src`. Neither finds `sfn/crypto` for a user
building against an **installed** toolchain: their `project_root` is their own
project, and `"*"` is not a cacheable version. The installer bundles
`runtime/capsule.toml`, `runtime/prelude.sfn`, `runtime/sfn/**` and the staged
import-context (`cli/commands/package.sfn:344-417`) — but no `capsules/` tree.

So E0 must also:

- **Stage the runtime's dep closure into the installer** — `cp -R
  capsules/sfn/crypto` and `capsules/sfn/strings` into
  `<staging>/capsules/<scope>/<name>/`, as a hard error like the
  `runtime/sfn` copy, not a soft skip. Cost: ~12.2k lines of source in the
  tarball, alongside the runtime sources it already ships.
- **Add one locator leg**: resolve a spec that arrived from a runtime capsule's
  `[dependencies]` against `<runtime_manifest_dir>/../capsules/<scope>/<name>/src`,
  with `capsule_origin_workspace()` trust (it ships with the toolchain, same
  provenance as the runtime itself). One path shape covers both layouts: in-repo
  `runtime/` → `../capsules/` is `<root>/capsules/`, and in-install
  `<prefix>/runtime/` → `<prefix>/capsules/`.

Note what this is *not*: it is source distribution, not a fork. One canonical
copy, canonical layout, no rename map, no `.srchash` gate, and `sfn fmt` /
`sfn test` continue to treat `capsules/sfn/crypto/` as the single tested source
of truth.

#### 3.1.5 What does NOT change

**(a) The `tls_*` definitions must be in the runtime link set.** Unchanged, and
still the reason `runtime/sfn/platform/tls.sfn` stays an `sfn-source`.
`adapters/http.sfn:111-121`, `concurrency/serve.sfn:184-192`, and
`adapters/websocket.sfn:120-130` reach the eight wrappers by `extern fn`
forward declaration; those references are emitted into every binary, and
`--gc-sections` runs after symbol resolution, so a referenced-but-undefined
`@tls_client_ctx` is a link error even in a hello-world — the mechanism
`compiler/src/build/target.sfn:178-189` documents for `ws2_32` under SFN-649.
§3.1.3's link scoping is what satisfies this constraint for the *crypto*
definitions; it does not relax it for the `tls_*` definitions themselves.

**The eight `extern fn tls_*` declarations stay `extern fn` for now.** Once
step 2 runs for runtime modules they *could* become ordinary imports — and,
usefully, they would stay correct on Windows, because step 2 keeps a runtime
provider's symbol unmangled (`:253`), so `@tls_client_ctx` still binds to
`runtime/ir/windows_stubs.ll:85-101`'s stub. But the externs are not load-bearing
for mangling; they are load-bearing for the **Windows cross-build's
standalone per-module emit**. `make ci-cross-windows` re-emits each runtime
module with no private import-context of its own, reading signatures from the
shared `build/compiler/import-context/` tree — which is why the Makefile
hand-stages `platform/posix` and `memory/ownedbuf` there (`Makefile:1046-1096`).
`platform/tls.sfn` is excluded from that build's `RUNTIME_MODS`, so its
`.sfn-asm` is never staged, and converting `http.sfn`'s externs to imports
would require a third hand-staged block. Converting them is therefore a
**separate, later, optional** change that belongs with retiring the bridge, not
with E0 or D4 — and constraint (a) does *not* dissolve with it.

**(b) Pointing `sfn-sources` at `../capsules/sfn/crypto/src/*.sfn` is still
dead** — but note carefully that its three failure modes are properties of that
**hack**, and of vendoring, and **none of them applies to a `[dependencies]`
edge**:

| Objection | Applies to `sfn-sources` hack | Applies to a dep edge |
|---|---|---|
| Slug derivation falls through to `module_name_from_path`, reintroducing SFN-146's duplicate `sfn_type_register` (`runtime_objs.sfn:163-172`, warned at `runtime_capsule_resolver.sfn:441-447`) | **yes** | **no** — `_runtime_module_slug` is only consulted for runtime `sfn-sources`; a dep's slug comes from `_cr_collect_capsule_sources` |
| `der.sfn:7` / `x509.sfn:8` import `sfn/strings` as a bare capsule spec, skipped by runtime staging (`runtime_objs.sfn:1192-1204`) | **yes** | **no** — `capsules/sfn/crypto/capsule.toml:6-10` declares it and `discovery.sfn:542-554` enqueues a dep's own deps transitively |
| The same files compiled twice into any binary linking both the runtime and `sfn/crypto` | **yes** | **no** — deduped at `discovery.sfn:466-468` / `:549-550` and again on `(slug, source_path)` at `dedupe.sfn:364-404` |

The skip at `discovery.sfn:464-466` (`if contains_string(runtime_cap_names, spec) { continue; }`) is
sometimes read as blocking this route. It does not: it skips the *runtime
capsule itself* as a dep spec, because `enumerate_runtime_capsule_artifacts`
owns it. It says nothing about the runtime's own deps and needs **no change**.

**Costs, stated plainly.** Runtime `sfn-sources` goes 36 → 31 modules: E0
**unwinds** SFN-766's five vendored modules (`runtime/sfn/crypto/{bits,
chacha20, poly1305, aead_chacha20poly1305, tls13_record}.sfn`, 948 lines,
`runtime/capsule.toml:60-64`). Verified: nothing outside `runtime/sfn/crypto/`
references any of them — they are a closed island paying a per-module emit on
every `make compile` and a ctor floor in every binary, for no consumer. Removing
them is a small, immediate self-host win, and the only build-time cost the new
route adds is the emit of the runtime's own dep closure into the *runtime*
import context (`.sfn-asm` only, content-keyed, ~28 modules, cached across
builds). The crypto `.ll` compile itself is not new work — it is the work the
compiler already does today.

#### 3.1.6 Enforcing the union at the link boundary

§3.1.3 put the union at the *resolver* layer, which is correct and stays.
But a union computed by the resolver only protects links whose caller
actually ran the resolver, and nothing required that. The gap was not
theoretical: `tensor_ir_link_harness.sfn` linked a real binary through
`_clang_link_multi` without ever calling a `prepare_project_capsules*`
facade, and `tensor_matmul_exec_test` failed at both matmul sizes with ~20
unresolved `__sfn__crypto__*` symbols referenced from `tls.sfn`'s object.

**Link-layer commonality is not the guarantee.** The obvious reading — route
every link through one function and the invariant follows — is wrong, and the
harness is the proof: it already shared `_clang_link_multi` with `build` and
`run`. The resolver is a separate, *skippable prerequisite*, not a parameter
the shared function derives. Collapsing dispatchers would not have closed it.

**Nor can the link derive the union itself.** `_clang_link_multi_with_opt`
could call `enumerate_capsule_sources("", runtime_root)`, but only with an
empty `ResolverConsumer`, so `capsule_artifact_layout_from_specs` would route
the resulting `.ll`s differently from the ones `build.sfn` already resolved:
two paths, one set of `__sfn__crypto__*` definitions, a duplicate-symbol link
failure. It also cannot subtract the project's set, because on the `sfn test`
path it never receives one. This is §3.1.3's rejected alternative in a new
shape.

**What the link can do is verify.** Every dispatcher already holds both halves:
`RuntimeCapsuleArtifacts.capsule_deps` is the obligation, the resolved
`ll_paths` are the discharge, and rule 1 of `ir_path_for_slug` maps between
them deterministically. `missing_runtime_dep_specs`
(`compiler/src/build/link_contract.sfn`) reports any declared spec with no
compiled module in the link, and both dispatchers refuse pre-backend on a
non-empty result. This needs no threading through `build`/`run`/`test`, and it
checks the invariant rather than a claim about it — a "the resolver ran" flag
would have read true through both resolver regressions that landed during this
work, each of which ran the resolver and still dropped capsule sources.

Deliberate asymmetry: a spec that is not safe `<scope>/<name>` form is
skipped. Rule 1 only routes that shape, so failing a link over any other shape
would be a false positive on a path the layout never produced. The needle is
derived from `capsule_artifact_ir_dir`, not a copied literal, and matched by
substring so absolute `ll_paths` still resolve. The residual risk is a false
*positive*, from a dep reaching the link via a leg tagged `spec = ""` that
routes through rule 2/3; it did not fire on any path exercised here, and that
is the direction to look first if the contract ever refuses a healthy link.

**This is not type safety, and should not be described as such.** Sailfin has
no field-level privacy (`spec/02-modules.md`), `emit_struct` emits a `.struct`
record for every struct with no export filter, and imports resolve
closure-globally by name. A `LinkClosure` value constructible only by the
resolver would be a naming convention, not a proof. The ceiling is a
fail-closed runtime precondition plus a static census, and the code says so.

**Two guards, neither sufficient alone.** The contract catches a link *caller*
that assembled an incomplete plan — the harness failure mode — at link time.
`link_dispatch_census_test.sfn` catches a third link *implementation* added
without consulting the contract, at test time, by enumerating `compiler/src`
for `backend.link(` rather than carrying a list. A hardcoded list cannot catch
an unknown dispatcher, which is the whole threat model;
`capsule_resolver_line_budget_test.sfn` demonstrates the failure today by
guarding 12 of 15 modules while passing.

**Deferred, with reasons.** Collapsing `_clang_link_multi_with_opt` and
`_clang_link_test_cmd_with_deps` contributes nothing to this invariant and
carries byte-level link-argv risk (opt level, `test_mode`, dead-strip and
retain-root flags, object order, the runtime object-cache override) guarded by
`direct_link_argv_test` and `backend_link_libs_parity_test`; `link_contract.sfn`
is the shared seam that makes it a smaller job later. Threading
`resolved_specs` through `ProjectCapsuleResult` is superseded by the
path-derived predicate. The import-reachability filter on
`_cr_collect_capsule_sources` remains the right answer to the ctor floor and to
cold-build cost, and remains separate (§10).

**One trap worth recording.** `prepare_runtime_dep_capsules` resolves with no
project entry, and `discover_project_root` substitutes `"."` for an empty start
dir. An ungated call therefore probes the *process CWD*, and any directory
holding a `capsule.toml` — the ordinary shape for a user build — would run the
manifest branch against an unrelated project. Both anchored discoveries are
gated on having an entry rather than on `discover_*_root("")` returning empty,
which also keeps the path from bypassing the SFN-352 `bundled_workspace_start`
anchor, the one anchor deliberately independent of the CWD.

### 3.2 The missing I/O driver

Neither handshake state machine nor `tls13_record.sfn` performs socket I/O,
allocates a session, or frames a plaintext record. The following must be
written from scratch in `runtime/sfn/platform/tls.sfn`. Nothing in this list
exists anywhere in-tree today.

**Session object.** Follow the `scheduler.sfn` precedent exactly: a
`malloc`'d, scalar-only Sailfin struct addressed through a typed pointer
(`let s: *TlsSession = handle as *TlsSession`, mirroring
`scheduler.sfn:261,539`). Scalar-only is load-bearing — the malloc'd structs
in `scheduler.sfn:91-99` hold `i64` addresses, never Sailfin `int[]` fields,
whose backing allocation the runtime allocator owns. Layout:

```
fd: i64, role: i64, state: i64,
read_key_addr: i64,  read_iv_addr: i64,  read_seq: i64,
write_key_addr: i64, write_iv_addr: i64, write_seq: i64,
rx_addr: i64, rx_cap: i64, rx_len: i64,        // raw socket bytes
pt_addr: i64, pt_cap: i64, pt_len: i64, pt_off: i64,  // decrypted, undelivered
eof: i64, failed: i64
```

The handshake's `int[]`/struct values live only inside `tls_connect_fd` /
`tls_accept_fd`'s own scope; on reaching `hs_state_connected()` the four
traffic key/IV arrays are copied out into the malloc'd buffers and every
`int[]` goes out of scope. Steady state is therefore pointer-only, which is
also what makes §3.3's hot path expressible.

**Receive-buffer ownership.** `rx_*` holds bytes read from the socket that do
not yet form a complete record; `pt_*` holds decrypted application data not
yet returned to the caller. `tls_read(ssl, buf, n)` drains `pt_*` first and
only touches the socket when it is empty, which is what preserves the
`recv`-identical contract `http.sfn:518-537` and `serve.sfn:470-473` depend
on.

**Plaintext record framing.** `tls13_record.sfn:144-248` handles only the
encrypted `TLSCiphertext` path — `tls13_seal_record` hardcodes
`opaque_type = 23` and `tls13_open_record` rejects anything else. The
cleartext ClientHello/ServerHello exchange and the `change_cipher_spec`
records real servers interleave for middlebox compatibility (RFC 8446 §5.1,
§D.4) have no encoder or decoder. The driver owns both.

**Handshake-message defragmentation.** `hs_client_recv_*` each take one
complete handshake message. On the wire a message may span records and
several messages routinely share one record (a server sends
EncryptedExtensions + Certificate + CertificateVerify + Finished coalesced).
The driver owns a reassembly buffer keyed on the 4-byte handshake header.

**Rekeying.** Three transitions, each = derive key/iv via
`tls13_traffic_key`/`tls13_traffic_iv` (`tls13_handshake.sfn:216-230`) and
reset the direction's sequence number to 0: cleartext → handshake traffic
keys after ServerHello, handshake → application traffic keys after Finished,
per direction.

**Alerts.** Inner content type 21 has no codec anywhere. This is what makes
`tls_read`'s existing classification (`tls.sfn:217-231`) reproducible:
`close_notify` (level warning, description 0) → return 0; any fatal alert →
-1; a `recv` timeout or reset with no alert → -1. Preserving the
timeout-is-not-EOF distinction that comment calls out is a correctness
requirement, not a nicety — collapsing it reports a truncated body as a clean
EOF.

**Trust-store caching — a new requirement OpenSSL did not have.**
`trust_store_load()` base64-decodes and `x509_parse`es the entire system
bundle (~150 anchors). `http.sfn:907,1197` calls `tls_client_ctx()` **per
request**. OpenSSL loads anchors lazily by subject hash; the native store does
not. The driver must build the `TrustStore` once into a process-global
(`extern var`, the `http_conn_tls_head` idiom at `http.sfn:125`) rather than
per-ctx, or every HTTPS request pays a full bundle parse.

Size estimate for the driver: **~900-1,100 lines** of new `runtime/sfn/`
source, none of it shared with anything existing.

### 3.3 Throughput — the hot/cold split

SFEP-0048 §3.5 records the anchor: in-process SHA-256 over `int[]` under
`-O0` took "seconds" for a multi-hundred-KB file where one `popen` to
`sha256sum` took ~30 ms, driving a CI shard from ~6 min to ~23 min
(`compiler/src/build/fs.sfn:713-721`). That implies order **~150 KB/s at
-O0**.

ChaCha20-Poly1305 is ~25 integer operations per byte, the same order as
SHA-256's ~31. On top of that, `tls13_open_record` performs four full `int[]`
copies of every record's bytes (`record` → `enc` at :228-234, AEAD output,
`_decode_inner_plaintext`'s `content` at :120-126, then the driver's copy into
`pt_*`), each element an i64 with a bounds check. The realistic estimate is
**~120-200 KB/s at -O0 and low single-digit MB/s at -O2**, against OpenSSL's
hundreds of MB/s. That is not a viable HTTP transport: `sfn toolchain install`
would spend minutes of CPU decrypting a release tarball, and `sfn_serve_tls`
would be CPU-bound at a rate no real client tolerates.

**The idiom is the problem, not the algorithm.** One byte per i64 array slot
with a bounds check is an 8x memory-traffic penalty before any arithmetic. The
handshake pays it ~once per connection and does not care; the record layer
pays it per byte and does.

**Design: split by hot/cold.** The record layer is re-expressed in the `*u8`
idiom (the SFN-338 precedent, `websocket.sfn:536-620`) as a new
`runtime/sfn/platform/tls_record.sfn`: ChaCha20 keystream generated 64 bytes
at a time into a caller-owned buffer, Poly1305 accumulated over a pointer,
record header/inner-plaintext framing done in place, zero intermediate arrays.
~700 lines. Everything else — key schedule, X25519, X.509, signature
verification, both handshake state machines — stays in the capsule's `int[]`
form and is reached by the dependency edge (§3.1), because it runs once per
connection.

This is *not* a fallback position taken for expedience. Re-expressing the
whole 10k-line closure in `*u8` (route (a) applied globally) would be a
multi-quarter hand-port of security-critical code with no oracle; re-expressing
only the ~700 lines that carry every byte gets essentially all of the win and
keeps a byte-exact differential oracle (the capsule's `int[]`
implementation) for the part that was rewritten.

**The estimate must be replaced by a measurement.** The record-layer issue's
acceptance includes a reported MB/s figure at `-O0` and `-O2` for
seal/open over a 1 MiB payload. If the pointer-idiom record layer does not
clear ~20 MB/s at `-O2`, the honest outcome is that Phase D ships behind a
documented throughput ceiling — not that the number is quietly omitted.

### 3.4 Peer authentication — the real blocker on acceptance criterion 3

Three defects, all inside `capsules/sfn/crypto/`, all independent of the
runtime swap:

1. **`_encode_signature_algorithms_extension`
   (`tls13_handshake_codec.sfn:290-295`) offers exactly one algorithm:
   `ed25519`.** No public CA issues Ed25519 leaf certificates and effectively
   no public server holds one. A ClientHello offering only ed25519 draws
   `handshake_failure` from every real host. `https://` against a real public
   host is impossible today for this reason alone, before any question of
   chain verification.
2. **`hs_client_recv_certificate_verify`
   (`tls13_handshake.sfn:743-747`) rejects any algorithm but ed25519**, and
   takes the peer key as a 64-character hex string rather than deriving it
   from the certificate. The primitives it needs already exist and are
   unwired: `rsa_pss_verify_sha256`/`_sha384` (`rsa.sfn:474,480`) and
   `ecdsa_p256_verify_sha256` (`ecdsa.sfn:214`). The in-source comment citing
   "SFN-653" is stale — those landed as SFN-656/SFN-657.
3. **`parse_certificate` discards intermediates.** `CertificateMsg`
   (`tls13_handshake_codec.sfn:1250-1254`) carries `leaf` and `entry_count`
   only, so `ClientHandshake.server_leaf_certificate` is all the state machine
   retains and `x509_verify_chain(leaf, intermediates, anchors, options)`
   (`x509_verify.sfn:522`) cannot be driven from it.

The fix is a capsule-only change: offer `rsa_pss_rsae_sha256`,
`rsa_pss_rsae_sha384`, `ecdsa_secp256r1_sha256`, `ed25519`; carry the full DER
chain on `CertificateMsg` and `ClientHandshake`; dispatch CertificateVerify on
`cv.algorithm` against the leaf's `spki_algorithm`/`spki_key`
(`x509.sfn:135-136`); add `hs_client_verify_peer(hs, hostname, anchors,
now_ms)` composing `x509_parse` → `x509_verify_chain` → `x509_hostname_matches`;
delete `hs_client_recv_certificate_verify_without_authenticating`, whose own
comment (`tls13_handshake.sfn:808-815`) says to delete it at exactly this
point.

**Verdict on acceptance criterion 3:** reachable, but only after this lands.
It is not deliverable inside a body-swap PR.

### 3.5 The server-side narrowing, stated as a regression

`tls13_server_handshake.sfn` signs CertificateVerify with `ed25519_sign` only,
and refuses a ClientHello that does not offer ed25519. RSA and ECDSA *signing*
are out of scope per SFEP-0048 §6.3 (which scopes RSA to verify — public data,
no constant-time requirement — and explicitly defers signing). So after the
swap, `sfn_serve_tls(cert_path, key_path)` accepts an **Ed25519 certificate
only**, where today it accepts anything OpenSSL loads.

All four TLS e2e tests generate `rsa:2048` self-signed certificates
(`serve_tls_loopback_test.sfn:75`, `runtime_tls_https_client_test.sfn:150`,
`runtime_tls_verify_failure_test.sfn:165`, `tls_loopback_test.sfn`). They must
be re-pointed at `openssl req -x509 -newkey ed25519`, which `openssl s_client`
and `s_server` both handle. The narrowing is user-visible and belongs in
`docs/status.md` and the swap PR's description; ECDSA-P256 signing (RFC 6979
deterministic `k` over the existing `p256.sfn` group layer, avoiding a
`![rand]` dependency in the signer) is the follow-on that closes it.

### 3.6 Platform reach

**Windows.** The native route does light Windows up, but only partially.
`openssl_absent_windows.sfn` retires. `runtime/ir/windows_stubs.ll:85-101`'s
six `tls_*` stubs delete **when `platform/tls.sfn` joins the cross-build's
`RUNTIME_MODS` list** — the stubs exist only because that module is excluded
for pulling OpenSSL, and the native stack needs none. Treat both the stub file
and the `RUNTIME_MODS` bridge as a transitional state, not an end state: the
whole hand-rolled loop (`Makefile:1169-1210`) exists because Windows has never
actually been built through the ordinary driver. D4 should delete the six
stubs and add the module; if the Windows leg is not green in that PR, leaving
the stubs is an acceptable one-release carry, but it must be recorded as such
and not quietly kept. Entropy
is already conditioned (`platform/rand_windows.sfn`, `BCryptGenRandom`) and
sockets already link (`target_extra_link_libs`, `-lws2_32`). What does **not**
work is trust: `trust_store_default_paths()`
(`trust_store.sfn:84-86`) lists seven POSIX bundle paths and no Windows
certificate store. Windows gets a working handshake and a working
`SAILFIN_TLS_CAFILE`, and nothing else. That is still strictly better than
today's fail-closed stub, and the Windows cert-store binding is separate work.

**macOS.** The same list does include `/etc/ssl/cert.pem` and
`/opt/homebrew/etc/openssl@3/cert.pem`, which covers stock macOS and Homebrew
respectively — but macOS is a *currently working* platform, so this must be
verified on a real host before the swap lands, not assumed. If neither path
resolves, the swap is a macOS regression.

**`SAILFIN_TLS_CAFILE`** keeps working unchanged: `trust_store_load()`
consults it before `SSL_CERT_FILE` and before the default paths, deliberately,
for exactly this transition (SFEP-0048 §3.1, 2026-08-07 amendment).

### 3.7 The feasibility unknown that gates everything

**No runtime sfn-source has ever used `Result<T, E>` or `match`.** Verified:
`match` appears in zero of the 31 modules; every `Result<` occurrence in
`runtime/sfn/` is a comment saying "until `Result<T, E>` lands"
(`io.sfn:575`, `platform/net.sfn:62`, `memory/arena.sfn:95`,
`adapters/filesystem.sfn:447`). `int[]` appears in two places
(`process.sfn:836`, and `array.sfn`'s own machinery). The runtime sfn-source
emit path is a deliberately restricted `*u8`+scalar environment.

**The dependency route shrinks this risk by roughly an order of magnitude, but
does not erase it.** Under the vendoring route the *entire* 10k-line closure —
`Result<T, string>`, `match`, generic enums, structs with `int[]` and
`X509Certificate[]` fields, `.push` growth, string concatenation in error paths
— had to compile on the runtime emit path. Under the dependency edge, every one
of those constructs stays on the **capsule** emit path, which already compiles
them today. What crosses into runtime source is only the *interface*: the
driver in `tls.sfn` receives whatever the crypto entry points return, and those
are `Result<T, string>` values it must inspect.

**Design response: keep the runtime side Result-free.** Rather than betting on
`match` lowering correctly in a module class that has never used it, D1 adds a
thin, Result-free facade to `capsules/sfn/crypto/src/mod.sfn` for exactly the
entry points the driver calls — the `?`/`match` unwrapping happens inside the
capsule, and the runtime sees pointers, `i64` status codes, and out-parameters,
the idiom every other runtime module already uses. This is cheap (the facade is
a few dozen lines over functions that already exist), it keeps the driver in the
`*u8` idiom §3.3 needs anyway, and it removes the single largest unknown in the
chain from the critical path.

The residual risk — a struct-by-value return or a generic enum crossing the
boundary — is what **E0's fixture test answers empirically**, and it answers it
before any production runtime module imports anything. E0 stands up a temp
runtime root (`SAILFIN_RUNTIME_ROOT`, the SFN-146 machinery, following
`compiler/tests/e2e/runtime_sfn_sources_link_consumer_test.sfn`) whose
`capsule.toml` declares a capsule dep and whose module imports from it, and
asserts the link resolves. Extending that fixture to import one
`Result`-returning function is a one-line addition that converts "we think the
facade is necessary" into a fact. Note `tls13_record.sfn:250-257` documents a
miscompile in exactly this territory (SFN-378: a `match` arm falling through
into a nested `match`/`if` reloads a sibling arm's binding and emits IR failing
the LLVM verifier with "Instruction does not dominate all uses"); SFN-378 is
`Done` on `main`, but the pinned seed is the binary that matters, and E0's
fixture is what tells us which side of that line we are on.

## 4. Effect & capability impact

No change to the effect surface. `tls_read`/`tls_write`/`tls_connect_fd`/
`tls_accept_fd` already carry `![net]` and continue to; the crypto capsule is
effect-free (`capsules/sfn/crypto/capsule.toml` declares
`[capabilities] required = []`), and the capability audit is per-member
(`capsule_resolver/capability.sfn:292-330`), never applied by a consumer to a
dep's sources — so linking crypto into every binary adds no capability
obligation to a hello-world. Two additions: `tls_client_ctx` gains `![io]` (it reads the trust bundle
off disk, where today OpenSSL did that behind an effect-free extern) and the
handshake's ephemeral key generation calls `sfn_rand_fill`, whose `![rand]`
rides the enclosing `![net]` wrapper the same way the socket externs do. Both
must be threaded through the `extern fn` forward declarations in
`http.sfn`/`serve.sfn`/`websocket.sfn` — extern declarations carry no effect
surface (E0804), so this is a change to the *defining* signatures only.

This is the change that clears SFEP-0016's precondition: after it, every byte
of TLS traffic passes through Sailfin-owned `recv`/`send` externs the seal can
gate, instead of libssl's opaque libc calls.

## 5. Self-hosting impact and the issue chain

**One compiler-pass change, and it forces one seed cut.** The mangling
reposition (§3.1.1) plus the driver plumbing (§3.1.2) are capabilities that
*runtime source calls*. `make compile` self-hosts against the binary pinned by
`bootstrap.toml [seed].version`, and that binary both compiles the working-tree
runtime (`_compile_runtime_sfn_sources`) and *is* the emit child for every
runtime module. Bundling the capability with its consumer does not help here:
the old seed is the one doing the work. This is the structural carve-out in
`.claude/rules/seed-dependency.md`, not a judgement call.

**Corollary — the plumbing lands *before* the seed cut, not after.** It is
tempting to read the driver-side work (staging, `.import-deps`, link scoping,
locator, installer) as ordinary compiler source that can bundle with its
consumer. It cannot: the seed executes that driver code during `make compile`.
Since the gate is unavoidable, cross it **once** — E0 carries the complete
capability family in a single `seed-blocker` PR, per the same rule's "land the
complete capability family in that single PR rather than trickling it per
consumer."

**What E0 deliberately does *not* carry:** the `[dependencies]` line in
`runtime/capsule.toml` and the `tls.sfn` body. Declaring the dep before a
runtime module imports anything would pay §3.1.3's ctor floor on every binary
with no benefit for however long the seed cut queues. The declaration belongs
with the first importer, in D4.

**The seed cut queues; it does not trigger a reactive cut.** Per SFEP-0026 WS-C
the advance batches onto the next scheduled cadence bump. D4 carries
`## Required in pinned seed: SFN-<E0>`.

**D4 remains one PR.** Body swap + link deletion together, exactly as
SFEP-0048 §5 requires. What changed is that it now has a seed-gated
predecessor, where the original note claimed none.

| # | Issue | Slice | Where | Est. | Blocks |
|---|---|---|---|---|---|
| E0 | *(new)* | **`seed-blocker`.** Runtime→capsule dependency capability: reposition the mangling early return so runtime modules skip step 1 but run step 2/2b (§3.1.1); `dep_specs` on `RuntimeCapsuleArtifacts` + `toml_get_dependencies`; stage the runtime's dep closure into the rt-import-context; `.import-deps` `/mod` fallback; `ResolverConsumer.runtime_root` + resolution-level union (§3.1.3); runtime-root locator leg + installer bundling (§3.1.4); **unwind SFN-766's five vendored modules**; out-of-tree `SAILFIN_RUNTIME_ROOT` fixture e2e proving a runtime module can call a capsule (§3.7) | compiler + runtime manifest | 5 | D4 |
| — | — | **cadence seed cut** (queued, SFEP-0026 WS-C) | — | — | D4 |
| D1 | SFN-767 | Capsule: real-world CertificateVerify + chain wiring (§3.4), **plus the Result-free driver facade** (§3.7) | capsule | 5 | D4 |
| D2 | SFN-768 | Runtime: `*u8` record layer + measured throughput (§3.3) | runtime | 3 | D4 |
| D4 | SFN-341 | Declare `[dependencies] "sfn/crypto"` in `runtime/capsule.toml`; the I/O driver + body swap + link deletion + platform/test/doc sweep; report hello-world size and cold/warm build deltas | runtime | 5 | — |

**Disposition of the superseded work.**

- **SFN-769 (D3, "vendor the 20-module cold path + rename map + drift test") is
  superseded** by E0 and should be closed as such, citing §6. Nothing in it
  survives: the rename map, the `runtime_crypto_vendor_sync_test.sfn` drift
  gate, and the `docs/conventions/` rename-map note all exist only to police a
  fork that no longer happens.
- **SFN-766 (D0) stays `Done` as history; its five modules unwind in E0.**
  `runtime/sfn/crypto/{bits,chacha20,poly1305,aead_chacha20poly1305,
  tls13_record}.sfn` delete and `runtime/capsule.toml:60-64` drops the five
  `sfn-sources` entries. Verified: no module outside `runtime/sfn/crypto/`
  references any symbol they define, so the removal is behaviour-neutral. Its
  feasibility-spike *role* is taken over by E0's fixture e2e, which answers the
  same question (§3.7) more directly and without committing source.
- **D2 is unaffected by the amendment.** The `*u8` record layer is
  re-expressed in the runtime idiom from the capsule as oracle; it never
  depended on the vendored `int[]` copies, and after E0 the capsule's
  `tls13_record`/`aead_chacha20poly1305` remain reachable as the differential
  test's reference implementation.
- **D1 is still fully parallelizable** with E0 and D2 — it touches only
  `capsules/sfn/crypto/`.

**Total: 18 points.** SFN-341's original 3-point estimate is wrong by ~6x, and
the issue as scoped is not deliverable as one PR.

## 6. Alternatives considered

**Reposition the mangling early return so runtime modules skip step 1 but still
run step 2 (`lowering_helpers_mangling.sfn:148-150`).** **CHOSEN** (§3.1.1) —
this note's earlier revision rejected it, and that rejection was wrong on the
benefit, not on the cost. The cost is stated plainly and unchanged: it is a
lowering change that runtime source depends on, so it lands **alone**, labelled
`seed-blocker`, and D4 waits on a queued cadence seed cut before it can
self-host. What the earlier revision got wrong was pricing the benefit at "11
renames." The benefit is **not forking 10-12k lines of security-critical
crypto**, and not paying a second full compile of code the build already does.
Against that, one queued seed cut is cheap. Note also that the change is *not*
the narrow "mangle a `runtime/sfn/crypto/` subtree" variant that was rejected —
that variant left step 2 broken for runtime importers and so could never have
worked. The chosen change splits the early return by pass: runtime modules keep
their unmangled ABI (step 1 still skipped) and gain the ability to *call*
mangled providers (step 2 runs).

**Vendor the cold path into `runtime/sfn/crypto/` (this note's original
route; SFN-769).** **REJECTED**, superseding the earlier revision's choice.
Four reasons, in order of weight:

1. **It duplicates a compile the build already performs.**
   `compiler/capsule.toml:59` declares `"sfn/crypto" = "*"`, and
   `_cr_collect_capsule_sources` (`discovery.sfn:230+`) walks a declared dep's
   entire `src_dir` with no import-reachability filter. Every crypto module is
   already emitted on every `make compile`. Vendoring adds a second copy under a
   second slug set, compiled a second time — which is precisely the "+8-12%
   self-host" figure the earlier revision quoted as the route's cost. It buys
   nothing in exchange: there is no caching asymmetry to exploit, because
   `cache_compiler_identity` is folded into *both* key schemes
   (`runtime_objs.sfn:568,795` and `capsule_resolver/compile.sfn:302` →
   `build_cache.sfn:1262-1267`), so both tiers re-emit on a compiler change
   equally.
2. **It forks security-critical code.** 10,146 lines of crypto maintained in
   two places, differing by a rename map, kept honest by a hash-diff test. A
   drift gate can only *detect* a fork after the fact; it cannot prevent one,
   and it cannot merge one. The failure mode is a security fix landing in
   `capsules/sfn/crypto/` and not in the copy that every Sailfin binary
   actually runs.
3. **It buys 13 symbol collisions and a permanent rename map.** `_append` ×4,
   `_slice` ×3, six more ×2, plus a collision against `adapters/http.sfn`'s
   `_append` — because the runtime link set is one flat namespace. Every future
   crypto module added upstream re-opens that negotiation.
4. **It solves nothing the dependency edge does not.** The three objections
   that made vendoring look forced are all properties of the `sfn-sources`
   hack, not of a `[dependencies]` edge (§3.1.5's table).

**Point `runtime/capsule.toml` `sfn-sources` at `../capsules/sfn/crypto/src/`
(no copy, one source of truth).** **REJECTED** — unchanged, and this is the
only variant the three classic objections actually apply to: the slug
derivation breaks (SFN-146's recorded failure mode), `sfn/strings` bare-capsule
imports are skipped by runtime staging, and the same modules are compiled twice.
§3.1.5 records which of those survive contact with a real dependency edge
(none).

**Compile the runtime's deps inside `assemble_runtime_capsule_link_inputs`,
alongside `sfn-sources`.** **REJECTED** (§3.1.3). It reads like the natural
home — the runtime object path is already the unconditional one — but the
compiler declares `sfn/crypto` itself, so its modules would arrive twice with
identical mangled symbols: once as `.ll` via `capsule_lls`, once as `.o` via the
runtime path. Hard duplicate-symbol link failure, and the link layer cannot
subtract the project's dep set on the `sfn test` path because it never sees it.
Union at *resolution* gets the dedup for free from machinery that already
exists.

**Hand re-express the whole stack in the `*u8` idiom (SFN-338 applied
globally).** Rejected. SFN-338 re-expressed ~200 lines of SHA-1 + base64;
this is ~10,000 lines of security-critical code with no oracle for the parts
that were rewritten. §3.3 takes the useful 7% of this route — the per-byte
record layer, where the idiom actually matters and where a byte-exact
differential oracle exists.

**A new capsule `kind` that links like a runtime capsule.** Rejected as
premature — and now doubly so: the dependency edge *is* that idea, implemented
with the mechanisms already in the tree (`[dependencies]`, the transitive
resolver, the existing mangling scheme) instead of a new manifest concept. If a
future need appears for a capsule that links unconditionally *without* being a
runtime dep, revisit then.

**Make TLS opt-in via a registration table instead of a direct call.**
Rejected for this cut, recorded because it is the honest answer to "must every
binary carry crypto's ctor floor?" `http.sfn` could reach TLS through an
`extern var` vtable head populated by a constructor in `platform/tls.sfn`
(the `http_conn_tls_head` idiom at `http.sfn:125`), so a binary that never
links TLS gets a null vtable and a clean "TLS not linked" failure. That only
pays off if `platform/tls.sfn` itself stops being an unconditional
`sfn-source` — i.e. if `https://` becomes something a program opts into. That
is a real, defensible future design ("runtime capability slices"), but it is a
user-visible change to what the runtime guarantees, and it is orthogonal to
getting OpenSSL out. See §10.

**Keep OpenSSL for TLS and seal around it.** Already rejected as SFEP-0048
§6.2 and unchanged: libssl calls libc directly and bypasses any Sailfin-owned
chokepoint.

## 7. Stage1 readiness mapping

No new syntax. E0 is the only slice that changes a compiler pass — the
mangling reposition (§3.1.1) — and it changes *symbol rewriting*, not the
language surface. The parse/typecheck/emit rows are satisfied by existing
support for the constructs used, **conditional on E0's fixture e2e confirming
that a runtime module can call a capsule provider** (§3.7). Until E0 is green,
those rows are honestly "unproven," not "satisfied."

- [ ] Parses — no new syntax; E0 confirms for the runtime path.
- [ ] Type-checks / effect-checks — `![io]` added to `tls_client_ctx`;
      `![rand]` rides `![net]`.
- [ ] Emits valid `.sfn-asm` — E0 gate.
- [ ] Lowers to LLVM IR — E0 gate (step 2 for runtime modules; the `E1001`
      shadow check and re-export shims are the new surfaces, §3.1.1); SFN-378
      is the known hazard for any `Result`/`match` that reaches runtime source.
- [ ] Regression coverage — §8.
- [ ] Self-hosts — `make clean-build` in E0 (structural: step 2 changes every
      runtime module's IR); `make compile` after D1/D2/D4; `make check` before
      E0 and D4 merge.
- [ ] `sfn fmt --check` clean — every new `runtime/sfn/crypto/*.sfn` and the
      rewritten `tls.sfn`.
- [ ] Documented — `docs/status.md` (the `sfn/crypto` row, the TLS row, and
      the Ed25519-server-cert narrowing), SFEP-0048 §3.1's Phase D row,
      `docs/runbooks/openssl-build-dependency.md` (retire),
      `docs/development-setup.md`, `install.sh`,
      `.github/actions/sailfin-build/action.yml`,
      `site/src/content/docs/docs/getting-started/install.md`.

## 8. Test plan

**E0.** `make clean-build` + `make check` green — the reposition changes every
runtime module's emitted IR, so a warm build proves nothing. Plus:

- `compiler/tests/e2e/` fixture: a temp runtime root
  (`SAILFIN_RUNTIME_ROOT`, following
  `runtime_sfn_sources_link_consumer_test.sfn`) whose `capsule.toml` declares a
  capsule dep and whose module imports and calls a symbol from it; assert the
  binary links and produces the right answer. Extend it with one
  `Result`-returning callee to settle §3.7 empirically.
- Assert a runtime module's own definitions stay **unmangled** after the
  reposition (`nm` on a built binary still shows bare `@sfn_arena_alloc`,
  `@tls_client_ctx`, …) — this is the invariant the early return exists to
  protect, and the reposition must not weaken it.
- Assert a *hello-world* (no `capsule.toml`) links crypto's mangled symbols and
  still runs, with an installed-layout leg exercising the
  `<runtime_root>/../capsules` locator and the installer's bundled tree.
- Report: `make compile` wall-time delta (expected slightly **negative** — five
  vendored modules leave `sfn-sources`), hello-world binary size, and cold vs
  warm hello-world build time (§3.1.3).
- `cross_windows_runtime_modules_test.sfn` stays green: the five unwound
  `runtime/sfn/crypto/*` entries leave the manifest, so the bridge's
  `RUNTIME_MODS` list must drop them in the same PR.

**D1.** Capsule tests under `capsules/sfn/crypto/tests/`: a CertificateVerify
dispatch table test per algorithm against fixture signatures; a
`parse_certificate` multi-entry chain test; an
`hs_client_verify_peer` test over a fixture leaf+intermediate+anchor chain
including expiry, hostname mismatch, and unknown-anchor rejections. The
existing RFC 8448 client/server tests must stay green.

**D2.** `compiler/tests/e2e/` differential test: the `*u8` record layer's
seal/open must be byte-identical to `tls13_seal_record`/`tls13_open_record`
over the RFC 8439 §2.8.2 AEAD vector and the RFC 8448 §3 record vectors, plus
a fuzz-ish sweep over record lengths 0..16640 and every fail-closed path
(short header, length mismatch, tag mismatch, all-zero plaintext). Reported
MB/s at `-O0` and `-O2`.

**D4.** The four existing TLS e2e tests re-pointed at Ed25519 certs and
green against `openssl s_client`/`s_server`
(`serve_tls_loopback_test.sfn`, `runtime_tls_https_client_test.sfn`,
`runtime_tls_verify_failure_test.sfn`, `tls_loopback_test.sfn`) — the
verify-failure leg is the one that proves the swap did not become a silent
downgrade. A new e2e fetching a real public `https://` host with an
RSA-rooted chain, skipping (not failing) without network. Link-line
assertions: `nm`/`otool` on a built binary shows no `SSL_*` symbol, and the
link trace carries no `-lssl`/`-lcrypto`/`-L<openssl>`.
`compiler/tests/e2e/openssl_prefix_honored_test.sfn` deletes;
`target_conditioning_test.sfn`, `windows_runtime_siblings_test.sfn`, and
`cross_windows_runtime_modules_test.sfn` update. `make check` before merge.

## 9. References

- SFEP-0048 (`0048-native-crypto.md`, Accepted) — the parent; §3.1 Phase D,
  §3.2 the runtime-vs-capsule tension, §3.3 the integer idiom, §3.5 the `-O0`
  measurement, §5 the one-PR requirement.
- SFEP-0036 (`0036-tls-runtime.md`, Implemented) — the wrapper contracts being
  swapped.
- SFEP-0016 (`0016-capability-sealed-runtime.md`) — the seal this unblocks.
- SFEP-0006 (`0006-build-architecture.md`) — the build budget §3.1's cost
  lands against.
- `.claude/rules/seed-dependency.md` — the bundle-vs-split call and the
  runtime-consumer carve-out.
- Link-line edit points: `runtime/capsule.toml:88`,
  `compiler/src/build/runtime_objs.sfn:1391-1419,1459`,
  `compiler/src/build/target.sfn:164`.
- Mangling boundary: `compiler/src/llvm/lowering/lowering_helpers_mangling.sfn:148-150`
  (early return), `:159` (step 1), `:189` (step 2), `:253` (runtime providers
  stay unmangled), `:319` (step 2b), `:290-296` (`E1001` shadow check);
  provider resolution `compiler/src/llvm/lowering/lowering_helpers.sfn:384-395`.
- Dependency route citations: `compiler/capsule.toml:59` and
  `compiler/src/cli/commands/toolchain.sfn:31,340` (the existence proof);
  `capsules/sfn/crypto/capsule.toml:6-10` (`sfn/strings` declared);
  `capsule_resolver/discovery.sfn:230+` (whole-`src/` walk, no reachability
  filter), `:393-417` (runtime-capsule discovery), `:464-468` + `:542-554`
  (dedup + transitive enqueue), `:131-170` (`_cr_locate_capsule_src`);
  `capsule_resolver/dedupe.sfn:364-404` (`(slug, source_path)` dedup);
  `capsule_resolver/types.sfn:79-84` (`ResolverConsumer`);
  `capsule_resolver/mod.sfn:275-288` (the no-deps short circuit);
  `cli/commands/build.sfn:455-472` (consumer link vs unconditional runtime
  fallback); `runtime_capsule_resolver.sfn:62-71` (`RuntimeCapsuleArtifacts`),
  `~:431-470` (`_rcr_artifacts_from_manifest`);
  `build/runtime_objs.sfn:985` (rt ctx root), `:1010`
  (`_stage_one_runtime_sfn_import_context`), `:1080` (`.import-deps` writer),
  `:1134` (staging pass), `:1278` (`_compile_runtime_sfn_sources`);
  `cli/commands/package.sfn:344-417` (installer staging);
  `build/clang_argv.sfn:53-54` + `build/link.sfn:113-123`
  (`-ffunction-sections` / `--gc-sections`);
  `llvm/lowering/type_descriptors.sfn:192-201,368-390` (the ctor floor);
  `Makefile:1046-1096` (the cross-windows hand-staging the `tls_*` externs
  serve).
- Slug derivation `compiler/src/build/runtime_objs.sfn:163-172`;
  SFN-146 warning `compiler/src/runtime_capsule_resolver.sfn:441-447`.
- RFC 8446 (TLS 1.3) §4 handshake, §5 record layer, §D.4 middlebox
  compatibility; RFC 8439 (ChaCha20-Poly1305); RFC 8017 §8.1 (RSASSA-PSS);
  RFC 6125 (hostname verification).

## 10. Future considerations

Three follow-ons this amendment surfaces but does not take on. None gates Phase
D; all become more attractive once the dependency edge exists.

**Import-reachability filtering in the capsule walk.**
`_cr_collect_capsule_sources` (`discovery.sfn:230+`) compiles every `.sfn` under
a declared dep's `src/`, reachable or not. That is the single root cause of both
§3.1.3's hello-world ctor floor *and* a chunk of the compiler's own self-host
time — the compiler links all 27 crypto modules to call one `ed25519_verify_utf8`.
Filtering the walk by the import closure of the consumer's entry would shrink
both, with no manifest change and no seed dependency of its own. It is the
highest-leverage build-time item this analysis turned up, and it belongs against
SFEP-0006's budget rather than here.

**Install-time seeding of the shared module cache.** The module cache key folds
nothing project-specific (`build_cache.sfn:1262-1267`), so the `.ll` artifacts
for the runtime's dependency closure are identical for every project on a host
at a given compiler version and target. `sfn toolchain install` can populate
`cache_root` with them, turning a cold first hello-world build back into a warm
one. This is the correct answer if D4's measured cold-build number is
unacceptable — it needs no new code path, only a cache write at install time.

**Runtime capability slices.** If the runtime's dependency closure ever grows
past one or two entries, "the runtime's deps link into every binary" stops being
obviously right, and the registration-table design rejected in §6 becomes worth
building: `platform/tls.sfn` (and its dep closure) linked only into programs
that opt in, reached through a constructor-populated vtable, with a clean
"TLS not linked" failure otherwise. That is a change to what the runtime
guarantees a program, so it wants its own SFEP and its own positioning
decision — not a quiet size optimisation.
