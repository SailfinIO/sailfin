# SFN-1034 — Bootstrap installers fail closed

Single-issue design gate for SFN-1034. Governing design: SFEP-0073 §3.7 and
§3.9 slice 5. This note records the decisions; it does not restate the SFEP.

## Problem

`install.sh` and `install.ps1` fail closed correctly *once verification
starts* — malformed signature, failed verify, and digest mismatch all abort.
Only the two "cannot start" branches warn and continue, and that asymmetry is
the whole vulnerability: an attacker needs merely to *prevent verification from
starting*.

- `install.ps1:250-255` — OpenSSL absent → `return`, placed **before** the
  pure-.NET SHA-256 digest at `install.ps1:285-292`, which needs no OpenSSL.
  A missing OpenSSL therefore silently disables the digest check too.
- `install.sh:307-315`, `install.ps1:242-248` — any manifest/signature fetch
  failure (404, DNS, 5xx, rate limit, or an attacker serving 404 for
  `SHA256SUMS*` while serving a tampered archive) collapses into one silent
  "continue unverified" branch.
- `install.sh:361` computes the digest only via `openssl dgst`; there is no
  `sha256sum`/`shasum` fallback at all.
- Neither script has any positive signal for "this release must be signed".

## D-01 — Delete the OpenSSL version gate; replace it with a known-answer test

Both scripts decide "can this host verify?" by regex-matching `openssl version`
(`install.sh:320`, `install.ps1:252`). The pattern `^OpenSSL (1\.1\.1|[2-9])`
is wrong: `pkeyutl -rawin` arrived in OpenSSL 3.0, so the gate admits a
toolchain that then fails the verify and reports a *signature* failure for a
missing flag. `.github/actions/sailfin-build-windows/verify-release-seed.ps1`
already documents this discrepancy.

Replace the version check with a functional self-test. Before any candidate
verifier is trusted with the release signature it must pass RFC 8032 §7.1
TEST 2, embedded in the script:

- public key `3d4017c3e843895a92b70aa74d1b7ebc9c982ccf2ec4968cc0cd55f12af4660c`
- message `0x72`, signature `92a009a9…bb0c00` → must verify **true**
- the same signature against message `0x73` → must verify **false**

Both assertions are mandatory. Without the negative half, a verifier stub that
always exits 0 passes the probe — precisely the failure this issue closes.
A candidate that fails either assertion, or errors, is discarded and the next
is tried. This gates all verifier implementations, removes the whole
"which version string" bug class, and works by capability rather than by
product name (LibreSSL, BoringSSL, AWS-LC).

## D-02 — Windows: the embedded verifier is the sole verifier

`install.ps1` gains a self-contained Ed25519 verify-only implementation and the
OpenSSL branch is **deleted**, not demoted to a fallback.

Rationale: CI runs `windows-latest`, which carries OpenSSL 3.6.3; a stock
Windows 11 host does not. Preferring OpenSSL when present means CI exercises
the path no user runs and nothing exercises the path every user runs — the
current defect relocated rather than fixed.

Measured on a stock Windows 11 host (Windows PowerShell 5.1.26100, no OpenSSL):
RFC 8032 vectors 1 and 2 verify true in 364–462 ms, a tampered message verifies
false, and the **real published `v0.10.4` `SHA256SUMS` verifies against the
pinned production key in 450 ms** with a one-byte tamper correctly rejected.

Implementation constraints (`#Requires -Version 5.1`, so .NET Framework 4.x):
`System.Numerics.BigInteger`, `System.Security.Cryptography.SHA512`/`SHA256`,
`[Convert]`, `[BitConverter]` only. No .NET Core-only surface.

The verifier runs the D-01 KAT on itself before use. A self-implemented
verifier without a self-test fails *open* if the arithmetic is wrong, which is
worse than no verifier.

`install.ps1` becomes hermetic: no external dependency but `tar` (in-box since
Windows 10 1803, already relied on at `install.ps1:315-318`). The pinned trust
anchor at `install.ps1:50-54` changes from PEM to the raw 32-byte hex constant
`c317207101f06c10a341656e906e95d6e7199fcaa85d9c793455b07d740a44b9`, matching
`compiler/src/release_trust.sfn`.

## D-03 — POSIX requires a KAT-passing OpenSSL

`bash` has 64-bit signed arithmetic and nothing else. Perl/`Math::BigInt`,
`bc`, and "extract and let the new `sfn` verify itself" are all rejected — the
last one executes unverified code to decide whether to trust it. Python is not
considered: absent or a stub on stock macOS and on minimal containers.

The asymmetry is stated rather than hidden: **Windows gets a hermetic verifier
because .NET ships BigInteger and SHA-512; POSIX gets a dependency requirement
because bash ships neither.** `install.sh` already hard-requires `jq`
(`install.sh:74`), a heavier and less universally present dependency than
OpenSSL, so this is one more row in an existing list.

