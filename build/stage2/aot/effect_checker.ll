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
  %t155 = bitcast i8* %t154 to { %Decorator*, i64 }**
  %t156 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t155
  %t157 = icmp eq i32 %t150, 3
  %t158 = select i1 %t157, { %Decorator*, i64 }* %t156, { %Decorator*, i64 }* null
  %t159 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t160 = bitcast [88 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 80
  %t162 = bitcast i8* %t161 to { %Decorator*, i64 }**
  %t163 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t162
  %t164 = icmp eq i32 %t150, 4
  %t165 = select i1 %t164, { %Decorator*, i64 }* %t163, { %Decorator*, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t167 = bitcast [88 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 80
  %t169 = bitcast i8* %t168 to { %Decorator*, i64 }**
  %t170 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t169
  %t171 = icmp eq i32 %t150, 5
  %t172 = select i1 %t171, { %Decorator*, i64 }* %t170, { %Decorator*, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t174 = bitcast [56 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 48
  %t176 = bitcast i8* %t175 to { %Decorator*, i64 }**
  %t177 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t176
  %t178 = icmp eq i32 %t150, 6
  %t179 = select i1 %t178, { %Decorator*, i64 }* %t177, { %Decorator*, i64 }* %t172
  %t180 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t181 = bitcast [88 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 80
  %t183 = bitcast i8* %t182 to { %Decorator*, i64 }**
  %t184 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t183
  %t185 = icmp eq i32 %t150, 7
  %t186 = select i1 %t185, { %Decorator*, i64 }* %t184, { %Decorator*, i64 }* %t179
  %t187 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t188 = bitcast [56 x i8]* %t187 to i8*
  %t189 = getelementptr inbounds i8, i8* %t188, i64 48
  %t190 = bitcast i8* %t189 to { %Decorator*, i64 }**
  %t191 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t190
  %t192 = icmp eq i32 %t150, 8
  %t193 = select i1 %t192, { %Decorator*, i64 }* %t191, { %Decorator*, i64 }* %t186
  %t194 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t195 = bitcast [40 x i8]* %t194 to i8*
  %t196 = getelementptr inbounds i8, i8* %t195, i64 32
  %t197 = bitcast i8* %t196 to { %Decorator*, i64 }**
  %t198 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t197
  %t199 = icmp eq i32 %t150, 9
  %t200 = select i1 %t199, { %Decorator*, i64 }* %t198, { %Decorator*, i64 }* %t193
  %t201 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t202 = bitcast [40 x i8]* %t201 to i8*
  %t203 = getelementptr inbounds i8, i8* %t202, i64 32
  %t204 = bitcast i8* %t203 to { %Decorator*, i64 }**
  %t205 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t204
  %t206 = icmp eq i32 %t150, 10
  %t207 = select i1 %t206, { %Decorator*, i64 }* %t205, { %Decorator*, i64 }* %t200
  %t208 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t209 = bitcast [40 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 32
  %t211 = bitcast i8* %t210 to { %Decorator*, i64 }**
  %t212 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t211
  %t213 = icmp eq i32 %t150, 11
  %t214 = select i1 %t213, { %Decorator*, i64 }* %t212, { %Decorator*, i64 }* %t207
  %t215 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t216 = bitcast [120 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 112
  %t218 = bitcast i8* %t217 to { %Decorator*, i64 }**
  %t219 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t218
  %t220 = icmp eq i32 %t150, 12
  %t221 = select i1 %t220, { %Decorator*, i64 }* %t219, { %Decorator*, i64 }* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t223 = bitcast [40 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 32
  %t225 = bitcast i8* %t224 to { %Decorator*, i64 }**
  %t226 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t225
  %t227 = icmp eq i32 %t150, 13
  %t228 = select i1 %t227, { %Decorator*, i64 }* %t226, { %Decorator*, i64 }* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t230 = bitcast [136 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 128
  %t232 = bitcast i8* %t231 to { %Decorator*, i64 }**
  %t233 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t232
  %t234 = icmp eq i32 %t150, 14
  %t235 = select i1 %t234, { %Decorator*, i64 }* %t233, { %Decorator*, i64 }* %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t237 = bitcast [32 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 24
  %t239 = bitcast i8* %t238 to { %Decorator*, i64 }**
  %t240 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t239
  %t241 = icmp eq i32 %t150, 15
  %t242 = select i1 %t241, { %Decorator*, i64 }* %t240, { %Decorator*, i64 }* %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t244 = bitcast [64 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 56
  %t246 = bitcast i8* %t245 to { %Decorator*, i64 }**
  %t247 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t246
  %t248 = icmp eq i32 %t150, 18
  %t249 = select i1 %t248, { %Decorator*, i64 }* %t247, { %Decorator*, i64 }* %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t251 = bitcast [88 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 80
  %t253 = bitcast i8* %t252 to { %Decorator*, i64 }**
  %t254 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t253
  %t255 = icmp eq i32 %t150, 19
  %t256 = select i1 %t255, { %Decorator*, i64 }* %t254, { %Decorator*, i64 }* %t249
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
  %t278 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t92, %Block %t149, { %Decorator*, i64 }* %t256, i8* %t277)
  ret { %EffectViolation*, i64 }* %t278
merge1:
  %t279 = extractvalue %Statement %statement, 0
  %t280 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t281 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t279, 0
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t279, 1
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t279, 2
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t279, 3
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t279, 4
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t279, 5
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t279, 6
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t279, 7
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t279, 8
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t279, 9
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t279, 10
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t279, 11
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t279, 12
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t279, 13
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t279, 14
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t279, 15
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t279, 16
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t279, 17
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t279, 18
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t279, 19
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t279, 20
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t279, 21
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t279, 22
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %s350 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t351 = call i1 @strings_equal(i8* %t349, i8* %s350)
  br i1 %t351, label %then2, label %merge3
then2:
  %t352 = extractvalue %Statement %statement, 0
  %t353 = alloca %Statement
  store %Statement %statement, %Statement* %t353
  %t354 = getelementptr inbounds %Statement, %Statement* %t353, i32 0, i32 1
  %t355 = bitcast [88 x i8]* %t354 to i8*
  %t356 = bitcast i8* %t355 to %FunctionSignature*
  %t357 = load %FunctionSignature, %FunctionSignature* %t356
  %t358 = icmp eq i32 %t352, 4
  %t359 = select i1 %t358, %FunctionSignature %t357, %FunctionSignature zeroinitializer
  %t360 = getelementptr inbounds %Statement, %Statement* %t353, i32 0, i32 1
  %t361 = bitcast [88 x i8]* %t360 to i8*
  %t362 = bitcast i8* %t361 to %FunctionSignature*
  %t363 = load %FunctionSignature, %FunctionSignature* %t362
  %t364 = icmp eq i32 %t352, 5
  %t365 = select i1 %t364, %FunctionSignature %t363, %FunctionSignature %t359
  %t366 = getelementptr inbounds %Statement, %Statement* %t353, i32 0, i32 1
  %t367 = bitcast [88 x i8]* %t366 to i8*
  %t368 = bitcast i8* %t367 to %FunctionSignature*
  %t369 = load %FunctionSignature, %FunctionSignature* %t368
  %t370 = icmp eq i32 %t352, 7
  %t371 = select i1 %t370, %FunctionSignature %t369, %FunctionSignature %t365
  store %FunctionSignature %t371, %FunctionSignature* %l0
  %s372 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1700456022, i32 0, i32 0
  %t373 = load %FunctionSignature, %FunctionSignature* %l0
  %t374 = extractvalue %FunctionSignature %t373, 0
  %t375 = call i8* @sailfin_runtime_string_concat(i8* %s372, i8* %t374)
  store i8* %t375, i8** %l1
  %t376 = load %FunctionSignature, %FunctionSignature* %l0
  %t377 = extractvalue %Statement %statement, 0
  %t378 = alloca %Statement
  store %Statement %statement, %Statement* %t378
  %t379 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t380 = bitcast [88 x i8]* %t379 to i8*
  %t381 = getelementptr inbounds i8, i8* %t380, i64 56
  %t382 = bitcast i8* %t381 to %Block*
  %t383 = load %Block, %Block* %t382
  %t384 = icmp eq i32 %t377, 4
  %t385 = select i1 %t384, %Block %t383, %Block zeroinitializer
  %t386 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t387 = bitcast [88 x i8]* %t386 to i8*
  %t388 = getelementptr inbounds i8, i8* %t387, i64 56
  %t389 = bitcast i8* %t388 to %Block*
  %t390 = load %Block, %Block* %t389
  %t391 = icmp eq i32 %t377, 5
  %t392 = select i1 %t391, %Block %t390, %Block %t385
  %t393 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t394 = bitcast [56 x i8]* %t393 to i8*
  %t395 = getelementptr inbounds i8, i8* %t394, i64 16
  %t396 = bitcast i8* %t395 to %Block*
  %t397 = load %Block, %Block* %t396
  %t398 = icmp eq i32 %t377, 6
  %t399 = select i1 %t398, %Block %t397, %Block %t392
  %t400 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t401 = bitcast [88 x i8]* %t400 to i8*
  %t402 = getelementptr inbounds i8, i8* %t401, i64 56
  %t403 = bitcast i8* %t402 to %Block*
  %t404 = load %Block, %Block* %t403
  %t405 = icmp eq i32 %t377, 7
  %t406 = select i1 %t405, %Block %t404, %Block %t399
  %t407 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t408 = bitcast [120 x i8]* %t407 to i8*
  %t409 = getelementptr inbounds i8, i8* %t408, i64 88
  %t410 = bitcast i8* %t409 to %Block*
  %t411 = load %Block, %Block* %t410
  %t412 = icmp eq i32 %t377, 12
  %t413 = select i1 %t412, %Block %t411, %Block %t406
  %t414 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t415 = bitcast [40 x i8]* %t414 to i8*
  %t416 = getelementptr inbounds i8, i8* %t415, i64 8
  %t417 = bitcast i8* %t416 to %Block*
  %t418 = load %Block, %Block* %t417
  %t419 = icmp eq i32 %t377, 13
  %t420 = select i1 %t419, %Block %t418, %Block %t413
  %t421 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t422 = bitcast [136 x i8]* %t421 to i8*
  %t423 = getelementptr inbounds i8, i8* %t422, i64 104
  %t424 = bitcast i8* %t423 to %Block*
  %t425 = load %Block, %Block* %t424
  %t426 = icmp eq i32 %t377, 14
  %t427 = select i1 %t426, %Block %t425, %Block %t420
  %t428 = getelementptr inbounds %Statement, %Statement* %t378, i32 0, i32 1
  %t429 = bitcast [32 x i8]* %t428 to i8*
  %t430 = bitcast i8* %t429 to %Block*
  %t431 = load %Block, %Block* %t430
  %t432 = icmp eq i32 %t377, 15
  %t433 = select i1 %t432, %Block %t431, %Block %t427
  %t434 = extractvalue %Statement %statement, 0
  %t435 = alloca %Statement
  store %Statement %statement, %Statement* %t435
  %t436 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t437 = bitcast [48 x i8]* %t436 to i8*
  %t438 = getelementptr inbounds i8, i8* %t437, i64 40
  %t439 = bitcast i8* %t438 to { %Decorator*, i64 }**
  %t440 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t439
  %t441 = icmp eq i32 %t434, 3
  %t442 = select i1 %t441, { %Decorator*, i64 }* %t440, { %Decorator*, i64 }* null
  %t443 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t444 = bitcast [88 x i8]* %t443 to i8*
  %t445 = getelementptr inbounds i8, i8* %t444, i64 80
  %t446 = bitcast i8* %t445 to { %Decorator*, i64 }**
  %t447 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t446
  %t448 = icmp eq i32 %t434, 4
  %t449 = select i1 %t448, { %Decorator*, i64 }* %t447, { %Decorator*, i64 }* %t442
  %t450 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t451 = bitcast [88 x i8]* %t450 to i8*
  %t452 = getelementptr inbounds i8, i8* %t451, i64 80
  %t453 = bitcast i8* %t452 to { %Decorator*, i64 }**
  %t454 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t453
  %t455 = icmp eq i32 %t434, 5
  %t456 = select i1 %t455, { %Decorator*, i64 }* %t454, { %Decorator*, i64 }* %t449
  %t457 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t458 = bitcast [56 x i8]* %t457 to i8*
  %t459 = getelementptr inbounds i8, i8* %t458, i64 48
  %t460 = bitcast i8* %t459 to { %Decorator*, i64 }**
  %t461 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t460
  %t462 = icmp eq i32 %t434, 6
  %t463 = select i1 %t462, { %Decorator*, i64 }* %t461, { %Decorator*, i64 }* %t456
  %t464 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t465 = bitcast [88 x i8]* %t464 to i8*
  %t466 = getelementptr inbounds i8, i8* %t465, i64 80
  %t467 = bitcast i8* %t466 to { %Decorator*, i64 }**
  %t468 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t467
  %t469 = icmp eq i32 %t434, 7
  %t470 = select i1 %t469, { %Decorator*, i64 }* %t468, { %Decorator*, i64 }* %t463
  %t471 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t472 = bitcast [56 x i8]* %t471 to i8*
  %t473 = getelementptr inbounds i8, i8* %t472, i64 48
  %t474 = bitcast i8* %t473 to { %Decorator*, i64 }**
  %t475 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t474
  %t476 = icmp eq i32 %t434, 8
  %t477 = select i1 %t476, { %Decorator*, i64 }* %t475, { %Decorator*, i64 }* %t470
  %t478 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t479 = bitcast [40 x i8]* %t478 to i8*
  %t480 = getelementptr inbounds i8, i8* %t479, i64 32
  %t481 = bitcast i8* %t480 to { %Decorator*, i64 }**
  %t482 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t481
  %t483 = icmp eq i32 %t434, 9
  %t484 = select i1 %t483, { %Decorator*, i64 }* %t482, { %Decorator*, i64 }* %t477
  %t485 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t486 = bitcast [40 x i8]* %t485 to i8*
  %t487 = getelementptr inbounds i8, i8* %t486, i64 32
  %t488 = bitcast i8* %t487 to { %Decorator*, i64 }**
  %t489 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t488
  %t490 = icmp eq i32 %t434, 10
  %t491 = select i1 %t490, { %Decorator*, i64 }* %t489, { %Decorator*, i64 }* %t484
  %t492 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t493 = bitcast [40 x i8]* %t492 to i8*
  %t494 = getelementptr inbounds i8, i8* %t493, i64 32
  %t495 = bitcast i8* %t494 to { %Decorator*, i64 }**
  %t496 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t495
  %t497 = icmp eq i32 %t434, 11
  %t498 = select i1 %t497, { %Decorator*, i64 }* %t496, { %Decorator*, i64 }* %t491
  %t499 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t500 = bitcast [120 x i8]* %t499 to i8*
  %t501 = getelementptr inbounds i8, i8* %t500, i64 112
  %t502 = bitcast i8* %t501 to { %Decorator*, i64 }**
  %t503 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t502
  %t504 = icmp eq i32 %t434, 12
  %t505 = select i1 %t504, { %Decorator*, i64 }* %t503, { %Decorator*, i64 }* %t498
  %t506 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t507 = bitcast [40 x i8]* %t506 to i8*
  %t508 = getelementptr inbounds i8, i8* %t507, i64 32
  %t509 = bitcast i8* %t508 to { %Decorator*, i64 }**
  %t510 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t509
  %t511 = icmp eq i32 %t434, 13
  %t512 = select i1 %t511, { %Decorator*, i64 }* %t510, { %Decorator*, i64 }* %t505
  %t513 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t514 = bitcast [136 x i8]* %t513 to i8*
  %t515 = getelementptr inbounds i8, i8* %t514, i64 128
  %t516 = bitcast i8* %t515 to { %Decorator*, i64 }**
  %t517 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t516
  %t518 = icmp eq i32 %t434, 14
  %t519 = select i1 %t518, { %Decorator*, i64 }* %t517, { %Decorator*, i64 }* %t512
  %t520 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t521 = bitcast [32 x i8]* %t520 to i8*
  %t522 = getelementptr inbounds i8, i8* %t521, i64 24
  %t523 = bitcast i8* %t522 to { %Decorator*, i64 }**
  %t524 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t523
  %t525 = icmp eq i32 %t434, 15
  %t526 = select i1 %t525, { %Decorator*, i64 }* %t524, { %Decorator*, i64 }* %t519
  %t527 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t528 = bitcast [64 x i8]* %t527 to i8*
  %t529 = getelementptr inbounds i8, i8* %t528, i64 56
  %t530 = bitcast i8* %t529 to { %Decorator*, i64 }**
  %t531 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t530
  %t532 = icmp eq i32 %t434, 18
  %t533 = select i1 %t532, { %Decorator*, i64 }* %t531, { %Decorator*, i64 }* %t526
  %t534 = getelementptr inbounds %Statement, %Statement* %t435, i32 0, i32 1
  %t535 = bitcast [88 x i8]* %t534 to i8*
  %t536 = getelementptr inbounds i8, i8* %t535, i64 80
  %t537 = bitcast i8* %t536 to { %Decorator*, i64 }**
  %t538 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t537
  %t539 = icmp eq i32 %t434, 19
  %t540 = select i1 %t539, { %Decorator*, i64 }* %t538, { %Decorator*, i64 }* %t533
  %t541 = load i8*, i8** %l1
  %t542 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t376, %Block %t433, { %Decorator*, i64 }* %t540, i8* %t541)
  ret { %EffectViolation*, i64 }* %t542
merge3:
  %t543 = extractvalue %Statement %statement, 0
  %t544 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t545 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t543, 0
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t543, 1
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t543, 2
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t543, 3
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t543, 4
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t543, 5
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t543, 6
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t543, 7
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t543, 8
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t543, 9
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t543, 10
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t543, 11
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t543, 12
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t543, 13
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t543, 14
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t543, 15
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t543, 16
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t543, 17
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t543, 18
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t543, 19
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t543, 20
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t543, 21
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t543, 22
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %s614 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t615 = call i1 @strings_equal(i8* %t613, i8* %s614)
  br i1 %t615, label %then4, label %merge5
then4:
  %t616 = extractvalue %Statement %statement, 0
  %t617 = alloca %Statement
  store %Statement %statement, %Statement* %t617
  %t618 = getelementptr inbounds %Statement, %Statement* %t617, i32 0, i32 1
  %t619 = bitcast [88 x i8]* %t618 to i8*
  %t620 = bitcast i8* %t619 to %FunctionSignature*
  %t621 = load %FunctionSignature, %FunctionSignature* %t620
  %t622 = icmp eq i32 %t616, 4
  %t623 = select i1 %t622, %FunctionSignature %t621, %FunctionSignature zeroinitializer
  %t624 = getelementptr inbounds %Statement, %Statement* %t617, i32 0, i32 1
  %t625 = bitcast [88 x i8]* %t624 to i8*
  %t626 = bitcast i8* %t625 to %FunctionSignature*
  %t627 = load %FunctionSignature, %FunctionSignature* %t626
  %t628 = icmp eq i32 %t616, 5
  %t629 = select i1 %t628, %FunctionSignature %t627, %FunctionSignature %t623
  %t630 = getelementptr inbounds %Statement, %Statement* %t617, i32 0, i32 1
  %t631 = bitcast [88 x i8]* %t630 to i8*
  %t632 = bitcast i8* %t631 to %FunctionSignature*
  %t633 = load %FunctionSignature, %FunctionSignature* %t632
  %t634 = icmp eq i32 %t616, 7
  %t635 = select i1 %t634, %FunctionSignature %t633, %FunctionSignature %t629
  store %FunctionSignature %t635, %FunctionSignature* %l2
  %s636 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h512542702, i32 0, i32 0
  %t637 = load %FunctionSignature, %FunctionSignature* %l2
  %t638 = extractvalue %FunctionSignature %t637, 0
  %t639 = call i8* @sailfin_runtime_string_concat(i8* %s636, i8* %t638)
  store i8* %t639, i8** %l3
  %t640 = load %FunctionSignature, %FunctionSignature* %l2
  %t641 = extractvalue %Statement %statement, 0
  %t642 = alloca %Statement
  store %Statement %statement, %Statement* %t642
  %t643 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t644 = bitcast [88 x i8]* %t643 to i8*
  %t645 = getelementptr inbounds i8, i8* %t644, i64 56
  %t646 = bitcast i8* %t645 to %Block*
  %t647 = load %Block, %Block* %t646
  %t648 = icmp eq i32 %t641, 4
  %t649 = select i1 %t648, %Block %t647, %Block zeroinitializer
  %t650 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t651 = bitcast [88 x i8]* %t650 to i8*
  %t652 = getelementptr inbounds i8, i8* %t651, i64 56
  %t653 = bitcast i8* %t652 to %Block*
  %t654 = load %Block, %Block* %t653
  %t655 = icmp eq i32 %t641, 5
  %t656 = select i1 %t655, %Block %t654, %Block %t649
  %t657 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t658 = bitcast [56 x i8]* %t657 to i8*
  %t659 = getelementptr inbounds i8, i8* %t658, i64 16
  %t660 = bitcast i8* %t659 to %Block*
  %t661 = load %Block, %Block* %t660
  %t662 = icmp eq i32 %t641, 6
  %t663 = select i1 %t662, %Block %t661, %Block %t656
  %t664 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t665 = bitcast [88 x i8]* %t664 to i8*
  %t666 = getelementptr inbounds i8, i8* %t665, i64 56
  %t667 = bitcast i8* %t666 to %Block*
  %t668 = load %Block, %Block* %t667
  %t669 = icmp eq i32 %t641, 7
  %t670 = select i1 %t669, %Block %t668, %Block %t663
  %t671 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t672 = bitcast [120 x i8]* %t671 to i8*
  %t673 = getelementptr inbounds i8, i8* %t672, i64 88
  %t674 = bitcast i8* %t673 to %Block*
  %t675 = load %Block, %Block* %t674
  %t676 = icmp eq i32 %t641, 12
  %t677 = select i1 %t676, %Block %t675, %Block %t670
  %t678 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t679 = bitcast [40 x i8]* %t678 to i8*
  %t680 = getelementptr inbounds i8, i8* %t679, i64 8
  %t681 = bitcast i8* %t680 to %Block*
  %t682 = load %Block, %Block* %t681
  %t683 = icmp eq i32 %t641, 13
  %t684 = select i1 %t683, %Block %t682, %Block %t677
  %t685 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t686 = bitcast [136 x i8]* %t685 to i8*
  %t687 = getelementptr inbounds i8, i8* %t686, i64 104
  %t688 = bitcast i8* %t687 to %Block*
  %t689 = load %Block, %Block* %t688
  %t690 = icmp eq i32 %t641, 14
  %t691 = select i1 %t690, %Block %t689, %Block %t684
  %t692 = getelementptr inbounds %Statement, %Statement* %t642, i32 0, i32 1
  %t693 = bitcast [32 x i8]* %t692 to i8*
  %t694 = bitcast i8* %t693 to %Block*
  %t695 = load %Block, %Block* %t694
  %t696 = icmp eq i32 %t641, 15
  %t697 = select i1 %t696, %Block %t695, %Block %t691
  %t698 = extractvalue %Statement %statement, 0
  %t699 = alloca %Statement
  store %Statement %statement, %Statement* %t699
  %t700 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t701 = bitcast [48 x i8]* %t700 to i8*
  %t702 = getelementptr inbounds i8, i8* %t701, i64 40
  %t703 = bitcast i8* %t702 to { %Decorator*, i64 }**
  %t704 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t703
  %t705 = icmp eq i32 %t698, 3
  %t706 = select i1 %t705, { %Decorator*, i64 }* %t704, { %Decorator*, i64 }* null
  %t707 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t708 = bitcast [88 x i8]* %t707 to i8*
  %t709 = getelementptr inbounds i8, i8* %t708, i64 80
  %t710 = bitcast i8* %t709 to { %Decorator*, i64 }**
  %t711 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t710
  %t712 = icmp eq i32 %t698, 4
  %t713 = select i1 %t712, { %Decorator*, i64 }* %t711, { %Decorator*, i64 }* %t706
  %t714 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t715 = bitcast [88 x i8]* %t714 to i8*
  %t716 = getelementptr inbounds i8, i8* %t715, i64 80
  %t717 = bitcast i8* %t716 to { %Decorator*, i64 }**
  %t718 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t717
  %t719 = icmp eq i32 %t698, 5
  %t720 = select i1 %t719, { %Decorator*, i64 }* %t718, { %Decorator*, i64 }* %t713
  %t721 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t722 = bitcast [56 x i8]* %t721 to i8*
  %t723 = getelementptr inbounds i8, i8* %t722, i64 48
  %t724 = bitcast i8* %t723 to { %Decorator*, i64 }**
  %t725 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t724
  %t726 = icmp eq i32 %t698, 6
  %t727 = select i1 %t726, { %Decorator*, i64 }* %t725, { %Decorator*, i64 }* %t720
  %t728 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t729 = bitcast [88 x i8]* %t728 to i8*
  %t730 = getelementptr inbounds i8, i8* %t729, i64 80
  %t731 = bitcast i8* %t730 to { %Decorator*, i64 }**
  %t732 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t731
  %t733 = icmp eq i32 %t698, 7
  %t734 = select i1 %t733, { %Decorator*, i64 }* %t732, { %Decorator*, i64 }* %t727
  %t735 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t736 = bitcast [56 x i8]* %t735 to i8*
  %t737 = getelementptr inbounds i8, i8* %t736, i64 48
  %t738 = bitcast i8* %t737 to { %Decorator*, i64 }**
  %t739 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t738
  %t740 = icmp eq i32 %t698, 8
  %t741 = select i1 %t740, { %Decorator*, i64 }* %t739, { %Decorator*, i64 }* %t734
  %t742 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t743 = bitcast [40 x i8]* %t742 to i8*
  %t744 = getelementptr inbounds i8, i8* %t743, i64 32
  %t745 = bitcast i8* %t744 to { %Decorator*, i64 }**
  %t746 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t745
  %t747 = icmp eq i32 %t698, 9
  %t748 = select i1 %t747, { %Decorator*, i64 }* %t746, { %Decorator*, i64 }* %t741
  %t749 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t750 = bitcast [40 x i8]* %t749 to i8*
  %t751 = getelementptr inbounds i8, i8* %t750, i64 32
  %t752 = bitcast i8* %t751 to { %Decorator*, i64 }**
  %t753 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t752
  %t754 = icmp eq i32 %t698, 10
  %t755 = select i1 %t754, { %Decorator*, i64 }* %t753, { %Decorator*, i64 }* %t748
  %t756 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t757 = bitcast [40 x i8]* %t756 to i8*
  %t758 = getelementptr inbounds i8, i8* %t757, i64 32
  %t759 = bitcast i8* %t758 to { %Decorator*, i64 }**
  %t760 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t759
  %t761 = icmp eq i32 %t698, 11
  %t762 = select i1 %t761, { %Decorator*, i64 }* %t760, { %Decorator*, i64 }* %t755
  %t763 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t764 = bitcast [120 x i8]* %t763 to i8*
  %t765 = getelementptr inbounds i8, i8* %t764, i64 112
  %t766 = bitcast i8* %t765 to { %Decorator*, i64 }**
  %t767 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t766
  %t768 = icmp eq i32 %t698, 12
  %t769 = select i1 %t768, { %Decorator*, i64 }* %t767, { %Decorator*, i64 }* %t762
  %t770 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t771 = bitcast [40 x i8]* %t770 to i8*
  %t772 = getelementptr inbounds i8, i8* %t771, i64 32
  %t773 = bitcast i8* %t772 to { %Decorator*, i64 }**
  %t774 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t773
  %t775 = icmp eq i32 %t698, 13
  %t776 = select i1 %t775, { %Decorator*, i64 }* %t774, { %Decorator*, i64 }* %t769
  %t777 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t778 = bitcast [136 x i8]* %t777 to i8*
  %t779 = getelementptr inbounds i8, i8* %t778, i64 128
  %t780 = bitcast i8* %t779 to { %Decorator*, i64 }**
  %t781 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t780
  %t782 = icmp eq i32 %t698, 14
  %t783 = select i1 %t782, { %Decorator*, i64 }* %t781, { %Decorator*, i64 }* %t776
  %t784 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t785 = bitcast [32 x i8]* %t784 to i8*
  %t786 = getelementptr inbounds i8, i8* %t785, i64 24
  %t787 = bitcast i8* %t786 to { %Decorator*, i64 }**
  %t788 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t787
  %t789 = icmp eq i32 %t698, 15
  %t790 = select i1 %t789, { %Decorator*, i64 }* %t788, { %Decorator*, i64 }* %t783
  %t791 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t792 = bitcast [64 x i8]* %t791 to i8*
  %t793 = getelementptr inbounds i8, i8* %t792, i64 56
  %t794 = bitcast i8* %t793 to { %Decorator*, i64 }**
  %t795 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t794
  %t796 = icmp eq i32 %t698, 18
  %t797 = select i1 %t796, { %Decorator*, i64 }* %t795, { %Decorator*, i64 }* %t790
  %t798 = getelementptr inbounds %Statement, %Statement* %t699, i32 0, i32 1
  %t799 = bitcast [88 x i8]* %t798 to i8*
  %t800 = getelementptr inbounds i8, i8* %t799, i64 80
  %t801 = bitcast i8* %t800 to { %Decorator*, i64 }**
  %t802 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t801
  %t803 = icmp eq i32 %t698, 19
  %t804 = select i1 %t803, { %Decorator*, i64 }* %t802, { %Decorator*, i64 }* %t797
  %t805 = load i8*, i8** %l3
  %t806 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t640, %Block %t697, { %Decorator*, i64 }* %t804, i8* %t805)
  ret { %EffectViolation*, i64 }* %t806
merge5:
  %t807 = extractvalue %Statement %statement, 0
  %t808 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t809 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t807, 0
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t807, 1
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t807, 2
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t807, 3
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t807, 4
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t807, 5
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t807, 6
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t807, 7
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t807, 8
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t807, 9
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t807, 10
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t807, 11
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t807, 12
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t807, 13
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t807, 14
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t807, 15
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t807, 16
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t807, 17
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t807, 18
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t807, 19
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t807, 20
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t807, 21
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t807, 22
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %s878 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t879 = call i1 @strings_equal(i8* %t877, i8* %s878)
  br i1 %t879, label %then6, label %merge7
then6:
  %t880 = extractvalue %Statement %statement, 0
  %t881 = alloca %Statement
  store %Statement %statement, %Statement* %t881
  %t882 = getelementptr inbounds %Statement, %Statement* %t881, i32 0, i32 1
  %t883 = bitcast [48 x i8]* %t882 to i8*
  %t884 = bitcast i8* %t883 to i8**
  %t885 = load i8*, i8** %t884
  %t886 = icmp eq i32 %t880, 2
  %t887 = select i1 %t886, i8* %t885, i8* null
  %t888 = getelementptr inbounds %Statement, %Statement* %t881, i32 0, i32 1
  %t889 = bitcast [48 x i8]* %t888 to i8*
  %t890 = bitcast i8* %t889 to i8**
  %t891 = load i8*, i8** %t890
  %t892 = icmp eq i32 %t880, 3
  %t893 = select i1 %t892, i8* %t891, i8* %t887
  %t894 = getelementptr inbounds %Statement, %Statement* %t881, i32 0, i32 1
  %t895 = bitcast [56 x i8]* %t894 to i8*
  %t896 = bitcast i8* %t895 to i8**
  %t897 = load i8*, i8** %t896
  %t898 = icmp eq i32 %t880, 6
  %t899 = select i1 %t898, i8* %t897, i8* %t893
  %t900 = getelementptr inbounds %Statement, %Statement* %t881, i32 0, i32 1
  %t901 = bitcast [56 x i8]* %t900 to i8*
  %t902 = bitcast i8* %t901 to i8**
  %t903 = load i8*, i8** %t902
  %t904 = icmp eq i32 %t880, 8
  %t905 = select i1 %t904, i8* %t903, i8* %t899
  %t906 = getelementptr inbounds %Statement, %Statement* %t881, i32 0, i32 1
  %t907 = bitcast [40 x i8]* %t906 to i8*
  %t908 = bitcast i8* %t907 to i8**
  %t909 = load i8*, i8** %t908
  %t910 = icmp eq i32 %t880, 9
  %t911 = select i1 %t910, i8* %t909, i8* %t905
  %t912 = getelementptr inbounds %Statement, %Statement* %t881, i32 0, i32 1
  %t913 = bitcast [40 x i8]* %t912 to i8*
  %t914 = bitcast i8* %t913 to i8**
  %t915 = load i8*, i8** %t914
  %t916 = icmp eq i32 %t880, 10
  %t917 = select i1 %t916, i8* %t915, i8* %t911
  %t918 = getelementptr inbounds %Statement, %Statement* %t881, i32 0, i32 1
  %t919 = bitcast [40 x i8]* %t918 to i8*
  %t920 = bitcast i8* %t919 to i8**
  %t921 = load i8*, i8** %t920
  %t922 = icmp eq i32 %t880, 11
  %t923 = select i1 %t922, i8* %t921, i8* %t917
  %t924 = insertvalue %FunctionSignature undef, i8* %t923, 0
  %t925 = insertvalue %FunctionSignature %t924, i1 0, 1
  %t926 = getelementptr [0 x %Parameter], [0 x %Parameter]* null, i32 1
  %t927 = ptrtoint [0 x %Parameter]* %t926 to i64
  %t928 = icmp eq i64 %t927, 0
  %t929 = select i1 %t928, i64 1, i64 %t927
  %t930 = call i8* @malloc(i64 %t929)
  %t931 = bitcast i8* %t930 to %Parameter*
  %t932 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* null, i32 1
  %t933 = ptrtoint { %Parameter*, i64 }* %t932 to i64
  %t934 = call i8* @malloc(i64 %t933)
  %t935 = bitcast i8* %t934 to { %Parameter*, i64 }*
  %t936 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t935, i32 0, i32 0
  store %Parameter* %t931, %Parameter** %t936
  %t937 = getelementptr { %Parameter*, i64 }, { %Parameter*, i64 }* %t935, i32 0, i32 1
  store i64 0, i64* %t937
  %t938 = insertvalue %FunctionSignature %t925, { %Parameter*, i64 }* %t935, 2
  %t939 = bitcast i8* null to %TypeAnnotation*
  %t940 = insertvalue %FunctionSignature %t938, %TypeAnnotation* %t939, 3
  %t941 = extractvalue %Statement %statement, 0
  %t942 = alloca %Statement
  store %Statement %statement, %Statement* %t942
  %t943 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t944 = bitcast [48 x i8]* %t943 to i8*
  %t945 = getelementptr inbounds i8, i8* %t944, i64 32
  %t946 = bitcast i8* %t945 to { i8**, i64 }**
  %t947 = load { i8**, i64 }*, { i8**, i64 }** %t946
  %t948 = icmp eq i32 %t941, 3
  %t949 = select i1 %t948, { i8**, i64 }* %t947, { i8**, i64 }* null
  %t950 = getelementptr inbounds %Statement, %Statement* %t942, i32 0, i32 1
  %t951 = bitcast [56 x i8]* %t950 to i8*
  %t952 = getelementptr inbounds i8, i8* %t951, i64 40
  %t953 = bitcast i8* %t952 to { i8**, i64 }**
  %t954 = load { i8**, i64 }*, { i8**, i64 }** %t953
  %t955 = icmp eq i32 %t941, 6
  %t956 = select i1 %t955, { i8**, i64 }* %t954, { i8**, i64 }* %t949
  %t957 = insertvalue %FunctionSignature %t940, { i8**, i64 }* %t956, 4
  %t958 = getelementptr [0 x %TypeParameter], [0 x %TypeParameter]* null, i32 1
  %t959 = ptrtoint [0 x %TypeParameter]* %t958 to i64
  %t960 = icmp eq i64 %t959, 0
  %t961 = select i1 %t960, i64 1, i64 %t959
  %t962 = call i8* @malloc(i64 %t961)
  %t963 = bitcast i8* %t962 to %TypeParameter*
  %t964 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* null, i32 1
  %t965 = ptrtoint { %TypeParameter*, i64 }* %t964 to i64
  %t966 = call i8* @malloc(i64 %t965)
  %t967 = bitcast i8* %t966 to { %TypeParameter*, i64 }*
  %t968 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t967, i32 0, i32 0
  store %TypeParameter* %t963, %TypeParameter** %t968
  %t969 = getelementptr { %TypeParameter*, i64 }, { %TypeParameter*, i64 }* %t967, i32 0, i32 1
  store i64 0, i64* %t969
  %t970 = insertvalue %FunctionSignature %t957, { %TypeParameter*, i64 }* %t967, 5
  %t971 = bitcast i8* null to %SourceSpan*
  %t972 = insertvalue %FunctionSignature %t970, %SourceSpan* %t971, 6
  store %FunctionSignature %t972, %FunctionSignature* %l4
  %s973 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h500835952, i32 0, i32 0
  %t974 = extractvalue %Statement %statement, 0
  %t975 = alloca %Statement
  store %Statement %statement, %Statement* %t975
  %t976 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t977 = bitcast [48 x i8]* %t976 to i8*
  %t978 = bitcast i8* %t977 to i8**
  %t979 = load i8*, i8** %t978
  %t980 = icmp eq i32 %t974, 2
  %t981 = select i1 %t980, i8* %t979, i8* null
  %t982 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t983 = bitcast [48 x i8]* %t982 to i8*
  %t984 = bitcast i8* %t983 to i8**
  %t985 = load i8*, i8** %t984
  %t986 = icmp eq i32 %t974, 3
  %t987 = select i1 %t986, i8* %t985, i8* %t981
  %t988 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t989 = bitcast [56 x i8]* %t988 to i8*
  %t990 = bitcast i8* %t989 to i8**
  %t991 = load i8*, i8** %t990
  %t992 = icmp eq i32 %t974, 6
  %t993 = select i1 %t992, i8* %t991, i8* %t987
  %t994 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t995 = bitcast [56 x i8]* %t994 to i8*
  %t996 = bitcast i8* %t995 to i8**
  %t997 = load i8*, i8** %t996
  %t998 = icmp eq i32 %t974, 8
  %t999 = select i1 %t998, i8* %t997, i8* %t993
  %t1000 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t1001 = bitcast [40 x i8]* %t1000 to i8*
  %t1002 = bitcast i8* %t1001 to i8**
  %t1003 = load i8*, i8** %t1002
  %t1004 = icmp eq i32 %t974, 9
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t999
  %t1006 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t1007 = bitcast [40 x i8]* %t1006 to i8*
  %t1008 = bitcast i8* %t1007 to i8**
  %t1009 = load i8*, i8** %t1008
  %t1010 = icmp eq i32 %t974, 10
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1005
  %t1012 = getelementptr inbounds %Statement, %Statement* %t975, i32 0, i32 1
  %t1013 = bitcast [40 x i8]* %t1012 to i8*
  %t1014 = bitcast i8* %t1013 to i8**
  %t1015 = load i8*, i8** %t1014
  %t1016 = icmp eq i32 %t974, 11
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1011
  %t1018 = call i8* @sailfin_runtime_string_concat(i8* %s973, i8* %t1017)
  store i8* %t1018, i8** %l5
  %t1019 = load %FunctionSignature, %FunctionSignature* %l4
  %t1020 = extractvalue %Statement %statement, 0
  %t1021 = alloca %Statement
  store %Statement %statement, %Statement* %t1021
  %t1022 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1023 = bitcast [88 x i8]* %t1022 to i8*
  %t1024 = getelementptr inbounds i8, i8* %t1023, i64 56
  %t1025 = bitcast i8* %t1024 to %Block*
  %t1026 = load %Block, %Block* %t1025
  %t1027 = icmp eq i32 %t1020, 4
  %t1028 = select i1 %t1027, %Block %t1026, %Block zeroinitializer
  %t1029 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1030 = bitcast [88 x i8]* %t1029 to i8*
  %t1031 = getelementptr inbounds i8, i8* %t1030, i64 56
  %t1032 = bitcast i8* %t1031 to %Block*
  %t1033 = load %Block, %Block* %t1032
  %t1034 = icmp eq i32 %t1020, 5
  %t1035 = select i1 %t1034, %Block %t1033, %Block %t1028
  %t1036 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1037 = bitcast [56 x i8]* %t1036 to i8*
  %t1038 = getelementptr inbounds i8, i8* %t1037, i64 16
  %t1039 = bitcast i8* %t1038 to %Block*
  %t1040 = load %Block, %Block* %t1039
  %t1041 = icmp eq i32 %t1020, 6
  %t1042 = select i1 %t1041, %Block %t1040, %Block %t1035
  %t1043 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1044 = bitcast [88 x i8]* %t1043 to i8*
  %t1045 = getelementptr inbounds i8, i8* %t1044, i64 56
  %t1046 = bitcast i8* %t1045 to %Block*
  %t1047 = load %Block, %Block* %t1046
  %t1048 = icmp eq i32 %t1020, 7
  %t1049 = select i1 %t1048, %Block %t1047, %Block %t1042
  %t1050 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1051 = bitcast [120 x i8]* %t1050 to i8*
  %t1052 = getelementptr inbounds i8, i8* %t1051, i64 88
  %t1053 = bitcast i8* %t1052 to %Block*
  %t1054 = load %Block, %Block* %t1053
  %t1055 = icmp eq i32 %t1020, 12
  %t1056 = select i1 %t1055, %Block %t1054, %Block %t1049
  %t1057 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1058 = bitcast [40 x i8]* %t1057 to i8*
  %t1059 = getelementptr inbounds i8, i8* %t1058, i64 8
  %t1060 = bitcast i8* %t1059 to %Block*
  %t1061 = load %Block, %Block* %t1060
  %t1062 = icmp eq i32 %t1020, 13
  %t1063 = select i1 %t1062, %Block %t1061, %Block %t1056
  %t1064 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1065 = bitcast [136 x i8]* %t1064 to i8*
  %t1066 = getelementptr inbounds i8, i8* %t1065, i64 104
  %t1067 = bitcast i8* %t1066 to %Block*
  %t1068 = load %Block, %Block* %t1067
  %t1069 = icmp eq i32 %t1020, 14
  %t1070 = select i1 %t1069, %Block %t1068, %Block %t1063
  %t1071 = getelementptr inbounds %Statement, %Statement* %t1021, i32 0, i32 1
  %t1072 = bitcast [32 x i8]* %t1071 to i8*
  %t1073 = bitcast i8* %t1072 to %Block*
  %t1074 = load %Block, %Block* %t1073
  %t1075 = icmp eq i32 %t1020, 15
  %t1076 = select i1 %t1075, %Block %t1074, %Block %t1070
  %t1077 = extractvalue %Statement %statement, 0
  %t1078 = alloca %Statement
  store %Statement %statement, %Statement* %t1078
  %t1079 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1080 = bitcast [48 x i8]* %t1079 to i8*
  %t1081 = getelementptr inbounds i8, i8* %t1080, i64 40
  %t1082 = bitcast i8* %t1081 to { %Decorator*, i64 }**
  %t1083 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1082
  %t1084 = icmp eq i32 %t1077, 3
  %t1085 = select i1 %t1084, { %Decorator*, i64 }* %t1083, { %Decorator*, i64 }* null
  %t1086 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1087 = bitcast [88 x i8]* %t1086 to i8*
  %t1088 = getelementptr inbounds i8, i8* %t1087, i64 80
  %t1089 = bitcast i8* %t1088 to { %Decorator*, i64 }**
  %t1090 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1089
  %t1091 = icmp eq i32 %t1077, 4
  %t1092 = select i1 %t1091, { %Decorator*, i64 }* %t1090, { %Decorator*, i64 }* %t1085
  %t1093 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1094 = bitcast [88 x i8]* %t1093 to i8*
  %t1095 = getelementptr inbounds i8, i8* %t1094, i64 80
  %t1096 = bitcast i8* %t1095 to { %Decorator*, i64 }**
  %t1097 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1096
  %t1098 = icmp eq i32 %t1077, 5
  %t1099 = select i1 %t1098, { %Decorator*, i64 }* %t1097, { %Decorator*, i64 }* %t1092
  %t1100 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1101 = bitcast [56 x i8]* %t1100 to i8*
  %t1102 = getelementptr inbounds i8, i8* %t1101, i64 48
  %t1103 = bitcast i8* %t1102 to { %Decorator*, i64 }**
  %t1104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1103
  %t1105 = icmp eq i32 %t1077, 6
  %t1106 = select i1 %t1105, { %Decorator*, i64 }* %t1104, { %Decorator*, i64 }* %t1099
  %t1107 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1108 = bitcast [88 x i8]* %t1107 to i8*
  %t1109 = getelementptr inbounds i8, i8* %t1108, i64 80
  %t1110 = bitcast i8* %t1109 to { %Decorator*, i64 }**
  %t1111 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1110
  %t1112 = icmp eq i32 %t1077, 7
  %t1113 = select i1 %t1112, { %Decorator*, i64 }* %t1111, { %Decorator*, i64 }* %t1106
  %t1114 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1115 = bitcast [56 x i8]* %t1114 to i8*
  %t1116 = getelementptr inbounds i8, i8* %t1115, i64 48
  %t1117 = bitcast i8* %t1116 to { %Decorator*, i64 }**
  %t1118 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1117
  %t1119 = icmp eq i32 %t1077, 8
  %t1120 = select i1 %t1119, { %Decorator*, i64 }* %t1118, { %Decorator*, i64 }* %t1113
  %t1121 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1122 = bitcast [40 x i8]* %t1121 to i8*
  %t1123 = getelementptr inbounds i8, i8* %t1122, i64 32
  %t1124 = bitcast i8* %t1123 to { %Decorator*, i64 }**
  %t1125 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1124
  %t1126 = icmp eq i32 %t1077, 9
  %t1127 = select i1 %t1126, { %Decorator*, i64 }* %t1125, { %Decorator*, i64 }* %t1120
  %t1128 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1129 = bitcast [40 x i8]* %t1128 to i8*
  %t1130 = getelementptr inbounds i8, i8* %t1129, i64 32
  %t1131 = bitcast i8* %t1130 to { %Decorator*, i64 }**
  %t1132 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1131
  %t1133 = icmp eq i32 %t1077, 10
  %t1134 = select i1 %t1133, { %Decorator*, i64 }* %t1132, { %Decorator*, i64 }* %t1127
  %t1135 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1136 = bitcast [40 x i8]* %t1135 to i8*
  %t1137 = getelementptr inbounds i8, i8* %t1136, i64 32
  %t1138 = bitcast i8* %t1137 to { %Decorator*, i64 }**
  %t1139 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1138
  %t1140 = icmp eq i32 %t1077, 11
  %t1141 = select i1 %t1140, { %Decorator*, i64 }* %t1139, { %Decorator*, i64 }* %t1134
  %t1142 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1143 = bitcast [120 x i8]* %t1142 to i8*
  %t1144 = getelementptr inbounds i8, i8* %t1143, i64 112
  %t1145 = bitcast i8* %t1144 to { %Decorator*, i64 }**
  %t1146 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1145
  %t1147 = icmp eq i32 %t1077, 12
  %t1148 = select i1 %t1147, { %Decorator*, i64 }* %t1146, { %Decorator*, i64 }* %t1141
  %t1149 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1150 = bitcast [40 x i8]* %t1149 to i8*
  %t1151 = getelementptr inbounds i8, i8* %t1150, i64 32
  %t1152 = bitcast i8* %t1151 to { %Decorator*, i64 }**
  %t1153 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1152
  %t1154 = icmp eq i32 %t1077, 13
  %t1155 = select i1 %t1154, { %Decorator*, i64 }* %t1153, { %Decorator*, i64 }* %t1148
  %t1156 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1157 = bitcast [136 x i8]* %t1156 to i8*
  %t1158 = getelementptr inbounds i8, i8* %t1157, i64 128
  %t1159 = bitcast i8* %t1158 to { %Decorator*, i64 }**
  %t1160 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1159
  %t1161 = icmp eq i32 %t1077, 14
  %t1162 = select i1 %t1161, { %Decorator*, i64 }* %t1160, { %Decorator*, i64 }* %t1155
  %t1163 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1164 = bitcast [32 x i8]* %t1163 to i8*
  %t1165 = getelementptr inbounds i8, i8* %t1164, i64 24
  %t1166 = bitcast i8* %t1165 to { %Decorator*, i64 }**
  %t1167 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1166
  %t1168 = icmp eq i32 %t1077, 15
  %t1169 = select i1 %t1168, { %Decorator*, i64 }* %t1167, { %Decorator*, i64 }* %t1162
  %t1170 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1171 = bitcast [64 x i8]* %t1170 to i8*
  %t1172 = getelementptr inbounds i8, i8* %t1171, i64 56
  %t1173 = bitcast i8* %t1172 to { %Decorator*, i64 }**
  %t1174 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1173
  %t1175 = icmp eq i32 %t1077, 18
  %t1176 = select i1 %t1175, { %Decorator*, i64 }* %t1174, { %Decorator*, i64 }* %t1169
  %t1177 = getelementptr inbounds %Statement, %Statement* %t1078, i32 0, i32 1
  %t1178 = bitcast [88 x i8]* %t1177 to i8*
  %t1179 = getelementptr inbounds i8, i8* %t1178, i64 80
  %t1180 = bitcast i8* %t1179 to { %Decorator*, i64 }**
  %t1181 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %t1180
  %t1182 = icmp eq i32 %t1077, 19
  %t1183 = select i1 %t1182, { %Decorator*, i64 }* %t1181, { %Decorator*, i64 }* %t1176
  %t1184 = load i8*, i8** %l5
  %t1185 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1019, %Block %t1076, { %Decorator*, i64 }* %t1183, i8* %t1184)
  ret { %EffectViolation*, i64 }* %t1185
merge7:
  %t1186 = extractvalue %Statement %statement, 0
  %t1187 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1188 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1186, 0
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1186, 1
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1186, 2
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1186, 3
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1186, 4
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1186, 5
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1186, 6
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1186, 7
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1186, 8
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1186, 9
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1186, 10
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1186, 11
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1186, 12
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1186, 13
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1186, 14
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1186, 15
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1186, 16
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1186, 17
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1186, 18
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %t1245 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1186, 19
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1186, 20
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %t1251 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1186, 21
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %t1254 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1255 = icmp eq i32 %t1186, 22
  %t1256 = select i1 %t1255, i8* %t1254, i8* %t1253
  %s1257 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t1258 = call i1 @strings_equal(i8* %t1256, i8* %s1257)
  br i1 %t1258, label %then8, label %merge9
then8:
  %t1259 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1260 = ptrtoint [0 x %EffectViolation]* %t1259 to i64
  %t1261 = icmp eq i64 %t1260, 0
  %t1262 = select i1 %t1261, i64 1, i64 %t1260
  %t1263 = call i8* @malloc(i64 %t1262)
  %t1264 = bitcast i8* %t1263 to %EffectViolation*
  %t1265 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t1266 = ptrtoint { %EffectViolation*, i64 }* %t1265 to i64
  %t1267 = call i8* @malloc(i64 %t1266)
  %t1268 = bitcast i8* %t1267 to { %EffectViolation*, i64 }*
  %t1269 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1268, i32 0, i32 0
  store %EffectViolation* %t1264, %EffectViolation** %t1269
  %t1270 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1268, i32 0, i32 1
  store i64 0, i64* %t1270
  store { %EffectViolation*, i64 }* %t1268, { %EffectViolation*, i64 }** %l6
  %t1271 = sitofp i64 0 to double
  store double %t1271, double* %l7
  %t1272 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1273 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1375 = phi { %EffectViolation*, i64 }* [ %t1272, %then8 ], [ %t1373, %loop.latch12 ]
  %t1376 = phi double [ %t1273, %then8 ], [ %t1374, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1375, { %EffectViolation*, i64 }** %l6
  store double %t1376, double* %l7
  br label %loop.body11
loop.body11:
  %t1274 = load double, double* %l7
  %t1275 = extractvalue %Statement %statement, 0
  %t1276 = alloca %Statement
  store %Statement %statement, %Statement* %t1276
  %t1277 = getelementptr inbounds %Statement, %Statement* %t1276, i32 0, i32 1
  %t1278 = bitcast [56 x i8]* %t1277 to i8*
  %t1279 = getelementptr inbounds i8, i8* %t1278, i64 40
  %t1280 = bitcast i8* %t1279 to { %MethodDeclaration*, i64 }**
  %t1281 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1280
  %t1282 = icmp eq i32 %t1275, 8
  %t1283 = select i1 %t1282, { %MethodDeclaration*, i64 }* %t1281, { %MethodDeclaration*, i64 }* null
  %t1284 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1283
  %t1285 = extractvalue { %MethodDeclaration*, i64 } %t1284, 1
  %t1286 = sitofp i64 %t1285 to double
  %t1287 = fcmp oge double %t1274, %t1286
  %t1288 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1289 = load double, double* %l7
  br i1 %t1287, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1290 = extractvalue %Statement %statement, 0
  %t1291 = alloca %Statement
  store %Statement %statement, %Statement* %t1291
  %t1292 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1293 = bitcast [56 x i8]* %t1292 to i8*
  %t1294 = getelementptr inbounds i8, i8* %t1293, i64 40
  %t1295 = bitcast i8* %t1294 to { %MethodDeclaration*, i64 }**
  %t1296 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1295
  %t1297 = icmp eq i32 %t1290, 8
  %t1298 = select i1 %t1297, { %MethodDeclaration*, i64 }* %t1296, { %MethodDeclaration*, i64 }* null
  %t1299 = load double, double* %l7
  %t1300 = call double @llvm.round.f64(double %t1299)
  %t1301 = fptosi double %t1300 to i64
  %t1302 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1298
  %t1303 = extractvalue { %MethodDeclaration*, i64 } %t1302, 0
  %t1304 = extractvalue { %MethodDeclaration*, i64 } %t1302, 1
  %t1305 = icmp uge i64 %t1301, %t1304
  ; bounds check: %t1305 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1301, i64 %t1304)
  %t1306 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1303, i64 %t1301
  %t1307 = load %MethodDeclaration, %MethodDeclaration* %t1306
  store %MethodDeclaration %t1307, %MethodDeclaration* %l8
  %t1308 = extractvalue %Statement %statement, 0
  %t1309 = alloca %Statement
  store %Statement %statement, %Statement* %t1309
  %t1310 = getelementptr inbounds %Statement, %Statement* %t1309, i32 0, i32 1
  %t1311 = bitcast [48 x i8]* %t1310 to i8*
  %t1312 = bitcast i8* %t1311 to i8**
  %t1313 = load i8*, i8** %t1312
  %t1314 = icmp eq i32 %t1308, 2
  %t1315 = select i1 %t1314, i8* %t1313, i8* null
  %t1316 = getelementptr inbounds %Statement, %Statement* %t1309, i32 0, i32 1
  %t1317 = bitcast [48 x i8]* %t1316 to i8*
  %t1318 = bitcast i8* %t1317 to i8**
  %t1319 = load i8*, i8** %t1318
  %t1320 = icmp eq i32 %t1308, 3
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1315
  %t1322 = getelementptr inbounds %Statement, %Statement* %t1309, i32 0, i32 1
  %t1323 = bitcast [56 x i8]* %t1322 to i8*
  %t1324 = bitcast i8* %t1323 to i8**
  %t1325 = load i8*, i8** %t1324
  %t1326 = icmp eq i32 %t1308, 6
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1321
  %t1328 = getelementptr inbounds %Statement, %Statement* %t1309, i32 0, i32 1
  %t1329 = bitcast [56 x i8]* %t1328 to i8*
  %t1330 = bitcast i8* %t1329 to i8**
  %t1331 = load i8*, i8** %t1330
  %t1332 = icmp eq i32 %t1308, 8
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1327
  %t1334 = getelementptr inbounds %Statement, %Statement* %t1309, i32 0, i32 1
  %t1335 = bitcast [40 x i8]* %t1334 to i8*
  %t1336 = bitcast i8* %t1335 to i8**
  %t1337 = load i8*, i8** %t1336
  %t1338 = icmp eq i32 %t1308, 9
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1333
  %t1340 = getelementptr inbounds %Statement, %Statement* %t1309, i32 0, i32 1
  %t1341 = bitcast [40 x i8]* %t1340 to i8*
  %t1342 = bitcast i8* %t1341 to i8**
  %t1343 = load i8*, i8** %t1342
  %t1344 = icmp eq i32 %t1308, 10
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1339
  %t1346 = getelementptr inbounds %Statement, %Statement* %t1309, i32 0, i32 1
  %t1347 = bitcast [40 x i8]* %t1346 to i8*
  %t1348 = bitcast i8* %t1347 to i8**
  %t1349 = load i8*, i8** %t1348
  %t1350 = icmp eq i32 %t1308, 11
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1345
  %t1352 = add i64 0, 2
  %t1353 = call i8* @malloc(i64 %t1352)
  store i8 46, i8* %t1353
  %t1354 = getelementptr i8, i8* %t1353, i64 1
  store i8 0, i8* %t1354
  call void @sailfin_runtime_mark_persistent(i8* %t1353)
  %t1355 = call i8* @sailfin_runtime_string_concat(i8* %t1351, i8* %t1353)
  %t1356 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1357 = extractvalue %MethodDeclaration %t1356, 0
  %t1358 = extractvalue %FunctionSignature %t1357, 0
  %t1359 = call i8* @sailfin_runtime_string_concat(i8* %t1355, i8* %t1358)
  store i8* %t1359, i8** %l9
  %t1360 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1361 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1362 = extractvalue %MethodDeclaration %t1361, 0
  %t1363 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1364 = extractvalue %MethodDeclaration %t1363, 1
  %t1365 = load %MethodDeclaration, %MethodDeclaration* %l8
  %t1366 = extractvalue %MethodDeclaration %t1365, 2
  %t1367 = load i8*, i8** %l9
  %t1368 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1362, %Block %t1364, { %Decorator*, i64 }* %t1366, i8* %t1367)
  %t1369 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t1360, { %EffectViolation*, i64 }* %t1368)
  store { %EffectViolation*, i64 }* %t1369, { %EffectViolation*, i64 }** %l6
  %t1370 = load double, double* %l7
  %t1371 = sitofp i64 1 to double
  %t1372 = fadd double %t1370, %t1371
  store double %t1372, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1373 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1374 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1377 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1378 = load double, double* %l7
  %t1379 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1379
merge9:
  %t1380 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1381 = ptrtoint [0 x %EffectViolation]* %t1380 to i64
  %t1382 = icmp eq i64 %t1381, 0
  %t1383 = select i1 %t1382, i64 1, i64 %t1381
  %t1384 = call i8* @malloc(i64 %t1383)
  %t1385 = bitcast i8* %t1384 to %EffectViolation*
  %t1386 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t1387 = ptrtoint { %EffectViolation*, i64 }* %t1386 to i64
  %t1388 = call i8* @malloc(i64 %t1387)
  %t1389 = bitcast i8* %t1388 to { %EffectViolation*, i64 }*
  %t1390 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1389, i32 0, i32 0
  store %EffectViolation* %t1385, %EffectViolation** %t1390
  %t1391 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1389, i32 0, i32 1
  store i64 0, i64* %t1391
  ret { %EffectViolation*, i64 }* %t1389
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
  %t200 = call i1 @contains_effect__effect_checker({ i8**, i64 }* %t198, i8* %t199)
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
  %t292 = insertvalue %EffectViolation %t290, { %EffectRequirement*, i64 }* %t291, 2
  %t293 = call { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %t287, %EffectViolation %t292)
  store { %EffectViolation*, i64 }* %t293, { %EffectViolation*, i64 }** %l12
  %t294 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t294
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
  %t143 = getelementptr %Token, %Token* null, i32 1
  %t144 = ptrtoint %Token* %t143 to i64
  %t145 = call noalias i8* @malloc(i64 %t144)
  %t146 = bitcast i8* %t145 to %Token*
  store %Token %t142, %Token* %t146
  call void @sailfin_runtime_mark_persistent(i8* %t145)
  %t147 = insertvalue %EffectRequirement %t133, %Token* %t146, 1
  %s148 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h196867800, i32 0, i32 0
  %t149 = extractvalue %Statement %statement, 0
  %t150 = alloca %Statement
  store %Statement %statement, %Statement* %t150
  %t151 = getelementptr inbounds %Statement, %Statement* %t150, i32 0, i32 1
  %t152 = bitcast [120 x i8]* %t151 to i8*
  %t153 = bitcast i8* %t152 to i8**
  %t154 = load i8*, i8** %t153
  %t155 = icmp eq i32 %t149, 12
  %t156 = select i1 %t155, i8* %t154, i8* null
  %t157 = call i8* @sailfin_runtime_string_concat(i8* %s148, i8* %t156)
  %t158 = add i64 0, 2
  %t159 = call i8* @malloc(i64 %t158)
  store i8 34, i8* %t159
  %t160 = getelementptr i8, i8* %t159, i64 1
  store i8 0, i8* %t160
  call void @sailfin_runtime_mark_persistent(i8* %t159)
  %t161 = call i8* @sailfin_runtime_string_concat(i8* %t157, i8* %t159)
  %t162 = insertvalue %EffectRequirement %t147, i8* %t161, 2
  %t163 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t131, %EffectRequirement %t162)
  store { %EffectRequirement*, i64 }* %t163, { %EffectRequirement*, i64 }** %l0
  %t164 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t164
merge1:
  %t165 = extractvalue %Statement %statement, 0
  %t166 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t167 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t165, 0
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t165, 1
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t165, 2
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t165, 3
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t165, 4
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t165, 5
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t165, 6
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t165, 7
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t165, 8
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t165, 9
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t165, 10
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t165, 11
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t165, 12
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t165, 13
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t165, 14
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t165, 15
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t165, 16
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t165, 17
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t165, 18
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t165, 19
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t165, 20
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t165, 21
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t165, 22
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %s236 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1925822000, i32 0, i32 0
  %t237 = call i1 @strings_equal(i8* %t235, i8* %s236)
  br i1 %t237, label %then2, label %merge3
then2:
  %t238 = extractvalue %Statement %statement, 0
  %t239 = alloca %Statement
  store %Statement %statement, %Statement* %t239
  %t240 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t241 = bitcast [88 x i8]* %t240 to i8*
  %t242 = getelementptr inbounds i8, i8* %t241, i64 56
  %t243 = bitcast i8* %t242 to %Block*
  %t244 = load %Block, %Block* %t243
  %t245 = icmp eq i32 %t238, 4
  %t246 = select i1 %t245, %Block %t244, %Block zeroinitializer
  %t247 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t248 = bitcast [88 x i8]* %t247 to i8*
  %t249 = getelementptr inbounds i8, i8* %t248, i64 56
  %t250 = bitcast i8* %t249 to %Block*
  %t251 = load %Block, %Block* %t250
  %t252 = icmp eq i32 %t238, 5
  %t253 = select i1 %t252, %Block %t251, %Block %t246
  %t254 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t255 = bitcast [56 x i8]* %t254 to i8*
  %t256 = getelementptr inbounds i8, i8* %t255, i64 16
  %t257 = bitcast i8* %t256 to %Block*
  %t258 = load %Block, %Block* %t257
  %t259 = icmp eq i32 %t238, 6
  %t260 = select i1 %t259, %Block %t258, %Block %t253
  %t261 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t262 = bitcast [88 x i8]* %t261 to i8*
  %t263 = getelementptr inbounds i8, i8* %t262, i64 56
  %t264 = bitcast i8* %t263 to %Block*
  %t265 = load %Block, %Block* %t264
  %t266 = icmp eq i32 %t238, 7
  %t267 = select i1 %t266, %Block %t265, %Block %t260
  %t268 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t269 = bitcast [120 x i8]* %t268 to i8*
  %t270 = getelementptr inbounds i8, i8* %t269, i64 88
  %t271 = bitcast i8* %t270 to %Block*
  %t272 = load %Block, %Block* %t271
  %t273 = icmp eq i32 %t238, 12
  %t274 = select i1 %t273, %Block %t272, %Block %t267
  %t275 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t276 = bitcast [40 x i8]* %t275 to i8*
  %t277 = getelementptr inbounds i8, i8* %t276, i64 8
  %t278 = bitcast i8* %t277 to %Block*
  %t279 = load %Block, %Block* %t278
  %t280 = icmp eq i32 %t238, 13
  %t281 = select i1 %t280, %Block %t279, %Block %t274
  %t282 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t283 = bitcast [136 x i8]* %t282 to i8*
  %t284 = getelementptr inbounds i8, i8* %t283, i64 104
  %t285 = bitcast i8* %t284 to %Block*
  %t286 = load %Block, %Block* %t285
  %t287 = icmp eq i32 %t238, 14
  %t288 = select i1 %t287, %Block %t286, %Block %t281
  %t289 = getelementptr inbounds %Statement, %Statement* %t239, i32 0, i32 1
  %t290 = bitcast [32 x i8]* %t289 to i8*
  %t291 = bitcast i8* %t290 to %Block*
  %t292 = load %Block, %Block* %t291
  %t293 = icmp eq i32 %t238, 15
  %t294 = select i1 %t293, %Block %t292, %Block %t288
  %t295 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t294)
  store { %EffectRequirement*, i64 }* %t295, { %EffectRequirement*, i64 }** %l1
  %t296 = sitofp i64 0 to double
  store double %t296, double* %l2
  %t297 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t298 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t345 = phi { %EffectRequirement*, i64 }* [ %t297, %then2 ], [ %t343, %loop.latch6 ]
  %t346 = phi double [ %t298, %then2 ], [ %t344, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t345, { %EffectRequirement*, i64 }** %l1
  store double %t346, double* %l2
  br label %loop.body5
loop.body5:
  %t299 = load double, double* %l2
  %t300 = extractvalue %Statement %statement, 0
  %t301 = alloca %Statement
  store %Statement %statement, %Statement* %t301
  %t302 = getelementptr inbounds %Statement, %Statement* %t301, i32 0, i32 1
  %t303 = bitcast [40 x i8]* %t302 to i8*
  %t304 = bitcast i8* %t303 to { %WithClause*, i64 }**
  %t305 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %t304
  %t306 = icmp eq i32 %t300, 13
  %t307 = select i1 %t306, { %WithClause*, i64 }* %t305, { %WithClause*, i64 }* null
  %t308 = load { %WithClause*, i64 }, { %WithClause*, i64 }* %t307
  %t309 = extractvalue { %WithClause*, i64 } %t308, 1
  %t310 = sitofp i64 %t309 to double
  %t311 = fcmp oge double %t299, %t310
  %t312 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t313 = load double, double* %l2
  br i1 %t311, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t314 = extractvalue %Statement %statement, 0
  %t315 = alloca %Statement
  store %Statement %statement, %Statement* %t315
  %t316 = getelementptr inbounds %Statement, %Statement* %t315, i32 0, i32 1
  %t317 = bitcast [40 x i8]* %t316 to i8*
  %t318 = bitcast i8* %t317 to { %WithClause*, i64 }**
  %t319 = load { %WithClause*, i64 }*, { %WithClause*, i64 }** %t318
  %t320 = icmp eq i32 %t314, 13
  %t321 = select i1 %t320, { %WithClause*, i64 }* %t319, { %WithClause*, i64 }* null
  %t322 = load double, double* %l2
  %t323 = call double @llvm.round.f64(double %t322)
  %t324 = fptosi double %t323 to i64
  %t325 = load { %WithClause*, i64 }, { %WithClause*, i64 }* %t321
  %t326 = extractvalue { %WithClause*, i64 } %t325, 0
  %t327 = extractvalue { %WithClause*, i64 } %t325, 1
  %t328 = icmp uge i64 %t324, %t327
  ; bounds check: %t328 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t324, i64 %t327)
  %t329 = getelementptr %WithClause, %WithClause* %t326, i64 %t324
  %t330 = load %WithClause, %WithClause* %t329
  store %WithClause %t330, %WithClause* %l3
  %t331 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t332 = load %WithClause, %WithClause* %l3
  %t333 = extractvalue %WithClause %t332, 0
  %t334 = getelementptr %Expression, %Expression* null, i32 1
  %t335 = ptrtoint %Expression* %t334 to i64
  %t336 = call noalias i8* @malloc(i64 %t335)
  %t337 = bitcast i8* %t336 to %Expression*
  store %Expression %t333, %Expression* %t337
  call void @sailfin_runtime_mark_persistent(i8* %t336)
  %t338 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t337)
  %t339 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t331, { %EffectRequirement*, i64 }* %t338)
  store { %EffectRequirement*, i64 }* %t339, { %EffectRequirement*, i64 }** %l1
  %t340 = load double, double* %l2
  %t341 = sitofp i64 1 to double
  %t342 = fadd double %t340, %t341
  store double %t342, double* %l2
  br label %loop.latch6
loop.latch6:
  %t343 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t344 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t347 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t348 = load double, double* %l2
  %t349 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t349
merge3:
  %t350 = extractvalue %Statement %statement, 0
  %t351 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t352 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t350, 0
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t350, 1
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t350, 2
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t350, 3
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t350, 4
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t350, 5
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t350, 6
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t350, 7
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t350, 8
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %t379 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t350, 9
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t350, 10
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t386 = icmp eq i32 %t350, 11
  %t387 = select i1 %t386, i8* %t385, i8* %t384
  %t388 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t350, 12
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %t391 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t392 = icmp eq i32 %t350, 13
  %t393 = select i1 %t392, i8* %t391, i8* %t390
  %t394 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t395 = icmp eq i32 %t350, 14
  %t396 = select i1 %t395, i8* %t394, i8* %t393
  %t397 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t398 = icmp eq i32 %t350, 15
  %t399 = select i1 %t398, i8* %t397, i8* %t396
  %t400 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t401 = icmp eq i32 %t350, 16
  %t402 = select i1 %t401, i8* %t400, i8* %t399
  %t403 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t404 = icmp eq i32 %t350, 17
  %t405 = select i1 %t404, i8* %t403, i8* %t402
  %t406 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t407 = icmp eq i32 %t350, 18
  %t408 = select i1 %t407, i8* %t406, i8* %t405
  %t409 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t410 = icmp eq i32 %t350, 19
  %t411 = select i1 %t410, i8* %t409, i8* %t408
  %t412 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t350, 20
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %t415 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t416 = icmp eq i32 %t350, 21
  %t417 = select i1 %t416, i8* %t415, i8* %t414
  %t418 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t419 = icmp eq i32 %t350, 22
  %t420 = select i1 %t419, i8* %t418, i8* %t417
  %s421 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h84042670, i32 0, i32 0
  %t422 = call i1 @strings_equal(i8* %t420, i8* %s421)
  br i1 %t422, label %then10, label %merge11
then10:
  %t423 = extractvalue %Statement %statement, 0
  %t424 = alloca %Statement
  store %Statement %statement, %Statement* %t424
  %t425 = getelementptr inbounds %Statement, %Statement* %t424, i32 0, i32 1
  %t426 = bitcast [88 x i8]* %t425 to i8*
  %t427 = getelementptr inbounds i8, i8* %t426, i64 56
  %t428 = bitcast i8* %t427 to %Block*
  %t429 = load %Block, %Block* %t428
  %t430 = icmp eq i32 %t423, 4
  %t431 = select i1 %t430, %Block %t429, %Block zeroinitializer
  %t432 = getelementptr inbounds %Statement, %Statement* %t424, i32 0, i32 1
  %t433 = bitcast [88 x i8]* %t432 to i8*
  %t434 = getelementptr inbounds i8, i8* %t433, i64 56
  %t435 = bitcast i8* %t434 to %Block*
  %t436 = load %Block, %Block* %t435
  %t437 = icmp eq i32 %t423, 5
  %t438 = select i1 %t437, %Block %t436, %Block %t431
  %t439 = getelementptr inbounds %Statement, %Statement* %t424, i32 0, i32 1
  %t440 = bitcast [56 x i8]* %t439 to i8*
  %t441 = getelementptr inbounds i8, i8* %t440, i64 16
  %t442 = bitcast i8* %t441 to %Block*
  %t443 = load %Block, %Block* %t442
  %t444 = icmp eq i32 %t423, 6
  %t445 = select i1 %t444, %Block %t443, %Block %t438
  %t446 = getelementptr inbounds %Statement, %Statement* %t424, i32 0, i32 1
  %t447 = bitcast [88 x i8]* %t446 to i8*
  %t448 = getelementptr inbounds i8, i8* %t447, i64 56
  %t449 = bitcast i8* %t448 to %Block*
  %t450 = load %Block, %Block* %t449
  %t451 = icmp eq i32 %t423, 7
  %t452 = select i1 %t451, %Block %t450, %Block %t445
  %t453 = getelementptr inbounds %Statement, %Statement* %t424, i32 0, i32 1
  %t454 = bitcast [120 x i8]* %t453 to i8*
  %t455 = getelementptr inbounds i8, i8* %t454, i64 88
  %t456 = bitcast i8* %t455 to %Block*
  %t457 = load %Block, %Block* %t456
  %t458 = icmp eq i32 %t423, 12
  %t459 = select i1 %t458, %Block %t457, %Block %t452
  %t460 = getelementptr inbounds %Statement, %Statement* %t424, i32 0, i32 1
  %t461 = bitcast [40 x i8]* %t460 to i8*
  %t462 = getelementptr inbounds i8, i8* %t461, i64 8
  %t463 = bitcast i8* %t462 to %Block*
  %t464 = load %Block, %Block* %t463
  %t465 = icmp eq i32 %t423, 13
  %t466 = select i1 %t465, %Block %t464, %Block %t459
  %t467 = getelementptr inbounds %Statement, %Statement* %t424, i32 0, i32 1
  %t468 = bitcast [136 x i8]* %t467 to i8*
  %t469 = getelementptr inbounds i8, i8* %t468, i64 104
  %t470 = bitcast i8* %t469 to %Block*
  %t471 = load %Block, %Block* %t470
  %t472 = icmp eq i32 %t423, 14
  %t473 = select i1 %t472, %Block %t471, %Block %t466
  %t474 = getelementptr inbounds %Statement, %Statement* %t424, i32 0, i32 1
  %t475 = bitcast [32 x i8]* %t474 to i8*
  %t476 = bitcast i8* %t475 to %Block*
  %t477 = load %Block, %Block* %t476
  %t478 = icmp eq i32 %t423, 15
  %t479 = select i1 %t478, %Block %t477, %Block %t473
  %t480 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t479)
  store { %EffectRequirement*, i64 }* %t480, { %EffectRequirement*, i64 }** %l4
  %t481 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t482 = extractvalue %Statement %statement, 0
  %t483 = alloca %Statement
  store %Statement %statement, %Statement* %t483
  %t484 = getelementptr inbounds %Statement, %Statement* %t483, i32 0, i32 1
  %t485 = bitcast [136 x i8]* %t484 to i8*
  %t486 = bitcast i8* %t485 to %ForClause*
  %t487 = load %ForClause, %ForClause* %t486
  %t488 = icmp eq i32 %t482, 14
  %t489 = select i1 %t488, %ForClause %t487, %ForClause zeroinitializer
  %t490 = extractvalue %ForClause %t489, 0
  %t491 = getelementptr %Expression, %Expression* null, i32 1
  %t492 = ptrtoint %Expression* %t491 to i64
  %t493 = call noalias i8* @malloc(i64 %t492)
  %t494 = bitcast i8* %t493 to %Expression*
  store %Expression %t490, %Expression* %t494
  call void @sailfin_runtime_mark_persistent(i8* %t493)
  %t495 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t494)
  %t496 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t481, { %EffectRequirement*, i64 }* %t495)
  store { %EffectRequirement*, i64 }* %t496, { %EffectRequirement*, i64 }** %l4
  %t497 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t498 = extractvalue %Statement %statement, 0
  %t499 = alloca %Statement
  store %Statement %statement, %Statement* %t499
  %t500 = getelementptr inbounds %Statement, %Statement* %t499, i32 0, i32 1
  %t501 = bitcast [136 x i8]* %t500 to i8*
  %t502 = bitcast i8* %t501 to %ForClause*
  %t503 = load %ForClause, %ForClause* %t502
  %t504 = icmp eq i32 %t498, 14
  %t505 = select i1 %t504, %ForClause %t503, %ForClause zeroinitializer
  %t506 = extractvalue %ForClause %t505, 1
  %t507 = getelementptr %Expression, %Expression* null, i32 1
  %t508 = ptrtoint %Expression* %t507 to i64
  %t509 = call noalias i8* @malloc(i64 %t508)
  %t510 = bitcast i8* %t509 to %Expression*
  store %Expression %t506, %Expression* %t510
  call void @sailfin_runtime_mark_persistent(i8* %t509)
  %t511 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t510)
  %t512 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t497, { %EffectRequirement*, i64 }* %t511)
  store { %EffectRequirement*, i64 }* %t512, { %EffectRequirement*, i64 }** %l4
  %t513 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t513
