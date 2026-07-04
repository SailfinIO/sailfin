# OpenSSL build-host dependency runbook

The native runtime links TLS via OpenSSL (`-lssl -lcrypto`;
`runtime/sfn/platform/tls.sfn`, SFEP-0036 gap B1 of epic #1540). Because the
runtime is linked into **every** Sailfin binary, OpenSSL must be resolvable on
the link host for *any* build — including the compiler's own self-host and each
per-test binary the suite links. This is the same class of build-host
dependency as `-lm` / `-lpthread`, not a runtime capability: linking `libssl`
is a build-time link decision, and TLS rides the existing `![net]` effect (no
new effect or manifest flag).

Dead-strip (`--gc-sections` / `-dead_strip`) removes the unreferenced `SSL_*`
symbols from binaries that never call TLS (the compiler), so those binaries do
not bloat — but they **still link** `-lssl -lcrypto`, so OpenSSL's presence on
the host is mandatory regardless of whether a binary uses TLS.

This page is the reference for provisioning that dependency per platform and
for the supported override.

---

## 1. Per-platform requirement

| Platform | Requirement | How the link finds it |
|---|---|---|
| **Linux** | `libssl-dev` (Debian/Ubuntu) / `openssl-devel` (Fedora/RHEL) | On clang's default library search path — the build driver emits **no** extra `-L` (byte-identical to a no-TLS link). |
| **macOS** | Homebrew `openssl@3` (`brew install openssl@3`) | Homebrew keeps `openssl@3` **keg-only** (not symlinked into a default `-l` dir), so without help clang reports `ld: library 'ssl' not found`. The build driver injects a single `-L<openssl>/lib` search flag (see §2). |
| **Windows** | Deferred / stubbed | Native TLS + link form are tracked with the Windows native self-host (#1494 / #1485 M10). The `tls.sfn` extern surface is OS-independent; only the link form and CA-store discovery differ. |

If `libssl` is missing on a Linux build host the link fails with
`/usr/bin/ld: cannot find -lssl`; install the dev package. On macOS the symptom
is `ld: library 'ssl' not found`; install `openssl@3` or set the override (§3).

---

## 2. How macOS `-L` discovery works

`_openssl_link_search_flags` (`compiler/src/build/runtime_objs.sfn`) runs a
single Darwin-gated shell probe (Linux returns `[]` — no probe, no cost). It
walks candidates in priority order and stops at the **first** hit, so exactly
one `-L<dir>` is ever emitted:

1. `SAILFIN_OPENSSL_PREFIX` — the supported override (§3), tried as
   `$SAILFIN_OPENSSL_PREFIX/lib`.
2. Standard Homebrew kegs — `/opt/homebrew/opt/openssl@3/lib` (Apple silicon),
   `/usr/local/opt/openssl@3/lib` (Intel).
3. `brew --prefix openssl@3` — shelled out **only** when the `[ -d ]` keg
   checks above all miss (a `brew` invocation is ~100–300 ms and this probe
   fires on every link, including each `sfn test` per-binary link, so it is
   kept off the fast keg-hit path).
4. `pkg-config --libs-only-L openssl` — a fallback for a non-Homebrew /
   system-registered OpenSSL, guarded by `command -v pkg-config`. Homebrew's
   `openssl@3` is keg-only so its `openssl.pc` is generally **off** the default
   `pkg-config` path; this branch targets system/registered installs, not the
   Homebrew case the keg/brew candidates already cover. When `pkg-config` is
   absent or has no `openssl.pc`, it yields empty output and the probe returns
   `[]` — a no-op, identical to the pre-fallback behavior.

The `-L` is injected into the shared runtime `link_libs` (consumed as
`plan.libs` by both the program and the `sfn test` link-argv builders), so no
link path can miss it, and it precedes `-lssl` / `-lcrypto` on the command line.

---

## 3. The `SAILFIN_OPENSSL_PREFIX` override

`SAILFIN_OPENSSL_PREFIX` is a **supported, documented** way to point the macOS
link at a specific OpenSSL install — a custom-built OpenSSL, a pinned version,
or a non-Homebrew prefix. Set it to the install **prefix** (the parent of
`lib/`); the driver appends `/lib`:

```bash
export SAILFIN_OPENSSL_PREFIX=/opt/my-openssl-3.5   # expects /opt/my-openssl-3.5/lib/libssl.dylib
make compile
```

It is the **first** candidate and, because the probe stops at the first match,
the **only** `-L` emitted when set to a valid prefix — the keg/brew/pkg-config
candidates are not consulted. A valid prefix therefore fully determines the
link search. (Regression coverage: `compiler/tests/e2e/openssl_prefix_honored_test.sfn`,
Darwin-gated — a valid prefix links; an empty-lib prefix suppresses keg
discovery and fails, proving the override is authoritative.)

---

## 4. CI provisioning

CI provisions OpenSSL for the macOS legs in the composite build action
`.github/actions/sailfin-build/action.yml`, step **`Provision OpenSSL link
path (macOS)`** (`if: target == 'macos-arm64'`). It resolves `brew --prefix
openssl@3` (installing `openssl@3` if absent) and exports both:

- `LIBRARY_PATH=<prefix>/lib` — clang honors it for `-l` resolution at link,
- `DYLD_FALLBACK_LIBRARY_PATH=<prefix>/lib` — so the linked binary loads the
  dylib at run time,

into `$GITHUB_ENV` so every later step inherits them. It runs on **all** macOS
modes — including `skip-build` test-shard jobs, which download the prebuilt
compiler yet still compile + link per-test binaries that need `-lssl` resolved.
Linux and Windows legs skip the step (byte-identical link there). The build
driver's own `-L` probe (§2) is the belt-and-suspenders complement: even
without the CI env, a macOS build with Homebrew `openssl@3` present links.

---

## References

- SFEP-0036 (`docs/proposals/0036-tls-runtime.md`) §3.1 (library choice /
  link mechanism), §5 (self-hosting impact / build-host risk).
- `#1782` — shipped `-lssl -lcrypto` + the initial keg `-L` probe.
- `#1821` — `pkg-config` fallback + `SAILFIN_OPENSSL_PREFIX` formalized as
  supported surface (this runbook).
- `compiler/src/build/runtime_objs.sfn` — `_openssl_link_search_flags`.
- `.github/actions/sailfin-build/action.yml` — CI macOS provisioning.
- `docs/status.md` — Toolchain § "Build-host OpenSSL dependency".
