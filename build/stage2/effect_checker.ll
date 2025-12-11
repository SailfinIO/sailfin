; ModuleID = 'sailfin'
source_filename = "sailfin"

%EffectRequirement = type { i8*, %Token*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { %EffectRequirement**, i64 }* }
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
%DecoratorArgumentInfo = type { i8*, %LiteralValue }
%DecoratorInfo = type { i8*, { %DecoratorArgumentInfo**, i64 }* }

%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }
%TokenKind = type { i32, [8 x i8] }
%LiteralValue = type { i32, [8 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare %Token @eof_token(double, double)
declare { i8**, i64 }* @infer_effects({ i8**, i64 }*, { %DecoratorInfo*, i64 }*)
declare { %DecoratorInfo*, i64 }* @evaluate_decorators({ %Decorator*, i64 }*)
declare { %DecoratorArgumentInfo*, i64 }* @evaluate_arguments({ %DecoratorArgument*, i64 }*)
declare %LiteralValue @evaluate_expression(%Expression)
declare { %DecoratorInfo*, i64 }* @evaluate_statement_decorators(%Statement)
declare i8* @trim_whitespace(i8*)
declare i1 @looks_like_quoted_string(i8*)
declare i1 @looks_like_number(i8*)
declare i1 @is_decimal_digit(i64)
declare { %DecoratorInfo*, i64 }* @append_decorator_info({ %DecoratorInfo*, i64 }*, %DecoratorInfo)
declare { %DecoratorArgumentInfo*, i64 }* @append_argument_info({ %DecoratorArgumentInfo*, i64 }*, %DecoratorArgumentInfo)
declare { i8**, i64 }* @append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @clone_effects({ i8**, i64 }*)
declare i1 @is_whitespace_char(i64)
declare i8* @slice_text(i8*, double, double)
declare i8* @strip_surrounding_quotes(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len2.h193491872 = private unnamed_addr constant [3 x i8] c"fs\00"
@.str.len2.h193495007 = private unnamed_addr constant [3 x i8] c"io\00"
@.str.len23.h509166939 = private unnamed_addr constant [24 x i8] c"filesystem helper usage\00"
@.str.len5.h359348221 = private unnamed_addr constant [6 x i8] c"print\00"
@.str.len18.h166827074 = private unnamed_addr constant [19 x i8] c"print helper usage\00"
@.str.len7.h1121316919 = private unnamed_addr constant [8 x i8] c"console\00"
@.str.len20.h1840566713 = private unnamed_addr constant [21 x i8] c"console helper usage\00"
@.str.len4.h261786827 = private unnamed_addr constant [5 x i8] c"http\00"
@.str.len3.h2090540497 = private unnamed_addr constant [4 x i8] c"net\00"
@.str.len17.h959371065 = private unnamed_addr constant [18 x i8] c"http helper usage\00"
@.str.len9.h6052019 = private unnamed_addr constant [10 x i8] c"websocket\00"
@.str.len22.h857956175 = private unnamed_addr constant [23 x i8] c"websocket helper usage\00"
@.str.len5.h474104665 = private unnamed_addr constant [6 x i8] c"spawn\00"
@.str.len10.h1970595328 = private unnamed_addr constant [11 x i8] c"spawn call\00"
@.str.len5.h461669077 = private unnamed_addr constant [6 x i8] c"serve\00"
@.str.len10.h1681046972 = private unnamed_addr constant [11 x i8] c"serve call\00"
@.str.len5.h469485193 = private unnamed_addr constant [6 x i8] c"sleep\00"
@.str.len5.h1991159579 = private unnamed_addr constant [6 x i8] c"clock\00"
@.str.len10.h881761880 = private unnamed_addr constant [11 x i8] c"sleep call\00"
@.enum.TokenKind.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.TokenKind.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.TokenKind.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.TokenKind.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.TokenKind.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.TokenKind.Symbol.variant = private unnamed_addr constant [7 x i8] c"Symbol\00"
@.enum.TokenKind.Whitespace.variant = private unnamed_addr constant [11 x i8] c"Whitespace\00"
@.enum.TokenKind.Comment.variant = private unnamed_addr constant [8 x i8] c"Comment\00"
@.enum.TokenKind.EndOfFile.variant = private unnamed_addr constant [10 x i8] c"EndOfFile\00"
@.str.len10.h715288307 = private unnamed_addr constant [11 x i8] c"Whitespace\00"
@.str.len7.h936649884 = private unnamed_addr constant [8 x i8] c"Comment\00"

define { %EffectViolation*, i64 }* @validate_effects(%Program %program) {
block.entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  %l2 = alloca %Statement*
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
  %t43 = phi { %EffectViolation*, i64 }* [ %t13, %block.entry ], [ %t41, %loop.latch2 ]
  %t44 = phi double [ %t14, %block.entry ], [ %t42, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t43, { %EffectViolation*, i64 }** %l0
  store double %t44, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = extractvalue %Program %program, 0
  %t17 = load { %Statement**, i64 }, { %Statement**, i64 }* %t16
  %t18 = extractvalue { %Statement**, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t15, %t19
  %t21 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = extractvalue %Program %program, 0
  %t24 = load double, double* %l1
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = load { %Statement**, i64 }, { %Statement**, i64 }* %t23
  %t28 = extractvalue { %Statement**, i64 } %t27, 0
  %t29 = extractvalue { %Statement**, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
  %t31 = getelementptr %Statement*, %Statement** %t28, i64 %t26
  %t32 = load %Statement*, %Statement** %t31
  store %Statement* %t32, %Statement** %l2
  %t33 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t34 = load %Statement*, %Statement** %l2
  %t35 = load %Statement, %Statement* %t34
  %t36 = call { %EffectViolation*, i64 }* @analyze_statement(%Statement %t35)
  %t37 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t33, { %EffectViolation*, i64 }* %t36)
  store { %EffectViolation*, i64 }* %t37, { %EffectViolation*, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch2
loop.latch2:
  %t41 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t42 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t45 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t47
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
  %l8 = alloca %MethodDeclaration*
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
  %s71 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t72 = call i1 @strings_equal(i8* %t70, i8* %s71)
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [88 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to %FunctionSignature*
  %t78 = load %FunctionSignature, %FunctionSignature* %t77
  %t79 = icmp eq i32 %t73, 4
  %t80 = select i1 %t79, %FunctionSignature %t78, %FunctionSignature zeroinitializer
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [88 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %FunctionSignature*
  %t84 = load %FunctionSignature, %FunctionSignature* %t83
  %t85 = icmp eq i32 %t73, 5
  %t86 = select i1 %t85, %FunctionSignature %t84, %FunctionSignature %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [88 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to %FunctionSignature*
  %t90 = load %FunctionSignature, %FunctionSignature* %t89
  %t91 = icmp eq i32 %t73, 7
  %t92 = select i1 %t91, %FunctionSignature %t90, %FunctionSignature %t86
  %t93 = extractvalue %Statement %statement, 0
  %t94 = alloca %Statement
  store %Statement %statement, %Statement* %t94
  %t95 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t96 = bitcast [88 x i8]* %t95 to i8*
  %t97 = getelementptr inbounds i8, i8* %t96, i64 56
  %t98 = bitcast i8* %t97 to %Block*
  %t99 = load %Block, %Block* %t98
  %t100 = icmp eq i32 %t93, 4
  %t101 = select i1 %t100, %Block %t99, %Block zeroinitializer
  %t102 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t103 = bitcast [88 x i8]* %t102 to i8*
  %t104 = getelementptr inbounds i8, i8* %t103, i64 56
  %t105 = bitcast i8* %t104 to %Block*
  %t106 = load %Block, %Block* %t105
  %t107 = icmp eq i32 %t93, 5
  %t108 = select i1 %t107, %Block %t106, %Block %t101
  %t109 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t110 = bitcast [56 x i8]* %t109 to i8*
  %t111 = getelementptr inbounds i8, i8* %t110, i64 16
  %t112 = bitcast i8* %t111 to %Block*
  %t113 = load %Block, %Block* %t112
  %t114 = icmp eq i32 %t93, 6
  %t115 = select i1 %t114, %Block %t113, %Block %t108
  %t116 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t117 = bitcast [88 x i8]* %t116 to i8*
  %t118 = getelementptr inbounds i8, i8* %t117, i64 56
  %t119 = bitcast i8* %t118 to %Block*
  %t120 = load %Block, %Block* %t119
  %t121 = icmp eq i32 %t93, 7
  %t122 = select i1 %t121, %Block %t120, %Block %t115
  %t123 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t124 = bitcast [120 x i8]* %t123 to i8*
  %t125 = getelementptr inbounds i8, i8* %t124, i64 88
  %t126 = bitcast i8* %t125 to %Block*
  %t127 = load %Block, %Block* %t126
  %t128 = icmp eq i32 %t93, 12
  %t129 = select i1 %t128, %Block %t127, %Block %t122
  %t130 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t131 = bitcast [40 x i8]* %t130 to i8*
  %t132 = getelementptr inbounds i8, i8* %t131, i64 8
  %t133 = bitcast i8* %t132 to %Block*
  %t134 = load %Block, %Block* %t133
  %t135 = icmp eq i32 %t93, 13
  %t136 = select i1 %t135, %Block %t134, %Block %t129
  %t137 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t138 = bitcast [136 x i8]* %t137 to i8*
  %t139 = getelementptr inbounds i8, i8* %t138, i64 104
  %t140 = bitcast i8* %t139 to %Block*
  %t141 = load %Block, %Block* %t140
  %t142 = icmp eq i32 %t93, 14
  %t143 = select i1 %t142, %Block %t141, %Block %t136
  %t144 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t145 = bitcast [32 x i8]* %t144 to i8*
  %t146 = bitcast i8* %t145 to %Block*
  %t147 = load %Block, %Block* %t146
  %t148 = icmp eq i32 %t93, 15
  %t149 = select i1 %t148, %Block %t147, %Block %t143
  %t150 = extractvalue %Statement %statement, 0
  %t151 = alloca %Statement
  store %Statement %statement, %Statement* %t151
  %t152 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t153 = bitcast [48 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 40
  %t155 = bitcast i8* %t154 to { %Decorator**, i64 }**
  %t156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t155
  %t157 = icmp eq i32 %t150, 3
  %t158 = select i1 %t157, { %Decorator**, i64 }* %t156, { %Decorator**, i64 }* null
  %t159 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t160 = bitcast [88 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 80
  %t162 = bitcast i8* %t161 to { %Decorator**, i64 }**
  %t163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t162
  %t164 = icmp eq i32 %t150, 4
  %t165 = select i1 %t164, { %Decorator**, i64 }* %t163, { %Decorator**, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t167 = bitcast [88 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 80
  %t169 = bitcast i8* %t168 to { %Decorator**, i64 }**
  %t170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t169
  %t171 = icmp eq i32 %t150, 5
  %t172 = select i1 %t171, { %Decorator**, i64 }* %t170, { %Decorator**, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t174 = bitcast [56 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 48
  %t176 = bitcast i8* %t175 to { %Decorator**, i64 }**
  %t177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t176
  %t178 = icmp eq i32 %t150, 6
  %t179 = select i1 %t178, { %Decorator**, i64 }* %t177, { %Decorator**, i64 }* %t172
  %t180 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t181 = bitcast [88 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 80
  %t183 = bitcast i8* %t182 to { %Decorator**, i64 }**
  %t184 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t183
  %t185 = icmp eq i32 %t150, 7
  %t186 = select i1 %t185, { %Decorator**, i64 }* %t184, { %Decorator**, i64 }* %t179
  %t187 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t188 = bitcast [56 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 48
  %t190 = bitcast i8* %t189 to { %Decorator**, i64 }**
  %t191 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t190
  %t192 = icmp eq i32 %t150, 8
  %t193 = select i1 %t192, { %Decorator**, i64 }* %t191, { %Decorator**, i64 }* %t186
  %t194 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t195 = bitcast [40 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 32
  %t197 = bitcast i8* %t196 to { %Decorator**, i64 }**
  %t198 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t197
  %t199 = icmp eq i32 %t150, 9
  %t200 = select i1 %t199, { %Decorator**, i64 }* %t198, { %Decorator**, i64 }* %t193
  %t201 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t202 = bitcast [40 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 32
  %t204 = bitcast i8* %t203 to { %Decorator**, i64 }**
  %t205 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t204
  %t206 = icmp eq i32 %t150, 10
  %t207 = select i1 %t206, { %Decorator**, i64 }* %t205, { %Decorator**, i64 }* %t200
  %t208 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t209 = bitcast [40 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 32
  %t211 = bitcast i8* %t210 to { %Decorator**, i64 }**
  %t212 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t211
  %t213 = icmp eq i32 %t150, 11
  %t214 = select i1 %t213, { %Decorator**, i64 }* %t212, { %Decorator**, i64 }* %t207
  %t215 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t216 = bitcast [120 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 112
  %t218 = bitcast i8* %t217 to { %Decorator**, i64 }**
  %t219 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t218
  %t220 = icmp eq i32 %t150, 12
  %t221 = select i1 %t220, { %Decorator**, i64 }* %t219, { %Decorator**, i64 }* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t223 = bitcast [40 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 32
  %t225 = bitcast i8* %t224 to { %Decorator**, i64 }**
  %t226 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t225
  %t227 = icmp eq i32 %t150, 13
  %t228 = select i1 %t227, { %Decorator**, i64 }* %t226, { %Decorator**, i64 }* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t230 = bitcast [136 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 128
  %t232 = bitcast i8* %t231 to { %Decorator**, i64 }**
  %t233 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t232
  %t234 = icmp eq i32 %t150, 14
  %t235 = select i1 %t234, { %Decorator**, i64 }* %t233, { %Decorator**, i64 }* %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t237 = bitcast [32 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 24
  %t239 = bitcast i8* %t238 to { %Decorator**, i64 }**
  %t240 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t239
  %t241 = icmp eq i32 %t150, 15
  %t242 = select i1 %t241, { %Decorator**, i64 }* %t240, { %Decorator**, i64 }* %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t244 = bitcast [64 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 56
  %t246 = bitcast i8* %t245 to { %Decorator**, i64 }**
  %t247 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t246
  %t248 = icmp eq i32 %t150, 18
  %t249 = select i1 %t248, { %Decorator**, i64 }* %t247, { %Decorator**, i64 }* %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t251 = bitcast [88 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 80
  %t253 = bitcast i8* %t252 to { %Decorator**, i64 }**
  %t254 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t253
  %t255 = icmp eq i32 %t150, 19
  %t256 = select i1 %t255, { %Decorator**, i64 }* %t254, { %Decorator**, i64 }* %t249
  %t257 = extractvalue %Statement %statement, 0
  %t258 = alloca %Statement
  store %Statement %statement, %Statement* %t258
  %t259 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t260 = bitcast [88 x i8]* %t259 to i8*
  %t261 = bitcast i8* %t260 to %FunctionSignature*
  %t262 = load %FunctionSignature, %FunctionSignature* %t261
  %t263 = icmp eq i32 %t257, 4
  %t264 = select i1 %t263, %FunctionSignature %t262, %FunctionSignature zeroinitializer
  %t265 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t266 = bitcast [88 x i8]* %t265 to i8*
  %t267 = bitcast i8* %t266 to %FunctionSignature*
  %t268 = load %FunctionSignature, %FunctionSignature* %t267
  %t269 = icmp eq i32 %t257, 5
  %t270 = select i1 %t269, %FunctionSignature %t268, %FunctionSignature %t264
  %t271 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t272 = bitcast [88 x i8]* %t271 to i8*
  %t273 = bitcast i8* %t272 to %FunctionSignature*
  %t274 = load %FunctionSignature, %FunctionSignature* %t273
  %t275 = icmp eq i32 %t257, 7
  %t276 = select i1 %t275, %FunctionSignature %t274, %FunctionSignature %t270
  %t277 = extractvalue %FunctionSignature %t276, 0
  %t278 = bitcast { %Decorator**, i64 }* %t256 to { %Decorator*, i64 }*
  %t279 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t92, %Block %t149, { %Decorator*, i64 }* %t278, i8* %t277)
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
  %s351 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t352 = call i1 @strings_equal(i8* %t350, i8* %s351)
  br i1 %t352, label %then2, label %merge3
then2:
  %t353 = extractvalue %Statement %statement, 0
  %t354 = alloca %Statement
  store %Statement %statement, %Statement* %t354
  %t355 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t356 = bitcast [88 x i8]* %t355 to i8*
  %t357 = bitcast i8* %t356 to %FunctionSignature*
  %t358 = load %FunctionSignature, %FunctionSignature* %t357
  %t359 = icmp eq i32 %t353, 4
  %t360 = select i1 %t359, %FunctionSignature %t358, %FunctionSignature zeroinitializer
  %t361 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t362 = bitcast [88 x i8]* %t361 to i8*
  %t363 = bitcast i8* %t362 to %FunctionSignature*
  %t364 = load %FunctionSignature, %FunctionSignature* %t363
  %t365 = icmp eq i32 %t353, 5
  %t366 = select i1 %t365, %FunctionSignature %t364, %FunctionSignature %t360
  %t367 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t368 = bitcast [88 x i8]* %t367 to i8*
  %t369 = bitcast i8* %t368 to %FunctionSignature*
  %t370 = load %FunctionSignature, %FunctionSignature* %t369
  %t371 = icmp eq i32 %t353, 7
  %t372 = select i1 %t371, %FunctionSignature %t370, %FunctionSignature %t366
  store %FunctionSignature %t372, %FunctionSignature* %l0
  %s373 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1700456022, i32 0, i32 0
  %t374 = load %FunctionSignature, %FunctionSignature* %l0
  %t375 = extractvalue %FunctionSignature %t374, 0
  %t376 = call i8* @sailfin_runtime_string_concat(i8* %s373, i8* %t375)
  store i8* %t376, i8** %l1
  %t377 = load %FunctionSignature, %FunctionSignature* %l0
  %t378 = extractvalue %Statement %statement, 0
  %t379 = alloca %Statement
  store %Statement %statement, %Statement* %t379
  %t380 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t381 = bitcast [88 x i8]* %t380 to i8*
  %t382 = getelementptr inbounds i8, i8* %t381, i64 56
  %t383 = bitcast i8* %t382 to %Block*
  %t384 = load %Block, %Block* %t383
  %t385 = icmp eq i32 %t378, 4
  %t386 = select i1 %t385, %Block %t384, %Block zeroinitializer
  %t387 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t388 = bitcast [88 x i8]* %t387 to i8*
  %t389 = getelementptr inbounds i8, i8* %t388, i64 56
  %t390 = bitcast i8* %t389 to %Block*
  %t391 = load %Block, %Block* %t390
  %t392 = icmp eq i32 %t378, 5
  %t393 = select i1 %t392, %Block %t391, %Block %t386
  %t394 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t395 = bitcast [56 x i8]* %t394 to i8*
  %t396 = getelementptr inbounds i8, i8* %t395, i64 16
  %t397 = bitcast i8* %t396 to %Block*
  %t398 = load %Block, %Block* %t397
  %t399 = icmp eq i32 %t378, 6
  %t400 = select i1 %t399, %Block %t398, %Block %t393
  %t401 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t402 = bitcast [88 x i8]* %t401 to i8*
  %t403 = getelementptr inbounds i8, i8* %t402, i64 56
  %t404 = bitcast i8* %t403 to %Block*
  %t405 = load %Block, %Block* %t404
  %t406 = icmp eq i32 %t378, 7
  %t407 = select i1 %t406, %Block %t405, %Block %t400
  %t408 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t409 = bitcast [120 x i8]* %t408 to i8*
  %t410 = getelementptr inbounds i8, i8* %t409, i64 88
  %t411 = bitcast i8* %t410 to %Block*
  %t412 = load %Block, %Block* %t411
  %t413 = icmp eq i32 %t378, 12
  %t414 = select i1 %t413, %Block %t412, %Block %t407
  %t415 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t416 = bitcast [40 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 8
  %t418 = bitcast i8* %t417 to %Block*
  %t419 = load %Block, %Block* %t418
  %t420 = icmp eq i32 %t378, 13
  %t421 = select i1 %t420, %Block %t419, %Block %t414
  %t422 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t423 = bitcast [136 x i8]* %t422 to i8*
  %t424 = getelementptr inbounds i8, i8* %t423, i64 104
  %t425 = bitcast i8* %t424 to %Block*
  %t426 = load %Block, %Block* %t425
  %t427 = icmp eq i32 %t378, 14
  %t428 = select i1 %t427, %Block %t426, %Block %t421
  %t429 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t430 = bitcast [32 x i8]* %t429 to i8*
  %t431 = bitcast i8* %t430 to %Block*
  %t432 = load %Block, %Block* %t431
  %t433 = icmp eq i32 %t378, 15
  %t434 = select i1 %t433, %Block %t432, %Block %t428
  %t435 = extractvalue %Statement %statement, 0
  %t436 = alloca %Statement
  store %Statement %statement, %Statement* %t436
  %t437 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t438 = bitcast [48 x i8]* %t437 to i8*
  %t439 = getelementptr inbounds i8, i8* %t438, i64 40
  %t440 = bitcast i8* %t439 to { %Decorator**, i64 }**
  %t441 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t440
  %t442 = icmp eq i32 %t435, 3
  %t443 = select i1 %t442, { %Decorator**, i64 }* %t441, { %Decorator**, i64 }* null
  %t444 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t445 = bitcast [88 x i8]* %t444 to i8*
  %t446 = getelementptr inbounds i8, i8* %t445, i64 80
  %t447 = bitcast i8* %t446 to { %Decorator**, i64 }**
  %t448 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t447
  %t449 = icmp eq i32 %t435, 4
  %t450 = select i1 %t449, { %Decorator**, i64 }* %t448, { %Decorator**, i64 }* %t443
  %t451 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t452 = bitcast [88 x i8]* %t451 to i8*
  %t453 = getelementptr inbounds i8, i8* %t452, i64 80
  %t454 = bitcast i8* %t453 to { %Decorator**, i64 }**
  %t455 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t454
  %t456 = icmp eq i32 %t435, 5
  %t457 = select i1 %t456, { %Decorator**, i64 }* %t455, { %Decorator**, i64 }* %t450
  %t458 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t459 = bitcast [56 x i8]* %t458 to i8*
  %t460 = getelementptr inbounds i8, i8* %t459, i64 48
  %t461 = bitcast i8* %t460 to { %Decorator**, i64 }**
  %t462 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t461
  %t463 = icmp eq i32 %t435, 6
  %t464 = select i1 %t463, { %Decorator**, i64 }* %t462, { %Decorator**, i64 }* %t457
  %t465 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t466 = bitcast [88 x i8]* %t465 to i8*
  %t467 = getelementptr inbounds i8, i8* %t466, i64 80
  %t468 = bitcast i8* %t467 to { %Decorator**, i64 }**
  %t469 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t468
  %t470 = icmp eq i32 %t435, 7
  %t471 = select i1 %t470, { %Decorator**, i64 }* %t469, { %Decorator**, i64 }* %t464
  %t472 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t473 = bitcast [56 x i8]* %t472 to i8*
  %t474 = getelementptr inbounds i8, i8* %t473, i64 48
  %t475 = bitcast i8* %t474 to { %Decorator**, i64 }**
  %t476 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t475
  %t477 = icmp eq i32 %t435, 8
  %t478 = select i1 %t477, { %Decorator**, i64 }* %t476, { %Decorator**, i64 }* %t471
  %t479 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t480 = bitcast [40 x i8]* %t479 to i8*
  %t481 = getelementptr inbounds i8, i8* %t480, i64 32
  %t482 = bitcast i8* %t481 to { %Decorator**, i64 }**
  %t483 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t482
  %t484 = icmp eq i32 %t435, 9
  %t485 = select i1 %t484, { %Decorator**, i64 }* %t483, { %Decorator**, i64 }* %t478
  %t486 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t487 = bitcast [40 x i8]* %t486 to i8*
  %t488 = getelementptr inbounds i8, i8* %t487, i64 32
  %t489 = bitcast i8* %t488 to { %Decorator**, i64 }**
  %t490 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t489
  %t491 = icmp eq i32 %t435, 10
  %t492 = select i1 %t491, { %Decorator**, i64 }* %t490, { %Decorator**, i64 }* %t485
  %t493 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t494 = bitcast [40 x i8]* %t493 to i8*
  %t495 = getelementptr inbounds i8, i8* %t494, i64 32
  %t496 = bitcast i8* %t495 to { %Decorator**, i64 }**
  %t497 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t496
  %t498 = icmp eq i32 %t435, 11
  %t499 = select i1 %t498, { %Decorator**, i64 }* %t497, { %Decorator**, i64 }* %t492
  %t500 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t501 = bitcast [120 x i8]* %t500 to i8*
  %t502 = getelementptr inbounds i8, i8* %t501, i64 112
  %t503 = bitcast i8* %t502 to { %Decorator**, i64 }**
  %t504 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t503
  %t505 = icmp eq i32 %t435, 12
  %t506 = select i1 %t505, { %Decorator**, i64 }* %t504, { %Decorator**, i64 }* %t499
  %t507 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t508 = bitcast [40 x i8]* %t507 to i8*
  %t509 = getelementptr inbounds i8, i8* %t508, i64 32
  %t510 = bitcast i8* %t509 to { %Decorator**, i64 }**
  %t511 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t510
  %t512 = icmp eq i32 %t435, 13
  %t513 = select i1 %t512, { %Decorator**, i64 }* %t511, { %Decorator**, i64 }* %t506
  %t514 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t515 = bitcast [136 x i8]* %t514 to i8*
  %t516 = getelementptr inbounds i8, i8* %t515, i64 128
  %t517 = bitcast i8* %t516 to { %Decorator**, i64 }**
  %t518 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t517
  %t519 = icmp eq i32 %t435, 14
  %t520 = select i1 %t519, { %Decorator**, i64 }* %t518, { %Decorator**, i64 }* %t513
  %t521 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t522 = bitcast [32 x i8]* %t521 to i8*
  %t523 = getelementptr inbounds i8, i8* %t522, i64 24
  %t524 = bitcast i8* %t523 to { %Decorator**, i64 }**
  %t525 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t524
  %t526 = icmp eq i32 %t435, 15
  %t527 = select i1 %t526, { %Decorator**, i64 }* %t525, { %Decorator**, i64 }* %t520
  %t528 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t529 = bitcast [64 x i8]* %t528 to i8*
  %t530 = getelementptr inbounds i8, i8* %t529, i64 56
  %t531 = bitcast i8* %t530 to { %Decorator**, i64 }**
  %t532 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t531
  %t533 = icmp eq i32 %t435, 18
  %t534 = select i1 %t533, { %Decorator**, i64 }* %t532, { %Decorator**, i64 }* %t527
  %t535 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t536 = bitcast [88 x i8]* %t535 to i8*
  %t537 = getelementptr inbounds i8, i8* %t536, i64 80
  %t538 = bitcast i8* %t537 to { %Decorator**, i64 }**
  %t539 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t538
  %t540 = icmp eq i32 %t435, 19
  %t541 = select i1 %t540, { %Decorator**, i64 }* %t539, { %Decorator**, i64 }* %t534
  %t542 = load i8*, i8** %l1
  %t543 = bitcast { %Decorator**, i64 }* %t541 to { %Decorator*, i64 }*
  %t544 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t377, %Block %t434, { %Decorator*, i64 }* %t543, i8* %t542)
  ret { %EffectViolation*, i64 }* %t544
merge3:
  %t545 = extractvalue %Statement %statement, 0
  %t546 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t547 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t548 = icmp eq i32 %t545, 0
  %t549 = select i1 %t548, i8* %t547, i8* %t546
  %t550 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t551 = icmp eq i32 %t545, 1
  %t552 = select i1 %t551, i8* %t550, i8* %t549
  %t553 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t554 = icmp eq i32 %t545, 2
  %t555 = select i1 %t554, i8* %t553, i8* %t552
  %t556 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t557 = icmp eq i32 %t545, 3
  %t558 = select i1 %t557, i8* %t556, i8* %t555
  %t559 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t560 = icmp eq i32 %t545, 4
  %t561 = select i1 %t560, i8* %t559, i8* %t558
  %t562 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t563 = icmp eq i32 %t545, 5
  %t564 = select i1 %t563, i8* %t562, i8* %t561
  %t565 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t566 = icmp eq i32 %t545, 6
  %t567 = select i1 %t566, i8* %t565, i8* %t564
  %t568 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t569 = icmp eq i32 %t545, 7
  %t570 = select i1 %t569, i8* %t568, i8* %t567
  %t571 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t572 = icmp eq i32 %t545, 8
  %t573 = select i1 %t572, i8* %t571, i8* %t570
  %t574 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t575 = icmp eq i32 %t545, 9
  %t576 = select i1 %t575, i8* %t574, i8* %t573
  %t577 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t578 = icmp eq i32 %t545, 10
  %t579 = select i1 %t578, i8* %t577, i8* %t576
  %t580 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t581 = icmp eq i32 %t545, 11
  %t582 = select i1 %t581, i8* %t580, i8* %t579
  %t583 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t584 = icmp eq i32 %t545, 12
  %t585 = select i1 %t584, i8* %t583, i8* %t582
  %t586 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t587 = icmp eq i32 %t545, 13
  %t588 = select i1 %t587, i8* %t586, i8* %t585
  %t589 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t590 = icmp eq i32 %t545, 14
  %t591 = select i1 %t590, i8* %t589, i8* %t588
  %t592 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t593 = icmp eq i32 %t545, 15
  %t594 = select i1 %t593, i8* %t592, i8* %t591
  %t595 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t596 = icmp eq i32 %t545, 16
  %t597 = select i1 %t596, i8* %t595, i8* %t594
  %t598 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t599 = icmp eq i32 %t545, 17
  %t600 = select i1 %t599, i8* %t598, i8* %t597
  %t601 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t545, 18
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t545, 19
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t545, 20
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t545, 21
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t545, 22
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %s616 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t617 = call i1 @strings_equal(i8* %t615, i8* %s616)
  br i1 %t617, label %then4, label %merge5
then4:
  %t618 = extractvalue %Statement %statement, 0
  %t619 = alloca %Statement
  store %Statement %statement, %Statement* %t619
  %t620 = getelementptr inbounds %Statement, %Statement* %t619, i32 0, i32 1
  %t621 = bitcast [88 x i8]* %t620 to i8*
  %t622 = bitcast i8* %t621 to %FunctionSignature*
  %t623 = load %FunctionSignature, %FunctionSignature* %t622
  %t624 = icmp eq i32 %t618, 4
  %t625 = select i1 %t624, %FunctionSignature %t623, %FunctionSignature zeroinitializer
  %t626 = getelementptr inbounds %Statement, %Statement* %t619, i32 0, i32 1
  %t627 = bitcast [88 x i8]* %t626 to i8*
  %t628 = bitcast i8* %t627 to %FunctionSignature*
  %t629 = load %FunctionSignature, %FunctionSignature* %t628
  %t630 = icmp eq i32 %t618, 5
  %t631 = select i1 %t630, %FunctionSignature %t629, %FunctionSignature %t625
  %t632 = getelementptr inbounds %Statement, %Statement* %t619, i32 0, i32 1
  %t633 = bitcast [88 x i8]* %t632 to i8*
  %t634 = bitcast i8* %t633 to %FunctionSignature*
  %t635 = load %FunctionSignature, %FunctionSignature* %t634
  %t636 = icmp eq i32 %t618, 7
  %t637 = select i1 %t636, %FunctionSignature %t635, %FunctionSignature %t631
  store %FunctionSignature %t637, %FunctionSignature* %l2
  %s638 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h512542702, i32 0, i32 0
  %t639 = load %FunctionSignature, %FunctionSignature* %l2
  %t640 = extractvalue %FunctionSignature %t639, 0
  %t641 = call i8* @sailfin_runtime_string_concat(i8* %s638, i8* %t640)
  store i8* %t641, i8** %l3
  %t642 = load %FunctionSignature, %FunctionSignature* %l2
  %t643 = extractvalue %Statement %statement, 0
  %t644 = alloca %Statement
  store %Statement %statement, %Statement* %t644
  %t645 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t646 = bitcast [88 x i8]* %t645 to i8*
  %t647 = getelementptr inbounds i8, i8* %t646, i64 56
  %t648 = bitcast i8* %t647 to %Block*
  %t649 = load %Block, %Block* %t648
  %t650 = icmp eq i32 %t643, 4
  %t651 = select i1 %t650, %Block %t649, %Block zeroinitializer
  %t652 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t653 = bitcast [88 x i8]* %t652 to i8*
  %t654 = getelementptr inbounds i8, i8* %t653, i64 56
  %t655 = bitcast i8* %t654 to %Block*
  %t656 = load %Block, %Block* %t655
  %t657 = icmp eq i32 %t643, 5
  %t658 = select i1 %t657, %Block %t656, %Block %t651
  %t659 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t660 = bitcast [56 x i8]* %t659 to i8*
  %t661 = getelementptr inbounds i8, i8* %t660, i64 16
  %t662 = bitcast i8* %t661 to %Block*
  %t663 = load %Block, %Block* %t662
  %t664 = icmp eq i32 %t643, 6
  %t665 = select i1 %t664, %Block %t663, %Block %t658
  %t666 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t667 = bitcast [88 x i8]* %t666 to i8*
  %t668 = getelementptr inbounds i8, i8* %t667, i64 56
  %t669 = bitcast i8* %t668 to %Block*
  %t670 = load %Block, %Block* %t669
  %t671 = icmp eq i32 %t643, 7
  %t672 = select i1 %t671, %Block %t670, %Block %t665
  %t673 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t674 = bitcast [120 x i8]* %t673 to i8*
  %t675 = getelementptr inbounds i8, i8* %t674, i64 88
  %t676 = bitcast i8* %t675 to %Block*
  %t677 = load %Block, %Block* %t676
  %t678 = icmp eq i32 %t643, 12
  %t679 = select i1 %t678, %Block %t677, %Block %t672
  %t680 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t681 = bitcast [40 x i8]* %t680 to i8*
  %t682 = getelementptr inbounds i8, i8* %t681, i64 8
  %t683 = bitcast i8* %t682 to %Block*
  %t684 = load %Block, %Block* %t683
  %t685 = icmp eq i32 %t643, 13
  %t686 = select i1 %t685, %Block %t684, %Block %t679
  %t687 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t688 = bitcast [136 x i8]* %t687 to i8*
  %t689 = getelementptr inbounds i8, i8* %t688, i64 104
  %t690 = bitcast i8* %t689 to %Block*
  %t691 = load %Block, %Block* %t690
  %t692 = icmp eq i32 %t643, 14
  %t693 = select i1 %t692, %Block %t691, %Block %t686
  %t694 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t695 = bitcast [32 x i8]* %t694 to i8*
  %t696 = bitcast i8* %t695 to %Block*
  %t697 = load %Block, %Block* %t696
  %t698 = icmp eq i32 %t643, 15
  %t699 = select i1 %t698, %Block %t697, %Block %t693
  %t700 = extractvalue %Statement %statement, 0
  %t701 = alloca %Statement
  store %Statement %statement, %Statement* %t701
  %t702 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t703 = bitcast [48 x i8]* %t702 to i8*
  %t704 = getelementptr inbounds i8, i8* %t703, i64 40
  %t705 = bitcast i8* %t704 to { %Decorator**, i64 }**
  %t706 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t705
  %t707 = icmp eq i32 %t700, 3
  %t708 = select i1 %t707, { %Decorator**, i64 }* %t706, { %Decorator**, i64 }* null
  %t709 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t710 = bitcast [88 x i8]* %t709 to i8*
  %t711 = getelementptr inbounds i8, i8* %t710, i64 80
  %t712 = bitcast i8* %t711 to { %Decorator**, i64 }**
  %t713 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t712
  %t714 = icmp eq i32 %t700, 4
  %t715 = select i1 %t714, { %Decorator**, i64 }* %t713, { %Decorator**, i64 }* %t708
  %t716 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t717 = bitcast [88 x i8]* %t716 to i8*
  %t718 = getelementptr inbounds i8, i8* %t717, i64 80
  %t719 = bitcast i8* %t718 to { %Decorator**, i64 }**
  %t720 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t719
  %t721 = icmp eq i32 %t700, 5
  %t722 = select i1 %t721, { %Decorator**, i64 }* %t720, { %Decorator**, i64 }* %t715
  %t723 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t724 = bitcast [56 x i8]* %t723 to i8*
  %t725 = getelementptr inbounds i8, i8* %t724, i64 48
  %t726 = bitcast i8* %t725 to { %Decorator**, i64 }**
  %t727 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t726
  %t728 = icmp eq i32 %t700, 6
  %t729 = select i1 %t728, { %Decorator**, i64 }* %t727, { %Decorator**, i64 }* %t722
  %t730 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t731 = bitcast [88 x i8]* %t730 to i8*
  %t732 = getelementptr inbounds i8, i8* %t731, i64 80
  %t733 = bitcast i8* %t732 to { %Decorator**, i64 }**
  %t734 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t733
  %t735 = icmp eq i32 %t700, 7
  %t736 = select i1 %t735, { %Decorator**, i64 }* %t734, { %Decorator**, i64 }* %t729
  %t737 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t738 = bitcast [56 x i8]* %t737 to i8*
  %t739 = getelementptr inbounds i8, i8* %t738, i64 48
  %t740 = bitcast i8* %t739 to { %Decorator**, i64 }**
  %t741 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t740
  %t742 = icmp eq i32 %t700, 8
  %t743 = select i1 %t742, { %Decorator**, i64 }* %t741, { %Decorator**, i64 }* %t736
  %t744 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t745 = bitcast [40 x i8]* %t744 to i8*
  %t746 = getelementptr inbounds i8, i8* %t745, i64 32
  %t747 = bitcast i8* %t746 to { %Decorator**, i64 }**
  %t748 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t747
  %t749 = icmp eq i32 %t700, 9
  %t750 = select i1 %t749, { %Decorator**, i64 }* %t748, { %Decorator**, i64 }* %t743
  %t751 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t752 = bitcast [40 x i8]* %t751 to i8*
  %t753 = getelementptr inbounds i8, i8* %t752, i64 32
  %t754 = bitcast i8* %t753 to { %Decorator**, i64 }**
  %t755 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t754
  %t756 = icmp eq i32 %t700, 10
  %t757 = select i1 %t756, { %Decorator**, i64 }* %t755, { %Decorator**, i64 }* %t750
  %t758 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t759 = bitcast [40 x i8]* %t758 to i8*
  %t760 = getelementptr inbounds i8, i8* %t759, i64 32
  %t761 = bitcast i8* %t760 to { %Decorator**, i64 }**
  %t762 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t761
  %t763 = icmp eq i32 %t700, 11
  %t764 = select i1 %t763, { %Decorator**, i64 }* %t762, { %Decorator**, i64 }* %t757
  %t765 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t766 = bitcast [120 x i8]* %t765 to i8*
  %t767 = getelementptr inbounds i8, i8* %t766, i64 112
  %t768 = bitcast i8* %t767 to { %Decorator**, i64 }**
  %t769 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t768
  %t770 = icmp eq i32 %t700, 12
  %t771 = select i1 %t770, { %Decorator**, i64 }* %t769, { %Decorator**, i64 }* %t764
  %t772 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t773 = bitcast [40 x i8]* %t772 to i8*
  %t774 = getelementptr inbounds i8, i8* %t773, i64 32
  %t775 = bitcast i8* %t774 to { %Decorator**, i64 }**
  %t776 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t775
  %t777 = icmp eq i32 %t700, 13
  %t778 = select i1 %t777, { %Decorator**, i64 }* %t776, { %Decorator**, i64 }* %t771
  %t779 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t780 = bitcast [136 x i8]* %t779 to i8*
  %t781 = getelementptr inbounds i8, i8* %t780, i64 128
  %t782 = bitcast i8* %t781 to { %Decorator**, i64 }**
  %t783 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t782
  %t784 = icmp eq i32 %t700, 14
  %t785 = select i1 %t784, { %Decorator**, i64 }* %t783, { %Decorator**, i64 }* %t778
  %t786 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t787 = bitcast [32 x i8]* %t786 to i8*
  %t788 = getelementptr inbounds i8, i8* %t787, i64 24
  %t789 = bitcast i8* %t788 to { %Decorator**, i64 }**
  %t790 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t789
  %t791 = icmp eq i32 %t700, 15
  %t792 = select i1 %t791, { %Decorator**, i64 }* %t790, { %Decorator**, i64 }* %t785
  %t793 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t794 = bitcast [64 x i8]* %t793 to i8*
  %t795 = getelementptr inbounds i8, i8* %t794, i64 56
  %t796 = bitcast i8* %t795 to { %Decorator**, i64 }**
  %t797 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t796
  %t798 = icmp eq i32 %t700, 18
  %t799 = select i1 %t798, { %Decorator**, i64 }* %t797, { %Decorator**, i64 }* %t792
  %t800 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t801 = bitcast [88 x i8]* %t800 to i8*
  %t802 = getelementptr inbounds i8, i8* %t801, i64 80
  %t803 = bitcast i8* %t802 to { %Decorator**, i64 }**
  %t804 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t803
  %t805 = icmp eq i32 %t700, 19
  %t806 = select i1 %t805, { %Decorator**, i64 }* %t804, { %Decorator**, i64 }* %t799
  %t807 = load i8*, i8** %l3
  %t808 = bitcast { %Decorator**, i64 }* %t806 to { %Decorator*, i64 }*
  %t809 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t642, %Block %t699, { %Decorator*, i64 }* %t808, i8* %t807)
  ret { %EffectViolation*, i64 }* %t809
merge5:
  %t810 = extractvalue %Statement %statement, 0
  %t811 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t812 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t810, 0
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t810, 1
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t810, 2
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t810, 3
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t810, 4
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t810, 5
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t810, 6
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t810, 7
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t810, 8
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t810, 9
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t810, 10
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t810, 11
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t810, 12
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t810, 13
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t810, 14
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t810, 15
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t810, 16
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t810, 17
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t810, 18
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t810, 19
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t810, 20
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t810, 21
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t810, 22
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %s881 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t882 = call i1 @strings_equal(i8* %t880, i8* %s881)
  br i1 %t882, label %then6, label %merge7
then6:
  %t883 = extractvalue %Statement %statement, 0
  %t884 = alloca %Statement
  store %Statement %statement, %Statement* %t884
  %t885 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t886 = bitcast [48 x i8]* %t885 to i8*
  %t887 = bitcast i8* %t886 to i8**
  %t888 = load i8*, i8** %t887
  %t889 = icmp eq i32 %t883, 2
  %t890 = select i1 %t889, i8* %t888, i8* null
  %t891 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t892 = bitcast [48 x i8]* %t891 to i8*
  %t893 = bitcast i8* %t892 to i8**
  %t894 = load i8*, i8** %t893
  %t895 = icmp eq i32 %t883, 3
  %t896 = select i1 %t895, i8* %t894, i8* %t890
  %t897 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t898 = bitcast [56 x i8]* %t897 to i8*
  %t899 = bitcast i8* %t898 to i8**
  %t900 = load i8*, i8** %t899
  %t901 = icmp eq i32 %t883, 6
  %t902 = select i1 %t901, i8* %t900, i8* %t896
  %t903 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t904 = bitcast [56 x i8]* %t903 to i8*
  %t905 = bitcast i8* %t904 to i8**
  %t906 = load i8*, i8** %t905
  %t907 = icmp eq i32 %t883, 8
  %t908 = select i1 %t907, i8* %t906, i8* %t902
  %t909 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t910 = bitcast [40 x i8]* %t909 to i8*
  %t911 = bitcast i8* %t910 to i8**
  %t912 = load i8*, i8** %t911
  %t913 = icmp eq i32 %t883, 9
  %t914 = select i1 %t913, i8* %t912, i8* %t908
  %t915 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t916 = bitcast [40 x i8]* %t915 to i8*
  %t917 = bitcast i8* %t916 to i8**
  %t918 = load i8*, i8** %t917
  %t919 = icmp eq i32 %t883, 10
  %t920 = select i1 %t919, i8* %t918, i8* %t914
  %t921 = getelementptr inbounds %Statement, %Statement* %t884, i32 0, i32 1
  %t922 = bitcast [40 x i8]* %t921 to i8*
  %t923 = bitcast i8* %t922 to i8**
  %t924 = load i8*, i8** %t923
  %t925 = icmp eq i32 %t883, 11
  %t926 = select i1 %t925, i8* %t924, i8* %t920
  %t927 = insertvalue %FunctionSignature undef, i8* %t926, 0
  %t928 = insertvalue %FunctionSignature %t927, i1 0, 1
  %t929 = getelementptr [0 x %Parameter*], [0 x %Parameter*]* null, i32 1
  %t930 = ptrtoint [0 x %Parameter*]* %t929 to i64
  %t931 = icmp eq i64 %t930, 0
  %t932 = select i1 %t931, i64 1, i64 %t930
  %t933 = call i8* @malloc(i64 %t932)
  %t934 = bitcast i8* %t933 to %Parameter**
  %t935 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* null, i32 1
  %t936 = ptrtoint { %Parameter**, i64 }* %t935 to i64
  %t937 = call i8* @malloc(i64 %t936)
  %t938 = bitcast i8* %t937 to { %Parameter**, i64 }*
  %t939 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t938, i32 0, i32 0
  store %Parameter** %t934, %Parameter*** %t939
  %t940 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t938, i32 0, i32 1
  store i64 0, i64* %t940
  %t941 = insertvalue %FunctionSignature %t928, { %Parameter**, i64 }* %t938, 2
  %t942 = bitcast i8* null to %TypeAnnotation*
  %t943 = insertvalue %FunctionSignature %t941, %TypeAnnotation* %t942, 3
  %t944 = extractvalue %Statement %statement, 0
  %t945 = alloca %Statement
  store %Statement %statement, %Statement* %t945
  %t946 = getelementptr inbounds %Statement, %Statement* %t945, i32 0, i32 1
  %t947 = bitcast [48 x i8]* %t946 to i8*
  %t948 = getelementptr inbounds i8, i8* %t947, i64 32
  %t949 = bitcast i8* %t948 to { i8**, i64 }**
  %t950 = load { i8**, i64 }*, { i8**, i64 }** %t949
  %t951 = icmp eq i32 %t944, 3
  %t952 = select i1 %t951, { i8**, i64 }* %t950, { i8**, i64 }* null
  %t953 = getelementptr inbounds %Statement, %Statement* %t945, i32 0, i32 1
  %t954 = bitcast [56 x i8]* %t953 to i8*
  %t955 = getelementptr inbounds i8, i8* %t954, i64 40
  %t956 = bitcast i8* %t955 to { i8**, i64 }**
  %t957 = load { i8**, i64 }*, { i8**, i64 }** %t956
  %t958 = icmp eq i32 %t944, 6
  %t959 = select i1 %t958, { i8**, i64 }* %t957, { i8**, i64 }* %t952
  %t960 = insertvalue %FunctionSignature %t943, { i8**, i64 }* %t959, 4
  %t961 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* null, i32 1
  %t962 = ptrtoint [0 x %TypeParameter*]* %t961 to i64
  %t963 = icmp eq i64 %t962, 0
  %t964 = select i1 %t963, i64 1, i64 %t962
  %t965 = call i8* @malloc(i64 %t964)
  %t966 = bitcast i8* %t965 to %TypeParameter**
  %t967 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* null, i32 1
  %t968 = ptrtoint { %TypeParameter**, i64 }* %t967 to i64
  %t969 = call i8* @malloc(i64 %t968)
  %t970 = bitcast i8* %t969 to { %TypeParameter**, i64 }*
  %t971 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t970, i32 0, i32 0
  store %TypeParameter** %t966, %TypeParameter*** %t971
  %t972 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t970, i32 0, i32 1
  store i64 0, i64* %t972
  %t973 = insertvalue %FunctionSignature %t960, { %TypeParameter**, i64 }* %t970, 5
  %t974 = bitcast i8* null to %SourceSpan*
  %t975 = insertvalue %FunctionSignature %t973, %SourceSpan* %t974, 6
  store %FunctionSignature %t975, %FunctionSignature* %l4
  %s976 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h500835952, i32 0, i32 0
  %t977 = extractvalue %Statement %statement, 0
  %t978 = alloca %Statement
  store %Statement %statement, %Statement* %t978
  %t979 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t980 = bitcast [48 x i8]* %t979 to i8*
  %t981 = bitcast i8* %t980 to i8**
  %t982 = load i8*, i8** %t981
  %t983 = icmp eq i32 %t977, 2
  %t984 = select i1 %t983, i8* %t982, i8* null
  %t985 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t986 = bitcast [48 x i8]* %t985 to i8*
  %t987 = bitcast i8* %t986 to i8**
  %t988 = load i8*, i8** %t987
  %t989 = icmp eq i32 %t977, 3
  %t990 = select i1 %t989, i8* %t988, i8* %t984
  %t991 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t992 = bitcast [56 x i8]* %t991 to i8*
  %t993 = bitcast i8* %t992 to i8**
  %t994 = load i8*, i8** %t993
  %t995 = icmp eq i32 %t977, 6
  %t996 = select i1 %t995, i8* %t994, i8* %t990
  %t997 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t998 = bitcast [56 x i8]* %t997 to i8*
  %t999 = bitcast i8* %t998 to i8**
  %t1000 = load i8*, i8** %t999
  %t1001 = icmp eq i32 %t977, 8
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t996
  %t1003 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t1004 = bitcast [40 x i8]* %t1003 to i8*
  %t1005 = bitcast i8* %t1004 to i8**
  %t1006 = load i8*, i8** %t1005
  %t1007 = icmp eq i32 %t977, 9
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1002
  %t1009 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t1010 = bitcast [40 x i8]* %t1009 to i8*
  %t1011 = bitcast i8* %t1010 to i8**
  %t1012 = load i8*, i8** %t1011
  %t1013 = icmp eq i32 %t977, 10
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1008
  %t1015 = getelementptr inbounds %Statement, %Statement* %t978, i32 0, i32 1
  %t1016 = bitcast [40 x i8]* %t1015 to i8*
  %t1017 = bitcast i8* %t1016 to i8**
  %t1018 = load i8*, i8** %t1017
  %t1019 = icmp eq i32 %t977, 11
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1014
  %t1021 = call i8* @sailfin_runtime_string_concat(i8* %s976, i8* %t1020)
  store i8* %t1021, i8** %l5
  %t1022 = load %FunctionSignature, %FunctionSignature* %l4
  %t1023 = extractvalue %Statement %statement, 0
  %t1024 = alloca %Statement
  store %Statement %statement, %Statement* %t1024
  %t1025 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1026 = bitcast [88 x i8]* %t1025 to i8*
  %t1027 = getelementptr inbounds i8, i8* %t1026, i64 56
  %t1028 = bitcast i8* %t1027 to %Block*
  %t1029 = load %Block, %Block* %t1028
  %t1030 = icmp eq i32 %t1023, 4
  %t1031 = select i1 %t1030, %Block %t1029, %Block zeroinitializer
  %t1032 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1033 = bitcast [88 x i8]* %t1032 to i8*
  %t1034 = getelementptr inbounds i8, i8* %t1033, i64 56
  %t1035 = bitcast i8* %t1034 to %Block*
  %t1036 = load %Block, %Block* %t1035
  %t1037 = icmp eq i32 %t1023, 5
  %t1038 = select i1 %t1037, %Block %t1036, %Block %t1031
  %t1039 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1040 = bitcast [56 x i8]* %t1039 to i8*
  %t1041 = getelementptr inbounds i8, i8* %t1040, i64 16
  %t1042 = bitcast i8* %t1041 to %Block*
  %t1043 = load %Block, %Block* %t1042
  %t1044 = icmp eq i32 %t1023, 6
  %t1045 = select i1 %t1044, %Block %t1043, %Block %t1038
  %t1046 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1047 = bitcast [88 x i8]* %t1046 to i8*
  %t1048 = getelementptr inbounds i8, i8* %t1047, i64 56
  %t1049 = bitcast i8* %t1048 to %Block*
  %t1050 = load %Block, %Block* %t1049
  %t1051 = icmp eq i32 %t1023, 7
  %t1052 = select i1 %t1051, %Block %t1050, %Block %t1045
  %t1053 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1054 = bitcast [120 x i8]* %t1053 to i8*
  %t1055 = getelementptr inbounds i8, i8* %t1054, i64 88
  %t1056 = bitcast i8* %t1055 to %Block*
  %t1057 = load %Block, %Block* %t1056
  %t1058 = icmp eq i32 %t1023, 12
  %t1059 = select i1 %t1058, %Block %t1057, %Block %t1052
  %t1060 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1061 = bitcast [40 x i8]* %t1060 to i8*
  %t1062 = getelementptr inbounds i8, i8* %t1061, i64 8
  %t1063 = bitcast i8* %t1062 to %Block*
  %t1064 = load %Block, %Block* %t1063
  %t1065 = icmp eq i32 %t1023, 13
  %t1066 = select i1 %t1065, %Block %t1064, %Block %t1059
  %t1067 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1068 = bitcast [136 x i8]* %t1067 to i8*
  %t1069 = getelementptr inbounds i8, i8* %t1068, i64 104
  %t1070 = bitcast i8* %t1069 to %Block*
  %t1071 = load %Block, %Block* %t1070
  %t1072 = icmp eq i32 %t1023, 14
  %t1073 = select i1 %t1072, %Block %t1071, %Block %t1066
  %t1074 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1075 = bitcast [32 x i8]* %t1074 to i8*
  %t1076 = bitcast i8* %t1075 to %Block*
  %t1077 = load %Block, %Block* %t1076
  %t1078 = icmp eq i32 %t1023, 15
  %t1079 = select i1 %t1078, %Block %t1077, %Block %t1073
  %t1080 = extractvalue %Statement %statement, 0
  %t1081 = alloca %Statement
  store %Statement %statement, %Statement* %t1081
  %t1082 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1083 = bitcast [48 x i8]* %t1082 to i8*
  %t1084 = getelementptr inbounds i8, i8* %t1083, i64 40
  %t1085 = bitcast i8* %t1084 to { %Decorator**, i64 }**
  %t1086 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1085
  %t1087 = icmp eq i32 %t1080, 3
  %t1088 = select i1 %t1087, { %Decorator**, i64 }* %t1086, { %Decorator**, i64 }* null
  %t1089 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1090 = bitcast [88 x i8]* %t1089 to i8*
  %t1091 = getelementptr inbounds i8, i8* %t1090, i64 80
  %t1092 = bitcast i8* %t1091 to { %Decorator**, i64 }**
  %t1093 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1092
  %t1094 = icmp eq i32 %t1080, 4
  %t1095 = select i1 %t1094, { %Decorator**, i64 }* %t1093, { %Decorator**, i64 }* %t1088
  %t1096 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1097 = bitcast [88 x i8]* %t1096 to i8*
  %t1098 = getelementptr inbounds i8, i8* %t1097, i64 80
  %t1099 = bitcast i8* %t1098 to { %Decorator**, i64 }**
  %t1100 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1099
  %t1101 = icmp eq i32 %t1080, 5
  %t1102 = select i1 %t1101, { %Decorator**, i64 }* %t1100, { %Decorator**, i64 }* %t1095
  %t1103 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1104 = bitcast [56 x i8]* %t1103 to i8*
  %t1105 = getelementptr inbounds i8, i8* %t1104, i64 48
  %t1106 = bitcast i8* %t1105 to { %Decorator**, i64 }**
  %t1107 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1106
  %t1108 = icmp eq i32 %t1080, 6
  %t1109 = select i1 %t1108, { %Decorator**, i64 }* %t1107, { %Decorator**, i64 }* %t1102
  %t1110 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1111 = bitcast [88 x i8]* %t1110 to i8*
  %t1112 = getelementptr inbounds i8, i8* %t1111, i64 80
  %t1113 = bitcast i8* %t1112 to { %Decorator**, i64 }**
  %t1114 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1113
  %t1115 = icmp eq i32 %t1080, 7
  %t1116 = select i1 %t1115, { %Decorator**, i64 }* %t1114, { %Decorator**, i64 }* %t1109
  %t1117 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1118 = bitcast [56 x i8]* %t1117 to i8*
  %t1119 = getelementptr inbounds i8, i8* %t1118, i64 48
  %t1120 = bitcast i8* %t1119 to { %Decorator**, i64 }**
  %t1121 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1120
  %t1122 = icmp eq i32 %t1080, 8
  %t1123 = select i1 %t1122, { %Decorator**, i64 }* %t1121, { %Decorator**, i64 }* %t1116
  %t1124 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1125 = bitcast [40 x i8]* %t1124 to i8*
  %t1126 = getelementptr inbounds i8, i8* %t1125, i64 32
  %t1127 = bitcast i8* %t1126 to { %Decorator**, i64 }**
  %t1128 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1127
  %t1129 = icmp eq i32 %t1080, 9
  %t1130 = select i1 %t1129, { %Decorator**, i64 }* %t1128, { %Decorator**, i64 }* %t1123
  %t1131 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1132 = bitcast [40 x i8]* %t1131 to i8*
  %t1133 = getelementptr inbounds i8, i8* %t1132, i64 32
  %t1134 = bitcast i8* %t1133 to { %Decorator**, i64 }**
  %t1135 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1134
  %t1136 = icmp eq i32 %t1080, 10
  %t1137 = select i1 %t1136, { %Decorator**, i64 }* %t1135, { %Decorator**, i64 }* %t1130
  %t1138 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1139 = bitcast [40 x i8]* %t1138 to i8*
  %t1140 = getelementptr inbounds i8, i8* %t1139, i64 32
  %t1141 = bitcast i8* %t1140 to { %Decorator**, i64 }**
  %t1142 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1141
  %t1143 = icmp eq i32 %t1080, 11
  %t1144 = select i1 %t1143, { %Decorator**, i64 }* %t1142, { %Decorator**, i64 }* %t1137
  %t1145 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1146 = bitcast [120 x i8]* %t1145 to i8*
  %t1147 = getelementptr inbounds i8, i8* %t1146, i64 112
  %t1148 = bitcast i8* %t1147 to { %Decorator**, i64 }**
  %t1149 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1148
  %t1150 = icmp eq i32 %t1080, 12
  %t1151 = select i1 %t1150, { %Decorator**, i64 }* %t1149, { %Decorator**, i64 }* %t1144
  %t1152 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1153 = bitcast [40 x i8]* %t1152 to i8*
  %t1154 = getelementptr inbounds i8, i8* %t1153, i64 32
  %t1155 = bitcast i8* %t1154 to { %Decorator**, i64 }**
  %t1156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1155
  %t1157 = icmp eq i32 %t1080, 13
  %t1158 = select i1 %t1157, { %Decorator**, i64 }* %t1156, { %Decorator**, i64 }* %t1151
  %t1159 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1160 = bitcast [136 x i8]* %t1159 to i8*
  %t1161 = getelementptr inbounds i8, i8* %t1160, i64 128
  %t1162 = bitcast i8* %t1161 to { %Decorator**, i64 }**
  %t1163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1162
  %t1164 = icmp eq i32 %t1080, 14
  %t1165 = select i1 %t1164, { %Decorator**, i64 }* %t1163, { %Decorator**, i64 }* %t1158
  %t1166 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1167 = bitcast [32 x i8]* %t1166 to i8*
  %t1168 = getelementptr inbounds i8, i8* %t1167, i64 24
  %t1169 = bitcast i8* %t1168 to { %Decorator**, i64 }**
  %t1170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1169
  %t1171 = icmp eq i32 %t1080, 15
  %t1172 = select i1 %t1171, { %Decorator**, i64 }* %t1170, { %Decorator**, i64 }* %t1165
  %t1173 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1174 = bitcast [64 x i8]* %t1173 to i8*
  %t1175 = getelementptr inbounds i8, i8* %t1174, i64 56
  %t1176 = bitcast i8* %t1175 to { %Decorator**, i64 }**
  %t1177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1176
  %t1178 = icmp eq i32 %t1080, 18
  %t1179 = select i1 %t1178, { %Decorator**, i64 }* %t1177, { %Decorator**, i64 }* %t1172
  %t1180 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1181 = bitcast [88 x i8]* %t1180 to i8*
  %t1182 = getelementptr inbounds i8, i8* %t1181, i64 80
  %t1183 = bitcast i8* %t1182 to { %Decorator**, i64 }**
  %t1184 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1183
  %t1185 = icmp eq i32 %t1080, 19
  %t1186 = select i1 %t1185, { %Decorator**, i64 }* %t1184, { %Decorator**, i64 }* %t1179
  %t1187 = load i8*, i8** %l5
  %t1188 = bitcast { %Decorator**, i64 }* %t1186 to { %Decorator*, i64 }*
  %t1189 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1022, %Block %t1079, { %Decorator*, i64 }* %t1188, i8* %t1187)
  ret { %EffectViolation*, i64 }* %t1189
merge7:
  %t1190 = extractvalue %Statement %statement, 0
  %t1191 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1192 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1190, 0
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1190, 1
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1190, 2
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1190, 3
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1190, 4
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1190, 5
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1190, 6
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1190, 7
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1190, 8
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1190, 9
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1190, 10
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1190, 11
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1190, 12
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %t1231 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1190, 13
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1190, 14
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1190, 15
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %t1240 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1241 = icmp eq i32 %t1190, 16
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1239
  %t1243 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1244 = icmp eq i32 %t1190, 17
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1242
  %t1246 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1247 = icmp eq i32 %t1190, 18
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1245
  %t1249 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1250 = icmp eq i32 %t1190, 19
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1248
  %t1252 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1190, 20
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1190, 21
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1190, 22
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %s1261 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t1262 = call i1 @strings_equal(i8* %t1260, i8* %s1261)
  br i1 %t1262, label %then8, label %merge9
then8:
  %t1263 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1264 = ptrtoint [0 x %EffectViolation]* %t1263 to i64
  %t1265 = icmp eq i64 %t1264, 0
  %t1266 = select i1 %t1265, i64 1, i64 %t1264
  %t1267 = call i8* @malloc(i64 %t1266)
  %t1268 = bitcast i8* %t1267 to %EffectViolation*
  %t1269 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t1270 = ptrtoint { %EffectViolation*, i64 }* %t1269 to i64
  %t1271 = call i8* @malloc(i64 %t1270)
  %t1272 = bitcast i8* %t1271 to { %EffectViolation*, i64 }*
  %t1273 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1272, i32 0, i32 0
  store %EffectViolation* %t1268, %EffectViolation** %t1273
  %t1274 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1272, i32 0, i32 1
  store i64 0, i64* %t1274
  store { %EffectViolation*, i64 }* %t1272, { %EffectViolation*, i64 }** %l6
  %t1275 = sitofp i64 0 to double
  store double %t1275, double* %l7
  %t1276 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1277 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1385 = phi { %EffectViolation*, i64 }* [ %t1276, %then8 ], [ %t1383, %loop.latch12 ]
  %t1386 = phi double [ %t1277, %then8 ], [ %t1384, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1385, { %EffectViolation*, i64 }** %l6
  store double %t1386, double* %l7
  br label %loop.body11
loop.body11:
  %t1278 = load double, double* %l7
  %t1279 = extractvalue %Statement %statement, 0
  %t1280 = alloca %Statement
  store %Statement %statement, %Statement* %t1280
  %t1281 = getelementptr inbounds %Statement, %Statement* %t1280, i32 0, i32 1
  %t1282 = bitcast [56 x i8]* %t1281 to i8*
  %t1283 = getelementptr inbounds i8, i8* %t1282, i64 40
  %t1284 = bitcast i8* %t1283 to { %MethodDeclaration**, i64 }**
  %t1285 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1284
  %t1286 = icmp eq i32 %t1279, 8
  %t1287 = select i1 %t1286, { %MethodDeclaration**, i64 }* %t1285, { %MethodDeclaration**, i64 }* null
  %t1288 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1287
  %t1289 = extractvalue { %MethodDeclaration**, i64 } %t1288, 1
  %t1290 = sitofp i64 %t1289 to double
  %t1291 = fcmp oge double %t1278, %t1290
  %t1292 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1293 = load double, double* %l7
  br i1 %t1291, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1294 = extractvalue %Statement %statement, 0
  %t1295 = alloca %Statement
  store %Statement %statement, %Statement* %t1295
  %t1296 = getelementptr inbounds %Statement, %Statement* %t1295, i32 0, i32 1
  %t1297 = bitcast [56 x i8]* %t1296 to i8*
  %t1298 = getelementptr inbounds i8, i8* %t1297, i64 40
  %t1299 = bitcast i8* %t1298 to { %MethodDeclaration**, i64 }**
  %t1300 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1299
  %t1301 = icmp eq i32 %t1294, 8
  %t1302 = select i1 %t1301, { %MethodDeclaration**, i64 }* %t1300, { %MethodDeclaration**, i64 }* null
  %t1303 = load double, double* %l7
  %t1304 = call double @llvm.round.f64(double %t1303)
  %t1305 = fptosi double %t1304 to i64
  %t1306 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1302
  %t1307 = extractvalue { %MethodDeclaration**, i64 } %t1306, 0
  %t1308 = extractvalue { %MethodDeclaration**, i64 } %t1306, 1
  %t1309 = icmp uge i64 %t1305, %t1308
  ; bounds check: %t1309 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1305, i64 %t1308)
  %t1310 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1307, i64 %t1305
  %t1311 = load %MethodDeclaration*, %MethodDeclaration** %t1310
  store %MethodDeclaration* %t1311, %MethodDeclaration** %l8
  %t1312 = extractvalue %Statement %statement, 0
  %t1313 = alloca %Statement
  store %Statement %statement, %Statement* %t1313
  %t1314 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1315 = bitcast [48 x i8]* %t1314 to i8*
  %t1316 = bitcast i8* %t1315 to i8**
  %t1317 = load i8*, i8** %t1316
  %t1318 = icmp eq i32 %t1312, 2
  %t1319 = select i1 %t1318, i8* %t1317, i8* null
  %t1320 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1321 = bitcast [48 x i8]* %t1320 to i8*
  %t1322 = bitcast i8* %t1321 to i8**
  %t1323 = load i8*, i8** %t1322
  %t1324 = icmp eq i32 %t1312, 3
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1319
  %t1326 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1327 = bitcast [56 x i8]* %t1326 to i8*
  %t1328 = bitcast i8* %t1327 to i8**
  %t1329 = load i8*, i8** %t1328
  %t1330 = icmp eq i32 %t1312, 6
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1325
  %t1332 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1333 = bitcast [56 x i8]* %t1332 to i8*
  %t1334 = bitcast i8* %t1333 to i8**
  %t1335 = load i8*, i8** %t1334
  %t1336 = icmp eq i32 %t1312, 8
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1331
  %t1338 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1339 = bitcast [40 x i8]* %t1338 to i8*
  %t1340 = bitcast i8* %t1339 to i8**
  %t1341 = load i8*, i8** %t1340
  %t1342 = icmp eq i32 %t1312, 9
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1337
  %t1344 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1345 = bitcast [40 x i8]* %t1344 to i8*
  %t1346 = bitcast i8* %t1345 to i8**
  %t1347 = load i8*, i8** %t1346
  %t1348 = icmp eq i32 %t1312, 10
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1343
  %t1350 = getelementptr inbounds %Statement, %Statement* %t1313, i32 0, i32 1
  %t1351 = bitcast [40 x i8]* %t1350 to i8*
  %t1352 = bitcast i8* %t1351 to i8**
  %t1353 = load i8*, i8** %t1352
  %t1354 = icmp eq i32 %t1312, 11
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1349
  %t1356 = alloca [2 x i8], align 1
  %t1357 = getelementptr [2 x i8], [2 x i8]* %t1356, i32 0, i32 0
  store i8 46, i8* %t1357
  %t1358 = getelementptr [2 x i8], [2 x i8]* %t1356, i32 0, i32 1
  store i8 0, i8* %t1358
  %t1359 = getelementptr [2 x i8], [2 x i8]* %t1356, i32 0, i32 0
  %t1360 = call i8* @sailfin_runtime_string_concat(i8* %t1355, i8* %t1359)
  %t1361 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1362 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1361, i32 0, i32 0
  %t1363 = load %FunctionSignature, %FunctionSignature* %t1362
  %t1364 = extractvalue %FunctionSignature %t1363, 0
  %t1365 = call i8* @sailfin_runtime_string_concat(i8* %t1360, i8* %t1364)
  store i8* %t1365, i8** %l9
  %t1366 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1367 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1368 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1367, i32 0, i32 0
  %t1369 = load %FunctionSignature, %FunctionSignature* %t1368
  %t1370 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1371 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1370, i32 0, i32 1
  %t1372 = load %Block, %Block* %t1371
  %t1373 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1374 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1373, i32 0, i32 2
  %t1375 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1374
  %t1376 = load i8*, i8** %l9
  %t1377 = bitcast { %Decorator**, i64 }* %t1375 to { %Decorator*, i64 }*
  %t1378 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1369, %Block %t1372, { %Decorator*, i64 }* %t1377, i8* %t1376)
  %t1379 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t1366, { %EffectViolation*, i64 }* %t1378)
  store { %EffectViolation*, i64 }* %t1379, { %EffectViolation*, i64 }** %l6
  %t1380 = load double, double* %l7
  %t1381 = sitofp i64 1 to double
  %t1382 = fadd double %t1380, %t1381
  store double %t1382, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1383 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1384 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1387 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1388 = load double, double* %l7
  %t1389 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1389
merge9:
  %t1390 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1391 = ptrtoint [0 x %EffectViolation]* %t1390 to i64
  %t1392 = icmp eq i64 %t1391, 0
  %t1393 = select i1 %t1392, i64 1, i64 %t1391
  %t1394 = call i8* @malloc(i64 %t1393)
  %t1395 = bitcast i8* %t1394 to %EffectViolation*
  %t1396 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t1397 = ptrtoint { %EffectViolation*, i64 }* %t1396 to i64
  %t1398 = call i8* @malloc(i64 %t1397)
  %t1399 = bitcast i8* %t1398 to { %EffectViolation*, i64 }*
  %t1400 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1399, i32 0, i32 0
  store %EffectViolation* %t1395, %EffectViolation** %t1400
  %t1401 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1399, i32 0, i32 1
  store i64 0, i64* %t1401
  ret { %EffectViolation*, i64 }* %t1399
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
  %t101 = phi i1 [ %t51, %afterloop3 ], [ %t99, %loop.latch8 ]
  %t102 = phi double [ %t52, %afterloop3 ], [ %t100, %loop.latch8 ]
  store i1 %t101, i1* %l3
  store double %t102, double* %l4
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
  %s77 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h515589823, i32 0, i32 0
  %t78 = call i1 @strings_equal(i8* %t76, i8* %s77)
  br label %logical_or_entry_74

logical_or_entry_74:
  br i1 %t78, label %logical_or_merge_74, label %logical_or_right_74

logical_or_right_74:
  %t80 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t81 = extractvalue %DecoratorInfo %t80, 0
  %s82 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1147459442, i32 0, i32 0
  %t83 = call i1 @strings_equal(i8* %t81, i8* %s82)
  br label %logical_or_entry_79

logical_or_entry_79:
  br i1 %t83, label %logical_or_merge_79, label %logical_or_right_79

logical_or_right_79:
  %t84 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t85 = extractvalue %DecoratorInfo %t84, 0
  %s86 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1170311443, i32 0, i32 0
  %t87 = call i1 @strings_equal(i8* %t85, i8* %s86)
  br label %logical_or_right_end_79

logical_or_right_end_79:
  br label %logical_or_merge_79

logical_or_merge_79:
  %t88 = phi i1 [ true, %logical_or_entry_79 ], [ %t87, %logical_or_right_end_79 ]
  br label %logical_or_right_end_74

logical_or_right_end_74:
  br label %logical_or_merge_74

logical_or_merge_74:
  %t89 = phi i1 [ true, %logical_or_entry_74 ], [ %t88, %logical_or_right_end_74 ]
  %t90 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t92 = load double, double* %l2
  %t93 = load i1, i1* %l3
  %t94 = load double, double* %l4
  %t95 = load %DecoratorInfo, %DecoratorInfo* %l5
  br i1 %t89, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t96 = load double, double* %l4
  %t97 = sitofp i64 1 to double
  %t98 = fadd double %t96, %t97
  store double %t98, double* %l4
  br label %loop.latch8
loop.latch8:
  %t99 = load i1, i1* %l3
  %t100 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t103 = load i1, i1* %l3
  %t104 = load double, double* %l4
  %t105 = load i1, i1* %l3
  %t106 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t108 = load double, double* %l2
  %t109 = load i1, i1* %l3
  %t110 = load double, double* %l4
  br i1 %t105, label %then14, label %merge15
then14:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s112 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t113 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t111, i8* %s112)
  store { i8**, i64 }* %t113, { i8**, i64 }** %l1
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t115 = phi { i8**, i64 }* [ %t114, %then14 ], [ %t107, %afterloop9 ]
  store { i8**, i64 }* %t115, { i8**, i64 }** %l1
  %t116 = call { %EffectRequirement*, i64 }* @required_effects(%Block %body)
  store { %EffectRequirement*, i64 }* %t116, { %EffectRequirement*, i64 }** %l6
  %t117 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t118 = ptrtoint [0 x i8*]* %t117 to i64
  %t119 = icmp eq i64 %t118, 0
  %t120 = select i1 %t119, i64 1, i64 %t118
  %t121 = call i8* @malloc(i64 %t120)
  %t122 = bitcast i8* %t121 to i8**
  %t123 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t124 = ptrtoint { i8**, i64 }* %t123 to i64
  %t125 = call i8* @malloc(i64 %t124)
  %t126 = bitcast i8* %t125 to { i8**, i64 }*
  %t127 = getelementptr { i8**, i64 }, { i8**, i64 }* %t126, i32 0, i32 0
  store i8** %t122, i8*** %t127
  %t128 = getelementptr { i8**, i64 }, { i8**, i64 }* %t126, i32 0, i32 1
  store i64 0, i64* %t128
  store { i8**, i64 }* %t126, { i8**, i64 }** %l7
  %t129 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t130 = ptrtoint [0 x %EffectRequirement]* %t129 to i64
  %t131 = icmp eq i64 %t130, 0
  %t132 = select i1 %t131, i64 1, i64 %t130
  %t133 = call i8* @malloc(i64 %t132)
  %t134 = bitcast i8* %t133 to %EffectRequirement*
  %t135 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t136 = ptrtoint { %EffectRequirement*, i64 }* %t135 to i64
  %t137 = call i8* @malloc(i64 %t136)
  %t138 = bitcast i8* %t137 to { %EffectRequirement*, i64 }*
  %t139 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t138, i32 0, i32 0
  store %EffectRequirement* %t134, %EffectRequirement** %t139
  %t140 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t138, i32 0, i32 1
  store i64 0, i64* %t140
  store { %EffectRequirement*, i64 }* %t138, { %EffectRequirement*, i64 }** %l8
  %t141 = sitofp i64 0 to double
  store double %t141, double* %l9
  %t142 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t144 = load double, double* %l2
  %t145 = load i1, i1* %l3
  %t146 = load double, double* %l4
  %t147 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t149 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t150 = load double, double* %l9
  br label %loop.header16
loop.header16:
  %t244 = phi double [ %t150, %merge15 ], [ %t241, %loop.latch18 ]
  %t245 = phi { i8**, i64 }* [ %t148, %merge15 ], [ %t242, %loop.latch18 ]
  %t246 = phi { %EffectRequirement*, i64 }* [ %t149, %merge15 ], [ %t243, %loop.latch18 ]
  store double %t244, double* %l9
  store { i8**, i64 }* %t245, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t246, { %EffectRequirement*, i64 }** %l8
  br label %loop.body17
loop.body17:
  %t151 = load double, double* %l9
  %t152 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t153 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t152
  %t154 = extractvalue { %EffectRequirement*, i64 } %t153, 1
  %t155 = sitofp i64 %t154 to double
  %t156 = fcmp oge double %t151, %t155
  %t157 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load double, double* %l2
  %t160 = load i1, i1* %l3
  %t161 = load double, double* %l4
  %t162 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t164 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t165 = load double, double* %l9
  br i1 %t156, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t166 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t167 = load double, double* %l9
  %t168 = call double @llvm.round.f64(double %t167)
  %t169 = fptosi double %t168 to i64
  %t170 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t166
  %t171 = extractvalue { %EffectRequirement*, i64 } %t170, 0
  %t172 = extractvalue { %EffectRequirement*, i64 } %t170, 1
  %t173 = icmp uge i64 %t169, %t172
  ; bounds check: %t173 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t169, i64 %t172)
  %t174 = getelementptr %EffectRequirement, %EffectRequirement* %t171, i64 %t169
  %t175 = load %EffectRequirement, %EffectRequirement* %t174
  store %EffectRequirement %t175, %EffectRequirement* %l10
  %t176 = load %EffectRequirement, %EffectRequirement* %l10
  %t177 = extractvalue %EffectRequirement %t176, 0
  store i8* %t177, i8** %l11
  %t179 = load i8*, i8** %l11
  %s180 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t181 = call i1 @strings_equal(i8* %t179, i8* %s180)
  br label %logical_and_entry_178

logical_and_entry_178:
  br i1 %t181, label %logical_and_right_178, label %logical_and_merge_178

logical_and_right_178:
  %t182 = load i1, i1* %l3
  br label %logical_and_right_end_178

logical_and_right_end_178:
  br label %logical_and_merge_178

logical_and_merge_178:
  %t183 = phi i1 [ false, %logical_and_entry_178 ], [ %t182, %logical_and_right_end_178 ]
  %t184 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t186 = load double, double* %l2
  %t187 = load i1, i1* %l3
  %t188 = load double, double* %l4
  %t189 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t191 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t192 = load double, double* %l9
  %t193 = load %EffectRequirement, %EffectRequirement* %l10
  %t194 = load i8*, i8** %l11
  br i1 %t183, label %then22, label %merge23
then22:
  %t195 = load double, double* %l9
  %t196 = sitofp i64 1 to double
  %t197 = fadd double %t195, %t196
  store double %t197, double* %l9
  br label %loop.latch18
merge23:
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t199 = load i8*, i8** %l11
  %t200 = call i1 @contains_effect({ i8**, i64 }* %t198, i8* %t199)
  %t201 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t203 = load double, double* %l2
  %t204 = load i1, i1* %l3
  %t205 = load double, double* %l4
  %t206 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t208 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t209 = load double, double* %l9
  %t210 = load %EffectRequirement, %EffectRequirement* %l10
  %t211 = load i8*, i8** %l11
  br i1 %t200, label %then24, label %merge25
then24:
  %t212 = load double, double* %l9
  %t213 = sitofp i64 1 to double
  %t214 = fadd double %t212, %t213
  store double %t214, double* %l9
  br label %loop.latch18
merge25:
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t216 = load i8*, i8** %l11
  %t217 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t215, i8* %t216)
  store { i8**, i64 }* %t217, { i8**, i64 }** %l7
  %t218 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t219 = load i8*, i8** %l11
  %t220 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t218, i8* %t219)
  %t221 = xor i1 %t220, 1
  %t222 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load double, double* %l2
  %t225 = load i1, i1* %l3
  %t226 = load double, double* %l4
  %t227 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t229 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t230 = load double, double* %l9
  %t231 = load %EffectRequirement, %EffectRequirement* %l10
  %t232 = load i8*, i8** %l11
  br i1 %t221, label %then26, label %merge27
then26:
  %t233 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t234 = load %EffectRequirement, %EffectRequirement* %l10
  %t235 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t233, %EffectRequirement %t234)
  store { %EffectRequirement*, i64 }* %t235, { %EffectRequirement*, i64 }** %l8
  %t236 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %merge27
merge27:
  %t237 = phi { %EffectRequirement*, i64 }* [ %t236, %then26 ], [ %t229, %merge25 ]
  store { %EffectRequirement*, i64 }* %t237, { %EffectRequirement*, i64 }** %l8
  %t238 = load double, double* %l9
  %t239 = sitofp i64 1 to double
  %t240 = fadd double %t238, %t239
  store double %t240, double* %l9
  br label %loop.latch18
loop.latch18:
  %t241 = load double, double* %l9
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t243 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header16
afterloop19:
  %t247 = load double, double* %l9
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t249 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t251 = load { i8**, i64 }, { i8**, i64 }* %t250
  %t252 = extractvalue { i8**, i64 } %t251, 1
  %t253 = icmp eq i64 %t252, 0
  %t254 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t256 = load double, double* %l2
  %t257 = load i1, i1* %l3
  %t258 = load double, double* %l4
  %t259 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t261 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t262 = load double, double* %l9
  br i1 %t253, label %then28, label %merge29
then28:
  %t263 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t264 = ptrtoint [0 x %EffectViolation]* %t263 to i64
  %t265 = icmp eq i64 %t264, 0
  %t266 = select i1 %t265, i64 1, i64 %t264
  %t267 = call i8* @malloc(i64 %t266)
  %t268 = bitcast i8* %t267 to %EffectViolation*
  %t269 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t270 = ptrtoint { %EffectViolation*, i64 }* %t269 to i64
  %t271 = call i8* @malloc(i64 %t270)
  %t272 = bitcast i8* %t271 to { %EffectViolation*, i64 }*
  %t273 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t272, i32 0, i32 0
  store %EffectViolation* %t268, %EffectViolation** %t273
  %t274 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t272, i32 0, i32 1
  store i64 0, i64* %t274
  ret { %EffectViolation*, i64 }* %t272
merge29:
  %t275 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t276 = ptrtoint [0 x %EffectViolation]* %t275 to i64
  %t277 = icmp eq i64 %t276, 0
  %t278 = select i1 %t277, i64 1, i64 %t276
  %t279 = call i8* @malloc(i64 %t278)
  %t280 = bitcast i8* %t279 to %EffectViolation*
  %t281 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t282 = ptrtoint { %EffectViolation*, i64 }* %t281 to i64
  %t283 = call i8* @malloc(i64 %t282)
  %t284 = bitcast i8* %t283 to { %EffectViolation*, i64 }*
  %t285 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t284, i32 0, i32 0
  store %EffectViolation* %t280, %EffectViolation** %t285
  %t286 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t284, i32 0, i32 1
  store i64 0, i64* %t286
  store { %EffectViolation*, i64 }* %t284, { %EffectViolation*, i64 }** %l12
  %t287 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  %t288 = insertvalue %EffectViolation undef, i8* %name, 0
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t290 = insertvalue %EffectViolation %t288, { i8**, i64 }* %t289, 1
  %t291 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t292 = bitcast { %EffectRequirement*, i64 }* %t291 to { %EffectRequirement**, i64 }*
  %t293 = insertvalue %EffectViolation %t290, { %EffectRequirement**, i64 }* %t292, 2
  %t294 = call { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %t287, %EffectViolation %t293)
  store { %EffectViolation*, i64 }* %t294, { %EffectViolation*, i64 }** %l12
  %t295 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t295
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
  %t1 = bitcast { %Token**, i64 }* %t0 to { %Token*, i64 }*
  %t2 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1)
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t5 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t33 = phi { %EffectRequirement*, i64 }* [ %t4, %block.entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t5, %block.entry ], [ %t32, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t33, { %EffectRequirement*, i64 }** %l0
  store double %t34, double* %l1
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l1
  %t7 = extractvalue %Block %block, 2
  %t8 = load { %Statement**, i64 }, { %Statement**, i64 }* %t7
  %t9 = extractvalue { %Statement**, i64 } %t8, 1
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp oge double %t6, %t10
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t15 = extractvalue %Block %block, 2
  %t16 = load double, double* %l1
  %t17 = call double @llvm.round.f64(double %t16)
  %t18 = fptosi double %t17 to i64
  %t19 = load { %Statement**, i64 }, { %Statement**, i64 }* %t15
  %t20 = extractvalue { %Statement**, i64 } %t19, 0
  %t21 = extractvalue { %Statement**, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t18, i64 %t21)
  %t23 = getelementptr %Statement*, %Statement** %t20, i64 %t18
  %t24 = load %Statement*, %Statement** %t23
  %t25 = load %Statement, %Statement* %t24
  %t26 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %t25)
  %t27 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t14, { %EffectRequirement*, i64 }* %t26)
  store { %EffectRequirement*, i64 }* %t27, { %EffectRequirement*, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch2
loop.latch2:
  %t31 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t37
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
  %l3 = alloca %WithClause*
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
  %s71 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1067284810, i32 0, i32 0
  %t72 = call i1 @strings_equal(i8* %t70, i8* %s71)
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [88 x i8]* %t75 to i8*
  %t77 = getelementptr inbounds i8, i8* %t76, i64 56
  %t78 = bitcast i8* %t77 to %Block*
  %t79 = load %Block, %Block* %t78
  %t80 = icmp eq i32 %t73, 4
  %t81 = select i1 %t80, %Block %t79, %Block zeroinitializer
  %t82 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t83 = bitcast [88 x i8]* %t82 to i8*
  %t84 = getelementptr inbounds i8, i8* %t83, i64 56
  %t85 = bitcast i8* %t84 to %Block*
  %t86 = load %Block, %Block* %t85
  %t87 = icmp eq i32 %t73, 5
  %t88 = select i1 %t87, %Block %t86, %Block %t81
  %t89 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t90 = bitcast [56 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 16
  %t92 = bitcast i8* %t91 to %Block*
  %t93 = load %Block, %Block* %t92
  %t94 = icmp eq i32 %t73, 6
  %t95 = select i1 %t94, %Block %t93, %Block %t88
  %t96 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t97 = bitcast [88 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 56
  %t99 = bitcast i8* %t98 to %Block*
  %t100 = load %Block, %Block* %t99
  %t101 = icmp eq i32 %t73, 7
  %t102 = select i1 %t101, %Block %t100, %Block %t95
  %t103 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t104 = bitcast [120 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 88
  %t106 = bitcast i8* %t105 to %Block*
  %t107 = load %Block, %Block* %t106
  %t108 = icmp eq i32 %t73, 12
  %t109 = select i1 %t108, %Block %t107, %Block %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t111 = bitcast [40 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 8
  %t113 = bitcast i8* %t112 to %Block*
  %t114 = load %Block, %Block* %t113
  %t115 = icmp eq i32 %t73, 13
  %t116 = select i1 %t115, %Block %t114, %Block %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t118 = bitcast [136 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 104
  %t120 = bitcast i8* %t119 to %Block*
  %t121 = load %Block, %Block* %t120
  %t122 = icmp eq i32 %t73, 14
  %t123 = select i1 %t122, %Block %t121, %Block %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t125 = bitcast [32 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to %Block*
  %t127 = load %Block, %Block* %t126
  %t128 = icmp eq i32 %t73, 15
  %t129 = select i1 %t128, %Block %t127, %Block %t123
  %t130 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t129)
  store { %EffectRequirement*, i64 }* %t130, { %EffectRequirement*, i64 }** %l0
  %t131 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s132 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t133 = insertvalue %EffectRequirement undef, i8* %s132, 0
  %t134 = extractvalue %Statement %statement, 0
  %t135 = alloca %Statement
  store %Statement %statement, %Statement* %t135
  %t136 = getelementptr inbounds %Statement, %Statement* %t135, i32 0, i32 1
  %t137 = bitcast [120 x i8]* %t136 to i8*
  %t138 = getelementptr inbounds i8, i8* %t137, i64 8
  %t139 = bitcast i8* %t138 to %Token*
  %t140 = load %Token, %Token* %t139
  %t141 = icmp eq i32 %t134, 12
  %t142 = select i1 %t141, %Token %t140, %Token zeroinitializer
  %t143 = alloca %Token
  store %Token %t142, %Token* %t143
  %t144 = insertvalue %EffectRequirement %t133, %Token* %t143, 1
  %s145 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h196867800, i32 0, i32 0
  %t146 = extractvalue %Statement %statement, 0
  %t147 = alloca %Statement
  store %Statement %statement, %Statement* %t147
  %t148 = getelementptr inbounds %Statement, %Statement* %t147, i32 0, i32 1
  %t149 = bitcast [120 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t146, 12
  %t153 = select i1 %t152, i8* %t151, i8* null
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %s145, i8* %t153)
  %t155 = alloca [2 x i8], align 1
  %t156 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  store i8 34, i8* %t156
  %t157 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 1
  store i8 0, i8* %t157
  %t158 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  %t159 = call i8* @sailfin_runtime_string_concat(i8* %t154, i8* %t158)
  %t160 = insertvalue %EffectRequirement %t144, i8* %t159, 2
  %t161 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t131, %EffectRequirement %t160)
  store { %EffectRequirement*, i64 }* %t161, { %EffectRequirement*, i64 }** %l0
  %t162 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t162
merge1:
  %t163 = extractvalue %Statement %statement, 0
  %t164 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t165 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t163, 0
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t163, 1
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t163, 2
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t163, 3
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t163, 4
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t163, 5
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t163, 6
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t163, 7
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t163, 8
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t163, 9
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t163, 10
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t163, 11
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t163, 12
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t163, 13
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t163, 14
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t163, 15
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t163, 16
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t163, 17
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t163, 18
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t163, 19
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t163, 20
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t163, 21
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %t231 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t163, 22
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %s234 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1925822000, i32 0, i32 0
  %t235 = call i1 @strings_equal(i8* %t233, i8* %s234)
  br i1 %t235, label %then2, label %merge3
then2:
  %t236 = extractvalue %Statement %statement, 0
  %t237 = alloca %Statement
  store %Statement %statement, %Statement* %t237
  %t238 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t239 = bitcast [88 x i8]* %t238 to i8*
  %t240 = getelementptr inbounds i8, i8* %t239, i64 56
  %t241 = bitcast i8* %t240 to %Block*
  %t242 = load %Block, %Block* %t241
  %t243 = icmp eq i32 %t236, 4
  %t244 = select i1 %t243, %Block %t242, %Block zeroinitializer
  %t245 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t246 = bitcast [88 x i8]* %t245 to i8*
  %t247 = getelementptr inbounds i8, i8* %t246, i64 56
  %t248 = bitcast i8* %t247 to %Block*
  %t249 = load %Block, %Block* %t248
  %t250 = icmp eq i32 %t236, 5
  %t251 = select i1 %t250, %Block %t249, %Block %t244
  %t252 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t253 = bitcast [56 x i8]* %t252 to i8*
  %t254 = getelementptr inbounds i8, i8* %t253, i64 16
  %t255 = bitcast i8* %t254 to %Block*
  %t256 = load %Block, %Block* %t255
  %t257 = icmp eq i32 %t236, 6
  %t258 = select i1 %t257, %Block %t256, %Block %t251
  %t259 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t260 = bitcast [88 x i8]* %t259 to i8*
  %t261 = getelementptr inbounds i8, i8* %t260, i64 56
  %t262 = bitcast i8* %t261 to %Block*
  %t263 = load %Block, %Block* %t262
  %t264 = icmp eq i32 %t236, 7
  %t265 = select i1 %t264, %Block %t263, %Block %t258
  %t266 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t267 = bitcast [120 x i8]* %t266 to i8*
  %t268 = getelementptr inbounds i8, i8* %t267, i64 88
  %t269 = bitcast i8* %t268 to %Block*
  %t270 = load %Block, %Block* %t269
  %t271 = icmp eq i32 %t236, 12
  %t272 = select i1 %t271, %Block %t270, %Block %t265
  %t273 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t274 = bitcast [40 x i8]* %t273 to i8*
  %t275 = getelementptr inbounds i8, i8* %t274, i64 8
  %t276 = bitcast i8* %t275 to %Block*
  %t277 = load %Block, %Block* %t276
  %t278 = icmp eq i32 %t236, 13
  %t279 = select i1 %t278, %Block %t277, %Block %t272
  %t280 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t281 = bitcast [136 x i8]* %t280 to i8*
  %t282 = getelementptr inbounds i8, i8* %t281, i64 104
  %t283 = bitcast i8* %t282 to %Block*
  %t284 = load %Block, %Block* %t283
  %t285 = icmp eq i32 %t236, 14
  %t286 = select i1 %t285, %Block %t284, %Block %t279
  %t287 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t288 = bitcast [32 x i8]* %t287 to i8*
  %t289 = bitcast i8* %t288 to %Block*
  %t290 = load %Block, %Block* %t289
  %t291 = icmp eq i32 %t236, 15
  %t292 = select i1 %t291, %Block %t290, %Block %t286
  %t293 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t292)
  store { %EffectRequirement*, i64 }* %t293, { %EffectRequirement*, i64 }** %l1
  %t294 = sitofp i64 0 to double
  store double %t294, double* %l2
  %t295 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t296 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t341 = phi { %EffectRequirement*, i64 }* [ %t295, %then2 ], [ %t339, %loop.latch6 ]
  %t342 = phi double [ %t296, %then2 ], [ %t340, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t341, { %EffectRequirement*, i64 }** %l1
  store double %t342, double* %l2
  br label %loop.body5
loop.body5:
  %t297 = load double, double* %l2
  %t298 = extractvalue %Statement %statement, 0
  %t299 = alloca %Statement
  store %Statement %statement, %Statement* %t299
  %t300 = getelementptr inbounds %Statement, %Statement* %t299, i32 0, i32 1
  %t301 = bitcast [40 x i8]* %t300 to i8*
  %t302 = bitcast i8* %t301 to { %WithClause**, i64 }**
  %t303 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t302
  %t304 = icmp eq i32 %t298, 13
  %t305 = select i1 %t304, { %WithClause**, i64 }* %t303, { %WithClause**, i64 }* null
  %t306 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t305
  %t307 = extractvalue { %WithClause**, i64 } %t306, 1
  %t308 = sitofp i64 %t307 to double
  %t309 = fcmp oge double %t297, %t308
  %t310 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t311 = load double, double* %l2
  br i1 %t309, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t312 = extractvalue %Statement %statement, 0
  %t313 = alloca %Statement
  store %Statement %statement, %Statement* %t313
  %t314 = getelementptr inbounds %Statement, %Statement* %t313, i32 0, i32 1
  %t315 = bitcast [40 x i8]* %t314 to i8*
  %t316 = bitcast i8* %t315 to { %WithClause**, i64 }**
  %t317 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t316
  %t318 = icmp eq i32 %t312, 13
  %t319 = select i1 %t318, { %WithClause**, i64 }* %t317, { %WithClause**, i64 }* null
  %t320 = load double, double* %l2
  %t321 = call double @llvm.round.f64(double %t320)
  %t322 = fptosi double %t321 to i64
  %t323 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t319
  %t324 = extractvalue { %WithClause**, i64 } %t323, 0
  %t325 = extractvalue { %WithClause**, i64 } %t323, 1
  %t326 = icmp uge i64 %t322, %t325
  ; bounds check: %t326 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t322, i64 %t325)
  %t327 = getelementptr %WithClause*, %WithClause** %t324, i64 %t322
  %t328 = load %WithClause*, %WithClause** %t327
  store %WithClause* %t328, %WithClause** %l3
  %t329 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t330 = load %WithClause*, %WithClause** %l3
  %t331 = getelementptr %WithClause, %WithClause* %t330, i32 0, i32 0
  %t332 = load %Expression, %Expression* %t331
  %t333 = alloca %Expression
  store %Expression %t332, %Expression* %t333
  %t334 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t333)
  %t335 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t329, { %EffectRequirement*, i64 }* %t334)
  store { %EffectRequirement*, i64 }* %t335, { %EffectRequirement*, i64 }** %l1
  %t336 = load double, double* %l2
  %t337 = sitofp i64 1 to double
  %t338 = fadd double %t336, %t337
  store double %t338, double* %l2
  br label %loop.latch6
loop.latch6:
  %t339 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t340 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t343 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t344 = load double, double* %l2
  %t345 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t345
merge3:
  %t346 = extractvalue %Statement %statement, 0
  %t347 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t348 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t346, 0
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t346, 1
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t346, 2
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t346, 3
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t346, 4
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t346, 5
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t346, 6
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t346, 7
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %t372 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t373 = icmp eq i32 %t346, 8
  %t374 = select i1 %t373, i8* %t372, i8* %t371
  %t375 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t376 = icmp eq i32 %t346, 9
  %t377 = select i1 %t376, i8* %t375, i8* %t374
  %t378 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t379 = icmp eq i32 %t346, 10
  %t380 = select i1 %t379, i8* %t378, i8* %t377
  %t381 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t382 = icmp eq i32 %t346, 11
  %t383 = select i1 %t382, i8* %t381, i8* %t380
  %t384 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t385 = icmp eq i32 %t346, 12
  %t386 = select i1 %t385, i8* %t384, i8* %t383
  %t387 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t388 = icmp eq i32 %t346, 13
  %t389 = select i1 %t388, i8* %t387, i8* %t386
  %t390 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t391 = icmp eq i32 %t346, 14
  %t392 = select i1 %t391, i8* %t390, i8* %t389
  %t393 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t394 = icmp eq i32 %t346, 15
  %t395 = select i1 %t394, i8* %t393, i8* %t392
  %t396 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t397 = icmp eq i32 %t346, 16
  %t398 = select i1 %t397, i8* %t396, i8* %t395
  %t399 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t400 = icmp eq i32 %t346, 17
  %t401 = select i1 %t400, i8* %t399, i8* %t398
  %t402 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t403 = icmp eq i32 %t346, 18
  %t404 = select i1 %t403, i8* %t402, i8* %t401
  %t405 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t406 = icmp eq i32 %t346, 19
  %t407 = select i1 %t406, i8* %t405, i8* %t404
  %t408 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t409 = icmp eq i32 %t346, 20
  %t410 = select i1 %t409, i8* %t408, i8* %t407
  %t411 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t412 = icmp eq i32 %t346, 21
  %t413 = select i1 %t412, i8* %t411, i8* %t410
  %t414 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t415 = icmp eq i32 %t346, 22
  %t416 = select i1 %t415, i8* %t414, i8* %t413
  %s417 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h84042670, i32 0, i32 0
  %t418 = call i1 @strings_equal(i8* %t416, i8* %s417)
  br i1 %t418, label %then10, label %merge11
then10:
  %t419 = extractvalue %Statement %statement, 0
  %t420 = alloca %Statement
  store %Statement %statement, %Statement* %t420
  %t421 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t422 = bitcast [88 x i8]* %t421 to i8*
  %t423 = getelementptr inbounds i8, i8* %t422, i64 56
  %t424 = bitcast i8* %t423 to %Block*
  %t425 = load %Block, %Block* %t424
  %t426 = icmp eq i32 %t419, 4
  %t427 = select i1 %t426, %Block %t425, %Block zeroinitializer
  %t428 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t429 = bitcast [88 x i8]* %t428 to i8*
  %t430 = getelementptr inbounds i8, i8* %t429, i64 56
  %t431 = bitcast i8* %t430 to %Block*
  %t432 = load %Block, %Block* %t431
  %t433 = icmp eq i32 %t419, 5
  %t434 = select i1 %t433, %Block %t432, %Block %t427
  %t435 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t436 = bitcast [56 x i8]* %t435 to i8*
  %t437 = getelementptr inbounds i8, i8* %t436, i64 16
  %t438 = bitcast i8* %t437 to %Block*
  %t439 = load %Block, %Block* %t438
  %t440 = icmp eq i32 %t419, 6
  %t441 = select i1 %t440, %Block %t439, %Block %t434
  %t442 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t443 = bitcast [88 x i8]* %t442 to i8*
  %t444 = getelementptr inbounds i8, i8* %t443, i64 56
  %t445 = bitcast i8* %t444 to %Block*
  %t446 = load %Block, %Block* %t445
  %t447 = icmp eq i32 %t419, 7
  %t448 = select i1 %t447, %Block %t446, %Block %t441
  %t449 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t450 = bitcast [120 x i8]* %t449 to i8*
  %t451 = getelementptr inbounds i8, i8* %t450, i64 88
  %t452 = bitcast i8* %t451 to %Block*
  %t453 = load %Block, %Block* %t452
  %t454 = icmp eq i32 %t419, 12
  %t455 = select i1 %t454, %Block %t453, %Block %t448
  %t456 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t457 = bitcast [40 x i8]* %t456 to i8*
  %t458 = getelementptr inbounds i8, i8* %t457, i64 8
  %t459 = bitcast i8* %t458 to %Block*
  %t460 = load %Block, %Block* %t459
  %t461 = icmp eq i32 %t419, 13
  %t462 = select i1 %t461, %Block %t460, %Block %t455
  %t463 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t464 = bitcast [136 x i8]* %t463 to i8*
  %t465 = getelementptr inbounds i8, i8* %t464, i64 104
  %t466 = bitcast i8* %t465 to %Block*
  %t467 = load %Block, %Block* %t466
  %t468 = icmp eq i32 %t419, 14
  %t469 = select i1 %t468, %Block %t467, %Block %t462
  %t470 = getelementptr inbounds %Statement, %Statement* %t420, i32 0, i32 1
  %t471 = bitcast [32 x i8]* %t470 to i8*
  %t472 = bitcast i8* %t471 to %Block*
  %t473 = load %Block, %Block* %t472
  %t474 = icmp eq i32 %t419, 15
  %t475 = select i1 %t474, %Block %t473, %Block %t469
  %t476 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t475)
  store { %EffectRequirement*, i64 }* %t476, { %EffectRequirement*, i64 }** %l4
  %t477 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t478 = extractvalue %Statement %statement, 0
  %t479 = alloca %Statement
  store %Statement %statement, %Statement* %t479
  %t480 = getelementptr inbounds %Statement, %Statement* %t479, i32 0, i32 1
  %t481 = bitcast [136 x i8]* %t480 to i8*
  %t482 = bitcast i8* %t481 to %ForClause*
  %t483 = load %ForClause, %ForClause* %t482
  %t484 = icmp eq i32 %t478, 14
  %t485 = select i1 %t484, %ForClause %t483, %ForClause zeroinitializer
  %t486 = extractvalue %ForClause %t485, 0
  %t487 = alloca %Expression
  store %Expression %t486, %Expression* %t487
  %t488 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t487)
  %t489 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t477, { %EffectRequirement*, i64 }* %t488)
  store { %EffectRequirement*, i64 }* %t489, { %EffectRequirement*, i64 }** %l4
  %t490 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t491 = extractvalue %Statement %statement, 0
  %t492 = alloca %Statement
  store %Statement %statement, %Statement* %t492
  %t493 = getelementptr inbounds %Statement, %Statement* %t492, i32 0, i32 1
  %t494 = bitcast [136 x i8]* %t493 to i8*
  %t495 = bitcast i8* %t494 to %ForClause*
  %t496 = load %ForClause, %ForClause* %t495
  %t497 = icmp eq i32 %t491, 14
  %t498 = select i1 %t497, %ForClause %t496, %ForClause zeroinitializer
  %t499 = extractvalue %ForClause %t498, 1
  %t500 = alloca %Expression
  store %Expression %t499, %Expression* %t500
  %t501 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t500)
  %t502 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t490, { %EffectRequirement*, i64 }* %t501)
  store { %EffectRequirement*, i64 }* %t502, { %EffectRequirement*, i64 }** %l4
  %t503 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t503
merge11:
  %t504 = extractvalue %Statement %statement, 0
  %t505 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t506 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t504, 0
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t504, 1
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t504, 2
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t504, 3
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t504, 4
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t504, 5
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t504, 6
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t504, 7
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t504, 8
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t504, 9
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t504, 10
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t504, 11
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t504, 12
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t504, 13
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t504, 14
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t504, 15
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t504, 16
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t504, 17
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t504, 18
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t504, 19
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t504, 20
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t504, 21
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t504, 22
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %s575 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1678412334, i32 0, i32 0
  %t576 = call i1 @strings_equal(i8* %t574, i8* %s575)
  br i1 %t576, label %then12, label %merge13
then12:
  %t577 = extractvalue %Statement %statement, 0
  %t578 = alloca %Statement
  store %Statement %statement, %Statement* %t578
  %t579 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t580 = bitcast [88 x i8]* %t579 to i8*
  %t581 = getelementptr inbounds i8, i8* %t580, i64 56
  %t582 = bitcast i8* %t581 to %Block*
  %t583 = load %Block, %Block* %t582
  %t584 = icmp eq i32 %t577, 4
  %t585 = select i1 %t584, %Block %t583, %Block zeroinitializer
  %t586 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t587 = bitcast [88 x i8]* %t586 to i8*
  %t588 = getelementptr inbounds i8, i8* %t587, i64 56
  %t589 = bitcast i8* %t588 to %Block*
  %t590 = load %Block, %Block* %t589
  %t591 = icmp eq i32 %t577, 5
  %t592 = select i1 %t591, %Block %t590, %Block %t585
  %t593 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t594 = bitcast [56 x i8]* %t593 to i8*
  %t595 = getelementptr inbounds i8, i8* %t594, i64 16
  %t596 = bitcast i8* %t595 to %Block*
  %t597 = load %Block, %Block* %t596
  %t598 = icmp eq i32 %t577, 6
  %t599 = select i1 %t598, %Block %t597, %Block %t592
  %t600 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t601 = bitcast [88 x i8]* %t600 to i8*
  %t602 = getelementptr inbounds i8, i8* %t601, i64 56
  %t603 = bitcast i8* %t602 to %Block*
  %t604 = load %Block, %Block* %t603
  %t605 = icmp eq i32 %t577, 7
  %t606 = select i1 %t605, %Block %t604, %Block %t599
  %t607 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t608 = bitcast [120 x i8]* %t607 to i8*
  %t609 = getelementptr inbounds i8, i8* %t608, i64 88
  %t610 = bitcast i8* %t609 to %Block*
  %t611 = load %Block, %Block* %t610
  %t612 = icmp eq i32 %t577, 12
  %t613 = select i1 %t612, %Block %t611, %Block %t606
  %t614 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t615 = bitcast [40 x i8]* %t614 to i8*
  %t616 = getelementptr inbounds i8, i8* %t615, i64 8
  %t617 = bitcast i8* %t616 to %Block*
  %t618 = load %Block, %Block* %t617
  %t619 = icmp eq i32 %t577, 13
  %t620 = select i1 %t619, %Block %t618, %Block %t613
  %t621 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t622 = bitcast [136 x i8]* %t621 to i8*
  %t623 = getelementptr inbounds i8, i8* %t622, i64 104
  %t624 = bitcast i8* %t623 to %Block*
  %t625 = load %Block, %Block* %t624
  %t626 = icmp eq i32 %t577, 14
  %t627 = select i1 %t626, %Block %t625, %Block %t620
  %t628 = getelementptr inbounds %Statement, %Statement* %t578, i32 0, i32 1
  %t629 = bitcast [32 x i8]* %t628 to i8*
  %t630 = bitcast i8* %t629 to %Block*
  %t631 = load %Block, %Block* %t630
  %t632 = icmp eq i32 %t577, 15
  %t633 = select i1 %t632, %Block %t631, %Block %t627
  %t634 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t633)
  ret { %EffectRequirement*, i64 }* %t634
merge13:
  %t635 = extractvalue %Statement %statement, 0
  %t636 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t637 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t635, 0
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t635, 1
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t635, 2
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t635, 3
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t635, 4
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t635, 5
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t635, 6
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t635, 7
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t635, 8
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t635, 9
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t635, 10
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t635, 11
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t635, 12
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t635, 13
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t635, 14
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t635, 15
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t635, 16
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t635, 17
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t635, 18
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t635, 19
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t635, 20
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t635, 21
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t635, 22
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %s706 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h196308685, i32 0, i32 0
  %t707 = call i1 @strings_equal(i8* %t705, i8* %s706)
  br i1 %t707, label %then14, label %merge15
then14:
  %t708 = extractvalue %Statement %statement, 0
  %t709 = alloca %Statement
  store %Statement %statement, %Statement* %t709
  %t710 = getelementptr inbounds %Statement, %Statement* %t709, i32 0, i32 1
  %t711 = bitcast [16 x i8]* %t710 to i8*
  %t712 = bitcast i8* %t711 to %Expression**
  %t713 = load %Expression*, %Expression** %t712
  %t714 = icmp eq i32 %t708, 20
  %t715 = select i1 %t714, %Expression* %t713, %Expression* null
  %t716 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t715)
  store { %EffectRequirement*, i64 }* %t716, { %EffectRequirement*, i64 }** %l5
  %t717 = sitofp i64 0 to double
  store double %t717, double* %l6
  %t718 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t719 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t763 = phi { %EffectRequirement*, i64 }* [ %t718, %then14 ], [ %t761, %loop.latch18 ]
  %t764 = phi double [ %t719, %then14 ], [ %t762, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t763, { %EffectRequirement*, i64 }** %l5
  store double %t764, double* %l6
  br label %loop.body17
loop.body17:
  %t720 = load double, double* %l6
  %t721 = extractvalue %Statement %statement, 0
  %t722 = alloca %Statement
  store %Statement %statement, %Statement* %t722
  %t723 = getelementptr inbounds %Statement, %Statement* %t722, i32 0, i32 1
  %t724 = bitcast [64 x i8]* %t723 to i8*
  %t725 = getelementptr inbounds i8, i8* %t724, i64 48
  %t726 = bitcast i8* %t725 to { %MatchCase**, i64 }**
  %t727 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t726
  %t728 = icmp eq i32 %t721, 18
  %t729 = select i1 %t728, { %MatchCase**, i64 }* %t727, { %MatchCase**, i64 }* null
  %t730 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t729
  %t731 = extractvalue { %MatchCase**, i64 } %t730, 1
  %t732 = sitofp i64 %t731 to double
  %t733 = fcmp oge double %t720, %t732
  %t734 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t735 = load double, double* %l6
  br i1 %t733, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t736 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t737 = extractvalue %Statement %statement, 0
  %t738 = alloca %Statement
  store %Statement %statement, %Statement* %t738
  %t739 = getelementptr inbounds %Statement, %Statement* %t738, i32 0, i32 1
  %t740 = bitcast [64 x i8]* %t739 to i8*
  %t741 = getelementptr inbounds i8, i8* %t740, i64 48
  %t742 = bitcast i8* %t741 to { %MatchCase**, i64 }**
  %t743 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t742
  %t744 = icmp eq i32 %t737, 18
  %t745 = select i1 %t744, { %MatchCase**, i64 }* %t743, { %MatchCase**, i64 }* null
  %t746 = load double, double* %l6
  %t747 = call double @llvm.round.f64(double %t746)
  %t748 = fptosi double %t747 to i64
  %t749 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t745
  %t750 = extractvalue { %MatchCase**, i64 } %t749, 0
  %t751 = extractvalue { %MatchCase**, i64 } %t749, 1
  %t752 = icmp uge i64 %t748, %t751
  ; bounds check: %t752 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t748, i64 %t751)
  %t753 = getelementptr %MatchCase*, %MatchCase** %t750, i64 %t748
  %t754 = load %MatchCase*, %MatchCase** %t753
  %t755 = load %MatchCase, %MatchCase* %t754
  %t756 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t755)
  %t757 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t736, { %EffectRequirement*, i64 }* %t756)
  store { %EffectRequirement*, i64 }* %t757, { %EffectRequirement*, i64 }** %l5
  %t758 = load double, double* %l6
  %t759 = sitofp i64 1 to double
  %t760 = fadd double %t758, %t759
  store double %t760, double* %l6
  br label %loop.latch18
loop.latch18:
  %t761 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t762 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t765 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t766 = load double, double* %l6
  %t767 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t767
merge15:
  %t768 = extractvalue %Statement %statement, 0
  %t769 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t770 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t768, 0
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t768, 1
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t768, 2
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t768, 3
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t768, 4
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t768, 5
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t768, 6
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t768, 7
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t768, 8
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t768, 9
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t768, 10
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t768, 11
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t768, 12
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %t809 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t768, 13
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t768, 14
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t768, 15
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t768, 16
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t768, 17
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t768, 18
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t768, 19
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t768, 20
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t768, 21
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t768, 22
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %s839 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1566780570, i32 0, i32 0
  %t840 = call i1 @strings_equal(i8* %t838, i8* %s839)
  br i1 %t840, label %then22, label %merge23
then22:
  %t841 = extractvalue %Statement %statement, 0
  %t842 = alloca %Statement
  store %Statement %statement, %Statement* %t842
  %t843 = getelementptr inbounds %Statement, %Statement* %t842, i32 0, i32 1
  %t844 = bitcast [88 x i8]* %t843 to i8*
  %t845 = bitcast i8* %t844 to %Expression*
  %t846 = load %Expression, %Expression* %t845
  %t847 = icmp eq i32 %t841, 19
  %t848 = select i1 %t847, %Expression %t846, %Expression zeroinitializer
  %t849 = alloca %Expression
  store %Expression %t848, %Expression* %t849
  %t850 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t849)
  store { %EffectRequirement*, i64 }* %t850, { %EffectRequirement*, i64 }** %l7
  %t851 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t852 = extractvalue %Statement %statement, 0
  %t853 = alloca %Statement
  store %Statement %statement, %Statement* %t853
  %t854 = getelementptr inbounds %Statement, %Statement* %t853, i32 0, i32 1
  %t855 = bitcast [88 x i8]* %t854 to i8*
  %t856 = getelementptr inbounds i8, i8* %t855, i64 48
  %t857 = bitcast i8* %t856 to %Block*
  %t858 = load %Block, %Block* %t857
  %t859 = icmp eq i32 %t852, 19
  %t860 = select i1 %t859, %Block %t858, %Block zeroinitializer
  %t861 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t860)
  %t862 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t851, { %EffectRequirement*, i64 }* %t861)
  store { %EffectRequirement*, i64 }* %t862, { %EffectRequirement*, i64 }** %l7
  %t863 = extractvalue %Statement %statement, 0
  %t864 = alloca %Statement
  store %Statement %statement, %Statement* %t864
  %t865 = getelementptr inbounds %Statement, %Statement* %t864, i32 0, i32 1
  %t866 = bitcast [88 x i8]* %t865 to i8*
  %t867 = getelementptr inbounds i8, i8* %t866, i64 72
  %t868 = bitcast i8* %t867 to %ElseBranch**
  %t869 = load %ElseBranch*, %ElseBranch** %t868
  %t870 = icmp eq i32 %t863, 19
  %t871 = select i1 %t870, %ElseBranch* %t869, %ElseBranch* null
  store %ElseBranch* %t871, %ElseBranch** %l8
  %t872 = load %ElseBranch*, %ElseBranch** %l8
  %t873 = icmp eq %ElseBranch* %t872, null
  %t874 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t875 = load %ElseBranch*, %ElseBranch** %l8
  br i1 %t873, label %then24, label %merge25
then24:
  %t876 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t876
merge25:
  %t877 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t878 = load %ElseBranch*, %ElseBranch** %l8
  %t879 = load %ElseBranch, %ElseBranch* %t878
  %t880 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %t879)
  %t881 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t877, { %EffectRequirement*, i64 }* %t880)
  store { %EffectRequirement*, i64 }* %t881, { %EffectRequirement*, i64 }** %l7
  %t882 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t882
merge23:
  %t883 = extractvalue %Statement %statement, 0
  %t884 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t885 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t883, 0
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t883, 1
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t883, 2
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t883, 3
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t883, 4
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t883, 5
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t883, 6
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t883, 7
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t883, 8
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t883, 9
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t883, 10
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t883, 11
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t883, 12
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t883, 13
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t883, 14
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t883, 15
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t883, 16
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t883, 17
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t883, 18
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t883, 19
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t883, 20
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t883, 21
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t883, 22
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %s954 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1613933868, i32 0, i32 0
  %t955 = call i1 @strings_equal(i8* %t953, i8* %s954)
  br i1 %t955, label %then26, label %merge27
then26:
  %t956 = extractvalue %Statement %statement, 0
  %t957 = alloca %Statement
  store %Statement %statement, %Statement* %t957
  %t958 = getelementptr inbounds %Statement, %Statement* %t957, i32 0, i32 1
  %t959 = bitcast [16 x i8]* %t958 to i8*
  %t960 = bitcast i8* %t959 to %Expression**
  %t961 = load %Expression*, %Expression** %t960
  %t962 = icmp eq i32 %t956, 20
  %t963 = select i1 %t962, %Expression* %t961, %Expression* null
  %t964 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t963)
  ret { %EffectRequirement*, i64 }* %t964
merge27:
  %t965 = extractvalue %Statement %statement, 0
  %t966 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t967 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t965, 0
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t965, 1
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t965, 2
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t965, 3
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t965, 4
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t965, 5
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t965, 6
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t965, 7
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t965, 8
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t965, 9
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t965, 10
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t965, 11
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t965, 12
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t965, 13
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t965, 14
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t965, 15
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t965, 16
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t965, 17
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t965, 18
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t965, 19
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t965, 20
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t965, 21
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t965, 22
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %s1036 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h868168677, i32 0, i32 0
  %t1037 = call i1 @strings_equal(i8* %t1035, i8* %s1036)
  br i1 %t1037, label %then28, label %merge29
then28:
  %t1038 = extractvalue %Statement %statement, 0
  %t1039 = alloca %Statement
  store %Statement %statement, %Statement* %t1039
  %t1040 = getelementptr inbounds %Statement, %Statement* %t1039, i32 0, i32 1
  %t1041 = bitcast [16 x i8]* %t1040 to i8*
  %t1042 = bitcast i8* %t1041 to %Expression**
  %t1043 = load %Expression*, %Expression** %t1042
  %t1044 = icmp eq i32 %t1038, 20
  %t1045 = select i1 %t1044, %Expression* %t1043, %Expression* null
  %t1046 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1045)
  ret { %EffectRequirement*, i64 }* %t1046
merge29:
  %t1047 = extractvalue %Statement %statement, 0
  %t1048 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1049 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1047, 0
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1047, 1
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1047, 2
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1047, 3
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1047, 4
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1047, 5
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1047, 6
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1047, 7
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1047, 8
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1047, 9
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1047, 10
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1047, 11
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1047, 12
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1047, 13
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1047, 14
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1047, 15
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1047, 16
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1047, 17
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1047, 18
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1047, 19
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1047, 20
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1047, 21
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %t1115 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1116 = icmp eq i32 %t1047, 22
  %t1117 = select i1 %t1116, i8* %t1115, i8* %t1114
  %s1118 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1204027478, i32 0, i32 0
  %t1119 = call i1 @strings_equal(i8* %t1117, i8* %s1118)
  br i1 %t1119, label %then30, label %merge31
then30:
  %t1120 = extractvalue %Statement %statement, 0
  %t1121 = alloca %Statement
  store %Statement %statement, %Statement* %t1121
  %t1122 = getelementptr inbounds %Statement, %Statement* %t1121, i32 0, i32 1
  %t1123 = bitcast [48 x i8]* %t1122 to i8*
  %t1124 = getelementptr inbounds i8, i8* %t1123, i64 24
  %t1125 = bitcast i8* %t1124 to %Expression**
  %t1126 = load %Expression*, %Expression** %t1125
  %t1127 = icmp eq i32 %t1120, 2
  %t1128 = select i1 %t1127, %Expression* %t1126, %Expression* null
  %t1129 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1128)
  ret { %EffectRequirement*, i64 }* %t1129