## D-04 — POSIX verifier probe chain

In order, each candidate gated by D-01's KAT, first pass wins:

1. `$SAILFIN_OPENSSL`
2. `openssl` on `PATH`
3. `/opt/homebrew/opt/openssl@3/bin/openssl`
4. `/usr/local/opt/openssl@3/bin/openssl`
5. `"$(brew --prefix openssl@3 2>/dev/null)"/bin/openssl`

The Homebrew keg paths are load-bearing: `openssl@3` is keg-only, so on a Mac
with Homebrew `openssl` on `PATH` resolves to Apple's LibreSSL while a working
OpenSSL 3 sits unlinked in the cellar. Probing the keg turns "works if you know
to fix your PATH" into "works".

## D-05 — Trust states

| State | Reached by | Opt-in |
|---|---|---|
| `VERIFIED_SIGNED` | Ed25519 signature over `SHA256SUMS` verifies against the pinned key, **and** the asset's manifest digest matches the bytes | none — the only state a network install may reach silently |
| `DIGEST_PINNED` | `SAILFIN_LOCAL_ARCHIVE` whose SHA-256 matches a caller-supplied `SAILFIN_LOCAL_ARCHIVE_SHA256` | none; reported as "digest-pinned, not signature-verified" |
| `UNVERIFIED_EXPLICIT` | (a) local archive with no supplied digest, (b) a release publishing no `SHA256SUMS`/`SHA256SUMS.sig`, or (c) **no KAT-passing verifier available** | **`SAILFIN_ALLOW_UNVERIFIED=1`** |

Everything else aborts. `SAILFIN_ALLOW_UNVERIFIED=1` is consent to install an
artifact whose *signature chain cannot be established*. It never bypasses a
check that could have run: a failed signature, a digest mismatch, a malformed
signature or manifest, or a missing/duplicate asset entry all abort regardless.

Case (c) is a deliberate widening of the architect's original design, taken at
the project owner's direction (2026-08-22). SFEP-0073 §3.7 treats an
unavailable verifier as a hard failure and scopes the loud opt-in to historical
unsigned releases; this note extends the same opt-in to an unavailable
verifier. The security property that matters is preserved: an attacker who
strips `SHA256SUMS` from the wire cannot supply the user's consent, so the
downgrade attack still fails closed. The residual risk is a user who habitually
exports the variable — the same tradeoff the SFEP already accepts for
historical unsigned releases.

