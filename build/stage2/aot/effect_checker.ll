; ModuleID = 'sailfin'
source_filename = "sailfin"

%EffectRequirement = type { i8*, %Token*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { %EffectRequirement*, i64 }* }
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
%DecoratorArgumentInfo = type { i8*, %LiteralValue }
%DecoratorInfo = type { i8*, { %DecoratorArgumentInfo*, i64 }* }

%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }
%TokenKind = type { i32 }
%LiteralValue = type { i32, [8 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i8* @sailfin_runtime_number_to_string(double)
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare %Token @eof_token(double, double)
declare { i8**, i64 }* @infer_effects({ i8**, i64 }*, { %DecoratorInfo*, i64 }*)
declare { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }*)
declare { %DecoratorArgumentInfo*, i64 }* @evaluate_arguments({ %DecoratorArgument*, i64 }*)
declare %LiteralValue @evaluate_expression(%Expression)
declare { %DecoratorInfo*, i64 }* @evaluate_statement_decorators(%Statement)
declare i8* @trim_whitespace(i8*)
declare i1 @looks_like_quoted_string(i8*)
declare i1 @looks_like_number(i8*)
declare i1 @is_decimal_digit_codepoint(double)
declare { %DecoratorInfo*, i64 }* @append_decorator_info({ %DecoratorInfo*, i64 }*, %DecoratorInfo)
declare { %DecoratorArgumentInfo*, i64 }* @append_argument_info({ %DecoratorArgumentInfo*, i64 }*, %DecoratorArgumentInfo)
declare { i8**, i64 }* @append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @clone_effects({ i8**, i64 }*)
declare i1 @is_whitespace_codepoint(double)
declare i8* @slice_text(i8*, double, double)
declare i8* @strip_surrounding_quotes(i8*)

declare noalias i8* @malloc(i64)

@runtime__effect_checker = external global i8**

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
@.enum.Statement.BlockStatement.variant = private unnamed_addr constant [15 x i8] c"BlockStatement\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
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
@.enum.TokenKind.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.TokenKind.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.TokenKind.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.TokenKind.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.TokenKind.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.TokenKind.Symbol.variant = private unnamed_addr constant [7 x i8] c"Symbol\00"
@.enum.TokenKind.Whitespace.variant = private unnamed_addr constant [11 x i8] c"Whitespace\00"
@.enum.TokenKind.Comment.variant = private unnamed_addr constant [8 x i8] c"Comment\00"
@.enum.TokenKind.EndOfFile.variant = private unnamed_addr constant [10 x i8] c"EndOfFile\00"

declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

define { %EffectViolation*, i64 }* @validate_effects(%Program %program) {
block.entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  %t0 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1 = ptrtoint [0 x %EffectViolation]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %EffectViolation*
  %t6 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t7 = ptrtoint { %EffectViolation*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %EffectViolation*, i64 }*
  %t10 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t9, i32 0, i32 0
  store %EffectViolation* %t5, %EffectViolation** %t10
  %t11 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %EffectViolation*, i64 }* %t9, { %EffectViolation*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t41 = phi { %EffectViolation*, i64 }* [ %t13, %block.entry ], [ %t39, %loop.latch2 ]
  %t42 = phi double [ %t14, %block.entry ], [ %t40, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t41, { %EffectViolation*, i64 }** %l0
  store double %t42, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = extractvalue %Program %program, 0
  %t17 = load { %Statement*, i64 }, { %Statement*, i64 }* %t16
  %t18 = extractvalue { %Statement*, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t15, %t19
  %t21 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t24 = extractvalue %Program %program, 0
  %t25 = load double, double* %l1
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = load { %Statement*, i64 }, { %Statement*, i64 }* %t24
  %t29 = extractvalue { %Statement*, i64 } %t28, 0
  %t30 = extractvalue { %Statement*, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr %Statement, %Statement* %t29, i64 %t27
  %t33 = load %Statement, %Statement* %t32
  %t34 = call { %EffectViolation*, i64 }* @analyze_statement(%Statement %t33)
  %t35 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t23, { %EffectViolation*, i64 }* %t34)
  store { %EffectViolation*, i64 }* %t35, { %EffectViolation*, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch2
loop.latch2:
  %t39 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t40 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t43 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t45
}

define { %EffectViolation*, i64 }* @analyze_statement(%Statement %statement) {
block.entry:
  %l0 = alloca %FunctionSignature
  %l1 = alloca i8*
  %l2 = alloca %FunctionSignature
  %l3 = alloca i8*
  %l4 = alloca %FunctionSignature
  %l5 = alloca i8*
  %l6 = alloca { %EffectViolation*, i64 }*
  %l7 = alloca double
  %l8 = alloca %MethodDeclaration
  %l9 = alloca i8*
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
  %t62 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t0, 20
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t0, 21
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t0, 22
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t0, 23
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = call i8* @malloc(i64 20)
  %t75 = bitcast i8* %t74 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t75
  %t76 = call i1 @strings_equal(i8* %t73, i8* %t74)
  br i1 %t76, label %then0, label %merge1
then0:
  %t77 = extractvalue %Statement %statement, 0
  %t78 = alloca %Statement
  store %Statement %statement, %Statement* %t78
  %t79 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t80 = bitcast [88 x i8]* %t79 to i8*
  %t81 = bitcast i8* %t80 to %FunctionSignature*
  %t82 = load %FunctionSignature, %FunctionSignature* %t81
  %t83 = icmp eq i32 %t77, 4
  %t84 = select i1 %t83, %FunctionSignature %t82, %FunctionSignature zeroinitializer
  %t85 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t86 = bitcast [88 x i8]* %t85 to i8*
  %t87 = bitcast i8* %t86 to %FunctionSignature*
  %t88 = load %FunctionSignature, %FunctionSignature* %t87
  %t89 = icmp eq i32 %t77, 5
  %t90 = select i1 %t89, %FunctionSignature %t88, %FunctionSignature %t84
  %t91 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t92 = bitcast [88 x i8]* %t91 to i8*
  %t93 = bitcast i8* %t92 to %FunctionSignature*
  %t94 = load %FunctionSignature, %FunctionSignature* %t93
  %t95 = icmp eq i32 %t77, 7
  %t96 = select i1 %t95, %FunctionSignature %t94, %FunctionSignature %t90
  %t97 = extractvalue %Statement %statement, 0
  %t98 = alloca %Statement
  store %Statement %statement, %Statement* %t98
  %t99 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t100 = bitcast [88 x i8]* %t99 to i8*
  %t101 = getelementptr inbounds i8, i8* %t100, i64 56
  %t102 = bitcast i8* %t101 to %Block*
  %t103 = load %Block, %Block* %t102
  %t104 = icmp eq i32 %t97, 4
  %t105 = select i1 %t104, %Block %t103, %Block zeroinitializer
  %t106 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t107 = bitcast [88 x i8]* %t106 to i8*
  %t108 = getelementptr inbounds i8, i8* %t107, i64 56
  %t109 = bitcast i8* %t108 to %Block*
  %t110 = load %Block, %Block* %t109
  %t111 = icmp eq i32 %t97, 5
  %t112 = select i1 %t111, %Block %t110, %Block %t105
  %t113 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t114 = bitcast [56 x i8]* %t113 to i8*
  %t115 = getelementptr inbounds i8, i8* %t114, i64 16
  %t116 = bitcast i8* %t115 to %Block*
  %t117 = load %Block, %Block* %t116
  %t118 = icmp eq i32 %t97, 6
  %t119 = select i1 %t118, %Block %t117, %Block %t112
  %t120 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t121 = bitcast [88 x i8]* %t120 to i8*
  %t122 = getelementptr inbounds i8, i8* %t121, i64 56
  %t123 = bitcast i8* %t122 to %Block*
  %t124 = load %Block, %Block* %t123
  %t125 = icmp eq i32 %t97, 7
  %t126 = select i1 %t125, %Block %t124, %Block %t119
  %t127 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t128 = bitcast [120 x i8]* %t127 to i8*
  %t129 = getelementptr inbounds i8, i8* %t128, i64 88
  %t130 = bitcast i8* %t129 to %Block*
  %t131 = load %Block, %Block* %t130
  %t132 = icmp eq i32 %t97, 12
  %t133 = select i1 %t132, %Block %t131, %Block %t126
  %t134 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t135 = bitcast [40 x i8]* %t134 to i8*
  %t136 = getelementptr inbounds i8, i8* %t135, i64 8
  %t137 = bitcast i8* %t136 to %Block*
  %t138 = load %Block, %Block* %t137
  %t139 = icmp eq i32 %t97, 13
  %t140 = select i1 %t139, %Block %t138, %Block %t133
  %t141 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t142 = bitcast [136 x i8]* %t141 to i8*
  %t143 = getelementptr inbounds i8, i8* %t142, i64 104
  %t144 = bitcast i8* %t143 to %Block*
  %t145 = load %Block, %Block* %t144
  %t146 = icmp eq i32 %t97, 14
  %t147 = select i1 %t146, %Block %t145, %Block %t140
  %t148 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t149 = bitcast [32 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to %Block*
  %t151 = load %Block, %Block* %t150
  %t152 = icmp eq i32 %t97, 15
  %t153 = select i1 %t152, %Block %t151, %Block %t147
  %t154 = getelementptr inbounds %Statement, %Statement* %t98, i32 0, i32 1
  %t155 = bitcast [24 x i8]* %t154 to i8*
  %t156 = bitcast i8* %t155 to %Block*
  %t157 = load %Block, %Block* %t156
  %t158 = icmp eq i32 %t97, 20
  %t159 = select i1 %t158, %Block %t157, %Block %t153
  %t160 = extractvalue %Statement %statement, 0
  %t161 = alloca %Statement
  store %Statement %statement, %Statement* %t161
  %t162 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t163 = bitcast [48 x i8]* %t162 to i8*
  %t164 = getelementptr inbounds i8, i8* %t163, i64 40
  %t165 = bitcast i8* %t164 to { %Decorator*, i64 }**
  %t166 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t165
  %t167 = icmp eq i32 %t160, 3
  %t168 = select i1 %t167, { %Decorator*, i64 }* %t166, { %Decorator*, i64 }* null
  %t169 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t170 = bitcast [88 x i8]* %t169 to i8*
  %t171 = getelementptr inbounds i8, i8* %t170, i64 80
  %t172 = bitcast i8* %t171 to { %Decorator*, i64 }**
  %t173 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t172
  %t174 = icmp eq i32 %t160, 4
  %t175 = select i1 %t174, { %Decorator*, i64 }* %t173, { %Decorator*, i64 }* %t168
  %t176 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t177 = bitcast [88 x i8]* %t176 to i8*
  %t178 = getelementptr inbounds i8, i8* %t177, i64 80
  %t179 = bitcast i8* %t178 to { %Decorator*, i64 }**
  %t180 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t179
  %t181 = icmp eq i32 %t160, 5
  %t182 = select i1 %t181, { %Decorator*, i64 }* %t180, { %Decorator*, i64 }* %t175
  %t183 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t184 = bitcast [56 x i8]* %t183 to i8*
  %t185 = getelementptr inbounds i8, i8* %t184, i64 48
  %t186 = bitcast i8* %t185 to { %Decorator*, i64 }**
  %t187 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t186
  %t188 = icmp eq i32 %t160, 6
  %t189 = select i1 %t188, { %Decorator*, i64 }* %t187, { %Decorator*, i64 }* %t182
  %t190 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t191 = bitcast [88 x i8]* %t190 to i8*
  %t192 = getelementptr inbounds i8, i8* %t191, i64 80
  %t193 = bitcast i8* %t192 to { %Decorator*, i64 }**
  %t194 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t193
  %t195 = icmp eq i32 %t160, 7
  %t196 = select i1 %t195, { %Decorator*, i64 }* %t194, { %Decorator*, i64 }* %t189
  %t197 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t198 = bitcast [56 x i8]* %t197 to i8*
  %t199 = getelementptr inbounds i8, i8* %t198, i64 48
  %t200 = bitcast i8* %t199 to { %Decorator*, i64 }**
  %t201 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t200
  %t202 = icmp eq i32 %t160, 8
  %t203 = select i1 %t202, { %Decorator*, i64 }* %t201, { %Decorator*, i64 }* %t196
  %t204 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t205 = bitcast [40 x i8]* %t204 to i8*
  %t206 = getelementptr inbounds i8, i8* %t205, i64 32
  %t207 = bitcast i8* %t206 to { %Decorator*, i64 }**
  %t208 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t207
  %t209 = icmp eq i32 %t160, 9
  %t210 = select i1 %t209, { %Decorator*, i64 }* %t208, { %Decorator*, i64 }* %t203
  %t211 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t212 = bitcast [40 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 32
  %t214 = bitcast i8* %t213 to { %Decorator*, i64 }**
  %t215 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t214
  %t216 = icmp eq i32 %t160, 10
  %t217 = select i1 %t216, { %Decorator*, i64 }* %t215, { %Decorator*, i64 }* %t210
  %t218 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t219 = bitcast [40 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 32
  %t221 = bitcast i8* %t220 to { %Decorator*, i64 }**
  %t222 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t221
  %t223 = icmp eq i32 %t160, 11
  %t224 = select i1 %t223, { %Decorator*, i64 }* %t222, { %Decorator*, i64 }* %t217
  %t225 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t226 = bitcast [120 x i8]* %t225 to i8*
  %t227 = getelementptr inbounds i8, i8* %t226, i64 112
  %t228 = bitcast i8* %t227 to { %Decorator*, i64 }**
  %t229 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t228
  %t230 = icmp eq i32 %t160, 12
  %t231 = select i1 %t230, { %Decorator*, i64 }* %t229, { %Decorator*, i64 }* %t224
  %t232 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t233 = bitcast [40 x i8]* %t232 to i8*
  %t234 = getelementptr inbounds i8, i8* %t233, i64 32
  %t235 = bitcast i8* %t234 to { %Decorator*, i64 }**
  %t236 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t235
  %t237 = icmp eq i32 %t160, 13
  %t238 = select i1 %t237, { %Decorator*, i64 }* %t236, { %Decorator*, i64 }* %t231
  %t239 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t240 = bitcast [136 x i8]* %t239 to i8*
  %t241 = getelementptr inbounds i8, i8* %t240, i64 128
  %t242 = bitcast i8* %t241 to { %Decorator*, i64 }**
  %t243 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t242
  %t244 = icmp eq i32 %t160, 14
  %t245 = select i1 %t244, { %Decorator*, i64 }* %t243, { %Decorator*, i64 }* %t238
  %t246 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t247 = bitcast [32 x i8]* %t246 to i8*
  %t248 = getelementptr inbounds i8, i8* %t247, i64 24
  %t249 = bitcast i8* %t248 to { %Decorator*, i64 }**
  %t250 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t249
  %t251 = icmp eq i32 %t160, 15
  %t252 = select i1 %t251, { %Decorator*, i64 }* %t250, { %Decorator*, i64 }* %t245
  %t253 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t254 = bitcast [64 x i8]* %t253 to i8*
  %t255 = getelementptr inbounds i8, i8* %t254, i64 56
  %t256 = bitcast i8* %t255 to { %Decorator*, i64 }**
  %t257 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t256
  %t258 = icmp eq i32 %t160, 18
  %t259 = select i1 %t258, { %Decorator*, i64 }* %t257, { %Decorator*, i64 }* %t252
  %t260 = getelementptr inbounds %Statement, %Statement* %t161, i32 0, i32 1
  %t261 = bitcast [88 x i8]* %t260 to i8*
  %t262 = getelementptr inbounds i8, i8* %t261, i64 80
  %t263 = bitcast i8* %t262 to { %Decorator*, i64 }**
  %t264 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t263
  %t265 = icmp eq i32 %t160, 19
  %t266 = select i1 %t265, { %Decorator*, i64 }* %t264, { %Decorator*, i64 }* %t259
  %t267 = extractvalue %Statement %statement, 0
  %t268 = alloca %Statement
  store %Statement %statement, %Statement* %t268
  %t269 = getelementptr inbounds %Statement, %Statement* %t268, i32 0, i32 1
  %t270 = bitcast [88 x i8]* %t269 to i8*
  %t271 = bitcast i8* %t270 to %FunctionSignature*
  %t272 = load %FunctionSignature, %FunctionSignature* %t271
  %t273 = icmp eq i32 %t267, 4
  %t274 = select i1 %t273, %FunctionSignature %t272, %FunctionSignature zeroinitializer
  %t275 = getelementptr inbounds %Statement, %Statement* %t268, i32 0, i32 1
  %t276 = bitcast [88 x i8]* %t275 to i8*
  %t277 = bitcast i8* %t276 to %FunctionSignature*
  %t278 = load %FunctionSignature, %FunctionSignature* %t277
  %t279 = icmp eq i32 %t267, 5
  %t280 = select i1 %t279, %FunctionSignature %t278, %FunctionSignature %t274
  %t281 = getelementptr inbounds %Statement, %Statement* %t268, i32 0, i32 1
  %t282 = bitcast [88 x i8]* %t281 to i8*
  %t283 = bitcast i8* %t282 to %FunctionSignature*
  %t284 = load %FunctionSignature, %FunctionSignature* %t283
  %t285 = icmp eq i32 %t267, 7
  %t286 = select i1 %t285, %FunctionSignature %t284, %FunctionSignature %t280
  %t287 = extractvalue %FunctionSignature %t286, 0
  %t288 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t96, %Block %t159, { %Decorator*, i64 }* %t266, i8* %t287)
  ret { %EffectViolation*, i64 }* %t288
merge1:
  %t289 = extractvalue %Statement %statement, 0
  %t290 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t291 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t289, 0
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t289, 1
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t289, 2
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t289, 3
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t289, 4
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t289, 5
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t289, 6
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t289, 7
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t289, 8
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t289, 9
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t289, 10
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t289, 11
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t289, 12
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t289, 13
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t289, 14
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t289, 15
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t289, 16
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t289, 17
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t289, 18
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t289, 19
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t289, 20
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t289, 21
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t289, 22
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t289, 23
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = call i8* @malloc(i64 20)
  %t364 = bitcast i8* %t363 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t364
  %t365 = call i1 @strings_equal(i8* %t362, i8* %t363)
  br i1 %t365, label %then2, label %merge3
then2:
  %t366 = extractvalue %Statement %statement, 0
  %t367 = alloca %Statement
  store %Statement %statement, %Statement* %t367
  %t368 = getelementptr inbounds %Statement, %Statement* %t367, i32 0, i32 1
  %t369 = bitcast [88 x i8]* %t368 to i8*
  %t370 = bitcast i8* %t369 to %FunctionSignature*
  %t371 = load %FunctionSignature, %FunctionSignature* %t370
  %t372 = icmp eq i32 %t366, 4
  %t373 = select i1 %t372, %FunctionSignature %t371, %FunctionSignature zeroinitializer
  %t374 = getelementptr inbounds %Statement, %Statement* %t367, i32 0, i32 1
  %t375 = bitcast [88 x i8]* %t374 to i8*
  %t376 = bitcast i8* %t375 to %FunctionSignature*
  %t377 = load %FunctionSignature, %FunctionSignature* %t376
  %t378 = icmp eq i32 %t366, 5
  %t379 = select i1 %t378, %FunctionSignature %t377, %FunctionSignature %t373
  %t380 = getelementptr inbounds %Statement, %Statement* %t367, i32 0, i32 1
  %t381 = bitcast [88 x i8]* %t380 to i8*
  %t382 = bitcast i8* %t381 to %FunctionSignature*
  %t383 = load %FunctionSignature, %FunctionSignature* %t382
  %t384 = icmp eq i32 %t366, 7
  %t385 = select i1 %t384, %FunctionSignature %t383, %FunctionSignature %t379
  store %FunctionSignature %t385, %FunctionSignature* %l0
  %t386 = call i8* @malloc(i64 10)
  %t387 = bitcast i8* %t386 to [10 x i8]*
  store [10 x i8] c"pipeline \00", [10 x i8]* %t387
  %t388 = load %FunctionSignature, %FunctionSignature* %l0
  %t389 = extractvalue %FunctionSignature %t388, 0
  %t390 = call i8* @sailfin_runtime_string_concat(i8* %t386, i8* %t389)
  store i8* %t390, i8** %l1
  %t391 = load %FunctionSignature, %FunctionSignature* %l0
  %t392 = extractvalue %Statement %statement, 0
  %t393 = alloca %Statement
  store %Statement %statement, %Statement* %t393
  %t394 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t395 = bitcast [88 x i8]* %t394 to i8*
  %t396 = getelementptr inbounds i8, i8* %t395, i64 56
  %t397 = bitcast i8* %t396 to %Block*
  %t398 = load %Block, %Block* %t397
  %t399 = icmp eq i32 %t392, 4
  %t400 = select i1 %t399, %Block %t398, %Block zeroinitializer
  %t401 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t402 = bitcast [88 x i8]* %t401 to i8*
  %t403 = getelementptr inbounds i8, i8* %t402, i64 56
  %t404 = bitcast i8* %t403 to %Block*
  %t405 = load %Block, %Block* %t404
  %t406 = icmp eq i32 %t392, 5
  %t407 = select i1 %t406, %Block %t405, %Block %t400
  %t408 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t409 = bitcast [56 x i8]* %t408 to i8*
  %t410 = getelementptr inbounds i8, i8* %t409, i64 16
  %t411 = bitcast i8* %t410 to %Block*
  %t412 = load %Block, %Block* %t411
  %t413 = icmp eq i32 %t392, 6
  %t414 = select i1 %t413, %Block %t412, %Block %t407
  %t415 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t416 = bitcast [88 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 56
  %t418 = bitcast i8* %t417 to %Block*
  %t419 = load %Block, %Block* %t418
  %t420 = icmp eq i32 %t392, 7
  %t421 = select i1 %t420, %Block %t419, %Block %t414
  %t422 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t423 = bitcast [120 x i8]* %t422 to i8*
  %t424 = getelementptr inbounds i8, i8* %t423, i64 88
  %t425 = bitcast i8* %t424 to %Block*
  %t426 = load %Block, %Block* %t425
  %t427 = icmp eq i32 %t392, 12
  %t428 = select i1 %t427, %Block %t426, %Block %t421
  %t429 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t430 = bitcast [40 x i8]* %t429 to i8*
  %t431 = getelementptr inbounds i8, i8* %t430, i64 8
  %t432 = bitcast i8* %t431 to %Block*
  %t433 = load %Block, %Block* %t432
  %t434 = icmp eq i32 %t392, 13
  %t435 = select i1 %t434, %Block %t433, %Block %t428
  %t436 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t437 = bitcast [136 x i8]* %t436 to i8*
  %t438 = getelementptr inbounds i8, i8* %t437, i64 104
  %t439 = bitcast i8* %t438 to %Block*
  %t440 = load %Block, %Block* %t439
  %t441 = icmp eq i32 %t392, 14
  %t442 = select i1 %t441, %Block %t440, %Block %t435
  %t443 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t444 = bitcast [32 x i8]* %t443 to i8*
  %t445 = bitcast i8* %t444 to %Block*
  %t446 = load %Block, %Block* %t445
  %t447 = icmp eq i32 %t392, 15
  %t448 = select i1 %t447, %Block %t446, %Block %t442
  %t449 = getelementptr inbounds %Statement, %Statement* %t393, i32 0, i32 1
  %t450 = bitcast [24 x i8]* %t449 to i8*
  %t451 = bitcast i8* %t450 to %Block*
  %t452 = load %Block, %Block* %t451
  %t453 = icmp eq i32 %t392, 20
  %t454 = select i1 %t453, %Block %t452, %Block %t448
  %t455 = extractvalue %Statement %statement, 0
  %t456 = alloca %Statement
  store %Statement %statement, %Statement* %t456
  %t457 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t458 = bitcast [48 x i8]* %t457 to i8*
  %t459 = getelementptr inbounds i8, i8* %t458, i64 40
  %t460 = bitcast i8* %t459 to { %Decorator*, i64 }**
  %t461 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t460
  %t462 = icmp eq i32 %t455, 3
  %t463 = select i1 %t462, { %Decorator*, i64 }* %t461, { %Decorator*, i64 }* null
  %t464 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t465 = bitcast [88 x i8]* %t464 to i8*
  %t466 = getelementptr inbounds i8, i8* %t465, i64 80
  %t467 = bitcast i8* %t466 to { %Decorator*, i64 }**
  %t468 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t467
  %t469 = icmp eq i32 %t455, 4
  %t470 = select i1 %t469, { %Decorator*, i64 }* %t468, { %Decorator*, i64 }* %t463
  %t471 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t472 = bitcast [88 x i8]* %t471 to i8*
  %t473 = getelementptr inbounds i8, i8* %t472, i64 80
  %t474 = bitcast i8* %t473 to { %Decorator*, i64 }**
  %t475 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t474
  %t476 = icmp eq i32 %t455, 5
  %t477 = select i1 %t476, { %Decorator*, i64 }* %t475, { %Decorator*, i64 }* %t470
  %t478 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t479 = bitcast [56 x i8]* %t478 to i8*
  %t480 = getelementptr inbounds i8, i8* %t479, i64 48
  %t481 = bitcast i8* %t480 to { %Decorator*, i64 }**
  %t482 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t481
  %t483 = icmp eq i32 %t455, 6
  %t484 = select i1 %t483, { %Decorator*, i64 }* %t482, { %Decorator*, i64 }* %t477
  %t485 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t486 = bitcast [88 x i8]* %t485 to i8*
  %t487 = getelementptr inbounds i8, i8* %t486, i64 80
  %t488 = bitcast i8* %t487 to { %Decorator*, i64 }**
  %t489 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t488
  %t490 = icmp eq i32 %t455, 7
  %t491 = select i1 %t490, { %Decorator*, i64 }* %t489, { %Decorator*, i64 }* %t484
  %t492 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t493 = bitcast [56 x i8]* %t492 to i8*
  %t494 = getelementptr inbounds i8, i8* %t493, i64 48
  %t495 = bitcast i8* %t494 to { %Decorator*, i64 }**
  %t496 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t495
  %t497 = icmp eq i32 %t455, 8
  %t498 = select i1 %t497, { %Decorator*, i64 }* %t496, { %Decorator*, i64 }* %t491
  %t499 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t500 = bitcast [40 x i8]* %t499 to i8*
  %t501 = getelementptr inbounds i8, i8* %t500, i64 32
  %t502 = bitcast i8* %t501 to { %Decorator*, i64 }**
  %t503 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t502
  %t504 = icmp eq i32 %t455, 9
  %t505 = select i1 %t504, { %Decorator*, i64 }* %t503, { %Decorator*, i64 }* %t498
  %t506 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t507 = bitcast [40 x i8]* %t506 to i8*
  %t508 = getelementptr inbounds i8, i8* %t507, i64 32
  %t509 = bitcast i8* %t508 to { %Decorator*, i64 }**
  %t510 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t509
  %t511 = icmp eq i32 %t455, 10
  %t512 = select i1 %t511, { %Decorator*, i64 }* %t510, { %Decorator*, i64 }* %t505
  %t513 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t514 = bitcast [40 x i8]* %t513 to i8*
  %t515 = getelementptr inbounds i8, i8* %t514, i64 32
  %t516 = bitcast i8* %t515 to { %Decorator*, i64 }**
  %t517 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t516
  %t518 = icmp eq i32 %t455, 11
  %t519 = select i1 %t518, { %Decorator*, i64 }* %t517, { %Decorator*, i64 }* %t512
  %t520 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t521 = bitcast [120 x i8]* %t520 to i8*
  %t522 = getelementptr inbounds i8, i8* %t521, i64 112
  %t523 = bitcast i8* %t522 to { %Decorator*, i64 }**
  %t524 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t523
  %t525 = icmp eq i32 %t455, 12
  %t526 = select i1 %t525, { %Decorator*, i64 }* %t524, { %Decorator*, i64 }* %t519
  %t527 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t528 = bitcast [40 x i8]* %t527 to i8*
  %t529 = getelementptr inbounds i8, i8* %t528, i64 32
  %t530 = bitcast i8* %t529 to { %Decorator*, i64 }**
  %t531 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t530
  %t532 = icmp eq i32 %t455, 13
  %t533 = select i1 %t532, { %Decorator*, i64 }* %t531, { %Decorator*, i64 }* %t526
  %t534 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t535 = bitcast [136 x i8]* %t534 to i8*
  %t536 = getelementptr inbounds i8, i8* %t535, i64 128
  %t537 = bitcast i8* %t536 to { %Decorator*, i64 }**
  %t538 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t537
  %t539 = icmp eq i32 %t455, 14
  %t540 = select i1 %t539, { %Decorator*, i64 }* %t538, { %Decorator*, i64 }* %t533
  %t541 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t542 = bitcast [32 x i8]* %t541 to i8*
  %t543 = getelementptr inbounds i8, i8* %t542, i64 24
  %t544 = bitcast i8* %t543 to { %Decorator*, i64 }**
  %t545 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t544
  %t546 = icmp eq i32 %t455, 15
  %t547 = select i1 %t546, { %Decorator*, i64 }* %t545, { %Decorator*, i64 }* %t540
  %t548 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t549 = bitcast [64 x i8]* %t548 to i8*
  %t550 = getelementptr inbounds i8, i8* %t549, i64 56
  %t551 = bitcast i8* %t550 to { %Decorator*, i64 }**
  %t552 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t551
  %t553 = icmp eq i32 %t455, 18
  %t554 = select i1 %t553, { %Decorator*, i64 }* %t552, { %Decorator*, i64 }* %t547
  %t555 = getelementptr inbounds %Statement, %Statement* %t456, i32 0, i32 1
  %t556 = bitcast [88 x i8]* %t555 to i8*
  %t557 = getelementptr inbounds i8, i8* %t556, i64 80
  %t558 = bitcast i8* %t557 to { %Decorator*, i64 }**
  %t559 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t558
  %t560 = icmp eq i32 %t455, 19
  %t561 = select i1 %t560, { %Decorator*, i64 }* %t559, { %Decorator*, i64 }* %t554
  %t562 = load i8*, i8** %l1
  %t563 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t391, %Block %t454, { %Decorator*, i64 }* %t561, i8* %t562)
  ret { %EffectViolation*, i64 }* %t563
merge3:
  %t564 = extractvalue %Statement %statement, 0
  %t565 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t566 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t564, 0
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t564, 1
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t564, 2
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t564, 3
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t564, 4
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t564, 5
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t564, 6
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t564, 7
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t564, 8
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t564, 9
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t564, 10
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t564, 11
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t564, 12
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t564, 13
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t564, 14
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t564, 15
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t564, 16
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t564, 17
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t621 = icmp eq i32 %t564, 18
  %t622 = select i1 %t621, i8* %t620, i8* %t619
  %t623 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t624 = icmp eq i32 %t564, 19
  %t625 = select i1 %t624, i8* %t623, i8* %t622
  %t626 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t627 = icmp eq i32 %t564, 20
  %t628 = select i1 %t627, i8* %t626, i8* %t625
  %t629 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t630 = icmp eq i32 %t564, 21
  %t631 = select i1 %t630, i8* %t629, i8* %t628
  %t632 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t564, 22
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t564, 23
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = call i8* @malloc(i64 16)
  %t639 = bitcast i8* %t638 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t639
  %t640 = call i1 @strings_equal(i8* %t637, i8* %t638)
  br i1 %t640, label %then4, label %merge5
then4:
  %t641 = extractvalue %Statement %statement, 0
  %t642 = alloca %Statement
  store %Statement %statement, %Statement* %t642
  %t643 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t644 = bitcast [88 x i8]* %t643 to i8*
  %t645 = bitcast i8* %t644 to %FunctionSignature*
  %t646 = load %FunctionSignature, %FunctionSignature* %t645
  %t647 = icmp eq i32 %t641, 4
  %t648 = select i1 %t647, %FunctionSignature %t646, %FunctionSignature zeroinitializer
  %t649 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t650 = bitcast [88 x i8]* %t649 to i8*
  %t651 = bitcast i8* %t650 to %FunctionSignature*
  %t652 = load %FunctionSignature, %FunctionSignature* %t651
  %t653 = icmp eq i32 %t641, 5
  %t654 = select i1 %t653, %FunctionSignature %t652, %FunctionSignature %t648
  %t655 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t656 = bitcast [88 x i8]* %t655 to i8*
  %t657 = bitcast i8* %t656 to %FunctionSignature*
  %t658 = load %FunctionSignature, %FunctionSignature* %t657
  %t659 = icmp eq i32 %t641, 7
  %t660 = select i1 %t659, %FunctionSignature %t658, %FunctionSignature %t654
  store %FunctionSignature %t660, %FunctionSignature* %l2
  %t661 = call i8* @malloc(i64 6)
  %t662 = bitcast i8* %t661 to [6 x i8]*
  store [6 x i8] c"tool \00", [6 x i8]* %t662
  %t663 = load %FunctionSignature, %FunctionSignature* %l2
  %t664 = extractvalue %FunctionSignature %t663, 0
  %t665 = call i8* @sailfin_runtime_string_concat(i8* %t661, i8* %t664)
  store i8* %t665, i8** %l3
  %t666 = load %FunctionSignature, %FunctionSignature* %l2
  %t667 = extractvalue %Statement %statement, 0
  %t668 = alloca %Statement
  store %Statement %statement, %Statement* %t668
  %t669 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t670 = bitcast [88 x i8]* %t669 to i8*
  %t671 = getelementptr inbounds i8, i8* %t670, i64 56
  %t672 = bitcast i8* %t671 to %Block*
  %t673 = load %Block, %Block* %t672
  %t674 = icmp eq i32 %t667, 4
  %t675 = select i1 %t674, %Block %t673, %Block zeroinitializer
  %t676 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t677 = bitcast [88 x i8]* %t676 to i8*
  %t678 = getelementptr inbounds i8, i8* %t677, i64 56
  %t679 = bitcast i8* %t678 to %Block*
  %t680 = load %Block, %Block* %t679
  %t681 = icmp eq i32 %t667, 5
  %t682 = select i1 %t681, %Block %t680, %Block %t675
  %t683 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t684 = bitcast [56 x i8]* %t683 to i8*
  %t685 = getelementptr inbounds i8, i8* %t684, i64 16
  %t686 = bitcast i8* %t685 to %Block*
  %t687 = load %Block, %Block* %t686
  %t688 = icmp eq i32 %t667, 6
  %t689 = select i1 %t688, %Block %t687, %Block %t682
  %t690 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t691 = bitcast [88 x i8]* %t690 to i8*
  %t692 = getelementptr inbounds i8, i8* %t691, i64 56
  %t693 = bitcast i8* %t692 to %Block*
  %t694 = load %Block, %Block* %t693
  %t695 = icmp eq i32 %t667, 7
  %t696 = select i1 %t695, %Block %t694, %Block %t689
  %t697 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t698 = bitcast [120 x i8]* %t697 to i8*
  %t699 = getelementptr inbounds i8, i8* %t698, i64 88
  %t700 = bitcast i8* %t699 to %Block*
  %t701 = load %Block, %Block* %t700
  %t702 = icmp eq i32 %t667, 12
  %t703 = select i1 %t702, %Block %t701, %Block %t696
  %t704 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t705 = bitcast [40 x i8]* %t704 to i8*
  %t706 = getelementptr inbounds i8, i8* %t705, i64 8
  %t707 = bitcast i8* %t706 to %Block*
  %t708 = load %Block, %Block* %t707
  %t709 = icmp eq i32 %t667, 13
  %t710 = select i1 %t709, %Block %t708, %Block %t703
  %t711 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t712 = bitcast [136 x i8]* %t711 to i8*
  %t713 = getelementptr inbounds i8, i8* %t712, i64 104
  %t714 = bitcast i8* %t713 to %Block*
  %t715 = load %Block, %Block* %t714
  %t716 = icmp eq i32 %t667, 14
  %t717 = select i1 %t716, %Block %t715, %Block %t710
  %t718 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t719 = bitcast [32 x i8]* %t718 to i8*
  %t720 = bitcast i8* %t719 to %Block*
  %t721 = load %Block, %Block* %t720
  %t722 = icmp eq i32 %t667, 15
  %t723 = select i1 %t722, %Block %t721, %Block %t717
  %t724 = getelementptr inbounds %Statement, %Statement* %t668, i32 0, i32 1
  %t725 = bitcast [24 x i8]* %t724 to i8*
  %t726 = bitcast i8* %t725 to %Block*
  %t727 = load %Block, %Block* %t726
  %t728 = icmp eq i32 %t667, 20
  %t729 = select i1 %t728, %Block %t727, %Block %t723
  %t730 = extractvalue %Statement %statement, 0
  %t731 = alloca %Statement
  store %Statement %statement, %Statement* %t731
  %t732 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t733 = bitcast [48 x i8]* %t732 to i8*
  %t734 = getelementptr inbounds i8, i8* %t733, i64 40
  %t735 = bitcast i8* %t734 to { %Decorator*, i64 }**
  %t736 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t735
  %t737 = icmp eq i32 %t730, 3
  %t738 = select i1 %t737, { %Decorator*, i64 }* %t736, { %Decorator*, i64 }* null
  %t739 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t740 = bitcast [88 x i8]* %t739 to i8*
  %t741 = getelementptr inbounds i8, i8* %t740, i64 80
  %t742 = bitcast i8* %t741 to { %Decorator*, i64 }**
  %t743 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t742
  %t744 = icmp eq i32 %t730, 4
  %t745 = select i1 %t744, { %Decorator*, i64 }* %t743, { %Decorator*, i64 }* %t738
  %t746 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t747 = bitcast [88 x i8]* %t746 to i8*
  %t748 = getelementptr inbounds i8, i8* %t747, i64 80
  %t749 = bitcast i8* %t748 to { %Decorator*, i64 }**
  %t750 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t749
  %t751 = icmp eq i32 %t730, 5
  %t752 = select i1 %t751, { %Decorator*, i64 }* %t750, { %Decorator*, i64 }* %t745
  %t753 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t754 = bitcast [56 x i8]* %t753 to i8*
  %t755 = getelementptr inbounds i8, i8* %t754, i64 48
  %t756 = bitcast i8* %t755 to { %Decorator*, i64 }**
  %t757 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t756
  %t758 = icmp eq i32 %t730, 6
  %t759 = select i1 %t758, { %Decorator*, i64 }* %t757, { %Decorator*, i64 }* %t752
  %t760 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t761 = bitcast [88 x i8]* %t760 to i8*
  %t762 = getelementptr inbounds i8, i8* %t761, i64 80
  %t763 = bitcast i8* %t762 to { %Decorator*, i64 }**
  %t764 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t763
  %t765 = icmp eq i32 %t730, 7
  %t766 = select i1 %t765, { %Decorator*, i64 }* %t764, { %Decorator*, i64 }* %t759
  %t767 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t768 = bitcast [56 x i8]* %t767 to i8*
  %t769 = getelementptr inbounds i8, i8* %t768, i64 48
  %t770 = bitcast i8* %t769 to { %Decorator*, i64 }**
  %t771 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t770
  %t772 = icmp eq i32 %t730, 8
  %t773 = select i1 %t772, { %Decorator*, i64 }* %t771, { %Decorator*, i64 }* %t766
  %t774 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t775 = bitcast [40 x i8]* %t774 to i8*
  %t776 = getelementptr inbounds i8, i8* %t775, i64 32
  %t777 = bitcast i8* %t776 to { %Decorator*, i64 }**
  %t778 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t777
  %t779 = icmp eq i32 %t730, 9
  %t780 = select i1 %t779, { %Decorator*, i64 }* %t778, { %Decorator*, i64 }* %t773
  %t781 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t782 = bitcast [40 x i8]* %t781 to i8*
  %t783 = getelementptr inbounds i8, i8* %t782, i64 32
  %t784 = bitcast i8* %t783 to { %Decorator*, i64 }**
  %t785 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t784
  %t786 = icmp eq i32 %t730, 10
  %t787 = select i1 %t786, { %Decorator*, i64 }* %t785, { %Decorator*, i64 }* %t780
  %t788 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t789 = bitcast [40 x i8]* %t788 to i8*
  %t790 = getelementptr inbounds i8, i8* %t789, i64 32
  %t791 = bitcast i8* %t790 to { %Decorator*, i64 }**
  %t792 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t791
  %t793 = icmp eq i32 %t730, 11
  %t794 = select i1 %t793, { %Decorator*, i64 }* %t792, { %Decorator*, i64 }* %t787
  %t795 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t796 = bitcast [120 x i8]* %t795 to i8*
  %t797 = getelementptr inbounds i8, i8* %t796, i64 112
  %t798 = bitcast i8* %t797 to { %Decorator*, i64 }**
  %t799 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t798
  %t800 = icmp eq i32 %t730, 12
  %t801 = select i1 %t800, { %Decorator*, i64 }* %t799, { %Decorator*, i64 }* %t794
  %t802 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t803 = bitcast [40 x i8]* %t802 to i8*
  %t804 = getelementptr inbounds i8, i8* %t803, i64 32
  %t805 = bitcast i8* %t804 to { %Decorator*, i64 }**
  %t806 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t805
  %t807 = icmp eq i32 %t730, 13
  %t808 = select i1 %t807, { %Decorator*, i64 }* %t806, { %Decorator*, i64 }* %t801
  %t809 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t810 = bitcast [136 x i8]* %t809 to i8*
  %t811 = getelementptr inbounds i8, i8* %t810, i64 128
  %t812 = bitcast i8* %t811 to { %Decorator*, i64 }**
  %t813 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t812
  %t814 = icmp eq i32 %t730, 14
  %t815 = select i1 %t814, { %Decorator*, i64 }* %t813, { %Decorator*, i64 }* %t808
  %t816 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t817 = bitcast [32 x i8]* %t816 to i8*
  %t818 = getelementptr inbounds i8, i8* %t817, i64 24
  %t819 = bitcast i8* %t818 to { %Decorator*, i64 }**
  %t820 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t819
  %t821 = icmp eq i32 %t730, 15
  %t822 = select i1 %t821, { %Decorator*, i64 }* %t820, { %Decorator*, i64 }* %t815
  %t823 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t824 = bitcast [64 x i8]* %t823 to i8*
  %t825 = getelementptr inbounds i8, i8* %t824, i64 56
  %t826 = bitcast i8* %t825 to { %Decorator*, i64 }**
  %t827 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t826
  %t828 = icmp eq i32 %t730, 18
  %t829 = select i1 %t828, { %Decorator*, i64 }* %t827, { %Decorator*, i64 }* %t822
  %t830 = getelementptr inbounds %Statement, %Statement* %t731, i32 0, i32 1
  %t831 = bitcast [88 x i8]* %t830 to i8*
  %t832 = getelementptr inbounds i8, i8* %t831, i64 80
  %t833 = bitcast i8* %t832 to { %Decorator*, i64 }**
  %t834 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t833
  %t835 = icmp eq i32 %t730, 19
  %t836 = select i1 %t835, { %Decorator*, i64 }* %t834, { %Decorator*, i64 }* %t829
  %t837 = load i8*, i8** %l3
  %t838 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t666, %Block %t729, { %Decorator*, i64 }* %t836, i8* %t837)
  ret { %EffectViolation*, i64 }* %t838
merge5:
  %t839 = extractvalue %Statement %statement, 0
  %t840 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t841 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t839, 0
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t839, 1
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t839, 2
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t839, 3
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t839, 4
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t839, 5
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t839, 6
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t839, 7
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t839, 8
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t839, 9
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t839, 10
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t839, 11
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t839, 12
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t839, 13
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t839, 14
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t839, 15
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t839, 16
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t839, 17
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t839, 18
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t839, 19
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t839, 20
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t839, 21
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t839, 22
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t839, 23
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = call i8* @malloc(i64 16)
  %t914 = bitcast i8* %t913 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t914
  %t915 = call i1 @strings_equal(i8* %t912, i8* %t913)
  br i1 %t915, label %then6, label %merge7
then6:
  %t916 = extractvalue %Statement %statement, 0
  %t917 = alloca %Statement
  store %Statement %statement, %Statement* %t917
  %t918 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t919 = bitcast [48 x i8]* %t918 to i8*
  %t920 = bitcast i8* %t919 to i8**
  %t921 = load i8*, i8** %t920
  %t922 = icmp eq i32 %t916, 2
  %t923 = select i1 %t922, i8* %t921, i8* null
  %t924 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t925 = bitcast [48 x i8]* %t924 to i8*
  %t926 = bitcast i8* %t925 to i8**
  %t927 = load i8*, i8** %t926
  %t928 = icmp eq i32 %t916, 3
  %t929 = select i1 %t928, i8* %t927, i8* %t923
  %t930 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t931 = bitcast [56 x i8]* %t930 to i8*
  %t932 = bitcast i8* %t931 to i8**
  %t933 = load i8*, i8** %t932
  %t934 = icmp eq i32 %t916, 6
  %t935 = select i1 %t934, i8* %t933, i8* %t929
  %t936 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t937 = bitcast [56 x i8]* %t936 to i8*
  %t938 = bitcast i8* %t937 to i8**
  %t939 = load i8*, i8** %t938
  %t940 = icmp eq i32 %t916, 8
  %t941 = select i1 %t940, i8* %t939, i8* %t935
  %t942 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t943 = bitcast [40 x i8]* %t942 to i8*
  %t944 = bitcast i8* %t943 to i8**
  %t945 = load i8*, i8** %t944
  %t946 = icmp eq i32 %t916, 9
  %t947 = select i1 %t946, i8* %t945, i8* %t941
  %t948 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t949 = bitcast [40 x i8]* %t948 to i8*
  %t950 = bitcast i8* %t949 to i8**
  %t951 = load i8*, i8** %t950
  %t952 = icmp eq i32 %t916, 10
  %t953 = select i1 %t952, i8* %t951, i8* %t947
  %t954 = getelementptr inbounds %Statement, %Statement* %t917, i32 0, i32 1
  %t955 = bitcast [40 x i8]* %t954 to i8*
  %t956 = bitcast i8* %t955 to i8**
  %t957 = load i8*, i8** %t956
  %t958 = icmp eq i32 %t916, 11
  %t959 = select i1 %t958, i8* %t957, i8* %t953
  %t960 = insertvalue %FunctionSignature undef, i8* %t959, 0
  %t961 = insertvalue %FunctionSignature %t960, i1 0, 1
  %t962 = getelementptr [0 x %Parameter], [0 x %Parameter]* null, i32 1
  %t963 = ptrtoint [0 x %Parameter]* %t962 to i64
  %t964 = icmp eq i64 %t963, 0
  %t965 = select i1 %t964, i64 1, i64 %t963
  %t966 = call i8* @malloc(i64 %t965)
  %t967 = bitcast i8* %t966 to %Parameter*
  %t968 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* null, i32 1
  %t969 = ptrtoint { %Parameter*, i64 }* %t968 to i64
  %t970 = call i8* @malloc(i64 %t969)
  %t971 = bitcast i8* %t970 to { %Parameter*, i64 }*
  %t972 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t971, i32 0, i32 0
  store %Parameter* %t967, %Parameter** %t972
  %t973 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t971, i32 0, i32 1
  store i64 0, i64* %t973
  %t974 = insertvalue %FunctionSignature %t961, { %Parameter*, i64 }* %t971, 2
  %t975 = bitcast i8* null to %TypeAnnotation*
  %t976 = insertvalue %FunctionSignature %t974, %TypeAnnotation* %t975, 3
  %t977 = extractvalue %Statement %statement, 0
  %t978 = alloca %Statement
  store %Statement %statement, %Statement* %t978
  %t979 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t980 = bitcast [48 x i8]* %t979 to i8*
  %t981 = getelementptr inbounds i8, i8* %t980, i64 32
  %t982 = bitcast i8* %t981 to { i8**, i64 }**
  %t983 = load { i8**, i64 }*, { i8**, i64 }** %t982
  %t984 = icmp eq i32 %t977, 3
  %t985 = select i1 %t984, { i8**, i64 }* %t983, { i8**, i64 }* null
  %t986 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t987 = bitcast [56 x i8]* %t986 to i8*
  %t988 = getelementptr inbounds i8, i8* %t987, i64 40
  %t989 = bitcast i8* %t988 to { i8**, i64 }**
  %t990 = load { i8**, i64 }*, { i8**, i64 }** %t989
  %t991 = icmp eq i32 %t977, 6
  %t992 = select i1 %t991, { i8**, i64 }* %t990, { i8**, i64 }* %t985
  %t993 = insertvalue %FunctionSignature %t976, { i8**, i64 }* %t992, 4
  %t994 = getelementptr [0 x %TypeParameter], [0 x %TypeParameter]* null, i32 1
  %t995 = ptrtoint [0 x %TypeParameter]* %t994 to i64
  %t996 = icmp eq i64 %t995, 0
  %t997 = select i1 %t996, i64 1, i64 %t995
  %t998 = call i8* @malloc(i64 %t997)
  %t999 = bitcast i8* %t998 to %TypeParameter*
  %t1000 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* null, i32 1
  %t1001 = ptrtoint { %TypeParameter*, i64 }* %t1000 to i64
  %t1002 = call i8* @malloc(i64 %t1001)
  %t1003 = bitcast i8* %t1002 to { %TypeParameter*, i64 }*
  %t1004 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t1003, i32 0, i32 0
  store %TypeParameter* %t999, %TypeParameter** %t1004
  %t1005 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t1003, i32 0, i32 1
  store i64 0, i64* %t1005
  %t1006 = insertvalue %FunctionSignature %t993, { %TypeParameter*, i64 }* %t1003, 5
  %t1007 = bitcast i8* null to %SourceSpan*
  %t1008 = insertvalue %FunctionSignature %t1006, %SourceSpan* %t1007, 6
  store %FunctionSignature %t1008, %FunctionSignature* %l4
  %t1009 = call i8* @malloc(i64 6)
  %t1010 = bitcast i8* %t1009 to [6 x i8]*
  store [6 x i8] c"test \00", [6 x i8]* %t1010
  %t1011 = extractvalue %Statement %statement, 0
  %t1012 = alloca %Statement
  store %Statement %statement, %Statement* %t1012
  %t1013 = getelementptr inbounds %Statement, %Statement* %t1012, i32 0, i32 1
  %t1014 = bitcast [48 x i8]* %t1013 to i8*
  %t1015 = bitcast i8* %t1014 to i8**
  %t1016 = load i8*, i8** %t1015
  %t1017 = icmp eq i32 %t1011, 2
  %t1018 = select i1 %t1017, i8* %t1016, i8* null
  %t1019 = getelementptr inbounds %Statement, %Statement* %t1012, i32 0, i32 1
  %t1020 = bitcast [48 x i8]* %t1019 to i8*
  %t1021 = bitcast i8* %t1020 to i8**
  %t1022 = load i8*, i8** %t1021
  %t1023 = icmp eq i32 %t1011, 3
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1018
  %t1025 = getelementptr inbounds %Statement, %Statement* %t1012, i32 0, i32 1
  %t1026 = bitcast [56 x i8]* %t1025 to i8*
  %t1027 = bitcast i8* %t1026 to i8**
  %t1028 = load i8*, i8** %t1027
  %t1029 = icmp eq i32 %t1011, 6
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1024
  %t1031 = getelementptr inbounds %Statement, %Statement* %t1012, i32 0, i32 1
  %t1032 = bitcast [56 x i8]* %t1031 to i8*
  %t1033 = bitcast i8* %t1032 to i8**
  %t1034 = load i8*, i8** %t1033
  %t1035 = icmp eq i32 %t1011, 8
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1030
  %t1037 = getelementptr inbounds %Statement, %Statement* %t1012, i32 0, i32 1
  %t1038 = bitcast [40 x i8]* %t1037 to i8*
  %t1039 = bitcast i8* %t1038 to i8**
  %t1040 = load i8*, i8** %t1039
  %t1041 = icmp eq i32 %t1011, 9
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1036
  %t1043 = getelementptr inbounds %Statement, %Statement* %t1012, i32 0, i32 1
  %t1044 = bitcast [40 x i8]* %t1043 to i8*
  %t1045 = bitcast i8* %t1044 to i8**
  %t1046 = load i8*, i8** %t1045
  %t1047 = icmp eq i32 %t1011, 10
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1042
  %t1049 = getelementptr inbounds %Statement, %Statement* %t1012, i32 0, i32 1
  %t1050 = bitcast [40 x i8]* %t1049 to i8*
  %t1051 = bitcast i8* %t1050 to i8**
  %t1052 = load i8*, i8** %t1051
  %t1053 = icmp eq i32 %t1011, 11
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1048
  %t1055 = call i8* @sailfin_runtime_string_concat(i8* %t1009, i8* %t1054)
  store i8* %t1055, i8** %l5
  %t1056 = load %FunctionSignature, %FunctionSignature* %l4
  %t1057 = extractvalue %Statement %statement, 0
  %t1058 = alloca %Statement
  store %Statement %statement, %Statement* %t1058
  %t1059 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1060 = bitcast [88 x i8]* %t1059 to i8*
  %t1061 = getelementptr inbounds i8, i8* %t1060, i64 56
  %t1062 = bitcast i8* %t1061 to %Block*
  %t1063 = load %Block, %Block* %t1062
  %t1064 = icmp eq i32 %t1057, 4
  %t1065 = select i1 %t1064, %Block %t1063, %Block zeroinitializer
  %t1066 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1067 = bitcast [88 x i8]* %t1066 to i8*
  %t1068 = getelementptr inbounds i8, i8* %t1067, i64 56
  %t1069 = bitcast i8* %t1068 to %Block*
  %t1070 = load %Block, %Block* %t1069
  %t1071 = icmp eq i32 %t1057, 5
  %t1072 = select i1 %t1071, %Block %t1070, %Block %t1065
  %t1073 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1074 = bitcast [56 x i8]* %t1073 to i8*
  %t1075 = getelementptr inbounds i8, i8* %t1074, i64 16
  %t1076 = bitcast i8* %t1075 to %Block*
  %t1077 = load %Block, %Block* %t1076
  %t1078 = icmp eq i32 %t1057, 6
  %t1079 = select i1 %t1078, %Block %t1077, %Block %t1072
  %t1080 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1081 = bitcast [88 x i8]* %t1080 to i8*
  %t1082 = getelementptr inbounds i8, i8* %t1081, i64 56
  %t1083 = bitcast i8* %t1082 to %Block*
  %t1084 = load %Block, %Block* %t1083
  %t1085 = icmp eq i32 %t1057, 7
  %t1086 = select i1 %t1085, %Block %t1084, %Block %t1079
  %t1087 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1088 = bitcast [120 x i8]* %t1087 to i8*
  %t1089 = getelementptr inbounds i8, i8* %t1088, i64 88
  %t1090 = bitcast i8* %t1089 to %Block*
  %t1091 = load %Block, %Block* %t1090
  %t1092 = icmp eq i32 %t1057, 12
  %t1093 = select i1 %t1092, %Block %t1091, %Block %t1086
  %t1094 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1095 = bitcast [40 x i8]* %t1094 to i8*
  %t1096 = getelementptr inbounds i8, i8* %t1095, i64 8
  %t1097 = bitcast i8* %t1096 to %Block*
  %t1098 = load %Block, %Block* %t1097
  %t1099 = icmp eq i32 %t1057, 13
  %t1100 = select i1 %t1099, %Block %t1098, %Block %t1093
  %t1101 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1102 = bitcast [136 x i8]* %t1101 to i8*
  %t1103 = getelementptr inbounds i8, i8* %t1102, i64 104
  %t1104 = bitcast i8* %t1103 to %Block*
  %t1105 = load %Block, %Block* %t1104
  %t1106 = icmp eq i32 %t1057, 14
  %t1107 = select i1 %t1106, %Block %t1105, %Block %t1100
  %t1108 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1109 = bitcast [32 x i8]* %t1108 to i8*
  %t1110 = bitcast i8* %t1109 to %Block*
  %t1111 = load %Block, %Block* %t1110
  %t1112 = icmp eq i32 %t1057, 15
  %t1113 = select i1 %t1112, %Block %t1111, %Block %t1107
  %t1114 = getelementptr inbounds %Statement, %Statement* %t1058, i32 0, i32 1
  %t1115 = bitcast [24 x i8]* %t1114 to i8*
  %t1116 = bitcast i8* %t1115 to %Block*
  %t1117 = load %Block, %Block* %t1116
  %t1118 = icmp eq i32 %t1057, 20
  %t1119 = select i1 %t1118, %Block %t1117, %Block %t1113
  %t1120 = extractvalue %Statement %statement, 0
  %t1121 = alloca %Statement
  store %Statement %statement, %Statement* %t1121
  %t1122 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1123 = bitcast [48 x i8]* %t1122 to i8*
  %t1124 = getelementptr inbounds i8, i8* %t1123, i64 40
  %t1125 = bitcast i8* %t1124 to { %Decorator*, i64 }**
  %t1126 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1125
  %t1127 = icmp eq i32 %t1120, 3
  %t1128 = select i1 %t1127, { %Decorator*, i64 }* %t1126, { %Decorator*, i64 }* null
  %t1129 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1130 = bitcast [88 x i8]* %t1129 to i8*
  %t1131 = getelementptr inbounds i8, i8* %t1130, i64 80
  %t1132 = bitcast i8* %t1131 to { %Decorator*, i64 }**
  %t1133 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1132
  %t1134 = icmp eq i32 %t1120, 4
  %t1135 = select i1 %t1134, { %Decorator*, i64 }* %t1133, { %Decorator*, i64 }* %t1128
  %t1136 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1137 = bitcast [88 x i8]* %t1136 to i8*
  %t1138 = getelementptr inbounds i8, i8* %t1137, i64 80
  %t1139 = bitcast i8* %t1138 to { %Decorator*, i64 }**
  %t1140 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1139
  %t1141 = icmp eq i32 %t1120, 5
  %t1142 = select i1 %t1141, { %Decorator*, i64 }* %t1140, { %Decorator*, i64 }* %t1135
  %t1143 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1144 = bitcast [56 x i8]* %t1143 to i8*
  %t1145 = getelementptr inbounds i8, i8* %t1144, i64 48
  %t1146 = bitcast i8* %t1145 to { %Decorator*, i64 }**
  %t1147 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1146
  %t1148 = icmp eq i32 %t1120, 6
  %t1149 = select i1 %t1148, { %Decorator*, i64 }* %t1147, { %Decorator*, i64 }* %t1142
  %t1150 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1151 = bitcast [88 x i8]* %t1150 to i8*
  %t1152 = getelementptr inbounds i8, i8* %t1151, i64 80
  %t1153 = bitcast i8* %t1152 to { %Decorator*, i64 }**
  %t1154 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1153
  %t1155 = icmp eq i32 %t1120, 7
  %t1156 = select i1 %t1155, { %Decorator*, i64 }* %t1154, { %Decorator*, i64 }* %t1149
  %t1157 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1158 = bitcast [56 x i8]* %t1157 to i8*
  %t1159 = getelementptr inbounds i8, i8* %t1158, i64 48
  %t1160 = bitcast i8* %t1159 to { %Decorator*, i64 }**
  %t1161 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1160
  %t1162 = icmp eq i32 %t1120, 8
  %t1163 = select i1 %t1162, { %Decorator*, i64 }* %t1161, { %Decorator*, i64 }* %t1156
  %t1164 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1165 = bitcast [40 x i8]* %t1164 to i8*
  %t1166 = getelementptr inbounds i8, i8* %t1165, i64 32
  %t1167 = bitcast i8* %t1166 to { %Decorator*, i64 }**
  %t1168 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1167
  %t1169 = icmp eq i32 %t1120, 9
  %t1170 = select i1 %t1169, { %Decorator*, i64 }* %t1168, { %Decorator*, i64 }* %t1163
  %t1171 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1172 = bitcast [40 x i8]* %t1171 to i8*
  %t1173 = getelementptr inbounds i8, i8* %t1172, i64 32
  %t1174 = bitcast i8* %t1173 to { %Decorator*, i64 }**
  %t1175 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1174
  %t1176 = icmp eq i32 %t1120, 10
  %t1177 = select i1 %t1176, { %Decorator*, i64 }* %t1175, { %Decorator*, i64 }* %t1170
  %t1178 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1179 = bitcast [40 x i8]* %t1178 to i8*
  %t1180 = getelementptr inbounds i8, i8* %t1179, i64 32
  %t1181 = bitcast i8* %t1180 to { %Decorator*, i64 }**
  %t1182 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1181
  %t1183 = icmp eq i32 %t1120, 11
  %t1184 = select i1 %t1183, { %Decorator*, i64 }* %t1182, { %Decorator*, i64 }* %t1177
  %t1185 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1186 = bitcast [120 x i8]* %t1185 to i8*
  %t1187 = getelementptr inbounds i8, i8* %t1186, i64 112
  %t1188 = bitcast i8* %t1187 to { %Decorator*, i64 }**
  %t1189 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1188
  %t1190 = icmp eq i32 %t1120, 12
  %t1191 = select i1 %t1190, { %Decorator*, i64 }* %t1189, { %Decorator*, i64 }* %t1184
  %t1192 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1193 = bitcast [40 x i8]* %t1192 to i8*
  %t1194 = getelementptr inbounds i8, i8* %t1193, i64 32
  %t1195 = bitcast i8* %t1194 to { %Decorator*, i64 }**
  %t1196 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1195
  %t1197 = icmp eq i32 %t1120, 13
  %t1198 = select i1 %t1197, { %Decorator*, i64 }* %t1196, { %Decorator*, i64 }* %t1191
  %t1199 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1200 = bitcast [136 x i8]* %t1199 to i8*
  %t1201 = getelementptr inbounds i8, i8* %t1200, i64 128
  %t1202 = bitcast i8* %t1201 to { %Decorator*, i64 }**
  %t1203 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1202
  %t1204 = icmp eq i32 %t1120, 14
  %t1205 = select i1 %t1204, { %Decorator*, i64 }* %t1203, { %Decorator*, i64 }* %t1198
  %t1206 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1207 = bitcast [32 x i8]* %t1206 to i8*
  %t1208 = getelementptr inbounds i8, i8* %t1207, i64 24
  %t1209 = bitcast i8* %t1208 to { %Decorator*, i64 }**
  %t1210 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1209
  %t1211 = icmp eq i32 %t1120, 15
  %t1212 = select i1 %t1211, { %Decorator*, i64 }* %t1210, { %Decorator*, i64 }* %t1205
  %t1213 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1214 = bitcast [64 x i8]* %t1213 to i8*
  %t1215 = getelementptr inbounds i8, i8* %t1214, i64 56
  %t1216 = bitcast i8* %t1215 to { %Decorator*, i64 }**
  %t1217 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1216
  %t1218 = icmp eq i32 %t1120, 18
  %t1219 = select i1 %t1218, { %Decorator*, i64 }* %t1217, { %Decorator*, i64 }* %t1212
  %t1220 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1221 = bitcast [88 x i8]* %t1220 to i8*
  %t1222 = getelementptr inbounds i8, i8* %t1221, i64 80
  %t1223 = bitcast i8* %t1222 to { %Decorator*, i64 }**
  %t1224 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1223
  %t1225 = icmp eq i32 %t1120, 19
  %t1226 = select i1 %t1225, { %Decorator*, i64 }* %t1224, { %Decorator*, i64 }* %t1219
  %t1227 = load i8*, i8** %l5
  %t1228 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1056, %Block %t1119, { %Decorator*, i64 }* %t1226, i8* %t1227)
  ret { %EffectViolation*, i64 }* %t1228
merge7:
  %t1229 = extractvalue %Statement %statement, 0
  %t1230 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1231 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1229, 0
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1229, 1
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1229, 2
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %t1240 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1241 = icmp eq i32 %t1229, 3
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1239
  %t1243 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1244 = icmp eq i32 %t1229, 4
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1242
  %t1246 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1247 = icmp eq i32 %t1229, 5
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1245
  %t1249 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1250 = icmp eq i32 %t1229, 6
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1248
  %t1252 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1229, 7
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1229, 8
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1229, 9
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1229, 10
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1229, 11
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1229, 12
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1229, 13
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1229, 14
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1229, 15
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1229, 16
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1229, 17
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1229, 18
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1229, 19
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1229, 20
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1229, 21
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1229, 22
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1229, 23
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = call i8* @malloc(i64 18)
  %t1304 = bitcast i8* %t1303 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t1304
  %t1305 = call i1 @strings_equal(i8* %t1302, i8* %t1303)
  br i1 %t1305, label %then8, label %merge9
then8:
  %t1306 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1307 = ptrtoint [0 x %EffectViolation]* %t1306 to i64
  %t1308 = icmp eq i64 %t1307, 0
  %t1309 = select i1 %t1308, i64 1, i64 %t1307
  %t1310 = call i8* @malloc(i64 %t1309)
  %t1311 = bitcast i8* %t1310 to %EffectViolation*
  %t1312 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t1313 = ptrtoint { %EffectViolation*, i64 }* %t1312 to i64
  %t1314 = call i8* @malloc(i64 %t1313)
  %t1315 = bitcast i8* %t1314 to { %EffectViolation*, i64 }*
  %t1316 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1315, i32 0, i32 0
  store %EffectViolation* %t1311, %EffectViolation** %t1316
  %t1317 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1315, i32 0, i32 1
  store i64 0, i64* %t1317
  store { %EffectViolation*, i64 }* %t1315, { %EffectViolation*, i64 }** %l6
  %t1318 = sitofp i64 0 to double
  store double %t1318, double* %l7
  %t1319 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1320 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1422 = phi { %EffectViolation*, i64 }* [ %t1319, %then8 ], [ %t1420, %loop.latch12 ]
  %t1423 = phi double [ %t1320, %then8 ], [ %t1421, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1422, { %EffectViolation*, i64 }** %l6
  store double %t1423, double* %l7
  br label %loop.body11
loop.body11:
  %t1321 = load double, double* %l7
  %t1322 = extractvalue %Statement %statement, 0
  %t1323 = alloca %Statement
  store %Statement %statement, %Statement* %t1323
  %t1324 = getelementptr inbounds %Statement, %Statement* %t1323, i32 0, i32 1
  %t1325 = bitcast [56 x i8]* %t1324 to i8*
  %t1326 = getelementptr inbounds i8, i8* %t1325, i64 40
  %t1327 = bitcast i8* %t1326 to { %MethodDeclaration*, i64 }**
  %t1328 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1327
  %t1329 = icmp eq i32 %t1322, 8
  %t1330 = select i1 %t1329, { %MethodDeclaration*, i64 }* %t1328, { %MethodDeclaration*, i64 }* null
  %t1331 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1330
  %t1332 = extractvalue { %MethodDeclaration*, i64 } %t1331, 1
  %t1333 = sitofp i64 %t1332 to double
  %t1334 = fcmp oge double %t1321, %t1333
  %t1335 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1336 = load double, double* %l7
  br i1 %t1334, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1337 = extractvalue %Statement %statement, 0
  %t1338 = alloca %Statement
  store %Statement %statement, %Statement* %t1338
  %t1339 = getelementptr inbounds %Statement, %Statement* %t1338, i32 0, i32 1
  %t1340 = bitcast [56 x i8]* %t1339 to i8*
  %t1341 = getelementptr inbounds i8, i8* %t1340, i64 40
  %t1342 = bitcast i8* %t1341 to { %MethodDeclaration*, i64 }**
  %t1343 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1342
  %t1344 = icmp eq i32 %t1337, 8
  %t1345 = select i1 %t1344, { %MethodDeclaration*, i64 }* %t1343, { %MethodDeclaration*, i64 }* null
  %t1346 = load double, double* %l7
  %t1347 = call double @llvm.round.f64(double %t1346)
  %t1348 = fptosi double %t1347 to i64
  %t1349 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1345
  %t1350 = extractvalue { %MethodDeclaration*, i64 } %t1349, 0
  %t1351 = extractvalue { %MethodDeclaration*, i64 } %t1349, 1
  %t1352 = icmp uge i64 %t1348, %t1351
  ; bounds check: %t1352 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1348, i64 %t1351)
  %t1353 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1350, i64 %t1348
  %t1354 = load %MethodDeclaration, %MethodDeclaration* %t1353
  store %MethodDeclaration %t1354, %MethodDeclaration* %l8
  %t1355 = extractvalue %Statement %statement, 0
  %t1356 = alloca %Statement
  store %Statement %statement, %Statement* %t1356
  %t1357 = getelementptr inbounds %Statement, %Statement* %t1356, i32 0, i32 1
  %t1358 = bitcast [48 x i8]* %t1357 to i8*
  %t1359 = bitcast i8* %t1358 to i8**
  %t1360 = load i8*, i8** %t1359
  %t1361 = icmp eq i32 %t1355, 2
  %t1362 = select i1 %t1361, i8* %t1360, i8* null
  %t1363 = getelementptr inbounds %Statement, %Statement* %t1356, i32 0, i32 1
  %t1364 = bitcast [48 x i8]* %t1363 to i8*
  %t1365 = bitcast i8* %t1364 to i8**
  %t1366 = load i8*, i8** %t1365
  %t1367 = icmp eq i32 %t1355, 3
  %t1368 = select i1 %t1367, i8* %t1366, i8* %t1362
  %t1369 = getelementptr inbounds %Statement, %Statement* %t1356, i32 0, i32 1
  %t1370 = bitcast [56 x i8]* %t1369 to i8*
  %t1371 = bitcast i8* %t1370 to i8**
  %t1372 = load i8*, i8** %t1371
  %t1373 = icmp eq i32 %t1355, 6
  %t1374 = select i1 %t1373, i8* %t1372, i8* %t1368
  %t1375 = getelementptr inbounds %Statement, %Statement* %t1356, i32 0, i32 1
  %t1376 = bitcast [56 x i8]* %t1375 to i8*
  %t1377 = bitcast i8* %t1376 to i8**
  %t1378 = load i8*, i8** %t1377
  %t1379 = icmp eq i32 %t1355, 8
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1374
  %t1381 = getelementptr inbounds %Statement, %Statement* %t1356, i32 0, i32 1
  %t1382 = bitcast [40 x i8]* %t1381 to i8*
  %t1383 = bitcast i8* %t1382 to i8**
  %t1384 = load i8*, i8** %t1383
  %t1385 = icmp eq i32 %t1355, 9
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1380
  %t1387 = getelementptr inbounds %Statement, %Statement* %t1356, i32 0, i32 1
  %t1388 = bitcast [40 x i8]* %t1387 to i8*
  %t1389 = bitcast i8* %t1388 to i8**
  %t1390 = load i8*, i8** %t1389
  %t1391 = icmp eq i32 %t1355, 10
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1386
  %t1393 = getelementptr inbounds %Statement, %Statement* %t1356, i32 0, i32 1
  %t1394 = bitcast [40 x i8]* %t1393 to i8*
  %t1395 = bitcast i8* %t1394 to i8**
  %t1396 = load i8*, i8** %t1395
  %t1397 = icmp eq i32 %t1355, 11
  %t1398 = select i1 %t1397, i8* %t1396, i8* %t1392
  %t1399 = add i64 0, 2
  %t1400 = call i8* @malloc(i64 %t1399)
  store i8 46, i8* %t1400
  %t1401 = getelementptr i8, i8* %t1400, i64 1
  store i8 0, i8* %t1401
  call void @sailfin_runtime_mark_persistent(i8* %t1400)
  %t1402 = call i8* @sailfin_runtime_string_concat(i8* %t1398, i8* %t1400)
  %t1403 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1404 = extractvalue %MethodDeclaration %t1403, 0
  %t1405 = extractvalue %FunctionSignature %t1404, 0
  %t1406 = call i8* @sailfin_runtime_string_concat(i8* %t1402, i8* %t1405)
  store i8* %t1406, i8** %l9
  %t1407 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1408 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1409 = extractvalue %MethodDeclaration %t1408, 0
  %t1410 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1411 = extractvalue %MethodDeclaration %t1410, 1
  %t1412 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1413 = extractvalue %MethodDeclaration %t1412, 2
  %t1414 = load i8*, i8** %l9
  %t1415 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1409, %Block %t1411, { %Decorator*, i64 }* %t1413, i8* %t1414)
  %t1416 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t1407, { %EffectViolation*, i64 }* %t1415)
  store { %EffectViolation*, i64 }* %t1416, { %EffectViolation*, i64 }** %l6
  %t1417 = load double, double* %l7
  %t1418 = sitofp i64 1 to double
  %t1419 = fadd double %t1417, %t1418
  store double %t1419, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1420 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1421 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1424 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1425 = load double, double* %l7
  %t1426 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1426
merge9:
  %t1427 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1428 = ptrtoint [0 x %EffectViolation]* %t1427 to i64
  %t1429 = icmp eq i64 %t1428, 0
  %t1430 = select i1 %t1429, i64 1, i64 %t1428
  %t1431 = call i8* @malloc(i64 %t1430)
  %t1432 = bitcast i8* %t1431 to %EffectViolation*
  %t1433 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t1434 = ptrtoint { %EffectViolation*, i64 }* %t1433 to i64
  %t1435 = call i8* @malloc(i64 %t1434)
  %t1436 = bitcast i8* %t1435 to { %EffectViolation*, i64 }*
  %t1437 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1436, i32 0, i32 0
  store %EffectViolation* %t1432, %EffectViolation** %t1437
  %t1438 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1436, i32 0, i32 1
  store i64 0, i64* %t1438
  ret { %EffectViolation*, i64 }* %t1436
}

define { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators, i8* %name) {
block.entry:
  %l0 = alloca { %DecoratorInfo*, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca double
  %l5 = alloca %DecoratorInfo
  %l6 = alloca { %EffectRequirement*, i64 }*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca { %EffectRequirement*, i64 }*
  %l9 = alloca double
  %l10 = alloca %EffectRequirement
  %l11 = alloca i8*
  %l12 = alloca { %EffectViolation*, i64 }*
  %t0 = call { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store { %DecoratorInfo*, i64 }* %t0, { %DecoratorInfo*, i64 }** %l0
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t43 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t41, %loop.latch2 ]
  %t44 = phi double [ %t16, %block.entry ], [ %t42, %loop.latch2 ]
  store { i8**, i64 }* %t43, { i8**, i64 }** %l1
  store double %t44, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = extractvalue %FunctionSignature %signature, 4
  %t19 = load { i8**, i64 }, { i8**, i64 }* %t18
  %t20 = extractvalue { i8**, i64 } %t19, 1
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t17, %t21
  %t23 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t25 = load double, double* %l2
  br i1 %t22, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = extractvalue %FunctionSignature %signature, 4
  %t28 = load double, double* %l2
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t27
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t30, i64 %t33)
  %t35 = getelementptr i8*, i8** %t32, i64 %t30
  %t36 = load i8*, i8** %t35
  %t37 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t26, i8* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l1
  %t38 = load double, double* %l2
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l2
  br label %loop.latch2
loop.latch2:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load double, double* %l2
  store i1 0, i1* %l3
  %t47 = sitofp i64 0 to double
  store double %t47, double* %l4
  %t48 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load double, double* %l2
  %t51 = load i1, i1* %l3
  %t52 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t104 = phi i1 [ %t51, %afterloop3 ], [ %t102, %loop.latch8 ]
  %t105 = phi double [ %t52, %afterloop3 ], [ %t103, %loop.latch8 ]
  store i1 %t104, i1* %l3
  store double %t105, double* %l4
  br label %loop.body7
loop.body7:
  %t53 = load double, double* %l4
  %t54 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t55 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t54
  %t56 = extractvalue { %DecoratorInfo*, i64 } %t55, 1
  %t57 = sitofp i64 %t56 to double
  %t58 = fcmp oge double %t53, %t57
  %t59 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  %t62 = load i1, i1* %l3
  %t63 = load double, double* %l4
  br i1 %t58, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t64 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t65 = load double, double* %l4
  %t66 = call double @llvm.round.f64(double %t65)
  %t67 = fptosi double %t66 to i64
  %t68 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t64
  %t69 = extractvalue { %DecoratorInfo*, i64 } %t68, 0
  %t70 = extractvalue { %DecoratorInfo*, i64 } %t68, 1
  %t71 = icmp uge i64 %t67, %t70
  ; bounds check: %t71 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t67, i64 %t70)
  %t72 = getelementptr %DecoratorInfo, %DecoratorInfo* %t69, i64 %t67
  %t73 = load %DecoratorInfo, %DecoratorInfo* %t72
  store %DecoratorInfo %t73, %DecoratorInfo* %l5
  %t75 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t76 = extractvalue %DecoratorInfo %t75, 0
  %t77 = call i8* @malloc(i64 6)
  %t78 = bitcast i8* %t77 to [6 x i8]*
  store [6 x i8] c"trace\00", [6 x i8]* %t78
  %t79 = call i1 @strings_equal(i8* %t76, i8* %t77)
  br label %logical_or_entry_74

logical_or_entry_74:
  br i1 %t79, label %logical_or_merge_74, label %logical_or_right_74

logical_or_right_74:
  %t81 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t82 = extractvalue %DecoratorInfo %t81, 0
  %t83 = call i8* @malloc(i64 13)
  %t84 = bitcast i8* %t83 to [13 x i8]*
  store [13 x i8] c"logExecution\00", [13 x i8]* %t84
  %t85 = call i1 @strings_equal(i8* %t82, i8* %t83)
  br label %logical_or_entry_80

logical_or_entry_80:
  br i1 %t85, label %logical_or_merge_80, label %logical_or_right_80

logical_or_right_80:
  %t86 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t87 = extractvalue %DecoratorInfo %t86, 0
  %t88 = call i8* @malloc(i64 13)
  %t89 = bitcast i8* %t88 to [13 x i8]*
  store [13 x i8] c"logexecution\00", [13 x i8]* %t89
  %t90 = call i1 @strings_equal(i8* %t87, i8* %t88)
  br label %logical_or_right_end_80

logical_or_right_end_80:
  br label %logical_or_merge_80

logical_or_merge_80:
  %t91 = phi i1 [ true, %logical_or_entry_80 ], [ %t90, %logical_or_right_end_80 ]
  br label %logical_or_right_end_74

logical_or_right_end_74:
  br label %logical_or_merge_74

logical_or_merge_74:
  %t92 = phi i1 [ true, %logical_or_entry_74 ], [ %t91, %logical_or_right_end_74 ]
  %t93 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load double, double* %l2
  %t96 = load i1, i1* %l3
  %t97 = load double, double* %l4
  %t98 = load %DecoratorInfo, %DecoratorInfo* %l5
  br i1 %t92, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t99 = load double, double* %l4
  %t100 = sitofp i64 1 to double
  %t101 = fadd double %t99, %t100
  store double %t101, double* %l4
  br label %loop.latch8
loop.latch8:
  %t102 = load i1, i1* %l3
  %t103 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t106 = load i1, i1* %l3
  %t107 = load double, double* %l4
  %t108 = load i1, i1* %l3
  %t109 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t111 = load double, double* %l2
  %t112 = load i1, i1* %l3
  %t113 = load double, double* %l4
  br i1 %t108, label %then14, label %merge15
then14:
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t115 = call i8* @malloc(i64 3)
  %t116 = bitcast i8* %t115 to [3 x i8]*
  store [3 x i8] c"io\00", [3 x i8]* %t116
  %t117 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t114, i8* %t115)
  store { i8**, i64 }* %t117, { i8**, i64 }** %l1
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t119 = phi { i8**, i64 }* [ %t118, %then14 ], [ %t110, %afterloop9 ]
  store { i8**, i64 }* %t119, { i8**, i64 }** %l1
  %t120 = call { %EffectRequirement*, i64 }* @required_effects(%Block %body)
  store { %EffectRequirement*, i64 }* %t120, { %EffectRequirement*, i64 }** %l6
  %t121 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t122 = ptrtoint [0 x i8*]* %t121 to i64
  %t123 = icmp eq i64 %t122, 0
  %t124 = select i1 %t123, i64 1, i64 %t122
  %t125 = call i8* @malloc(i64 %t124)
  %t126 = bitcast i8* %t125 to i8**
  %t127 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t128 = ptrtoint { i8**, i64 }* %t127 to i64
  %t129 = call i8* @malloc(i64 %t128)
  %t130 = bitcast i8* %t129 to { i8**, i64 }*
  %t131 = getelementptr { i8**, i64 }, { i8**, i64 }* %t130, i32 0, i32 0
  store i8** %t126, i8*** %t131
  %t132 = getelementptr { i8**, i64 }, { i8**, i64 }* %t130, i32 0, i32 1
  store i64 0, i64* %t132
  store { i8**, i64 }* %t130, { i8**, i64 }** %l7
  %t133 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t134 = ptrtoint [0 x %EffectRequirement]* %t133 to i64
  %t135 = icmp eq i64 %t134, 0
  %t136 = select i1 %t135, i64 1, i64 %t134
  %t137 = call i8* @malloc(i64 %t136)
  %t138 = bitcast i8* %t137 to %EffectRequirement*
  %t139 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t140 = ptrtoint { %EffectRequirement*, i64 }* %t139 to i64
  %t141 = call i8* @malloc(i64 %t140)
  %t142 = bitcast i8* %t141 to { %EffectRequirement*, i64 }*
  %t143 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t142, i32 0, i32 0
  store %EffectRequirement* %t138, %EffectRequirement** %t143
  %t144 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t142, i32 0, i32 1
  store i64 0, i64* %t144
  store { %EffectRequirement*, i64 }* %t142, { %EffectRequirement*, i64 }** %l8
  %t145 = sitofp i64 0 to double
  store double %t145, double* %l9
  %t146 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t148 = load double, double* %l2
  %t149 = load i1, i1* %l3
  %t150 = load double, double* %l4
  %t151 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t153 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t154 = load double, double* %l9
  br label %loop.header16
loop.header16:
  %t249 = phi double [ %t154, %merge15 ], [ %t246, %loop.latch18 ]
  %t250 = phi { i8**, i64 }* [ %t152, %merge15 ], [ %t247, %loop.latch18 ]
  %t251 = phi { %EffectRequirement*, i64 }* [ %t153, %merge15 ], [ %t248, %loop.latch18 ]
  store double %t249, double* %l9
  store { i8**, i64 }* %t250, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t251, { %EffectRequirement*, i64 }** %l8
  br label %loop.body17
loop.body17:
  %t155 = load double, double* %l9
  %t156 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t157 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t156
  %t158 = extractvalue { %EffectRequirement*, i64 } %t157, 1
  %t159 = sitofp i64 %t158 to double
  %t160 = fcmp oge double %t155, %t159
  %t161 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t163 = load double, double* %l2
  %t164 = load i1, i1* %l3
  %t165 = load double, double* %l4
  %t166 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t168 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t169 = load double, double* %l9
  br i1 %t160, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t170 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t171 = load double, double* %l9
  %t172 = call double @llvm.round.f64(double %t171)
  %t173 = fptosi double %t172 to i64
  %t174 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t170
  %t175 = extractvalue { %EffectRequirement*, i64 } %t174, 0
  %t176 = extractvalue { %EffectRequirement*, i64 } %t174, 1
  %t177 = icmp uge i64 %t173, %t176
  ; bounds check: %t177 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t173, i64 %t176)
  %t178 = getelementptr %EffectRequirement, %EffectRequirement* %t175, i64 %t173
  %t179 = load %EffectRequirement, %EffectRequirement* %t178
  store %EffectRequirement %t179, %EffectRequirement* %l10
  %t180 = load %EffectRequirement, %EffectRequirement* %l10
  %t181 = extractvalue %EffectRequirement %t180, 0
  store i8* %t181, i8** %l11
  %t183 = load i8*, i8** %l11
  %t184 = call i8* @malloc(i64 3)
  %t185 = bitcast i8* %t184 to [3 x i8]*
  store [3 x i8] c"io\00", [3 x i8]* %t185
  %t186 = call i1 @strings_equal(i8* %t183, i8* %t184)
  br label %logical_and_entry_182

