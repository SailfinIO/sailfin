---
sfep: 19
title: "sfn/http — Typed HTTP Surface"
status: Implemented
type: tooling
created: 2026-06-13
updated: 2026-07-24
author: "agent:compiler-architect"
tracking: "#1321"
supersedes:
superseded-by:
graduates-to:
---

# Proposal: `sfn/http` — typed HTTP server/client surface

Status: **approved** (design gate cleared 2026-06-13) — groomed into a tracking epic + Wave 1–4 issues
Decisions locked at the gate: handler API = return-based `fn(Request) -> Response`; v0 handlers
**restricted to top-level named functions** (closures documented + best-effort diagnostic, per
open question 2); `ServerConfig.host` dropped from the v0 signature.
Depends on: M4 epic #965 (closed 2026-06-12) — Sailfin-native scheduler + `sfn_serve`
Related: `runtime/sfn/concurrency/serve.sfn` (raw server), `runtime/sfn/adapters/http.sfn`
(raw client), `capsules/sfn/http/src/mod.sfn` (typed stubs), #1308 / #1318 (string-ABI
reshaping — deliberately not touched), #1220 (move semantics — designed-around).

## 1. Goal

Turn the `sfn/http` capsule into a real, typed HTTP/1.1 server (and incrementally
client) surface so users can write web servers in native Sailfin:

```sfn
// In a consumer capsule whose capsule.toml declares [dependencies] "sfn/http" = "*"
import { serve, Request, Response, response, not_found } from "sfn/http";

fn handler(req: Request) -> Response {
    if strings_equal(req.path, "/") { return response("Welcome to Sailfin!"); }
    return not_found();
}

fn main() ![net, io] {
    // Handlers are top-level fns passed address-taken (closures unsupported in v0).
    serve(handler as * fn (Request) -> Response, 8080);
}
```

This is the "follow-up wave" the `serve.sfn` header (lines 24–36) explicitly names:
the `fn(Request) -> Response` struct-marshalling layer on top of the proven raw
`fn(* u8) -> * u8` runtime ABI.

## 2. Handler API decision

**Chosen: return-based `fn(req: Request) -> Response`** (Deno.serve / Cloudflare
Workers `fetch` shape).

Rationale:

- **Single marshalling boundary.** The runtime ABI is one value in, one value out
  (`* u8` request bytes → `* u8` response bytes). A return-based handler maps onto it
  1:1; an Express-style `fn(req, res)` mutation API would need a mutable `res` object
  threaded across the boundary and a "did the handler respond?" protocol.