merge31:
  %t1130 = extractvalue %Statement %statement, 0
  %t1131 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1132 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1133 = icmp eq i32 %t1130, 0
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1131
  %t1135 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1136 = icmp eq i32 %t1130, 1
  %t1137 = select i1 %t1136, i8* %t1135, i8* %t1134
  %t1138 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1130, 2
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1130, 3
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1130, 4
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1130, 5
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1130, 6
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1130, 7
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1130, 8
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1130, 9
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1130, 10
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1130, 11
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1130, 12
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1130, 13
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1130, 14
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1130, 15
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1130, 16
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1130, 17
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1130, 18
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1130, 19
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1130, 20
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1130, 21
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1130, 22
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %s1201 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t1202 = call i1 @strings_equal(i8* %t1200, i8* %s1201)
  br i1 %t1202, label %then32, label %merge33
then32:
  %t1203 = extractvalue %Statement %statement, 0
  %t1204 = alloca %Statement
  store %Statement %statement, %Statement* %t1204
  %t1205 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1206 = bitcast [88 x i8]* %t1205 to i8*
  %t1207 = getelementptr inbounds i8, i8* %t1206, i64 56
  %t1208 = bitcast i8* %t1207 to %Block*
  %t1209 = load %Block, %Block* %t1208
  %t1210 = icmp eq i32 %t1203, 4
  %t1211 = select i1 %t1210, %Block %t1209, %Block zeroinitializer
  %t1212 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1213 = bitcast [88 x i8]* %t1212 to i8*
  %t1214 = getelementptr inbounds i8, i8* %t1213, i64 56
  %t1215 = bitcast i8* %t1214 to %Block*
  %t1216 = load %Block, %Block* %t1215
  %t1217 = icmp eq i32 %t1203, 5
  %t1218 = select i1 %t1217, %Block %t1216, %Block %t1211
  %t1219 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1220 = bitcast [56 x i8]* %t1219 to i8*
  %t1221 = getelementptr inbounds i8, i8* %t1220, i64 16
  %t1222 = bitcast i8* %t1221 to %Block*
  %t1223 = load %Block, %Block* %t1222
  %t1224 = icmp eq i32 %t1203, 6
  %t1225 = select i1 %t1224, %Block %t1223, %Block %t1218
  %t1226 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1227 = bitcast [88 x i8]* %t1226 to i8*
  %t1228 = getelementptr inbounds i8, i8* %t1227, i64 56
  %t1229 = bitcast i8* %t1228 to %Block*
  %t1230 = load %Block, %Block* %t1229
  %t1231 = icmp eq i32 %t1203, 7
  %t1232 = select i1 %t1231, %Block %t1230, %Block %t1225
  %t1233 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1234 = bitcast [120 x i8]* %t1233 to i8*
  %t1235 = getelementptr inbounds i8, i8* %t1234, i64 88
  %t1236 = bitcast i8* %t1235 to %Block*
  %t1237 = load %Block, %Block* %t1236
  %t1238 = icmp eq i32 %t1203, 12
  %t1239 = select i1 %t1238, %Block %t1237, %Block %t1232
  %t1240 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1241 = bitcast [40 x i8]* %t1240 to i8*
  %t1242 = getelementptr inbounds i8, i8* %t1241, i64 8
  %t1243 = bitcast i8* %t1242 to %Block*
  %t1244 = load %Block, %Block* %t1243
  %t1245 = icmp eq i32 %t1203, 13
  %t1246 = select i1 %t1245, %Block %t1244, %Block %t1239
  %t1247 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1248 = bitcast [136 x i8]* %t1247 to i8*
  %t1249 = getelementptr inbounds i8, i8* %t1248, i64 104
  %t1250 = bitcast i8* %t1249 to %Block*
  %t1251 = load %Block, %Block* %t1250
  %t1252 = icmp eq i32 %t1203, 14
  %t1253 = select i1 %t1252, %Block %t1251, %Block %t1246
  %t1254 = getelementptr inbounds %Statement, %Statement* %t1204, i32 0, i32 1
  %t1255 = bitcast [32 x i8]* %t1254 to i8*
  %t1256 = bitcast i8* %t1255 to %Block*
  %t1257 = load %Block, %Block* %t1256
  %t1258 = icmp eq i32 %t1203, 15
  %t1259 = select i1 %t1258, %Block %t1257, %Block %t1253
  %t1260 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1259)
  ret { %EffectRequirement*, i64 }* %t1260
