; ModuleID = 'sailfin'
source_filename = "sailfin"

%CompiledModule = type { i8*, i8* }
%ModuleDiagnostics = type { i8*, { i8**, i64 }*, i1 }
%ModuleCompilationResult = type { i8*, { i8**, i64 }* }
%ProjectCompilation = type { { i8**, i64 }*, { i8**, i64 }* }

; intrinsic sailfin_runtime_print_info requires capabilities: ![io]
declare void @sailfin_runtime_print_info(i8*)
; intrinsic sailfin_runtime_print_error requires capabilities: ![io]
declare void @sailfin_runtime_print_error(i8*)
; intrinsic sailfin_runtime_print_warn requires capabilities: ![io]
declare void @sailfin_runtime_print_warn(i8*)

declare noalias i8* @malloc(i64)

@.str.0 = private unnamed_addr constant [27 x i8] c"Sailfin compiler (stage 0)\00"
@.str.1 = private unnamed_addr constant [13 x i8] c"[typecheck] \00"
@.str.2 = private unnamed_addr constant [2 x i8] c" \00"
@.str.18 = private unnamed_addr constant [3 x i8] c" |\00"
@.str.23 = private unnamed_addr constant [1 x i8] c"\00"
@.str.63 = private unnamed_addr constant [4 x i8] c" | \00"
@.str.10 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.0 = private unnamed_addr constant [26 x i8] c"def needs_python_fallback\00"
@.str.8 = private unnamed_addr constant [13 x i8] c"return False\00"

; fn compile_to_sailfin effects: ![io]
define i8* @compile_to_sailfin(i8* %source) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = call double @parse_program(i8* %source)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call double @typecheck_program(double %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = load double, double* %l0
  %t5 = call double @emit_program(double %t4)
  ret i8* null
}

; fn main effects: ![io]
define void @main() {
entry:
  %s0 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.0, i32 0, i32 0
  call void @sailfin_runtime_print_info(i8* %s0)
  ret void
}

; fn compile_project effects: ![io]
define %ProjectCompilation @compile_project({ i8**, i64 }* %sources) {
entry:
  %l0 = alloca { %CompiledModule*, i64 }*
  %l1 = alloca { %ModuleDiagnostics*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca %ModuleCompilationResult
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %CompiledModule*, i64 }* null, { %CompiledModule*, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %ModuleDiagnostics*, i64 }* null, { %ModuleDiagnostics*, i64 }** %l1
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %sources, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %sources, i32 0, i32 0
  %t13 = load i8**, i8*** %t12
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr i8*, i8** %t13, i64 %t16
  %t18 = load i8*, i8** %t17
  store i8* %t18, i8** %l3
  %t19 = load i8*, i8** %l3
  %t20 = call %ModuleCompilationResult @compile_source_at_path(i8* %t19)
  store %ModuleCompilationResult %t20, %ModuleCompilationResult* %l4
  %t21 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t22 = extractvalue %ModuleCompilationResult %t21, 0
  %t23 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t24 = extractvalue %ModuleCompilationResult %t23, 1
  br label %forinc2
forinc2:
  %t25 = load i64, i64* %l2
  %t26 = add i64 %t25, 1
  store i64 %t26, i64* %l2
  br label %for0
afterfor3:
  %t27 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t28 = insertvalue %ProjectCompilation undef, { i8**, i64 }* null, 0
  %t29 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t30 = insertvalue %ProjectCompilation %t28, { i8**, i64 }* null, 1
  ret %ProjectCompilation %t30
}

