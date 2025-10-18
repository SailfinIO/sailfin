; ModuleID = 'sailfin'
source_filename = "sailfin"

%Diagnostic = type { i8*, i8*, i8* }
%SymbolEntry = type { i8*, i8*, i8* }
%TypecheckResult = type { { i8**, i64 }*, { i8**, i64 }* }
%SymbolCollectionResult = type { { i8**, i64 }*, { i8**, i64 }* }
%ScopeResult = type { { i8**, i64 }*, { i8**, i64 }* }
%Program = type { { i8**, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, i8*, i8* }
%Block = type { { i8**, i64 }*, i8*, { i8**, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, i8*, i8*, i1, i8* }
%WithClause = type { i8* }
%ObjectField = type { i8*, i8* }
%ElseBranch = type { i8*, i8* }
%ForClause = type { i8*, i8*, { i8**, i64 }* }
%MatchCase = type { i8*, i8*, i8* }
%ModelProperty = type { i8*, i8*, i8* }
%FieldDeclaration = type { i8*, i8*, i1, i8* }
%MethodDeclaration = type { i8*, i8*, { i8**, i64 }* }
%EnumVariant = type { i8*, { i8**, i64 }*, i8* }
%FunctionSignature = type { i8*, i1, { i8**, i64 }*, i8*, { i8**, i64 }*, { i8**, i64 }*, i8* }
%PipelineDeclaration = type { i8*, i8*, { i8**, i64 }* }
%ToolDeclaration = type { i8*, i8*, { i8**, i64 }* }
%TestDeclaration = type { i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%ModelDeclaration = type { i8*, i8*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%Decorator = type { i8*, { i8**, i64 }* }
%DecoratorArgument = type { i8*, i8* }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { i8*, i8*, double, double }
%EffectRequirement = type { i8*, i8*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { i8**, i64 }* }

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }

declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)

declare noalias i8* @malloc(i64)

@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [21 x i8] c" is missing effect '\00"
@.str.15 = private unnamed_addr constant [15 x i8] c". hint: add ![\00"
@.str.22 = private unnamed_addr constant [61 x i8] c"] to the signature or accept the CLI fix prompt when offered\00"

define %TypecheckResult @typecheck_program(%Program %program) {
entry:
  %l0 = alloca %SymbolCollectionResult
  %l1 = alloca { %Statement*, i64 }*
  %l2 = alloca { %Diagnostic*, i64 }*
  %l3 = alloca { %Diagnostic*, i64 }*
  %t0 = call %SymbolCollectionResult @collect_top_level_symbols(%Program %program)
  store %SymbolCollectionResult %t0, %SymbolCollectionResult* %l0
  %t1 = call { %Statement*, i64 }* @collect_interface_definitions(%Program %program)
  store { %Statement*, i64 }* %t1, { %Statement*, i64 }** %l1
  %t2 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t3 = call { %Diagnostic*, i64 }* @check_program_scopes(%Program %program, { %Statement*, i64 }* %t2)
  store { %Diagnostic*, i64 }* %t3, { %Diagnostic*, i64 }** %l2
  %t4 = call { %Diagnostic*, i64 }* @build_effect_diagnostics(%Program %program)
  store { %Diagnostic*, i64 }* %t4, { %Diagnostic*, i64 }** %l3
  %t5 = insertvalue %TypecheckResult undef, { i8**, i64 }* null, 0
  %t6 = load %SymbolCollectionResult, %SymbolCollectionResult* %l0
  %t7 = extractvalue %SymbolCollectionResult %t6, 0
  %t8 = insertvalue %TypecheckResult %t5, { i8**, i64 }* %t7, 1
  ret %TypecheckResult %t8
}

define { %Statement*, i64 }* @collect_interface_definitions(%Program %program) {
entry:
  %l0 = alloca { %Statement*, i64 }*
  %l1 = alloca i64
  %l2 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Statement*, i64 }* null, { %Statement*, i64 }** %l0
  %t5 = extractvalue %Program %program, 0
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  %t7 = load i64, i64* %t6
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  %t9 = load i8**, i8*** %t8
  store i64 0, i64* %l1
  store i8* null, i8** %l2
  br label %for0
for0:
  %t10 = load i64, i64* %l1
  %t11 = icmp slt i64 %t10, %t7
  br i1 %t11, label %forbody1, label %afterfor3
forbody1:
  %t12 = load i64, i64* %l1
  %t13 = getelementptr i8*, i8** %t9, i64 %t12
  %t14 = load i8*, i8** %t13
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  br label %forinc2
forinc2:
  %t16 = load i64, i64* %l1
  %t17 = add i64 %t16, 1
  store i64 %t17, i64* %l1
  br label %for0
afterfor3:
  %t18 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l0
  ret { %Statement*, i64 }* %t18
}

define %SymbolCollectionResult @collect_top_level_symbols(%Program %program) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca %SymbolCollectionResult
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
  %t10 = extractvalue %Program %program, 0
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  %t12 = load i64, i64* %t11
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  %t14 = load i8**, i8*** %t13
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t15 = load i64, i64* %l2
  %t16 = icmp slt i64 %t15, %t12
  br i1 %t16, label %forbody1, label %afterfor3
forbody1:
  %t17 = load i64, i64* %l2
  %t18 = getelementptr i8*, i8** %t14, i64 %t17
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l3
  %t20 = load i8*, i8** %l3
  %t21 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t22 = call %SymbolCollectionResult @register_top_level_symbol(%Statement zeroinitializer, { %SymbolEntry*, i64 }* %t21)
  store %SymbolCollectionResult %t22, %SymbolCollectionResult* %l4
  %t23 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t24 = extractvalue %SymbolCollectionResult %t23, 0
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t25 = load %SymbolCollectionResult, %SymbolCollectionResult* %l4
  %t26 = extractvalue %SymbolCollectionResult %t25, 1
  %t27 = call double @diagnosticsconcat({ i8**, i64 }* %t26)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t28 = load i64, i64* %l2
  %t29 = add i64 %t28, 1
  store i64 %t29, i64* %l2
  br label %for0
afterfor3:
  %t30 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t31 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t32 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t33 = insertvalue %SymbolCollectionResult %t31, { i8**, i64 }* null, 1
  ret %SymbolCollectionResult %t33
}

