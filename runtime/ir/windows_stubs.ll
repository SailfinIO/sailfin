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

; Self-applied compiler memory budget
; (`runtime/sfn/platform/rlimit.sfn`, excluded from RUNTIME_MODS —
; mingw has no getrlimit/setrlimit, so the module's libc externs
; cannot resolve in a static Windows link; the process.sfn exclusion
; precedent). A no-op is the correct Windows behavior: RLIMIT_AS is
; a POSIX concept and the Sailfin implementation already gates on a
; Linux /proc probe. Sync pinned by
; compiler/tests/e2e/test_cross_windows_runtime_modules.sh.
define i32 @apply_default_mem_limit() {
  ret i32 0
}

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
