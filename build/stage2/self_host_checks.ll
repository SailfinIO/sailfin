; ModuleID = 'sailfin'
source_filename = "sailfin"

%SelfHostCheckResult = type { i1, double, double, { %ModuleDiagnostics**, i64 }*, { i8**, i64 }* }
%CompiledModule = type { i8*, i8* }
%ModuleDiagnostics = type { i8*, { i8**, i64 }*, i1 }
%ModuleCompilationResult = type { %CompiledModule*, { %ModuleDiagnostics**, i64 }* }
%ProjectCompilation = type { { %CompiledModule**, i64 }*, { %ModuleDiagnostics**, i64 }* }
%LLVMCompilationResult = type { %LoweredLLVMResult, %NativeModule }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

; fn run_self_host_check effects: ![io]
define %SelfHostCheckResult @run_self_host_check({ i8**, i64 }* %sources) {
block.entry:
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
  %t15 = load i1, i1* %l3
  br label %merge1
merge1:
  %t16 = phi i1 [ %t15, %then0 ], [ %t14, %block.entry ]
  store i1 %t16, i1* %l3
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t17
  %t19 = extractvalue { i8**, i64 } %t18, 1
  %t20 = icmp sgt i64 %t19, 0
  %t21 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t22 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load i1, i1* %l3
  br i1 %t20, label %then2, label %merge3
then2:
  store i1 0, i1* %l3
  %t25 = load i1, i1* %l3
  br label %merge3
merge3:
  %t26 = phi i1 [ %t25, %then2 ], [ %t24, %merge1 ]
  store i1 %t26, i1* %l3
  %t27 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t28 = extractvalue %ProjectCompilation %t27, 0
  %t29 = load { %CompiledModule**, i64 }, { %CompiledModule**, i64 }* %t28
  %t30 = extractvalue { %CompiledModule**, i64 } %t29, 1
  %t31 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t32 = extractvalue { i8**, i64 } %t31, 1
  %t33 = icmp ne i64 %t30, %t32
  %t34 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t35 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t37 = load i1, i1* %l3
  br i1 %t33, label %then4, label %merge5
then4:
  store i1 0, i1* %l3
  %t38 = load i1, i1* %l3
  br label %merge5
merge5:
  %t39 = phi i1 [ %t38, %then4 ], [ %t37, %merge3 ]
  store i1 %t39, i1* %l3
  %t40 = load i1, i1* %l3
  %t41 = insertvalue %SelfHostCheckResult undef, i1 %t40, 0
  %t42 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t43 = extractvalue %ProjectCompilation %t42, 0
  %t44 = load { %CompiledModule**, i64 }, { %CompiledModule**, i64 }* %t43
  %t45 = extractvalue { %CompiledModule**, i64 } %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = insertvalue %SelfHostCheckResult %t41, double %t46, 1
  %t48 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t49 = extractvalue { i8**, i64 } %t48, 1
  %t50 = sitofp i64 %t49 to double
  %t51 = insertvalue %SelfHostCheckResult %t47, double %t50, 2
  %t52 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t53 = bitcast { %ModuleDiagnostics*, i64 }* %t52 to { %ModuleDiagnostics**, i64 }*
  %t54 = insertvalue %SelfHostCheckResult %t51, { %ModuleDiagnostics**, i64 }* %t53, 3
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t56 = insertvalue %SelfHostCheckResult %t54, { i8**, i64 }* %t55, 4
  ret %SelfHostCheckResult %t56
}

