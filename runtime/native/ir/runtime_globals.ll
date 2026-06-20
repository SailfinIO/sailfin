; `@runtime` (#1436) is no longer defined here — it moved to a
; Sailfin-emitted object (`runtime/sfn/runtime_globals.sfn`, via the
; `extern var NAME: T = init` defining-global primitive #1440, with the
; redundant `external` declaration suppressed in the defining module by
; #1445). Every emitted module still declares `@runtime = external global
; i8**`; the single strong definition now comes from the Sailfin runtime
; object linked via `sfn-sources`.

; `@sfn_default_arena` (#822 / #1308 / #1437) retired. The transitional
; `null` global only existed to satisfy a pre-#1428 macOS-arm64 seed whose
; emitter still produced load-from-`@sfn_default_arena` references. The
; pinned seed (v0.7.0-alpha.44) is built post-#1428 on every platform — its
; emitter threads `ptr null` directly (resolved by
; `string.sfn::_sfn_resolve_arena` to the real global arena), so no seed
; references the symbol anymore and the global is gone.