; fn compile_source_at_path effects: ![io]
define %ModuleCompilationResult @compile_source_at_path(i8* %source_path) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca i1
  %l8 = alloca { %ModuleDiagnostics*, i64 }*
  %t0 = call double @fsreadFile(i8* %source_path)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call double @parse_program(double %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = call double @typecheck_program(double %t3)
  store double %t4, double* %l2
  %t5 = load double, double* %l2
  %t6 = load double, double* %l1
  %t7 = call double @emit_native(double %t6)
  store double %t7, double* %l3
  %t8 = load double, double* %l3
  store double 0.0, double* %l4
  %t9 = load double, double* %l4
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t10 = load double, double* %l4
  store double 0.0, double* %l6
  %t11 = load double, double* %l6
  %t12 = call i1 @needs_python_fallback(i8* null)
  store i1 %t12, i1* %l7
  %t13 = load i1, i1* %l7
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  %t17 = load double, double* %l3
  %t18 = load double, double* %l4
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t20 = load double, double* %l6
  %t21 = load i1, i1* %l7
  br i1 %t13, label %then0, label %merge1
then0:
  %s22 = getelementptr inbounds [86 x i8], [86 x i8]* @.str.22, i32 0, i32 0
  %t23 = alloca [1 x i8*]
  %t24 = getelementptr [1 x i8*], [1 x i8*]* %t23, i32 0, i32 0
  %t25 = getelementptr i8*, i8** %t24, i64 0
  store i8* %s22, i8** %t25
  %t26 = alloca { i8**, i64 }
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* %t26, i32 0, i32 0
  store i8** %t24, i8*** %t27
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* %t26, i32 0, i32 1
  store i64 1, i64* %t28
  %t29 = call double @messagesconcat({ i8**, i64 }* %t26)
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t30 = insertvalue %ModuleCompilationResult undef, i8* null, 0
  %t31 = insertvalue %ModuleDiagnostics undef, i8* %source_path, 0
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t33 = insertvalue %ModuleDiagnostics %t31, { i8**, i64 }* %t32, 1
  %t34 = insertvalue %ModuleDiagnostics %t33, i1 1, 2
  %t35 = alloca [1 x %ModuleDiagnostics]
  %t36 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* %t35, i32 0, i32 0
  %t37 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t36, i64 0
  store %ModuleDiagnostics %t34, %ModuleDiagnostics* %t37
  %t38 = alloca { %ModuleDiagnostics*, i64 }
  %t39 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t38, i32 0, i32 0
  store %ModuleDiagnostics* %t36, %ModuleDiagnostics** %t39
  %t40 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t38, i32 0, i32 1
  store i64 1, i64* %t40
  %t41 = insertvalue %ModuleCompilationResult %t30, { i8**, i64 }* null, 1
  ret %ModuleCompilationResult %t41
merge1:
  %t42 = alloca [0 x double]
  %t43 = getelementptr [0 x double], [0 x double]* %t42, i32 0, i32 0
  %t44 = alloca { double*, i64 }
  %t45 = getelementptr { double*, i64 }, { double*, i64 }* %t44, i32 0, i32 0
  store double* %t43, double** %t45
  %t46 = getelementptr { double*, i64 }, { double*, i64 }* %t44, i32 0, i32 1
  store i64 0, i64* %t46
  store { %ModuleDiagnostics*, i64 }* null, { %ModuleDiagnostics*, i64 }** %l8
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t48 = insertvalue %CompiledModule undef, i8* %source_path, 0
  %t49 = load double, double* %l6
  %t50 = insertvalue %CompiledModule %t48, i8* null, 1
  %t51 = insertvalue %ModuleCompilationResult undef, i8* null, 0
  %t52 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  %t53 = insertvalue %ModuleCompilationResult %t51, { i8**, i64 }* null, 1
  ret %ModuleCompilationResult %t53
}

define { i8**, i64 }* @format_typecheck_diagnostics(double %entries, i8* %source) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %t0 = call { i8**, i64 }* @split_source_lines(i8* %source)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l1
  %t2 = load double, double* %l1
  %t3 = sitofp i64 1 to double
  %t4 = fcmp olt double %t2, %t3
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load double, double* %l1
  br i1 %t4, label %then0, label %merge1
then0:
  %t7 = sitofp i64 1 to double
  store double %t7, double* %l1
  br label %merge1
merge1:
  %t8 = phi double [ %t7, %then0 ], [ %t6, %entry ]
  store double %t8, double* %l1
  %t9 = alloca [0 x double]
  %t10 = getelementptr [0 x double], [0 x double]* %t9, i32 0, i32 0
  %t11 = alloca { double*, i64 }
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 0
  store double* %t10, double** %t12
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l3
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t18 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t27 = phi { i8**, i64 }* [ %t17, %entry ], [ %t26, %loop.latch4 ]
  store { i8**, i64 }* %t27, { i8**, i64 }** %l2
  br label %loop.body3
loop.body3:
  %t19 = load double, double* %l3
  %t20 = load double, double* %l3
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  store double 0.0, double* %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load double, double* %l4
  %t25 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t23, i8* null)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l2
  br label %loop.latch4
loop.latch4:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %loop.header2
afterloop5:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l2
  ret { i8**, i64 }* %t28
}