define %SymbolCollectionResult @register_top_level_symbol(%Statement %statement, { %SymbolEntry*, i64 }* %existing) {
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

define { %Diagnostic*, i64 }* @check_program_scopes(%Program %program, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca %ScopeResult
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
  %t10 = extractvalue %Program %program, 0
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  %t12 = load i64, i64* %t11
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  %t14 = load i8**, i8*** %t13
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t15 = load i64, i64* %l2
  %t16 = icmp slt i64 %t15, %t12
  br i1 %t16, label %forbody1, label %afterfor3
forbody1:
  %t17 = load i64, i64* %l2
  %t18 = getelementptr i8*, i8** %t14, i64 %t17
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l3
  %t20 = load i8*, i8** %l3
  %t21 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t22 = call %ScopeResult @check_statement(%Statement zeroinitializer, { %SymbolEntry*, i64 }* %t21, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t22, %ScopeResult* %l4
  %t23 = load %ScopeResult, %ScopeResult* %l4
  %t24 = extractvalue %ScopeResult %t23, 0
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t25 = load %ScopeResult, %ScopeResult* %l4
  %t26 = extractvalue %ScopeResult %t25, 1
  %t27 = call double @diagnosticsconcat({ i8**, i64 }* %t26)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t28 = load i64, i64* %l2
  %t29 = add i64 %t28, 1
  store i64 %t29, i64* %l2
  br label %for0
afterfor3:
  %t30 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t30
}

define %ScopeResult @check_statement(%Statement %statement, { %SymbolEntry*, i64 }* %bindings, { %Statement*, i64 }* %interfaces) {
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

define { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature %signature, %Block %body, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca %ScopeResult
  %l1 = alloca { %Diagnostic*, i64 }*
  %t0 = call %ScopeResult @seed_parameter_scope(%FunctionSignature %signature)
  store %ScopeResult %t0, %ScopeResult* %l0
  %t1 = load %ScopeResult, %ScopeResult* %l0
  %t2 = extractvalue %ScopeResult %t1, 0
  %t3 = call { %Diagnostic*, i64 }* @check_block(%Block %body, { %SymbolEntry*, i64 }* null, { %Statement*, i64 }* %interfaces)
  store { %Diagnostic*, i64 }* %t3, { %Diagnostic*, i64 }** %l1
  %t4 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t5 = call double @parameter_scopediagnosticsconcat({ %Diagnostic*, i64 }* %t4)
  ret { %Diagnostic*, i64 }* null
}

define %ScopeResult @seed_parameter_scope(%FunctionSignature %signature) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca double
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
  %t10 = extractvalue %FunctionSignature %signature, 2
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  %t12 = load i64, i64* %t11
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  %t14 = load i8**, i8*** %t13
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t15 = load i64, i64* %l2
  %t16 = icmp slt i64 %t15, %t12
  br i1 %t16, label %forbody1, label %afterfor3
forbody1:
  %t17 = load i64, i64* %l2
  %t18 = getelementptr i8*, i8** %t14, i64 %t17
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l3
  %t20 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t21 = load i8*, i8** %l3
  %s22 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.22, i32 0, i32 0
  %t23 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t24 = load double, double* %l4
  %t25 = load double, double* %l4
  br label %forinc2
forinc2:
  %t26 = load i64, i64* %l2
  %t27 = add i64 %t26, 1
  store i64 %t27, i64* %l2
  br label %for0
afterfor3:
  %t28 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t29 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t30 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t31 = insertvalue %ScopeResult %t29, { i8**, i64 }* null, 1
  ret %ScopeResult %t31
}

define { %Diagnostic*, i64 }* @check_block(%Block %block, { %SymbolEntry*, i64 }* %parent_bindings, { %Statement*, i64 }* %interfaces) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca %ScopeResult
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
  %t6 = extractvalue %Block %block, 2
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  %t8 = load i64, i64* %t7
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  %t10 = load i8**, i8*** %t9
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t11 = load i64, i64* %l2
  %t12 = icmp slt i64 %t11, %t8
  br i1 %t12, label %forbody1, label %afterfor3
forbody1:
  %t13 = load i64, i64* %l2
  %t14 = getelementptr i8*, i8** %t10, i64 %t13
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = load { %SymbolEntry*, i64 }*, { %SymbolEntry*, i64 }** %l0
  %t18 = call %ScopeResult @check_statement(%Statement zeroinitializer, { %SymbolEntry*, i64 }* %t17, { %Statement*, i64 }* %interfaces)
  store %ScopeResult %t18, %ScopeResult* %l4
  %t19 = load %ScopeResult, %ScopeResult* %l4
  %t20 = extractvalue %ScopeResult %t19, 0
  store { %SymbolEntry*, i64 }* null, { %SymbolEntry*, i64 }** %l0
  %t21 = load %ScopeResult, %ScopeResult* %l4
  %t22 = extractvalue %ScopeResult %t21, 1
  %t23 = call double @diagnosticsconcat({ i8**, i64 }* %t22)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  br label %forinc2
forinc2:
  %t24 = load i64, i64* %l2
  %t25 = add i64 %t24, 1
  store i64 %t25, i64* %l2
  br label %for0
afterfor3:
  %t26 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t26
}

define { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement %statement, { %Statement*, i64 }* %interfaces) {
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

define { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %FieldDeclaration
  %l4 = alloca i8*
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
  %t10 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %FieldDeclaration*, i64 }, { %FieldDeclaration*, i64 }* %fields, i32 0, i32 0
  %t13 = load %FieldDeclaration*, %FieldDeclaration** %t12
  store i64 0, i64* %l2
  store %FieldDeclaration zeroinitializer, %FieldDeclaration* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %FieldDeclaration, %FieldDeclaration* %t13, i64 %t16
  %t18 = load %FieldDeclaration, %FieldDeclaration* %t17
  store %FieldDeclaration %t18, %FieldDeclaration* %l3
  %t19 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t20 = extractvalue %FieldDeclaration %t19, 0
  store i8* %t20, i8** %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l4
  %t23 = call i1 @contains_string({ i8**, i64 }* %t21, i8* %t22)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t26 = load %FieldDeclaration, %FieldDeclaration* %l3
  %t27 = load i8*, i8** %l4
  br i1 %t23, label %then4, label %else5
then4:
  br label %merge6
else5:
  %t28 = load i8*, i8** %l4
  %t29 = alloca [1 x i8*]
  %t30 = getelementptr [1 x i8*], [1 x i8*]* %t29, i32 0, i32 0
  %t31 = getelementptr i8*, i8** %t30, i64 0
  store i8* %t28, i8** %t31
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t30, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @seenconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t36 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t37 = phi { i8**, i64 }* [ %t24, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t36, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  br label %for0
afterfor3:
  %t40 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t40
}

define { %Diagnostic*, i64 }* @validate_interface_annotation(i8* %struct_name, %Statement %interface_definition, %TypeAnnotation %annotation) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  store double 0.0, double* %l0
  %t0 = extractvalue %TypeAnnotation %annotation, 0
  %t1 = call { i8**, i64 }* @parse_type_arguments(i8* %t0)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l1
  %t2 = load double, double* %l0
  %t3 = sitofp i64 0 to double
  %t4 = fcmp oeq double %t2, %t3
  %t5 = load double, double* %l0
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t4, label %then0, label %merge1
then0:
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t8 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t9 = extractvalue { i8**, i64 } %t8, 1
  %t10 = icmp sgt i64 %t9, 0
  %t11 = load double, double* %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t10, label %then2, label %merge3
then2:
  %t13 = extractvalue %TypeAnnotation %annotation, 0
  %t14 = call i8* @trim_text(i8* %t13)
  ret { %Diagnostic*, i64 }* null
merge3:
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  ret { %Diagnostic*, i64 }* null
merge1:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t22 = extractvalue { i8**, i64 } %t21, 1
  %t23 = icmp eq i64 %t22, 0
  %t24 = load double, double* %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t23, label %then4, label %merge5
then4:
  %t26 = call i8* @format_interface_signature(%Statement %interface_definition)
  ret { %Diagnostic*, i64 }* null
merge5:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load { i8**, i64 }, { i8**, i64 }* %t27
  %t29 = extractvalue { i8**, i64 } %t28, 1
  %t30 = load double, double* %l0
  %t31 = sitofp i64 %t29 to double
  %t32 = fcmp une double %t31, %t30
  %t33 = load double, double* %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t32, label %then6, label %merge7
then6:
  %t35 = extractvalue %TypeAnnotation %annotation, 0
  %t36 = call i8* @trim_text(i8* %t35)
  %t37 = call i8* @format_interface_signature(%Statement %interface_definition)
  %t38 = call %Diagnostic @make_interface_type_argument_mismatch_diagnostic(i8* %struct_name, i8* %t36, i8* %t37)
  %t39 = alloca [1 x %Diagnostic]
  %t40 = getelementptr [1 x %Diagnostic], [1 x %Diagnostic]* %t39, i32 0, i32 0
  %t41 = getelementptr %Diagnostic, %Diagnostic* %t40, i64 0
  store %Diagnostic %t38, %Diagnostic* %t41
  %t42 = alloca { %Diagnostic*, i64 }
  %t43 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 0
  store %Diagnostic* %t40, %Diagnostic** %t43
  %t44 = getelementptr { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t42, i32 0, i32 1
  store i64 1, i64* %t44
  ret { %Diagnostic*, i64 }* %t42
merge7:
  %t45 = alloca [0 x double]
  %t46 = getelementptr [0 x double], [0 x double]* %t45, i32 0, i32 0
  %t47 = alloca { double*, i64 }
  %t48 = getelementptr { double*, i64 }, { double*, i64 }* %t47, i32 0, i32 0
  store double* %t46, double** %t48
  %t49 = getelementptr { double*, i64 }, { double*, i64 }* %t47, i32 0, i32 1
  store i64 0, i64* %t49
  ret { %Diagnostic*, i64 }* null
}

define i8* @format_interface_signature(%Statement %interface_definition) {
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
  %t6 = load { i8**, i64 }, { i8**, i64 }* %t5
  %t7 = extractvalue { i8**, i64 } %t6, 1
  %t8 = icmp eq i64 %t7, 0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  ret i8* null
}

define i8* @join_with_separator({ i8**, i64 }* %items, i8* %separator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %items
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %items
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  store i8* %t9, i8** %l0
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l1
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t35 = phi i8* [ %t11, %entry ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t12, %entry ], [ %t34, %loop.latch4 ]
  store i8* %t35, i8** %l0
  store double %t36, double* %l1
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %items
  %t15 = extractvalue { i8**, i64 } %t14, 1
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp oge double %t13, %t16
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  br i1 %t17, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t20 = load i8*, i8** %l0
  %t21 = add i8* %t20, %separator
  %t22 = load double, double* %l1
  %t23 = load { i8**, i64 }, { i8**, i64 }* %items
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  %t29 = add i8* %t21, %t28
  store i8* %t29, i8** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load i8*, i8** %l0
  ret i8* %t37
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
  %t21 = phi double [ %t11, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l3
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l3
  %t13 = load double, double* %l3
  %t14 = getelementptr i8, i8* %block, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l4
  %t16 = load i8, i8* %l4
  %t17 = load double, double* %l3
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l3
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t22 = load i8*, i8** %l1
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l5
  %t24 = load i8*, i8** %l5
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t25
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
  %t18 = phi double [ %t1, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l0
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
  %t14 = load double, double* %l0
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t17 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t21 = load double, double* %l1
  %t22 = load double, double* %l0
  %t23 = fcmp ole double %t21, %t22
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  %t28 = call i8* @slice_text(i8* %value, double %t26, double %t27)
  ret i8* %t28
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
  %t23 = phi i8* [ %t5, %entry ], [ %t21, %loop.latch6 ]
  %t24 = phi double [ %t6, %entry ], [ %t22, %loop.latch6 ]
  store i8* %t23, i8** %l0
  store double %t24, double* %l1
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
  %t15 = getelementptr i8, i8* %t11, i64 0
  %t16 = load i8, i8* %t15
  %t17 = add i8 %t16, %t14
  store i8* null, i8** %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch6
loop.latch6:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t25 = load i8*, i8** %l0
  ret i8* %t25
}

define i1 @is_whitespace(i8* %ch) {
entry:
  %t3 = getelementptr i8, i8* %ch, i64 0
  %t4 = load i8, i8* %t3
  %t5 = icmp eq i8 %t4, 32
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t5, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t6 = getelementptr i8, i8* %ch, i64 0
  %t7 = load i8, i8* %t6
  %t8 = icmp eq i8 %t7, 10
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t9 = phi i1 [ true, %logical_or_entry_2 ], [ %t8, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t9, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t10 = getelementptr i8, i8* %ch, i64 0
  %t11 = load i8, i8* %t10
  %t12 = icmp eq i8 %t11, 9
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t13 = phi i1 [ true, %logical_or_entry_1 ], [ %t12, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t13, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t14 = getelementptr i8, i8* %ch, i64 0
  %t15 = load i8, i8* %t14
  %t16 = icmp eq i8 %t15, 13
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t17 = phi i1 [ true, %logical_or_entry_0 ], [ %t16, %logical_or_right_end_0 ]
  ret i1 %t17
}

define { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }* %methods) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %MethodDeclaration
  %l4 = alloca double
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
  %t10 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %methods, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %methods, i32 0, i32 0
  %t13 = load %MethodDeclaration*, %MethodDeclaration** %t12
  store i64 0, i64* %l2
  store %MethodDeclaration zeroinitializer, %MethodDeclaration* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %MethodDeclaration, %MethodDeclaration* %t13, i64 %t16
  %t18 = load %MethodDeclaration, %MethodDeclaration* %t17
  store %MethodDeclaration %t18, %MethodDeclaration* %l3
  %t19 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t20 = extractvalue %MethodDeclaration %t19, 0
  %t21 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature zeroinitializer)
  %t22 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t21)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t23 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t24 = extractvalue %MethodDeclaration %t23, 0
  store double 0.0, double* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l4
  %t27 = call i1 @contains_string({ i8**, i64 }* %t25, i8* null)
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t30 = load %MethodDeclaration, %MethodDeclaration* %l3
  %t31 = load double, double* %l4
  br i1 %t27, label %then4, label %else5
then4:
  br label %merge6
else5:
  %t32 = load double, double* %l4
  %t33 = alloca [1 x double]
  %t34 = getelementptr [1 x double], [1 x double]* %t33, i32 0, i32 0
  %t35 = getelementptr double, double* %t34, i64 0
  store double %t32, double* %t35
  %t36 = alloca { double*, i64 }
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 0
  store double* %t34, double** %t37
  %t38 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 1
  store i64 1, i64* %t38
  %t39 = call double @seenconcat({ double*, i64 }* %t36)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t40 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t29, %else5 ]
  %t41 = phi { i8**, i64 }* [ %t28, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t40, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t42 = load i64, i64* %l2
  %t43 = add i64 %t42, 1
  store i64 %t43, i64* %l2
  br label %for0
afterfor3:
  %t44 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t44
}

define { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }* %variants) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %EnumVariant
  %l4 = alloca i8*
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
  %t10 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %variants, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %EnumVariant*, i64 }, { %EnumVariant*, i64 }* %variants, i32 0, i32 0
  %t13 = load %EnumVariant*, %EnumVariant** %t12
  store i64 0, i64* %l2
  store %EnumVariant zeroinitializer, %EnumVariant* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %EnumVariant, %EnumVariant* %t13, i64 %t16
  %t18 = load %EnumVariant, %EnumVariant* %t17
  store %EnumVariant %t18, %EnumVariant* %l3
  %t19 = load %EnumVariant, %EnumVariant* %l3
  %t20 = extractvalue %EnumVariant %t19, 0
  store i8* %t20, i8** %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l4
  %t23 = call i1 @contains_string({ i8**, i64 }* %t21, i8* %t22)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t26 = load %EnumVariant, %EnumVariant* %l3
  %t27 = load i8*, i8** %l4
  br i1 %t23, label %then4, label %else5
