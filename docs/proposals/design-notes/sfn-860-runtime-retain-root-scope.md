# SFN-860 — Scope the runtime retain-root set

Design gate for SFN-860 (`fix(link): scope the runtime retain-root set`).
**Design only — no compiler code written.** RCA:
`docs/rca/2026-08-13-e2e-shard-time-doubling-runtime-crypto-retain-roots.md`.
Project: Compiler Hardening.

---

## 1. Decision

**Shape (a): gate the retain-root set on producing a declared provider
surface.** The gate is a manifest opt-in — `[build] retain-runtime-symbols =
true` — read from the `-p` project's own `capsule.toml`, set on
`compiler/capsule.toml`, and defaulted to `false` everywhere else. Ordinary
`sfn build` / `sfn run` links get `--gc-sections` with **no** `-Wl,-u,` roots.

Shape (b) — excluding the networking/TLS runtime objects from the root set —
is rejected. Reasoning in §3.

---

## 2. Current state

### 2.1 The mechanism, corrected

The RCA's summary is right about the effect but the retention path is worth
stating precisely, because it decides what (b) would actually have to name.

`sfn/crypto` does **not** reach the link as a runtime object. It is a
`[dependencies]` entry of `runtime/capsule.toml:106-107`, unioned into every
project's resolution by `capsule_resolver/discovery.sfn:414-453`, compiled to
per-capsule IR under `build/capsules/sfn/crypto/ir/`, and folded into
`ll_paths` — landing in `link_input_result.object_paths`
(`compiler/src/build/link.sfn:294`, `364-368`), never in `runtime_objs`. That
is why the capsule-object guard at `link.sfn:352-355` holds literally.

What `_runtime_retain_root_flags` (`link.sfn:172-198`) roots is the **runtime
capsule's own objects** — the 33 `sfn-sources` plus `prelude.sfn` from
`runtime/capsule.toml:46-81, 97`. Among them are
`sfn/platform/tls.sfn`, `sfn/platform/tls_record.sfn`,
`sfn/platform/cert_roots.sfn`, `sfn/adapters/http.sfn`,
`sfn/adapters/websocket.sfn`, `sfn/adapters/net.sfn`, and
`sfn/concurrency/serve.sfn`. Rooting every `/sfn/`-matching defined global in
those objects forces `sfn_tls_*` / `sfn_http_*` / … to survive
`--gc-sections`, and their relocations then pull the entire
`__sfn__crypto__*` closure out of the capsule objects **transitively**. The
RCA's measured "roots minus TLS/HTTP/WS/serve/cert_roots objects" variant
(127,824 B, 0 crypto text syms) is exactly the removal of those runtime
objects from the *root set*.

### 2.2 Call sites and the degrade trap

`link.sfn:335-351` applies the roots unconditionally on any GNU-GC target:

```
let retain_flags = _runtime_retain_root_flags(runtime_objs);
let strip_safe = runtime_objs.length == 0 || retain_flags.length > 0;
```

**`strip_safe` conflates "roots are intentionally empty" with "`nm` failed".**
An implementer who merely makes `_runtime_retain_root_flags` return `[]` for
ordinary builds will land in the `else` branch, **disable `--gc-sections`**,
and print

```
sfn: dead-code strip disabled — could not enumerate runtime
     provider symbols (is `nm` on PATH?); linking unstripped
```

on every build — producing a *larger* binary than today's and a spurious
warning on every e2e nested build. This is the single most likely way to get
this issue wrong. The restructure in §4.3 is mandatory, not cosmetic.

### 2.3 What already does not root

`compiler/src/cli/commands/test/link.sfn:163, 183-190` builds its own
`LinkPlan` with `link_flags: no_link_flags` — the **`sfn test` link path has
never had `--gc-sections` or retain roots**. Test binaries are therefore
unaffected by this issue in either direction. Do not expect test-binary
shrinkage.

### 2.4 What the roots are actually paying for

