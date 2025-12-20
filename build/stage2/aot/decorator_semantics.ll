; ModuleID = 'sailfin'
source_filename = "sailfin"

%DecoratorArgumentInfo = type { i8*, %LiteralValue }
%DecoratorInfo = type { i8*, { %DecoratorArgumentInfo*, i64 }* }
%Program = type { { %Statement*, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, %TypeAnnotation*, %SourceSpan* }
%Block = type { { %Token*, i64 }*, i8*, { %Statement*, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, %TypeAnnotation*, %Expression*, i1, %SourceSpan* }
%WithClause = type { %Expression }
%ObjectField = type { i8*, %Expression }
%ElseBranch = type { %Statement*, %Block* }
%ForClause = type { %Expression, %Expression, { %Token*, i64 }* }
%MatchCase = type { %Expression, %Expression*, %Block }
%ModelProperty = type { i8*, %Expression, %SourceSpan* }
%FieldDeclaration = type { i8*, %TypeAnnotation, i1, %SourceSpan* }
%MethodDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%EnumVariant = type { i8*, { %FieldDeclaration*, i64 }*, %SourceSpan* }
%FunctionSignature = type { i8*, i1, { %Parameter*, i64 }*, %TypeAnnotation*, { i8**, i64 }*, { %TypeParameter*, i64 }*, %SourceSpan* }
%PipelineDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%ToolDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%TestDeclaration = type { i8*, %Block, { i8**, i64 }*, { %Decorator*, i64 }* }
%ModelDeclaration = type { i8*, %TypeAnnotation, { %ModelProperty*, i64 }*, { i8**, i64 }*, { %Decorator*, i64 }* }
%Decorator = type { i8*, { %DecoratorArgument*, i64 }* }
%DecoratorArgument = type { i8*, %Expression }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { %TokenKind, i8*, double, double }

%LiteralValue = type { i32, [8 x i8] }
%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }
%TokenKind = type { i32 }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare %Token @eof_token(double, double)
declare i8* @char_at(i8*, double)
declare i1 @is_symbol_char(i8*)
declare i8* @sanitize_symbol(i8*)

declare noalias i8* @malloc(i64)

@runtime__decorator_semantics = external global i8**

@.str.len2.h193495007 = private unnamed_addr constant [3 x i8] c"io\00"

declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

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
  %t52 = phi i1 [ %t6, %block.entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t7, %block.entry ], [ %t51, %loop.latch2 ]
  store i1 %t52, i1* %l1
  store double %t53, double* %l2
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
  %t17 = call double @llvm.round.f64(double %t16)
  %t18 = fptosi double %t17 to i64
  %t19 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %decorators
  %t20 = extractvalue { %DecoratorInfo*, i64 } %t19, 0
  %t21 = extractvalue { %DecoratorInfo*, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t18, i64 %t21)
  %t23 = getelementptr %DecoratorInfo, %DecoratorInfo* %t20, i64 %t18
  %t24 = load %DecoratorInfo, %DecoratorInfo* %t23
  store %DecoratorInfo %t24, %DecoratorInfo* %l3
  %t26 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t27 = extractvalue %DecoratorInfo %t26, 0
  %s28 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h515589823, i32 0, i32 0
  %t29 = call i1 @strings_equal(i8* %t27, i8* %s28)
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t29, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t31 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t32 = extractvalue %DecoratorInfo %t31, 0
  %s33 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1147459442, i32 0, i32 0
  %t34 = call i1 @strings_equal(i8* %t32, i8* %s33)
  br label %logical_or_entry_30

logical_or_entry_30:
  br i1 %t34, label %logical_or_merge_30, label %logical_or_right_30

logical_or_right_30:
  %t35 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t36 = extractvalue %DecoratorInfo %t35, 0
  %s37 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1170311443, i32 0, i32 0
  %t38 = call i1 @strings_equal(i8* %t36, i8* %s37)
  br label %logical_or_right_end_30

logical_or_right_end_30:
  br label %logical_or_merge_30

logical_or_merge_30:
  %t39 = phi i1 [ true, %logical_or_entry_30 ], [ %t38, %logical_or_right_end_30 ]
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t40 = phi i1 [ true, %logical_or_entry_25 ], [ %t39, %logical_or_right_end_25 ]
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i1, i1* %l1
  %t43 = load double, double* %l2
  %t44 = load %DecoratorInfo, %DecoratorInfo* %l3
  br i1 %t40, label %then6, label %merge7
then6:
  store i1 1, i1* %l1
  %t45 = load i1, i1* %l1
  br label %merge7
merge7:
  %t46 = phi i1 [ %t45, %then6 ], [ %t42, %logical_or_merge_25 ]
  store i1 %t46, i1* %l1
  %t47 = load double, double* %l2
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l2
  br label %loop.latch2
loop.latch2:
  %t50 = load i1, i1* %l1
  %t51 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t54 = load i1, i1* %l1
  %t55 = load double, double* %l2
  %t57 = load i1, i1* %l1
  br label %logical_and_entry_56

logical_and_entry_56:
  br i1 %t57, label %logical_and_right_56, label %logical_and_merge_56

logical_and_right_56:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s59 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t60 = call i1 @contains_effect({ i8**, i64 }* %t58, i8* %s59)
  %t61 = xor i1 %t60, 1
  br label %logical_and_right_end_56

logical_and_right_end_56:
  br label %logical_and_merge_56

logical_and_merge_56:
  %t62 = phi i1 [ false, %logical_and_entry_56 ], [ %t61, %logical_and_right_end_56 ]
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load i1, i1* %l1
  %t65 = load double, double* %l2
  br i1 %t62, label %then8, label %merge9
then8:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s67 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t68 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t66, i8* %s67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t70 = phi { i8**, i64 }* [ %t69, %then8 ], [ %t63, %logical_and_merge_56 ]
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t71
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
  %t46 = phi { %DecoratorInfo*, i64 }* [ %t13, %block.entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t14, %block.entry ], [ %t45, %loop.latch2 ]
  store { %DecoratorInfo*, i64 }* %t46, { %DecoratorInfo*, i64 }** %l0
  store double %t47, double* %l1
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
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %decorators
  %t26 = extractvalue { %Decorator*, i64 } %t25, 0
  %t27 = extractvalue { %Decorator*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %Decorator, %Decorator* %t26, i64 %t24
  %t30 = load %Decorator, %Decorator* %t29
  store %Decorator %t30, %Decorator* %l2
  %t31 = load %Decorator, %Decorator* %l2
  %t32 = extractvalue %Decorator %t31, 1
  %t33 = call { %DecoratorArgumentInfo*, i64 }* @evaluate_arguments({ %DecoratorArgument*, i64 }* %t32)
  store { %DecoratorArgumentInfo*, i64 }* %t33, { %DecoratorArgumentInfo*, i64 }** %l3
  %t34 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t35 = load %Decorator, %Decorator* %l2
  %t36 = extractvalue %Decorator %t35, 0
  %t37 = insertvalue %DecoratorInfo undef, i8* %t36, 0
  %t38 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l3
  %t39 = insertvalue %DecoratorInfo %t37, { %DecoratorArgumentInfo*, i64 }* %t38, 1
  %t40 = call { %DecoratorInfo*, i64 }* @append_decorator_info({ %DecoratorInfo*, i64 }* %t34, %DecoratorInfo %t39)
  store { %DecoratorInfo*, i64 }* %t40, { %DecoratorInfo*, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
loop.latch2:
  %t44 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t45 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t48 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  ret { %DecoratorInfo*, i64 }* %t50
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
  %t46 = phi { %DecoratorArgumentInfo*, i64 }* [ %t13, %block.entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t14, %block.entry ], [ %t45, %loop.latch2 ]
  store { %DecoratorArgumentInfo*, i64 }* %t46, { %DecoratorArgumentInfo*, i64 }** %l0
  store double %t47, double* %l1
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
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %DecoratorArgument*, i64 }, { %DecoratorArgument*, i64 }* %arguments
  %t26 = extractvalue { %DecoratorArgument*, i64 } %t25, 0
  %t27 = extractvalue { %DecoratorArgument*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %DecoratorArgument, %DecoratorArgument* %t26, i64 %t24
  %t30 = load %DecoratorArgument, %DecoratorArgument* %t29
  store %DecoratorArgument %t30, %DecoratorArgument* %l2
  %t31 = load %DecoratorArgument, %DecoratorArgument* %l2
  %t32 = extractvalue %DecoratorArgument %t31, 1
  %t33 = call %LiteralValue @evaluate_expression(%Expression %t32)
  store %LiteralValue %t33, %LiteralValue* %l3
  %t34 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t35 = load %DecoratorArgument, %DecoratorArgument* %l2
  %t36 = extractvalue %DecoratorArgument %t35, 0
  %t37 = insertvalue %DecoratorArgumentInfo undef, i8* %t36, 0
  %t38 = load %LiteralValue, %LiteralValue* %l3
  %t39 = insertvalue %DecoratorArgumentInfo %t37, %LiteralValue %t38, 1
  %t40 = call { %DecoratorArgumentInfo*, i64 }* @append_argument_info({ %DecoratorArgumentInfo*, i64 }* %t34, %DecoratorArgumentInfo %t39)
  store { %DecoratorArgumentInfo*, i64 }* %t40, { %DecoratorArgumentInfo*, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
loop.latch2:
  %t44 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t45 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t48 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  ret { %DecoratorArgumentInfo*, i64 }* %t50
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
  %t78 = bitcast i8* %t77 to { %Decorator*, i64 }**
  %t79 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t78
  %t80 = icmp eq i32 %t73, 3
  %t81 = select i1 %t80, { %Decorator*, i64 }* %t79, { %Decorator*, i64 }* null
  %t82 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t83 = bitcast [88 x i8]* %t82 to i8*
  %t84 = getelementptr inbounds i8, i8* %t83, i64 80
  %t85 = bitcast i8* %t84 to { %Decorator*, i64 }**
  %t86 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t85
  %t87 = icmp eq i32 %t73, 4
  %t88 = select i1 %t87, { %Decorator*, i64 }* %t86, { %Decorator*, i64 }* %t81
  %t89 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t90 = bitcast [88 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 80
  %t92 = bitcast i8* %t91 to { %Decorator*, i64 }**
  %t93 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t92
  %t94 = icmp eq i32 %t73, 5
  %t95 = select i1 %t94, { %Decorator*, i64 }* %t93, { %Decorator*, i64 }* %t88
  %t96 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t97 = bitcast [56 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 48
  %t99 = bitcast i8* %t98 to { %Decorator*, i64 }**
  %t100 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t99
  %t101 = icmp eq i32 %t73, 6
  %t102 = select i1 %t101, { %Decorator*, i64 }* %t100, { %Decorator*, i64 }* %t95
  %t103 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t104 = bitcast [88 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 80
  %t106 = bitcast i8* %t105 to { %Decorator*, i64 }**
  %t107 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t106
  %t108 = icmp eq i32 %t73, 7
  %t109 = select i1 %t108, { %Decorator*, i64 }* %t107, { %Decorator*, i64 }* %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t111 = bitcast [56 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 48
  %t113 = bitcast i8* %t112 to { %Decorator*, i64 }**
  %t114 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t113
  %t115 = icmp eq i32 %t73, 8
  %t116 = select i1 %t115, { %Decorator*, i64 }* %t114, { %Decorator*, i64 }* %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t118 = bitcast [40 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 32
  %t120 = bitcast i8* %t119 to { %Decorator*, i64 }**
  %t121 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t120
  %t122 = icmp eq i32 %t73, 9
  %t123 = select i1 %t122, { %Decorator*, i64 }* %t121, { %Decorator*, i64 }* %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t125 = bitcast [40 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 32
  %t127 = bitcast i8* %t126 to { %Decorator*, i64 }**
  %t128 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t127
  %t129 = icmp eq i32 %t73, 10
  %t130 = select i1 %t129, { %Decorator*, i64 }* %t128, { %Decorator*, i64 }* %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t132 = bitcast [40 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 32
  %t134 = bitcast i8* %t133 to { %Decorator*, i64 }**
  %t135 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t134
  %t136 = icmp eq i32 %t73, 11
  %t137 = select i1 %t136, { %Decorator*, i64 }* %t135, { %Decorator*, i64 }* %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t139 = bitcast [120 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 112
  %t141 = bitcast i8* %t140 to { %Decorator*, i64 }**
  %t142 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t141
  %t143 = icmp eq i32 %t73, 12
  %t144 = select i1 %t143, { %Decorator*, i64 }* %t142, { %Decorator*, i64 }* %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t146 = bitcast [40 x i8]* %t145 to i8*
  %t147 = getelementptr inbounds i8, i8* %t146, i64 32
  %t148 = bitcast i8* %t147 to { %Decorator*, i64 }**
  %t149 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t148
  %t150 = icmp eq i32 %t73, 13
  %t151 = select i1 %t150, { %Decorator*, i64 }* %t149, { %Decorator*, i64 }* %t144
  %t152 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t153 = bitcast [136 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 128
  %t155 = bitcast i8* %t154 to { %Decorator*, i64 }**
  %t156 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t155
  %t157 = icmp eq i32 %t73, 14
  %t158 = select i1 %t157, { %Decorator*, i64 }* %t156, { %Decorator*, i64 }* %t151
  %t159 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t160 = bitcast [32 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 24
  %t162 = bitcast i8* %t161 to { %Decorator*, i64 }**
  %t163 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t162
  %t164 = icmp eq i32 %t73, 15
  %t165 = select i1 %t164, { %Decorator*, i64 }* %t163, { %Decorator*, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t167 = bitcast [64 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 56
  %t169 = bitcast i8* %t168 to { %Decorator*, i64 }**
  %t170 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t169
  %t171 = icmp eq i32 %t73, 18
  %t172 = select i1 %t171, { %Decorator*, i64 }* %t170, { %Decorator*, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t174 = bitcast [88 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 80
  %t176 = bitcast i8* %t175 to { %Decorator*, i64 }**
  %t177 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t176
  %t178 = icmp eq i32 %t73, 19
  %t179 = select i1 %t178, { %Decorator*, i64 }* %t177, { %Decorator*, i64 }* %t172
  %t180 = call { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* %t179)
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
  %s252 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t253 = call i1 @strings_equal(i8* %t251, i8* %s252)
  br i1 %t253, label %then2, label %merge3
then2:
  %t254 = extractvalue %Statement %statement, 0
  %t255 = alloca %Statement
  store %Statement %statement, %Statement* %t255
  %t256 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t257 = bitcast [48 x i8]* %t256 to i8*
  %t258 = getelementptr inbounds i8, i8* %t257, i64 40
  %t259 = bitcast i8* %t258 to { %Decorator*, i64 }**
  %t260 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t259
  %t261 = icmp eq i32 %t254, 3
  %t262 = select i1 %t261, { %Decorator*, i64 }* %t260, { %Decorator*, i64 }* null
  %t263 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t264 = bitcast [88 x i8]* %t263 to i8*
  %t265 = getelementptr inbounds i8, i8* %t264, i64 80
  %t266 = bitcast i8* %t265 to { %Decorator*, i64 }**
  %t267 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t266
  %t268 = icmp eq i32 %t254, 4
  %t269 = select i1 %t268, { %Decorator*, i64 }* %t267, { %Decorator*, i64 }* %t262
  %t270 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t271 = bitcast [88 x i8]* %t270 to i8*
  %t272 = getelementptr inbounds i8, i8* %t271, i64 80
  %t273 = bitcast i8* %t272 to { %Decorator*, i64 }**
  %t274 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t273
  %t275 = icmp eq i32 %t254, 5
  %t276 = select i1 %t275, { %Decorator*, i64 }* %t274, { %Decorator*, i64 }* %t269
  %t277 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t278 = bitcast [56 x i8]* %t277 to i8*
  %t279 = getelementptr inbounds i8, i8* %t278, i64 48
  %t280 = bitcast i8* %t279 to { %Decorator*, i64 }**
  %t281 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t280
  %t282 = icmp eq i32 %t254, 6
  %t283 = select i1 %t282, { %Decorator*, i64 }* %t281, { %Decorator*, i64 }* %t276
  %t284 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t285 = bitcast [88 x i8]* %t284 to i8*
  %t286 = getelementptr inbounds i8, i8* %t285, i64 80
  %t287 = bitcast i8* %t286 to { %Decorator*, i64 }**
  %t288 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t287
  %t289 = icmp eq i32 %t254, 7
  %t290 = select i1 %t289, { %Decorator*, i64 }* %t288, { %Decorator*, i64 }* %t283
  %t291 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t292 = bitcast [56 x i8]* %t291 to i8*
  %t293 = getelementptr inbounds i8, i8* %t292, i64 48
  %t294 = bitcast i8* %t293 to { %Decorator*, i64 }**
  %t295 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t294
  %t296 = icmp eq i32 %t254, 8
  %t297 = select i1 %t296, { %Decorator*, i64 }* %t295, { %Decorator*, i64 }* %t290
  %t298 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t299 = bitcast [40 x i8]* %t298 to i8*
  %t300 = getelementptr inbounds i8, i8* %t299, i64 32
  %t301 = bitcast i8* %t300 to { %Decorator*, i64 }**
  %t302 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t301
  %t303 = icmp eq i32 %t254, 9
  %t304 = select i1 %t303, { %Decorator*, i64 }* %t302, { %Decorator*, i64 }* %t297
  %t305 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t306 = bitcast [40 x i8]* %t305 to i8*
  %t307 = getelementptr inbounds i8, i8* %t306, i64 32
  %t308 = bitcast i8* %t307 to { %Decorator*, i64 }**
  %t309 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t308
  %t310 = icmp eq i32 %t254, 10
  %t311 = select i1 %t310, { %Decorator*, i64 }* %t309, { %Decorator*, i64 }* %t304
  %t312 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t313 = bitcast [40 x i8]* %t312 to i8*
  %t314 = getelementptr inbounds i8, i8* %t313, i64 32
  %t315 = bitcast i8* %t314 to { %Decorator*, i64 }**
  %t316 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t315
  %t317 = icmp eq i32 %t254, 11
  %t318 = select i1 %t317, { %Decorator*, i64 }* %t316, { %Decorator*, i64 }* %t311
  %t319 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t320 = bitcast [120 x i8]* %t319 to i8*
  %t321 = getelementptr inbounds i8, i8* %t320, i64 112
  %t322 = bitcast i8* %t321 to { %Decorator*, i64 }**
  %t323 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t322
  %t324 = icmp eq i32 %t254, 12
  %t325 = select i1 %t324, { %Decorator*, i64 }* %t323, { %Decorator*, i64 }* %t318
  %t326 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t327 = bitcast [40 x i8]* %t326 to i8*
  %t328 = getelementptr inbounds i8, i8* %t327, i64 32
  %t329 = bitcast i8* %t328 to { %Decorator*, i64 }**
  %t330 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t329
  %t331 = icmp eq i32 %t254, 13
  %t332 = select i1 %t331, { %Decorator*, i64 }* %t330, { %Decorator*, i64 }* %t325
  %t333 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t334 = bitcast [136 x i8]* %t333 to i8*
  %t335 = getelementptr inbounds i8, i8* %t334, i64 128
  %t336 = bitcast i8* %t335 to { %Decorator*, i64 }**
  %t337 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t336
  %t338 = icmp eq i32 %t254, 14
  %t339 = select i1 %t338, { %Decorator*, i64 }* %t337, { %Decorator*, i64 }* %t332
  %t340 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t341 = bitcast [32 x i8]* %t340 to i8*
  %t342 = getelementptr inbounds i8, i8* %t341, i64 24
  %t343 = bitcast i8* %t342 to { %Decorator*, i64 }**
  %t344 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t343
  %t345 = icmp eq i32 %t254, 15
  %t346 = select i1 %t345, { %Decorator*, i64 }* %t344, { %Decorator*, i64 }* %t339
  %t347 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t348 = bitcast [64 x i8]* %t347 to i8*
  %t349 = getelementptr inbounds i8, i8* %t348, i64 56
  %t350 = bitcast i8* %t349 to { %Decorator*, i64 }**
  %t351 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t350
  %t352 = icmp eq i32 %t254, 18
  %t353 = select i1 %t352, { %Decorator*, i64 }* %t351, { %Decorator*, i64 }* %t346
  %t354 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t355 = bitcast [88 x i8]* %t354 to i8*
  %t356 = getelementptr inbounds i8, i8* %t355, i64 80
  %t357 = bitcast i8* %t356 to { %Decorator*, i64 }**
  %t358 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t357
  %t359 = icmp eq i32 %t254, 19
  %t360 = select i1 %t359, { %Decorator*, i64 }* %t358, { %Decorator*, i64 }* %t353
  %t361 = call { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* %t360)
  ret { %DecoratorInfo*, i64 }* %t361
merge3:
  %t362 = getelementptr [0 x %DecoratorInfo], [0 x %DecoratorInfo]* null, i32 1
  %t363 = ptrtoint [0 x %DecoratorInfo]* %t362 to i64
  %t364 = icmp eq i64 %t363, 0
  %t365 = select i1 %t364, i64 1, i64 %t363
  %t366 = call i8* @malloc(i64 %t365)
  %t367 = bitcast i8* %t366 to %DecoratorInfo*
  %t368 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* null, i32 1
  %t369 = ptrtoint { %DecoratorInfo*, i64 }* %t368 to i64
  %t370 = call i8* @malloc(i64 %t369)
  %t371 = bitcast i8* %t370 to { %DecoratorInfo*, i64 }*
  %t372 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t371, i32 0, i32 0
  store %DecoratorInfo* %t367, %DecoratorInfo** %t372
  %t373 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t371, i32 0, i32 1
  store i64 0, i64* %t373
  ret { %DecoratorInfo*, i64 }* %t371
}

define i8* @trim_whitespace(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t22 = phi double [ %t3, %block.entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
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
  %t11 = call i8* @char_at(i8* %value, double %t10)
  %t12 = call double @char_code(i8* %t11)
  store double %t12, double* %l2
  %t13 = load double, double* %l2
  %t14 = call i1 @is_whitespace_codepoint(double %t13)
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t23 = load double, double* %l0
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t47 = phi double [ %t25, %afterloop3 ], [ %t46, %loop.latch10 ]
  store double %t47, double* %l1
  br label %loop.body9
loop.body9:
  %t26 = load double, double* %l1
  %t27 = load double, double* %l0
  %t28 = fcmp ole double %t26, %t27
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br i1 %t28, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fsub double %t31, %t32
  store double %t33, double* %l3
  %t34 = load double, double* %l3
  %t35 = call i8* @char_at(i8* %value, double %t34)
  %t36 = call double @char_code(i8* %t35)
  store double %t36, double* %l4
  %t37 = load double, double* %l4
  %t38 = call i1 @is_whitespace_codepoint(double %t37)
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  %t41 = load double, double* %l3
  %t42 = load double, double* %l4
  br i1 %t38, label %then14, label %merge15
then14:
  %t43 = load double, double* %l1
  %t44 = sitofp i64 1 to double
  %t45 = fsub double %t43, %t44
  store double %t45, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t46 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t48 = load double, double* %l1
  %t49 = load double, double* %l0
  %t50 = load double, double* %l1
  %t51 = call i8* @slice_text(i8* %value, double %t49, double %t50)
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  ret i8* %t51
}

define i1 @looks_like_quoted_string(i8* %text) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i64
  %l2 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = sitofp i64 0 to double
  %t3 = call i8* @char_at(i8* %text, double %t2)
  %t4 = call double @char_code(i8* %t3)
  store double %t4, double* %l0
  %t5 = load double, double* %l0
  %t6 = sitofp i64 34 to double
  %t7 = fcmp une double %t5, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t9 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t10 = sub i64 %t9, 1
  store i64 %t10, i64* %l1
  %t11 = load i64, i64* %l1
  %t12 = sitofp i64 %t11 to double
  %t13 = call i8* @char_at(i8* %text, double %t12)
  %t14 = call double @char_code(i8* %t13)
  store double %t14, double* %l2
  %t15 = load double, double* %l2
  %t16 = sitofp i64 34 to double
  %t17 = fcmp une double %t15, %t16
  %t18 = load double, double* %l0
  %t19 = load i64, i64* %l1
  %t20 = load double, double* %l2
  br i1 %t17, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  ret i1 1
}

define i1 @looks_like_number(i8* %text) {
block.entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  store i1 0, i1* %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = sitofp i64 0 to double
  %t4 = call i8* @char_at(i8* %text, double %t3)
  %t5 = call double @char_code(i8* %t4)
  store double %t5, double* %l2
  %t6 = load double, double* %l2
  %t7 = sitofp i64 45 to double
  %t8 = fcmp oeq double %t6, %t7
  %t9 = load i1, i1* %l0
  %t10 = load double, double* %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then2, label %merge3
then2:
  %t12 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t13 = icmp eq i64 %t12, 1
  %t14 = load i1, i1* %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t17 = sitofp i64 1 to double
  store double %t17, double* %l1
  %t18 = load double, double* %l1
  br label %merge3
merge3:
  %t19 = phi double [ %t18, %merge5 ], [ %t10, %merge1 ]
  store double %t19, double* %l1
  %t20 = load i1, i1* %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  br label %loop.header6
loop.header6:
  %t60 = phi i1 [ %t20, %merge3 ], [ %t58, %loop.latch8 ]
  %t61 = phi double [ %t21, %merge3 ], [ %t59, %loop.latch8 ]
  store i1 %t60, i1* %l0
  store double %t61, double* %l1
  br label %loop.body7
loop.body7:
  %t23 = load double, double* %l1
  %t24 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp oge double %t23, %t25
  %t27 = load i1, i1* %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  br i1 %t26, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t30 = load double, double* %l1
  %t31 = call i8* @char_at(i8* %text, double %t30)
  %t32 = call double @char_code(i8* %t31)
  store double %t32, double* %l3
  %t33 = load double, double* %l3
  %t34 = sitofp i64 46 to double
  %t35 = fcmp oeq double %t33, %t34
  %t36 = load i1, i1* %l0
  %t37 = load double, double* %l1
  %t38 = load double, double* %l2
  %t39 = load double, double* %l3
  br i1 %t35, label %then12, label %merge13
then12:
  %t40 = load i1, i1* %l0
  %t41 = load i1, i1* %l0
  %t42 = load double, double* %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
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
  %t48 = load double, double* %l3
  %t49 = call i1 @is_decimal_digit_codepoint(double %t48)
  %t50 = xor i1 %t49, 1
  %t51 = load i1, i1* %l0
  %t52 = load double, double* %l1
  %t53 = load double, double* %l2
  %t54 = load double, double* %l3
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

define i1 @is_decimal_digit_codepoint(double %ch) {
block.entry:
  %t1 = sitofp i64 48 to double
  %t2 = fcmp oge double %ch, %t1
  br label %logical_and_entry_0

logical_and_entry_0:
  br i1 %t2, label %logical_and_right_0, label %logical_and_merge_0

logical_and_right_0:
  %t3 = sitofp i64 57 to double
  %t4 = fcmp ole double %ch, %t3
  br label %logical_and_right_end_0

logical_and_right_end_0:
  br label %logical_and_merge_0

logical_and_merge_0:
  %t5 = phi i1 [ false, %logical_and_entry_0 ], [ %t4, %logical_and_right_end_0 ]
  ret i1 %t5
}

define { %DecoratorInfo*, i64 }* @append_decorator_info({ %DecoratorInfo*, i64 }* %collection, %DecoratorInfo %item) {
block.entry:
  %t0 = getelementptr [1 x %DecoratorInfo], [1 x %DecoratorInfo]* null, i32 1
  %t1 = ptrtoint [1 x %DecoratorInfo]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %DecoratorInfo*
  %t6 = getelementptr %DecoratorInfo, %DecoratorInfo* %t5, i64 0
  store %DecoratorInfo %item, %DecoratorInfo* %t6
  %t7 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* null, i32 1
  %t8 = ptrtoint { %DecoratorInfo*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %DecoratorInfo*, i64 }*
  %t11 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t10, i32 0, i32 0
  store %DecoratorInfo* %t5, %DecoratorInfo** %t11
  %t12 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %collection, i32 0, i32 0
  %t14 = load %DecoratorInfo*, %DecoratorInfo** %t13
  %t15 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %collection, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t10, i32 0, i32 0
  %t18 = load %DecoratorInfo*, %DecoratorInfo** %t17
  %t19 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %DecoratorInfo], [1 x %DecoratorInfo]* null, i32 0, i32 1
  %t22 = ptrtoint %DecoratorInfo* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %DecoratorInfo*
  %t27 = bitcast %DecoratorInfo* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %DecoratorInfo* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %DecoratorInfo* %t18 to i8*
  %t32 = getelementptr %DecoratorInfo, %DecoratorInfo* %t26, i64 %t16
  %t33 = bitcast %DecoratorInfo* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* null, i32 1
  %t35 = ptrtoint { %DecoratorInfo*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %DecoratorInfo*, i64 }*
  %t38 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t37, i32 0, i32 0
  store %DecoratorInfo* %t26, %DecoratorInfo** %t38
  %t39 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %DecoratorInfo*, i64 }* %t37
}

define { %DecoratorArgumentInfo*, i64 }* @append_argument_info({ %DecoratorArgumentInfo*, i64 }* %collection, %DecoratorArgumentInfo %item) {
block.entry:
  %t0 = getelementptr [1 x %DecoratorArgumentInfo], [1 x %DecoratorArgumentInfo]* null, i32 1
  %t1 = ptrtoint [1 x %DecoratorArgumentInfo]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %DecoratorArgumentInfo*
  %t6 = getelementptr %DecoratorArgumentInfo, %DecoratorArgumentInfo* %t5, i64 0
  store %DecoratorArgumentInfo %item, %DecoratorArgumentInfo* %t6
  %t7 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* null, i32 1
  %t8 = ptrtoint { %DecoratorArgumentInfo*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %DecoratorArgumentInfo*, i64 }*
  %t11 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t10, i32 0, i32 0
  store %DecoratorArgumentInfo* %t5, %DecoratorArgumentInfo** %t11
  %t12 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %collection, i32 0, i32 0
  %t14 = load %DecoratorArgumentInfo*, %DecoratorArgumentInfo** %t13
  %t15 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %collection, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t10, i32 0, i32 0
  %t18 = load %DecoratorArgumentInfo*, %DecoratorArgumentInfo** %t17
  %t19 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %DecoratorArgumentInfo], [1 x %DecoratorArgumentInfo]* null, i32 0, i32 1
  %t22 = ptrtoint %DecoratorArgumentInfo* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %DecoratorArgumentInfo*
  %t27 = bitcast %DecoratorArgumentInfo* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %DecoratorArgumentInfo* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %DecoratorArgumentInfo* %t18 to i8*
  %t32 = getelementptr %DecoratorArgumentInfo, %DecoratorArgumentInfo* %t26, i64 %t16
  %t33 = bitcast %DecoratorArgumentInfo* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* null, i32 1
  %t35 = ptrtoint { %DecoratorArgumentInfo*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %DecoratorArgumentInfo*, i64 }*
  %t38 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t37, i32 0, i32 0
  store %DecoratorArgumentInfo* %t26, %DecoratorArgumentInfo** %t38
  %t39 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %DecoratorArgumentInfo*, i64 }* %t37
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
  %t38 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t14, %block.entry ], [ %t37, %loop.latch2 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
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
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  %t32 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch2
loop.latch2:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t42
}

define i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect) {
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
  %t9 = call double @llvm.round.f64(double %t8)
  %t10 = fptosi double %t9 to i64
  %t11 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = call i1 @strings_equal(i8* %t16, i8* %effect)
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

define i1 @is_whitespace_codepoint(double %ch) {
block.entry:
  %t1 = sitofp i64 32 to double
  %t2 = fcmp oeq double %ch, %t1
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t4 = sitofp i64 9 to double
  %t5 = fcmp oeq double %ch, %t4
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = sitofp i64 10 to double
  %t8 = fcmp oeq double %ch, %t7
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t9 = sitofp i64 13 to double
  %t10 = fcmp oeq double %ch, %t9
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t11 = phi i1 [ true, %logical_or_entry_6 ], [ %t10, %logical_or_right_end_6 ]
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t12 = phi i1 [ true, %logical_or_entry_3 ], [ %t11, %logical_or_right_end_3 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t13 = phi i1 [ true, %logical_or_entry_0 ], [ %t12, %logical_or_right_end_0 ]
  ret i1 %t13
}

define i8* @slice_text(i8* %text, double %start, double %end) {
block.entry:
  %t0 = call double @llvm.round.f64(double %start)
  %t1 = fptosi double %t0 to i64
  %t2 = call double @llvm.round.f64(double %end)
  %t3 = fptosi double %t2 to i64
  %t4 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t1, i64 %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  ret i8* %t4
}

define i8* @strip_surrounding_quotes(i8* %value) {
block.entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sub i64 %t2, 1
  %t4 = sitofp i64 1 to double
  %t5 = sitofp i64 %t3 to double
  %t6 = call i8* @slice_text(i8* %value, double %t4, double %t5)
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  ret i8* %t6
}

define double @add__decorator_semantics(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.enum.Expression.Call.variant = private unnamed_addr constant [5 x i8] c"Call\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len13.h1570408460 = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.Expression.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Expression.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.Expression.Array.variant = private unnamed_addr constant [6 x i8] c"Array\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.enum.Expression.Object.variant = private unnamed_addr constant [7 x i8] c"Object\00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Expression.Unary.variant = private unnamed_addr constant [6 x i8] c"Unary\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.str.len3.h2089530004 = private unnamed_addr constant [4 x i8] c"Raw\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Expression.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len14.h1318614710 = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.str.len12.h1147459442 = private unnamed_addr constant [13 x i8] c"logExecution\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.enum.Expression.NullLiteral.variant = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.enum.Expression.Lambda.variant = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.enum.Expression.Range.variant = private unnamed_addr constant [6 x i8] c"Range\00"
@.str.len5.h515589823 = private unnamed_addr constant [6 x i8] c"trace\00"
@.enum.Expression.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Expression.Raw.variant = private unnamed_addr constant [4 x i8] c"Raw\00"
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.str.len11.h1571993816 = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Expression.Binary.variant = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.enum.Expression.Struct.variant = private unnamed_addr constant [7 x i8] c"Struct\00"
@.enum.Expression.Index.variant = private unnamed_addr constant [6 x i8] c"Index\00"
@.enum.Expression.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len12.h1170311443 = private unnamed_addr constant [13 x i8] c"logexecution\00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.enum.Expression.Member.variant = private unnamed_addr constant [7 x i8] c"Member\00"
@.str.len13.h590768815 = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"