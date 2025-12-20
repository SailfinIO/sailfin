; ModuleID = 'sailfin'
source_filename = "sailfin"

%Diagnostic = type opaque
%SelfHostCheckResult = type { i1, double, double, { %ModuleDiagnostics*, i64 }*, { i8**, i64 }* }
%CompiledModule = type { i8*, i8* }
%ModuleDiagnostics = type { i8*, { i8**, i64 }*, i1 }
%ModuleCompilationResult = type { %CompiledModule*, { %ModuleDiagnostics*, i64 }* }
%ProjectCompilation = type { { %CompiledModule*, i64 }*, { %ModuleDiagnostics*, i64 }* }
%LLVMCompilationResult = type { i8*, i8* }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i8* @sailfin_runtime_number_to_string(double)
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare i8* @compile_to_sailfin(i8*)
declare i8* @compile_to_native(i8*)
declare i8* @compile_to_native_python(i8*)
declare i8* @compile_to_native_llvm(i8*)
declare i8* @compile_to_llvm(i8*)
declare %LLVMCompilationResult @compile_to_native_llvm_full(i8*)
declare i8* @compile_to_native_llvm_with_context(i8*, { i8**, i64 }*, { i8**, i64 }*)
declare i8* @compile_to_native_llvm_with_manifests(i8*, { i8**, i64 }*)
declare void @main()
declare %ProjectCompilation @compile_project({ i8**, i64 }*)
declare %ModuleCompilationResult @compile_source_at_path(i8*)
declare { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }*, i8*)
declare void @report_typecheck_errors({ %Diagnostic*, i64 }*, i8*)
declare i8* @format_typecheck_diagnostic(i8*, { i8**, i64 }*, double)
declare { i8**, i64 }* @split_source_lines(i8*)
declare i8* @build_pointer_line(double, i8*, i8*)
declare i8* @join_lines({ i8**, i64 }*)
declare { i8**, i64 }* @append_string({ i8**, i64 }*, i8*)
declare i8* @number_to_string(double)
declare i8* @empty_native_module()
declare i1 @has_prefix(i8*, i8*)
declare i1 @needs_python_fallback(i8*)
declare i1 @string_contains(i8*, i8*)
declare i8* @strip_needs_python_fallback_literals(i8*)
declare i8* @strip_python_string_literals(i8*)
declare double @python_quote_length(i8*, double, i8*)
declare double @skip_python_string_literal(i8*, double, i8*, double)
declare i8* @repeat_character(i8*, double)
declare double @find_substring(i8*, i8*)
declare double @find_substring_from(i8*, i8*, double)
declare double @advance_to_line_end(i8*, double)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