- **No mutable aliasing.** A shared mutable `res` is exactly the #1205-class aliasing
  shape the ownership floor (#1209) exists to forbid, and it fights #1220
  (channel-send/spawn as moves). Value-return composes with moves; mutation does not.
- **Boring syntax / LLM-friendly.** `Request -> Response` is the dominant modern
  convention (Deno, Workers, Bun, Go's `http.Handler` is morally request→write-once).
  LLMs generate it reliably.
- **Methods-on-structs not required.** `res.send(...)` needs method dispatch on a
  capsule struct; free functions (`response(...)`, `json_response(...)`) need nothing
  new.

Reconciling the three in-tree shapes:

| Shape | Disposition |
|---|---|
| runtime `fn(* u8) -> * u8` | Stays as the substrate. Untyped `serve(handle, 8080)` with a `fn(string) -> string` handler keeps working (pinned by `test_runtime_serve.sh`). |
| capsule `fn(Request) -> Response` | Becomes the real, typed public API. `serve(handler: fn(Request) -> Response, port: int)` replaces the `any`-typed stub. |
| `examples/web/http-server.sfn` Express-style `fn(req, res)` + `{ port: 8080 }` | Rewritten to the return-based form in the same PR that ships typed `serve` (Wave 2). The Express shape never worked (serve was a print stub) so there is no compat concern. |

`ServerConfig` is **dropped from the v0 signature** (kept as a type only if trivially
useful later): the runtime binds `INADDR_ANY` unconditionally, so a `host` field would
be parsed-but-not-enforced — exactly what we don't ship. v0 is `serve(handler, port:
int = 8080)`; `ServerConfig { port, host }` returns when host binding is real.

## 3. Architecture

### 3.1 Where things live

- **All marshalling lives in the capsule** (`capsules/sfn/http/src/`), in plain
  high-level Sailfin (`string`, `string[]`, structs). No retyping of runtime
  descriptors, no arena threading, no interaction with #1318's `OwnedBuf` reshaping.
  This works because Sailfin strings are NUL-terminated `i8*` at the ABI
  (`sfn_str_to_cstr` / `from_cstr` are identity bridges, `runtime/sfn/string.sfn:202`),
  so a trampoline typed `fn(raw: string) -> string` *is* the runtime's
  `fn(* u8) -> * u8` — proven by the pinned e2e probe `fn handle(req: string) -> string`
  in `compiler/tests/e2e/test_runtime_serve.sh`.
- **One additive runtime entrypoint** (`runtime/sfn/concurrency/serve.sfn`):
  `sfn_serve_framed(handler: * u8, port: i32)` — identical accept loop, but the
  handler's return is the **full pre-framed HTTP response** (status line + headers +
  body) sent verbatim; `null` → `500`. This is what makes `Response.status` and
  `Response.headers` real instead of parsed-but-ignored (today `_serve_send_response`
  always frames `200 OK`). It is a **new Sailfin-only symbol** — purely additive,
  with no C definition, header, or shared-struct layout to consider (the runtime
  is pure Sailfin).
- **One small compiler change** (`compiler/src/llvm/expression_lowering/native/core.sfn:1415`):
  the bespoke `serve(` lowering text-matches **any** call spelled `serve(...)` and
  lowers it straight to `@sfn_serve(handler, port)`. An imported capsule `serve` would
  be silently hijacked (its typed handler bitcast to a raw handler, its config arg
  truncated to i32). Fix: gate the bespoke path on `serve` **not** resolving to a
  user-defined/imported function (consult the `functions` map already in scope; fall
  through to generic call lowering when found). Bare `serve(handle, 8080)` with no
  import is unaffected, so the pinned e2e stays green.

### 3.2 Data flow

```
user: serve(handler, 8080)                              [capsule serve, ![net, io]]
  └─ stores handler code-pointer in module global  let mut _handler_addr: i64
     (the future.sfn `_sfn_g_queue_addr` pattern)
  └─ extern call: sfn_serve_framed(_sfn_http_trampoline as ... as * u8, port as i32)

runtime: accept → pool worker → dispatch (fn(* u8) -> * u8)
  └─ _sfn_http_trampoline(raw: string) -> string        [capsule, top-level fn]
       ├─ parse_request(raw)      -> Request            [capsule wire.sfn]
       ├─ user handler(Request)   -> Response           (called via * fn cast from _handler_addr)
       └─ serialize_response(rsp) -> string             [full HTTP/1.1 bytes]

runtime: send verbatim, Connection: close, close(fd)
```

### 3.3 Request population (v0 honesty)

`_serve_recv_request` reads only to the `\r\n\r\n` terminator (GET-shaped v0), so:

- **v0 (Wave 2):** `method`, `path` (query split off), `query` (raw string),
  `headers: string[]` ("Name: value" lines), `body` = whatever trailed the terminator
  in the final chunk — documented as **unreliable; GET-only support**.
- **Wave 3 (runtime, additive):** `_serve_recv_request` drains `Content-Length` bytes
  after the terminator (capped, e.g. 1 MiB) → `body` becomes real, POST ships. No ABI
  change.

### 3.4 Response serialization (capsule `wire.sfn`)

- Status line from `Response.status` with a small reason-phrase table (200, 201, 204,
  301, 302, 400, 401, 403, 404, 405, 500, 502, 503; default `"Status"`).
- User headers emitted as-is **after CR/LF rejection** (any header string containing
  `\r` or `\n` is dropped — header-injection guard).
- `Content-Length` computed from `body.length`; `Connection: close` appended.
- Text bodies only in v0 (strings are NUL-terminated; embedded-NUL binary bodies are
  out of scope and documented).

### 3.5 Handler-value restriction (v0)

The handler slot stores a **bare code pointer** (i64) and the trampoline calls it via a
`* fn` cast — the same env-less indirect-call shape `sfn_serve` itself uses. Closures
(`{fn_ptr, env}`, #689) have a different representation, so **v0 requires a top-level
named function as the handler** (documented; same restriction the raw `serve` has
today). Closure-handler support is a follow-up (store the full fn value / add an
env-aware dispatch) and is listed as an open question below.

## 4. Scope cut

| Surface | v0 (this proposal) | Follow-up | Out (post-1.0) |
|---|---|---|---|
| Typed `serve(fn(Request) -> Response, port)` | yes (Wave 2) | — | — |
| Status codes + headers honored on the wire | yes (`sfn_serve_framed`) | — | — |
| Request: method, path, query, headers | yes | — | — |
| Request body (POST) | no — documented GET-only | Wave 3 (Content-Length drain) | — |
| Header/query accessors (`header(req, n)`, `query_param(req, n)`) | yes (Wave 1, pure capsule) | — | — |
| Typed client (`fetch`-style → `Response` with status/headers) | no — `get`/`post` body-string wrappers stay | Wave 4 (needs additive `sfn_http_request_raw` returning the full raw response) | — |
| Routing (`Router`) | no — handler-side `if req.path == ...` idiom | **shipped** (SFN-37 — `Router`/`route`/`dispatch` with `{param}` path capture in `router.sfn`; handlers are top-level `fn(Request, Params) -> Response` registered by address, sidestepping the closure-handler story; 405 on method mismatch, 404 on no match) | — |
| Keep-alive | no (`Connection: close` default) | **shipped** (#1711 — the serve connection worker loops recv→dispatch→send; `serialize_response` is negotiation-aware; a native single-connection-reuse client `sfn_http_conn_*` lands in the adapter) | — |
| Closure handlers | no (top-level fn only, documented) | follow-up | — |
| `ServerConfig.host` binding | dropped from v0 API | with host-bind runtime support | — |
| DNS resolution (`getaddrinfo`) | no — localhost / dotted-quad only | **shipped** (#1707 — real hostnames resolve via `getaddrinfo`, first IPv4/A record; `sfn/net::resolve` wired) | — |
| Chunked response decode (client) | no — `Content-Length` only | **shipped** (#1708 — `_extract_body` decodes `Transfer-Encoding: chunked` on the get/post/download body-extraction path, length-tracked; chunked *request* decode on `serve` stays out) | — |
| TLS (`https://` client + `serve` termination) | — | **shipped** (SFEP-0036, epic #1540 B1 — outbound `https://` on `http.*`/capsule `get`/`post` with peer-chain + hostname verification against the system CA store; inbound termination via the `sfn_serve_tls` runtime entry; `runtime/sfn/platform/tls.sfn`. Typed `fetch`/keep-alive client stays HTTP-only for now) | — |
| Redirects | — | — | out (matches client v0 limits) |
| Per-response buffer free / Task reaping | no — documented leak (same class as the existing fire-and-forget Task leak) | request-scoped arena follow-up (ties to ownership/arena work) | — |

Stage1 readiness: everything in the v0 column is enforced end-to-end (status/headers
actually hit the wire; the GET-only body limit is documented, not implied-working).

## 5. Sequencing (pickable issues)

**Wave 1 — `sfn/http` wire layer (S).** Pure capsule, no deps, first mergeable PR.
- `capsules/sfn/http/src/wire.sfn`: `parse_request(raw: string) -> Request`,
  `serialize_response(rsp: Response) -> string`, `header(req, name) -> string?`,
  `query_param(req, name) -> string?`; path/query split; CR/LF header guard;
  reason-phrase table.
- `capsules/sfn/http/tests/wire_test.sfn` unit tests (parse a canned GET/POST head,
  round-trip a 404-with-headers response, injection guard).
- No runtime, no compiler, no example changes. Independently shippable.

**Wave 2 — typed `serve` vertical slice (M).** *The first user-visible slice.*
Bundles the compiler gate with its single consumer (per decomposition discipline —
splitting would add a PR with no standalone value; no seed cut needed because the
compiler change and the capsule consumer land in one `make compile` pass and the
compiler itself never calls `serve`).
- Runtime: `sfn_serve_framed` in `runtime/sfn/concurrency/serve.sfn` (additive; reuse
  `_serve_*` helpers; conn ctx grows a mode word or a second worker fn).
- Compiler: gate the bespoke `serve(` lowering
  (`compiler/src/llvm/expression_lowering/native/core.sfn:1415`) on `serve` not
  resolving in `functions`.
- Capsule: replace the `serve` stub in `mod.sfn` with the typed signature, handler
  slot global, `_sfn_http_trampoline`, `extern fn sfn_serve_framed(...)`.
- Example: rewrite `examples/web/http-server.sfn` to the return-based form.
- e2e: new `compiler/tests/e2e/test_http_capsule_serve.sh` — loopback round-trip
  asserting a non-200 status and a custom header arrive on the wire; plus an IR probe
  that an *imported* `serve` does **not** lower to `@sfn_serve` directly.
- Pre-flight verifications (cheap, before coding): (a) struct params/returns lower as
  single pointers at the `* fn` cast boundary; (b) the `functions` map at
  core.sfn:1415 contains imported capsule functions; (c) capsule sources accept
  `extern fn` + `as * u8` casts like `runtime/sfn` modules do.

**Wave 3 — POST body draining (S).**
- Runtime: `_serve_recv_request` parses `Content-Length` and drains the body (cap ~1
  MiB, over-cap → 500 path). No ABI change.
- Capsule: none (wire.sfn already parses the body when present).
- e2e: POST round-trip through the typed handler echoing `req.body`.
- Docs: lift the GET-only caveat.

**Wave 4 — typed client (S/M, optional for the server goal).**
- Runtime (additive): `sfn_http_request_raw(method, url, headers, body) -> * u8`
  returning the **full** raw response in `runtime/sfn/adapters/http.sfn` (shares the
  existing socket helpers; same v0 limits: no TLS/DNS/chunked).
- Capsule: `fetch(method, url, headers, body) -> Response ![net]` parsing via a
  response-side twin of `wire.sfn`'s request parser. `get`/`post` wrappers unchanged.
- e2e: loopback client↔server round-trip — the capsule talks to itself.

Dependency order: 1 → 2 → 3; 4 after 1 (parallel to 2/3 in principle, but sequencing
after 3 lets its e2e use the capsule server as the test peer).

## 6. Risks / open questions

1. **Bespoke-lowering gate regressions.** Text-matched lowerings are fragile; the gate
   must not break bare `serve(h, port)` (pinned e2e) nor accidentally suppress the
   bespoke path inside the capsule itself. Mitigation: the capsule never spells a call
   `serve(...)` internally — it calls the `sfn_serve_framed` extern directly.
2. **Closure handlers typecheck but crash** (a closure value bitcast to a bare code
   pointer). **Resolved at the design gate (2026-06-13): ship v0 with the documented
   top-level-function restriction + a best-effort diagnostic** ("serve handler must be a
   top-level function"). Closure-handler support is a post-v0 follow-up (store the full
   fn value / env-aware dispatch). Wave 2 is *not* blocked on closure-value plumbing.
3. **Per-request allocations are never freed** (handler-built strings come from the
   runtime allocator; the worker can't `free()` them). Same class as the documented
   fire-and-forget Task leak. Acceptable for v0? The principled fix is a
   request-scoped arena — flag for the ownership/arena track, not this epic.
4. **Effect enforcement depth.** Extern fns must not declare effects
   (`typecheck_types.sfn:1388`), so the `sfn_serve_framed` call inside the capsule is
   effect-invisible; enforcement rides on the capsule `serve`'s own `![net, io]`
   annotation (pinned by test). The general "externs are effect holes" gap is
   pre-existing and out of scope here.
5. **Single server per process** (one global handler slot; `sfn_serve*` never returns
   and owns its pool). Matches the runtime's existing shape; document it.
6. **Struct ABI assumption** (single-pointer structs across the `* fn` cast) is
   load-bearing for Wave 2 — verify in pre-flight, escalate to the architect if
   structs lower by-value anywhere on this path.

## 7. Pipeline touchpoints

| Stage | Files |
|---|---|
| Capsule | `capsules/sfn/http/src/mod.sfn`, `capsules/sfn/http/src/wire.sfn` (new), `capsules/sfn/http/capsule.toml` (version bump), `capsules/sfn/http/tests/wire_test.sfn` (new) |
| Runtime (Sailfin) | `runtime/sfn/concurrency/serve.sfn` (Wave 2: `sfn_serve_framed`; Wave 3: body drain), `runtime/sfn/adapters/http.sfn` (Wave 4: `sfn_http_request_raw`) |
| Runtime (C) | none — no symbol flips, no header edits, no shared-layout hazards |
| Compiler | `compiler/src/llvm/expression_lowering/native/core.sfn` (~line 1415, Wave 2 gate only); `compiler/src/llvm/runtime_helpers.sfn` only if a `serve_framed` registry row is wanted for defense-in-depth (optional) |
| Examples | `examples/web/http-server.sfn` (rewrite), `examples/README.md` (capabilities note) |
| Tests | `compiler/tests/e2e/test_http_capsule_serve.sh` (new), `compiler/tests/e2e/test_runtime_serve.sh` (unchanged — must stay green), per-wave capsule unit tests |
| Docs | `docs/status.md` (http capsule row), `site/src/content/docs/docs/reference/standard-library.md` (sfn/http section: API, v0 limits), `runtime/sfn/concurrency/serve.sfn` header comment (framed contract) |