then4:
  br label %merge6
else5:
  %t28 = load i8*, i8** %l4
  %t29 = alloca [1 x i8*]
  %t30 = getelementptr [1 x i8*], [1 x i8*]* %t29, i32 0, i32 0
  %t31 = getelementptr i8*, i8** %t30, i64 0
  store i8* %t28, i8** %t31
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t30, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @seenconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t36 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t37 = phi { i8**, i64 }* [ %t24, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t36, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  br label %for0
afterfor3:
  %t40 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t40
}

define { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }* %members) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %FunctionSignature
  %l4 = alloca i8*
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
  %t10 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %members, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %FunctionSignature*, i64 }, { %FunctionSignature*, i64 }* %members, i32 0, i32 0
  %t13 = load %FunctionSignature*, %FunctionSignature** %t12
  store i64 0, i64* %l2
  store %FunctionSignature zeroinitializer, %FunctionSignature* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %FunctionSignature, %FunctionSignature* %t13, i64 %t16
  %t18 = load %FunctionSignature, %FunctionSignature* %t17
  store %FunctionSignature %t18, %FunctionSignature* %l3
  %t19 = load %FunctionSignature, %FunctionSignature* %l3
  %t20 = call { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %t19)
  %t21 = call double @diagnosticsconcat({ %Diagnostic*, i64 }* %t20)
  store { %Diagnostic*, i64 }* null, { %Diagnostic*, i64 }** %l1
  %t22 = load %FunctionSignature, %FunctionSignature* %l3
  %t23 = extractvalue %FunctionSignature %t22, 0
  store i8* %t23, i8** %l4
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load i8*, i8** %l4
  %t26 = call i1 @contains_string({ i8**, i64 }* %t24, i8* %t25)
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t29 = load %FunctionSignature, %FunctionSignature* %l3
  %t30 = load i8*, i8** %l4
  br i1 %t26, label %then4, label %else5
