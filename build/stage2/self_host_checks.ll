; ModuleID = 'sailfin'
source_filename = "sailfin"

%SelfHostCheckResult = type { i1, double, double, { %ModuleDiagnostics**, i64 }*, { i8**, i64 }* }
%CompiledModule = type { i8*, i8* }
%ModuleDiagnostics = type { i8*, { i8**, i64 }*, i1 }
%ModuleCompilationResult = type { %CompiledModule*, { %ModuleDiagnostics**, i64 }* }
%ProjectCompilation = type { { %CompiledModule**, i64 }*, { %ModuleDiagnostics**, i64 }* }
%LLVMCompilationResult = type { %LoweredLLVMResult, %NativeModule }

declare noalias i8* @malloc(i64)

@runtime = external global i8**

; fn run_self_host_check effects: ![io]
define %SelfHostCheckResult @run_self_host_check({ i8**, i64 }* %sources) {
entry:
  %l0 = alloca %ProjectCompilation
  %l1 = alloca { %ModuleDiagnostics*, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i1
  %t0 = call %ProjectCompilation @compile_project({ i8**, i64 }* %sources)
  store %ProjectCompilation %t0, %ProjectCompilation* %l0
  %t1 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t2 = extractvalue %ProjectCompilation %t1, 1
  %t3 = bitcast { %ModuleDiagnostics**, i64 }* %t2 to { %ModuleDiagnostics*, i64 }*
  %t4 = call { %ModuleDiagnostics*, i64 }* @collect_fatal_diagnostics({ %ModuleDiagnostics*, i64 }* %t3)
  store { %ModuleDiagnostics*, i64 }* %t4, { %ModuleDiagnostics*, i64 }** %l1
  %t5 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t6 = call { i8**, i64 }* @collect_missing_sources({ i8**, i64 }* %sources, %ProjectCompilation %t5)
  store { i8**, i64 }* %t6, { i8**, i64 }** %l2
  store i1 1, i1* %l3
  %t7 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t8 = load { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t7
  %t9 = extractvalue { %ModuleDiagnostics*, i64 } %t8, 1
  %t10 = icmp sgt i64 %t9, 0
  %t11 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t12 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t14 = load i1, i1* %l3
  br i1 %t10, label %then0, label %merge1
then0:
  store i1 0, i1* %l3
  br label %merge1
merge1:
  %t15 = phi i1 [ 0, %then0 ], [ %t14, %entry ]
  store i1 %t15, i1* %l3
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t17 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t18 = extractvalue { i8**, i64 } %t17, 1
  %t19 = icmp sgt i64 %t18, 0
  %t20 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t21 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t23 = load i1, i1* %l3
  br i1 %t19, label %then2, label %merge3
then2:
  store i1 0, i1* %l3
  br label %merge3
merge3:
  %t24 = phi i1 [ 0, %then2 ], [ %t23, %entry ]
  store i1 %t24, i1* %l3
  %t25 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t26 = extractvalue %ProjectCompilation %t25, 0
  %t27 = load { %CompiledModule**, i64 }, { %CompiledModule**, i64 }* %t26
  %t28 = extractvalue { %CompiledModule**, i64 } %t27, 1
  %t29 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t30 = extractvalue { i8**, i64 } %t29, 1
  %t31 = icmp ne i64 %t28, %t30
  %t32 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t33 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = load i1, i1* %l3
  br i1 %t31, label %then4, label %merge5
then4:
  store i1 0, i1* %l3
  br label %merge5
merge5:
  %t36 = phi i1 [ 0, %then4 ], [ %t35, %entry ]
  store i1 %t36, i1* %l3
  %t37 = load i1, i1* %l3
  %t38 = insertvalue %SelfHostCheckResult undef, i1 %t37, 0
  %t39 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t40 = extractvalue %ProjectCompilation %t39, 0
  %t41 = load { %CompiledModule**, i64 }, { %CompiledModule**, i64 }* %t40
  %t42 = extractvalue { %CompiledModule**, i64 } %t41, 1
  %t43 = sitofp i64 %t42 to double
  %t44 = insertvalue %SelfHostCheckResult %t38, double %t43, 1
  %t45 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = sitofp i64 %t46 to double
  %t48 = insertvalue %SelfHostCheckResult %t44, double %t47, 2
  %t49 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t50 = bitcast { %ModuleDiagnostics*, i64 }* %t49 to { %ModuleDiagnostics**, i64 }*
  %t51 = insertvalue %SelfHostCheckResult %t48, { %ModuleDiagnostics**, i64 }* %t50, 3
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t53 = insertvalue %SelfHostCheckResult %t51, { i8**, i64 }* %t52, 4
  ret %SelfHostCheckResult %t53
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
  %t47 = phi { %ModuleDiagnostics*, i64 }* [ %t6, %entry ], [ %t45, %loop.latch2 ]
  %t48 = phi double [ %t7, %entry ], [ %t46, %loop.latch2 ]
  store { %ModuleDiagnostics*, i64 }* %t47, { %ModuleDiagnostics*, i64 }** %l0
  store double %t48, double* %l1
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
  %t16 = fptosi double %t15 to i64
  %t17 = load { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %entries
  %t18 = extractvalue { %ModuleDiagnostics*, i64 } %t17, 0
  %t19 = extractvalue { %ModuleDiagnostics*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t18, i64 %t16
  %t22 = load %ModuleDiagnostics, %ModuleDiagnostics* %t21
  store %ModuleDiagnostics %t22, %ModuleDiagnostics* %l2
  %t23 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  %t24 = extractvalue %ModuleDiagnostics %t23, 2
  %t25 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  %t28 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t29 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  %t30 = call noalias i8* @malloc(i64 24)
  %t31 = bitcast i8* %t30 to %ModuleDiagnostics*
  store %ModuleDiagnostics %t29, %ModuleDiagnostics* %t31
  %t32 = alloca [1 x i8*]
  %t33 = getelementptr [1 x i8*], [1 x i8*]* %t32, i32 0, i32 0
  %t34 = getelementptr i8*, i8** %t33, i64 0
  store i8* %t30, i8** %t34
  %t35 = alloca { i8**, i64 }
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 0
  store i8** %t33, i8*** %t36
  %t37 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 1
  store i64 1, i64* %t37
  %t38 = bitcast { %ModuleDiagnostics*, i64 }* %t28 to { i8**, i64 }*
  %t39 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t38, { i8**, i64 }* %t35)
  %t40 = bitcast { i8**, i64 }* %t39 to { %ModuleDiagnostics*, i64 }*
  store { %ModuleDiagnostics*, i64 }* %t40, { %ModuleDiagnostics*, i64 }** %l0
  br label %merge7
merge7:
  %t41 = phi { %ModuleDiagnostics*, i64 }* [ %t40, %then6 ], [ %t25, %loop.body1 ]
  store { %ModuleDiagnostics*, i64 }* %t41, { %ModuleDiagnostics*, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l1
  br label %loop.latch2
loop.latch2:
  %t45 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t46 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t49 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  ret { %ModuleDiagnostics*, i64 }* %t49
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
  %t46 = phi { i8**, i64 }* [ %t6, %entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t7, %entry ], [ %t45, %loop.latch2 ]
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  store double %t47, double* %l1
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
  %t16 = fptosi double %t15 to i64
  %t17 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  store i8* %t22, i8** %l2
  %t23 = load i8*, i8** %l2
  %t24 = extractvalue %ProjectCompilation %compilation, 0
  %t25 = bitcast { %CompiledModule**, i64 }* %t24 to { %CompiledModule*, i64 }*
  %t26 = call i1 @module_present(i8* %t23, { %CompiledModule*, i64 }* %t25)
  %t27 = xor i1 %t26, 1
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  br i1 %t27, label %then6, label %merge7
then6:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l2
  %t33 = alloca [1 x i8*]
  %t34 = getelementptr [1 x i8*], [1 x i8*]* %t33, i32 0, i32 0
  %t35 = getelementptr i8*, i8** %t34, i64 0
  store i8* %t32, i8** %t35
  %t36 = alloca { i8**, i64 }
  %t37 = getelementptr { i8**, i64 }, { i8**, i64 }* %t36, i32 0, i32 0
  store i8** %t34, i8*** %t37
  %t38 = getelementptr { i8**, i64 }, { i8**, i64 }* %t36, i32 0, i32 1
  store i64 1, i64* %t38
  %t39 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t31, { i8**, i64 }* %t36)
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t40 = phi { i8**, i64 }* [ %t39, %then6 ], [ %t28, %loop.body1 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
loop.latch2:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t48
}

define i1 @module_present(i8* %target, { %CompiledModule*, i64 }* %modules) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t1, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
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
  %t9 = fptosi double %t8 to i64
  %t10 = load { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %modules
  %t11 = extractvalue { %CompiledModule*, i64 } %t10, 0
  %t12 = extractvalue { %CompiledModule*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %CompiledModule, %CompiledModule* %t11, i64 %t9
  %t15 = load %CompiledModule, %CompiledModule* %t14
  %t16 = extractvalue %CompiledModule %t15, 0
  %t17 = icmp eq i8* %t16, %target
  %t18 = load double, double* %l0
  br i1 %t17, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