**In state `UNVERIFIED_EXPLICIT` the digest check still runs** wherever a
digest tool is available, and a mismatch still aborts. This is acceptance
criterion 2 ("POSIX digest verification runs with no OpenSSL installed through
an available native digest tool and fails closed on a mismatch"). Its output
must be phrased as *matched an UNSIGNED manifest — this is not a trust
statement*, and the terminal state remains `UNVERIFIED_EXPLICIT`.

`DIGEST_ONLY` is **not** a permitted state. An unsigned manifest fetched over
the same channel as the archive is not evidence against an adversary who
controls that channel — they rewrite both. Reporting "digest verified" there is
a false integrity claim, and is the shape of the present bug.

There is **no key-override environment variable, ever**. An env var that swaps
the trust anchor is a one-line social-engineering exploit.

## D-06 — "Modern release" chooses wording, never enforcement

Inferring "modern" from the presence of `SHA256SUMS.sig` hands the attacker the
downgrade: they omit the file. Inferring it from the version is only half a fix,
because the version is attacker-influenced whenever `VERSION=latest` resolves
through the same API.

**Enforcement is therefore version-independent: a missing manifest or missing
signature aborts, always, unless `SAILFIN_ALLOW_UNVERIFIED=1`.** No branch on
version, no branch on presence.

A constant `SAILFIN_SIGNING_FLOOR="0.8.0"` exists **for diagnostics only**,
selecting between two messages (below floor: "predates release signing, first
signed release v0.8.0-alpha.4"; at or above: "must publish `SHA256SUMS.sig`,
but the fetch returned 404 — either a broken release or an attempt to strip
verification"). Because the floor is diagnostic, a naive `MAJOR.MINOR.PATCH`
comparison ignoring prerelease is sufficient; no semver prerelease ordering
logic is needed in either script.

## D-07 — Verification announces itself

`verify-release-seed.ps1:150-154` already records why: `install.ps1`'s
equivalent is silent on success, so establishing whether it verified anything
took log forensics rather than reading a line. Both installers emit stable,
greppable lines on the happy path:

```
verified: SHA256SUMS ed25519 signature (verifier: powershell-ed25519)
verified: sailfin_0.10.4_linux_x86_64.tar.gz sha256 <hex>
```

and in the opt-in state a block prefixed `WARNING: UNVERIFIED INSTALL` naming
exactly what was not checked. These strings are a contract consumed by the
smoke tests (D-11); they are what converts "verification ran" from an
assumption into an assertion.

## D-08 — Order: verify metadata → fetch payload → verify payload

Today the archive is downloaded (`install.sh:281-291`) before verification
(`install.sh:369-375`). Verifying the manifest first means a stripped signature
aborts before a large download and the code reads in trust order.

1. Resolve version / tag / asset (unchanged).
2. Fetch `SHA256SUMS`. 404 → abort (D-06 wording). Transient → retry 3× with
   backoff, then abort.
3. Fetch `SHA256SUMS.sig`. Same policy.
4. Select and KAT-gate a signature verifier. None → abort (D-10), unless
   `SAILFIN_ALLOW_UNVERIFIED=1` (D-05 case c).
5. Verify the signature over the manifest bytes. Malformed hex → abort.
   False → abort ("tampering").
6. Parse the manifest; require **exactly one** entry for the asset with a
   well-formed 64-hex digest. Zero or >1 → abort.
7. **Now** download the archive.
8. Select and KAT-gate a digest tool (D-09). None → abort.
9. Compute and compare. Mismatch → abort and unlink the archive.
10. `tar -tzf` listing validation, then extract (unchanged).
11. Emit D-07's confirmation lines.

Nothing is created under `INSTALL_BASE`/`GLOBAL_BIN_DIR` before step 10; that
invariant is already true and must survive the reorder. The `-msvc` asset probe
(`install.sh:216-236`, `install.ps1:198-213`) stays exactly where it is.

## D-09 — Digest-tool probe order

**POSIX:** `sha256sum` → `shasum -a 256` → `<selected openssl> dgst -sha256 -r`
→ none ⇒ abort. Each candidate is KAT-gated on a fixed input
(`"abc"` → `ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad`)
**including output-field position**, because the tools disagree on format.
Always pass `-r` to `openssl dgst`; without it the output is `SHA256(f)= <hex>`.
Naming a LibreSSL `openssl` as a *digest* candidate is correct even though D-04
rejects it as a *signature* verifier — SHA-256 is not the capability it lacks.

**Windows:** `[System.Security.Cryptography.SHA256]` streaming only, already
present at `install.ps1:285-292`. No probe, no fallback. Do not add `certutil`
or `Get-FileHash`.

## D-10 — POSIX remediation text

The no-verifier abort must name every candidate tried and why each failed, then
give per-platform remediation (`brew install openssl@3`,
`apt-get install openssl`, `dnf install openssl`, `export SAILFIN_OPENSSL=…`),
the `SAILFIN_ALLOW_UNVERIFIED=1` opt-in and what it forfeits, and a link to
the manual verification page. Listing what each candidate was and why it failed
is the difference between a 30-second fix and a filed issue.

## D-11 — Smoke tests

**Rule boundary.** `.claude/rules/no-bash-e2e.md` governs `compiler/tests/e2e/`
— the `sfn test` suite. `installer-smoke.yml` exercises shell and PowerShell
*before any `sfn` exists on the host*; the artifact under test is the script
itself and there is no compiler to run `sfn test` with. It is **outside** that
rule's boundary. Nothing here lands under `compiler/tests/`.

**Enabling change:** both installers gain `SAILFIN_RELEASE_BASE`, overriding
the hardcoded release URL (`install.sh:272`, `install.sh:301`,
`install.ps1:240`), mirroring the native `SAILFIN_TOOLCHAIN_RELEASE_BASE`.
SFEP-0073 §3.7 licenses it: "Mirrors may change location, never verification."

**No test keypair is needed.** Seed a local mirror from the real pinned
release, then mutate:

| Fixture | Mirror serves | Required outcome |
|---|---|---|
| F1 happy | real trio | exit 0; both `verified:` lines; binary runs |
| F2 missing manifest | 404 on `SHA256SUMS` | non-zero; message names the release |
| F3 missing signature | manifest, 404 on `.sig` | non-zero; D-06 wording; nothing installed |
| F4 bad signature | one byte flipped in `.sig` | non-zero; "signature verification failed" |
| F5 tampered archive | real manifest + real sig, one byte flipped in archive | non-zero; "digest mismatch"; nothing installed |
| F6 opt-in | F3's mirror + `SAILFIN_ALLOW_UNVERIFIED=1` | exit 0; `WARNING: UNVERIFIED INSTALL`; no `verified: … signature` line |
| F7 no verifier (POSIX) | real trio, `PATH` scrubbed of openssl | non-zero with D-10 text; with the opt-in set, exit 0 and the digest still checked |

F4 and F5 are the sharp pair: F4 proves the signature check is live, F5 proves
the digest check is live *given a genuine signature* — acceptance criterion 8.

On Windows the no-verifier case is structural: after D-02 there is no OpenSSL
path, so every Windows fixture run is the no-OpenSSL case. Assert on
`verifier: powershell-ed25519` so a regression reintroducing an OpenSSL
shortcut turns the leg red. **At least one Windows fixture must run under
`powershell.exe` (5.1), not `pwsh`** — the current job is `shell: pwsh`
throughout, so the declared floor is otherwise untested.

Highest-value single change: add a grep for the two `verified:` lines to the
existing published-release installs (`installer-smoke.yml:118-139`, `:230-258`).
That job asserts nothing about verification today, so a regression that always
takes the warn branch is green.

## D-12 — `verify-release-seed.ps1` is not extracted into a shared helper

`install.ps1` is delivered by `irm | iex` and must stay one self-contained file
with no repo checkout, so there is no import mechanism to share with a CI
script that reads its key from disk. Forcing sharing would require a build step
for a bootstrap script. Instead: correct the now-false comment at
`verify-release-seed.ps1:12-17`, and converge it onto the embedded verifier in
a separate follow-up (SFN-1093) so CI and users exercise identical arithmetic.

## D-13 — CI consumer migration lands in the same PR

`ci.yml:1329-1354` passes `SAILFIN_LOCAL_ARCHIVE` and would newly need consent.
Do **not** paper over it with `SAILFIN_ALLOW_UNVERIFIED=1`: that step just built
the archive and can hash it, so pass `SAILFIN_LOCAL_ARCHIVE_SHA256` and land in
`DIGEST_PINNED`, turning an opt-out into a real end-to-end test of the digest
path. `SAILFIN_ALLOW_UNVERIFIED` should appear in exactly one place in the
repo: fixture F6.

## D-14 — No self-host gate, no seed interaction

Nothing here touches `compiler/src/`, `compiler/capsules/`, or `runtime/`. No
`make compile`, no `sfn fmt`, no seedcheck, no `.claude/rules/seed-dependency.md`
decision, no `seed-blocker`, no `/pin-seed`. The pinned seed `0.10.4` is signed,
so the stricter installer can still fetch it. `installer-smoke.yml` is the
validation rung and triggers on PR for installer changes.

## Rejected

- **`ssh-keygen -Y verify` for Windows.** Not merely fragile —
  cryptographically impossible. `PROTOCOL.sshsig` signs
  `"SSHSIG" || namespace || reserved || hash_algorithm || H(message)`, not the
  message bytes; our signature is Ed25519 over the raw manifest. A raw-message
  signature cannot be repackaged into an SSHSIG blob because the signed
  preimage differs. Serving such hosts would require the release producer to
  publish a second signature format.
- **`DIGEST_ONLY` as a trust state.** See D-05.
- **A trust-anchor override environment variable.** See D-05.
- **Warn-and-continue on macOS.** Forbidden by name in SFEP-0073 §3.7 and
  incompatible with three of SFN-1034's acceptance criteria. Replaced by
  D-05 case (c)'s loud opt-in.

## Risks

- **R-1 — `macos-26` may have no KAT-passing OpenSSL.** Apple ships LibreSSL as
  `/usr/bin/openssl` and Homebrew's `openssl@3` is keg-only. Answered by the
  PR's own CI, provided D-07's verifier-name line lands first in the diff. If
  macos-26 fails, the fix is `brew install openssl@3` plus `$GITHUB_PATH`,
  beside the existing `brew install jq llvm`. Green on macos-26 does **not**
  prove a bare Mac works — the runner has Homebrew — so the fixture must also
  KAT `/usr/bin/openssl` in isolation and print the verdict.
- **R-2 — a subtly wrong embedded verifier fails open**, which is worse than
  today's honest warning. Gated by D-01's mandatory positive+negative KAT, F4
  and F5, and the real-release vector. The PR must paste both RFC 8032 and
  real-release results.
- **R-3 — the D-08 reorder perturbs asset resolution.** `install.sh:216-236`
  and `install.ps1:198-213` carry hard-won `-msvc` fallback logic (SFN-798,
  SFN-1033) and a deliberately non-fatal API lookup at `install.sh:186-190`.
  Gate: the existing msvc PE-import assertion at `installer-smoke.yml:288-295`
  staying green.
- **R-4 — 404 and transient failure are indistinguishable today.**
  `curl --fail` returns non-zero for both. Adopt `verify-release-seed.ps1`'s
  policy: capture `%{http_code}`, never retry 404, retry others 3× with backoff.
- **R-5 — `SAILFIN_RELEASE_BASE` as attack surface.** Contained: verification
  is unconditional and the anchor is not overridable. Document as
  location-only; reject any companion key override.
- **R-6 — `#Requires -Version 5.1` must keep holding.** Gated by the parse
  check plus a `powershell.exe` (not `pwsh`) fixture leg.