merge11:
  %t514 = extractvalue %Statement %statement, 0
  %t515 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t516 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t517 = icmp eq i32 %t514, 0
  %t518 = select i1 %t517, i8* %t516, i8* %t515
  %t519 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t520 = icmp eq i32 %t514, 1
  %t521 = select i1 %t520, i8* %t519, i8* %t518
  %t522 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t523 = icmp eq i32 %t514, 2
  %t524 = select i1 %t523, i8* %t522, i8* %t521
  %t525 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t526 = icmp eq i32 %t514, 3
  %t527 = select i1 %t526, i8* %t525, i8* %t524
  %t528 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t529 = icmp eq i32 %t514, 4
  %t530 = select i1 %t529, i8* %t528, i8* %t527
  %t531 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t532 = icmp eq i32 %t514, 5
  %t533 = select i1 %t532, i8* %t531, i8* %t530
  %t534 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t535 = icmp eq i32 %t514, 6
  %t536 = select i1 %t535, i8* %t534, i8* %t533
  %t537 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t538 = icmp eq i32 %t514, 7
  %t539 = select i1 %t538, i8* %t537, i8* %t536
  %t540 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t541 = icmp eq i32 %t514, 8
  %t542 = select i1 %t541, i8* %t540, i8* %t539
  %t543 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t514, 9
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t514, 10
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t514, 11
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t514, 12
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t514, 13
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t514, 14
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t514, 15
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t514, 16
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t514, 17
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t514, 18
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t514, 19
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t514, 20
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t514, 21
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t514, 22
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %s585 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1678412334, i32 0, i32 0
  %t586 = call i1 @strings_equal(i8* %t584, i8* %s585)
  br i1 %t586, label %then12, label %merge13