merge33:
  %t1261 = extractvalue %Statement %statement, 0
  %t1262 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1263 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1261, 0
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1261, 1
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1261, 2
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1261, 3
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1261, 4
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1261, 5
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1261, 6
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1261, 7
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1261, 8
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1261, 9
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1261, 10
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1261, 11
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1261, 12
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1261, 13
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1261, 14
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1261, 15
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1261, 16
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1261, 17
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1261, 18
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1261, 19
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1261, 20
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1261, 21
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1261, 22
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %s1332 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t1333 = call i1 @strings_equal(i8* %t1331, i8* %s1332)
  br i1 %t1333, label %then34, label %merge35
then34:
  %t1334 = extractvalue %Statement %statement, 0
  %t1335 = alloca %Statement
  store %Statement %statement, %Statement* %t1335
  %t1336 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1337 = bitcast [88 x i8]* %t1336 to i8*
  %t1338 = getelementptr inbounds i8, i8* %t1337, i64 56
  %t1339 = bitcast i8* %t1338 to %Block*
  %t1340 = load %Block, %Block* %t1339
  %t1341 = icmp eq i32 %t1334, 4
  %t1342 = select i1 %t1341, %Block %t1340, %Block zeroinitializer
  %t1343 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1344 = bitcast [88 x i8]* %t1343 to i8*
  %t1345 = getelementptr inbounds i8, i8* %t1344, i64 56
  %t1346 = bitcast i8* %t1345 to %Block*
  %t1347 = load %Block, %Block* %t1346
  %t1348 = icmp eq i32 %t1334, 5
  %t1349 = select i1 %t1348, %Block %t1347, %Block %t1342
  %t1350 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1351 = bitcast [56 x i8]* %t1350 to i8*
  %t1352 = getelementptr inbounds i8, i8* %t1351, i64 16
  %t1353 = bitcast i8* %t1352 to %Block*
  %t1354 = load %Block, %Block* %t1353
  %t1355 = icmp eq i32 %t1334, 6
  %t1356 = select i1 %t1355, %Block %t1354, %Block %t1349
  %t1357 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1358 = bitcast [88 x i8]* %t1357 to i8*
  %t1359 = getelementptr inbounds i8, i8* %t1358, i64 56
  %t1360 = bitcast i8* %t1359 to %Block*
  %t1361 = load %Block, %Block* %t1360
  %t1362 = icmp eq i32 %t1334, 7
  %t1363 = select i1 %t1362, %Block %t1361, %Block %t1356
  %t1364 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1365 = bitcast [120 x i8]* %t1364 to i8*
  %t1366 = getelementptr inbounds i8, i8* %t1365, i64 88
  %t1367 = bitcast i8* %t1366 to %Block*
  %t1368 = load %Block, %Block* %t1367
  %t1369 = icmp eq i32 %t1334, 12
  %t1370 = select i1 %t1369, %Block %t1368, %Block %t1363
  %t1371 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1372 = bitcast [40 x i8]* %t1371 to i8*
  %t1373 = getelementptr inbounds i8, i8* %t1372, i64 8
  %t1374 = bitcast i8* %t1373 to %Block*
  %t1375 = load %Block, %Block* %t1374
  %t1376 = icmp eq i32 %t1334, 13
  %t1377 = select i1 %t1376, %Block %t1375, %Block %t1370
  %t1378 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1379 = bitcast [136 x i8]* %t1378 to i8*
  %t1380 = getelementptr inbounds i8, i8* %t1379, i64 104
  %t1381 = bitcast i8* %t1380 to %Block*
  %t1382 = load %Block, %Block* %t1381
  %t1383 = icmp eq i32 %t1334, 14
  %t1384 = select i1 %t1383, %Block %t1382, %Block %t1377
  %t1385 = getelementptr inbounds %Statement, %Statement* %t1335, i32 0, i32 1
  %t1386 = bitcast [32 x i8]* %t1385 to i8*
  %t1387 = bitcast i8* %t1386 to %Block*
  %t1388 = load %Block, %Block* %t1387
  %t1389 = icmp eq i32 %t1334, 15
  %t1390 = select i1 %t1389, %Block %t1388, %Block %t1384
  %t1391 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1390)
  ret { %EffectRequirement*, i64 }* %t1391