; fn report_typecheck_errors effects: ![io]
define void @report_typecheck_errors(double %entries, i8* %source) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %t0 = call { i8**, i64 }* @format_typecheck_diagnostics(double %entries, i8* %source)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %s1 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.1, i32 0, i32 0
  store i8* %s1, i8** %l1
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = load i8*, i8** %l1
  store double 0.0, double* %l2
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l3
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load i8*, i8** %l1
  %t7 = load double, double* %l2
  %t8 = load double, double* %l3
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l3
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l3
  %t13 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  store i8* %t18, i8** %l4
  %t19 = load i8*, i8** %l4
  %t20 = call { i8**, i64 }* @split_source_lines(i8* %t19)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l5
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l6
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  %t27 = load i8*, i8** %l4
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t29 = load double, double* %l6
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t30 = load double, double* %l6
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t32 = load double, double* %l6
  %t33 = sitofp i64 0 to double
  %t34 = fcmp oeq double %t32, %t33
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = load i8*, i8** %l4
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t41 = load double, double* %l6
  br i1 %t34, label %then8, label %else9
then8:
  %t42 = load i8*, i8** %l1
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t44 = load double, double* %l6
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t43
  %t46 = extractvalue { i8**, i64 } %t45, 0
  %t47 = extractvalue { i8**, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  %t49 = getelementptr i8*, i8** %t46, i64 %t44
  %t50 = load i8*, i8** %t49
  %t51 = add i8* %t42, %t50
  call void @sailfin_runtime_print_error(i8* %t51)
  br label %merge10
else9:
  %t52 = load double, double* %l2
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t54 = load double, double* %l6
  %t55 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t56 = extractvalue { i8**, i64 } %t55, 0
  %t57 = extractvalue { i8**, i64 } %t55, 1
  %t58 = icmp uge i64 %t54, %t57
  ; bounds check: %t58 (if true, out of bounds)
  %t59 = getelementptr i8*, i8** %t56, i64 %t54
  %t60 = load i8*, i8** %t59
  br label %merge10
merge10:
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret void
}

define i8* @format_typecheck_diagnostic(double %entry, { i8**, i64 }* %source_lines, double %line_padding) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l1
  %t6 = load double, double* %l1
  store double 0.0, double* %l2
  %t7 = load double, double* %l1
  store double 0.0, double* %l3
  store double 0.0, double* %l4
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load double, double* %l4
  %t10 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t8, i8* null)
  store { i8**, i64 }* %t10, { i8**, i64 }** %l0
  %t11 = load double, double* %l2
  store double 0.0, double* %l5
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i8* @repeat_character(i8* %s12, double %line_padding)
  store i8* %t13, i8** %l6
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load i8*, i8** %l6
  %t17 = add i8* %s15, %t16
  %s18 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.18, i32 0, i32 0
  %t19 = add i8* %t17, %s18
  %t20 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t14, i8* %t19)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  %t21 = load double, double* %l2
  %t22 = call i8* @number_to_string(double %t21)
  store i8* %t22, i8** %l7
  %s23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.23, i32 0, i32 0
  store i8* %s23, i8** %l8
  %t24 = load i8*, i8** %l7
  store double 0.0, double* %l9
  %t25 = load double, double* %l9
  %t26 = sitofp i64 0 to double
  %t27 = fcmp olt double %t25, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  %t33 = load double, double* %l5
  %t34 = load i8*, i8** %l6
  %t35 = load i8*, i8** %l7
  %t36 = load i8*, i8** %l8
  %t37 = load double, double* %l9
  br i1 %t27, label %then0, label %merge1
then0:
  %t38 = sitofp i64 0 to double
  store double %t38, double* %l9
  br label %merge1
merge1:
  %t39 = phi double [ %t38, %then0 ], [ %t37, %entry ]
  store double %t39, double* %l9
  %t40 = load double, double* %l9
  %t41 = sitofp i64 0 to double
  %t42 = fcmp ogt double %t40, %t41
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = load double, double* %l2
  %t46 = load double, double* %l3
  %t47 = load double, double* %l4
  %t48 = load double, double* %l5
  %t49 = load i8*, i8** %l6
  %t50 = load i8*, i8** %l7
  %t51 = load i8*, i8** %l8
  %t52 = load double, double* %l9
  br i1 %t42, label %then2, label %merge3
then2:
  %s53 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.53, i32 0, i32 0
  %t54 = load double, double* %l9
  %t55 = call i8* @repeat_character(i8* %s53, double %t54)
  store i8* %t55, i8** %l8
  br label %merge3