Nothing links against `build/bin/sfn`; there is no shared library and every
downstream program recompiles the runtime from `runtime/capsule.toml`
`sfn-sources` into its own objects. No `dlopen`/`dlsym` exists anywhere in
`compiler/` or `runtime/`. The root policy has exactly two real consumers:

1. **The migration/ABI assertions**, all of which `nm` `build/bin/sfn`:
   - `compiler/tests/e2e/runtime_sfn_sources_active_test.sfn:109-134` (arena)
   - `compiler/tests/e2e/runtime_type_meta_test.sfn:228-237` (type meta)
   - `compiler/tests/e2e/runtime_adapter_filesystem_test.sfn:268-275` (fs)
   - `compiler/tests/e2e/runtime_string_basic_test.sfn:204-210` (string)
   - `compiler/tests/e2e/runtime_string_utf8_numeric_test.sfn:159-160`
   - `compiler/tests/e2e/runtime_string_allocating_test.sfn:155-156`
2. **An unstated but genuine invariant**: one link per build that force-includes
   the *whole* runtime surface proves that surface is self-consistent and
   co-linkable. Under blanket GC with no roots anywhere, a runtime module could
   acquire an undefined reference and never be caught, because it is always
   stripped. This is the honest content of "provider surface" and it is worth
   keeping.

Both are properties of **one** binary. Every binary currently pays for them.

---

## 3. Why (a), and why (b) loses

### 3.1 (b) degrades worse on the next heavy runtime dep

(b) is a **denylist keyed on today's subsystem names**, and it would have to
live in `compiler/src/build/link.sfn` as a match over runtime source basenames
(`tls.sfn`, `tls_record.sfn`, `cert_roots.sfn`, `http.sfn`, `websocket.sfn`,
`net.sfn`, `serve.sfn`) with nothing structurally coupling it to
`runtime/capsule.toml`. The next heavy dependency edge — a compression
capsule behind an adapter, a regex engine, `sfn/crypto` growing a post-quantum
KEM behind a *new* runtime module, a QUIC stack — re-introduces the full
regression **silently**, with no diagnostic, no failing test, and no
mechanical prompt for the author to update the list. This repo has a documented
history of exactly this drift class (`_runtime_obj_stem`'s SFN-617 header names
it: "MIRRORS the compile paths … keep the two in sync").

(a) is a **whitelist with a safe default**. The next heavy dep costs a binary
only what that binary actually references. Its worst case is that someone adds
a *second* provider surface and forgets the manifest key — which fails loudly
at the assertion that motivated the key, not silently at size.

### 3.2 (b) leaves the policy incoherent and 84 KB on the table

The RCA's own numbers: (b) lands at 127,824 B, (a) at 43,608 B. The ~84 KB
difference is the rest of the runtime surface (string, array, arena, io,
type_meta, fs, concurrency) retained in every binary for a justification —
"the runtime is a provider surface" — that is **false for an ordinary
executable**. (b) preserves a wrong premise and merely trims its worst
consequence; (a) corrects the premise.

### 3.3 (a) leaves the compiler's own link line byte-identical

Under (a) the compiler binary's flags are *exactly* what they are today: all
`/sfn/` roots plus `--gc-sections`. That means:

- **Zero edits to the six migration test files.** Their assertions stay true
  and become *sharper* — they now assert a property the manifest explicitly
  requests, rather than an accident of an unscoped policy. (The issue's
  "adjusted, never deleted" constraint is satisfied by adding a pointer
  comment, §7.1, plus the new negative companion that bounds the property.)
- **Seedcheck/fixed-point unaffected.** `sfn selfhost`
  (`compiler/src/cli_selfhost.sfn:321`) shells `build --no-cache -p compiler`
  for stage2 and stage3; both honour the key, both root identically, and the
  stage2/stage3 `.ll` fixed-point hash-diff is untouched.

(b) changes the compiler's own link line, so the pass-1 (seed, old policy) and
pass-2 (new policy) compiler binaries diverge, and the migration assertions
would need per-symbol auditing against the exclusion list to confirm nothing
in `sfn_tls_*`/`sfn_http_*` was being asserted. (a) needs no such audit.