define { %ModuleDiagnostics*, i64 }* @collect_fatal_diagnostics({ %ModuleDiagnostics*, i64 }* %entries) {
block.entry:
  %l0 = alloca { %ModuleDiagnostics*, i64 }*
  %l1 = alloca double
  %l2 = alloca %ModuleDiagnostics
  %t0 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* null, i32 1
  %t1 = ptrtoint [0 x %ModuleDiagnostics]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %ModuleDiagnostics*
  %t6 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t7 = ptrtoint { %ModuleDiagnostics*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %ModuleDiagnostics*, i64 }*
  %t10 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t9, i32 0, i32 0
  store %ModuleDiagnostics* %t5, %ModuleDiagnostics** %t10
  %t11 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %ModuleDiagnostics*, i64 }* %t9, { %ModuleDiagnostics*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t63 = phi { %ModuleDiagnostics*, i64 }* [ %t13, %block.entry ], [ %t61, %loop.latch2 ]
  %t64 = phi double [ %t14, %block.entry ], [ %t62, %loop.latch2 ]
  store { %ModuleDiagnostics*, i64 }* %t63, { %ModuleDiagnostics*, i64 }** %l0
  store double %t64, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %entries
  %t17 = extractvalue { %ModuleDiagnostics*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %entries
  %t26 = extractvalue { %ModuleDiagnostics*, i64 } %t25, 0
  %t27 = extractvalue { %ModuleDiagnostics*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t26, i64 %t24
  %t30 = load %ModuleDiagnostics, %ModuleDiagnostics* %t29
  store %ModuleDiagnostics %t30, %ModuleDiagnostics* %l2
  %t31 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  %t32 = extractvalue %ModuleDiagnostics %t31, 2
  %t33 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  br i1 %t32, label %then6, label %merge7
then6:
  %t36 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t37 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  %t38 = call noalias i8* @malloc(i64 24)
  %t39 = bitcast i8* %t38 to %ModuleDiagnostics*
  store %ModuleDiagnostics %t37, %ModuleDiagnostics* %t39
  %t40 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t41 = ptrtoint [1 x i8*]* %t40 to i64
  %t42 = icmp eq i64 %t41, 0
  %t43 = select i1 %t42, i64 1, i64 %t41
  %t44 = call i8* @malloc(i64 %t43)
  %t45 = bitcast i8* %t44 to i8**
  %t46 = getelementptr i8*, i8** %t45, i64 0
  store i8* %t38, i8** %t46
  %t47 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t48 = ptrtoint { i8**, i64 }* %t47 to i64
  %t49 = call i8* @malloc(i64 %t48)
  %t50 = bitcast i8* %t49 to { i8**, i64 }*
  %t51 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 0
  store i8** %t45, i8*** %t51
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 1
  store i64 1, i64* %t52
  %t53 = bitcast { %ModuleDiagnostics*, i64 }* %t36 to { i8**, i64 }*
  %t54 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t53, { i8**, i64 }* %t50)
  %t55 = bitcast { i8**, i64 }* %t54 to { %ModuleDiagnostics*, i64 }*
  store { %ModuleDiagnostics*, i64 }* %t55, { %ModuleDiagnostics*, i64 }** %l0
  %t56 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  br label %merge7
merge7:
  %t57 = phi { %ModuleDiagnostics*, i64 }* [ %t56, %then6 ], [ %t33, %merge5 ]
  store { %ModuleDiagnostics*, i64 }* %t57, { %ModuleDiagnostics*, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l1
  br label %loop.latch2
loop.latch2:
  %t61 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t62 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t65 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t66 = load double, double* %l1
  %t67 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  ret { %ModuleDiagnostics*, i64 }* %t67
}

define { i8**, i64 }* @collect_missing_sources({ i8**, i64 }* %sources, %ProjectCompilation %compilation) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t62 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t60, %loop.latch2 ]
  %t63 = phi double [ %t14, %block.entry ], [ %t61, %loop.latch2 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l0
  store double %t63, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  %t32 = extractvalue %ProjectCompilation %compilation, 0
  %t33 = bitcast { %CompiledModule**, i64 }* %t32 to { %CompiledModule*, i64 }*
  %t34 = call i1 @module_present(i8* %t31, { %CompiledModule*, i64 }* %t33)
  %t35 = xor i1 %t34, 1
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = load i8*, i8** %l2
  br i1 %t35, label %then6, label %merge7
then6:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l2
  %t41 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t42 = ptrtoint [1 x i8*]* %t41 to i64
  %t43 = icmp eq i64 %t42, 0
  %t44 = select i1 %t43, i64 1, i64 %t42
  %t45 = call i8* @malloc(i64 %t44)
  %t46 = bitcast i8* %t45 to i8**
  %t47 = getelementptr i8*, i8** %t46, i64 0
  store i8* %t40, i8** %t47
  %t48 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t49 = ptrtoint { i8**, i64 }* %t48 to i64
  %t50 = call i8* @malloc(i64 %t49)
  %t51 = bitcast i8* %t50 to { i8**, i64 }*
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 0
  store i8** %t46, i8*** %t52
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t39, { i8**, i64 }* %t51)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t56 = phi { i8**, i64 }* [ %t55, %then6 ], [ %t36, %merge5 ]
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l1
  br label %loop.latch2
loop.latch2:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load double, double* %l1
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t66
}

define i1 @module_present(i8* %target, { %CompiledModule*, i64 }* %modules) {
block.entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t1, %block.entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
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
  %t9 = call double @llvm.round.f64(double %t8)
  %t10 = fptosi double %t9 to i64
  %t11 = load { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %modules
  %t12 = extractvalue { %CompiledModule*, i64 } %t11, 0
  %t13 = extractvalue { %CompiledModule*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr %CompiledModule, %CompiledModule* %t12, i64 %t10
  %t16 = load %CompiledModule, %CompiledModule* %t15
  %t17 = extractvalue %CompiledModule %t16, 0
  %t18 = call i1 @strings_equal(i8* %t17, i8* %target)
  %t19 = load double, double* %l0
  br i1 %t18, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t25 = load double, double* %l0
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
