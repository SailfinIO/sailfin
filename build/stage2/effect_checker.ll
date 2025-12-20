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

@runtime = external global i8**

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
  %t77 = bitcast [88 x i8]* %t76 to i8*
  %t78 = bitcast i8* %t77 to %FunctionSignature*
  %t79 = load %FunctionSignature, %FunctionSignature* %t78
  %t80 = icmp eq i32 %t74, 4
  %t81 = select i1 %t80, %FunctionSignature %t79, %FunctionSignature zeroinitializer
  %t82 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t83 = bitcast [88 x i8]* %t82 to i8*
  %t84 = bitcast i8* %t83 to %FunctionSignature*
  %t85 = load %FunctionSignature, %FunctionSignature* %t84
  %t86 = icmp eq i32 %t74, 5
  %t87 = select i1 %t86, %FunctionSignature %t85, %FunctionSignature %t81
  %t88 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t89 = bitcast [88 x i8]* %t88 to i8*
  %t90 = bitcast i8* %t89 to %FunctionSignature*
  %t91 = load %FunctionSignature, %FunctionSignature* %t90
  %t92 = icmp eq i32 %t74, 7
  %t93 = select i1 %t92, %FunctionSignature %t91, %FunctionSignature %t87
  %t94 = extractvalue %Statement %statement, 0
  %t95 = alloca %Statement
  store %Statement %statement, %Statement* %t95
  %t96 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t97 = bitcast [88 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 56
  %t99 = bitcast i8* %t98 to %Block*
  %t100 = load %Block, %Block* %t99
  %t101 = icmp eq i32 %t94, 4
  %t102 = select i1 %t101, %Block %t100, %Block zeroinitializer
  %t103 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t104 = bitcast [88 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 56
  %t106 = bitcast i8* %t105 to %Block*
  %t107 = load %Block, %Block* %t106
  %t108 = icmp eq i32 %t94, 5
  %t109 = select i1 %t108, %Block %t107, %Block %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t111 = bitcast [56 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 16
  %t113 = bitcast i8* %t112 to %Block*
  %t114 = load %Block, %Block* %t113
  %t115 = icmp eq i32 %t94, 6
  %t116 = select i1 %t115, %Block %t114, %Block %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t118 = bitcast [88 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 56
  %t120 = bitcast i8* %t119 to %Block*
  %t121 = load %Block, %Block* %t120
  %t122 = icmp eq i32 %t94, 7
  %t123 = select i1 %t122, %Block %t121, %Block %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t125 = bitcast [120 x i8]* %t124 to i8*
  %t126 = getelementptr inbounds i8, i8* %t125, i64 88
  %t127 = bitcast i8* %t126 to %Block*
  %t128 = load %Block, %Block* %t127
  %t129 = icmp eq i32 %t94, 12
  %t130 = select i1 %t129, %Block %t128, %Block %t123
  %t131 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t132 = bitcast [40 x i8]* %t131 to i8*
  %t133 = getelementptr inbounds i8, i8* %t132, i64 8
  %t134 = bitcast i8* %t133 to %Block*
  %t135 = load %Block, %Block* %t134
  %t136 = icmp eq i32 %t94, 13
  %t137 = select i1 %t136, %Block %t135, %Block %t130
  %t138 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t139 = bitcast [136 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 104
  %t141 = bitcast i8* %t140 to %Block*
  %t142 = load %Block, %Block* %t141
  %t143 = icmp eq i32 %t94, 14
  %t144 = select i1 %t143, %Block %t142, %Block %t137
  %t145 = getelementptr inbounds %Statement, %Statement* %t95, i32 0, i32 1
  %t146 = bitcast [32 x i8]* %t145 to i8*
  %t147 = bitcast i8* %t146 to %Block*
  %t148 = load %Block, %Block* %t147
  %t149 = icmp eq i32 %t94, 15
  %t150 = select i1 %t149, %Block %t148, %Block %t144
  %t151 = extractvalue %Statement %statement, 0
  %t152 = alloca %Statement
  store %Statement %statement, %Statement* %t152
  %t153 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t154 = bitcast [48 x i8]* %t153 to i8*
  %t155 = getelementptr inbounds i8, i8* %t154, i64 40
  %t156 = bitcast i8* %t155 to { %Decorator*, i64 }**
  %t157 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t156
  %t158 = icmp eq i32 %t151, 3
  %t159 = select i1 %t158, { %Decorator*, i64 }* %t157, { %Decorator*, i64 }* null
  %t160 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t161 = bitcast [88 x i8]* %t160 to i8*
  %t162 = getelementptr inbounds i8, i8* %t161, i64 80
  %t163 = bitcast i8* %t162 to { %Decorator*, i64 }**
  %t164 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t163
  %t165 = icmp eq i32 %t151, 4
  %t166 = select i1 %t165, { %Decorator*, i64 }* %t164, { %Decorator*, i64 }* %t159
  %t167 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t168 = bitcast [88 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 80
  %t170 = bitcast i8* %t169 to { %Decorator*, i64 }**
  %t171 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t170
  %t172 = icmp eq i32 %t151, 5
  %t173 = select i1 %t172, { %Decorator*, i64 }* %t171, { %Decorator*, i64 }* %t166
  %t174 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t175 = bitcast [56 x i8]* %t174 to i8*
  %t176 = getelementptr inbounds i8, i8* %t175, i64 48
  %t177 = bitcast i8* %t176 to { %Decorator*, i64 }**
  %t178 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t177
  %t179 = icmp eq i32 %t151, 6
  %t180 = select i1 %t179, { %Decorator*, i64 }* %t178, { %Decorator*, i64 }* %t173
  %t181 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t182 = bitcast [88 x i8]* %t181 to i8*
  %t183 = getelementptr inbounds i8, i8* %t182, i64 80
  %t184 = bitcast i8* %t183 to { %Decorator*, i64 }**
  %t185 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t184
  %t186 = icmp eq i32 %t151, 7
  %t187 = select i1 %t186, { %Decorator*, i64 }* %t185, { %Decorator*, i64 }* %t180
  %t188 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t189 = bitcast [56 x i8]* %t188 to i8*
  %t190 = getelementptr inbounds i8, i8* %t189, i64 48
  %t191 = bitcast i8* %t190 to { %Decorator*, i64 }**
  %t192 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t191
  %t193 = icmp eq i32 %t151, 8
  %t194 = select i1 %t193, { %Decorator*, i64 }* %t192, { %Decorator*, i64 }* %t187
  %t195 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t196 = bitcast [40 x i8]* %t195 to i8*
  %t197 = getelementptr inbounds i8, i8* %t196, i64 32
  %t198 = bitcast i8* %t197 to { %Decorator*, i64 }**
  %t199 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t198
  %t200 = icmp eq i32 %t151, 9
  %t201 = select i1 %t200, { %Decorator*, i64 }* %t199, { %Decorator*, i64 }* %t194
  %t202 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t203 = bitcast [40 x i8]* %t202 to i8*
  %t204 = getelementptr inbounds i8, i8* %t203, i64 32
  %t205 = bitcast i8* %t204 to { %Decorator*, i64 }**
  %t206 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t205
  %t207 = icmp eq i32 %t151, 10
  %t208 = select i1 %t207, { %Decorator*, i64 }* %t206, { %Decorator*, i64 }* %t201
  %t209 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t210 = bitcast [40 x i8]* %t209 to i8*
  %t211 = getelementptr inbounds i8, i8* %t210, i64 32
  %t212 = bitcast i8* %t211 to { %Decorator*, i64 }**
  %t213 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t212
  %t214 = icmp eq i32 %t151, 11
  %t215 = select i1 %t214, { %Decorator*, i64 }* %t213, { %Decorator*, i64 }* %t208
  %t216 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t217 = bitcast [120 x i8]* %t216 to i8*
  %t218 = getelementptr inbounds i8, i8* %t217, i64 112
  %t219 = bitcast i8* %t218 to { %Decorator*, i64 }**
  %t220 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t219
  %t221 = icmp eq i32 %t151, 12
  %t222 = select i1 %t221, { %Decorator*, i64 }* %t220, { %Decorator*, i64 }* %t215
  %t223 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t224 = bitcast [40 x i8]* %t223 to i8*
  %t225 = getelementptr inbounds i8, i8* %t224, i64 32
  %t226 = bitcast i8* %t225 to { %Decorator*, i64 }**
  %t227 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t226
  %t228 = icmp eq i32 %t151, 13
  %t229 = select i1 %t228, { %Decorator*, i64 }* %t227, { %Decorator*, i64 }* %t222
  %t230 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t231 = bitcast [136 x i8]* %t230 to i8*
  %t232 = getelementptr inbounds i8, i8* %t231, i64 128
  %t233 = bitcast i8* %t232 to { %Decorator*, i64 }**
  %t234 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t233
  %t235 = icmp eq i32 %t151, 14
  %t236 = select i1 %t235, { %Decorator*, i64 }* %t234, { %Decorator*, i64 }* %t229
  %t237 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t238 = bitcast [32 x i8]* %t237 to i8*
  %t239 = getelementptr inbounds i8, i8* %t238, i64 24
  %t240 = bitcast i8* %t239 to { %Decorator*, i64 }**
  %t241 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t240
  %t242 = icmp eq i32 %t151, 15
  %t243 = select i1 %t242, { %Decorator*, i64 }* %t241, { %Decorator*, i64 }* %t236
  %t244 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t245 = bitcast [64 x i8]* %t244 to i8*
  %t246 = getelementptr inbounds i8, i8* %t245, i64 56
  %t247 = bitcast i8* %t246 to { %Decorator*, i64 }**
  %t248 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t247
  %t249 = icmp eq i32 %t151, 18
  %t250 = select i1 %t249, { %Decorator*, i64 }* %t248, { %Decorator*, i64 }* %t243
  %t251 = getelementptr inbounds %Statement, %Statement* %t152, i32 0, i32 1
  %t252 = bitcast [88 x i8]* %t251 to i8*
  %t253 = getelementptr inbounds i8, i8* %t252, i64 80
  %t254 = bitcast i8* %t253 to { %Decorator*, i64 }**
  %t255 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t254
  %t256 = icmp eq i32 %t151, 19
  %t257 = select i1 %t256, { %Decorator*, i64 }* %t255, { %Decorator*, i64 }* %t250
  %t258 = extractvalue %Statement %statement, 0
  %t259 = alloca %Statement
  store %Statement %statement, %Statement* %t259
  %t260 = getelementptr inbounds %Statement, %Statement* %t259, i32 0, i32 1
  %t261 = bitcast [88 x i8]* %t260 to i8*
  %t262 = bitcast i8* %t261 to %FunctionSignature*
  %t263 = load %FunctionSignature, %FunctionSignature* %t262
  %t264 = icmp eq i32 %t258, 4
  %t265 = select i1 %t264, %FunctionSignature %t263, %FunctionSignature zeroinitializer
  %t266 = getelementptr inbounds %Statement, %Statement* %t259, i32 0, i32 1
  %t267 = bitcast [88 x i8]* %t266 to i8*
  %t268 = bitcast i8* %t267 to %FunctionSignature*
  %t269 = load %FunctionSignature, %FunctionSignature* %t268
  %t270 = icmp eq i32 %t258, 5
  %t271 = select i1 %t270, %FunctionSignature %t269, %FunctionSignature %t265
  %t272 = getelementptr inbounds %Statement, %Statement* %t259, i32 0, i32 1
  %t273 = bitcast [88 x i8]* %t272 to i8*
  %t274 = bitcast i8* %t273 to %FunctionSignature*
  %t275 = load %FunctionSignature, %FunctionSignature* %t274
  %t276 = icmp eq i32 %t258, 7
  %t277 = select i1 %t276, %FunctionSignature %t275, %FunctionSignature %t271
  %t278 = extractvalue %FunctionSignature %t277, 0
  %t279 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t93, %Block %t150, { %Decorator*, i64 }* %t257, i8* %t278)
  ret { %EffectViolation*, i64 }* %t279
merge1:
  %t280 = extractvalue %Statement %statement, 0
  %t281 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t282 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t280, 0
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t280, 1
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t280, 2
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t280, 3
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t280, 4
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t280, 5
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %t300 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t301 = icmp eq i32 %t280, 6
  %t302 = select i1 %t301, i8* %t300, i8* %t299
  %t303 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t304 = icmp eq i32 %t280, 7
  %t305 = select i1 %t304, i8* %t303, i8* %t302
  %t306 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t307 = icmp eq i32 %t280, 8
  %t308 = select i1 %t307, i8* %t306, i8* %t305
  %t309 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t310 = icmp eq i32 %t280, 9
  %t311 = select i1 %t310, i8* %t309, i8* %t308
  %t312 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t313 = icmp eq i32 %t280, 10
  %t314 = select i1 %t313, i8* %t312, i8* %t311
  %t315 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t280, 11
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t280, 12
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t280, 13
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t280, 14
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t280, 15
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t280, 16
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t280, 17
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t280, 18
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t280, 19
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t280, 20
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t280, 21
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t280, 22
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = call i8* @malloc(i64 20)
  %t352 = bitcast i8* %t351 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t352
  %t353 = call i1 @strings_equal(i8* %t350, i8* %t351)
  br i1 %t353, label %then2, label %merge3
then2:
  %t354 = extractvalue %Statement %statement, 0
  %t355 = alloca %Statement
  store %Statement %statement, %Statement* %t355
  %t356 = getelementptr inbounds %Statement, %Statement* %t355, i32 0, i32 1
  %t357 = bitcast [88 x i8]* %t356 to i8*
  %t358 = bitcast i8* %t357 to %FunctionSignature*
  %t359 = load %FunctionSignature, %FunctionSignature* %t358
  %t360 = icmp eq i32 %t354, 4
  %t361 = select i1 %t360, %FunctionSignature %t359, %FunctionSignature zeroinitializer
  %t362 = getelementptr inbounds %Statement, %Statement* %t355, i32 0, i32 1
  %t363 = bitcast [88 x i8]* %t362 to i8*
  %t364 = bitcast i8* %t363 to %FunctionSignature*
  %t365 = load %FunctionSignature, %FunctionSignature* %t364
  %t366 = icmp eq i32 %t354, 5
  %t367 = select i1 %t366, %FunctionSignature %t365, %FunctionSignature %t361
  %t368 = getelementptr inbounds %Statement, %Statement* %t355, i32 0, i32 1
  %t369 = bitcast [88 x i8]* %t368 to i8*
  %t370 = bitcast i8* %t369 to %FunctionSignature*
  %t371 = load %FunctionSignature, %FunctionSignature* %t370
  %t372 = icmp eq i32 %t354, 7
  %t373 = select i1 %t372, %FunctionSignature %t371, %FunctionSignature %t367
  store %FunctionSignature %t373, %FunctionSignature* %l0
  %t374 = call i8* @malloc(i64 10)
  %t375 = bitcast i8* %t374 to [10 x i8]*
  store [10 x i8] c"pipeline \00", [10 x i8]* %t375
  %t376 = load %FunctionSignature, %FunctionSignature* %l0
  %t377 = extractvalue %FunctionSignature %t376, 0
  %t378 = call i8* @sailfin_runtime_string_concat(i8* %t374, i8* %t377)
  store i8* %t378, i8** %l1
  %t379 = load %FunctionSignature, %FunctionSignature* %l0
  %t380 = extractvalue %Statement %statement, 0
  %t381 = alloca %Statement
  store %Statement %statement, %Statement* %t381
  %t382 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t383 = bitcast [88 x i8]* %t382 to i8*
  %t384 = getelementptr inbounds i8, i8* %t383, i64 56
  %t385 = bitcast i8* %t384 to %Block*
  %t386 = load %Block, %Block* %t385
  %t387 = icmp eq i32 %t380, 4
  %t388 = select i1 %t387, %Block %t386, %Block zeroinitializer
  %t389 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t390 = bitcast [88 x i8]* %t389 to i8*
  %t391 = getelementptr inbounds i8, i8* %t390, i64 56
  %t392 = bitcast i8* %t391 to %Block*
  %t393 = load %Block, %Block* %t392
  %t394 = icmp eq i32 %t380, 5
  %t395 = select i1 %t394, %Block %t393, %Block %t388
  %t396 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t397 = bitcast [56 x i8]* %t396 to i8*
  %t398 = getelementptr inbounds i8, i8* %t397, i64 16
  %t399 = bitcast i8* %t398 to %Block*
  %t400 = load %Block, %Block* %t399
  %t401 = icmp eq i32 %t380, 6
  %t402 = select i1 %t401, %Block %t400, %Block %t395
  %t403 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t404 = bitcast [88 x i8]* %t403 to i8*
  %t405 = getelementptr inbounds i8, i8* %t404, i64 56
  %t406 = bitcast i8* %t405 to %Block*
  %t407 = load %Block, %Block* %t406
  %t408 = icmp eq i32 %t380, 7
  %t409 = select i1 %t408, %Block %t407, %Block %t402
  %t410 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t411 = bitcast [120 x i8]* %t410 to i8*
  %t412 = getelementptr inbounds i8, i8* %t411, i64 88
  %t413 = bitcast i8* %t412 to %Block*
  %t414 = load %Block, %Block* %t413
  %t415 = icmp eq i32 %t380, 12
  %t416 = select i1 %t415, %Block %t414, %Block %t409
  %t417 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t418 = bitcast [40 x i8]* %t417 to i8*
  %t419 = getelementptr inbounds i8, i8* %t418, i64 8
  %t420 = bitcast i8* %t419 to %Block*
  %t421 = load %Block, %Block* %t420
  %t422 = icmp eq i32 %t380, 13
  %t423 = select i1 %t422, %Block %t421, %Block %t416
  %t424 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t425 = bitcast [136 x i8]* %t424 to i8*
  %t426 = getelementptr inbounds i8, i8* %t425, i64 104
  %t427 = bitcast i8* %t426 to %Block*
  %t428 = load %Block, %Block* %t427
  %t429 = icmp eq i32 %t380, 14
  %t430 = select i1 %t429, %Block %t428, %Block %t423
  %t431 = getelementptr inbounds %Statement, %Statement* %t381, i32 0, i32 1
  %t432 = bitcast [32 x i8]* %t431 to i8*
  %t433 = bitcast i8* %t432 to %Block*
  %t434 = load %Block, %Block* %t433
  %t435 = icmp eq i32 %t380, 15
  %t436 = select i1 %t435, %Block %t434, %Block %t430
  %t437 = extractvalue %Statement %statement, 0
  %t438 = alloca %Statement
  store %Statement %statement, %Statement* %t438
  %t439 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t440 = bitcast [48 x i8]* %t439 to i8*
  %t441 = getelementptr inbounds i8, i8* %t440, i64 40
  %t442 = bitcast i8* %t441 to { %Decorator*, i64 }**
  %t443 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t442
  %t444 = icmp eq i32 %t437, 3
  %t445 = select i1 %t444, { %Decorator*, i64 }* %t443, { %Decorator*, i64 }* null
  %t446 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t447 = bitcast [88 x i8]* %t446 to i8*
  %t448 = getelementptr inbounds i8, i8* %t447, i64 80
  %t449 = bitcast i8* %t448 to { %Decorator*, i64 }**
  %t450 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t449
  %t451 = icmp eq i32 %t437, 4
  %t452 = select i1 %t451, { %Decorator*, i64 }* %t450, { %Decorator*, i64 }* %t445
  %t453 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t454 = bitcast [88 x i8]* %t453 to i8*
  %t455 = getelementptr inbounds i8, i8* %t454, i64 80
  %t456 = bitcast i8* %t455 to { %Decorator*, i64 }**
  %t457 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t456
  %t458 = icmp eq i32 %t437, 5
  %t459 = select i1 %t458, { %Decorator*, i64 }* %t457, { %Decorator*, i64 }* %t452
  %t460 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t461 = bitcast [56 x i8]* %t460 to i8*
  %t462 = getelementptr inbounds i8, i8* %t461, i64 48
  %t463 = bitcast i8* %t462 to { %Decorator*, i64 }**
  %t464 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t463
  %t465 = icmp eq i32 %t437, 6
  %t466 = select i1 %t465, { %Decorator*, i64 }* %t464, { %Decorator*, i64 }* %t459
  %t467 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t468 = bitcast [88 x i8]* %t467 to i8*
  %t469 = getelementptr inbounds i8, i8* %t468, i64 80
  %t470 = bitcast i8* %t469 to { %Decorator*, i64 }**
  %t471 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t470
  %t472 = icmp eq i32 %t437, 7
  %t473 = select i1 %t472, { %Decorator*, i64 }* %t471, { %Decorator*, i64 }* %t466
  %t474 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t475 = bitcast [56 x i8]* %t474 to i8*
  %t476 = getelementptr inbounds i8, i8* %t475, i64 48
  %t477 = bitcast i8* %t476 to { %Decorator*, i64 }**
  %t478 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t477
  %t479 = icmp eq i32 %t437, 8
  %t480 = select i1 %t479, { %Decorator*, i64 }* %t478, { %Decorator*, i64 }* %t473
  %t481 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t482 = bitcast [40 x i8]* %t481 to i8*
  %t483 = getelementptr inbounds i8, i8* %t482, i64 32
  %t484 = bitcast i8* %t483 to { %Decorator*, i64 }**
  %t485 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t484
  %t486 = icmp eq i32 %t437, 9
  %t487 = select i1 %t486, { %Decorator*, i64 }* %t485, { %Decorator*, i64 }* %t480
  %t488 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t489 = bitcast [40 x i8]* %t488 to i8*
  %t490 = getelementptr inbounds i8, i8* %t489, i64 32
  %t491 = bitcast i8* %t490 to { %Decorator*, i64 }**
  %t492 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t491
  %t493 = icmp eq i32 %t437, 10
  %t494 = select i1 %t493, { %Decorator*, i64 }* %t492, { %Decorator*, i64 }* %t487
  %t495 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t496 = bitcast [40 x i8]* %t495 to i8*
  %t497 = getelementptr inbounds i8, i8* %t496, i64 32
  %t498 = bitcast i8* %t497 to { %Decorator*, i64 }**
  %t499 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t498
  %t500 = icmp eq i32 %t437, 11
  %t501 = select i1 %t500, { %Decorator*, i64 }* %t499, { %Decorator*, i64 }* %t494
  %t502 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t503 = bitcast [120 x i8]* %t502 to i8*
  %t504 = getelementptr inbounds i8, i8* %t503, i64 112
  %t505 = bitcast i8* %t504 to { %Decorator*, i64 }**
  %t506 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t505
  %t507 = icmp eq i32 %t437, 12
  %t508 = select i1 %t507, { %Decorator*, i64 }* %t506, { %Decorator*, i64 }* %t501
  %t509 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t510 = bitcast [40 x i8]* %t509 to i8*
  %t511 = getelementptr inbounds i8, i8* %t510, i64 32
  %t512 = bitcast i8* %t511 to { %Decorator*, i64 }**
  %t513 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t512
  %t514 = icmp eq i32 %t437, 13
  %t515 = select i1 %t514, { %Decorator*, i64 }* %t513, { %Decorator*, i64 }* %t508
  %t516 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t517 = bitcast [136 x i8]* %t516 to i8*
  %t518 = getelementptr inbounds i8, i8* %t517, i64 128
  %t519 = bitcast i8* %t518 to { %Decorator*, i64 }**
  %t520 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t519
  %t521 = icmp eq i32 %t437, 14
  %t522 = select i1 %t521, { %Decorator*, i64 }* %t520, { %Decorator*, i64 }* %t515
  %t523 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t524 = bitcast [32 x i8]* %t523 to i8*
  %t525 = getelementptr inbounds i8, i8* %t524, i64 24
  %t526 = bitcast i8* %t525 to { %Decorator*, i64 }**
  %t527 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t526
  %t528 = icmp eq i32 %t437, 15
  %t529 = select i1 %t528, { %Decorator*, i64 }* %t527, { %Decorator*, i64 }* %t522
  %t530 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t531 = bitcast [64 x i8]* %t530 to i8*
  %t532 = getelementptr inbounds i8, i8* %t531, i64 56
  %t533 = bitcast i8* %t532 to { %Decorator*, i64 }**
  %t534 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t533
  %t535 = icmp eq i32 %t437, 18
  %t536 = select i1 %t535, { %Decorator*, i64 }* %t534, { %Decorator*, i64 }* %t529
  %t537 = getelementptr inbounds %Statement, %Statement* %t438, i32 0, i32 1
  %t538 = bitcast [88 x i8]* %t537 to i8*
  %t539 = getelementptr inbounds i8, i8* %t538, i64 80
  %t540 = bitcast i8* %t539 to { %Decorator*, i64 }**
  %t541 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t540
  %t542 = icmp eq i32 %t437, 19
  %t543 = select i1 %t542, { %Decorator*, i64 }* %t541, { %Decorator*, i64 }* %t536
  %t544 = load i8*, i8** %l1
  %t545 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t379, %Block %t436, { %Decorator*, i64 }* %t543, i8* %t544)
  ret { %EffectViolation*, i64 }* %t545
merge3:
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
  %t608 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t546, 20
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t546, 21
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t546, 22
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = call i8* @malloc(i64 16)
  %t618 = bitcast i8* %t617 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t618
  %t619 = call i1 @strings_equal(i8* %t616, i8* %t617)
  br i1 %t619, label %then4, label %merge5
then4:
  %t620 = extractvalue %Statement %statement, 0
  %t621 = alloca %Statement
  store %Statement %statement, %Statement* %t621
  %t622 = getelementptr inbounds %Statement, %Statement* %t621, i32 0, i32 1
  %t623 = bitcast [88 x i8]* %t622 to i8*
  %t624 = bitcast i8* %t623 to %FunctionSignature*
  %t625 = load %FunctionSignature, %FunctionSignature* %t624
  %t626 = icmp eq i32 %t620, 4
  %t627 = select i1 %t626, %FunctionSignature %t625, %FunctionSignature zeroinitializer
  %t628 = getelementptr inbounds %Statement, %Statement* %t621, i32 0, i32 1
  %t629 = bitcast [88 x i8]* %t628 to i8*
  %t630 = bitcast i8* %t629 to %FunctionSignature*
  %t631 = load %FunctionSignature, %FunctionSignature* %t630
  %t632 = icmp eq i32 %t620, 5
  %t633 = select i1 %t632, %FunctionSignature %t631, %FunctionSignature %t627
  %t634 = getelementptr inbounds %Statement, %Statement* %t621, i32 0, i32 1
  %t635 = bitcast [88 x i8]* %t634 to i8*
  %t636 = bitcast i8* %t635 to %FunctionSignature*
  %t637 = load %FunctionSignature, %FunctionSignature* %t636
  %t638 = icmp eq i32 %t620, 7
  %t639 = select i1 %t638, %FunctionSignature %t637, %FunctionSignature %t633
  store %FunctionSignature %t639, %FunctionSignature* %l2
  %t640 = call i8* @malloc(i64 6)
  %t641 = bitcast i8* %t640 to [6 x i8]*
  store [6 x i8] c"tool \00", [6 x i8]* %t641
  %t642 = load %FunctionSignature, %FunctionSignature* %l2
  %t643 = extractvalue %FunctionSignature %t642, 0
  %t644 = call i8* @sailfin_runtime_string_concat(i8* %t640, i8* %t643)
  store i8* %t644, i8** %l3
  %t645 = load %FunctionSignature, %FunctionSignature* %l2
  %t646 = extractvalue %Statement %statement, 0
  %t647 = alloca %Statement
  store %Statement %statement, %Statement* %t647
  %t648 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t649 = bitcast [88 x i8]* %t648 to i8*
  %t650 = getelementptr inbounds i8, i8* %t649, i64 56
  %t651 = bitcast i8* %t650 to %Block*
  %t652 = load %Block, %Block* %t651
  %t653 = icmp eq i32 %t646, 4
  %t654 = select i1 %t653, %Block %t652, %Block zeroinitializer
  %t655 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t656 = bitcast [88 x i8]* %t655 to i8*
  %t657 = getelementptr inbounds i8, i8* %t656, i64 56
  %t658 = bitcast i8* %t657 to %Block*
  %t659 = load %Block, %Block* %t658
  %t660 = icmp eq i32 %t646, 5
  %t661 = select i1 %t660, %Block %t659, %Block %t654
  %t662 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t663 = bitcast [56 x i8]* %t662 to i8*
  %t664 = getelementptr inbounds i8, i8* %t663, i64 16
  %t665 = bitcast i8* %t664 to %Block*
  %t666 = load %Block, %Block* %t665
  %t667 = icmp eq i32 %t646, 6
  %t668 = select i1 %t667, %Block %t666, %Block %t661
  %t669 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t670 = bitcast [88 x i8]* %t669 to i8*
  %t671 = getelementptr inbounds i8, i8* %t670, i64 56
  %t672 = bitcast i8* %t671 to %Block*
  %t673 = load %Block, %Block* %t672
  %t674 = icmp eq i32 %t646, 7
  %t675 = select i1 %t674, %Block %t673, %Block %t668
  %t676 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t677 = bitcast [120 x i8]* %t676 to i8*
  %t678 = getelementptr inbounds i8, i8* %t677, i64 88
  %t679 = bitcast i8* %t678 to %Block*
  %t680 = load %Block, %Block* %t679
  %t681 = icmp eq i32 %t646, 12
  %t682 = select i1 %t681, %Block %t680, %Block %t675
  %t683 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t684 = bitcast [40 x i8]* %t683 to i8*
  %t685 = getelementptr inbounds i8, i8* %t684, i64 8
  %t686 = bitcast i8* %t685 to %Block*
  %t687 = load %Block, %Block* %t686
  %t688 = icmp eq i32 %t646, 13
  %t689 = select i1 %t688, %Block %t687, %Block %t682
  %t690 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t691 = bitcast [136 x i8]* %t690 to i8*
  %t692 = getelementptr inbounds i8, i8* %t691, i64 104
  %t693 = bitcast i8* %t692 to %Block*
  %t694 = load %Block, %Block* %t693
  %t695 = icmp eq i32 %t646, 14
  %t696 = select i1 %t695, %Block %t694, %Block %t689
  %t697 = getelementptr inbounds %Statement, %Statement* %t647, i32 0, i32 1
  %t698 = bitcast [32 x i8]* %t697 to i8*
  %t699 = bitcast i8* %t698 to %Block*
  %t700 = load %Block, %Block* %t699
  %t701 = icmp eq i32 %t646, 15
  %t702 = select i1 %t701, %Block %t700, %Block %t696
  %t703 = extractvalue %Statement %statement, 0
  %t704 = alloca %Statement
  store %Statement %statement, %Statement* %t704
  %t705 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t706 = bitcast [48 x i8]* %t705 to i8*
  %t707 = getelementptr inbounds i8, i8* %t706, i64 40
  %t708 = bitcast i8* %t707 to { %Decorator*, i64 }**
  %t709 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t708
  %t710 = icmp eq i32 %t703, 3
  %t711 = select i1 %t710, { %Decorator*, i64 }* %t709, { %Decorator*, i64 }* null
  %t712 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t713 = bitcast [88 x i8]* %t712 to i8*
  %t714 = getelementptr inbounds i8, i8* %t713, i64 80
  %t715 = bitcast i8* %t714 to { %Decorator*, i64 }**
  %t716 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t715
  %t717 = icmp eq i32 %t703, 4
  %t718 = select i1 %t717, { %Decorator*, i64 }* %t716, { %Decorator*, i64 }* %t711
  %t719 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t720 = bitcast [88 x i8]* %t719 to i8*
  %t721 = getelementptr inbounds i8, i8* %t720, i64 80
  %t722 = bitcast i8* %t721 to { %Decorator*, i64 }**
  %t723 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t722
  %t724 = icmp eq i32 %t703, 5
  %t725 = select i1 %t724, { %Decorator*, i64 }* %t723, { %Decorator*, i64 }* %t718
  %t726 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t727 = bitcast [56 x i8]* %t726 to i8*
  %t728 = getelementptr inbounds i8, i8* %t727, i64 48
  %t729 = bitcast i8* %t728 to { %Decorator*, i64 }**
  %t730 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t729
  %t731 = icmp eq i32 %t703, 6
  %t732 = select i1 %t731, { %Decorator*, i64 }* %t730, { %Decorator*, i64 }* %t725
  %t733 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t734 = bitcast [88 x i8]* %t733 to i8*
  %t735 = getelementptr inbounds i8, i8* %t734, i64 80
  %t736 = bitcast i8* %t735 to { %Decorator*, i64 }**
  %t737 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t736
  %t738 = icmp eq i32 %t703, 7
  %t739 = select i1 %t738, { %Decorator*, i64 }* %t737, { %Decorator*, i64 }* %t732
  %t740 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t741 = bitcast [56 x i8]* %t740 to i8*
  %t742 = getelementptr inbounds i8, i8* %t741, i64 48
  %t743 = bitcast i8* %t742 to { %Decorator*, i64 }**
  %t744 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t743
  %t745 = icmp eq i32 %t703, 8
  %t746 = select i1 %t745, { %Decorator*, i64 }* %t744, { %Decorator*, i64 }* %t739
  %t747 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t748 = bitcast [40 x i8]* %t747 to i8*
  %t749 = getelementptr inbounds i8, i8* %t748, i64 32
  %t750 = bitcast i8* %t749 to { %Decorator*, i64 }**
  %t751 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t750
  %t752 = icmp eq i32 %t703, 9
  %t753 = select i1 %t752, { %Decorator*, i64 }* %t751, { %Decorator*, i64 }* %t746
  %t754 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t755 = bitcast [40 x i8]* %t754 to i8*
  %t756 = getelementptr inbounds i8, i8* %t755, i64 32
  %t757 = bitcast i8* %t756 to { %Decorator*, i64 }**
  %t758 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t757
  %t759 = icmp eq i32 %t703, 10
  %t760 = select i1 %t759, { %Decorator*, i64 }* %t758, { %Decorator*, i64 }* %t753
  %t761 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t762 = bitcast [40 x i8]* %t761 to i8*
  %t763 = getelementptr inbounds i8, i8* %t762, i64 32
  %t764 = bitcast i8* %t763 to { %Decorator*, i64 }**
  %t765 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t764
  %t766 = icmp eq i32 %t703, 11
  %t767 = select i1 %t766, { %Decorator*, i64 }* %t765, { %Decorator*, i64 }* %t760
  %t768 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t769 = bitcast [120 x i8]* %t768 to i8*
  %t770 = getelementptr inbounds i8, i8* %t769, i64 112
  %t771 = bitcast i8* %t770 to { %Decorator*, i64 }**
  %t772 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t771
  %t773 = icmp eq i32 %t703, 12
  %t774 = select i1 %t773, { %Decorator*, i64 }* %t772, { %Decorator*, i64 }* %t767
  %t775 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t776 = bitcast [40 x i8]* %t775 to i8*
  %t777 = getelementptr inbounds i8, i8* %t776, i64 32
  %t778 = bitcast i8* %t777 to { %Decorator*, i64 }**
  %t779 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t778
  %t780 = icmp eq i32 %t703, 13
  %t781 = select i1 %t780, { %Decorator*, i64 }* %t779, { %Decorator*, i64 }* %t774
  %t782 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t783 = bitcast [136 x i8]* %t782 to i8*
  %t784 = getelementptr inbounds i8, i8* %t783, i64 128
  %t785 = bitcast i8* %t784 to { %Decorator*, i64 }**
  %t786 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t785
  %t787 = icmp eq i32 %t703, 14
  %t788 = select i1 %t787, { %Decorator*, i64 }* %t786, { %Decorator*, i64 }* %t781
  %t789 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t790 = bitcast [32 x i8]* %t789 to i8*
  %t791 = getelementptr inbounds i8, i8* %t790, i64 24
  %t792 = bitcast i8* %t791 to { %Decorator*, i64 }**
  %t793 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t792
  %t794 = icmp eq i32 %t703, 15
  %t795 = select i1 %t794, { %Decorator*, i64 }* %t793, { %Decorator*, i64 }* %t788
  %t796 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t797 = bitcast [64 x i8]* %t796 to i8*
  %t798 = getelementptr inbounds i8, i8* %t797, i64 56
  %t799 = bitcast i8* %t798 to { %Decorator*, i64 }**
  %t800 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t799
  %t801 = icmp eq i32 %t703, 18
  %t802 = select i1 %t801, { %Decorator*, i64 }* %t800, { %Decorator*, i64 }* %t795
  %t803 = getelementptr inbounds %Statement, %Statement* %t704, i32 0, i32 1
  %t804 = bitcast [88 x i8]* %t803 to i8*
  %t805 = getelementptr inbounds i8, i8* %t804, i64 80
  %t806 = bitcast i8* %t805 to { %Decorator*, i64 }**
  %t807 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t806
  %t808 = icmp eq i32 %t703, 19
  %t809 = select i1 %t808, { %Decorator*, i64 }* %t807, { %Decorator*, i64 }* %t802
  %t810 = load i8*, i8** %l3
  %t811 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t645, %Block %t702, { %Decorator*, i64 }* %t809, i8* %t810)
  ret { %EffectViolation*, i64 }* %t811
merge5:
  %t812 = extractvalue %Statement %statement, 0
  %t813 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t814 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t812, 0
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t812, 1
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t812, 2
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t812, 3
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t812, 4
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t812, 5
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t812, 6
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t812, 7
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t812, 8
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t812, 9
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t812, 10
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t812, 11
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t812, 12
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t812, 13
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t812, 14
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t812, 15
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t812, 16
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t812, 17
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t812, 18
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t812, 19
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t812, 20
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t812, 21
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t812, 22
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = call i8* @malloc(i64 16)
  %t884 = bitcast i8* %t883 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t884
  %t885 = call i1 @strings_equal(i8* %t882, i8* %t883)
  br i1 %t885, label %then6, label %merge7
then6:
  %t886 = extractvalue %Statement %statement, 0
  %t887 = alloca %Statement
  store %Statement %statement, %Statement* %t887
  %t888 = getelementptr inbounds %Statement, %Statement* %t887, i32 0, i32 1
  %t889 = bitcast [48 x i8]* %t888 to i8*
  %t890 = bitcast i8* %t889 to i8**
  %t891 = load i8*, i8** %t890
  %t892 = icmp eq i32 %t886, 2
  %t893 = select i1 %t892, i8* %t891, i8* null
  %t894 = getelementptr inbounds %Statement, %Statement* %t887, i32 0, i32 1
  %t895 = bitcast [48 x i8]* %t894 to i8*
  %t896 = bitcast i8* %t895 to i8**
  %t897 = load i8*, i8** %t896
  %t898 = icmp eq i32 %t886, 3
  %t899 = select i1 %t898, i8* %t897, i8* %t893
  %t900 = getelementptr inbounds %Statement, %Statement* %t887, i32 0, i32 1
  %t901 = bitcast [56 x i8]* %t900 to i8*
  %t902 = bitcast i8* %t901 to i8**
  %t903 = load i8*, i8** %t902
  %t904 = icmp eq i32 %t886, 6
  %t905 = select i1 %t904, i8* %t903, i8* %t899
  %t906 = getelementptr inbounds %Statement, %Statement* %t887, i32 0, i32 1
  %t907 = bitcast [56 x i8]* %t906 to i8*
  %t908 = bitcast i8* %t907 to i8**
  %t909 = load i8*, i8** %t908
  %t910 = icmp eq i32 %t886, 8
  %t911 = select i1 %t910, i8* %t909, i8* %t905
  %t912 = getelementptr inbounds %Statement, %Statement* %t887, i32 0, i32 1
  %t913 = bitcast [40 x i8]* %t912 to i8*
  %t914 = bitcast i8* %t913 to i8**
  %t915 = load i8*, i8** %t914
  %t916 = icmp eq i32 %t886, 9
  %t917 = select i1 %t916, i8* %t915, i8* %t911
  %t918 = getelementptr inbounds %Statement, %Statement* %t887, i32 0, i32 1
  %t919 = bitcast [40 x i8]* %t918 to i8*
  %t920 = bitcast i8* %t919 to i8**
  %t921 = load i8*, i8** %t920
  %t922 = icmp eq i32 %t886, 10
  %t923 = select i1 %t922, i8* %t921, i8* %t917
  %t924 = getelementptr inbounds %Statement, %Statement* %t887, i32 0, i32 1
  %t925 = bitcast [40 x i8]* %t924 to i8*
  %t926 = bitcast i8* %t925 to i8**
  %t927 = load i8*, i8** %t926
  %t928 = icmp eq i32 %t886, 11
  %t929 = select i1 %t928, i8* %t927, i8* %t923
  %t930 = insertvalue %FunctionSignature undef, i8* %t929, 0
  %t931 = insertvalue %FunctionSignature %t930, i1 0, 1
  %t932 = getelementptr [0 x %Parameter], [0 x %Parameter]* null, i32 1
  %t933 = ptrtoint [0 x %Parameter]* %t932 to i64
  %t934 = icmp eq i64 %t933, 0
  %t935 = select i1 %t934, i64 1, i64 %t933
  %t936 = call i8* @malloc(i64 %t935)
  %t937 = bitcast i8* %t936 to %Parameter*
  %t938 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* null, i32 1
  %t939 = ptrtoint { %Parameter*, i64 }* %t938 to i64
  %t940 = call i8* @malloc(i64 %t939)
  %t941 = bitcast i8* %t940 to { %Parameter*, i64 }*
  %t942 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t941, i32 0, i32 0
  store %Parameter* %t937, %Parameter** %t942
  %t943 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t941, i32 0, i32 1
  store i64 0, i64* %t943
  %t944 = insertvalue %FunctionSignature %t931, { %Parameter*, i64 }* %t941, 2
  %t945 = bitcast i8* null to %TypeAnnotation*
  %t946 = insertvalue %FunctionSignature %t944, %TypeAnnotation* %t945, 3
  %t947 = extractvalue %Statement %statement, 0
  %t948 = alloca %Statement
  store %Statement %statement, %Statement* %t948
  %t949 = getelementptr inbounds %Statement, %Statement* %t948, i32 0, i32 1
  %t950 = bitcast [48 x i8]* %t949 to i8*
  %t951 = getelementptr inbounds i8, i8* %t950, i64 32
  %t952 = bitcast i8* %t951 to { i8**, i64 }**
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %t952
  %t954 = icmp eq i32 %t947, 3
  %t955 = select i1 %t954, { i8**, i64 }* %t953, { i8**, i64 }* null
  %t956 = getelementptr inbounds %Statement, %Statement* %t948, i32 0, i32 1
  %t957 = bitcast [56 x i8]* %t956 to i8*
  %t958 = getelementptr inbounds i8, i8* %t957, i64 40
  %t959 = bitcast i8* %t958 to { i8**, i64 }**
  %t960 = load { i8**, i64 }*, { i8**, i64 }** %t959
  %t961 = icmp eq i32 %t947, 6
  %t962 = select i1 %t961, { i8**, i64 }* %t960, { i8**, i64 }* %t955
  %t963 = insertvalue %FunctionSignature %t946, { i8**, i64 }* %t962, 4
  %t964 = getelementptr [0 x %TypeParameter], [0 x %TypeParameter]* null, i32 1
  %t965 = ptrtoint [0 x %TypeParameter]* %t964 to i64
  %t966 = icmp eq i64 %t965, 0
  %t967 = select i1 %t966, i64 1, i64 %t965
  %t968 = call i8* @malloc(i64 %t967)
  %t969 = bitcast i8* %t968 to %TypeParameter*
  %t970 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* null, i32 1
  %t971 = ptrtoint { %TypeParameter*, i64 }* %t970 to i64
  %t972 = call i8* @malloc(i64 %t971)
  %t973 = bitcast i8* %t972 to { %TypeParameter*, i64 }*
  %t974 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t973, i32 0, i32 0
  store %TypeParameter* %t969, %TypeParameter** %t974
  %t975 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t973, i32 0, i32 1
  store i64 0, i64* %t975
  %t976 = insertvalue %FunctionSignature %t963, { %TypeParameter*, i64 }* %t973, 5
  %t977 = bitcast i8* null to %SourceSpan*
  %t978 = insertvalue %FunctionSignature %t976, %SourceSpan* %t977, 6
  store %FunctionSignature %t978, %FunctionSignature* %l4
  %t979 = call i8* @malloc(i64 6)
  %t980 = bitcast i8* %t979 to [6 x i8]*
  store [6 x i8] c"test \00", [6 x i8]* %t980
  %t981 = extractvalue %Statement %statement, 0
  %t982 = alloca %Statement
  store %Statement %statement, %Statement* %t982
  %t983 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t984 = bitcast [48 x i8]* %t983 to i8*
  %t985 = bitcast i8* %t984 to i8**
  %t986 = load i8*, i8** %t985
  %t987 = icmp eq i32 %t981, 2
  %t988 = select i1 %t987, i8* %t986, i8* null
  %t989 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t990 = bitcast [48 x i8]* %t989 to i8*
  %t991 = bitcast i8* %t990 to i8**
  %t992 = load i8*, i8** %t991
  %t993 = icmp eq i32 %t981, 3
  %t994 = select i1 %t993, i8* %t992, i8* %t988
  %t995 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t996 = bitcast [56 x i8]* %t995 to i8*
  %t997 = bitcast i8* %t996 to i8**
  %t998 = load i8*, i8** %t997
  %t999 = icmp eq i32 %t981, 6
  %t1000 = select i1 %t999, i8* %t998, i8* %t994
  %t1001 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t1002 = bitcast [56 x i8]* %t1001 to i8*
  %t1003 = bitcast i8* %t1002 to i8**
  %t1004 = load i8*, i8** %t1003
  %t1005 = icmp eq i32 %t981, 8
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1000
  %t1007 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t1008 = bitcast [40 x i8]* %t1007 to i8*
  %t1009 = bitcast i8* %t1008 to i8**
  %t1010 = load i8*, i8** %t1009
  %t1011 = icmp eq i32 %t981, 9
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1006
  %t1013 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t1014 = bitcast [40 x i8]* %t1013 to i8*
  %t1015 = bitcast i8* %t1014 to i8**
  %t1016 = load i8*, i8** %t1015
  %t1017 = icmp eq i32 %t981, 10
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1012
  %t1019 = getelementptr inbounds %Statement, %Statement* %t982, i32 0, i32 1
  %t1020 = bitcast [40 x i8]* %t1019 to i8*
  %t1021 = bitcast i8* %t1020 to i8**
  %t1022 = load i8*, i8** %t1021
  %t1023 = icmp eq i32 %t981, 11
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1018
  %t1025 = call i8* @sailfin_runtime_string_concat(i8* %t979, i8* %t1024)
  store i8* %t1025, i8** %l5
  %t1026 = load %FunctionSignature, %FunctionSignature* %l4
  %t1027 = extractvalue %Statement %statement, 0
  %t1028 = alloca %Statement
  store %Statement %statement, %Statement* %t1028
  %t1029 = getelementptr inbounds %Statement, %Statement* %t1028, i32 0, i32 1
  %t1030 = bitcast [88 x i8]* %t1029 to i8*
  %t1031 = getelementptr inbounds i8, i8* %t1030, i64 56
  %t1032 = bitcast i8* %t1031 to %Block*
  %t1033 = load %Block, %Block* %t1032
  %t1034 = icmp eq i32 %t1027, 4
  %t1035 = select i1 %t1034, %Block %t1033, %Block zeroinitializer
  %t1036 = getelementptr inbounds %Statement, %Statement* %t1028, i32 0, i32 1
  %t1037 = bitcast [88 x i8]* %t1036 to i8*
  %t1038 = getelementptr inbounds i8, i8* %t1037, i64 56
  %t1039 = bitcast i8* %t1038 to %Block*
  %t1040 = load %Block, %Block* %t1039
  %t1041 = icmp eq i32 %t1027, 5
  %t1042 = select i1 %t1041, %Block %t1040, %Block %t1035
  %t1043 = getelementptr inbounds %Statement, %Statement* %t1028, i32 0, i32 1
  %t1044 = bitcast [56 x i8]* %t1043 to i8*
  %t1045 = getelementptr inbounds i8, i8* %t1044, i64 16
  %t1046 = bitcast i8* %t1045 to %Block*
  %t1047 = load %Block, %Block* %t1046
  %t1048 = icmp eq i32 %t1027, 6
  %t1049 = select i1 %t1048, %Block %t1047, %Block %t1042
  %t1050 = getelementptr inbounds %Statement, %Statement* %t1028, i32 0, i32 1
  %t1051 = bitcast [88 x i8]* %t1050 to i8*
  %t1052 = getelementptr inbounds i8, i8* %t1051, i64 56
  %t1053 = bitcast i8* %t1052 to %Block*
  %t1054 = load %Block, %Block* %t1053
  %t1055 = icmp eq i32 %t1027, 7
  %t1056 = select i1 %t1055, %Block %t1054, %Block %t1049
  %t1057 = getelementptr inbounds %Statement, %Statement* %t1028, i32 0, i32 1
  %t1058 = bitcast [120 x i8]* %t1057 to i8*
  %t1059 = getelementptr inbounds i8, i8* %t1058, i64 88
  %t1060 = bitcast i8* %t1059 to %Block*
  %t1061 = load %Block, %Block* %t1060
  %t1062 = icmp eq i32 %t1027, 12
  %t1063 = select i1 %t1062, %Block %t1061, %Block %t1056
  %t1064 = getelementptr inbounds %Statement, %Statement* %t1028, i32 0, i32 1
  %t1065 = bitcast [40 x i8]* %t1064 to i8*
  %t1066 = getelementptr inbounds i8, i8* %t1065, i64 8
  %t1067 = bitcast i8* %t1066 to %Block*
  %t1068 = load %Block, %Block* %t1067
  %t1069 = icmp eq i32 %t1027, 13
  %t1070 = select i1 %t1069, %Block %t1068, %Block %t1063
  %t1071 = getelementptr inbounds %Statement, %Statement* %t1028, i32 0, i32 1
  %t1072 = bitcast [136 x i8]* %t1071 to i8*
  %t1073 = getelementptr inbounds i8, i8* %t1072, i64 104
  %t1074 = bitcast i8* %t1073 to %Block*
  %t1075 = load %Block, %Block* %t1074
  %t1076 = icmp eq i32 %t1027, 14
  %t1077 = select i1 %t1076, %Block %t1075, %Block %t1070
  %t1078 = getelementptr inbounds %Statement, %Statement* %t1028, i32 0, i32 1
  %t1079 = bitcast [32 x i8]* %t1078 to i8*
  %t1080 = bitcast i8* %t1079 to %Block*
  %t1081 = load %Block, %Block* %t1080
  %t1082 = icmp eq i32 %t1027, 15
  %t1083 = select i1 %t1082, %Block %t1081, %Block %t1077
  %t1084 = extractvalue %Statement %statement, 0
  %t1085 = alloca %Statement
  store %Statement %statement, %Statement* %t1085
  %t1086 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1087 = bitcast [48 x i8]* %t1086 to i8*
  %t1088 = getelementptr inbounds i8, i8* %t1087, i64 40
  %t1089 = bitcast i8* %t1088 to { %Decorator*, i64 }**
  %t1090 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1089
  %t1091 = icmp eq i32 %t1084, 3
  %t1092 = select i1 %t1091, { %Decorator*, i64 }* %t1090, { %Decorator*, i64 }* null
  %t1093 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1094 = bitcast [88 x i8]* %t1093 to i8*
  %t1095 = getelementptr inbounds i8, i8* %t1094, i64 80
  %t1096 = bitcast i8* %t1095 to { %Decorator*, i64 }**
  %t1097 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1096
  %t1098 = icmp eq i32 %t1084, 4
  %t1099 = select i1 %t1098, { %Decorator*, i64 }* %t1097, { %Decorator*, i64 }* %t1092
  %t1100 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1101 = bitcast [88 x i8]* %t1100 to i8*
  %t1102 = getelementptr inbounds i8, i8* %t1101, i64 80
  %t1103 = bitcast i8* %t1102 to { %Decorator*, i64 }**
  %t1104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1103
  %t1105 = icmp eq i32 %t1084, 5
  %t1106 = select i1 %t1105, { %Decorator*, i64 }* %t1104, { %Decorator*, i64 }* %t1099
  %t1107 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1108 = bitcast [56 x i8]* %t1107 to i8*
  %t1109 = getelementptr inbounds i8, i8* %t1108, i64 48
  %t1110 = bitcast i8* %t1109 to { %Decorator*, i64 }**
  %t1111 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1110
  %t1112 = icmp eq i32 %t1084, 6
  %t1113 = select i1 %t1112, { %Decorator*, i64 }* %t1111, { %Decorator*, i64 }* %t1106
  %t1114 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1115 = bitcast [88 x i8]* %t1114 to i8*
  %t1116 = getelementptr inbounds i8, i8* %t1115, i64 80
  %t1117 = bitcast i8* %t1116 to { %Decorator*, i64 }**
  %t1118 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1117
  %t1119 = icmp eq i32 %t1084, 7
  %t1120 = select i1 %t1119, { %Decorator*, i64 }* %t1118, { %Decorator*, i64 }* %t1113
  %t1121 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1122 = bitcast [56 x i8]* %t1121 to i8*
  %t1123 = getelementptr inbounds i8, i8* %t1122, i64 48
  %t1124 = bitcast i8* %t1123 to { %Decorator*, i64 }**
  %t1125 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1124
  %t1126 = icmp eq i32 %t1084, 8
  %t1127 = select i1 %t1126, { %Decorator*, i64 }* %t1125, { %Decorator*, i64 }* %t1120
  %t1128 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1129 = bitcast [40 x i8]* %t1128 to i8*
  %t1130 = getelementptr inbounds i8, i8* %t1129, i64 32
  %t1131 = bitcast i8* %t1130 to { %Decorator*, i64 }**
  %t1132 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1131
  %t1133 = icmp eq i32 %t1084, 9
  %t1134 = select i1 %t1133, { %Decorator*, i64 }* %t1132, { %Decorator*, i64 }* %t1127
  %t1135 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1136 = bitcast [40 x i8]* %t1135 to i8*
  %t1137 = getelementptr inbounds i8, i8* %t1136, i64 32
  %t1138 = bitcast i8* %t1137 to { %Decorator*, i64 }**
  %t1139 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1138
  %t1140 = icmp eq i32 %t1084, 10
  %t1141 = select i1 %t1140, { %Decorator*, i64 }* %t1139, { %Decorator*, i64 }* %t1134
  %t1142 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1143 = bitcast [40 x i8]* %t1142 to i8*
  %t1144 = getelementptr inbounds i8, i8* %t1143, i64 32
  %t1145 = bitcast i8* %t1144 to { %Decorator*, i64 }**
  %t1146 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1145
  %t1147 = icmp eq i32 %t1084, 11
  %t1148 = select i1 %t1147, { %Decorator*, i64 }* %t1146, { %Decorator*, i64 }* %t1141
  %t1149 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1150 = bitcast [120 x i8]* %t1149 to i8*
  %t1151 = getelementptr inbounds i8, i8* %t1150, i64 112
  %t1152 = bitcast i8* %t1151 to { %Decorator*, i64 }**
  %t1153 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1152
  %t1154 = icmp eq i32 %t1084, 12
  %t1155 = select i1 %t1154, { %Decorator*, i64 }* %t1153, { %Decorator*, i64 }* %t1148
  %t1156 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1157 = bitcast [40 x i8]* %t1156 to i8*
  %t1158 = getelementptr inbounds i8, i8* %t1157, i64 32
  %t1159 = bitcast i8* %t1158 to { %Decorator*, i64 }**
  %t1160 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1159
  %t1161 = icmp eq i32 %t1084, 13
  %t1162 = select i1 %t1161, { %Decorator*, i64 }* %t1160, { %Decorator*, i64 }* %t1155
  %t1163 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1164 = bitcast [136 x i8]* %t1163 to i8*
  %t1165 = getelementptr inbounds i8, i8* %t1164, i64 128
  %t1166 = bitcast i8* %t1165 to { %Decorator*, i64 }**
  %t1167 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1166
  %t1168 = icmp eq i32 %t1084, 14
  %t1169 = select i1 %t1168, { %Decorator*, i64 }* %t1167, { %Decorator*, i64 }* %t1162
  %t1170 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1171 = bitcast [32 x i8]* %t1170 to i8*
  %t1172 = getelementptr inbounds i8, i8* %t1171, i64 24
  %t1173 = bitcast i8* %t1172 to { %Decorator*, i64 }**
  %t1174 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1173
  %t1175 = icmp eq i32 %t1084, 15
  %t1176 = select i1 %t1175, { %Decorator*, i64 }* %t1174, { %Decorator*, i64 }* %t1169
  %t1177 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1178 = bitcast [64 x i8]* %t1177 to i8*
  %t1179 = getelementptr inbounds i8, i8* %t1178, i64 56
  %t1180 = bitcast i8* %t1179 to { %Decorator*, i64 }**
  %t1181 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1180
  %t1182 = icmp eq i32 %t1084, 18
  %t1183 = select i1 %t1182, { %Decorator*, i64 }* %t1181, { %Decorator*, i64 }* %t1176
  %t1184 = getelementptr inbounds %Statement, %Statement* %t1085, i32 0, i32 1
  %t1185 = bitcast [88 x i8]* %t1184 to i8*
  %t1186 = getelementptr inbounds i8, i8* %t1185, i64 80
  %t1187 = bitcast i8* %t1186 to { %Decorator*, i64 }**
  %t1188 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1187
  %t1189 = icmp eq i32 %t1084, 19
  %t1190 = select i1 %t1189, { %Decorator*, i64 }* %t1188, { %Decorator*, i64 }* %t1183
  %t1191 = load i8*, i8** %l5
  %t1192 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1026, %Block %t1083, { %Decorator*, i64 }* %t1190, i8* %t1191)
  ret { %EffectViolation*, i64 }* %t1192
merge7:
  %t1193 = extractvalue %Statement %statement, 0
  %t1194 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1195 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1193, 0
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1193, 1
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1193, 2
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1193, 3
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1193, 4
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1193, 5
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1193, 6
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1193, 7
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1193, 8
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1193, 9
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1193, 10
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1193, 11
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %t1231 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1193, 12
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1193, 13
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1193, 14
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %t1240 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1241 = icmp eq i32 %t1193, 15
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1239
  %t1243 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1244 = icmp eq i32 %t1193, 16
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1242
  %t1246 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1247 = icmp eq i32 %t1193, 17
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1245
  %t1249 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1250 = icmp eq i32 %t1193, 18
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1248
  %t1252 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1193, 19
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1193, 20
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1193, 21
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1193, 22
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = call i8* @malloc(i64 18)
  %t1265 = bitcast i8* %t1264 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t1265
  %t1266 = call i1 @strings_equal(i8* %t1263, i8* %t1264)
  br i1 %t1266, label %then8, label %merge9
then8:
  %t1267 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1268 = ptrtoint [0 x %EffectViolation]* %t1267 to i64
  %t1269 = icmp eq i64 %t1268, 0
  %t1270 = select i1 %t1269, i64 1, i64 %t1268
  %t1271 = call i8* @malloc(i64 %t1270)
  %t1272 = bitcast i8* %t1271 to %EffectViolation*
  %t1273 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t1274 = ptrtoint { %EffectViolation*, i64 }* %t1273 to i64
  %t1275 = call i8* @malloc(i64 %t1274)
  %t1276 = bitcast i8* %t1275 to { %EffectViolation*, i64 }*
  %t1277 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1276, i32 0, i32 0
  store %EffectViolation* %t1272, %EffectViolation** %t1277
  %t1278 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1276, i32 0, i32 1
  store i64 0, i64* %t1278
  store { %EffectViolation*, i64 }* %t1276, { %EffectViolation*, i64 }** %l6
  %t1279 = sitofp i64 0 to double
  store double %t1279, double* %l7
  %t1280 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1281 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1383 = phi { %EffectViolation*, i64 }* [ %t1280, %then8 ], [ %t1381, %loop.latch12 ]
  %t1384 = phi double [ %t1281, %then8 ], [ %t1382, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1383, { %EffectViolation*, i64 }** %l6
  store double %t1384, double* %l7
  br label %loop.body11
loop.body11:
  %t1282 = load double, double* %l7
  %t1283 = extractvalue %Statement %statement, 0
  %t1284 = alloca %Statement
  store %Statement %statement, %Statement* %t1284
  %t1285 = getelementptr inbounds %Statement, %Statement* %t1284, i32 0, i32 1
  %t1286 = bitcast [56 x i8]* %t1285 to i8*
  %t1287 = getelementptr inbounds i8, i8* %t1286, i64 40
  %t1288 = bitcast i8* %t1287 to { %MethodDeclaration*, i64 }**
  %t1289 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1288
  %t1290 = icmp eq i32 %t1283, 8
  %t1291 = select i1 %t1290, { %MethodDeclaration*, i64 }* %t1289, { %MethodDeclaration*, i64 }* null
  %t1292 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1291
  %t1293 = extractvalue { %MethodDeclaration*, i64 } %t1292, 1
  %t1294 = sitofp i64 %t1293 to double
  %t1295 = fcmp oge double %t1282, %t1294
  %t1296 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1297 = load double, double* %l7
  br i1 %t1295, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1298 = extractvalue %Statement %statement, 0
  %t1299 = alloca %Statement
  store %Statement %statement, %Statement* %t1299
  %t1300 = getelementptr inbounds %Statement, %Statement* %t1299, i32 0, i32 1
  %t1301 = bitcast [56 x i8]* %t1300 to i8*
  %t1302 = getelementptr inbounds i8, i8* %t1301, i64 40
  %t1303 = bitcast i8* %t1302 to { %MethodDeclaration*, i64 }**
  %t1304 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1303
  %t1305 = icmp eq i32 %t1298, 8
  %t1306 = select i1 %t1305, { %MethodDeclaration*, i64 }* %t1304, { %MethodDeclaration*, i64 }* null
  %t1307 = load double, double* %l7
  %t1308 = call double @llvm.round.f64(double %t1307)
  %t1309 = fptosi double %t1308 to i64
  %t1310 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1306
  %t1311 = extractvalue { %MethodDeclaration*, i64 } %t1310, 0
  %t1312 = extractvalue { %MethodDeclaration*, i64 } %t1310, 1
  %t1313 = icmp uge i64 %t1309, %t1312
  ; bounds check: %t1313 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1309, i64 %t1312)
  %t1314 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1311, i64 %t1309
  %t1315 = load %MethodDeclaration, %MethodDeclaration* %t1314
  store %MethodDeclaration %t1315, %MethodDeclaration* %l8
  %t1316 = extractvalue %Statement %statement, 0
  %t1317 = alloca %Statement
  store %Statement %statement, %Statement* %t1317
  %t1318 = getelementptr inbounds %Statement, %Statement* %t1317, i32 0, i32 1
  %t1319 = bitcast [48 x i8]* %t1318 to i8*
  %t1320 = bitcast i8* %t1319 to i8**
  %t1321 = load i8*, i8** %t1320
  %t1322 = icmp eq i32 %t1316, 2
  %t1323 = select i1 %t1322, i8* %t1321, i8* null
  %t1324 = getelementptr inbounds %Statement, %Statement* %t1317, i32 0, i32 1
  %t1325 = bitcast [48 x i8]* %t1324 to i8*
  %t1326 = bitcast i8* %t1325 to i8**
  %t1327 = load i8*, i8** %t1326
  %t1328 = icmp eq i32 %t1316, 3
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1323
  %t1330 = getelementptr inbounds %Statement, %Statement* %t1317, i32 0, i32 1
  %t1331 = bitcast [56 x i8]* %t1330 to i8*
  %t1332 = bitcast i8* %t1331 to i8**
  %t1333 = load i8*, i8** %t1332
  %t1334 = icmp eq i32 %t1316, 6
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1329
  %t1336 = getelementptr inbounds %Statement, %Statement* %t1317, i32 0, i32 1
  %t1337 = bitcast [56 x i8]* %t1336 to i8*
  %t1338 = bitcast i8* %t1337 to i8**
  %t1339 = load i8*, i8** %t1338
  %t1340 = icmp eq i32 %t1316, 8
  %t1341 = select i1 %t1340, i8* %t1339, i8* %t1335
  %t1342 = getelementptr inbounds %Statement, %Statement* %t1317, i32 0, i32 1
  %t1343 = bitcast [40 x i8]* %t1342 to i8*
  %t1344 = bitcast i8* %t1343 to i8**
  %t1345 = load i8*, i8** %t1344
  %t1346 = icmp eq i32 %t1316, 9
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1341
  %t1348 = getelementptr inbounds %Statement, %Statement* %t1317, i32 0, i32 1
  %t1349 = bitcast [40 x i8]* %t1348 to i8*
  %t1350 = bitcast i8* %t1349 to i8**
  %t1351 = load i8*, i8** %t1350
  %t1352 = icmp eq i32 %t1316, 10
  %t1353 = select i1 %t1352, i8* %t1351, i8* %t1347
  %t1354 = getelementptr inbounds %Statement, %Statement* %t1317, i32 0, i32 1
  %t1355 = bitcast [40 x i8]* %t1354 to i8*
  %t1356 = bitcast i8* %t1355 to i8**
  %t1357 = load i8*, i8** %t1356
  %t1358 = icmp eq i32 %t1316, 11
  %t1359 = select i1 %t1358, i8* %t1357, i8* %t1353
  %t1360 = add i64 0, 2
  %t1361 = call i8* @malloc(i64 %t1360)
  store i8 46, i8* %t1361
  %t1362 = getelementptr i8, i8* %t1361, i64 1
  store i8 0, i8* %t1362
  call void @sailfin_runtime_mark_persistent(i8* %t1361)
  %t1363 = call i8* @sailfin_runtime_string_concat(i8* %t1359, i8* %t1361)
  %t1364 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1365 = extractvalue %MethodDeclaration %t1364, 0
  %t1366 = extractvalue %FunctionSignature %t1365, 0
  %t1367 = call i8* @sailfin_runtime_string_concat(i8* %t1363, i8* %t1366)
  store i8* %t1367, i8** %l9
  %t1368 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1369 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1370 = extractvalue %MethodDeclaration %t1369, 0
  %t1371 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1372 = extractvalue %MethodDeclaration %t1371, 1
  %t1373 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1374 = extractvalue %MethodDeclaration %t1373, 2
  %t1375 = load i8*, i8** %l9
  %t1376 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1370, %Block %t1372, { %Decorator*, i64 }* %t1374, i8* %t1375)
  %t1377 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t1368, { %EffectViolation*, i64 }* %t1376)
  store { %EffectViolation*, i64 }* %t1377, { %EffectViolation*, i64 }** %l6
  %t1378 = load double, double* %l7
  %t1379 = sitofp i64 1 to double
  %t1380 = fadd double %t1378, %t1379
  store double %t1380, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1381 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1382 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1385 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1386 = load double, double* %l7
  %t1387 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1387