### 3.4 (b) also can't express "used TLS still works" any better

Both shapes rely on ordinary reachability to keep TLS in a program that uses
it. (b) buys nothing here that (a) does not.

**Plainly: (b) fixes today's symptom by naming today's heavy subsystem, and
degrades silently the next time the runtime grows one. (a) changes the
policy's intent, and its failure mode on the next heavy dep is "no
regression."**

---

## 4. Design

### 4.1 "Provider surface", operationally

A provider surface is **an artifact whose capsule manifest declares that its
link must carry the complete runtime symbol family, because something other
than the program's own execution consumes that family.** Today exactly one
artifact qualifies: the compiler binary.

New manifest key, in the *project being built*:

```toml
[build]
kind = "binary"
entry = "src/main.sfn"
# SFN-860: this binary is the runtime provider surface — its link force-roots
# the whole `sfn_*` family so the C→Sailfin migration assertions have one
# artifact to check and the runtime surface is proved co-linkable. Ordinary
# binaries take demand-driven dead-stripping instead.
retain-runtime-symbols = true
```

Default `false`. Unknown to the pinned seed's parser, which simply ignores it
(§6).

### 4.2 The information is already in scope — one boolean to thread

`compiler/src/cli/commands/build.sfn:240` already calls
`_resolve_capsule_build_spec(capsule_path)`, which reads the manifest and
returns `_CapsuleBuildSpec` (`compiler/src/build/cache.sfn:192-198`). The
manifest text is already parsed there
(`compiler/src/build/cache.sfn:233-244`). **No new file read, no new resolver
pass.** One boolean field, one assignment, one extra argument on two link
functions.

Precedent for driver behaviour gated on the project manifest already exists in
the same function: `emit_compiler_build_stamp_if_applicable`
(`build.sfn:504, 591`) and the toolchain gate at `build.sfn:255`, both keyed on
`[capsule].name == "sailfin"`. A manifest key is preferred over a third
name-equality gate because it (i) states intent instead of identity, (ii) is
testable with a scratch fixture that does not have to impersonate the
compiler, and (iii) does not hardcode the compiler into link policy.

### 4.3 The link-flag restructure (the trap from §2.2)

Replace `link.sfn:335-351` with a two-branch form. Non-provider builds must
**skip `_runtime_retain_root_flags` entirely** — never call it and discard the
result — so the `nm` subprocess is not spawned and `strip_safe` is not
consulted:

- `target_uses_gnu_link_gc(gc_triple)` false (msvc) → unchanged: no GC flag,
  no roots.
- `retain_runtime_symbols` true → **today's code verbatim**, including
  `strip_safe` and the "could not enumerate runtime provider symbols"
  diagnostic. That diagnostic keeps its exact current meaning: `nm` failed on
  a link that needed it.
- `retain_runtime_symbols` false → push `_dead_strip_link_flag(gc_triple)` and
  nothing else.

Add one line of visibility through the existing channel rather than a new
knob: under `SAILFIN_TRACE_LINK`, print the retain-root decision
(`[link] retain-roots: <N> (provider surface)` / `[link] retain-roots: none`),
mirroring `_trace_linker_choice` (`link.sfn:67-71`). No new environment
override — a policy escape hatch here would just re-create the bug under a
different name.

### 4.4 Comment debt to pay in the same PR

