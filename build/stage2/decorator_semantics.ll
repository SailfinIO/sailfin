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
declare i8* @sailfin_runtime_number_to_string(double)
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

@runtime = external global i8**

@.enum.Expression.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Expression.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.Expression.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.Expression.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Expression.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.Expression.NullLiteral.variant = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.enum.Expression.Unary.variant = private unnamed_addr constant [6 x i8] c"Unary\00"
@.enum.Expression.Binary.variant = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Expression.Member.variant = private unnamed_addr constant [7 x i8] c"Member\00"
@.enum.Expression.Call.variant = private unnamed_addr constant [5 x i8] c"Call\00"
@.enum.Expression.Index.variant = private unnamed_addr constant [6 x i8] c"Index\00"
@.enum.Expression.Array.variant = private unnamed_addr constant [6 x i8] c"Array\00"
@.enum.Expression.Object.variant = private unnamed_addr constant [7 x i8] c"Object\00"
@.enum.Expression.Struct.variant = private unnamed_addr constant [7 x i8] c"Struct\00"
@.enum.Expression.Lambda.variant = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.enum.Expression.Range.variant = private unnamed_addr constant [6 x i8] c"Range\00"
@.enum.Expression.Raw.variant = private unnamed_addr constant [4 x i8] c"Raw\00"
@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"

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
  %t2 = call i8* @malloc(i64 3)
  %t3 = bitcast i8* %t2 to [3 x i8]*
  store [3 x i8] c"io\00", [3 x i8]* %t3
  %t4 = call i1 @contains_effect({ i8**, i64 }* %t1, i8* %t2)
  store i1 %t4, i1* %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load i1, i1* %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t56 = phi i1 [ %t7, %block.entry ], [ %t54, %loop.latch2 ]
  %t57 = phi double [ %t8, %block.entry ], [ %t55, %loop.latch2 ]
  store i1 %t56, i1* %l1
  store double %t57, double* %l2
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %decorators
  %t11 = extractvalue { %DecoratorInfo*, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t9, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i1, i1* %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load double, double* %l2
  %t18 = call double @llvm.round.f64(double %t17)
  %t19 = fptosi double %t18 to i64
  %t20 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %decorators
  %t21 = extractvalue { %DecoratorInfo*, i64 } %t20, 0
  %t22 = extractvalue { %DecoratorInfo*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t19, i64 %t22)
  %t24 = getelementptr %DecoratorInfo, %DecoratorInfo* %t21, i64 %t19
  %t25 = load %DecoratorInfo, %DecoratorInfo* %t24
  store %DecoratorInfo %t25, %DecoratorInfo* %l3
  %t27 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t28 = extractvalue %DecoratorInfo %t27, 0
  %t29 = call i8* @malloc(i64 6)
  %t30 = bitcast i8* %t29 to [6 x i8]*
  store [6 x i8] c"trace\00", [6 x i8]* %t30
  %t31 = call i1 @strings_equal(i8* %t28, i8* %t29)
  br label %logical_or_entry_26

logical_or_entry_26:
  br i1 %t31, label %logical_or_merge_26, label %logical_or_right_26

logical_or_right_26:
  %t33 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t34 = extractvalue %DecoratorInfo %t33, 0
  %t35 = call i8* @malloc(i64 13)
  %t36 = bitcast i8* %t35 to [13 x i8]*
  store [13 x i8] c"logExecution\00", [13 x i8]* %t36
  %t37 = call i1 @strings_equal(i8* %t34, i8* %t35)
  br label %logical_or_entry_32

logical_or_entry_32:
  br i1 %t37, label %logical_or_merge_32, label %logical_or_right_32

logical_or_right_32:
  %t38 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t39 = extractvalue %DecoratorInfo %t38, 0
  %t40 = call i8* @malloc(i64 13)
  %t41 = bitcast i8* %t40 to [13 x i8]*
  store [13 x i8] c"logexecution\00", [13 x i8]* %t41
  %t42 = call i1 @strings_equal(i8* %t39, i8* %t40)
  br label %logical_or_right_end_32

logical_or_right_end_32:
  br label %logical_or_merge_32

logical_or_merge_32:
  %t43 = phi i1 [ true, %logical_or_entry_32 ], [ %t42, %logical_or_right_end_32 ]
  br label %logical_or_right_end_26

logical_or_right_end_26:
  br label %logical_or_merge_26

logical_or_merge_26:
  %t44 = phi i1 [ true, %logical_or_entry_26 ], [ %t43, %logical_or_right_end_26 ]
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load i1, i1* %l1
  %t47 = load double, double* %l2
  %t48 = load %DecoratorInfo, %DecoratorInfo* %l3
  br i1 %t44, label %then6, label %merge7
then6:
  store i1 1, i1* %l1
  %t49 = load i1, i1* %l1
  br label %merge7
merge7:
  %t50 = phi i1 [ %t49, %then6 ], [ %t46, %logical_or_merge_26 ]
  store i1 %t50, i1* %l1
  %t51 = load double, double* %l2
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l2
  br label %loop.latch2
loop.latch2:
  %t54 = load i1, i1* %l1
  %t55 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t58 = load i1, i1* %l1
  %t59 = load double, double* %l2
  %t61 = load i1, i1* %l1
  br label %logical_and_entry_60

logical_and_entry_60:
  br i1 %t61, label %logical_and_right_60, label %logical_and_merge_60

logical_and_right_60:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = call i8* @malloc(i64 3)
  %t64 = bitcast i8* %t63 to [3 x i8]*
  store [3 x i8] c"io\00", [3 x i8]* %t64
  %t65 = call i1 @contains_effect({ i8**, i64 }* %t62, i8* %t63)
  %t66 = xor i1 %t65, 1
  br label %logical_and_right_end_60

logical_and_right_end_60:
  br label %logical_and_merge_60

logical_and_merge_60:
  %t67 = phi i1 [ false, %logical_and_entry_60 ], [ %t66, %logical_and_right_end_60 ]
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load i1, i1* %l1
  %t70 = load double, double* %l2
  br i1 %t67, label %then8, label %merge9
then8:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = call i8* @malloc(i64 3)
  %t73 = bitcast i8* %t72 to [3 x i8]*
  store [3 x i8] c"io\00", [3 x i8]* %t73
  %t74 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t71, i8* %t72)
  store { i8**, i64 }* %t74, { i8**, i64 }** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t76 = phi { i8**, i64 }* [ %t75, %then8 ], [ %t68, %logical_and_merge_60 ]
  store { i8**, i64 }* %t76, { i8**, i64 }** %l0
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t77
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
  %t50 = call i8* @malloc(i64 14)
  %t51 = bitcast i8* %t50 to [14 x i8]*
  store [14 x i8] c"StringLiteral\00", [14 x i8]* %t51
  %t52 = call i1 @strings_equal(i8* %t49, i8* %t50)
  br i1 %t52, label %then0, label %merge1
