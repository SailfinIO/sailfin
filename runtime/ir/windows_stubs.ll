; Windows-only link stubs for the `ci-cross-windows` bridge.
;
; This file is compiled and linked ONLY by the `ci-cross-windows`
; Make target — it is deliberately absent from the runtime capsule's
; `ll-sources` (runtime/native/capsule.toml), so Linux/macOS builds
; never see these definitions and there is no duplicate-symbol
; hazard with the real implementations.
;
; A note on why these are strong (not `weak`) definitions: a prior
; attempt put a `define weak` stub in runtime_globals.ll so ELF
; strong/weak resolution could share one file across targets. That
; works under ELF linkers, but mingw's BFD `ld` did not honor the
; LLVM-emitted COFF weak-external as a definition and the Windows
; link still failed with an undefined reference. Per-target strong
; stubs avoid weak-symbol semantics entirely.
;
; Retires wholesale with the cross-windows bridge when
; `sfn build --target=x86_64-w64-mingw32` lands.

; Legacy untyped `serve(handler, config?)` prelude target
; (`runtime/sfn/concurrency/serve.sfn`, excluded from RUNTIME_MODS —
; serve.sfn pulls BSD-socket + scheduler externs that cannot resolve
; in a static mingw link; the process.sfn/rlimit.sfn exclusion
; precedent). #1308 flipped this symbol from a no-op C body to a
; Sailfin no-op in serve.sfn; since that module is not in the Windows
; runtime set, `prelude.o`'s reference needs this stub. A no-op is the
; byte-identical Windows behavior (the C body was also a no-op); the
; real typed `serve(handler, port)` server (`sfn_serve`) is unaffected.
; Sync pinned by
; compiler/tests/e2e/test_cross_windows_runtime_modules.sh.
define void @sailfin_runtime_serve(i8* %handler, i8* %config) {
  ret void
}

