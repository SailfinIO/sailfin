; ModuleID = 'sailfin'
source_filename = "sailfin"

%SelfHostCheckResult = type { i1, double, double, { i8**, i64 }*, { i8**, i64 }* }
%CompiledModule = type { i8*, i8* }
%ModuleDiagnostics = type { i8*, { i8**, i64 }*, i1 }
%ModuleCompilationResult = type { i8*, { i8**, i64 }* }
%ProjectCompilation = type { { i8**, i64 }*, { i8**, i64 }* }
%LLVMCompilationResult = type { i8*, i8* }

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
  %t3 = call { i8**, i64 }* @collect_missing_sources({ i8**, i64 }* %sources, %ProjectCompilation zeroinitializer)
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

define { %ModuleDiagnostics*, i64 }* @collect_fatal_diagnostics({ %ModuleDiagnostics*, i64 }* %entries) {
entry:
  %l0 = alloca { %ModuleDiagnostics*, i64 }*
  %l1 = alloca double
  %l2 = alloca %ModuleDiagnostics
  %t0 = alloca [0 x %ModuleDiagnostics]
  %t1 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* %t0, i32 0, i32 0
  %t2 = alloca { %ModuleDiagnostics*, i64 }
  %t3 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t2, i32 0, i32 0
  store %ModuleDiagnostics* %t1, %ModuleDiagnostics** %t3
  %t4 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %ModuleDiagnostics*, i64 }* %t2, { %ModuleDiagnostics*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t41 = phi { %ModuleDiagnostics*, i64 }* [ %t6, %entry ], [ %t39, %loop.latch2 ]
  %t42 = phi double [ %t7, %entry ], [ %t40, %loop.latch2 ]
  store { %ModuleDiagnostics*, i64 }* %t41, { %ModuleDiagnostics*, i64 }** %l0
  store double %t42, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %entries
  %t10 = extractvalue { %ModuleDiagnostics*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %entries
  %t17 = extractvalue { %ModuleDiagnostics*, i64 } %t16, 0
  %t18 = extractvalue { %ModuleDiagnostics*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t17, i64 %t15
  %t21 = load %ModuleDiagnostics, %ModuleDiagnostics* %t20
  store %ModuleDiagnostics %t21, %ModuleDiagnostics* %l2
  %t22 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  %t23 = extractvalue %ModuleDiagnostics %t22, 2
  %t24 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  br i1 %t23, label %then6, label %merge7
then6:
  %t27 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  %t28 = alloca [1 x %ModuleDiagnostics]
  %t29 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* %t28, i32 0, i32 0
  %t30 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t29, i64 0
  store %ModuleDiagnostics %t27, %ModuleDiagnostics* %t30
  %t31 = alloca { %ModuleDiagnostics*, i64 }
  %t32 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t31, i32 0, i32 0
  store %ModuleDiagnostics* %t29, %ModuleDiagnostics** %t32
  %t33 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t31, i32 0, i32 1
  store i64 1, i64* %t33
  %t34 = call double @fatalconcat({ %ModuleDiagnostics*, i64 }* %t31)
  store { %ModuleDiagnostics*, i64 }* null, { %ModuleDiagnostics*, i64 }** %l0
  br label %merge7
merge7:
  %t35 = phi { %ModuleDiagnostics*, i64 }* [ null, %then6 ], [ %t24, %loop.body1 ]
  store { %ModuleDiagnostics*, i64 }* %t35, { %ModuleDiagnostics*, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch2
loop.latch2:
  %t39 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t40 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t43 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  ret { %ModuleDiagnostics*, i64 }* %t43
}

define { i8**, i64 }* @collect_missing_sources({ i8**, i64 }* %sources, %ProjectCompilation %compilation) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t43 = phi { i8**, i64 }* [ %t6, %entry ], [ %t41, %loop.latch2 ]
  %t44 = phi double [ %t7, %entry ], [ %t42, %loop.latch2 ]
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  store double %t44, double* %l1
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
  %t23 = extractvalue %ProjectCompilation %compilation, 0
  %t24 = call i1 @module_present(i8* %t22, { %CompiledModule*, i64 }* null)
  %t25 = xor i1 %t24, 1
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load double, double* %l1
  %t28 = load i8*, i8** %l2
  br i1 %t25, label %then6, label %merge7
then6:
  %t29 = load i8*, i8** %l2
  %t30 = alloca [1 x i8*]
  %t31 = getelementptr [1 x i8*], [1 x i8*]* %t30, i32 0, i32 0
  %t32 = getelementptr i8*, i8** %t31, i64 0
  store i8* %t29, i8** %t32
  %t33 = alloca { i8**, i64 }
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 0
  store i8** %t31, i8*** %t34
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = call double @missingconcat({ i8**, i64 }* %t33)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t37 = phi { i8**, i64 }* [ null, %then6 ], [ %t26, %loop.body1 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch2
loop.latch2:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t45
}

define i1 @module_present(i8* %target, { %CompiledModule*, i64 }* %modules) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t22 = phi double [ %t1, %entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %modules
  %t4 = extractvalue { %CompiledModule*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = load { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %modules
  %t10 = extractvalue { %CompiledModule*, i64 } %t9, 0
  %t11 = extractvalue { %CompiledModule*, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr %CompiledModule, %CompiledModule* %t10, i64 %t8
  %t14 = load %CompiledModule, %CompiledModule* %t13
  %t15 = extractvalue %CompiledModule %t14, 0
  %t16 = icmp eq i8* %t15, %target
  %t17 = load double, double* %l0
  br i1 %t16, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch2
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