merge9:
  %t1388 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1389 = ptrtoint [0 x %EffectViolation]* %t1388 to i64
  %t1390 = icmp eq i64 %t1389, 0
  %t1391 = select i1 %t1390, i64 1, i64 %t1389
  %t1392 = call i8* @malloc(i64 %t1391)
  %t1393 = bitcast i8* %t1392 to %EffectViolation*
  %t1394 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t1395 = ptrtoint { %EffectViolation*, i64 }* %t1394 to i64
  %t1396 = call i8* @malloc(i64 %t1395)
  %t1397 = bitcast i8* %t1396 to { %EffectViolation*, i64 }*
  %t1398 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1397, i32 0, i32 0
  store %EffectViolation* %t1393, %EffectViolation** %t1398
  %t1399 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1397, i32 0, i32 1
  store i64 0, i64* %t1399
  ret { %EffectViolation*, i64 }* %t1397
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
  %t205 = call i1 @contains_effect({ i8**, i64 }* %t203, i8* %t204)
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
  %t62 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t0, 20
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t0, 21
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t0, 22
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = call i8* @malloc(i64 16)
  %t72 = bitcast i8* %t71 to [16 x i8]*
  store [16 x i8] c"PromptStatement\00", [16 x i8]* %t72
  %t73 = call i1 @strings_equal(i8* %t70, i8* %t71)
  br i1 %t73, label %then0, label %merge1