; POSIX `realpath` (#822 / #1308): mingw-w64 does not ship it, and the
; retired `sailfin_runtime.c` provided a `_WIN32` shim forwarding to
; `_fullpath`. `runtime/sfn/platform/exec.sfn::exe_path` /
; `resolve_runtime_root` call `realpath` on every startup to canonicalize
; the binary path, so a working body is load-bearing on Windows (a broken
; one means the compiler cannot locate its runtime root). The Sailfin
; callers pass NULL for `resolved`, so `_fullpath` mallocs the buffer.
; This stub is cross-windows-only; Linux/macOS resolve `realpath` from
; libc. Sync pinned by test_cross_windows_runtime_modules.sh.
declare i8* @_fullpath(i8* %resolved, i8* %path, i32 %maxlen)
define i8* @realpath(i8* %path, i8* %resolved) {
  %r = call i8* @_fullpath(i8* %resolved, i8* %path, i32 260)
  ret i8* %r
}

; Assertion-failure handlers (#822 / #1308). On Linux/macOS the compiler's
; whole-program link emits `@runtime_assert_fail_fn` /
; `@sailfin_assert_fail` from the `runtime.assert_fail` builtin (used by
; `runtime/prelude.sfn`); the standalone cross-windows module emit does
; not, and the retired `sailfin_runtime.c` was their Windows provider.
; A failed assertion is a compiler bug, so terminating via `abort()` is
; the correct terminal behavior — the byte-for-byte Windows diagnostic
; message (file:line:col) is a post-1.0 follow-up (the cross-windows
; bridge is degraded for several such debug surfaces). These stubs are
; cross-windows-only; Linux/macOS keep the real bodies. Signatures match
; the emitted call sites (`runtime_assert_fail_fn` takes Sailfin `number`
; = `double` line/col; `sailfin_assert_fail` takes `i64`).
declare void @abort()
define void @runtime_assert_fail_fn(i8* %file, double %line, double %col, i8* %msg) {
  call void @abort()
  unreachable
}
define void @sailfin_assert_fail(i8* %file, i64 %line, i64 %col, i8* %msg) {
  call void @abort()
  unreachable
}

; Native OS entropy primitive (SFN-123, SFEP-0048 Phase D).
; `runtime/sfn/platform/rand.sfn` is excluded from RUNTIME_MODS — its
; `getentropy(2)` / `/dev/urandom` (`open`/`read`/`close`) externs have no
; static-mingw provider (the process.sfn / rlimit.sfn / tls.sfn exclusion
; precedent). The compiler links `sfn/crypto`, whose `random_bytes` wrapper
; references `@sfn_rand_fill`, so the standalone-emitted crypto IR needs it
; defined at the Windows link. A fail-closed stub (return 0 = failure) is the
; correct degraded behavior: `random_bytes` surfaces `[]`, never zeroed or
; partial entropy. It is unreached during normal compiler operation (the
; compiler does not call `random_bytes`, and the WebSocket adapter that consumes
; it for real is itself excluded from RUNTIME_MODS);
; native Windows entropy rides the same M10 OS-independent surface as TLS.
; Sync pinned by compiler/tests/e2e/cross_windows_runtime_modules_test.sfn.
define i32 @sfn_rand_fill(i8* %buf, i64 %n) {
  ret i32 0
}

; Platform trust-store enumeration (SFN-808). `runtime/sfn/platform/
; cert_roots.sfn` is excluded from RUNTIME_MODS, the same hand-rolled
; mingw bridge exclusion as `sfn_rand_fill` directly above. The compiler
; links `sfn/crypto`, whose `trust_store_load` references
; `@sfn_cert_roots_blob`, so the standalone-emitted crypto IR needs the
; symbol defined at the Windows link. Null is the correct degraded value:
; it means "this host has no enumerable platform trust store", which
; routes `trust_store_load` to its existing environment-override /
; CA-bundle-path probe rather than fabricating either trust or a failure.
; Sync pinned by compiler/tests/e2e/cross_windows_runtime_modules_test.sfn.
define i8* @sfn_cert_roots_blob() {
  ret i8* null
}

; TLS client wrappers. `runtime/sfn/platform/tls.sfn` is excluded from
; RUNTIME_MODS, so the standalone-emitted `http.o` — whose `https://` path
; forward-declares these `@tls_*` symbols — needs them defined at the
; Windows link.
;
; SFN-341 retired OpenSSL, so the ORIGINAL reason for the exclusion (the
; `libssl`/`libcrypto` externs could not resolve in a static mingw link) is
; gone. The module still stays out of RUNTIME_MODS because it now depends on
; the `sfn/crypto` capsule, which the hand-rolled cross-Windows loop
; (`Makefile`) has no staging path for. So these stubs are a deliberate
; one-release carry, exactly the fallback
; `docs/proposals/design-notes/sfn-341-native-tls-runtime-swap.md` 3.6
; sanctions — recorded, not quietly kept. Removal condition: these stubs
; delete when the cross-Windows build learns to stage a capsule dependency
; and `tls.sfn` joins RUNTIME_MODS, which is the same work as the Windows
; certificate-store binding that design note 3.6 scopes out of SFN-341.
;
; No-op stubs remain the correct degraded behavior: `tls_client_ctx` /
; `tls_connect_fd` return null so `_http_send` surfaces a clean null
; (https unsupported on Windows for now, never a silent downgrade); the
; read/write/free helpers are unreachable once the ctx is null but are
; defined for completeness. Plaintext `http://` is unaffected. Sync pinned
; by compiler/tests/e2e/cross_windows_runtime_modules_test.sfn.
define i8* @tls_client_ctx() {
  ret i8* null
}
define void @tls_ctx_free(i8* %ctx) {
  ret void
}
define i8* @tls_connect_fd(i8* %ctx, i32 %fd, i8* %host) {
  ret i8* null
}
define i64 @tls_read(i8* %ssl, i8* %buf, i64 %n) {
  ret i64 -1
}
define i64 @tls_write(i8* %ssl, i8* %buf, i64 %n) {
  ret i64 -1
}
define void @tls_shutdown_free(i8* %ssl) {
  ret void
}