logical_and_entry_182:
  br i1 %t186, label %logical_and_right_182, label %logical_and_merge_182

logical_and_right_182:
  %t187 = load i1, i1* %l3
  br label %logical_and_right_end_182

logical_and_right_end_182:
  br label %logical_and_merge_182

logical_and_merge_182:
  %t188 = phi i1 [ false, %logical_and_entry_182 ], [ %t187, %logical_and_right_end_182 ]
  %t189 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t191 = load double, double* %l2
  %t192 = load i1, i1* %l3
  %t193 = load double, double* %l4
  %t194 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t196 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t197 = load double, double* %l9
  %t198 = load %EffectRequirement, %EffectRequirement* %l10
  %t199 = load i8*, i8** %l11
  br i1 %t188, label %then22, label %merge23
then22:
  %t200 = load double, double* %l9
  %t201 = sitofp i64 1 to double
  %t202 = fadd double %t200, %t201
  store double %t202, double* %l9
  br label %loop.latch18
merge23:
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t204 = load i8*, i8** %l11
  %t205 = call i1 @contains_effect__effect_checker({ i8**, i64 }* %t203, i8* %t204)
  %t206 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t208 = load double, double* %l2
  %t209 = load i1, i1* %l3
  %t210 = load double, double* %l4
  %t211 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t213 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t214 = load double, double* %l9
  %t215 = load %EffectRequirement, %EffectRequirement* %l10
  %t216 = load i8*, i8** %l11
  br i1 %t205, label %then24, label %merge25