then0:
  %t74 = extractvalue %Statement %statement, 0
  %t75 = alloca %Statement
  store %Statement %statement, %Statement* %t75
  %t76 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t77 = bitcast [88 x i8]* %t76 to i8*
  %t78 = getelementptr inbounds i8, i8* %t77, i64 56
  %t79 = bitcast i8* %t78 to %Block*
  %t80 = load %Block, %Block* %t79
  %t81 = icmp eq i32 %t74, 4
  %t82 = select i1 %t81, %Block %t80, %Block zeroinitializer
  %t83 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t84 = bitcast [88 x i8]* %t83 to i8*
  %t85 = getelementptr inbounds i8, i8* %t84, i64 56
  %t86 = bitcast i8* %t85 to %Block*
  %t87 = load %Block, %Block* %t86
  %t88 = icmp eq i32 %t74, 5
  %t89 = select i1 %t88, %Block %t87, %Block %t82
  %t90 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t91 = bitcast [56 x i8]* %t90 to i8*
  %t92 = getelementptr inbounds i8, i8* %t91, i64 16
  %t93 = bitcast i8* %t92 to %Block*
  %t94 = load %Block, %Block* %t93
  %t95 = icmp eq i32 %t74, 6
  %t96 = select i1 %t95, %Block %t94, %Block %t89
  %t97 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t98 = bitcast [88 x i8]* %t97 to i8*
  %t99 = getelementptr inbounds i8, i8* %t98, i64 56
  %t100 = bitcast i8* %t99 to %Block*
  %t101 = load %Block, %Block* %t100
  %t102 = icmp eq i32 %t74, 7
  %t103 = select i1 %t102, %Block %t101, %Block %t96
  %t104 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t105 = bitcast [120 x i8]* %t104 to i8*
  %t106 = getelementptr inbounds i8, i8* %t105, i64 88
  %t107 = bitcast i8* %t106 to %Block*
  %t108 = load %Block, %Block* %t107
  %t109 = icmp eq i32 %t74, 12
  %t110 = select i1 %t109, %Block %t108, %Block %t103
  %t111 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t112 = bitcast [40 x i8]* %t111 to i8*
  %t113 = getelementptr inbounds i8, i8* %t112, i64 8
  %t114 = bitcast i8* %t113 to %Block*
  %t115 = load %Block, %Block* %t114
  %t116 = icmp eq i32 %t74, 13
  %t117 = select i1 %t116, %Block %t115, %Block %t110
  %t118 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t119 = bitcast [136 x i8]* %t118 to i8*
  %t120 = getelementptr inbounds i8, i8* %t119, i64 104
  %t121 = bitcast i8* %t120 to %Block*
  %t122 = load %Block, %Block* %t121
  %t123 = icmp eq i32 %t74, 14
  %t124 = select i1 %t123, %Block %t122, %Block %t117
  %t125 = getelementptr inbounds %Statement, %Statement* %t75, i32 0, i32 1
  %t126 = bitcast [32 x i8]* %t125 to i8*
  %t127 = bitcast i8* %t126 to %Block*
  %t128 = load %Block, %Block* %t127
  %t129 = icmp eq i32 %t74, 15
  %t130 = select i1 %t129, %Block %t128, %Block %t124
  %t131 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t130)
  store { %EffectRequirement*, i64 }* %t131, { %EffectRequirement*, i64 }** %l0
  %t132 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t133 = call i8* @malloc(i64 6)
  %t134 = bitcast i8* %t133 to [6 x i8]*
  store [6 x i8] c"model\00", [6 x i8]* %t134
  %t135 = insertvalue %EffectRequirement undef, i8* %t133, 0
  %t136 = extractvalue %Statement %statement, 0
  %t137 = alloca %Statement
  store %Statement %statement, %Statement* %t137
  %t138 = getelementptr inbounds %Statement, %Statement* %t137, i32 0, i32 1
  %t139 = bitcast [120 x i8]* %t138 to i8*
  %t140 = getelementptr inbounds i8, i8* %t139, i64 8
  %t141 = bitcast i8* %t140 to %Token*
  %t142 = load %Token, %Token* %t141
  %t143 = icmp eq i32 %t136, 12
  %t144 = select i1 %t143, %Token %t142, %Token zeroinitializer
  %t145 = getelementptr %Token, %Token* null, i32 1
  %t146 = ptrtoint %Token* %t145 to i64
  %t147 = call noalias i8* @malloc(i64 %t146)
  %t148 = bitcast i8* %t147 to %Token*
  store %Token %t144, %Token* %t148
  call void @sailfin_runtime_mark_persistent(i8* %t147)
  %t149 = insertvalue %EffectRequirement %t135, %Token* %t148, 1
  %t150 = call i8* @malloc(i64 9)
  %t151 = bitcast i8* %t150 to [9 x i8]*
  store [9 x i8] c"prompt \22\00", [9 x i8]* %t151
  %t152 = extractvalue %Statement %statement, 0
  %t153 = alloca %Statement
  store %Statement %statement, %Statement* %t153
  %t154 = getelementptr inbounds %Statement, %Statement* %t153, i32 0, i32 1
  %t155 = bitcast [120 x i8]* %t154 to i8*
  %t156 = bitcast i8* %t155 to i8**
  %t157 = load i8*, i8** %t156
  %t158 = icmp eq i32 %t152, 12
  %t159 = select i1 %t158, i8* %t157, i8* null
  %t160 = call i8* @sailfin_runtime_string_concat(i8* %t150, i8* %t159)
  %t161 = add i64 0, 2
  %t162 = call i8* @malloc(i64 %t161)
  store i8 34, i8* %t162
  %t163 = getelementptr i8, i8* %t162, i64 1
  store i8 0, i8* %t163
  call void @sailfin_runtime_mark_persistent(i8* %t162)
  %t164 = call i8* @sailfin_runtime_string_concat(i8* %t160, i8* %t162)
  %t165 = insertvalue %EffectRequirement %t149, i8* %t164, 2
  %t166 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t132, %EffectRequirement %t165)
  store { %EffectRequirement*, i64 }* %t166, { %EffectRequirement*, i64 }** %l0
  %t167 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t167
