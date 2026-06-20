; `@runtime` (#1436) is no longer defined here — it moved to a
; Sailfin-emitted object (`runtime/sfn/runtime_globals.sfn`, via the
; `extern var NAME: T = init` defining-global primitive #1440, with the
; redundant `external` declaration suppressed in the defining module by
; #1445). Every emitted module still declares `@runtime = external global
; i8**`; the single strong definition now comes from the Sailfin runtime
; object linked via `sfn-sources`.

; `@sfn_default_arena` (#822 / #1308) — the IR-visible default-arena slot.
; The compiler SOURCE no longer emits references to it (#1428 switched the
; arena operand to a literal `null`), but the pinned macOS-arm64 seed
; binary still emits load-from-`@sfn_default_arena` references in some
; modules (typecheck / num_format / parser / effect_gate); the linux-x86_64
; seed does not. The deleted `sailfin_runtime.c` was their provider
; (`SfnArray *sfn_default_arena = NULL;`). Re-provide the global here so the
; macOS link resolves. A `null` value is correct, not just link-satisfying:
; the runtime threads this slot through `string.sfn::_sfn_resolve_arena`,
; which returns `sfn_arena_global()` whenever the slot's handle is 0 — so a
; null slot resolves to the real global arena on every path, identical to
; #1428's direct-`null` emission. Linked on all targets; unreferenced and
; harmless where the seed does not emit it. Retires once the seed is bumped
; past the #1428 propagation (drop this global then).
@sfn_default_arena = global i8* null