then12:
  %t587 = extractvalue %Statement %statement, 0
  %t588 = alloca %Statement
  store %Statement %statement, %Statement* %t588
  %t589 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t590 = bitcast [88 x i8]* %t589 to i8*
  %t591 = getelementptr inbounds i8, i8* %t590, i64 56
  %t592 = bitcast i8* %t591 to %Block*
  %t593 = load %Block, %Block* %t592
  %t594 = icmp eq i32 %t587, 4
  %t595 = select i1 %t594, %Block %t593, %Block zeroinitializer
  %t596 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t597 = bitcast [88 x i8]* %t596 to i8*
  %t598 = getelementptr inbounds i8, i8* %t597, i64 56
  %t599 = bitcast i8* %t598 to %Block*
  %t600 = load %Block, %Block* %t599
  %t601 = icmp eq i32 %t587, 5
  %t602 = select i1 %t601, %Block %t600, %Block %t595
  %t603 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t604 = bitcast [56 x i8]* %t603 to i8*
  %t605 = getelementptr inbounds i8, i8* %t604, i64 16
  %t606 = bitcast i8* %t605 to %Block*
  %t607 = load %Block, %Block* %t606
  %t608 = icmp eq i32 %t587, 6
  %t609 = select i1 %t608, %Block %t607, %Block %t602
  %t610 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t611 = bitcast [88 x i8]* %t610 to i8*
  %t612 = getelementptr inbounds i8, i8* %t611, i64 56
  %t613 = bitcast i8* %t612 to %Block*
  %t614 = load %Block, %Block* %t613
  %t615 = icmp eq i32 %t587, 7
  %t616 = select i1 %t615, %Block %t614, %Block %t609
  %t617 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t618 = bitcast [120 x i8]* %t617 to i8*
  %t619 = getelementptr inbounds i8, i8* %t618, i64 88
  %t620 = bitcast i8* %t619 to %Block*
  %t621 = load %Block, %Block* %t620
  %t622 = icmp eq i32 %t587, 12
  %t623 = select i1 %t622, %Block %t621, %Block %t616
  %t624 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t625 = bitcast [40 x i8]* %t624 to i8*
  %t626 = getelementptr inbounds i8, i8* %t625, i64 8
  %t627 = bitcast i8* %t626 to %Block*
  %t628 = load %Block, %Block* %t627
  %t629 = icmp eq i32 %t587, 13
  %t630 = select i1 %t629, %Block %t628, %Block %t623
  %t631 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t632 = bitcast [136 x i8]* %t631 to i8*
  %t633 = getelementptr inbounds i8, i8* %t632, i64 104
  %t634 = bitcast i8* %t633 to %Block*
  %t635 = load %Block, %Block* %t634
  %t636 = icmp eq i32 %t587, 14
  %t637 = select i1 %t636, %Block %t635, %Block %t630
  %t638 = getelementptr inbounds %Statement, %Statement* %t588, i32 0, i32 1
  %t639 = bitcast [32 x i8]* %t638 to i8*
  %t640 = bitcast i8* %t639 to %Block*
  %t641 = load %Block, %Block* %t640
  %t642 = icmp eq i32 %t587, 15
  %t643 = select i1 %t642, %Block %t641, %Block %t637
  %t644 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t643)
  ret { %EffectRequirement*, i64 }* %t644
