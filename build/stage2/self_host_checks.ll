; ModuleID = 'sailfin'
source_filename = "sailfin"

%SelfHostCheckResult = type { i1, double, double, { i8**, i64 }*, { i8**, i64 }* }

declare noalias i8* @malloc(i64)

; fn run_self_host_check effects: ![io]
define %SelfHostCheckResult @run_self_host_check({ i8**, i64 }* %sources) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i1
  %t0 = call double @compile_project({ i8**, i64 }* %sources)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  store double 0.0, double* %l1
  %t2 = load double, double* %l0
  %t3 = call { i8**, i64 }* @collect_missing_sources({ i8**, i64 }* %sources, i8* null)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l2
  store i1 1, i1* %l3
  %t4 = load double, double* %l1
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t6 = load { i8**, i64 }, { i8**, i64 }* %t5
  %t7 = extractvalue { i8**, i64 } %t6, 1
  %t8 = icmp sgt i64 %t7, 0
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t12 = load i1, i1* %l3
  br i1 %t8, label %then0, label %merge1
then0:
  store i1 0, i1* %l3
  br label %merge1
merge1:
  %t13 = phi i1 [ 0, %then0 ], [ %t12, %entry ]
  store i1 %t13, i1* %l3
  %t14 = load double, double* %l0
  %t15 = load i1, i1* %l3
  %t16 = insertvalue %SelfHostCheckResult undef, i1 %t15, 0
  %t17 = load double, double* %l0
  %t18 = insertvalue %SelfHostCheckResult %t16, double 0.0, 1
  %t19 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t20 = extractvalue { i8**, i64 } %t19, 1
  %t21 = sitofp i64 %t20 to double
  %t22 = insertvalue %SelfHostCheckResult %t18, double %t21, 2
  %t23 = load double, double* %l1
  %t24 = insertvalue %SelfHostCheckResult %t22, { i8**, i64 }* null, 3
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = insertvalue %SelfHostCheckResult %t24, { i8**, i64 }* %t25, 4
  ret %SelfHostCheckResult %t26
}

define { i8**, i64 }* @collect_fatal_diagnostics({ i8**, i64 }* %entries) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t27 = phi double [ %t7, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store i8* %t21, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch2
loop.latch2:
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t28
}

define { i8**, i64 }* @collect_missing_sources({ i8**, i64 }* %sources, i8* %compilation) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t27 = phi double [ %t7, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store i8* %t21, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch2
loop.latch2:
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t28
}

define i1 @module_present(i8* %target, { i8**, i64 }* %modules) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t19 = phi double [ %t1, %entry ], [ %t18, %loop.latch2 ]
  store double %t19, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { i8**, i64 }, { i8**, i64 }* %modules
  %t4 = extractvalue { i8**, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = load { i8**, i64 }, { i8**, i64 }* %modules
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = load double, double* %l0
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l0
  br label %loop.latch2
loop.latch2:
  %t18 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