merge35:
  %t1392 = extractvalue %Statement %statement, 0
  %t1393 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1394 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1392, 0
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1392, 1
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1392, 2
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1392, 3
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1392, 4
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1392, 5
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1392, 6
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1392, 7
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1419 = icmp eq i32 %t1392, 8
  %t1420 = select i1 %t1419, i8* %t1418, i8* %t1417
  %t1421 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1422 = icmp eq i32 %t1392, 9
  %t1423 = select i1 %t1422, i8* %t1421, i8* %t1420
  %t1424 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1425 = icmp eq i32 %t1392, 10
  %t1426 = select i1 %t1425, i8* %t1424, i8* %t1423
  %t1427 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1392, 11
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %t1430 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1392, 12
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1392, 13
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1392, 14
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1392, 15
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1392, 16
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1392, 17
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1449 = icmp eq i32 %t1392, 18
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1447
  %t1451 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1452 = icmp eq i32 %t1392, 19
  %t1453 = select i1 %t1452, i8* %t1451, i8* %t1450
  %t1454 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1455 = icmp eq i32 %t1392, 20
  %t1456 = select i1 %t1455, i8* %t1454, i8* %t1453
  %t1457 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1458 = icmp eq i32 %t1392, 21
  %t1459 = select i1 %t1458, i8* %t1457, i8* %t1456
  %t1460 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1461 = icmp eq i32 %t1392, 22
  %t1462 = select i1 %t1461, i8* %t1460, i8* %t1459
  %s1463 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t1464 = call i1 @strings_equal(i8* %t1462, i8* %s1463)
  br i1 %t1464, label %then36, label %merge37