merge13:
  %t645 = extractvalue %Statement %statement, 0
  %t646 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t647 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t645, 0
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t645, 1
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t645, 2
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t645, 3
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t645, 4
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t645, 5
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t645, 6
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t645, 7
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t645, 8
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t645, 9
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t645, 10
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t645, 11
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t645, 12
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t645, 13
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t645, 14
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t645, 15
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t645, 16
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t645, 17
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t645, 18
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t645, 19
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t645, 20
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t645, 21
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t645, 22
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %s716 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h196308685, i32 0, i32 0
  %t717 = call i1 @strings_equal(i8* %t715, i8* %s716)
  br i1 %t717, label %then14, label %merge15
then14:
  %t718 = extractvalue %Statement %statement, 0
  %t719 = alloca %Statement
  store %Statement %statement, %Statement* %t719
  %t720 = getelementptr inbounds %Statement, %Statement* %t719, i32 0, i32 1
  %t721 = bitcast [16 x i8]* %t720 to i8*
  %t722 = bitcast i8* %t721 to %Expression**
  %t723 = load %Expression*, %Expression** %t722
  %t724 = icmp eq i32 %t718, 20
  %t725 = select i1 %t724, %Expression* %t723, %Expression* null
  %t726 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t725)
  store { %EffectRequirement*, i64 }* %t726, { %EffectRequirement*, i64 }** %l5
  %t727 = sitofp i64 0 to double
  store double %t727, double* %l6
  %t728 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t729 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t772 = phi { %EffectRequirement*, i64 }* [ %t728, %then14 ], [ %t770, %loop.latch18 ]
  %t773 = phi double [ %t729, %then14 ], [ %t771, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t772, { %EffectRequirement*, i64 }** %l5
  store double %t773, double* %l6
  br label %loop.body17
loop.body17:
  %t730 = load double, double* %l6
  %t731 = extractvalue %Statement %statement, 0
  %t732 = alloca %Statement
  store %Statement %statement, %Statement* %t732
  %t733 = getelementptr inbounds %Statement, %Statement* %t732, i32 0, i32 1
  %t734 = bitcast [64 x i8]* %t733 to i8*
  %t735 = getelementptr inbounds i8, i8* %t734, i64 48
  %t736 = bitcast i8* %t735 to { %MatchCase*, i64 }**
  %t737 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t736
  %t738 = icmp eq i32 %t731, 18
  %t739 = select i1 %t738, { %MatchCase*, i64 }* %t737, { %MatchCase*, i64 }* null
  %t740 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t739
  %t741 = extractvalue { %MatchCase*, i64 } %t740, 1
  %t742 = sitofp i64 %t741 to double
  %t743 = fcmp oge double %t730, %t742
  %t744 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t745 = load double, double* %l6
  br i1 %t743, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t746 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t747 = extractvalue %Statement %statement, 0
  %t748 = alloca %Statement
  store %Statement %statement, %Statement* %t748
  %t749 = getelementptr inbounds %Statement, %Statement* %t748, i32 0, i32 1
  %t750 = bitcast [64 x i8]* %t749 to i8*
  %t751 = getelementptr inbounds i8, i8* %t750, i64 48
  %t752 = bitcast i8* %t751 to { %MatchCase*, i64 }**
  %t753 = load { %MatchCase*, i64 }*, { %MatchCase*, i64 }** %t752
  %t754 = icmp eq i32 %t747, 18
  %t755 = select i1 %t754, { %MatchCase*, i64 }* %t753, { %MatchCase*, i64 }* null
  %t756 = load double, double* %l6
  %t757 = call double @llvm.round.f64(double %t756)
  %t758 = fptosi double %t757 to i64
  %t759 = load { %MatchCase*, i64 }, { %MatchCase*, i64 }* %t755
  %t760 = extractvalue { %MatchCase*, i64 } %t759, 0
  %t761 = extractvalue { %MatchCase*, i64 } %t759, 1
  %t762 = icmp uge i64 %t758, %t761
  ; bounds check: %t762 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t758, i64 %t761)
  %t763 = getelementptr %MatchCase, %MatchCase* %t760, i64 %t758
  %t764 = load %MatchCase, %MatchCase* %t763
  %t765 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t764)
  %t766 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t746, { %EffectRequirement*, i64 }* %t765)
  store { %EffectRequirement*, i64 }* %t766, { %EffectRequirement*, i64 }** %l5
  %t767 = load double, double* %l6
  %t768 = sitofp i64 1 to double
  %t769 = fadd double %t767, %t768
  store double %t769, double* %l6
  br label %loop.latch18
loop.latch18:
  %t770 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t771 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t774 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t775 = load double, double* %l6
  %t776 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t776
merge15:
  %t777 = extractvalue %Statement %statement, 0
  %t778 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t779 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t777, 0
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t777, 1
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t777, 2
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t777, 3
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t777, 4
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t777, 5
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t777, 6
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t777, 7
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t777, 8
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t777, 9
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %t809 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t777, 10
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t777, 11
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t777, 12
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t777, 13
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t777, 14
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t777, 15
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t777, 16
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t777, 17
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t777, 18
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t777, 19
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t777, 20
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t777, 21
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t777, 22
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %s848 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1566780570, i32 0, i32 0
  %t849 = call i1 @strings_equal(i8* %t847, i8* %s848)
  br i1 %t849, label %then22, label %merge23
then22:
  %t850 = extractvalue %Statement %statement, 0
  %t851 = alloca %Statement
  store %Statement %statement, %Statement* %t851
  %t852 = getelementptr inbounds %Statement, %Statement* %t851, i32 0, i32 1
  %t853 = bitcast [88 x i8]* %t852 to i8*
  %t854 = bitcast i8* %t853 to %Expression*
  %t855 = load %Expression, %Expression* %t854
  %t856 = icmp eq i32 %t850, 19
  %t857 = select i1 %t856, %Expression %t855, %Expression zeroinitializer
  %t858 = getelementptr %Expression, %Expression* null, i32 1
  %t859 = ptrtoint %Expression* %t858 to i64
  %t860 = call noalias i8* @malloc(i64 %t859)
  %t861 = bitcast i8* %t860 to %Expression*
  store %Expression %t857, %Expression* %t861
  call void @sailfin_runtime_mark_persistent(i8* %t860)
  %t862 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t861)
  store { %EffectRequirement*, i64 }* %t862, { %EffectRequirement*, i64 }** %l7
  %t863 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t864 = extractvalue %Statement %statement, 0
  %t865 = alloca %Statement
  store %Statement %statement, %Statement* %t865
  %t866 = getelementptr inbounds %Statement, %Statement* %t865, i32 0, i32 1
  %t867 = bitcast [88 x i8]* %t866 to i8*
  %t868 = getelementptr inbounds i8, i8* %t867, i64 48
  %t869 = bitcast i8* %t868 to %Block*
  %t870 = load %Block, %Block* %t869
  %t871 = icmp eq i32 %t864, 19
  %t872 = select i1 %t871, %Block %t870, %Block zeroinitializer
  %t873 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t872)
  %t874 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t863, { %EffectRequirement*, i64 }* %t873)
  store { %EffectRequirement*, i64 }* %t874, { %EffectRequirement*, i64 }** %l7
  %t875 = extractvalue %Statement %statement, 0
  %t876 = alloca %Statement
  store %Statement %statement, %Statement* %t876
  %t877 = getelementptr inbounds %Statement, %Statement* %t876, i32 0, i32 1
  %t878 = bitcast [88 x i8]* %t877 to i8*
  %t879 = getelementptr inbounds i8, i8* %t878, i64 72
  %t880 = bitcast i8* %t879 to %ElseBranch**
  %t881 = load %ElseBranch*, %ElseBranch** %t880
  %t882 = icmp eq i32 %t875, 19
  %t883 = select i1 %t882, %ElseBranch* %t881, %ElseBranch* null
  store %ElseBranch* %t883, %ElseBranch** %l8
  %t884 = load %ElseBranch*, %ElseBranch** %l8
  %t885 = icmp eq %ElseBranch* %t884, null
  %t886 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t887 = load %ElseBranch*, %ElseBranch** %l8
  br i1 %t885, label %then24, label %merge25
