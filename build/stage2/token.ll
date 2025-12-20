; ModuleID = 'sailfin'
source_filename = "sailfin"

%Token = type { %TokenKind, i8*, double, double }

%TokenKind = type { i32 }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

define %Token @eof_token(double %line, double %column) {
block.entry:
  %t0 = insertvalue %TokenKind undef, i32 7, 0
  %t1 = insertvalue %Token undef, %TokenKind %t0, 0
  %t2 = call i8* @malloc(i64 1)
  %t3 = bitcast i8* %t2 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t3
  %t4 = insertvalue %Token %t1, i8* %t2, 1
  %t5 = insertvalue %Token %t4, double %line, 2
  %t6 = insertvalue %Token %t5, double %column, 3
  ret %Token %t6
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
