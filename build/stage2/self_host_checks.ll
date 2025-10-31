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
  %t62 = phi { %ModuleDiagnostics*, i64 }* [ %t13, %block.entry ], [ %t60, %loop.latch2 ]
  %t63 = phi double [ %t14, %block.entry ], [ %t61, %loop.latch2 ]
  store { %ModuleDiagnostics*, i64 }* %t62, { %ModuleDiagnostics*, i64 }** %l0
  store double %t63, double* %l1
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
  %t23 = fptosi double %t22 to i64
  %t24 = load { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %entries
  %t25 = extractvalue { %ModuleDiagnostics*, i64 } %t24, 0
  %t26 = extractvalue { %ModuleDiagnostics*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t25, i64 %t23
  %t29 = load %ModuleDiagnostics, %ModuleDiagnostics* %t28
  store %ModuleDiagnostics %t29, %ModuleDiagnostics* %l2
  %t30 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  %t31 = extractvalue %ModuleDiagnostics %t30, 2
  %t32 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  br i1 %t31, label %then6, label %merge7
then6:
  %t35 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t36 = load %ModuleDiagnostics, %ModuleDiagnostics* %l2
  %t37 = call noalias i8* @malloc(i64 24)
  %t38 = bitcast i8* %t37 to %ModuleDiagnostics*
  store %ModuleDiagnostics %t36, %ModuleDiagnostics* %t38
  %t39 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t40 = ptrtoint [1 x i8*]* %t39 to i64
  %t41 = icmp eq i64 %t40, 0
  %t42 = select i1 %t41, i64 1, i64 %t40
  %t43 = call i8* @malloc(i64 %t42)
  %t44 = bitcast i8* %t43 to i8**
  %t45 = getelementptr i8*, i8** %t44, i64 0
  store i8* %t37, i8** %t45
  %t46 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t47 = ptrtoint { i8**, i64 }* %t46 to i64
  %t48 = call i8* @malloc(i64 %t47)
  %t49 = bitcast i8* %t48 to { i8**, i64 }*
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t49, i32 0, i32 0
  store i8** %t44, i8*** %t50
  %t51 = getelementptr { i8**, i64 }, { i8**, i64 }* %t49, i32 0, i32 1
  store i64 1, i64* %t51
  %t52 = bitcast { %ModuleDiagnostics*, i64 }* %t35 to { i8**, i64 }*
  %t53 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t52, { i8**, i64 }* %t49)
  %t54 = bitcast { i8**, i64 }* %t53 to { %ModuleDiagnostics*, i64 }*
  store { %ModuleDiagnostics*, i64 }* %t54, { %ModuleDiagnostics*, i64 }** %l0
  %t55 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  br label %merge7
merge7:
  %t56 = phi { %ModuleDiagnostics*, i64 }* [ %t55, %then6 ], [ %t32, %merge5 ]
  store { %ModuleDiagnostics*, i64 }* %t56, { %ModuleDiagnostics*, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l1
  br label %loop.latch2
loop.latch2:
  %t60 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t61 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t64 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t65 = load double, double* %l1
  %t66 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  ret { %ModuleDiagnostics*, i64 }* %t66
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
  %t61 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t59, %loop.latch2 ]
  %t62 = phi double [ %t14, %block.entry ], [ %t60, %loop.latch2 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  store double %t62, double* %l1
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
  %t23 = fptosi double %t22 to i64
  %t24 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  store i8* %t29, i8** %l2
  %t30 = load i8*, i8** %l2
  %t31 = extractvalue %ProjectCompilation %compilation, 0
  %t32 = bitcast { %CompiledModule**, i64 }* %t31 to { %CompiledModule*, i64 }*
  %t33 = call i1 @module_present(i8* %t30, { %CompiledModule*, i64 }* %t32)
  %t34 = xor i1 %t33, 1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then6, label %merge7
then6:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load i8*, i8** %l2
  %t40 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t41 = ptrtoint [1 x i8*]* %t40 to i64
  %t42 = icmp eq i64 %t41, 0
  %t43 = select i1 %t42, i64 1, i64 %t41
  %t44 = call i8* @malloc(i64 %t43)
  %t45 = bitcast i8* %t44 to i8**
  %t46 = getelementptr i8*, i8** %t45, i64 0
  store i8* %t39, i8** %t46
  %t47 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t48 = ptrtoint { i8**, i64 }* %t47 to i64
  %t49 = call i8* @malloc(i64 %t48)
  %t50 = bitcast i8* %t49 to { i8**, i64 }*
  %t51 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 0
  store i8** %t45, i8*** %t51
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 1
  store i64 1, i64* %t52
  %t53 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t38, { i8**, i64 }* %t50)
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t55 = phi { i8**, i64 }* [ %t54, %then6 ], [ %t35, %merge5 ]
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  %t56 = load double, double* %l1
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l1
  br label %loop.latch2
loop.latch2:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load double, double* %l1
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t65
}

define i1 @module_present(i8* %target, { %CompiledModule*, i64 }* %modules) {
block.entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t1, %block.entry ], [ %t22, %loop.latch2 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
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
  %t24 = load double, double* %l0
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