merge3:
  %t56 = phi i8* [ %t55, %then2 ], [ %t51, %entry ]
  store i8* %t56, i8** %l8
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s58 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.58, i32 0, i32 0
  %t59 = load i8*, i8** %l8
  %t60 = add i8* %s58, %t59
  %t61 = load i8*, i8** %l7
  %t62 = add i8* %t60, %t61
  %s63 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.63, i32 0, i32 0
  %t64 = add i8* %t62, %s63
  %t65 = load double, double* %l5
  %t66 = load double, double* %l3
  %t67 = load double, double* %l1
  %t68 = load double, double* %l5
  store double 0.0, double* %l10
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s70 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.70, i32 0, i32 0
  %t71 = load i8*, i8** %l6
  %t72 = add i8* %s70, %t71
  %s73 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.73, i32 0, i32 0
  %t74 = add i8* %t72, %s73
  %t75 = load double, double* %l10
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = call i8* @join_lines({ i8**, i64 }* %t76)
  ret i8* %t77
}

define { i8**, i64 }* @split_source_lines(i8* %source) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load i8*, i8** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t21 = phi i8* [ %t8, %entry ], [ %t20, %loop.latch2 ]
  store i8* %t21, i8** %l1
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %source, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t14 = load i8, i8* %l3
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load i8, i8* %l3
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = load i8*, i8** %l1
  %t19 = load i8, i8* %l3
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load i8*, i8** %l1
  %t24 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t22, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t25
}

define i8* @build_pointer_line(double %column, i8* %lexeme, i8* %line_text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  store double %column, double* %l0
  %t0 = load double, double* %l0
  %t1 = sitofp i64 1 to double
  %t2 = fcmp olt double %t0, %t1
  %t3 = load double, double* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = sitofp i64 1 to double
  store double %t4, double* %l0
  br label %merge1
merge1:
  %t5 = phi double [ %t4, %then0 ], [ %t3, %entry ]
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  store i8* %s7, i8** %l1
  %t8 = sitofp i64 1 to double
  store double %t8, double* %l2
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  br label %loop.header2
loop.header2:
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l2
  %t13 = load double, double* %l0
  %t14 = fcmp oge double %t12, %t13
  %t15 = load double, double* %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load double, double* %l2
  br label %loop.latch4
loop.latch4:
  br label %loop.header2
afterloop5:
  store double 0.0, double* %l3
  %t19 = load double, double* %l3
  %t20 = sitofp i64 0 to double
  %t21 = fcmp ole double %t19, %t20
  %t22 = load double, double* %l0
  %t23 = load i8*, i8** %l1
  %t24 = load double, double* %l2
  %t25 = load double, double* %l3
  br i1 %t21, label %then8, label %merge9
then8:
  %t26 = sitofp i64 1 to double
  store double %t26, double* %l3
  br label %merge9
merge9:
  %t27 = phi double [ %t26, %then8 ], [ %t25, %entry ]
  store double %t27, double* %l3
  store double 0.0, double* %l4
  %t28 = load double, double* %l4
  %t29 = sitofp i64 0 to double
  %t30 = fcmp ole double %t28, %t29
  %t31 = load double, double* %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load double, double* %l3
  %t35 = load double, double* %l4
  br i1 %t30, label %then10, label %merge11
then10:
  %t36 = sitofp i64 1 to double
  store double %t36, double* %l4
  br label %merge11
merge11:
  %t37 = phi double [ %t36, %then10 ], [ %t35, %entry ]
  store double %t37, double* %l4
  %t38 = load double, double* %l3
  %t39 = load double, double* %l4
  %t40 = fcmp ogt double %t38, %t39
  %t41 = load double, double* %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load double, double* %l4
  br i1 %t40, label %then12, label %merge13
then12:
  %t46 = load double, double* %l4
  store double %t46, double* %l3
  br label %merge13
merge13:
  %t47 = phi double [ %t46, %then12 ], [ %t44, %entry ]
  store double %t47, double* %l3
  %t48 = sitofp i64 0 to double
  store double %t48, double* %l5
  %t49 = load double, double* %l0
  %t50 = load i8*, i8** %l1
  %t51 = load double, double* %l2
  %t52 = load double, double* %l3
  %t53 = load double, double* %l4
  %t54 = load double, double* %l5
  br label %loop.header14
loop.header14:
  %t68 = phi i8* [ %t50, %entry ], [ %t67, %loop.latch16 ]
  store i8* %t68, i8** %l1
  br label %loop.body15
loop.body15:
  %t55 = load double, double* %l5
  %t56 = load double, double* %l3
  %t57 = fcmp oge double %t55, %t56
  %t58 = load double, double* %l0
  %t59 = load i8*, i8** %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l4
  %t63 = load double, double* %l5
  br i1 %t57, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t64 = load i8*, i8** %l1
  %s65 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.65, i32 0, i32 0
  %t66 = add i8* %t64, %s65
  store i8* %t66, i8** %l1
  br label %loop.latch16
loop.latch16:
  %t67 = load i8*, i8** %l1
  br label %loop.header14
afterloop17:
  %t69 = load i8*, i8** %l1
  ret i8* %t69
}