- `link.sfn:152-171` — the header of `_runtime_retain_root_flags` currently
  *justifies unconditional rooting* ("the runtime is a provider surface;
  downstream programs link these helpers fresh"). That premise is false for an
  ordinary executable and is the reason the policy was unscoped. Rewrite it to
  state that the function computes the provider-surface root set and that its
  application is gated by the caller.
- `link.sfn:352-355` — the existing capsule-object guard comment is correct but
  incomplete: it explains why capsule objects are excluded from the root set
  and does not mention that their closure was retained transitively through
  rooted runtime symbols anyway. Extend it to name the transitive path and
  point at the gate.

---

## 5. Files affected

| Stage | File | Change |
|---|---|---|
| Manifest schema | `compiler/src/toml_parser.sfn` | New getter beside `toml_get_build_implicit` (`:439-442`): `toml_get_build_retain_runtime_symbols(text) -> boolean`, body `strings_equal(toml_get_string(text, "build", "retain-runtime-symbols"), "true")`. **No `SailToml` struct change and no `_parse_toml_internal` change** — `toml_get_string` (`:782-809`) already returns an unquoted `true` verbatim through `_toml_strip_quotes` (`:66-78`). Export it. |
| Build driver | `compiler/src/build/cache.sfn` | `_CapsuleBuildSpec` (`:192-198`) gains `retain_runtime_symbols: boolean`; initialised `false` at `:213-219`; assigned from the getter alongside `spec.capsule_name` at `:242-243`. |
| Build driver | `compiler/src/cli/commands/build.sfn` | New local beside `cap_capsule_name` (`:232-246`), default `false` so a positional build is never a provider; pass it as the new trailing argument at `:553`. |
| Link | `compiler/src/build/link.sfn` | `_clang_link_multi_with_opt` (`:225`) and `_clang_link_multi` (`:392`) gain a trailing `retain_runtime_symbols: boolean`, forwarded at `:399`. Restructure `:335-351` per §4.3. Rewrite comments at `:152-171` and `:352-355`. `_runtime_retain_root_flags` itself is **unchanged**. |
| Link (callers) | `compiler/src/cli/commands/run.sfn:183` | Pass `false` — `sfn run` is positional-only (no `-p`), so it can never be a provider surface. Comment it. |
| Link (callers) | `compiler/src/build/tensor_ir_link_harness.sfn:294` | Pass `false`. |
| Manifest | `compiler/capsule.toml:76-78` | Add `retain-runtime-symbols = true` to `[build]` with the §4.1 comment. **Put the comment on its own line** — `toml_get_string` returns the raw remainder after `=`, so a trailing `# …` on the value line would be captured. |
| Tests | `compiler/tests/unit/backend_failure_banner_test.sfn:39` | Argument-count fix only. |
| Tests | new `compiler/tests/e2e/runtime_retain_root_scope_test.sfn` | §7.2. |
| Docs | `site/src/content/docs/docs/advanced/capsules.md:110-114` | One row in the `[build]` field table, marked advanced/rare. |

Not touched, deliberately: `compiler/src/build/link_contract.sfn`,
`compiler/src/capsule_resolver/discovery.sfn`,
`compiler/src/cli/commands/test/link.sfn`, `runtime/capsule.toml`, and any
runtime source.

---

## 6. The `missing_runtime_dep_specs` link contract survives untouched

This is the question most likely to bite, so, concretely:

`missing_runtime_dep_specs`
(`compiler/src/build/link_contract.sfn:40-67`) is a **preflight over
`ll_paths`**, the resolver's output, evaluated at `link.sfn:273` — *before*
`assemble_runtime_capsule_link_inputs` runs and long before any linker flag is
chosen. It asks: did `build/capsules/sfn/crypto/ir/` contribute at least one
path to the link set (`_lc_ll_paths_cover`, `:69-77`)?

Root scoping changes **only `link_flags`**. It does not change `ll_paths`, does
not change `discovery.sfn`'s union of the runtime's `[dependencies]`, and does
not change which objects are handed to `backend.link`. Every crypto module is
still compiled, still assembled, still *on the link line*. The contract's
predicate is therefore evaluated on an identical input and returns an
identical result. **It cannot start failing.**

The follow-up question — does the invariant still *mean* anything once the
contributed modules can be garbage-collected? Yes, and its strength is
unchanged:

- If a runtime module that calls into `sfn/crypto` is itself reachable from
  the program entry, the linker sees that call as a relocation and retains the
  callee. The contract's failure mode (unresolved
  `__sfn__<scope>__<name>__*` at link) is still precisely what it guards.
- If no reachable code calls into crypto, nothing references those symbols and
  collecting them is correct — that is the intended outcome, not a contract
  violation.
- The contract guards a **missing** dependency (nothing compiled), which is a
  hard link error. Dead-stripping guards an **unused** dependency, which is
  not. They are orthogonal.

