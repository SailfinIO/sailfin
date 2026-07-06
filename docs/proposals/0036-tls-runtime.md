---
sfep: 0036
title: "TLS termination + upstream TLS for the native runtime (OpenSSL)"
status: Implemented
type: runtime
created: 2026-06-29
updated: 2026-07-06
author: "agent:compiler-architect; human review"
tracking: "#1820, #1821, #1822"
supersedes:
superseded-by:
graduates-to: reference/standard-library.md
---

# SFEP-0036 — TLS termination + upstream TLS for the native runtime (OpenSSL)

> **Implemented (2026-07-05).** Shipped across #1782 (extern surface + HTTPS
> client), #1783 (inbound TLS termination in `serve`), #1784 (client cert
> verification + system CA trust store), and #1785 (loopback e2e); documented
> here at #1786. Graduates to `reference/standard-library.md`. Accepted at the
> grooming design gate (2026-06-29), decomposed into the issue table in §10, and
> filed as sub-issues of epic #1540. Gap **B1** of epic #1540 (MCP-proxy
> enablement). Extends, does not contradict, SFEP-0019 (`sfn/http`): TLS was the
> deferred "TLS, redirects" row of SFEP-0019 §4, promoted to a 1.0 blocker by
> the MCP-proxy hot path and now shipped.

## 1. Summary

Add TLS to the native runtime by linking OpenSSL (`libssl`/`libcrypto`) and
declaring a minimal, **callback-free** `extern fn` surface (`SSL_CTX_*`,
`SSL_*`) over the existing connected-`fd` socket layer. A new Sailfin body
`runtime/sfn/platform/tls.sfn` wraps an `fd` into an opaque `SSL*` handle and
exposes blocking `tls_connect_fd` / `tls_accept_fd` / `tls_read` / `tls_write`
/ `tls_shutdown` helpers. The HTTP **client** (`runtime/sfn/adapters/http.sfn`)
gains an `https://` path that TLS-wraps its connected socket; the **serve**
accept loop (`runtime/sfn/concurrency/serve.sfn`) gains an optional
TLS-termination mode that wraps each accepted connection before the
recv→dispatch→send cycle. TLS rides the existing `![net]` effect — no new
effect or capability. This is the single external-dependency item in epic #1540
and the last 🔴 blocker for the HTTP transport of the MCP proxy.

## 2. Motivation