define i8* @join_lines({ i8**, i64 }* %lines) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t1 = extractvalue { i8**, i64 } %t0, 0
  %t2 = extractvalue { i8**, i64 } %t0, 1
  %t3 = icmp uge i64 0, %t2
  ; bounds check: %t3 (if true, out of bounds)
  %t4 = getelementptr i8*, i8** %t1, i64 0
  %t5 = load i8*, i8** %t4
  store i8* %t5, i8** %l0
  %t6 = sitofp i64 1 to double
  store double %t6, double* %l1
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t22 = phi i8* [ %t7, %entry ], [ %t21, %loop.latch2 ]
  store i8* %t22, i8** %l0
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load i8*, i8** %l0
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = add i8* %t10, %s11
  %t13 = load double, double* %l1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t15 = extractvalue { i8**, i64 } %t14, 0
  %t16 = extractvalue { i8**, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr i8*, i8** %t15, i64 %t13
  %t19 = load i8*, i8** %t18
  %t20 = add i8* %t12, %t19
  store i8* %t20, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t21 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t23 = load i8*, i8** %l0
  ret i8* %t23
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %value, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define i8* @number_to_string(double %value) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp oeq double %value, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  store double %value, double* %l0
  store i1 0, i1* %l1
  %t3 = load double, double* %l0
  %t4 = sitofp i64 0 to double
  %t5 = fcmp olt double %t3, %t4
  %t6 = load double, double* %l0
  %t7 = load i1, i1* %l1
  br i1 %t5, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  br label %merge3
merge3:
  %t8 = phi i1 [ 1, %then2 ], [ %t7, %entry ]
  %t9 = phi double [ 0.0, %then2 ], [ %t6, %entry ]
  store i1 %t8, i1* %l1
  store double %t9, double* %l0
  %s10 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.10, i32 0, i32 0
  store i8* %s10, i8** %l2
  %t11 = load double, double* %l0
  store double %t11, double* %l3
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.12, i32 0, i32 0
  store i8* %s12, i8** %l4
  %t13 = load double, double* %l0
  %t14 = load i1, i1* %l1
  %t15 = load i8*, i8** %l2
  %t16 = load double, double* %l3
  %t17 = load i8*, i8** %l4
  br label %loop.header4
loop.header4:
  %t58 = phi i8* [ %t17, %entry ], [ %t56, %loop.latch6 ]
  %t59 = phi double [ %t16, %entry ], [ %t57, %loop.latch6 ]
  store i8* %t58, i8** %l4
  store double %t59, double* %l3
  br label %loop.body5
loop.body5:
  %t18 = load double, double* %l3
  %t19 = sitofp i64 0 to double
  %t20 = fcmp ole double %t18, %t19
  %t21 = load double, double* %l0
  %t22 = load i1, i1* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  %t25 = load i8*, i8** %l4
  br i1 %t20, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t26 = load double, double* %l3
  store double %t26, double* %l5
  %t27 = sitofp i64 0 to double
  store double %t27, double* %l6
  %t28 = load double, double* %l0
  %t29 = load i1, i1* %l1
  %t30 = load i8*, i8** %l2
  %t31 = load double, double* %l3
  %t32 = load i8*, i8** %l4
  %t33 = load double, double* %l5
  %t34 = load double, double* %l6
  br label %loop.header10
loop.header10:
  br label %loop.body11
loop.body11:
  %t35 = load double, double* %l5
  %t36 = sitofp i64 10 to double
  %t37 = fcmp olt double %t35, %t36
  %t38 = load double, double* %l0
  %t39 = load i1, i1* %l1
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l3
  %t42 = load i8*, i8** %l4
  %t43 = load double, double* %l5
  %t44 = load double, double* %l6
  br i1 %t37, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t45 = load double, double* %l5
  br label %loop.latch12
loop.latch12:
  br label %loop.header10
afterloop13:
  %t46 = load i8*, i8** %l2
  %t47 = load double, double* %l5
  %t48 = load double, double* %l5
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  %t51 = call i8* @slice_string(i8* %t46, double %t47, double %t50)
  store i8* %t51, i8** %l7
  %t52 = load i8*, i8** %l7
  %t53 = load i8*, i8** %l4
  %t54 = add i8* %t52, %t53
  store i8* %t54, i8** %l4
  %t55 = load double, double* %l6
  store double %t55, double* %l3
  br label %loop.latch6
loop.latch6:
  %t56 = load i8*, i8** %l4
  %t57 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t60 = load i1, i1* %l1
  %t61 = load double, double* %l0
  %t62 = load i1, i1* %l1
  %t63 = load i8*, i8** %l2
  %t64 = load double, double* %l3
  %t65 = load i8*, i8** %l4
  br i1 %t60, label %then16, label %merge17
then16:
  br label %merge17
merge17:
  %t66 = phi i8* [ null, %then16 ], [ %t65, %entry ]
  store i8* %t66, i8** %l4
  %t67 = load i8*, i8** %l4
  ret i8* %t67
}

