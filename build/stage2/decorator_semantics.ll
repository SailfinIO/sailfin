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
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = extractvalue %Expression %expr, 0
  %t1 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t2 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t3 = icmp eq i32 %t0, 0
  %t4 = select i1 %t3, i8* %t2, i8* %t1
  %t5 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t0, 1
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t0, 2
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t0, 3
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t0, 4
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t0, 5
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t0, 6
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t0, 7
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t0, 8
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t0, 9
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t0, 10
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t0, 11
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t0, 12
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t0, 13
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t0, 14
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t0, 15
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br i1 %t51, label %then0, label %merge1
then0:
  %t52 = alloca %LiteralValue
  %t53 = getelementptr inbounds %LiteralValue, %LiteralValue* %t52, i32 0, i32 0
  store i32 0, i32* %t53
  %t54 = extractvalue %Expression %expr, 0
  %t55 = alloca %Expression
  store %Expression %expr, %Expression* %t55
  %t56 = getelementptr inbounds %Expression, %Expression* %t55, i32 0, i32 1
  %t57 = bitcast [8 x i8]* %t56 to i8*
  %t58 = bitcast i8* %t57 to i8**
  %t59 = load i8*, i8** %t58
  %t60 = icmp eq i32 %t54, 1
  %t61 = select i1 %t60, i8* %t59, i8* null
  %t62 = getelementptr inbounds %Expression, %Expression* %t55, i32 0, i32 1
  %t63 = bitcast [8 x i8]* %t62 to i8*
  %t64 = bitcast i8* %t63 to i8**
  %t65 = load i8*, i8** %t64
  %t66 = icmp eq i32 %t54, 2
  %t67 = select i1 %t66, i8* %t65, i8* %t61
  %t68 = getelementptr inbounds %LiteralValue, %LiteralValue* %t52, i32 0, i32 1
  %t69 = bitcast [8 x i8]* %t68 to i8*
  %t70 = bitcast i8* %t69 to i8**
  store i8* %t67, i8** %t70
  %t71 = load %LiteralValue, %LiteralValue* %t52
  ret %LiteralValue %t71
merge1:
  %t72 = extractvalue %Expression %expr, 0
  %t73 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t74 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t72, 0
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t72, 1
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t72, 2
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t72, 3
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t72, 4
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t72, 5
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t72, 6
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t72, 7
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t72, 8
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t72, 9
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t72, 10
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t72, 11
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t72, 12
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t72, 13
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t72, 14
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t72, 15
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %s122 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.122, i32 0, i32 0
  %t123 = icmp eq i8* %t121, %s122
  br i1 %t123, label %then2, label %merge3