then24:
  %t888 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t888
merge25:
  %t889 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t890 = load %ElseBranch*, %ElseBranch** %l8
  %t891 = load %ElseBranch, %ElseBranch* %t890
  %t892 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %t891)
  %t893 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t889, { %EffectRequirement*, i64 }* %t892)
  store { %EffectRequirement*, i64 }* %t893, { %EffectRequirement*, i64 }** %l7
  %t894 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t894
merge23:
  %t895 = extractvalue %Statement %statement, 0
  %t896 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t897 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t895, 0
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t895, 1
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t895, 2
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t895, 3
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t895, 4
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t895, 5
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t895, 6
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t895, 7
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t895, 8
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t895, 9
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t895, 10
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t895, 11
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t895, 12
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t895, 13
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t895, 14
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t895, 15
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t895, 16
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t895, 17
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t895, 18
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t895, 19
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t895, 20
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t895, 21
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t895, 22
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %s966 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1613933868, i32 0, i32 0
  %t967 = call i1 @strings_equal(i8* %t965, i8* %s966)
  br i1 %t967, label %then26, label %merge27
then26:
  %t968 = extractvalue %Statement %statement, 0
  %t969 = alloca %Statement
  store %Statement %statement, %Statement* %t969
  %t970 = getelementptr inbounds %Statement, %Statement* %t969, i32 0, i32 1
  %t971 = bitcast [16 x i8]* %t970 to i8*
  %t972 = bitcast i8* %t971 to %Expression**
  %t973 = load %Expression*, %Expression** %t972
  %t974 = icmp eq i32 %t968, 20
  %t975 = select i1 %t974, %Expression* %t973, %Expression* null
  %t976 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t975)
  ret { %EffectRequirement*, i64 }* %t976
merge27:
  %t977 = extractvalue %Statement %statement, 0
  %t978 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t979 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t977, 0
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t977, 1
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t977, 2
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t977, 3
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t977, 4
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t977, 5
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t977, 6
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t977, 7
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t977, 8
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t977, 9
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t977, 10
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t977, 11
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t977, 12
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t977, 13
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t977, 14
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t977, 15
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t977, 16
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t977, 17
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t977, 18
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t977, 19
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t977, 20
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t977, 21
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t977, 22
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %s1048 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h868168677, i32 0, i32 0
  %t1049 = call i1 @strings_equal(i8* %t1047, i8* %s1048)
  br i1 %t1049, label %then28, label %merge29
then28:
  %t1050 = extractvalue %Statement %statement, 0
  %t1051 = alloca %Statement
  store %Statement %statement, %Statement* %t1051
  %t1052 = getelementptr inbounds %Statement, %Statement* %t1051, i32 0, i32 1
  %t1053 = bitcast [16 x i8]* %t1052 to i8*
  %t1054 = bitcast i8* %t1053 to %Expression**
  %t1055 = load %Expression*, %Expression** %t1054
  %t1056 = icmp eq i32 %t1050, 20
  %t1057 = select i1 %t1056, %Expression* %t1055, %Expression* null
  %t1058 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1057)
  ret { %EffectRequirement*, i64 }* %t1058
merge29:
  %t1059 = extractvalue %Statement %statement, 0
  %t1060 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1061 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1059, 0
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1059, 1
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1059, 2
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1059, 3
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1059, 4
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1059, 5
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1059, 6
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1059, 7
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1059, 8
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1059, 9
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1059, 10
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1059, 11
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1059, 12
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1059, 13
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1059, 14
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1059, 15
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1059, 16
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1059, 17
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %t1115 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1116 = icmp eq i32 %t1059, 18
  %t1117 = select i1 %t1116, i8* %t1115, i8* %t1114
  %t1118 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1119 = icmp eq i32 %t1059, 19
  %t1120 = select i1 %t1119, i8* %t1118, i8* %t1117
  %t1121 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1122 = icmp eq i32 %t1059, 20
  %t1123 = select i1 %t1122, i8* %t1121, i8* %t1120
  %t1124 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1125 = icmp eq i32 %t1059, 21
  %t1126 = select i1 %t1125, i8* %t1124, i8* %t1123
  %t1127 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1059, 22
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %s1130 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1204027478, i32 0, i32 0
  %t1131 = call i1 @strings_equal(i8* %t1129, i8* %s1130)
  br i1 %t1131, label %then30, label %merge31
then30:
  %t1132 = extractvalue %Statement %statement, 0
  %t1133 = alloca %Statement
  store %Statement %statement, %Statement* %t1133
  %t1134 = getelementptr inbounds %Statement, %Statement* %t1133, i32 0, i32 1
  %t1135 = bitcast [48 x i8]* %t1134 to i8*
  %t1136 = getelementptr inbounds i8, i8* %t1135, i64 24
  %t1137 = bitcast i8* %t1136 to %Expression**
  %t1138 = load %Expression*, %Expression** %t1137
  %t1139 = icmp eq i32 %t1132, 2
  %t1140 = select i1 %t1139, %Expression* %t1138, %Expression* null
  %t1141 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1140)
  ret { %EffectRequirement*, i64 }* %t1141
merge31:
  %t1142 = extractvalue %Statement %statement, 0
  %t1143 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1144 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1142, 0
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1142, 1
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1142, 2
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1142, 3
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1142, 4
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1142, 5
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1142, 6
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1142, 7
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1142, 8
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1142, 9
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1142, 10
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1142, 11
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1142, 12
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1142, 13
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1142, 14
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1142, 15
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1142, 16
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1142, 17
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1142, 18
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1142, 19
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1142, 20
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1142, 21
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1142, 22
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %s1213 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t1214 = call i1 @strings_equal(i8* %t1212, i8* %s1213)
  br i1 %t1214, label %then32, label %merge33
then32:
  %t1215 = extractvalue %Statement %statement, 0
  %t1216 = alloca %Statement
  store %Statement %statement, %Statement* %t1216
  %t1217 = getelementptr inbounds %Statement, %Statement* %t1216, i32 0, i32 1
  %t1218 = bitcast [88 x i8]* %t1217 to i8*
  %t1219 = getelementptr inbounds i8, i8* %t1218, i64 56
  %t1220 = bitcast i8* %t1219 to %Block*
  %t1221 = load %Block, %Block* %t1220
  %t1222 = icmp eq i32 %t1215, 4
  %t1223 = select i1 %t1222, %Block %t1221, %Block zeroinitializer
  %t1224 = getelementptr inbounds %Statement, %Statement* %t1216, i32 0, i32 1
  %t1225 = bitcast [88 x i8]* %t1224 to i8*
  %t1226 = getelementptr inbounds i8, i8* %t1225, i64 56
  %t1227 = bitcast i8* %t1226 to %Block*
  %t1228 = load %Block, %Block* %t1227
  %t1229 = icmp eq i32 %t1215, 5
  %t1230 = select i1 %t1229, %Block %t1228, %Block %t1223
  %t1231 = getelementptr inbounds %Statement, %Statement* %t1216, i32 0, i32 1
  %t1232 = bitcast [56 x i8]* %t1231 to i8*
  %t1233 = getelementptr inbounds i8, i8* %t1232, i64 16
  %t1234 = bitcast i8* %t1233 to %Block*
  %t1235 = load %Block, %Block* %t1234
  %t1236 = icmp eq i32 %t1215, 6
  %t1237 = select i1 %t1236, %Block %t1235, %Block %t1230
  %t1238 = getelementptr inbounds %Statement, %Statement* %t1216, i32 0, i32 1
  %t1239 = bitcast [88 x i8]* %t1238 to i8*
  %t1240 = getelementptr inbounds i8, i8* %t1239, i64 56
  %t1241 = bitcast i8* %t1240 to %Block*
  %t1242 = load %Block, %Block* %t1241
  %t1243 = icmp eq i32 %t1215, 7
  %t1244 = select i1 %t1243, %Block %t1242, %Block %t1237
  %t1245 = getelementptr inbounds %Statement, %Statement* %t1216, i32 0, i32 1
  %t1246 = bitcast [120 x i8]* %t1245 to i8*
  %t1247 = getelementptr inbounds i8, i8* %t1246, i64 88
  %t1248 = bitcast i8* %t1247 to %Block*
  %t1249 = load %Block, %Block* %t1248
  %t1250 = icmp eq i32 %t1215, 12
  %t1251 = select i1 %t1250, %Block %t1249, %Block %t1244
  %t1252 = getelementptr inbounds %Statement, %Statement* %t1216, i32 0, i32 1
  %t1253 = bitcast [40 x i8]* %t1252 to i8*
  %t1254 = getelementptr inbounds i8, i8* %t1253, i64 8
  %t1255 = bitcast i8* %t1254 to %Block*
  %t1256 = load %Block, %Block* %t1255
  %t1257 = icmp eq i32 %t1215, 13
  %t1258 = select i1 %t1257, %Block %t1256, %Block %t1251
  %t1259 = getelementptr inbounds %Statement, %Statement* %t1216, i32 0, i32 1
  %t1260 = bitcast [136 x i8]* %t1259 to i8*
  %t1261 = getelementptr inbounds i8, i8* %t1260, i64 104
  %t1262 = bitcast i8* %t1261 to %Block*
  %t1263 = load %Block, %Block* %t1262
  %t1264 = icmp eq i32 %t1215, 14
  %t1265 = select i1 %t1264, %Block %t1263, %Block %t1258
  %t1266 = getelementptr inbounds %Statement, %Statement* %t1216, i32 0, i32 1
  %t1267 = bitcast [32 x i8]* %t1266 to i8*
  %t1268 = bitcast i8* %t1267 to %Block*
  %t1269 = load %Block, %Block* %t1268
  %t1270 = icmp eq i32 %t1215, 15
  %t1271 = select i1 %t1270, %Block %t1269, %Block %t1265
  %t1272 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1271)
  ret { %EffectRequirement*, i64 }* %t1272
merge33:
  %t1273 = extractvalue %Statement %statement, 0
  %t1274 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1275 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1273, 0
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1273, 1
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1273, 2
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1273, 3
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1273, 4
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1273, 5
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1273, 6
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1273, 7
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1273, 8
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1273, 9
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1273, 10
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1273, 11
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1273, 12
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1273, 13
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1273, 14
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1273, 15
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1273, 16
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1273, 17
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1273, 18
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1273, 19
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1273, 20
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1273, 21
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1273, 22
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %s1344 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t1345 = call i1 @strings_equal(i8* %t1343, i8* %s1344)
  br i1 %t1345, label %then34, label %merge35
then34:
  %t1346 = extractvalue %Statement %statement, 0
  %t1347 = alloca %Statement
  store %Statement %statement, %Statement* %t1347
  %t1348 = getelementptr inbounds %Statement, %Statement* %t1347, i32 0, i32 1
  %t1349 = bitcast [88 x i8]* %t1348 to i8*
  %t1350 = getelementptr inbounds i8, i8* %t1349, i64 56
  %t1351 = bitcast i8* %t1350 to %Block*
  %t1352 = load %Block, %Block* %t1351
  %t1353 = icmp eq i32 %t1346, 4
  %t1354 = select i1 %t1353, %Block %t1352, %Block zeroinitializer
  %t1355 = getelementptr inbounds %Statement, %Statement* %t1347, i32 0, i32 1
  %t1356 = bitcast [88 x i8]* %t1355 to i8*
  %t1357 = getelementptr inbounds i8, i8* %t1356, i64 56
  %t1358 = bitcast i8* %t1357 to %Block*
  %t1359 = load %Block, %Block* %t1358
  %t1360 = icmp eq i32 %t1346, 5
  %t1361 = select i1 %t1360, %Block %t1359, %Block %t1354
  %t1362 = getelementptr inbounds %Statement, %Statement* %t1347, i32 0, i32 1
  %t1363 = bitcast [56 x i8]* %t1362 to i8*
  %t1364 = getelementptr inbounds i8, i8* %t1363, i64 16
  %t1365 = bitcast i8* %t1364 to %Block*
  %t1366 = load %Block, %Block* %t1365
  %t1367 = icmp eq i32 %t1346, 6
  %t1368 = select i1 %t1367, %Block %t1366, %Block %t1361
  %t1369 = getelementptr inbounds %Statement, %Statement* %t1347, i32 0, i32 1
  %t1370 = bitcast [88 x i8]* %t1369 to i8*
  %t1371 = getelementptr inbounds i8, i8* %t1370, i64 56
  %t1372 = bitcast i8* %t1371 to %Block*
  %t1373 = load %Block, %Block* %t1372
  %t1374 = icmp eq i32 %t1346, 7
  %t1375 = select i1 %t1374, %Block %t1373, %Block %t1368
  %t1376 = getelementptr inbounds %Statement, %Statement* %t1347, i32 0, i32 1
  %t1377 = bitcast [120 x i8]* %t1376 to i8*
  %t1378 = getelementptr inbounds i8, i8* %t1377, i64 88
  %t1379 = bitcast i8* %t1378 to %Block*
  %t1380 = load %Block, %Block* %t1379
  %t1381 = icmp eq i32 %t1346, 12
  %t1382 = select i1 %t1381, %Block %t1380, %Block %t1375
  %t1383 = getelementptr inbounds %Statement, %Statement* %t1347, i32 0, i32 1
  %t1384 = bitcast [40 x i8]* %t1383 to i8*
  %t1385 = getelementptr inbounds i8, i8* %t1384, i64 8
  %t1386 = bitcast i8* %t1385 to %Block*
  %t1387 = load %Block, %Block* %t1386
  %t1388 = icmp eq i32 %t1346, 13
  %t1389 = select i1 %t1388, %Block %t1387, %Block %t1382
  %t1390 = getelementptr inbounds %Statement, %Statement* %t1347, i32 0, i32 1
  %t1391 = bitcast [136 x i8]* %t1390 to i8*
  %t1392 = getelementptr inbounds i8, i8* %t1391, i64 104
  %t1393 = bitcast i8* %t1392 to %Block*
  %t1394 = load %Block, %Block* %t1393
  %t1395 = icmp eq i32 %t1346, 14
  %t1396 = select i1 %t1395, %Block %t1394, %Block %t1389
  %t1397 = getelementptr inbounds %Statement, %Statement* %t1347, i32 0, i32 1
  %t1398 = bitcast [32 x i8]* %t1397 to i8*
  %t1399 = bitcast i8* %t1398 to %Block*
  %t1400 = load %Block, %Block* %t1399
  %t1401 = icmp eq i32 %t1346, 15
  %t1402 = select i1 %t1401, %Block %t1400, %Block %t1396
  %t1403 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1402)
  ret { %EffectRequirement*, i64 }* %t1403
merge35:
  %t1404 = extractvalue %Statement %statement, 0
  %t1405 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1406 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1404, 0
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1404, 1
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1404, 2
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1404, 3
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1419 = icmp eq i32 %t1404, 4
  %t1420 = select i1 %t1419, i8* %t1418, i8* %t1417
  %t1421 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1422 = icmp eq i32 %t1404, 5
  %t1423 = select i1 %t1422, i8* %t1421, i8* %t1420
  %t1424 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1425 = icmp eq i32 %t1404, 6
  %t1426 = select i1 %t1425, i8* %t1424, i8* %t1423
  %t1427 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1404, 7
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %t1430 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1404, 8
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1404, 9
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1404, 10
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1404, 11
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1404, 12
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1404, 13
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1449 = icmp eq i32 %t1404, 14
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1447
  %t1451 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1452 = icmp eq i32 %t1404, 15
  %t1453 = select i1 %t1452, i8* %t1451, i8* %t1450
  %t1454 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1455 = icmp eq i32 %t1404, 16
  %t1456 = select i1 %t1455, i8* %t1454, i8* %t1453
  %t1457 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1458 = icmp eq i32 %t1404, 17
  %t1459 = select i1 %t1458, i8* %t1457, i8* %t1456
  %t1460 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1461 = icmp eq i32 %t1404, 18
  %t1462 = select i1 %t1461, i8* %t1460, i8* %t1459
  %t1463 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1464 = icmp eq i32 %t1404, 19
  %t1465 = select i1 %t1464, i8* %t1463, i8* %t1462
  %t1466 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1467 = icmp eq i32 %t1404, 20
  %t1468 = select i1 %t1467, i8* %t1466, i8* %t1465
  %t1469 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1470 = icmp eq i32 %t1404, 21
  %t1471 = select i1 %t1470, i8* %t1469, i8* %t1468
  %t1472 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1473 = icmp eq i32 %t1404, 22
  %t1474 = select i1 %t1473, i8* %t1472, i8* %t1471
  %s1475 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t1476 = call i1 @strings_equal(i8* %t1474, i8* %s1475)
  br i1 %t1476, label %then36, label %merge37
then36:
  %t1477 = extractvalue %Statement %statement, 0
  %t1478 = alloca %Statement
  store %Statement %statement, %Statement* %t1478
  %t1479 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1480 = bitcast [88 x i8]* %t1479 to i8*
  %t1481 = getelementptr inbounds i8, i8* %t1480, i64 56
  %t1482 = bitcast i8* %t1481 to %Block*
  %t1483 = load %Block, %Block* %t1482
  %t1484 = icmp eq i32 %t1477, 4
  %t1485 = select i1 %t1484, %Block %t1483, %Block zeroinitializer
  %t1486 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1487 = bitcast [88 x i8]* %t1486 to i8*
  %t1488 = getelementptr inbounds i8, i8* %t1487, i64 56
  %t1489 = bitcast i8* %t1488 to %Block*
  %t1490 = load %Block, %Block* %t1489
  %t1491 = icmp eq i32 %t1477, 5
  %t1492 = select i1 %t1491, %Block %t1490, %Block %t1485
  %t1493 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1494 = bitcast [56 x i8]* %t1493 to i8*
  %t1495 = getelementptr inbounds i8, i8* %t1494, i64 16
  %t1496 = bitcast i8* %t1495 to %Block*
  %t1497 = load %Block, %Block* %t1496
  %t1498 = icmp eq i32 %t1477, 6
  %t1499 = select i1 %t1498, %Block %t1497, %Block %t1492
  %t1500 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1501 = bitcast [88 x i8]* %t1500 to i8*
  %t1502 = getelementptr inbounds i8, i8* %t1501, i64 56
  %t1503 = bitcast i8* %t1502 to %Block*
  %t1504 = load %Block, %Block* %t1503
  %t1505 = icmp eq i32 %t1477, 7
  %t1506 = select i1 %t1505, %Block %t1504, %Block %t1499
  %t1507 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1508 = bitcast [120 x i8]* %t1507 to i8*
  %t1509 = getelementptr inbounds i8, i8* %t1508, i64 88
  %t1510 = bitcast i8* %t1509 to %Block*
  %t1511 = load %Block, %Block* %t1510
  %t1512 = icmp eq i32 %t1477, 12
  %t1513 = select i1 %t1512, %Block %t1511, %Block %t1506
  %t1514 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1515 = bitcast [40 x i8]* %t1514 to i8*
  %t1516 = getelementptr inbounds i8, i8* %t1515, i64 8
  %t1517 = bitcast i8* %t1516 to %Block*
  %t1518 = load %Block, %Block* %t1517
  %t1519 = icmp eq i32 %t1477, 13
  %t1520 = select i1 %t1519, %Block %t1518, %Block %t1513
  %t1521 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1522 = bitcast [136 x i8]* %t1521 to i8*
  %t1523 = getelementptr inbounds i8, i8* %t1522, i64 104
  %t1524 = bitcast i8* %t1523 to %Block*
  %t1525 = load %Block, %Block* %t1524
  %t1526 = icmp eq i32 %t1477, 14
  %t1527 = select i1 %t1526, %Block %t1525, %Block %t1520
  %t1528 = getelementptr inbounds %Statement, %Statement* %t1478, i32 0, i32 1
  %t1529 = bitcast [32 x i8]* %t1528 to i8*
  %t1530 = bitcast i8* %t1529 to %Block*
  %t1531 = load %Block, %Block* %t1530
  %t1532 = icmp eq i32 %t1477, 15
  %t1533 = select i1 %t1532, %Block %t1531, %Block %t1527
  %t1534 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1533)
  ret { %EffectRequirement*, i64 }* %t1534
merge37:
  %t1535 = extractvalue %Statement %statement, 0
  %t1536 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1537 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1538 = icmp eq i32 %t1535, 0
  %t1539 = select i1 %t1538, i8* %t1537, i8* %t1536
  %t1540 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1541 = icmp eq i32 %t1535, 1
  %t1542 = select i1 %t1541, i8* %t1540, i8* %t1539
  %t1543 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1544 = icmp eq i32 %t1535, 2
  %t1545 = select i1 %t1544, i8* %t1543, i8* %t1542
  %t1546 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1547 = icmp eq i32 %t1535, 3
  %t1548 = select i1 %t1547, i8* %t1546, i8* %t1545
  %t1549 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1550 = icmp eq i32 %t1535, 4
  %t1551 = select i1 %t1550, i8* %t1549, i8* %t1548
  %t1552 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1553 = icmp eq i32 %t1535, 5
  %t1554 = select i1 %t1553, i8* %t1552, i8* %t1551
  %t1555 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1556 = icmp eq i32 %t1535, 6
  %t1557 = select i1 %t1556, i8* %t1555, i8* %t1554
  %t1558 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1559 = icmp eq i32 %t1535, 7
  %t1560 = select i1 %t1559, i8* %t1558, i8* %t1557
  %t1561 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1562 = icmp eq i32 %t1535, 8
  %t1563 = select i1 %t1562, i8* %t1561, i8* %t1560
  %t1564 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1565 = icmp eq i32 %t1535, 9
  %t1566 = select i1 %t1565, i8* %t1564, i8* %t1563
  %t1567 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1568 = icmp eq i32 %t1535, 10
  %t1569 = select i1 %t1568, i8* %t1567, i8* %t1566
  %t1570 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1571 = icmp eq i32 %t1535, 11
  %t1572 = select i1 %t1571, i8* %t1570, i8* %t1569
  %t1573 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1574 = icmp eq i32 %t1535, 12
  %t1575 = select i1 %t1574, i8* %t1573, i8* %t1572
  %t1576 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1577 = icmp eq i32 %t1535, 13
  %t1578 = select i1 %t1577, i8* %t1576, i8* %t1575
  %t1579 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1580 = icmp eq i32 %t1535, 14
  %t1581 = select i1 %t1580, i8* %t1579, i8* %t1578
  %t1582 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1583 = icmp eq i32 %t1535, 15
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1581
  %t1585 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1586 = icmp eq i32 %t1535, 16
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1584
  %t1588 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1589 = icmp eq i32 %t1535, 17
  %t1590 = select i1 %t1589, i8* %t1588, i8* %t1587
  %t1591 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1535, 18
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %t1594 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1595 = icmp eq i32 %t1535, 19
  %t1596 = select i1 %t1595, i8* %t1594, i8* %t1593
  %t1597 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1535, 20
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1535, 21
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1535, 22
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %s1606 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t1607 = call i1 @strings_equal(i8* %t1605, i8* %s1606)
  br i1 %t1607, label %then38, label %merge39