merge1:
  %t168 = extractvalue %Statement %statement, 0
  %t169 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t170 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t168, 0
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t168, 1
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t168, 2
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t168, 3
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t168, 4
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t168, 5
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t168, 6
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t168, 7
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t168, 8
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t168, 9
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t168, 10
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t168, 11
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t168, 12
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t168, 13
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t168, 14
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t168, 15
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t168, 16
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t168, 17
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t168, 18
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t168, 19
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t168, 20
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t168, 21
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t168, 22
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = call i8* @malloc(i64 14)
  %t240 = bitcast i8* %t239 to [14 x i8]*
  store [14 x i8] c"WithStatement\00", [14 x i8]* %t240
  %t241 = call i1 @strings_equal(i8* %t238, i8* %t239)
  br i1 %t241, label %then2, label %merge3
then2:
  %t242 = extractvalue %Statement %statement, 0
  %t243 = alloca %Statement
  store %Statement %statement, %Statement* %t243
  %t244 = getelementptr inbounds %Statement, %Statement* %t243, i32 0, i32 1
  %t245 = bitcast [88 x i8]* %t244 to i8*
  %t246 = getelementptr inbounds i8, i8* %t245, i64 56
  %t247 = bitcast i8* %t246 to %Block*
  %t248 = load %Block, %Block* %t247
  %t249 = icmp eq i32 %t242, 4
  %t250 = select i1 %t249, %Block %t248, %Block zeroinitializer
  %t251 = getelementptr inbounds %Statement, %Statement* %t243, i32 0, i32 1
  %t252 = bitcast [88 x i8]* %t251 to i8*
  %t253 = getelementptr inbounds i8, i8* %t252, i64 56
  %t254 = bitcast i8* %t253 to %Block*
  %t255 = load %Block, %Block* %t254
  %t256 = icmp eq i32 %t242, 5
  %t257 = select i1 %t256, %Block %t255, %Block %t250
  %t258 = getelementptr inbounds %Statement, %Statement* %t243, i32 0, i32 1
  %t259 = bitcast [56 x i8]* %t258 to i8*
  %t260 = getelementptr inbounds i8, i8* %t259, i64 16
  %t261 = bitcast i8* %t260 to %Block*
  %t262 = load %Block, %Block* %t261
  %t263 = icmp eq i32 %t242, 6
  %t264 = select i1 %t263, %Block %t262, %Block %t257
  %t265 = getelementptr inbounds %Statement, %Statement* %t243, i32 0, i32 1
  %t266 = bitcast [88 x i8]* %t265 to i8*
  %t267 = getelementptr inbounds i8, i8* %t266, i64 56
  %t268 = bitcast i8* %t267 to %Block*
  %t269 = load %Block, %Block* %t268
  %t270 = icmp eq i32 %t242, 7
  %t271 = select i1 %t270, %Block %t269, %Block %t264
  %t272 = getelementptr inbounds %Statement, %Statement* %t243, i32 0, i32 1
  %t273 = bitcast [120 x i8]* %t272 to i8*
  %t274 = getelementptr inbounds i8, i8* %t273, i64 88
  %t275 = bitcast i8* %t274 to %Block*
  %t276 = load %Block, %Block* %t275
  %t277 = icmp eq i32 %t242, 12
  %t278 = select i1 %t277, %Block %t276, %Block %t271
  %t279 = getelementptr inbounds %Statement, %Statement* %t243, i32 0, i32 1
  %t280 = bitcast [40 x i8]* %t279 to i8*
  %t281 = getelementptr inbounds i8, i8* %t280, i64 8
  %t282 = bitcast i8* %t281 to %Block*
  %t283 = load %Block, %Block* %t282
  %t284 = icmp eq i32 %t242, 13
  %t285 = select i1 %t284, %Block %t283, %Block %t278
  %t286 = getelementptr inbounds %Statement, %Statement* %t243, i32 0, i32 1
  %t287 = bitcast [136 x i8]* %t286 to i8*
  %t288 = getelementptr inbounds i8, i8* %t287, i64 104
  %t289 = bitcast i8* %t288 to %Block*
  %t290 = load %Block, %Block* %t289
  %t291 = icmp eq i32 %t242, 14
  %t292 = select i1 %t291, %Block %t290, %Block %t285
  %t293 = getelementptr inbounds %Statement, %Statement* %t243, i32 0, i32 1
  %t294 = bitcast [32 x i8]* %t293 to i8*
  %t295 = bitcast i8* %t294 to %Block*
  %t296 = load %Block, %Block* %t295
  %t297 = icmp eq i32 %t242, 15
  %t298 = select i1 %t297, %Block %t296, %Block %t292
  %t299 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t298)
  store { %EffectRequirement*, i64 }* %t299, { %EffectRequirement*, i64 }** %l1
  %t300 = sitofp i64 0 to double
  store double %t300, double* %l2
  %t301 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t302 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t349 = phi { %EffectRequirement*, i64 }* [ %t301, %then2 ], [ %t347, %loop.latch6 ]
  %t350 = phi double [ %t302, %then2 ], [ %t348, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t349, { %EffectRequirement*, i64 }** %l1
  store double %t350, double* %l2
  br label %loop.body5
loop.body5:
  %t303 = load double, double* %l2
  %t304 = extractvalue %Statement %statement, 0
  %t305 = alloca %Statement
  store %Statement %statement, %Statement* %t305
  %t306 = getelementptr inbounds %Statement, %Statement* %t305, i32 0, i32 1
  %t307 = bitcast [40 x i8]* %t306 to i8*
  %t308 = bitcast i8* %t307 to { %WithClause*, i64 }**
  %t309 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %t308
  %t310 = icmp eq i32 %t304, 13
  %t311 = select i1 %t310, { %WithClause*, i64 }* %t309, { %WithClause*, i64 }* null
  %t312 = load { %WithClause*, i64 }, { %WithClause*, i64 }* %t311
  %t313 = extractvalue { %WithClause*, i64 } %t312, 1
  %t314 = sitofp i64 %t313 to double
  %t315 = fcmp oge double %t303, %t314
  %t316 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t317 = load double, double* %l2
  br i1 %t315, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t318 = extractvalue %Statement %statement, 0
  %t319 = alloca %Statement
  store %Statement %statement, %Statement* %t319
  %t320 = getelementptr inbounds %Statement, %Statement* %t319, i32 0, i32 1
  %t321 = bitcast [40 x i8]* %t320 to i8*
  %t322 = bitcast i8* %t321 to { %WithClause*, i64 }**
  %t323 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %t322
  %t324 = icmp eq i32 %t318, 13
  %t325 = select i1 %t324, { %WithClause*, i64 }* %t323, { %WithClause*, i64 }* null
  %t326 = load double, double* %l2
  %t327 = call double @llvm.round.f64(double %t326)
  %t328 = fptosi double %t327 to i64
  %t329 = load { %WithClause*, i64 }, { %WithClause*, i64 }* %t325
  %t330 = extractvalue { %WithClause*, i64 } %t329, 0
  %t331 = extractvalue { %WithClause*, i64 } %t329, 1
  %t332 = icmp uge i64 %t328, %t331
  ; bounds check: %t332 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t328, i64 %t331)
  %t333 = getelementptr %WithClause, %WithClause* %t330, i64 %t328
  %t334 = load %WithClause, %WithClause* %t333
  store %WithClause %t334, %WithClause* %l3
  %t335 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t336 = load %WithClause, %WithClause* %l3
  %t337 = extractvalue %WithClause %t336, 0
  %t338 = getelementptr %Expression, %Expression* null, i32 1
  %t339 = ptrtoint %Expression* %t338 to i64
  %t340 = call noalias i8* @malloc(i64 %t339)
  %t341 = bitcast i8* %t340 to %Expression*
  store %Expression %t337, %Expression* %t341
  call void @sailfin_runtime_mark_persistent(i8* %t340)
  %t342 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t341)
  %t343 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t335, { %EffectRequirement*, i64 }* %t342)
  store { %EffectRequirement*, i64 }* %t343, { %EffectRequirement*, i64 }** %l1
  %t344 = load double, double* %l2
  %t345 = sitofp i64 1 to double
  %t346 = fadd double %t344, %t345
  store double %t346, double* %l2
  br label %loop.latch6
