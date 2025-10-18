; ModuleID = 'sailfin'
source_filename = "sailfin"

declare noalias i8* @malloc(i64)

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