then0:
  %t53 = alloca %LiteralValue
  %t54 = getelementptr inbounds %LiteralValue, %LiteralValue* %t53, i32 0, i32 0
  store i32 0, i32* %t54
  %t55 = extractvalue %Expression %expr, 0
  %t56 = alloca %Expression
  store %Expression %expr, %Expression* %t56
  %t57 = getelementptr inbounds %Expression, %Expression* %t56, i32 0, i32 1
  %t58 = bitcast [8 x i8]* %t57 to i8*
  %t59 = bitcast i8* %t58 to i8**
  %t60 = load i8*, i8** %t59
  %t61 = icmp eq i32 %t55, 1
  %t62 = select i1 %t61, i8* %t60, i8* null
  %t63 = getelementptr inbounds %Expression, %Expression* %t56, i32 0, i32 1
  %t64 = bitcast [8 x i8]* %t63 to i8*
  %t65 = bitcast i8* %t64 to i8**
  %t66 = load i8*, i8** %t65
  %t67 = icmp eq i32 %t55, 2
  %t68 = select i1 %t67, i8* %t66, i8* %t62
  %t69 = getelementptr inbounds %Expression, %Expression* %t56, i32 0, i32 1
  %t70 = bitcast [8 x i8]* %t69 to i8*
  %t71 = bitcast i8* %t70 to i8**
  %t72 = load i8*, i8** %t71
  %t73 = icmp eq i32 %t55, 3
  %t74 = select i1 %t73, i8* %t72, i8* %t68
  %t75 = getelementptr inbounds %LiteralValue, %LiteralValue* %t53, i32 0, i32 1
  %t76 = bitcast [8 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to i8**
  store i8* %t74, i8** %t77
  %t78 = load %LiteralValue, %LiteralValue* %t53
  ret %LiteralValue %t78
merge1:
  %t79 = extractvalue %Expression %expr, 0
  %t80 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t81 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t79, 0
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t79, 1
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t79, 2
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t79, 3
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t79, 4
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t79, 5
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t79, 6
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t79, 7
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t79, 8
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t79, 9
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t79, 10
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t79, 11
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t79, 12
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t79, 13
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t79, 14
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t79, 15
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = call i8* @malloc(i64 15)
  %t130 = bitcast i8* %t129 to [15 x i8]*
  store [15 x i8] c"BooleanLiteral\00", [15 x i8]* %t130
  %t131 = call i1 @strings_equal(i8* %t128, i8* %t129)
  br i1 %t131, label %then2, label %merge3
then2:
  %t132 = alloca %LiteralValue
  %t133 = getelementptr inbounds %LiteralValue, %LiteralValue* %t132, i32 0, i32 0
  store i32 1, i32* %t133
  %t134 = extractvalue %Expression %expr, 0
  %t135 = alloca %Expression
  store %Expression %expr, %Expression* %t135
  %t136 = getelementptr inbounds %Expression, %Expression* %t135, i32 0, i32 1
  %t137 = bitcast [8 x i8]* %t136 to i8*
  %t138 = bitcast i8* %t137 to i8**
  %t139 = load i8*, i8** %t138
  %t140 = icmp eq i32 %t134, 1
  %t141 = select i1 %t140, i8* %t139, i8* null
  %t142 = getelementptr inbounds %Expression, %Expression* %t135, i32 0, i32 1
  %t143 = bitcast [8 x i8]* %t142 to i8*
  %t144 = bitcast i8* %t143 to i8**
  %t145 = load i8*, i8** %t144
  %t146 = icmp eq i32 %t134, 2
  %t147 = select i1 %t146, i8* %t145, i8* %t141
  %t148 = getelementptr inbounds %Expression, %Expression* %t135, i32 0, i32 1
  %t149 = bitcast [8 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t134, 3
  %t153 = select i1 %t152, i8* %t151, i8* %t147
  %t154 = getelementptr inbounds %LiteralValue, %LiteralValue* %t132, i32 0, i32 1
  %t155 = bitcast [8 x i8]* %t154 to i8*
  %t156 = bitcast i8* %t155 to i8**
  store i8* %t153, i8** %t156
  %t157 = load %LiteralValue, %LiteralValue* %t132
  ret %LiteralValue %t157
merge3:
  %t158 = extractvalue %Expression %expr, 0
  %t159 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t160 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t158, 0
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t158, 1
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t158, 2
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t158, 3
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t158, 4
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t158, 5
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t158, 6
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t158, 7
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t158, 8
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t158, 9
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t158, 10
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t158, 11
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t158, 12
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t158, 13
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t158, 14
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t158, 15
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = call i8* @malloc(i64 14)
  %t209 = bitcast i8* %t208 to [14 x i8]*
  store [14 x i8] c"NumberLiteral\00", [14 x i8]* %t209
  %t210 = call i1 @strings_equal(i8* %t207, i8* %t208)
  br i1 %t210, label %then4, label %merge5
then4:
  %t211 = alloca %LiteralValue
  %t212 = getelementptr inbounds %LiteralValue, %LiteralValue* %t211, i32 0, i32 0
  store i32 2, i32* %t212
  %t213 = extractvalue %Expression %expr, 0
  %t214 = alloca %Expression
  store %Expression %expr, %Expression* %t214
  %t215 = getelementptr inbounds %Expression, %Expression* %t214, i32 0, i32 1
  %t216 = bitcast [8 x i8]* %t215 to i8*
  %t217 = bitcast i8* %t216 to i8**
  %t218 = load i8*, i8** %t217
  %t219 = icmp eq i32 %t213, 1
  %t220 = select i1 %t219, i8* %t218, i8* null
  %t221 = getelementptr inbounds %Expression, %Expression* %t214, i32 0, i32 1
  %t222 = bitcast [8 x i8]* %t221 to i8*
  %t223 = bitcast i8* %t222 to i8**
  %t224 = load i8*, i8** %t223
  %t225 = icmp eq i32 %t213, 2
  %t226 = select i1 %t225, i8* %t224, i8* %t220
  %t227 = getelementptr inbounds %Expression, %Expression* %t214, i32 0, i32 1
  %t228 = bitcast [8 x i8]* %t227 to i8*
  %t229 = bitcast i8* %t228 to i8**
  %t230 = load i8*, i8** %t229
  %t231 = icmp eq i32 %t213, 3
  %t232 = select i1 %t231, i8* %t230, i8* %t226
  %t233 = getelementptr inbounds %LiteralValue, %LiteralValue* %t211, i32 0, i32 1
  %t234 = bitcast [8 x i8]* %t233 to i8*
  %t235 = bitcast i8* %t234 to i8**
  store i8* %t232, i8** %t235
  %t236 = load %LiteralValue, %LiteralValue* %t211
  ret %LiteralValue %t236
merge5:
  %t237 = extractvalue %Expression %expr, 0
  %t238 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t239 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t237, 0
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t237, 1
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t237, 2
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t237, 3
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t252 = icmp eq i32 %t237, 4
  %t253 = select i1 %t252, i8* %t251, i8* %t250
  %t254 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t255 = icmp eq i32 %t237, 5
  %t256 = select i1 %t255, i8* %t254, i8* %t253
  %t257 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t237, 6
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t237, 7
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t237, 8
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t237, 9
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t237, 10
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t237, 11
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t237, 12
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t237, 13
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t237, 14
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t237, 15
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = call i8* @malloc(i64 12)
  %t288 = bitcast i8* %t287 to [12 x i8]*
  store [12 x i8] c"NullLiteral\00", [12 x i8]* %t288
  %t289 = call i1 @strings_equal(i8* %t286, i8* %t287)
  br i1 %t289, label %then6, label %merge7
then6:
  %t290 = insertvalue %LiteralValue undef, i32 3, 0
  ret %LiteralValue %t290
merge7:
  %t291 = extractvalue %Expression %expr, 0
  %t292 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t293 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t291, 0
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t291, 1
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t291, 2
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t291, 3
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t291, 4
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t291, 5
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t291, 6
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t291, 7
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t291, 8
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t291, 9
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t291, 10
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t291, 11
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t291, 12
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t291, 13
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t291, 14
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t291, 15
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = call i8* @malloc(i64 4)
  %t342 = bitcast i8* %t341 to [4 x i8]*
  store [4 x i8] c"Raw\00", [4 x i8]* %t342
  %t343 = call i1 @strings_equal(i8* %t340, i8* %t341)
  br i1 %t343, label %then8, label %merge9
then8:
  %t344 = extractvalue %Expression %expr, 0
  %t345 = alloca %Expression
  store %Expression %expr, %Expression* %t345
  %t346 = getelementptr inbounds %Expression, %Expression* %t345, i32 0, i32 1
  %t347 = bitcast [8 x i8]* %t346 to i8*
  %t348 = bitcast i8* %t347 to i8**
  %t349 = load i8*, i8** %t348
  %t350 = icmp eq i32 %t344, 15
  %t351 = select i1 %t350, i8* %t349, i8* null
  %t352 = call i8* @trim_whitespace(i8* %t351)
  store i8* %t352, i8** %l0
  %t353 = load i8*, i8** %l0
  %t354 = call i64 @sailfin_runtime_string_length(i8* %t353)
  %t355 = icmp eq i64 %t354, 0
  %t356 = load i8*, i8** %l0
  br i1 %t355, label %then10, label %merge11
then10:
  %t357 = insertvalue %LiteralValue undef, i32 4, 0
  ret %LiteralValue %t357
merge11:
  %t358 = load i8*, i8** %l0
  %t359 = call i1 @looks_like_quoted_string(i8* %t358)
  %t360 = load i8*, i8** %l0
  br i1 %t359, label %then12, label %merge13
then12:
  %t361 = load i8*, i8** %l0
  %t362 = call i8* @strip_surrounding_quotes(i8* %t361)
  store i8* %t362, i8** %l1
  %t363 = alloca %LiteralValue
  %t364 = getelementptr inbounds %LiteralValue, %LiteralValue* %t363, i32 0, i32 0
  store i32 0, i32* %t364
  %t365 = load i8*, i8** %l1
  %t366 = getelementptr inbounds %LiteralValue, %LiteralValue* %t363, i32 0, i32 1
  %t367 = bitcast [8 x i8]* %t366 to i8*
  %t368 = bitcast i8* %t367 to i8**
  store i8* %t365, i8** %t368
  %t369 = load %LiteralValue, %LiteralValue* %t363
  ret %LiteralValue %t369
merge13:
  %t370 = load i8*, i8** %l0
  %t371 = call i8* @malloc(i64 5)
  %t372 = bitcast i8* %t371 to [5 x i8]*
  store [5 x i8] c"true\00", [5 x i8]* %t372
  %t373 = call i1 @strings_equal(i8* %t370, i8* %t371)
  %t374 = load i8*, i8** %l0
  br i1 %t373, label %then14, label %merge15
then14:
  %t375 = alloca %LiteralValue
  %t376 = getelementptr inbounds %LiteralValue, %LiteralValue* %t375, i32 0, i32 0
  store i32 1, i32* %t376
  %t377 = call i8* @malloc(i64 5)
  %t378 = bitcast i8* %t377 to [5 x i8]*
  store [5 x i8] c"true\00", [5 x i8]* %t378
  %t379 = getelementptr inbounds %LiteralValue, %LiteralValue* %t375, i32 0, i32 1
  %t380 = bitcast [8 x i8]* %t379 to i8*
  %t381 = bitcast i8* %t380 to i8**
  store i8* %t377, i8** %t381
  %t382 = load %LiteralValue, %LiteralValue* %t375
  ret %LiteralValue %t382
merge15:
  %t383 = load i8*, i8** %l0
  %t384 = call i8* @malloc(i64 6)
  %t385 = bitcast i8* %t384 to [6 x i8]*
  store [6 x i8] c"false\00", [6 x i8]* %t385
  %t386 = call i1 @strings_equal(i8* %t383, i8* %t384)
  %t387 = load i8*, i8** %l0
  br i1 %t386, label %then16, label %merge17
then16:
  %t388 = alloca %LiteralValue
  %t389 = getelementptr inbounds %LiteralValue, %LiteralValue* %t388, i32 0, i32 0
  store i32 1, i32* %t389
  %t390 = call i8* @malloc(i64 6)
  %t391 = bitcast i8* %t390 to [6 x i8]*
  store [6 x i8] c"false\00", [6 x i8]* %t391
  %t392 = getelementptr inbounds %LiteralValue, %LiteralValue* %t388, i32 0, i32 1
  %t393 = bitcast [8 x i8]* %t392 to i8*
  %t394 = bitcast i8* %t393 to i8**
  store i8* %t390, i8** %t394
  %t395 = load %LiteralValue, %LiteralValue* %t388
  ret %LiteralValue %t395
merge17:
  %t396 = load i8*, i8** %l0
  %t397 = call i1 @looks_like_number(i8* %t396)
  %t398 = load i8*, i8** %l0
  br i1 %t397, label %then18, label %merge19
then18:
  %t399 = alloca %LiteralValue
  %t400 = getelementptr inbounds %LiteralValue, %LiteralValue* %t399, i32 0, i32 0
  store i32 2, i32* %t400
  %t401 = load i8*, i8** %l0
  %t402 = getelementptr inbounds %LiteralValue, %LiteralValue* %t399, i32 0, i32 1
  %t403 = bitcast [8 x i8]* %t402 to i8*
  %t404 = bitcast i8* %t403 to i8**
  store i8* %t401, i8** %t404
  %t405 = load %LiteralValue, %LiteralValue* %t399
  ret %LiteralValue %t405
merge19:
  br label %merge9
merge9:
  %t406 = insertvalue %LiteralValue undef, i32 4, 0
  ret %LiteralValue %t406
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
  %t71 = call i8* @malloc(i64 20)
  %t72 = bitcast i8* %t71 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  br i1 %t73, label %then0, label %merge1
then0:
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [48 x i8]* %t76 to i8*
  %t78 = getelementptr inbounds i8, i8* %t77, i64 40
  %t79 = bitcast i8* %t78 to { %Decorator*, i64 }**
  %t80 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t79
  %t81 = icmp eq i32 %t74, 3
  %t82 = select i1 %t81, { %Decorator*, i64 }* %t80, { %Decorator*, i64 }* null
  %t83 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t84 = bitcast [88 x i8]* %t83 to i8*
  %t85 = getelementptr inbounds i8, i8* %t84, i64 80
  %t86 = bitcast i8* %t85 to { %Decorator*, i64 }**
  %t87 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t86
  %t88 = icmp eq i32 %t74, 4
  %t89 = select i1 %t88, { %Decorator*, i64 }* %t87, { %Decorator*, i64 }* %t82
  %t90 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t91 = bitcast [88 x i8]* %t90 to i8*
  %t92 = getelementptr inbounds i8, i8* %t91, i64 80
  %t93 = bitcast i8* %t92 to { %Decorator*, i64 }**
  %t94 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t93
  %t95 = icmp eq i32 %t74, 5
  %t96 = select i1 %t95, { %Decorator*, i64 }* %t94, { %Decorator*, i64 }* %t89
  %t97 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t98 = bitcast [56 x i8]* %t97 to i8*
  %t99 = getelementptr inbounds i8, i8* %t98, i64 48
  %t100 = bitcast i8* %t99 to { %Decorator*, i64 }**
  %t101 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t100
  %t102 = icmp eq i32 %t74, 6
  %t103 = select i1 %t102, { %Decorator*, i64 }* %t101, { %Decorator*, i64 }* %t96
  %t104 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t105 = bitcast [88 x i8]* %t104 to i8*
  %t106 = getelementptr inbounds i8, i8* %t105, i64 80
  %t107 = bitcast i8* %t106 to { %Decorator*, i64 }**
  %t108 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t107
  %t109 = icmp eq i32 %t74, 7
  %t110 = select i1 %t109, { %Decorator*, i64 }* %t108, { %Decorator*, i64 }* %t103
  %t111 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t112 = bitcast [56 x i8]* %t111 to i8*
  %t113 = getelementptr inbounds i8, i8* %t112, i64 48
  %t114 = bitcast i8* %t113 to { %Decorator*, i64 }**
  %t115 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t114
  %t116 = icmp eq i32 %t74, 8
  %t117 = select i1 %t116, { %Decorator*, i64 }* %t115, { %Decorator*, i64 }* %t110
  %t118 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t119 = bitcast [40 x i8]* %t118 to i8*
  %t120 = getelementptr inbounds i8, i8* %t119, i64 32
  %t121 = bitcast i8* %t120 to { %Decorator*, i64 }**
  %t122 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t121
  %t123 = icmp eq i32 %t74, 9
  %t124 = select i1 %t123, { %Decorator*, i64 }* %t122, { %Decorator*, i64 }* %t117
  %t125 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t126 = bitcast [40 x i8]* %t125 to i8*
  %t127 = getelementptr inbounds i8, i8* %t126, i64 32
  %t128 = bitcast i8* %t127 to { %Decorator*, i64 }**
  %t129 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t128
  %t130 = icmp eq i32 %t74, 10
  %t131 = select i1 %t130, { %Decorator*, i64 }* %t129, { %Decorator*, i64 }* %t124
  %t132 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t133 = bitcast [40 x i8]* %t132 to i8*
  %t134 = getelementptr inbounds i8, i8* %t133, i64 32
  %t135 = bitcast i8* %t134 to { %Decorator*, i64 }**
  %t136 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t135
  %t137 = icmp eq i32 %t74, 11
  %t138 = select i1 %t137, { %Decorator*, i64 }* %t136, { %Decorator*, i64 }* %t131
  %t139 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t140 = bitcast [120 x i8]* %t139 to i8*
  %t141 = getelementptr inbounds i8, i8* %t140, i64 112
  %t142 = bitcast i8* %t141 to { %Decorator*, i64 }**
  %t143 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t142
  %t144 = icmp eq i32 %t74, 12
  %t145 = select i1 %t144, { %Decorator*, i64 }* %t143, { %Decorator*, i64 }* %t138
  %t146 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t147 = bitcast [40 x i8]* %t146 to i8*
  %t148 = getelementptr inbounds i8, i8* %t147, i64 32
  %t149 = bitcast i8* %t148 to { %Decorator*, i64 }**
  %t150 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t149
  %t151 = icmp eq i32 %t74, 13
  %t152 = select i1 %t151, { %Decorator*, i64 }* %t150, { %Decorator*, i64 }* %t145
  %t153 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t154 = bitcast [136 x i8]* %t153 to i8*
  %t155 = getelementptr inbounds i8, i8* %t154, i64 128
  %t156 = bitcast i8* %t155 to { %Decorator*, i64 }**
  %t157 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t156
  %t158 = icmp eq i32 %t74, 14
  %t159 = select i1 %t158, { %Decorator*, i64 }* %t157, { %Decorator*, i64 }* %t152
  %t160 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t161 = bitcast [32 x i8]* %t160 to i8*
  %t162 = getelementptr inbounds i8, i8* %t161, i64 24
  %t163 = bitcast i8* %t162 to { %Decorator*, i64 }**
  %t164 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t163
  %t165 = icmp eq i32 %t74, 15
  %t166 = select i1 %t165, { %Decorator*, i64 }* %t164, { %Decorator*, i64 }* %t159
  %t167 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t168 = bitcast [64 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 56
  %t170 = bitcast i8* %t169 to { %Decorator*, i64 }**
  %t171 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t170
  %t172 = icmp eq i32 %t74, 18
  %t173 = select i1 %t172, { %Decorator*, i64 }* %t171, { %Decorator*, i64 }* %t166
  %t174 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t175 = bitcast [88 x i8]* %t174 to i8*
  %t176 = getelementptr inbounds i8, i8* %t175, i64 80
  %t177 = bitcast i8* %t176 to { %Decorator*, i64 }**
  %t178 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t177
  %t179 = icmp eq i32 %t74, 19
  %t180 = select i1 %t179, { %Decorator*, i64 }* %t178, { %Decorator*, i64 }* %t173
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
  %t253 = call i8* @malloc(i64 18)
  %t254 = bitcast i8* %t253 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t254
  %t255 = call i1 @strings_equal(i8* %t252, i8* %t253)
  br i1 %t255, label %then2, label %merge3
then2:
  %t256 = extractvalue %Statement %statement, 0
  %t257 = alloca %Statement
  store %Statement %statement, %Statement* %t257
  %t258 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t259 = bitcast [48 x i8]* %t258 to i8*
  %t260 = getelementptr inbounds i8, i8* %t259, i64 40
  %t261 = bitcast i8* %t260 to { %Decorator*, i64 }**
  %t262 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t261
  %t263 = icmp eq i32 %t256, 3
  %t264 = select i1 %t263, { %Decorator*, i64 }* %t262, { %Decorator*, i64 }* null
  %t265 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t266 = bitcast [88 x i8]* %t265 to i8*
  %t267 = getelementptr inbounds i8, i8* %t266, i64 80
  %t268 = bitcast i8* %t267 to { %Decorator*, i64 }**
  %t269 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t268
  %t270 = icmp eq i32 %t256, 4
  %t271 = select i1 %t270, { %Decorator*, i64 }* %t269, { %Decorator*, i64 }* %t264
  %t272 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t273 = bitcast [88 x i8]* %t272 to i8*
  %t274 = getelementptr inbounds i8, i8* %t273, i64 80
  %t275 = bitcast i8* %t274 to { %Decorator*, i64 }**
  %t276 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t275
  %t277 = icmp eq i32 %t256, 5
  %t278 = select i1 %t277, { %Decorator*, i64 }* %t276, { %Decorator*, i64 }* %t271
  %t279 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t280 = bitcast [56 x i8]* %t279 to i8*
  %t281 = getelementptr inbounds i8, i8* %t280, i64 48
  %t282 = bitcast i8* %t281 to { %Decorator*, i64 }**
  %t283 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t282
  %t284 = icmp eq i32 %t256, 6
  %t285 = select i1 %t284, { %Decorator*, i64 }* %t283, { %Decorator*, i64 }* %t278
  %t286 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t287 = bitcast [88 x i8]* %t286 to i8*
  %t288 = getelementptr inbounds i8, i8* %t287, i64 80
  %t289 = bitcast i8* %t288 to { %Decorator*, i64 }**
  %t290 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t289
  %t291 = icmp eq i32 %t256, 7
  %t292 = select i1 %t291, { %Decorator*, i64 }* %t290, { %Decorator*, i64 }* %t285
  %t293 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t294 = bitcast [56 x i8]* %t293 to i8*
  %t295 = getelementptr inbounds i8, i8* %t294, i64 48
  %t296 = bitcast i8* %t295 to { %Decorator*, i64 }**
  %t297 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t296
  %t298 = icmp eq i32 %t256, 8
  %t299 = select i1 %t298, { %Decorator*, i64 }* %t297, { %Decorator*, i64 }* %t292
  %t300 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t301 = bitcast [40 x i8]* %t300 to i8*
  %t302 = getelementptr inbounds i8, i8* %t301, i64 32
  %t303 = bitcast i8* %t302 to { %Decorator*, i64 }**
  %t304 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t303
  %t305 = icmp eq i32 %t256, 9
  %t306 = select i1 %t305, { %Decorator*, i64 }* %t304, { %Decorator*, i64 }* %t299
  %t307 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t308 = bitcast [40 x i8]* %t307 to i8*
  %t309 = getelementptr inbounds i8, i8* %t308, i64 32
  %t310 = bitcast i8* %t309 to { %Decorator*, i64 }**
  %t311 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t310
  %t312 = icmp eq i32 %t256, 10
  %t313 = select i1 %t312, { %Decorator*, i64 }* %t311, { %Decorator*, i64 }* %t306
  %t314 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t315 = bitcast [40 x i8]* %t314 to i8*
  %t316 = getelementptr inbounds i8, i8* %t315, i64 32
  %t317 = bitcast i8* %t316 to { %Decorator*, i64 }**
  %t318 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t317
  %t319 = icmp eq i32 %t256, 11
  %t320 = select i1 %t319, { %Decorator*, i64 }* %t318, { %Decorator*, i64 }* %t313
  %t321 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t322 = bitcast [120 x i8]* %t321 to i8*
  %t323 = getelementptr inbounds i8, i8* %t322, i64 112
  %t324 = bitcast i8* %t323 to { %Decorator*, i64 }**
  %t325 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t324
  %t326 = icmp eq i32 %t256, 12
  %t327 = select i1 %t326, { %Decorator*, i64 }* %t325, { %Decorator*, i64 }* %t320
  %t328 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t329 = bitcast [40 x i8]* %t328 to i8*
  %t330 = getelementptr inbounds i8, i8* %t329, i64 32
  %t331 = bitcast i8* %t330 to { %Decorator*, i64 }**
  %t332 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t331
  %t333 = icmp eq i32 %t256, 13
  %t334 = select i1 %t333, { %Decorator*, i64 }* %t332, { %Decorator*, i64 }* %t327
  %t335 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t336 = bitcast [136 x i8]* %t335 to i8*
  %t337 = getelementptr inbounds i8, i8* %t336, i64 128
  %t338 = bitcast i8* %t337 to { %Decorator*, i64 }**
  %t339 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t338
  %t340 = icmp eq i32 %t256, 14
  %t341 = select i1 %t340, { %Decorator*, i64 }* %t339, { %Decorator*, i64 }* %t334
  %t342 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t343 = bitcast [32 x i8]* %t342 to i8*
  %t344 = getelementptr inbounds i8, i8* %t343, i64 24
  %t345 = bitcast i8* %t344 to { %Decorator*, i64 }**
  %t346 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t345
  %t347 = icmp eq i32 %t256, 15
  %t348 = select i1 %t347, { %Decorator*, i64 }* %t346, { %Decorator*, i64 }* %t341
  %t349 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t350 = bitcast [64 x i8]* %t349 to i8*
  %t351 = getelementptr inbounds i8, i8* %t350, i64 56
  %t352 = bitcast i8* %t351 to { %Decorator*, i64 }**
  %t353 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t352
  %t354 = icmp eq i32 %t256, 18
  %t355 = select i1 %t354, { %Decorator*, i64 }* %t353, { %Decorator*, i64 }* %t348
  %t356 = getelementptr inbounds %Statement, %Statement* %t257, i32 0, i32 1
  %t357 = bitcast [88 x i8]* %t356 to i8*
  %t358 = getelementptr inbounds i8, i8* %t357, i64 80
  %t359 = bitcast i8* %t358 to { %Decorator*, i64 }**
  %t360 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t359
  %t361 = icmp eq i32 %t256, 19
  %t362 = select i1 %t361, { %Decorator*, i64 }* %t360, { %Decorator*, i64 }* %t355
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}