define i1 @has_prefix(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %prefix, i64 %t6
  %t8 = load i8, i8* %t7
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @needs_python_fallback(i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i8* @strip_needs_python_fallback_literals(i8* %source)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i8* @strip_python_string_literals(i8* %t1)
  store i8* %t2, i8** %l1
  %t3 = load i8*, i8** %l1
  store i8* %t3, i8** %l2
  %t4 = load i8*, i8** %l2
  %t5 = load i8*, i8** %l2
  store i8* %t5, i8** %l3
  %t6 = load i8*, i8** %l3
  %t7 = load i8*, i8** %l3
  %s8 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.8, i32 0, i32 0
  %t9 = call i1 @string_contains(i8* %t7, i8* %s8)
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l1
  %t12 = load i8*, i8** %l2
  %t13 = load i8*, i8** %l3
  br i1 %t9, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t14 = load i8*, i8** %l3
  %s15 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.15, i32 0, i32 0
  %t16 = call i1 @string_contains(i8* %t14, i8* %s15)
  %t17 = load i8*, i8** %l0
  %t18 = load i8*, i8** %l1
  %t19 = load i8*, i8** %l2
  %t20 = load i8*, i8** %l3
  br i1 %t16, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t21 = load i8*, i8** %l3
  %s22 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.22, i32 0, i32 0
  %t23 = call i1 @string_contains(i8* %t21, i8* %s22)
  %t24 = load i8*, i8** %l0
  %t25 = load i8*, i8** %l1
  %t26 = load i8*, i8** %l2
  %t27 = load i8*, i8** %l3
  br i1 %t23, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t28 = load i8*, i8** %l3
  %s29 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.29, i32 0, i32 0
  %t30 = call i1 @string_contains(i8* %t28, i8* %s29)
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load i8*, i8** %l2
  %t34 = load i8*, i8** %l3
  br i1 %t30, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t35 = load i8*, i8** %l3
  %s36 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.36, i32 0, i32 0
  %t37 = call i1 @string_contains(i8* %t35, i8* %s36)
  %t38 = load i8*, i8** %l0
  %t39 = load i8*, i8** %l1
  %t40 = load i8*, i8** %l2
  %t41 = load i8*, i8** %l3
  br i1 %t37, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t42 = load i8*, i8** %l3
  %s43 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.43, i32 0, i32 0
  %t44 = call i1 @string_contains(i8* %t42, i8* %s43)
  %t45 = load i8*, i8** %l0
  %t46 = load i8*, i8** %l1
  %t47 = load i8*, i8** %l2
  %t48 = load i8*, i8** %l3
  br i1 %t44, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  %t49 = load i8*, i8** %l3
  %s50 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.50, i32 0, i32 0
  %t51 = call i1 @string_contains(i8* %t49, i8* %s50)
  %t52 = load i8*, i8** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load i8*, i8** %l2
  %t55 = load i8*, i8** %l3
  br i1 %t51, label %then12, label %merge13
then12:
  ret i1 1
merge13:
  %t56 = load i8*, i8** %l3
  %s57 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.57, i32 0, i32 0
  %t58 = call i1 @string_contains(i8* %t56, i8* %s57)
  %t59 = load i8*, i8** %l0
  %t60 = load i8*, i8** %l1
  %t61 = load i8*, i8** %l2
  %t62 = load i8*, i8** %l3
  br i1 %t58, label %then14, label %merge15
then14:
  ret i1 1
merge15:
  %t63 = load i8*, i8** %l3
  %s64 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.64, i32 0, i32 0
  %t65 = call i1 @string_contains(i8* %t63, i8* %s64)
  %t66 = load i8*, i8** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load i8*, i8** %l2
  %t69 = load i8*, i8** %l3
  br i1 %t65, label %then16, label %merge17
then16:
  ret i1 1
merge17:
  %t70 = load i8*, i8** %l3
  %s71 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.71, i32 0, i32 0
  %t72 = call i1 @string_contains(i8* %t70, i8* %s71)
  %t73 = load i8*, i8** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l3
  br i1 %t72, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t77 = load i8*, i8** %l3
  %s78 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.78, i32 0, i32 0
  %t79 = call i1 @string_contains(i8* %t77, i8* %s78)
  %t80 = load i8*, i8** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load i8*, i8** %l2
  %t83 = load i8*, i8** %l3
  br i1 %t79, label %then20, label %merge21
then20:
  ret i1 1
merge21:
  %t84 = load i8*, i8** %l3
  %s85 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.85, i32 0, i32 0
  %t86 = call i1 @string_contains(i8* %t84, i8* %s85)
  %t87 = load i8*, i8** %l0
  %t88 = load i8*, i8** %l1
  %t89 = load i8*, i8** %l2
  %t90 = load i8*, i8** %l3
  br i1 %t86, label %then22, label %merge23
then22:
  ret i1 1
merge23:
  ret i1 0
}

define i1 @string_contains(i8* %value, i8* %pattern) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  store i1 1, i1* %l1
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l2
  %t4 = load double, double* %l0
  %t5 = load i1, i1* %l1
  %t6 = load double, double* %l2
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l2
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t8 = load i1, i1* %l1
  %t9 = load double, double* %l0
  %t10 = load i1, i1* %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 0
}

