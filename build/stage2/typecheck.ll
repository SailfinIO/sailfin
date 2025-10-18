; ModuleID = 'sailfin'
source_filename = "sailfin"

%Diagnostic = type { i8*, i8*, i8* }
%SymbolEntry = type { i8*, i8*, i8* }
%TypecheckResult = type { { i8**, i64 }*, { i8**, i64 }* }
%SymbolCollectionResult = type { { i8**, i64 }*, { i8**, i64 }* }
%ScopeResult = type { { i8**, i64 }*, { i8**, i64 }* }

declare noalias i8* @malloc(i64)

@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [21 x i8] c" is missing effect '\00"
@.str.3 = private unnamed_addr constant [2 x i8] c"'\00"
@.str.6 = private unnamed_addr constant [15 x i8] c". hint: add ![\00"
@.str.9 = private unnamed_addr constant [61 x i8] c"] to the signature or accept the CLI fix prompt when offered\00"

define %TypecheckResult @typecheck_program(double %program) {
entry:
  %l0 = alloca %SymbolCollectionResult
  %l1 = alloca double
  %l2 = alloca { %Diagnostic*, i64 }*
  %l3 = alloca { %Diagnostic*, i64 }*
  %t0 = call %SymbolCollectionResult @collect_top_level_symbols(double %program)
  store %SymbolCollectionResult %t0, %SymbolCollectionResult* %l0
  %t1 = call double @collect_interface_definitions(double %program)
  store double %t1, double* %l1
  %t2 = load double, double* %l1
  %t3 = call { %Diagnostic*, i64 }* @check_program_scopes(double %program, double %t2)
  store { %Diagnostic*, i64 }* %t3, { %Diagnostic*, i64 }** %l2
  %t4 = call { %Diagnostic*, i64 }* @build_effect_diagnostics(double %program)
  store { %Diagnostic*, i64 }* %t4, { %Diagnostic*, i64 }** %l3
  %t5 = insertvalue %TypecheckResult undef, { i8**, i64 }* null, 0
  %t6 = load %SymbolCollectionResult, %SymbolCollectionResult* %l0
  %t7 = extractvalue %SymbolCollectionResult %t6, 0
  %t8 = insertvalue %TypecheckResult %t5, { i8**, i64 }* %t7, 1
  ret %TypecheckResult %t8
}

define %SymbolCollectionResult @collect_top_level_symbols(double %program) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t11 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t12 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t13 = insertvalue %SymbolCollectionResult %t11, { i8**, i64 }* null, 1
  ret %SymbolCollectionResult %t13
}

define %SymbolCollectionResult @register_top_level_symbol(double %statement, { %SymbolEntry*, i64 }* %existing) {
entry:
  %t0 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = insertvalue %SymbolCollectionResult %t0, { i8**, i64 }* null, 1
  ret %SymbolCollectionResult %t6
}

define { %Diagnostic*, i64 }* @check_program_scopes(double %program, double %interfaces) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t10
}

define %ScopeResult @check_statement(double %statement, { %SymbolEntry*, i64 }* %bindings, double %interfaces) {
entry:
  %t0 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = insertvalue %ScopeResult %t0, { i8**, i64 }* null, 1
  ret %ScopeResult %t6
}

define { %Diagnostic*, i64 }* @check_function_body(double %signature, double %body, double %interfaces) {
entry:
  %l0 = alloca %ScopeResult
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = call %ScopeResult @seed_parameter_scope(double %signature)
  store %ScopeResult %t0, %ScopeResult* %l0
  %t1 = load %ScopeResult, %ScopeResult* %l0
  %t2 = extractvalue %ScopeResult %t1, 0
  %t3 = call { %Diagnostic*, i64 }* @check_block(double %body, { %SymbolEntry*, i64 }* null, double %interfaces)
  store { %Diagnostic*, i64 }* %t3, { %Diagnostic*, i64 }** %l1
  %t4 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t5 = call double @parameter_scopediagnosticsconcat({ %Diagnostic*, i64 }* %t4)
  ret { %Diagnostic*, i64 }* null
}

define %ScopeResult @seed_parameter_scope(double %signature) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t11 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t12 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t13 = insertvalue %ScopeResult %t11, { i8**, i64 }* null, 1
  ret %ScopeResult %t13
}

define { %Diagnostic*, i64 }* @check_block(double %block, { %SymbolEntry*, i64 }* %parent_bindings, double %interfaces) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %parent_bindings)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t6 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t6
}

define { %Diagnostic*, i64 }* @check_struct_implements_interfaces(double %statement, double %interfaces) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t10
}

define { %Diagnostic*, i64 }* @check_struct_fields(double %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t10
}

define { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %struct_name, double %interface_definition, double %annotation) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  store double 0.0, double* %l1
  %t0 = load double, double* %l0
  %t1 = sitofp i64 0 to double
  %t2 = fcmp oeq double %t0, %t1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br i1 %t2, label %then0, label %merge1
then0:
  %t5 = load double, double* %l1
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  ret { %Diagnostic*, i64 }* null
merge1:
  %t11 = load double, double* %l1
  %t12 = load double, double* %l1
  %t13 = alloca [0 x double]
  %t14 = getelementptr [0 x double], [0 x double]* %t13, i32 0, i32 0
  %t15 = alloca { double*, i64 }
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t15, i32 0, i32 0
  store double* %t14, double** %t16
  %t17 = getelementptr { double*, i64 }, { double*, i64 }* %t15, i32 0, i32 1
  store i64 0, i64* %t17
  ret { %Diagnostic*, i64 }* null
}

define i8* @format_interface_signature(double %interface_definition) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @join_with_separator({ i8**, i64 }* %items, i8* %separator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %items
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
  %t21 = phi i8* [ %t7, %entry ], [ %t20, %loop.latch2 ]
  store i8* %t21, i8** %l0
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load i8*, i8** %l0
  %t11 = add i8* %t10, %separator
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %items
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = add i8* %t11, %t18
  store i8* %t19, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t22 = load i8*, i8** %l0
  ret i8* %t22
}

define { i8**, i64 }* @parse_type_arguments(i8* %annotation_text) {
entry:
  %l0 = alloca double
  %t0 = call double @extract_generic_argument_block(i8* %annotation_text)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = load double, double* %l0
  %t3 = call { i8**, i64 }* @split_generic_argument_list(i8* null)
  ret { i8**, i64 }* %t3
}

define { i8**, i64 }* @split_generic_argument_list(i8* %block) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
  %l5 = alloca i8*
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
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l3
  %t13 = load double, double* %l3
  %t14 = getelementptr i8, i8* %block, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l4
  %t16 = load i8, i8* %l4
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t17 = load i8*, i8** %l1
  %t18 = call i8* @trim_text(i8* %t17)
  store i8* %t18, i8** %l5
  %t19 = load i8*, i8** %l5
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t20
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  %t5 = fcmp oge double %t3, %t4
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = getelementptr i8, i8* %value, i64 %t8
  %t10 = load i8, i8* %t9
  %t11 = call i1 @is_whitespace(i8* null)
  %t12 = load double, double* %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t16 = load double, double* %l1
  %t17 = load double, double* %l0
  %t18 = fcmp ole double %t16, %t17
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = call i8* @slice_text(i8* %value, double %t21, double %t22)
  ret i8* %t23
}

define i8* @slice_text(i8* %value, double %start, double %end) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %start, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  br label %merge1
merge1:
  %t2 = fcmp ole double %end, %start
  br i1 %t2, label %then2, label %merge3
then2:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge3:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  store i8* %s4, i8** %l0
  store double %start, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t16 = phi i8* [ %t5, %entry ], [ %t15, %loop.latch6 ]
  store i8* %t16, i8** %l0
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l1
  %t8 = fcmp oge double %t7, %end
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  br label %loop.latch6
loop.latch6:
  %t15 = load i8*, i8** %l0
  br label %loop.header4
afterloop7:
  %t17 = load i8*, i8** %l0
  ret i8* %t17
}

define i1 @is_whitespace(i8* %ch) {
entry:
  ret i1 false
}

define { %Diagnostic*, i64 }* @check_struct_methods(double %methods) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t10
}

define { %Diagnostic*, i64 }* @check_enum_variants(double %variants) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t10
}

define { %Diagnostic*, i64 }* @check_interface_members(double %members) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t10
}

define { %Diagnostic*, i64 }* @check_model_properties(double %properties) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t10
}

define { %Diagnostic*, i64 }* @check_function_signature(double %signature) {
entry:
  ret { %Diagnostic*, i64 }* null
}

define { %Diagnostic*, i64 }* @check_type_parameters(double %type_parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t10 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t10
}