then24:
  %t217 = load double, double* %l9
  %t218 = sitofp i64 1 to double
  %t219 = fadd double %t217, %t218
  store double %t219, double* %l9
  br label %loop.latch18
merge25:
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t221 = load i8*, i8** %l11
  %t222 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t220, i8* %t221)
  store { i8**, i64 }* %t222, { i8**, i64 }** %l7
  %t223 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t224 = load i8*, i8** %l11
  %t225 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t223, i8* %t224)
  %t226 = xor i1 %t225, 1
  %t227 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t229 = load double, double* %l2
  %t230 = load i1, i1* %l3
  %t231 = load double, double* %l4
  %t232 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t234 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t235 = load double, double* %l9
  %t236 = load %EffectRequirement, %EffectRequirement* %l10
  %t237 = load i8*, i8** %l11
  br i1 %t226, label %then26, label %merge27
then26:
  %t238 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t239 = load %EffectRequirement, %EffectRequirement* %l10
  %t240 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t238, %EffectRequirement %t239)
  store { %EffectRequirement*, i64 }* %t240, { %EffectRequirement*, i64 }** %l8
  %t241 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %merge27
merge27:
  %t242 = phi { %EffectRequirement*, i64 }* [ %t241, %then26 ], [ %t234, %merge25 ]
  store { %EffectRequirement*, i64 }* %t242, { %EffectRequirement*, i64 }** %l8
  %t243 = load double, double* %l9
  %t244 = sitofp i64 1 to double
  %t245 = fadd double %t243, %t244
  store double %t245, double* %l9
  br label %loop.latch18
loop.latch18:
  %t246 = load double, double* %l9
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t248 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header16
afterloop19:
  %t252 = load double, double* %l9
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t254 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t256 = load { i8**, i64 }, { i8**, i64 }* %t255
  %t257 = extractvalue { i8**, i64 } %t256, 1
  %t258 = icmp eq i64 %t257, 0
  %t259 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t261 = load double, double* %l2
  %t262 = load i1, i1* %l3
  %t263 = load double, double* %l4
  %t264 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t266 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t267 = load double, double* %l9
  br i1 %t258, label %then28, label %merge29
then28:
  %t268 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t269 = ptrtoint [0 x %EffectViolation]* %t268 to i64
  %t270 = icmp eq i64 %t269, 0
  %t271 = select i1 %t270, i64 1, i64 %t269
  %t272 = call i8* @malloc(i64 %t271)
  %t273 = bitcast i8* %t272 to %EffectViolation*
  %t274 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t275 = ptrtoint { %EffectViolation*, i64 }* %t274 to i64
  %t276 = call i8* @malloc(i64 %t275)
  %t277 = bitcast i8* %t276 to { %EffectViolation*, i64 }*
  %t278 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t277, i32 0, i32 0
  store %EffectViolation* %t273, %EffectViolation** %t278
  %t279 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t277, i32 0, i32 1
  store i64 0, i64* %t279
  ret { %EffectViolation*, i64 }* %t277
merge29:
  %t280 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t281 = ptrtoint [0 x %EffectViolation]* %t280 to i64
  %t282 = icmp eq i64 %t281, 0
  %t283 = select i1 %t282, i64 1, i64 %t281
  %t284 = call i8* @malloc(i64 %t283)
  %t285 = bitcast i8* %t284 to %EffectViolation*
  %t286 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t287 = ptrtoint { %EffectViolation*, i64 }* %t286 to i64
  %t288 = call i8* @malloc(i64 %t287)
  %t289 = bitcast i8* %t288 to { %EffectViolation*, i64 }*
  %t290 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t289, i32 0, i32 0
  store %EffectViolation* %t285, %EffectViolation** %t290
  %t291 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t289, i32 0, i32 1
  store i64 0, i64* %t291
  store { %EffectViolation*, i64 }* %t289, { %EffectViolation*, i64 }** %l12
  %t292 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  %t293 = insertvalue %EffectViolation undef, i8* %name, 0
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t295 = insertvalue %EffectViolation %t293, { i8**, i64 }* %t294, 1
  %t296 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t297 = insertvalue %EffectViolation %t295, { %EffectRequirement*, i64 }* %t296, 2
  %t298 = call { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %t292, %EffectViolation %t297)
  store { %EffectViolation*, i64 }* %t298, { %EffectViolation*, i64 }** %l12
  %t299 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t299
}

define { %EffectRequirement*, i64 }* @required_effects(%Block %body) {
block.entry:
  %t0 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %body)
  ret { %EffectRequirement*, i64 }* %t0
}

define { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %block) {
block.entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %t0 = extractvalue %Block %block, 0
  %t1 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t0)
  store { %EffectRequirement*, i64 }* %t1, { %EffectRequirement*, i64 }** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t31 = phi { %EffectRequirement*, i64 }* [ %t3, %block.entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t4, %block.entry ], [ %t30, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t31, { %EffectRequirement*, i64 }** %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = extractvalue %Block %block, 2
  %t7 = load { %Statement*, i64 }, { %Statement*, i64 }* %t6
  %t8 = extractvalue { %Statement*, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t5, %t9
  %t11 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t14 = extractvalue %Block %block, 2
  %t15 = load double, double* %l1
  %t16 = call double @llvm.round.f64(double %t15)
  %t17 = fptosi double %t16 to i64
  %t18 = load { %Statement*, i64 }, { %Statement*, i64 }* %t14
  %t19 = extractvalue { %Statement*, i64 } %t18, 0
  %t20 = extractvalue { %Statement*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
  %t22 = getelementptr %Statement, %Statement* %t19, i64 %t17
  %t23 = load %Statement, %Statement* %t22
  %t24 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %t23)
  %t25 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t13, { %EffectRequirement*, i64 }* %t24)
  store { %EffectRequirement*, i64 }* %t25, { %EffectRequirement*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t33 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t35
}

define { %EffectRequirement*, i64 }* @collect_effects_from_optional_block(%Block* %block) {
block.entry:
  %t0 = icmp eq %Block* %block, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t2 = ptrtoint [0 x %EffectRequirement]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %EffectRequirement*
  %t7 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t8 = ptrtoint { %EffectRequirement*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %EffectRequirement*, i64 }*
  %t11 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 0
  store %EffectRequirement* %t6, %EffectRequirement** %t11
  %t12 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  ret { %EffectRequirement*, i64 }* %t10
merge1:
  %t13 = load %Block, %Block* %block
  %t14 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t13)
  ret { %EffectRequirement*, i64 }* %t14
}

define { %EffectRequirement*, i64 }* @collect_effects_from_optional_statement(%Statement* %statement) {
block.entry:
  %t0 = icmp eq %Statement* %statement, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t2 = ptrtoint [0 x %EffectRequirement]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %EffectRequirement*
  %t7 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t8 = ptrtoint { %EffectRequirement*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %EffectRequirement*, i64 }*
  %t11 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 0
  store %EffectRequirement* %t6, %EffectRequirement** %t11
  %t12 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  ret { %EffectRequirement*, i64 }* %t10
merge1:
  %t13 = load %Statement, %Statement* %statement
  %t14 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %t13)
  ret { %EffectRequirement*, i64 }* %t14
}

define { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %statement) {
block.entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %l3 = alloca %WithClause
  %l4 = alloca { %EffectRequirement*, i64 }*
  %l5 = alloca { %EffectRequirement*, i64 }*
  %l6 = alloca double
  %l7 = alloca { %EffectRequirement*, i64 }*
  %l8 = alloca %ElseBranch*
  %l9 = alloca { %EffectRequirement*, i64 }*
  %l10 = alloca double
  %l11 = alloca { %EffectRequirement*, i64 }*
  %l12 = alloca double
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
  %t62 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t0, 20
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t0, 21
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t0, 22
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t0, 23
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = call i8* @malloc(i64 16)
  %t75 = bitcast i8* %t74 to [16 x i8]*
  store [16 x i8] c"PromptStatement\00", [16 x i8]* %t75
  %t76 = call i1 @strings_equal(i8* %t73, i8* %t74)
  br i1 %t76, label %then0, label %merge1
then0:
  %t77 = extractvalue %Statement %statement, 0
  %t78 = alloca %Statement
  store %Statement %statement, %Statement* %t78
  %t79 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t80 = bitcast [88 x i8]* %t79 to i8*
  %t81 = getelementptr inbounds i8, i8* %t80, i64 56
  %t82 = bitcast i8* %t81 to %Block*
  %t83 = load %Block, %Block* %t82
  %t84 = icmp eq i32 %t77, 4
  %t85 = select i1 %t84, %Block %t83, %Block zeroinitializer
  %t86 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t87 = bitcast [88 x i8]* %t86 to i8*
  %t88 = getelementptr inbounds i8, i8* %t87, i64 56
  %t89 = bitcast i8* %t88 to %Block*
  %t90 = load %Block, %Block* %t89
  %t91 = icmp eq i32 %t77, 5
  %t92 = select i1 %t91, %Block %t90, %Block %t85
  %t93 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t94 = bitcast [56 x i8]* %t93 to i8*
  %t95 = getelementptr inbounds i8, i8* %t94, i64 16
  %t96 = bitcast i8* %t95 to %Block*
  %t97 = load %Block, %Block* %t96
  %t98 = icmp eq i32 %t77, 6
  %t99 = select i1 %t98, %Block %t97, %Block %t92
  %t100 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t101 = bitcast [88 x i8]* %t100 to i8*
  %t102 = getelementptr inbounds i8, i8* %t101, i64 56
  %t103 = bitcast i8* %t102 to %Block*
  %t104 = load %Block, %Block* %t103
  %t105 = icmp eq i32 %t77, 7
  %t106 = select i1 %t105, %Block %t104, %Block %t99
  %t107 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t108 = bitcast [120 x i8]* %t107 to i8*
  %t109 = getelementptr inbounds i8, i8* %t108, i64 88
  %t110 = bitcast i8* %t109 to %Block*
  %t111 = load %Block, %Block* %t110
  %t112 = icmp eq i32 %t77, 12
  %t113 = select i1 %t112, %Block %t111, %Block %t106
  %t114 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t115 = bitcast [40 x i8]* %t114 to i8*
  %t116 = getelementptr inbounds i8, i8* %t115, i64 8
  %t117 = bitcast i8* %t116 to %Block*
  %t118 = load %Block, %Block* %t117
  %t119 = icmp eq i32 %t77, 13
  %t120 = select i1 %t119, %Block %t118, %Block %t113
  %t121 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t122 = bitcast [136 x i8]* %t121 to i8*
  %t123 = getelementptr inbounds i8, i8* %t122, i64 104
  %t124 = bitcast i8* %t123 to %Block*
  %t125 = load %Block, %Block* %t124
  %t126 = icmp eq i32 %t77, 14
  %t127 = select i1 %t126, %Block %t125, %Block %t120
  %t128 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t129 = bitcast [32 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to %Block*
  %t131 = load %Block, %Block* %t130
  %t132 = icmp eq i32 %t77, 15
  %t133 = select i1 %t132, %Block %t131, %Block %t127
  %t134 = getelementptr inbounds %Statement, %Statement* %t78, i32 0, i32 1
  %t135 = bitcast [24 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to %Block*
  %t137 = load %Block, %Block* %t136
  %t138 = icmp eq i32 %t77, 20
  %t139 = select i1 %t138, %Block %t137, %Block %t133
  %t140 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t139)
  store { %EffectRequirement*, i64 }* %t140, { %EffectRequirement*, i64 }** %l0
  %t141 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t142 = call i8* @malloc(i64 6)
  %t143 = bitcast i8* %t142 to [6 x i8]*
  store [6 x i8] c"model\00", [6 x i8]* %t143
  %t144 = insertvalue %EffectRequirement undef, i8* %t142, 0
  %t145 = extractvalue %Statement %statement, 0
  %t146 = alloca %Statement
  store %Statement %statement, %Statement* %t146
  %t147 = getelementptr inbounds %Statement, %Statement* %t146, i32 0, i32 1
  %t148 = bitcast [120 x i8]* %t147 to i8*
  %t149 = getelementptr inbounds i8, i8* %t148, i64 8
  %t150 = bitcast i8* %t149 to %Token*
  %t151 = load %Token, %Token* %t150
  %t152 = icmp eq i32 %t145, 12
  %t153 = select i1 %t152, %Token %t151, %Token zeroinitializer
  %t154 = getelementptr %Token, %Token* null, i32 1
  %t155 = ptrtoint %Token* %t154 to i64
  %t156 = call noalias i8* @malloc(i64 %t155)
  %t157 = bitcast i8* %t156 to %Token*
  store %Token %t153, %Token* %t157
  call void @sailfin_runtime_mark_persistent(i8* %t156)
  %t158 = insertvalue %EffectRequirement %t144, %Token* %t157, 1
  %t159 = call i8* @malloc(i64 9)
  %t160 = bitcast i8* %t159 to [9 x i8]*
  store [9 x i8] c"prompt \22\00", [9 x i8]* %t160
  %t161 = extractvalue %Statement %statement, 0
  %t162 = alloca %Statement
  store %Statement %statement, %Statement* %t162
  %t163 = getelementptr inbounds %Statement, %Statement* %t162, i32 0, i32 1
  %t164 = bitcast [120 x i8]* %t163 to i8*
  %t165 = bitcast i8* %t164 to i8**
  %t166 = load i8*, i8** %t165
  %t167 = icmp eq i32 %t161, 12
  %t168 = select i1 %t167, i8* %t166, i8* null
  %t169 = call i8* @sailfin_runtime_string_concat(i8* %t159, i8* %t168)
  %t170 = add i64 0, 2
  %t171 = call i8* @malloc(i64 %t170)
  store i8 34, i8* %t171
  %t172 = getelementptr i8, i8* %t171, i64 1
  store i8 0, i8* %t172
  call void @sailfin_runtime_mark_persistent(i8* %t171)
  %t173 = call i8* @sailfin_runtime_string_concat(i8* %t169, i8* %t171)
  %t174 = insertvalue %EffectRequirement %t158, i8* %t173, 2
  %t175 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t141, %EffectRequirement %t174)
  store { %EffectRequirement*, i64 }* %t175, { %EffectRequirement*, i64 }** %l0
  %t176 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t176
merge1:
  %t177 = extractvalue %Statement %statement, 0
  %t178 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t179 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t177, 0
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t177, 1
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t177, 2
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t177, 3
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t177, 4
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t177, 5
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t177, 6
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t177, 7
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t177, 8
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t177, 9
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t177, 10
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t177, 11
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t177, 12
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t177, 13
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t177, 14
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t177, 15
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t177, 16
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t177, 17
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t177, 18
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t177, 19
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t177, 20
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %t242 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t243 = icmp eq i32 %t177, 21
  %t244 = select i1 %t243, i8* %t242, i8* %t241
  %t245 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t246 = icmp eq i32 %t177, 22
  %t247 = select i1 %t246, i8* %t245, i8* %t244
  %t248 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t249 = icmp eq i32 %t177, 23
  %t250 = select i1 %t249, i8* %t248, i8* %t247
  %t251 = call i8* @malloc(i64 14)
  %t252 = bitcast i8* %t251 to [14 x i8]*
  store [14 x i8] c"WithStatement\00", [14 x i8]* %t252
  %t253 = call i1 @strings_equal(i8* %t250, i8* %t251)
  br i1 %t253, label %then2, label %merge3
then2:
  %t254 = extractvalue %Statement %statement, 0
  %t255 = alloca %Statement
  store %Statement %statement, %Statement* %t255
  %t256 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t257 = bitcast [88 x i8]* %t256 to i8*
  %t258 = getelementptr inbounds i8, i8* %t257, i64 56
  %t259 = bitcast i8* %t258 to %Block*
  %t260 = load %Block, %Block* %t259
  %t261 = icmp eq i32 %t254, 4
  %t262 = select i1 %t261, %Block %t260, %Block zeroinitializer
  %t263 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t264 = bitcast [88 x i8]* %t263 to i8*
  %t265 = getelementptr inbounds i8, i8* %t264, i64 56
  %t266 = bitcast i8* %t265 to %Block*
  %t267 = load %Block, %Block* %t266
  %t268 = icmp eq i32 %t254, 5
  %t269 = select i1 %t268, %Block %t267, %Block %t262
  %t270 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t271 = bitcast [56 x i8]* %t270 to i8*
  %t272 = getelementptr inbounds i8, i8* %t271, i64 16
  %t273 = bitcast i8* %t272 to %Block*
  %t274 = load %Block, %Block* %t273
  %t275 = icmp eq i32 %t254, 6
  %t276 = select i1 %t275, %Block %t274, %Block %t269
  %t277 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t278 = bitcast [88 x i8]* %t277 to i8*
  %t279 = getelementptr inbounds i8, i8* %t278, i64 56
  %t280 = bitcast i8* %t279 to %Block*
  %t281 = load %Block, %Block* %t280
  %t282 = icmp eq i32 %t254, 7
  %t283 = select i1 %t282, %Block %t281, %Block %t276
  %t284 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t285 = bitcast [120 x i8]* %t284 to i8*
  %t286 = getelementptr inbounds i8, i8* %t285, i64 88
  %t287 = bitcast i8* %t286 to %Block*
  %t288 = load %Block, %Block* %t287
  %t289 = icmp eq i32 %t254, 12
  %t290 = select i1 %t289, %Block %t288, %Block %t283
  %t291 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t292 = bitcast [40 x i8]* %t291 to i8*
  %t293 = getelementptr inbounds i8, i8* %t292, i64 8
  %t294 = bitcast i8* %t293 to %Block*
  %t295 = load %Block, %Block* %t294
  %t296 = icmp eq i32 %t254, 13
  %t297 = select i1 %t296, %Block %t295, %Block %t290
  %t298 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t299 = bitcast [136 x i8]* %t298 to i8*
  %t300 = getelementptr inbounds i8, i8* %t299, i64 104
  %t301 = bitcast i8* %t300 to %Block*
  %t302 = load %Block, %Block* %t301
  %t303 = icmp eq i32 %t254, 14
  %t304 = select i1 %t303, %Block %t302, %Block %t297
  %t305 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t306 = bitcast [32 x i8]* %t305 to i8*
  %t307 = bitcast i8* %t306 to %Block*
  %t308 = load %Block, %Block* %t307
  %t309 = icmp eq i32 %t254, 15
  %t310 = select i1 %t309, %Block %t308, %Block %t304
  %t311 = getelementptr inbounds %Statement, %Statement* %t255, i32 0, i32 1
  %t312 = bitcast [24 x i8]* %t311 to i8*
  %t313 = bitcast i8* %t312 to %Block*
  %t314 = load %Block, %Block* %t313
  %t315 = icmp eq i32 %t254, 20
  %t316 = select i1 %t315, %Block %t314, %Block %t310
  %t317 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t316)
  store { %EffectRequirement*, i64 }* %t317, { %EffectRequirement*, i64 }** %l1
  %t318 = sitofp i64 0 to double
  store double %t318, double* %l2
  %t319 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t320 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t367 = phi { %EffectRequirement*, i64 }* [ %t319, %then2 ], [ %t365, %loop.latch6 ]
  %t368 = phi double [ %t320, %then2 ], [ %t366, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t367, { %EffectRequirement*, i64 }** %l1
  store double %t368, double* %l2
  br label %loop.body5
loop.body5:
  %t321 = load double, double* %l2
  %t322 = extractvalue %Statement %statement, 0
  %t323 = alloca %Statement
  store %Statement %statement, %Statement* %t323
  %t324 = getelementptr inbounds %Statement, %Statement* %t323, i32 0, i32 1
  %t325 = bitcast [40 x i8]* %t324 to i8*
  %t326 = bitcast i8* %t325 to { %WithClause*, i64 }**
  %t327 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %t326
  %t328 = icmp eq i32 %t322, 13
  %t329 = select i1 %t328, { %WithClause*, i64 }* %t327, { %WithClause*, i64 }* null
  %t330 = load { %WithClause*, i64 }, { %WithClause*, i64 }* %t329
  %t331 = extractvalue { %WithClause*, i64 } %t330, 1
  %t332 = sitofp i64 %t331 to double
  %t333 = fcmp oge double %t321, %t332
  %t334 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t335 = load double, double* %l2
  br i1 %t333, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t336 = extractvalue %Statement %statement, 0
  %t337 = alloca %Statement
  store %Statement %statement, %Statement* %t337
  %t338 = getelementptr inbounds %Statement, %Statement* %t337, i32 0, i32 1
  %t339 = bitcast [40 x i8]* %t338 to i8*
  %t340 = bitcast i8* %t339 to { %WithClause*, i64 }**
  %t341 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %t340
  %t342 = icmp eq i32 %t336, 13
  %t343 = select i1 %t342, { %WithClause*, i64 }* %t341, { %WithClause*, i64 }* null
  %t344 = load double, double* %l2
  %t345 = call double @llvm.round.f64(double %t344)
  %t346 = fptosi double %t345 to i64
  %t347 = load { %WithClause*, i64 }, { %WithClause*, i64 }* %t343
  %t348 = extractvalue { %WithClause*, i64 } %t347, 0
  %t349 = extractvalue { %WithClause*, i64 } %t347, 1
  %t350 = icmp uge i64 %t346, %t349
  ; bounds check: %t350 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t346, i64 %t349)
  %t351 = getelementptr %WithClause, %WithClause* %t348, i64 %t346
  %t352 = load %WithClause, %WithClause* %t351
  store %WithClause %t352, %WithClause* %l3
  %t353 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t354 = load %WithClause, %WithClause* %l3
  %t355 = extractvalue %WithClause %t354, 0
  %t356 = getelementptr %Expression, %Expression* null, i32 1
  %t357 = ptrtoint %Expression* %t356 to i64
  %t358 = call noalias i8* @malloc(i64 %t357)
  %t359 = bitcast i8* %t358 to %Expression*
  store %Expression %t355, %Expression* %t359
  call void @sailfin_runtime_mark_persistent(i8* %t358)
  %t360 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t359)
  %t361 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t353, { %EffectRequirement*, i64 }* %t360)
  store { %EffectRequirement*, i64 }* %t361, { %EffectRequirement*, i64 }** %l1
  %t362 = load double, double* %l2
  %t363 = sitofp i64 1 to double
  %t364 = fadd double %t362, %t363
  store double %t364, double* %l2
  br label %loop.latch6
loop.latch6:
  %t365 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t366 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t369 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t370 = load double, double* %l2
  %t371 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t371
merge3:
  %t372 = extractvalue %Statement %statement, 0
  %t373 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t374 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t372, 0
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t372, 1
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t372, 2
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t372, 3
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t372, 4
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t372, 5
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t372, 6
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t372, 7
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t372, 8
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t372, 9
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t372, 10
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t372, 11
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t372, 12
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t372, 13
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t372, 14
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t372, 15
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t372, 16
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t372, 17
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t372, 18
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t372, 19
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t372, 20
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t372, 21
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %t440 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t372, 22
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t372, 23
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %t446 = call i8* @malloc(i64 13)
  %t447 = bitcast i8* %t446 to [13 x i8]*
  store [13 x i8] c"ForStatement\00", [13 x i8]* %t447
  %t448 = call i1 @strings_equal(i8* %t445, i8* %t446)
  br i1 %t448, label %then10, label %merge11
then10:
  %t449 = extractvalue %Statement %statement, 0
  %t450 = alloca %Statement
  store %Statement %statement, %Statement* %t450
  %t451 = getelementptr inbounds %Statement, %Statement* %t450, i32 0, i32 1
  %t452 = bitcast [88 x i8]* %t451 to i8*
  %t453 = getelementptr inbounds i8, i8* %t452, i64 56
  %t454 = bitcast i8* %t453 to %Block*
  %t455 = load %Block, %Block* %t454
  %t456 = icmp eq i32 %t449, 4
  %t457 = select i1 %t456, %Block %t455, %Block zeroinitializer
  %t458 = getelementptr inbounds %Statement, %Statement* %t450, i32 0, i32 1
  %t459 = bitcast [88 x i8]* %t458 to i8*
  %t460 = getelementptr inbounds i8, i8* %t459, i64 56
  %t461 = bitcast i8* %t460 to %Block*
  %t462 = load %Block, %Block* %t461
  %t463 = icmp eq i32 %t449, 5
  %t464 = select i1 %t463, %Block %t462, %Block %t457
  %t465 = getelementptr inbounds %Statement, %Statement* %t450, i32 0, i32 1
  %t466 = bitcast [56 x i8]* %t465 to i8*
  %t467 = getelementptr inbounds i8, i8* %t466, i64 16
  %t468 = bitcast i8* %t467 to %Block*
  %t469 = load %Block, %Block* %t468
  %t470 = icmp eq i32 %t449, 6
  %t471 = select i1 %t470, %Block %t469, %Block %t464
  %t472 = getelementptr inbounds %Statement, %Statement* %t450, i32 0, i32 1
  %t473 = bitcast [88 x i8]* %t472 to i8*
  %t474 = getelementptr inbounds i8, i8* %t473, i64 56
  %t475 = bitcast i8* %t474 to %Block*
  %t476 = load %Block, %Block* %t475
  %t477 = icmp eq i32 %t449, 7
  %t478 = select i1 %t477, %Block %t476, %Block %t471
  %t479 = getelementptr inbounds %Statement, %Statement* %t450, i32 0, i32 1
  %t480 = bitcast [120 x i8]* %t479 to i8*
  %t481 = getelementptr inbounds i8, i8* %t480, i64 88
  %t482 = bitcast i8* %t481 to %Block*
  %t483 = load %Block, %Block* %t482
  %t484 = icmp eq i32 %t449, 12
  %t485 = select i1 %t484, %Block %t483, %Block %t478
  %t486 = getelementptr inbounds %Statement, %Statement* %t450, i32 0, i32 1
  %t487 = bitcast [40 x i8]* %t486 to i8*
  %t488 = getelementptr inbounds i8, i8* %t487, i64 8
  %t489 = bitcast i8* %t488 to %Block*
  %t490 = load %Block, %Block* %t489
  %t491 = icmp eq i32 %t449, 13
  %t492 = select i1 %t491, %Block %t490, %Block %t485
  %t493 = getelementptr inbounds %Statement, %Statement* %t450, i32 0, i32 1
  %t494 = bitcast [136 x i8]* %t493 to i8*
  %t495 = getelementptr inbounds i8, i8* %t494, i64 104
  %t496 = bitcast i8* %t495 to %Block*
  %t497 = load %Block, %Block* %t496
  %t498 = icmp eq i32 %t449, 14
  %t499 = select i1 %t498, %Block %t497, %Block %t492
  %t500 = getelementptr inbounds %Statement, %Statement* %t450, i32 0, i32 1
  %t501 = bitcast [32 x i8]* %t500 to i8*
  %t502 = bitcast i8* %t501 to %Block*
  %t503 = load %Block, %Block* %t502
  %t504 = icmp eq i32 %t449, 15
  %t505 = select i1 %t504, %Block %t503, %Block %t499
  %t506 = getelementptr inbounds %Statement, %Statement* %t450, i32 0, i32 1
  %t507 = bitcast [24 x i8]* %t506 to i8*
  %t508 = bitcast i8* %t507 to %Block*
  %t509 = load %Block, %Block* %t508
  %t510 = icmp eq i32 %t449, 20
  %t511 = select i1 %t510, %Block %t509, %Block %t505
  %t512 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t511)
  store { %EffectRequirement*, i64 }* %t512, { %EffectRequirement*, i64 }** %l4
  %t513 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t514 = extractvalue %Statement %statement, 0
  %t515 = alloca %Statement
  store %Statement %statement, %Statement* %t515
  %t516 = getelementptr inbounds %Statement, %Statement* %t515, i32 0, i32 1
  %t517 = bitcast [136 x i8]* %t516 to i8*
  %t518 = bitcast i8* %t517 to %ForClause*
  %t519 = load %ForClause, %ForClause* %t518
  %t520 = icmp eq i32 %t514, 14
  %t521 = select i1 %t520, %ForClause %t519, %ForClause zeroinitializer
  %t522 = extractvalue %ForClause %t521, 0
  %t523 = getelementptr %Expression, %Expression* null, i32 1
  %t524 = ptrtoint %Expression* %t523 to i64
  %t525 = call noalias i8* @malloc(i64 %t524)
  %t526 = bitcast i8* %t525 to %Expression*
  store %Expression %t522, %Expression* %t526
  call void @sailfin_runtime_mark_persistent(i8* %t525)
  %t527 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t526)
  %t528 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t513, { %EffectRequirement*, i64 }* %t527)
  store { %EffectRequirement*, i64 }* %t528, { %EffectRequirement*, i64 }** %l4
  %t529 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t530 = extractvalue %Statement %statement, 0
  %t531 = alloca %Statement
  store %Statement %statement, %Statement* %t531
  %t532 = getelementptr inbounds %Statement, %Statement* %t531, i32 0, i32 1
  %t533 = bitcast [136 x i8]* %t532 to i8*
  %t534 = bitcast i8* %t533 to %ForClause*
  %t535 = load %ForClause, %ForClause* %t534
  %t536 = icmp eq i32 %t530, 14
  %t537 = select i1 %t536, %ForClause %t535, %ForClause zeroinitializer
  %t538 = extractvalue %ForClause %t537, 1
  %t539 = getelementptr %Expression, %Expression* null, i32 1
  %t540 = ptrtoint %Expression* %t539 to i64
  %t541 = call noalias i8* @malloc(i64 %t540)
  %t542 = bitcast i8* %t541 to %Expression*
  store %Expression %t538, %Expression* %t542
  call void @sailfin_runtime_mark_persistent(i8* %t541)
  %t543 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t542)
  %t544 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t529, { %EffectRequirement*, i64 }* %t543)
  store { %EffectRequirement*, i64 }* %t544, { %EffectRequirement*, i64 }** %l4
  %t545 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t545
merge11:
  %t546 = extractvalue %Statement %statement, 0
  %t547 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t548 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t546, 0
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t546, 1
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t546, 2
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t546, 3
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t546, 4
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t546, 5
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t546, 6
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t546, 7
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t546, 8
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t546, 9
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t546, 10
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t546, 11
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t546, 12
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t546, 13
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t546, 14
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t546, 15
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t546, 16
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t546, 17
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t546, 18
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t546, 19
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t546, 20
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t546, 21
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t546, 22
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t546, 23
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %t620 = call i8* @malloc(i64 14)
  %t621 = bitcast i8* %t620 to [14 x i8]*
  store [14 x i8] c"LoopStatement\00", [14 x i8]* %t621
  %t622 = call i1 @strings_equal(i8* %t619, i8* %t620)
  br i1 %t622, label %then12, label %merge13
then12:
  %t623 = extractvalue %Statement %statement, 0
  %t624 = alloca %Statement
  store %Statement %statement, %Statement* %t624
  %t625 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t626 = bitcast [88 x i8]* %t625 to i8*
  %t627 = getelementptr inbounds i8, i8* %t626, i64 56
  %t628 = bitcast i8* %t627 to %Block*
  %t629 = load %Block, %Block* %t628
  %t630 = icmp eq i32 %t623, 4
  %t631 = select i1 %t630, %Block %t629, %Block zeroinitializer
  %t632 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t633 = bitcast [88 x i8]* %t632 to i8*
  %t634 = getelementptr inbounds i8, i8* %t633, i64 56
  %t635 = bitcast i8* %t634 to %Block*
  %t636 = load %Block, %Block* %t635
  %t637 = icmp eq i32 %t623, 5
  %t638 = select i1 %t637, %Block %t636, %Block %t631
  %t639 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t640 = bitcast [56 x i8]* %t639 to i8*
  %t641 = getelementptr inbounds i8, i8* %t640, i64 16
  %t642 = bitcast i8* %t641 to %Block*
  %t643 = load %Block, %Block* %t642
  %t644 = icmp eq i32 %t623, 6
  %t645 = select i1 %t644, %Block %t643, %Block %t638
  %t646 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t647 = bitcast [88 x i8]* %t646 to i8*
  %t648 = getelementptr inbounds i8, i8* %t647, i64 56
  %t649 = bitcast i8* %t648 to %Block*
  %t650 = load %Block, %Block* %t649
  %t651 = icmp eq i32 %t623, 7
  %t652 = select i1 %t651, %Block %t650, %Block %t645
  %t653 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t654 = bitcast [120 x i8]* %t653 to i8*
  %t655 = getelementptr inbounds i8, i8* %t654, i64 88
  %t656 = bitcast i8* %t655 to %Block*
  %t657 = load %Block, %Block* %t656
  %t658 = icmp eq i32 %t623, 12
  %t659 = select i1 %t658, %Block %t657, %Block %t652
  %t660 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t661 = bitcast [40 x i8]* %t660 to i8*
  %t662 = getelementptr inbounds i8, i8* %t661, i64 8
  %t663 = bitcast i8* %t662 to %Block*
  %t664 = load %Block, %Block* %t663
  %t665 = icmp eq i32 %t623, 13
  %t666 = select i1 %t665, %Block %t664, %Block %t659
  %t667 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t668 = bitcast [136 x i8]* %t667 to i8*
  %t669 = getelementptr inbounds i8, i8* %t668, i64 104
  %t670 = bitcast i8* %t669 to %Block*
  %t671 = load %Block, %Block* %t670
  %t672 = icmp eq i32 %t623, 14
  %t673 = select i1 %t672, %Block %t671, %Block %t666
  %t674 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t675 = bitcast [32 x i8]* %t674 to i8*
  %t676 = bitcast i8* %t675 to %Block*
  %t677 = load %Block, %Block* %t676
  %t678 = icmp eq i32 %t623, 15
  %t679 = select i1 %t678, %Block %t677, %Block %t673
  %t680 = getelementptr inbounds %Statement, %Statement* %t624, i32 0, i32 1
  %t681 = bitcast [24 x i8]* %t680 to i8*
  %t682 = bitcast i8* %t681 to %Block*
  %t683 = load %Block, %Block* %t682
  %t684 = icmp eq i32 %t623, 20
  %t685 = select i1 %t684, %Block %t683, %Block %t679
  %t686 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t685)
  ret { %EffectRequirement*, i64 }* %t686
merge13:
  %t687 = extractvalue %Statement %statement, 0
  %t688 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t689 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t687, 0
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t687, 1
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t687, 2
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t687, 3
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t687, 4
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t687, 5
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t687, 6
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t687, 7
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t687, 8
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %t716 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t717 = icmp eq i32 %t687, 9
  %t718 = select i1 %t717, i8* %t716, i8* %t715
  %t719 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t720 = icmp eq i32 %t687, 10
  %t721 = select i1 %t720, i8* %t719, i8* %t718
  %t722 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t723 = icmp eq i32 %t687, 11
  %t724 = select i1 %t723, i8* %t722, i8* %t721
  %t725 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t726 = icmp eq i32 %t687, 12
  %t727 = select i1 %t726, i8* %t725, i8* %t724
  %t728 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t729 = icmp eq i32 %t687, 13
  %t730 = select i1 %t729, i8* %t728, i8* %t727
  %t731 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t687, 14
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t687, 15
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t687, 16
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t687, 17
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t687, 18
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t687, 19
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t687, 20
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t687, 21
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t687, 22
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t687, 23
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = call i8* @malloc(i64 15)
  %t762 = bitcast i8* %t761 to [15 x i8]*
  store [15 x i8] c"MatchStatement\00", [15 x i8]* %t762
  %t763 = call i1 @strings_equal(i8* %t760, i8* %t761)
  br i1 %t763, label %then14, label %merge15
then14:
  %t764 = extractvalue %Statement %statement, 0
  %t765 = alloca %Statement
  store %Statement %statement, %Statement* %t765
  %t766 = getelementptr inbounds %Statement, %Statement* %t765, i32 0, i32 1
  %t767 = bitcast [16 x i8]* %t766 to i8*
  %t768 = bitcast i8* %t767 to %Expression**
  %t769 = load %Expression*, %Expression** %t768
  %t770 = icmp eq i32 %t764, 21
  %t771 = select i1 %t770, %Expression* %t769, %Expression* null
  %t772 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t771)
  store { %EffectRequirement*, i64 }* %t772, { %EffectRequirement*, i64 }** %l5
  %t773 = sitofp i64 0 to double
  store double %t773, double* %l6
  %t774 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t775 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t818 = phi { %EffectRequirement*, i64 }* [ %t774, %then14 ], [ %t816, %loop.latch18 ]
  %t819 = phi double [ %t775, %then14 ], [ %t817, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t818, { %EffectRequirement*, i64 }** %l5
  store double %t819, double* %l6
  br label %loop.body17
loop.body17:
  %t776 = load double, double* %l6
  %t777 = extractvalue %Statement %statement, 0
  %t778 = alloca %Statement
  store %Statement %statement, %Statement* %t778
  %t779 = getelementptr inbounds %Statement, %Statement* %t778, i32 0, i32 1
  %t780 = bitcast [64 x i8]* %t779 to i8*
  %t781 = getelementptr inbounds i8, i8* %t780, i64 48
  %t782 = bitcast i8* %t781 to { %MatchCase*, i64 }**
  %t783 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t782
  %t784 = icmp eq i32 %t777, 18
  %t785 = select i1 %t784, { %MatchCase*, i64 }* %t783, { %MatchCase*, i64 }* null
  %t786 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t785
  %t787 = extractvalue { %MatchCase*, i64 } %t786, 1
  %t788 = sitofp i64 %t787 to double
  %t789 = fcmp oge double %t776, %t788
  %t790 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t791 = load double, double* %l6
  br i1 %t789, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t792 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t793 = extractvalue %Statement %statement, 0
  %t794 = alloca %Statement
  store %Statement %statement, %Statement* %t794
  %t795 = getelementptr inbounds %Statement, %Statement* %t794, i32 0, i32 1
  %t796 = bitcast [64 x i8]* %t795 to i8*
  %t797 = getelementptr inbounds i8, i8* %t796, i64 48
  %t798 = bitcast i8* %t797 to { %MatchCase*, i64 }**
  %t799 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t798
  %t800 = icmp eq i32 %t793, 18
  %t801 = select i1 %t800, { %MatchCase*, i64 }* %t799, { %MatchCase*, i64 }* null
  %t802 = load double, double* %l6
  %t803 = call double @llvm.round.f64(double %t802)
  %t804 = fptosi double %t803 to i64
  %t805 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t801
  %t806 = extractvalue { %MatchCase*, i64 } %t805, 0
  %t807 = extractvalue { %MatchCase*, i64 } %t805, 1
  %t808 = icmp uge i64 %t804, %t807
  ; bounds check: %t808 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t804, i64 %t807)
  %t809 = getelementptr %MatchCase, %MatchCase* %t806, i64 %t804
  %t810 = load %MatchCase, %MatchCase* %t809
  %t811 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t810)
  %t812 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t792, { %EffectRequirement*, i64 }* %t811)
  store { %EffectRequirement*, i64 }* %t812, { %EffectRequirement*, i64 }** %l5
  %t813 = load double, double* %l6
  %t814 = sitofp i64 1 to double
  %t815 = fadd double %t813, %t814
  store double %t815, double* %l6
  br label %loop.latch18
loop.latch18:
  %t816 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t817 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t820 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t821 = load double, double* %l6
  %t822 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t822
merge15:
  %t823 = extractvalue %Statement %statement, 0
  %t824 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t825 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t823, 0
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t823, 1
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t823, 2
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t823, 3
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t823, 4
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %t840 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t823, 5
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t823, 6
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t823, 7
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %t849 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t823, 8
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t823, 9
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t823, 10
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t823, 11
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t823, 12
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t823, 13
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t823, 14
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t823, 15
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t823, 16
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t823, 17
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t823, 18
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t823, 19
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t823, 20
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t823, 21
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t823, 22
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t823, 23
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = call i8* @malloc(i64 12)
  %t898 = bitcast i8* %t897 to [12 x i8]*
  store [12 x i8] c"IfStatement\00", [12 x i8]* %t898
  %t899 = call i1 @strings_equal(i8* %t896, i8* %t897)
  br i1 %t899, label %then22, label %merge23
then22:
  %t900 = extractvalue %Statement %statement, 0
  %t901 = alloca %Statement
  store %Statement %statement, %Statement* %t901
  %t902 = getelementptr inbounds %Statement, %Statement* %t901, i32 0, i32 1
  %t903 = bitcast [88 x i8]* %t902 to i8*
  %t904 = bitcast i8* %t903 to %Expression*
  %t905 = load %Expression, %Expression* %t904
  %t906 = icmp eq i32 %t900, 19
  %t907 = select i1 %t906, %Expression %t905, %Expression zeroinitializer
  %t908 = getelementptr %Expression, %Expression* null, i32 1
  %t909 = ptrtoint %Expression* %t908 to i64
  %t910 = call noalias i8* @malloc(i64 %t909)
  %t911 = bitcast i8* %t910 to %Expression*
  store %Expression %t907, %Expression* %t911
  call void @sailfin_runtime_mark_persistent(i8* %t910)
  %t912 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t911)
  store { %EffectRequirement*, i64 }* %t912, { %EffectRequirement*, i64 }** %l7
  %t913 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t914 = extractvalue %Statement %statement, 0
  %t915 = alloca %Statement
  store %Statement %statement, %Statement* %t915
  %t916 = getelementptr inbounds %Statement, %Statement* %t915, i32 0, i32 1
  %t917 = bitcast [88 x i8]* %t916 to i8*
  %t918 = getelementptr inbounds i8, i8* %t917, i64 48
  %t919 = bitcast i8* %t918 to %Block*
  %t920 = load %Block, %Block* %t919
  %t921 = icmp eq i32 %t914, 19
  %t922 = select i1 %t921, %Block %t920, %Block zeroinitializer
  %t923 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t922)
  %t924 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t913, { %EffectRequirement*, i64 }* %t923)
  store { %EffectRequirement*, i64 }* %t924, { %EffectRequirement*, i64 }** %l7
  %t925 = extractvalue %Statement %statement, 0
  %t926 = alloca %Statement
  store %Statement %statement, %Statement* %t926
  %t927 = getelementptr inbounds %Statement, %Statement* %t926, i32 0, i32 1
  %t928 = bitcast [88 x i8]* %t927 to i8*
  %t929 = getelementptr inbounds i8, i8* %t928, i64 72
  %t930 = bitcast i8* %t929 to %ElseBranch**
  %t931 = load %ElseBranch*, %ElseBranch** %t930
  %t932 = icmp eq i32 %t925, 19
  %t933 = select i1 %t932, %ElseBranch* %t931, %ElseBranch* null
  store %ElseBranch* %t933, %ElseBranch** %l8
  %t934 = load %ElseBranch*, %ElseBranch** %l8
  %t935 = icmp eq %ElseBranch* %t934, null
  %t936 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t937 = load %ElseBranch*, %ElseBranch** %l8
  br i1 %t935, label %then24, label %merge25
then24:
  %t938 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t938
merge25:
  %t939 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t940 = load %ElseBranch*, %ElseBranch** %l8
  %t941 = load %ElseBranch, %ElseBranch* %t940
  %t942 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %t941)
  %t943 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t939, { %EffectRequirement*, i64 }* %t942)
  store { %EffectRequirement*, i64 }* %t943, { %EffectRequirement*, i64 }** %l7
  %t944 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t944
merge23:
  %t945 = extractvalue %Statement %statement, 0
  %t946 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t947 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t945, 0
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t945, 1
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t945, 2
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t945, 3
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t945, 4
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t945, 5
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t945, 6
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t945, 7
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t945, 8
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t945, 9
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t945, 10
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t945, 11
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t945, 12
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t945, 13
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t945, 14
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t945, 15
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t945, 16
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t945, 17
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t945, 18
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t945, 19
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t945, 20
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t945, 21
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t945, 22
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t945, 23
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = call i8* @malloc(i64 16)
  %t1020 = bitcast i8* %t1019 to [16 x i8]*
  store [16 x i8] c"ReturnStatement\00", [16 x i8]* %t1020
  %t1021 = call i1 @strings_equal(i8* %t1018, i8* %t1019)
  br i1 %t1021, label %then26, label %merge27
then26:
  %t1022 = extractvalue %Statement %statement, 0
  %t1023 = alloca %Statement
  store %Statement %statement, %Statement* %t1023
  %t1024 = getelementptr inbounds %Statement, %Statement* %t1023, i32 0, i32 1
  %t1025 = bitcast [16 x i8]* %t1024 to i8*
  %t1026 = bitcast i8* %t1025 to %Expression**
  %t1027 = load %Expression*, %Expression** %t1026
  %t1028 = icmp eq i32 %t1022, 21
  %t1029 = select i1 %t1028, %Expression* %t1027, %Expression* null
  %t1030 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1029)
  ret { %EffectRequirement*, i64 }* %t1030
merge27:
  %t1031 = extractvalue %Statement %statement, 0
  %t1032 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1033 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t1031, 0
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t1031, 1
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t1031, 2
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t1031, 3
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t1031, 4
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1031, 5
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1031, 6
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1031, 7
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1031, 8
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1031, 9
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1031, 10
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1031, 11
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1031, 12
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1031, 13
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1031, 14
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1031, 15
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1031, 16
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1031, 17
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %t1087 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1088 = icmp eq i32 %t1031, 18
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1086
  %t1090 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1091 = icmp eq i32 %t1031, 19
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1089
  %t1093 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1094 = icmp eq i32 %t1031, 20
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1092
  %t1096 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1097 = icmp eq i32 %t1031, 21
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1095
  %t1099 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1031, 22
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1031, 23
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %t1105 = call i8* @malloc(i64 20)
  %t1106 = bitcast i8* %t1105 to [20 x i8]*
  store [20 x i8] c"ExpressionStatement\00", [20 x i8]* %t1106
  %t1107 = call i1 @strings_equal(i8* %t1104, i8* %t1105)
  br i1 %t1107, label %then28, label %merge29
then28:
  %t1108 = extractvalue %Statement %statement, 0
  %t1109 = alloca %Statement
  store %Statement %statement, %Statement* %t1109
  %t1110 = getelementptr inbounds %Statement, %Statement* %t1109, i32 0, i32 1
  %t1111 = bitcast [16 x i8]* %t1110 to i8*
  %t1112 = bitcast i8* %t1111 to %Expression**
  %t1113 = load %Expression*, %Expression** %t1112
  %t1114 = icmp eq i32 %t1108, 21
  %t1115 = select i1 %t1114, %Expression* %t1113, %Expression* null
  %t1116 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1115)
  ret { %EffectRequirement*, i64 }* %t1116
merge29:
  %t1117 = extractvalue %Statement %statement, 0
  %t1118 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1119 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1117, 0
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1117, 1
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1117, 2
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1117, 3
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1117, 4
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1117, 5
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1117, 6
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1117, 7
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1117, 8
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1117, 9
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1117, 10
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1117, 11
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1117, 12
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1117, 13
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1117, 14
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1117, 15
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1117, 16
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1117, 17
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1117, 18
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1117, 19
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1117, 20
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1117, 21
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1117, 22
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1117, 23
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = call i8* @malloc(i64 20)
  %t1192 = bitcast i8* %t1191 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t1192
  %t1193 = call i1 @strings_equal(i8* %t1190, i8* %t1191)
  br i1 %t1193, label %then30, label %merge31
then30:
  %t1194 = extractvalue %Statement %statement, 0
  %t1195 = alloca %Statement
  store %Statement %statement, %Statement* %t1195
  %t1196 = getelementptr inbounds %Statement, %Statement* %t1195, i32 0, i32 1
  %t1197 = bitcast [48 x i8]* %t1196 to i8*
  %t1198 = getelementptr inbounds i8, i8* %t1197, i64 24
  %t1199 = bitcast i8* %t1198 to %Expression**
  %t1200 = load %Expression*, %Expression** %t1199
  %t1201 = icmp eq i32 %t1194, 2
  %t1202 = select i1 %t1201, %Expression* %t1200, %Expression* null
  %t1203 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1202)
  ret { %EffectRequirement*, i64 }* %t1203
