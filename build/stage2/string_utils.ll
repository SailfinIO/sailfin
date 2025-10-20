; ModuleID = 'sailfin'
source_filename = "sailfin"

declare i8* @sailfin_runtime_substring(i8*, i64, i64)

declare noalias i8* @malloc(i64)

define i8* @char_at(i8* %value, double %index) {
entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = sitofp i64 0 to double
  %t4 = fcmp olt double %index, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge3:
  %t6 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %index, %t7
  br i1 %t8, label %then4, label %merge5
then4:
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.9, i32 0, i32 0
  ret i8* %s9
merge5:
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %index, %t10
  %t12 = fptosi double %index to i64
  %t13 = fptosi double %t11 to i64
  %t14 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t12, i64 %t13)
  ret i8* %t14
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