define { %Diagnostic*, i64 }* @build_effect_diagnostics(double %program) {
entry:
  %l0 = alloca double
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = call double @validate_effects(double %program)
  store double %t0, double* %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load double, double* %l0
  %t8 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t28 = phi { %Diagnostic*, i64 }* [ %t8, %entry ], [ %t27, %loop.latch2 ]
  store { %Diagnostic*, i64 }* %t28, { %Diagnostic*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l0
  %t12 = load double, double* %l0
  %t13 = load double, double* %l2
  store double 0.0, double* %l3
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l4
  %t15 = load double, double* %l0
  %t16 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t26 = phi { %Diagnostic*, i64 }* [ %t16, %loop.body1 ], [ %t25, %loop.latch6 ]
  store { %Diagnostic*, i64 }* %t26, { %Diagnostic*, i64 }** %l1
  br label %loop.body5
loop.body5:
  %t20 = load double, double* %l4
  %t21 = load double, double* %l3
  %t22 = load double, double* %l3
  store double 0.0, double* %l5
  %t23 = load double, double* %l3
  %t24 = load double, double* %l5
  store double 0.0, double* %l6
  br label %loop.latch6
loop.latch6:
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %loop.header4
afterloop7:
  br label %loop.latch2
loop.latch2:
  %t27 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t29 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t29
}

define i8* @format_effect_message(i8* %routine_name, i8* %effect, double %requirement) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.0, i32 0, i32 0
  %t1 = add i8* %routine_name, %s0
  %t2 = add i8* %t1, %effect
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %t2, %s3
  store i8* %t4, i8** %l0
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.6, i32 0, i32 0
  %t7 = add i8* %t5, %s6
  %t8 = add i8* %t7, %effect
  %s9 = getelementptr inbounds [61 x i8], [61 x i8]* @.str.9, i32 0, i32 0
  %t10 = add i8* %t8, %s9
  store i8* %t10, i8** %l0
  %t11 = load i8*, i8** %l0
  ret i8* %t11
}

define i1 @contains_string({ i8**, i64 }* %items, i8* %candidate) {
entry:
  %l0 = alloca i64
  %l1 = alloca i8*
  %t0 = getelementptr { i8**, i64 }, { i8**, i64 }* %items, i32 0, i32 1
  %t1 = load i64, i64* %t0
  %t2 = getelementptr { i8**, i64 }, { i8**, i64 }* %items, i32 0, i32 0
  %t3 = load i8**, i8*** %t2
  store i64 0, i64* %l0
  store i8* null, i8** %l1
  br label %for0
for0:
  %t4 = load i64, i64* %l0
  %t5 = icmp slt i64 %t4, %t1
  br i1 %t5, label %forbody1, label %afterfor3
forbody1:
  %t6 = load i64, i64* %l0
  %t7 = getelementptr i8*, i8** %t3, i64 %t6
  %t8 = load i8*, i8** %t7
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  br label %forinc2
forinc2:
  %t10 = load i64, i64* %l0
  %t11 = add i64 %t10, 1
  store i64 %t11, i64* %l0
  br label %for0
afterfor3:
  ret i1 0
}

define %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, double %span) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t2 = call double @token_from_name(i8* %name, double %span)
  %t3 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, double %t2)
  %t4 = alloca [1 x %Diagnostic]
  %t5 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t4, i32 0, i32 0
  %t6 = getelementptr %Diagnostic, %Diagnostic* %t5, i64 0
  store %Diagnostic %t3, %Diagnostic* %t6
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t5, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = insertvalue %ScopeResult %t1, { i8**, i64 }* null, 1
  ret %ScopeResult %t10
merge1:
  %t11 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, double %span)
  store { %SymbolEntry*, i64 }* %t11, { %SymbolEntry*, i64 }** %l0
  %t12 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t13 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t14 = alloca [0 x double]
  %t15 = getelementptr [0 x double], [0 x double]* %t14, i32 0, i32 0
  %t16 = alloca { double*, i64 }
  %t17 = getelementptr { double*, i64 }, { double*, i64 }* %t16, i32 0, i32 0
  store double* %t15, double** %t17
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  %t19 = insertvalue %ScopeResult %t13, { i8**, i64 }* null, 1
  ret %ScopeResult %t19
}

define %SymbolCollectionResult @register_symbol(i8* %name, i8* %kind, double %span, { %SymbolEntry*, i64 }* %existing) {
entry:
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t2 = call double @token_from_name(i8* %name, double %span)
  %t3 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, double %t2)
  %t4 = alloca [1 x %Diagnostic]
  %t5 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t4, i32 0, i32 0
  %t6 = getelementptr %Diagnostic, %Diagnostic* %t5, i64 0
  store %Diagnostic %t3, %Diagnostic* %t6
  %t7 = alloca { %Diagnostic*, i64 }
  %t8 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 0
  store %Diagnostic* %t5, %Diagnostic** %t8
  %t9 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = insertvalue %SymbolCollectionResult %t1, { i8**, i64 }* null, 1
  ret %SymbolCollectionResult %t10