One direction-of-safety argument worth recording: `-Wl,-u,<sym>` only ever
*adds* an undefined-symbol requirement and an extra GC root. Every link input
here is a plain `.o` on the command line, not an archive, so `-u` does not
change object selection either. **Removing roots can only shrink the retained
set; it cannot introduce a new undefined reference.** Any link that succeeds
today still links.

---

## 7. Test plan

### 7.1 Existing tests

- **Zero assertion changes** in the six migration tests listed in §2.4 — they
  `nm` `build/bin/sfn`, which is built by `-p compiler` and opts in. Add a
  one-line pointer comment in **one** of them (`runtime_sfn_sources_active_test.sfn`,
  above the `compiler binary exports …` tests) naming `SFN-860` and
  `[build] retain-runtime-symbols`, so a future reader knows why this binary
  keeps a family ordinary binaries do not. This is the "adjusted, never
  deleted" obligation: the assertions are unchanged, their *basis* is now
  explicit, and §7.2's negative test bounds them.
- `compiler/tests/e2e/capsule_dead_strip_guard_test.sfn` — assertions unchanged
  and strictly stronger: its fixture consumer now links with **zero** roots, so
  the `clamp`/`mean` absence checks (`:168-177`) test real GC rather than GC in
  the presence of a root set that could have masked a regression. Note this in
  its header.
- `compiler/tests/e2e/capsule_reachability_filter_test.sfn` — asserts
  capsule-mangled `__sfn__…` symbols on a `-p` fixture build; used symbols stay
  (real references), unused stay absent. No change expected; verify in the run.
- `compiler/tests/unit/direct_link_argv_test.sfn:70, 131-134` — string fixtures
  only, unaffected.
- `compiler/tests/e2e/runtime_http_chunked_decode_test.sfn:247` links its C
  harness with a **direct `clang`** invocation (no `--gc-sections`), so it is
  outside this policy entirely.

### 7.2 New: `compiler/tests/e2e/runtime_retain_root_scope_test.sfn`

Follow `.claude/rules/no-bash-e2e.md`: drive `_sfn_bin()` (never a seed path —
during the pre-pin window the seed still applies the old policy), and use
`clean_runner_env(nested_runner_scratch("retain_root_scope"))`.

One `print("hi")` fixture capsule, built twice: once with
`retain-runtime-symbols = true` in `[build]`, once without.

1. **Ordinary binary is stripped and correct.** Build without the key: exit 0;
   binary runs and prints; **zero defined `__sfn__crypto__*` text symbols**
   (` T `/` t ` line match with optional `_` prefix, as the existing helpers
   do); zero defined `sfn_tls_*`.
2. **Relative size is the primary size gate.** `wc -c` both binaries and assert
   `unrooted < rooted`. This is host- and linker-independent (mold/lld/ld.bfd,
   glibc/musl, Linux/Darwin all preserve the ordering) and asserts the *policy*
   rather than a magic number.
3. **Absolute ceiling, Linux-gated.** On `linux` targets only (derive from
   `build_target_triple()`/`target_artifact_tag`, as
   `runtime_sfn_sources_link_consumer_test.sfn:184-188` already does), assert
   the unrooted binary is `< 167_256` bytes — the issue's AC, i.e. below the
   pre-regression tree. Keep it a ceiling, not a band; a tight band on an
   absolute byte count is a cross-host flake generator.
4. **The provider gate works from a fixture.** With the key set, assert a
   handful of family members are defined that the trivial program cannot
   reference: `sfn_str_len`, `sfn_arena_alloc`, `sfn_type_register`,
   `sfn_fs_read_file`. This proves the gate independently of the compiler
   binary — so the migration assertions are no longer the only thing pinning it.
5. **Ctor survival under zero roots.** Extend the ordinary fixture's `main` to
   exercise runtime type metadata (`type_of` / `instance_of`) and a
   `try`/`throw` round trip, and assert the expected output. Type registration
   runs from `.init_array`; GNU ld `KEEP`s it, lld and mold treat it as a GC
   root, and Darwin `-dead_strip` keeps `__mod_init_func` — so this should
   pass, but it is the one silent-breakage candidate and deserves an explicit
   pin rather than an inference.