define i8* @strip_needs_python_fallback_literals(i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %s0 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call double @find_substring(i8* %source, i8* %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = sitofp i64 0 to double
  %t5 = fcmp olt double %t3, %t4
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  ret i8* %source
merge1:
  %s8 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l2
  %t9 = load i8*, i8** %l2
  %t10 = load double, double* %l1
  %t11 = call double @find_substring_from(i8* %source, i8* %t9, double %t10)
  store double %t11, double* %l3
  %t12 = load double, double* %l3
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load i8*, i8** %l2
  %t18 = load double, double* %l3
  br i1 %t14, label %then2, label %merge3
then2:
  ret i8* %source
merge3:
  %t19 = load double, double* %l3
  %t20 = load i8*, i8** %l2
  store double 0.0, double* %l4
  %t21 = load double, double* %l4
  %t22 = call double @advance_to_line_end(i8* %source, double %t21)
  store double %t22, double* %l4
  %t23 = load double, double* %l1
  %t24 = sitofp i64 0 to double
  %t25 = call i8* @slice_string(i8* %source, double %t24, double %t23)
  store i8* %t25, i8** %l5
  %t26 = load double, double* %l4
  store double 0.0, double* %l6
  %t27 = load i8*, i8** %l5
  %t28 = load double, double* %l6
  ret i8* null
}

define i8* @strip_python_string_literals(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  br label %loop.header0
loop.header0:
  %t15 = phi i8* [ %t3, %entry ], [ %t14, %loop.latch2 ]
  store i8* %t15, i8** %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = getelementptr i8, i8* %value, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = load i8, i8* %l2
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = load i8*, i8** %l1
  %t13 = load i8, i8* %l2
  br label %loop.latch2
loop.latch2:
  %t14 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t16 = load i8*, i8** %l1
  ret i8* %t16
}

define double @python_quote_length(i8* %value, double %start, i8* %delimiter) {
entry:
  %t0 = sitofp i64 2 to double
  %t1 = fadd double %start, %t0
  %t2 = sitofp i64 1 to double
  ret double %t2
}

define double @skip_python_string_literal(i8* %value, double %position, i8* %delimiter, double %quote_length) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca double
  %t0 = sitofp i64 1 to double
  %t1 = fcmp oeq double %quote_length, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  store double %position, double* %l0
  store i1 0, i1* %l1
  %t2 = load double, double* %l0
  %t3 = load i1, i1* %l1
  br label %loop.header2
loop.header2:
  %t16 = phi i1 [ %t3, %then0 ], [ %t15, %loop.latch4 ]
  store i1 %t16, i1* %l1
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = getelementptr i8, i8* %value, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i1, i1* %l1
  %t9 = load double, double* %l0
  %t10 = load i1, i1* %l1
  %t11 = load i8, i8* %l2
  br i1 %t8, label %then6, label %merge7
then6:
  store i1 0, i1* %l1
  br label %loop.latch4
merge7:
  %t12 = load i8, i8* %l2
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8, i8* %l2
  br label %loop.latch4
loop.latch4:
  %t15 = load i1, i1* %l1
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  store double %position, double* %l3
  %t17 = load double, double* %l3
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t18 = load double, double* %l3
  %t19 = fadd double %t18, %quote_length
  store i1 1, i1* %l4
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l5
  %t21 = load double, double* %l3
  %t22 = load i1, i1* %l4
  %t23 = load double, double* %l5
  br label %loop.header12
loop.header12:
  br label %loop.body13
loop.body13:
  %t24 = load double, double* %l5
  %t25 = fcmp oge double %t24, %quote_length
  %t26 = load double, double* %l3
  %t27 = load i1, i1* %l4
  %t28 = load double, double* %l5
  br i1 %t25, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  br label %loop.latch14
loop.latch14:
  br label %loop.header12
afterloop15:
  %t29 = load i1, i1* %l4
  %t30 = load double, double* %l3
  %t31 = load i1, i1* %l4
  %t32 = load double, double* %l5
  br i1 %t29, label %then18, label %merge19
then18:
  %t33 = load double, double* %l3
  %t34 = fadd double %t33, %quote_length
  ret double %t34
merge19:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  ret double 0.0
}

