# Public-Claims Inventory — Sailfin 0.8 Technical Preview

- **Date:** 2026-07-24
- **Issue:** SFN-461
- **Source of truth:** `docs/status.md` (2026-07-24; capsule version `0.8.0`, seed pinned
  `0.8.0-alpha.5`) plus, where a claim is factual rather than status-derived, the actual
  repository source (installer scripts, released GitHub tags).
- **Purpose:** classify every externally visible product claim across the public surface as
  **shipped**, **partial/experimental**, or **planned**, find contradictions before the 0.8
  technical-preview announcement, and either correct or track each one.

> This audit classifies claims. It does not change compiler/runtime behavior, and it does
> **not** weaken `docs/status.md` to match marketing copy — where copy and `status.md`
> disagree, `status.md` (verified against source) wins.

## Surfaces reviewed

| Surface | Files | Verdict |
|---|---|---|
| Homepage / positioning | `site/src/pages/index.astro`, `why.astro` | Contradictions (fixed in-PR) |
| Community / legal | `community.astro`, `license.astro`, `privacy.astro`, `terms.astro` | Clean |
| Downloads / install / verify | `dl.astro`, `getting-started/{install,verify-download,editor-setup,hello-world,tour}.md` | Contradictions (2 security fixes in-PR; rest → SFN-470) |
| Roadmap | `site/src/pages/roadmap.astro` | 1 stale item (fixed in-PR) |
| Docs landing + learn paths | `docs/index.md`, `learn/*` | Heavy drift → **SFN-467** |
| Reference + advanced | `reference/*`, `advanced/*` | Drift → **SFN-468** |
| Blog | `blog/welcome.md`, `blog/capability-seal.md` | welcome.md dated → **SFN-469**; capability-seal.md **clean** |
| README / examples | `README.md`, `examples/README.md` | README accurate; examples 1 fix in-PR + tags → SFN-470 |
| Spec / preview chapters | `reference/spec/*`, `reference/preview/*` | Clean (correctly labeled) |

## Severity legend

- **CONTRADICTION** — copy asserts something `status.md`/source proves false (either direction).
- **OVER-CLAIM** — presents planned/partial/removed as shipped.
- **UNDER-CLAIM** — presents a shipped feature as planned/absent (still a truth defect; misleads and undersells).
- **SOFT / POSITIONING** — defensible but launch-sensitive wording; owner decision.
- **UNVERIFIABLE** — not settleable from `status.md` or in-repo source (external verification needed).

---

## A. Contradictions fixed in this PR (verified)

| Claim (file:line) | Wording | Reality (evidence) | Fix |
|---|---|---|---|
| `install.md:58-63` | "install script … does not currently verify the release signature. This first install is TLS-trust only." | **FALSE.** `install.sh` (L203-279) downloads `SHA256SUMS`+`.sig`, verifies the Ed25519 signature with the embedded key and the SHA-256 digest, and `die`s on failure — warn-and-continue only when the manifest is absent or OpenSSL lacks raw-Ed25519 (matches `status.md` Release-signing, SFN-204). | Rewrote the note to describe the shipped verify-before-extract behavior. |
| `verify-download.md:143-150` | "the scripts do **not** currently verify `SHA256SUMS.sig`. That first bootstrap is therefore TLS-trust only." | **FALSE**, same as above (`install.ps1` L150-226 mirrors it). | Rewrote the "Bootstrap trust boundary" section. |
| `why.astro:26` | "// Missing ![net] — once effect enforcement ships, this will be a compile error" | Effect enforcement is a **shipped build gate** for `io`/`net`/`clock` (`status.md`: `validate_effects()` fails the build). | Present-tense: the effect checker rejects it at compile time. |
| `why.astro:32-34` | "effect checker can detect these violations today; wiring it into the compilation gate … is the next milestone on the roadmap" | Build-gate enforcement + cross-module propagation (`E0402`) are shipped. | Rewrote to shipped gate; runtime **syscall seal** is the 1.0 item, not the build gate. |
| `why.astro:49-50` | "once enforcement ships as a compilation gate, it becomes a build error" | Shipped. | Present-tense. |
| `why.astro:103` | "network, file system, or **model** access must declare those capabilities" | `model` is **Reserved** (no detector). | Listed the enforced effects (`io`/`net`/`clock`); dropped `model` from the enforced list. |
| `tour.md:521-524, 565-569` | "`Affine<T>`, `Linear<T>`, `PII<T>`, `Secret<T>` all parse and type-check, but **none** of the additional guarantees are enforced yet." | `status.md`: Affine/Linear **single-use enforced** (`E0901`/`E0904`/`E0907`); ownership checker ships. Only `PII`/`Secret` (and `&T`/`&mut T`) are parse-only. | Split the two: Affine/Linear single-use enforced today; PII/Secret parse-only. |
| `examples/README.md:130` | "the `![model]` effect **is enforced**, but the model backend is metadata-only" | `model` is Reserved — declarable + propagates (`E0402`) but no detector. | "declarable and propagates … but not detector-enforced". |
| `roadmap.astro:175` | "Release pipeline hardening — **signed checksums**, installer CI, self-hosted-only artifacts" (status: planned) | Signed Ed25519 `SHA256SUMS` + verifying installers are **shipped**. | Moved "signed checksums (shipped)" out of the planned bundle. |
| `docs/status.md:676` (Installer) | "Current release: `v0.7.0-alpha.39`" | A real non-prerelease **`v0.8.0`** is published (GitHub Releases); capsule version is `0.8.0`. The source-of-truth doc was itself stale on the audit's own version. | Updated to `v0.8.0`. |

