; ModuleID = 'sailfin'
source_filename = "sailfin"

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare noalias i8* @malloc(i64)

@runtime__cli_emit = external global i8**

define double @cli_emit_stub() {
block.entry:
  %t0 = sitofp i64 0 to double
  ret double %t0
}

define double @add__cli_emit(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
