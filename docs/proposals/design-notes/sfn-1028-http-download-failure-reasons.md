# SFN-1028 — HTTP download failure reasons

Design gate for SFN-1028. Genre is a single-issue design note, not an SFEP
(`.claude/rules/proposals.md`): no new language feature, no toolchain design of
its own scope — this is a runtime/ABI-adjacent contract plus a fixed literal
taxonomy behind an existing runtime helper. Sibling precedent for the
ownership-contract half of this note: `sfn-460-string-view-consumer-surface.md`
(the `i8*`/`string` boundary from the other direction — a view rather than a
runtime-helper return).

Bundled with its consumer per `.claude/rules/seed-dependency.md`:
`runtime/sfn/adapters/http.sfn` carries the taxonomy,
`compiler/src/toolchain/install.sfn` consumes it, and two e2e tests pin it.
This note is the durable record of *why*; the issue is the session-sized
*what*.

---

## 1. The ownership contract for `i8*` runtime-helper returns adopted as a Sailfin `string`

This is generally useful and, until now, written down nowhere.

A builtin member call (e.g. `http.download`) whose `RuntimeHelperDescriptor`
declares `return_type: "i8*"`
(`compiler/capsules/codegen-llvm/src/runtime_helpers/registry_values.sfn:333`)
lowers to a plain `call i8* @<symbol>` returning an
`LLVMOperand { llvm_type: "i8*" }`
(`compiler/capsules/codegen-llvm/src/expression_lowering/native/core_call_lowering.sfn:216`).

When that operand is consumed where a Sailfin `string` (`{i8*, i64}`) is
required, it goes through the coercion at
`compiler/capsules/codegen-llvm/src/expression_lowering/native/core_operands/pointer_coercion.sfn:45`,
which recovers the length via the `string.length` descriptor (`sfn_str_len`)
and `insertvalue`s `{ptr, len}`. **No copy and no null check are emitted.**

**Null is safe.** `sfn_str_len` returns 0 for a null pointer
(`runtime/sfn/string.sfn:274`), so a null return yields `{null, 0}` — `.length`
is 0 and nothing is dereferenced. `sfn_str_eq` is likewise null-safe
(`runtime/sfn/string.sfn:284`). Live proof:
`compiler/tests/e2e/publish_test.sfn:216` takes `.length` directly on
`http.get_body(...)`, which returns null on every connect failure.

**Nothing frees the pointer.** There is no compiler-emitted free, refcount,
drop, or copy for a runtime-helper `i8*` return adopted as a `string`. Two
consequences, and this is the load-bearing part of the contract:

- Returning a **static string literal** is correct and immortal — literals
  lower to `private unnamed_addr constant`
  (`compiler/capsules/codegen-llvm/src/strings.sfn:99`). Established
  precedent: `sfn_str_from_codepoint` returns
  `let empty: string = ""; return empty as *u8;` (`runtime/sfn/string.sfn:146`).
- Returning a **malloc'd** buffer that every caller discards is a per-call
  leak. `sfn_http_download`'s former `malloc(3)` for its `"ok"` sentinel was
  exactly that — a 3-byte leak on every successful download — and SFN-1028
  removes it.

Note the contrast that could otherwise mislead a reader:
`capsules/sfn/http/src/mod.sfn:100` null-checks `sfn_http_request_raw`'s
pointer before `as string`. That guard protects `parse_response`'s scanning
logic from a zero-length view; it is **not** evidence that the cast itself is
unsafe.

**The rule for any future `i8*`-returning runtime helper:** return either a
static literal or nothing — never a heap allocation the caller has no way to
free. If a helper genuinely needs to hand back owned, non-static bytes, that is
a new ownership primitive, not a variant of this pattern, and needs its own
design note.

---

## 2. The download failure reason taxonomy

Reasons travel **numerically** through a `*i64` fail-slot out-param threaded
down the request path, and are rendered to a string exactly once, at the top
of `sfn_http_download`. This keeps every intermediate layer allocation-free
and confines string production to one function. `_connect_tcp` and
`_http_send` each keep their existing signature as a thin forwarder over a new
`_ex`/`_rc` variant, so `sfn_http_get` and `sfn_http_post_lv` are untouched.

