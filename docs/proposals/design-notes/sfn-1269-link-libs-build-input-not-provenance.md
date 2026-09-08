# SFN-1269 — `link-libs` declares a build input, not provenance

Single-issue implementation design gate. Not an SFEP: SFEP-0006 §4.2 introduced
`link-libs` and SFEP-0016 §3.4–3.5 owns the future admission rule, so this note
only records the coexistence rule between the two, which
`.claude/rules/proposals.md` puts below the SFEP bar (the "single-issue design
gate" genre → `design-notes/`).

Issue: `SFN-1269` — "feat(build): honor `[build] link-libs` on the root capsule
so an application can link a foreign library" (type:feature, area:build, Medium,
3 points).

---

## 1. What shipped

`[build] link-libs` in the manifest of the capsule **being built** now reaches
the final link argv. Before, `toml_get_link_libs`
(`compiler/src/toml_parser.sfn:518`) parsed the key and
`_rcr_artifacts_from_manifest` (`compiler/src/runtime_capsule_resolver.sfn:718`)
dropped it on the floor for every `kind != "runtime"` capsule — no diagnostic, no
trace. That gate is unchanged; the root capsule's flags are resolved on the build
spec (`compiler/src/build/cache.sfn`) and merged at the two `LinkPlan`
construction sites instead.

Three properties, all load-bearing:

- **Root-capsule only.** A dependency's `link-libs` are ignored, with a
  `warning`-severity `E0627` naming the capsule.
- **Appended, deduplicated.** Root libs go after the runtime's own
  (`runtime/capsule.toml:110`), skipping anything already present, then flow
  through `_target_conditioned_plan` (`compiler/src/backend.sfn:392`) like every
  other lib. The existing argv is a prefix of the new one; with nothing declared
  it is byte-identical.
- **Both link routes agree.** `sfn build`/`sfn run` and `sfn test` share one
  merge helper, so a capsule cannot build and fail to test.

## 2. What root-only does and does not buy — stated honestly

It does **not** close a security hole, and must not be described as if it does.
`extern fn` over an arbitrary C symbol is already ungated for any capsule
(`site/src/content/docs/docs/advanced/ffi.md:91`: *"General extern-call gating is
not yet enforced."*). The only allowlist in the tree is the raw-syscall
intrinsic gate (`compiler/capsules/codegen-llvm/src/syscall.sfn:49-66`), which
has no bearing on ordinary externs. Nothing validates a capsule's declared
`[capabilities]` against what it links or calls.

What it buys is narrower and still worth having: **a dependency you pulled in
cannot silently add a linker input to your binary.** A dependency can still
declare `extern fn SDL_Init` and have it resolve against whatever the root
capsule chose to link. That is the pre-existing FFI surface, unchanged here.

This is also why a dependency's `link-libs` is a warning rather than an error:
the same manifest is legitimate when that capsule is itself the root. A
`kind = "library"` capsule's own `link-libs` reach the link of *its own* tests
and never its consumers' binaries — the propagation this rule exists to forbid.

## 3. The coexistence rule with the seal

SFEP-0016 §3.5 specifies `vetted-link-inputs` as the digest-authoritative
mechanism for foreign link inputs, and explicitly rules out *"wildcards, bare
linker flags, directories, SONAME-only entries, and an 'all system libraries'
escape hatch."* A bare `-lSDL2` is both a bare linker flag and a SONAME-only
entry.

**So `link-libs` must never be presented as provenance.** The rule:

> `link-libs` declares a **build input**, not provenance. It records that the
> author asked for a library by name. It does not record, and cannot record,
> what the host resolved that name to.

`vetted-link-inputs` is unimplemented — zero occurrences across `compiler/` and
`runtime/` — and blocked: SFEP-0016 §4.2 hole 4 makes sha256 its authority while
the compiler still computes sha256 by spawning a shell, so §3.5 has a hard
prerequisite on SFEP-0048's native hashing.

**The tier consequence.** A binary linking un-digested `link-libs` entries sits
**below provenance-sealed** (SFEP-0016 §3.1). When `vetted-link-inputs` ships, a
`link-libs` entry with no matching vetted entry is exactly what pins the artifact
below that tier. This is additive to §3.5, not a contradiction of it — but it is
only additive if written down, which is what this note is for.

## 4. Why this matters more than it did last week

Before this issue, every foreign link input in a default build was
host-provided: libc, libm, libpthread, libgcc, and the CRT objects. SFN-341
retired the last OpenSSL entry, so `runtime/capsule.toml:110` now reads
`link-libs = ["-lm", "-lpthread"]`.

A user-declared `link-libs` is therefore **the first user-controlled foreign link
input in the tree.** The admission rule in SFEP-0016 §3.4–3.5 now governs a
surface a user can actually widen, which is the reason it has to be *specified*
rather than deferred. SFEP-0016 §4.2 hole 3 was corrected in the same change to
say so, since its previous argument rested on an OpenSSL link that no longer
exists.

## 5. What this note does not decide

- **Digest machinery.** Out of scope, blocked on native hashing (§3).
- **Capability or effect gating of `extern fn`.** Pre-existing gap (§2), not
  touched.
- **`c-sources` / `include-dirs` for non-runtime capsules.** SFN-949 owns the
  C-compilation policy; this change moved `link-libs` only and deliberately did
  not weaken the kind gate for the other two keys.
- **Workspace-level inheritance** and `link-libs-add`/`link-libs-drop`
  conditioning for non-runtime capsules. A member's own manifest only.