define i8* @repeat_character(i8* %ch, double %count) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %count, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  store i8* %s4, i8** %l1
  %t5 = load double, double* %l0
  %t6 = load i8*, i8** %l1
  br label %loop.header2
loop.header2:
  %t14 = phi i8* [ %t6, %entry ], [ %t13, %loop.latch4 ]
  store i8* %t14, i8** %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l0
  %t8 = fcmp oge double %t7, %count
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  br i1 %t8, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t11 = load i8*, i8** %l1
  %t12 = add i8* %t11, %ch
  store i8* %t12, i8** %l1
  br label %loop.latch4
loop.latch4:
  %t13 = load i8*, i8** %l1
  br label %loop.header2
afterloop5:
  %t15 = load i8*, i8** %l1
  ret i8* %t15
}

define double @find_substring(i8* %value, i8* %pattern) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  store i1 1, i1* %l1
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l2
  %t4 = load double, double* %l0
  %t5 = load i1, i1* %l1
  %t6 = load double, double* %l2
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l2
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t8 = load i1, i1* %l1
  %t9 = load double, double* %l0
  %t10 = load i1, i1* %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then8, label %merge9
then8:
  %t12 = load double, double* %l0
  ret double %t12
merge9:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = sitofp i64 -1 to double
  ret double %t13
}

define double @find_substring_from(i8* %value, i8* %pattern, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %start, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call double @find_substring(i8* %value, i8* %pattern)
  ret double %t2
merge1:
  store double %start, double* %l0
  %t3 = load double, double* %l0
  br label %loop.header2
loop.header2:
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  store i1 1, i1* %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load double, double* %l0
  %t7 = load i1, i1* %l1
  %t8 = load double, double* %l2
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t9 = load double, double* %l2
  br label %loop.latch8
loop.latch8:
  br label %loop.header6
afterloop9:
  %t10 = load i1, i1* %l1
  %t11 = load double, double* %l0
  %t12 = load i1, i1* %l1
  %t13 = load double, double* %l2
  br i1 %t10, label %then10, label %merge11
then10:
  %t14 = load double, double* %l0
  ret double %t14
merge11:
  br label %loop.latch4
loop.latch4:
  br label %loop.header2
afterloop5:
  %t15 = sitofp i64 -1 to double
  ret double %t15
}

define double @advance_to_line_end(i8* %value, double %position) {
entry:
  %l0 = alloca double
  %l1 = alloca i8
  store double %position, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = load double, double* %l0
  %t3 = getelementptr i8, i8* %value, i64 %t2
  %t4 = load i8, i8* %t3
  store i8 %t4, i8* %l1
  %t5 = load i8, i8* %l1
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t7 = load double, double* %l0
  ret double %t7
}

define i8* @slice_string(i8* %value, double %start, double %end) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %start, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  br label %merge1
merge1:
  %t2 = fcmp olt double %end, %start
  br i1 %t2, label %then2, label %merge3
then2:
  br label %merge3
merge3:
  store double %start, double* %l0
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l1
  %t4 = load double, double* %l0
  %t5 = load i8*, i8** %l1
  br label %loop.header4
loop.header4:
  %t15 = phi i8* [ %t5, %entry ], [ %t14, %loop.latch6 ]
  store i8* %t15, i8** %l1
  br label %loop.body5
loop.body5:
  %t6 = load double, double* %l0
  %t7 = fcmp oge double %t6, %end
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  br i1 %t7, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l0
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  br label %loop.latch6
loop.latch6:
  %t14 = load i8*, i8** %l1
  br label %loop.header4
afterloop7:
  %t16 = load i8*, i8** %l1
  ret i8* %t16
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