merge31:
  %t1204 = extractvalue %Statement %statement, 0
  %t1205 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1206 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1204, 0
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1204, 1
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1204, 2
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1204, 3
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1204, 4
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1204, 5
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1204, 6
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1204, 7
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1204, 8
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1204, 9
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1204, 10
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1204, 11
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1204, 12
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %t1245 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1204, 13
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1204, 14
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %t1251 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1204, 15
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %t1254 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1255 = icmp eq i32 %t1204, 16
  %t1256 = select i1 %t1255, i8* %t1254, i8* %t1253
  %t1257 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1258 = icmp eq i32 %t1204, 17
  %t1259 = select i1 %t1258, i8* %t1257, i8* %t1256
  %t1260 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1204, 18
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1204, 19
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1204, 20
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1204, 21
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1204, 22
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1204, 23
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = call i8* @malloc(i64 20)
  %t1279 = bitcast i8* %t1278 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t1279
  %t1280 = call i1 @strings_equal(i8* %t1277, i8* %t1278)
  br i1 %t1280, label %then32, label %merge33
then32:
  %t1281 = extractvalue %Statement %statement, 0
  %t1282 = alloca %Statement
  store %Statement %statement, %Statement* %t1282
  %t1283 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1284 = bitcast [88 x i8]* %t1283 to i8*
  %t1285 = getelementptr inbounds i8, i8* %t1284, i64 56
  %t1286 = bitcast i8* %t1285 to %Block*
  %t1287 = load %Block, %Block* %t1286
  %t1288 = icmp eq i32 %t1281, 4
  %t1289 = select i1 %t1288, %Block %t1287, %Block zeroinitializer
  %t1290 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1291 = bitcast [88 x i8]* %t1290 to i8*
  %t1292 = getelementptr inbounds i8, i8* %t1291, i64 56
  %t1293 = bitcast i8* %t1292 to %Block*
  %t1294 = load %Block, %Block* %t1293
  %t1295 = icmp eq i32 %t1281, 5
  %t1296 = select i1 %t1295, %Block %t1294, %Block %t1289
  %t1297 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1298 = bitcast [56 x i8]* %t1297 to i8*
  %t1299 = getelementptr inbounds i8, i8* %t1298, i64 16
  %t1300 = bitcast i8* %t1299 to %Block*
  %t1301 = load %Block, %Block* %t1300
  %t1302 = icmp eq i32 %t1281, 6
  %t1303 = select i1 %t1302, %Block %t1301, %Block %t1296
  %t1304 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1305 = bitcast [88 x i8]* %t1304 to i8*
  %t1306 = getelementptr inbounds i8, i8* %t1305, i64 56
  %t1307 = bitcast i8* %t1306 to %Block*
  %t1308 = load %Block, %Block* %t1307
  %t1309 = icmp eq i32 %t1281, 7
  %t1310 = select i1 %t1309, %Block %t1308, %Block %t1303
  %t1311 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1312 = bitcast [120 x i8]* %t1311 to i8*
  %t1313 = getelementptr inbounds i8, i8* %t1312, i64 88
  %t1314 = bitcast i8* %t1313 to %Block*
  %t1315 = load %Block, %Block* %t1314
  %t1316 = icmp eq i32 %t1281, 12
  %t1317 = select i1 %t1316, %Block %t1315, %Block %t1310
  %t1318 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1319 = bitcast [40 x i8]* %t1318 to i8*
  %t1320 = getelementptr inbounds i8, i8* %t1319, i64 8
  %t1321 = bitcast i8* %t1320 to %Block*
  %t1322 = load %Block, %Block* %t1321
  %t1323 = icmp eq i32 %t1281, 13
  %t1324 = select i1 %t1323, %Block %t1322, %Block %t1317
  %t1325 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1326 = bitcast [136 x i8]* %t1325 to i8*
  %t1327 = getelementptr inbounds i8, i8* %t1326, i64 104
  %t1328 = bitcast i8* %t1327 to %Block*
  %t1329 = load %Block, %Block* %t1328
  %t1330 = icmp eq i32 %t1281, 14
  %t1331 = select i1 %t1330, %Block %t1329, %Block %t1324
  %t1332 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1333 = bitcast [32 x i8]* %t1332 to i8*
  %t1334 = bitcast i8* %t1333 to %Block*
  %t1335 = load %Block, %Block* %t1334
  %t1336 = icmp eq i32 %t1281, 15
  %t1337 = select i1 %t1336, %Block %t1335, %Block %t1331
  %t1338 = getelementptr inbounds %Statement, %Statement* %t1282, i32 0, i32 1
  %t1339 = bitcast [24 x i8]* %t1338 to i8*
  %t1340 = bitcast i8* %t1339 to %Block*
  %t1341 = load %Block, %Block* %t1340
  %t1342 = icmp eq i32 %t1281, 20
  %t1343 = select i1 %t1342, %Block %t1341, %Block %t1337
  %t1344 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1343)
  ret { %EffectRequirement*, i64 }* %t1344
merge33:
  %t1345 = extractvalue %Statement %statement, 0
  %t1346 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1347 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1345, 0
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1345, 1
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1345, 2
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %t1356 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1357 = icmp eq i32 %t1345, 3
  %t1358 = select i1 %t1357, i8* %t1356, i8* %t1355
  %t1359 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1360 = icmp eq i32 %t1345, 4
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1358
  %t1362 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1363 = icmp eq i32 %t1345, 5
  %t1364 = select i1 %t1363, i8* %t1362, i8* %t1361
  %t1365 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1366 = icmp eq i32 %t1345, 6
  %t1367 = select i1 %t1366, i8* %t1365, i8* %t1364
  %t1368 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1369 = icmp eq i32 %t1345, 7
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1367
  %t1371 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1372 = icmp eq i32 %t1345, 8
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1370
  %t1374 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1375 = icmp eq i32 %t1345, 9
  %t1376 = select i1 %t1375, i8* %t1374, i8* %t1373
  %t1377 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1378 = icmp eq i32 %t1345, 10
  %t1379 = select i1 %t1378, i8* %t1377, i8* %t1376
  %t1380 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1381 = icmp eq i32 %t1345, 11
  %t1382 = select i1 %t1381, i8* %t1380, i8* %t1379
  %t1383 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1384 = icmp eq i32 %t1345, 12
  %t1385 = select i1 %t1384, i8* %t1383, i8* %t1382
  %t1386 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1387 = icmp eq i32 %t1345, 13
  %t1388 = select i1 %t1387, i8* %t1386, i8* %t1385
  %t1389 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1345, 14
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %t1392 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1345, 15
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1345, 16
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1345, 17
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1345, 18
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1345, 19
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1345, 20
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1345, 21
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1345, 22
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1345, 23
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = call i8* @malloc(i64 20)
  %t1420 = bitcast i8* %t1419 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t1420
  %t1421 = call i1 @strings_equal(i8* %t1418, i8* %t1419)
  br i1 %t1421, label %then34, label %merge35
then34:
  %t1422 = extractvalue %Statement %statement, 0
  %t1423 = alloca %Statement
  store %Statement %statement, %Statement* %t1423
  %t1424 = getelementptr inbounds %Statement, %Statement* %t1423, i32 0, i32 1
  %t1425 = bitcast [88 x i8]* %t1424 to i8*
  %t1426 = getelementptr inbounds i8, i8* %t1425, i64 56
  %t1427 = bitcast i8* %t1426 to %Block*
  %t1428 = load %Block, %Block* %t1427
  %t1429 = icmp eq i32 %t1422, 4
  %t1430 = select i1 %t1429, %Block %t1428, %Block zeroinitializer
  %t1431 = getelementptr inbounds %Statement, %Statement* %t1423, i32 0, i32 1
  %t1432 = bitcast [88 x i8]* %t1431 to i8*
  %t1433 = getelementptr inbounds i8, i8* %t1432, i64 56
  %t1434 = bitcast i8* %t1433 to %Block*
  %t1435 = load %Block, %Block* %t1434
  %t1436 = icmp eq i32 %t1422, 5
  %t1437 = select i1 %t1436, %Block %t1435, %Block %t1430
  %t1438 = getelementptr inbounds %Statement, %Statement* %t1423, i32 0, i32 1
  %t1439 = bitcast [56 x i8]* %t1438 to i8*
  %t1440 = getelementptr inbounds i8, i8* %t1439, i64 16
  %t1441 = bitcast i8* %t1440 to %Block*
  %t1442 = load %Block, %Block* %t1441
  %t1443 = icmp eq i32 %t1422, 6
  %t1444 = select i1 %t1443, %Block %t1442, %Block %t1437
  %t1445 = getelementptr inbounds %Statement, %Statement* %t1423, i32 0, i32 1
  %t1446 = bitcast [88 x i8]* %t1445 to i8*
  %t1447 = getelementptr inbounds i8, i8* %t1446, i64 56
  %t1448 = bitcast i8* %t1447 to %Block*
  %t1449 = load %Block, %Block* %t1448
  %t1450 = icmp eq i32 %t1422, 7
  %t1451 = select i1 %t1450, %Block %t1449, %Block %t1444
  %t1452 = getelementptr inbounds %Statement, %Statement* %t1423, i32 0, i32 1
  %t1453 = bitcast [120 x i8]* %t1452 to i8*
  %t1454 = getelementptr inbounds i8, i8* %t1453, i64 88
  %t1455 = bitcast i8* %t1454 to %Block*
  %t1456 = load %Block, %Block* %t1455
  %t1457 = icmp eq i32 %t1422, 12
  %t1458 = select i1 %t1457, %Block %t1456, %Block %t1451
  %t1459 = getelementptr inbounds %Statement, %Statement* %t1423, i32 0, i32 1
  %t1460 = bitcast [40 x i8]* %t1459 to i8*
  %t1461 = getelementptr inbounds i8, i8* %t1460, i64 8
  %t1462 = bitcast i8* %t1461 to %Block*
  %t1463 = load %Block, %Block* %t1462
  %t1464 = icmp eq i32 %t1422, 13
  %t1465 = select i1 %t1464, %Block %t1463, %Block %t1458
  %t1466 = getelementptr inbounds %Statement, %Statement* %t1423, i32 0, i32 1
  %t1467 = bitcast [136 x i8]* %t1466 to i8*
  %t1468 = getelementptr inbounds i8, i8* %t1467, i64 104
  %t1469 = bitcast i8* %t1468 to %Block*
  %t1470 = load %Block, %Block* %t1469
  %t1471 = icmp eq i32 %t1422, 14
  %t1472 = select i1 %t1471, %Block %t1470, %Block %t1465
  %t1473 = getelementptr inbounds %Statement, %Statement* %t1423, i32 0, i32 1
  %t1474 = bitcast [32 x i8]* %t1473 to i8*
  %t1475 = bitcast i8* %t1474 to %Block*
  %t1476 = load %Block, %Block* %t1475
  %t1477 = icmp eq i32 %t1422, 15
  %t1478 = select i1 %t1477, %Block %t1476, %Block %t1472
  %t1479 = getelementptr inbounds %Statement, %Statement* %t1423, i32 0, i32 1
  %t1480 = bitcast [24 x i8]* %t1479 to i8*
  %t1481 = bitcast i8* %t1480 to %Block*
  %t1482 = load %Block, %Block* %t1481
  %t1483 = icmp eq i32 %t1422, 20
  %t1484 = select i1 %t1483, %Block %t1482, %Block %t1478
  %t1485 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1484)
  ret { %EffectRequirement*, i64 }* %t1485
merge35:
  %t1486 = extractvalue %Statement %statement, 0
  %t1487 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1488 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1486, 0
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1486, 1
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1486, 2
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1486, 3
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1486, 4
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1486, 5
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1486, 6
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1486, 7
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1486, 8
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1486, 9
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1486, 10
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1486, 11
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1486, 12
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1486, 13
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1486, 14
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1486, 15
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1486, 16
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1486, 17
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1486, 18
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1486, 19
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1486, 20
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1486, 21
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1486, 22
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1486, 23
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = call i8* @malloc(i64 16)
  %t1561 = bitcast i8* %t1560 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t1561
  %t1562 = call i1 @strings_equal(i8* %t1559, i8* %t1560)
  br i1 %t1562, label %then36, label %merge37
then36:
  %t1563 = extractvalue %Statement %statement, 0
  %t1564 = alloca %Statement
  store %Statement %statement, %Statement* %t1564
  %t1565 = getelementptr inbounds %Statement, %Statement* %t1564, i32 0, i32 1
  %t1566 = bitcast [88 x i8]* %t1565 to i8*
  %t1567 = getelementptr inbounds i8, i8* %t1566, i64 56
  %t1568 = bitcast i8* %t1567 to %Block*
  %t1569 = load %Block, %Block* %t1568
  %t1570 = icmp eq i32 %t1563, 4
  %t1571 = select i1 %t1570, %Block %t1569, %Block zeroinitializer
  %t1572 = getelementptr inbounds %Statement, %Statement* %t1564, i32 0, i32 1
  %t1573 = bitcast [88 x i8]* %t1572 to i8*
  %t1574 = getelementptr inbounds i8, i8* %t1573, i64 56
  %t1575 = bitcast i8* %t1574 to %Block*
  %t1576 = load %Block, %Block* %t1575
  %t1577 = icmp eq i32 %t1563, 5
  %t1578 = select i1 %t1577, %Block %t1576, %Block %t1571
  %t1579 = getelementptr inbounds %Statement, %Statement* %t1564, i32 0, i32 1
  %t1580 = bitcast [56 x i8]* %t1579 to i8*
  %t1581 = getelementptr inbounds i8, i8* %t1580, i64 16
  %t1582 = bitcast i8* %t1581 to %Block*
  %t1583 = load %Block, %Block* %t1582
  %t1584 = icmp eq i32 %t1563, 6
  %t1585 = select i1 %t1584, %Block %t1583, %Block %t1578
  %t1586 = getelementptr inbounds %Statement, %Statement* %t1564, i32 0, i32 1
  %t1587 = bitcast [88 x i8]* %t1586 to i8*
  %t1588 = getelementptr inbounds i8, i8* %t1587, i64 56
  %t1589 = bitcast i8* %t1588 to %Block*
  %t1590 = load %Block, %Block* %t1589
  %t1591 = icmp eq i32 %t1563, 7
  %t1592 = select i1 %t1591, %Block %t1590, %Block %t1585
  %t1593 = getelementptr inbounds %Statement, %Statement* %t1564, i32 0, i32 1
  %t1594 = bitcast [120 x i8]* %t1593 to i8*
  %t1595 = getelementptr inbounds i8, i8* %t1594, i64 88
  %t1596 = bitcast i8* %t1595 to %Block*
  %t1597 = load %Block, %Block* %t1596
  %t1598 = icmp eq i32 %t1563, 12
  %t1599 = select i1 %t1598, %Block %t1597, %Block %t1592
  %t1600 = getelementptr inbounds %Statement, %Statement* %t1564, i32 0, i32 1
  %t1601 = bitcast [40 x i8]* %t1600 to i8*
  %t1602 = getelementptr inbounds i8, i8* %t1601, i64 8
  %t1603 = bitcast i8* %t1602 to %Block*
  %t1604 = load %Block, %Block* %t1603
  %t1605 = icmp eq i32 %t1563, 13
  %t1606 = select i1 %t1605, %Block %t1604, %Block %t1599
  %t1607 = getelementptr inbounds %Statement, %Statement* %t1564, i32 0, i32 1
  %t1608 = bitcast [136 x i8]* %t1607 to i8*
  %t1609 = getelementptr inbounds i8, i8* %t1608, i64 104
  %t1610 = bitcast i8* %t1609 to %Block*
  %t1611 = load %Block, %Block* %t1610
  %t1612 = icmp eq i32 %t1563, 14
  %t1613 = select i1 %t1612, %Block %t1611, %Block %t1606
  %t1614 = getelementptr inbounds %Statement, %Statement* %t1564, i32 0, i32 1
  %t1615 = bitcast [32 x i8]* %t1614 to i8*
  %t1616 = bitcast i8* %t1615 to %Block*
  %t1617 = load %Block, %Block* %t1616
  %t1618 = icmp eq i32 %t1563, 15
  %t1619 = select i1 %t1618, %Block %t1617, %Block %t1613
  %t1620 = getelementptr inbounds %Statement, %Statement* %t1564, i32 0, i32 1
  %t1621 = bitcast [24 x i8]* %t1620 to i8*
  %t1622 = bitcast i8* %t1621 to %Block*
  %t1623 = load %Block, %Block* %t1622
  %t1624 = icmp eq i32 %t1563, 20
  %t1625 = select i1 %t1624, %Block %t1623, %Block %t1619
  %t1626 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1625)
  ret { %EffectRequirement*, i64 }* %t1626
merge37:
  %t1627 = extractvalue %Statement %statement, 0
  %t1628 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1629 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1630 = icmp eq i32 %t1627, 0
  %t1631 = select i1 %t1630, i8* %t1629, i8* %t1628
  %t1632 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1633 = icmp eq i32 %t1627, 1
  %t1634 = select i1 %t1633, i8* %t1632, i8* %t1631
  %t1635 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1636 = icmp eq i32 %t1627, 2
  %t1637 = select i1 %t1636, i8* %t1635, i8* %t1634
  %t1638 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1639 = icmp eq i32 %t1627, 3
  %t1640 = select i1 %t1639, i8* %t1638, i8* %t1637
  %t1641 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1642 = icmp eq i32 %t1627, 4
  %t1643 = select i1 %t1642, i8* %t1641, i8* %t1640
  %t1644 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1645 = icmp eq i32 %t1627, 5
  %t1646 = select i1 %t1645, i8* %t1644, i8* %t1643
  %t1647 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1648 = icmp eq i32 %t1627, 6
  %t1649 = select i1 %t1648, i8* %t1647, i8* %t1646
  %t1650 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1651 = icmp eq i32 %t1627, 7
  %t1652 = select i1 %t1651, i8* %t1650, i8* %t1649
  %t1653 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1654 = icmp eq i32 %t1627, 8
  %t1655 = select i1 %t1654, i8* %t1653, i8* %t1652
  %t1656 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1657 = icmp eq i32 %t1627, 9
  %t1658 = select i1 %t1657, i8* %t1656, i8* %t1655
  %t1659 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1660 = icmp eq i32 %t1627, 10
  %t1661 = select i1 %t1660, i8* %t1659, i8* %t1658
  %t1662 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1663 = icmp eq i32 %t1627, 11
  %t1664 = select i1 %t1663, i8* %t1662, i8* %t1661
  %t1665 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1666 = icmp eq i32 %t1627, 12
  %t1667 = select i1 %t1666, i8* %t1665, i8* %t1664
  %t1668 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1669 = icmp eq i32 %t1627, 13
  %t1670 = select i1 %t1669, i8* %t1668, i8* %t1667
  %t1671 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1672 = icmp eq i32 %t1627, 14
  %t1673 = select i1 %t1672, i8* %t1671, i8* %t1670
  %t1674 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1675 = icmp eq i32 %t1627, 15
  %t1676 = select i1 %t1675, i8* %t1674, i8* %t1673
  %t1677 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1678 = icmp eq i32 %t1627, 16
  %t1679 = select i1 %t1678, i8* %t1677, i8* %t1676
  %t1680 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1681 = icmp eq i32 %t1627, 17
  %t1682 = select i1 %t1681, i8* %t1680, i8* %t1679
  %t1683 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1684 = icmp eq i32 %t1627, 18
  %t1685 = select i1 %t1684, i8* %t1683, i8* %t1682
  %t1686 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1687 = icmp eq i32 %t1627, 19
  %t1688 = select i1 %t1687, i8* %t1686, i8* %t1685
  %t1689 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1690 = icmp eq i32 %t1627, 20
  %t1691 = select i1 %t1690, i8* %t1689, i8* %t1688
  %t1692 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1693 = icmp eq i32 %t1627, 21
  %t1694 = select i1 %t1693, i8* %t1692, i8* %t1691
  %t1695 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1696 = icmp eq i32 %t1627, 22
  %t1697 = select i1 %t1696, i8* %t1695, i8* %t1694
  %t1698 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1699 = icmp eq i32 %t1627, 23
  %t1700 = select i1 %t1699, i8* %t1698, i8* %t1697
  %t1701 = call i8* @malloc(i64 16)
  %t1702 = bitcast i8* %t1701 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t1702
  %t1703 = call i1 @strings_equal(i8* %t1700, i8* %t1701)
  br i1 %t1703, label %then38, label %merge39
then38:
  %t1704 = extractvalue %Statement %statement, 0
  %t1705 = alloca %Statement
  store %Statement %statement, %Statement* %t1705
  %t1706 = getelementptr inbounds %Statement, %Statement* %t1705, i32 0, i32 1
  %t1707 = bitcast [88 x i8]* %t1706 to i8*
  %t1708 = getelementptr inbounds i8, i8* %t1707, i64 56
  %t1709 = bitcast i8* %t1708 to %Block*
  %t1710 = load %Block, %Block* %t1709
  %t1711 = icmp eq i32 %t1704, 4
  %t1712 = select i1 %t1711, %Block %t1710, %Block zeroinitializer
  %t1713 = getelementptr inbounds %Statement, %Statement* %t1705, i32 0, i32 1
  %t1714 = bitcast [88 x i8]* %t1713 to i8*
  %t1715 = getelementptr inbounds i8, i8* %t1714, i64 56
  %t1716 = bitcast i8* %t1715 to %Block*
  %t1717 = load %Block, %Block* %t1716
  %t1718 = icmp eq i32 %t1704, 5
  %t1719 = select i1 %t1718, %Block %t1717, %Block %t1712
  %t1720 = getelementptr inbounds %Statement, %Statement* %t1705, i32 0, i32 1
  %t1721 = bitcast [56 x i8]* %t1720 to i8*
  %t1722 = getelementptr inbounds i8, i8* %t1721, i64 16
  %t1723 = bitcast i8* %t1722 to %Block*
  %t1724 = load %Block, %Block* %t1723
  %t1725 = icmp eq i32 %t1704, 6
  %t1726 = select i1 %t1725, %Block %t1724, %Block %t1719
  %t1727 = getelementptr inbounds %Statement, %Statement* %t1705, i32 0, i32 1
  %t1728 = bitcast [88 x i8]* %t1727 to i8*
  %t1729 = getelementptr inbounds i8, i8* %t1728, i64 56
  %t1730 = bitcast i8* %t1729 to %Block*
  %t1731 = load %Block, %Block* %t1730
  %t1732 = icmp eq i32 %t1704, 7
  %t1733 = select i1 %t1732, %Block %t1731, %Block %t1726
  %t1734 = getelementptr inbounds %Statement, %Statement* %t1705, i32 0, i32 1
  %t1735 = bitcast [120 x i8]* %t1734 to i8*
  %t1736 = getelementptr inbounds i8, i8* %t1735, i64 88
  %t1737 = bitcast i8* %t1736 to %Block*
  %t1738 = load %Block, %Block* %t1737
  %t1739 = icmp eq i32 %t1704, 12
  %t1740 = select i1 %t1739, %Block %t1738, %Block %t1733
  %t1741 = getelementptr inbounds %Statement, %Statement* %t1705, i32 0, i32 1
  %t1742 = bitcast [40 x i8]* %t1741 to i8*
  %t1743 = getelementptr inbounds i8, i8* %t1742, i64 8
  %t1744 = bitcast i8* %t1743 to %Block*
  %t1745 = load %Block, %Block* %t1744
  %t1746 = icmp eq i32 %t1704, 13
  %t1747 = select i1 %t1746, %Block %t1745, %Block %t1740
  %t1748 = getelementptr inbounds %Statement, %Statement* %t1705, i32 0, i32 1
  %t1749 = bitcast [136 x i8]* %t1748 to i8*
  %t1750 = getelementptr inbounds i8, i8* %t1749, i64 104
  %t1751 = bitcast i8* %t1750 to %Block*
  %t1752 = load %Block, %Block* %t1751
  %t1753 = icmp eq i32 %t1704, 14
  %t1754 = select i1 %t1753, %Block %t1752, %Block %t1747
  %t1755 = getelementptr inbounds %Statement, %Statement* %t1705, i32 0, i32 1
  %t1756 = bitcast [32 x i8]* %t1755 to i8*
  %t1757 = bitcast i8* %t1756 to %Block*
  %t1758 = load %Block, %Block* %t1757
  %t1759 = icmp eq i32 %t1704, 15
  %t1760 = select i1 %t1759, %Block %t1758, %Block %t1754
  %t1761 = getelementptr inbounds %Statement, %Statement* %t1705, i32 0, i32 1
  %t1762 = bitcast [24 x i8]* %t1761 to i8*
  %t1763 = bitcast i8* %t1762 to %Block*
  %t1764 = load %Block, %Block* %t1763
  %t1765 = icmp eq i32 %t1704, 20
  %t1766 = select i1 %t1765, %Block %t1764, %Block %t1760
  %t1767 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1766)
  ret { %EffectRequirement*, i64 }* %t1767
merge39:
  %t1768 = extractvalue %Statement %statement, 0
  %t1769 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1770 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1771 = icmp eq i32 %t1768, 0
  %t1772 = select i1 %t1771, i8* %t1770, i8* %t1769
  %t1773 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1774 = icmp eq i32 %t1768, 1
  %t1775 = select i1 %t1774, i8* %t1773, i8* %t1772
  %t1776 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1777 = icmp eq i32 %t1768, 2
  %t1778 = select i1 %t1777, i8* %t1776, i8* %t1775
  %t1779 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1768, 3
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1783 = icmp eq i32 %t1768, 4
  %t1784 = select i1 %t1783, i8* %t1782, i8* %t1781
  %t1785 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1786 = icmp eq i32 %t1768, 5
  %t1787 = select i1 %t1786, i8* %t1785, i8* %t1784
  %t1788 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1789 = icmp eq i32 %t1768, 6
  %t1790 = select i1 %t1789, i8* %t1788, i8* %t1787
  %t1791 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1792 = icmp eq i32 %t1768, 7
  %t1793 = select i1 %t1792, i8* %t1791, i8* %t1790
  %t1794 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1795 = icmp eq i32 %t1768, 8
  %t1796 = select i1 %t1795, i8* %t1794, i8* %t1793
  %t1797 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1798 = icmp eq i32 %t1768, 9
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1796
  %t1800 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1801 = icmp eq i32 %t1768, 10
  %t1802 = select i1 %t1801, i8* %t1800, i8* %t1799
  %t1803 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1804 = icmp eq i32 %t1768, 11
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1802
  %t1806 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1807 = icmp eq i32 %t1768, 12
  %t1808 = select i1 %t1807, i8* %t1806, i8* %t1805
  %t1809 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1810 = icmp eq i32 %t1768, 13
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1808
  %t1812 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1813 = icmp eq i32 %t1768, 14
  %t1814 = select i1 %t1813, i8* %t1812, i8* %t1811
  %t1815 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1816 = icmp eq i32 %t1768, 15
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1814
  %t1818 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1819 = icmp eq i32 %t1768, 16
  %t1820 = select i1 %t1819, i8* %t1818, i8* %t1817
  %t1821 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1822 = icmp eq i32 %t1768, 17
  %t1823 = select i1 %t1822, i8* %t1821, i8* %t1820
  %t1824 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1825 = icmp eq i32 %t1768, 18
  %t1826 = select i1 %t1825, i8* %t1824, i8* %t1823
  %t1827 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1828 = icmp eq i32 %t1768, 19
  %t1829 = select i1 %t1828, i8* %t1827, i8* %t1826
  %t1830 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1831 = icmp eq i32 %t1768, 20
  %t1832 = select i1 %t1831, i8* %t1830, i8* %t1829
  %t1833 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1834 = icmp eq i32 %t1768, 21
  %t1835 = select i1 %t1834, i8* %t1833, i8* %t1832
  %t1836 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1837 = icmp eq i32 %t1768, 22
  %t1838 = select i1 %t1837, i8* %t1836, i8* %t1835
  %t1839 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1840 = icmp eq i32 %t1768, 23
  %t1841 = select i1 %t1840, i8* %t1839, i8* %t1838
  %t1842 = call i8* @malloc(i64 18)
  %t1843 = bitcast i8* %t1842 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t1843
  %t1844 = call i1 @strings_equal(i8* %t1841, i8* %t1842)
  br i1 %t1844, label %then40, label %merge41
then40:
  %t1845 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1846 = ptrtoint [0 x %EffectRequirement]* %t1845 to i64
  %t1847 = icmp eq i64 %t1846, 0
  %t1848 = select i1 %t1847, i64 1, i64 %t1846
  %t1849 = call i8* @malloc(i64 %t1848)
  %t1850 = bitcast i8* %t1849 to %EffectRequirement*
  %t1851 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1852 = ptrtoint { %EffectRequirement*, i64 }* %t1851 to i64
  %t1853 = call i8* @malloc(i64 %t1852)
  %t1854 = bitcast i8* %t1853 to { %EffectRequirement*, i64 }*
  %t1855 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1854, i32 0, i32 0
  store %EffectRequirement* %t1850, %EffectRequirement** %t1855
  %t1856 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1854, i32 0, i32 1
  store i64 0, i64* %t1856
  store { %EffectRequirement*, i64 }* %t1854, { %EffectRequirement*, i64 }** %l9
  %t1857 = sitofp i64 0 to double
  store double %t1857, double* %l10
  %t1858 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1859 = load double, double* %l10
  br label %loop.header42
loop.header42:
  %t1903 = phi { %EffectRequirement*, i64 }* [ %t1858, %then40 ], [ %t1901, %loop.latch44 ]
  %t1904 = phi double [ %t1859, %then40 ], [ %t1902, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1903, { %EffectRequirement*, i64 }** %l9
  store double %t1904, double* %l10
  br label %loop.body43
loop.body43:
  %t1860 = load double, double* %l10
  %t1861 = extractvalue %Statement %statement, 0
  %t1862 = alloca %Statement
  store %Statement %statement, %Statement* %t1862
  %t1863 = getelementptr inbounds %Statement, %Statement* %t1862, i32 0, i32 1
  %t1864 = bitcast [56 x i8]* %t1863 to i8*
  %t1865 = getelementptr inbounds i8, i8* %t1864, i64 40
  %t1866 = bitcast i8* %t1865 to { %MethodDeclaration*, i64 }**
  %t1867 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1866
  %t1868 = icmp eq i32 %t1861, 8
  %t1869 = select i1 %t1868, { %MethodDeclaration*, i64 }* %t1867, { %MethodDeclaration*, i64 }* null
  %t1870 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1869
  %t1871 = extractvalue { %MethodDeclaration*, i64 } %t1870, 1
  %t1872 = sitofp i64 %t1871 to double
  %t1873 = fcmp oge double %t1860, %t1872
  %t1874 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1875 = load double, double* %l10
  br i1 %t1873, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1876 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1877 = extractvalue %Statement %statement, 0
  %t1878 = alloca %Statement
  store %Statement %statement, %Statement* %t1878
  %t1879 = getelementptr inbounds %Statement, %Statement* %t1878, i32 0, i32 1
  %t1880 = bitcast [56 x i8]* %t1879 to i8*
  %t1881 = getelementptr inbounds i8, i8* %t1880, i64 40
  %t1882 = bitcast i8* %t1881 to { %MethodDeclaration*, i64 }**
  %t1883 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1882
  %t1884 = icmp eq i32 %t1877, 8
  %t1885 = select i1 %t1884, { %MethodDeclaration*, i64 }* %t1883, { %MethodDeclaration*, i64 }* null
  %t1886 = load double, double* %l10
  %t1887 = call double @llvm.round.f64(double %t1886)
  %t1888 = fptosi double %t1887 to i64
  %t1889 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1885
  %t1890 = extractvalue { %MethodDeclaration*, i64 } %t1889, 0
  %t1891 = extractvalue { %MethodDeclaration*, i64 } %t1889, 1
  %t1892 = icmp uge i64 %t1888, %t1891
  ; bounds check: %t1892 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1888, i64 %t1891)
  %t1893 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1890, i64 %t1888
  %t1894 = load %MethodDeclaration, %MethodDeclaration* %t1893
  %t1895 = extractvalue %MethodDeclaration %t1894, 1
  %t1896 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1895)
  %t1897 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1876, { %EffectRequirement*, i64 }* %t1896)
  store { %EffectRequirement*, i64 }* %t1897, { %EffectRequirement*, i64 }** %l9
  %t1898 = load double, double* %l10
  %t1899 = sitofp i64 1 to double
  %t1900 = fadd double %t1898, %t1899
  store double %t1900, double* %l10
  br label %loop.latch44
loop.latch44:
  %t1901 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1902 = load double, double* %l10
  br label %loop.header42
afterloop45:
  %t1905 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1906 = load double, double* %l10
  %t1907 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t1907