then4:
  br label %merge6
else5:
  %t31 = load i8*, i8** %l4
  %t32 = alloca [1 x i8*]
  %t33 = getelementptr [1 x i8*], [1 x i8*]* %t32, i32 0, i32 0
  %t34 = getelementptr i8*, i8** %t33, i64 0
  store i8* %t31, i8** %t34
  %t35 = alloca { i8**, i64 }
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 0
  store i8** %t33, i8*** %t36
  %t37 = getelementptr { i8**, i64 }, { i8**, i64 }* %t35, i32 0, i32 1
  store i64 1, i64* %t37
  %t38 = call double @seenconcat({ i8**, i64 }* %t35)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t39 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t28, %else5 ]
  %t40 = phi { i8**, i64 }* [ %t27, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t39, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t41 = load i64, i64* %l2
  %t42 = add i64 %t41, 1
  store i64 %t42, i64* %l2
  br label %for0
afterfor3:
  %t43 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t43
}

define { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }* %properties) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %ModelProperty
  %l4 = alloca i8*
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
  %t10 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %properties, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %properties, i32 0, i32 0
  %t13 = load %ModelProperty*, %ModelProperty** %t12
  store i64 0, i64* %l2
  store %ModelProperty zeroinitializer, %ModelProperty* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %ModelProperty, %ModelProperty* %t13, i64 %t16
  %t18 = load %ModelProperty, %ModelProperty* %t17
  store %ModelProperty %t18, %ModelProperty* %l3
  %t19 = load %ModelProperty, %ModelProperty* %l3
  %t20 = extractvalue %ModelProperty %t19, 0
  store i8* %t20, i8** %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l4
  %t23 = call i1 @contains_string({ i8**, i64 }* %t21, i8* %t22)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t26 = load %ModelProperty, %ModelProperty* %l3
  %t27 = load i8*, i8** %l4
  br i1 %t23, label %then4, label %else5