then36:
  %t1465 = extractvalue %Statement %statement, 0
  %t1466 = alloca %Statement
  store %Statement %statement, %Statement* %t1466
  %t1467 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1468 = bitcast [88 x i8]* %t1467 to i8*
  %t1469 = getelementptr inbounds i8, i8* %t1468, i64 56
  %t1470 = bitcast i8* %t1469 to %Block*
  %t1471 = load %Block, %Block* %t1470
  %t1472 = icmp eq i32 %t1465, 4
  %t1473 = select i1 %t1472, %Block %t1471, %Block zeroinitializer
  %t1474 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1475 = bitcast [88 x i8]* %t1474 to i8*
  %t1476 = getelementptr inbounds i8, i8* %t1475, i64 56
  %t1477 = bitcast i8* %t1476 to %Block*
  %t1478 = load %Block, %Block* %t1477
  %t1479 = icmp eq i32 %t1465, 5
  %t1480 = select i1 %t1479, %Block %t1478, %Block %t1473
  %t1481 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1482 = bitcast [56 x i8]* %t1481 to i8*
  %t1483 = getelementptr inbounds i8, i8* %t1482, i64 16
  %t1484 = bitcast i8* %t1483 to %Block*
  %t1485 = load %Block, %Block* %t1484
  %t1486 = icmp eq i32 %t1465, 6
  %t1487 = select i1 %t1486, %Block %t1485, %Block %t1480
  %t1488 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1489 = bitcast [88 x i8]* %t1488 to i8*
  %t1490 = getelementptr inbounds i8, i8* %t1489, i64 56
  %t1491 = bitcast i8* %t1490 to %Block*
  %t1492 = load %Block, %Block* %t1491
  %t1493 = icmp eq i32 %t1465, 7
  %t1494 = select i1 %t1493, %Block %t1492, %Block %t1487
  %t1495 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1496 = bitcast [120 x i8]* %t1495 to i8*
  %t1497 = getelementptr inbounds i8, i8* %t1496, i64 88
  %t1498 = bitcast i8* %t1497 to %Block*
  %t1499 = load %Block, %Block* %t1498
  %t1500 = icmp eq i32 %t1465, 12
  %t1501 = select i1 %t1500, %Block %t1499, %Block %t1494
  %t1502 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1503 = bitcast [40 x i8]* %t1502 to i8*
  %t1504 = getelementptr inbounds i8, i8* %t1503, i64 8
  %t1505 = bitcast i8* %t1504 to %Block*
  %t1506 = load %Block, %Block* %t1505
  %t1507 = icmp eq i32 %t1465, 13
  %t1508 = select i1 %t1507, %Block %t1506, %Block %t1501
  %t1509 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1510 = bitcast [136 x i8]* %t1509 to i8*
  %t1511 = getelementptr inbounds i8, i8* %t1510, i64 104
  %t1512 = bitcast i8* %t1511 to %Block*
  %t1513 = load %Block, %Block* %t1512
  %t1514 = icmp eq i32 %t1465, 14
  %t1515 = select i1 %t1514, %Block %t1513, %Block %t1508
  %t1516 = getelementptr inbounds %Statement, %Statement* %t1466, i32 0, i32 1
  %t1517 = bitcast [32 x i8]* %t1516 to i8*
  %t1518 = bitcast i8* %t1517 to %Block*
  %t1519 = load %Block, %Block* %t1518
  %t1520 = icmp eq i32 %t1465, 15
  %t1521 = select i1 %t1520, %Block %t1519, %Block %t1515
  %t1522 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1521)
  ret { %EffectRequirement*, i64 }* %t1522
merge37:
  %t1523 = extractvalue %Statement %statement, 0
  %t1524 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1525 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1526 = icmp eq i32 %t1523, 0
  %t1527 = select i1 %t1526, i8* %t1525, i8* %t1524
  %t1528 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1529 = icmp eq i32 %t1523, 1
  %t1530 = select i1 %t1529, i8* %t1528, i8* %t1527
  %t1531 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1532 = icmp eq i32 %t1523, 2
  %t1533 = select i1 %t1532, i8* %t1531, i8* %t1530
  %t1534 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1535 = icmp eq i32 %t1523, 3
  %t1536 = select i1 %t1535, i8* %t1534, i8* %t1533
  %t1537 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1538 = icmp eq i32 %t1523, 4
  %t1539 = select i1 %t1538, i8* %t1537, i8* %t1536
  %t1540 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1541 = icmp eq i32 %t1523, 5
  %t1542 = select i1 %t1541, i8* %t1540, i8* %t1539
  %t1543 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1544 = icmp eq i32 %t1523, 6
  %t1545 = select i1 %t1544, i8* %t1543, i8* %t1542
  %t1546 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1547 = icmp eq i32 %t1523, 7
  %t1548 = select i1 %t1547, i8* %t1546, i8* %t1545
  %t1549 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1550 = icmp eq i32 %t1523, 8
  %t1551 = select i1 %t1550, i8* %t1549, i8* %t1548
  %t1552 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1553 = icmp eq i32 %t1523, 9
  %t1554 = select i1 %t1553, i8* %t1552, i8* %t1551
  %t1555 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1556 = icmp eq i32 %t1523, 10
  %t1557 = select i1 %t1556, i8* %t1555, i8* %t1554
  %t1558 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1559 = icmp eq i32 %t1523, 11
  %t1560 = select i1 %t1559, i8* %t1558, i8* %t1557
  %t1561 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1562 = icmp eq i32 %t1523, 12
  %t1563 = select i1 %t1562, i8* %t1561, i8* %t1560
  %t1564 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1565 = icmp eq i32 %t1523, 13
  %t1566 = select i1 %t1565, i8* %t1564, i8* %t1563
  %t1567 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1568 = icmp eq i32 %t1523, 14
  %t1569 = select i1 %t1568, i8* %t1567, i8* %t1566
  %t1570 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1571 = icmp eq i32 %t1523, 15
  %t1572 = select i1 %t1571, i8* %t1570, i8* %t1569
  %t1573 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1574 = icmp eq i32 %t1523, 16
  %t1575 = select i1 %t1574, i8* %t1573, i8* %t1572
  %t1576 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1577 = icmp eq i32 %t1523, 17
  %t1578 = select i1 %t1577, i8* %t1576, i8* %t1575
  %t1579 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1580 = icmp eq i32 %t1523, 18
  %t1581 = select i1 %t1580, i8* %t1579, i8* %t1578
  %t1582 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1583 = icmp eq i32 %t1523, 19
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1581
  %t1585 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1586 = icmp eq i32 %t1523, 20
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1584
  %t1588 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1589 = icmp eq i32 %t1523, 21
  %t1590 = select i1 %t1589, i8* %t1588, i8* %t1587
  %t1591 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1523, 22
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %s1594 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t1595 = call i1 @strings_equal(i8* %t1593, i8* %s1594)
  br i1 %t1595, label %then38, label %merge39
then38:
  %t1596 = extractvalue %Statement %statement, 0
  %t1597 = alloca %Statement
  store %Statement %statement, %Statement* %t1597
  %t1598 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1599 = bitcast [88 x i8]* %t1598 to i8*
  %t1600 = getelementptr inbounds i8, i8* %t1599, i64 56
  %t1601 = bitcast i8* %t1600 to %Block*
  %t1602 = load %Block, %Block* %t1601
  %t1603 = icmp eq i32 %t1596, 4
  %t1604 = select i1 %t1603, %Block %t1602, %Block zeroinitializer
  %t1605 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1606 = bitcast [88 x i8]* %t1605 to i8*
  %t1607 = getelementptr inbounds i8, i8* %t1606, i64 56
  %t1608 = bitcast i8* %t1607 to %Block*
  %t1609 = load %Block, %Block* %t1608
  %t1610 = icmp eq i32 %t1596, 5
  %t1611 = select i1 %t1610, %Block %t1609, %Block %t1604
  %t1612 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1613 = bitcast [56 x i8]* %t1612 to i8*
  %t1614 = getelementptr inbounds i8, i8* %t1613, i64 16
  %t1615 = bitcast i8* %t1614 to %Block*
  %t1616 = load %Block, %Block* %t1615
  %t1617 = icmp eq i32 %t1596, 6
  %t1618 = select i1 %t1617, %Block %t1616, %Block %t1611
  %t1619 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1620 = bitcast [88 x i8]* %t1619 to i8*
  %t1621 = getelementptr inbounds i8, i8* %t1620, i64 56
  %t1622 = bitcast i8* %t1621 to %Block*
  %t1623 = load %Block, %Block* %t1622
  %t1624 = icmp eq i32 %t1596, 7
  %t1625 = select i1 %t1624, %Block %t1623, %Block %t1618
  %t1626 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1627 = bitcast [120 x i8]* %t1626 to i8*
  %t1628 = getelementptr inbounds i8, i8* %t1627, i64 88
  %t1629 = bitcast i8* %t1628 to %Block*
  %t1630 = load %Block, %Block* %t1629
  %t1631 = icmp eq i32 %t1596, 12
  %t1632 = select i1 %t1631, %Block %t1630, %Block %t1625
  %t1633 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1634 = bitcast [40 x i8]* %t1633 to i8*
  %t1635 = getelementptr inbounds i8, i8* %t1634, i64 8
  %t1636 = bitcast i8* %t1635 to %Block*
  %t1637 = load %Block, %Block* %t1636
  %t1638 = icmp eq i32 %t1596, 13
  %t1639 = select i1 %t1638, %Block %t1637, %Block %t1632
  %t1640 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1641 = bitcast [136 x i8]* %t1640 to i8*
  %t1642 = getelementptr inbounds i8, i8* %t1641, i64 104
  %t1643 = bitcast i8* %t1642 to %Block*
  %t1644 = load %Block, %Block* %t1643
  %t1645 = icmp eq i32 %t1596, 14
  %t1646 = select i1 %t1645, %Block %t1644, %Block %t1639
  %t1647 = getelementptr inbounds %Statement, %Statement* %t1597, i32 0, i32 1
  %t1648 = bitcast [32 x i8]* %t1647 to i8*
  %t1649 = bitcast i8* %t1648 to %Block*
  %t1650 = load %Block, %Block* %t1649
  %t1651 = icmp eq i32 %t1596, 15
  %t1652 = select i1 %t1651, %Block %t1650, %Block %t1646
  %t1653 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1652)
  ret { %EffectRequirement*, i64 }* %t1653
