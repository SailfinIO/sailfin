; ModuleID = 'sailfin'
source_filename = "sailfin"

%DecoratorArgumentInfo = type { i8*, i8* }
%DecoratorInfo = type { i8*, { i8**, i64 }* }
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

%LiteralValue = type { i32, [8 x i8] }
%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i1 @sailfin_runtime_is_whitespace_char(i8)
declare i1 @sailfin_runtime_is_decimal_digit(i8)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@.str.2 = private unnamed_addr constant [3 x i8] c"io\00"

define { i8**, i64 }* @infer_effects({ i8**, i64 }* %existing, { %DecoratorInfo*, i64 }* %decorators) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca %DecoratorInfo
  %t0 = call { i8**, i64 }* @clone_effects({ i8**, i64 }* %existing)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @contains_effect({ i8**, i64 }* %t1, i8* %s2)
  store i1 %t3, i1* %l1
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l2
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load i1, i1* %l1
  %t7 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t49 = phi i1 [ %t6, %entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t7, %entry ], [ %t48, %loop.latch2 ]
  store i1 %t49, i1* %l1
  store double %t50, double* %l2
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l2
  %t9 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %decorators
  %t10 = extractvalue { %DecoratorInfo*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load i1, i1* %l1
  %t15 = load double, double* %l2
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = load double, double* %l2
  %t17 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %decorators
  %t18 = extractvalue { %DecoratorInfo*, i64 } %t17, 0
  %t19 = extractvalue { %DecoratorInfo*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %DecoratorInfo, %DecoratorInfo* %t18, i64 %t16
  %t22 = load %DecoratorInfo, %DecoratorInfo* %t21
  store %DecoratorInfo %t22, %DecoratorInfo* %l3
  %t25 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t26 = extractvalue %DecoratorInfo %t25, 0
  %s27 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.27, i32 0, i32 0
  %t28 = icmp eq i8* %t26, %s27
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t28, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t29 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t30 = extractvalue %DecoratorInfo %t29, 0
  %s31 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.31, i32 0, i32 0
  %t32 = icmp eq i8* %t30, %s31
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t33 = phi i1 [ true, %logical_or_entry_24 ], [ %t32, %logical_or_right_end_24 ]
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t33, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %t34 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t35 = extractvalue %DecoratorInfo %t34, 0
  %s36 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.36, i32 0, i32 0
  %t37 = icmp eq i8* %t35, %s36
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t38 = phi i1 [ true, %logical_or_entry_23 ], [ %t37, %logical_or_right_end_23 ]
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i1, i1* %l1
  %t41 = load double, double* %l2
  %t42 = load %DecoratorInfo, %DecoratorInfo* %l3
  br i1 %t38, label %then6, label %merge7
then6:
  store i1 1, i1* %l1
  br label %merge7
merge7:
  %t43 = phi i1 [ 1, %then6 ], [ %t40, %loop.body1 ]
  store i1 %t43, i1* %l1
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l2
  br label %loop.latch2
loop.latch2:
  %t47 = load i1, i1* %l1
  %t48 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t52 = load i1, i1* %l1
  br label %logical_and_entry_51

logical_and_entry_51:
  br i1 %t52, label %logical_and_right_51, label %logical_and_merge_51

logical_and_right_51:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s54 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.54, i32 0, i32 0
  %t55 = call i1 @contains_effect({ i8**, i64 }* %t53, i8* %s54)
  %t56 = xor i1 %t55, 1
  br label %logical_and_right_end_51

logical_and_right_end_51:
  br label %logical_and_merge_51

logical_and_merge_51:
  %t57 = phi i1 [ false, %logical_and_entry_51 ], [ %t56, %logical_and_right_end_51 ]
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load i1, i1* %l1
  %t60 = load double, double* %l2
  br i1 %t57, label %then8, label %merge9
then8:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s62 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.62, i32 0, i32 0
  %t63 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t61, i8* %s62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t64 = phi { i8**, i64 }* [ %t63, %then8 ], [ %t58, %entry ]
  store { i8**, i64 }* %t64, { i8**, i64 }** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t65
}

define { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* %decorators) {
entry:
  %l0 = alloca { %DecoratorInfo*, i64 }*
  %l1 = alloca double
  %l2 = alloca %Decorator
  %l3 = alloca { %DecoratorArgumentInfo*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %DecoratorInfo*, i64 }* null, { %DecoratorInfo*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t30 = phi { %DecoratorInfo*, i64 }* [ %t6, %entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t7, %entry ], [ %t29, %loop.latch2 ]
  store { %DecoratorInfo*, i64 }* %t30, { %DecoratorInfo*, i64 }** %l0
  store double %t31, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t10 = extractvalue { %Decorator*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t17 = extractvalue { %Decorator*, i64 } %t16, 0
  %t18 = extractvalue { %Decorator*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %Decorator, %Decorator* %t17, i64 %t15
  %t21 = load %Decorator, %Decorator* %t20
  store %Decorator %t21, %Decorator* %l2
  %t22 = load %Decorator, %Decorator* %l2
  %t23 = extractvalue %Decorator %t22, 1
  %t24 = call { %DecoratorArgumentInfo*, i64 }* @evaluate_arguments({ %DecoratorArgument*, i64 }* null)
  store { %DecoratorArgumentInfo*, i64 }* %t24, { %DecoratorArgumentInfo*, i64 }** %l3
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch2
loop.latch2:
  %t28 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  ret { %DecoratorInfo*, i64 }* %t32
}

define { %DecoratorArgumentInfo*, i64 }* @evaluate_arguments({ %DecoratorArgument*, i64 }* %arguments) {
entry:
  %l0 = alloca { %DecoratorArgumentInfo*, i64 }*
  %l1 = alloca double
  %l2 = alloca %DecoratorArgument
  %l3 = alloca %LiteralValue
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %DecoratorArgumentInfo*, i64 }* null, { %DecoratorArgumentInfo*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t30 = phi { %DecoratorArgumentInfo*, i64 }* [ %t6, %entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t7, %entry ], [ %t29, %loop.latch2 ]
  store { %DecoratorArgumentInfo*, i64 }* %t30, { %DecoratorArgumentInfo*, i64 }** %l0
  store double %t31, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %arguments
  %t10 = extractvalue { %DecoratorArgument*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %arguments
  %t17 = extractvalue { %DecoratorArgument*, i64 } %t16, 0
  %t18 = extractvalue { %DecoratorArgument*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %DecoratorArgument, %DecoratorArgument* %t17, i64 %t15
  %t21 = load %DecoratorArgument, %DecoratorArgument* %t20
  store %DecoratorArgument %t21, %DecoratorArgument* %l2
  %t22 = load %DecoratorArgument, %DecoratorArgument* %l2
  %t23 = extractvalue %DecoratorArgument %t22, 1
  %t24 = call %LiteralValue @evaluate_expression(%Expression zeroinitializer)
  store %LiteralValue %t24, %LiteralValue* %l3
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch2
loop.latch2:
  %t28 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  ret { %DecoratorArgumentInfo*, i64 }* %t32
}

define %LiteralValue @evaluate_expression(%Expression %expr) {
entry:
  %t0 = call double @LiteralValueUnsupported()
  ret %LiteralValue zeroinitializer
}

define { %DecoratorInfo*, i64 }* @evaluate_statement_decorators(%Statement %statement) {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  ret { %DecoratorInfo*, i64 }* null
}

define i8* @trim_whitespace(i8* %value) {
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
  %t12 = call i1 @sailfin_runtime_is_whitespace_char(i8* null)
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
  %t29 = call i1 @sailfin_runtime_is_whitespace_char(i8* null)
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
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  %t40 = call i8* @slice_text(i8* %value, double %t38, double %t39)
  ret i8* %t40
}

define i1 @looks_like_quoted_string(i8* %text) {
entry:
  %t0 = getelementptr i8, i8* %text, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp ne i8 %t1, 34
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  ret i1 1
}

define i1 @looks_like_number(i8* %text) {
entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca i8
  store i1 0, i1* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = getelementptr i8, i8* %text, i64 0
  %t2 = load i8, i8* %t1
  %t3 = load i1, i1* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t32 = phi i1 [ %t3, %entry ], [ %t30, %loop.latch2 ]
  %t33 = phi double [ %t4, %entry ], [ %t31, %loop.latch2 ]
  store i1 %t32, i1* %l0
  store double %t33, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %text, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l2
  %t9 = load i8, i8* %l2
  %t10 = icmp eq i8 %t9, 46
  %t11 = load i1, i1* %l0
  %t12 = load double, double* %l1
  %t13 = load i8, i8* %l2
  br i1 %t10, label %then4, label %merge5
then4:
  %t14 = load i1, i1* %l0
  %t15 = load i1, i1* %l0
  %t16 = load double, double* %l1
  %t17 = load i8, i8* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  ret i1 0
merge7:
  store i1 1, i1* %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch2
merge5:
  %t21 = load i8, i8* %l2
  %t22 = call i1 @sailfin_runtime_is_decimal_digit(i8* null)
  %t23 = xor i1 %t22, 1
  %t24 = load i1, i1* %l0
  %t25 = load double, double* %l1
  %t26 = load i8, i8* %l2
  br i1 %t23, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l1
  br label %loop.latch2
loop.latch2:
  %t30 = load i1, i1* %l0
  %t31 = load double, double* %l1
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @is_decimal_digit(i8* %ch) {
entry:
  %t9 = getelementptr i8, i8* %ch, i64 0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 48
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t11, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t12 = getelementptr i8, i8* %ch, i64 0
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 49
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t15 = phi i1 [ true, %logical_or_entry_8 ], [ %t14, %logical_or_right_end_8 ]
  br label %logical_or_entry_7

logical_or_entry_7:
  br i1 %t15, label %logical_or_merge_7, label %logical_or_right_7

logical_or_right_7:
  %t16 = getelementptr i8, i8* %ch, i64 0
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 50
  br label %logical_or_right_end_7

logical_or_right_end_7:
  br label %logical_or_merge_7

logical_or_merge_7:
  %t19 = phi i1 [ true, %logical_or_entry_7 ], [ %t18, %logical_or_right_end_7 ]
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t19, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t20 = getelementptr i8, i8* %ch, i64 0
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 51
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t23 = phi i1 [ true, %logical_or_entry_6 ], [ %t22, %logical_or_right_end_6 ]
  br label %logical_or_entry_5

logical_or_entry_5:
  br i1 %t23, label %logical_or_merge_5, label %logical_or_right_5

logical_or_right_5:
  %t24 = getelementptr i8, i8* %ch, i64 0
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 52
  br label %logical_or_right_end_5

logical_or_right_end_5:
  br label %logical_or_merge_5

logical_or_merge_5:
  %t27 = phi i1 [ true, %logical_or_entry_5 ], [ %t26, %logical_or_right_end_5 ]
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t27, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t28 = getelementptr i8, i8* %ch, i64 0
  %t29 = load i8, i8* %t28
  %t30 = icmp eq i8 %t29, 53
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t31 = phi i1 [ true, %logical_or_entry_4 ], [ %t30, %logical_or_right_end_4 ]
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t31, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t32 = getelementptr i8, i8* %ch, i64 0
  %t33 = load i8, i8* %t32
  %t34 = icmp eq i8 %t33, 54
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t35 = phi i1 [ true, %logical_or_entry_3 ], [ %t34, %logical_or_right_end_3 ]
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t35, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t36 = getelementptr i8, i8* %ch, i64 0
  %t37 = load i8, i8* %t36
  %t38 = icmp eq i8 %t37, 55
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t39 = phi i1 [ true, %logical_or_entry_2 ], [ %t38, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t39, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t40 = getelementptr i8, i8* %ch, i64 0
  %t41 = load i8, i8* %t40
  %t42 = icmp eq i8 %t41, 56
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t43 = phi i1 [ true, %logical_or_entry_1 ], [ %t42, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t43, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t44 = getelementptr i8, i8* %ch, i64 0
  %t45 = load i8, i8* %t44
  %t46 = icmp eq i8 %t45, 57
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t47 = phi i1 [ true, %logical_or_entry_0 ], [ %t46, %logical_or_right_end_0 ]
  ret i1 %t47
}

define { %DecoratorInfo*, i64 }* @append_decorator_info({ %DecoratorInfo*, i64 }* %collection, %DecoratorInfo %item) {
entry:
  %t0 = alloca [1 x %DecoratorInfo]
  %t1 = getelementptr [1 x %DecoratorInfo], [1 x %DecoratorInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %DecoratorInfo, %DecoratorInfo* %t1, i64 0
  store %DecoratorInfo %item, %DecoratorInfo* %t2
  %t3 = alloca { %DecoratorInfo*, i64 }
  %t4 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t3, i32 0, i32 0
  store %DecoratorInfo* %t1, %DecoratorInfo** %t4
  %t5 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ %DecoratorInfo*, i64 }* %t3)
  ret { %DecoratorInfo*, i64 }* null
}

define { %DecoratorArgumentInfo*, i64 }* @append_argument_info({ %DecoratorArgumentInfo*, i64 }* %collection, %DecoratorArgumentInfo %item) {
entry:
  %t0 = alloca [1 x %DecoratorArgumentInfo]
  %t1 = getelementptr [1 x %DecoratorArgumentInfo], [1 x %DecoratorArgumentInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %DecoratorArgumentInfo, %DecoratorArgumentInfo* %t1, i64 0
  store %DecoratorArgumentInfo %item, %DecoratorArgumentInfo* %t2
  %t3 = alloca { %DecoratorArgumentInfo*, i64 }
  %t4 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t3, i32 0, i32 0
  store %DecoratorArgumentInfo* %t1, %DecoratorArgumentInfo** %t4
  %t5 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ %DecoratorArgumentInfo*, i64 }* %t3)
  ret { %DecoratorArgumentInfo*, i64 }* null
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %collection, i8* %item) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %item, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @clone_effects({ i8**, i64 }* %effects) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %t29 = phi { i8**, i64 }* [ %t6, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t7, %entry ], [ %t28, %loop.latch2 ]
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t31
}

define i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t21 = phi double [ %t1, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t4 = extractvalue { i8**, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = icmp eq i8* %t14, %effect
  %t16 = load double, double* %l0
  br i1 %t15, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define i1 @is_whitespace_char(i8* %ch) {
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
  %t8 = icmp eq i8 %t7, 9
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
  %t12 = icmp eq i8 %t11, 10
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

define i8* @slice_text(i8* %text, double %start, double %end) {
entry:
  %t0 = fptosi double %start to i64
  %t1 = fptosi double %end to i64
  %t2 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t0, i64 %t1)
  ret i8* %t2
}

define i8* @strip_surrounding_quotes(i8* %value) {
entry:
  ret i8* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