then4:
  br label %merge6
else5:
  %t28 = load i8*, i8** %l4
  %t29 = alloca [1 x i8*]
  %t30 = getelementptr [1 x i8*], [1 x i8*]* %t29, i32 0, i32 0
  %t31 = getelementptr i8*, i8** %t30, i64 0
  store i8* %t28, i8** %t31
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t30, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @seenconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t36 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t37 = phi { i8**, i64 }* [ %t24, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t36, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  br label %for0
afterfor3:
  %t40 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t40
}

define { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature %signature) {
entry:
  %t0 = extractvalue %FunctionSignature %signature, 5
  %t1 = call { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* null)
  ret { %Diagnostic*, i64 }* %t1
}

define { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }* %type_parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca i64
  %l3 = alloca %TypeParameter
  %l4 = alloca i8*
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
  %t10 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %type_parameters, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %type_parameters, i32 0, i32 0
  %t13 = load %TypeParameter*, %TypeParameter** %t12
  store i64 0, i64* %l2
  store %TypeParameter zeroinitializer, %TypeParameter* %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr %TypeParameter, %TypeParameter* %t13, i64 %t16
  %t18 = load %TypeParameter, %TypeParameter* %t17
  store %TypeParameter %t18, %TypeParameter* %l3
  %t19 = load %TypeParameter, %TypeParameter* %l3
  %t20 = extractvalue %TypeParameter %t19, 0
  store i8* %t20, i8** %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l4
  %t23 = call i1 @contains_string({ i8**, i64 }* %t21, i8* %t22)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t26 = load %TypeParameter, %TypeParameter* %l3
  %t27 = load i8*, i8** %l4
  br i1 %t23, label %then4, label %else5
