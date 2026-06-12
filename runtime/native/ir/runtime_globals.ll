; Native definition for the Stage2 external @runtime global.
; The stage2 IR declares `@runtime = external global i8**`.
; Defining it as an `i8*` global yields an `i8**`-typed symbol.

@runtime = global i8* null

; Weak no-op stub for the self-applied compiler memory budget
; (`runtime/sfn/platform/rlimit.sfn`). On Linux/macOS the Sailfin
; module's strong definition wins and this stub is discarded. The
; `ci-cross-windows` bridge excludes rlimit.sfn from its RUNTIME_MODS
; (mingw has no getrlimit/setrlimit, so the module's libc externs
; cannot resolve in a static Windows link — the process.sfn exclusion
; precedent); this weak definition satisfies cli_main's
; `apply_default_mem_limit` reference there instead. Windows is a
; deliberate no-op — RLIMIT_AS is a POSIX concept and the Sailfin
; implementation already gates on a Linux /proc probe. Retires with
; the cross-windows bridge when `sfn build --target` lands.
define weak i32 @apply_default_mem_limit() {
  ret i32 0
}