then38:
  %t1608 = extractvalue %Statement %statement, 0
  %t1609 = alloca %Statement
  store %Statement %statement, %Statement* %t1609
  %t1610 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1611 = bitcast [88 x i8]* %t1610 to i8*
  %t1612 = getelementptr inbounds i8, i8* %t1611, i64 56
  %t1613 = bitcast i8* %t1612 to %Block*
  %t1614 = load %Block, %Block* %t1613
  %t1615 = icmp eq i32 %t1608, 4
  %t1616 = select i1 %t1615, %Block %t1614, %Block zeroinitializer
  %t1617 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1618 = bitcast [88 x i8]* %t1617 to i8*
  %t1619 = getelementptr inbounds i8, i8* %t1618, i64 56
  %t1620 = bitcast i8* %t1619 to %Block*
  %t1621 = load %Block, %Block* %t1620
  %t1622 = icmp eq i32 %t1608, 5
  %t1623 = select i1 %t1622, %Block %t1621, %Block %t1616
  %t1624 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1625 = bitcast [56 x i8]* %t1624 to i8*
  %t1626 = getelementptr inbounds i8, i8* %t1625, i64 16
  %t1627 = bitcast i8* %t1626 to %Block*
  %t1628 = load %Block, %Block* %t1627
  %t1629 = icmp eq i32 %t1608, 6
  %t1630 = select i1 %t1629, %Block %t1628, %Block %t1623
  %t1631 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1632 = bitcast [88 x i8]* %t1631 to i8*
  %t1633 = getelementptr inbounds i8, i8* %t1632, i64 56
  %t1634 = bitcast i8* %t1633 to %Block*
  %t1635 = load %Block, %Block* %t1634
  %t1636 = icmp eq i32 %t1608, 7
  %t1637 = select i1 %t1636, %Block %t1635, %Block %t1630
  %t1638 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1639 = bitcast [120 x i8]* %t1638 to i8*
  %t1640 = getelementptr inbounds i8, i8* %t1639, i64 88
  %t1641 = bitcast i8* %t1640 to %Block*
  %t1642 = load %Block, %Block* %t1641
  %t1643 = icmp eq i32 %t1608, 12
  %t1644 = select i1 %t1643, %Block %t1642, %Block %t1637
  %t1645 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1646 = bitcast [40 x i8]* %t1645 to i8*
  %t1647 = getelementptr inbounds i8, i8* %t1646, i64 8
  %t1648 = bitcast i8* %t1647 to %Block*
  %t1649 = load %Block, %Block* %t1648
  %t1650 = icmp eq i32 %t1608, 13
  %t1651 = select i1 %t1650, %Block %t1649, %Block %t1644
  %t1652 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1653 = bitcast [136 x i8]* %t1652 to i8*
  %t1654 = getelementptr inbounds i8, i8* %t1653, i64 104
  %t1655 = bitcast i8* %t1654 to %Block*
  %t1656 = load %Block, %Block* %t1655
  %t1657 = icmp eq i32 %t1608, 14
  %t1658 = select i1 %t1657, %Block %t1656, %Block %t1651
  %t1659 = getelementptr inbounds %Statement, %Statement* %t1609, i32 0, i32 1
  %t1660 = bitcast [32 x i8]* %t1659 to i8*
  %t1661 = bitcast i8* %t1660 to %Block*
  %t1662 = load %Block, %Block* %t1661
  %t1663 = icmp eq i32 %t1608, 15
  %t1664 = select i1 %t1663, %Block %t1662, %Block %t1658
  %t1665 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1664)
  ret { %EffectRequirement*, i64 }* %t1665
merge39:
  %t1666 = extractvalue %Statement %statement, 0
  %t1667 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1668 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1669 = icmp eq i32 %t1666, 0
  %t1670 = select i1 %t1669, i8* %t1668, i8* %t1667
  %t1671 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1672 = icmp eq i32 %t1666, 1
  %t1673 = select i1 %t1672, i8* %t1671, i8* %t1670
  %t1674 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1675 = icmp eq i32 %t1666, 2
  %t1676 = select i1 %t1675, i8* %t1674, i8* %t1673
  %t1677 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1678 = icmp eq i32 %t1666, 3
  %t1679 = select i1 %t1678, i8* %t1677, i8* %t1676
  %t1680 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1681 = icmp eq i32 %t1666, 4
  %t1682 = select i1 %t1681, i8* %t1680, i8* %t1679
  %t1683 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1684 = icmp eq i32 %t1666, 5
  %t1685 = select i1 %t1684, i8* %t1683, i8* %t1682
  %t1686 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1687 = icmp eq i32 %t1666, 6
  %t1688 = select i1 %t1687, i8* %t1686, i8* %t1685
  %t1689 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1690 = icmp eq i32 %t1666, 7
  %t1691 = select i1 %t1690, i8* %t1689, i8* %t1688
  %t1692 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1693 = icmp eq i32 %t1666, 8
  %t1694 = select i1 %t1693, i8* %t1692, i8* %t1691
  %t1695 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1696 = icmp eq i32 %t1666, 9
  %t1697 = select i1 %t1696, i8* %t1695, i8* %t1694
  %t1698 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1699 = icmp eq i32 %t1666, 10
  %t1700 = select i1 %t1699, i8* %t1698, i8* %t1697
  %t1701 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1702 = icmp eq i32 %t1666, 11
  %t1703 = select i1 %t1702, i8* %t1701, i8* %t1700
  %t1704 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1705 = icmp eq i32 %t1666, 12
  %t1706 = select i1 %t1705, i8* %t1704, i8* %t1703
  %t1707 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1708 = icmp eq i32 %t1666, 13
  %t1709 = select i1 %t1708, i8* %t1707, i8* %t1706
  %t1710 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1711 = icmp eq i32 %t1666, 14
  %t1712 = select i1 %t1711, i8* %t1710, i8* %t1709
  %t1713 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1714 = icmp eq i32 %t1666, 15
  %t1715 = select i1 %t1714, i8* %t1713, i8* %t1712
  %t1716 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1717 = icmp eq i32 %t1666, 16
  %t1718 = select i1 %t1717, i8* %t1716, i8* %t1715
  %t1719 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1720 = icmp eq i32 %t1666, 17
  %t1721 = select i1 %t1720, i8* %t1719, i8* %t1718
  %t1722 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1723 = icmp eq i32 %t1666, 18
  %t1724 = select i1 %t1723, i8* %t1722, i8* %t1721
  %t1725 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1726 = icmp eq i32 %t1666, 19
  %t1727 = select i1 %t1726, i8* %t1725, i8* %t1724
  %t1728 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1729 = icmp eq i32 %t1666, 20
  %t1730 = select i1 %t1729, i8* %t1728, i8* %t1727
  %t1731 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1732 = icmp eq i32 %t1666, 21
  %t1733 = select i1 %t1732, i8* %t1731, i8* %t1730
  %t1734 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1735 = icmp eq i32 %t1666, 22
  %t1736 = select i1 %t1735, i8* %t1734, i8* %t1733
  %s1737 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t1738 = call i1 @strings_equal(i8* %t1736, i8* %s1737)
  br i1 %t1738, label %then40, label %merge41
then40:
  %t1739 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1740 = ptrtoint [0 x %EffectRequirement]* %t1739 to i64
  %t1741 = icmp eq i64 %t1740, 0
  %t1742 = select i1 %t1741, i64 1, i64 %t1740
  %t1743 = call i8* @malloc(i64 %t1742)
  %t1744 = bitcast i8* %t1743 to %EffectRequirement*
  %t1745 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1746 = ptrtoint { %EffectRequirement*, i64 }* %t1745 to i64
  %t1747 = call i8* @malloc(i64 %t1746)
  %t1748 = bitcast i8* %t1747 to { %EffectRequirement*, i64 }*
  %t1749 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1748, i32 0, i32 0
  store %EffectRequirement* %t1744, %EffectRequirement** %t1749
  %t1750 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1748, i32 0, i32 1
  store i64 0, i64* %t1750
  store { %EffectRequirement*, i64 }* %t1748, { %EffectRequirement*, i64 }** %l9
  %t1751 = sitofp i64 0 to double
  store double %t1751, double* %l10
  %t1752 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1753 = load double, double* %l10
  br label %loop.header42
loop.header42:
  %t1797 = phi { %EffectRequirement*, i64 }* [ %t1752, %then40 ], [ %t1795, %loop.latch44 ]
  %t1798 = phi double [ %t1753, %then40 ], [ %t1796, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1797, { %EffectRequirement*, i64 }** %l9
  store double %t1798, double* %l10
  br label %loop.body43
loop.body43:
  %t1754 = load double, double* %l10
  %t1755 = extractvalue %Statement %statement, 0
  %t1756 = alloca %Statement
  store %Statement %statement, %Statement* %t1756
  %t1757 = getelementptr inbounds %Statement, %Statement* %t1756, i32 0, i32 1
  %t1758 = bitcast [56 x i8]* %t1757 to i8*
  %t1759 = getelementptr inbounds i8, i8* %t1758, i64 40
  %t1760 = bitcast i8* %t1759 to { %MethodDeclaration*, i64 }**
  %t1761 = load { %MethodDeclaration*, i64 }*, { %MethodDeclaration*, i64 }** %t1760
  %t1762 = icmp eq i32 %t1755, 8
  %t1763 = select i1 %t1762, { %MethodDeclaration*, i64 }* %t1761, { %MethodDeclaration*, i64 }* null
  %t1764 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1763
  %t1765 = extractvalue { %MethodDeclaration*, i64 } %t1764, 1
  %t1766 = sitofp i64 %t1765 to double
  %t1767 = fcmp oge double %t1754, %t1766
  %t1768 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1769 = load double, double* %l10
  br i1 %t1767, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1770 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
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
  %t1780 = load double, double* %l10
  %t1781 = call double @llvm.round.f64(double %t1780)
  %t1782 = fptosi double %t1781 to i64
  %t1783 = load { %MethodDeclaration*, i64 }, { %MethodDeclaration*, i64 }* %t1779
  %t1784 = extractvalue { %MethodDeclaration*, i64 } %t1783, 0
  %t1785 = extractvalue { %MethodDeclaration*, i64 } %t1783, 1
  %t1786 = icmp uge i64 %t1782, %t1785
  ; bounds check: %t1786 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1782, i64 %t1785)
  %t1787 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1784, i64 %t1782
  %t1788 = load %MethodDeclaration, %MethodDeclaration* %t1787
  %t1789 = extractvalue %MethodDeclaration %t1788, 1
  %t1790 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1789)
  %t1791 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1770, { %EffectRequirement*, i64 }* %t1790)
  store { %EffectRequirement*, i64 }* %t1791, { %EffectRequirement*, i64 }** %l9
  %t1792 = load double, double* %l10
  %t1793 = sitofp i64 1 to double
  %t1794 = fadd double %t1792, %t1793
  store double %t1794, double* %l10
  br label %loop.latch44
loop.latch44:
  %t1795 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1796 = load double, double* %l10
  br label %loop.header42
afterloop45:
  %t1799 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1800 = load double, double* %l10
  %t1801 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t1801
merge41:
  %t1802 = extractvalue %Statement %statement, 0
  %t1803 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1804 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1805 = icmp eq i32 %t1802, 0
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1803
  %t1807 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1808 = icmp eq i32 %t1802, 1
  %t1809 = select i1 %t1808, i8* %t1807, i8* %t1806
  %t1810 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1811 = icmp eq i32 %t1802, 2
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1809
  %t1813 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1814 = icmp eq i32 %t1802, 3
  %t1815 = select i1 %t1814, i8* %t1813, i8* %t1812
  %t1816 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1817 = icmp eq i32 %t1802, 4
  %t1818 = select i1 %t1817, i8* %t1816, i8* %t1815
  %t1819 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1820 = icmp eq i32 %t1802, 5
  %t1821 = select i1 %t1820, i8* %t1819, i8* %t1818
  %t1822 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1823 = icmp eq i32 %t1802, 6
  %t1824 = select i1 %t1823, i8* %t1822, i8* %t1821
  %t1825 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1826 = icmp eq i32 %t1802, 7
  %t1827 = select i1 %t1826, i8* %t1825, i8* %t1824
  %t1828 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1829 = icmp eq i32 %t1802, 8
  %t1830 = select i1 %t1829, i8* %t1828, i8* %t1827
  %t1831 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1832 = icmp eq i32 %t1802, 9
  %t1833 = select i1 %t1832, i8* %t1831, i8* %t1830
  %t1834 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1835 = icmp eq i32 %t1802, 10
  %t1836 = select i1 %t1835, i8* %t1834, i8* %t1833
  %t1837 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1838 = icmp eq i32 %t1802, 11
  %t1839 = select i1 %t1838, i8* %t1837, i8* %t1836
  %t1840 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1841 = icmp eq i32 %t1802, 12
  %t1842 = select i1 %t1841, i8* %t1840, i8* %t1839
  %t1843 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1844 = icmp eq i32 %t1802, 13
  %t1845 = select i1 %t1844, i8* %t1843, i8* %t1842
  %t1846 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1847 = icmp eq i32 %t1802, 14
  %t1848 = select i1 %t1847, i8* %t1846, i8* %t1845
  %t1849 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1850 = icmp eq i32 %t1802, 15
  %t1851 = select i1 %t1850, i8* %t1849, i8* %t1848
  %t1852 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1853 = icmp eq i32 %t1802, 16
  %t1854 = select i1 %t1853, i8* %t1852, i8* %t1851
  %t1855 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1856 = icmp eq i32 %t1802, 17
  %t1857 = select i1 %t1856, i8* %t1855, i8* %t1854
  %t1858 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1859 = icmp eq i32 %t1802, 18
  %t1860 = select i1 %t1859, i8* %t1858, i8* %t1857
  %t1861 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1862 = icmp eq i32 %t1802, 19
  %t1863 = select i1 %t1862, i8* %t1861, i8* %t1860
  %t1864 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1865 = icmp eq i32 %t1802, 20
  %t1866 = select i1 %t1865, i8* %t1864, i8* %t1863
  %t1867 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1868 = icmp eq i32 %t1802, 21
  %t1869 = select i1 %t1868, i8* %t1867, i8* %t1866
  %t1870 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1871 = icmp eq i32 %t1802, 22
  %t1872 = select i1 %t1871, i8* %t1870, i8* %t1869
  %s1873 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t1874 = call i1 @strings_equal(i8* %t1872, i8* %s1873)
  br i1 %t1874, label %then48, label %merge49
then48:
  %t1875 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1876 = ptrtoint [0 x %EffectRequirement]* %t1875 to i64
  %t1877 = icmp eq i64 %t1876, 0
  %t1878 = select i1 %t1877, i64 1, i64 %t1876
  %t1879 = call i8* @malloc(i64 %t1878)
  %t1880 = bitcast i8* %t1879 to %EffectRequirement*
  %t1881 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1882 = ptrtoint { %EffectRequirement*, i64 }* %t1881 to i64
  %t1883 = call i8* @malloc(i64 %t1882)
  %t1884 = bitcast i8* %t1883 to { %EffectRequirement*, i64 }*
  %t1885 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1884, i32 0, i32 0
  store %EffectRequirement* %t1880, %EffectRequirement** %t1885
  %t1886 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1884, i32 0, i32 1
  store i64 0, i64* %t1886
  store { %EffectRequirement*, i64 }* %t1884, { %EffectRequirement*, i64 }** %l11
  %t1887 = sitofp i64 0 to double
  store double %t1887, double* %l12
  %t1888 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1889 = load double, double* %l12
  br label %loop.header50
loop.header50:
  %t1937 = phi { %EffectRequirement*, i64 }* [ %t1888, %then48 ], [ %t1935, %loop.latch52 ]
  %t1938 = phi double [ %t1889, %then48 ], [ %t1936, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1937, { %EffectRequirement*, i64 }** %l11
  store double %t1938, double* %l12
  br label %loop.body51
loop.body51:
  %t1890 = load double, double* %l12
  %t1891 = extractvalue %Statement %statement, 0
  %t1892 = alloca %Statement
  store %Statement %statement, %Statement* %t1892
  %t1893 = getelementptr inbounds %Statement, %Statement* %t1892, i32 0, i32 1
  %t1894 = bitcast [48 x i8]* %t1893 to i8*
  %t1895 = getelementptr inbounds i8, i8* %t1894, i64 24
  %t1896 = bitcast i8* %t1895 to { %ModelProperty*, i64 }**
  %t1897 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t1896
  %t1898 = icmp eq i32 %t1891, 3
  %t1899 = select i1 %t1898, { %ModelProperty*, i64 }* %t1897, { %ModelProperty*, i64 }* null
  %t1900 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t1899
  %t1901 = extractvalue { %ModelProperty*, i64 } %t1900, 1
  %t1902 = sitofp i64 %t1901 to double
  %t1903 = fcmp oge double %t1890, %t1902
  %t1904 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1905 = load double, double* %l12
  br i1 %t1903, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1906 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1907 = extractvalue %Statement %statement, 0
  %t1908 = alloca %Statement
  store %Statement %statement, %Statement* %t1908
  %t1909 = getelementptr inbounds %Statement, %Statement* %t1908, i32 0, i32 1
  %t1910 = bitcast [48 x i8]* %t1909 to i8*
  %t1911 = getelementptr inbounds i8, i8* %t1910, i64 24
  %t1912 = bitcast i8* %t1911 to { %ModelProperty*, i64 }**
  %t1913 = load { %ModelProperty*, i64 }*, { %ModelProperty*, i64 }** %t1912
  %t1914 = icmp eq i32 %t1907, 3
  %t1915 = select i1 %t1914, { %ModelProperty*, i64 }* %t1913, { %ModelProperty*, i64 }* null
  %t1916 = load double, double* %l12
  %t1917 = call double @llvm.round.f64(double %t1916)
  %t1918 = fptosi double %t1917 to i64
  %t1919 = load { %ModelProperty*, i64 }, { %ModelProperty*, i64 }* %t1915
  %t1920 = extractvalue { %ModelProperty*, i64 } %t1919, 0
  %t1921 = extractvalue { %ModelProperty*, i64 } %t1919, 1
  %t1922 = icmp uge i64 %t1918, %t1921
  ; bounds check: %t1922 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1918, i64 %t1921)
  %t1923 = getelementptr %ModelProperty, %ModelProperty* %t1920, i64 %t1918
  %t1924 = load %ModelProperty, %ModelProperty* %t1923
  %t1925 = extractvalue %ModelProperty %t1924, 1
  %t1926 = getelementptr %Expression, %Expression* null, i32 1
  %t1927 = ptrtoint %Expression* %t1926 to i64
  %t1928 = call noalias i8* @malloc(i64 %t1927)
  %t1929 = bitcast i8* %t1928 to %Expression*
  store %Expression %t1925, %Expression* %t1929
  call void @sailfin_runtime_mark_persistent(i8* %t1928)
  %t1930 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1929)
  %t1931 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1906, { %EffectRequirement*, i64 }* %t1930)
  store { %EffectRequirement*, i64 }* %t1931, { %EffectRequirement*, i64 }** %l11
  %t1932 = load double, double* %l12
  %t1933 = sitofp i64 1 to double
  %t1934 = fadd double %t1932, %t1933
  store double %t1934, double* %l12
  br label %loop.latch52
loop.latch52:
  %t1935 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1936 = load double, double* %l12
  br label %loop.header50
afterloop53:
  %t1939 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1940 = load double, double* %l12
  %t1941 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  ret { %EffectRequirement*, i64 }* %t1941
merge49:
  %t1942 = extractvalue %Statement %statement, 0
  %t1943 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1944 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1945 = icmp eq i32 %t1942, 0
  %t1946 = select i1 %t1945, i8* %t1944, i8* %t1943
  %t1947 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1948 = icmp eq i32 %t1942, 1
  %t1949 = select i1 %t1948, i8* %t1947, i8* %t1946
  %t1950 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1951 = icmp eq i32 %t1942, 2
  %t1952 = select i1 %t1951, i8* %t1950, i8* %t1949
  %t1953 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1954 = icmp eq i32 %t1942, 3
  %t1955 = select i1 %t1954, i8* %t1953, i8* %t1952
  %t1956 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1957 = icmp eq i32 %t1942, 4
  %t1958 = select i1 %t1957, i8* %t1956, i8* %t1955
  %t1959 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1960 = icmp eq i32 %t1942, 5
  %t1961 = select i1 %t1960, i8* %t1959, i8* %t1958
  %t1962 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1963 = icmp eq i32 %t1942, 6
  %t1964 = select i1 %t1963, i8* %t1962, i8* %t1961
  %t1965 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1966 = icmp eq i32 %t1942, 7
  %t1967 = select i1 %t1966, i8* %t1965, i8* %t1964
  %t1968 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1969 = icmp eq i32 %t1942, 8
  %t1970 = select i1 %t1969, i8* %t1968, i8* %t1967
  %t1971 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1972 = icmp eq i32 %t1942, 9
  %t1973 = select i1 %t1972, i8* %t1971, i8* %t1970
  %t1974 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1975 = icmp eq i32 %t1942, 10
  %t1976 = select i1 %t1975, i8* %t1974, i8* %t1973
  %t1977 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1978 = icmp eq i32 %t1942, 11
  %t1979 = select i1 %t1978, i8* %t1977, i8* %t1976
  %t1980 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1981 = icmp eq i32 %t1942, 12
  %t1982 = select i1 %t1981, i8* %t1980, i8* %t1979
  %t1983 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1984 = icmp eq i32 %t1942, 13
  %t1985 = select i1 %t1984, i8* %t1983, i8* %t1982
  %t1986 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1987 = icmp eq i32 %t1942, 14
  %t1988 = select i1 %t1987, i8* %t1986, i8* %t1985
  %t1989 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1990 = icmp eq i32 %t1942, 15
  %t1991 = select i1 %t1990, i8* %t1989, i8* %t1988
  %t1992 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1993 = icmp eq i32 %t1942, 16
  %t1994 = select i1 %t1993, i8* %t1992, i8* %t1991
  %t1995 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1996 = icmp eq i32 %t1942, 17
  %t1997 = select i1 %t1996, i8* %t1995, i8* %t1994
  %t1998 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1999 = icmp eq i32 %t1942, 18
  %t2000 = select i1 %t1999, i8* %t1998, i8* %t1997
  %t2001 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t2002 = icmp eq i32 %t1942, 19
  %t2003 = select i1 %t2002, i8* %t2001, i8* %t2000
  %t2004 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2005 = icmp eq i32 %t1942, 20
  %t2006 = select i1 %t2005, i8* %t2004, i8* %t2003
  %t2007 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2008 = icmp eq i32 %t1942, 21
  %t2009 = select i1 %t2008, i8* %t2007, i8* %t2006
  %t2010 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2011 = icmp eq i32 %t1942, 22
  %t2012 = select i1 %t2011, i8* %t2010, i8* %t2009
  %s2013 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t2014 = call i1 @strings_equal(i8* %t2012, i8* %s2013)
  br i1 %t2014, label %then56, label %merge57
