# SFN-341 — Native TLS runtime swap: routing SFEP-0048 Phase D

Implementation design gate (per `.claude/rules/proposals.md`: this routes an
already-Accepted SFEP's remaining phase into deliverable slices — it is not a
new forward-looking design, so no SFEP number). Design record for the chain
that lands SFEP-0048 Phase D.

- **Issues:** SFN-766 (D0), SFN-767 (D1), SFN-768 (D2), SFN-769 (D3),
  SFN-341 (D4)
- **Author:** agent:compiler-architect
- **Status:** design-approved
- **Parent SFEP:** SFEP-0048 (`../0048-native-crypto.md`, Accepted) — this note
  routes its Phase D; it does not amend the SFEP's design.
- **Depends on pinned seed:** nothing new in the expected path; D0 is the gate
  that confirms it (§3.7, §5).

## 1. Summary

SFEP-0048 Phase D is recorded as one step: "swap the `tls_*` wrapper bodies
onto the native stack, delete the OpenSSL externs, drop `-lssl`/`-lcrypto`."
That framing was written when Phase B/C were hypothetical. Now that they have
landed, Phase D decomposes into five separable pieces, only one of which is
the swap itself:

1. the **reachability** problem — the native stack is in a `kind = "library"`
   capsule the runtime cannot import, and the runtime links into every binary;
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
headline conclusions: **vendor the cold path, re-express the hot path**; the
work is **~19 points across five issues**, not three points in one; and the
one-PR property SFEP-0048 §5 requires (swap + link deletion together, no seed
cut) survives the decomposition because every predecessor is purely additive.

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
import a library capsule; that no runtime sfn-source has ever used
`Result<T, E>` or `match`; that the handshake cannot authenticate any real
peer; that the record layer is ~1000x slower than what it replaces; and that
the server can no longer serve the RSA certificates every existing loopback
e2e generates. Each of those is a stop-and-regroom moment mid-PR.

## 3. Design

### 3.1 Reachability — why vendoring is forced, and what makes it cheap

Three constraints interact, all verified:

**(a) The `tls_*` definitions must be in the runtime link set.**
`adapters/http.sfn:111-121`, `concurrency/serve.sfn:184-192`, and
`adapters/websocket.sfn:120-130` reach the eight wrappers by `extern fn`
forward declaration, not by import. Those references are emitted into every
binary. `--gc-sections` runs after symbol resolution, so a referenced-but-
undefined `@tls_client_ctx` is a link error even in a hello-world that never
calls it — the mechanism `compiler/src/build/target.sfn:178-189` documents for
`ws2_32` under SFN-649. So the definitions cannot move into a capsule that is
only linked on demand.

**(b) Runtime modules are emitted unmangled; capsule modules are not.**
`compiler/src/llvm/lowering/lowering_helpers_mangling.sfn:146-150` returns
early for any module whose slug starts with `runtime/`, leaving its symbols at
their bare names. Capsule modules take the module-suffix path — verified in
build output as `@sha256_bytes__sfn__crypto__hkdf`
(`build/cache/v2/57/.../mod.ll:202`). Two consequences:

- Vendoring the capsule modules into `runtime/sfn/crypto/` produces *unmangled*
  `sha256_bytes`, which does **not** collide with the capsule's
  `sha256_bytes__sfn__crypto__hkdf`. A binary can link both copies. This is
  what makes vendoring viable at all.
- Within the runtime link set, every top-level `fn` shares one flat namespace.
  Across the 20-module TLS closure there are exactly **11 duplicated names**
  (`_append` ×4, `_slice` ×3, and `_byte_to_char`/`_hash_len`/
  `_is_supported_suite`/`_take_body`/`_text_err`/`_text_ok`/`_was_offered`/
  `_with` ×2 each), plus one collision against the existing runtime
  (`_append` in `adapters/http.sfn`). 527 distinct top-level symbols, 13
  collision instances. That is a mechanical rename, not a rewrite.

**(c) Pointing `sfn-sources` at `../capsules/sfn/crypto/src/*.sfn` is dead.**
Three independent reasons: `_runtime_module_slug`
(`compiler/src/build/runtime_objs.sfn:163-172`) only yields a `runtime/`-
prefixed slug when the source path has `manifest_dir + "/"` as a prefix, so a
normalized `<root>/capsules/...` path falls through to
`module_name_from_path` — precisely the case
`compiler/src/runtime_capsule_resolver.sfn:441-447` warns "defeat[s] the
runtime-relative slug derivation ... reintroducing the out-of-tree duplicate
`sfn_type_register` failure" (SFN-146). Second, `der.sfn:7` and `x509.sfn:8`
import `sfn/strings` as a bare capsule spec, which the runtime staging path
skips by construction (`runtime_objs.sfn:1195-1200`). Third, the same files
would be compiled twice into any binary that links both the runtime and
`sfn/crypto` — which includes the compiler itself
(`compiler/capsule.toml:59`) — under whichever symbol scheme applies.

**Route: vendor the cold path into `runtime/sfn/crypto/`, re-express the hot
path.** Cold path = 20 modules, 10,146 lines, byte-identical except for the 11
renames and the five `sfn/strings` call sites (`der.sfn:450-452`,
`x509.sfn:780,831-832`) inlined locally. Hot path = §3.3.

