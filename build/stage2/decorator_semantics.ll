; ModuleID = 'sailfin'
source_filename = "sailfin"

%DecoratorArgumentInfo = type { i8*, %LiteralValue }
%DecoratorInfo = type { i8*, { %DecoratorArgumentInfo**, i64 }* }
%Program = type { { %Statement**, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, %TypeAnnotation*, %SourceSpan* }
%Block = type { { %Token**, i64 }*, i8*, { %Statement**, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, %TypeAnnotation*, %Expression*, i1, %SourceSpan* }
%WithClause = type { %Expression }
%ObjectField = type { i8*, %Expression }
%ElseBranch = type { %Statement*, %Block* }
%ForClause = type { %Expression, %Expression, { %Token**, i64 }* }
%MatchCase = type { %Expression, %Expression*, %Block }
%ModelProperty = type { i8*, %Expression, %SourceSpan* }
%FieldDeclaration = type { i8*, %TypeAnnotation, i1, %SourceSpan* }
%MethodDeclaration = type { %FunctionSignature, %Block, { %Decorator**, i64 }* }
%EnumVariant = type { i8*, { %FieldDeclaration**, i64 }*, %SourceSpan* }
%FunctionSignature = type { i8*, i1, { %Parameter**, i64 }*, %TypeAnnotation*, { i8**, i64 }*, { %TypeParameter**, i64 }*, %SourceSpan* }
%PipelineDeclaration = type { %FunctionSignature, %Block, { %Decorator**, i64 }* }
%ToolDeclaration = type { %FunctionSignature, %Block, { %Decorator**, i64 }* }
%TestDeclaration = type { i8*, %Block, { i8**, i64 }*, { %Decorator**, i64 }* }
%ModelDeclaration = type { i8*, %TypeAnnotation, { %ModelProperty**, i64 }*, { i8**, i64 }*, { %Decorator**, i64 }* }
%Decorator = type { i8*, { %DecoratorArgument**, i64 }* }
%DecoratorArgument = type { i8*, %Expression }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { %TokenKind, i8*, double, double }

%LiteralValue = type { i32, [8 x i8] }
%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare i1 @sailfin_runtime_is_whitespace_char(i8)
declare i1 @sailfin_runtime_is_decimal_digit(i8)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len2.h193495007 = private unnamed_addr constant [3 x i8] c"io\00"

define { i8**, i64 }* @infer_effects({ i8**, i64 }* %existing, { %DecoratorInfo*, i64 }* %decorators) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca %DecoratorInfo
  %t0 = call { i8**, i64 }* @clone_effects({ i8**, i64 }* %existing)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t3 = call i1 @contains_effect({ i8**, i64 }* %t1, i8* %s2)
  store i1 %t3, i1* %l1
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l2
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load i1, i1* %l1
  %t7 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t51 = phi i1 [ %t6, %block.entry ], [ %t49, %loop.latch2 ]
  %t52 = phi double [ %t7, %block.entry ], [ %t50, %loop.latch2 ]
  store i1 %t51, i1* %l1
  store double %t52, double* %l2
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
  %t17 = fptosi double %t16 to i64
  %t18 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %decorators
  %t19 = extractvalue { %DecoratorInfo*, i64 } %t18, 0
  %t20 = extractvalue { %DecoratorInfo*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
  %t22 = getelementptr %DecoratorInfo, %DecoratorInfo* %t19, i64 %t17
  %t23 = load %DecoratorInfo, %DecoratorInfo* %t22
  store %DecoratorInfo %t23, %DecoratorInfo* %l3
  %t25 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t26 = extractvalue %DecoratorInfo %t25, 0
  %s27 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h515589823, i32 0, i32 0
  %t28 = call i1 @strings_equal(i8* %t26, i8* %s27)
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t28, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t30 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t31 = extractvalue %DecoratorInfo %t30, 0
  %s32 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1147459442, i32 0, i32 0
  %t33 = call i1 @strings_equal(i8* %t31, i8* %s32)
  br label %logical_or_entry_29

logical_or_entry_29:
  br i1 %t33, label %logical_or_merge_29, label %logical_or_right_29

logical_or_right_29:
  %t34 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t35 = extractvalue %DecoratorInfo %t34, 0
  %s36 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1170311443, i32 0, i32 0
  %t37 = call i1 @strings_equal(i8* %t35, i8* %s36)
  br label %logical_or_right_end_29

logical_or_right_end_29:
  br label %logical_or_merge_29

logical_or_merge_29:
  %t38 = phi i1 [ true, %logical_or_entry_29 ], [ %t37, %logical_or_right_end_29 ]
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t39 = phi i1 [ true, %logical_or_entry_24 ], [ %t38, %logical_or_right_end_24 ]
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i1, i1* %l1
  %t42 = load double, double* %l2
  %t43 = load %DecoratorInfo, %DecoratorInfo* %l3
  br i1 %t39, label %then6, label %merge7
then6:
  store i1 1, i1* %l1
  %t44 = load i1, i1* %l1
  br label %merge7
merge7:
  %t45 = phi i1 [ %t44, %then6 ], [ %t41, %logical_or_merge_24 ]
  store i1 %t45, i1* %l1
  %t46 = load double, double* %l2
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l2
  br label %loop.latch2
loop.latch2:
  %t49 = load i1, i1* %l1
  %t50 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t53 = load i1, i1* %l1
  %t54 = load double, double* %l2
  %t56 = load i1, i1* %l1
  br label %logical_and_entry_55

logical_and_entry_55:
  br i1 %t56, label %logical_and_right_55, label %logical_and_merge_55

logical_and_right_55:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t59 = call i1 @contains_effect({ i8**, i64 }* %t57, i8* %s58)
  %t60 = xor i1 %t59, 1
  br label %logical_and_right_end_55

logical_and_right_end_55:
  br label %logical_and_merge_55

logical_and_merge_55:
  %t61 = phi i1 [ false, %logical_and_entry_55 ], [ %t60, %logical_and_right_end_55 ]
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i1, i1* %l1
  %t64 = load double, double* %l2
  br i1 %t61, label %then8, label %merge9
then8:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s66 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t67 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t65, i8* %s66)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t69 = phi { i8**, i64 }* [ %t68, %then8 ], [ %t62, %logical_and_merge_55 ]
  store { i8**, i64 }* %t69, { i8**, i64 }** %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t70
}

define { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* %decorators) {
block.entry:
  %l0 = alloca { %DecoratorInfo*, i64 }*
  %l1 = alloca double
  %l2 = alloca %Decorator
  %l3 = alloca { %DecoratorArgumentInfo*, i64 }*
  %t0 = getelementptr [0 x %DecoratorInfo], [0 x %DecoratorInfo]* null, i32 1
  %t1 = ptrtoint [0 x %DecoratorInfo]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %DecoratorInfo*
  %t6 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* null, i32 1
  %t7 = ptrtoint { %DecoratorInfo*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %DecoratorInfo*, i64 }*
  %t10 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t9, i32 0, i32 0
  store %DecoratorInfo* %t5, %DecoratorInfo** %t10
  %t11 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %DecoratorInfo*, i64 }* %t9, { %DecoratorInfo*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t47 = phi { %DecoratorInfo*, i64 }* [ %t13, %block.entry ], [ %t45, %loop.latch2 ]
  %t48 = phi double [ %t14, %block.entry ], [ %t46, %loop.latch2 ]
  store { %DecoratorInfo*, i64 }* %t47, { %DecoratorInfo*, i64 }** %l0
  store double %t48, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t17 = extractvalue { %Decorator*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t25 = extractvalue { %Decorator*, i64 } %t24, 0
  %t26 = extractvalue { %Decorator*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %Decorator, %Decorator* %t25, i64 %t23
  %t29 = load %Decorator, %Decorator* %t28
  store %Decorator %t29, %Decorator* %l2
  %t30 = load %Decorator, %Decorator* %l2
  %t31 = extractvalue %Decorator %t30, 1
  %t32 = bitcast { %DecoratorArgument**, i64 }* %t31 to { %DecoratorArgument*, i64 }*
  %t33 = call { %DecoratorArgumentInfo*, i64 }* @evaluate_arguments({ %DecoratorArgument*, i64 }* %t32)
  store { %DecoratorArgumentInfo*, i64 }* %t33, { %DecoratorArgumentInfo*, i64 }** %l3
  %t34 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t35 = load %Decorator, %Decorator* %l2
  %t36 = extractvalue %Decorator %t35, 0
  %t37 = insertvalue %DecoratorInfo undef, i8* %t36, 0
  %t38 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l3
  %t39 = bitcast { %DecoratorArgumentInfo*, i64 }* %t38 to { %DecoratorArgumentInfo**, i64 }*
  %t40 = insertvalue %DecoratorInfo %t37, { %DecoratorArgumentInfo**, i64 }* %t39, 1
  %t41 = call { %DecoratorInfo*, i64 }* @append_decorator_info({ %DecoratorInfo*, i64 }* %t34, %DecoratorInfo %t40)
  store { %DecoratorInfo*, i64 }* %t41, { %DecoratorInfo*, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l1
  br label %loop.latch2
loop.latch2:
  %t45 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t46 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t49 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  ret { %DecoratorInfo*, i64 }* %t51
}

define { %DecoratorArgumentInfo*, i64 }* @evaluate_arguments({ %DecoratorArgument*, i64 }* %arguments) {
block.entry:
  %l0 = alloca { %DecoratorArgumentInfo*, i64 }*
  %l1 = alloca double
  %l2 = alloca %DecoratorArgument
  %l3 = alloca %LiteralValue
  %t0 = getelementptr [0 x %DecoratorArgumentInfo], [0 x %DecoratorArgumentInfo]* null, i32 1
  %t1 = ptrtoint [0 x %DecoratorArgumentInfo]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %DecoratorArgumentInfo*
  %t6 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* null, i32 1
  %t7 = ptrtoint { %DecoratorArgumentInfo*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %DecoratorArgumentInfo*, i64 }*
  %t10 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t9, i32 0, i32 0
  store %DecoratorArgumentInfo* %t5, %DecoratorArgumentInfo** %t10
  %t11 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %DecoratorArgumentInfo*, i64 }* %t9, { %DecoratorArgumentInfo*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t45 = phi { %DecoratorArgumentInfo*, i64 }* [ %t13, %block.entry ], [ %t43, %loop.latch2 ]
  %t46 = phi double [ %t14, %block.entry ], [ %t44, %loop.latch2 ]
  store { %DecoratorArgumentInfo*, i64 }* %t45, { %DecoratorArgumentInfo*, i64 }** %l0
  store double %t46, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %arguments
  %t17 = extractvalue { %DecoratorArgument*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %arguments
  %t25 = extractvalue { %DecoratorArgument*, i64 } %t24, 0
  %t26 = extractvalue { %DecoratorArgument*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %DecoratorArgument, %DecoratorArgument* %t25, i64 %t23
  %t29 = load %DecoratorArgument, %DecoratorArgument* %t28
  store %DecoratorArgument %t29, %DecoratorArgument* %l2
  %t30 = load %DecoratorArgument, %DecoratorArgument* %l2
  %t31 = extractvalue %DecoratorArgument %t30, 1
  %t32 = call %LiteralValue @evaluate_expression(%Expression %t31)
  store %LiteralValue %t32, %LiteralValue* %l3
  %t33 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t34 = load %DecoratorArgument, %DecoratorArgument* %l2
  %t35 = extractvalue %DecoratorArgument %t34, 0
  %t36 = insertvalue %DecoratorArgumentInfo undef, i8* %t35, 0
  %t37 = load %LiteralValue, %LiteralValue* %l3
  %t38 = insertvalue %DecoratorArgumentInfo %t36, %LiteralValue %t37, 1
  %t39 = call { %DecoratorArgumentInfo*, i64 }* @append_argument_info({ %DecoratorArgumentInfo*, i64 }* %t33, %DecoratorArgumentInfo %t38)
  store { %DecoratorArgumentInfo*, i64 }* %t39, { %DecoratorArgumentInfo*, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t44 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t47 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  ret { %DecoratorArgumentInfo*, i64 }* %t49
}

define %LiteralValue @evaluate_expression(%Expression %expr) {
block.entry:
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
  %s50 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h590768815, i32 0, i32 0
  %t51 = call i1 @strings_equal(i8* %t49, i8* %s50)
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
  %t68 = getelementptr inbounds %Expression, %Expression* %t55, i32 0, i32 1
  %t69 = bitcast [8 x i8]* %t68 to i8*
  %t70 = bitcast i8* %t69 to i8**
  %t71 = load i8*, i8** %t70
  %t72 = icmp eq i32 %t54, 3
  %t73 = select i1 %t72, i8* %t71, i8* %t67
  %t74 = getelementptr inbounds %LiteralValue, %LiteralValue* %t52, i32 0, i32 1
  %t75 = bitcast [8 x i8]* %t74 to i8*
  %t76 = bitcast i8* %t75 to i8**
  store i8* %t73, i8** %t76
  %t77 = load %LiteralValue, %LiteralValue* %t52
  ret %LiteralValue %t77
merge1:
  %t78 = extractvalue %Expression %expr, 0
  %t79 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t80 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t78, 0
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t78, 1
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t78, 2
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t78, 3
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t78, 4
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t78, 5
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t78, 6
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t78, 7
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t78, 8
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t78, 9
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t78, 10
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t78, 11
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t78, 12
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t78, 13
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t78, 14
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t78, 15
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %s128 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1318614710, i32 0, i32 0
  %t129 = call i1 @strings_equal(i8* %t127, i8* %s128)
  br i1 %t129, label %then2, label %merge3
then2:
  %t130 = alloca %LiteralValue
  %t131 = getelementptr inbounds %LiteralValue, %LiteralValue* %t130, i32 0, i32 0
  store i32 1, i32* %t131
  %t132 = extractvalue %Expression %expr, 0
  %t133 = alloca %Expression
  store %Expression %expr, %Expression* %t133
  %t134 = getelementptr inbounds %Expression, %Expression* %t133, i32 0, i32 1
  %t135 = bitcast [8 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t132, 1
  %t139 = select i1 %t138, i8* %t137, i8* null
  %t140 = getelementptr inbounds %Expression, %Expression* %t133, i32 0, i32 1
  %t141 = bitcast [8 x i8]* %t140 to i8*
  %t142 = bitcast i8* %t141 to i8**
  %t143 = load i8*, i8** %t142
  %t144 = icmp eq i32 %t132, 2
  %t145 = select i1 %t144, i8* %t143, i8* %t139
  %t146 = getelementptr inbounds %Expression, %Expression* %t133, i32 0, i32 1
  %t147 = bitcast [8 x i8]* %t146 to i8*
  %t148 = bitcast i8* %t147 to i8**
  %t149 = load i8*, i8** %t148
  %t150 = icmp eq i32 %t132, 3
  %t151 = select i1 %t150, i8* %t149, i8* %t145
  %t152 = getelementptr inbounds %LiteralValue, %LiteralValue* %t130, i32 0, i32 1
  %t153 = bitcast [8 x i8]* %t152 to i8*
  %t154 = bitcast i8* %t153 to i8**
  store i8* %t151, i8** %t154
  %t155 = load %LiteralValue, %LiteralValue* %t130
  ret %LiteralValue %t155
merge3:
  %t156 = extractvalue %Expression %expr, 0
  %t157 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t158 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t156, 0
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t156, 1
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t156, 2
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t156, 3
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t156, 4
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t156, 5
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t156, 6
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t156, 7
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t156, 8
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t156, 9
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t156, 10
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t156, 11
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t156, 12
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t156, 13
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t156, 14
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t156, 15
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %s206 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1570408460, i32 0, i32 0
  %t207 = call i1 @strings_equal(i8* %t205, i8* %s206)
  br i1 %t207, label %then4, label %merge5
then4:
  %t208 = alloca %LiteralValue
  %t209 = getelementptr inbounds %LiteralValue, %LiteralValue* %t208, i32 0, i32 0
  store i32 2, i32* %t209
  %t210 = extractvalue %Expression %expr, 0
  %t211 = alloca %Expression
  store %Expression %expr, %Expression* %t211
  %t212 = getelementptr inbounds %Expression, %Expression* %t211, i32 0, i32 1
  %t213 = bitcast [8 x i8]* %t212 to i8*
  %t214 = bitcast i8* %t213 to i8**
  %t215 = load i8*, i8** %t214
  %t216 = icmp eq i32 %t210, 1
  %t217 = select i1 %t216, i8* %t215, i8* null
  %t218 = getelementptr inbounds %Expression, %Expression* %t211, i32 0, i32 1
  %t219 = bitcast [8 x i8]* %t218 to i8*
  %t220 = bitcast i8* %t219 to i8**
  %t221 = load i8*, i8** %t220
  %t222 = icmp eq i32 %t210, 2
  %t223 = select i1 %t222, i8* %t221, i8* %t217
  %t224 = getelementptr inbounds %Expression, %Expression* %t211, i32 0, i32 1
  %t225 = bitcast [8 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to i8**
  %t227 = load i8*, i8** %t226
  %t228 = icmp eq i32 %t210, 3
  %t229 = select i1 %t228, i8* %t227, i8* %t223
  %t230 = getelementptr inbounds %LiteralValue, %LiteralValue* %t208, i32 0, i32 1
  %t231 = bitcast [8 x i8]* %t230 to i8*
  %t232 = bitcast i8* %t231 to i8**
  store i8* %t229, i8** %t232
  %t233 = load %LiteralValue, %LiteralValue* %t208
  ret %LiteralValue %t233
merge5:
  %t234 = extractvalue %Expression %expr, 0
  %t235 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t236 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t234, 0
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t234, 1
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t234, 2
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t234, 3
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t234, 4
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t234, 5
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t234, 6
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t234, 7
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t234, 8
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t234, 9
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t234, 10
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t234, 11
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t234, 12
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t234, 13
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t234, 14
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t234, 15
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %s284 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1571993816, i32 0, i32 0
  %t285 = call i1 @strings_equal(i8* %t283, i8* %s284)
  br i1 %t285, label %then6, label %merge7
then6:
  %t286 = insertvalue %LiteralValue undef, i32 3, 0
  ret %LiteralValue %t286
merge7:
  %t287 = extractvalue %Expression %expr, 0
  %t288 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t289 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t287, 0
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t287, 1
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t287, 2
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t287, 3
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %t301 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t302 = icmp eq i32 %t287, 4
  %t303 = select i1 %t302, i8* %t301, i8* %t300
  %t304 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t305 = icmp eq i32 %t287, 5
  %t306 = select i1 %t305, i8* %t304, i8* %t303
  %t307 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t308 = icmp eq i32 %t287, 6
  %t309 = select i1 %t308, i8* %t307, i8* %t306
  %t310 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t311 = icmp eq i32 %t287, 7
  %t312 = select i1 %t311, i8* %t310, i8* %t309
  %t313 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t314 = icmp eq i32 %t287, 8
  %t315 = select i1 %t314, i8* %t313, i8* %t312
  %t316 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t287, 9
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t287, 10
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t287, 11
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t287, 12
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t287, 13
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t287, 14
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t287, 15
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %s337 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089530004, i32 0, i32 0
  %t338 = call i1 @strings_equal(i8* %t336, i8* %s337)
  br i1 %t338, label %then8, label %merge9
then8:
  %t339 = extractvalue %Expression %expr, 0
  %t340 = alloca %Expression
  store %Expression %expr, %Expression* %t340
  %t341 = getelementptr inbounds %Expression, %Expression* %t340, i32 0, i32 1
  %t342 = bitcast [8 x i8]* %t341 to i8*
  %t343 = bitcast i8* %t342 to i8**
  %t344 = load i8*, i8** %t343
  %t345 = icmp eq i32 %t339, 15
  %t346 = select i1 %t345, i8* %t344, i8* null
  %t347 = call i8* @trim_whitespace(i8* %t346)
  store i8* %t347, i8** %l0
  %t348 = load i8*, i8** %l0
  %t349 = call i64 @sailfin_runtime_string_length(i8* %t348)
  %t350 = icmp eq i64 %t349, 0
  %t351 = load i8*, i8** %l0
  br i1 %t350, label %then10, label %merge11
then10:
  %t352 = insertvalue %LiteralValue undef, i32 4, 0
  ret %LiteralValue %t352
merge11:
  %t353 = load i8*, i8** %l0
  %t354 = call i1 @looks_like_quoted_string(i8* %t353)
  %t355 = load i8*, i8** %l0
  br i1 %t354, label %then12, label %merge13
then12:
  %t356 = load i8*, i8** %l0
  %t357 = call i8* @strip_surrounding_quotes(i8* %t356)
  store i8* %t357, i8** %l1
  %t358 = alloca %LiteralValue
  %t359 = getelementptr inbounds %LiteralValue, %LiteralValue* %t358, i32 0, i32 0
  store i32 0, i32* %t359
  %t360 = load i8*, i8** %l1
  %t361 = getelementptr inbounds %LiteralValue, %LiteralValue* %t358, i32 0, i32 1
  %t362 = bitcast [8 x i8]* %t361 to i8*
  %t363 = bitcast i8* %t362 to i8**
  store i8* %t360, i8** %t363
  %t364 = load %LiteralValue, %LiteralValue* %t358
  ret %LiteralValue %t364
merge13:
  %t365 = load i8*, i8** %l0
  %s366 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t367 = call i1 @strings_equal(i8* %t365, i8* %s366)
  %t368 = load i8*, i8** %l0
  br i1 %t367, label %then14, label %merge15
then14:
  %t369 = alloca %LiteralValue
  %t370 = getelementptr inbounds %LiteralValue, %LiteralValue* %t369, i32 0, i32 0
  store i32 1, i32* %t370
  %s371 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t372 = getelementptr inbounds %LiteralValue, %LiteralValue* %t369, i32 0, i32 1
  %t373 = bitcast [8 x i8]* %t372 to i8*
  %t374 = bitcast i8* %t373 to i8**
  store i8* %s371, i8** %t374
  %t375 = load %LiteralValue, %LiteralValue* %t369
  ret %LiteralValue %t375
merge15:
  %t376 = load i8*, i8** %l0
  %s377 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t378 = call i1 @strings_equal(i8* %t376, i8* %s377)
  %t379 = load i8*, i8** %l0
  br i1 %t378, label %then16, label %merge17
then16:
  %t380 = alloca %LiteralValue
  %t381 = getelementptr inbounds %LiteralValue, %LiteralValue* %t380, i32 0, i32 0
  store i32 1, i32* %t381
  %s382 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t383 = getelementptr inbounds %LiteralValue, %LiteralValue* %t380, i32 0, i32 1
  %t384 = bitcast [8 x i8]* %t383 to i8*
  %t385 = bitcast i8* %t384 to i8**
  store i8* %s382, i8** %t385
  %t386 = load %LiteralValue, %LiteralValue* %t380
  ret %LiteralValue %t386
merge17:
  %t387 = load i8*, i8** %l0
  %t388 = call i1 @looks_like_number(i8* %t387)
  %t389 = load i8*, i8** %l0
  br i1 %t388, label %then18, label %merge19
then18:
  %t390 = alloca %LiteralValue
  %t391 = getelementptr inbounds %LiteralValue, %LiteralValue* %t390, i32 0, i32 0
  store i32 2, i32* %t391
  %t392 = load i8*, i8** %l0
  %t393 = getelementptr inbounds %LiteralValue, %LiteralValue* %t390, i32 0, i32 1
  %t394 = bitcast [8 x i8]* %t393 to i8*
  %t395 = bitcast i8* %t394 to i8**
  store i8* %t392, i8** %t395
  %t396 = load %LiteralValue, %LiteralValue* %t390
  ret %LiteralValue %t396
merge19:
  br label %merge9
merge9:
  %t397 = insertvalue %LiteralValue undef, i32 4, 0
  ret %LiteralValue %t397
}

define { %DecoratorInfo*, i64 }* @evaluate_statement_decorators(%Statement %statement) {
block.entry:
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
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t72 = call i1 @strings_equal(i8* %t70, i8* %s71)
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [48 x i8]* %t75 to i8*
  %t77 = getelementptr inbounds i8, i8* %t76, i64 40
  %t78 = bitcast i8* %t77 to { %Decorator**, i64 }**
  %t79 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t78
  %t80 = icmp eq i32 %t73, 3
  %t81 = select i1 %t80, { %Decorator**, i64 }* %t79, { %Decorator**, i64 }* null
  %t82 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t83 = bitcast [24 x i8]* %t82 to i8*
  %t84 = getelementptr inbounds i8, i8* %t83, i64 16
  %t85 = bitcast i8* %t84 to { %Decorator**, i64 }**
  %t86 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t85
  %t87 = icmp eq i32 %t73, 4
  %t88 = select i1 %t87, { %Decorator**, i64 }* %t86, { %Decorator**, i64 }* %t81
  %t89 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t90 = bitcast [24 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 16
  %t92 = bitcast i8* %t91 to { %Decorator**, i64 }**
  %t93 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t92
  %t94 = icmp eq i32 %t73, 5
  %t95 = select i1 %t94, { %Decorator**, i64 }* %t93, { %Decorator**, i64 }* %t88
  %t96 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t97 = bitcast [40 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 32
  %t99 = bitcast i8* %t98 to { %Decorator**, i64 }**
  %t100 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t99
  %t101 = icmp eq i32 %t73, 6
  %t102 = select i1 %t101, { %Decorator**, i64 }* %t100, { %Decorator**, i64 }* %t95
  %t103 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t104 = bitcast [24 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 16
  %t106 = bitcast i8* %t105 to { %Decorator**, i64 }**
  %t107 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t106
  %t108 = icmp eq i32 %t73, 7
  %t109 = select i1 %t108, { %Decorator**, i64 }* %t107, { %Decorator**, i64 }* %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t111 = bitcast [56 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 48
  %t113 = bitcast i8* %t112 to { %Decorator**, i64 }**
  %t114 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t113
  %t115 = icmp eq i32 %t73, 8
  %t116 = select i1 %t115, { %Decorator**, i64 }* %t114, { %Decorator**, i64 }* %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t118 = bitcast [40 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 32
  %t120 = bitcast i8* %t119 to { %Decorator**, i64 }**
  %t121 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t120
  %t122 = icmp eq i32 %t73, 9
  %t123 = select i1 %t122, { %Decorator**, i64 }* %t121, { %Decorator**, i64 }* %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t125 = bitcast [40 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 32
  %t127 = bitcast i8* %t126 to { %Decorator**, i64 }**
  %t128 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t127
  %t129 = icmp eq i32 %t73, 10
  %t130 = select i1 %t129, { %Decorator**, i64 }* %t128, { %Decorator**, i64 }* %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t132 = bitcast [40 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 32
  %t134 = bitcast i8* %t133 to { %Decorator**, i64 }**
  %t135 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t134
  %t136 = icmp eq i32 %t73, 11
  %t137 = select i1 %t136, { %Decorator**, i64 }* %t135, { %Decorator**, i64 }* %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t139 = bitcast [40 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 32
  %t141 = bitcast i8* %t140 to { %Decorator**, i64 }**
  %t142 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t141
  %t143 = icmp eq i32 %t73, 12
  %t144 = select i1 %t143, { %Decorator**, i64 }* %t142, { %Decorator**, i64 }* %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t146 = bitcast [24 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 16
  %t148 = bitcast i8* %t147 to { %Decorator**, i64 }**
  %t149 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t148
  %t150 = icmp eq i32 %t73, 13
  %t151 = select i1 %t150, { %Decorator**, i64 }* %t149, { %Decorator**, i64 }* %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t153 = bitcast [24 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 16
  %t155 = bitcast i8* %t154 to { %Decorator**, i64 }**
  %t156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t155
  %t157 = icmp eq i32 %t73, 14
  %t158 = select i1 %t157, { %Decorator**, i64 }* %t156, { %Decorator**, i64 }* %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t160 = bitcast [16 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 8
  %t162 = bitcast i8* %t161 to { %Decorator**, i64 }**
  %t163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t162
  %t164 = icmp eq i32 %t73, 15
  %t165 = select i1 %t164, { %Decorator**, i64 }* %t163, { %Decorator**, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t167 = bitcast [24 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 16
  %t169 = bitcast i8* %t168 to { %Decorator**, i64 }**
  %t170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t169
  %t171 = icmp eq i32 %t73, 18
  %t172 = select i1 %t171, { %Decorator**, i64 }* %t170, { %Decorator**, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t174 = bitcast [32 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 24
  %t176 = bitcast i8* %t175 to { %Decorator**, i64 }**
  %t177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t176
  %t178 = icmp eq i32 %t73, 19
  %t179 = select i1 %t178, { %Decorator**, i64 }* %t177, { %Decorator**, i64 }* %t172
  %t180 = bitcast { %Decorator**, i64 }* %t179 to { %Decorator*, i64 }*
  %t181 = call { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* %t180)
  ret { %DecoratorInfo*, i64 }* %t181
merge1:
  %t182 = extractvalue %Statement %statement, 0
  %t183 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t184 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t182, 0
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t182, 1
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t182, 2
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t182, 3
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t182, 4
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t182, 5
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t182, 6
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t182, 7
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t182, 8
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t182, 9
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t182, 10
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t182, 11
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t182, 12
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t182, 13
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t182, 14
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t182, 15
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t182, 16
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t182, 17
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %t238 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t239 = icmp eq i32 %t182, 18
  %t240 = select i1 %t239, i8* %t238, i8* %t237
  %t241 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t242 = icmp eq i32 %t182, 19
  %t243 = select i1 %t242, i8* %t241, i8* %t240
  %t244 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t245 = icmp eq i32 %t182, 20
  %t246 = select i1 %t245, i8* %t244, i8* %t243
  %t247 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t248 = icmp eq i32 %t182, 21
  %t249 = select i1 %t248, i8* %t247, i8* %t246
  %t250 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t251 = icmp eq i32 %t182, 22
  %t252 = select i1 %t251, i8* %t250, i8* %t249
  %s253 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t254 = call i1 @strings_equal(i8* %t252, i8* %s253)
  br i1 %t254, label %then2, label %merge3
then2:
  %t255 = extractvalue %Statement %statement, 0
  %t256 = alloca %Statement
  store %Statement %statement, %Statement* %t256
  %t257 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t258 = bitcast [48 x i8]* %t257 to i8*
  %t259 = getelementptr inbounds i8, i8* %t258, i64 40
  %t260 = bitcast i8* %t259 to { %Decorator**, i64 }**
  %t261 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t260
  %t262 = icmp eq i32 %t255, 3
  %t263 = select i1 %t262, { %Decorator**, i64 }* %t261, { %Decorator**, i64 }* null
  %t264 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t265 = bitcast [24 x i8]* %t264 to i8*
  %t266 = getelementptr inbounds i8, i8* %t265, i64 16
  %t267 = bitcast i8* %t266 to { %Decorator**, i64 }**
  %t268 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t267
  %t269 = icmp eq i32 %t255, 4
  %t270 = select i1 %t269, { %Decorator**, i64 }* %t268, { %Decorator**, i64 }* %t263
  %t271 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t272 = bitcast [24 x i8]* %t271 to i8*
  %t273 = getelementptr inbounds i8, i8* %t272, i64 16
  %t274 = bitcast i8* %t273 to { %Decorator**, i64 }**
  %t275 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t274
  %t276 = icmp eq i32 %t255, 5
  %t277 = select i1 %t276, { %Decorator**, i64 }* %t275, { %Decorator**, i64 }* %t270
  %t278 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t279 = bitcast [40 x i8]* %t278 to i8*
  %t280 = getelementptr inbounds i8, i8* %t279, i64 32
  %t281 = bitcast i8* %t280 to { %Decorator**, i64 }**
  %t282 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t281
  %t283 = icmp eq i32 %t255, 6
  %t284 = select i1 %t283, { %Decorator**, i64 }* %t282, { %Decorator**, i64 }* %t277
  %t285 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t286 = bitcast [24 x i8]* %t285 to i8*
  %t287 = getelementptr inbounds i8, i8* %t286, i64 16
  %t288 = bitcast i8* %t287 to { %Decorator**, i64 }**
  %t289 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t288
  %t290 = icmp eq i32 %t255, 7
  %t291 = select i1 %t290, { %Decorator**, i64 }* %t289, { %Decorator**, i64 }* %t284
  %t292 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t293 = bitcast [56 x i8]* %t292 to i8*
  %t294 = getelementptr inbounds i8, i8* %t293, i64 48
  %t295 = bitcast i8* %t294 to { %Decorator**, i64 }**
  %t296 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t295
  %t297 = icmp eq i32 %t255, 8
  %t298 = select i1 %t297, { %Decorator**, i64 }* %t296, { %Decorator**, i64 }* %t291
  %t299 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t300 = bitcast [40 x i8]* %t299 to i8*
  %t301 = getelementptr inbounds i8, i8* %t300, i64 32
  %t302 = bitcast i8* %t301 to { %Decorator**, i64 }**
  %t303 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t302
  %t304 = icmp eq i32 %t255, 9
  %t305 = select i1 %t304, { %Decorator**, i64 }* %t303, { %Decorator**, i64 }* %t298
  %t306 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t307 = bitcast [40 x i8]* %t306 to i8*
  %t308 = getelementptr inbounds i8, i8* %t307, i64 32
  %t309 = bitcast i8* %t308 to { %Decorator**, i64 }**
  %t310 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t309
  %t311 = icmp eq i32 %t255, 10
  %t312 = select i1 %t311, { %Decorator**, i64 }* %t310, { %Decorator**, i64 }* %t305
  %t313 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t314 = bitcast [40 x i8]* %t313 to i8*
  %t315 = getelementptr inbounds i8, i8* %t314, i64 32
  %t316 = bitcast i8* %t315 to { %Decorator**, i64 }**
  %t317 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t316
  %t318 = icmp eq i32 %t255, 11
  %t319 = select i1 %t318, { %Decorator**, i64 }* %t317, { %Decorator**, i64 }* %t312
  %t320 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t321 = bitcast [40 x i8]* %t320 to i8*
  %t322 = getelementptr inbounds i8, i8* %t321, i64 32
  %t323 = bitcast i8* %t322 to { %Decorator**, i64 }**
  %t324 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t323
  %t325 = icmp eq i32 %t255, 12
  %t326 = select i1 %t325, { %Decorator**, i64 }* %t324, { %Decorator**, i64 }* %t319
  %t327 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t328 = bitcast [24 x i8]* %t327 to i8*
  %t329 = getelementptr inbounds i8, i8* %t328, i64 16
  %t330 = bitcast i8* %t329 to { %Decorator**, i64 }**
  %t331 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t330
  %t332 = icmp eq i32 %t255, 13
  %t333 = select i1 %t332, { %Decorator**, i64 }* %t331, { %Decorator**, i64 }* %t326
  %t334 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t335 = bitcast [24 x i8]* %t334 to i8*
  %t336 = getelementptr inbounds i8, i8* %t335, i64 16
  %t337 = bitcast i8* %t336 to { %Decorator**, i64 }**
  %t338 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t337
  %t339 = icmp eq i32 %t255, 14
  %t340 = select i1 %t339, { %Decorator**, i64 }* %t338, { %Decorator**, i64 }* %t333
  %t341 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t342 = bitcast [16 x i8]* %t341 to i8*
  %t343 = getelementptr inbounds i8, i8* %t342, i64 8
  %t344 = bitcast i8* %t343 to { %Decorator**, i64 }**
  %t345 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t344
  %t346 = icmp eq i32 %t255, 15
  %t347 = select i1 %t346, { %Decorator**, i64 }* %t345, { %Decorator**, i64 }* %t340
  %t348 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t349 = bitcast [24 x i8]* %t348 to i8*
  %t350 = getelementptr inbounds i8, i8* %t349, i64 16
  %t351 = bitcast i8* %t350 to { %Decorator**, i64 }**
  %t352 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t351
  %t353 = icmp eq i32 %t255, 18
  %t354 = select i1 %t353, { %Decorator**, i64 }* %t352, { %Decorator**, i64 }* %t347
  %t355 = getelementptr inbounds %Statement, %Statement* %t256, i32 0, i32 1
  %t356 = bitcast [32 x i8]* %t355 to i8*
  %t357 = getelementptr inbounds i8, i8* %t356, i64 24
  %t358 = bitcast i8* %t357 to { %Decorator**, i64 }**
  %t359 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t358
  %t360 = icmp eq i32 %t255, 19
  %t361 = select i1 %t360, { %Decorator**, i64 }* %t359, { %Decorator**, i64 }* %t354
  %t362 = bitcast { %Decorator**, i64 }* %t361 to { %Decorator*, i64 }*
  %t363 = call { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* %t362)
  ret { %DecoratorInfo*, i64 }* %t363
merge3:
  %t364 = getelementptr [0 x %DecoratorInfo], [0 x %DecoratorInfo]* null, i32 1
  %t365 = ptrtoint [0 x %DecoratorInfo]* %t364 to i64
  %t366 = icmp eq i64 %t365, 0
  %t367 = select i1 %t366, i64 1, i64 %t365
  %t368 = call i8* @malloc(i64 %t367)
  %t369 = bitcast i8* %t368 to %DecoratorInfo*
  %t370 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* null, i32 1
  %t371 = ptrtoint { %DecoratorInfo*, i64 }* %t370 to i64
  %t372 = call i8* @malloc(i64 %t371)
  %t373 = bitcast i8* %t372 to { %DecoratorInfo*, i64 }*
  %t374 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t373, i32 0, i32 0
  store %DecoratorInfo* %t369, %DecoratorInfo** %t374
  %t375 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t373, i32 0, i32 1
  store i64 0, i64* %t375
  ret { %DecoratorInfo*, i64 }* %t373
}

define i8* @trim_whitespace(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i64
  %l3 = alloca double
  %l4 = alloca i64
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t3, %block.entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = fcmp oge double %t5, %t6
  %t8 = load double, double* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l0
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  %t14 = sext i8 %t13 to i64
  store i64 %t14, i64* %l2
  %t15 = load i64, i64* %l2
  %t16 = call i1 @sailfin_runtime_is_whitespace_char(i64 %t15)
  %t17 = load double, double* %l0
  %t18 = load double, double* %l1
  %t19 = load i64, i64* %l2
  br i1 %t16, label %then6, label %merge7
then6:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t23 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t25 = load double, double* %l0
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t51 = phi double [ %t27, %afterloop3 ], [ %t50, %loop.latch10 ]
  store double %t51, double* %l1
  br label %loop.body9
loop.body9:
  %t28 = load double, double* %l1
  %t29 = load double, double* %l0
  %t30 = fcmp ole double %t28, %t29
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l3
  %t36 = load double, double* %l3
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %value, i64 %t37
  %t39 = load i8, i8* %t38
  %t40 = sext i8 %t39 to i64
  store i64 %t40, i64* %l4
  %t41 = load i64, i64* %l4
  %t42 = call i1 @sailfin_runtime_is_whitespace_char(i64 %t41)
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = load double, double* %l3
  %t46 = load i64, i64* %l4
  br i1 %t42, label %then14, label %merge15
then14:
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fsub double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t50 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t52 = load double, double* %l1
  %t53 = load double, double* %l0
  %t54 = load double, double* %l1
  %t55 = call i8* @slice_text(i8* %value, double %t53, double %t54)
  ret i8* %t55
}

define i1 @looks_like_quoted_string(i8* %text) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca i64
  %l2 = alloca i64
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = getelementptr i8, i8* %text, i64 0
  %t3 = load i8, i8* %t2
  %t4 = sext i8 %t3 to i64
  store i64 %t4, i64* %l0
  %t5 = load i64, i64* %l0
  %t6 = icmp ne i64 %t5, 34
  %t7 = load i64, i64* %l0
  br i1 %t6, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t8 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t9 = sub i64 %t8, 1
  store i64 %t9, i64* %l1
  %t10 = load i64, i64* %l1
  %t11 = getelementptr i8, i8* %text, i64 %t10
  %t12 = load i8, i8* %t11
  %t13 = sext i8 %t12 to i64
  store i64 %t13, i64* %l2
  %t14 = load i64, i64* %l2
  %t15 = icmp ne i64 %t14, 34
  %t16 = load i64, i64* %l0
  %t17 = load i64, i64* %l1
  %t18 = load i64, i64* %l2
  br i1 %t15, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  ret i1 1
}

define i1 @looks_like_number(i8* %text) {
block.entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca i64
  %l3 = alloca i64
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  store i1 0, i1* %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = getelementptr i8, i8* %text, i64 0
  %t4 = load i8, i8* %t3
  %t5 = sext i8 %t4 to i64
  store i64 %t5, i64* %l2
  %t6 = load i64, i64* %l2
  %t7 = icmp eq i64 %t6, 45
  %t8 = load i1, i1* %l0
  %t9 = load double, double* %l1
  %t10 = load i64, i64* %l2
  br i1 %t7, label %then2, label %merge3
then2:
  %t11 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t12 = icmp eq i64 %t11, 1
  %t13 = load i1, i1* %l0
  %t14 = load double, double* %l1
  %t15 = load i64, i64* %l2
  br i1 %t12, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t16 = sitofp i64 1 to double
  store double %t16, double* %l1
  %t17 = load double, double* %l1
  br label %merge3
merge3:
  %t18 = phi double [ %t17, %merge5 ], [ %t9, %merge1 ]
  store double %t18, double* %l1
  %t19 = load i1, i1* %l0
  %t20 = load double, double* %l1
  %t21 = load i64, i64* %l2
  br label %loop.header6
loop.header6:
  %t60 = phi i1 [ %t19, %merge3 ], [ %t58, %loop.latch8 ]
  %t61 = phi double [ %t20, %merge3 ], [ %t59, %loop.latch8 ]
  store i1 %t60, i1* %l0
  store double %t61, double* %l1
  br label %loop.body7
loop.body7:
  %t22 = load double, double* %l1
  %t23 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp oge double %t22, %t24
  %t26 = load i1, i1* %l0
  %t27 = load double, double* %l1
  %t28 = load i64, i64* %l2
  br i1 %t25, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t29 = load double, double* %l1
  %t30 = fptosi double %t29 to i64
  %t31 = getelementptr i8, i8* %text, i64 %t30
  %t32 = load i8, i8* %t31
  %t33 = sext i8 %t32 to i64
  store i64 %t33, i64* %l3
  %t34 = load i64, i64* %l3
  %t35 = icmp eq i64 %t34, 46
  %t36 = load i1, i1* %l0
  %t37 = load double, double* %l1
  %t38 = load i64, i64* %l2
  %t39 = load i64, i64* %l3
  br i1 %t35, label %then12, label %merge13
then12:
  %t40 = load i1, i1* %l0
  %t41 = load i1, i1* %l0
  %t42 = load double, double* %l1
  %t43 = load i64, i64* %l2
  %t44 = load i64, i64* %l3
  br i1 %t40, label %then14, label %merge15
then14:
  ret i1 0
merge15:
  store i1 1, i1* %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch8
merge13:
  %t48 = load i64, i64* %l3
  %t49 = call i1 @sailfin_runtime_is_decimal_digit(i64 %t48)
  %t50 = xor i1 %t49, 1
  %t51 = load i1, i1* %l0
  %t52 = load double, double* %l1
  %t53 = load i64, i64* %l2
  %t54 = load i64, i64* %l3
  br i1 %t50, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  %t55 = load double, double* %l1
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l1
  br label %loop.latch8
loop.latch8:
  %t58 = load i1, i1* %l0
  %t59 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t62 = load i1, i1* %l0
  %t63 = load double, double* %l1
  ret i1 1
}

define i1 @is_decimal_digit(i64 %ch) {
block.entry:
  %t1 = icmp sge i64 %ch, 48
  br label %logical_and_entry_0

logical_and_entry_0:
  br i1 %t1, label %logical_and_right_0, label %logical_and_merge_0

logical_and_right_0:
  %t2 = icmp sle i64 %ch, 57
  br label %logical_and_right_end_0

logical_and_right_end_0:
  br label %logical_and_merge_0

logical_and_merge_0:
  %t3 = phi i1 [ false, %logical_and_entry_0 ], [ %t2, %logical_and_right_end_0 ]
  ret i1 %t3
}

define { %DecoratorInfo*, i64 }* @append_decorator_info({ %DecoratorInfo*, i64 }* %collection, %DecoratorInfo %item) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %DecoratorInfo*
  store %DecoratorInfo %item, %DecoratorInfo* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %DecoratorInfo*, i64 }* %collection to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %DecoratorInfo*, i64 }*
  ret { %DecoratorInfo*, i64 }* %t17
}

define { %DecoratorArgumentInfo*, i64 }* @append_argument_info({ %DecoratorArgumentInfo*, i64 }* %collection, %DecoratorArgumentInfo %item) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %DecoratorArgumentInfo*
  store %DecoratorArgumentInfo %item, %DecoratorArgumentInfo* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %DecoratorArgumentInfo*, i64 }* %collection to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %DecoratorArgumentInfo*, i64 }*
  ret { %DecoratorArgumentInfo*, i64 }* %t17
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %collection, i8* %item) {
block.entry:
  %t0 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t1 = ptrtoint [1 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr i8*, i8** %t5, i64 0
  store i8* %item, i8** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t5, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %collection, { i8**, i64 }* %t10)
  ret { i8**, i64 }* %t13
}

define { i8**, i64 }* @clone_effects({ i8**, i64 }* %effects) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %t37 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t14, %block.entry ], [ %t36, %loop.latch2 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  store double %t38, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch2
loop.latch2:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t41
}

define i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect) {
block.entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t22 = phi double [ %t1, %block.entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
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
  %t9 = fptosi double %t8 to i64
  %t10 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = call i1 @strings_equal(i8* %t15, i8* %effect)
  %t17 = load double, double* %l0
  br i1 %t16, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch2
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t23 = load double, double* %l0
  ret i1 0
}

define i1 @is_whitespace_char(i64 %ch) {
block.entry:
  %t1 = icmp eq i64 %ch, 32
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t3 = icmp eq i64 %ch, 9
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t3, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t5 = icmp eq i64 %ch, 10
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t5, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t6 = icmp eq i64 %ch, 13
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t7 = phi i1 [ true, %logical_or_entry_4 ], [ %t6, %logical_or_right_end_4 ]
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t8 = phi i1 [ true, %logical_or_entry_2 ], [ %t7, %logical_or_right_end_2 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t9 = phi i1 [ true, %logical_or_entry_0 ], [ %t8, %logical_or_right_end_0 ]
  ret i1 %t9
}

define i8* @slice_text(i8* %text, double %start, double %end) {
block.entry:
  %t0 = fptosi double %start to i64
  %t1 = fptosi double %end to i64
  %t2 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t0, i64 %t1)
  ret i8* %t2
}

define i8* @strip_surrounding_quotes(i8* %value) {
block.entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %value
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sub i64 %t2, 1
  %t4 = sitofp i64 1 to double
  %t5 = sitofp i64 %t3 to double
  %t6 = call i8* @slice_text(i8* %value, double %t4, double %t5)
  ret i8* %t6
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len14.h1318614710 = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Expression.NullLiteral.variant = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.str.len5.h515589823 = private unnamed_addr constant [6 x i8] c"trace\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Expression.Member.variant = private unnamed_addr constant [7 x i8] c"Member\00"
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.enum.Expression.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Expression.Binary.variant = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.enum.Expression.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Expression.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.Expression.Lambda.variant = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.enum.Expression.Unary.variant = private unnamed_addr constant [6 x i8] c"Unary\00"
@.enum.Expression.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Expression.Raw.variant = private unnamed_addr constant [4 x i8] c"Raw\00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Expression.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len12.h1170311443 = private unnamed_addr constant [13 x i8] c"logexecution\00"
@.enum.Expression.Struct.variant = private unnamed_addr constant [7 x i8] c"Struct\00"
@.str.len13.h590768815 = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Expression.Object.variant = private unnamed_addr constant [7 x i8] c"Object\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.enum.Expression.Index.variant = private unnamed_addr constant [6 x i8] c"Index\00"
@.enum.Expression.Call.variant = private unnamed_addr constant [5 x i8] c"Call\00"
@.str.len12.h1147459442 = private unnamed_addr constant [13 x i8] c"logExecution\00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len3.h2089530004 = private unnamed_addr constant [4 x i8] c"Raw\00"
@.enum.Expression.Array.variant = private unnamed_addr constant [6 x i8] c"Array\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.enum.Expression.Range.variant = private unnamed_addr constant [6 x i8] c"Range\00"
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.str.len13.h1570408460 = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.str.len11.h1571993816 = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
