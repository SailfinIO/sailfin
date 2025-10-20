; ModuleID = 'sailfin'
source_filename = "sailfin"

%Token = type { %TokenKind*, i8*, double, double }

%TokenKind = type { i32, [8 x i8] }

declare noalias i8* @malloc(i64)

@.str.2 = private unnamed_addr constant [1 x i8] c"\00"

define %Token @eof_token(double %line, double %column) {
entry:
  %t0 = insertvalue %TokenKind undef, i32 7, 0
  %t1 = insertvalue %Token undef, %TokenKind* null, 0
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  %t3 = insertvalue %Token %t1, i8* %s2, 1
  %t4 = insertvalue %Token %t3, double %line, 2
  %t5 = insertvalue %Token %t4, double %column, 3
  ret %Token %t5
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