6. **Demand-driven retention: used TLS survives.** A second fixture whose
   `main` reaches the TLS/HTTPS surface (no network I/O needed — a call that
   forces the symbols onto the reachability graph and fails cleanly is enough)
   links, runs, and `nm` shows `__sfn__crypto__*` text symbols **present**.
   Paired with test 1 this asserts the real property: crypto is absent when
   unused and present when used, which no size number alone can express.

The existing `runtime_tls_anchor_cache_test.sfn` /
`runtime_tls_verify_failure_test.sfn` build and run real TLS programs through
the driver and act as the end-to-end backstop for "a program that genuinely
uses TLS still links and runs."

### 7.3 Commands

```
make clean-build                 # structural: new manifest key + changed signatures
make compile
build/bin/sfn fmt --check compiler/src/build/link.sfn compiler/src/build/cache.sfn \
  compiler/src/toml_parser.sfn compiler/src/cli/commands/build.sfn \
  compiler/src/cli/commands/run.sfn compiler/src/build/tensor_ir_link_harness.sfn \
  compiler/tests/e2e/runtime_retain_root_scope_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_retain_root_scope_test.sfn
build/bin/sfn test compiler/tests/e2e/capsule_dead_strip_guard_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_sfn_sources_active_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_type_meta_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_adapter_filesystem_test.sfn
build/bin/sfn test compiler/tests/e2e/runtime_string_basic_test.sfn
build/bin/sfn test compiler/tests/e2e/capsule_reachability_filter_test.sfn
build/bin/sfn test compiler/tests/unit/backend_failure_banner_test.sfn
make check                       # required — link-policy blast radius
```

Manual confirmation of the AC, mirroring the RCA's reproduction:

```
nm <trivial-binary> | grep -c __sfn__crypto__   # -> 0
wc -c <trivial-binary>                          # -> < 167256
nm build/bin/sfn | grep -c ' T .*sfn_str_len'   # -> >= 1
```

---

## 8. Self-hosting and the seed call

**This bundles. One PR, no `seed-blocker` predecessor, no seed cut.**

Per `.claude/rules/seed-dependency.md`: bundling is the default, and the one
carve-out is "a capability consumed by *runtime* source," which applies because
`_compile_runtime_sfn_sources` /`_prepare_runtime_sfn_object`
(`compiler/src/build/runtime_objs.sfn:817-921`) spawns
`self_path emit` — during `make compile`, `self_path` **is the pinned seed** —
to compile the working-tree `runtime/capsule.toml` `sfn-sources`. That carve-out
does not apply here: no runtime source changes, and nothing in `runtime/` calls
a compiler capability the seed lacks. The entire change is build-driver
orchestration plus a manifest key.

The bootstrap sequence is well-behaved at every step:

1. **`make compile` (seed builds the new compiler).** The seed's TOML parser
   has no notion of `retain-runtime-symbols`; `toml_get_string` on an absent
   key returns `""` and no seed code path reads it. There is no unknown-key
   validation anywhere in `compiler/src`. The seed therefore applies the old
   all-roots policy to the compiler binary's own link — which is the policy
   that binary is *supposed* to have. `build/bin/sfn` keeps the full family and
   the six migration tests pass.
2. **Everything that new compiler then builds** — every e2e nested `sfn build`
   / `sfn run`, every user build — honours the key. **The fix is fully
   effective on merge, before any re-pin.**
3. **After the next cadence seed pin**, step 1's link is performed by a seed
   that reads the key and roots the same set. Byte-identical outcome; nothing
   to migrate, nothing to remove later.
4. **`make check` stage2/stage3.** `sfn selfhost`
   (`compiler/src/cli_selfhost.sfn:321`) shells
   `build --no-cache -p compiler`, so both stages opt in identically and the
   `.ll` fixed-point hash-diff is unaffected. `--check-determinism` likewise:
   the compiler's own link line does not change.