merge39:
  %t1654 = extractvalue %Statement %statement, 0
  %t1655 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1656 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1657 = icmp eq i32 %t1654, 0
  %t1658 = select i1 %t1657, i8* %t1656, i8* %t1655
  %t1659 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1660 = icmp eq i32 %t1654, 1
  %t1661 = select i1 %t1660, i8* %t1659, i8* %t1658
  %t1662 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1663 = icmp eq i32 %t1654, 2
  %t1664 = select i1 %t1663, i8* %t1662, i8* %t1661
  %t1665 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1666 = icmp eq i32 %t1654, 3
  %t1667 = select i1 %t1666, i8* %t1665, i8* %t1664
  %t1668 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1669 = icmp eq i32 %t1654, 4
  %t1670 = select i1 %t1669, i8* %t1668, i8* %t1667
  %t1671 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1672 = icmp eq i32 %t1654, 5
  %t1673 = select i1 %t1672, i8* %t1671, i8* %t1670
  %t1674 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1675 = icmp eq i32 %t1654, 6
  %t1676 = select i1 %t1675, i8* %t1674, i8* %t1673
  %t1677 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1678 = icmp eq i32 %t1654, 7
  %t1679 = select i1 %t1678, i8* %t1677, i8* %t1676
  %t1680 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1681 = icmp eq i32 %t1654, 8
  %t1682 = select i1 %t1681, i8* %t1680, i8* %t1679
  %t1683 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1684 = icmp eq i32 %t1654, 9
  %t1685 = select i1 %t1684, i8* %t1683, i8* %t1682
  %t1686 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1687 = icmp eq i32 %t1654, 10
  %t1688 = select i1 %t1687, i8* %t1686, i8* %t1685
  %t1689 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1690 = icmp eq i32 %t1654, 11
  %t1691 = select i1 %t1690, i8* %t1689, i8* %t1688
  %t1692 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1693 = icmp eq i32 %t1654, 12
  %t1694 = select i1 %t1693, i8* %t1692, i8* %t1691
  %t1695 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1696 = icmp eq i32 %t1654, 13
  %t1697 = select i1 %t1696, i8* %t1695, i8* %t1694
  %t1698 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1699 = icmp eq i32 %t1654, 14
  %t1700 = select i1 %t1699, i8* %t1698, i8* %t1697
  %t1701 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1702 = icmp eq i32 %t1654, 15
  %t1703 = select i1 %t1702, i8* %t1701, i8* %t1700
  %t1704 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1705 = icmp eq i32 %t1654, 16
  %t1706 = select i1 %t1705, i8* %t1704, i8* %t1703
  %t1707 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1708 = icmp eq i32 %t1654, 17
  %t1709 = select i1 %t1708, i8* %t1707, i8* %t1706
  %t1710 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1711 = icmp eq i32 %t1654, 18
  %t1712 = select i1 %t1711, i8* %t1710, i8* %t1709
  %t1713 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1714 = icmp eq i32 %t1654, 19
  %t1715 = select i1 %t1714, i8* %t1713, i8* %t1712
  %t1716 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1717 = icmp eq i32 %t1654, 20
  %t1718 = select i1 %t1717, i8* %t1716, i8* %t1715
  %t1719 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1720 = icmp eq i32 %t1654, 21
  %t1721 = select i1 %t1720, i8* %t1719, i8* %t1718
  %t1722 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1723 = icmp eq i32 %t1654, 22
  %t1724 = select i1 %t1723, i8* %t1722, i8* %t1721
  %s1725 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t1726 = call i1 @strings_equal(i8* %t1724, i8* %s1725)
  br i1 %t1726, label %then40, label %merge41
then40:
  %t1727 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1728 = ptrtoint [0 x %EffectRequirement]* %t1727 to i64
  %t1729 = icmp eq i64 %t1728, 0
  %t1730 = select i1 %t1729, i64 1, i64 %t1728
  %t1731 = call i8* @malloc(i64 %t1730)
  %t1732 = bitcast i8* %t1731 to %EffectRequirement*
  %t1733 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1734 = ptrtoint { %EffectRequirement*, i64 }* %t1733 to i64
  %t1735 = call i8* @malloc(i64 %t1734)
  %t1736 = bitcast i8* %t1735 to { %EffectRequirement*, i64 }*
  %t1737 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1736, i32 0, i32 0
  store %EffectRequirement* %t1732, %EffectRequirement** %t1737
  %t1738 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1736, i32 0, i32 1
  store i64 0, i64* %t1738
  store { %EffectRequirement*, i64 }* %t1736, { %EffectRequirement*, i64 }** %l9
  %t1739 = sitofp i64 0 to double
  store double %t1739, double* %l10
  %t1740 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1741 = load double, double* %l10
  br label %loop.header42
loop.header42:
  %t1786 = phi { %EffectRequirement*, i64 }* [ %t1740, %then40 ], [ %t1784, %loop.latch44 ]
  %t1787 = phi double [ %t1741, %then40 ], [ %t1785, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1786, { %EffectRequirement*, i64 }** %l9
  store double %t1787, double* %l10
  br label %loop.body43
loop.body43:
  %t1742 = load double, double* %l10
  %t1743 = extractvalue %Statement %statement, 0
  %t1744 = alloca %Statement
  store %Statement %statement, %Statement* %t1744
  %t1745 = getelementptr inbounds %Statement, %Statement* %t1744, i32 0, i32 1
  %t1746 = bitcast [56 x i8]* %t1745 to i8*
  %t1747 = getelementptr inbounds i8, i8* %t1746, i64 40
  %t1748 = bitcast i8* %t1747 to { %MethodDeclaration**, i64 }**
  %t1749 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1748
  %t1750 = icmp eq i32 %t1743, 8
  %t1751 = select i1 %t1750, { %MethodDeclaration**, i64 }* %t1749, { %MethodDeclaration**, i64 }* null
  %t1752 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1751
  %t1753 = extractvalue { %MethodDeclaration**, i64 } %t1752, 1
  %t1754 = sitofp i64 %t1753 to double
  %t1755 = fcmp oge double %t1742, %t1754
  %t1756 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1757 = load double, double* %l10
  br i1 %t1755, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1758 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1759 = extractvalue %Statement %statement, 0
  %t1760 = alloca %Statement
  store %Statement %statement, %Statement* %t1760
  %t1761 = getelementptr inbounds %Statement, %Statement* %t1760, i32 0, i32 1
  %t1762 = bitcast [56 x i8]* %t1761 to i8*
  %t1763 = getelementptr inbounds i8, i8* %t1762, i64 40
  %t1764 = bitcast i8* %t1763 to { %MethodDeclaration**, i64 }**
  %t1765 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1764
  %t1766 = icmp eq i32 %t1759, 8
  %t1767 = select i1 %t1766, { %MethodDeclaration**, i64 }* %t1765, { %MethodDeclaration**, i64 }* null
  %t1768 = load double, double* %l10
  %t1769 = call double @llvm.round.f64(double %t1768)
  %t1770 = fptosi double %t1769 to i64
  %t1771 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1767
  %t1772 = extractvalue { %MethodDeclaration**, i64 } %t1771, 0
  %t1773 = extractvalue { %MethodDeclaration**, i64 } %t1771, 1
  %t1774 = icmp uge i64 %t1770, %t1773
  ; bounds check: %t1774 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1770, i64 %t1773)
  %t1775 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1772, i64 %t1770
  %t1776 = load %MethodDeclaration*, %MethodDeclaration** %t1775
  %t1777 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1776, i32 0, i32 1
  %t1778 = load %Block, %Block* %t1777
  %t1779 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1778)
  %t1780 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1758, { %EffectRequirement*, i64 }* %t1779)
  store { %EffectRequirement*, i64 }* %t1780, { %EffectRequirement*, i64 }** %l9
  %t1781 = load double, double* %l10
  %t1782 = sitofp i64 1 to double
  %t1783 = fadd double %t1781, %t1782
  store double %t1783, double* %l10
  br label %loop.latch44
loop.latch44:
  %t1784 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1785 = load double, double* %l10
  br label %loop.header42
afterloop45:
  %t1788 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1789 = load double, double* %l10
  %t1790 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t1790
merge41:
  %t1791 = extractvalue %Statement %statement, 0
  %t1792 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1793 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1794 = icmp eq i32 %t1791, 0
  %t1795 = select i1 %t1794, i8* %t1793, i8* %t1792
  %t1796 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1797 = icmp eq i32 %t1791, 1
  %t1798 = select i1 %t1797, i8* %t1796, i8* %t1795
  %t1799 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1800 = icmp eq i32 %t1791, 2
  %t1801 = select i1 %t1800, i8* %t1799, i8* %t1798
  %t1802 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1803 = icmp eq i32 %t1791, 3
  %t1804 = select i1 %t1803, i8* %t1802, i8* %t1801
  %t1805 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1806 = icmp eq i32 %t1791, 4
  %t1807 = select i1 %t1806, i8* %t1805, i8* %t1804
  %t1808 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1809 = icmp eq i32 %t1791, 5
  %t1810 = select i1 %t1809, i8* %t1808, i8* %t1807
  %t1811 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1812 = icmp eq i32 %t1791, 6
  %t1813 = select i1 %t1812, i8* %t1811, i8* %t1810
  %t1814 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1815 = icmp eq i32 %t1791, 7
  %t1816 = select i1 %t1815, i8* %t1814, i8* %t1813
  %t1817 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1818 = icmp eq i32 %t1791, 8
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1816
  %t1820 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1791, 9
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1791, 10
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1791, 11
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1791, 12
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1791, 13
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1791, 14
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1791, 15
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1791, 16
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1791, 17
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1791, 18
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1791, 19
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %t1853 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1791, 20
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %t1856 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1857 = icmp eq i32 %t1791, 21
  %t1858 = select i1 %t1857, i8* %t1856, i8* %t1855
  %t1859 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1860 = icmp eq i32 %t1791, 22
  %t1861 = select i1 %t1860, i8* %t1859, i8* %t1858
  %s1862 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t1863 = call i1 @strings_equal(i8* %t1861, i8* %s1862)
  br i1 %t1863, label %then48, label %merge49
then48:
  %t1864 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1865 = ptrtoint [0 x %EffectRequirement]* %t1864 to i64
  %t1866 = icmp eq i64 %t1865, 0
  %t1867 = select i1 %t1866, i64 1, i64 %t1865
  %t1868 = call i8* @malloc(i64 %t1867)
  %t1869 = bitcast i8* %t1868 to %EffectRequirement*
  %t1870 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1871 = ptrtoint { %EffectRequirement*, i64 }* %t1870 to i64
  %t1872 = call i8* @malloc(i64 %t1871)
  %t1873 = bitcast i8* %t1872 to { %EffectRequirement*, i64 }*
  %t1874 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1873, i32 0, i32 0
  store %EffectRequirement* %t1869, %EffectRequirement** %t1874
  %t1875 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1873, i32 0, i32 1
  store i64 0, i64* %t1875
  store { %EffectRequirement*, i64 }* %t1873, { %EffectRequirement*, i64 }** %l11
  %t1876 = sitofp i64 0 to double
  store double %t1876, double* %l12
  %t1877 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1878 = load double, double* %l12
  br label %loop.header50
loop.header50:
  %t1924 = phi { %EffectRequirement*, i64 }* [ %t1877, %then48 ], [ %t1922, %loop.latch52 ]
  %t1925 = phi double [ %t1878, %then48 ], [ %t1923, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1924, { %EffectRequirement*, i64 }** %l11
  store double %t1925, double* %l12
  br label %loop.body51
loop.body51:
  %t1879 = load double, double* %l12
  %t1880 = extractvalue %Statement %statement, 0
  %t1881 = alloca %Statement
  store %Statement %statement, %Statement* %t1881
  %t1882 = getelementptr inbounds %Statement, %Statement* %t1881, i32 0, i32 1
  %t1883 = bitcast [48 x i8]* %t1882 to i8*
  %t1884 = getelementptr inbounds i8, i8* %t1883, i64 24
  %t1885 = bitcast i8* %t1884 to { %ModelProperty**, i64 }**
  %t1886 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1885
  %t1887 = icmp eq i32 %t1880, 3
  %t1888 = select i1 %t1887, { %ModelProperty**, i64 }* %t1886, { %ModelProperty**, i64 }* null
  %t1889 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1888
  %t1890 = extractvalue { %ModelProperty**, i64 } %t1889, 1
  %t1891 = sitofp i64 %t1890 to double
  %t1892 = fcmp oge double %t1879, %t1891
  %t1893 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1894 = load double, double* %l12
  br i1 %t1892, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1895 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1896 = extractvalue %Statement %statement, 0
  %t1897 = alloca %Statement
  store %Statement %statement, %Statement* %t1897
  %t1898 = getelementptr inbounds %Statement, %Statement* %t1897, i32 0, i32 1
  %t1899 = bitcast [48 x i8]* %t1898 to i8*
  %t1900 = getelementptr inbounds i8, i8* %t1899, i64 24
  %t1901 = bitcast i8* %t1900 to { %ModelProperty**, i64 }**
  %t1902 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1901
  %t1903 = icmp eq i32 %t1896, 3
  %t1904 = select i1 %t1903, { %ModelProperty**, i64 }* %t1902, { %ModelProperty**, i64 }* null
  %t1905 = load double, double* %l12
  %t1906 = call double @llvm.round.f64(double %t1905)
  %t1907 = fptosi double %t1906 to i64
  %t1908 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1904
  %t1909 = extractvalue { %ModelProperty**, i64 } %t1908, 0
  %t1910 = extractvalue { %ModelProperty**, i64 } %t1908, 1
  %t1911 = icmp uge i64 %t1907, %t1910
  ; bounds check: %t1911 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1907, i64 %t1910)
  %t1912 = getelementptr %ModelProperty*, %ModelProperty** %t1909, i64 %t1907
  %t1913 = load %ModelProperty*, %ModelProperty** %t1912
  %t1914 = getelementptr %ModelProperty, %ModelProperty* %t1913, i32 0, i32 1
  %t1915 = load %Expression, %Expression* %t1914
  %t1916 = alloca %Expression
  store %Expression %t1915, %Expression* %t1916
  %t1917 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1916)
  %t1918 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1895, { %EffectRequirement*, i64 }* %t1917)
  store { %EffectRequirement*, i64 }* %t1918, { %EffectRequirement*, i64 }** %l11
  %t1919 = load double, double* %l12
  %t1920 = sitofp i64 1 to double
  %t1921 = fadd double %t1919, %t1920
  store double %t1921, double* %l12
  br label %loop.latch52
loop.latch52:
  %t1922 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1923 = load double, double* %l12
  br label %loop.header50
afterloop53:
  %t1926 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1927 = load double, double* %l12
  %t1928 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  ret { %EffectRequirement*, i64 }* %t1928
merge49:
  %t1929 = extractvalue %Statement %statement, 0
  %t1930 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1931 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1932 = icmp eq i32 %t1929, 0
  %t1933 = select i1 %t1932, i8* %t1931, i8* %t1930
  %t1934 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1935 = icmp eq i32 %t1929, 1
  %t1936 = select i1 %t1935, i8* %t1934, i8* %t1933
  %t1937 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1938 = icmp eq i32 %t1929, 2
  %t1939 = select i1 %t1938, i8* %t1937, i8* %t1936
  %t1940 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1941 = icmp eq i32 %t1929, 3
  %t1942 = select i1 %t1941, i8* %t1940, i8* %t1939
  %t1943 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1944 = icmp eq i32 %t1929, 4
  %t1945 = select i1 %t1944, i8* %t1943, i8* %t1942
  %t1946 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1947 = icmp eq i32 %t1929, 5
  %t1948 = select i1 %t1947, i8* %t1946, i8* %t1945
  %t1949 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1950 = icmp eq i32 %t1929, 6
  %t1951 = select i1 %t1950, i8* %t1949, i8* %t1948
  %t1952 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1953 = icmp eq i32 %t1929, 7
  %t1954 = select i1 %t1953, i8* %t1952, i8* %t1951
  %t1955 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1956 = icmp eq i32 %t1929, 8
  %t1957 = select i1 %t1956, i8* %t1955, i8* %t1954
  %t1958 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1959 = icmp eq i32 %t1929, 9
  %t1960 = select i1 %t1959, i8* %t1958, i8* %t1957
  %t1961 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1962 = icmp eq i32 %t1929, 10
  %t1963 = select i1 %t1962, i8* %t1961, i8* %t1960
  %t1964 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1965 = icmp eq i32 %t1929, 11
  %t1966 = select i1 %t1965, i8* %t1964, i8* %t1963
  %t1967 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1968 = icmp eq i32 %t1929, 12
  %t1969 = select i1 %t1968, i8* %t1967, i8* %t1966
  %t1970 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1971 = icmp eq i32 %t1929, 13
  %t1972 = select i1 %t1971, i8* %t1970, i8* %t1969
  %t1973 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1974 = icmp eq i32 %t1929, 14
  %t1975 = select i1 %t1974, i8* %t1973, i8* %t1972
  %t1976 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1977 = icmp eq i32 %t1929, 15
  %t1978 = select i1 %t1977, i8* %t1976, i8* %t1975
  %t1979 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1980 = icmp eq i32 %t1929, 16
  %t1981 = select i1 %t1980, i8* %t1979, i8* %t1978
  %t1982 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1983 = icmp eq i32 %t1929, 17
  %t1984 = select i1 %t1983, i8* %t1982, i8* %t1981
  %t1985 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1986 = icmp eq i32 %t1929, 18
  %t1987 = select i1 %t1986, i8* %t1985, i8* %t1984
  %t1988 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1989 = icmp eq i32 %t1929, 19
  %t1990 = select i1 %t1989, i8* %t1988, i8* %t1987
  %t1991 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1992 = icmp eq i32 %t1929, 20
  %t1993 = select i1 %t1992, i8* %t1991, i8* %t1990
  %t1994 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1995 = icmp eq i32 %t1929, 21
  %t1996 = select i1 %t1995, i8* %t1994, i8* %t1993
  %t1997 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1998 = icmp eq i32 %t1929, 22
  %t1999 = select i1 %t1998, i8* %t1997, i8* %t1996
  %s2000 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t2001 = call i1 @strings_equal(i8* %t1999, i8* %s2000)
  br i1 %t2001, label %then56, label %merge57
then56:
  %t2002 = extractvalue %Statement %statement, 0
  %t2003 = alloca %Statement
  store %Statement %statement, %Statement* %t2003
  %t2004 = getelementptr inbounds %Statement, %Statement* %t2003, i32 0, i32 1
  %t2005 = bitcast [16 x i8]* %t2004 to i8*
  %t2006 = bitcast i8* %t2005 to { %Token**, i64 }**
  %t2007 = load { %Token**, i64 }*, { %Token**, i64 }** %t2006
  %t2008 = icmp eq i32 %t2002, 22
  %t2009 = select i1 %t2008, { %Token**, i64 }* %t2007, { %Token**, i64 }* null
  %t2010 = bitcast { %Token**, i64 }* %t2009 to { %Token*, i64 }*
  %t2011 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t2010)
  ret { %EffectRequirement*, i64 }* %t2011
merge57:
  %t2012 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t2013 = ptrtoint [0 x %EffectRequirement]* %t2012 to i64
  %t2014 = icmp eq i64 %t2013, 0
  %t2015 = select i1 %t2014, i64 1, i64 %t2013
  %t2016 = call i8* @malloc(i64 %t2015)
  %t2017 = bitcast i8* %t2016 to %EffectRequirement*
  %t2018 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t2019 = ptrtoint { %EffectRequirement*, i64 }* %t2018 to i64
  %t2020 = call i8* @malloc(i64 %t2019)
  %t2021 = bitcast i8* %t2020 to { %EffectRequirement*, i64 }*
  %t2022 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2021, i32 0, i32 0
  store %EffectRequirement* %t2017, %EffectRequirement** %t2022
  %t2023 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2021, i32 0, i32 1
  store i64 0, i64* %t2023
  ret { %EffectRequirement*, i64 }* %t2021
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
  %t1 = alloca %Expression
  store %Expression %t0, %Expression* %t1
  %t2 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1)
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t3 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t4 = extractvalue %MatchCase %case, 1
  %t5 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t4)
  %t6 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t3, { %EffectRequirement*, i64 }* %t5)
  store { %EffectRequirement*, i64 }* %t6, { %EffectRequirement*, i64 }** %l0
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t8 = extractvalue %MatchCase %case, 2
  %t9 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t8)
  %t10 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t7, { %EffectRequirement*, i64 }* %t9)
  store { %EffectRequirement*, i64 }* %t10, { %EffectRequirement*, i64 }** %l0
  %t11 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t11
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
  %s64 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217216103, i32 0, i32 0
  %t65 = call i1 @strings_equal(i8* %t63, i8* %s64)
  br i1 %t65, label %then2, label %merge3
then2:
  %t66 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t67 = load i32, i32* %t66
  %t68 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t69 = bitcast [16 x i8]* %t68 to i8*
  %t70 = bitcast i8* %t69 to %Expression**
  %t71 = load %Expression*, %Expression** %t70
  %t72 = icmp eq i32 %t67, 8
  %t73 = select i1 %t72, %Expression* %t71, %Expression* null
  %t74 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t73)
  store { %EffectRequirement*, i64 }* %t74, { %EffectRequirement*, i64 }** %l0
  %t75 = sitofp i64 0 to double
  store double %t75, double* %l1
  %t76 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t77 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t120 = phi { %EffectRequirement*, i64 }* [ %t76, %then2 ], [ %t118, %loop.latch6 ]
  %t121 = phi double [ %t77, %then2 ], [ %t119, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t120, { %EffectRequirement*, i64 }** %l0
  store double %t121, double* %l1
  br label %loop.body5
loop.body5:
  %t78 = load double, double* %l1
  %t79 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t80 = load i32, i32* %t79
  %t81 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t82 = bitcast [16 x i8]* %t81 to i8*
  %t83 = getelementptr inbounds i8, i8* %t82, i64 8
  %t84 = bitcast i8* %t83 to { %Expression**, i64 }**
  %t85 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t84
  %t86 = icmp eq i32 %t80, 8
  %t87 = select i1 %t86, { %Expression**, i64 }* %t85, { %Expression**, i64 }* null
  %t88 = load { %Expression**, i64 }, { %Expression**, i64 }* %t87
  %t89 = extractvalue { %Expression**, i64 } %t88, 1
  %t90 = sitofp i64 %t89 to double
  %t91 = fcmp oge double %t78, %t90
  %t92 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t93 = load double, double* %l1
  br i1 %t91, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t94 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t95 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t96 = load i32, i32* %t95
  %t97 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t98 = bitcast [16 x i8]* %t97 to i8*
  %t99 = getelementptr inbounds i8, i8* %t98, i64 8
  %t100 = bitcast i8* %t99 to { %Expression**, i64 }**
  %t101 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t100
  %t102 = icmp eq i32 %t96, 8
  %t103 = select i1 %t102, { %Expression**, i64 }* %t101, { %Expression**, i64 }* null
  %t104 = load double, double* %l1
  %t105 = call double @llvm.round.f64(double %t104)
  %t106 = fptosi double %t105 to i64
  %t107 = load { %Expression**, i64 }, { %Expression**, i64 }* %t103
  %t108 = extractvalue { %Expression**, i64 } %t107, 0
  %t109 = extractvalue { %Expression**, i64 } %t107, 1
  %t110 = icmp uge i64 %t106, %t109
  ; bounds check: %t110 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t106, i64 %t109)
  %t111 = getelementptr %Expression*, %Expression** %t108, i64 %t106
  %t112 = load %Expression*, %Expression** %t111
  %t113 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t112)
  %t114 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t94, { %EffectRequirement*, i64 }* %t113)
  store { %EffectRequirement*, i64 }* %t114, { %EffectRequirement*, i64 }** %l0
  %t115 = load double, double* %l1
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l1
  br label %loop.latch6
loop.latch6:
  %t118 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t119 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t122 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t123 = load double, double* %l1
  %t124 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t124
merge3:
  %t125 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t126 = load i32, i32* %t125
  %t127 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t128 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t126, 0
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t126, 1
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t126, 2
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t126, 3
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t126, 4
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t126, 5
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t126, 6
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t126, 7
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t126, 8
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t126, 9
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t126, 10
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t126, 11
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t126, 12
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t126, 13
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t126, 14
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t126, 15
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %s176 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h512390329, i32 0, i32 0
  %t177 = call i1 @strings_equal(i8* %t175, i8* %s176)
  br i1 %t177, label %then10, label %merge11
then10:
  %t178 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t179 = load i32, i32* %t178
  %t180 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t181 = bitcast [16 x i8]* %t180 to i8*
  %t182 = bitcast i8* %t181 to %Expression**
  %t183 = load %Expression*, %Expression** %t182
  %t184 = icmp eq i32 %t179, 7
  %t185 = select i1 %t184, %Expression* %t183, %Expression* null
  %t186 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t185)
  ret { %EffectRequirement*, i64 }* %t186
merge11:
  %t187 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t188 = load i32, i32* %t187
  %t189 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t190 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t188, 0
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t188, 1
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t188, 2
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t188, 3
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t188, 4
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t188, 5
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t188, 6
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t188, 7
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t188, 8
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t188, 9
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t188, 10
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t188, 11
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t188, 12
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t188, 13
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t188, 14
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t188, 15
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %s238 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1445149598, i32 0, i32 0
  %t239 = call i1 @strings_equal(i8* %t237, i8* %s238)
  br i1 %t239, label %then12, label %merge13
then12:
  %t240 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t241 = load i32, i32* %t240
  %t242 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t243 = bitcast [16 x i8]* %t242 to i8*
  %t244 = getelementptr inbounds i8, i8* %t243, i64 8
  %t245 = bitcast i8* %t244 to %Expression**
  %t246 = load %Expression*, %Expression** %t245
  %t247 = icmp eq i32 %t241, 5
  %t248 = select i1 %t247, %Expression* %t246, %Expression* null
  %t249 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t248)
  ret { %EffectRequirement*, i64 }* %t249
merge13:
  %t250 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t251 = load i32, i32* %t250
  %t252 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t253 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t254 = icmp eq i32 %t251, 0
  %t255 = select i1 %t254, i8* %t253, i8* %t252
  %t256 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t257 = icmp eq i32 %t251, 1
  %t258 = select i1 %t257, i8* %t256, i8* %t255
  %t259 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t251, 2
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t251, 3
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t251, 4
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t251, 5
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t251, 6
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t251, 7
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t251, 8
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t251, 9
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t251, 10
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t251, 11
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t251, 12
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %t292 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t293 = icmp eq i32 %t251, 13
  %t294 = select i1 %t293, i8* %t292, i8* %t291
  %t295 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t296 = icmp eq i32 %t251, 14
  %t297 = select i1 %t296, i8* %t295, i8* %t294
  %t298 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t299 = icmp eq i32 %t251, 15
  %t300 = select i1 %t299, i8* %t298, i8* %t297
  %s301 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1496334143, i32 0, i32 0
  %t302 = call i1 @strings_equal(i8* %t300, i8* %s301)
  br i1 %t302, label %then14, label %merge15
then14:
  %t303 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t304 = load i32, i32* %t303
  %t305 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t306 = bitcast [24 x i8]* %t305 to i8*
  %t307 = getelementptr inbounds i8, i8* %t306, i64 8
  %t308 = bitcast i8* %t307 to %Expression**
  %t309 = load %Expression*, %Expression** %t308
  %t310 = icmp eq i32 %t304, 6
  %t311 = select i1 %t310, %Expression* %t309, %Expression* null
  %t312 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t311)
  store { %EffectRequirement*, i64 }* %t312, { %EffectRequirement*, i64 }** %l2
  %t313 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  %t314 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t315 = load i32, i32* %t314
  %t316 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t317 = bitcast [24 x i8]* %t316 to i8*
  %t318 = getelementptr inbounds i8, i8* %t317, i64 16
  %t319 = bitcast i8* %t318 to %Expression**
  %t320 = load %Expression*, %Expression** %t319
  %t321 = icmp eq i32 %t315, 6
  %t322 = select i1 %t321, %Expression* %t320, %Expression* null
  %t323 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t322)
  %t324 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t313, { %EffectRequirement*, i64 }* %t323)
  store { %EffectRequirement*, i64 }* %t324, { %EffectRequirement*, i64 }** %l2
  %t325 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  ret { %EffectRequirement*, i64 }* %t325
merge15:
  %t326 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t327 = load i32, i32* %t326
  %t328 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t329 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t327, 0
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t327, 1
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t327, 2
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t327, 3
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t327, 4
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t327, 5
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t327, 6
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t327, 7
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t327, 8
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t327, 9
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t327, 10
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t327, 11
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t327, 12
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t327, 13
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t327, 14
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t327, 15
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %s377 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h667777838, i32 0, i32 0
  %t378 = call i1 @strings_equal(i8* %t376, i8* %s377)
  br i1 %t378, label %then16, label %merge17