loop.latch6:
  %t347 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t348 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t351 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t352 = load double, double* %l2
  %t353 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t353
merge3:
  %t354 = extractvalue %Statement %statement, 0
  %t355 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t356 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t354, 0
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t354, 1
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t354, 2
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t354, 3
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t354, 4
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t354, 5
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t354, 6
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t354, 7
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t354, 8
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t354, 9
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t354, 10
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t354, 11
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t354, 12
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t354, 13
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t354, 14
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t354, 15
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t354, 16
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t354, 17
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t354, 18
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t354, 19
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %t416 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t417 = icmp eq i32 %t354, 20
  %t418 = select i1 %t417, i8* %t416, i8* %t415
  %t419 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t420 = icmp eq i32 %t354, 21
  %t421 = select i1 %t420, i8* %t419, i8* %t418
  %t422 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t354, 22
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = call i8* @malloc(i64 13)
  %t426 = bitcast i8* %t425 to [13 x i8]*
  store [13 x i8] c"ForStatement\00", [13 x i8]* %t426
  %t427 = call i1 @strings_equal(i8* %t424, i8* %t425)
  br i1 %t427, label %then10, label %merge11
then10:
  %t428 = extractvalue %Statement %statement, 0
  %t429 = alloca %Statement
  store %Statement %statement, %Statement* %t429
  %t430 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t431 = bitcast [88 x i8]* %t430 to i8*
  %t432 = getelementptr inbounds i8, i8* %t431, i64 56
  %t433 = bitcast i8* %t432 to %Block*
  %t434 = load %Block, %Block* %t433
  %t435 = icmp eq i32 %t428, 4
  %t436 = select i1 %t435, %Block %t434, %Block zeroinitializer
  %t437 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t438 = bitcast [88 x i8]* %t437 to i8*
  %t439 = getelementptr inbounds i8, i8* %t438, i64 56
  %t440 = bitcast i8* %t439 to %Block*
  %t441 = load %Block, %Block* %t440
  %t442 = icmp eq i32 %t428, 5
  %t443 = select i1 %t442, %Block %t441, %Block %t436
  %t444 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t445 = bitcast [56 x i8]* %t444 to i8*
  %t446 = getelementptr inbounds i8, i8* %t445, i64 16
  %t447 = bitcast i8* %t446 to %Block*
  %t448 = load %Block, %Block* %t447
  %t449 = icmp eq i32 %t428, 6
  %t450 = select i1 %t449, %Block %t448, %Block %t443
  %t451 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t452 = bitcast [88 x i8]* %t451 to i8*
  %t453 = getelementptr inbounds i8, i8* %t452, i64 56
  %t454 = bitcast i8* %t453 to %Block*
  %t455 = load %Block, %Block* %t454
  %t456 = icmp eq i32 %t428, 7
  %t457 = select i1 %t456, %Block %t455, %Block %t450
  %t458 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t459 = bitcast [120 x i8]* %t458 to i8*
  %t460 = getelementptr inbounds i8, i8* %t459, i64 88
  %t461 = bitcast i8* %t460 to %Block*
  %t462 = load %Block, %Block* %t461
  %t463 = icmp eq i32 %t428, 12
  %t464 = select i1 %t463, %Block %t462, %Block %t457
  %t465 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t466 = bitcast [40 x i8]* %t465 to i8*
  %t467 = getelementptr inbounds i8, i8* %t466, i64 8
  %t468 = bitcast i8* %t467 to %Block*
  %t469 = load %Block, %Block* %t468
  %t470 = icmp eq i32 %t428, 13
  %t471 = select i1 %t470, %Block %t469, %Block %t464
  %t472 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t473 = bitcast [136 x i8]* %t472 to i8*
  %t474 = getelementptr inbounds i8, i8* %t473, i64 104
  %t475 = bitcast i8* %t474 to %Block*
  %t476 = load %Block, %Block* %t475
  %t477 = icmp eq i32 %t428, 14
  %t478 = select i1 %t477, %Block %t476, %Block %t471
  %t479 = getelementptr inbounds %Statement, %Statement* %t429, i32 0, i32 1
  %t480 = bitcast [32 x i8]* %t479 to i8*
  %t481 = bitcast i8* %t480 to %Block*
  %t482 = load %Block, %Block* %t481
  %t483 = icmp eq i32 %t428, 15
  %t484 = select i1 %t483, %Block %t482, %Block %t478
  %t485 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t484)
  store { %EffectRequirement*, i64 }* %t485, { %EffectRequirement*, i64 }** %l4
  %t486 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t487 = extractvalue %Statement %statement, 0
  %t488 = alloca %Statement
  store %Statement %statement, %Statement* %t488
  %t489 = getelementptr inbounds %Statement, %Statement* %t488, i32 0, i32 1
  %t490 = bitcast [136 x i8]* %t489 to i8*
  %t491 = bitcast i8* %t490 to %ForClause*
  %t492 = load %ForClause, %ForClause* %t491
  %t493 = icmp eq i32 %t487, 14
  %t494 = select i1 %t493, %ForClause %t492, %ForClause zeroinitializer
  %t495 = extractvalue %ForClause %t494, 0
  %t496 = getelementptr %Expression, %Expression* null, i32 1
  %t497 = ptrtoint %Expression* %t496 to i64
  %t498 = call noalias i8* @malloc(i64 %t497)
  %t499 = bitcast i8* %t498 to %Expression*
  store %Expression %t495, %Expression* %t499
  call void @sailfin_runtime_mark_persistent(i8* %t498)
  %t500 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t499)
  %t501 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t486, { %EffectRequirement*, i64 }* %t500)
  store { %EffectRequirement*, i64 }* %t501, { %EffectRequirement*, i64 }** %l4
  %t502 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t503 = extractvalue %Statement %statement, 0
  %t504 = alloca %Statement
  store %Statement %statement, %Statement* %t504
  %t505 = getelementptr inbounds %Statement, %Statement* %t504, i32 0, i32 1
  %t506 = bitcast [136 x i8]* %t505 to i8*
  %t507 = bitcast i8* %t506 to %ForClause*
  %t508 = load %ForClause, %ForClause* %t507
  %t509 = icmp eq i32 %t503, 14
  %t510 = select i1 %t509, %ForClause %t508, %ForClause zeroinitializer
  %t511 = extractvalue %ForClause %t510, 1
  %t512 = getelementptr %Expression, %Expression* null, i32 1
  %t513 = ptrtoint %Expression* %t512 to i64
  %t514 = call noalias i8* @malloc(i64 %t513)
  %t515 = bitcast i8* %t514 to %Expression*
  store %Expression %t511, %Expression* %t515
  call void @sailfin_runtime_mark_persistent(i8* %t514)
  %t516 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t515)
  %t517 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t502, { %EffectRequirement*, i64 }* %t516)
  store { %EffectRequirement*, i64 }* %t517, { %EffectRequirement*, i64 }** %l4
  %t518 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t518
merge11:
  %t519 = extractvalue %Statement %statement, 0
  %t520 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t521 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t519, 0
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t519, 1
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t519, 2
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t519, 3
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t519, 4
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t519, 5
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t519, 6
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t519, 7
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t519, 8
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t519, 9
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t519, 10
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t519, 11
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t519, 12
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t519, 13
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t519, 14
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t519, 15
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t519, 16
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t519, 17
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t519, 18
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t519, 19
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t519, 20
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t519, 21
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t519, 22
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = call i8* @malloc(i64 14)
  %t591 = bitcast i8* %t590 to [14 x i8]*
  store [14 x i8] c"LoopStatement\00", [14 x i8]* %t591
  %t592 = call i1 @strings_equal(i8* %t589, i8* %t590)
  br i1 %t592, label %then12, label %merge13
then12:
  %t593 = extractvalue %Statement %statement, 0
  %t594 = alloca %Statement
  store %Statement %statement, %Statement* %t594
  %t595 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t596 = bitcast [88 x i8]* %t595 to i8*
  %t597 = getelementptr inbounds i8, i8* %t596, i64 56
  %t598 = bitcast i8* %t597 to %Block*
  %t599 = load %Block, %Block* %t598
  %t600 = icmp eq i32 %t593, 4
  %t601 = select i1 %t600, %Block %t599, %Block zeroinitializer
  %t602 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t603 = bitcast [88 x i8]* %t602 to i8*
  %t604 = getelementptr inbounds i8, i8* %t603, i64 56
  %t605 = bitcast i8* %t604 to %Block*
  %t606 = load %Block, %Block* %t605
  %t607 = icmp eq i32 %t593, 5
  %t608 = select i1 %t607, %Block %t606, %Block %t601
  %t609 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t610 = bitcast [56 x i8]* %t609 to i8*
  %t611 = getelementptr inbounds i8, i8* %t610, i64 16
  %t612 = bitcast i8* %t611 to %Block*
  %t613 = load %Block, %Block* %t612
  %t614 = icmp eq i32 %t593, 6
  %t615 = select i1 %t614, %Block %t613, %Block %t608
  %t616 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t617 = bitcast [88 x i8]* %t616 to i8*
  %t618 = getelementptr inbounds i8, i8* %t617, i64 56
  %t619 = bitcast i8* %t618 to %Block*
  %t620 = load %Block, %Block* %t619
  %t621 = icmp eq i32 %t593, 7
  %t622 = select i1 %t621, %Block %t620, %Block %t615
  %t623 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t624 = bitcast [120 x i8]* %t623 to i8*
  %t625 = getelementptr inbounds i8, i8* %t624, i64 88
  %t626 = bitcast i8* %t625 to %Block*
  %t627 = load %Block, %Block* %t626
  %t628 = icmp eq i32 %t593, 12
  %t629 = select i1 %t628, %Block %t627, %Block %t622
  %t630 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t631 = bitcast [40 x i8]* %t630 to i8*
  %t632 = getelementptr inbounds i8, i8* %t631, i64 8
  %t633 = bitcast i8* %t632 to %Block*
  %t634 = load %Block, %Block* %t633
  %t635 = icmp eq i32 %t593, 13
  %t636 = select i1 %t635, %Block %t634, %Block %t629
  %t637 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t638 = bitcast [136 x i8]* %t637 to i8*
  %t639 = getelementptr inbounds i8, i8* %t638, i64 104
  %t640 = bitcast i8* %t639 to %Block*
  %t641 = load %Block, %Block* %t640
  %t642 = icmp eq i32 %t593, 14
  %t643 = select i1 %t642, %Block %t641, %Block %t636
  %t644 = getelementptr inbounds %Statement, %Statement* %t594, i32 0, i32 1
  %t645 = bitcast [32 x i8]* %t644 to i8*
  %t646 = bitcast i8* %t645 to %Block*
  %t647 = load %Block, %Block* %t646
  %t648 = icmp eq i32 %t593, 15
  %t649 = select i1 %t648, %Block %t647, %Block %t643
  %t650 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t649)
  ret { %EffectRequirement*, i64 }* %t650