then4:
  br label %merge6
else5:
  %t28 = load i8*, i8** %l4
  %t29 = alloca [1 x i8*]
  %t30 = getelementptr [1 x i8*], [1 x i8*]* %t29, i32 0, i32 0
  %t31 = getelementptr i8*, i8** %t30, i64 0
  store i8* %t28, i8** %t31
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t30, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @seenconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge6
merge6:
  %t36 = phi { %Diagnostic*, i64 }* [ null, %then4 ], [ %t25, %else5 ]
  %t37 = phi { i8**, i64 }* [ %t24, %then4 ], [ null, %else5 ]
  store { %Diagnostic*, i64 }* %t36, { %Diagnostic*, i64 }** %l1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  br label %forinc2
forinc2:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  br label %for0
afterfor3:
  %t40 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t40
}

define { %Diagnostic*, i64 }* @build_effect_diagnostics(%Program %program) {
entry:
  %l0 = alloca double
  %l1 = alloca { %Diagnostic*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = call double @validate_effects(%Program %program)
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
  %t37 = phi { %Diagnostic*, i64 }* [ %t8, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t9, %entry ], [ %t36, %loop.latch2 ]
  store { %Diagnostic*, i64 }* %t37, { %Diagnostic*, i64 }** %l1
  store double %t38, double* %l2
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
  %t30 = phi { %Diagnostic*, i64 }* [ %t16, %loop.body1 ], [ %t28, %loop.latch6 ]
  %t31 = phi double [ %t19, %loop.body1 ], [ %t29, %loop.latch6 ]
  store { %Diagnostic*, i64 }* %t30, { %Diagnostic*, i64 }** %l1
  store double %t31, double* %l4
  br label %loop.body5
loop.body5:
  %t20 = load double, double* %l4
  %t21 = load double, double* %l3
  %t22 = load double, double* %l3
  store double 0.0, double* %l5
  %t23 = load double, double* %l3
  %t24 = load double, double* %l5
  store double 0.0, double* %l6
  %t25 = load double, double* %l4
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l4
  br label %loop.latch6
loop.latch6:
  %t28 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t29 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t32 = load double, double* %l2
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l2
  br label %loop.latch2
loop.latch2:
  %t35 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  %t36 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t39 = load { %Diagnostic*, i64 }*, { %Diagnostic*, i64 }** %l1
  ret { %Diagnostic*, i64 }* %t39
}

define i8* @format_effect_message(i8* %routine_name, i8* %effect, i8* %requirement) {
entry:
  %l0 = alloca i8
  %s0 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.0, i32 0, i32 0
  %t1 = add i8* %routine_name, %s0
  %t2 = add i8* %t1, %effect
  %t3 = getelementptr i8, i8* %t2, i64 0
  %t4 = load i8, i8* %t3
  %t5 = add i8 %t4, 39
  store i8 %t5, i8* %l0
  %t6 = icmp ne i8* %requirement, null
  %t7 = load i8, i8* %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %t8 = load i8, i8* %l0
  %s9 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.9, i32 0, i32 0
  %t10 = getelementptr i8, i8* %s9, i64 0
  %t11 = load i8, i8* %t10
  %t12 = add i8 %t8, %t11
  br label %merge1
merge1:
  %t13 = phi i8 [ zeroinitializer, %then0 ], [ %t7, %entry ]
  store i8 %t13, i8* %l0
  %t14 = load i8, i8* %l0
  %s15 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.15, i32 0, i32 0
  %t16 = getelementptr i8, i8* %s15, i64 0
  %t17 = load i8, i8* %t16
  %t18 = add i8 %t14, %t17
  %t19 = getelementptr i8, i8* %effect, i64 0
  %t20 = load i8, i8* %t19
  %t21 = add i8 %t18, %t20
  %s22 = getelementptr inbounds [61 x i8], [61 x i8]* @.str.22, i32 0, i32 0
  %t23 = getelementptr i8, i8* %s22, i64 0
  %t24 = load i8, i8* %t23
  %t25 = add i8 %t21, %t24
  store i8 %t25, i8* %l0
  %t26 = load i8, i8* %l0
  ret i8* null
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
  %t10 = icmp eq i8* %t9, %candidate
  %t11 = load i8*, i8** %l1
  br i1 %t10, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  br label %forinc2
forinc2:
  %t12 = load i64, i64* %l0
  %t13 = add i64 %t12, 1
  store i64 %t13, i64* %l0
  br label %for0
afterfor3:
  ret i1 0
}

define %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, i8* %span) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = insertvalue %ScopeResult undef, { i8**, i64 }* null, 0
  %t2 = call double @token_from_name(i8* %name, i8* %span)
  %t3 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* null)
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
  %t11 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %bindings, i8* %name, i8* %kind, i8* %span)
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

