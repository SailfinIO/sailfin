; ModuleID = 'sailfin'
source_filename = "sailfin"

%TextBuilder = type { { i8**, i64 }*, double }
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

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@.str.1 = private unnamed_addr constant [10 x i8] c"import { \00"
@.str.4 = private unnamed_addr constant [10 x i8] c" } from \22\00"
@.str.7 = private unnamed_addr constant [3 x i8] c"\22;\00"
@.str.1 = private unnamed_addr constant [10 x i8] c"export { \00"
@.str.0 = private unnamed_addr constant [5 x i8] c"let \00"
@.str.0 = private unnamed_addr constant [6 x i8] c"test \00"
@.str.0 = private unnamed_addr constant [7 x i8] c"model \00"
@.str.2 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.0 = private unnamed_addr constant [6 x i8] c"type \00"
@.str.3 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.0 = private unnamed_addr constant [11 x i8] c"interface \00"
@.str.0 = private unnamed_addr constant [6 x i8] c"enum \00"
@.str.0 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.0 = private unnamed_addr constant [8 x i8] c"prompt \00"
@.str.0 = private unnamed_addr constant [6 x i8] c"with \00"
@.str.0 = private unnamed_addr constant [4 x i8] c"if \00"
@.str.0 = private unnamed_addr constant [5 x i8] c"for \00"
@.str.0 = private unnamed_addr constant [7 x i8] c"match \00"
@.str.0 = private unnamed_addr constant [6 x i8] c"case \00"
@.str.47 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.7 = private unnamed_addr constant [3 x i8] c": \00"
@.str.7 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.0 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.19 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.40 = private unnamed_addr constant [4 x i8] c" { \00"
@.str.43 = private unnamed_addr constant [3 x i8] c"; \00"
@.str.46 = private unnamed_addr constant [3 x i8] c" }\00"
@.str.4 = private unnamed_addr constant [3 x i8] c"![\00"
@.str.0 = private unnamed_addr constant [4 x i8] c"fn \00"
@.str.44 = private unnamed_addr constant [15 x i8] c"(\22 + args + \22)\00"
@.str.44 = private unnamed_addr constant [3 x i8] c"{\0A\00"
@.str.48 = private unnamed_addr constant [3 x i8] c"\0A}\00"

define i8* @emit_program(%Program %program) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  %t0 = call %TextBuilder @builder_new()
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = call %TextBuilder @builder_emit_blank(%TextBuilder %t2)
  store %TextBuilder %t3, %TextBuilder* %l0
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %t5 = call %TextBuilder @builder_emit_blank(%TextBuilder %t4)
  store %TextBuilder %t5, %TextBuilder* %l0
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l1
  %t7 = load %TextBuilder, %TextBuilder* %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t45 = phi %TextBuilder [ %t7, %entry ], [ %t43, %loop.latch2 ]
  %t46 = phi double [ %t8, %entry ], [ %t44, %loop.latch2 ]
  store %TextBuilder %t45, %TextBuilder* %l0
  store double %t46, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = extractvalue %Program %program, 0
  %t11 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t12 = extractvalue { i8**, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t9, %t13
  %t15 = load %TextBuilder, %TextBuilder* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load %TextBuilder, %TextBuilder* %l0
  %t18 = extractvalue %Program %program, 0
  %t19 = load double, double* %l1
  %t20 = load { i8**, i64 }, { i8**, i64 }* %t18
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  %t26 = call %TextBuilder @emit_statement(%TextBuilder %t17, %Statement zeroinitializer)
  store %TextBuilder %t26, %TextBuilder* %l0
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  %t30 = extractvalue %Program %program, 0
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 1
  %t33 = sitofp i64 %t32 to double
  %t34 = fcmp olt double %t29, %t33
  %t35 = load %TextBuilder, %TextBuilder* %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then6, label %merge7
then6:
  %t37 = load %TextBuilder, %TextBuilder* %l0
  %t38 = call %TextBuilder @builder_emit_blank(%TextBuilder %t37)
  store %TextBuilder %t38, %TextBuilder* %l0
  br label %merge7
merge7:
  %t39 = phi %TextBuilder [ %t38, %then6 ], [ %t35, %loop.body1 ]
  store %TextBuilder %t39, %TextBuilder* %l0
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load %TextBuilder, %TextBuilder* %l0
  %t44 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t47 = load %TextBuilder, %TextBuilder* %l0
  %t48 = call i8* @builder_to_string(%TextBuilder %t47)
  ret i8* %t48
}

define %TextBuilder @emit_statement(%TextBuilder %builder, %Statement %statement) {
entry:
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_import(%TextBuilder %builder, { %ImportSpecifier*, i64 }* %specifiers, i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @format_import_specifiers({ %ImportSpecifier*, i64 }* %specifiers)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1, i32 0, i32 0
  %t2 = load i8*, i8** %l0
  %t3 = add i8* %s1, %t2
  %s4 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %source
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t9)
  ret %TextBuilder %t10
}

define %TextBuilder @emit_export(%TextBuilder %builder, { %ExportSpecifier*, i64 }* %specifiers, i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @format_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1, i32 0, i32 0
  %t2 = load i8*, i8** %l0
  %t3 = add i8* %s1, %t2
  %s4 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %source
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t9)
  ret %TextBuilder %t10
}

define %TextBuilder @emit_variable(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = getelementptr i8, i8* %t4, i64 0
  %t6 = load i8, i8* %t5
  %t7 = add i8 %t6, 59
  %t8 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  ret %TextBuilder %t8
}

define %TextBuilder @emit_function(%TextBuilder %builder, %FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = call i8* @format_function_header(%FunctionSignature %signature)
  store i8* %t1, i8** %l1
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder %t2, i8* %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call %TextBuilder @emit_block(%TextBuilder %t5, %Block %body)
  store %TextBuilder %t6, %TextBuilder* %l0
  %t7 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t7
}

define %TextBuilder @emit_callable(%TextBuilder %builder, i8* %keyword, %FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = call i8* @format_callable_header(i8* %keyword, %FunctionSignature %signature)
  store i8* %t1, i8** %l1
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder %t2, i8* %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call %TextBuilder @emit_block(%TextBuilder %t5, %Block %body)
  store %TextBuilder %t6, %TextBuilder* %l0
  %t7 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t7
}