then56:
  %t2015 = extractvalue %Statement %statement, 0
  %t2016 = alloca %Statement
  store %Statement %statement, %Statement* %t2016
  %t2017 = getelementptr inbounds %Statement, %Statement* %t2016, i32 0, i32 1
  %t2018 = bitcast [16 x i8]* %t2017 to i8*
  %t2019 = bitcast i8* %t2018 to { %Token*, i64 }**
  %t2020 = load { %Token*, i64 }*, { %Token*, i64 }** %t2019
  %t2021 = icmp eq i32 %t2015, 22
  %t2022 = select i1 %t2021, { %Token*, i64 }* %t2020, { %Token*, i64 }* null
  %t2023 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t2022)
  ret { %EffectRequirement*, i64 }* %t2023
merge57:
  %t2024 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t2025 = ptrtoint [0 x %EffectRequirement]* %t2024 to i64
  %t2026 = icmp eq i64 %t2025, 0
  %t2027 = select i1 %t2026, i64 1, i64 %t2025
  %t2028 = call i8* @malloc(i64 %t2027)
  %t2029 = bitcast i8* %t2028 to %EffectRequirement*
  %t2030 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t2031 = ptrtoint { %EffectRequirement*, i64 }* %t2030 to i64
  %t2032 = call i8* @malloc(i64 %t2031)
  %t2033 = bitcast i8* %t2032 to { %EffectRequirement*, i64 }*
  %t2034 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2033, i32 0, i32 0
  store %EffectRequirement* %t2029, %EffectRequirement** %t2034
  %t2035 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2033, i32 0, i32 1
  store i64 0, i64* %t2035
  ret { %EffectRequirement*, i64 }* %t2033
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
  %t124 = phi { %EffectRequirement*, i64 }* [ %t76, %then2 ], [ %t122, %loop.latch6 ]
  %t125 = phi double [ %t77, %then2 ], [ %t123, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t124, { %EffectRequirement*, i64 }** %l0
  store double %t125, double* %l1
  br label %loop.body5
loop.body5:
  %t78 = load double, double* %l1
  %t79 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t80 = load i32, i32* %t79
  %t81 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t82 = bitcast [16 x i8]* %t81 to i8*
  %t83 = getelementptr inbounds i8, i8* %t82, i64 8
  %t84 = bitcast i8* %t83 to { %Expression*, i64 }**
  %t85 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t84
  %t86 = icmp eq i32 %t80, 8
  %t87 = select i1 %t86, { %Expression*, i64 }* %t85, { %Expression*, i64 }* null
  %t88 = load { %Expression*, i64 }, { %Expression*, i64 }* %t87
  %t89 = extractvalue { %Expression*, i64 } %t88, 1
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
  %t100 = bitcast i8* %t99 to { %Expression*, i64 }**
  %t101 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t100
  %t102 = icmp eq i32 %t96, 8
  %t103 = select i1 %t102, { %Expression*, i64 }* %t101, { %Expression*, i64 }* null
  %t104 = load double, double* %l1
  %t105 = call double @llvm.round.f64(double %t104)
  %t106 = fptosi double %t105 to i64
  %t107 = load { %Expression*, i64 }, { %Expression*, i64 }* %t103
  %t108 = extractvalue { %Expression*, i64 } %t107, 0
  %t109 = extractvalue { %Expression*, i64 } %t107, 1
  %t110 = icmp uge i64 %t106, %t109
  ; bounds check: %t110 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t106, i64 %t109)
  %t111 = getelementptr %Expression, %Expression* %t108, i64 %t106
  %t112 = load %Expression, %Expression* %t111
  %t113 = getelementptr %Expression, %Expression* null, i32 1
  %t114 = ptrtoint %Expression* %t113 to i64
  %t115 = call noalias i8* @malloc(i64 %t114)
  %t116 = bitcast i8* %t115 to %Expression*
  store %Expression %t112, %Expression* %t116
  call void @sailfin_runtime_mark_persistent(i8* %t115)
  %t117 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t116)
  %t118 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t94, { %EffectRequirement*, i64 }* %t117)
  store { %EffectRequirement*, i64 }* %t118, { %EffectRequirement*, i64 }** %l0
  %t119 = load double, double* %l1
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  store double %t121, double* %l1
  br label %loop.latch6
loop.latch6:
  %t122 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t123 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t126 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t127 = load double, double* %l1
  %t128 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t128
merge3:
  %t129 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t130 = load i32, i32* %t129
  %t131 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t132 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t130, 0
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t130, 1
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t130, 2
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t130, 3
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t130, 4
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t130, 5
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t130, 6
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t130, 7
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t130, 8
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t130, 9
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t130, 10
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t130, 11
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t130, 12
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t130, 13
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t130, 14
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t130, 15
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %s180 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h512390329, i32 0, i32 0
  %t181 = call i1 @strings_equal(i8* %t179, i8* %s180)
  br i1 %t181, label %then10, label %merge11
then10:
  %t182 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t183 = load i32, i32* %t182
  %t184 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t185 = bitcast [16 x i8]* %t184 to i8*
  %t186 = bitcast i8* %t185 to %Expression**
  %t187 = load %Expression*, %Expression** %t186
  %t188 = icmp eq i32 %t183, 7
  %t189 = select i1 %t188, %Expression* %t187, %Expression* null
  %t190 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t189)
  ret { %EffectRequirement*, i64 }* %t190
merge11:
  %t191 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t192 = load i32, i32* %t191
  %t193 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t194 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t192, 0
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t192, 1
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t192, 2
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t192, 3
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t192, 4
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t192, 5
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t192, 6
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t192, 7
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t192, 8
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t192, 9
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t192, 10
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t192, 11
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t192, 12
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t192, 13
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %t236 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t237 = icmp eq i32 %t192, 14
  %t238 = select i1 %t237, i8* %t236, i8* %t235
  %t239 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t240 = icmp eq i32 %t192, 15
  %t241 = select i1 %t240, i8* %t239, i8* %t238
  %s242 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1445149598, i32 0, i32 0
  %t243 = call i1 @strings_equal(i8* %t241, i8* %s242)
  br i1 %t243, label %then12, label %merge13
then12:
  %t244 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t245 = load i32, i32* %t244
  %t246 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t247 = bitcast [16 x i8]* %t246 to i8*
  %t248 = getelementptr inbounds i8, i8* %t247, i64 8
  %t249 = bitcast i8* %t248 to %Expression**
  %t250 = load %Expression*, %Expression** %t249
  %t251 = icmp eq i32 %t245, 5
  %t252 = select i1 %t251, %Expression* %t250, %Expression* null
  %t253 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t252)
  ret { %EffectRequirement*, i64 }* %t253
merge13:
  %t254 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t255 = load i32, i32* %t254
  %t256 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t257 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t258 = icmp eq i32 %t255, 0
  %t259 = select i1 %t258, i8* %t257, i8* %t256
  %t260 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t261 = icmp eq i32 %t255, 1
  %t262 = select i1 %t261, i8* %t260, i8* %t259
  %t263 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t264 = icmp eq i32 %t255, 2
  %t265 = select i1 %t264, i8* %t263, i8* %t262
  %t266 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t267 = icmp eq i32 %t255, 3
  %t268 = select i1 %t267, i8* %t266, i8* %t265
  %t269 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t270 = icmp eq i32 %t255, 4
  %t271 = select i1 %t270, i8* %t269, i8* %t268
  %t272 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t273 = icmp eq i32 %t255, 5
  %t274 = select i1 %t273, i8* %t272, i8* %t271
  %t275 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t276 = icmp eq i32 %t255, 6
  %t277 = select i1 %t276, i8* %t275, i8* %t274
  %t278 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t279 = icmp eq i32 %t255, 7
  %t280 = select i1 %t279, i8* %t278, i8* %t277
  %t281 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t282 = icmp eq i32 %t255, 8
  %t283 = select i1 %t282, i8* %t281, i8* %t280
  %t284 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t285 = icmp eq i32 %t255, 9
  %t286 = select i1 %t285, i8* %t284, i8* %t283
  %t287 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t288 = icmp eq i32 %t255, 10
  %t289 = select i1 %t288, i8* %t287, i8* %t286
  %t290 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t291 = icmp eq i32 %t255, 11
  %t292 = select i1 %t291, i8* %t290, i8* %t289
  %t293 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t294 = icmp eq i32 %t255, 12
  %t295 = select i1 %t294, i8* %t293, i8* %t292
  %t296 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t255, 13
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t255, 14
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t255, 15
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %s305 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1496334143, i32 0, i32 0
  %t306 = call i1 @strings_equal(i8* %t304, i8* %s305)
  br i1 %t306, label %then14, label %merge15
then14:
  %t307 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t308 = load i32, i32* %t307
  %t309 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t310 = bitcast [24 x i8]* %t309 to i8*
  %t311 = getelementptr inbounds i8, i8* %t310, i64 8
  %t312 = bitcast i8* %t311 to %Expression**
  %t313 = load %Expression*, %Expression** %t312
  %t314 = icmp eq i32 %t308, 6
  %t315 = select i1 %t314, %Expression* %t313, %Expression* null
  %t316 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t315)
  store { %EffectRequirement*, i64 }* %t316, { %EffectRequirement*, i64 }** %l2
  %t317 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  %t318 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t319 = load i32, i32* %t318
  %t320 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t321 = bitcast [24 x i8]* %t320 to i8*
  %t322 = getelementptr inbounds i8, i8* %t321, i64 16
  %t323 = bitcast i8* %t322 to %Expression**
  %t324 = load %Expression*, %Expression** %t323
  %t325 = icmp eq i32 %t319, 6
  %t326 = select i1 %t325, %Expression* %t324, %Expression* null
  %t327 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t326)
  %t328 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t317, { %EffectRequirement*, i64 }* %t327)
  store { %EffectRequirement*, i64 }* %t328, { %EffectRequirement*, i64 }** %l2
  %t329 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  ret { %EffectRequirement*, i64 }* %t329
merge15:
  %t330 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t331 = load i32, i32* %t330
  %t332 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t333 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t331, 0
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t331, 1
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t331, 2
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t331, 3
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t331, 4
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t331, 5
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t331, 6
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t331, 7
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t331, 8
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t331, 9
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t331, 10
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t331, 11
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t331, 12
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %t372 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t373 = icmp eq i32 %t331, 13
  %t374 = select i1 %t373, i8* %t372, i8* %t371
  %t375 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t376 = icmp eq i32 %t331, 14
  %t377 = select i1 %t376, i8* %t375, i8* %t374
  %t378 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t379 = icmp eq i32 %t331, 15
  %t380 = select i1 %t379, i8* %t378, i8* %t377
  %s381 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h667777838, i32 0, i32 0
  %t382 = call i1 @strings_equal(i8* %t380, i8* %s381)
  br i1 %t382, label %then16, label %merge17
then16:
  %t383 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t384 = ptrtoint [0 x %EffectRequirement]* %t383 to i64
  %t385 = icmp eq i64 %t384, 0
  %t386 = select i1 %t385, i64 1, i64 %t384
  %t387 = call i8* @malloc(i64 %t386)
  %t388 = bitcast i8* %t387 to %EffectRequirement*
  %t389 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t390 = ptrtoint { %EffectRequirement*, i64 }* %t389 to i64
  %t391 = call i8* @malloc(i64 %t390)
  %t392 = bitcast i8* %t391 to { %EffectRequirement*, i64 }*
  %t393 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t392, i32 0, i32 0
  store %EffectRequirement* %t388, %EffectRequirement** %t393
  %t394 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t392, i32 0, i32 1
  store i64 0, i64* %t394
  store { %EffectRequirement*, i64 }* %t392, { %EffectRequirement*, i64 }** %l3
  %t395 = sitofp i64 0 to double
  store double %t395, double* %l4
  %t396 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t397 = load double, double* %l4
  br label %loop.header18
loop.header18:
  %t442 = phi { %EffectRequirement*, i64 }* [ %t396, %then16 ], [ %t440, %loop.latch20 ]
  %t443 = phi double [ %t397, %then16 ], [ %t441, %loop.latch20 ]
  store { %EffectRequirement*, i64 }* %t442, { %EffectRequirement*, i64 }** %l3
  store double %t443, double* %l4
  br label %loop.body19
loop.body19:
  %t398 = load double, double* %l4
  %t399 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t400 = load i32, i32* %t399
  %t401 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t402 = bitcast [8 x i8]* %t401 to i8*
  %t403 = bitcast i8* %t402 to { %Expression*, i64 }**
  %t404 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t403
  %t405 = icmp eq i32 %t400, 10
  %t406 = select i1 %t405, { %Expression*, i64 }* %t404, { %Expression*, i64 }* null
  %t407 = load { %Expression*, i64 }, { %Expression*, i64 }* %t406
  %t408 = extractvalue { %Expression*, i64 } %t407, 1
  %t409 = sitofp i64 %t408 to double
  %t410 = fcmp oge double %t398, %t409
  %t411 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t412 = load double, double* %l4
  br i1 %t410, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t413 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t414 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t415 = load i32, i32* %t414
  %t416 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t417 = bitcast [8 x i8]* %t416 to i8*
  %t418 = bitcast i8* %t417 to { %Expression*, i64 }**
  %t419 = load { %Expression*, i64 }*, { %Expression*, i64 }** %t418
  %t420 = icmp eq i32 %t415, 10
  %t421 = select i1 %t420, { %Expression*, i64 }* %t419, { %Expression*, i64 }* null
  %t422 = load double, double* %l4
  %t423 = call double @llvm.round.f64(double %t422)
  %t424 = fptosi double %t423 to i64
  %t425 = load { %Expression*, i64 }, { %Expression*, i64 }* %t421
  %t426 = extractvalue { %Expression*, i64 } %t425, 0
  %t427 = extractvalue { %Expression*, i64 } %t425, 1
  %t428 = icmp uge i64 %t424, %t427
  ; bounds check: %t428 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t424, i64 %t427)
  %t429 = getelementptr %Expression, %Expression* %t426, i64 %t424
  %t430 = load %Expression, %Expression* %t429
  %t431 = getelementptr %Expression, %Expression* null, i32 1
  %t432 = ptrtoint %Expression* %t431 to i64
  %t433 = call noalias i8* @malloc(i64 %t432)
  %t434 = bitcast i8* %t433 to %Expression*
  store %Expression %t430, %Expression* %t434
  call void @sailfin_runtime_mark_persistent(i8* %t433)
  %t435 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t434)
  %t436 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t413, { %EffectRequirement*, i64 }* %t435)
  store { %EffectRequirement*, i64 }* %t436, { %EffectRequirement*, i64 }** %l3
  %t437 = load double, double* %l4
  %t438 = sitofp i64 1 to double
  %t439 = fadd double %t437, %t438
  store double %t439, double* %l4
  br label %loop.latch20
loop.latch20:
  %t440 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t441 = load double, double* %l4
  br label %loop.header18
afterloop21:
  %t444 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t445 = load double, double* %l4
  %t446 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  ret { %EffectRequirement*, i64 }* %t446
merge17:
  %t447 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t448 = load i32, i32* %t447
  %t449 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t450 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t451 = icmp eq i32 %t448, 0
  %t452 = select i1 %t451, i8* %t450, i8* %t449
  %t453 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t454 = icmp eq i32 %t448, 1
  %t455 = select i1 %t454, i8* %t453, i8* %t452
  %t456 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t457 = icmp eq i32 %t448, 2
  %t458 = select i1 %t457, i8* %t456, i8* %t455
  %t459 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t460 = icmp eq i32 %t448, 3
  %t461 = select i1 %t460, i8* %t459, i8* %t458
  %t462 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t463 = icmp eq i32 %t448, 4
  %t464 = select i1 %t463, i8* %t462, i8* %t461
  %t465 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t466 = icmp eq i32 %t448, 5
  %t467 = select i1 %t466, i8* %t465, i8* %t464
  %t468 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t469 = icmp eq i32 %t448, 6
  %t470 = select i1 %t469, i8* %t468, i8* %t467
  %t471 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t472 = icmp eq i32 %t448, 7
  %t473 = select i1 %t472, i8* %t471, i8* %t470
  %t474 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t475 = icmp eq i32 %t448, 8
  %t476 = select i1 %t475, i8* %t474, i8* %t473
  %t477 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t478 = icmp eq i32 %t448, 9
  %t479 = select i1 %t478, i8* %t477, i8* %t476
  %t480 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t481 = icmp eq i32 %t448, 10
  %t482 = select i1 %t481, i8* %t480, i8* %t479
  %t483 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t484 = icmp eq i32 %t448, 11
  %t485 = select i1 %t484, i8* %t483, i8* %t482
  %t486 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t487 = icmp eq i32 %t448, 12
  %t488 = select i1 %t487, i8* %t486, i8* %t485
  %t489 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t490 = icmp eq i32 %t448, 13
  %t491 = select i1 %t490, i8* %t489, i8* %t488
  %t492 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t493 = icmp eq i32 %t448, 14
  %t494 = select i1 %t493, i8* %t492, i8* %t491
  %t495 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t496 = icmp eq i32 %t448, 15
  %t497 = select i1 %t496, i8* %t495, i8* %t494
  %s498 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h826984377, i32 0, i32 0
  %t499 = call i1 @strings_equal(i8* %t497, i8* %s498)
  br i1 %t499, label %then24, label %merge25
then24:
  %t500 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t501 = ptrtoint [0 x %EffectRequirement]* %t500 to i64
  %t502 = icmp eq i64 %t501, 0
  %t503 = select i1 %t502, i64 1, i64 %t501
  %t504 = call i8* @malloc(i64 %t503)
  %t505 = bitcast i8* %t504 to %EffectRequirement*
  %t506 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t507 = ptrtoint { %EffectRequirement*, i64 }* %t506 to i64
  %t508 = call i8* @malloc(i64 %t507)
  %t509 = bitcast i8* %t508 to { %EffectRequirement*, i64 }*
  %t510 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t509, i32 0, i32 0
  store %EffectRequirement* %t505, %EffectRequirement** %t510
  %t511 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t509, i32 0, i32 1
  store i64 0, i64* %t511
  store { %EffectRequirement*, i64 }* %t509, { %EffectRequirement*, i64 }** %l5
  %t512 = sitofp i64 0 to double
  store double %t512, double* %l6
  %t513 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t514 = load double, double* %l6
  br label %loop.header26
loop.header26:
  %t574 = phi { %EffectRequirement*, i64 }* [ %t513, %then24 ], [ %t572, %loop.latch28 ]
  %t575 = phi double [ %t514, %then24 ], [ %t573, %loop.latch28 ]
  store { %EffectRequirement*, i64 }* %t574, { %EffectRequirement*, i64 }** %l5
  store double %t575, double* %l6
  br label %loop.body27
loop.body27:
  %t515 = load double, double* %l6
  %t516 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t517 = load i32, i32* %t516
  %t518 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t519 = bitcast [8 x i8]* %t518 to i8*
  %t520 = bitcast i8* %t519 to { %ObjectField*, i64 }**
  %t521 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t520
  %t522 = icmp eq i32 %t517, 11
  %t523 = select i1 %t522, { %ObjectField*, i64 }* %t521, { %ObjectField*, i64 }* null
  %t524 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t525 = bitcast [16 x i8]* %t524 to i8*
  %t526 = getelementptr inbounds i8, i8* %t525, i64 8
  %t527 = bitcast i8* %t526 to { %ObjectField*, i64 }**
  %t528 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t527
  %t529 = icmp eq i32 %t517, 12
  %t530 = select i1 %t529, { %ObjectField*, i64 }* %t528, { %ObjectField*, i64 }* %t523
  %t531 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t530
  %t532 = extractvalue { %ObjectField*, i64 } %t531, 1
  %t533 = sitofp i64 %t532 to double
  %t534 = fcmp oge double %t515, %t533
  %t535 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t536 = load double, double* %l6
  br i1 %t534, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t537 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t538 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t539 = load i32, i32* %t538
  %t540 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t541 = bitcast [8 x i8]* %t540 to i8*
  %t542 = bitcast i8* %t541 to { %ObjectField*, i64 }**
  %t543 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t542
  %t544 = icmp eq i32 %t539, 11
  %t545 = select i1 %t544, { %ObjectField*, i64 }* %t543, { %ObjectField*, i64 }* null
  %t546 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t547 = bitcast [16 x i8]* %t546 to i8*
  %t548 = getelementptr inbounds i8, i8* %t547, i64 8
  %t549 = bitcast i8* %t548 to { %ObjectField*, i64 }**
  %t550 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t549
  %t551 = icmp eq i32 %t539, 12
  %t552 = select i1 %t551, { %ObjectField*, i64 }* %t550, { %ObjectField*, i64 }* %t545
  %t553 = load double, double* %l6
  %t554 = call double @llvm.round.f64(double %t553)
  %t555 = fptosi double %t554 to i64
  %t556 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t552
  %t557 = extractvalue { %ObjectField*, i64 } %t556, 0
  %t558 = extractvalue { %ObjectField*, i64 } %t556, 1
  %t559 = icmp uge i64 %t555, %t558
  ; bounds check: %t559 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t555, i64 %t558)
  %t560 = getelementptr %ObjectField, %ObjectField* %t557, i64 %t555
  %t561 = load %ObjectField, %ObjectField* %t560
  %t562 = extractvalue %ObjectField %t561, 1
  %t563 = getelementptr %Expression, %Expression* null, i32 1
  %t564 = ptrtoint %Expression* %t563 to i64
  %t565 = call noalias i8* @malloc(i64 %t564)
  %t566 = bitcast i8* %t565 to %Expression*
  store %Expression %t562, %Expression* %t566
  call void @sailfin_runtime_mark_persistent(i8* %t565)
  %t567 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t566)
  %t568 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t537, { %EffectRequirement*, i64 }* %t567)
  store { %EffectRequirement*, i64 }* %t568, { %EffectRequirement*, i64 }** %l5
  %t569 = load double, double* %l6
  %t570 = sitofp i64 1 to double
  %t571 = fadd double %t569, %t570
  store double %t571, double* %l6
  br label %loop.latch28