There is **zero TLS anywhere** in the runtime or capsules today. The MCP proxy
(epic #1540) must, on its HTTP transport: (1) **terminate** an inbound HTTPS MCP
connection, and (2) open an **outbound** TLS connection to an upstream MCP
server. Both are impossible without a TLS implementation. A from-scratch
pure-Sailfin TLS stack (handshake state machine, X.509 parsing, AES/ChaCha,
curve math) is impractical pre-1.0 and would be a security liability — so B1 is
explicitly the one item in epic #1540 that links an external library.

The substrate already exists and is proven: BSD-socket externs
(`socket`/`connect`/`bind`/`listen`/`accept`/`send`/`recv`/`setsockopt`/`close`)
are declared and used in `runtime/sfn/platform/net.sfn`,
`runtime/sfn/adapters/http.sfn`, and `runtime/sfn/concurrency/serve.sfn`; DNS
(#1707), socket timeouts (#1581), and keep-alive (#1711) all shipped on top of
them. TLS sits one layer above a connected `fd`: replace the raw
`send(fd,…)`/`recv(fd,…)` syscalls on a connection with `SSL_write(ssl,…)` /
`SSL_read(ssl,…)` after a handshake. The "TLS, redirects" row of SFEP-0019 §4
deferred this as post-1.0; the MCP proxy promotes inbound+outbound TLS to a 1.0
hard gate.

The proxy parses MCP/JSON-RPC inline on a ~150 ms hot-path budget. OpenSSL's
record layer runs in C at line rate; the per-record overhead is negligible
against that budget and is not on the critical path of this design.

## 3. Design

### 3.1 Library choice — OpenSSL

**Recommend OpenSSL (`-lssl -lcrypto`).** Weighed against BoringSSL and mbedTLS:

| Criterion | OpenSSL | BoringSSL | mbedTLS |
|---|---|---|---|
| Ubiquity / present on host | Everywhere; `libssl.so.3` + headers confirmed present on this host (`/usr/lib/x86_64-linux-gnu/libssl.so`, `/usr/include/openssl/ssl.h`) | Rare as a system lib; usually vendored from source (needs a Bazel/CMake build) | Common but **not present on this host**; small/embeddable, easy to vendor |
| Link mechanism fit (`c-sources=[]`, no C build step) | Pure `-l` link via existing `link-libs` — zero new toolchain surface | Would need a vendored build → reintroduces a C/CMake build step the C-runtime retirement (#822) removed | `-lmbedtls -lmbedx509 -lmbedcrypto` if system-installed; vendoring re-adds a C build |
| API stability for opaque-handle externs | Stable, widely-documented `SSL_CTX_*`/`SSL_*` C ABI; the exact surface LLMs know | BoringSSL deliberately breaks API; moving target | Stable but a different (and less LLM-familiar) API shape |
| System CA trust store | `SSL_CTX_set_default_verify_paths` + `/etc/ssl/certs/ca-certificates.crt` (confirmed present) | Same family of calls | Manual CA file load; no default-paths convenience |
| Windows coordination (#1485 M10) | OpenSSL ships for Windows (vcpkg/Win builds); the **extern surface is identical** cross-platform — only the `-l`/link form and CA-store discovery differ per OS | BoringSSL on Windows = vendored build | mbedTLS builds on Windows but the API diverges from the proxy's reference shape |

Decisive factors: (a) OpenSSL is the **only** option installable as a pure `-l`
link without re-introducing a C/CMake build step — directly preserving the
`c-sources=[]` / no-C-runtime invariant (#822/#823); (b) its `SSL_CTX_*`/`SSL_*`
C ABI is the surface LLMs generate most reliably (a project design principle);
(c) the extern surface is **OS-independent**, so the #1485 M10 Windows work
reuses this exact `tls.sfn` body and only swaps the link form + CA-store path.
mbedTLS stays the documented fallback if a future static/embeddable build is
wanted (its small footprint is its only edge, and it loses on availability and
API familiarity here).

### 3.2 Callback-free integration (the load-bearing design choice)

The chief feasibility risk for any C-library extern surface is needing a
**Sailfin function passed as a C callback** — the `pthread_create`
start-routine gap that broke #1088. **This design takes the blocking-BIO path
that needs no Sailfin→C callback:**

- **No verify callback.** Certificate verification is configured *numerically*
  (`SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER /*=1*/, null)` — the callback arg is
  passed `null`) and the result is **polled imperatively** after the handshake
  with `SSL_get_verify_result(ssl)` (returns `X509_V_OK == 0` on success). No
  Sailfin function is ever address-taken for OpenSSL.
- **Blocking BIO over the existing fd.** `SSL_set_fd(ssl, fd)` attaches the
  default socket BIO; OpenSSL drives blocking `read(2)`/`write(2)` on our
  already-connected, already-timeout-armed (`SO_RCVTIMEO`/`SO_SNDTIMEO`, #1581)
  fd. We never supply a custom BIO method table (which would need C function
  pointers). `SSL_connect`/`SSL_accept`/`SSL_read`/`SSL_write` block; the
  existing socket timeouts bound them.

**Feasibility probe results (run against the freshly self-hosted
`build/native/sailfin`):**

1. **Opaque-pointer externs — PASS.** A 19-extern `SSL_CTX_*`/`SSL_*` surface
   spelled with opaque `* u8` handles (`SSL_CTX_new(method: * u8) -> * u8`,
   `SSL_get_verify_result(ssl: * u8) -> i64`, etc.) and a `tls_connect_fd`
   body using them passes `check` (`checked 1 files: ok`) and **emits** correct
   LLVM (`declare i8* @SSL_CTX_new(i8* %method)`,
   `call i32 @SSL_connect(i8* %t10)`, `call i64 @SSL_get_verify_result(...)`).
   Matches the existing socket-extern pattern exactly. No frontend change.
2. **No callback needed — confirmed avoidable.** The chosen design passes `null`
   for `SSL_CTX_set_verify`'s callback arg, so **no Sailfin fn is address-taken**
   for OpenSSL. For the record, a *top-level* fn's address **can** be taken
   today via `myfn as * u8` (probe emitted `bitcast i32 (i32, i8*)* @myfn to
   i8*` cleanly — the same env-less code-pointer shape `serve` uses for its
   handler). The `* fn (A) -> B` extern-param spelling is rejected by E0805
   (accept-list wants bare `fn(A) -> B`), but this design needs **neither** —
   it is callback-free. **Conclusion: no frontend predecessor.**
3. **Linking `-lssl -lcrypto` — existing mechanism, manifest-only.** `link-libs`
   is a first-class `[build]` field in `capsule.toml`, parsed by
   `toml_get_link_libs` and flowed through `RuntimeCapsuleArtifacts.link_libs` →
   `RuntimeLinkInputs.link_libs` → `LinkPlan.libs` → the clang argv. The runtime
   capsule already declares `link-libs = ["-lm", "-lpthread"]`. **Constraint
   found:** `_rcr_artifacts_from_manifest` only reads `link-libs` for `kind =
   "runtime"` capsules (non-runtime kinds return the empty artifact), so a
   `kind = "library"` capsule's `link-libs` does **not** reach the link today.
   Therefore TLS must live in the **runtime** capsule and `-lssl -lcrypto` is
   appended to `runtime/capsule.toml`'s `link-libs`. **No toolchain predecessor.**

### 3.3 Where the Sailfin body lives

A new `runtime/sfn/platform/tls.sfn`, added to `runtime/capsule.toml`'s
`sfn-sources` list, alongside `-lssl -lcrypto` in that manifest's `link-libs`.
Rationale: only the `kind = "runtime"` capsule's `link-libs` reaches the link
(§3.2 probe 3), so the OpenSSL-using body must be a runtime module, not a
`sfn/tls` library capsule. This mirrors how `serve.sfn` and `adapters/http.sfn`
(the consumers) already live in the runtime. (A `sfn/tls` *library* capsule is
the rejected alternative in §6 — it would require a separate toolchain feature
to make library `link-libs` reach the link.)

`tls.sfn` exposes a small, body-only Sailfin surface (no new compiler lowering;
these are ordinary fns calling externs):

```sfn
// runtime/sfn/platform/tls.sfn  (illustrative)
extern fn TLS_client_method() -> * u8;
extern fn TLS_server_method() -> * u8;
extern fn SSL_CTX_new(method: * u8) -> * u8;
extern fn SSL_CTX_free(ctx: * u8) -> void;
extern fn SSL_CTX_set_verify(ctx: * u8, mode: i32, cb: * u8) -> void;       // cb always null
extern fn SSL_CTX_set_default_verify_paths(ctx: * u8) -> i32;
extern fn SSL_CTX_load_verify_locations(ctx: * u8, cafile: * u8, capath: * u8) -> i32;
extern fn SSL_CTX_use_certificate_chain_file(ctx: * u8, file: * u8) -> i32;
extern fn SSL_CTX_use_PrivateKey_file(ctx: * u8, file: * u8, ty: i32) -> i32;
extern fn SSL_new(ctx: * u8) -> * u8;
extern fn SSL_free(ssl: * u8) -> void;
extern fn SSL_set_fd(ssl: * u8, fd: i32) -> i32;
extern fn SSL_set_tlsext_host_name(ssl: * u8, name: * u8) -> i64;           // SNI (macro → set_tlsext)
extern fn SSL_set1_host(ssl: * u8, host: * u8) -> i32;                       // hostname check
extern fn SSL_connect(ssl: * u8) -> i32;
extern fn SSL_accept(ssl: * u8) -> i32;
extern fn SSL_read(ssl: * u8, buf: * u8, num: i32) -> i32;
extern fn SSL_write(ssl: * u8, buf: * u8, num: i32) -> i32;
extern fn SSL_shutdown(ssl: * u8) -> i32;
extern fn SSL_get_error(ssl: * u8, ret: i32) -> i32;
extern fn SSL_get_verify_result(ssl: * u8) -> i64;
extern fn OPENSSL_init_ssl(opts: u64, settings: * u8) -> i32;               // idempotent init

// Public Sailfin surface (all bodies, no compiler change):
//   tls_client_ctx() -> * u8                  // new ctx, default verify paths loaded
//   tls_server_ctx(cert_path, key_path) -> * u8
//   tls_connect_fd(ctx, fd, host) -> * u8      // wrap+SNI+handshake+verify; null on fail
//   tls_accept_fd(ctx, fd) -> * u8             // server handshake; null on fail
//   tls_read(ssl, buf, n) -> i64 / tls_write(ssl, buf, n) -> i64
//   tls_shutdown_free(ssl) -> void             // SSL_shutdown + SSL_free
```

`SSL_set_tlsext_host_name` and `SSL_set1_host` are macros in OpenSSL headers; at
the ABI they resolve to `SSL_ctrl` / `SSL_set1_host` symbols. Per-issue,
implementers confirm the actual exported symbol (`nm -D libssl.so | grep
set1_host`) and declare the real symbol name; this is a routine adapter detail,
not a design risk (same "confirm the libc symbol" discipline the socket externs
already document).

### 3.4 Outbound — HTTPS client (simpler; no accept)

`runtime/sfn/adapters/http.sfn` already does `socket` → `_connect_tcp` →
`_send_all`/`_recv_all` → `_extract_body`. The HTTPS path adds, after a
successful `connect`: build a client ctx (`tls_client_ctx`), `tls_connect_fd(ctx,
fd, host)`; on success, route the request/response bytes through
`tls_write`/`tls_read` instead of `send`/`recv`. URL scheme dispatch (`https://`
→ port 443 default + TLS; `http://` → existing path) selects between the two.
DNS (#1707), timeouts (#1581), chunked decode (#1708), and keep-alive (#1711)
are all reused unchanged — they operate on the connection, agnostic to whether
bytes are plain or TLS. This is the **simpler half** (one direction, no pool
interaction) and ships first.

### 3.5 Inbound — TLS termination in `serve`

`serve.sfn`'s connection worker currently loops `recv → dispatch → send` on the
accepted `fd`. TLS termination adds an optional server-side handshake: when the
server is started in TLS mode (cert+key configured), after `accept` the worker
calls `tls_accept_fd(server_ctx, fd)` to obtain an `SSL*`, then performs the
keep-alive loop with `tls_read`/`tls_write` in place of `recv`/`send`, and
`tls_shutdown_free` before `close`. The server ctx is built once at startup
(`tls_server_ctx(cert, key)`), stored in a module global alongside the existing
handler-addr global, and read by each worker (read-only sharing of an opaque
handle — OpenSSL `SSL_CTX` is reference-counted and thread-safe for `SSL_new`).
A new runtime entrypoint `sfn_serve_tls(handler, port, cert_path, key_path)` (or
a TLS flag on the existing `sfn_serve` ctx) selects the mode; bare `sfn_serve`
stays byte-for-byte unchanged so the pinned plaintext e2e (`test_runtime_serve`)
and SFEP-0019's framed serve stay green.

### 3.6 Cert verification & trust store (1.0 scope)

- **Outbound (client): verification ON by default.** `tls_client_ctx` calls
  `SSL_CTX_set_default_verify_paths` (system trust store; on this host
  `/etc/ssl/certs/ca-certificates.crt`) and `SSL_CTX_set_verify(ctx, 1, null)`;
  the client checks `SSL_get_verify_result(ssl) == 0` **and** `SSL_set1_host` /
  `SSL_set_tlsext_host_name` for hostname/SNI before trusting the connection. A
  failed verify → null handle → typed failure (closed connection / null body),
  never a silent downgrade. **In scope for 1.0.** An explicit
  `SAILFIN_TLS_INSECURE=1` opt-out (skip verify) is **out of scope** — we do not
  ship an unenforced safety claim; if added later it is loud and documented.
- **CA bundle discovery.** Default verify paths first (OpenSSL's compiled-in
  dir); `SSL_CTX_load_verify_locations` with `/etc/ssl/certs/ca-certificates.crt`
  as a documented fallback when default paths are empty. macOS/Windows CA-store
  discovery is deferred to the #1485 M10 / Darwin coordination (the `tls.sfn`
  body is unchanged; only the bundle path differs).
- **Inbound (server): cert+key from files** via
  `SSL_CTX_use_certificate_chain_file` / `SSL_CTX_use_PrivateKey_file`. Client
  certificate (mTLS) verification on the server side is **out of scope for 1.0**
  (the MCP proxy terminates server TLS but does not require client certs in v0).
- **Out of scope for 1.0 (documented, not implied-working):** OCSP/CRL revocation
  checking, certificate pinning, session resumption/tickets, ALPN negotiation
  beyond a fixed default, custom cipher-suite policy, mTLS.

### 3.7 Memory / handle lifecycle

`SSL_CTX` (client: per-request or cached; server: one process-global) and `SSL`
(per-connection) are opaque heap handles owned by OpenSSL; freed via
`SSL_CTX_free` / `SSL_free`. The client frees its `SSL` (and per-request ctx)
after the response; the serve worker frees the `SSL` after the keep-alive loop,
matching the existing connection-`ctx`/response-`OwnedBuf` free discipline in
`serve.sfn`. No interaction with the ownership floor (#1209) — these are opaque
C pointers, not Sailfin `OwnedBuf`/`Affine` values.

## 4. Effect & capability impact

**No new effect.** TLS rides the existing **`![net]`** effect: it is network
I/O, and both consumers (`adapters/http.sfn` client, `serve.sfn`) are already
`![net]`. Extern fns carry no effects (`typecheck_types.sfn` E0804 forbids it),
so the `SSL_*` calls are effect-invisible at the boundary; enforcement rides on
the enclosing `![net]` Sailfin fns exactly as the socket externs do today (the
same "externs are effect holes" property SFEP-0019 §6 notes — pre-existing, not
introduced here). No new capability, no manifest capability flag: linking
`libssl` is a build-time link decision, not a runtime capability gate. If the
capability-sealed runtime (#1639, SFEP-0016) later wants to gate
"opens-TLS-connections" distinctly from "opens-sockets," that is a separate
follow-up — for 1.0, TLS == `![net]`.

## 5. Self-hosting impact

**The compiler does not use TLS.** No compiler pass changes: parser, AST,
typecheck, effect-checker, native emitter, and LLVM lowering are all untouched.
The opaque-pointer externs and `as * u8` casts this design uses are already
supported (probe 1) — there is **no new language or codegen feature**. The only
changes are:

- New runtime module `runtime/sfn/platform/tls.sfn` (added to `sfn-sources`).
- `runtime/capsule.toml`: `+ -lssl -lcrypto` in `link-libs`; `+ tls.sfn` in
  `sfn-sources` (single-line array — the parser's one-line-array constraint and
  its guarding regression test, noted in the manifest, must be honored).
- Additive runtime entrypoint(s) in `serve.sfn` / `adapters/http.sfn`.

**Self-host preservation:** `make compile` builds the new compiler from the
*pinned seed* (0.7.0-alpha.50), which already supports every construct used
here — so no seed cut is needed for any frontend reason. The risk is purely a
**link-time** one: every Sailfin binary (including the compiler itself) now
links `-lssl -lcrypto`, so the **build host and every CI runner must have
`libssl`/`libcrypto` available** (dev package on Linux; present on this host).
This is the same class of dependency as the existing `-lm`/`-lpthread`. The
runtime's `--gc-sections` dead-strip (link.sfn) drops the unreferenced
`SSL_*` symbols from binaries that never call TLS (the compiler), so the
compiler binary does not bloat — but it **still links the libraries**, so their
presence on the link host is mandatory. This is the one cross-cutting risk and
is gated first (see §10 issue #1).

## 6. Alternatives considered

- **`sfn/tls` library capsule (rejected).** Cleaner conceptually, but a
  `kind = "library"` capsule's `link-libs` is **not read** by the resolver
  (`_rcr_artifacts_from_manifest` returns empty for non-runtime kinds), so
  `-lssl` would never reach the link. Making library `link-libs` reach the link
  is a real toolchain feature with its own blast radius (every consumer's link
  line) — out of scope for B1 and unnecessary, since the runtime capsule already
  has a working `link-libs` path. Revisit post-1.0 if a user-facing `sfn/tls`
  surface is wanted.
- **mbedTLS / BoringSSL (rejected for v0).** mbedTLS is absent on the host and
  its API is less LLM-familiar; BoringSSL must be vendored+built, reintroducing
  the C/CMake build step #822 deleted. Both lose to OpenSSL's pure-`-l`
  linkability. mbedTLS stays the documented fallback for a future static build.
- **Custom BIO with a Sailfin read/write callback (rejected).** Would let TLS
  run over a non-fd transport, but requires passing Sailfin fns as C function
  pointers in a `BIO_METHOD` table — the #1088 callback gap. The blocking-fd BIO
  avoids it entirely; we already own the fd.
- **From-scratch pure-Sailfin TLS (rejected pre-1.0).** Handshake + X.509 +
  symmetric/asymmetric crypto is a multi-quarter effort and a security
  liability; explicitly out of scope per the epic.
- **A new `![tls]` effect (rejected).** Adds a keyword-class capability with no
  semantic gain over `![net]`; violates "keywords are expensive" and "don't
  dilute the three pillars." TLS is network I/O.

## 7. Stage1 readiness mapping

- [x] **Parses** — no new syntax (externs + body fns; parser unchanged).
- [x] **Type-checks / effect-checks** — opaque externs pass `check` (probe 1);
      rides `![net]`; verified end-to-end per consumer.
- [x] **Emits valid `.sfn-asm`** — no new IR; externs emit `declare`/`call`
      (probe 1).
- [x] **Lowers to LLVM IR** — confirmed (`declare i8* @SSL_CTX_new`, calls).
- [x] **Regression coverage** — §8, shipped: `runtime_tls_https_client_test.sfn`
      (outbound), `serve_tls_loopback_test.sfn` + `tls_loopback_test.sfn`
      (client↔server round-trip), `runtime_tls_verify_failure_test.sfn`
      (verification enforced); plaintext serve stays green.
- [x] **Self-hosts** — `make compile` / `make check` green with the runtime
      linking `-lssl -lcrypto`; the compiler calls no TLS (#1782/#1783/#1784).
- [x] **`sfn fmt --check` clean** — on `tls.sfn` and every touched `.sfn`.
- [x] **Documented** — `docs/status.md` (sfn/http TLS row), SFEP-0019 §4 row
      promoted, `standard-library.md` https-client + serve-TLS notes, manifest
      `link-libs` comment, and the OpenSSL build-dependency runbook.

## 8. Test plan

- **Unit (`compiler/tests/unit`)** — `tls.sfn` extern-surface check test
  (assert the surface type-checks; mirrors the `net.sfn` smoke test). Pure
  parse/typecheck, no link.
- **e2e (`compiler/tests/e2e`, `*_test.sfn` — never bash, per `no-bash-e2e`):**
  - **Outbound HTTPS round-trip** — drive `sfn build`+run of a fixture that
    `get`s an `https://` URL served by a local OpenSSL `s_server` (or the
    capsule's own TLS serve from the inbound issue), asserting the body arrives.
    Skip if `libssl`/`openssl` CLI is absent (probe + `assert true`), mirroring
    the established tool-absent SKIP pattern.
  - **Inbound termination round-trip** — start `sfn_serve_tls` with a generated
    self-signed cert+key (`openssl req` via `process.run_capture`), connect with
    an `https`-capable client (the capsule client from the outbound issue, with
    verify pointed at the self-signed CA), assert a non-200 status + custom
    header arrive on the wire over TLS.
  - **Verify-failure is enforced** — client against a server cert **not** in the
    trust store → connection fails (null body / closed), proving verification is
    real and not parsed-but-ignored.
  - **Plaintext serve unchanged** — the existing `test_runtime_serve` peer and
    SFEP-0019 framed-serve e2e stay green (TLS mode is additive).
- **Build-host guard** — a CI note / preflight that `libssl`-dev is installed on
  every runner; the first issue's acceptance includes "`make check` is green on
  CI with the new `-lssl -lcrypto` link."

## 9. References

- Epic **#1540** (MCP-proxy enablement — stdio/HTTP transport + policy-engine
  gaps), gap **B1**.
- **SFEP-0019** (`0019-sfn-http-capsule.md`) — the `sfn/http` design this
  extends; §4 "TLS, redirects" deferral row, §3 serve/trampoline architecture.
- **SFEP-0025** (`0025-native-runtime-architecture.md`) — runtime adapter /
  serve accept-loop design this layers on.
- **#1321** (Epic: `sfn/http` capsule) — names TLS/DNS/keep-alive as post-1.0;
  this promotes TLS to a 1.0 blocker via the MCP proxy.
- **#1485 M10** (Windows native self-host) — also wants native TLS; the extern
  surface here is OS-independent and reused there (only link form + CA path
  differ). Coordinate cert-store discovery.
- **#934** (`sfn/capability`) — TLS == `![net]`; any future "opens-TLS" sub-gate
  is its concern, not B1's.
- Shipped substrate: **#1707** (DNS/`getaddrinfo`), **#1581** (socket timeouts),
  **#1711** (keep-alive), **#1708** (chunked decode) — all reused unchanged.
- **#1088** — the `pthread_create` start-routine / fn-address callback gap this
  design deliberately avoids (callback-free OpenSSL integration).
- Link mechanism: `compiler/src/toml_parser.sfn` (`toml_get_link_libs`),
  `compiler/src/runtime_capsule_resolver.sfn` (`_rcr_artifacts_from_manifest`,
  runtime-kind gate), `compiler/src/build/runtime_objs.sfn` /
  `compiler/src/build/link.sfn` (`link_libs` → `LinkPlan.libs` → clang argv),
  `runtime/capsule.toml` (`link-libs = ["-lm", "-lpthread"]`).

## 10. Decomposition (issue table — returned for approval, not yet filed)

Sequenced riskiest-design-first; each is XS/S/M (never L) and cites this SFEP.
Per `.claude/rules/seed-dependency.md`, the extern surface + linking + first
consumer (outbound) are **bundled into one issue** — the capability and its
first consumer are one tightly-coupled session, so bundling avoids a manufactured
seed-cut (the compiler never calls TLS, so no seed dependency exists regardless;
`make compile` builds the new compiler from the old seed and that compiler
compiles the runtime in one pass).

| # | Title | Type | Size | Blocked by | Required-in-seed |
|---|---|---|---|---|---|
| 1 | `feat(runtime): link OpenSSL + tls.sfn extern surface + HTTPS client (outbound)` | Feature | M | — | none |
| 2 | `feat(runtime): TLS termination in serve accept loop (inbound)` | Feature | M | #1 | none |
| 3 | `feat(runtime): client cert verification + system CA trust store` | Feature | S | #1 | none |
| 4 | `test(runtime): TLS loopback e2e (client↔server, verify-failure)` | Feature | S | #2, #3 | none |
| 5 | `docs(runtime): TLS status, SFEP-0019 row, https/serve-TLS reference` | Refactor | XS | #2, #3 | none |

No issue is **Required-in-seed**: TLS is runtime-only and the compiler never
calls it, so no seed cut is triggered by any of these. The single cross-cutting
gate is build-host `libssl`-dev availability, owned by issue #1.