define %SymbolCollectionResult @register_symbol(i8* %name, i8* %kind, i8* %span, { %SymbolEntry*, i64 }* %existing) {
entry:
  %t0 = call i1 @has_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = insertvalue %SymbolCollectionResult undef, { i8**, i64 }* null, 0
  %t2 = call double @token_from_name(i8* %name, i8* %span)
  %t3 = call %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* null)
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
  %t11 = call { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %existing, i8* %name, i8* %kind, i8* %span)
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

define { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }* %symbols, i8* %name, i8* %kind, i8* %span) {
entry:
  %l0 = alloca { %SymbolEntry*, i64 }*
  %t0 = call { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }* %symbols)
  store { %SymbolEntry*, i64 }* %t0, { %SymbolEntry*, i64 }** %l0
  %t1 = insertvalue %SymbolEntry undef, i8* %name, 0
  %t2 = insertvalue %SymbolEntry %t1, i8* %kind, 1
  %t3 = insertvalue %SymbolEntry %t2, i8* %span, 2
  %t4 = alloca [1 x %SymbolEntry]
  %t5 = getelementptr [1 x %SymbolEntry], [1 x %SymbolEntry]* %t4, i32 0, i32 0
  %t6 = getelementptr %SymbolEntry, %SymbolEntry* %t5, i64 0
  store %SymbolEntry %t3, %SymbolEntry* %t6
  %t7 = alloca { %SymbolEntry*, i64 }
  %t8 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t7, i32 0, i32 0
  store %SymbolEntry* %t5, %SymbolEntry** %t8
  %t9 = getelementptr { %SymbolEntry*, i64 }, { %SymbolEntry*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @updatedconcat({ %SymbolEntry*, i64 }* %t7)
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
  %t11 = icmp eq i8* %t10, %name
  %t12 = load %SymbolEntry, %SymbolEntry* %l1
  br i1 %t11, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  br label %forinc2
forinc2:
  %t13 = load i64, i64* %l0
  %t14 = add i64 %t13, 1
  store i64 %t14, i64* %l0
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

define %Diagnostic @make_duplicate_symbol_diagnostic(i8* %name, i8* %kind, i8* %token) {
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
  %t15 = phi double [ %t1, %entry ], [ %t14, %loop.latch2 ]
  store double %t15, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %prefix, i64 %t6
  %t8 = load i8, i8* %t7
  %t9 = icmp ne i8 %t5, %t8
  %t10 = load double, double* %l0
  br i1 %t9, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 1
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