merge13:
  %t651 = extractvalue %Statement %statement, 0
  %t652 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t653 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t651, 0
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t651, 1
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t651, 2
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t651, 3
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t651, 4
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t651, 5
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t651, 6
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t651, 7
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t651, 8
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t651, 9
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t651, 10
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t651, 11
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t651, 12
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t651, 13
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t651, 14
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t651, 15
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t651, 16
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t651, 17
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t651, 18
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t651, 19
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t651, 20
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %t716 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t717 = icmp eq i32 %t651, 21
  %t718 = select i1 %t717, i8* %t716, i8* %t715
  %t719 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t720 = icmp eq i32 %t651, 22
  %t721 = select i1 %t720, i8* %t719, i8* %t718
  %t722 = call i8* @malloc(i64 15)
  %t723 = bitcast i8* %t722 to [15 x i8]*
  store [15 x i8] c"MatchStatement\00", [15 x i8]* %t723
  %t724 = call i1 @strings_equal(i8* %t721, i8* %t722)
  br i1 %t724, label %then14, label %merge15
then14:
  %t725 = extractvalue %Statement %statement, 0
  %t726 = alloca %Statement
  store %Statement %statement, %Statement* %t726
  %t727 = getelementptr inbounds %Statement, %Statement* %t726, i32 0, i32 1
  %t728 = bitcast [16 x i8]* %t727 to i8*
  %t729 = bitcast i8* %t728 to %Expression**
  %t730 = load %Expression*, %Expression** %t729
  %t731 = icmp eq i32 %t725, 20
  %t732 = select i1 %t731, %Expression* %t730, %Expression* null
  %t733 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t732)
  store { %EffectRequirement*, i64 }* %t733, { %EffectRequirement*, i64 }** %l5
  %t734 = sitofp i64 0 to double
  store double %t734, double* %l6
  %t735 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t736 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t779 = phi { %EffectRequirement*, i64 }* [ %t735, %then14 ], [ %t777, %loop.latch18 ]
  %t780 = phi double [ %t736, %then14 ], [ %t778, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t779, { %EffectRequirement*, i64 }** %l5
  store double %t780, double* %l6
  br label %loop.body17
loop.body17:
  %t737 = load double, double* %l6
  %t738 = extractvalue %Statement %statement, 0
  %t739 = alloca %Statement
  store %Statement %statement, %Statement* %t739
  %t740 = getelementptr inbounds %Statement, %Statement* %t739, i32 0, i32 1
  %t741 = bitcast [64 x i8]* %t740 to i8*
  %t742 = getelementptr inbounds i8, i8* %t741, i64 48
  %t743 = bitcast i8* %t742 to { %MatchCase*, i64 }**
  %t744 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t743
  %t745 = icmp eq i32 %t738, 18
  %t746 = select i1 %t745, { %MatchCase*, i64 }* %t744, { %MatchCase*, i64 }* null
  %t747 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t746
  %t748 = extractvalue { %MatchCase*, i64 } %t747, 1
  %t749 = sitofp i64 %t748 to double
  %t750 = fcmp oge double %t737, %t749
  %t751 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t752 = load double, double* %l6
  br i1 %t750, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t753 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t754 = extractvalue %Statement %statement, 0
  %t755 = alloca %Statement
  store %Statement %statement, %Statement* %t755
  %t756 = getelementptr inbounds %Statement, %Statement* %t755, i32 0, i32 1
  %t757 = bitcast [64 x i8]* %t756 to i8*
  %t758 = getelementptr inbounds i8, i8* %t757, i64 48
  %t759 = bitcast i8* %t758 to { %MatchCase*, i64 }**
  %t760 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t759
  %t761 = icmp eq i32 %t754, 18
  %t762 = select i1 %t761, { %MatchCase*, i64 }* %t760, { %MatchCase*, i64 }* null
  %t763 = load double, double* %l6
  %t764 = call double @llvm.round.f64(double %t763)
  %t765 = fptosi double %t764 to i64
  %t766 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t762
  %t767 = extractvalue { %MatchCase*, i64 } %t766, 0
  %t768 = extractvalue { %MatchCase*, i64 } %t766, 1
  %t769 = icmp uge i64 %t765, %t768
  ; bounds check: %t769 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t765, i64 %t768)
  %t770 = getelementptr %MatchCase, %MatchCase* %t767, i64 %t765
  %t771 = load %MatchCase, %MatchCase* %t770
  %t772 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t771)
  %t773 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t753, { %EffectRequirement*, i64 }* %t772)
  store { %EffectRequirement*, i64 }* %t773, { %EffectRequirement*, i64 }** %l5
  %t774 = load double, double* %l6
  %t775 = sitofp i64 1 to double
  %t776 = fadd double %t774, %t775
  store double %t776, double* %l6
  br label %loop.latch18
loop.latch18:
  %t777 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t778 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t781 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t782 = load double, double* %l6
  %t783 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t783
merge15:
  %t784 = extractvalue %Statement %statement, 0
  %t785 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t786 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t784, 0
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t784, 1
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t784, 2
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t784, 3
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t784, 4
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t784, 5
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t784, 6
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t784, 7
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t784, 8
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t784, 9
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t784, 10
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t784, 11
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t784, 12
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t784, 13
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t784, 14
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t784, 15
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t784, 16
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t784, 17
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %t840 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t784, 18
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t784, 19
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t784, 20
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %t849 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t784, 21
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t784, 22
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = call i8* @malloc(i64 12)
  %t856 = bitcast i8* %t855 to [12 x i8]*
  store [12 x i8] c"IfStatement\00", [12 x i8]* %t856
  %t857 = call i1 @strings_equal(i8* %t854, i8* %t855)
  br i1 %t857, label %then22, label %merge23
then22:
  %t858 = extractvalue %Statement %statement, 0
  %t859 = alloca %Statement
  store %Statement %statement, %Statement* %t859
  %t860 = getelementptr inbounds %Statement, %Statement* %t859, i32 0, i32 1
  %t861 = bitcast [88 x i8]* %t860 to i8*
  %t862 = bitcast i8* %t861 to %Expression*
  %t863 = load %Expression, %Expression* %t862
  %t864 = icmp eq i32 %t858, 19
  %t865 = select i1 %t864, %Expression %t863, %Expression zeroinitializer
  %t866 = getelementptr %Expression, %Expression* null, i32 1
  %t867 = ptrtoint %Expression* %t866 to i64
  %t868 = call noalias i8* @malloc(i64 %t867)
  %t869 = bitcast i8* %t868 to %Expression*
  store %Expression %t865, %Expression* %t869
  call void @sailfin_runtime_mark_persistent(i8* %t868)
  %t870 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t869)
  store { %EffectRequirement*, i64 }* %t870, { %EffectRequirement*, i64 }** %l7
  %t871 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t872 = extractvalue %Statement %statement, 0
  %t873 = alloca %Statement
  store %Statement %statement, %Statement* %t873
  %t874 = getelementptr inbounds %Statement, %Statement* %t873, i32 0, i32 1
  %t875 = bitcast [88 x i8]* %t874 to i8*
  %t876 = getelementptr inbounds i8, i8* %t875, i64 48
  %t877 = bitcast i8* %t876 to %Block*
  %t878 = load %Block, %Block* %t877
  %t879 = icmp eq i32 %t872, 19
  %t880 = select i1 %t879, %Block %t878, %Block zeroinitializer
  %t881 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t880)
  %t882 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t871, { %EffectRequirement*, i64 }* %t881)
  store { %EffectRequirement*, i64 }* %t882, { %EffectRequirement*, i64 }** %l7
  %t883 = extractvalue %Statement %statement, 0
  %t884 = alloca %Statement
  store %Statement %statement, %Statement* %t884
  %t885 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t886 = bitcast [88 x i8]* %t885 to i8*
  %t887 = getelementptr inbounds i8, i8* %t886, i64 72
  %t888 = bitcast i8* %t887 to %ElseBranch**
  %t889 = load %ElseBranch*, %ElseBranch** %t888
  %t890 = icmp eq i32 %t883, 19
  %t891 = select i1 %t890, %ElseBranch* %t889, %ElseBranch* null
  store %ElseBranch* %t891, %ElseBranch** %l8
  %t892 = load %ElseBranch*, %ElseBranch** %l8
  %t893 = icmp eq %ElseBranch* %t892, null
  %t894 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t895 = load %ElseBranch*, %ElseBranch** %l8
  br i1 %t893, label %then24, label %merge25
then24:
  %t896 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t896
merge25:
  %t897 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t898 = load %ElseBranch*, %ElseBranch** %l8
  %t899 = load %ElseBranch, %ElseBranch* %t898
  %t900 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %t899)
  %t901 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t897, { %EffectRequirement*, i64 }* %t900)
  store { %EffectRequirement*, i64 }* %t901, { %EffectRequirement*, i64 }** %l7
  %t902 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t902
merge23:
  %t903 = extractvalue %Statement %statement, 0
  %t904 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t905 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t903, 0
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t903, 1
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t903, 2
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t903, 3
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t903, 4
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t903, 5
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t903, 6
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t903, 7
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t903, 8
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t903, 9
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t903, 10
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t903, 11
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t903, 12
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t903, 13
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t903, 14
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t903, 15
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t903, 16
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t903, 17
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t903, 18
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t903, 19
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t903, 20
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t903, 21
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t903, 22
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = call i8* @malloc(i64 16)
  %t975 = bitcast i8* %t974 to [16 x i8]*
  store [16 x i8] c"ReturnStatement\00", [16 x i8]* %t975
  %t976 = call i1 @strings_equal(i8* %t973, i8* %t974)
  br i1 %t976, label %then26, label %merge27
then26:
  %t977 = extractvalue %Statement %statement, 0
  %t978 = alloca %Statement
  store %Statement %statement, %Statement* %t978
  %t979 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t980 = bitcast [16 x i8]* %t979 to i8*
  %t981 = bitcast i8* %t980 to %Expression**
  %t982 = load %Expression*, %Expression** %t981
  %t983 = icmp eq i32 %t977, 20
  %t984 = select i1 %t983, %Expression* %t982, %Expression* null
  %t985 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t984)
  ret { %EffectRequirement*, i64 }* %t985
merge27:
  %t986 = extractvalue %Statement %statement, 0
  %t987 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t988 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t986, 0
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t986, 1
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t986, 2
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t986, 3
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t986, 4
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t986, 5
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t986, 6
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t986, 7
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t986, 8
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t986, 9
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t986, 10
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t986, 11
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t986, 12
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t986, 13
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t986, 14
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t986, 15
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t986, 16
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t986, 17
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t986, 18
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t986, 19
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t986, 20
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t986, 21
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t986, 22
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = call i8* @malloc(i64 20)
  %t1058 = bitcast i8* %t1057 to [20 x i8]*
  store [20 x i8] c"ExpressionStatement\00", [20 x i8]* %t1058
  %t1059 = call i1 @strings_equal(i8* %t1056, i8* %t1057)
  br i1 %t1059, label %then28, label %merge29
then28:
  %t1060 = extractvalue %Statement %statement, 0
  %t1061 = alloca %Statement
  store %Statement %statement, %Statement* %t1061
  %t1062 = getelementptr inbounds %Statement, %Statement* %t1061, i32 0, i32 1
  %t1063 = bitcast [16 x i8]* %t1062 to i8*
  %t1064 = bitcast i8* %t1063 to %Expression**
  %t1065 = load %Expression*, %Expression** %t1064
  %t1066 = icmp eq i32 %t1060, 20
  %t1067 = select i1 %t1066, %Expression* %t1065, %Expression* null
  %t1068 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1067)
  ret { %EffectRequirement*, i64 }* %t1068
merge29:
  %t1069 = extractvalue %Statement %statement, 0
  %t1070 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1071 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1069, 0
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1069, 1
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1069, 2
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1069, 3
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1069, 4
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1069, 5
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1069, 6
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1069, 7
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1069, 8
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1069, 9
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1069, 10
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1069, 11
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1069, 12
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1069, 13
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1069, 14
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1069, 15
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1069, 16
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1069, 17
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1069, 18
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1069, 19
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1069, 20
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1069, 21
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1069, 22
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = call i8* @malloc(i64 20)
  %t1141 = bitcast i8* %t1140 to [20 x i8]*
  store [20 x i8] c"VariableDeclaration\00", [20 x i8]* %t1141
  %t1142 = call i1 @strings_equal(i8* %t1139, i8* %t1140)
  br i1 %t1142, label %then30, label %merge31
then30:
  %t1143 = extractvalue %Statement %statement, 0
  %t1144 = alloca %Statement
  store %Statement %statement, %Statement* %t1144
  %t1145 = getelementptr inbounds %Statement, %Statement* %t1144, i32 0, i32 1
  %t1146 = bitcast [48 x i8]* %t1145 to i8*
  %t1147 = getelementptr inbounds i8, i8* %t1146, i64 24
  %t1148 = bitcast i8* %t1147 to %Expression**
  %t1149 = load %Expression*, %Expression** %t1148
  %t1150 = icmp eq i32 %t1143, 2
  %t1151 = select i1 %t1150, %Expression* %t1149, %Expression* null
  %t1152 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1151)
  ret { %EffectRequirement*, i64 }* %t1152
merge31:
  %t1153 = extractvalue %Statement %statement, 0
  %t1154 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1155 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1153, 0
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1153, 1
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1153, 2
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1153, 3
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1153, 4
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1153, 5
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1153, 6
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1153, 7
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1153, 8
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1153, 9
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1153, 10
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1153, 11
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1153, 12
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1153, 13
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1153, 14
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1153, 15
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1153, 16
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1153, 17
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1153, 18
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1153, 19
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1153, 20
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1153, 21
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1153, 22
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = call i8* @malloc(i64 20)
  %t1225 = bitcast i8* %t1224 to [20 x i8]*
  store [20 x i8] c"FunctionDeclaration\00", [20 x i8]* %t1225
  %t1226 = call i1 @strings_equal(i8* %t1223, i8* %t1224)
  br i1 %t1226, label %then32, label %merge33
then32:
  %t1227 = extractvalue %Statement %statement, 0
  %t1228 = alloca %Statement
  store %Statement %statement, %Statement* %t1228
  %t1229 = getelementptr inbounds %Statement, %Statement* %t1228, i32 0, i32 1
  %t1230 = bitcast [88 x i8]* %t1229 to i8*
  %t1231 = getelementptr inbounds i8, i8* %t1230, i64 56
  %t1232 = bitcast i8* %t1231 to %Block*
  %t1233 = load %Block, %Block* %t1232
  %t1234 = icmp eq i32 %t1227, 4
  %t1235 = select i1 %t1234, %Block %t1233, %Block zeroinitializer
  %t1236 = getelementptr inbounds %Statement, %Statement* %t1228, i32 0, i32 1
  %t1237 = bitcast [88 x i8]* %t1236 to i8*
  %t1238 = getelementptr inbounds i8, i8* %t1237, i64 56
  %t1239 = bitcast i8* %t1238 to %Block*
  %t1240 = load %Block, %Block* %t1239
  %t1241 = icmp eq i32 %t1227, 5
  %t1242 = select i1 %t1241, %Block %t1240, %Block %t1235
  %t1243 = getelementptr inbounds %Statement, %Statement* %t1228, i32 0, i32 1
  %t1244 = bitcast [56 x i8]* %t1243 to i8*
  %t1245 = getelementptr inbounds i8, i8* %t1244, i64 16
  %t1246 = bitcast i8* %t1245 to %Block*
  %t1247 = load %Block, %Block* %t1246
  %t1248 = icmp eq i32 %t1227, 6
  %t1249 = select i1 %t1248, %Block %t1247, %Block %t1242
  %t1250 = getelementptr inbounds %Statement, %Statement* %t1228, i32 0, i32 1
  %t1251 = bitcast [88 x i8]* %t1250 to i8*
  %t1252 = getelementptr inbounds i8, i8* %t1251, i64 56
  %t1253 = bitcast i8* %t1252 to %Block*
  %t1254 = load %Block, %Block* %t1253
  %t1255 = icmp eq i32 %t1227, 7
  %t1256 = select i1 %t1255, %Block %t1254, %Block %t1249
  %t1257 = getelementptr inbounds %Statement, %Statement* %t1228, i32 0, i32 1
  %t1258 = bitcast [120 x i8]* %t1257 to i8*
  %t1259 = getelementptr inbounds i8, i8* %t1258, i64 88
  %t1260 = bitcast i8* %t1259 to %Block*
  %t1261 = load %Block, %Block* %t1260
  %t1262 = icmp eq i32 %t1227, 12
  %t1263 = select i1 %t1262, %Block %t1261, %Block %t1256
  %t1264 = getelementptr inbounds %Statement, %Statement* %t1228, i32 0, i32 1
  %t1265 = bitcast [40 x i8]* %t1264 to i8*
  %t1266 = getelementptr inbounds i8, i8* %t1265, i64 8
  %t1267 = bitcast i8* %t1266 to %Block*
  %t1268 = load %Block, %Block* %t1267
  %t1269 = icmp eq i32 %t1227, 13
  %t1270 = select i1 %t1269, %Block %t1268, %Block %t1263
  %t1271 = getelementptr inbounds %Statement, %Statement* %t1228, i32 0, i32 1
  %t1272 = bitcast [136 x i8]* %t1271 to i8*
  %t1273 = getelementptr inbounds i8, i8* %t1272, i64 104
  %t1274 = bitcast i8* %t1273 to %Block*
  %t1275 = load %Block, %Block* %t1274
  %t1276 = icmp eq i32 %t1227, 14
  %t1277 = select i1 %t1276, %Block %t1275, %Block %t1270
  %t1278 = getelementptr inbounds %Statement, %Statement* %t1228, i32 0, i32 1
  %t1279 = bitcast [32 x i8]* %t1278 to i8*
  %t1280 = bitcast i8* %t1279 to %Block*
  %t1281 = load %Block, %Block* %t1280
  %t1282 = icmp eq i32 %t1227, 15
  %t1283 = select i1 %t1282, %Block %t1281, %Block %t1277
  %t1284 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1283)
  ret { %EffectRequirement*, i64 }* %t1284