merge1:
  %t11 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name, i8* %kind, double %span)
  %t12 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t13 = alloca [0 x double]
  %t14 = getelementptr [0 x double], [0 x double]* %t13, i32 0, i32 0
  %t15 = alloca { double*, i64 }
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t15, i32 0, i32 0
  store double* %t14, double** %t16
  %t17 = getelementptr { double*, i64 }, { double*, i64 }* %t15, i32 0, i32 1
  store i64 0, i64* %t17
  %t18 = insertvalue %SymbolCollectionResult %t12, { i8**, i64 }* null, 1
  ret %SymbolCollectionResult %t18
}

define { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name, i8* %kind, double %span) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %symbols)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  ret { %SymbolEntry*, i64 }* null
}

define { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %source) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca i64
  %l2 = alloca %SymbolEntry
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t5 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %source, i32 0, i32 1
  %t6 = load i64, i64* %t5
  %t7 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %source, i32 0, i32 0
  %t8 = load %SymbolEntry*, %SymbolEntry** %t7
  store i64 0, i64* %l1
  store %SymbolEntry zeroinitializer, %SymbolEntry* %l2
  br label %for0
for0:
  %t9 = load i64, i64* %l1
  %t10 = icmp slt i64 %t9, %t6
  br i1 %t10, label %forbody1, label %afterfor3
forbody1:
  %t11 = load i64, i64* %l1
  %t12 = getelementptr %SymbolEntry, %SymbolEntry* %t8, i64 %t11
  %t13 = load %SymbolEntry, %SymbolEntry* %t12
  store %SymbolEntry %t13, %SymbolEntry* %l2
  %t14 = load %SymbolEntry, %SymbolEntry* %l2
  %t15 = alloca [1 x %SymbolEntry]
  %t16 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* %t15, i32 0, i32 0
  %t17 = getelementptr %SymbolEntry, %SymbolEntry* %t16, i64 0
  store %SymbolEntry %t14, %SymbolEntry* %t17
  %t18 = alloca { %SymbolEntry*, i64 }
  %t19 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t18, i32 0, i32 0
  store %SymbolEntry* %t16, %SymbolEntry** %t19
  %t20 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t18, i32 0, i32 1
  store i64 1, i64* %t20
  %t21 = call double @copyconcat({ %SymbolEntry*, i64 }* %t18)
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  br label %forinc2
forinc2:
  %t22 = load i64, i64* %l1
  %t23 = add i64 %t22, 1
  store i64 %t23, i64* %l1
  br label %for0
afterfor3:
  %t24 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  ret { %SymbolEntry*, i64 }* %t24
}

define i1 @has_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name) {
entry:
  %l0 = alloca i64
  %l1 = alloca %SymbolEntry
  %t0 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %symbols, i32 0, i32 1
  %t1 = load i64, i64* %t0
  %t2 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %symbols, i32 0, i32 0
  %t3 = load %SymbolEntry*, %SymbolEntry** %t2
  store i64 0, i64* %l0
  store %SymbolEntry zeroinitializer, %SymbolEntry* %l1
  br label %for0
for0:
  %t4 = load i64, i64* %l0
  %t5 = icmp slt i64 %t4, %t1
  br i1 %t5, label %forbody1, label %afterfor3
forbody1:
  %t6 = load i64, i64* %l0
  %t7 = getelementptr %SymbolEntry, %SymbolEntry* %t3, i64 %t6
  %t8 = load %SymbolEntry, %SymbolEntry* %t7
  store %SymbolEntry %t8, %SymbolEntry* %l1
  %t9 = load %SymbolEntry, %SymbolEntry* %l1
  %t10 = extractvalue %SymbolEntry %t9, 0
  br label %forinc2
forinc2:
  %t11 = load i64, i64* %l0
  %t12 = add i64 %t11, 1
  store i64 %t12, i64* %l0
  br label %for0
afterfor3:
  ret i1 0
}

define %Diagnostic @make_interface_missing_type_arguments_diagnostic(i8* %struct_name, i8* %interface_name, i8* %interface_signature) {
entry:
  ret %Diagnostic zeroinitializer
}

define %Diagnostic @make_interface_type_argument_mismatch_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_signature) {
entry:
  ret %Diagnostic zeroinitializer
}

define %Diagnostic @make_interface_no_type_arguments_diagnostic(i8* %struct_name, i8* %annotation_text, i8* %interface_name) {
entry:
  ret %Diagnostic zeroinitializer
}

define %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, double %token) {
entry:
  ret %Diagnostic zeroinitializer
}

define %Diagnostic @make_missing_interface_member_diagnostic(i8* %struct_name, i8* %interface_name, i8* %member_name) {
entry:
  ret %Diagnostic zeroinitializer
}

define i1 @starts_with(i8* %value, i8* %prefix) {
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