loop.latch28:
  %t572 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t573 = load double, double* %l6
  br label %loop.header26
afterloop29:
  %t576 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t577 = load double, double* %l6
  %t578 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t578
merge25:
  %t579 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t580 = load i32, i32* %t579
  %t581 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t582 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t580, 0
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t580, 1
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t580, 2
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %t591 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t592 = icmp eq i32 %t580, 3
  %t593 = select i1 %t592, i8* %t591, i8* %t590
  %t594 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t595 = icmp eq i32 %t580, 4
  %t596 = select i1 %t595, i8* %t594, i8* %t593
  %t597 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t598 = icmp eq i32 %t580, 5
  %t599 = select i1 %t598, i8* %t597, i8* %t596
  %t600 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t601 = icmp eq i32 %t580, 6
  %t602 = select i1 %t601, i8* %t600, i8* %t599
  %t603 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t604 = icmp eq i32 %t580, 7
  %t605 = select i1 %t604, i8* %t603, i8* %t602
  %t606 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t607 = icmp eq i32 %t580, 8
  %t608 = select i1 %t607, i8* %t606, i8* %t605
  %t609 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t610 = icmp eq i32 %t580, 9
  %t611 = select i1 %t610, i8* %t609, i8* %t608
  %t612 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t613 = icmp eq i32 %t580, 10
  %t614 = select i1 %t613, i8* %t612, i8* %t611
  %t615 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t616 = icmp eq i32 %t580, 11
  %t617 = select i1 %t616, i8* %t615, i8* %t614
  %t618 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t619 = icmp eq i32 %t580, 12
  %t620 = select i1 %t619, i8* %t618, i8* %t617
  %t621 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t622 = icmp eq i32 %t580, 13
  %t623 = select i1 %t622, i8* %t621, i8* %t620
  %t624 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t625 = icmp eq i32 %t580, 14
  %t626 = select i1 %t625, i8* %t624, i8* %t623
  %t627 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t628 = icmp eq i32 %t580, 15
  %t629 = select i1 %t628, i8* %t627, i8* %t626
  %s630 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h264904746, i32 0, i32 0
  %t631 = call i1 @strings_equal(i8* %t629, i8* %s630)
  br i1 %t631, label %then32, label %merge33
then32:
  %t632 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t633 = ptrtoint [0 x %EffectRequirement]* %t632 to i64
  %t634 = icmp eq i64 %t633, 0
  %t635 = select i1 %t634, i64 1, i64 %t633
  %t636 = call i8* @malloc(i64 %t635)
  %t637 = bitcast i8* %t636 to %EffectRequirement*
  %t638 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t639 = ptrtoint { %EffectRequirement*, i64 }* %t638 to i64
  %t640 = call i8* @malloc(i64 %t639)
  %t641 = bitcast i8* %t640 to { %EffectRequirement*, i64 }*
  %t642 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t641, i32 0, i32 0
  store %EffectRequirement* %t637, %EffectRequirement** %t642
  %t643 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t641, i32 0, i32 1
  store i64 0, i64* %t643
  store { %EffectRequirement*, i64 }* %t641, { %EffectRequirement*, i64 }** %l7
  %t644 = sitofp i64 0 to double
  store double %t644, double* %l8
  %t645 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t646 = load double, double* %l8
  br label %loop.header34
loop.header34:
  %t706 = phi { %EffectRequirement*, i64 }* [ %t645, %then32 ], [ %t704, %loop.latch36 ]
  %t707 = phi double [ %t646, %then32 ], [ %t705, %loop.latch36 ]
  store { %EffectRequirement*, i64 }* %t706, { %EffectRequirement*, i64 }** %l7
  store double %t707, double* %l8
  br label %loop.body35
loop.body35:
  %t647 = load double, double* %l8
  %t648 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t649 = load i32, i32* %t648
  %t650 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t651 = bitcast [8 x i8]* %t650 to i8*
  %t652 = bitcast i8* %t651 to { %ObjectField*, i64 }**
  %t653 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t652
  %t654 = icmp eq i32 %t649, 11
  %t655 = select i1 %t654, { %ObjectField*, i64 }* %t653, { %ObjectField*, i64 }* null
  %t656 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t657 = bitcast [16 x i8]* %t656 to i8*
  %t658 = getelementptr inbounds i8, i8* %t657, i64 8
  %t659 = bitcast i8* %t658 to { %ObjectField*, i64 }**
  %t660 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t659
  %t661 = icmp eq i32 %t649, 12
  %t662 = select i1 %t661, { %ObjectField*, i64 }* %t660, { %ObjectField*, i64 }* %t655
  %t663 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t662
  %t664 = extractvalue { %ObjectField*, i64 } %t663, 1
  %t665 = sitofp i64 %t664 to double
  %t666 = fcmp oge double %t647, %t665
  %t667 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t668 = load double, double* %l8
  br i1 %t666, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t669 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t670 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t671 = load i32, i32* %t670
  %t672 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t673 = bitcast [8 x i8]* %t672 to i8*
  %t674 = bitcast i8* %t673 to { %ObjectField*, i64 }**
  %t675 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t674
  %t676 = icmp eq i32 %t671, 11
  %t677 = select i1 %t676, { %ObjectField*, i64 }* %t675, { %ObjectField*, i64 }* null
  %t678 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t679 = bitcast [16 x i8]* %t678 to i8*
  %t680 = getelementptr inbounds i8, i8* %t679, i64 8
  %t681 = bitcast i8* %t680 to { %ObjectField*, i64 }**
  %t682 = load { %ObjectField*, i64 }*, { %ObjectField*, i64 }** %t681
  %t683 = icmp eq i32 %t671, 12
  %t684 = select i1 %t683, { %ObjectField*, i64 }* %t682, { %ObjectField*, i64 }* %t677
  %t685 = load double, double* %l8
  %t686 = call double @llvm.round.f64(double %t685)
  %t687 = fptosi double %t686 to i64
  %t688 = load { %ObjectField*, i64 }, { %ObjectField*, i64 }* %t684
  %t689 = extractvalue { %ObjectField*, i64 } %t688, 0
  %t690 = extractvalue { %ObjectField*, i64 } %t688, 1
  %t691 = icmp uge i64 %t687, %t690
  ; bounds check: %t691 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t687, i64 %t690)
  %t692 = getelementptr %ObjectField, %ObjectField* %t689, i64 %t687
  %t693 = load %ObjectField, %ObjectField* %t692
  %t694 = extractvalue %ObjectField %t693, 1
  %t695 = getelementptr %Expression, %Expression* null, i32 1
  %t696 = ptrtoint %Expression* %t695 to i64
  %t697 = call noalias i8* @malloc(i64 %t696)
  %t698 = bitcast i8* %t697 to %Expression*
  store %Expression %t694, %Expression* %t698
  call void @sailfin_runtime_mark_persistent(i8* %t697)
  %t699 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t698)
  %t700 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t669, { %EffectRequirement*, i64 }* %t699)
  store { %EffectRequirement*, i64 }* %t700, { %EffectRequirement*, i64 }** %l7
  %t701 = load double, double* %l8
  %t702 = sitofp i64 1 to double
  %t703 = fadd double %t701, %t702
  store double %t703, double* %l8
  br label %loop.latch36
loop.latch36:
  %t704 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t705 = load double, double* %l8
  br label %loop.header34
afterloop37:
  %t708 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t709 = load double, double* %l8
  %t710 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t710
merge33:
  %t711 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t712 = load i32, i32* %t711
  %t713 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t714 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t712, 0
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t712, 1
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t712, 2
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t712, 3
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %t726 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t712, 4
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t712, 5
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t712, 6
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t712, 7
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t712, 8
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t712, 9
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t712, 10
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t712, 11
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t712, 12
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t712, 13
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %t756 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t757 = icmp eq i32 %t712, 14
  %t758 = select i1 %t757, i8* %t756, i8* %t755
  %t759 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t712, 15
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %s762 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1211862785, i32 0, i32 0
  %t763 = call i1 @strings_equal(i8* %t761, i8* %s762)
  br i1 %t763, label %then40, label %merge41
then40:
  %t764 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t765 = load i32, i32* %t764
  %t766 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t767 = bitcast [40 x i8]* %t766 to i8*
  %t768 = getelementptr inbounds i8, i8* %t767, i64 8
  %t769 = bitcast i8* %t768 to %Block*
  %t770 = load %Block, %Block* %t769
  %t771 = icmp eq i32 %t765, 13
  %t772 = select i1 %t771, %Block %t770, %Block zeroinitializer
  %t773 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t772)
  ret { %EffectRequirement*, i64 }* %t773
merge41:
  %t774 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t775 = load i32, i32* %t774
  %t776 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t777 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t775, 0
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t775, 1
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t775, 2
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t775, 3
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t775, 4
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t775, 5
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t775, 6
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t775, 7
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t775, 8
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t775, 9
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t775, 10
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t775, 11
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t775, 12
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t775, 13
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t775, 14
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t775, 15
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %s825 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h975618503, i32 0, i32 0
  %t826 = call i1 @strings_equal(i8* %t824, i8* %s825)
  br i1 %t826, label %then42, label %merge43
then42:
  %t827 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t828 = load i32, i32* %t827
  %t829 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t830 = bitcast [16 x i8]* %t829 to i8*
  %t831 = bitcast i8* %t830 to %Expression**
  %t832 = load %Expression*, %Expression** %t831
  %t833 = icmp eq i32 %t828, 9
  %t834 = select i1 %t833, %Expression* %t832, %Expression* null
  %t835 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t834)
  store { %EffectRequirement*, i64 }* %t835, { %EffectRequirement*, i64 }** %l9
  %t836 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t837 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t838 = load i32, i32* %t837
  %t839 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t840 = bitcast [16 x i8]* %t839 to i8*
  %t841 = getelementptr inbounds i8, i8* %t840, i64 8
  %t842 = bitcast i8* %t841 to %Expression**
  %t843 = load %Expression*, %Expression** %t842
  %t844 = icmp eq i32 %t838, 9
  %t845 = select i1 %t844, %Expression* %t843, %Expression* null
  %t846 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t845)
  %t847 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t836, { %EffectRequirement*, i64 }* %t846)
  store { %EffectRequirement*, i64 }* %t847, { %EffectRequirement*, i64 }** %l9
  %t848 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t848
merge43:
  %t849 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t850 = load i32, i32* %t849
  %t851 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t852 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t850, 0
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t850, 1
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t850, 2
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t850, 3
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t850, 4
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t850, 5
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t850, 6
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t850, 7
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t850, 8
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t850, 9
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t850, 10
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t850, 11
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t850, 12
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t850, 13
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t850, 14
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t850, 15
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %s900 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1312780988, i32 0, i32 0
  %t901 = call i1 @strings_equal(i8* %t899, i8* %s900)
  br i1 %t901, label %then44, label %merge45
then44:
  %t902 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t903 = load i32, i32* %t902
  %t904 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t905 = bitcast [16 x i8]* %t904 to i8*
  %t906 = bitcast i8* %t905 to %Expression**
  %t907 = load %Expression*, %Expression** %t906
  %t908 = icmp eq i32 %t903, 14
  %t909 = select i1 %t908, %Expression* %t907, %Expression* null
  %t910 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t909)
  store { %EffectRequirement*, i64 }* %t910, { %EffectRequirement*, i64 }** %l10
  %t911 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t912 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t913 = load i32, i32* %t912
  %t914 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t915 = bitcast [16 x i8]* %t914 to i8*
  %t916 = getelementptr inbounds i8, i8* %t915, i64 8
  %t917 = bitcast i8* %t916 to %Expression**
  %t918 = load %Expression*, %Expression** %t917
  %t919 = icmp eq i32 %t913, 14
  %t920 = select i1 %t919, %Expression* %t918, %Expression* null
  %t921 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t920)
  %t922 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t911, { %EffectRequirement*, i64 }* %t921)
  store { %EffectRequirement*, i64 }* %t922, { %EffectRequirement*, i64 }** %l10
  %t923 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t923
merge45:
  %t924 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t925 = load i32, i32* %t924
  %t926 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t927 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t925, 0
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t925, 1
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t925, 2
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t925, 3
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t925, 4
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t925, 5
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t925, 6
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t925, 7
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t925, 8
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t925, 9
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t925, 10
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t925, 11
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t925, 12
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t925, 13
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t925, 14
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t925, 15
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %s975 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089530004, i32 0, i32 0
  %t976 = call i1 @strings_equal(i8* %t974, i8* %s975)
  br i1 %t976, label %then46, label %merge47
then46:
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
merge47:
  %t989 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t990 = ptrtoint [0 x %EffectRequirement]* %t989 to i64
  %t991 = icmp eq i64 %t990, 0
  %t992 = select i1 %t991, i64 1, i64 %t990
  %t993 = call i8* @malloc(i64 %t992)
  %t994 = bitcast i8* %t993 to %EffectRequirement*
  %t995 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t996 = ptrtoint { %EffectRequirement*, i64 }* %t995 to i64
  %t997 = call i8* @malloc(i64 %t996)
  %t998 = bitcast i8* %t997 to { %EffectRequirement*, i64 }*
  %t999 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t998, i32 0, i32 0
  store %EffectRequirement* %t994, %EffectRequirement** %t999
  %t1000 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t998, i32 0, i32 1
  store i64 0, i64* %t1000
  ret { %EffectRequirement*, i64 }* %t998
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
  %t198 = phi { %EffectRequirement*, i64 }* [ %t1, %block.entry ], [ %t196, %loop.latch2 ]
  %t199 = phi double [ %t2, %block.entry ], [ %t197, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t198, { %EffectRequirement*, i64 }** %l0
  store double %t199, double* %l1
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
  %t117 = call i8* @token_text(%Token %t116)
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
  %t136 = add i64 0, 2
  %t137 = call i8* @malloc(i64 %t136)
  store i8 123, i8* %t137
  %t138 = getelementptr i8, i8* %t137, i64 1
  store i8 0, i8* %t138
  call void @sailfin_runtime_mark_persistent(i8* %t137)
  %t139 = call i1 @is_symbol_token(%Token %t135, i8* %t137)
  br label %logical_and_right_end_123

logical_and_right_end_123:
  br label %logical_and_merge_123

logical_and_merge_123:
  %t140 = phi i1 [ false, %logical_and_entry_123 ], [ %t139, %logical_and_right_end_123 ]
  %t141 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t142 = load double, double* %l1
  %t143 = load %Token, %Token* %l2
  %t144 = load double, double* %l3
  %t145 = load i8*, i8** %l4
  %t146 = load %Token, %Token* %l5
  %t147 = load double, double* %l6
  br i1 %t140, label %then12, label %merge13
then12:
  %t148 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s149 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t150 = insertvalue %EffectRequirement undef, i8* %s149, 0
  %t151 = load %Token, %Token* %l2
  %t152 = getelementptr %Token, %Token* null, i32 1
  %t153 = ptrtoint %Token* %t152 to i64
  %t154 = call noalias i8* @malloc(i64 %t153)
  %t155 = bitcast i8* %t154 to %Token*
  store %Token %t151, %Token* %t155
  call void @sailfin_runtime_mark_persistent(i8* %t154)
  %t156 = insertvalue %EffectRequirement %t150, %Token* %t155, 1
  %t157 = load i8*, i8** %l4
  %t158 = insertvalue %EffectRequirement %t156, i8* %t157, 2
  %t159 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t148, %EffectRequirement %t158)
  store { %EffectRequirement*, i64 }* %t159, { %EffectRequirement*, i64 }** %l0
  %t160 = load double, double* %l1
  %t161 = sitofp i64 1 to double
  %t162 = fadd double %t160, %t161
  store double %t162, double* %l1
  br label %loop.latch2
merge13:
  %t163 = load i8*, i8** %l4
  %t164 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t165 = load double, double* %l1
  br label %merge11
merge11:
  %t166 = phi i8* [ %t163, %merge13 ], [ %t113, %logical_or_merge_47 ]
  %t167 = phi { %EffectRequirement*, i64 }* [ %t164, %merge13 ], [ %t109, %logical_or_merge_47 ]
  %t168 = phi double [ %t165, %merge13 ], [ %t110, %logical_or_merge_47 ]
  store i8* %t166, i8** %l4
  store { %EffectRequirement*, i64 }* %t167, { %EffectRequirement*, i64 }** %l0
  store double %t168, double* %l1
  %t169 = load i8*, i8** %l4
  %t170 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t171 = load double, double* %l1
  br label %merge9
merge9:
  %t172 = phi i8* [ %t169, %merge11 ], [ %t37, %then6 ]
  %t173 = phi { %EffectRequirement*, i64 }* [ %t170, %merge11 ], [ %t33, %then6 ]
  %t174 = phi double [ %t171, %merge11 ], [ %t34, %then6 ]
  store i8* %t172, i8** %l4
  store { %EffectRequirement*, i64 }* %t173, { %EffectRequirement*, i64 }** %l0
  store double %t174, double* %l1
  %t175 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s176 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t177 = insertvalue %EffectRequirement undef, i8* %s176, 0
  %t178 = load %Token, %Token* %l2
  %t179 = getelementptr %Token, %Token* null, i32 1
  %t180 = ptrtoint %Token* %t179 to i64
  %t181 = call noalias i8* @malloc(i64 %t180)
  %t182 = bitcast i8* %t181 to %Token*
  store %Token %t178, %Token* %t182
  call void @sailfin_runtime_mark_persistent(i8* %t181)
  %t183 = insertvalue %EffectRequirement %t177, %Token* %t182, 1
  %t184 = load i8*, i8** %l4
  %t185 = insertvalue %EffectRequirement %t183, i8* %t184, 2
  %t186 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t175, %EffectRequirement %t185)
  store { %EffectRequirement*, i64 }* %t186, { %EffectRequirement*, i64 }** %l0
  %t187 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t188 = load double, double* %l1
  %t189 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t190 = phi { %EffectRequirement*, i64 }* [ %t187, %merge9 ], [ %t22, %merge5 ]
  %t191 = phi double [ %t188, %merge9 ], [ %t23, %merge5 ]
  %t192 = phi { %EffectRequirement*, i64 }* [ %t189, %merge9 ], [ %t22, %merge5 ]
  store { %EffectRequirement*, i64 }* %t190, { %EffectRequirement*, i64 }** %l0
  store double %t191, double* %l1
  store { %EffectRequirement*, i64 }* %t192, { %EffectRequirement*, i64 }** %l0
  %t193 = load double, double* %l1
  %t194 = sitofp i64 1 to double
  %t195 = fadd double %t193, %t194
  store double %t195, double* %l1
  br label %loop.latch2
loop.latch2:
  %t196 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t197 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t200 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t201 = load double, double* %l1
  %t202 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t202
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
@.str.len11.h1566780570 = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Expression.Range.variant = private unnamed_addr constant [6 x i8] c"Range\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len13.h590768815 = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Expression.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.str.len4.h217216103 = private unnamed_addr constant [5 x i8] c"Call\00"
@.enum.Expression.Index.variant = private unnamed_addr constant [6 x i8] c"Index\00"
@.str.len15.h571715647 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.str.len12.h1147459442 = private unnamed_addr constant [13 x i8] c"logExecution\00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.str.len16.h2043328844 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.enum.Expression.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Expression.Member.variant = private unnamed_addr constant [7 x i8] c"Member\00"
@.str.len19.h1204027478 = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.str.len12.h10983220 = private unnamed_addr constant [13 x i8] c"prompt block\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.str.len5.h667777838 = private unnamed_addr constant [6 x i8] c"Array\00"
@.str.len19.h479148896 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.enum.Expression.Call.variant = private unnamed_addr constant [5 x i8] c"Call\00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len5.h515589823 = private unnamed_addr constant [6 x i8] c"trace\00"
@.str.len5.h500835952 = private unnamed_addr constant [6 x i8] c"test \00"
@.str.len13.h1925822000 = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Expression.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.str.len14.h196308685 = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Expression.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len15.h1613933868 = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len15.h1067284810 = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Expression.Lambda.variant = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.str.len5.h975618503 = private unnamed_addr constant [6 x i8] c"Index\00"
@.str.len7.h48777630 = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len5.h1312780988 = private unnamed_addr constant [6 x i8] c"Range\00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.str.len6.h264904746 = private unnamed_addr constant [7 x i8] c"Struct\00"
@.str.len9.h1700456022 = private unnamed_addr constant [10 x i8] c"pipeline \00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Expression.NullLiteral.variant = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.enum.Expression.Struct.variant = private unnamed_addr constant [7 x i8] c"Struct\00"
@.str.len15.h889179835 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len6.h826984377 = private unnamed_addr constant [7 x i8] c"Object\00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.enum.Expression.Raw.variant = private unnamed_addr constant [4 x i8] c"Raw\00"
@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len6.h512390329 = private unnamed_addr constant [7 x i8] c"Member\00"
@.str.len12.h1170311443 = private unnamed_addr constant [13 x i8] c"logexecution\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len6.h1496334143 = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len5.h1445149598 = private unnamed_addr constant [6 x i8] c"Unary\00"
@.enum.Expression.Binary.variant = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.str.len6.h1128151960 = private unnamed_addr constant [7 x i8] c"prompt\00"
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.str.len6.h1211862785 = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.str.len5.h512542702 = private unnamed_addr constant [6 x i8] c"tool \00"
@.str.len3.h2089530004 = private unnamed_addr constant [4 x i8] c"Raw\00"
@.enum.Expression.Object.variant = private unnamed_addr constant [7 x i8] c"Object\00"
@.str.len12.h84042670 = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.str.len19.h868168677 = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.enum.Expression.Unary.variant = private unnamed_addr constant [6 x i8] c"Unary\00"
@.str.len10.h1576352120 = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.str.len5.h238194529 = private unnamed_addr constant [6 x i8] c"model\00"
@.str.len13.h1678412334 = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.enum.Expression.Array.variant = private unnamed_addr constant [6 x i8] c"Array\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len8.h196867800 = private unnamed_addr constant [9 x i8] c"prompt \22\00"
@.str.len7.h721793546 = private unnamed_addr constant [8 x i8] c"prompt \00"
@.enum.Expression.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"