then2:
  %t124 = alloca %LiteralValue
  %t125 = getelementptr inbounds %LiteralValue, %LiteralValue* %t124, i32 0, i32 0
  store i32 1, i32* %t125
  %t126 = extractvalue %Expression %expr, 0
  %t127 = alloca %Expression
  store %Expression %expr, %Expression* %t127
  %t128 = getelementptr inbounds %Expression, %Expression* %t127, i32 0, i32 1
  %t129 = bitcast [1 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i1*
  %t131 = load i1, i1* %t130
  %t132 = icmp eq i32 %t126, 3
  %t133 = select i1 %t132, i1 %t131, i1 false
  %t134 = getelementptr inbounds %LiteralValue, %LiteralValue* %t124, i32 0, i32 1
  %t135 = bitcast [1 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i1*
  store i1 %t133, i1* %t136
  %t137 = load %LiteralValue, %LiteralValue* %t124
  ret %LiteralValue %t137
merge3:
  %t138 = extractvalue %Expression %expr, 0
  %t139 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t140 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t138, 0
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t138, 1
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t138, 2
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t138, 3
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t138, 4
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t138, 5
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t138, 6
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t138, 7
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t138, 8
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t138, 9
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t138, 10
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t138, 11
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t138, 12
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t138, 13
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t138, 14
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t138, 15
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %s188 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.188, i32 0, i32 0
  %t189 = icmp eq i8* %t187, %s188
  br i1 %t189, label %then4, label %merge5
then4:
  %t190 = alloca %LiteralValue
  %t191 = getelementptr inbounds %LiteralValue, %LiteralValue* %t190, i32 0, i32 0
  store i32 2, i32* %t191
  %t192 = extractvalue %Expression %expr, 0
  %t193 = alloca %Expression
  store %Expression %expr, %Expression* %t193
  %t194 = getelementptr inbounds %Expression, %Expression* %t193, i32 0, i32 1
  %t195 = bitcast [8 x i8]* %t194 to i8*
  %t196 = bitcast i8* %t195 to i8**
  %t197 = load i8*, i8** %t196
  %t198 = icmp eq i32 %t192, 1
  %t199 = select i1 %t198, i8* %t197, i8* null
  %t200 = getelementptr inbounds %Expression, %Expression* %t193, i32 0, i32 1
  %t201 = bitcast [8 x i8]* %t200 to i8*
  %t202 = bitcast i8* %t201 to i8**
  %t203 = load i8*, i8** %t202
  %t204 = icmp eq i32 %t192, 2
  %t205 = select i1 %t204, i8* %t203, i8* %t199
  %t206 = getelementptr inbounds %LiteralValue, %LiteralValue* %t190, i32 0, i32 1
  %t207 = bitcast [8 x i8]* %t206 to i8*
  %t208 = bitcast i8* %t207 to i8**
  store i8* %t205, i8** %t208
  %t209 = load %LiteralValue, %LiteralValue* %t190
  ret %LiteralValue %t209
merge5:
  %t210 = extractvalue %Expression %expr, 0
  %t211 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t212 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t210, 0
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t210, 1
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t210, 2
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t210, 3
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t210, 4
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t210, 5
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t210, 6
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t210, 7
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t210, 8
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t210, 9
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t210, 10
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t210, 11
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t210, 12
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t210, 13
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t210, 14
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t210, 15
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %s260 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.260, i32 0, i32 0
  %t261 = icmp eq i8* %t259, %s260
  br i1 %t261, label %then6, label %merge7
then6:
  %t262 = call double @LiteralValueNull()
  ret %LiteralValue zeroinitializer
merge7:
  %t263 = extractvalue %Expression %expr, 0
  %t264 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t265 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t263, 0
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t263, 1
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t263, 2
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t263, 3
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t263, 4
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t263, 5
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t263, 6
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t263, 7
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t263, 8
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t263, 9
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t263, 10
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t263, 11
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t263, 12
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t263, 13
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t263, 14
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %t310 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t263, 15
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %s313 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.313, i32 0, i32 0
  %t314 = icmp eq i8* %t312, %s313
  br i1 %t314, label %then8, label %merge9
then8:
  %t315 = extractvalue %Expression %expr, 0
  %t316 = alloca %Expression
  store %Expression %expr, %Expression* %t316
  %t317 = getelementptr inbounds %Expression, %Expression* %t316, i32 0, i32 1
  %t318 = bitcast [8 x i8]* %t317 to i8*
  %t319 = bitcast i8* %t318 to i8**
  %t320 = load i8*, i8** %t319
  %t321 = icmp eq i32 %t315, 15
  %t322 = select i1 %t321, i8* %t320, i8* null
  %t323 = call i8* @trim_whitespace(i8* %t322)
  store i8* %t323, i8** %l0
  %t324 = load i8*, i8** %l0
  %t325 = load i8*, i8** %l0
  %t326 = call i1 @looks_like_quoted_string(i8* %t325)
  %t327 = load i8*, i8** %l0
  br i1 %t326, label %then10, label %merge11
then10:
  %t328 = load i8*, i8** %l0
  %t329 = call i8* @strip_surrounding_quotes(i8* %t328)
  store i8* %t329, i8** %l1
  %t330 = alloca %LiteralValue
  %t331 = getelementptr inbounds %LiteralValue, %LiteralValue* %t330, i32 0, i32 0
  store i32 0, i32* %t331
  %t332 = load i8*, i8** %l1
  %t333 = getelementptr inbounds %LiteralValue, %LiteralValue* %t330, i32 0, i32 1
  %t334 = bitcast [8 x i8]* %t333 to i8*
  %t335 = bitcast i8* %t334 to i8**
  store i8* %t332, i8** %t335
  %t336 = load %LiteralValue, %LiteralValue* %t330
  ret %LiteralValue %t336
merge11:
  %t337 = load i8*, i8** %l0
  %s338 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.338, i32 0, i32 0
  %t339 = icmp eq i8* %t337, %s338
  %t340 = load i8*, i8** %l0
  br i1 %t339, label %then12, label %merge13
then12:
  %t341 = alloca %LiteralValue
  %t342 = getelementptr inbounds %LiteralValue, %LiteralValue* %t341, i32 0, i32 0
  store i32 1, i32* %t342
  %t343 = getelementptr inbounds %LiteralValue, %LiteralValue* %t341, i32 0, i32 1
  %t344 = bitcast [1 x i8]* %t343 to i8*
  %t345 = bitcast i8* %t344 to i1*
  store i1 1, i1* %t345
  %t346 = load %LiteralValue, %LiteralValue* %t341
  ret %LiteralValue %t346
merge13:
  %t347 = load i8*, i8** %l0
  %s348 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.348, i32 0, i32 0
  %t349 = icmp eq i8* %t347, %s348
  %t350 = load i8*, i8** %l0
  br i1 %t349, label %then14, label %merge15
then14:
  %t351 = alloca %LiteralValue
  %t352 = getelementptr inbounds %LiteralValue, %LiteralValue* %t351, i32 0, i32 0
  store i32 1, i32* %t352
  %t353 = getelementptr inbounds %LiteralValue, %LiteralValue* %t351, i32 0, i32 1
  %t354 = bitcast [1 x i8]* %t353 to i8*
  %t355 = bitcast i8* %t354 to i1*
  store i1 0, i1* %t355
  %t356 = load %LiteralValue, %LiteralValue* %t351
  ret %LiteralValue %t356
merge15:
  %t357 = load i8*, i8** %l0
  %t358 = call i1 @looks_like_number(i8* %t357)
  %t359 = load i8*, i8** %l0
  br i1 %t358, label %then16, label %merge17
then16:
  %t360 = alloca %LiteralValue
  %t361 = getelementptr inbounds %LiteralValue, %LiteralValue* %t360, i32 0, i32 0
  store i32 2, i32* %t361
  %t362 = load i8*, i8** %l0
  %t363 = getelementptr inbounds %LiteralValue, %LiteralValue* %t360, i32 0, i32 1
  %t364 = bitcast [8 x i8]* %t363 to i8*
  %t365 = bitcast i8* %t364 to i8**
  store i8* %t362, i8** %t365
  %t366 = load %LiteralValue, %LiteralValue* %t360
  ret %LiteralValue %t366
merge17:
  br label %merge9
merge9:
  %t367 = call double @LiteralValueUnsupported()
  ret %LiteralValue zeroinitializer
}

define { %DecoratorInfo*, i64 }* @evaluate_statement_decorators(%Statement %statement) {
entry:
  %t0 = extractvalue %Statement %statement, 0
  %t1 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t3 = icmp eq i32 %t0, 0
  %t4 = select i1 %t3, i8* %t2, i8* %t1
  %t5 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t0, 1
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t0, 2
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t0, 3
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t0, 4
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t0, 5
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t0, 6
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t0, 7
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t0, 8
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t0, 9
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t0, 10
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t0, 11
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t0, 12
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t0, 13
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t0, 14
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t0, 15
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t0, 16
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t0, 17
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t0, 18
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t0, 19
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t0, 20
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t0, 21
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t0, 22
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.71, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [48 x i8]* %t75 to i8*
  %t77 = getelementptr inbounds i8, i8* %t76, i64 40
  %t78 = bitcast i8* %t77 to { i8**, i64 }**
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %t78
  %t80 = icmp eq i32 %t73, 3
  %t81 = select i1 %t80, { i8**, i64 }* %t79, { i8**, i64 }* null
  %t82 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t83 = bitcast [24 x i8]* %t82 to i8*
  %t84 = getelementptr inbounds i8, i8* %t83, i64 16
  %t85 = bitcast i8* %t84 to { i8**, i64 }**
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %t85
  %t87 = icmp eq i32 %t73, 4
  %t88 = select i1 %t87, { i8**, i64 }* %t86, { i8**, i64 }* %t81
  %t89 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t90 = bitcast [24 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 16
  %t92 = bitcast i8* %t91 to { i8**, i64 }**
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %t92
  %t94 = icmp eq i32 %t73, 5
  %t95 = select i1 %t94, { i8**, i64 }* %t93, { i8**, i64 }* %t88
  %t96 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t97 = bitcast [40 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 32
  %t99 = bitcast i8* %t98 to { i8**, i64 }**
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %t99
  %t101 = icmp eq i32 %t73, 6
  %t102 = select i1 %t101, { i8**, i64 }* %t100, { i8**, i64 }* %t95
  %t103 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t104 = bitcast [24 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 16
  %t106 = bitcast i8* %t105 to { i8**, i64 }**
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %t106
  %t108 = icmp eq i32 %t73, 7
  %t109 = select i1 %t108, { i8**, i64 }* %t107, { i8**, i64 }* %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t111 = bitcast [56 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 48
  %t113 = bitcast i8* %t112 to { i8**, i64 }**
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %t113
  %t115 = icmp eq i32 %t73, 8
  %t116 = select i1 %t115, { i8**, i64 }* %t114, { i8**, i64 }* %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t118 = bitcast [40 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 32
  %t120 = bitcast i8* %t119 to { i8**, i64 }**
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %t120
  %t122 = icmp eq i32 %t73, 9
  %t123 = select i1 %t122, { i8**, i64 }* %t121, { i8**, i64 }* %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t125 = bitcast [40 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 32
  %t127 = bitcast i8* %t126 to { i8**, i64 }**
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %t127
  %t129 = icmp eq i32 %t73, 10
  %t130 = select i1 %t129, { i8**, i64 }* %t128, { i8**, i64 }* %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t132 = bitcast [40 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 32
  %t134 = bitcast i8* %t133 to { i8**, i64 }**
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %t134
  %t136 = icmp eq i32 %t73, 11
  %t137 = select i1 %t136, { i8**, i64 }* %t135, { i8**, i64 }* %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t139 = bitcast [40 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 32
  %t141 = bitcast i8* %t140 to { i8**, i64 }**
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %t141
  %t143 = icmp eq i32 %t73, 12
  %t144 = select i1 %t143, { i8**, i64 }* %t142, { i8**, i64 }* %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t146 = bitcast [24 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 16
  %t148 = bitcast i8* %t147 to { i8**, i64 }**
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %t148
  %t150 = icmp eq i32 %t73, 13
  %t151 = select i1 %t150, { i8**, i64 }* %t149, { i8**, i64 }* %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t153 = bitcast [24 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 16
  %t155 = bitcast i8* %t154 to { i8**, i64 }**
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %t155
  %t157 = icmp eq i32 %t73, 14
  %t158 = select i1 %t157, { i8**, i64 }* %t156, { i8**, i64 }* %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t160 = bitcast [16 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 8
  %t162 = bitcast i8* %t161 to { i8**, i64 }**
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %t162
  %t164 = icmp eq i32 %t73, 15
  %t165 = select i1 %t164, { i8**, i64 }* %t163, { i8**, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t167 = bitcast [24 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 16
  %t169 = bitcast i8* %t168 to { i8**, i64 }**
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %t169
  %t171 = icmp eq i32 %t73, 18
  %t172 = select i1 %t171, { i8**, i64 }* %t170, { i8**, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t174 = bitcast [32 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 24
  %t176 = bitcast i8* %t175 to { i8**, i64 }**
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %t176
  %t178 = icmp eq i32 %t73, 19
  %t179 = select i1 %t178, { i8**, i64 }* %t177, { i8**, i64 }* %t172
  %t180 = call { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* null)
  ret { %DecoratorInfo*, i64 }* %t180
merge1:
  %t181 = extractvalue %Statement %statement, 0
  %t182 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t183 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t181, 0
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t181, 1
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t181, 2
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t181, 3
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t181, 4
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t181, 5
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t181, 6
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t181, 7
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t181, 8
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t181, 9
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t181, 10
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t181, 11
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t181, 12
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t181, 13
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t181, 14
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t181, 15
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %t231 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t181, 16
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t181, 17
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %t237 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t238 = icmp eq i32 %t181, 18
  %t239 = select i1 %t238, i8* %t237, i8* %t236
  %t240 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t241 = icmp eq i32 %t181, 19
  %t242 = select i1 %t241, i8* %t240, i8* %t239
  %t243 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t181, 20
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t181, 21
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t181, 22
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %s252 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.252, i32 0, i32 0
  %t253 = icmp eq i8* %t251, %s252
  br i1 %t253, label %then2, label %merge3
then2:
  %t254 = extractvalue %Statement %statement, 0
  %t255 = alloca %Statement
  store %Statement %statement, %Statement* %t255
  %t256 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t257 = bitcast [48 x i8]* %t256 to i8*
  %t258 = getelementptr inbounds i8, i8* %t257, i64 40
  %t259 = bitcast i8* %t258 to { i8**, i64 }**
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %t259
  %t261 = icmp eq i32 %t254, 3
  %t262 = select i1 %t261, { i8**, i64 }* %t260, { i8**, i64 }* null
  %t263 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t264 = bitcast [24 x i8]* %t263 to i8*
  %t265 = getelementptr inbounds i8, i8* %t264, i64 16
  %t266 = bitcast i8* %t265 to { i8**, i64 }**
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %t266
  %t268 = icmp eq i32 %t254, 4
  %t269 = select i1 %t268, { i8**, i64 }* %t267, { i8**, i64 }* %t262
  %t270 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t271 = bitcast [24 x i8]* %t270 to i8*
  %t272 = getelementptr inbounds i8, i8* %t271, i64 16
  %t273 = bitcast i8* %t272 to { i8**, i64 }**
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %t273
  %t275 = icmp eq i32 %t254, 5
  %t276 = select i1 %t275, { i8**, i64 }* %t274, { i8**, i64 }* %t269
  %t277 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t278 = bitcast [40 x i8]* %t277 to i8*
  %t279 = getelementptr inbounds i8, i8* %t278, i64 32
  %t280 = bitcast i8* %t279 to { i8**, i64 }**
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %t280
  %t282 = icmp eq i32 %t254, 6
  %t283 = select i1 %t282, { i8**, i64 }* %t281, { i8**, i64 }* %t276
  %t284 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t285 = bitcast [24 x i8]* %t284 to i8*
  %t286 = getelementptr inbounds i8, i8* %t285, i64 16
  %t287 = bitcast i8* %t286 to { i8**, i64 }**
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %t287
  %t289 = icmp eq i32 %t254, 7
  %t290 = select i1 %t289, { i8**, i64 }* %t288, { i8**, i64 }* %t283
  %t291 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t292 = bitcast [56 x i8]* %t291 to i8*
  %t293 = getelementptr inbounds i8, i8* %t292, i64 48
  %t294 = bitcast i8* %t293 to { i8**, i64 }**
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %t294
  %t296 = icmp eq i32 %t254, 8
  %t297 = select i1 %t296, { i8**, i64 }* %t295, { i8**, i64 }* %t290
  %t298 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t299 = bitcast [40 x i8]* %t298 to i8*
  %t300 = getelementptr inbounds i8, i8* %t299, i64 32
  %t301 = bitcast i8* %t300 to { i8**, i64 }**
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %t301
  %t303 = icmp eq i32 %t254, 9
  %t304 = select i1 %t303, { i8**, i64 }* %t302, { i8**, i64 }* %t297
  %t305 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t306 = bitcast [40 x i8]* %t305 to i8*
  %t307 = getelementptr inbounds i8, i8* %t306, i64 32
  %t308 = bitcast i8* %t307 to { i8**, i64 }**
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %t308
  %t310 = icmp eq i32 %t254, 10
  %t311 = select i1 %t310, { i8**, i64 }* %t309, { i8**, i64 }* %t304
  %t312 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t313 = bitcast [40 x i8]* %t312 to i8*
  %t314 = getelementptr inbounds i8, i8* %t313, i64 32
  %t315 = bitcast i8* %t314 to { i8**, i64 }**
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %t315
  %t317 = icmp eq i32 %t254, 11
  %t318 = select i1 %t317, { i8**, i64 }* %t316, { i8**, i64 }* %t311
  %t319 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t320 = bitcast [40 x i8]* %t319 to i8*
  %t321 = getelementptr inbounds i8, i8* %t320, i64 32
  %t322 = bitcast i8* %t321 to { i8**, i64 }**
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %t322
  %t324 = icmp eq i32 %t254, 12
  %t325 = select i1 %t324, { i8**, i64 }* %t323, { i8**, i64 }* %t318
  %t326 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t327 = bitcast [24 x i8]* %t326 to i8*
  %t328 = getelementptr inbounds i8, i8* %t327, i64 16
  %t329 = bitcast i8* %t328 to { i8**, i64 }**
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %t329
  %t331 = icmp eq i32 %t254, 13
  %t332 = select i1 %t331, { i8**, i64 }* %t330, { i8**, i64 }* %t325
  %t333 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t334 = bitcast [24 x i8]* %t333 to i8*
  %t335 = getelementptr inbounds i8, i8* %t334, i64 16
  %t336 = bitcast i8* %t335 to { i8**, i64 }**
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %t336
  %t338 = icmp eq i32 %t254, 14
  %t339 = select i1 %t338, { i8**, i64 }* %t337, { i8**, i64 }* %t332
  %t340 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t341 = bitcast [16 x i8]* %t340 to i8*
  %t342 = getelementptr inbounds i8, i8* %t341, i64 8
  %t343 = bitcast i8* %t342 to { i8**, i64 }**
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %t343
  %t345 = icmp eq i32 %t254, 15
  %t346 = select i1 %t345, { i8**, i64 }* %t344, { i8**, i64 }* %t339
  %t347 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t348 = bitcast [24 x i8]* %t347 to i8*
  %t349 = getelementptr inbounds i8, i8* %t348, i64 16
  %t350 = bitcast i8* %t349 to { i8**, i64 }**
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %t350
  %t352 = icmp eq i32 %t254, 18
  %t353 = select i1 %t352, { i8**, i64 }* %t351, { i8**, i64 }* %t346
  %t354 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t355 = bitcast [32 x i8]* %t354 to i8*
  %t356 = getelementptr inbounds i8, i8* %t355, i64 24
  %t357 = bitcast i8* %t356 to { i8**, i64 }**
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %t357
  %t359 = icmp eq i32 %t254, 19
  %t360 = select i1 %t359, { i8**, i64 }* %t358, { i8**, i64 }* %t353
  %t361 = call { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* null)
  ret { %DecoratorInfo*, i64 }* %t361
merge3:
  %t362 = alloca [0 x double]
  %t363 = getelementptr [0 x double], [0 x double]* %t362, i32 0, i32 0
  %t364 = alloca { double*, i64 }
  %t365 = getelementptr { double*, i64 }, { double*, i64 }* %t364, i32 0, i32 0
  store double* %t363, double** %t365
  %t366 = getelementptr { double*, i64 }, { double*, i64 }* %t364, i32 0, i32 1
  store i64 0, i64* %t366
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
