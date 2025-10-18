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
  %t6 = load double, double* %l0
  %t7 = load i1, i1* %l3
  %t8 = insertvalue %SelfHostCheckResult undef, i1 %t7, 0
  %t9 = load double, double* %l0
  %t10 = insertvalue %SelfHostCheckResult %t8, double 0.0, 1
  %t11 = insertvalue %SelfHostCheckResult %t10, double 0.0, 2
  %t12 = load double, double* %l1
  %t13 = insertvalue %SelfHostCheckResult %t11, { i8**, i64 }* null, 3
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t15 = insertvalue %SelfHostCheckResult %t13, { i8**, i64 }* %t14, 4
  ret %SelfHostCheckResult %t15
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
  %t21 = phi double [ %t7, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t22
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
  %t21 = phi double [ %t7, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t22
}

define i1 @module_present(i8* %target, { i8**, i64 }* %modules) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t14 = phi double [ %t1, %entry ], [ %t13, %loop.latch2 ]
  store double %t14, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load { i8**, i64 }, { i8**, i64 }* %modules
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 %t3, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 %t3
  %t9 = load i8*, i8** %t8
  %t10 = load double, double* %l0
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l0
  br label %loop.latch2
loop.latch2:
  %t13 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