## B. Contradictions / drift tracked to Ready follow-ups

### SFN-467 — learn/ path feature-status drift (heaviest cluster)

Both directions; several learn pages also contradict each other.

- **OVER-CLAIM** `learn/functions.md:623` "`async fn` and `await` are both shipped … awaiting a future unwraps its value" — `async fn` is structural-only; awaiting an `async fn` return is **not** wired into the live typecheck. Use `spawn fn() -> T { }` + `await`. (`:614` "returns a `Future<T>`" — shipped handle type is `Task<T>`.)
- **OVER-CLAIM** `learn/testing.md:470-492` "`model` and `prompt` blocks parse correctly today but do not execute" — the keywords were **removed**; they do not parse.
- **UNDER-CLAIM** `learn/functions.md:636` routine/spawn/channel "on the roadmap" — ship v0.
- **UNDER-CLAIM** int/float "single numeric type, split on the roadmap" (`basics.md:121-131`, `types.md:17`, `functions.md:27`) — shipped (`number` = alias for `float`).
- **UNDER-CLAIM** `learn/ownership.md:15,281,352,541-544` Affine/Linear "syntax only / not enforced" — single-use enforced.
- **UNDER-CLAIM** `learn/testing.md` "no `beforeEach`/`afterEach`" (`:390`), "`--filter` not supported" (`:236`), "`assert_*` on the roadmap" (`:96`) — hooks, `-k`, and the assert/expect tiers all ship.
- **CONTRADICTION (syntax)** `learn/types.md:961` `|x| x * 2` pipe-closure (no such syntax); `learn/functions.md:528-534` `match` colon-arm form — canonical is `fn(x) => expr` and `=>` arms.
- Cross-page inconsistency: closure capture "on the roadmap" (`functions.md`) vs "ships today" (`effective-sailfin.md`).

### SFN-468 — reference/ + advanced/ drift