; fn run_self_host_check effects: ![io]
declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

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
  %t3 = call { %ModuleDiagnostics*, i64 }* @collect_fatal_diagnostics({ %ModuleDiagnostics*, i64 }* %t2)
  store { %ModuleDiagnostics*, i64 }* %t3, { %ModuleDiagnostics*, i64 }** %l1
  %t4 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t5 = call { i8**, i64 }* @collect_missing_sources({ i8**, i64 }* %sources, %ProjectCompilation %t4)
  store { i8**, i64 }* %t5, { i8**, i64 }** %l2
  store i1 1, i1* %l3
  %t6 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t7 = load { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t6
  %t8 = extractvalue { %ModuleDiagnostics*, i64 } %t7, 1
  %t9 = icmp sgt i64 %t8, 0
  %t10 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t11 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t13 = load i1, i1* %l3
  br i1 %t9, label %then0, label %merge1
then0:
  store i1 0, i1* %l3
  %t14 = load i1, i1* %l3
  br label %merge1
merge1:
  %t15 = phi i1 [ %t14, %then0 ], [ %t13, %block.entry ]
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
  %t24 = load i1, i1* %l3
  br label %merge3
merge3:
  %t25 = phi i1 [ %t24, %then2 ], [ %t23, %merge1 ]
  store i1 %t25, i1* %l3
  %t26 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t27 = extractvalue %ProjectCompilation %t26, 0
  %t28 = load { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t27
  %t29 = extractvalue { %CompiledModule*, i64 } %t28, 1
  %t30 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t31 = extractvalue { i8**, i64 } %t30, 1
  %t32 = icmp ne i64 %t29, %t31
  %t33 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t34 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load i1, i1* %l3
  br i1 %t32, label %then4, label %merge5
then4:
  store i1 0, i1* %l3
  %t37 = load i1, i1* %l3
  br label %merge5
merge5:
  %t38 = phi i1 [ %t37, %then4 ], [ %t36, %merge3 ]
  store i1 %t38, i1* %l3
  %t39 = load i1, i1* %l3
  %t40 = insertvalue %SelfHostCheckResult undef, i1 %t39, 0
  %t41 = load %ProjectCompilation, %ProjectCompilation* %l0
  %t42 = extractvalue %ProjectCompilation %t41, 0
  %t43 = load { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t42
  %t44 = extractvalue { %CompiledModule*, i64 } %t43, 1
  %t45 = sitofp i64 %t44 to double
  %t46 = insertvalue %SelfHostCheckResult %t40, double %t45, 1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %sources
  %t48 = extractvalue { i8**, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = insertvalue %SelfHostCheckResult %t46, double %t49, 2
  %t51 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t52 = insertvalue %SelfHostCheckResult %t50, { %ModuleDiagnostics*, i64 }* %t51, 3
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t54 = insertvalue %SelfHostCheckResult %t52, { i8**, i64 }* %t53, 4
  ret %SelfHostCheckResult %t54
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
  %t85 = phi { %ModuleDiagnostics*, i64 }* [ %t13, %block.entry ], [ %t83, %loop.latch2 ]
  %t86 = phi double [ %t14, %block.entry ], [ %t84, %loop.latch2 ]
  store { %ModuleDiagnostics*, i64 }* %t85, { %ModuleDiagnostics*, i64 }** %l0
  store double %t86, double* %l1
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
  %t38 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 1
  %t39 = ptrtoint [1 x %ModuleDiagnostics]* %t38 to i64
  %t40 = icmp eq i64 %t39, 0
  %t41 = select i1 %t40, i64 1, i64 %t39
  %t42 = call i8* @malloc(i64 %t41)
  %t43 = bitcast i8* %t42 to %ModuleDiagnostics*
  %t44 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t43, i64 0
  store %ModuleDiagnostics %t37, %ModuleDiagnostics* %t44
  %t45 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t46 = ptrtoint { %ModuleDiagnostics*, i64 }* %t45 to i64
  %t47 = call i8* @malloc(i64 %t46)
  %t48 = bitcast i8* %t47 to { %ModuleDiagnostics*, i64 }*
  %t49 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t48, i32 0, i32 0
  store %ModuleDiagnostics* %t43, %ModuleDiagnostics** %t49
  %t50 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t48, i32 0, i32 1
  store i64 1, i64* %t50
  %t51 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t36, i32 0, i32 0
  %t52 = load %ModuleDiagnostics*, %ModuleDiagnostics** %t51
  %t53 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t36, i32 0, i32 1
  %t54 = load i64, i64* %t53
  %t55 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t48, i32 0, i32 0
  %t56 = load %ModuleDiagnostics*, %ModuleDiagnostics** %t55
  %t57 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t48, i32 0, i32 1
  %t58 = load i64, i64* %t57
  %t59 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 0, i32 1
  %t60 = ptrtoint %ModuleDiagnostics* %t59 to i64
  %t61 = add i64 %t54, %t58
  %t62 = mul i64 %t60, %t61
  %t63 = call noalias i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to %ModuleDiagnostics*
  %t65 = bitcast %ModuleDiagnostics* %t64 to i8*
  %t66 = mul i64 %t60, %t54
  %t67 = bitcast %ModuleDiagnostics* %t52 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t65, i8* %t67, i64 %t66)
  %t68 = mul i64 %t60, %t58
  %t69 = bitcast %ModuleDiagnostics* %t56 to i8*
  %t70 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t64, i64 %t54
  %t71 = bitcast %ModuleDiagnostics* %t70 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t71, i8* %t69, i64 %t68)
  %t72 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t73 = ptrtoint { %ModuleDiagnostics*, i64 }* %t72 to i64
  %t74 = call i8* @malloc(i64 %t73)
  %t75 = bitcast i8* %t74 to { %ModuleDiagnostics*, i64 }*
  %t76 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t75, i32 0, i32 0
  store %ModuleDiagnostics* %t64, %ModuleDiagnostics** %t76
  %t77 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t75, i32 0, i32 1
  store i64 %t61, i64* %t77
  store { %ModuleDiagnostics*, i64 }* %t75, { %ModuleDiagnostics*, i64 }** %l0
  %t78 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  br label %merge7
merge7:
  %t79 = phi { %ModuleDiagnostics*, i64 }* [ %t78, %then6 ], [ %t33, %merge5 ]
  store { %ModuleDiagnostics*, i64 }* %t79, { %ModuleDiagnostics*, i64 }** %l0
  %t80 = load double, double* %l1
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l1
  br label %loop.latch2
loop.latch2:
  %t83 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t84 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t87 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  %t88 = load double, double* %l1
  %t89 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l0
  ret { %ModuleDiagnostics*, i64 }* %t89
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
  %t33 = call i1 @module_present(i8* %t31, { %CompiledModule*, i64 }* %t32)
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