merge41:
  %t1908 = extractvalue %Statement %statement, 0
  %t1909 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1910 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1911 = icmp eq i32 %t1908, 0
  %t1912 = select i1 %t1911, i8* %t1910, i8* %t1909
  %t1913 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1914 = icmp eq i32 %t1908, 1
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1912
  %t1916 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1917 = icmp eq i32 %t1908, 2
  %t1918 = select i1 %t1917, i8* %t1916, i8* %t1915
  %t1919 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1920 = icmp eq i32 %t1908, 3
  %t1921 = select i1 %t1920, i8* %t1919, i8* %t1918
  %t1922 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1923 = icmp eq i32 %t1908, 4
  %t1924 = select i1 %t1923, i8* %t1922, i8* %t1921
  %t1925 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1926 = icmp eq i32 %t1908, 5
  %t1927 = select i1 %t1926, i8* %t1925, i8* %t1924
  %t1928 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1929 = icmp eq i32 %t1908, 6
  %t1930 = select i1 %t1929, i8* %t1928, i8* %t1927
  %t1931 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1932 = icmp eq i32 %t1908, 7
  %t1933 = select i1 %t1932, i8* %t1931, i8* %t1930
  %t1934 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1935 = icmp eq i32 %t1908, 8
  %t1936 = select i1 %t1935, i8* %t1934, i8* %t1933
  %t1937 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1938 = icmp eq i32 %t1908, 9
  %t1939 = select i1 %t1938, i8* %t1937, i8* %t1936
  %t1940 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1941 = icmp eq i32 %t1908, 10
  %t1942 = select i1 %t1941, i8* %t1940, i8* %t1939
  %t1943 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1944 = icmp eq i32 %t1908, 11
  %t1945 = select i1 %t1944, i8* %t1943, i8* %t1942
  %t1946 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1947 = icmp eq i32 %t1908, 12
  %t1948 = select i1 %t1947, i8* %t1946, i8* %t1945
  %t1949 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1950 = icmp eq i32 %t1908, 13
  %t1951 = select i1 %t1950, i8* %t1949, i8* %t1948
  %t1952 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1953 = icmp eq i32 %t1908, 14
  %t1954 = select i1 %t1953, i8* %t1952, i8* %t1951
  %t1955 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1956 = icmp eq i32 %t1908, 15
  %t1957 = select i1 %t1956, i8* %t1955, i8* %t1954
  %t1958 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1959 = icmp eq i32 %t1908, 16
  %t1960 = select i1 %t1959, i8* %t1958, i8* %t1957
  %t1961 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1962 = icmp eq i32 %t1908, 17
  %t1963 = select i1 %t1962, i8* %t1961, i8* %t1960
  %t1964 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1965 = icmp eq i32 %t1908, 18
  %t1966 = select i1 %t1965, i8* %t1964, i8* %t1963
  %t1967 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1968 = icmp eq i32 %t1908, 19
  %t1969 = select i1 %t1968, i8* %t1967, i8* %t1966
  %t1970 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t1971 = icmp eq i32 %t1908, 20
  %t1972 = select i1 %t1971, i8* %t1970, i8* %t1969
  %t1973 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1974 = icmp eq i32 %t1908, 21
  %t1975 = select i1 %t1974, i8* %t1973, i8* %t1972
  %t1976 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1977 = icmp eq i32 %t1908, 22
  %t1978 = select i1 %t1977, i8* %t1976, i8* %t1975
  %t1979 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1980 = icmp eq i32 %t1908, 23
  %t1981 = select i1 %t1980, i8* %t1979, i8* %t1978
  %t1982 = call i8* @malloc(i64 17)
  %t1983 = bitcast i8* %t1982 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t1983
  %t1984 = call i1 @strings_equal(i8* %t1981, i8* %t1982)
  br i1 %t1984, label %then48, label %merge49
then48:
  %t1985 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1986 = ptrtoint [0 x %EffectRequirement]* %t1985 to i64
  %t1987 = icmp eq i64 %t1986, 0
  %t1988 = select i1 %t1987, i64 1, i64 %t1986
  %t1989 = call i8* @malloc(i64 %t1988)
  %t1990 = bitcast i8* %t1989 to %EffectRequirement*
  %t1991 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1992 = ptrtoint { %EffectRequirement*, i64 }* %t1991 to i64
  %t1993 = call i8* @malloc(i64 %t1992)
  %t1994 = bitcast i8* %t1993 to { %EffectRequirement*, i64 }*
  %t1995 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1994, i32 0, i32 0
  store %EffectRequirement* %t1990, %EffectRequirement** %t1995
  %t1996 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1994, i32 0, i32 1
  store i64 0, i64* %t1996
  store { %EffectRequirement*, i64 }* %t1994, { %EffectRequirement*, i64 }** %l11
  %t1997 = sitofp i64 0 to double
  store double %t1997, double* %l12
  %t1998 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1999 = load double, double* %l12
  br label %loop.header50
loop.header50:
  %t2047 = phi { %EffectRequirement*, i64 }* [ %t1998, %then48 ], [ %t2045, %loop.latch52 ]
  %t2048 = phi double [ %t1999, %then48 ], [ %t2046, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t2047, { %EffectRequirement*, i64 }** %l11
  store double %t2048, double* %l12
  br label %loop.body51
loop.body51:
  %t2000 = load double, double* %l12
  %t2001 = extractvalue %Statement %statement, 0
  %t2002 = alloca %Statement
  store %Statement %statement, %Statement* %t2002
  %t2003 = getelementptr inbounds %Statement, %Statement* %t2002, i32 0, i32 1
  %t2004 = bitcast [48 x i8]* %t2003 to i8*
  %t2005 = getelementptr inbounds i8, i8* %t2004, i64 24
  %t2006 = bitcast i8* %t2005 to { %ModelProperty*, i64 }**
  %t2007 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t2006
  %t2008 = icmp eq i32 %t2001, 3
  %t2009 = select i1 %t2008, { %ModelProperty*, i64 }* %t2007, { %ModelProperty*, i64 }* null
  %t2010 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t2009
  %t2011 = extractvalue { %ModelProperty*, i64 } %t2010, 1
  %t2012 = sitofp i64 %t2011 to double
  %t2013 = fcmp oge double %t2000, %t2012
  %t2014 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t2015 = load double, double* %l12
  br i1 %t2013, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t2016 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t2017 = extractvalue %Statement %statement, 0
  %t2018 = alloca %Statement
  store %Statement %statement, %Statement* %t2018
  %t2019 = getelementptr inbounds %Statement, %Statement* %t2018, i32 0, i32 1
  %t2020 = bitcast [48 x i8]* %t2019 to i8*
  %t2021 = getelementptr inbounds i8, i8* %t2020, i64 24
  %t2022 = bitcast i8* %t2021 to { %ModelProperty*, i64 }**
  %t2023 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t2022
  %t2024 = icmp eq i32 %t2017, 3
  %t2025 = select i1 %t2024, { %ModelProperty*, i64 }* %t2023, { %ModelProperty*, i64 }* null
  %t2026 = load double, double* %l12
  %t2027 = call double @llvm.round.f64(double %t2026)
  %t2028 = fptosi double %t2027 to i64
  %t2029 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t2025
  %t2030 = extractvalue { %ModelProperty*, i64 } %t2029, 0
  %t2031 = extractvalue { %ModelProperty*, i64 } %t2029, 1
  %t2032 = icmp uge i64 %t2028, %t2031
  ; bounds check: %t2032 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2028, i64 %t2031)
  %t2033 = getelementptr %ModelProperty, %ModelProperty* %t2030, i64 %t2028
  %t2034 = load %ModelProperty, %ModelProperty* %t2033
  %t2035 = extractvalue %ModelProperty %t2034, 1
  %t2036 = getelementptr %Expression, %Expression* null, i32 1
  %t2037 = ptrtoint %Expression* %t2036 to i64
  %t2038 = call noalias i8* @malloc(i64 %t2037)
  %t2039 = bitcast i8* %t2038 to %Expression*
  store %Expression %t2035, %Expression* %t2039
  call void @sailfin_runtime_mark_persistent(i8* %t2038)
  %t2040 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t2039)
  %t2041 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t2016, { %EffectRequirement*, i64 }* %t2040)
  store { %EffectRequirement*, i64 }* %t2041, { %EffectRequirement*, i64 }** %l11
  %t2042 = load double, double* %l12
  %t2043 = sitofp i64 1 to double
  %t2044 = fadd double %t2042, %t2043
  store double %t2044, double* %l12
  br label %loop.latch52
loop.latch52:
  %t2045 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t2046 = load double, double* %l12
  br label %loop.header50
afterloop53:
  %t2049 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t2050 = load double, double* %l12
  %t2051 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  ret { %EffectRequirement*, i64 }* %t2051
merge49:
  %t2052 = extractvalue %Statement %statement, 0
  %t2053 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t2054 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t2055 = icmp eq i32 %t2052, 0
  %t2056 = select i1 %t2055, i8* %t2054, i8* %t2053
  %t2057 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t2058 = icmp eq i32 %t2052, 1
  %t2059 = select i1 %t2058, i8* %t2057, i8* %t2056
  %t2060 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t2061 = icmp eq i32 %t2052, 2
  %t2062 = select i1 %t2061, i8* %t2060, i8* %t2059
  %t2063 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t2064 = icmp eq i32 %t2052, 3
  %t2065 = select i1 %t2064, i8* %t2063, i8* %t2062
  %t2066 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t2067 = icmp eq i32 %t2052, 4
  %t2068 = select i1 %t2067, i8* %t2066, i8* %t2065
  %t2069 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t2070 = icmp eq i32 %t2052, 5
  %t2071 = select i1 %t2070, i8* %t2069, i8* %t2068
  %t2072 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t2073 = icmp eq i32 %t2052, 6
  %t2074 = select i1 %t2073, i8* %t2072, i8* %t2071
  %t2075 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t2076 = icmp eq i32 %t2052, 7
  %t2077 = select i1 %t2076, i8* %t2075, i8* %t2074
  %t2078 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t2079 = icmp eq i32 %t2052, 8
  %t2080 = select i1 %t2079, i8* %t2078, i8* %t2077
  %t2081 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t2082 = icmp eq i32 %t2052, 9
  %t2083 = select i1 %t2082, i8* %t2081, i8* %t2080
  %t2084 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t2085 = icmp eq i32 %t2052, 10
  %t2086 = select i1 %t2085, i8* %t2084, i8* %t2083
  %t2087 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t2088 = icmp eq i32 %t2052, 11
  %t2089 = select i1 %t2088, i8* %t2087, i8* %t2086
  %t2090 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t2091 = icmp eq i32 %t2052, 12
  %t2092 = select i1 %t2091, i8* %t2090, i8* %t2089
  %t2093 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2094 = icmp eq i32 %t2052, 13
  %t2095 = select i1 %t2094, i8* %t2093, i8* %t2092
  %t2096 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2097 = icmp eq i32 %t2052, 14
  %t2098 = select i1 %t2097, i8* %t2096, i8* %t2095
  %t2099 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2100 = icmp eq i32 %t2052, 15
  %t2101 = select i1 %t2100, i8* %t2099, i8* %t2098
  %t2102 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2103 = icmp eq i32 %t2052, 16
  %t2104 = select i1 %t2103, i8* %t2102, i8* %t2101
  %t2105 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2106 = icmp eq i32 %t2052, 17
  %t2107 = select i1 %t2106, i8* %t2105, i8* %t2104
  %t2108 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2109 = icmp eq i32 %t2052, 18
  %t2110 = select i1 %t2109, i8* %t2108, i8* %t2107
  %t2111 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2112 = icmp eq i32 %t2052, 19
  %t2113 = select i1 %t2112, i8* %t2111, i8* %t2110
  %t2114 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BlockStatement.variant, i32 0, i32 0
  %t2115 = icmp eq i32 %t2052, 20
  %t2116 = select i1 %t2115, i8* %t2114, i8* %t2113
  %t2117 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2118 = icmp eq i32 %t2052, 21
  %t2119 = select i1 %t2118, i8* %t2117, i8* %t2116
  %t2120 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2121 = icmp eq i32 %t2052, 22
  %t2122 = select i1 %t2121, i8* %t2120, i8* %t2119
  %t2123 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2124 = icmp eq i32 %t2052, 23
  %t2125 = select i1 %t2124, i8* %t2123, i8* %t2122
  %t2126 = call i8* @malloc(i64 8)
  %t2127 = bitcast i8* %t2126 to [8 x i8]*
  store [8 x i8] c"Unknown\00", [8 x i8]* %t2127
  %t2128 = call i1 @strings_equal(i8* %t2125, i8* %t2126)
  br i1 %t2128, label %then56, label %merge57
then56:
  %t2129 = extractvalue %Statement %statement, 0
  %t2130 = alloca %Statement
  store %Statement %statement, %Statement* %t2130
  %t2131 = getelementptr inbounds %Statement, %Statement* %t2130, i32 0, i32 1
  %t2132 = bitcast [16 x i8]* %t2131 to i8*
  %t2133 = bitcast i8* %t2132 to { %Token*, i64 }**
  %t2134 = load { %Token*, i64 }*, { %Token*, i64 }** %t2133
  %t2135 = icmp eq i32 %t2129, 23
  %t2136 = select i1 %t2135, { %Token*, i64 }* %t2134, { %Token*, i64 }* null
  %t2137 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t2136)
  ret { %EffectRequirement*, i64 }* %t2137
merge57:
  %t2138 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t2139 = ptrtoint [0 x %EffectRequirement]* %t2138 to i64
  %t2140 = icmp eq i64 %t2139, 0
  %t2141 = select i1 %t2140, i64 1, i64 %t2139
  %t2142 = call i8* @malloc(i64 %t2141)
  %t2143 = bitcast i8* %t2142 to %EffectRequirement*
  %t2144 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t2145 = ptrtoint { %EffectRequirement*, i64 }* %t2144 to i64
  %t2146 = call i8* @malloc(i64 %t2145)
  %t2147 = bitcast i8* %t2146 to { %EffectRequirement*, i64 }*
  %t2148 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2147, i32 0, i32 0
  store %EffectRequirement* %t2143, %EffectRequirement** %t2148
  %t2149 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2147, i32 0, i32 1
  store i64 0, i64* %t2149
  ret { %EffectRequirement*, i64 }* %t2147
}

define { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %branch) {
block.entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1 = ptrtoint [0 x %EffectRequirement]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %EffectRequirement*
  %t6 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t7 = ptrtoint { %EffectRequirement*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %EffectRequirement*, i64 }*
  %t10 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t9, i32 0, i32 0
  store %EffectRequirement* %t5, %EffectRequirement** %t10
  %t11 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t13 = extractvalue %ElseBranch %branch, 1
  %t14 = call { %EffectRequirement*, i64 }* @collect_effects_from_optional_block(%Block* %t13)
  %t15 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t12, { %EffectRequirement*, i64 }* %t14)
  store { %EffectRequirement*, i64 }* %t15, { %EffectRequirement*, i64 }** %l0
  %t16 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t17 = extractvalue %ElseBranch %branch, 0
  %t18 = call { %EffectRequirement*, i64 }* @collect_effects_from_optional_statement(%Statement* %t17)
  %t19 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t16, { %EffectRequirement*, i64 }* %t18)
  store { %EffectRequirement*, i64 }* %t19, { %EffectRequirement*, i64 }** %l0
  %t20 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t20
}

define { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %case) {
block.entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = getelementptr %Expression, %Expression* null, i32 1
  %t2 = ptrtoint %Expression* %t1 to i64
  %t3 = call noalias i8* @malloc(i64 %t2)
  %t4 = bitcast i8* %t3 to %Expression*
  store %Expression %t0, %Expression* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  %t5 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t4)
  store { %EffectRequirement*, i64 }* %t5, { %EffectRequirement*, i64 }** %l0
  %t6 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t7 = extractvalue %MatchCase %case, 1
  %t8 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t7)
  %t9 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t6, { %EffectRequirement*, i64 }* %t8)
  store { %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }** %l0
  %t10 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t11 = extractvalue %MatchCase %case, 2
  %t12 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t11)
  %t13 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t10, { %EffectRequirement*, i64 }* %t12)
  store { %EffectRequirement*, i64 }* %t13, { %EffectRequirement*, i64 }** %l0
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t14
}

define { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %expression) {
block.entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %l2 = alloca { %EffectRequirement*, i64 }*
  %l3 = alloca { %EffectRequirement*, i64 }*
  %l4 = alloca double
  %l5 = alloca { %EffectRequirement*, i64 }*
  %l6 = alloca double
  %l7 = alloca { %EffectRequirement*, i64 }*
  %l8 = alloca double
  %l9 = alloca { %EffectRequirement*, i64 }*
  %l10 = alloca { %EffectRequirement*, i64 }*
  %t0 = icmp eq %Expression* %expression, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t2 = ptrtoint [0 x %EffectRequirement]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %EffectRequirement*
  %t7 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t8 = ptrtoint { %EffectRequirement*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %EffectRequirement*, i64 }*
  %t11 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 0
  store %EffectRequirement* %t6, %EffectRequirement** %t11
  %t12 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  ret { %EffectRequirement*, i64 }* %t10
merge1:
  %t13 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t14 = load i32, i32* %t13
  %t15 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t16 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t14, 0
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t14, 1
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t14, 2
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t14, 3
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t14, 4
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t14, 5
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t14, 6
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t14, 7
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t14, 8
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t14, 9
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t14, 10
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t14, 11
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t14, 12
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t14, 13
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t14, 14
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t14, 15
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = call i8* @malloc(i64 5)
  %t65 = bitcast i8* %t64 to [5 x i8]*
  store [5 x i8] c"Call\00", [5 x i8]* %t65
  %t66 = call i1 @strings_equal(i8* %t63, i8* %t64)
  br i1 %t66, label %then2, label %merge3
then2:
  %t67 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t68 = load i32, i32* %t67
  %t69 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t70 = bitcast [16 x i8]* %t69 to i8*
  %t71 = bitcast i8* %t70 to %Expression**
  %t72 = load %Expression*, %Expression** %t71
  %t73 = icmp eq i32 %t68, 8
  %t74 = select i1 %t73, %Expression* %t72, %Expression* null
  %t75 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t74)
  store { %EffectRequirement*, i64 }* %t75, { %EffectRequirement*, i64 }** %l0
  %t76 = sitofp i64 0 to double
  store double %t76, double* %l1
  %t77 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t78 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t125 = phi { %EffectRequirement*, i64 }* [ %t77, %then2 ], [ %t123, %loop.latch6 ]
  %t126 = phi double [ %t78, %then2 ], [ %t124, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t125, { %EffectRequirement*, i64 }** %l0
  store double %t126, double* %l1
  br label %loop.body5
loop.body5:
  %t79 = load double, double* %l1
  %t80 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t81 = load i32, i32* %t80
  %t82 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t83 = bitcast [16 x i8]* %t82 to i8*
  %t84 = getelementptr inbounds i8, i8* %t83, i64 8
  %t85 = bitcast i8* %t84 to { %Expression*, i64 }**
  %t86 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t85
  %t87 = icmp eq i32 %t81, 8
  %t88 = select i1 %t87, { %Expression*, i64 }* %t86, { %Expression*, i64 }* null
  %t89 = load { %Expression*, i64 }, { %Expression*, i64 }* %t88
  %t90 = extractvalue { %Expression*, i64 } %t89, 1
  %t91 = sitofp i64 %t90 to double
  %t92 = fcmp oge double %t79, %t91
  %t93 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t94 = load double, double* %l1
  br i1 %t92, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t95 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t96 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t97 = load i32, i32* %t96
  %t98 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t99 = bitcast [16 x i8]* %t98 to i8*
  %t100 = getelementptr inbounds i8, i8* %t99, i64 8
  %t101 = bitcast i8* %t100 to { %Expression*, i64 }**
  %t102 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t101
  %t103 = icmp eq i32 %t97, 8
  %t104 = select i1 %t103, { %Expression*, i64 }* %t102, { %Expression*, i64 }* null
  %t105 = load double, double* %l1
  %t106 = call double @llvm.round.f64(double %t105)
  %t107 = fptosi double %t106 to i64
  %t108 = load { %Expression*, i64 }, { %Expression*, i64 }* %t104
  %t109 = extractvalue { %Expression*, i64 } %t108, 0
  %t110 = extractvalue { %Expression*, i64 } %t108, 1
  %t111 = icmp uge i64 %t107, %t110
  ; bounds check: %t111 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t107, i64 %t110)
  %t112 = getelementptr %Expression, %Expression* %t109, i64 %t107
  %t113 = load %Expression, %Expression* %t112
  %t114 = getelementptr %Expression, %Expression* null, i32 1
  %t115 = ptrtoint %Expression* %t114 to i64
  %t116 = call noalias i8* @malloc(i64 %t115)
  %t117 = bitcast i8* %t116 to %Expression*
  store %Expression %t113, %Expression* %t117
  call void @sailfin_runtime_mark_persistent(i8* %t116)
  %t118 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t117)
  %t119 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t95, { %EffectRequirement*, i64 }* %t118)
  store { %EffectRequirement*, i64 }* %t119, { %EffectRequirement*, i64 }** %l0
  %t120 = load double, double* %l1
  %t121 = sitofp i64 1 to double
  %t122 = fadd double %t120, %t121
  store double %t122, double* %l1
  br label %loop.latch6
loop.latch6:
  %t123 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t124 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t127 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t128 = load double, double* %l1
  %t129 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t129
merge3:
  %t130 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t131 = load i32, i32* %t130
  %t132 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t133 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t131, 0
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t131, 1
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t131, 2
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t131, 3
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t131, 4
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t131, 5
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t131, 6
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t131, 7
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t131, 8
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t131, 9
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t131, 10
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t131, 11
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t131, 12
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t131, 13
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t131, 14
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t131, 15
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = call i8* @malloc(i64 7)
  %t182 = bitcast i8* %t181 to [7 x i8]*
  store [7 x i8] c"Member\00", [7 x i8]* %t182
  %t183 = call i1 @strings_equal(i8* %t180, i8* %t181)
  br i1 %t183, label %then10, label %merge11
then10:
  %t184 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t185 = load i32, i32* %t184
  %t186 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t187 = bitcast [16 x i8]* %t186 to i8*
  %t188 = bitcast i8* %t187 to %Expression**
  %t189 = load %Expression*, %Expression** %t188
  %t190 = icmp eq i32 %t185, 7
  %t191 = select i1 %t190, %Expression* %t189, %Expression* null
  %t192 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t191)
  ret { %EffectRequirement*, i64 }* %t192
merge11:
  %t193 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t194 = load i32, i32* %t193
  %t195 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t196 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t194, 0
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t194, 1
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t194, 2
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t194, 3
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t194, 4
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t194, 5
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t194, 6
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t194, 7
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t194, 8
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t194, 9
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t194, 10
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t194, 11
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t194, 12
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t194, 13
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %t238 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t239 = icmp eq i32 %t194, 14
  %t240 = select i1 %t239, i8* %t238, i8* %t237
  %t241 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t242 = icmp eq i32 %t194, 15
  %t243 = select i1 %t242, i8* %t241, i8* %t240
  %t244 = call i8* @malloc(i64 6)
  %t245 = bitcast i8* %t244 to [6 x i8]*
  store [6 x i8] c"Unary\00", [6 x i8]* %t245
  %t246 = call i1 @strings_equal(i8* %t243, i8* %t244)
  br i1 %t246, label %then12, label %merge13
then12:
  %t247 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t248 = load i32, i32* %t247
  %t249 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t250 = bitcast [16 x i8]* %t249 to i8*
  %t251 = getelementptr inbounds i8, i8* %t250, i64 8
  %t252 = bitcast i8* %t251 to %Expression**
  %t253 = load %Expression*, %Expression** %t252
  %t254 = icmp eq i32 %t248, 5
  %t255 = select i1 %t254, %Expression* %t253, %Expression* null
  %t256 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t255)
  ret { %EffectRequirement*, i64 }* %t256
merge13:
  %t257 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t258 = load i32, i32* %t257
  %t259 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t260 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t258, 0
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t258, 1
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t258, 2
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t258, 3
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t258, 4
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t258, 5
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t258, 6
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t258, 7
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t258, 8
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t258, 9
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t258, 10
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t258, 11
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t258, 12
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t258, 13
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t258, 14
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t258, 15
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = call i8* @malloc(i64 7)
  %t309 = bitcast i8* %t308 to [7 x i8]*
  store [7 x i8] c"Binary\00", [7 x i8]* %t309
  %t310 = call i1 @strings_equal(i8* %t307, i8* %t308)
  br i1 %t310, label %then14, label %merge15
then14:
  %t311 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t312 = load i32, i32* %t311
  %t313 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t314 = bitcast [24 x i8]* %t313 to i8*
  %t315 = getelementptr inbounds i8, i8* %t314, i64 8
  %t316 = bitcast i8* %t315 to %Expression**
  %t317 = load %Expression*, %Expression** %t316
  %t318 = icmp eq i32 %t312, 6
  %t319 = select i1 %t318, %Expression* %t317, %Expression* null
  %t320 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t319)
  store { %EffectRequirement*, i64 }* %t320, { %EffectRequirement*, i64 }** %l2
  %t321 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  %t322 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t323 = load i32, i32* %t322
  %t324 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t325 = bitcast [24 x i8]* %t324 to i8*
  %t326 = getelementptr inbounds i8, i8* %t325, i64 16
  %t327 = bitcast i8* %t326 to %Expression**
  %t328 = load %Expression*, %Expression** %t327
  %t329 = icmp eq i32 %t323, 6
  %t330 = select i1 %t329, %Expression* %t328, %Expression* null
  %t331 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t330)
  %t332 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t321, { %EffectRequirement*, i64 }* %t331)
  store { %EffectRequirement*, i64 }* %t332, { %EffectRequirement*, i64 }** %l2
  %t333 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  ret { %EffectRequirement*, i64 }* %t333
merge15:
  %t334 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t335 = load i32, i32* %t334
  %t336 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t337 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t335, 0
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t335, 1
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t335, 2
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t335, 3
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t335, 4
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t335, 5
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t335, 6
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t335, 7
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t335, 8
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t335, 9
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t335, 10
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t335, 11
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t335, 12
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t335, 13
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %t379 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t335, 14
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t335, 15
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = call i8* @malloc(i64 6)
  %t386 = bitcast i8* %t385 to [6 x i8]*
  store [6 x i8] c"Array\00", [6 x i8]* %t386
  %t387 = call i1 @strings_equal(i8* %t384, i8* %t385)
  br i1 %t387, label %then16, label %merge17
then16:
  %t388 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t389 = ptrtoint [0 x %EffectRequirement]* %t388 to i64
  %t390 = icmp eq i64 %t389, 0
  %t391 = select i1 %t390, i64 1, i64 %t389
  %t392 = call i8* @malloc(i64 %t391)
  %t393 = bitcast i8* %t392 to %EffectRequirement*
  %t394 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t395 = ptrtoint { %EffectRequirement*, i64 }* %t394 to i64
  %t396 = call i8* @malloc(i64 %t395)
  %t397 = bitcast i8* %t396 to { %EffectRequirement*, i64 }*
  %t398 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t397, i32 0, i32 0
  store %EffectRequirement* %t393, %EffectRequirement** %t398
  %t399 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t397, i32 0, i32 1
  store i64 0, i64* %t399
  store { %EffectRequirement*, i64 }* %t397, { %EffectRequirement*, i64 }** %l3
  %t400 = sitofp i64 0 to double
  store double %t400, double* %l4
  %t401 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t402 = load double, double* %l4
  br label %loop.header18
loop.header18:
  %t447 = phi { %EffectRequirement*, i64 }* [ %t401, %then16 ], [ %t445, %loop.latch20 ]
  %t448 = phi double [ %t402, %then16 ], [ %t446, %loop.latch20 ]
  store { %EffectRequirement*, i64 }* %t447, { %EffectRequirement*, i64 }** %l3
  store double %t448, double* %l4
  br label %loop.body19
loop.body19:
  %t403 = load double, double* %l4
  %t404 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t405 = load i32, i32* %t404
  %t406 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t407 = bitcast [8 x i8]* %t406 to i8*
  %t408 = bitcast i8* %t407 to { %Expression*, i64 }**
  %t409 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t408
  %t410 = icmp eq i32 %t405, 10
  %t411 = select i1 %t410, { %Expression*, i64 }* %t409, { %Expression*, i64 }* null
  %t412 = load { %Expression*, i64 }, { %Expression*, i64 }* %t411
  %t413 = extractvalue { %Expression*, i64 } %t412, 1
  %t414 = sitofp i64 %t413 to double
  %t415 = fcmp oge double %t403, %t414
  %t416 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t417 = load double, double* %l4
  br i1 %t415, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t418 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t419 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t420 = load i32, i32* %t419
  %t421 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t422 = bitcast [8 x i8]* %t421 to i8*
  %t423 = bitcast i8* %t422 to { %Expression*, i64 }**
  %t424 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t423
  %t425 = icmp eq i32 %t420, 10
  %t426 = select i1 %t425, { %Expression*, i64 }* %t424, { %Expression*, i64 }* null
  %t427 = load double, double* %l4
  %t428 = call double @llvm.round.f64(double %t427)
  %t429 = fptosi double %t428 to i64
  %t430 = load { %Expression*, i64 }, { %Expression*, i64 }* %t426
  %t431 = extractvalue { %Expression*, i64 } %t430, 0
  %t432 = extractvalue { %Expression*, i64 } %t430, 1
  %t433 = icmp uge i64 %t429, %t432
  ; bounds check: %t433 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t429, i64 %t432)
  %t434 = getelementptr %Expression, %Expression* %t431, i64 %t429
  %t435 = load %Expression, %Expression* %t434
  %t436 = getelementptr %Expression, %Expression* null, i32 1
  %t437 = ptrtoint %Expression* %t436 to i64
  %t438 = call noalias i8* @malloc(i64 %t437)
  %t439 = bitcast i8* %t438 to %Expression*
  store %Expression %t435, %Expression* %t439
  call void @sailfin_runtime_mark_persistent(i8* %t438)
  %t440 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t439)
  %t441 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t418, { %EffectRequirement*, i64 }* %t440)
  store { %EffectRequirement*, i64 }* %t441, { %EffectRequirement*, i64 }** %l3
  %t442 = load double, double* %l4
  %t443 = sitofp i64 1 to double
  %t444 = fadd double %t442, %t443
  store double %t444, double* %l4
  br label %loop.latch20
loop.latch20:
  %t445 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t446 = load double, double* %l4
  br label %loop.header18
afterloop21:
  %t449 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t450 = load double, double* %l4
  %t451 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  ret { %EffectRequirement*, i64 }* %t451
merge17:
  %t452 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t453 = load i32, i32* %t452
  %t454 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t455 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t456 = icmp eq i32 %t453, 0
  %t457 = select i1 %t456, i8* %t455, i8* %t454
  %t458 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t459 = icmp eq i32 %t453, 1
  %t460 = select i1 %t459, i8* %t458, i8* %t457
  %t461 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t462 = icmp eq i32 %t453, 2
  %t463 = select i1 %t462, i8* %t461, i8* %t460
  %t464 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t465 = icmp eq i32 %t453, 3
  %t466 = select i1 %t465, i8* %t464, i8* %t463
  %t467 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t453, 4
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t453, 5
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t453, 6
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t453, 7
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t453, 8
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t453, 9
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t453, 10
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t453, 11
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t453, 12
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t453, 13
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t453, 14
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t453, 15
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = call i8* @malloc(i64 7)
  %t504 = bitcast i8* %t503 to [7 x i8]*
  store [7 x i8] c"Object\00", [7 x i8]* %t504
  %t505 = call i1 @strings_equal(i8* %t502, i8* %t503)
  br i1 %t505, label %then24, label %merge25
then24:
  %t506 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t507 = ptrtoint [0 x %EffectRequirement]* %t506 to i64
  %t508 = icmp eq i64 %t507, 0
  %t509 = select i1 %t508, i64 1, i64 %t507
  %t510 = call i8* @malloc(i64 %t509)
  %t511 = bitcast i8* %t510 to %EffectRequirement*
  %t512 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t513 = ptrtoint { %EffectRequirement*, i64 }* %t512 to i64
  %t514 = call i8* @malloc(i64 %t513)
  %t515 = bitcast i8* %t514 to { %EffectRequirement*, i64 }*
  %t516 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t515, i32 0, i32 0
  store %EffectRequirement* %t511, %EffectRequirement** %t516
  %t517 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t515, i32 0, i32 1
  store i64 0, i64* %t517
  store { %EffectRequirement*, i64 }* %t515, { %EffectRequirement*, i64 }** %l5
  %t518 = sitofp i64 0 to double
  store double %t518, double* %l6
  %t519 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t520 = load double, double* %l6
  br label %loop.header26
loop.header26:
  %t580 = phi { %EffectRequirement*, i64 }* [ %t519, %then24 ], [ %t578, %loop.latch28 ]
  %t581 = phi double [ %t520, %then24 ], [ %t579, %loop.latch28 ]
  store { %EffectRequirement*, i64 }* %t580, { %EffectRequirement*, i64 }** %l5
  store double %t581, double* %l6
  br label %loop.body27