then16:
  %t379 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t380 = ptrtoint [0 x %EffectRequirement]* %t379 to i64
  %t381 = icmp eq i64 %t380, 0
  %t382 = select i1 %t381, i64 1, i64 %t380
  %t383 = call i8* @malloc(i64 %t382)
  %t384 = bitcast i8* %t383 to %EffectRequirement*
  %t385 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t386 = ptrtoint { %EffectRequirement*, i64 }* %t385 to i64
  %t387 = call i8* @malloc(i64 %t386)
  %t388 = bitcast i8* %t387 to { %EffectRequirement*, i64 }*
  %t389 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t388, i32 0, i32 0
  store %EffectRequirement* %t384, %EffectRequirement** %t389
  %t390 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t388, i32 0, i32 1
  store i64 0, i64* %t390
  store { %EffectRequirement*, i64 }* %t388, { %EffectRequirement*, i64 }** %l3
  %t391 = sitofp i64 0 to double
  store double %t391, double* %l4
  %t392 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t393 = load double, double* %l4
  br label %loop.header18
loop.header18:
  %t434 = phi { %EffectRequirement*, i64 }* [ %t392, %then16 ], [ %t432, %loop.latch20 ]
  %t435 = phi double [ %t393, %then16 ], [ %t433, %loop.latch20 ]
  store { %EffectRequirement*, i64 }* %t434, { %EffectRequirement*, i64 }** %l3
  store double %t435, double* %l4
  br label %loop.body19
loop.body19:
  %t394 = load double, double* %l4
  %t395 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t396 = load i32, i32* %t395
  %t397 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t398 = bitcast [8 x i8]* %t397 to i8*
  %t399 = bitcast i8* %t398 to { %Expression**, i64 }**
  %t400 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t399
  %t401 = icmp eq i32 %t396, 10
  %t402 = select i1 %t401, { %Expression**, i64 }* %t400, { %Expression**, i64 }* null
  %t403 = load { %Expression**, i64 }, { %Expression**, i64 }* %t402
  %t404 = extractvalue { %Expression**, i64 } %t403, 1
  %t405 = sitofp i64 %t404 to double
  %t406 = fcmp oge double %t394, %t405
  %t407 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t408 = load double, double* %l4
  br i1 %t406, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t409 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t410 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t411 = load i32, i32* %t410
  %t412 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t413 = bitcast [8 x i8]* %t412 to i8*
  %t414 = bitcast i8* %t413 to { %Expression**, i64 }**
  %t415 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t414
  %t416 = icmp eq i32 %t411, 10
  %t417 = select i1 %t416, { %Expression**, i64 }* %t415, { %Expression**, i64 }* null
  %t418 = load double, double* %l4
  %t419 = call double @llvm.round.f64(double %t418)
  %t420 = fptosi double %t419 to i64
  %t421 = load { %Expression**, i64 }, { %Expression**, i64 }* %t417
  %t422 = extractvalue { %Expression**, i64 } %t421, 0
  %t423 = extractvalue { %Expression**, i64 } %t421, 1
  %t424 = icmp uge i64 %t420, %t423
  ; bounds check: %t424 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t420, i64 %t423)
  %t425 = getelementptr %Expression*, %Expression** %t422, i64 %t420
  %t426 = load %Expression*, %Expression** %t425
  %t427 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t426)
  %t428 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t409, { %EffectRequirement*, i64 }* %t427)
  store { %EffectRequirement*, i64 }* %t428, { %EffectRequirement*, i64 }** %l3
  %t429 = load double, double* %l4
  %t430 = sitofp i64 1 to double
  %t431 = fadd double %t429, %t430
  store double %t431, double* %l4
  br label %loop.latch20
loop.latch20:
  %t432 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t433 = load double, double* %l4
  br label %loop.header18
afterloop21:
  %t436 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t437 = load double, double* %l4
  %t438 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  ret { %EffectRequirement*, i64 }* %t438
merge17:
  %t439 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t440 = load i32, i32* %t439
  %t441 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t442 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t443 = icmp eq i32 %t440, 0
  %t444 = select i1 %t443, i8* %t442, i8* %t441
  %t445 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t446 = icmp eq i32 %t440, 1
  %t447 = select i1 %t446, i8* %t445, i8* %t444
  %t448 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t449 = icmp eq i32 %t440, 2
  %t450 = select i1 %t449, i8* %t448, i8* %t447
  %t451 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t452 = icmp eq i32 %t440, 3
  %t453 = select i1 %t452, i8* %t451, i8* %t450
  %t454 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t455 = icmp eq i32 %t440, 4
  %t456 = select i1 %t455, i8* %t454, i8* %t453
  %t457 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t458 = icmp eq i32 %t440, 5
  %t459 = select i1 %t458, i8* %t457, i8* %t456
  %t460 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t461 = icmp eq i32 %t440, 6
  %t462 = select i1 %t461, i8* %t460, i8* %t459
  %t463 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t464 = icmp eq i32 %t440, 7
  %t465 = select i1 %t464, i8* %t463, i8* %t462
  %t466 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t467 = icmp eq i32 %t440, 8
  %t468 = select i1 %t467, i8* %t466, i8* %t465
  %t469 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t470 = icmp eq i32 %t440, 9
  %t471 = select i1 %t470, i8* %t469, i8* %t468
  %t472 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t473 = icmp eq i32 %t440, 10
  %t474 = select i1 %t473, i8* %t472, i8* %t471
  %t475 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t476 = icmp eq i32 %t440, 11
  %t477 = select i1 %t476, i8* %t475, i8* %t474
  %t478 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t440, 12
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t440, 13
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t440, 14
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t440, 15
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %s490 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h826984377, i32 0, i32 0
  %t491 = call i1 @strings_equal(i8* %t489, i8* %s490)
  br i1 %t491, label %then24, label %merge25
then24:
  %t492 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t493 = ptrtoint [0 x %EffectRequirement]* %t492 to i64
  %t494 = icmp eq i64 %t493, 0
  %t495 = select i1 %t494, i64 1, i64 %t493
  %t496 = call i8* @malloc(i64 %t495)
  %t497 = bitcast i8* %t496 to %EffectRequirement*
  %t498 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t499 = ptrtoint { %EffectRequirement*, i64 }* %t498 to i64
  %t500 = call i8* @malloc(i64 %t499)
  %t501 = bitcast i8* %t500 to { %EffectRequirement*, i64 }*
  %t502 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t501, i32 0, i32 0
  store %EffectRequirement* %t497, %EffectRequirement** %t502
  %t503 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t501, i32 0, i32 1
  store i64 0, i64* %t503
  store { %EffectRequirement*, i64 }* %t501, { %EffectRequirement*, i64 }** %l5
  %t504 = sitofp i64 0 to double
  store double %t504, double* %l6
  %t505 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t506 = load double, double* %l6
  br label %loop.header26
loop.header26:
  %t564 = phi { %EffectRequirement*, i64 }* [ %t505, %then24 ], [ %t562, %loop.latch28 ]
  %t565 = phi double [ %t506, %then24 ], [ %t563, %loop.latch28 ]
  store { %EffectRequirement*, i64 }* %t564, { %EffectRequirement*, i64 }** %l5
  store double %t565, double* %l6
  br label %loop.body27
loop.body27:
  %t507 = load double, double* %l6
  %t508 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t509 = load i32, i32* %t508
  %t510 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t511 = bitcast [8 x i8]* %t510 to i8*
  %t512 = bitcast i8* %t511 to { %ObjectField**, i64 }**
  %t513 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t512
  %t514 = icmp eq i32 %t509, 11
  %t515 = select i1 %t514, { %ObjectField**, i64 }* %t513, { %ObjectField**, i64 }* null
  %t516 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t517 = bitcast [16 x i8]* %t516 to i8*
  %t518 = getelementptr inbounds i8, i8* %t517, i64 8
  %t519 = bitcast i8* %t518 to { %ObjectField**, i64 }**
  %t520 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t519
  %t521 = icmp eq i32 %t509, 12
  %t522 = select i1 %t521, { %ObjectField**, i64 }* %t520, { %ObjectField**, i64 }* %t515
  %t523 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t522
  %t524 = extractvalue { %ObjectField**, i64 } %t523, 1
  %t525 = sitofp i64 %t524 to double
  %t526 = fcmp oge double %t507, %t525
  %t527 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t528 = load double, double* %l6
  br i1 %t526, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t529 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t530 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t531 = load i32, i32* %t530
  %t532 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t533 = bitcast [8 x i8]* %t532 to i8*
  %t534 = bitcast i8* %t533 to { %ObjectField**, i64 }**
  %t535 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t534
  %t536 = icmp eq i32 %t531, 11
  %t537 = select i1 %t536, { %ObjectField**, i64 }* %t535, { %ObjectField**, i64 }* null
  %t538 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t539 = bitcast [16 x i8]* %t538 to i8*
  %t540 = getelementptr inbounds i8, i8* %t539, i64 8
  %t541 = bitcast i8* %t540 to { %ObjectField**, i64 }**
  %t542 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t541
  %t543 = icmp eq i32 %t531, 12
  %t544 = select i1 %t543, { %ObjectField**, i64 }* %t542, { %ObjectField**, i64 }* %t537
  %t545 = load double, double* %l6
  %t546 = call double @llvm.round.f64(double %t545)
  %t547 = fptosi double %t546 to i64
  %t548 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t544
  %t549 = extractvalue { %ObjectField**, i64 } %t548, 0
  %t550 = extractvalue { %ObjectField**, i64 } %t548, 1
  %t551 = icmp uge i64 %t547, %t550
  ; bounds check: %t551 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t547, i64 %t550)
  %t552 = getelementptr %ObjectField*, %ObjectField** %t549, i64 %t547
  %t553 = load %ObjectField*, %ObjectField** %t552
  %t554 = getelementptr %ObjectField, %ObjectField* %t553, i32 0, i32 1
  %t555 = load %Expression, %Expression* %t554
  %t556 = alloca %Expression
  store %Expression %t555, %Expression* %t556
  %t557 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t556)
  %t558 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t529, { %EffectRequirement*, i64 }* %t557)
  store { %EffectRequirement*, i64 }* %t558, { %EffectRequirement*, i64 }** %l5
  %t559 = load double, double* %l6
  %t560 = sitofp i64 1 to double
  %t561 = fadd double %t559, %t560
  store double %t561, double* %l6
  br label %loop.latch28
loop.latch28:
  %t562 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t563 = load double, double* %l6
  br label %loop.header26
afterloop29:
  %t566 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t567 = load double, double* %l6
  %t568 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t568
merge25:
  %t569 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t570 = load i32, i32* %t569
  %t571 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t572 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t570, 0
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t570, 1
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t570, 2
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t570, 3
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t570, 4
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t570, 5
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t570, 6
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t570, 7
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t570, 8
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t570, 9
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t570, 10
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t570, 11
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t570, 12
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t570, 13
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t570, 14
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %t617 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t618 = icmp eq i32 %t570, 15
  %t619 = select i1 %t618, i8* %t617, i8* %t616
  %s620 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h264904746, i32 0, i32 0
  %t621 = call i1 @strings_equal(i8* %t619, i8* %s620)
  br i1 %t621, label %then32, label %merge33
then32:
  %t622 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t623 = ptrtoint [0 x %EffectRequirement]* %t622 to i64
  %t624 = icmp eq i64 %t623, 0
  %t625 = select i1 %t624, i64 1, i64 %t623
  %t626 = call i8* @malloc(i64 %t625)
  %t627 = bitcast i8* %t626 to %EffectRequirement*
  %t628 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t629 = ptrtoint { %EffectRequirement*, i64 }* %t628 to i64
  %t630 = call i8* @malloc(i64 %t629)
  %t631 = bitcast i8* %t630 to { %EffectRequirement*, i64 }*
  %t632 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t631, i32 0, i32 0
  store %EffectRequirement* %t627, %EffectRequirement** %t632
  %t633 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t631, i32 0, i32 1
  store i64 0, i64* %t633
  store { %EffectRequirement*, i64 }* %t631, { %EffectRequirement*, i64 }** %l7
  %t634 = sitofp i64 0 to double
  store double %t634, double* %l8
  %t635 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t636 = load double, double* %l8
  br label %loop.header34
loop.header34:
  %t694 = phi { %EffectRequirement*, i64 }* [ %t635, %then32 ], [ %t692, %loop.latch36 ]
  %t695 = phi double [ %t636, %then32 ], [ %t693, %loop.latch36 ]
  store { %EffectRequirement*, i64 }* %t694, { %EffectRequirement*, i64 }** %l7
  store double %t695, double* %l8
  br label %loop.body35
loop.body35:
  %t637 = load double, double* %l8
  %t638 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t639 = load i32, i32* %t638
  %t640 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t641 = bitcast [8 x i8]* %t640 to i8*
  %t642 = bitcast i8* %t641 to { %ObjectField**, i64 }**
  %t643 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t642
  %t644 = icmp eq i32 %t639, 11
  %t645 = select i1 %t644, { %ObjectField**, i64 }* %t643, { %ObjectField**, i64 }* null
  %t646 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t647 = bitcast [16 x i8]* %t646 to i8*
  %t648 = getelementptr inbounds i8, i8* %t647, i64 8
  %t649 = bitcast i8* %t648 to { %ObjectField**, i64 }**
  %t650 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t649
  %t651 = icmp eq i32 %t639, 12
  %t652 = select i1 %t651, { %ObjectField**, i64 }* %t650, { %ObjectField**, i64 }* %t645
  %t653 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t652
  %t654 = extractvalue { %ObjectField**, i64 } %t653, 1
  %t655 = sitofp i64 %t654 to double
  %t656 = fcmp oge double %t637, %t655
  %t657 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t658 = load double, double* %l8
  br i1 %t656, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t659 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t660 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t661 = load i32, i32* %t660
  %t662 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t663 = bitcast [8 x i8]* %t662 to i8*
  %t664 = bitcast i8* %t663 to { %ObjectField**, i64 }**
  %t665 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t664
  %t666 = icmp eq i32 %t661, 11
  %t667 = select i1 %t666, { %ObjectField**, i64 }* %t665, { %ObjectField**, i64 }* null
  %t668 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t669 = bitcast [16 x i8]* %t668 to i8*
  %t670 = getelementptr inbounds i8, i8* %t669, i64 8
  %t671 = bitcast i8* %t670 to { %ObjectField**, i64 }**
  %t672 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t671
  %t673 = icmp eq i32 %t661, 12
  %t674 = select i1 %t673, { %ObjectField**, i64 }* %t672, { %ObjectField**, i64 }* %t667
  %t675 = load double, double* %l8
  %t676 = call double @llvm.round.f64(double %t675)
  %t677 = fptosi double %t676 to i64
  %t678 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t674
  %t679 = extractvalue { %ObjectField**, i64 } %t678, 0
  %t680 = extractvalue { %ObjectField**, i64 } %t678, 1
  %t681 = icmp uge i64 %t677, %t680
  ; bounds check: %t681 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t677, i64 %t680)
  %t682 = getelementptr %ObjectField*, %ObjectField** %t679, i64 %t677
  %t683 = load %ObjectField*, %ObjectField** %t682
  %t684 = getelementptr %ObjectField, %ObjectField* %t683, i32 0, i32 1
  %t685 = load %Expression, %Expression* %t684
  %t686 = alloca %Expression
  store %Expression %t685, %Expression* %t686
  %t687 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t686)
  %t688 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t659, { %EffectRequirement*, i64 }* %t687)
  store { %EffectRequirement*, i64 }* %t688, { %EffectRequirement*, i64 }** %l7
  %t689 = load double, double* %l8
  %t690 = sitofp i64 1 to double
  %t691 = fadd double %t689, %t690
  store double %t691, double* %l8
  br label %loop.latch36
loop.latch36:
  %t692 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t693 = load double, double* %l8
  br label %loop.header34
afterloop37:
  %t696 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t697 = load double, double* %l8
  %t698 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t698
merge33:
  %t699 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t700 = load i32, i32* %t699
  %t701 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t702 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t700, 0
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t700, 1
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t700, 2
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %t711 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t712 = icmp eq i32 %t700, 3
  %t713 = select i1 %t712, i8* %t711, i8* %t710
  %t714 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t700, 4
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t700, 5
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t700, 6
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t700, 7
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %t726 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t700, 8
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t700, 9
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t700, 10
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t700, 11
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t700, 12
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t700, 13
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t700, 14
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t700, 15
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %s750 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1211862785, i32 0, i32 0
  %t751 = call i1 @strings_equal(i8* %t749, i8* %s750)
  br i1 %t751, label %then40, label %merge41
then40:
  %t752 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t753 = load i32, i32* %t752
  %t754 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t755 = bitcast [40 x i8]* %t754 to i8*
  %t756 = getelementptr inbounds i8, i8* %t755, i64 8
  %t757 = bitcast i8* %t756 to %Block*
  %t758 = load %Block, %Block* %t757
  %t759 = icmp eq i32 %t753, 13
  %t760 = select i1 %t759, %Block %t758, %Block zeroinitializer
  %t761 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t760)
  ret { %EffectRequirement*, i64 }* %t761
merge41:
  %t762 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t763 = load i32, i32* %t762
  %t764 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t765 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t763, 0
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t763, 1
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t763, 2
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t763, 3
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t763, 4
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t763, 5
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t763, 6
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t763, 7
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t763, 8
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t763, 9
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t763, 10
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t763, 11
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t763, 12
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t763, 13
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t763, 14
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t763, 15
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %s813 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h975618503, i32 0, i32 0
  %t814 = call i1 @strings_equal(i8* %t812, i8* %s813)
  br i1 %t814, label %then42, label %merge43
then42:
  %t815 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t816 = load i32, i32* %t815
  %t817 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t818 = bitcast [16 x i8]* %t817 to i8*
  %t819 = bitcast i8* %t818 to %Expression**
  %t820 = load %Expression*, %Expression** %t819
  %t821 = icmp eq i32 %t816, 9
  %t822 = select i1 %t821, %Expression* %t820, %Expression* null
  %t823 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t822)
  store { %EffectRequirement*, i64 }* %t823, { %EffectRequirement*, i64 }** %l9
  %t824 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t825 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t826 = load i32, i32* %t825
  %t827 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t828 = bitcast [16 x i8]* %t827 to i8*
  %t829 = getelementptr inbounds i8, i8* %t828, i64 8
  %t830 = bitcast i8* %t829 to %Expression**
  %t831 = load %Expression*, %Expression** %t830
  %t832 = icmp eq i32 %t826, 9
  %t833 = select i1 %t832, %Expression* %t831, %Expression* null
  %t834 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t833)
  %t835 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t824, { %EffectRequirement*, i64 }* %t834)
  store { %EffectRequirement*, i64 }* %t835, { %EffectRequirement*, i64 }** %l9
  %t836 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t836
merge43:
  %t837 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t838 = load i32, i32* %t837
  %t839 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t840 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t838, 0
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t838, 1
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t838, 2
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %t849 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t838, 3
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t838, 4
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t838, 5
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t838, 6
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t838, 7
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t838, 8
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t838, 9
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t838, 10
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t838, 11
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t838, 12
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t838, 13
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t838, 14
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t838, 15
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %s888 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1312780988, i32 0, i32 0
  %t889 = call i1 @strings_equal(i8* %t887, i8* %s888)
  br i1 %t889, label %then44, label %merge45
then44:
  %t890 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t891 = load i32, i32* %t890
  %t892 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t893 = bitcast [16 x i8]* %t892 to i8*
  %t894 = bitcast i8* %t893 to %Expression**
  %t895 = load %Expression*, %Expression** %t894
  %t896 = icmp eq i32 %t891, 14
  %t897 = select i1 %t896, %Expression* %t895, %Expression* null
  %t898 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t897)
  store { %EffectRequirement*, i64 }* %t898, { %EffectRequirement*, i64 }** %l10
  %t899 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t900 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t901 = load i32, i32* %t900
  %t902 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t903 = bitcast [16 x i8]* %t902 to i8*
  %t904 = getelementptr inbounds i8, i8* %t903, i64 8
  %t905 = bitcast i8* %t904 to %Expression**
  %t906 = load %Expression*, %Expression** %t905
  %t907 = icmp eq i32 %t901, 14
  %t908 = select i1 %t907, %Expression* %t906, %Expression* null
  %t909 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t908)
  %t910 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t899, { %EffectRequirement*, i64 }* %t909)
  store { %EffectRequirement*, i64 }* %t910, { %EffectRequirement*, i64 }** %l10
  %t911 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t911
merge45:
  %t912 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t913 = load i32, i32* %t912
  %t914 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t915 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t913, 0
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t913, 1
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t913, 2
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t913, 3
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t913, 4
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t913, 5
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t913, 6
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t913, 7
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t913, 8
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t913, 9
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t913, 10
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t913, 11
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t913, 12
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t913, 13
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t913, 14
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t913, 15
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %s963 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089530004, i32 0, i32 0
  %t964 = call i1 @strings_equal(i8* %t962, i8* %s963)
  br i1 %t964, label %then46, label %merge47
then46:
  %t965 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t966 = ptrtoint [0 x %EffectRequirement]* %t965 to i64
  %t967 = icmp eq i64 %t966, 0
  %t968 = select i1 %t967, i64 1, i64 %t966
  %t969 = call i8* @malloc(i64 %t968)
  %t970 = bitcast i8* %t969 to %EffectRequirement*
  %t971 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t972 = ptrtoint { %EffectRequirement*, i64 }* %t971 to i64
  %t973 = call i8* @malloc(i64 %t972)
  %t974 = bitcast i8* %t973 to { %EffectRequirement*, i64 }*
  %t975 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t974, i32 0, i32 0
  store %EffectRequirement* %t970, %EffectRequirement** %t975
  %t976 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t974, i32 0, i32 1
  store i64 0, i64* %t976
  ret { %EffectRequirement*, i64 }* %t974
merge47:
  %t977 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t978 = ptrtoint [0 x %EffectRequirement]* %t977 to i64
  %t979 = icmp eq i64 %t978, 0
  %t980 = select i1 %t979, i64 1, i64 %t978
  %t981 = call i8* @malloc(i64 %t980)
  %t982 = bitcast i8* %t981 to %EffectRequirement*
  %t983 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t984 = ptrtoint { %EffectRequirement*, i64 }* %t983 to i64
  %t985 = call i8* @malloc(i64 %t984)
  %t986 = bitcast i8* %t985 to { %EffectRequirement*, i64 }*
  %t987 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t986, i32 0, i32 0
  store %EffectRequirement* %t982, %EffectRequirement** %t987
  %t988 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t986, i32 0, i32 1
  store i64 0, i64* %t988
  ret { %EffectRequirement*, i64 }* %t986
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
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193491872, i32 0, i32 0
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %s17 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h509166939, i32 0, i32 0
  %t18 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t14, { %Token*, i64 }* %tokens, i8* %s15, i8* %s16, i8* %s17)
  store { %EffectRequirement*, i64 }* %t18, { %EffectRequirement*, i64 }** %l0
  %t19 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s20 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h359348221, i32 0, i32 0
  %s21 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %s22 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h166827074, i32 0, i32 0
  %t23 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t19, { %Token*, i64 }* %tokens, i8* %s20, i8* %s21, i8* %s22)
  store { %EffectRequirement*, i64 }* %t23, { %EffectRequirement*, i64 }** %l0
  %t24 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s25 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1121316919, i32 0, i32 0
  %s26 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %s27 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1840566713, i32 0, i32 0
  %t28 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t24, { %Token*, i64 }* %tokens, i8* %s25, i8* %s26, i8* %s27)
  store { %EffectRequirement*, i64 }* %t28, { %EffectRequirement*, i64 }** %l0
  %t29 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s30 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h261786827, i32 0, i32 0
  %s31 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090540497, i32 0, i32 0
  %s32 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h959371065, i32 0, i32 0
  %t33 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t29, { %Token*, i64 }* %tokens, i8* %s30, i8* %s31, i8* %s32)
  store { %EffectRequirement*, i64 }* %t33, { %EffectRequirement*, i64 }** %l0
  %t34 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s35 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h6052019, i32 0, i32 0
  %s36 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090540497, i32 0, i32 0
  %s37 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h857956175, i32 0, i32 0
  %t38 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t34, { %Token*, i64 }* %tokens, i8* %s35, i8* %s36, i8* %s37)
  store { %EffectRequirement*, i64 }* %t38, { %EffectRequirement*, i64 }** %l0
  %t39 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s40 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h474104665, i32 0, i32 0
  %s41 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %s42 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1970595328, i32 0, i32 0
  %t43 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t39, { %Token*, i64 }* %tokens, i8* %s40, i8* %s41, i8* %s42)
  store { %EffectRequirement*, i64 }* %t43, { %EffectRequirement*, i64 }** %l0
  %t44 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s45 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h461669077, i32 0, i32 0
  %s46 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090540497, i32 0, i32 0
  %s47 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1681046972, i32 0, i32 0
  %t48 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t44, { %Token*, i64 }* %tokens, i8* %s45, i8* %s46, i8* %s47)
  store { %EffectRequirement*, i64 }* %t48, { %EffectRequirement*, i64 }** %l0
  %t49 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s50 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h469485193, i32 0, i32 0
  %s51 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1991159579, i32 0, i32 0
  %s52 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h881761880, i32 0, i32 0
  %t53 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t49, { %Token*, i64 }* %tokens, i8* %s50, i8* %s51, i8* %s52)
  store { %EffectRequirement*, i64 }* %t53, { %EffectRequirement*, i64 }** %l0
  %t54 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t54
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
  %t193 = phi { %EffectRequirement*, i64 }* [ %t1, %block.entry ], [ %t191, %loop.latch2 ]
  %t194 = phi double [ %t2, %block.entry ], [ %t192, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t193, { %EffectRequirement*, i64 }** %l0
  store double %t194, double* %l1
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
  %s20 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1128151960, i32 0, i32 0
  %t21 = call i1 @is_identifier_token(%Token %t19, i8* %s20)
  %t22 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = load %Token, %Token* %l2
  br i1 %t21, label %then6, label %merge7
then6:
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t27)
  store double %t28, double* %l3
  %s29 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h10983220, i32 0, i32 0
  store i8* %s29, i8** %l4
  %t30 = load double, double* %l3
  %t31 = sitofp i64 -1 to double
  %t32 = fcmp une double %t30, %t31
  %t33 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load %Token, %Token* %l2
  %t36 = load double, double* %l3
  %t37 = load i8*, i8** %l4
  br i1 %t32, label %then8, label %merge9
then8:
  %t38 = load double, double* %l3
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t42 = extractvalue { %Token*, i64 } %t41, 0
  %t43 = extractvalue { %Token*, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t40, i64 %t43)
  %t45 = getelementptr %Token, %Token* %t42, i64 %t40
  %t46 = load %Token, %Token* %t45
  store %Token %t46, %Token* %l5
  %t48 = load %Token, %Token* %l5
  %t49 = extractvalue %Token %t48, 0
  %t50 = extractvalue %TokenKind %t49, 0
  %t51 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t52 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t50, 0
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t50, 1
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t50, 2
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t50, 3
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t50, 4
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t50, 5
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t50, 6
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t50, 7
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %s76 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1576352120, i32 0, i32 0
  %t77 = call i1 @strings_equal(i8* %t75, i8* %s76)
  br label %logical_or_entry_47

logical_or_entry_47:
  br i1 %t77, label %logical_or_merge_47, label %logical_or_right_47

logical_or_right_47:
  %t78 = load %Token, %Token* %l5
  %t79 = extractvalue %Token %t78, 0
  %t80 = extractvalue %TokenKind %t79, 0
  %t81 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t82 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t80, 0
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t80, 1
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t80, 2
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t80, 3
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t80, 4
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t80, 5
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t80, 6
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t80, 7
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %s106 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h590768815, i32 0, i32 0
  %t107 = call i1 @strings_equal(i8* %t105, i8* %s106)
  br label %logical_or_right_end_47