- **OVER-CLAIM** `advanced/ai-constructs.md:18,21` `![model]` "Enforced today" / "a real, enforced capability" — Reserved.
- **UNDER-CLAIM** `reference/keywords.md:622-639` Affine/Linear "Parsed only" — single-use enforced. Intra-file contradiction: `extern` "Status: Parsed" (`:696`) vs "Status: Implemented" (`:214`).
- **UNDER-CLAIM** `advanced/ffi.md:13,42,79,135,261,285-293` unsafe/extern + Linear/Affine "not enforced, planned for 1.0" — `extern fn` shipped (`E0801`–`E0805`); the `extern`-escape boundary (`E0906`) and Affine/Linear single-use are enforced.
- **STALE** `reference/runtime-abi.md:160-205,362-378` present-tense live C runtime (`sailfin_runtime.c`) — the C runtime was deleted (#822); runtime is pure Sailfin.
- **INTERNAL** `advanced/capsules.md:501` registry "live at pkg.sfn.dev" vs `:523-555` `sfn publish` "planned" — reconcile.

### SFN-469 — dated blog (welcome.md, 2026-03-29)

- **UNDER-CLAIM** `:25` "Structured concurrency (planned)" — v0 ships. `:29` "migrating the runtime from C to Sailfin" — complete (#822). (`capability-seal.md` is accurate.)

### SFN-470 — positioning + external verification

- **SOFT/POSITIONING** `dl.astro:155,202` "Stable: v0.8.0" — GitHub flags `v0.8.0` non-prerelease, so the label is technically sourced, but "Stable" for a 0.x technical preview overstates maturity. Product decision. (The `0.8.0` command examples target a real tag — valid.)
- **UNVERIFIABLE** example `model`-effect tags (`examples/README.md:48,88,108`); official VS Code Marketplace extension existence (`editor-setup.md:11-15`); canonical docs domain `sailfin.dev` vs `sfn.dev` for the signing-key well-known URL.

## C. Soft over-claims noted, not fixed (marketing-owner call)

- `index.astro:59` (Supply-Chain card) "no hidden network calls, no surprise file access" — true at the **declared/compile-time** level; the runtime syscall seal is a 1.0 target. Defensible positioning; flagged for the marketing owner.
- `index.astro:51`, `why.astro:85-87` "suitable for performance-critical infrastructure" — production-adjacent for a pre-1.0 alpha; no explicit "production-ready/stable" string appears anywhere (a positive finding).
- `why.astro:122-124` "Sailfin guarantees capability safety" — a genuine *compile-time* guarantee; acceptable parallel to "Rust guarantees memory safety," but watch that it isn't read as a shipped runtime seal.

## D. Clean surfaces (positive findings)

- `blog/capability-seal.md` — states the runtime seal "is also not shipped yet" / "a hard 1.0 gate"; scopes the shipped claim to *compile-time* enforcement; admits the LLVM/clang last-mile dependency. No fix.
- `reference/effects.md` — canonical effects table matches `status.md` exactly (`model` Reserved, `gpu` parsed-only, `rand` at the crypto entropy boundary, runtime seal a 1.0 target).
- `README.md` — correctly frames LLVM/clang/OpenSSL as required build-host deps ("LLVM/clang independence is a project goal, not the current shipping state"), self-hosting from a seed, runtime seal a 1.0 target.
- `getting-started/install.md` dependency sections, `tour.md` effect table + AI section, `verify-download.md` signing-key section, `reference/{cli,bench,standard-library}.md`, `advanced/workspaces.md`, `reference/preview/*`, `reference/spec/*` — accurate / correctly hedged.
- Community/legal pages — no product-capability claims.
- **No "production-ready" / "stable" / "1.0" / "battle-tested" string** appears on any audited page.

## E. Version & dependency consistency

- Public copy is internally consistent on `0.8.0` / `0.8.0-alpha.5` / "0.8"; no stray `v0.5.x`/`v0.7.x` strings surfaced in the audited pages.
- `v0.8.0` and `v0.7.0` exist as **non-prerelease** GitHub releases; the docs' `0.8.0` download/verify examples resolve to a real tag.
- The **LLVM/clang/OpenSSL** build-host dependency is disclosed correctly everywhere it appears — **no** page makes a false "no dependencies / self-contained toolchain" claim.
- `dl.astro:99` hard-codes `0.8.0` as a last-resort fallback (comment: "keep aligned with install docs") — a drift risk when `capsule.toml` advances; noted for the downloads owner.

---

## F. Claims SAFE to use in the 0.8 technical-preview announcement

Each is shipped and enforced per `status.md` (2026-07-24), verified against source where relevant:

1. **Compile-time effect enforcement is a build gate.** `io`, `net`, and `clock` effects are enforced today — an undeclared effectful operation fails the build (`validate_effects()`), with source spans and fix-it hints.
2. **Hierarchical sub-effects** (`io.fs`, `io.console`, `net.http`, `net.ws`) and **cross-module effect propagation** (`E0402`) are enforced; a caller inherits its callees' declared effects.
3. **Capsule capability cross-check** (`E0403`) and the **opt-in workspace capability envelope** (`E0405`/`E0406`, enforce-by-default) check declared capability surfaces at compile time.
4. **Self-hosting native toolchain.** The compiler is written in Sailfin and self-hosts from a released seed to a single native binary; stage2/stage3 emit byte-identical IR (verified fixed point).
5. **Pure-Sailfin runtime.** No C runtime and no Python participate in startup (`@main` entry; C runtime deleted, #822).
6. **Structured concurrency, v0.** `routine {}` (structured nursery, join-all), `channel()` (bounded MPMC), `spawn`/`await`, `parallel [...]`, and `Task<T>`/`join_all` run end-to-end on a real thread-pool scheduler.
7. **Result<T, E> + `?`**, closures with capture, the `fn(x) => expr` lambda short form, `int`/`float`, and array `.map`/`.filter`/`.reduce` (pointer-width int elements) ship.
8. **Release supply chain.** Every release publishes a signed `SHA256SUMS` + detached Ed25519 signature; the verify key is pinned in the `sfn` binary (`sfn version --signing-key`) and published; `install.sh`/`install.ps1` and `sfn toolchain install` verify signature + digest before extraction (fail-closed).
9. **Bounded ownership floor** (a soundness requirement, **not** a marketed pillar): Affine/Linear single-use and the `OwnedBuf` move/use-after-free/FFI-escape family are enforced on the native runtime.
10. **Package registry + toolchain management:** `sfn init/add/publish` (default `pkg.sfn.dev`), `[toolchain]` pin + gate, native `sfn toolchain install`, re-exec dispatch, `sfn fmt`/`check`/`test`/`bench`/`cache`/`symbols`.
11. **Std capsules (shipped):** `strings`, `json`, `crypto` (`![rand]` via `random_bytes`), `math`, `path`, `toml`, `fs`, `os`, `log`, `time`, `cli`, `bench`, `losses`; `tensor`/`layers`/`nn` (CPU); `http` and `net` are explicitly **partial**.

### Framing guardrails for the announcement

- Position 0.8 as a **pre-1.0 technical preview**, not production-ready/stable.
- The **three pillars** are effects, capability-based security, and structured concurrency. Ownership is a soundness floor, **not** a fourth pillar. AI is a post-1.0 library concern.
- The **runtime capability seal** (OS-boundary syscall enforcement) is **built but not shipped** — a 1.0 GA gate. Say "compile-time capability enforcement today; runtime seal targets 1.0," never a shipped runtime seal.
- Sailfin still **lowers through LLVM and links via clang + a platform linker + OpenSSL** — do not claim LLVM/clang independence.
- The `model`/`prompt`/`tool`/`pipeline` **keywords were removed**; only the reserved `![model]` effect remains, for the post-1.0 `sfn/ai` capsule. Do not present AI blocks as language syntax.

## G. Follow-up tracking (AC-3)

| Cluster | Disposition |
|---|---|
| Homepage effect-enforcement staleness, tour ownership, examples model-effect prose, roadmap signed-checksums | Fixed in this PR |
| install.sh / verify-download signature-verification claim (security) | Fixed in this PR |
| `status.md` Installer "Current release" version | Fixed in this PR |
| learn/ feature-status drift | **SFN-467** (Ready) |
| reference/ + advanced/ status drift | **SFN-468** (Ready) |
| Dated blog posts (welcome.md) | **SFN-469** (Ready) |
| "Stable" download positioning + external verifications (VS Code ext, docs domain, example effect tags) | **SFN-470** (Ready) |
| Soft marketing over-claims (index.astro §C) | Noted for marketing owner; no code change |

No high-impact contradiction remains untracked: every item is either corrected in this PR or carried by a Ready follow-up above.