loop.body27:
  %t521 = load double, double* %l6
  %t522 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t523 = load i32, i32* %t522
  %t524 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t525 = bitcast [8 x i8]* %t524 to i8*
  %t526 = bitcast i8* %t525 to { %ObjectField*, i64 }**
  %t527 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t526
  %t528 = icmp eq i32 %t523, 11
  %t529 = select i1 %t528, { %ObjectField*, i64 }* %t527, { %ObjectField*, i64 }* null
  %t530 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t531 = bitcast [16 x i8]* %t530 to i8*
  %t532 = getelementptr inbounds i8, i8* %t531, i64 8
  %t533 = bitcast i8* %t532 to { %ObjectField*, i64 }**
  %t534 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t533
  %t535 = icmp eq i32 %t523, 12
  %t536 = select i1 %t535, { %ObjectField*, i64 }* %t534, { %ObjectField*, i64 }* %t529
  %t537 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t536
  %t538 = extractvalue { %ObjectField*, i64 } %t537, 1
  %t539 = sitofp i64 %t538 to double
  %t540 = fcmp oge double %t521, %t539
  %t541 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t542 = load double, double* %l6
  br i1 %t540, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t543 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t544 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t545 = load i32, i32* %t544
  %t546 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t547 = bitcast [8 x i8]* %t546 to i8*
  %t548 = bitcast i8* %t547 to { %ObjectField*, i64 }**
  %t549 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t548
  %t550 = icmp eq i32 %t545, 11
  %t551 = select i1 %t550, { %ObjectField*, i64 }* %t549, { %ObjectField*, i64 }* null
  %t552 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t553 = bitcast [16 x i8]* %t552 to i8*
  %t554 = getelementptr inbounds i8, i8* %t553, i64 8
  %t555 = bitcast i8* %t554 to { %ObjectField*, i64 }**
  %t556 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t555
  %t557 = icmp eq i32 %t545, 12
  %t558 = select i1 %t557, { %ObjectField*, i64 }* %t556, { %ObjectField*, i64 }* %t551
  %t559 = load double, double* %l6
  %t560 = call double @llvm.round.f64(double %t559)
  %t561 = fptosi double %t560 to i64
  %t562 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t558
  %t563 = extractvalue { %ObjectField*, i64 } %t562, 0
  %t564 = extractvalue { %ObjectField*, i64 } %t562, 1
  %t565 = icmp uge i64 %t561, %t564
  ; bounds check: %t565 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t561, i64 %t564)
  %t566 = getelementptr %ObjectField, %ObjectField* %t563, i64 %t561
  %t567 = load %ObjectField, %ObjectField* %t566
  %t568 = extractvalue %ObjectField %t567, 1
  %t569 = getelementptr %Expression, %Expression* null, i32 1
  %t570 = ptrtoint %Expression* %t569 to i64
  %t571 = call noalias i8* @malloc(i64 %t570)
  %t572 = bitcast i8* %t571 to %Expression*
  store %Expression %t568, %Expression* %t572
  call void @sailfin_runtime_mark_persistent(i8* %t571)
  %t573 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t572)
  %t574 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t543, { %EffectRequirement*, i64 }* %t573)
  store { %EffectRequirement*, i64 }* %t574, { %EffectRequirement*, i64 }** %l5
  %t575 = load double, double* %l6
  %t576 = sitofp i64 1 to double
  %t577 = fadd double %t575, %t576
  store double %t577, double* %l6
  br label %loop.latch28
loop.latch28:
  %t578 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t579 = load double, double* %l6
  br label %loop.header26
afterloop29:
  %t582 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t583 = load double, double* %l6
  %t584 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t584
merge25:
  %t585 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t586 = load i32, i32* %t585
  %t587 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t588 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t586, 0
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t586, 1
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t586, 2
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t586, 3
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t586, 4
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t586, 5
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t586, 6
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t586, 7
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t586, 8
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t586, 9
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t586, 10
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t586, 11
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t586, 12
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t628 = icmp eq i32 %t586, 13
  %t629 = select i1 %t628, i8* %t627, i8* %t626
  %t630 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t631 = icmp eq i32 %t586, 14
  %t632 = select i1 %t631, i8* %t630, i8* %t629
  %t633 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t634 = icmp eq i32 %t586, 15
  %t635 = select i1 %t634, i8* %t633, i8* %t632
  %t636 = call i8* @malloc(i64 7)
  %t637 = bitcast i8* %t636 to [7 x i8]*
  store [7 x i8] c"Struct\00", [7 x i8]* %t637
  %t638 = call i1 @strings_equal(i8* %t635, i8* %t636)
  br i1 %t638, label %then32, label %merge33
then32:
  %t639 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t640 = ptrtoint [0 x %EffectRequirement]* %t639 to i64
  %t641 = icmp eq i64 %t640, 0
  %t642 = select i1 %t641, i64 1, i64 %t640
  %t643 = call i8* @malloc(i64 %t642)
  %t644 = bitcast i8* %t643 to %EffectRequirement*
  %t645 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t646 = ptrtoint { %EffectRequirement*, i64 }* %t645 to i64
  %t647 = call i8* @malloc(i64 %t646)
  %t648 = bitcast i8* %t647 to { %EffectRequirement*, i64 }*
  %t649 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t648, i32 0, i32 0
  store %EffectRequirement* %t644, %EffectRequirement** %t649
  %t650 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t648, i32 0, i32 1
  store i64 0, i64* %t650
  store { %EffectRequirement*, i64 }* %t648, { %EffectRequirement*, i64 }** %l7
  %t651 = sitofp i64 0 to double
  store double %t651, double* %l8
  %t652 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t653 = load double, double* %l8
  br label %loop.header34
loop.header34:
  %t713 = phi { %EffectRequirement*, i64 }* [ %t652, %then32 ], [ %t711, %loop.latch36 ]
  %t714 = phi double [ %t653, %then32 ], [ %t712, %loop.latch36 ]
  store { %EffectRequirement*, i64 }* %t713, { %EffectRequirement*, i64 }** %l7
  store double %t714, double* %l8
  br label %loop.body35
loop.body35:
  %t654 = load double, double* %l8
  %t655 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t656 = load i32, i32* %t655
  %t657 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t658 = bitcast [8 x i8]* %t657 to i8*
  %t659 = bitcast i8* %t658 to { %ObjectField*, i64 }**
  %t660 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t659
  %t661 = icmp eq i32 %t656, 11
  %t662 = select i1 %t661, { %ObjectField*, i64 }* %t660, { %ObjectField*, i64 }* null
  %t663 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t664 = bitcast [16 x i8]* %t663 to i8*
  %t665 = getelementptr inbounds i8, i8* %t664, i64 8
  %t666 = bitcast i8* %t665 to { %ObjectField*, i64 }**
  %t667 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t666
  %t668 = icmp eq i32 %t656, 12
  %t669 = select i1 %t668, { %ObjectField*, i64 }* %t667, { %ObjectField*, i64 }* %t662
  %t670 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t669
  %t671 = extractvalue { %ObjectField*, i64 } %t670, 1
  %t672 = sitofp i64 %t671 to double
  %t673 = fcmp oge double %t654, %t672
  %t674 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t675 = load double, double* %l8
  br i1 %t673, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t676 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t677 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t678 = load i32, i32* %t677
  %t679 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t680 = bitcast [8 x i8]* %t679 to i8*
  %t681 = bitcast i8* %t680 to { %ObjectField*, i64 }**
  %t682 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t681
  %t683 = icmp eq i32 %t678, 11
  %t684 = select i1 %t683, { %ObjectField*, i64 }* %t682, { %ObjectField*, i64 }* null
  %t685 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t686 = bitcast [16 x i8]* %t685 to i8*
  %t687 = getelementptr inbounds i8, i8* %t686, i64 8
  %t688 = bitcast i8* %t687 to { %ObjectField*, i64 }**
  %t689 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t688
  %t690 = icmp eq i32 %t678, 12
  %t691 = select i1 %t690, { %ObjectField*, i64 }* %t689, { %ObjectField*, i64 }* %t684
  %t692 = load double, double* %l8
  %t693 = call double @llvm.round.f64(double %t692)
  %t694 = fptosi double %t693 to i64
  %t695 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t691
  %t696 = extractvalue { %ObjectField*, i64 } %t695, 0
  %t697 = extractvalue { %ObjectField*, i64 } %t695, 1
  %t698 = icmp uge i64 %t694, %t697
  ; bounds check: %t698 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t694, i64 %t697)
  %t699 = getelementptr %ObjectField, %ObjectField* %t696, i64 %t694
  %t700 = load %ObjectField, %ObjectField* %t699
  %t701 = extractvalue %ObjectField %t700, 1
  %t702 = getelementptr %Expression, %Expression* null, i32 1
  %t703 = ptrtoint %Expression* %t702 to i64
  %t704 = call noalias i8* @malloc(i64 %t703)
  %t705 = bitcast i8* %t704 to %Expression*
  store %Expression %t701, %Expression* %t705
  call void @sailfin_runtime_mark_persistent(i8* %t704)
  %t706 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t705)
  %t707 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t676, { %EffectRequirement*, i64 }* %t706)
  store { %EffectRequirement*, i64 }* %t707, { %EffectRequirement*, i64 }** %l7
  %t708 = load double, double* %l8
  %t709 = sitofp i64 1 to double
  %t710 = fadd double %t708, %t709
  store double %t710, double* %l8
  br label %loop.latch36
loop.latch36:
  %t711 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t712 = load double, double* %l8
  br label %loop.header34
afterloop37:
  %t715 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t716 = load double, double* %l8
  %t717 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t717
merge33:
  %t718 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t719 = load i32, i32* %t718
  %t720 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t721 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t722 = icmp eq i32 %t719, 0
  %t723 = select i1 %t722, i8* %t721, i8* %t720
  %t724 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t725 = icmp eq i32 %t719, 1
  %t726 = select i1 %t725, i8* %t724, i8* %t723
  %t727 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t728 = icmp eq i32 %t719, 2
  %t729 = select i1 %t728, i8* %t727, i8* %t726
  %t730 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t731 = icmp eq i32 %t719, 3
  %t732 = select i1 %t731, i8* %t730, i8* %t729
  %t733 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t734 = icmp eq i32 %t719, 4
  %t735 = select i1 %t734, i8* %t733, i8* %t732
  %t736 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t737 = icmp eq i32 %t719, 5
  %t738 = select i1 %t737, i8* %t736, i8* %t735
  %t739 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t740 = icmp eq i32 %t719, 6
  %t741 = select i1 %t740, i8* %t739, i8* %t738
  %t742 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t743 = icmp eq i32 %t719, 7
  %t744 = select i1 %t743, i8* %t742, i8* %t741
  %t745 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t746 = icmp eq i32 %t719, 8
  %t747 = select i1 %t746, i8* %t745, i8* %t744
  %t748 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t749 = icmp eq i32 %t719, 9
  %t750 = select i1 %t749, i8* %t748, i8* %t747
  %t751 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t752 = icmp eq i32 %t719, 10
  %t753 = select i1 %t752, i8* %t751, i8* %t750
  %t754 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t755 = icmp eq i32 %t719, 11
  %t756 = select i1 %t755, i8* %t754, i8* %t753
  %t757 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t719, 12
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t719, 13
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t719, 14
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t719, 15
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = call i8* @malloc(i64 7)
  %t770 = bitcast i8* %t769 to [7 x i8]*
  store [7 x i8] c"Lambda\00", [7 x i8]* %t770
  %t771 = call i1 @strings_equal(i8* %t768, i8* %t769)
  br i1 %t771, label %then40, label %merge41
then40:
  %t772 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t773 = load i32, i32* %t772
  %t774 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t775 = bitcast [40 x i8]* %t774 to i8*
  %t776 = getelementptr inbounds i8, i8* %t775, i64 8
  %t777 = bitcast i8* %t776 to %Block*
  %t778 = load %Block, %Block* %t777
  %t779 = icmp eq i32 %t773, 13
  %t780 = select i1 %t779, %Block %t778, %Block zeroinitializer
  %t781 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t780)
  ret { %EffectRequirement*, i64 }* %t781
merge41:
  %t782 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t783 = load i32, i32* %t782
  %t784 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t785 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t783, 0
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t783, 1
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t783, 2
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t783, 3
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t783, 4
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t783, 5
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t783, 6
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t783, 7
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %t809 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t783, 8
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t783, 9
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t783, 10
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t783, 11
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t783, 12
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t783, 13
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t783, 14
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t783, 15
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = call i8* @malloc(i64 6)
  %t834 = bitcast i8* %t833 to [6 x i8]*
  store [6 x i8] c"Index\00", [6 x i8]* %t834
  %t835 = call i1 @strings_equal(i8* %t832, i8* %t833)
  br i1 %t835, label %then42, label %merge43
then42:
  %t836 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t837 = load i32, i32* %t836
  %t838 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t839 = bitcast [16 x i8]* %t838 to i8*
  %t840 = bitcast i8* %t839 to %Expression**
  %t841 = load %Expression*, %Expression** %t840
  %t842 = icmp eq i32 %t837, 9
  %t843 = select i1 %t842, %Expression* %t841, %Expression* null
  %t844 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t843)
  store { %EffectRequirement*, i64 }* %t844, { %EffectRequirement*, i64 }** %l9
  %t845 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t846 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t847 = load i32, i32* %t846
  %t848 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t849 = bitcast [16 x i8]* %t848 to i8*
  %t850 = getelementptr inbounds i8, i8* %t849, i64 8
  %t851 = bitcast i8* %t850 to %Expression**
  %t852 = load %Expression*, %Expression** %t851
  %t853 = icmp eq i32 %t847, 9
  %t854 = select i1 %t853, %Expression* %t852, %Expression* null
  %t855 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t854)
  %t856 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t845, { %EffectRequirement*, i64 }* %t855)
  store { %EffectRequirement*, i64 }* %t856, { %EffectRequirement*, i64 }** %l9
  %t857 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t857
merge43:
  %t858 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t859 = load i32, i32* %t858
  %t860 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t861 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t859, 0
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t859, 1
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t859, 2
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t859, 3
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t859, 4
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t859, 5
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t859, 6
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t859, 7
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t859, 8
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t859, 9
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t859, 10
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t859, 11
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t859, 12
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t859, 13
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t859, 14
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t859, 15
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = call i8* @malloc(i64 6)
  %t910 = bitcast i8* %t909 to [6 x i8]*
  store [6 x i8] c"Range\00", [6 x i8]* %t910
  %t911 = call i1 @strings_equal(i8* %t908, i8* %t909)
  br i1 %t911, label %then44, label %merge45
then44:
  %t912 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t913 = load i32, i32* %t912
  %t914 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t915 = bitcast [16 x i8]* %t914 to i8*
  %t916 = bitcast i8* %t915 to %Expression**
  %t917 = load %Expression*, %Expression** %t916
  %t918 = icmp eq i32 %t913, 14
  %t919 = select i1 %t918, %Expression* %t917, %Expression* null
  %t920 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t919)
  store { %EffectRequirement*, i64 }* %t920, { %EffectRequirement*, i64 }** %l10
  %t921 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t922 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t923 = load i32, i32* %t922
  %t924 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t925 = bitcast [16 x i8]* %t924 to i8*
  %t926 = getelementptr inbounds i8, i8* %t925, i64 8
  %t927 = bitcast i8* %t926 to %Expression**
  %t928 = load %Expression*, %Expression** %t927
  %t929 = icmp eq i32 %t923, 14
  %t930 = select i1 %t929, %Expression* %t928, %Expression* null
  %t931 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t930)
  %t932 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t921, { %EffectRequirement*, i64 }* %t931)
  store { %EffectRequirement*, i64 }* %t932, { %EffectRequirement*, i64 }** %l10
  %t933 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t933
merge45:
  %t934 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t935 = load i32, i32* %t934
  %t936 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t937 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t935, 0
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t935, 1
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t935, 2
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t935, 3
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t935, 4
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t935, 5
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t935, 6
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t935, 7
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %t961 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t962 = icmp eq i32 %t935, 8
  %t963 = select i1 %t962, i8* %t961, i8* %t960
  %t964 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t935, 9
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t935, 10
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t935, 11
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t935, 12
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t935, 13
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t935, 14
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t935, 15
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = call i8* @malloc(i64 4)
  %t986 = bitcast i8* %t985 to [4 x i8]*
  store [4 x i8] c"Raw\00", [4 x i8]* %t986
  %t987 = call i1 @strings_equal(i8* %t984, i8* %t985)
  br i1 %t987, label %then46, label %merge47
then46:
  %t988 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t989 = ptrtoint [0 x %EffectRequirement]* %t988 to i64
  %t990 = icmp eq i64 %t989, 0
  %t991 = select i1 %t990, i64 1, i64 %t989
  %t992 = call i8* @malloc(i64 %t991)
  %t993 = bitcast i8* %t992 to %EffectRequirement*
  %t994 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t995 = ptrtoint { %EffectRequirement*, i64 }* %t994 to i64
  %t996 = call i8* @malloc(i64 %t995)
  %t997 = bitcast i8* %t996 to { %EffectRequirement*, i64 }*
  %t998 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t997, i32 0, i32 0
  store %EffectRequirement* %t993, %EffectRequirement** %t998
  %t999 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t997, i32 0, i32 1
  store i64 0, i64* %t999
  ret { %EffectRequirement*, i64 }* %t997
merge47:
  %t1000 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1001 = ptrtoint [0 x %EffectRequirement]* %t1000 to i64
  %t1002 = icmp eq i64 %t1001, 0
  %t1003 = select i1 %t1002, i64 1, i64 %t1001
  %t1004 = call i8* @malloc(i64 %t1003)
  %t1005 = bitcast i8* %t1004 to %EffectRequirement*
  %t1006 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1007 = ptrtoint { %EffectRequirement*, i64 }* %t1006 to i64
  %t1008 = call i8* @malloc(i64 %t1007)
  %t1009 = bitcast i8* %t1008 to { %EffectRequirement*, i64 }*
  %t1010 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1009, i32 0, i32 0
  store %EffectRequirement* %t1005, %EffectRequirement** %t1010
  %t1011 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1009, i32 0, i32 1
  store i64 0, i64* %t1011
  ret { %EffectRequirement*, i64 }* %t1009
}

define { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %tokens) {
block.entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1 = ptrtoint [0 x %EffectRequirement]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %EffectRequirement*
  %t6 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t7 = ptrtoint { %EffectRequirement*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %EffectRequirement*, i64 }*
  %t10 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t9, i32 0, i32 0
  store %EffectRequirement* %t5, %EffectRequirement** %t10
  %t11 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t13 = call { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %t12, { %Token*, i64 }* %tokens)
  store { %EffectRequirement*, i64 }* %t13, { %EffectRequirement*, i64 }** %l0
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t15 = call i8* @malloc(i64 3)
  %t16 = bitcast i8* %t15 to [3 x i8]*
  store [3 x i8] c"fs\00", [3 x i8]* %t16
  %t17 = call i8* @malloc(i64 3)
  %t18 = bitcast i8* %t17 to [3 x i8]*
  store [3 x i8] c"io\00", [3 x i8]* %t18
  %t19 = call i8* @malloc(i64 24)
  %t20 = bitcast i8* %t19 to [24 x i8]*
  store [24 x i8] c"filesystem helper usage\00", [24 x i8]* %t20
  %t21 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t14, { %Token*, i64 }* %tokens, i8* %t15, i8* %t17, i8* %t19)
  store { %EffectRequirement*, i64 }* %t21, { %EffectRequirement*, i64 }** %l0
  %t22 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t23 = call i8* @malloc(i64 6)
  %t24 = bitcast i8* %t23 to [6 x i8]*
  store [6 x i8] c"print\00", [6 x i8]* %t24
  %t25 = call i8* @malloc(i64 3)
  %t26 = bitcast i8* %t25 to [3 x i8]*
  store [3 x i8] c"io\00", [3 x i8]* %t26
  %t27 = call i8* @malloc(i64 19)
  %t28 = bitcast i8* %t27 to [19 x i8]*
  store [19 x i8] c"print helper usage\00", [19 x i8]* %t28
  %t29 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t22, { %Token*, i64 }* %tokens, i8* %t23, i8* %t25, i8* %t27)
  store { %EffectRequirement*, i64 }* %t29, { %EffectRequirement*, i64 }** %l0
  %t30 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t31 = call i8* @malloc(i64 8)
  %t32 = bitcast i8* %t31 to [8 x i8]*
  store [8 x i8] c"console\00", [8 x i8]* %t32
  %t33 = call i8* @malloc(i64 3)
  %t34 = bitcast i8* %t33 to [3 x i8]*
  store [3 x i8] c"io\00", [3 x i8]* %t34
  %t35 = call i8* @malloc(i64 21)
  %t36 = bitcast i8* %t35 to [21 x i8]*
  store [21 x i8] c"console helper usage\00", [21 x i8]* %t36
  %t37 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t30, { %Token*, i64 }* %tokens, i8* %t31, i8* %t33, i8* %t35)
  store { %EffectRequirement*, i64 }* %t37, { %EffectRequirement*, i64 }** %l0
  %t38 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t39 = call i8* @malloc(i64 5)
  %t40 = bitcast i8* %t39 to [5 x i8]*
  store [5 x i8] c"http\00", [5 x i8]* %t40
  %t41 = call i8* @malloc(i64 4)
  %t42 = bitcast i8* %t41 to [4 x i8]*
  store [4 x i8] c"net\00", [4 x i8]* %t42
  %t43 = call i8* @malloc(i64 18)
  %t44 = bitcast i8* %t43 to [18 x i8]*
  store [18 x i8] c"http helper usage\00", [18 x i8]* %t44
  %t45 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t38, { %Token*, i64 }* %tokens, i8* %t39, i8* %t41, i8* %t43)
  store { %EffectRequirement*, i64 }* %t45, { %EffectRequirement*, i64 }** %l0
  %t46 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t47 = call i8* @malloc(i64 10)
  %t48 = bitcast i8* %t47 to [10 x i8]*
  store [10 x i8] c"websocket\00", [10 x i8]* %t48
  %t49 = call i8* @malloc(i64 4)
  %t50 = bitcast i8* %t49 to [4 x i8]*
  store [4 x i8] c"net\00", [4 x i8]* %t50
  %t51 = call i8* @malloc(i64 23)
  %t52 = bitcast i8* %t51 to [23 x i8]*
  store [23 x i8] c"websocket helper usage\00", [23 x i8]* %t52
  %t53 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t46, { %Token*, i64 }* %tokens, i8* %t47, i8* %t49, i8* %t51)
  store { %EffectRequirement*, i64 }* %t53, { %EffectRequirement*, i64 }** %l0
  %t54 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t55 = call i8* @malloc(i64 6)
  %t56 = bitcast i8* %t55 to [6 x i8]*
  store [6 x i8] c"spawn\00", [6 x i8]* %t56
  %t57 = call i8* @malloc(i64 3)
  %t58 = bitcast i8* %t57 to [3 x i8]*
  store [3 x i8] c"io\00", [3 x i8]* %t58
  %t59 = call i8* @malloc(i64 11)
  %t60 = bitcast i8* %t59 to [11 x i8]*
  store [11 x i8] c"spawn call\00", [11 x i8]* %t60
  %t61 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t54, { %Token*, i64 }* %tokens, i8* %t55, i8* %t57, i8* %t59)
  store { %EffectRequirement*, i64 }* %t61, { %EffectRequirement*, i64 }** %l0
  %t62 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t63 = call i8* @malloc(i64 6)
  %t64 = bitcast i8* %t63 to [6 x i8]*
  store [6 x i8] c"serve\00", [6 x i8]* %t64
  %t65 = call i8* @malloc(i64 4)
  %t66 = bitcast i8* %t65 to [4 x i8]*
  store [4 x i8] c"net\00", [4 x i8]* %t66
  %t67 = call i8* @malloc(i64 11)
  %t68 = bitcast i8* %t67 to [11 x i8]*
  store [11 x i8] c"serve call\00", [11 x i8]* %t68
  %t69 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t62, { %Token*, i64 }* %tokens, i8* %t63, i8* %t65, i8* %t67)
  store { %EffectRequirement*, i64 }* %t69, { %EffectRequirement*, i64 }** %l0
  %t70 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t71 = call i8* @malloc(i64 6)
  %t72 = bitcast i8* %t71 to [6 x i8]*
  store [6 x i8] c"sleep\00", [6 x i8]* %t72
  %t73 = call i8* @malloc(i64 6)
  %t74 = bitcast i8* %t73 to [6 x i8]*
  store [6 x i8] c"clock\00", [6 x i8]* %t74
  %t75 = call i8* @malloc(i64 11)
  %t76 = bitcast i8* %t75 to [11 x i8]*
  store [11 x i8] c"sleep call\00", [11 x i8]* %t76
  %t77 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t70, { %Token*, i64 }* %tokens, i8* %t71, i8* %t73, i8* %t75)
  store { %EffectRequirement*, i64 }* %t77, { %EffectRequirement*, i64 }** %l0
  %t78 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t78
}

define i8* @token_text(%Token %token) {
block.entry:
  %t0 = extractvalue %Token %token, 1
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

define { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens) {
block.entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %l2 = alloca %Token
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca %Token
  %l6 = alloca double
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t205 = phi { %EffectRequirement*, i64 }* [ %t1, %block.entry ], [ %t203, %loop.latch2 ]
  %t206 = phi double [ %t2, %block.entry ], [ %t204, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t205, { %EffectRequirement*, i64 }** %l0
  store double %t206, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t5 = extractvalue { %Token*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t14 = extractvalue { %Token*, i64 } %t13, 0
  %t15 = extractvalue { %Token*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %Token, %Token* %t14, i64 %t12
  %t18 = load %Token, %Token* %t17
  store %Token %t18, %Token* %l2
  %t19 = load %Token, %Token* %l2
  %t20 = call i8* @malloc(i64 7)
  %t21 = bitcast i8* %t20 to [7 x i8]*
  store [7 x i8] c"prompt\00", [7 x i8]* %t21
  %t22 = call i1 @is_identifier_token(%Token %t19, i8* %t20)
  %t23 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load %Token, %Token* %l2
  br i1 %t22, label %then6, label %merge7
then6:
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  %t29 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t28)
  store double %t29, double* %l3
  %t30 = call i8* @malloc(i64 13)
  %t31 = bitcast i8* %t30 to [13 x i8]*
  store [13 x i8] c"prompt block\00", [13 x i8]* %t31
  store i8* %t30, i8** %l4
  %t32 = load double, double* %l3
  %t33 = sitofp i64 -1 to double
  %t34 = fcmp une double %t32, %t33
  %t35 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = load %Token, %Token* %l2
  %t38 = load double, double* %l3
  %t39 = load i8*, i8** %l4
  br i1 %t34, label %then8, label %merge9
then8:
  %t40 = load double, double* %l3
  %t41 = call double @llvm.round.f64(double %t40)
  %t42 = fptosi double %t41 to i64
  %t43 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t44 = extractvalue { %Token*, i64 } %t43, 0
  %t45 = extractvalue { %Token*, i64 } %t43, 1
  %t46 = icmp uge i64 %t42, %t45
  ; bounds check: %t46 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t42, i64 %t45)
  %t47 = getelementptr %Token, %Token* %t44, i64 %t42
  %t48 = load %Token, %Token* %t47
  store %Token %t48, %Token* %l5
  %t50 = load %Token, %Token* %l5
  %t51 = extractvalue %Token %t50, 0
  %t52 = extractvalue %TokenKind %t51, 0
  %t53 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t54 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t52, 0
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %t57 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t52, 1
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t52, 2
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t52, 3
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t52, 4
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t52, 5
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t52, 6
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t52, 7
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = call i8* @malloc(i64 11)
  %t79 = bitcast i8* %t78 to [11 x i8]*
  store [11 x i8] c"Identifier\00", [11 x i8]* %t79
  %t80 = call i1 @strings_equal(i8* %t77, i8* %t78)
  br label %logical_or_entry_49

logical_or_entry_49:
  br i1 %t80, label %logical_or_merge_49, label %logical_or_right_49

logical_or_right_49:
  %t81 = load %Token, %Token* %l5
  %t82 = extractvalue %Token %t81, 0
  %t83 = extractvalue %TokenKind %t82, 0
  %t84 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t85 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t83, 0
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t83, 1
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t83, 2
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t83, 3
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t83, 4
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t83, 5
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t83, 6
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t83, 7
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = call i8* @malloc(i64 14)
  %t110 = bitcast i8* %t109 to [14 x i8]*
  store [14 x i8] c"StringLiteral\00", [14 x i8]* %t110
  %t111 = call i1 @strings_equal(i8* %t108, i8* %t109)
  br label %logical_or_right_end_49

logical_or_right_end_49:
  br label %logical_or_merge_49

logical_or_merge_49:
  %t112 = phi i1 [ true, %logical_or_entry_49 ], [ %t111, %logical_or_right_end_49 ]
  %t113 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t114 = load double, double* %l1
  %t115 = load %Token, %Token* %l2
  %t116 = load double, double* %l3
  %t117 = load i8*, i8** %l4
  %t118 = load %Token, %Token* %l5
  br i1 %t112, label %then10, label %merge11
then10:
  %t119 = call i8* @malloc(i64 8)
  %t120 = bitcast i8* %t119 to [8 x i8]*
  store [8 x i8] c"prompt \00", [8 x i8]* %t120
  %t121 = load %Token, %Token* %l5
  %t122 = call i8* @token_text(%Token %t121)
  %t123 = call i8* @sailfin_runtime_string_concat(i8* %t119, i8* %t122)
  store i8* %t123, i8** %l4
  %t124 = load double, double* %l3
  %t125 = sitofp i64 1 to double
  %t126 = fadd double %t124, %t125
  %t127 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t126)
  store double %t127, double* %l6
  %t129 = load double, double* %l6
  %t130 = sitofp i64 -1 to double
  %t131 = fcmp une double %t129, %t130
  br label %logical_and_entry_128

logical_and_entry_128:
  br i1 %t131, label %logical_and_right_128, label %logical_and_merge_128

logical_and_right_128:
  %t132 = load double, double* %l6
  %t133 = call double @llvm.round.f64(double %t132)
  %t134 = fptosi double %t133 to i64
  %t135 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t136 = extractvalue { %Token*, i64 } %t135, 0
  %t137 = extractvalue { %Token*, i64 } %t135, 1
  %t138 = icmp uge i64 %t134, %t137
  ; bounds check: %t138 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t134, i64 %t137)
  %t139 = getelementptr %Token, %Token* %t136, i64 %t134
  %t140 = load %Token, %Token* %t139
  %t141 = add i64 0, 2
  %t142 = call i8* @malloc(i64 %t141)
  store i8 123, i8* %t142
  %t143 = getelementptr i8, i8* %t142, i64 1
  store i8 0, i8* %t143
  call void @sailfin_runtime_mark_persistent(i8* %t142)
  %t144 = call i1 @is_symbol_token(%Token %t140, i8* %t142)
  br label %logical_and_right_end_128

logical_and_right_end_128:
  br label %logical_and_merge_128

logical_and_merge_128:
  %t145 = phi i1 [ false, %logical_and_entry_128 ], [ %t144, %logical_and_right_end_128 ]
  %t146 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t147 = load double, double* %l1
  %t148 = load %Token, %Token* %l2
  %t149 = load double, double* %l3
  %t150 = load i8*, i8** %l4
  %t151 = load %Token, %Token* %l5
  %t152 = load double, double* %l6
  br i1 %t145, label %then12, label %merge13
then12:
  %t153 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t154 = call i8* @malloc(i64 6)
  %t155 = bitcast i8* %t154 to [6 x i8]*
  store [6 x i8] c"model\00", [6 x i8]* %t155
  %t156 = insertvalue %EffectRequirement undef, i8* %t154, 0
  %t157 = load %Token, %Token* %l2
  %t158 = getelementptr %Token, %Token* null, i32 1
  %t159 = ptrtoint %Token* %t158 to i64
  %t160 = call noalias i8* @malloc(i64 %t159)
  %t161 = bitcast i8* %t160 to %Token*
  store %Token %t157, %Token* %t161
  call void @sailfin_runtime_mark_persistent(i8* %t160)
  %t162 = insertvalue %EffectRequirement %t156, %Token* %t161, 1
  %t163 = load i8*, i8** %l4
  %t164 = insertvalue %EffectRequirement %t162, i8* %t163, 2
  %t165 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t153, %EffectRequirement %t164)
  store { %EffectRequirement*, i64 }* %t165, { %EffectRequirement*, i64 }** %l0
  %t166 = load double, double* %l1
  %t167 = sitofp i64 1 to double
  %t168 = fadd double %t166, %t167
  store double %t168, double* %l1
  br label %loop.latch2
merge13:
  %t169 = load i8*, i8** %l4
  %t170 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t171 = load double, double* %l1
  br label %merge11
merge11:
  %t172 = phi i8* [ %t169, %merge13 ], [ %t117, %logical_or_merge_49 ]
  %t173 = phi { %EffectRequirement*, i64 }* [ %t170, %merge13 ], [ %t113, %logical_or_merge_49 ]
  %t174 = phi double [ %t171, %merge13 ], [ %t114, %logical_or_merge_49 ]
  store i8* %t172, i8** %l4
  store { %EffectRequirement*, i64 }* %t173, { %EffectRequirement*, i64 }** %l0
  store double %t174, double* %l1
  %t175 = load i8*, i8** %l4
  %t176 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t177 = load double, double* %l1
  br label %merge9
