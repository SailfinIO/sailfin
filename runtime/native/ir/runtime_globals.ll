; Native definition for the Stage2 external @runtime global.
; The stage2 IR declares `@runtime = external global i8**`.
; Defining it as an `i8*` global yields an `i8**`-typed symbol.

@runtime = global i8* null