Modules NOT vendored: `mod.sfn` (public wrappers only), `rand.sfn` (the
runtime already owns `sfn_rand_fill` in `platform/rand.sfn`), `sha1.sfn`
(WebSocket-only, already re-expressed at `websocket.sfn:536-539`),
`chacha20.sfn` / `poly1305.sfn` / `aead_chacha20poly1305.sfn` (superseded by
the hot-path module, retained only as the differential-test oracle).

**Costs, stated plainly.** Runtime `sfn-sources` goes 31 → ~53 modules and
18,155 → ~30,000 lines. `compiler_identity` is in the runtime object cache key
(`runtime_objs.sfn:568,795`), so every runtime module is re-emitted on every
`make compile`; expect **+8-12% on self-host wall time** against a 5:28 CI
baseline already over the 5-minute target (SFEP-0006). Binary size for a
hello-world is unaffected — `--gc-sections` strips the whole closure once
`http.sfn` is dead — except for 11 `@llvm.global_ctors` entries and 29 type
descriptors (`llvm/lowering/type_descriptors.sfn:1-42`), which are not
strippable and run `sfn_type_register` before `main` in every binary. That is
a few KB and ~29 calls; acceptable, but it is a permanent floor.

**The drift hazard, and its mitigation.** Vendoring forks a tested source of
truth that is still moving. Mitigation is the `build/hash.sfn` precedent
(`compiler/tests/e2e/build_hash_matches_sha256sum_test.sfn`): a
`compiler/tests/e2e/runtime_crypto_vendor_sync_test.sfn` that hashes each
capsule module and its runtime twin modulo the documented rename map and
fails on divergence, plus a `docs/conventions/` note recording the rename map
as the single place the two copies are allowed to differ.

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
verification, both handshake state machines — stays `int[]`-vendored, because
it runs once per connection.

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
`openssl_absent_windows.sfn` retires and `runtime/ir/windows_stubs.ll:85-102`'s
six `tls_*` stubs delete, because the native stack needs no OpenSSL. Entropy
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

The entire vendored closure is built on `Result<T, string>`, `match`, generic
enums, structs with `int[]` and `X509Certificate[]` fields, `.push` growth,
and string concatenation in error paths. In principle the runtime path is the
same `sfn emit ... native` → `emit-llvm` pipeline capsules use, differing only
in the mangling bypass and the import-context staging — so it *should* work.
But `tls13_record.sfn:250-257` documents a miscompile in exactly this
territory (SFN-378: a `match` arm falling through into a nested `match`/`if`
reloads a sibling arm's binding and emits IR failing the LLVM verifier with
"Instruction does not dominate all uses"), which the capsule authors worked
around by hand.

SFN-378 is `Done`, so the defect is fixed on `main` — but `make compile`
self-hosts against the binary pinned by `bootstrap.toml [seed].version`, not
against `main`, and the in-source workaround is still present. Whether the fix
has reached the pinned seed is exactly the kind of question that is cheaper to
answer empirically than by archaeology, which is D0's job. Note also that the
capsule authors hit this class of bug on the *capsule* emit path; the runtime
path is the one with no `match` precedent at all, so a clean capsule build is
not evidence for it.

This is the single largest risk in the chain and it is invisible from the
issue title. It is de-risked by a one-point spike (§5, D0) that vendors four
small modules and proves `make compile` green — before 10,000 lines are
committed to the route.

## 4. Effect & capability impact