define %TextBuilder @emit_test(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  store double 0.0, double* %l0
  store double 0.0, double* %l1
  store double 0.0, double* %l2
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = load double, double* %l1
  store i8* null, i8** %l3
  %t2 = load double, double* %l2
  %t3 = load double, double* %l0
  %t4 = load i8*, i8** %l3
  %t5 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t4)
  store double 0.0, double* %l0
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_model(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  store double 0.0, double* %l2
  %t1 = load double, double* %l2
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t7 = load double, double* %l0
  %t8 = call %TextBuilder @builder_push_indent(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l3
  %t10 = load double, double* %l0
  %t11 = load i8*, i8** %l1
  %t12 = load double, double* %l2
  %t13 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t10, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t13, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  store double %t25, double* %l3
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l3
  store double 0.0, double* %l4
  %t15 = load double, double* %l4
  store double 0.0, double* %l5
  %t16 = load double, double* %l0
  %t17 = load double, double* %l5
  %t18 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t19 = load double, double* %l3
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l3
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l0
  %t23 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t26 = load double, double* %l0
  %t27 = call %TextBuilder @builder_pop_indent(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t28 = load double, double* %l0
  %t29 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t30 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define i8* @format_import_specifiers({ %ImportSpecifier*, i64 }* %specifiers) {
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
  %t40 = phi { i8**, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t7, %entry ], [ %t39, %loop.latch2 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store double %t41, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t10 = extractvalue { %ImportSpecifier*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %ImportSpecifier*, i64 } %t16, 0
  %t18 = extractvalue { %ImportSpecifier*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %ImportSpecifier, %ImportSpecifier* %t17, i64 %t15
  %t21 = load %ImportSpecifier, %ImportSpecifier* %t20
  %t22 = extractvalue %ImportSpecifier %t21, 0
  %t23 = load double, double* %l1
  %t24 = load { %ImportSpecifier*, i64 }, { %ImportSpecifier*, i64 }* %specifiers
  %t25 = extractvalue { %ImportSpecifier*, i64 } %t24, 0
  %t26 = extractvalue { %ImportSpecifier*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr %ImportSpecifier, %ImportSpecifier* %t25, i64 %t23
  %t29 = load %ImportSpecifier, %ImportSpecifier* %t28
  %t30 = extractvalue %ImportSpecifier %t29, 1
  %t31 = call i8* @format_specifier_entry(i8* %t22, i8* %t30)
  store i8* %t31, i8** %l2
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l2
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t32, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_export_specifiers({ %ExportSpecifier*, i64 }* %specifiers) {
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
  %t40 = phi { i8**, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t7, %entry ], [ %t39, %loop.latch2 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store double %t41, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t10 = extractvalue { %ExportSpecifier*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %ExportSpecifier*, i64 } %t16, 0
  %t18 = extractvalue { %ExportSpecifier*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %ExportSpecifier, %ExportSpecifier* %t17, i64 %t15
  %t21 = load %ExportSpecifier, %ExportSpecifier* %t20
  %t22 = extractvalue %ExportSpecifier %t21, 0
  %t23 = load double, double* %l1
  %t24 = load { %ExportSpecifier*, i64 }, { %ExportSpecifier*, i64 }* %specifiers
  %t25 = extractvalue { %ExportSpecifier*, i64 } %t24, 0
  %t26 = extractvalue { %ExportSpecifier*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr %ExportSpecifier, %ExportSpecifier* %t25, i64 %t23
  %t29 = load %ExportSpecifier, %ExportSpecifier* %t28
  %t30 = extractvalue %ExportSpecifier %t29, 1
  %t31 = call i8* @format_specifier_entry(i8* %t22, i8* %t30)
  store i8* %t31, i8** %l2
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l2
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t32, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_specifier_entry(i8* %name, i8* %alias) {
entry:
  %t1 = icmp eq i8* %alias, null
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %name, %s2
  %t4 = add i8* %t3, %alias
  ret i8* %t4
}

define %TextBuilder @emit_type_alias(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %t2, %s3
  %t5 = load i8*, i8** %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_interface(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %TextBuilder @emit_block_start(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t26 = phi double [ %t8, %entry ], [ %t24, %loop.latch2 ]
  %t27 = phi double [ %t10, %entry ], [ %t25, %loop.latch2 ]
  store double %t26, double* %l0
  store double %t27, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  store double 0.0, double* %l3
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = load double, double* %l3
  %t14 = call i8* @format_signature_line(i8* %s12, %FunctionSignature zeroinitializer)
  %t15 = getelementptr i8, i8* %t14, i64 0
  %t16 = load i8, i8* %t15
  %t17 = add i8 %t16, 59
  store i8 %t17, i8* %l4
  %t18 = load double, double* %l0
  %t19 = load i8, i8* %l4
  %t20 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t21 = load double, double* %l2
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l2
  br label %loop.latch2
loop.latch2:
  %t24 = load double, double* %l0
  %t25 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t28 = load double, double* %l0
  %t29 = call %TextBuilder @emit_block_end(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t30 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_enum(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %TextBuilder @emit_block_start(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t8, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t10, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  store double %t25, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  store double 0.0, double* %l3
  %t12 = load double, double* %l0
  %t13 = load double, double* %l3
  %t14 = call i8* @format_enum_variant(%EnumVariant zeroinitializer)
  %t15 = getelementptr i8, i8* %t14, i64 0
  %t16 = load i8, i8* %t15
  %t17 = add i8 %t16, 59
  %t18 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t19 = load double, double* %l2
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l2
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l0
  %t23 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t26 = load double, double* %l0
  %t27 = call %TextBuilder @emit_block_end(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t28 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_struct(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %TextBuilder @emit_block_start(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t18 = phi double [ %t8, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t10, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l0
  store double %t19, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  %t12 = load double, double* %l0
  %t13 = load double, double* %l2
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l2
  br label %loop.latch2
loop.latch2:
  %t16 = load double, double* %l0
  %t17 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load double, double* %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  %t24 = load double, double* %l3
  br label %loop.header4
loop.header4:
  %t40 = phi double [ %t21, %entry ], [ %t38, %loop.latch6 ]
  %t41 = phi double [ %t24, %entry ], [ %t39, %loop.latch6 ]
  store double %t40, double* %l0
  store double %t41, double* %l3
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l3
  store double 0.0, double* %l4
  %t26 = load double, double* %l0
  %t27 = load double, double* %l4
  %t28 = load double, double* %l0
  %t29 = load double, double* %l4
  %t30 = load double, double* %l0
  %t31 = load double, double* %l4
  %t32 = load double, double* %l3
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  %t35 = load double, double* %l3
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l3
  br label %loop.latch6
loop.latch6:
  %t38 = load double, double* %l0
  %t39 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t43 = load double, double* %l0
  %t44 = call %TextBuilder @emit_block_end(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t45 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_block(%TextBuilder %builder, %Block %block) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @emit_block_start(%TextBuilder %builder)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @emit_block_body(%TextBuilder %t1, %Block %block)
  store %TextBuilder %t2, %TextBuilder* %l0
  %t3 = load %TextBuilder, %TextBuilder* %l0
  %t4 = call %TextBuilder @emit_block_end(%TextBuilder %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t5
}

define %TextBuilder @emit_block_body(%TextBuilder %builder, %Block %block) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %TextBuilder
  %l2 = alloca double
  %t0 = extractvalue %Block %block, 2
  %t1 = load { i8**, i64 }, { i8**, i64 }* %t0
  %t2 = extractvalue { i8**, i64 } %t1, 1
  %t3 = icmp eq i64 %t2, 0
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = extractvalue %Block %block, 1
  %t5 = call i8* @trim_block_body(i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  ret %TextBuilder zeroinitializer
merge1:
  store %TextBuilder %builder, %TextBuilder* %l1
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load %TextBuilder, %TextBuilder* %l1
  %t9 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t33 = phi %TextBuilder [ %t8, %entry ], [ %t31, %loop.latch4 ]
  %t34 = phi double [ %t9, %entry ], [ %t32, %loop.latch4 ]
  store %TextBuilder %t33, %TextBuilder* %l1
  store double %t34, double* %l2
  br label %loop.body3
loop.body3:
  %t10 = load double, double* %l2
  %t11 = extractvalue %Block %block, 2
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t10, %t14
  %t16 = load %TextBuilder, %TextBuilder* %l1
  %t17 = load double, double* %l2
  br i1 %t15, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load %TextBuilder, %TextBuilder* %l1
  %t19 = extractvalue %Block %block, 2
  %t20 = load double, double* %l2
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  %t27 = call %TextBuilder @emit_block_statement(%TextBuilder %t18, %Statement zeroinitializer)
  store %TextBuilder %t27, %TextBuilder* %l1
  %t28 = load double, double* %l2
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l2
  br label %loop.latch4
loop.latch4:
  %t31 = load %TextBuilder, %TextBuilder* %l1
  %t32 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t35 = load %TextBuilder, %TextBuilder* %l1
  ret %TextBuilder %t35
}

define %TextBuilder @emit_block_statement(%TextBuilder %builder, %Statement %statement) {
entry:
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_prompt(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  ret %TextBuilder %t6
}

define %TextBuilder @emit_with(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t22 = phi i8* [ %t3, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t4, %entry ], [ %t21, %loop.latch2 ]
  store i8* %t22, i8** %l1
  store double %t23, double* %l2
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l2
  %t6 = load double, double* %l2
  %t7 = sitofp i64 0 to double
  %t8 = fcmp ogt double %t6, %t7
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then4, label %merge5
then4:
  %t12 = load i8*, i8** %l1
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = add i8* %t12, %s13
  store i8* %t14, i8** %l1
  br label %merge5
merge5:
  %t15 = phi i8* [ %t14, %then4 ], [ %t10, %loop.body1 ]
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l2
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t24 = load double, double* %l0
  %t25 = load i8*, i8** %l1
  %t26 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t25)
  store double 0.0, double* %l0
  %t27 = load double, double* %l0
  %t28 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_if(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_else_branch(%TextBuilder %builder, %ElseBranch %branch) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca %TextBuilder
  %t0 = extractvalue %ElseBranch %branch, 1
  %t1 = icmp ne i8* %t0, null
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %s2)
  store %TextBuilder %t3, %TextBuilder* %l0
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %t5 = extractvalue %ElseBranch %branch, 1
  %t6 = call %TextBuilder @emit_block(%TextBuilder %t4, %Block zeroinitializer)
  ret %TextBuilder %t6
merge1:
  %t7 = extractvalue %ElseBranch %branch, 0
  %t8 = icmp ne i8* %t7, null
  br i1 %t8, label %then2, label %merge3
then2:
  %t9 = extractvalue %ElseBranch %branch, 0
  %s10 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %s10)
  store %TextBuilder %t11, %TextBuilder* %l1
  %t12 = load %TextBuilder, %TextBuilder* %l1
  %t13 = extractvalue %ElseBranch %branch, 0
  %t14 = call %TextBuilder @emit_block_statement(%TextBuilder %t12, %Statement zeroinitializer)
  ret %TextBuilder %t14
merge3:
  ret %TextBuilder %builder
}

define %TextBuilder @emit_for(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_match(%TextBuilder %builder, %Statement %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t6 = load double, double* %l0
  %t7 = call %TextBuilder @builder_push_indent(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l2
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  %t11 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t19 = phi double [ %t9, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t11, %entry ], [ %t18, %loop.latch2 ]
  store double %t19, double* %l0
  store double %t20, double* %l2
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l2
  %t13 = load double, double* %l0
  %t14 = load double, double* %l2
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l2
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l0
  %t18 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t21 = load double, double* %l0
  %t22 = call %TextBuilder @builder_pop_indent(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t23 = load double, double* %l0
  %t24 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  ret %TextBuilder %t24
}

define %TextBuilder @emit_match_case(%TextBuilder %builder, %MatchCase %case) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %TextBuilder
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = extractvalue %MatchCase %case, 0
  %t2 = call i8* @format_expression(%Expression zeroinitializer)
  %t3 = add i8* %s0, %t2
  store i8* %t3, i8** %l0
  %t4 = extractvalue %MatchCase %case, 1
  %t5 = icmp ne i8* %t4, null
  %t6 = load i8*, i8** %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = load i8*, i8** %l0
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  %t9 = add i8* %t7, %s8
  %t10 = extractvalue %MatchCase %case, 1
  %t11 = call i8* @format_expression(%Expression zeroinitializer)
  %t12 = add i8* %t9, %t11
  store i8* %t12, i8** %l0
  br label %merge1
merge1:
  %t13 = phi i8* [ %t12, %then0 ], [ %t6, %entry ]
  store i8* %t13, i8** %l0
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l0
  %t16 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t15)
  store %TextBuilder %t16, %TextBuilder* %l1
  %t17 = load %TextBuilder, %TextBuilder* %l1
  %t18 = call %TextBuilder @builder_push_indent(%TextBuilder %t17)
  store %TextBuilder %t18, %TextBuilder* %l1
  %t19 = load %TextBuilder, %TextBuilder* %l1
  %t20 = extractvalue %MatchCase %case, 2
  %t21 = call %TextBuilder @emit_block_body(%TextBuilder %t19, %Block zeroinitializer)
  store %TextBuilder %t21, %TextBuilder* %l1
  %t22 = load %TextBuilder, %TextBuilder* %l1
  %t23 = call %TextBuilder @builder_pop_indent(%TextBuilder %t22)
  store %TextBuilder %t23, %TextBuilder* %l1
  %t24 = load %TextBuilder, %TextBuilder* %l1
  %t25 = call %TextBuilder @builder_emit_line(%TextBuilder %t24, i8* null)
  ret %TextBuilder %t25
}

define %TextBuilder @emit_block_start(%TextBuilder %builder) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* null)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @builder_push_indent(%TextBuilder %t1)
  ret %TextBuilder %t2
}

define %TextBuilder @emit_block_end(%TextBuilder %builder) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @builder_pop_indent(%TextBuilder %builder)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* null)
  ret %TextBuilder %t2
}

define %TextBuilder @emit_decorators_then_line(%TextBuilder %builder, { %Decorator*, i64 }* %decorators, i8* %line) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %line)
  ret %TextBuilder %t2
}

define %TextBuilder @emit_decorators(%TextBuilder %builder, { %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  store %TextBuilder %builder, %TextBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t25 = phi %TextBuilder [ %t1, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t2, %entry ], [ %t24, %loop.latch2 ]
  store %TextBuilder %t25, %TextBuilder* %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t5 = extractvalue { %Decorator*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %TextBuilder, %TextBuilder* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load %TextBuilder, %TextBuilder* %l0
  %t11 = load double, double* %l1
  %t12 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t13 = extractvalue { %Decorator*, i64 } %t12, 0
  %t14 = extractvalue { %Decorator*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %Decorator, %Decorator* %t13, i64 %t11
  %t17 = load %Decorator, %Decorator* %t16
  %t18 = call i8* @format_decorator(%Decorator %t17)
  %t19 = call %TextBuilder @builder_emit_line(%TextBuilder %t10, i8* %t18)
  store %TextBuilder %t19, %TextBuilder* %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load %TextBuilder, %TextBuilder* %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t27
}

define i8* @format_decorator(%Decorator %decorator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %t0 = extractvalue %Decorator %decorator, 0
  %t1 = getelementptr i8, i8* %t0, i64 0
  %t2 = load i8, i8* %t1
  %t3 = add i8 64, %t2
  store i8* null, i8** %l0
  %t4 = extractvalue %Decorator %decorator, 1
  %t5 = load { i8**, i64 }, { i8**, i64 }* %t4
  %t6 = extractvalue { i8**, i64 } %t5, 1
  %t7 = icmp eq i64 %t6, 0
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %t9 = load i8*, i8** %l0
  ret i8* %t9
merge1:
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l2
  %t16 = load i8*, i8** %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t44 = phi { i8**, i64 }* [ %t17, %entry ], [ %t42, %loop.latch4 ]
  %t45 = phi double [ %t18, %entry ], [ %t43, %loop.latch4 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l1
  store double %t45, double* %l2
  br label %loop.body3
loop.body3:
  %t19 = load double, double* %l2
  %t20 = extractvalue %Decorator %decorator, 1
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t22 = extractvalue { i8**, i64 } %t21, 1
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t19, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = extractvalue %Decorator %decorator, 1
  %t30 = load double, double* %l2
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr i8*, i8** %t32, i64 %t30
  %t36 = load i8*, i8** %t35
  %t37 = call i8* @format_decorator_argument(%DecoratorArgument zeroinitializer)
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l2
  br label %loop.latch4
loop.latch4:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t46 = load i8*, i8** %l0
  %s47 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.47, i32 0, i32 0
  %t48 = add i8* %t46, %s47
  ret i8* %t48
}

define i8* @format_decorator_argument(%DecoratorArgument %argument) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %DecoratorArgument %argument, 1
  %t1 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %DecoratorArgument %argument, 0
  %t3 = icmp eq i8* %t2, null
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  ret i8* %t5
merge1:
  %t6 = extractvalue %DecoratorArgument %argument, 0
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = load i8*, i8** %l0
  %t10 = add i8* %t8, %t9
  ret i8* %t10
}

define i8* @format_for_clause(%ForClause %clause) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = extractvalue %ForClause %clause, 0
  %t1 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t1, i8** %l0
  %t2 = extractvalue %ForClause %clause, 1
  %t3 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t3, i8** %l1
  %t5 = load i8*, i8** %l0
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = load i8*, i8** %l1
  %t10 = add i8* %t8, %t9
  ret i8* %t10
}

define i8* @format_function_header(%FunctionSignature %signature) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @format_signature_line(i8* %s0, %FunctionSignature %signature)
  ret i8* %t1
}

define i8* @format_method_header(%FunctionSignature %signature) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @format_signature_line(i8* %s0, %FunctionSignature %signature)
  ret i8* %t1
}

define i8* @format_callable_header(i8* %keyword, %FunctionSignature %signature) {
entry:
  %t0 = call i8* @format_signature_line(i8* %keyword, %FunctionSignature %signature)
  ret i8* %t0
}

define i8* @format_signature_line(i8* %keyword, %FunctionSignature %signature) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = extractvalue %FunctionSignature %signature, 1
  %t2 = load i8*, i8** %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l0
  br label %merge1
merge1:
  %t4 = phi i8* [ %s3, %then0 ], [ %t2, %entry ]
  store i8* %t4, i8** %l0
  %t5 = load i8*, i8** %l0
  %t6 = add i8* %t5, %keyword
  %t7 = getelementptr i8, i8* %t6, i64 0
  %t8 = load i8, i8* %t7
  %t9 = add i8 %t8, 32
  %t10 = extractvalue %FunctionSignature %signature, 0
  %t11 = getelementptr i8, i8* %t10, i64 0
  %t12 = load i8, i8* %t11
  %t13 = add i8 %t9, %t12
  store i8* null, i8** %l1
  %t14 = load i8*, i8** %l1
  %t15 = extractvalue %FunctionSignature %signature, 5
  %t16 = call i8* @format_type_parameters({ %TypeParameter*, i64 }* null)
  %t17 = add i8* %t14, %t16
  store i8* %t17, i8** %l1
  %t18 = load i8*, i8** %l1
  %s19 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.19, i32 0, i32 0
  %t20 = add i8* %t18, %s19
  store i8* %t20, i8** %l1
  %t21 = extractvalue %FunctionSignature %signature, 3
  %t22 = icmp ne i8* %t21, null
  %t23 = load i8*, i8** %l0
  %t24 = load i8*, i8** %l1
  br i1 %t22, label %then2, label %merge3
then2:
  %t25 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t26 = phi i8* [ null, %then2 ], [ %t24, %entry ]
  store i8* %t26, i8** %l1
  %t27 = extractvalue %FunctionSignature %signature, 4
  %t28 = call i8* @format_effects({ i8**, i64 }* %t27)
  store i8* %t28, i8** %l2
  %t29 = load i8*, i8** %l2
  %t30 = load i8*, i8** %l1
  ret i8* %t30
}

define i8* @format_field(%FieldDeclaration %field) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = extractvalue %FieldDeclaration %field, 2
  %t2 = load i8*, i8** %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = load i8*, i8** %l0
  %s4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  store i8* %t5, i8** %l0
  br label %merge1
merge1:
  %t6 = phi i8* [ %t5, %then0 ], [ %t2, %entry ]
  store i8* %t6, i8** %l0
  %t7 = load i8*, i8** %l0
  %t8 = extractvalue %FieldDeclaration %field, 0
  %t9 = add i8* %t7, %t8
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l0
  ret i8* %t11
}

define i8* @format_enum_variant(%EnumVariant %variant) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = extractvalue %EnumVariant %variant, 1
  %t1 = load { i8**, i64 }, { i8**, i64 }* %t0
  %t2 = extractvalue { i8**, i64 } %t1, 1
  %t3 = icmp eq i64 %t2, 0
  br i1 %t3, label %then0, label %merge1
then0:
  %t4 = extractvalue %EnumVariant %variant, 0
  ret i8* %t4
merge1:
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l1
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t37 = phi { i8**, i64 }* [ %t11, %entry ], [ %t35, %loop.latch4 ]
  %t38 = phi double [ %t12, %entry ], [ %t36, %loop.latch4 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  store double %t38, double* %l1
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l1
  %t14 = extractvalue %EnumVariant %variant, 1
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t14
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t13, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = extractvalue %EnumVariant %variant, 1
  %t23 = load double, double* %l1
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t22
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  %t30 = call i8* @format_field(%FieldDeclaration zeroinitializer)
  %t31 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t21, i8* %t30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch4
loop.latch4:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t39 = extractvalue %EnumVariant %variant, 0
  %s40 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.40, i32 0, i32 0
  %t41 = add i8* %t39, %s40
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s43 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.43, i32 0, i32 0
  %t44 = call i8* @join_with_separator({ i8**, i64 }* %t42, i8* %s43)
  %t45 = add i8* %t41, %t44
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.46, i32 0, i32 0
  %t47 = add i8* %t45, %s46
  ret i8* %t47
}

define i8* @format_parameters({ %Parameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t1 = extractvalue { %Parameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t34 = phi { i8**, i64 }* [ %t10, %entry ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t11, %entry ], [ %t33, %loop.latch4 ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  store double %t35, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t14 = extractvalue { %Parameter*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t22 = extractvalue { %Parameter*, i64 } %t21, 0
  %t23 = extractvalue { %Parameter*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Parameter, %Parameter* %t22, i64 %t20
  %t26 = load %Parameter, %Parameter* %t25
  %t27 = call i8* @format_parameter(%Parameter %t26)
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch4
loop.latch4:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_parameter(%Parameter %parameter) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = extractvalue %Parameter %parameter, 3
  %t2 = load i8*, i8** %l0
  br i1 %t1, label %then0, label %else1
then0:
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = extractvalue %Parameter %parameter, 0
  %t5 = add i8* %s3, %t4
  store i8* %t5, i8** %l0
  br label %merge2
else1:
  %t6 = extractvalue %Parameter %parameter, 0
  store i8* %t6, i8** %l0
  br label %merge2
merge2:
  %t7 = phi i8* [ %t5, %then0 ], [ %t6, %else1 ]
  store i8* %t7, i8** %l0
  %t8 = extractvalue %Parameter %parameter, 1
  %t9 = icmp ne i8* %t8, null
  %t10 = load i8*, i8** %l0
  br i1 %t9, label %then3, label %merge4
then3:
  %t11 = load i8*, i8** %l0
  br label %merge4
merge4:
  %t12 = phi i8* [ null, %then3 ], [ %t10, %entry ]
  store i8* %t12, i8** %l0
  %t13 = extractvalue %Parameter %parameter, 2
  %t14 = icmp ne i8* %t13, null
  %t15 = load i8*, i8** %l0
  br i1 %t14, label %then5, label %merge6
then5:
  %t16 = load i8*, i8** %l0
  %s17 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.17, i32 0, i32 0
  %t18 = add i8* %t16, %s17
  %t19 = extractvalue %Parameter %parameter, 2
  %t20 = call i8* @format_expression(%Expression zeroinitializer)
  %t21 = add i8* %t18, %t20
  store i8* %t21, i8** %l0
  br label %merge6
merge6:
  %t22 = phi i8* [ %t21, %then5 ], [ %t15, %entry ]
  store i8* %t22, i8** %l0
  %t23 = load i8*, i8** %l0
  ret i8* %t23
}

define i8* @format_type_parameters({ %TypeParameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %TypeParameter
  %l3 = alloca i8*
  %t0 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t1 = extractvalue { %TypeParameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t49 = phi { i8**, i64 }* [ %t10, %entry ], [ %t47, %loop.latch4 ]
  %t50 = phi double [ %t11, %entry ], [ %t48, %loop.latch4 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  store double %t50, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t14 = extractvalue { %TypeParameter*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load double, double* %l1
  %t20 = load { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %parameters
  %t21 = extractvalue { %TypeParameter*, i64 } %t20, 0
  %t22 = extractvalue { %TypeParameter*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr %TypeParameter, %TypeParameter* %t21, i64 %t19
  %t25 = load %TypeParameter, %TypeParameter* %t24
  store %TypeParameter %t25, %TypeParameter* %l2
  %t26 = load %TypeParameter, %TypeParameter* %l2
  %t27 = extractvalue %TypeParameter %t26, 0
  store i8* %t27, i8** %l3
  %t28 = load %TypeParameter, %TypeParameter* %l2
  %t29 = extractvalue %TypeParameter %t28, 1
  %t30 = icmp ne i8* %t29, null
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load %TypeParameter, %TypeParameter* %l2
  %t34 = load i8*, i8** %l3
  br i1 %t30, label %then8, label %merge9
then8:
  %t35 = load i8*, i8** %l3
  %s36 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.36, i32 0, i32 0
  %t37 = add i8* %t35, %s36
  %t38 = load %TypeParameter, %TypeParameter* %l2
  %t39 = extractvalue %TypeParameter %t38, 1
  br label %merge9
merge9:
  %t40 = phi i8* [ null, %then8 ], [ %t34, %loop.body3 ]
  store i8* %t40, i8** %l3
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l3
  %t43 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t41, i8* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch4
loop.latch4:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  br label %loop.header2
afterloop5:
  ret i8* null
}

define i8* @format_type_annotation(i8* %annotation) {
entry:
  %t0 = icmp eq i8* %annotation, null
  br i1 %t0, label %then0, label %merge1
then0:
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  ret i8* %s1
merge1:
  ret i8* null
}

define i8* @format_initializer(i8* %initializer) {
entry:
  %l0 = alloca i8*
  %t0 = icmp eq i8* %initializer, null
  br i1 %t0, label %then0, label %merge1
then0:
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  ret i8* %s1
merge1:
  %t2 = call i8* @format_expression(%Expression zeroinitializer)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %s4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.4, i32 0, i32 0
  %t5 = load i8*, i8** %l0
  %t6 = add i8* %s4, %t5
  ret i8* %t6
}

define i8* @format_effects({ i8**, i64 }* %effects) {
entry:
  %t0 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.4, i32 0, i32 0
  ret i8* null
}

define i8* @join_type_annotations({ %TypeAnnotation*, i64 }* %values) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t1 = extractvalue { %TypeAnnotation*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t34 = phi { i8**, i64 }* [ %t10, %entry ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t11, %entry ], [ %t33, %loop.latch4 ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  store double %t35, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t14 = extractvalue { %TypeAnnotation*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load { %TypeAnnotation*, i64 }, { %TypeAnnotation*, i64 }* %values
  %t22 = extractvalue { %TypeAnnotation*, i64 } %t21, 0
  %t23 = extractvalue { %TypeAnnotation*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %TypeAnnotation, %TypeAnnotation* %t22, i64 %t20
  %t26 = load %TypeAnnotation, %TypeAnnotation* %t25
  %t27 = extractvalue %TypeAnnotation %t26, 0
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch4
loop.latch4:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_expression(%Expression %expression) {
entry:
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  ret i8* %s0
}

define i8* @format_lambda_expression(%Expression %expression) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.0, i32 0, i32 0
  %t1 = load double, double* %l0
  store i8* null, i8** %l1
  store double 0.0, double* %l2
  %t2 = load i8*, i8** %l1
  %t3 = getelementptr i8, i8* %t2, i64 0
  %t4 = load i8, i8* %t3
  %t5 = add i8 %t4, 32
  %t6 = load double, double* %l2
  ret i8* null
}

define i8* @format_lambda_parameters({ %Parameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %Parameter
  %l3 = alloca i8*
  %l4 = alloca double
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
  %t41 = phi { i8**, i64 }* [ %t6, %entry ], [ %t39, %loop.latch2 ]
  %t42 = phi double [ %t7, %entry ], [ %t40, %loop.latch2 ]
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  store double %t42, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t10 = extractvalue { %Parameter*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %Parameter*, i64 }, { %Parameter*, i64 }* %parameters
  %t17 = extractvalue { %Parameter*, i64 } %t16, 0
  %t18 = extractvalue { %Parameter*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %Parameter, %Parameter* %t17, i64 %t15
  %t21 = load %Parameter, %Parameter* %t20
  store %Parameter %t21, %Parameter* %l2
  %t22 = load %Parameter, %Parameter* %l2
  %t23 = extractvalue %Parameter %t22, 0
  store i8* %t23, i8** %l3
  %t24 = load %Parameter, %Parameter* %l2
  %t25 = extractvalue %Parameter %t24, 1
  %t26 = icmp ne i8* %t25, null
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = load %Parameter, %Parameter* %l2
  %t30 = load i8*, i8** %l3
  br i1 %t26, label %then6, label %merge7
then6:
  %t31 = load i8*, i8** %l3
  br label %merge7
merge7:
  %t32 = phi i8* [ null, %then6 ], [ %t30, %loop.body1 ]
  store i8* %t32, i8** %l3
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load i8*, i8** %l3
  %t35 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t33, i8* %t34)
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch2
loop.latch2:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l4
  %s44 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.44, i32 0, i32 0
  ret i8* %s44
}

define i8* @format_lambda_body(%Block %body) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = extractvalue %Block %body, 2
  %t6 = load { i8**, i64 }, { i8**, i64 }* %t5
  %t7 = extractvalue { i8**, i64 } %t6, 1
  %t8 = icmp eq i64 %t7, 0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t8, label %then0, label %else1
then0:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge2
else1:
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l1
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load double, double* %l1
  br label %loop.header3
loop.header3:
  %t38 = phi { i8**, i64 }* [ %t12, %else1 ], [ %t36, %loop.latch5 ]
  %t39 = phi double [ %t13, %else1 ], [ %t37, %loop.latch5 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
  br label %loop.body4
loop.body4:
  %t14 = load double, double* %l1
  %t15 = extractvalue %Block %body, 2
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t14, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then7, label %merge8
then7:
  br label %afterloop6
merge8:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = extractvalue %Block %body, 2
  %t24 = load double, double* %l1
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call i8* @format_lambda_statement(%Statement zeroinitializer)
  %t32 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch5
loop.latch5:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header3
afterloop6:
  br label %merge2
merge2:
  %t40 = phi { i8**, i64 }* [ null, %then0 ], [ %t32, %else1 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = sitofp i64 1 to double
  %t43 = call { i8**, i64 }* @indent_lines({ i8**, i64 }* %t41, double %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l2
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = call i8* @join_with_separator({ i8**, i64 }* %t45, i8* null)
  %t47 = add i8* %s44, %t46
  %s48 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.48, i32 0, i32 0
  %t49 = add i8* %t47, %s48
  ret i8* %t49
}

define i8* @format_lambda_statement(%Statement %statement) {
entry:
  ret i8* null
}

define { i8**, i64 }* @indent_lines({ i8**, i64 }* %lines, double %depth) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
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
  %t53 = phi { i8**, i64 }* [ %t6, %entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t7, %entry ], [ %t52, %loop.latch2 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  store double %t54, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.15, i32 0, i32 0
  store i8* %s15, i8** %l2
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l3
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t35 = phi i8* [ %t19, %loop.body1 ], [ %t33, %loop.latch8 ]
  %t36 = phi double [ %t20, %loop.body1 ], [ %t34, %loop.latch8 ]
  store i8* %t35, i8** %l2
  store double %t36, double* %l3
  br label %loop.body7
loop.body7:
  %t21 = load double, double* %l3
  %t22 = fcmp oge double %t21, %depth
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load i8*, i8** %l2
  %t26 = load double, double* %l3
  br i1 %t22, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t27 = load i8*, i8** %l2
  %s28 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.28, i32 0, i32 0
  %t29 = add i8* %t27, %s28
  store i8* %t29, i8** %l2
  %t30 = load double, double* %l3
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l3
  br label %loop.latch8
loop.latch8:
  %t33 = load i8*, i8** %l2
  %t34 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load i8*, i8** %l2
  %t39 = load double, double* %l1
  %t40 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t41 = extractvalue { i8**, i64 } %t40, 0
  %t42 = extractvalue { i8**, i64 } %t40, 1
  %t43 = icmp uge i64 %t39, %t42
  ; bounds check: %t43 (if true, out of bounds)
  %t44 = getelementptr i8*, i8** %t41, i64 %t39
  %t45 = load i8*, i8** %t44
  %t46 = add i8* %t38, %t45
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t37, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t55
}

define i8* @quote_string(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  store i8* null, i8** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load i8*, i8** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t15 = phi i8* [ %t1, %entry ], [ %t13, %loop.latch2 ]
  %t16 = phi double [ %t2, %entry ], [ %t14, %loop.latch2 ]
  store i8* %t15, i8** %l0
  store double %t16, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %value, i64 %t5
  %t7 = load i8, i8* %t6
  %t8 = call i8* @escape_string_char(i8* null)
  %t9 = add i8* %t4, %t8
  store i8* %t9, i8** %l0
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch2
loop.latch2:
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t17 = load i8*, i8** %l0
  %t18 = getelementptr i8, i8* %t17, i64 0
  %t19 = load i8, i8* %t18
  %t20 = add i8 %t19, 34
  store i8* null, i8** %l0
  %t21 = load i8*, i8** %l0
  ret i8* %t21
}

define i8* @escape_string_char(i8* %ch) {
entry:
  %t0 = getelementptr i8, i8* %ch, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 34
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = getelementptr i8, i8* %ch, i64 0
  %t5 = load i8, i8* %t4
  %t6 = icmp eq i8 %t5, 92
  br i1 %t6, label %then2, label %merge3
then2:
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  ret i8* %s7
merge3:
  %t8 = getelementptr i8, i8* %ch, i64 0
  %t9 = load i8, i8* %t8
  %t10 = icmp eq i8 %t9, 10
  br i1 %t10, label %then4, label %merge5
then4:
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.11, i32 0, i32 0
  ret i8* %s11
merge5:
  %t12 = getelementptr i8, i8* %ch, i64 0
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 13
  br i1 %t14, label %then6, label %merge7
then6:
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.15, i32 0, i32 0
  ret i8* %s15
merge7:
  %t16 = getelementptr i8, i8* %ch, i64 0
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 9
  br i1 %t18, label %then8, label %merge9
then8:
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.19, i32 0, i32 0
  ret i8* %s19
merge9:
  ret i8* %ch
}

define i8* @format_test_name(i8* %name) {
entry:
  %t0 = call i8* @quote_string(i8* %name)
  ret i8* %t0
}

define i1 @is_identifier(i8* %value) {
entry:
  %l0 = alloca i8
  %l1 = alloca double
  %t0 = getelementptr i8, i8* %value, i64 0
  %t1 = load i8, i8* %t0
  store i8 %t1, i8* %l0
  %t2 = load i8, i8* %l0
  %t3 = call i1 @is_identifier_start(i8* null)
  %t4 = xor i1 %t3, 1
  %t5 = load i8, i8* %l0
  br i1 %t4, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t6 = sitofp i64 1 to double
  store double %t6, double* %l1
  %t7 = load i8, i8* %l0
  %t8 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t21 = phi double [ %t8, %entry ], [ %t20, %loop.latch4 ]
  store double %t21, double* %l1
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l1
  %t10 = load double, double* %l1
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  %t13 = call i1 @is_identifier_part(i8* null)
  %t14 = xor i1 %t13, 1
  %t15 = load i8, i8* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then6, label %merge7
then6:
  ret i1 0
merge7:
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch4
loop.latch4:
  %t20 = load double, double* %l1
  br label %loop.header2
afterloop5:
  ret i1 1
}

define i1 @is_identifier_start(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = getelementptr i8, i8* %ch, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 95
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t3 = call double @char_code(i8* %ch)
  store double %t3, double* %l0
  %t6 = load double, double* %l0
  %t7 = call double @char_code(i8 97)
  %t8 = fcmp oge double %t6, %t7
  br label %logical_and_entry_5

logical_and_entry_5:
  br i1 %t8, label %logical_and_right_5, label %logical_and_merge_5

logical_and_right_5:
  %t9 = load double, double* %l0
  %t10 = call double @char_code(i8 122)
  %t11 = fcmp ole double %t9, %t10
  br label %logical_and_right_end_5

logical_and_right_end_5:
  br label %logical_and_merge_5

logical_and_merge_5:
  %t12 = phi i1 [ false, %logical_and_entry_5 ], [ %t11, %logical_and_right_end_5 ]
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t12, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t14 = load double, double* %l0
  %t15 = call double @char_code(i8 65)
  %t16 = fcmp oge double %t14, %t15
  br label %logical_and_entry_13

logical_and_entry_13:
  br i1 %t16, label %logical_and_right_13, label %logical_and_merge_13

logical_and_right_13:
  %t17 = load double, double* %l0
  %t18 = call double @char_code(i8 90)
  %t19 = fcmp ole double %t17, %t18
  br label %logical_and_right_end_13

logical_and_right_end_13:
  br label %logical_and_merge_13

logical_and_merge_13:
  %t20 = phi i1 [ false, %logical_and_entry_13 ], [ %t19, %logical_and_right_end_13 ]
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t21 = phi i1 [ true, %logical_or_entry_4 ], [ %t20, %logical_or_right_end_4 ]
  ret i1 %t21
}

define i1 @is_identifier_part(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call i1 @is_identifier_start(i8* %ch)
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t1 = call double @char_code(i8* %ch)
  store double %t1, double* %l0
  %t3 = load double, double* %l0
  %t4 = call double @char_code(i8 48)
  %t5 = fcmp oge double %t3, %t4
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t5, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t6 = load double, double* %l0
  %t7 = call double @char_code(i8 57)
  %t8 = fcmp ole double %t6, %t7
  br label %logical_and_right_end_2

logical_and_right_end_2:
  br label %logical_and_merge_2

logical_and_merge_2:
  %t9 = phi i1 [ false, %logical_and_entry_2 ], [ %t8, %logical_and_right_end_2 ]
  ret i1 %t9
}

define i8* @trim_block_body(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  %t6 = icmp eq i8 %t5, 123
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t6, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t7 = load i8*, i8** %l0
  ret i8* %t7
}

define i8* @collapse_whitespace(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i8
  %l4 = alloca i1
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  store i1 0, i1* %l2
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  %t4 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  %t55 = phi i8* [ %t2, %entry ], [ %t52, %loop.latch2 ]
  %t56 = phi i1 [ %t4, %entry ], [ %t53, %loop.latch2 ]
  %t57 = phi double [ %t3, %entry ], [ %t54, %loop.latch2 ]
  store i8* %t55, i8** %l0
  store i1 %t56, i1* %l2
  store double %t57, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %value, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l3
  %t12 = load i8, i8* %l3
  %t13 = icmp eq i8 %t12, 32
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t13, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t14 = load i8, i8* %l3
  %t15 = icmp eq i8 %t14, 10
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t16 = phi i1 [ true, %logical_or_entry_11 ], [ %t15, %logical_or_right_end_11 ]
  br label %logical_or_entry_10

logical_or_entry_10:
  br i1 %t16, label %logical_or_merge_10, label %logical_or_right_10

logical_or_right_10:
  %t17 = load i8, i8* %l3
  %t18 = icmp eq i8 %t17, 13
  br label %logical_or_right_end_10

logical_or_right_end_10:
  br label %logical_or_merge_10

logical_or_merge_10:
  %t19 = phi i1 [ true, %logical_or_entry_10 ], [ %t18, %logical_or_right_end_10 ]
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t19, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %t20 = load i8, i8* %l3
  %t21 = icmp eq i8 %t20, 9
  br label %logical_or_right_end_9

logical_or_right_end_9:
  br label %logical_or_merge_9

logical_or_merge_9:
  %t22 = phi i1 [ true, %logical_or_entry_9 ], [ %t21, %logical_or_right_end_9 ]
  store i1 %t22, i1* %l4
  %t23 = load i1, i1* %l4
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load i1, i1* %l2
  %t27 = load i8, i8* %l3
  %t28 = load i1, i1* %l4
  br i1 %t23, label %then4, label %else5
then4:
  %t29 = load i1, i1* %l2
  %t30 = xor i1 %t29, 1
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load i1, i1* %l2
  %t34 = load i8, i8* %l3
  %t35 = load i1, i1* %l4
  br i1 %t30, label %then7, label %merge8
then7:
  %t36 = load i8*, i8** %l0
  %t37 = getelementptr i8, i8* %t36, i64 0
  %t38 = load i8, i8* %t37
  %t39 = add i8 %t38, 32
  store i8* null, i8** %l0
  store i1 1, i1* %l2
  br label %merge8
merge8:
  %t40 = phi i8* [ null, %then7 ], [ %t31, %then4 ]
  %t41 = phi i1 [ 1, %then7 ], [ %t33, %then4 ]
  store i8* %t40, i8** %l0
  store i1 %t41, i1* %l2
  br label %merge6
else5:
  %t42 = load i8*, i8** %l0
  %t43 = load i8, i8* %l3
  %t44 = getelementptr i8, i8* %t42, i64 0
  %t45 = load i8, i8* %t44
  %t46 = add i8 %t45, %t43
  store i8* null, i8** %l0
  store i1 0, i1* %l2
  br label %merge6
merge6:
  %t47 = phi i8* [ null, %then4 ], [ null, %else5 ]
  %t48 = phi i1 [ 1, %then4 ], [ 0, %else5 ]
  store i8* %t47, i8** %l0
  store i1 %t48, i1* %l2
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch2
loop.latch2:
  %t52 = load i8*, i8** %l0
  %t53 = load i1, i1* %l2
  %t54 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t58 = load i8*, i8** %l0
  %t59 = call i8* @trim_text(i8* %t58)
  ret i8* %t59
}

define i8* @tokens_to_source({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t1 = extractvalue { %Token*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t34 = phi { i8**, i64 }* [ %t10, %entry ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t11, %entry ], [ %t33, %loop.latch4 ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  store double %t35, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t14 = extractvalue { %Token*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t22 = extractvalue { %Token*, i64 } %t21, 0
  %t23 = extractvalue { %Token*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %Token, %Token* %t22, i64 %t20
  %t26 = load %Token, %Token* %t25
  %t27 = extractvalue %Token %t26, 1
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch4
loop.latch4:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s37 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.37, i32 0, i32 0
  %t38 = call i8* @join_with_separator({ i8**, i64 }* %t36, i8* %s37)
  %t39 = call i8* @collapse_whitespace(i8* %t38)
  ret i8* %t39
}

define %TextBuilder @builder_new() {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %TextBuilder undef, { i8**, i64 }* null, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %TextBuilder %t5, double %t6, 1
  ret %TextBuilder %t7
}

define %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %line) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t17 = phi i8* [ %t2, %entry ], [ %t15, %loop.latch2 ]
  %t18 = phi double [ %t3, %entry ], [ %t16, %loop.latch2 ]
  store i8* %t17, i8** %l0
  store double %t18, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = extractvalue %TextBuilder %builder, 1
  %t6 = fcmp oge double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %s10 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %t9, %s10
  store i8* %t11, i8** %l0
  %t12 = load double, double* %l1
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l1
  br label %loop.latch2
loop.latch2:
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = load i8*, i8** %l0
  %t20 = call i8* @trim_right(i8* %line)
  %t21 = add i8* %t19, %t20
  store i8* %t21, i8** %l2
  %t22 = extractvalue %TextBuilder %builder, 0
  %t23 = load i8*, i8** %l2
  %t24 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l3
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t26 = insertvalue %TextBuilder undef, { i8**, i64 }* %t25, 0
  %t27 = extractvalue %TextBuilder %builder, 1
  %t28 = insertvalue %TextBuilder %t26, double %t27, 1
  ret %TextBuilder %t28
}

define %TextBuilder @builder_emit_blank(%TextBuilder %builder) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %TextBuilder %builder, 0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  %t2 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %s1)
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t4 = insertvalue %TextBuilder undef, { i8**, i64 }* %t3, 0
  %t5 = extractvalue %TextBuilder %builder, 1
  %t6 = insertvalue %TextBuilder %t4, double %t5, 1
  ret %TextBuilder %t6
}

define %TextBuilder @builder_push_indent(%TextBuilder %builder) {
entry:
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @builder_pop_indent(%TextBuilder %builder) {
entry:
  %l0 = alloca double
  %t0 = extractvalue %TextBuilder %builder, 1
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ogt double %t1, %t2
  %t4 = load double, double* %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load double, double* %l0
  %t6 = sitofp i64 1 to double
  %t7 = fsub double %t5, %t6
  store double %t7, double* %l0
  br label %merge1
merge1:
  %t8 = phi double [ %t7, %then0 ], [ %t4, %entry ]
  store double %t8, double* %l0
  %t9 = extractvalue %TextBuilder %builder, 0
  %t10 = insertvalue %TextBuilder undef, { i8**, i64 }* %t9, 0
  %t11 = load double, double* %l0
  %t12 = insertvalue %TextBuilder %t10, double %t11, 1
  ret %TextBuilder %t12
}

define i8* @builder_to_string(%TextBuilder %builder) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %TextBuilder %builder, 0
  %t1 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* null)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  %t6 = add i8 %t5, 10
  ret i8* null
}

define i8* @trim_right(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ole double %t1, %t2
  %t4 = load double, double* %l0
  br i1 %t3, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  store double 0.0, double* %l1
  %t6 = load double, double* %l1
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t7 = load double, double* %l0
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = call i8* @sailfin_runtime_substring(i8* %value, i64 0, i64 %t9)
  ret i8* %t10
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

define i8* @join_with_separator({ i8**, i64 }* %values, i8* %separator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %values
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %values
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
  %t14 = load { i8**, i64 }, { i8**, i64 }* %values
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
  %t23 = load { i8**, i64 }, { i8**, i64 }* %values
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

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t20 = phi double [ %t1, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l0
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
  store i8 %t10, i8* %l2
  %t11 = load i8, i8* %l2
  %t12 = call i1 @is_trim_char(i8* null)
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then6, label %merge7
then6:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t19 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t37 = phi double [ %t22, %entry ], [ %t36, %loop.latch10 ]
  store double %t37, double* %l1
  br label %loop.body9
loop.body9:
  %t23 = load double, double* %l1
  %t24 = load double, double* %l0
  %t25 = fcmp ole double %t23, %t24
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  br i1 %t25, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = call i1 @is_trim_char(i8* null)
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l3
  br i1 %t29, label %then14, label %merge15
then14:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t36 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t39 = load double, double* %l0
  %t40 = sitofp i64 0 to double
  %t41 = fcmp oeq double %t39, %t40
  br label %logical_and_entry_38

logical_and_entry_38:
  br i1 %t41, label %logical_and_right_38, label %logical_and_merge_38

logical_and_right_38:
  %t42 = load double, double* %l1
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = fptosi double %t43 to i64
  %t46 = fptosi double %t44 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t45, i64 %t46)
  ret i8* %t47
}

define i1 @is_trim_char(i8* %ch) {
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
  %t12 = icmp eq i8 %t11, 13
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
  %t16 = icmp eq i8 %t15, 9
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t17 = phi i1 [ true, %logical_or_entry_0 ], [ %t16, %logical_or_right_end_0 ]
  ret i1 %t17
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