merge9:
  %t178 = phi i8* [ %t175, %merge11 ], [ %t39, %then6 ]
  %t179 = phi { %EffectRequirement*, i64 }* [ %t176, %merge11 ], [ %t35, %then6 ]
  %t180 = phi double [ %t177, %merge11 ], [ %t36, %then6 ]
  store i8* %t178, i8** %l4
  store { %EffectRequirement*, i64 }* %t179, { %EffectRequirement*, i64 }** %l0
  store double %t180, double* %l1
  %t181 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t182 = call i8* @malloc(i64 6)
  %t183 = bitcast i8* %t182 to [6 x i8]*
  store [6 x i8] c"model\00", [6 x i8]* %t183
  %t184 = insertvalue %EffectRequirement undef, i8* %t182, 0
  %t185 = load %Token, %Token* %l2
  %t186 = getelementptr %Token, %Token* null, i32 1
  %t187 = ptrtoint %Token* %t186 to i64
  %t188 = call noalias i8* @malloc(i64 %t187)
  %t189 = bitcast i8* %t188 to %Token*
  store %Token %t185, %Token* %t189
  call void @sailfin_runtime_mark_persistent(i8* %t188)
  %t190 = insertvalue %EffectRequirement %t184, %Token* %t189, 1
  %t191 = load i8*, i8** %l4
  %t192 = insertvalue %EffectRequirement %t190, i8* %t191, 2
  %t193 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t181, %EffectRequirement %t192)
  store { %EffectRequirement*, i64 }* %t193, { %EffectRequirement*, i64 }** %l0
  %t194 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t195 = load double, double* %l1
  %t196 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t197 = phi { %EffectRequirement*, i64 }* [ %t194, %merge9 ], [ %t23, %merge5 ]
  %t198 = phi double [ %t195, %merge9 ], [ %t24, %merge5 ]
  %t199 = phi { %EffectRequirement*, i64 }* [ %t196, %merge9 ], [ %t23, %merge5 ]
  store { %EffectRequirement*, i64 }* %t197, { %EffectRequirement*, i64 }** %l0
  store double %t198, double* %l1
  store { %EffectRequirement*, i64 }* %t199, { %EffectRequirement*, i64 }** %l0
  %t200 = load double, double* %l1
  %t201 = sitofp i64 1 to double
  %t202 = fadd double %t200, %t201
  store double %t202, double* %l1
  br label %loop.latch2
loop.latch2:
  %t203 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t204 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t207 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t208 = load double, double* %l1
  %t209 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t209
}

define { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
block.entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = add i64 0, 2
  %t1 = call i8* @malloc(i64 %t0)
  store i8 46, i8* %t1
  %t2 = getelementptr i8, i8* %t1, i64 1
  store i8 0, i8* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  %t3 = call { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }* %tokens, i8* %identifier, i8* %t1)
  store { %Token*, i64 }* %t3, { %Token*, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l2
  %t5 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t6 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t7 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t41 = phi { %EffectRequirement*, i64 }* [ %t6, %block.entry ], [ %t39, %loop.latch2 ]
  %t42 = phi double [ %t7, %block.entry ], [ %t40, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t41, { %EffectRequirement*, i64 }** %l1
  store double %t42, double* %l2
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l2
  %t9 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t10 = load { %Token*, i64 }, { %Token*, i64 }* %t9
  %t11 = extractvalue { %Token*, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t15 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t18 = insertvalue %EffectRequirement undef, i8* %effect, 0
  %t19 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t20 = load double, double* %l2
  %t21 = call double @llvm.round.f64(double %t20)
  %t22 = fptosi double %t21 to i64
  %t23 = load { %Token*, i64 }, { %Token*, i64 }* %t19
  %t24 = extractvalue { %Token*, i64 } %t23, 0
  %t25 = extractvalue { %Token*, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t22, i64 %t25)
  %t27 = getelementptr %Token, %Token* %t24, i64 %t22
  %t28 = load %Token, %Token* %t27
  %t29 = getelementptr %Token, %Token* null, i32 1
  %t30 = ptrtoint %Token* %t29 to i64
  %t31 = call noalias i8* @malloc(i64 %t30)
  %t32 = bitcast i8* %t31 to %Token*
  store %Token %t28, %Token* %t32
  call void @sailfin_runtime_mark_persistent(i8* %t31)
  %t33 = insertvalue %EffectRequirement %t18, %Token* %t32, 1
  %t34 = insertvalue %EffectRequirement %t33, i8* %description, 2
  %t35 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t17, %EffectRequirement %t34)
  store { %EffectRequirement*, i64 }* %t35, { %EffectRequirement*, i64 }** %l1
  %t36 = load double, double* %l2
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l2
  br label %loop.latch2
loop.latch2:
  %t39 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t40 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t43 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t44 = load double, double* %l2
  %t45 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t45
}

define { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
block.entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = call { %Token*, i64 }* @find_identifier_call({ %Token*, i64 }* %tokens, i8* %identifier)
  store { %Token*, i64 }* %t0, { %Token*, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t3 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t4 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t38 = phi { %EffectRequirement*, i64 }* [ %t3, %block.entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t4, %block.entry ], [ %t37, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t38, { %EffectRequirement*, i64 }** %l1
  store double %t39, double* %l2
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l2
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load { %Token*, i64 }, { %Token*, i64 }* %t6
  %t8 = extractvalue { %Token*, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t5, %t9
  %t11 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t13 = load double, double* %l2
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t15 = insertvalue %EffectRequirement undef, i8* %effect, 0
  %t16 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t17 = load double, double* %l2
  %t18 = call double @llvm.round.f64(double %t17)
  %t19 = fptosi double %t18 to i64
  %t20 = load { %Token*, i64 }, { %Token*, i64 }* %t16
  %t21 = extractvalue { %Token*, i64 } %t20, 0
  %t22 = extractvalue { %Token*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t19, i64 %t22)
  %t24 = getelementptr %Token, %Token* %t21, i64 %t19
  %t25 = load %Token, %Token* %t24
  %t26 = getelementptr %Token, %Token* null, i32 1
  %t27 = ptrtoint %Token* %t26 to i64
  %t28 = call noalias i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to %Token*
  store %Token %t25, %Token* %t29
  call void @sailfin_runtime_mark_persistent(i8* %t28)
  %t30 = insertvalue %EffectRequirement %t15, %Token* %t29, 1
  %t31 = insertvalue %EffectRequirement %t30, i8* %description, 2
  %t32 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t14, %EffectRequirement %t31)
  store { %EffectRequirement*, i64 }* %t32, { %EffectRequirement*, i64 }** %l1
  %t33 = load double, double* %l2
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l2
  br label %loop.latch2
loop.latch2:
  %t36 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t37 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t40 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t41 = load double, double* %l2
  %t42 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t42
}

define { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }* %tokens, i8* %name, i8* %symbol) {
block.entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = getelementptr [0 x %Token], [0 x %Token]* null, i32 1
  %t1 = ptrtoint [0 x %Token]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %Token*
  %t6 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t7 = ptrtoint { %Token*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %Token*, i64 }*
  %t10 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 0
  store %Token* %t5, %Token** %t10
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %Token*, i64 }* %t9, { %Token*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t115 = phi { %Token*, i64 }* [ %t13, %block.entry ], [ %t113, %loop.latch2 ]
  %t116 = phi double [ %t14, %block.entry ], [ %t114, %loop.latch2 ]
  store { %Token*, i64 }* %t115, { %Token*, i64 }** %l0
  store double %t116, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t17 = extractvalue { %Token*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t26 = extractvalue { %Token*, i64 } %t25, 0
  %t27 = extractvalue { %Token*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %Token, %Token* %t26, i64 %t24
  %t30 = load %Token, %Token* %t29
  %t31 = call i1 @is_identifier_token(%Token %t30, i8* %name)
  %t32 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t33 = load double, double* %l1
  br i1 %t31, label %then6, label %merge7
then6:
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  %t37 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t36)
  store double %t37, double* %l2
  %t39 = load double, double* %l2
  %t40 = sitofp i64 -1 to double
  %t41 = fcmp une double %t39, %t40
  br label %logical_and_entry_38

logical_and_entry_38:
  br i1 %t41, label %logical_and_right_38, label %logical_and_merge_38

logical_and_right_38:
  %t42 = load double, double* %l2
  %t43 = call double @llvm.round.f64(double %t42)
  %t44 = fptosi double %t43 to i64
  %t45 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t46 = extractvalue { %Token*, i64 } %t45, 0
  %t47 = extractvalue { %Token*, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t44, i64 %t47)
  %t49 = getelementptr %Token, %Token* %t46, i64 %t44
  %t50 = load %Token, %Token* %t49
  %t51 = call i1 @is_symbol_token(%Token %t50, i8* %symbol)
  br label %logical_and_right_end_38

logical_and_right_end_38:
  br label %logical_and_merge_38

logical_and_merge_38:
  %t52 = phi i1 [ false, %logical_and_entry_38 ], [ %t51, %logical_and_right_end_38 ]
  %t53 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t54 = load double, double* %l1
  %t55 = load double, double* %l2
  br i1 %t52, label %then8, label %merge9
then8:
  %t56 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = call double @llvm.round.f64(double %t57)
  %t59 = fptosi double %t58 to i64
  %t60 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t61 = extractvalue { %Token*, i64 } %t60, 0
  %t62 = extractvalue { %Token*, i64 } %t60, 1
  %t63 = icmp uge i64 %t59, %t62
  ; bounds check: %t63 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t59, i64 %t62)
  %t64 = getelementptr %Token, %Token* %t61, i64 %t59
  %t65 = load %Token, %Token* %t64
  %t66 = getelementptr [1 x %Token], [1 x %Token]* null, i32 1
  %t67 = ptrtoint [1 x %Token]* %t66 to i64
  %t68 = icmp eq i64 %t67, 0
  %t69 = select i1 %t68, i64 1, i64 %t67
  %t70 = call i8* @malloc(i64 %t69)
  %t71 = bitcast i8* %t70 to %Token*
  %t72 = getelementptr %Token, %Token* %t71, i64 0
  store %Token %t65, %Token* %t72
  %t73 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t74 = ptrtoint { %Token*, i64 }* %t73 to i64
  %t75 = call i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to { %Token*, i64 }*
  %t77 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t76, i32 0, i32 0
  store %Token* %t71, %Token** %t77
  %t78 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t76, i32 0, i32 1
  store i64 1, i64* %t78
  %t79 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t56, i32 0, i32 0
  %t80 = load %Token*, %Token** %t79
  %t81 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t56, i32 0, i32 1
  %t82 = load i64, i64* %t81
  %t83 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t76, i32 0, i32 0
  %t84 = load %Token*, %Token** %t83
  %t85 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t76, i32 0, i32 1
  %t86 = load i64, i64* %t85
  %t87 = getelementptr [1 x %Token], [1 x %Token]* null, i32 0, i32 1
  %t88 = ptrtoint %Token* %t87 to i64
  %t89 = add i64 %t82, %t86
  %t90 = mul i64 %t88, %t89
  %t91 = call noalias i8* @malloc(i64 %t90)
  %t92 = bitcast i8* %t91 to %Token*
  %t93 = bitcast %Token* %t92 to i8*
  %t94 = mul i64 %t88, %t82
  %t95 = bitcast %Token* %t80 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t93, i8* %t95, i64 %t94)
  %t96 = mul i64 %t88, %t86
  %t97 = bitcast %Token* %t84 to i8*
  %t98 = getelementptr %Token, %Token* %t92, i64 %t82
  %t99 = bitcast %Token* %t98 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t99, i8* %t97, i64 %t96)
  %t100 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t101 = ptrtoint { %Token*, i64 }* %t100 to i64
  %t102 = call i8* @malloc(i64 %t101)
  %t103 = bitcast i8* %t102 to { %Token*, i64 }*
  %t104 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t103, i32 0, i32 0
  store %Token* %t92, %Token** %t104
  %t105 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t103, i32 0, i32 1
  store i64 %t89, i64* %t105
  store { %Token*, i64 }* %t103, { %Token*, i64 }** %l0
  %t106 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t107 = phi { %Token*, i64 }* [ %t106, %then8 ], [ %t53, %logical_and_merge_38 ]
  store { %Token*, i64 }* %t107, { %Token*, i64 }** %l0
  %t108 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t109 = phi { %Token*, i64 }* [ %t108, %merge9 ], [ %t32, %merge5 ]
  store { %Token*, i64 }* %t109, { %Token*, i64 }** %l0
  %t110 = load double, double* %l1
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l1
  br label %loop.latch2
loop.latch2:
  %t113 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t114 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t117 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t118 = load double, double* %l1
  %t119 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t119
}

define { %Token*, i64 }* @find_identifier_call({ %Token*, i64 }* %tokens, i8* %name) {
block.entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = getelementptr [0 x %Token], [0 x %Token]* null, i32 1
  %t1 = ptrtoint [0 x %Token]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %Token*
  %t6 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t7 = ptrtoint { %Token*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %Token*, i64 }*
  %t10 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 0
  store %Token* %t5, %Token** %t10
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %Token*, i64 }* %t9, { %Token*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t118 = phi { %Token*, i64 }* [ %t13, %block.entry ], [ %t116, %loop.latch2 ]
  %t119 = phi double [ %t14, %block.entry ], [ %t117, %loop.latch2 ]
  store { %Token*, i64 }* %t118, { %Token*, i64 }** %l0
  store double %t119, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t17 = extractvalue { %Token*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t26 = extractvalue { %Token*, i64 } %t25, 0
  %t27 = extractvalue { %Token*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %Token, %Token* %t26, i64 %t24
  %t30 = load %Token, %Token* %t29
  %t31 = call i1 @is_identifier_token(%Token %t30, i8* %name)
  %t32 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t33 = load double, double* %l1
  br i1 %t31, label %then6, label %merge7
then6:
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  %t37 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t36)
  store double %t37, double* %l2
  %t39 = load double, double* %l2
  %t40 = sitofp i64 -1 to double
  %t41 = fcmp une double %t39, %t40
  br label %logical_and_entry_38

logical_and_entry_38:
  br i1 %t41, label %logical_and_right_38, label %logical_and_merge_38

logical_and_right_38:
  %t42 = load double, double* %l2
  %t43 = call double @llvm.round.f64(double %t42)
  %t44 = fptosi double %t43 to i64
  %t45 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t46 = extractvalue { %Token*, i64 } %t45, 0
  %t47 = extractvalue { %Token*, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t44, i64 %t47)
  %t49 = getelementptr %Token, %Token* %t46, i64 %t44
  %t50 = load %Token, %Token* %t49
  %t51 = add i64 0, 2
  %t52 = call i8* @malloc(i64 %t51)
  store i8 40, i8* %t52
  %t53 = getelementptr i8, i8* %t52, i64 1
  store i8 0, i8* %t53
  call void @sailfin_runtime_mark_persistent(i8* %t52)
  %t54 = call i1 @is_symbol_token(%Token %t50, i8* %t52)
  br label %logical_and_right_end_38

logical_and_right_end_38:
  br label %logical_and_merge_38

logical_and_merge_38:
  %t55 = phi i1 [ false, %logical_and_entry_38 ], [ %t54, %logical_and_right_end_38 ]
  %t56 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = load double, double* %l2
  br i1 %t55, label %then8, label %merge9
then8:
  %t59 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t60 = load double, double* %l1
  %t61 = call double @llvm.round.f64(double %t60)
  %t62 = fptosi double %t61 to i64
  %t63 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t64 = extractvalue { %Token*, i64 } %t63, 0
  %t65 = extractvalue { %Token*, i64 } %t63, 1
  %t66 = icmp uge i64 %t62, %t65
  ; bounds check: %t66 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t62, i64 %t65)
  %t67 = getelementptr %Token, %Token* %t64, i64 %t62
  %t68 = load %Token, %Token* %t67
  %t69 = getelementptr [1 x %Token], [1 x %Token]* null, i32 1
  %t70 = ptrtoint [1 x %Token]* %t69 to i64
  %t71 = icmp eq i64 %t70, 0
  %t72 = select i1 %t71, i64 1, i64 %t70
  %t73 = call i8* @malloc(i64 %t72)
  %t74 = bitcast i8* %t73 to %Token*
  %t75 = getelementptr %Token, %Token* %t74, i64 0
  store %Token %t68, %Token* %t75
  %t76 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t77 = ptrtoint { %Token*, i64 }* %t76 to i64
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to { %Token*, i64 }*
  %t80 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t79, i32 0, i32 0
  store %Token* %t74, %Token** %t80
  %t81 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t79, i32 0, i32 1
  store i64 1, i64* %t81
  %t82 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t59, i32 0, i32 0
  %t83 = load %Token*, %Token** %t82
  %t84 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t59, i32 0, i32 1
  %t85 = load i64, i64* %t84
  %t86 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t79, i32 0, i32 0
  %t87 = load %Token*, %Token** %t86
  %t88 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t79, i32 0, i32 1
  %t89 = load i64, i64* %t88
  %t90 = getelementptr [1 x %Token], [1 x %Token]* null, i32 0, i32 1
  %t91 = ptrtoint %Token* %t90 to i64
  %t92 = add i64 %t85, %t89
  %t93 = mul i64 %t91, %t92
  %t94 = call noalias i8* @malloc(i64 %t93)
  %t95 = bitcast i8* %t94 to %Token*
  %t96 = bitcast %Token* %t95 to i8*
  %t97 = mul i64 %t91, %t85
  %t98 = bitcast %Token* %t83 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t96, i8* %t98, i64 %t97)
  %t99 = mul i64 %t91, %t89
  %t100 = bitcast %Token* %t87 to i8*
  %t101 = getelementptr %Token, %Token* %t95, i64 %t85
  %t102 = bitcast %Token* %t101 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t102, i8* %t100, i64 %t99)
  %t103 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t104 = ptrtoint { %Token*, i64 }* %t103 to i64
  %t105 = call i8* @malloc(i64 %t104)
  %t106 = bitcast i8* %t105 to { %Token*, i64 }*
  %t107 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t106, i32 0, i32 0
  store %Token* %t95, %Token** %t107
  %t108 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t106, i32 0, i32 1
  store i64 %t92, i64* %t108
  store { %Token*, i64 }* %t106, { %Token*, i64 }** %l0
  %t109 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t110 = phi { %Token*, i64 }* [ %t109, %then8 ], [ %t56, %logical_and_merge_38 ]
  store { %Token*, i64 }* %t110, { %Token*, i64 }** %l0
  %t111 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t112 = phi { %Token*, i64 }* [ %t111, %merge9 ], [ %t32, %merge5 ]
  store { %Token*, i64 }* %t112, { %Token*, i64 }** %l0
  %t113 = load double, double* %l1
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  store double %t115, double* %l1
  br label %loop.latch2
loop.latch2:
  %t116 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t117 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t120 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t121 = load double, double* %l1
  %t122 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t122
}

define double @next_non_trivia({ %Token*, i64 }* %tokens, double %start) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %Token
  store double %start, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t26 = phi double [ %t0, %block.entry ], [ %t25, %loop.latch2 ]
  store double %t26, double* %l0
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t3 = extractvalue { %Token*, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t1, %t4
  %t6 = load double, double* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = load double, double* %l0
  %t8 = call double @llvm.round.f64(double %t7)
  %t9 = fptosi double %t8 to i64
  %t10 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t11 = extractvalue { %Token*, i64 } %t10, 0
  %t12 = extractvalue { %Token*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr %Token, %Token* %t11, i64 %t9
  %t15 = load %Token, %Token* %t14
  store %Token %t15, %Token* %l1
  %t16 = load %Token, %Token* %l1
  %t17 = call i1 @is_trivia_token(%Token %t16)
  %t18 = xor i1 %t17, 1
  %t19 = load double, double* %l0
  %t20 = load %Token, %Token* %l1
  br i1 %t18, label %then6, label %merge7
then6:
  %t21 = load double, double* %l0
  ret double %t21
merge7:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l0
  br label %loop.latch2
loop.latch2:
  %t25 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 -1 to double
  ret double %t28
}

define i1 @is_trivia_token(%Token %token) {
block.entry:
  %t1 = extractvalue %Token %token, 0
  %t2 = extractvalue %TokenKind %t1, 0
  %t3 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t4 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t5 = icmp eq i32 %t2, 0
  %t6 = select i1 %t5, i8* %t4, i8* %t3
  %t7 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t8 = icmp eq i32 %t2, 1
  %t9 = select i1 %t8, i8* %t7, i8* %t6
  %t10 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t11 = icmp eq i32 %t2, 2
  %t12 = select i1 %t11, i8* %t10, i8* %t9
  %t13 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t2, 3
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t2, 4
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t2, 5
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t2, 6
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t2, 7
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = call i8* @malloc(i64 11)
  %t29 = bitcast i8* %t28 to [11 x i8]*
  store [11 x i8] c"Whitespace\00", [11 x i8]* %t29
  %t30 = call i1 @strings_equal(i8* %t27, i8* %t28)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t30, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t31 = extractvalue %Token %token, 0
  %t32 = extractvalue %TokenKind %t31, 0
  %t33 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t34 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t32, 0
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t32, 1
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t32, 2
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t32, 3
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t32, 4
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t32, 5
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t32, 6
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t32, 7
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = call i8* @malloc(i64 8)
  %t59 = bitcast i8* %t58 to [8 x i8]*
  store [8 x i8] c"Comment\00", [8 x i8]* %t59
  %t60 = call i1 @strings_equal(i8* %t57, i8* %t58)
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t61 = phi i1 [ true, %logical_or_entry_0 ], [ %t60, %logical_or_right_end_0 ]
  ret i1 %t61
}

define i1 @is_identifier_token(%Token %token, i8* %expected) {
block.entry:
  %t0 = extractvalue %Token %token, 1
  %t1 = call i1 @strings_equal(i8* %t0, i8* %expected)
  ret i1 %t1
}

define i1 @is_symbol_token(%Token %token, i8* %expected) {
block.entry:
  %t0 = extractvalue %Token %token, 1
  %t1 = call i1 @strings_equal(i8* %t0, i8* %expected)
  ret i1 %t1
}

define { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %violations, { %EffectViolation*, i64 }* %new_violations) {
block.entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  store { %EffectViolation*, i64 }* %violations, { %EffectViolation*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t65 = phi { %EffectViolation*, i64 }* [ %t1, %block.entry ], [ %t63, %loop.latch2 ]
  %t66 = phi double [ %t2, %block.entry ], [ %t64, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t65, { %EffectViolation*, i64 }** %l0
  store double %t66, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %new_violations
  %t5 = extractvalue { %EffectViolation*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = call double @llvm.round.f64(double %t11)
  %t13 = fptosi double %t12 to i64
  %t14 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %new_violations
  %t15 = extractvalue { %EffectViolation*, i64 } %t14, 0
  %t16 = extractvalue { %EffectViolation*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t13, i64 %t16)
  %t18 = getelementptr %EffectViolation, %EffectViolation* %t15, i64 %t13
  %t19 = load %EffectViolation, %EffectViolation* %t18
  %t20 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* null, i32 1
  %t21 = ptrtoint [1 x %EffectViolation]* %t20 to i64
  %t22 = icmp eq i64 %t21, 0
  %t23 = select i1 %t22, i64 1, i64 %t21
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to %EffectViolation*
  %t26 = getelementptr %EffectViolation, %EffectViolation* %t25, i64 0
  store %EffectViolation %t19, %EffectViolation* %t26
  %t27 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t28 = ptrtoint { %EffectViolation*, i64 }* %t27 to i64
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to { %EffectViolation*, i64 }*
  %t31 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t30, i32 0, i32 0
  store %EffectViolation* %t25, %EffectViolation** %t31
  %t32 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t30, i32 0, i32 1
  store i64 1, i64* %t32
  %t33 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t10, i32 0, i32 0
  %t34 = load %EffectViolation*, %EffectViolation** %t33
  %t35 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t10, i32 0, i32 1
  %t36 = load i64, i64* %t35
  %t37 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t30, i32 0, i32 0
  %t38 = load %EffectViolation*, %EffectViolation** %t37
  %t39 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t30, i32 0, i32 1
  %t40 = load i64, i64* %t39
  %t41 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* null, i32 0, i32 1
  %t42 = ptrtoint %EffectViolation* %t41 to i64
  %t43 = add i64 %t36, %t40
  %t44 = mul i64 %t42, %t43
  %t45 = call noalias i8* @malloc(i64 %t44)
  %t46 = bitcast i8* %t45 to %EffectViolation*
  %t47 = bitcast %EffectViolation* %t46 to i8*
  %t48 = mul i64 %t42, %t36
  %t49 = bitcast %EffectViolation* %t34 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t47, i8* %t49, i64 %t48)
  %t50 = mul i64 %t42, %t40
  %t51 = bitcast %EffectViolation* %t38 to i8*
  %t52 = getelementptr %EffectViolation, %EffectViolation* %t46, i64 %t36
  %t53 = bitcast %EffectViolation* %t52 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t53, i8* %t51, i64 %t50)
  %t54 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t55 = ptrtoint { %EffectViolation*, i64 }* %t54 to i64
  %t56 = call i8* @malloc(i64 %t55)
  %t57 = bitcast i8* %t56 to { %EffectViolation*, i64 }*
  %t58 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t57, i32 0, i32 0
  store %EffectViolation* %t46, %EffectViolation** %t58
  %t59 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t57, i32 0, i32 1
  store i64 %t43, i64* %t59
  store { %EffectViolation*, i64 }* %t57, { %EffectViolation*, i64 }** %l0
  %t60 = load double, double* %l1
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l1
  br label %loop.latch2
loop.latch2:
  %t63 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t64 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t67 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t68 = load double, double* %l1
  %t69 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t69
}

define { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %collection, %EffectViolation %item) {
block.entry:
  %t0 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* null, i32 1
  %t1 = ptrtoint [1 x %EffectViolation]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %EffectViolation*
  %t6 = getelementptr %EffectViolation, %EffectViolation* %t5, i64 0
  store %EffectViolation %item, %EffectViolation* %t6
  %t7 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t8 = ptrtoint { %EffectViolation*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %EffectViolation*, i64 }*
  %t11 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t10, i32 0, i32 0
  store %EffectViolation* %t5, %EffectViolation** %t11
  %t12 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %collection, i32 0, i32 0
  %t14 = load %EffectViolation*, %EffectViolation** %t13
  %t15 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %collection, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t10, i32 0, i32 0
  %t18 = load %EffectViolation*, %EffectViolation** %t17
  %t19 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* null, i32 0, i32 1
  %t22 = ptrtoint %EffectViolation* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %EffectViolation*
  %t27 = bitcast %EffectViolation* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %EffectViolation* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %EffectViolation* %t18 to i8*
  %t32 = getelementptr %EffectViolation, %EffectViolation* %t26, i64 %t16
  %t33 = bitcast %EffectViolation* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t35 = ptrtoint { %EffectViolation*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %EffectViolation*, i64 }*
  %t38 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t37, i32 0, i32 0
  store %EffectViolation* %t26, %EffectViolation** %t38
  %t39 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %EffectViolation*, i64 }* %t37
}

define { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %effects, i8* %effect) {
block.entry:
  %t0 = call i1 @contains_effect__effect_checker({ i8**, i64 }* %effects, i8* %effect)
  br i1 %t0, label %then0, label %merge1
then0:
  ret { i8**, i64 }* %effects
merge1:
  %t1 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t2 = ptrtoint [1 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr i8*, i8** %t6, i64 0
  store i8* %effect, i8** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t9 = ptrtoint { i8**, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { i8**, i64 }*
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 0
  store i8** %t6, i8*** %t12
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 1
  store i64 1, i64* %t13
  %t14 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %effects, { i8**, i64 }* %t11)
  ret { i8**, i64 }* %t14
}

define i1 @contains_effect__effect_checker({ i8**, i64 }* %effects, i8* %effect) {
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

define { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %collection, %EffectRequirement %item) {
block.entry:
  %t0 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* null, i32 1
  %t1 = ptrtoint [1 x %EffectRequirement]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %EffectRequirement*
  %t6 = getelementptr %EffectRequirement, %EffectRequirement* %t5, i64 0
  store %EffectRequirement %item, %EffectRequirement* %t6
  %t7 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t8 = ptrtoint { %EffectRequirement*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %EffectRequirement*, i64 }*
  %t11 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 0
  store %EffectRequirement* %t5, %EffectRequirement** %t11
  %t12 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %collection, i32 0, i32 0
  %t14 = load %EffectRequirement*, %EffectRequirement** %t13
  %t15 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %collection, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 0
  %t18 = load %EffectRequirement*, %EffectRequirement** %t17
  %t19 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* null, i32 0, i32 1
  %t22 = ptrtoint %EffectRequirement* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %EffectRequirement*
  %t27 = bitcast %EffectRequirement* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %EffectRequirement* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %EffectRequirement* %t18 to i8*
  %t32 = getelementptr %EffectRequirement, %EffectRequirement* %t26, i64 %t16
  %t33 = bitcast %EffectRequirement* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t35 = ptrtoint { %EffectRequirement*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %EffectRequirement*, i64 }*
  %t38 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t37, i32 0, i32 0
  store %EffectRequirement* %t26, %EffectRequirement** %t38
  %t39 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %EffectRequirement*, i64 }* %t37
}

define { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %base, { %EffectRequirement*, i64 }* %additions) {
block.entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  store { %EffectRequirement*, i64 }* %base, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t65 = phi { %EffectRequirement*, i64 }* [ %t1, %block.entry ], [ %t63, %loop.latch2 ]
  %t66 = phi double [ %t2, %block.entry ], [ %t64, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t65, { %EffectRequirement*, i64 }** %l0
  store double %t66, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %additions
  %t5 = extractvalue { %EffectRequirement*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = call double @llvm.round.f64(double %t11)
  %t13 = fptosi double %t12 to i64
  %t14 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %additions
  %t15 = extractvalue { %EffectRequirement*, i64 } %t14, 0
  %t16 = extractvalue { %EffectRequirement*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t13, i64 %t16)
  %t18 = getelementptr %EffectRequirement, %EffectRequirement* %t15, i64 %t13
  %t19 = load %EffectRequirement, %EffectRequirement* %t18
  %t20 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* null, i32 1
  %t21 = ptrtoint [1 x %EffectRequirement]* %t20 to i64
  %t22 = icmp eq i64 %t21, 0
  %t23 = select i1 %t22, i64 1, i64 %t21
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to %EffectRequirement*
  %t26 = getelementptr %EffectRequirement, %EffectRequirement* %t25, i64 0
  store %EffectRequirement %t19, %EffectRequirement* %t26
  %t27 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t28 = ptrtoint { %EffectRequirement*, i64 }* %t27 to i64
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to { %EffectRequirement*, i64 }*
  %t31 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t30, i32 0, i32 0
  store %EffectRequirement* %t25, %EffectRequirement** %t31
  %t32 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t30, i32 0, i32 1
  store i64 1, i64* %t32
  %t33 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 0
  %t34 = load %EffectRequirement*, %EffectRequirement** %t33
  %t35 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t10, i32 0, i32 1
  %t36 = load i64, i64* %t35
  %t37 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t30, i32 0, i32 0
  %t38 = load %EffectRequirement*, %EffectRequirement** %t37
  %t39 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t30, i32 0, i32 1
  %t40 = load i64, i64* %t39
  %t41 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* null, i32 0, i32 1
  %t42 = ptrtoint %EffectRequirement* %t41 to i64
  %t43 = add i64 %t36, %t40
  %t44 = mul i64 %t42, %t43
  %t45 = call noalias i8* @malloc(i64 %t44)
  %t46 = bitcast i8* %t45 to %EffectRequirement*
  %t47 = bitcast %EffectRequirement* %t46 to i8*
  %t48 = mul i64 %t42, %t36
  %t49 = bitcast %EffectRequirement* %t34 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t47, i8* %t49, i64 %t48)
  %t50 = mul i64 %t42, %t40
  %t51 = bitcast %EffectRequirement* %t38 to i8*
  %t52 = getelementptr %EffectRequirement, %EffectRequirement* %t46, i64 %t36
  %t53 = bitcast %EffectRequirement* %t52 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t53, i8* %t51, i64 %t50)
  %t54 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t55 = ptrtoint { %EffectRequirement*, i64 }* %t54 to i64
  %t56 = call i8* @malloc(i64 %t55)
  %t57 = bitcast i8* %t56 to { %EffectRequirement*, i64 }*
  %t58 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t57, i32 0, i32 0
  store %EffectRequirement* %t46, %EffectRequirement** %t58
  %t59 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t57, i32 0, i32 1
  store i64 %t43, i64* %t59
  store { %EffectRequirement*, i64 }* %t57, { %EffectRequirement*, i64 }** %l0
  %t60 = load double, double* %l1
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l1
  br label %loop.latch2
loop.latch2:
  %t63 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t64 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t67 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t68 = load double, double* %l1
  %t69 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t69
}

define i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
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
  %t3 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t4 = extractvalue { %EffectRequirement*, i64 } %t3, 1
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
  %t11 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t12 = extractvalue { %EffectRequirement*, i64 } %t11, 0
  %t13 = extractvalue { %EffectRequirement*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr %EffectRequirement, %EffectRequirement* %t12, i64 %t10
  %t16 = load %EffectRequirement, %EffectRequirement* %t15
  %t17 = extractvalue %EffectRequirement %t16, 0
  %t18 = call i1 @strings_equal(i8* %t17, i8* %effect)
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

define double @add__effect_checker(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}