No change to the effect surface. `tls_read`/`tls_write`/`tls_connect_fd`/
`tls_accept_fd` already carry `![net]` and continue to; the vendored crypto is
pure. Two additions: `tls_client_ctx` gains `![io]` (it reads the trust bundle
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

**No compiler pass changes** in the expected path — every construct the
vendored code uses is one the pinned seed (`bootstrap.toml`, 0.9.1) already
compiles for capsule modules. The only question is whether the *runtime*
sfn-source emit path handles them, which D0 answers.

**No seed cut, in the expected path.** D0-D4 are purely additive: they add
runtime modules and capsule capability, remove nothing, and leave
`-lssl`/`-lcrypto` on the link line throughout. `make compile` builds the new
compiler from the old seed and that compiler compiles everything in the same
pass. D4 bundles the body swap **and** the link deletion in one PR, exactly as
SFEP-0048 §5 requires. **The one-PR property survives the decomposition.**

**The one branch that would force a seed cut:** if D0 shows the runtime emit
path cannot lower `Result`/`match`, the fix is a lowering change that
*runtime source* depends on. That is the structural carve-out in
`.claude/rules/seed-dependency.md` — the pinned seed compiles the working-tree
runtime, so bundling does not help. It would land alone, `seed-blocker`, and
D4 would wait on a seed cut. This is precisely why D0 runs first and alone.

| # | Issue | Slice | Where | Est. | Blocks |
|---|---|---|---|---|---|
| D0 | SFN-766 | Feasibility spike: vendor `bits`/`chacha20`/`poly1305`/`aead_chacha20poly1305` into `runtime/sfn/crypto/`, add to `sfn-sources`, `make compile` green, report build-time delta | runtime | 1 | D3 |
| D1 | SFN-767 | Capsule: real-world CertificateVerify + chain wiring (§3.4) | capsule | 5 | D4 |
| D2 | SFN-768 | Runtime: `*u8` record layer + measured throughput (§3.3) | runtime | 3 | D4 |
| D3 | SFN-769 | Runtime: vendor the 20-module cold path + rename map + drift test (§3.1) | runtime | 5 | D4 |
| D4 | SFN-341 | Runtime: the I/O driver + body swap + link deletion + platform/test/doc sweep | runtime | 5 | — |

(D3 renumbers around D0's spike; D0's four modules are subsumed.)

D1 is parallelizable with D0/D2/D3 — it touches only
`capsules/sfn/crypto/`. D4 is the single PR that deletes OpenSSL.

**Total: 19 points.** SFN-341's current 3-point estimate is wrong by roughly
6x, and the issue as scoped is not deliverable as one PR.

## 6. Alternatives considered

**Point `runtime/capsule.toml` `sfn-sources` at `../capsules/sfn/crypto/src/`
(no copy, one source of truth).** Rejected — three independent failures, all
verified: the slug derivation breaks (§3.1(c), SFN-146's recorded failure
mode); `sfn/strings` bare-capsule imports are skipped by runtime staging; and
the same modules would be linked twice into the compiler and into any user
program importing `sfn/crypto`. The single-source-of-truth benefit is real and
is the reason to invest in the drift test instead.

**Hand re-express the whole stack in the `*u8` idiom (SFN-338 applied
globally).** Rejected. SFN-338 re-expressed ~200 lines of SHA-1 + base64;
this is ~10,000 lines of security-critical code with no oracle for the parts
that were rewritten. §3.3 takes the useful 7% of this route — the per-byte
record layer, where the idiom actually matters and where a byte-exact
differential oracle exists.

**A new capsule `kind` that links like a runtime capsule.** Rejected as
premature: it is the same vendoring with more compiler surface, and it does
not solve the flat-namespace collision, the `sfn/strings` edge, or the
double-link problem. If a second consumer ever needs this, revisit.

**Narrow the mangling bypass so a `runtime/sfn/crypto/` subtree is mangled**
(`lowering_helpers_mangling.sfn:148`). Rejected for this cut. It removes the
11 renames, but an unmangled `tls.sfn` cannot then call a mangled provider
(the early return at :149 skips the import-rewriting pass entirely), so it
also requires reworking step 2 for runtime importers — and it is a lowering
change runtime source depends on, i.e. a forced seed cut, for a benefit of 11
renames. Revisit if the vendored surface grows much past this.

**Keep OpenSSL for TLS and seal around it.** Already rejected as SFEP-0048
§6.2 and unchanged: libssl calls libc directly and bypasses any Sailfin-owned
chokepoint.

## 7. Stage1 readiness mapping

No new syntax; the parse/typecheck/emit/lower rows are satisfied by existing
compiler support for the constructs used — **conditional on D0 confirming
that support extends to the runtime sfn-source emit path** (§3.7). Until D0 is
green, those rows are honestly "unproven," not "satisfied."

- [ ] Parses — no new syntax; D0 confirms for the runtime path.
- [ ] Type-checks / effect-checks — `![io]` added to `tls_client_ctx`;
      `![rand]` rides `![net]`.
- [ ] Emits valid `.sfn-asm` — D0 gate.
- [ ] Lowers to LLVM IR — D0 gate; SFN-378 is the known hazard.
- [ ] Regression coverage — §8.
- [ ] Self-hosts — `make compile` after each of D0-D4; `make check` before D4
      merges.
- [ ] `sfn fmt --check` clean — every new `runtime/sfn/crypto/*.sfn` and the
      rewritten `tls.sfn`.
- [ ] Documented — `docs/status.md` (the `sfn/crypto` row, the TLS row, and
      the Ed25519-server-cert narrowing), SFEP-0048 §3.1's Phase D row,
      `docs/runbooks/openssl-build-dependency.md` (retire),
      `docs/development-setup.md`, `install.sh`,
      `.github/actions/sailfin-build/action.yml`,
      `site/src/content/docs/docs/getting-started/install.md`.

## 8. Test plan

**D0.** `make compile` green with four vendored modules in `sfn-sources`;
reported wall-time delta.

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

**D3.** `compiler/tests/e2e/runtime_crypto_vendor_sync_test.sfn` — the drift
gate.

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
- Mangling boundary: `compiler/src/llvm/lowering/lowering_helpers_mangling.sfn:146-150`;
  slug derivation `compiler/src/build/runtime_objs.sfn:163-172`;
  SFN-146 warning `compiler/src/runtime_capsule_resolver.sfn:441-447`.
- RFC 8446 (TLS 1.3) §4 handshake, §5 record layer, §D.4 middlebox
  compatibility; RFC 8439 (ChaCha20-Poly1305); RFC 8017 §8.1 (RSASSA-PSS);
  RFC 6125 (hostname verification).