No `needs-seed-cut` label, no `## Required in pinned seed:` line.

---

## 9. Risks

| Risk | Assessment / mitigation |
|---|---|
| **`strip_safe` conflation** (§2.2) turns the fix into a de-optimisation plus a per-build warning | Highest-probability implementation error. §4.3 restructure is mandatory; the new test's relative-size assertion (`unrooted < rooted`) catches it immediately. |
| A runtime symbol is genuinely needed but statically unreferenced | No `dlopen`/`dlsym` exists in the tree; ctors are `.init_array`-rooted by every supported linker. The failure mode is a loud undefined symbol or crash, never silent miscompilation. Blast radius is wide but the detector is `make check`, which the issue already mandates. |
| macOS `-dead_strip` over-collects where GNU `--gc-sections` does not | Ordinary Darwin builds also lose their roots. Covered by the macOS `make check` leg. If something breaks, fix the specific symbol (e.g. an explicit reference or `used` attribute) — do **not** default the gate to `true` on Darwin; that forfeits the win on a whole platform to paper over one symbol. |
| Absolute byte threshold flakes across hosts/linkers | Relative assertion is primary; the absolute ceiling is Linux-gated and generous (167,256 B against a measured 43,608 B). |
| A future second provider surface forgets the key | Fails loudly at whatever assertion motivated it, at the time it is written — not silently at size, which is (b)'s failure mode. |
| `retain-runtime-symbols` becomes a public schema commitment | Document it as advanced/rare in the `[build]` table. It is a link-policy knob, not a language feature; it does not belong in `docs/status.md`'s feature matrix or a spec chapter. |

---

## 10. Flags — things that make this different from a clean 3-point fix

Four, in descending order of how much they matter to whoever picks this up.

1. **SFN-860 will not recover the 1.93x CI regression, and the issue title
   claims it will.** The RCA's own "Where the time actually goes" section is
   explicit: linking is 0.09 s at HEAD vs 0.08 s pre-regression, and the 16 s
   per-build delta is the **front end** — 102 `.sfn-asm` emits vs 33, i.e.
   SFN-861 (emit cache gate) and the closure width. Root scoping changes
   `link_flags` only; it does not narrow the emitted closure by one module. The
   issue's acceptance criteria are correctly size-based, but its title, its
   Goal ("recovers a measured 2x CI regression"), and the SFN-860 row in the
   RCA's tracked-work table all promise wall-time that this change cannot
   deliver. **Recommend restating the issue's Goal before pickup** so the PR is
   not reviewed against a target it was never going to hit. What it does
   deliver: binaries ~74% below the pre-regression size, one fewer `nm`
   subprocess per non-provider link, and a policy that stops compounding.
2. **The `sfn test` link path never stripped or rooted** (§2.3). Test binaries
   — the bulk of what CI produces — see no change. Adding `--gc-sections`
   there is a separate, riskier question (the test registry uses ctors) and is
   out of scope.
3. **The durable fix for the emit width is upstream of both.** `docs/status.md:336-359`
   records that the SFEP-0070/SFN-833 import-reachable filter already runs on
   the build path but yields nothing for `sfn/crypto`, because that capsule's
   barrel re-exports its whole surface; **SFN-834** (re-export name narrowing)
   is the change that would actually shrink the 102-module closure. Separately,
   every binary compiles all 33 runtime `sfn-sources` from
   `runtime/capsule.toml:46-81` regardless of use — demand-driven runtime
   module selection is the deeper lever and has no issue yet. Worth naming in
   the RCA's tracked-work table.
4. **Scope creep to resist.** The manifest key invites a general
   `[build] link-roots = [...]` schema, and the `strip_safe` restructure invites
   refactoring `_clang_link_multi_with_opt`'s nine-argument signature into a
   `LinkOptions` struct. Both are defensible and neither belongs here. If either
   feels necessary mid-implementation, that is a pause-and-present moment.

Estimate holds at **3 points**, with the new e2e test the largest single chunk
and `make check` (15–20 min) on the critical path.