| Code | Literal | Produced when |
|---:|---|---|
| 1 | `invalid-argument` | null `url` or `output_path` |
| 2 | `out-of-memory` | any allocation failure on the request path |
| 3 | `dns-failed` | `_host_ip4` returned false (alias, dotted-quad, and `getaddrinfo` fall-through) |
| 4 | `socket-failed` | `sfn_socket_open` returned < 0 |
| 5 | `connect-failed` | both sockaddr-layout attempts exhausted without a successful `connect()` |
| 6 | `tls-context-failed` | `tls_client_ctx()` returned null |
| 7 | `tls-handshake-failed` | `tls_connect_fd()` returned null |
| 8 | `send-failed` | `_send_all` returned false |
| 9 | `recv-failed` | `_recv_all` returned null |
| 10 | `malformed-response` | no `\r\n\r\n` header terminator |
| 11 | `body-decode-failed` | chunked-framing failure, negative body length, or body copy OOM |
| 12 | `redirect-no-location` | a 3xx with no `Location` |
| 13 | `redirect-limit` | redirect hop limit exceeded |
| 14 | `open-failed` | `fopen(output_path, "wb")` returned null |
| 15 | `write-failed` | short `fwrite` or `fclose` reported an error — a truncated or quota-exhausted local write |
| 1000+N | `http-status-<N>` | the server answered with status N >= 400 |

`unknown` is `_dl_reason`'s terminal default for code `0` or an unrecognized
code — it has no ordinal of its own.

On the compiler side, `_download_to` (`compiler/src/toolchain/install.sfn`)
returns `""` for success and adds one reason of its own: `missing-output`,
produced when the runtime reported `ok` but the destination file is absent.
This is the criterion-1 fix: `fs.exists` is demoted from *primary success
signal* to *post-condition* — the runtime's own report of success is now
primary, and the filesystem check only guards against a report/reality
mismatch.

**Governing rule: every literal names the branch that produced it, never an
inferred cause.** `dns-failed` means `_host_ip4` returned false — not "we
think DNS is broken." There is no ABI, certificate, or mingw inference
anywhere. That is what SFN-1028's second acceptance criterion demands.

`http-status-<N>` is the single dynamic case — a one-shot ≤24-byte allocation
on a terminal failure path; every other reason is a static literal. Per §1,
the returned pointer is never freed by the caller, so this allocation is a
deliberate, bounded, once-per-failed-download exception to the "never a heap
allocation the caller can't free" rule — acceptable because it is realized
only on a terminal failure path, not on every call.

---

## 3. Why `tls.last_error()` was deliberately excluded

Record this carefully so nobody re-litigates it from the wrong premise. The
obvious objection — "it's process-global and last-writer-wins, so it could be
stale" — is **false**, and saying so is the point of writing this down.
`tls_connect_fd` clears both slots on entry precisely so a reason read
afterwards belongs to that connect and not a previous one
(`runtime/sfn/platform/tls.sfn:954`, SFN-816). A read immediately after a null
`tls_connect_fd`, in the same straight-line frame, is contracted to be
correct.

It was excluded anyway, for three reasons:

1. It is reachable only for `https://`, which **no hermetic test can
   exercise** — it would ship untested, against the "parsed but not enforced
   is not shipped" bar in `CLAUDE.md`.
2. It turns a flat, reviewable closed set of 15 literals into a two-level
   taxonomy whose sub-code range a future TLS reason can silently collide
   with.
3. SFN-1028's second acceptance criterion warns specifically against
   TLS/certificate causes; adding one invites exactly the review argument the
   issue exists to close.

**The extension point, if it is ever wanted:** the fail-slot plumbing is what
makes a later addition cheap. Widening code 7 into a reserved sub-range (e.g.
30..39) with an out-of-range clamp is a small follow-on if the TLS sub-reason
(`cert-verify` vs `peer-alert` — the corporate-MITM distinction) is ever
wanted. It is not filed as a follow-up here: it fails the
`.claude/rules/follow-up-filing.md` bar today (no reproducer, no urgency, not
a prerequisite of SFN-1028) and belongs to whichever future issue first needs
a hermetic TLS failure test to justify it.