logical_or_right_end_47:
  br label %logical_or_merge_47

logical_or_merge_47:
  %t108 = phi i1 [ true, %logical_or_entry_47 ], [ %t107, %logical_or_right_end_47 ]
  %t109 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t110 = load double, double* %l1
  %t111 = load %Token, %Token* %l2
  %t112 = load double, double* %l3
  %t113 = load i8*, i8** %l4
  %t114 = load %Token, %Token* %l5
  br i1 %t108, label %then10, label %merge11
then10:
  %s115 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h721793546, i32 0, i32 0
  %t116 = load %Token, %Token* %l5
  %t117 = extractvalue %Token %t116, 1
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %s115, i8* %t117)
  store i8* %t118, i8** %l4
  %t119 = load double, double* %l3
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  %t122 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t121)
  store double %t122, double* %l6
  %t124 = load double, double* %l6
  %t125 = sitofp i64 -1 to double
  %t126 = fcmp une double %t124, %t125
  br label %logical_and_entry_123

logical_and_entry_123:
  br i1 %t126, label %logical_and_right_123, label %logical_and_merge_123

logical_and_right_123:
  %t127 = load double, double* %l6
  %t128 = call double @llvm.round.f64(double %t127)
  %t129 = fptosi double %t128 to i64
  %t130 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t131 = extractvalue { %Token*, i64 } %t130, 0
  %t132 = extractvalue { %Token*, i64 } %t130, 1
  %t133 = icmp uge i64 %t129, %t132
  ; bounds check: %t133 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t129, i64 %t132)
  %t134 = getelementptr %Token, %Token* %t131, i64 %t129
  %t135 = load %Token, %Token* %t134
  %t136 = alloca [2 x i8], align 1
  %t137 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  store i8 123, i8* %t137
  %t138 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 1
  store i8 0, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  %t140 = call i1 @is_symbol_token(%Token %t135, i8* %t139)
  br label %logical_and_right_end_123

logical_and_right_end_123:
  br label %logical_and_merge_123

logical_and_merge_123:
  %t141 = phi i1 [ false, %logical_and_entry_123 ], [ %t140, %logical_and_right_end_123 ]
  %t142 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t143 = load double, double* %l1
  %t144 = load %Token, %Token* %l2
  %t145 = load double, double* %l3
  %t146 = load i8*, i8** %l4
  %t147 = load %Token, %Token* %l5
  %t148 = load double, double* %l6
  br i1 %t141, label %then12, label %merge13
then12:
  %t149 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s150 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t151 = insertvalue %EffectRequirement undef, i8* %s150, 0
  %t152 = load %Token, %Token* %l2
  %t153 = alloca %Token
  store %Token %t152, %Token* %t153
  %t154 = insertvalue %EffectRequirement %t151, %Token* %t153, 1
  %t155 = load i8*, i8** %l4
  %t156 = insertvalue %EffectRequirement %t154, i8* %t155, 2
  %t157 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t149, %EffectRequirement %t156)
  store { %EffectRequirement*, i64 }* %t157, { %EffectRequirement*, i64 }** %l0
  %t158 = load double, double* %l1
  %t159 = sitofp i64 1 to double
  %t160 = fadd double %t158, %t159
  store double %t160, double* %l1
  br label %loop.latch2
merge13:
  %t161 = load i8*, i8** %l4
  %t162 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t163 = load double, double* %l1
  br label %merge11
merge11:
  %t164 = phi i8* [ %t161, %merge13 ], [ %t113, %logical_or_merge_47 ]
  %t165 = phi { %EffectRequirement*, i64 }* [ %t162, %merge13 ], [ %t109, %logical_or_merge_47 ]
  %t166 = phi double [ %t163, %merge13 ], [ %t110, %logical_or_merge_47 ]
  store i8* %t164, i8** %l4
  store { %EffectRequirement*, i64 }* %t165, { %EffectRequirement*, i64 }** %l0
  store double %t166, double* %l1
  %t167 = load i8*, i8** %l4
  %t168 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t169 = load double, double* %l1
  br label %merge9
merge9:
  %t170 = phi i8* [ %t167, %merge11 ], [ %t37, %then6 ]
  %t171 = phi { %EffectRequirement*, i64 }* [ %t168, %merge11 ], [ %t33, %then6 ]
  %t172 = phi double [ %t169, %merge11 ], [ %t34, %then6 ]
  store i8* %t170, i8** %l4
  store { %EffectRequirement*, i64 }* %t171, { %EffectRequirement*, i64 }** %l0
  store double %t172, double* %l1
  %t173 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s174 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t175 = insertvalue %EffectRequirement undef, i8* %s174, 0
  %t176 = load %Token, %Token* %l2
  %t177 = alloca %Token
  store %Token %t176, %Token* %t177
  %t178 = insertvalue %EffectRequirement %t175, %Token* %t177, 1
  %t179 = load i8*, i8** %l4
  %t180 = insertvalue %EffectRequirement %t178, i8* %t179, 2
  %t181 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t173, %EffectRequirement %t180)
  store { %EffectRequirement*, i64 }* %t181, { %EffectRequirement*, i64 }** %l0
  %t182 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t183 = load double, double* %l1
  %t184 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t185 = phi { %EffectRequirement*, i64 }* [ %t182, %merge9 ], [ %t22, %merge5 ]
  %t186 = phi double [ %t183, %merge9 ], [ %t23, %merge5 ]
  %t187 = phi { %EffectRequirement*, i64 }* [ %t184, %merge9 ], [ %t22, %merge5 ]
  store { %EffectRequirement*, i64 }* %t185, { %EffectRequirement*, i64 }** %l0
  store double %t186, double* %l1
  store { %EffectRequirement*, i64 }* %t187, { %EffectRequirement*, i64 }** %l0
  %t188 = load double, double* %l1
  %t189 = sitofp i64 1 to double
  %t190 = fadd double %t188, %t189
  store double %t190, double* %l1
  br label %loop.latch2
loop.latch2:
  %t191 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t192 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t195 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t196 = load double, double* %l1
  %t197 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t197
}

define { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
block.entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 46, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = call { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }* %tokens, i8* %identifier, i8* %t3)
  store { %Token*, i64 }* %t4, { %Token*, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t39 = phi { %EffectRequirement*, i64 }* [ %t7, %block.entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t8, %block.entry ], [ %t38, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t39, { %EffectRequirement*, i64 }** %l1
  store double %t40, double* %l2
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t11 = load { %Token*, i64 }, { %Token*, i64 }* %t10
  %t12 = extractvalue { %Token*, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t9, %t13
  %t15 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t16 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t18 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t19 = insertvalue %EffectRequirement undef, i8* %effect, 0
  %t20 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t21 = load double, double* %l2
  %t22 = call double @llvm.round.f64(double %t21)
  %t23 = fptosi double %t22 to i64
  %t24 = load { %Token*, i64 }, { %Token*, i64 }* %t20
  %t25 = extractvalue { %Token*, i64 } %t24, 0
  %t26 = extractvalue { %Token*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %Token, %Token* %t25, i64 %t23
  %t29 = load %Token, %Token* %t28
  %t30 = alloca %Token
  store %Token %t29, %Token* %t30
  %t31 = insertvalue %EffectRequirement %t19, %Token* %t30, 1
  %t32 = insertvalue %EffectRequirement %t31, i8* %description, 2
  %t33 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t18, %EffectRequirement %t32)
  store { %EffectRequirement*, i64 }* %t33, { %EffectRequirement*, i64 }** %l1
  %t34 = load double, double* %l2
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l2
  br label %loop.latch2
loop.latch2:
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t38 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t41 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t42 = load double, double* %l2
  %t43 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t43
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
  %t35 = phi { %EffectRequirement*, i64 }* [ %t3, %block.entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t4, %block.entry ], [ %t34, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t35, { %EffectRequirement*, i64 }** %l1
  store double %t36, double* %l2
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
  %t26 = alloca %Token
  store %Token %t25, %Token* %t26
  %t27 = insertvalue %EffectRequirement %t15, %Token* %t26, 1
  %t28 = insertvalue %EffectRequirement %t27, i8* %description, 2
  %t29 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t14, %EffectRequirement %t28)
  store { %EffectRequirement*, i64 }* %t29, { %EffectRequirement*, i64 }** %l1
  %t30 = load double, double* %l2
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l2
  br label %loop.latch2
loop.latch2:
  %t33 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t34 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t38 = load double, double* %l2
  %t39 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t39
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
  %t93 = phi { %Token*, i64 }* [ %t13, %block.entry ], [ %t91, %loop.latch2 ]
  %t94 = phi double [ %t14, %block.entry ], [ %t92, %loop.latch2 ]
  store { %Token*, i64 }* %t93, { %Token*, i64 }** %l0
  store double %t94, double* %l1
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
  %t66 = call noalias i8* @malloc(i64 40)
  %t67 = bitcast i8* %t66 to %Token*
  store %Token %t65, %Token* %t67
  %t68 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t69 = ptrtoint [1 x i8*]* %t68 to i64
  %t70 = icmp eq i64 %t69, 0
  %t71 = select i1 %t70, i64 1, i64 %t69
  %t72 = call i8* @malloc(i64 %t71)
  %t73 = bitcast i8* %t72 to i8**
  %t74 = getelementptr i8*, i8** %t73, i64 0
  store i8* %t66, i8** %t74
  %t75 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t76 = ptrtoint { i8**, i64 }* %t75 to i64
  %t77 = call i8* @malloc(i64 %t76)
  %t78 = bitcast i8* %t77 to { i8**, i64 }*
  %t79 = getelementptr { i8**, i64 }, { i8**, i64 }* %t78, i32 0, i32 0
  store i8** %t73, i8*** %t79
  %t80 = getelementptr { i8**, i64 }, { i8**, i64 }* %t78, i32 0, i32 1
  store i64 1, i64* %t80
  %t81 = bitcast { %Token*, i64 }* %t56 to { i8**, i64 }*
  %t82 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t81, { i8**, i64 }* %t78)
  %t83 = bitcast { i8**, i64 }* %t82 to { %Token*, i64 }*
  store { %Token*, i64 }* %t83, { %Token*, i64 }** %l0
  %t84 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t85 = phi { %Token*, i64 }* [ %t84, %then8 ], [ %t53, %logical_and_merge_38 ]
  store { %Token*, i64 }* %t85, { %Token*, i64 }** %l0
  %t86 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t87 = phi { %Token*, i64 }* [ %t86, %merge9 ], [ %t32, %merge5 ]
  store { %Token*, i64 }* %t87, { %Token*, i64 }** %l0
  %t88 = load double, double* %l1
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l1
  br label %loop.latch2
loop.latch2:
  %t91 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t92 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t95 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t96 = load double, double* %l1
  %t97 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t97
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
  %t97 = phi { %Token*, i64 }* [ %t13, %block.entry ], [ %t95, %loop.latch2 ]
  %t98 = phi double [ %t14, %block.entry ], [ %t96, %loop.latch2 ]
  store { %Token*, i64 }* %t97, { %Token*, i64 }** %l0
  store double %t98, double* %l1
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
  %t51 = alloca [2 x i8], align 1
  %t52 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 0
  store i8 40, i8* %t52
  %t53 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 1
  store i8 0, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 0
  %t55 = call i1 @is_symbol_token(%Token %t50, i8* %t54)
  br label %logical_and_right_end_38

logical_and_right_end_38:
  br label %logical_and_merge_38

logical_and_merge_38:
  %t56 = phi i1 [ false, %logical_and_entry_38 ], [ %t55, %logical_and_right_end_38 ]
  %t57 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = load double, double* %l2
  br i1 %t56, label %then8, label %merge9
then8:
  %t60 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t61 = load double, double* %l1
  %t62 = call double @llvm.round.f64(double %t61)
  %t63 = fptosi double %t62 to i64
  %t64 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t65 = extractvalue { %Token*, i64 } %t64, 0
  %t66 = extractvalue { %Token*, i64 } %t64, 1
  %t67 = icmp uge i64 %t63, %t66
  ; bounds check: %t67 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t63, i64 %t66)
  %t68 = getelementptr %Token, %Token* %t65, i64 %t63
  %t69 = load %Token, %Token* %t68
  %t70 = call noalias i8* @malloc(i64 40)
  %t71 = bitcast i8* %t70 to %Token*
  store %Token %t69, %Token* %t71
  %t72 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t73 = ptrtoint [1 x i8*]* %t72 to i64
  %t74 = icmp eq i64 %t73, 0
  %t75 = select i1 %t74, i64 1, i64 %t73
  %t76 = call i8* @malloc(i64 %t75)
  %t77 = bitcast i8* %t76 to i8**
  %t78 = getelementptr i8*, i8** %t77, i64 0
  store i8* %t70, i8** %t78
  %t79 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t80 = ptrtoint { i8**, i64 }* %t79 to i64
  %t81 = call i8* @malloc(i64 %t80)
  %t82 = bitcast i8* %t81 to { i8**, i64 }*
  %t83 = getelementptr { i8**, i64 }, { i8**, i64 }* %t82, i32 0, i32 0
  store i8** %t77, i8*** %t83
  %t84 = getelementptr { i8**, i64 }, { i8**, i64 }* %t82, i32 0, i32 1
  store i64 1, i64* %t84
  %t85 = bitcast { %Token*, i64 }* %t60 to { i8**, i64 }*
  %t86 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t85, { i8**, i64 }* %t82)
  %t87 = bitcast { i8**, i64 }* %t86 to { %Token*, i64 }*
  store { %Token*, i64 }* %t87, { %Token*, i64 }** %l0
  %t88 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t89 = phi { %Token*, i64 }* [ %t88, %then8 ], [ %t57, %logical_and_merge_38 ]
  store { %Token*, i64 }* %t89, { %Token*, i64 }** %l0
  %t90 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t91 = phi { %Token*, i64 }* [ %t90, %merge9 ], [ %t32, %merge5 ]
  store { %Token*, i64 }* %t91, { %Token*, i64 }** %l0
  %t92 = load double, double* %l1
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l1
  br label %loop.latch2
loop.latch2:
  %t95 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t96 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t99 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t100 = load double, double* %l1
  %t101 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t101
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
  %s28 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h715288307, i32 0, i32 0
  %t29 = call i1 @strings_equal(i8* %t27, i8* %s28)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t29, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t30 = extractvalue %Token %token, 0
  %t31 = extractvalue %TokenKind %t30, 0
  %t32 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t33 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t31, 0
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t31, 1
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t31, 2
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t31, 3
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t31, 4
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t31, 5
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t31, 6
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t31, 7
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %s57 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h936649884, i32 0, i32 0
  %t58 = call i1 @strings_equal(i8* %t56, i8* %s57)
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t59 = phi i1 [ true, %logical_or_entry_0 ], [ %t58, %logical_or_right_end_0 ]
  ret i1 %t59
}

define i1 @is_identifier_token(%Token %token, i8* %expected) {
block.entry:
  %l0 = alloca i8*
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %TokenKind %t0, 0
  %t2 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t3 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t4 = icmp eq i32 %t1, 0
  %t5 = select i1 %t4, i8* %t3, i8* %t2
  %t6 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t7 = icmp eq i32 %t1, 1
  %t8 = select i1 %t7, i8* %t6, i8* %t5
  %t9 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t10 = icmp eq i32 %t1, 2
  %t11 = select i1 %t10, i8* %t9, i8* %t8
  %t12 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t1, 3
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t1, 4
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t1, 5
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t1, 6
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t1, 7
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %s27 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1576352120, i32 0, i32 0
  %t28 = call i1 @strings_equal(i8* %t26, i8* %s27)
  br i1 %t28, label %then0, label %merge1
then0:
  %t29 = extractvalue %Token %token, 0
  %t30 = extractvalue %TokenKind %t29, 0
  %t31 = alloca %TokenKind
  store %TokenKind %t29, %TokenKind* %t31
  %t32 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t33 = bitcast [8 x i8]* %t32 to i8*
  %t34 = bitcast i8* %t33 to i8**
  %t35 = load i8*, i8** %t34
  %t36 = icmp eq i32 %t30, 0
  %t37 = select i1 %t36, i8* %t35, i8* null
  %t38 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t39 = bitcast [8 x i8]* %t38 to i8*
  %t40 = bitcast i8* %t39 to i8**
  %t41 = load i8*, i8** %t40
  %t42 = icmp eq i32 %t30, 1
  %t43 = select i1 %t42, i8* %t41, i8* %t37
  %t44 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t45 = bitcast [8 x i8]* %t44 to i8*
  %t46 = bitcast i8* %t45 to i8**
  %t47 = load i8*, i8** %t46
  %t48 = icmp eq i32 %t30, 2
  %t49 = select i1 %t48, i8* %t47, i8* %t43
  %t50 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t51 = bitcast [8 x i8]* %t50 to i8*
  %t52 = bitcast i8* %t51 to i8**
  %t53 = load i8*, i8** %t52
  %t54 = icmp eq i32 %t30, 3
  %t55 = select i1 %t54, i8* %t53, i8* %t49
  %t56 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t57 = bitcast [8 x i8]* %t56 to i8*
  %t58 = bitcast i8* %t57 to i8**
  %t59 = load i8*, i8** %t58
  %t60 = icmp eq i32 %t30, 4
  %t61 = select i1 %t60, i8* %t59, i8* %t55
  store i8* %t61, i8** %l0
  %t62 = load i8*, i8** %l0
  %t63 = call i64 @sailfin_runtime_string_length(i8* %t62)
  %t64 = icmp sgt i64 %t63, 0
  %t65 = load i8*, i8** %l0
  br i1 %t64, label %then2, label %merge3
then2:
  %t66 = load i8*, i8** %l0
  %t67 = call i1 @strings_equal(i8* %t66, i8* %expected)
  ret i1 %t67
merge3:
  br label %merge1
merge1:
  %t68 = extractvalue %Token %token, 1
  %t69 = call i1 @strings_equal(i8* %t68, i8* %expected)
  ret i1 %t69
}

define i1 @is_symbol_token(%Token %token, i8* %expected) {
block.entry:
  %l0 = alloca i8*
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %TokenKind %t0, 0
  %t2 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t3 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t4 = icmp eq i32 %t1, 0
  %t5 = select i1 %t4, i8* %t3, i8* %t2
  %t6 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t7 = icmp eq i32 %t1, 1
  %t8 = select i1 %t7, i8* %t6, i8* %t5
  %t9 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t10 = icmp eq i32 %t1, 2
  %t11 = select i1 %t10, i8* %t9, i8* %t8
  %t12 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t1, 3
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t1, 4
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t1, 5
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t1, 6
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t1, 7
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %s27 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h453982107, i32 0, i32 0
  %t28 = call i1 @strings_equal(i8* %t26, i8* %s27)
  br i1 %t28, label %then0, label %merge1
then0:
  %t29 = extractvalue %Token %token, 0
  %t30 = extractvalue %TokenKind %t29, 0
  %t31 = alloca %TokenKind
  store %TokenKind %t29, %TokenKind* %t31
  %t32 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t33 = bitcast [8 x i8]* %t32 to i8*
  %t34 = bitcast i8* %t33 to i8**
  %t35 = load i8*, i8** %t34
  %t36 = icmp eq i32 %t30, 0
  %t37 = select i1 %t36, i8* %t35, i8* null
  %t38 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t39 = bitcast [8 x i8]* %t38 to i8*
  %t40 = bitcast i8* %t39 to i8**
  %t41 = load i8*, i8** %t40
  %t42 = icmp eq i32 %t30, 1
  %t43 = select i1 %t42, i8* %t41, i8* %t37
  %t44 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t45 = bitcast [8 x i8]* %t44 to i8*
  %t46 = bitcast i8* %t45 to i8**
  %t47 = load i8*, i8** %t46
  %t48 = icmp eq i32 %t30, 2
  %t49 = select i1 %t48, i8* %t47, i8* %t43
  %t50 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t51 = bitcast [8 x i8]* %t50 to i8*
  %t52 = bitcast i8* %t51 to i8**
  %t53 = load i8*, i8** %t52
  %t54 = icmp eq i32 %t30, 3
  %t55 = select i1 %t54, i8* %t53, i8* %t49
  %t56 = getelementptr inbounds %TokenKind, %TokenKind* %t31, i32 0, i32 1
  %t57 = bitcast [8 x i8]* %t56 to i8*
  %t58 = bitcast i8* %t57 to i8**
  %t59 = load i8*, i8** %t58
  %t60 = icmp eq i32 %t30, 4
  %t61 = select i1 %t60, i8* %t59, i8* %t55
  store i8* %t61, i8** %l0
  %t62 = load i8*, i8** %l0
  %t63 = call i64 @sailfin_runtime_string_length(i8* %t62)
  %t64 = icmp sgt i64 %t63, 0
  %t65 = load i8*, i8** %l0
  br i1 %t64, label %then2, label %merge3
then2:
  %t66 = load i8*, i8** %l0
  %t67 = call i1 @strings_equal(i8* %t66, i8* %expected)
  ret i1 %t67
merge3:
  br label %merge1
merge1:
  %t68 = extractvalue %Token %token, 1
  %t69 = call i1 @strings_equal(i8* %t68, i8* %expected)
  ret i1 %t69
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
  %t43 = phi { %EffectViolation*, i64 }* [ %t1, %block.entry ], [ %t41, %loop.latch2 ]
  %t44 = phi double [ %t2, %block.entry ], [ %t42, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t43, { %EffectViolation*, i64 }** %l0
  store double %t44, double* %l1
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
  %t20 = call noalias i8* @malloc(i64 24)
  %t21 = bitcast i8* %t20 to %EffectViolation*
  store %EffectViolation %t19, %EffectViolation* %t21
  %t22 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t23 = ptrtoint [1 x i8*]* %t22 to i64
  %t24 = icmp eq i64 %t23, 0
  %t25 = select i1 %t24, i64 1, i64 %t23
  %t26 = call i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to i8**
  %t28 = getelementptr i8*, i8** %t27, i64 0
  store i8* %t20, i8** %t28
  %t29 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t30 = ptrtoint { i8**, i64 }* %t29 to i64
  %t31 = call i8* @malloc(i64 %t30)
  %t32 = bitcast i8* %t31 to { i8**, i64 }*
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t27, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = bitcast { %EffectViolation*, i64 }* %t10 to { i8**, i64 }*
  %t36 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t35, { i8**, i64 }* %t32)
  %t37 = bitcast { i8**, i64 }* %t36 to { %EffectViolation*, i64 }*
  store { %EffectViolation*, i64 }* %t37, { %EffectViolation*, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch2
loop.latch2:
  %t41 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t42 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t45 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t47
}

define { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %collection, %EffectViolation %item) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %EffectViolation*
  store %EffectViolation %item, %EffectViolation* %t1
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
  %t15 = bitcast { %EffectViolation*, i64 }* %collection to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %EffectViolation*, i64 }*
  ret { %EffectViolation*, i64 }* %t17
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
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %EffectRequirement*
  store %EffectRequirement %item, %EffectRequirement* %t1
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
  %t15 = bitcast { %EffectRequirement*, i64 }* %collection to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %EffectRequirement*, i64 }*
  ret { %EffectRequirement*, i64 }* %t17
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
  %t43 = phi { %EffectRequirement*, i64 }* [ %t1, %block.entry ], [ %t41, %loop.latch2 ]
  %t44 = phi double [ %t2, %block.entry ], [ %t42, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t43, { %EffectRequirement*, i64 }** %l0
  store double %t44, double* %l1
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
  %t20 = call noalias i8* @malloc(i64 24)
  %t21 = bitcast i8* %t20 to %EffectRequirement*
  store %EffectRequirement %t19, %EffectRequirement* %t21
  %t22 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t23 = ptrtoint [1 x i8*]* %t22 to i64
  %t24 = icmp eq i64 %t23, 0
  %t25 = select i1 %t24, i64 1, i64 %t23
  %t26 = call i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to i8**
  %t28 = getelementptr i8*, i8** %t27, i64 0
  store i8* %t20, i8** %t28
  %t29 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t30 = ptrtoint { i8**, i64 }* %t29 to i64
  %t31 = call i8* @malloc(i64 %t30)
  %t32 = bitcast i8* %t31 to { i8**, i64 }*
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t27, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = bitcast { %EffectRequirement*, i64 }* %t10 to { i8**, i64 }*
  %t36 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t35, { i8**, i64 }* %t32)
  %t37 = bitcast { i8**, i64 }* %t36 to { %EffectRequirement*, i64 }*
  store { %EffectRequirement*, i64 }* %t37, { %EffectRequirement*, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch2
loop.latch2:
  %t41 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t42 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t45 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t47
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
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.str.len6.h1128151960 = private unnamed_addr constant [7 x i8] c"prompt\00"
@.str.len15.h1067284810 = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len12.h10983220 = private unnamed_addr constant [13 x i8] c"prompt block\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.enum.Expression.Member.variant = private unnamed_addr constant [7 x i8] c"Member\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len6.h1211862785 = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.enum.Expression.Call.variant = private unnamed_addr constant [5 x i8] c"Call\00"
@.str.len11.h1566780570 = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.str.len13.h1678412334 = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.str.len5.h1445149598 = private unnamed_addr constant [6 x i8] c"Unary\00"
@.str.len6.h512390329 = private unnamed_addr constant [7 x i8] c"Member\00"
@.enum.Expression.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.str.len5.h500835952 = private unnamed_addr constant [6 x i8] c"test \00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.str.len6.h453982107 = private unnamed_addr constant [7 x i8] c"Symbol\00"
@.str.len12.h1170311443 = private unnamed_addr constant [13 x i8] c"logexecution\00"
@.enum.Expression.Unary.variant = private unnamed_addr constant [6 x i8] c"Unary\00"
@.str.len5.h238194529 = private unnamed_addr constant [6 x i8] c"model\00"
@.enum.Expression.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.str.len19.h479148896 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.str.len13.h1925822000 = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.str.len8.h196867800 = private unnamed_addr constant [9 x i8] c"prompt \22\00"
@.str.len5.h1312780988 = private unnamed_addr constant [6 x i8] c"Range\00"
@.enum.Expression.NullLiteral.variant = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.enum.Expression.Raw.variant = private unnamed_addr constant [4 x i8] c"Raw\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.str.len15.h1613933868 = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len5.h667777838 = private unnamed_addr constant [6 x i8] c"Array\00"
@.enum.Expression.Struct.variant = private unnamed_addr constant [7 x i8] c"Struct\00"
@.str.len5.h975618503 = private unnamed_addr constant [6 x i8] c"Index\00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.str.len6.h264904746 = private unnamed_addr constant [7 x i8] c"Struct\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.str.len14.h196308685 = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.str.len12.h84042670 = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.str.len16.h2043328844 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len3.h2089530004 = private unnamed_addr constant [4 x i8] c"Raw\00"
@.str.len6.h1496334143 = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Expression.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.str.len7.h721793546 = private unnamed_addr constant [8 x i8] c"prompt \00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.enum.Expression.Range.variant = private unnamed_addr constant [6 x i8] c"Range\00"
@.str.len6.h826984377 = private unnamed_addr constant [7 x i8] c"Object\00"
@.enum.Expression.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.str.len5.h515589823 = private unnamed_addr constant [6 x i8] c"trace\00"
@.enum.Expression.Object.variant = private unnamed_addr constant [7 x i8] c"Object\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Expression.Index.variant = private unnamed_addr constant [6 x i8] c"Index\00"
@.enum.Expression.Binary.variant = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Expression.Array.variant = private unnamed_addr constant [6 x i8] c"Array\00"
@.str.len15.h889179835 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len19.h868168677 = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.str.len15.h571715647 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.enum.Expression.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.str.len4.h217216103 = private unnamed_addr constant [5 x i8] c"Call\00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Expression.Lambda.variant = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.str.len12.h1147459442 = private unnamed_addr constant [13 x i8] c"logExecution\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len7.h48777630 = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len13.h590768815 = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.str.len9.h1700456022 = private unnamed_addr constant [10 x i8] c"pipeline \00"
@.str.len10.h1576352120 = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.str.len19.h1204027478 = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.str.len5.h512542702 = private unnamed_addr constant [6 x i8] c"tool \00"
