# Security Policy

Sailfin is a systems language whose core promise is **compile-time capability
enforcement** — every function declares the effects it uses (`![io, net,
clock, ...]`) and the compiler rejects code that exceeds its declaration. A
vulnerability in the compiler, runtime, or toolchain can undermine that promise
(for example, by letting code perform an effect it never declared, or by
corrupting memory in the native runtime). We take such reports seriously.

## Supported Versions

Sailfin is pre-1.0 and ships on an `alpha` channel. Security fixes land on
`main` and are delivered through the **most recent release only** — we do not
backport to older prereleases.

| Version                       | Supported          |
| ----------------------------- | ------------------ |
| Latest `alpha` release        | :white_check_mark: |
| Any earlier release           | :x:                |
| Building from `main` (source) | :white_check_mark: (fixes land here first) |

If you are on an older build, upgrade to the latest release (or `main`) before
reporting — the issue may already be fixed.

## Reporting a Vulnerability

**Please do not open a public issue, pull request, or discussion for a security
vulnerability.** Public disclosure before a fix is available puts every user at
risk.

Report privately through **GitHub Security Advisories**:

1. Go to <https://github.com/SailfinIO/sailfin/security/advisories/new>
   (or the repository's **Security → Advisories → Report a vulnerability**
   button).
2. Describe the issue with enough detail for us to reproduce it.

A good report includes:

- **Affected component** — compiler pass (lexer/parser/typecheck/effect
  checker/emitter/LLVM lowering), native runtime (`runtime/native`,
  `runtime/sfn`), the build/self-host driver, or a released binary.
- **Version / commit** — the release tag or `git` commit, and your platform
  (e.g. `linux-x86_64`, `macos-arm64`).
- **Reproduction** — a minimal `.sfn` snippet or command sequence that triggers
  the issue, plus expected vs. actual behavior.
- **Impact** — what an attacker gains (capability/effect bypass, memory
  corruption, code execution, denial of service, supply-chain compromise).

## What to Expect

- **Acknowledgement** within **5 business days**.
- An initial assessment (severity, affected versions, whether we can reproduce)
  within **10 business days**.
- Coordinated disclosure: we'll work with you on a fix and a disclosure
  timeline. We aim to ship a fix within **90 days** of triage, sooner for
  actively exploited issues.
- Credit in the published advisory, unless you prefer to remain anonymous.

If you do not receive an acknowledgement within the window above, please follow
up on the advisory thread.

## Scope

Security-relevant areas for this repository include, but are not limited to:

- **Effect / capability bypass** — code that performs an undeclared effect
  (`![io]`, `![net]`, `![model]`, `![clock]`, …) without a diagnostic, or a way
  to defeat capsule-manifest capability enforcement. This is the project's
  central guarantee; bypasses are high severity. *Note:* effect enforcement is
  fully realized on Linux x86_64 and **partial on macOS arm64** (tracked in
  public issues) — known gaps documented there are not new vulnerabilities, but
  a *novel* bypass on a platform claimed to enforce is in scope.
- **Native runtime memory safety** — heap corruption, use-after-free,
  out-of-bounds access, or ownership/aliasing-analysis soundness holes in
  `runtime/native/` and `runtime/sfn/`.
- **Compiler miscompilation with a security impact** — generating code that
  silently violates the source program's declared safety properties.
- **Supply chain** — the seed/self-host trust chain, release artifacts, the
  capsule dependency resolver, or build tooling that could let a malicious
  dependency or seed compromise a build.

### Out of scope

- Bugs with no security impact — file a normal
  [issue](https://github.com/SailfinIO/sailfin/issues) instead.
- Features documented as **not yet enforced** (e.g. `PII<T>` / `Secret<T>`
  runtime enforcement, AI/`model` blocks) — these are tracked publicly and are
  known-incomplete, not vulnerabilities. See `docs/status.md` and `CLAUDE.md`
  for what currently ships vs. what is parsed-but-not-enforced.
- Vulnerabilities in third-party tools we invoke (`clang`, `lld`/`mold`, LLVM)
  — report those upstream; if our usage makes them exploitable in a way they
  otherwise wouldn't be, that part is in scope.

## Safe Harbor

We will not pursue or support legal action against researchers who, in good
faith, follow this policy: who avoid privacy violations, data destruction, and
service disruption, and who give us a reasonable opportunity to remediate
before any public disclosure.

Thank you for helping keep Sailfin and its users safe.