merge33:
  %t1285 = extractvalue %Statement %statement, 0
  %t1286 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1287 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1285, 0
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1285, 1
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1285, 2
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1285, 3
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1285, 4
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1285, 5
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1285, 6
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1285, 7
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1285, 8
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1285, 9
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1285, 10
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1285, 11
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1285, 12
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1285, 13
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1285, 14
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1285, 15
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1285, 16
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1285, 17
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1285, 18
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1285, 19
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1285, 20
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1285, 21
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1285, 22
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %t1356 = call i8* @malloc(i64 20)
  %t1357 = bitcast i8* %t1356 to [20 x i8]*
  store [20 x i8] c"PipelineDeclaration\00", [20 x i8]* %t1357
  %t1358 = call i1 @strings_equal(i8* %t1355, i8* %t1356)
  br i1 %t1358, label %then34, label %merge35
then34:
  %t1359 = extractvalue %Statement %statement, 0
  %t1360 = alloca %Statement
  store %Statement %statement, %Statement* %t1360
  %t1361 = getelementptr inbounds %Statement, %Statement* %t1360, i32 0, i32 1
  %t1362 = bitcast [88 x i8]* %t1361 to i8*
  %t1363 = getelementptr inbounds i8, i8* %t1362, i64 56
  %t1364 = bitcast i8* %t1363 to %Block*
  %t1365 = load %Block, %Block* %t1364
  %t1366 = icmp eq i32 %t1359, 4
  %t1367 = select i1 %t1366, %Block %t1365, %Block zeroinitializer
  %t1368 = getelementptr inbounds %Statement, %Statement* %t1360, i32 0, i32 1
  %t1369 = bitcast [88 x i8]* %t1368 to i8*
  %t1370 = getelementptr inbounds i8, i8* %t1369, i64 56
  %t1371 = bitcast i8* %t1370 to %Block*
  %t1372 = load %Block, %Block* %t1371
  %t1373 = icmp eq i32 %t1359, 5
  %t1374 = select i1 %t1373, %Block %t1372, %Block %t1367
  %t1375 = getelementptr inbounds %Statement, %Statement* %t1360, i32 0, i32 1
  %t1376 = bitcast [56 x i8]* %t1375 to i8*
  %t1377 = getelementptr inbounds i8, i8* %t1376, i64 16
  %t1378 = bitcast i8* %t1377 to %Block*
  %t1379 = load %Block, %Block* %t1378
  %t1380 = icmp eq i32 %t1359, 6
  %t1381 = select i1 %t1380, %Block %t1379, %Block %t1374
  %t1382 = getelementptr inbounds %Statement, %Statement* %t1360, i32 0, i32 1
  %t1383 = bitcast [88 x i8]* %t1382 to i8*
  %t1384 = getelementptr inbounds i8, i8* %t1383, i64 56
  %t1385 = bitcast i8* %t1384 to %Block*
  %t1386 = load %Block, %Block* %t1385
  %t1387 = icmp eq i32 %t1359, 7
  %t1388 = select i1 %t1387, %Block %t1386, %Block %t1381
  %t1389 = getelementptr inbounds %Statement, %Statement* %t1360, i32 0, i32 1
  %t1390 = bitcast [120 x i8]* %t1389 to i8*
  %t1391 = getelementptr inbounds i8, i8* %t1390, i64 88
  %t1392 = bitcast i8* %t1391 to %Block*
  %t1393 = load %Block, %Block* %t1392
  %t1394 = icmp eq i32 %t1359, 12
  %t1395 = select i1 %t1394, %Block %t1393, %Block %t1388
  %t1396 = getelementptr inbounds %Statement, %Statement* %t1360, i32 0, i32 1
  %t1397 = bitcast [40 x i8]* %t1396 to i8*
  %t1398 = getelementptr inbounds i8, i8* %t1397, i64 8
  %t1399 = bitcast i8* %t1398 to %Block*
  %t1400 = load %Block, %Block* %t1399
  %t1401 = icmp eq i32 %t1359, 13
  %t1402 = select i1 %t1401, %Block %t1400, %Block %t1395
  %t1403 = getelementptr inbounds %Statement, %Statement* %t1360, i32 0, i32 1
  %t1404 = bitcast [136 x i8]* %t1403 to i8*
  %t1405 = getelementptr inbounds i8, i8* %t1404, i64 104
  %t1406 = bitcast i8* %t1405 to %Block*
  %t1407 = load %Block, %Block* %t1406
  %t1408 = icmp eq i32 %t1359, 14
  %t1409 = select i1 %t1408, %Block %t1407, %Block %t1402
  %t1410 = getelementptr inbounds %Statement, %Statement* %t1360, i32 0, i32 1
  %t1411 = bitcast [32 x i8]* %t1410 to i8*
  %t1412 = bitcast i8* %t1411 to %Block*
  %t1413 = load %Block, %Block* %t1412
  %t1414 = icmp eq i32 %t1359, 15
  %t1415 = select i1 %t1414, %Block %t1413, %Block %t1409
  %t1416 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1415)
  ret { %EffectRequirement*, i64 }* %t1416
merge35:
  %t1417 = extractvalue %Statement %statement, 0
  %t1418 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1419 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1417, 0
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1417, 1
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1417, 2
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1417, 3
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1417, 4
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1417, 5
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1417, 6
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1417, 7
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1417, 8
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1417, 9
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1417, 10
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1417, 11
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1417, 12
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1417, 13
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1417, 14
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1417, 15
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1417, 16
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1417, 17
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1417, 18
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1417, 19
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1417, 20
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1417, 21
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1417, 22
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = call i8* @malloc(i64 16)
  %t1489 = bitcast i8* %t1488 to [16 x i8]*
  store [16 x i8] c"ToolDeclaration\00", [16 x i8]* %t1489
  %t1490 = call i1 @strings_equal(i8* %t1487, i8* %t1488)
  br i1 %t1490, label %then36, label %merge37
then36:
  %t1491 = extractvalue %Statement %statement, 0
  %t1492 = alloca %Statement
  store %Statement %statement, %Statement* %t1492
  %t1493 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1494 = bitcast [88 x i8]* %t1493 to i8*
  %t1495 = getelementptr inbounds i8, i8* %t1494, i64 56
  %t1496 = bitcast i8* %t1495 to %Block*
  %t1497 = load %Block, %Block* %t1496
  %t1498 = icmp eq i32 %t1491, 4
  %t1499 = select i1 %t1498, %Block %t1497, %Block zeroinitializer
  %t1500 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1501 = bitcast [88 x i8]* %t1500 to i8*
  %t1502 = getelementptr inbounds i8, i8* %t1501, i64 56
  %t1503 = bitcast i8* %t1502 to %Block*
  %t1504 = load %Block, %Block* %t1503
  %t1505 = icmp eq i32 %t1491, 5
  %t1506 = select i1 %t1505, %Block %t1504, %Block %t1499
  %t1507 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1508 = bitcast [56 x i8]* %t1507 to i8*
  %t1509 = getelementptr inbounds i8, i8* %t1508, i64 16
  %t1510 = bitcast i8* %t1509 to %Block*
  %t1511 = load %Block, %Block* %t1510
  %t1512 = icmp eq i32 %t1491, 6
  %t1513 = select i1 %t1512, %Block %t1511, %Block %t1506
  %t1514 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1515 = bitcast [88 x i8]* %t1514 to i8*
  %t1516 = getelementptr inbounds i8, i8* %t1515, i64 56
  %t1517 = bitcast i8* %t1516 to %Block*
  %t1518 = load %Block, %Block* %t1517
  %t1519 = icmp eq i32 %t1491, 7
  %t1520 = select i1 %t1519, %Block %t1518, %Block %t1513
  %t1521 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1522 = bitcast [120 x i8]* %t1521 to i8*
  %t1523 = getelementptr inbounds i8, i8* %t1522, i64 88
  %t1524 = bitcast i8* %t1523 to %Block*
  %t1525 = load %Block, %Block* %t1524
  %t1526 = icmp eq i32 %t1491, 12
  %t1527 = select i1 %t1526, %Block %t1525, %Block %t1520
  %t1528 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1529 = bitcast [40 x i8]* %t1528 to i8*
  %t1530 = getelementptr inbounds i8, i8* %t1529, i64 8
  %t1531 = bitcast i8* %t1530 to %Block*
  %t1532 = load %Block, %Block* %t1531
  %t1533 = icmp eq i32 %t1491, 13
  %t1534 = select i1 %t1533, %Block %t1532, %Block %t1527
  %t1535 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1536 = bitcast [136 x i8]* %t1535 to i8*
  %t1537 = getelementptr inbounds i8, i8* %t1536, i64 104
  %t1538 = bitcast i8* %t1537 to %Block*
  %t1539 = load %Block, %Block* %t1538
  %t1540 = icmp eq i32 %t1491, 14
  %t1541 = select i1 %t1540, %Block %t1539, %Block %t1534
  %t1542 = getelementptr inbounds %Statement, %Statement* %t1492, i32 0, i32 1
  %t1543 = bitcast [32 x i8]* %t1542 to i8*
  %t1544 = bitcast i8* %t1543 to %Block*
  %t1545 = load %Block, %Block* %t1544
  %t1546 = icmp eq i32 %t1491, 15
  %t1547 = select i1 %t1546, %Block %t1545, %Block %t1541
  %t1548 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1547)
  ret { %EffectRequirement*, i64 }* %t1548
merge37:
  %t1549 = extractvalue %Statement %statement, 0
  %t1550 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1551 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1549, 0
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1549, 1
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1549, 2
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1549, 3
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %t1563 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1564 = icmp eq i32 %t1549, 4
  %t1565 = select i1 %t1564, i8* %t1563, i8* %t1562
  %t1566 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1567 = icmp eq i32 %t1549, 5
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1565
  %t1569 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1570 = icmp eq i32 %t1549, 6
  %t1571 = select i1 %t1570, i8* %t1569, i8* %t1568
  %t1572 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1573 = icmp eq i32 %t1549, 7
  %t1574 = select i1 %t1573, i8* %t1572, i8* %t1571
  %t1575 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1576 = icmp eq i32 %t1549, 8
  %t1577 = select i1 %t1576, i8* %t1575, i8* %t1574
  %t1578 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1579 = icmp eq i32 %t1549, 9
  %t1580 = select i1 %t1579, i8* %t1578, i8* %t1577
  %t1581 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1582 = icmp eq i32 %t1549, 10
  %t1583 = select i1 %t1582, i8* %t1581, i8* %t1580
  %t1584 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1585 = icmp eq i32 %t1549, 11
  %t1586 = select i1 %t1585, i8* %t1584, i8* %t1583
  %t1587 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1588 = icmp eq i32 %t1549, 12
  %t1589 = select i1 %t1588, i8* %t1587, i8* %t1586
  %t1590 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1591 = icmp eq i32 %t1549, 13
  %t1592 = select i1 %t1591, i8* %t1590, i8* %t1589
  %t1593 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1594 = icmp eq i32 %t1549, 14
  %t1595 = select i1 %t1594, i8* %t1593, i8* %t1592
  %t1596 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1597 = icmp eq i32 %t1549, 15
  %t1598 = select i1 %t1597, i8* %t1596, i8* %t1595
  %t1599 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1600 = icmp eq i32 %t1549, 16
  %t1601 = select i1 %t1600, i8* %t1599, i8* %t1598
  %t1602 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1603 = icmp eq i32 %t1549, 17
  %t1604 = select i1 %t1603, i8* %t1602, i8* %t1601
  %t1605 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1606 = icmp eq i32 %t1549, 18
  %t1607 = select i1 %t1606, i8* %t1605, i8* %t1604
  %t1608 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1609 = icmp eq i32 %t1549, 19
  %t1610 = select i1 %t1609, i8* %t1608, i8* %t1607
  %t1611 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1612 = icmp eq i32 %t1549, 20
  %t1613 = select i1 %t1612, i8* %t1611, i8* %t1610
  %t1614 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1615 = icmp eq i32 %t1549, 21
  %t1616 = select i1 %t1615, i8* %t1614, i8* %t1613
  %t1617 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1618 = icmp eq i32 %t1549, 22
  %t1619 = select i1 %t1618, i8* %t1617, i8* %t1616
  %t1620 = call i8* @malloc(i64 16)
  %t1621 = bitcast i8* %t1620 to [16 x i8]*
  store [16 x i8] c"TestDeclaration\00", [16 x i8]* %t1621
  %t1622 = call i1 @strings_equal(i8* %t1619, i8* %t1620)
  br i1 %t1622, label %then38, label %merge39
then38:
  %t1623 = extractvalue %Statement %statement, 0
  %t1624 = alloca %Statement
  store %Statement %statement, %Statement* %t1624
  %t1625 = getelementptr inbounds %Statement, %Statement* %t1624, i32 0, i32 1
  %t1626 = bitcast [88 x i8]* %t1625 to i8*
  %t1627 = getelementptr inbounds i8, i8* %t1626, i64 56
  %t1628 = bitcast i8* %t1627 to %Block*
  %t1629 = load %Block, %Block* %t1628
  %t1630 = icmp eq i32 %t1623, 4
  %t1631 = select i1 %t1630, %Block %t1629, %Block zeroinitializer
  %t1632 = getelementptr inbounds %Statement, %Statement* %t1624, i32 0, i32 1
  %t1633 = bitcast [88 x i8]* %t1632 to i8*
  %t1634 = getelementptr inbounds i8, i8* %t1633, i64 56
  %t1635 = bitcast i8* %t1634 to %Block*
  %t1636 = load %Block, %Block* %t1635
  %t1637 = icmp eq i32 %t1623, 5
  %t1638 = select i1 %t1637, %Block %t1636, %Block %t1631
  %t1639 = getelementptr inbounds %Statement, %Statement* %t1624, i32 0, i32 1
  %t1640 = bitcast [56 x i8]* %t1639 to i8*
  %t1641 = getelementptr inbounds i8, i8* %t1640, i64 16
  %t1642 = bitcast i8* %t1641 to %Block*
  %t1643 = load %Block, %Block* %t1642
  %t1644 = icmp eq i32 %t1623, 6
  %t1645 = select i1 %t1644, %Block %t1643, %Block %t1638
  %t1646 = getelementptr inbounds %Statement, %Statement* %t1624, i32 0, i32 1
  %t1647 = bitcast [88 x i8]* %t1646 to i8*
  %t1648 = getelementptr inbounds i8, i8* %t1647, i64 56
  %t1649 = bitcast i8* %t1648 to %Block*
  %t1650 = load %Block, %Block* %t1649
  %t1651 = icmp eq i32 %t1623, 7
  %t1652 = select i1 %t1651, %Block %t1650, %Block %t1645
  %t1653 = getelementptr inbounds %Statement, %Statement* %t1624, i32 0, i32 1
  %t1654 = bitcast [120 x i8]* %t1653 to i8*
  %t1655 = getelementptr inbounds i8, i8* %t1654, i64 88
  %t1656 = bitcast i8* %t1655 to %Block*
  %t1657 = load %Block, %Block* %t1656
  %t1658 = icmp eq i32 %t1623, 12
  %t1659 = select i1 %t1658, %Block %t1657, %Block %t1652
  %t1660 = getelementptr inbounds %Statement, %Statement* %t1624, i32 0, i32 1
  %t1661 = bitcast [40 x i8]* %t1660 to i8*
  %t1662 = getelementptr inbounds i8, i8* %t1661, i64 8
  %t1663 = bitcast i8* %t1662 to %Block*
  %t1664 = load %Block, %Block* %t1663
  %t1665 = icmp eq i32 %t1623, 13
  %t1666 = select i1 %t1665, %Block %t1664, %Block %t1659
  %t1667 = getelementptr inbounds %Statement, %Statement* %t1624, i32 0, i32 1
  %t1668 = bitcast [136 x i8]* %t1667 to i8*
  %t1669 = getelementptr inbounds i8, i8* %t1668, i64 104
  %t1670 = bitcast i8* %t1669 to %Block*
  %t1671 = load %Block, %Block* %t1670
  %t1672 = icmp eq i32 %t1623, 14
  %t1673 = select i1 %t1672, %Block %t1671, %Block %t1666
  %t1674 = getelementptr inbounds %Statement, %Statement* %t1624, i32 0, i32 1
  %t1675 = bitcast [32 x i8]* %t1674 to i8*
  %t1676 = bitcast i8* %t1675 to %Block*
  %t1677 = load %Block, %Block* %t1676
  %t1678 = icmp eq i32 %t1623, 15
  %t1679 = select i1 %t1678, %Block %t1677, %Block %t1673
  %t1680 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1679)
  ret { %EffectRequirement*, i64 }* %t1680
merge39:
  %t1681 = extractvalue %Statement %statement, 0
  %t1682 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1683 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1684 = icmp eq i32 %t1681, 0
  %t1685 = select i1 %t1684, i8* %t1683, i8* %t1682
  %t1686 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1687 = icmp eq i32 %t1681, 1
  %t1688 = select i1 %t1687, i8* %t1686, i8* %t1685
  %t1689 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1690 = icmp eq i32 %t1681, 2
  %t1691 = select i1 %t1690, i8* %t1689, i8* %t1688
  %t1692 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1693 = icmp eq i32 %t1681, 3
  %t1694 = select i1 %t1693, i8* %t1692, i8* %t1691
  %t1695 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1696 = icmp eq i32 %t1681, 4
  %t1697 = select i1 %t1696, i8* %t1695, i8* %t1694
  %t1698 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1699 = icmp eq i32 %t1681, 5
  %t1700 = select i1 %t1699, i8* %t1698, i8* %t1697
  %t1701 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1702 = icmp eq i32 %t1681, 6
  %t1703 = select i1 %t1702, i8* %t1701, i8* %t1700
  %t1704 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1705 = icmp eq i32 %t1681, 7
  %t1706 = select i1 %t1705, i8* %t1704, i8* %t1703
  %t1707 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1708 = icmp eq i32 %t1681, 8
  %t1709 = select i1 %t1708, i8* %t1707, i8* %t1706
  %t1710 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1711 = icmp eq i32 %t1681, 9
  %t1712 = select i1 %t1711, i8* %t1710, i8* %t1709
  %t1713 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1714 = icmp eq i32 %t1681, 10
  %t1715 = select i1 %t1714, i8* %t1713, i8* %t1712
  %t1716 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1717 = icmp eq i32 %t1681, 11
  %t1718 = select i1 %t1717, i8* %t1716, i8* %t1715
  %t1719 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1720 = icmp eq i32 %t1681, 12
  %t1721 = select i1 %t1720, i8* %t1719, i8* %t1718
  %t1722 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1723 = icmp eq i32 %t1681, 13
  %t1724 = select i1 %t1723, i8* %t1722, i8* %t1721
  %t1725 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1726 = icmp eq i32 %t1681, 14
  %t1727 = select i1 %t1726, i8* %t1725, i8* %t1724
  %t1728 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1729 = icmp eq i32 %t1681, 15
  %t1730 = select i1 %t1729, i8* %t1728, i8* %t1727
  %t1731 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1732 = icmp eq i32 %t1681, 16
  %t1733 = select i1 %t1732, i8* %t1731, i8* %t1730
  %t1734 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1735 = icmp eq i32 %t1681, 17
  %t1736 = select i1 %t1735, i8* %t1734, i8* %t1733
  %t1737 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1738 = icmp eq i32 %t1681, 18
  %t1739 = select i1 %t1738, i8* %t1737, i8* %t1736
  %t1740 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1741 = icmp eq i32 %t1681, 19
  %t1742 = select i1 %t1741, i8* %t1740, i8* %t1739
  %t1743 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1744 = icmp eq i32 %t1681, 20
  %t1745 = select i1 %t1744, i8* %t1743, i8* %t1742
  %t1746 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1747 = icmp eq i32 %t1681, 21
  %t1748 = select i1 %t1747, i8* %t1746, i8* %t1745
  %t1749 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1750 = icmp eq i32 %t1681, 22
  %t1751 = select i1 %t1750, i8* %t1749, i8* %t1748
  %t1752 = call i8* @malloc(i64 18)
  %t1753 = bitcast i8* %t1752 to [18 x i8]*
  store [18 x i8] c"StructDeclaration\00", [18 x i8]* %t1753
  %t1754 = call i1 @strings_equal(i8* %t1751, i8* %t1752)
  br i1 %t1754, label %then40, label %merge41
