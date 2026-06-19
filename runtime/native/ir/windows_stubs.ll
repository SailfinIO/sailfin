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