then40:
  %t1755 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1756 = ptrtoint [0 x %EffectRequirement]* %t1755 to i64
  %t1757 = icmp eq i64 %t1756, 0
  %t1758 = select i1 %t1757, i64 1, i64 %t1756
  %t1759 = call i8* @malloc(i64 %t1758)
  %t1760 = bitcast i8* %t1759 to %EffectRequirement*
  %t1761 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1762 = ptrtoint { %EffectRequirement*, i64 }* %t1761 to i64
  %t1763 = call i8* @malloc(i64 %t1762)
  %t1764 = bitcast i8* %t1763 to { %EffectRequirement*, i64 }*
  %t1765 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1764, i32 0, i32 0
  store %EffectRequirement* %t1760, %EffectRequirement** %t1765
  %t1766 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1764, i32 0, i32 1
  store i64 0, i64* %t1766
  store { %EffectRequirement*, i64 }* %t1764, { %EffectRequirement*, i64 }** %l9
  %t1767 = sitofp i64 0 to double
  store double %t1767, double* %l10
  %t1768 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1769 = load double, double* %l10
  br label %loop.header42
loop.header42:
  %t1813 = phi { %EffectRequirement*, i64 }* [ %t1768, %then40 ], [ %t1811, %loop.latch44 ]
  %t1814 = phi double [ %t1769, %then40 ], [ %t1812, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1813, { %EffectRequirement*, i64 }** %l9
  store double %t1814, double* %l10
  br label %loop.body43
loop.body43:
  %t1770 = load double, double* %l10
  %t1771 = extractvalue %Statement %statement, 0
  %t1772 = alloca %Statement
  store %Statement %statement, %Statement* %t1772
  %t1773 = getelementptr inbounds %Statement, %Statement* %t1772, i32 0, i32 1
  %t1774 = bitcast [56 x i8]* %t1773 to i8*
  %t1775 = getelementptr inbounds i8, i8* %t1774, i64 40
  %t1776 = bitcast i8* %t1775 to { %MethodDeclaration*, i64 }**
  %t1777 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1776
  %t1778 = icmp eq i32 %t1771, 8
  %t1779 = select i1 %t1778, { %MethodDeclaration*, i64 }* %t1777, { %MethodDeclaration*, i64 }* null
  %t1780 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1779
  %t1781 = extractvalue { %MethodDeclaration*, i64 } %t1780, 1
  %t1782 = sitofp i64 %t1781 to double
  %t1783 = fcmp oge double %t1770, %t1782
  %t1784 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1785 = load double, double* %l10
  br i1 %t1783, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1786 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1787 = extractvalue %Statement %statement, 0
  %t1788 = alloca %Statement
  store %Statement %statement, %Statement* %t1788
  %t1789 = getelementptr inbounds %Statement, %Statement* %t1788, i32 0, i32 1
  %t1790 = bitcast [56 x i8]* %t1789 to i8*
  %t1791 = getelementptr inbounds i8, i8* %t1790, i64 40
  %t1792 = bitcast i8* %t1791 to { %MethodDeclaration*, i64 }**
  %t1793 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1792
  %t1794 = icmp eq i32 %t1787, 8
  %t1795 = select i1 %t1794, { %MethodDeclaration*, i64 }* %t1793, { %MethodDeclaration*, i64 }* null
  %t1796 = load double, double* %l10
  %t1797 = call double @llvm.round.f64(double %t1796)
  %t1798 = fptosi double %t1797 to i64
  %t1799 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1795
  %t1800 = extractvalue { %MethodDeclaration*, i64 } %t1799, 0
  %t1801 = extractvalue { %MethodDeclaration*, i64 } %t1799, 1
  %t1802 = icmp uge i64 %t1798, %t1801
  ; bounds check: %t1802 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1798, i64 %t1801)
  %t1803 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1800, i64 %t1798
  %t1804 = load %MethodDeclaration, %MethodDeclaration* %t1803
  %t1805 = extractvalue %MethodDeclaration %t1804, 1
  %t1806 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1805)
  %t1807 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1786, { %EffectRequirement*, i64 }* %t1806)
  store { %EffectRequirement*, i64 }* %t1807, { %EffectRequirement*, i64 }** %l9
  %t1808 = load double, double* %l10
  %t1809 = sitofp i64 1 to double
  %t1810 = fadd double %t1808, %t1809
  store double %t1810, double* %l10
  br label %loop.latch44
loop.latch44:
  %t1811 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1812 = load double, double* %l10
  br label %loop.header42
afterloop45:
  %t1815 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1816 = load double, double* %l10
  %t1817 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t1817
merge41:
  %t1818 = extractvalue %Statement %statement, 0
  %t1819 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1820 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1818, 0
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1818, 1
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1818, 2
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1818, 3
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1818, 4
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1818, 5
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1818, 6
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1818, 7
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1818, 8
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1818, 9
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1818, 10
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %t1853 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1818, 11
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %t1856 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1857 = icmp eq i32 %t1818, 12
  %t1858 = select i1 %t1857, i8* %t1856, i8* %t1855
  %t1859 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1860 = icmp eq i32 %t1818, 13
  %t1861 = select i1 %t1860, i8* %t1859, i8* %t1858
  %t1862 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1863 = icmp eq i32 %t1818, 14
  %t1864 = select i1 %t1863, i8* %t1862, i8* %t1861
  %t1865 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1866 = icmp eq i32 %t1818, 15
  %t1867 = select i1 %t1866, i8* %t1865, i8* %t1864
  %t1868 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1869 = icmp eq i32 %t1818, 16
  %t1870 = select i1 %t1869, i8* %t1868, i8* %t1867
  %t1871 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1872 = icmp eq i32 %t1818, 17
  %t1873 = select i1 %t1872, i8* %t1871, i8* %t1870
  %t1874 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1875 = icmp eq i32 %t1818, 18
  %t1876 = select i1 %t1875, i8* %t1874, i8* %t1873
  %t1877 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1878 = icmp eq i32 %t1818, 19
  %t1879 = select i1 %t1878, i8* %t1877, i8* %t1876
  %t1880 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1881 = icmp eq i32 %t1818, 20
  %t1882 = select i1 %t1881, i8* %t1880, i8* %t1879
  %t1883 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1884 = icmp eq i32 %t1818, 21
  %t1885 = select i1 %t1884, i8* %t1883, i8* %t1882
  %t1886 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1887 = icmp eq i32 %t1818, 22
  %t1888 = select i1 %t1887, i8* %t1886, i8* %t1885
  %t1889 = call i8* @malloc(i64 17)
  %t1890 = bitcast i8* %t1889 to [17 x i8]*
  store [17 x i8] c"ModelDeclaration\00", [17 x i8]* %t1890
  %t1891 = call i1 @strings_equal(i8* %t1888, i8* %t1889)
  br i1 %t1891, label %then48, label %merge49
then48:
  %t1892 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1893 = ptrtoint [0 x %EffectRequirement]* %t1892 to i64
  %t1894 = icmp eq i64 %t1893, 0
  %t1895 = select i1 %t1894, i64 1, i64 %t1893
  %t1896 = call i8* @malloc(i64 %t1895)
  %t1897 = bitcast i8* %t1896 to %EffectRequirement*
  %t1898 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1899 = ptrtoint { %EffectRequirement*, i64 }* %t1898 to i64
  %t1900 = call i8* @malloc(i64 %t1899)
  %t1901 = bitcast i8* %t1900 to { %EffectRequirement*, i64 }*
  %t1902 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1901, i32 0, i32 0
  store %EffectRequirement* %t1897, %EffectRequirement** %t1902
  %t1903 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1901, i32 0, i32 1
  store i64 0, i64* %t1903
  store { %EffectRequirement*, i64 }* %t1901, { %EffectRequirement*, i64 }** %l11
  %t1904 = sitofp i64 0 to double
  store double %t1904, double* %l12
  %t1905 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1906 = load double, double* %l12
  br label %loop.header50
loop.header50:
  %t1954 = phi { %EffectRequirement*, i64 }* [ %t1905, %then48 ], [ %t1952, %loop.latch52 ]
  %t1955 = phi double [ %t1906, %then48 ], [ %t1953, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1954, { %EffectRequirement*, i64 }** %l11
  store double %t1955, double* %l12
  br label %loop.body51
loop.body51:
  %t1907 = load double, double* %l12
  %t1908 = extractvalue %Statement %statement, 0
  %t1909 = alloca %Statement
  store %Statement %statement, %Statement* %t1909
  %t1910 = getelementptr inbounds %Statement, %Statement* %t1909, i32 0, i32 1
  %t1911 = bitcast [48 x i8]* %t1910 to i8*
  %t1912 = getelementptr inbounds i8, i8* %t1911, i64 24
  %t1913 = bitcast i8* %t1912 to { %ModelProperty*, i64 }**
  %t1914 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t1913
  %t1915 = icmp eq i32 %t1908, 3
  %t1916 = select i1 %t1915, { %ModelProperty*, i64 }* %t1914, { %ModelProperty*, i64 }* null
  %t1917 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t1916
  %t1918 = extractvalue { %ModelProperty*, i64 } %t1917, 1
  %t1919 = sitofp i64 %t1918 to double
  %t1920 = fcmp oge double %t1907, %t1919
  %t1921 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1922 = load double, double* %l12
  br i1 %t1920, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1923 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1924 = extractvalue %Statement %statement, 0
  %t1925 = alloca %Statement
  store %Statement %statement, %Statement* %t1925
  %t1926 = getelementptr inbounds %Statement, %Statement* %t1925, i32 0, i32 1
  %t1927 = bitcast [48 x i8]* %t1926 to i8*
  %t1928 = getelementptr inbounds i8, i8* %t1927, i64 24
  %t1929 = bitcast i8* %t1928 to { %ModelProperty*, i64 }**
  %t1930 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t1929
  %t1931 = icmp eq i32 %t1924, 3
  %t1932 = select i1 %t1931, { %ModelProperty*, i64 }* %t1930, { %ModelProperty*, i64 }* null
  %t1933 = load double, double* %l12
  %t1934 = call double @llvm.round.f64(double %t1933)
  %t1935 = fptosi double %t1934 to i64
  %t1936 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t1932
  %t1937 = extractvalue { %ModelProperty*, i64 } %t1936, 0
  %t1938 = extractvalue { %ModelProperty*, i64 } %t1936, 1
  %t1939 = icmp uge i64 %t1935, %t1938
  ; bounds check: %t1939 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1935, i64 %t1938)
  %t1940 = getelementptr %ModelProperty, %ModelProperty* %t1937, i64 %t1935
  %t1941 = load %ModelProperty, %ModelProperty* %t1940
  %t1942 = extractvalue %ModelProperty %t1941, 1
  %t1943 = getelementptr %Expression, %Expression* null, i32 1
  %t1944 = ptrtoint %Expression* %t1943 to i64
  %t1945 = call noalias i8* @malloc(i64 %t1944)
  %t1946 = bitcast i8* %t1945 to %Expression*
  store %Expression %t1942, %Expression* %t1946
  call void @sailfin_runtime_mark_persistent(i8* %t1945)
  %t1947 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1946)
  %t1948 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1923, { %EffectRequirement*, i64 }* %t1947)
  store { %EffectRequirement*, i64 }* %t1948, { %EffectRequirement*, i64 }** %l11
  %t1949 = load double, double* %l12
  %t1950 = sitofp i64 1 to double
  %t1951 = fadd double %t1949, %t1950
  store double %t1951, double* %l12
  br label %loop.latch52
loop.latch52:
  %t1952 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1953 = load double, double* %l12
  br label %loop.header50
afterloop53:
  %t1956 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1957 = load double, double* %l12
  %t1958 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  ret { %EffectRequirement*, i64 }* %t1958
merge49:
  %t1959 = extractvalue %Statement %statement, 0
  %t1960 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1961 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1962 = icmp eq i32 %t1959, 0
  %t1963 = select i1 %t1962, i8* %t1961, i8* %t1960
  %t1964 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1965 = icmp eq i32 %t1959, 1
  %t1966 = select i1 %t1965, i8* %t1964, i8* %t1963
  %t1967 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1968 = icmp eq i32 %t1959, 2
  %t1969 = select i1 %t1968, i8* %t1967, i8* %t1966
  %t1970 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1971 = icmp eq i32 %t1959, 3
  %t1972 = select i1 %t1971, i8* %t1970, i8* %t1969
  %t1973 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1974 = icmp eq i32 %t1959, 4
  %t1975 = select i1 %t1974, i8* %t1973, i8* %t1972
  %t1976 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1977 = icmp eq i32 %t1959, 5
  %t1978 = select i1 %t1977, i8* %t1976, i8* %t1975
  %t1979 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1980 = icmp eq i32 %t1959, 6
  %t1981 = select i1 %t1980, i8* %t1979, i8* %t1978
  %t1982 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1983 = icmp eq i32 %t1959, 7
  %t1984 = select i1 %t1983, i8* %t1982, i8* %t1981
  %t1985 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1986 = icmp eq i32 %t1959, 8
  %t1987 = select i1 %t1986, i8* %t1985, i8* %t1984
  %t1988 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1989 = icmp eq i32 %t1959, 9
  %t1990 = select i1 %t1989, i8* %t1988, i8* %t1987
  %t1991 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1992 = icmp eq i32 %t1959, 10
  %t1993 = select i1 %t1992, i8* %t1991, i8* %t1990
  %t1994 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1995 = icmp eq i32 %t1959, 11
  %t1996 = select i1 %t1995, i8* %t1994, i8* %t1993
  %t1997 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1998 = icmp eq i32 %t1959, 12
  %t1999 = select i1 %t1998, i8* %t1997, i8* %t1996
  %t2000 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t2001 = icmp eq i32 %t1959, 13
  %t2002 = select i1 %t2001, i8* %t2000, i8* %t1999
  %t2003 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t2004 = icmp eq i32 %t1959, 14
  %t2005 = select i1 %t2004, i8* %t2003, i8* %t2002
  %t2006 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t2007 = icmp eq i32 %t1959, 15
  %t2008 = select i1 %t2007, i8* %t2006, i8* %t2005
  %t2009 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t2010 = icmp eq i32 %t1959, 16
  %t2011 = select i1 %t2010, i8* %t2009, i8* %t2008
  %t2012 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t2013 = icmp eq i32 %t1959, 17
  %t2014 = select i1 %t2013, i8* %t2012, i8* %t2011
  %t2015 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t2016 = icmp eq i32 %t1959, 18
  %t2017 = select i1 %t2016, i8* %t2015, i8* %t2014
  %t2018 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2019 = icmp eq i32 %t1959, 19
  %t2020 = select i1 %t2019, i8* %t2018, i8* %t2017
  %t2021 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2022 = icmp eq i32 %t1959, 20
  %t2023 = select i1 %t2022, i8* %t2021, i8* %t2020
  %t2024 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2025 = icmp eq i32 %t1959, 21
  %t2026 = select i1 %t2025, i8* %t2024, i8* %t2023
  %t2027 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2028 = icmp eq i32 %t1959, 22
  %t2029 = select i1 %t2028, i8* %t2027, i8* %t2026
  %t2030 = call i8* @malloc(i64 8)
  %t2031 = bitcast i8* %t2030 to [8 x i8]*
  store [8 x i8] c"Unknown\00", [8 x i8]* %t2031
  %t2032 = call i1 @strings_equal(i8* %t2029, i8* %t2030)
  br i1 %t2032, label %then56, label %merge57
then56:
  %t2033 = extractvalue %Statement %statement, 0
  %t2034 = alloca %Statement
  store %Statement %statement, %Statement* %t2034
  %t2035 = getelementptr inbounds %Statement, %Statement* %t2034, i32 0, i32 1
  %t2036 = bitcast [16 x i8]* %t2035 to i8*
  %t2037 = bitcast i8* %t2036 to { %Token*, i64 }**
  %t2038 = load { %Token*, i64 }*, { %Token*, i64 }** %t2037
  %t2039 = icmp eq i32 %t2033, 22
  %t2040 = select i1 %t2039, { %Token*, i64 }* %t2038, { %Token*, i64 }* null
  %t2041 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t2040)
  ret { %EffectRequirement*, i64 }* %t2041
merge57:
  %t2042 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t2043 = ptrtoint [0 x %EffectRequirement]* %t2042 to i64
  %t2044 = icmp eq i64 %t2043, 0
  %t2045 = select i1 %t2044, i64 1, i64 %t2043
  %t2046 = call i8* @malloc(i64 %t2045)
  %t2047 = bitcast i8* %t2046 to %EffectRequirement*
  %t2048 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t2049 = ptrtoint { %EffectRequirement*, i64 }* %t2048 to i64
  %t2050 = call i8* @malloc(i64 %t2049)
  %t2051 = bitcast i8* %t2050 to { %EffectRequirement*, i64 }*
  %t2052 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2051, i32 0, i32 0
  store %EffectRequirement* %t2047, %EffectRequirement** %t2052
  %t2053 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2051, i32 0, i32 1
  store i64 0, i64* %t2053
  ret { %EffectRequirement*, i64 }* %t2051
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
  %t0 = call i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect)
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}