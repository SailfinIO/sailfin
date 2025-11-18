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

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }
%LiteralValue = type { i32, [8 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

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
  %t42 = phi { %EffectViolation*, i64 }* [ %t13, %block.entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t14, %block.entry ], [ %t41, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t42, { %EffectViolation*, i64 }** %l0
  store double %t43, double* %l1
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
  %t25 = fptosi double %t24 to i64
  %t26 = load { %Statement**, i64 }, { %Statement**, i64 }* %t23
  %t27 = extractvalue { %Statement**, i64 } %t26, 0
  %t28 = extractvalue { %Statement**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %Statement*, %Statement** %t27, i64 %t25
  %t31 = load %Statement*, %Statement** %t30
  store %Statement* %t31, %Statement** %l2
  %t32 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t33 = load %Statement*, %Statement** %l2
  %t34 = load %Statement, %Statement* %t33
  %t35 = call { %EffectViolation*, i64 }* @analyze_statement(%Statement %t34)
  %t36 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t32, { %EffectViolation*, i64 }* %t35)
  store { %EffectViolation*, i64 }* %t36, { %EffectViolation*, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch2
loop.latch2:
  %t40 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t41 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t44 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t46
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
  %t72 = icmp eq i8* %t70, %s71
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [24 x i8]* %t75 to i8*
  %t77 = bitcast i8* %t76 to %FunctionSignature*
  %t78 = load %FunctionSignature, %FunctionSignature* %t77
  %t79 = icmp eq i32 %t73, 4
  %t80 = select i1 %t79, %FunctionSignature %t78, %FunctionSignature zeroinitializer
  %t81 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t82 = bitcast [24 x i8]* %t81 to i8*
  %t83 = bitcast i8* %t82 to %FunctionSignature*
  %t84 = load %FunctionSignature, %FunctionSignature* %t83
  %t85 = icmp eq i32 %t73, 5
  %t86 = select i1 %t85, %FunctionSignature %t84, %FunctionSignature %t80
  %t87 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t88 = bitcast [24 x i8]* %t87 to i8*
  %t89 = bitcast i8* %t88 to %FunctionSignature*
  %t90 = load %FunctionSignature, %FunctionSignature* %t89
  %t91 = icmp eq i32 %t73, 7
  %t92 = select i1 %t91, %FunctionSignature %t90, %FunctionSignature %t86
  %t93 = extractvalue %Statement %statement, 0
  %t94 = alloca %Statement
  store %Statement %statement, %Statement* %t94
  %t95 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t96 = bitcast [24 x i8]* %t95 to i8*
  %t97 = getelementptr inbounds i8, i8* %t96, i64 8
  %t98 = bitcast i8* %t97 to %Block*
  %t99 = load %Block, %Block* %t98
  %t100 = icmp eq i32 %t93, 4
  %t101 = select i1 %t100, %Block %t99, %Block zeroinitializer
  %t102 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t103 = bitcast [24 x i8]* %t102 to i8*
  %t104 = getelementptr inbounds i8, i8* %t103, i64 8
  %t105 = bitcast i8* %t104 to %Block*
  %t106 = load %Block, %Block* %t105
  %t107 = icmp eq i32 %t93, 5
  %t108 = select i1 %t107, %Block %t106, %Block %t101
  %t109 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t110 = bitcast [40 x i8]* %t109 to i8*
  %t111 = getelementptr inbounds i8, i8* %t110, i64 16
  %t112 = bitcast i8* %t111 to %Block*
  %t113 = load %Block, %Block* %t112
  %t114 = icmp eq i32 %t93, 6
  %t115 = select i1 %t114, %Block %t113, %Block %t108
  %t116 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t117 = bitcast [24 x i8]* %t116 to i8*
  %t118 = getelementptr inbounds i8, i8* %t117, i64 8
  %t119 = bitcast i8* %t118 to %Block*
  %t120 = load %Block, %Block* %t119
  %t121 = icmp eq i32 %t93, 7
  %t122 = select i1 %t121, %Block %t120, %Block %t115
  %t123 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t124 = bitcast [40 x i8]* %t123 to i8*
  %t125 = getelementptr inbounds i8, i8* %t124, i64 24
  %t126 = bitcast i8* %t125 to %Block*
  %t127 = load %Block, %Block* %t126
  %t128 = icmp eq i32 %t93, 12
  %t129 = select i1 %t128, %Block %t127, %Block %t122
  %t130 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t131 = bitcast [24 x i8]* %t130 to i8*
  %t132 = getelementptr inbounds i8, i8* %t131, i64 8
  %t133 = bitcast i8* %t132 to %Block*
  %t134 = load %Block, %Block* %t133
  %t135 = icmp eq i32 %t93, 13
  %t136 = select i1 %t135, %Block %t134, %Block %t129
  %t137 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t138 = bitcast [24 x i8]* %t137 to i8*
  %t139 = getelementptr inbounds i8, i8* %t138, i64 8
  %t140 = bitcast i8* %t139 to %Block*
  %t141 = load %Block, %Block* %t140
  %t142 = icmp eq i32 %t93, 14
  %t143 = select i1 %t142, %Block %t141, %Block %t136
  %t144 = getelementptr inbounds %Statement, %Statement* %t94, i32 0, i32 1
  %t145 = bitcast [16 x i8]* %t144 to i8*
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
  %t160 = bitcast [24 x i8]* %t159 to i8*
  %t161 = getelementptr inbounds i8, i8* %t160, i64 16
  %t162 = bitcast i8* %t161 to { %Decorator**, i64 }**
  %t163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t162
  %t164 = icmp eq i32 %t150, 4
  %t165 = select i1 %t164, { %Decorator**, i64 }* %t163, { %Decorator**, i64 }* %t158
  %t166 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t167 = bitcast [24 x i8]* %t166 to i8*
  %t168 = getelementptr inbounds i8, i8* %t167, i64 16
  %t169 = bitcast i8* %t168 to { %Decorator**, i64 }**
  %t170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t169
  %t171 = icmp eq i32 %t150, 5
  %t172 = select i1 %t171, { %Decorator**, i64 }* %t170, { %Decorator**, i64 }* %t165
  %t173 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t174 = bitcast [40 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 32
  %t176 = bitcast i8* %t175 to { %Decorator**, i64 }**
  %t177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t176
  %t178 = icmp eq i32 %t150, 6
  %t179 = select i1 %t178, { %Decorator**, i64 }* %t177, { %Decorator**, i64 }* %t172
  %t180 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t181 = bitcast [24 x i8]* %t180 to i8*
  %t182 = getelementptr inbounds i8, i8* %t181, i64 16
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
  %t216 = bitcast [40 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 32
  %t218 = bitcast i8* %t217 to { %Decorator**, i64 }**
  %t219 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t218
  %t220 = icmp eq i32 %t150, 12
  %t221 = select i1 %t220, { %Decorator**, i64 }* %t219, { %Decorator**, i64 }* %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t223 = bitcast [24 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 16
  %t225 = bitcast i8* %t224 to { %Decorator**, i64 }**
  %t226 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t225
  %t227 = icmp eq i32 %t150, 13
  %t228 = select i1 %t227, { %Decorator**, i64 }* %t226, { %Decorator**, i64 }* %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t230 = bitcast [24 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 16
  %t232 = bitcast i8* %t231 to { %Decorator**, i64 }**
  %t233 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t232
  %t234 = icmp eq i32 %t150, 14
  %t235 = select i1 %t234, { %Decorator**, i64 }* %t233, { %Decorator**, i64 }* %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t237 = bitcast [16 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 8
  %t239 = bitcast i8* %t238 to { %Decorator**, i64 }**
  %t240 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t239
  %t241 = icmp eq i32 %t150, 15
  %t242 = select i1 %t241, { %Decorator**, i64 }* %t240, { %Decorator**, i64 }* %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t244 = bitcast [24 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 16
  %t246 = bitcast i8* %t245 to { %Decorator**, i64 }**
  %t247 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t246
  %t248 = icmp eq i32 %t150, 18
  %t249 = select i1 %t248, { %Decorator**, i64 }* %t247, { %Decorator**, i64 }* %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t151, i32 0, i32 1
  %t251 = bitcast [32 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 24
  %t253 = bitcast i8* %t252 to { %Decorator**, i64 }**
  %t254 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t253
  %t255 = icmp eq i32 %t150, 19
  %t256 = select i1 %t255, { %Decorator**, i64 }* %t254, { %Decorator**, i64 }* %t249
  %t257 = extractvalue %Statement %statement, 0
  %t258 = alloca %Statement
  store %Statement %statement, %Statement* %t258
  %t259 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t260 = bitcast [24 x i8]* %t259 to i8*
  %t261 = bitcast i8* %t260 to %FunctionSignature*
  %t262 = load %FunctionSignature, %FunctionSignature* %t261
  %t263 = icmp eq i32 %t257, 4
  %t264 = select i1 %t263, %FunctionSignature %t262, %FunctionSignature zeroinitializer
  %t265 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t266 = bitcast [24 x i8]* %t265 to i8*
  %t267 = bitcast i8* %t266 to %FunctionSignature*
  %t268 = load %FunctionSignature, %FunctionSignature* %t267
  %t269 = icmp eq i32 %t257, 5
  %t270 = select i1 %t269, %FunctionSignature %t268, %FunctionSignature %t264
  %t271 = getelementptr inbounds %Statement, %Statement* %t258, i32 0, i32 1
  %t272 = bitcast [24 x i8]* %t271 to i8*
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
  %t352 = icmp eq i8* %t350, %s351
  br i1 %t352, label %then2, label %merge3
then2:
  %t353 = extractvalue %Statement %statement, 0
  %t354 = alloca %Statement
  store %Statement %statement, %Statement* %t354
  %t355 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t356 = bitcast [24 x i8]* %t355 to i8*
  %t357 = bitcast i8* %t356 to %FunctionSignature*
  %t358 = load %FunctionSignature, %FunctionSignature* %t357
  %t359 = icmp eq i32 %t353, 4
  %t360 = select i1 %t359, %FunctionSignature %t358, %FunctionSignature zeroinitializer
  %t361 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t362 = bitcast [24 x i8]* %t361 to i8*
  %t363 = bitcast i8* %t362 to %FunctionSignature*
  %t364 = load %FunctionSignature, %FunctionSignature* %t363
  %t365 = icmp eq i32 %t353, 5
  %t366 = select i1 %t365, %FunctionSignature %t364, %FunctionSignature %t360
  %t367 = getelementptr inbounds %Statement, %Statement* %t354, i32 0, i32 1
  %t368 = bitcast [24 x i8]* %t367 to i8*
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
  %t381 = bitcast [24 x i8]* %t380 to i8*
  %t382 = getelementptr inbounds i8, i8* %t381, i64 8
  %t383 = bitcast i8* %t382 to %Block*
  %t384 = load %Block, %Block* %t383
  %t385 = icmp eq i32 %t378, 4
  %t386 = select i1 %t385, %Block %t384, %Block zeroinitializer
  %t387 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t388 = bitcast [24 x i8]* %t387 to i8*
  %t389 = getelementptr inbounds i8, i8* %t388, i64 8
  %t390 = bitcast i8* %t389 to %Block*
  %t391 = load %Block, %Block* %t390
  %t392 = icmp eq i32 %t378, 5
  %t393 = select i1 %t392, %Block %t391, %Block %t386
  %t394 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t395 = bitcast [40 x i8]* %t394 to i8*
  %t396 = getelementptr inbounds i8, i8* %t395, i64 16
  %t397 = bitcast i8* %t396 to %Block*
  %t398 = load %Block, %Block* %t397
  %t399 = icmp eq i32 %t378, 6
  %t400 = select i1 %t399, %Block %t398, %Block %t393
  %t401 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t402 = bitcast [24 x i8]* %t401 to i8*
  %t403 = getelementptr inbounds i8, i8* %t402, i64 8
  %t404 = bitcast i8* %t403 to %Block*
  %t405 = load %Block, %Block* %t404
  %t406 = icmp eq i32 %t378, 7
  %t407 = select i1 %t406, %Block %t405, %Block %t400
  %t408 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t409 = bitcast [40 x i8]* %t408 to i8*
  %t410 = getelementptr inbounds i8, i8* %t409, i64 24
  %t411 = bitcast i8* %t410 to %Block*
  %t412 = load %Block, %Block* %t411
  %t413 = icmp eq i32 %t378, 12
  %t414 = select i1 %t413, %Block %t412, %Block %t407
  %t415 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t416 = bitcast [24 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 8
  %t418 = bitcast i8* %t417 to %Block*
  %t419 = load %Block, %Block* %t418
  %t420 = icmp eq i32 %t378, 13
  %t421 = select i1 %t420, %Block %t419, %Block %t414
  %t422 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t423 = bitcast [24 x i8]* %t422 to i8*
  %t424 = getelementptr inbounds i8, i8* %t423, i64 8
  %t425 = bitcast i8* %t424 to %Block*
  %t426 = load %Block, %Block* %t425
  %t427 = icmp eq i32 %t378, 14
  %t428 = select i1 %t427, %Block %t426, %Block %t421
  %t429 = getelementptr inbounds %Statement, %Statement* %t379, i32 0, i32 1
  %t430 = bitcast [16 x i8]* %t429 to i8*
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
  %t445 = bitcast [24 x i8]* %t444 to i8*
  %t446 = getelementptr inbounds i8, i8* %t445, i64 16
  %t447 = bitcast i8* %t446 to { %Decorator**, i64 }**
  %t448 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t447
  %t449 = icmp eq i32 %t435, 4
  %t450 = select i1 %t449, { %Decorator**, i64 }* %t448, { %Decorator**, i64 }* %t443
  %t451 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t452 = bitcast [24 x i8]* %t451 to i8*
  %t453 = getelementptr inbounds i8, i8* %t452, i64 16
  %t454 = bitcast i8* %t453 to { %Decorator**, i64 }**
  %t455 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t454
  %t456 = icmp eq i32 %t435, 5
  %t457 = select i1 %t456, { %Decorator**, i64 }* %t455, { %Decorator**, i64 }* %t450
  %t458 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t459 = bitcast [40 x i8]* %t458 to i8*
  %t460 = getelementptr inbounds i8, i8* %t459, i64 32
  %t461 = bitcast i8* %t460 to { %Decorator**, i64 }**
  %t462 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t461
  %t463 = icmp eq i32 %t435, 6
  %t464 = select i1 %t463, { %Decorator**, i64 }* %t462, { %Decorator**, i64 }* %t457
  %t465 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t466 = bitcast [24 x i8]* %t465 to i8*
  %t467 = getelementptr inbounds i8, i8* %t466, i64 16
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
  %t501 = bitcast [40 x i8]* %t500 to i8*
  %t502 = getelementptr inbounds i8, i8* %t501, i64 32
  %t503 = bitcast i8* %t502 to { %Decorator**, i64 }**
  %t504 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t503
  %t505 = icmp eq i32 %t435, 12
  %t506 = select i1 %t505, { %Decorator**, i64 }* %t504, { %Decorator**, i64 }* %t499
  %t507 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t508 = bitcast [24 x i8]* %t507 to i8*
  %t509 = getelementptr inbounds i8, i8* %t508, i64 16
  %t510 = bitcast i8* %t509 to { %Decorator**, i64 }**
  %t511 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t510
  %t512 = icmp eq i32 %t435, 13
  %t513 = select i1 %t512, { %Decorator**, i64 }* %t511, { %Decorator**, i64 }* %t506
  %t514 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t515 = bitcast [24 x i8]* %t514 to i8*
  %t516 = getelementptr inbounds i8, i8* %t515, i64 16
  %t517 = bitcast i8* %t516 to { %Decorator**, i64 }**
  %t518 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t517
  %t519 = icmp eq i32 %t435, 14
  %t520 = select i1 %t519, { %Decorator**, i64 }* %t518, { %Decorator**, i64 }* %t513
  %t521 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t522 = bitcast [16 x i8]* %t521 to i8*
  %t523 = getelementptr inbounds i8, i8* %t522, i64 8
  %t524 = bitcast i8* %t523 to { %Decorator**, i64 }**
  %t525 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t524
  %t526 = icmp eq i32 %t435, 15
  %t527 = select i1 %t526, { %Decorator**, i64 }* %t525, { %Decorator**, i64 }* %t520
  %t528 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t529 = bitcast [24 x i8]* %t528 to i8*
  %t530 = getelementptr inbounds i8, i8* %t529, i64 16
  %t531 = bitcast i8* %t530 to { %Decorator**, i64 }**
  %t532 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t531
  %t533 = icmp eq i32 %t435, 18
  %t534 = select i1 %t533, { %Decorator**, i64 }* %t532, { %Decorator**, i64 }* %t527
  %t535 = getelementptr inbounds %Statement, %Statement* %t436, i32 0, i32 1
  %t536 = bitcast [32 x i8]* %t535 to i8*
  %t537 = getelementptr inbounds i8, i8* %t536, i64 24
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
  %t617 = icmp eq i8* %t615, %s616
  br i1 %t617, label %then4, label %merge5
then4:
  %t618 = extractvalue %Statement %statement, 0
  %t619 = alloca %Statement
  store %Statement %statement, %Statement* %t619
  %t620 = getelementptr inbounds %Statement, %Statement* %t619, i32 0, i32 1
  %t621 = bitcast [24 x i8]* %t620 to i8*
  %t622 = bitcast i8* %t621 to %FunctionSignature*
  %t623 = load %FunctionSignature, %FunctionSignature* %t622
  %t624 = icmp eq i32 %t618, 4
  %t625 = select i1 %t624, %FunctionSignature %t623, %FunctionSignature zeroinitializer
  %t626 = getelementptr inbounds %Statement, %Statement* %t619, i32 0, i32 1
  %t627 = bitcast [24 x i8]* %t626 to i8*
  %t628 = bitcast i8* %t627 to %FunctionSignature*
  %t629 = load %FunctionSignature, %FunctionSignature* %t628
  %t630 = icmp eq i32 %t618, 5
  %t631 = select i1 %t630, %FunctionSignature %t629, %FunctionSignature %t625
  %t632 = getelementptr inbounds %Statement, %Statement* %t619, i32 0, i32 1
  %t633 = bitcast [24 x i8]* %t632 to i8*
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
  %t646 = bitcast [24 x i8]* %t645 to i8*
  %t647 = getelementptr inbounds i8, i8* %t646, i64 8
  %t648 = bitcast i8* %t647 to %Block*
  %t649 = load %Block, %Block* %t648
  %t650 = icmp eq i32 %t643, 4
  %t651 = select i1 %t650, %Block %t649, %Block zeroinitializer
  %t652 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t653 = bitcast [24 x i8]* %t652 to i8*
  %t654 = getelementptr inbounds i8, i8* %t653, i64 8
  %t655 = bitcast i8* %t654 to %Block*
  %t656 = load %Block, %Block* %t655
  %t657 = icmp eq i32 %t643, 5
  %t658 = select i1 %t657, %Block %t656, %Block %t651
  %t659 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t660 = bitcast [40 x i8]* %t659 to i8*
  %t661 = getelementptr inbounds i8, i8* %t660, i64 16
  %t662 = bitcast i8* %t661 to %Block*
  %t663 = load %Block, %Block* %t662
  %t664 = icmp eq i32 %t643, 6
  %t665 = select i1 %t664, %Block %t663, %Block %t658
  %t666 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t667 = bitcast [24 x i8]* %t666 to i8*
  %t668 = getelementptr inbounds i8, i8* %t667, i64 8
  %t669 = bitcast i8* %t668 to %Block*
  %t670 = load %Block, %Block* %t669
  %t671 = icmp eq i32 %t643, 7
  %t672 = select i1 %t671, %Block %t670, %Block %t665
  %t673 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t674 = bitcast [40 x i8]* %t673 to i8*
  %t675 = getelementptr inbounds i8, i8* %t674, i64 24
  %t676 = bitcast i8* %t675 to %Block*
  %t677 = load %Block, %Block* %t676
  %t678 = icmp eq i32 %t643, 12
  %t679 = select i1 %t678, %Block %t677, %Block %t672
  %t680 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t681 = bitcast [24 x i8]* %t680 to i8*
  %t682 = getelementptr inbounds i8, i8* %t681, i64 8
  %t683 = bitcast i8* %t682 to %Block*
  %t684 = load %Block, %Block* %t683
  %t685 = icmp eq i32 %t643, 13
  %t686 = select i1 %t685, %Block %t684, %Block %t679
  %t687 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t688 = bitcast [24 x i8]* %t687 to i8*
  %t689 = getelementptr inbounds i8, i8* %t688, i64 8
  %t690 = bitcast i8* %t689 to %Block*
  %t691 = load %Block, %Block* %t690
  %t692 = icmp eq i32 %t643, 14
  %t693 = select i1 %t692, %Block %t691, %Block %t686
  %t694 = getelementptr inbounds %Statement, %Statement* %t644, i32 0, i32 1
  %t695 = bitcast [16 x i8]* %t694 to i8*
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
  %t710 = bitcast [24 x i8]* %t709 to i8*
  %t711 = getelementptr inbounds i8, i8* %t710, i64 16
  %t712 = bitcast i8* %t711 to { %Decorator**, i64 }**
  %t713 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t712
  %t714 = icmp eq i32 %t700, 4
  %t715 = select i1 %t714, { %Decorator**, i64 }* %t713, { %Decorator**, i64 }* %t708
  %t716 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t717 = bitcast [24 x i8]* %t716 to i8*
  %t718 = getelementptr inbounds i8, i8* %t717, i64 16
  %t719 = bitcast i8* %t718 to { %Decorator**, i64 }**
  %t720 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t719
  %t721 = icmp eq i32 %t700, 5
  %t722 = select i1 %t721, { %Decorator**, i64 }* %t720, { %Decorator**, i64 }* %t715
  %t723 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t724 = bitcast [40 x i8]* %t723 to i8*
  %t725 = getelementptr inbounds i8, i8* %t724, i64 32
  %t726 = bitcast i8* %t725 to { %Decorator**, i64 }**
  %t727 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t726
  %t728 = icmp eq i32 %t700, 6
  %t729 = select i1 %t728, { %Decorator**, i64 }* %t727, { %Decorator**, i64 }* %t722
  %t730 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t731 = bitcast [24 x i8]* %t730 to i8*
  %t732 = getelementptr inbounds i8, i8* %t731, i64 16
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
  %t766 = bitcast [40 x i8]* %t765 to i8*
  %t767 = getelementptr inbounds i8, i8* %t766, i64 32
  %t768 = bitcast i8* %t767 to { %Decorator**, i64 }**
  %t769 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t768
  %t770 = icmp eq i32 %t700, 12
  %t771 = select i1 %t770, { %Decorator**, i64 }* %t769, { %Decorator**, i64 }* %t764
  %t772 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t773 = bitcast [24 x i8]* %t772 to i8*
  %t774 = getelementptr inbounds i8, i8* %t773, i64 16
  %t775 = bitcast i8* %t774 to { %Decorator**, i64 }**
  %t776 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t775
  %t777 = icmp eq i32 %t700, 13
  %t778 = select i1 %t777, { %Decorator**, i64 }* %t776, { %Decorator**, i64 }* %t771
  %t779 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t780 = bitcast [24 x i8]* %t779 to i8*
  %t781 = getelementptr inbounds i8, i8* %t780, i64 16
  %t782 = bitcast i8* %t781 to { %Decorator**, i64 }**
  %t783 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t782
  %t784 = icmp eq i32 %t700, 14
  %t785 = select i1 %t784, { %Decorator**, i64 }* %t783, { %Decorator**, i64 }* %t778
  %t786 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t787 = bitcast [16 x i8]* %t786 to i8*
  %t788 = getelementptr inbounds i8, i8* %t787, i64 8
  %t789 = bitcast i8* %t788 to { %Decorator**, i64 }**
  %t790 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t789
  %t791 = icmp eq i32 %t700, 15
  %t792 = select i1 %t791, { %Decorator**, i64 }* %t790, { %Decorator**, i64 }* %t785
  %t793 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t794 = bitcast [24 x i8]* %t793 to i8*
  %t795 = getelementptr inbounds i8, i8* %t794, i64 16
  %t796 = bitcast i8* %t795 to { %Decorator**, i64 }**
  %t797 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t796
  %t798 = icmp eq i32 %t700, 18
  %t799 = select i1 %t798, { %Decorator**, i64 }* %t797, { %Decorator**, i64 }* %t792
  %t800 = getelementptr inbounds %Statement, %Statement* %t701, i32 0, i32 1
  %t801 = bitcast [32 x i8]* %t800 to i8*
  %t802 = getelementptr inbounds i8, i8* %t801, i64 24
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
  %t882 = icmp eq i8* %t880, %s881
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
  %t898 = bitcast [40 x i8]* %t897 to i8*
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
  %t954 = bitcast [40 x i8]* %t953 to i8*
  %t955 = getelementptr inbounds i8, i8* %t954, i64 24
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
  %t992 = bitcast [40 x i8]* %t991 to i8*
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
  %t1026 = bitcast [24 x i8]* %t1025 to i8*
  %t1027 = getelementptr inbounds i8, i8* %t1026, i64 8
  %t1028 = bitcast i8* %t1027 to %Block*
  %t1029 = load %Block, %Block* %t1028
  %t1030 = icmp eq i32 %t1023, 4
  %t1031 = select i1 %t1030, %Block %t1029, %Block zeroinitializer
  %t1032 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1033 = bitcast [24 x i8]* %t1032 to i8*
  %t1034 = getelementptr inbounds i8, i8* %t1033, i64 8
  %t1035 = bitcast i8* %t1034 to %Block*
  %t1036 = load %Block, %Block* %t1035
  %t1037 = icmp eq i32 %t1023, 5
  %t1038 = select i1 %t1037, %Block %t1036, %Block %t1031
  %t1039 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1040 = bitcast [40 x i8]* %t1039 to i8*
  %t1041 = getelementptr inbounds i8, i8* %t1040, i64 16
  %t1042 = bitcast i8* %t1041 to %Block*
  %t1043 = load %Block, %Block* %t1042
  %t1044 = icmp eq i32 %t1023, 6
  %t1045 = select i1 %t1044, %Block %t1043, %Block %t1038
  %t1046 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1047 = bitcast [24 x i8]* %t1046 to i8*
  %t1048 = getelementptr inbounds i8, i8* %t1047, i64 8
  %t1049 = bitcast i8* %t1048 to %Block*
  %t1050 = load %Block, %Block* %t1049
  %t1051 = icmp eq i32 %t1023, 7
  %t1052 = select i1 %t1051, %Block %t1050, %Block %t1045
  %t1053 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1054 = bitcast [40 x i8]* %t1053 to i8*
  %t1055 = getelementptr inbounds i8, i8* %t1054, i64 24
  %t1056 = bitcast i8* %t1055 to %Block*
  %t1057 = load %Block, %Block* %t1056
  %t1058 = icmp eq i32 %t1023, 12
  %t1059 = select i1 %t1058, %Block %t1057, %Block %t1052
  %t1060 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1061 = bitcast [24 x i8]* %t1060 to i8*
  %t1062 = getelementptr inbounds i8, i8* %t1061, i64 8
  %t1063 = bitcast i8* %t1062 to %Block*
  %t1064 = load %Block, %Block* %t1063
  %t1065 = icmp eq i32 %t1023, 13
  %t1066 = select i1 %t1065, %Block %t1064, %Block %t1059
  %t1067 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1068 = bitcast [24 x i8]* %t1067 to i8*
  %t1069 = getelementptr inbounds i8, i8* %t1068, i64 8
  %t1070 = bitcast i8* %t1069 to %Block*
  %t1071 = load %Block, %Block* %t1070
  %t1072 = icmp eq i32 %t1023, 14
  %t1073 = select i1 %t1072, %Block %t1071, %Block %t1066
  %t1074 = getelementptr inbounds %Statement, %Statement* %t1024, i32 0, i32 1
  %t1075 = bitcast [16 x i8]* %t1074 to i8*
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
  %t1090 = bitcast [24 x i8]* %t1089 to i8*
  %t1091 = getelementptr inbounds i8, i8* %t1090, i64 16
  %t1092 = bitcast i8* %t1091 to { %Decorator**, i64 }**
  %t1093 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1092
  %t1094 = icmp eq i32 %t1080, 4
  %t1095 = select i1 %t1094, { %Decorator**, i64 }* %t1093, { %Decorator**, i64 }* %t1088
  %t1096 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1097 = bitcast [24 x i8]* %t1096 to i8*
  %t1098 = getelementptr inbounds i8, i8* %t1097, i64 16
  %t1099 = bitcast i8* %t1098 to { %Decorator**, i64 }**
  %t1100 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1099
  %t1101 = icmp eq i32 %t1080, 5
  %t1102 = select i1 %t1101, { %Decorator**, i64 }* %t1100, { %Decorator**, i64 }* %t1095
  %t1103 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1104 = bitcast [40 x i8]* %t1103 to i8*
  %t1105 = getelementptr inbounds i8, i8* %t1104, i64 32
  %t1106 = bitcast i8* %t1105 to { %Decorator**, i64 }**
  %t1107 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1106
  %t1108 = icmp eq i32 %t1080, 6
  %t1109 = select i1 %t1108, { %Decorator**, i64 }* %t1107, { %Decorator**, i64 }* %t1102
  %t1110 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1111 = bitcast [24 x i8]* %t1110 to i8*
  %t1112 = getelementptr inbounds i8, i8* %t1111, i64 16
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
  %t1146 = bitcast [40 x i8]* %t1145 to i8*
  %t1147 = getelementptr inbounds i8, i8* %t1146, i64 32
  %t1148 = bitcast i8* %t1147 to { %Decorator**, i64 }**
  %t1149 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1148
  %t1150 = icmp eq i32 %t1080, 12
  %t1151 = select i1 %t1150, { %Decorator**, i64 }* %t1149, { %Decorator**, i64 }* %t1144
  %t1152 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1153 = bitcast [24 x i8]* %t1152 to i8*
  %t1154 = getelementptr inbounds i8, i8* %t1153, i64 16
  %t1155 = bitcast i8* %t1154 to { %Decorator**, i64 }**
  %t1156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1155
  %t1157 = icmp eq i32 %t1080, 13
  %t1158 = select i1 %t1157, { %Decorator**, i64 }* %t1156, { %Decorator**, i64 }* %t1151
  %t1159 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1160 = bitcast [24 x i8]* %t1159 to i8*
  %t1161 = getelementptr inbounds i8, i8* %t1160, i64 16
  %t1162 = bitcast i8* %t1161 to { %Decorator**, i64 }**
  %t1163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1162
  %t1164 = icmp eq i32 %t1080, 14
  %t1165 = select i1 %t1164, { %Decorator**, i64 }* %t1163, { %Decorator**, i64 }* %t1158
  %t1166 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1167 = bitcast [16 x i8]* %t1166 to i8*
  %t1168 = getelementptr inbounds i8, i8* %t1167, i64 8
  %t1169 = bitcast i8* %t1168 to { %Decorator**, i64 }**
  %t1170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1169
  %t1171 = icmp eq i32 %t1080, 15
  %t1172 = select i1 %t1171, { %Decorator**, i64 }* %t1170, { %Decorator**, i64 }* %t1165
  %t1173 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1174 = bitcast [24 x i8]* %t1173 to i8*
  %t1175 = getelementptr inbounds i8, i8* %t1174, i64 16
  %t1176 = bitcast i8* %t1175 to { %Decorator**, i64 }**
  %t1177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1176
  %t1178 = icmp eq i32 %t1080, 18
  %t1179 = select i1 %t1178, { %Decorator**, i64 }* %t1177, { %Decorator**, i64 }* %t1172
  %t1180 = getelementptr inbounds %Statement, %Statement* %t1081, i32 0, i32 1
  %t1181 = bitcast [32 x i8]* %t1180 to i8*
  %t1182 = getelementptr inbounds i8, i8* %t1181, i64 24
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
  %t1262 = icmp eq i8* %t1260, %s1261
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
  %t1384 = phi { %EffectViolation*, i64 }* [ %t1276, %then8 ], [ %t1382, %loop.latch12 ]
  %t1385 = phi double [ %t1277, %then8 ], [ %t1383, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1384, { %EffectViolation*, i64 }** %l6
  store double %t1385, double* %l7
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
  %t1304 = fptosi double %t1303 to i64
  %t1305 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1302
  %t1306 = extractvalue { %MethodDeclaration**, i64 } %t1305, 0
  %t1307 = extractvalue { %MethodDeclaration**, i64 } %t1305, 1
  %t1308 = icmp uge i64 %t1304, %t1307
  ; bounds check: %t1308 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1304, i64 %t1307)
  %t1309 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1306, i64 %t1304
  %t1310 = load %MethodDeclaration*, %MethodDeclaration** %t1309
  store %MethodDeclaration* %t1310, %MethodDeclaration** %l8
  %t1311 = extractvalue %Statement %statement, 0
  %t1312 = alloca %Statement
  store %Statement %statement, %Statement* %t1312
  %t1313 = getelementptr inbounds %Statement, %Statement* %t1312, i32 0, i32 1
  %t1314 = bitcast [48 x i8]* %t1313 to i8*
  %t1315 = bitcast i8* %t1314 to i8**
  %t1316 = load i8*, i8** %t1315
  %t1317 = icmp eq i32 %t1311, 2
  %t1318 = select i1 %t1317, i8* %t1316, i8* null
  %t1319 = getelementptr inbounds %Statement, %Statement* %t1312, i32 0, i32 1
  %t1320 = bitcast [48 x i8]* %t1319 to i8*
  %t1321 = bitcast i8* %t1320 to i8**
  %t1322 = load i8*, i8** %t1321
  %t1323 = icmp eq i32 %t1311, 3
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1318
  %t1325 = getelementptr inbounds %Statement, %Statement* %t1312, i32 0, i32 1
  %t1326 = bitcast [40 x i8]* %t1325 to i8*
  %t1327 = bitcast i8* %t1326 to i8**
  %t1328 = load i8*, i8** %t1327
  %t1329 = icmp eq i32 %t1311, 6
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1324
  %t1331 = getelementptr inbounds %Statement, %Statement* %t1312, i32 0, i32 1
  %t1332 = bitcast [56 x i8]* %t1331 to i8*
  %t1333 = bitcast i8* %t1332 to i8**
  %t1334 = load i8*, i8** %t1333
  %t1335 = icmp eq i32 %t1311, 8
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1330
  %t1337 = getelementptr inbounds %Statement, %Statement* %t1312, i32 0, i32 1
  %t1338 = bitcast [40 x i8]* %t1337 to i8*
  %t1339 = bitcast i8* %t1338 to i8**
  %t1340 = load i8*, i8** %t1339
  %t1341 = icmp eq i32 %t1311, 9
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1336
  %t1343 = getelementptr inbounds %Statement, %Statement* %t1312, i32 0, i32 1
  %t1344 = bitcast [40 x i8]* %t1343 to i8*
  %t1345 = bitcast i8* %t1344 to i8**
  %t1346 = load i8*, i8** %t1345
  %t1347 = icmp eq i32 %t1311, 10
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1342
  %t1349 = getelementptr inbounds %Statement, %Statement* %t1312, i32 0, i32 1
  %t1350 = bitcast [40 x i8]* %t1349 to i8*
  %t1351 = bitcast i8* %t1350 to i8**
  %t1352 = load i8*, i8** %t1351
  %t1353 = icmp eq i32 %t1311, 11
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1348
  %t1355 = alloca [2 x i8], align 1
  %t1356 = getelementptr [2 x i8], [2 x i8]* %t1355, i32 0, i32 0
  store i8 46, i8* %t1356
  %t1357 = getelementptr [2 x i8], [2 x i8]* %t1355, i32 0, i32 1
  store i8 0, i8* %t1357
  %t1358 = getelementptr [2 x i8], [2 x i8]* %t1355, i32 0, i32 0
  %t1359 = call i8* @sailfin_runtime_string_concat(i8* %t1354, i8* %t1358)
  %t1360 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1361 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1360, i32 0, i32 0
  %t1362 = load %FunctionSignature, %FunctionSignature* %t1361
  %t1363 = extractvalue %FunctionSignature %t1362, 0
  %t1364 = call i8* @sailfin_runtime_string_concat(i8* %t1359, i8* %t1363)
  store i8* %t1364, i8** %l9
  %t1365 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1366 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1367 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1366, i32 0, i32 0
  %t1368 = load %FunctionSignature, %FunctionSignature* %t1367
  %t1369 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1370 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1369, i32 0, i32 1
  %t1371 = load %Block, %Block* %t1370
  %t1372 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1373 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1372, i32 0, i32 2
  %t1374 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1373
  %t1375 = load i8*, i8** %l9
  %t1376 = bitcast { %Decorator**, i64 }* %t1374 to { %Decorator*, i64 }*
  %t1377 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1368, %Block %t1371, { %Decorator*, i64 }* %t1376, i8* %t1375)
  %t1378 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t1365, { %EffectViolation*, i64 }* %t1377)
  store { %EffectViolation*, i64 }* %t1378, { %EffectViolation*, i64 }** %l6
  %t1379 = load double, double* %l7
  %t1380 = sitofp i64 1 to double
  %t1381 = fadd double %t1379, %t1380
  store double %t1381, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1382 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1383 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1386 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1387 = load double, double* %l7
  %t1388 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1388
merge9:
  %t1389 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t1390 = ptrtoint [0 x %EffectViolation]* %t1389 to i64
  %t1391 = icmp eq i64 %t1390, 0
  %t1392 = select i1 %t1391, i64 1, i64 %t1390
  %t1393 = call i8* @malloc(i64 %t1392)
  %t1394 = bitcast i8* %t1393 to %EffectViolation*
  %t1395 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t1396 = ptrtoint { %EffectViolation*, i64 }* %t1395 to i64
  %t1397 = call i8* @malloc(i64 %t1396)
  %t1398 = bitcast i8* %t1397 to { %EffectViolation*, i64 }*
  %t1399 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1398, i32 0, i32 0
  store %EffectViolation* %t1394, %EffectViolation** %t1399
  %t1400 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1398, i32 0, i32 1
  store i64 0, i64* %t1400
  ret { %EffectViolation*, i64 }* %t1398
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
  %t42 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t16, %block.entry ], [ %t41, %loop.latch2 ]
  store { i8**, i64 }* %t42, { i8**, i64 }** %l1
  store double %t43, double* %l2
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
  %t29 = fptosi double %t28 to i64
  %t30 = load { i8**, i64 }, { i8**, i64 }* %t27
  %t31 = extractvalue { i8**, i64 } %t30, 0
  %t32 = extractvalue { i8**, i64 } %t30, 1
  %t33 = icmp uge i64 %t29, %t32
  ; bounds check: %t33 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t29, i64 %t32)
  %t34 = getelementptr i8*, i8** %t31, i64 %t29
  %t35 = load i8*, i8** %t34
  %t36 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t26, i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l1
  %t37 = load double, double* %l2
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l2
  br label %loop.latch2
loop.latch2:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t45 = load double, double* %l2
  store i1 0, i1* %l3
  %t46 = sitofp i64 0 to double
  store double %t46, double* %l4
  %t47 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load double, double* %l2
  %t50 = load i1, i1* %l3
  %t51 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t99 = phi i1 [ %t50, %afterloop3 ], [ %t97, %loop.latch8 ]
  %t100 = phi double [ %t51, %afterloop3 ], [ %t98, %loop.latch8 ]
  store i1 %t99, i1* %l3
  store double %t100, double* %l4
  br label %loop.body7
loop.body7:
  %t52 = load double, double* %l4
  %t53 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t54 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t53
  %t55 = extractvalue { %DecoratorInfo*, i64 } %t54, 1
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t52, %t56
  %t58 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load double, double* %l2
  %t61 = load i1, i1* %l3
  %t62 = load double, double* %l4
  br i1 %t57, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t63 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t64 = load double, double* %l4
  %t65 = fptosi double %t64 to i64
  %t66 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t63
  %t67 = extractvalue { %DecoratorInfo*, i64 } %t66, 0
  %t68 = extractvalue { %DecoratorInfo*, i64 } %t66, 1
  %t69 = icmp uge i64 %t65, %t68
  ; bounds check: %t69 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t65, i64 %t68)
  %t70 = getelementptr %DecoratorInfo, %DecoratorInfo* %t67, i64 %t65
  %t71 = load %DecoratorInfo, %DecoratorInfo* %t70
  store %DecoratorInfo %t71, %DecoratorInfo* %l5
  %t73 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t74 = extractvalue %DecoratorInfo %t73, 0
  %s75 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h515589823, i32 0, i32 0
  %t76 = icmp eq i8* %t74, %s75
  br label %logical_or_entry_72

logical_or_entry_72:
  br i1 %t76, label %logical_or_merge_72, label %logical_or_right_72

logical_or_right_72:
  %t78 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t79 = extractvalue %DecoratorInfo %t78, 0
  %s80 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1147459442, i32 0, i32 0
  %t81 = icmp eq i8* %t79, %s80
  br label %logical_or_entry_77

logical_or_entry_77:
  br i1 %t81, label %logical_or_merge_77, label %logical_or_right_77

logical_or_right_77:
  %t82 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t83 = extractvalue %DecoratorInfo %t82, 0
  %s84 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1170311443, i32 0, i32 0
  %t85 = icmp eq i8* %t83, %s84
  br label %logical_or_right_end_77

logical_or_right_end_77:
  br label %logical_or_merge_77

logical_or_merge_77:
  %t86 = phi i1 [ true, %logical_or_entry_77 ], [ %t85, %logical_or_right_end_77 ]
  br label %logical_or_right_end_72

logical_or_right_end_72:
  br label %logical_or_merge_72

logical_or_merge_72:
  %t87 = phi i1 [ true, %logical_or_entry_72 ], [ %t86, %logical_or_right_end_72 ]
  %t88 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t90 = load double, double* %l2
  %t91 = load i1, i1* %l3
  %t92 = load double, double* %l4
  %t93 = load %DecoratorInfo, %DecoratorInfo* %l5
  br i1 %t87, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t94 = load double, double* %l4
  %t95 = sitofp i64 1 to double
  %t96 = fadd double %t94, %t95
  store double %t96, double* %l4
  br label %loop.latch8
loop.latch8:
  %t97 = load i1, i1* %l3
  %t98 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t101 = load i1, i1* %l3
  %t102 = load double, double* %l4
  %t103 = load i1, i1* %l3
  %t104 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load double, double* %l2
  %t107 = load i1, i1* %l3
  %t108 = load double, double* %l4
  br i1 %t103, label %then14, label %merge15
then14:
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s110 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t111 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t109, i8* %s110)
  store { i8**, i64 }* %t111, { i8**, i64 }** %l1
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t113 = phi { i8**, i64 }* [ %t112, %then14 ], [ %t105, %afterloop9 ]
  store { i8**, i64 }* %t113, { i8**, i64 }** %l1
  %t114 = call { %EffectRequirement*, i64 }* @required_effects(%Block %body)
  store { %EffectRequirement*, i64 }* %t114, { %EffectRequirement*, i64 }** %l6
  %t115 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t116 = ptrtoint [0 x i8*]* %t115 to i64
  %t117 = icmp eq i64 %t116, 0
  %t118 = select i1 %t117, i64 1, i64 %t116
  %t119 = call i8* @malloc(i64 %t118)
  %t120 = bitcast i8* %t119 to i8**
  %t121 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t122 = ptrtoint { i8**, i64 }* %t121 to i64
  %t123 = call i8* @malloc(i64 %t122)
  %t124 = bitcast i8* %t123 to { i8**, i64 }*
  %t125 = getelementptr { i8**, i64 }, { i8**, i64 }* %t124, i32 0, i32 0
  store i8** %t120, i8*** %t125
  %t126 = getelementptr { i8**, i64 }, { i8**, i64 }* %t124, i32 0, i32 1
  store i64 0, i64* %t126
  store { i8**, i64 }* %t124, { i8**, i64 }** %l7
  %t127 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t128 = ptrtoint [0 x %EffectRequirement]* %t127 to i64
  %t129 = icmp eq i64 %t128, 0
  %t130 = select i1 %t129, i64 1, i64 %t128
  %t131 = call i8* @malloc(i64 %t130)
  %t132 = bitcast i8* %t131 to %EffectRequirement*
  %t133 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t134 = ptrtoint { %EffectRequirement*, i64 }* %t133 to i64
  %t135 = call i8* @malloc(i64 %t134)
  %t136 = bitcast i8* %t135 to { %EffectRequirement*, i64 }*
  %t137 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t136, i32 0, i32 0
  store %EffectRequirement* %t132, %EffectRequirement** %t137
  %t138 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t136, i32 0, i32 1
  store i64 0, i64* %t138
  store { %EffectRequirement*, i64 }* %t136, { %EffectRequirement*, i64 }** %l8
  %t139 = sitofp i64 0 to double
  store double %t139, double* %l9
  %t140 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t142 = load double, double* %l2
  %t143 = load i1, i1* %l3
  %t144 = load double, double* %l4
  %t145 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t147 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t148 = load double, double* %l9
  br label %loop.header16
loop.header16:
  %t241 = phi double [ %t148, %merge15 ], [ %t238, %loop.latch18 ]
  %t242 = phi { i8**, i64 }* [ %t146, %merge15 ], [ %t239, %loop.latch18 ]
  %t243 = phi { %EffectRequirement*, i64 }* [ %t147, %merge15 ], [ %t240, %loop.latch18 ]
  store double %t241, double* %l9
  store { i8**, i64 }* %t242, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t243, { %EffectRequirement*, i64 }** %l8
  br label %loop.body17
loop.body17:
  %t149 = load double, double* %l9
  %t150 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t151 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t150
  %t152 = extractvalue { %EffectRequirement*, i64 } %t151, 1
  %t153 = sitofp i64 %t152 to double
  %t154 = fcmp oge double %t149, %t153
  %t155 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t157 = load double, double* %l2
  %t158 = load i1, i1* %l3
  %t159 = load double, double* %l4
  %t160 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t162 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t163 = load double, double* %l9
  br i1 %t154, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t164 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t165 = load double, double* %l9
  %t166 = fptosi double %t165 to i64
  %t167 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t164
  %t168 = extractvalue { %EffectRequirement*, i64 } %t167, 0
  %t169 = extractvalue { %EffectRequirement*, i64 } %t167, 1
  %t170 = icmp uge i64 %t166, %t169
  ; bounds check: %t170 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t166, i64 %t169)
  %t171 = getelementptr %EffectRequirement, %EffectRequirement* %t168, i64 %t166
  %t172 = load %EffectRequirement, %EffectRequirement* %t171
  store %EffectRequirement %t172, %EffectRequirement* %l10
  %t173 = load %EffectRequirement, %EffectRequirement* %l10
  %t174 = extractvalue %EffectRequirement %t173, 0
  store i8* %t174, i8** %l11
  %t176 = load i8*, i8** %l11
  %s177 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193495007, i32 0, i32 0
  %t178 = icmp eq i8* %t176, %s177
  br label %logical_and_entry_175

logical_and_entry_175:
  br i1 %t178, label %logical_and_right_175, label %logical_and_merge_175

logical_and_right_175:
  %t179 = load i1, i1* %l3
  br label %logical_and_right_end_175

logical_and_right_end_175:
  br label %logical_and_merge_175

logical_and_merge_175:
  %t180 = phi i1 [ false, %logical_and_entry_175 ], [ %t179, %logical_and_right_end_175 ]
  %t181 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t183 = load double, double* %l2
  %t184 = load i1, i1* %l3
  %t185 = load double, double* %l4
  %t186 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t188 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t189 = load double, double* %l9
  %t190 = load %EffectRequirement, %EffectRequirement* %l10
  %t191 = load i8*, i8** %l11
  br i1 %t180, label %then22, label %merge23
then22:
  %t192 = load double, double* %l9
  %t193 = sitofp i64 1 to double
  %t194 = fadd double %t192, %t193
  store double %t194, double* %l9
  br label %loop.latch18
merge23:
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t196 = load i8*, i8** %l11
  %t197 = call i1 @contains_effect({ i8**, i64 }* %t195, i8* %t196)
  %t198 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t200 = load double, double* %l2
  %t201 = load i1, i1* %l3
  %t202 = load double, double* %l4
  %t203 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t205 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t206 = load double, double* %l9
  %t207 = load %EffectRequirement, %EffectRequirement* %l10
  %t208 = load i8*, i8** %l11
  br i1 %t197, label %then24, label %merge25
then24:
  %t209 = load double, double* %l9
  %t210 = sitofp i64 1 to double
  %t211 = fadd double %t209, %t210
  store double %t211, double* %l9
  br label %loop.latch18
merge25:
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t213 = load i8*, i8** %l11
  %t214 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t212, i8* %t213)
  store { i8**, i64 }* %t214, { i8**, i64 }** %l7
  %t215 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t216 = load i8*, i8** %l11
  %t217 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t215, i8* %t216)
  %t218 = xor i1 %t217, 1
  %t219 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t221 = load double, double* %l2
  %t222 = load i1, i1* %l3
  %t223 = load double, double* %l4
  %t224 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t226 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t227 = load double, double* %l9
  %t228 = load %EffectRequirement, %EffectRequirement* %l10
  %t229 = load i8*, i8** %l11
  br i1 %t218, label %then26, label %merge27
then26:
  %t230 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t231 = load %EffectRequirement, %EffectRequirement* %l10
  %t232 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t230, %EffectRequirement %t231)
  store { %EffectRequirement*, i64 }* %t232, { %EffectRequirement*, i64 }** %l8
  %t233 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %merge27
merge27:
  %t234 = phi { %EffectRequirement*, i64 }* [ %t233, %then26 ], [ %t226, %merge25 ]
  store { %EffectRequirement*, i64 }* %t234, { %EffectRequirement*, i64 }** %l8
  %t235 = load double, double* %l9
  %t236 = sitofp i64 1 to double
  %t237 = fadd double %t235, %t236
  store double %t237, double* %l9
  br label %loop.latch18
loop.latch18:
  %t238 = load double, double* %l9
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t240 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header16
afterloop19:
  %t244 = load double, double* %l9
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t246 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t248 = load { i8**, i64 }, { i8**, i64 }* %t247
  %t249 = extractvalue { i8**, i64 } %t248, 1
  %t250 = icmp eq i64 %t249, 0
  %t251 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t253 = load double, double* %l2
  %t254 = load i1, i1* %l3
  %t255 = load double, double* %l4
  %t256 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t258 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t259 = load double, double* %l9
  br i1 %t250, label %then28, label %merge29
then28:
  %t260 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t261 = ptrtoint [0 x %EffectViolation]* %t260 to i64
  %t262 = icmp eq i64 %t261, 0
  %t263 = select i1 %t262, i64 1, i64 %t261
  %t264 = call i8* @malloc(i64 %t263)
  %t265 = bitcast i8* %t264 to %EffectViolation*
  %t266 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t267 = ptrtoint { %EffectViolation*, i64 }* %t266 to i64
  %t268 = call i8* @malloc(i64 %t267)
  %t269 = bitcast i8* %t268 to { %EffectViolation*, i64 }*
  %t270 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t269, i32 0, i32 0
  store %EffectViolation* %t265, %EffectViolation** %t270
  %t271 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t269, i32 0, i32 1
  store i64 0, i64* %t271
  ret { %EffectViolation*, i64 }* %t269
merge29:
  %t272 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* null, i32 1
  %t273 = ptrtoint [0 x %EffectViolation]* %t272 to i64
  %t274 = icmp eq i64 %t273, 0
  %t275 = select i1 %t274, i64 1, i64 %t273
  %t276 = call i8* @malloc(i64 %t275)
  %t277 = bitcast i8* %t276 to %EffectViolation*
  %t278 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* null, i32 1
  %t279 = ptrtoint { %EffectViolation*, i64 }* %t278 to i64
  %t280 = call i8* @malloc(i64 %t279)
  %t281 = bitcast i8* %t280 to { %EffectViolation*, i64 }*
  %t282 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t281, i32 0, i32 0
  store %EffectViolation* %t277, %EffectViolation** %t282
  %t283 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t281, i32 0, i32 1
  store i64 0, i64* %t283
  store { %EffectViolation*, i64 }* %t281, { %EffectViolation*, i64 }** %l12
  %t284 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  %t285 = insertvalue %EffectViolation undef, i8* %name, 0
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t287 = insertvalue %EffectViolation %t285, { i8**, i64 }* %t286, 1
  %t288 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t289 = bitcast { %EffectRequirement*, i64 }* %t288 to { %EffectRequirement**, i64 }*
  %t290 = insertvalue %EffectViolation %t287, { %EffectRequirement**, i64 }* %t289, 2
  %t291 = call { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %t284, %EffectViolation %t290)
  store { %EffectViolation*, i64 }* %t291, { %EffectViolation*, i64 }** %l12
  %t292 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t292
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
  %t32 = phi { %EffectRequirement*, i64 }* [ %t4, %block.entry ], [ %t30, %loop.latch2 ]
  %t33 = phi double [ %t5, %block.entry ], [ %t31, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t32, { %EffectRequirement*, i64 }** %l0
  store double %t33, double* %l1
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
  %t17 = fptosi double %t16 to i64
  %t18 = load { %Statement**, i64 }, { %Statement**, i64 }* %t15
  %t19 = extractvalue { %Statement**, i64 } %t18, 0
  %t20 = extractvalue { %Statement**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t17, i64 %t20)
  %t22 = getelementptr %Statement*, %Statement** %t19, i64 %t17
  %t23 = load %Statement*, %Statement** %t22
  %t24 = load %Statement, %Statement* %t23
  %t25 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %t24)
  %t26 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t14, { %EffectRequirement*, i64 }* %t25)
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l0
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l1
  br label %loop.latch2
loop.latch2:
  %t30 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t31 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t34 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t36
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
  %t72 = icmp eq i8* %t70, %s71
  br i1 %t72, label %then0, label %merge1
then0:
  %t73 = extractvalue %Statement %statement, 0
  %t74 = alloca %Statement
  store %Statement %statement, %Statement* %t74
  %t75 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t76 = bitcast [24 x i8]* %t75 to i8*
  %t77 = getelementptr inbounds i8, i8* %t76, i64 8
  %t78 = bitcast i8* %t77 to %Block*
  %t79 = load %Block, %Block* %t78
  %t80 = icmp eq i32 %t73, 4
  %t81 = select i1 %t80, %Block %t79, %Block zeroinitializer
  %t82 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t83 = bitcast [24 x i8]* %t82 to i8*
  %t84 = getelementptr inbounds i8, i8* %t83, i64 8
  %t85 = bitcast i8* %t84 to %Block*
  %t86 = load %Block, %Block* %t85
  %t87 = icmp eq i32 %t73, 5
  %t88 = select i1 %t87, %Block %t86, %Block %t81
  %t89 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t90 = bitcast [40 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 16
  %t92 = bitcast i8* %t91 to %Block*
  %t93 = load %Block, %Block* %t92
  %t94 = icmp eq i32 %t73, 6
  %t95 = select i1 %t94, %Block %t93, %Block %t88
  %t96 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t97 = bitcast [24 x i8]* %t96 to i8*
  %t98 = getelementptr inbounds i8, i8* %t97, i64 8
  %t99 = bitcast i8* %t98 to %Block*
  %t100 = load %Block, %Block* %t99
  %t101 = icmp eq i32 %t73, 7
  %t102 = select i1 %t101, %Block %t100, %Block %t95
  %t103 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t104 = bitcast [40 x i8]* %t103 to i8*
  %t105 = getelementptr inbounds i8, i8* %t104, i64 24
  %t106 = bitcast i8* %t105 to %Block*
  %t107 = load %Block, %Block* %t106
  %t108 = icmp eq i32 %t73, 12
  %t109 = select i1 %t108, %Block %t107, %Block %t102
  %t110 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t111 = bitcast [24 x i8]* %t110 to i8*
  %t112 = getelementptr inbounds i8, i8* %t111, i64 8
  %t113 = bitcast i8* %t112 to %Block*
  %t114 = load %Block, %Block* %t113
  %t115 = icmp eq i32 %t73, 13
  %t116 = select i1 %t115, %Block %t114, %Block %t109
  %t117 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t118 = bitcast [24 x i8]* %t117 to i8*
  %t119 = getelementptr inbounds i8, i8* %t118, i64 8
  %t120 = bitcast i8* %t119 to %Block*
  %t121 = load %Block, %Block* %t120
  %t122 = icmp eq i32 %t73, 14
  %t123 = select i1 %t122, %Block %t121, %Block %t116
  %t124 = getelementptr inbounds %Statement, %Statement* %t74, i32 0, i32 1
  %t125 = bitcast [16 x i8]* %t124 to i8*
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
  %t137 = bitcast [40 x i8]* %t136 to i8*
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
  %t149 = bitcast [40 x i8]* %t148 to i8*
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
  %t235 = icmp eq i8* %t233, %s234
  br i1 %t235, label %then2, label %merge3
then2:
  %t236 = extractvalue %Statement %statement, 0
  %t237 = alloca %Statement
  store %Statement %statement, %Statement* %t237
  %t238 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t239 = bitcast [24 x i8]* %t238 to i8*
  %t240 = getelementptr inbounds i8, i8* %t239, i64 8
  %t241 = bitcast i8* %t240 to %Block*
  %t242 = load %Block, %Block* %t241
  %t243 = icmp eq i32 %t236, 4
  %t244 = select i1 %t243, %Block %t242, %Block zeroinitializer
  %t245 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t246 = bitcast [24 x i8]* %t245 to i8*
  %t247 = getelementptr inbounds i8, i8* %t246, i64 8
  %t248 = bitcast i8* %t247 to %Block*
  %t249 = load %Block, %Block* %t248
  %t250 = icmp eq i32 %t236, 5
  %t251 = select i1 %t250, %Block %t249, %Block %t244
  %t252 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t253 = bitcast [40 x i8]* %t252 to i8*
  %t254 = getelementptr inbounds i8, i8* %t253, i64 16
  %t255 = bitcast i8* %t254 to %Block*
  %t256 = load %Block, %Block* %t255
  %t257 = icmp eq i32 %t236, 6
  %t258 = select i1 %t257, %Block %t256, %Block %t251
  %t259 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t260 = bitcast [24 x i8]* %t259 to i8*
  %t261 = getelementptr inbounds i8, i8* %t260, i64 8
  %t262 = bitcast i8* %t261 to %Block*
  %t263 = load %Block, %Block* %t262
  %t264 = icmp eq i32 %t236, 7
  %t265 = select i1 %t264, %Block %t263, %Block %t258
  %t266 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t267 = bitcast [40 x i8]* %t266 to i8*
  %t268 = getelementptr inbounds i8, i8* %t267, i64 24
  %t269 = bitcast i8* %t268 to %Block*
  %t270 = load %Block, %Block* %t269
  %t271 = icmp eq i32 %t236, 12
  %t272 = select i1 %t271, %Block %t270, %Block %t265
  %t273 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t274 = bitcast [24 x i8]* %t273 to i8*
  %t275 = getelementptr inbounds i8, i8* %t274, i64 8
  %t276 = bitcast i8* %t275 to %Block*
  %t277 = load %Block, %Block* %t276
  %t278 = icmp eq i32 %t236, 13
  %t279 = select i1 %t278, %Block %t277, %Block %t272
  %t280 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t281 = bitcast [24 x i8]* %t280 to i8*
  %t282 = getelementptr inbounds i8, i8* %t281, i64 8
  %t283 = bitcast i8* %t282 to %Block*
  %t284 = load %Block, %Block* %t283
  %t285 = icmp eq i32 %t236, 14
  %t286 = select i1 %t285, %Block %t284, %Block %t279
  %t287 = getelementptr inbounds %Statement, %Statement* %t237, i32 0, i32 1
  %t288 = bitcast [16 x i8]* %t287 to i8*
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
  %t340 = phi { %EffectRequirement*, i64 }* [ %t295, %then2 ], [ %t338, %loop.latch6 ]
  %t341 = phi double [ %t296, %then2 ], [ %t339, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t340, { %EffectRequirement*, i64 }** %l1
  store double %t341, double* %l2
  br label %loop.body5
loop.body5:
  %t297 = load double, double* %l2
  %t298 = extractvalue %Statement %statement, 0
  %t299 = alloca %Statement
  store %Statement %statement, %Statement* %t299
  %t300 = getelementptr inbounds %Statement, %Statement* %t299, i32 0, i32 1
  %t301 = bitcast [24 x i8]* %t300 to i8*
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
  %t315 = bitcast [24 x i8]* %t314 to i8*
  %t316 = bitcast i8* %t315 to { %WithClause**, i64 }**
  %t317 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t316
  %t318 = icmp eq i32 %t312, 13
  %t319 = select i1 %t318, { %WithClause**, i64 }* %t317, { %WithClause**, i64 }* null
  %t320 = load double, double* %l2
  %t321 = fptosi double %t320 to i64
  %t322 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t319
  %t323 = extractvalue { %WithClause**, i64 } %t322, 0
  %t324 = extractvalue { %WithClause**, i64 } %t322, 1
  %t325 = icmp uge i64 %t321, %t324
  ; bounds check: %t325 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t321, i64 %t324)
  %t326 = getelementptr %WithClause*, %WithClause** %t323, i64 %t321
  %t327 = load %WithClause*, %WithClause** %t326
  store %WithClause* %t327, %WithClause** %l3
  %t328 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t329 = load %WithClause*, %WithClause** %l3
  %t330 = getelementptr %WithClause, %WithClause* %t329, i32 0, i32 0
  %t331 = load %Expression, %Expression* %t330
  %t332 = alloca %Expression
  store %Expression %t331, %Expression* %t332
  %t333 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t332)
  %t334 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t328, { %EffectRequirement*, i64 }* %t333)
  store { %EffectRequirement*, i64 }* %t334, { %EffectRequirement*, i64 }** %l1
  %t335 = load double, double* %l2
  %t336 = sitofp i64 1 to double
  %t337 = fadd double %t335, %t336
  store double %t337, double* %l2
  br label %loop.latch6
loop.latch6:
  %t338 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t339 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t342 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t343 = load double, double* %l2
  %t344 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t344
merge3:
  %t345 = extractvalue %Statement %statement, 0
  %t346 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t347 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t345, 0
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t345, 1
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t345, 2
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t345, 3
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t345, 4
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t345, 5
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t345, 6
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t345, 7
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t345, 8
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t345, 9
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t345, 10
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t345, 11
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %t383 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t384 = icmp eq i32 %t345, 12
  %t385 = select i1 %t384, i8* %t383, i8* %t382
  %t386 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t387 = icmp eq i32 %t345, 13
  %t388 = select i1 %t387, i8* %t386, i8* %t385
  %t389 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t390 = icmp eq i32 %t345, 14
  %t391 = select i1 %t390, i8* %t389, i8* %t388
  %t392 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t393 = icmp eq i32 %t345, 15
  %t394 = select i1 %t393, i8* %t392, i8* %t391
  %t395 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t396 = icmp eq i32 %t345, 16
  %t397 = select i1 %t396, i8* %t395, i8* %t394
  %t398 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t399 = icmp eq i32 %t345, 17
  %t400 = select i1 %t399, i8* %t398, i8* %t397
  %t401 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t402 = icmp eq i32 %t345, 18
  %t403 = select i1 %t402, i8* %t401, i8* %t400
  %t404 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t405 = icmp eq i32 %t345, 19
  %t406 = select i1 %t405, i8* %t404, i8* %t403
  %t407 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t408 = icmp eq i32 %t345, 20
  %t409 = select i1 %t408, i8* %t407, i8* %t406
  %t410 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t411 = icmp eq i32 %t345, 21
  %t412 = select i1 %t411, i8* %t410, i8* %t409
  %t413 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t414 = icmp eq i32 %t345, 22
  %t415 = select i1 %t414, i8* %t413, i8* %t412
  %s416 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h84042670, i32 0, i32 0
  %t417 = icmp eq i8* %t415, %s416
  br i1 %t417, label %then10, label %merge11
then10:
  %t418 = extractvalue %Statement %statement, 0
  %t419 = alloca %Statement
  store %Statement %statement, %Statement* %t419
  %t420 = getelementptr inbounds %Statement, %Statement* %t419, i32 0, i32 1
  %t421 = bitcast [24 x i8]* %t420 to i8*
  %t422 = getelementptr inbounds i8, i8* %t421, i64 8
  %t423 = bitcast i8* %t422 to %Block*
  %t424 = load %Block, %Block* %t423
  %t425 = icmp eq i32 %t418, 4
  %t426 = select i1 %t425, %Block %t424, %Block zeroinitializer
  %t427 = getelementptr inbounds %Statement, %Statement* %t419, i32 0, i32 1
  %t428 = bitcast [24 x i8]* %t427 to i8*
  %t429 = getelementptr inbounds i8, i8* %t428, i64 8
  %t430 = bitcast i8* %t429 to %Block*
  %t431 = load %Block, %Block* %t430
  %t432 = icmp eq i32 %t418, 5
  %t433 = select i1 %t432, %Block %t431, %Block %t426
  %t434 = getelementptr inbounds %Statement, %Statement* %t419, i32 0, i32 1
  %t435 = bitcast [40 x i8]* %t434 to i8*
  %t436 = getelementptr inbounds i8, i8* %t435, i64 16
  %t437 = bitcast i8* %t436 to %Block*
  %t438 = load %Block, %Block* %t437
  %t439 = icmp eq i32 %t418, 6
  %t440 = select i1 %t439, %Block %t438, %Block %t433
  %t441 = getelementptr inbounds %Statement, %Statement* %t419, i32 0, i32 1
  %t442 = bitcast [24 x i8]* %t441 to i8*
  %t443 = getelementptr inbounds i8, i8* %t442, i64 8
  %t444 = bitcast i8* %t443 to %Block*
  %t445 = load %Block, %Block* %t444
  %t446 = icmp eq i32 %t418, 7
  %t447 = select i1 %t446, %Block %t445, %Block %t440
  %t448 = getelementptr inbounds %Statement, %Statement* %t419, i32 0, i32 1
  %t449 = bitcast [40 x i8]* %t448 to i8*
  %t450 = getelementptr inbounds i8, i8* %t449, i64 24
  %t451 = bitcast i8* %t450 to %Block*
  %t452 = load %Block, %Block* %t451
  %t453 = icmp eq i32 %t418, 12
  %t454 = select i1 %t453, %Block %t452, %Block %t447
  %t455 = getelementptr inbounds %Statement, %Statement* %t419, i32 0, i32 1
  %t456 = bitcast [24 x i8]* %t455 to i8*
  %t457 = getelementptr inbounds i8, i8* %t456, i64 8
  %t458 = bitcast i8* %t457 to %Block*
  %t459 = load %Block, %Block* %t458
  %t460 = icmp eq i32 %t418, 13
  %t461 = select i1 %t460, %Block %t459, %Block %t454
  %t462 = getelementptr inbounds %Statement, %Statement* %t419, i32 0, i32 1
  %t463 = bitcast [24 x i8]* %t462 to i8*
  %t464 = getelementptr inbounds i8, i8* %t463, i64 8
  %t465 = bitcast i8* %t464 to %Block*
  %t466 = load %Block, %Block* %t465
  %t467 = icmp eq i32 %t418, 14
  %t468 = select i1 %t467, %Block %t466, %Block %t461
  %t469 = getelementptr inbounds %Statement, %Statement* %t419, i32 0, i32 1
  %t470 = bitcast [16 x i8]* %t469 to i8*
  %t471 = bitcast i8* %t470 to %Block*
  %t472 = load %Block, %Block* %t471
  %t473 = icmp eq i32 %t418, 15
  %t474 = select i1 %t473, %Block %t472, %Block %t468
  %t475 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t474)
  store { %EffectRequirement*, i64 }* %t475, { %EffectRequirement*, i64 }** %l4
  %t476 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t477 = extractvalue %Statement %statement, 0
  %t478 = alloca %Statement
  store %Statement %statement, %Statement* %t478
  %t479 = getelementptr inbounds %Statement, %Statement* %t478, i32 0, i32 1
  %t480 = bitcast [24 x i8]* %t479 to i8*
  %t481 = bitcast i8* %t480 to %ForClause*
  %t482 = load %ForClause, %ForClause* %t481
  %t483 = icmp eq i32 %t477, 14
  %t484 = select i1 %t483, %ForClause %t482, %ForClause zeroinitializer
  %t485 = extractvalue %ForClause %t484, 0
  %t486 = alloca %Expression
  store %Expression %t485, %Expression* %t486
  %t487 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t486)
  %t488 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t476, { %EffectRequirement*, i64 }* %t487)
  store { %EffectRequirement*, i64 }* %t488, { %EffectRequirement*, i64 }** %l4
  %t489 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t490 = extractvalue %Statement %statement, 0
  %t491 = alloca %Statement
  store %Statement %statement, %Statement* %t491
  %t492 = getelementptr inbounds %Statement, %Statement* %t491, i32 0, i32 1
  %t493 = bitcast [24 x i8]* %t492 to i8*
  %t494 = bitcast i8* %t493 to %ForClause*
  %t495 = load %ForClause, %ForClause* %t494
  %t496 = icmp eq i32 %t490, 14
  %t497 = select i1 %t496, %ForClause %t495, %ForClause zeroinitializer
  %t498 = extractvalue %ForClause %t497, 1
  %t499 = alloca %Expression
  store %Expression %t498, %Expression* %t499
  %t500 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t499)
  %t501 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t489, { %EffectRequirement*, i64 }* %t500)
  store { %EffectRequirement*, i64 }* %t501, { %EffectRequirement*, i64 }** %l4
  %t502 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t502
merge11:
  %t503 = extractvalue %Statement %statement, 0
  %t504 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t505 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t503, 0
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t503, 1
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t503, 2
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t503, 3
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t503, 4
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t521 = icmp eq i32 %t503, 5
  %t522 = select i1 %t521, i8* %t520, i8* %t519
  %t523 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t524 = icmp eq i32 %t503, 6
  %t525 = select i1 %t524, i8* %t523, i8* %t522
  %t526 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t527 = icmp eq i32 %t503, 7
  %t528 = select i1 %t527, i8* %t526, i8* %t525
  %t529 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t530 = icmp eq i32 %t503, 8
  %t531 = select i1 %t530, i8* %t529, i8* %t528
  %t532 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t533 = icmp eq i32 %t503, 9
  %t534 = select i1 %t533, i8* %t532, i8* %t531
  %t535 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t536 = icmp eq i32 %t503, 10
  %t537 = select i1 %t536, i8* %t535, i8* %t534
  %t538 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t539 = icmp eq i32 %t503, 11
  %t540 = select i1 %t539, i8* %t538, i8* %t537
  %t541 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t542 = icmp eq i32 %t503, 12
  %t543 = select i1 %t542, i8* %t541, i8* %t540
  %t544 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t545 = icmp eq i32 %t503, 13
  %t546 = select i1 %t545, i8* %t544, i8* %t543
  %t547 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t548 = icmp eq i32 %t503, 14
  %t549 = select i1 %t548, i8* %t547, i8* %t546
  %t550 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t551 = icmp eq i32 %t503, 15
  %t552 = select i1 %t551, i8* %t550, i8* %t549
  %t553 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t554 = icmp eq i32 %t503, 16
  %t555 = select i1 %t554, i8* %t553, i8* %t552
  %t556 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t557 = icmp eq i32 %t503, 17
  %t558 = select i1 %t557, i8* %t556, i8* %t555
  %t559 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t560 = icmp eq i32 %t503, 18
  %t561 = select i1 %t560, i8* %t559, i8* %t558
  %t562 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t563 = icmp eq i32 %t503, 19
  %t564 = select i1 %t563, i8* %t562, i8* %t561
  %t565 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t566 = icmp eq i32 %t503, 20
  %t567 = select i1 %t566, i8* %t565, i8* %t564
  %t568 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t569 = icmp eq i32 %t503, 21
  %t570 = select i1 %t569, i8* %t568, i8* %t567
  %t571 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t572 = icmp eq i32 %t503, 22
  %t573 = select i1 %t572, i8* %t571, i8* %t570
  %s574 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1678412334, i32 0, i32 0
  %t575 = icmp eq i8* %t573, %s574
  br i1 %t575, label %then12, label %merge13
then12:
  %t576 = extractvalue %Statement %statement, 0
  %t577 = alloca %Statement
  store %Statement %statement, %Statement* %t577
  %t578 = getelementptr inbounds %Statement, %Statement* %t577, i32 0, i32 1
  %t579 = bitcast [24 x i8]* %t578 to i8*
  %t580 = getelementptr inbounds i8, i8* %t579, i64 8
  %t581 = bitcast i8* %t580 to %Block*
  %t582 = load %Block, %Block* %t581
  %t583 = icmp eq i32 %t576, 4
  %t584 = select i1 %t583, %Block %t582, %Block zeroinitializer
  %t585 = getelementptr inbounds %Statement, %Statement* %t577, i32 0, i32 1
  %t586 = bitcast [24 x i8]* %t585 to i8*
  %t587 = getelementptr inbounds i8, i8* %t586, i64 8
  %t588 = bitcast i8* %t587 to %Block*
  %t589 = load %Block, %Block* %t588
  %t590 = icmp eq i32 %t576, 5
  %t591 = select i1 %t590, %Block %t589, %Block %t584
  %t592 = getelementptr inbounds %Statement, %Statement* %t577, i32 0, i32 1
  %t593 = bitcast [40 x i8]* %t592 to i8*
  %t594 = getelementptr inbounds i8, i8* %t593, i64 16
  %t595 = bitcast i8* %t594 to %Block*
  %t596 = load %Block, %Block* %t595
  %t597 = icmp eq i32 %t576, 6
  %t598 = select i1 %t597, %Block %t596, %Block %t591
  %t599 = getelementptr inbounds %Statement, %Statement* %t577, i32 0, i32 1
  %t600 = bitcast [24 x i8]* %t599 to i8*
  %t601 = getelementptr inbounds i8, i8* %t600, i64 8
  %t602 = bitcast i8* %t601 to %Block*
  %t603 = load %Block, %Block* %t602
  %t604 = icmp eq i32 %t576, 7
  %t605 = select i1 %t604, %Block %t603, %Block %t598
  %t606 = getelementptr inbounds %Statement, %Statement* %t577, i32 0, i32 1
  %t607 = bitcast [40 x i8]* %t606 to i8*
  %t608 = getelementptr inbounds i8, i8* %t607, i64 24
  %t609 = bitcast i8* %t608 to %Block*
  %t610 = load %Block, %Block* %t609
  %t611 = icmp eq i32 %t576, 12
  %t612 = select i1 %t611, %Block %t610, %Block %t605
  %t613 = getelementptr inbounds %Statement, %Statement* %t577, i32 0, i32 1
  %t614 = bitcast [24 x i8]* %t613 to i8*
  %t615 = getelementptr inbounds i8, i8* %t614, i64 8
  %t616 = bitcast i8* %t615 to %Block*
  %t617 = load %Block, %Block* %t616
  %t618 = icmp eq i32 %t576, 13
  %t619 = select i1 %t618, %Block %t617, %Block %t612
  %t620 = getelementptr inbounds %Statement, %Statement* %t577, i32 0, i32 1
  %t621 = bitcast [24 x i8]* %t620 to i8*
  %t622 = getelementptr inbounds i8, i8* %t621, i64 8
  %t623 = bitcast i8* %t622 to %Block*
  %t624 = load %Block, %Block* %t623
  %t625 = icmp eq i32 %t576, 14
  %t626 = select i1 %t625, %Block %t624, %Block %t619
  %t627 = getelementptr inbounds %Statement, %Statement* %t577, i32 0, i32 1
  %t628 = bitcast [16 x i8]* %t627 to i8*
  %t629 = bitcast i8* %t628 to %Block*
  %t630 = load %Block, %Block* %t629
  %t631 = icmp eq i32 %t576, 15
  %t632 = select i1 %t631, %Block %t630, %Block %t626
  %t633 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t632)
  ret { %EffectRequirement*, i64 }* %t633
merge13:
  %t634 = extractvalue %Statement %statement, 0
  %t635 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t636 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t637 = icmp eq i32 %t634, 0
  %t638 = select i1 %t637, i8* %t636, i8* %t635
  %t639 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t640 = icmp eq i32 %t634, 1
  %t641 = select i1 %t640, i8* %t639, i8* %t638
  %t642 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t643 = icmp eq i32 %t634, 2
  %t644 = select i1 %t643, i8* %t642, i8* %t641
  %t645 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t646 = icmp eq i32 %t634, 3
  %t647 = select i1 %t646, i8* %t645, i8* %t644
  %t648 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t649 = icmp eq i32 %t634, 4
  %t650 = select i1 %t649, i8* %t648, i8* %t647
  %t651 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t652 = icmp eq i32 %t634, 5
  %t653 = select i1 %t652, i8* %t651, i8* %t650
  %t654 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t655 = icmp eq i32 %t634, 6
  %t656 = select i1 %t655, i8* %t654, i8* %t653
  %t657 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t658 = icmp eq i32 %t634, 7
  %t659 = select i1 %t658, i8* %t657, i8* %t656
  %t660 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t661 = icmp eq i32 %t634, 8
  %t662 = select i1 %t661, i8* %t660, i8* %t659
  %t663 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t664 = icmp eq i32 %t634, 9
  %t665 = select i1 %t664, i8* %t663, i8* %t662
  %t666 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t667 = icmp eq i32 %t634, 10
  %t668 = select i1 %t667, i8* %t666, i8* %t665
  %t669 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t670 = icmp eq i32 %t634, 11
  %t671 = select i1 %t670, i8* %t669, i8* %t668
  %t672 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t673 = icmp eq i32 %t634, 12
  %t674 = select i1 %t673, i8* %t672, i8* %t671
  %t675 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t676 = icmp eq i32 %t634, 13
  %t677 = select i1 %t676, i8* %t675, i8* %t674
  %t678 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t679 = icmp eq i32 %t634, 14
  %t680 = select i1 %t679, i8* %t678, i8* %t677
  %t681 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t682 = icmp eq i32 %t634, 15
  %t683 = select i1 %t682, i8* %t681, i8* %t680
  %t684 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t634, 16
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t634, 17
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t634, 18
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t634, 19
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t634, 20
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t634, 21
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t634, 22
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %s705 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h196308685, i32 0, i32 0
  %t706 = icmp eq i8* %t704, %s705
  br i1 %t706, label %then14, label %merge15
then14:
  %t707 = extractvalue %Statement %statement, 0
  %t708 = alloca %Statement
  store %Statement %statement, %Statement* %t708
  %t709 = getelementptr inbounds %Statement, %Statement* %t708, i32 0, i32 1
  %t710 = bitcast [16 x i8]* %t709 to i8*
  %t711 = bitcast i8* %t710 to %Expression**
  %t712 = load %Expression*, %Expression** %t711
  %t713 = icmp eq i32 %t707, 20
  %t714 = select i1 %t713, %Expression* %t712, %Expression* null
  %t715 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t714)
  store { %EffectRequirement*, i64 }* %t715, { %EffectRequirement*, i64 }** %l5
  %t716 = sitofp i64 0 to double
  store double %t716, double* %l6
  %t717 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t718 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t761 = phi { %EffectRequirement*, i64 }* [ %t717, %then14 ], [ %t759, %loop.latch18 ]
  %t762 = phi double [ %t718, %then14 ], [ %t760, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t761, { %EffectRequirement*, i64 }** %l5
  store double %t762, double* %l6
  br label %loop.body17
loop.body17:
  %t719 = load double, double* %l6
  %t720 = extractvalue %Statement %statement, 0
  %t721 = alloca %Statement
  store %Statement %statement, %Statement* %t721
  %t722 = getelementptr inbounds %Statement, %Statement* %t721, i32 0, i32 1
  %t723 = bitcast [24 x i8]* %t722 to i8*
  %t724 = getelementptr inbounds i8, i8* %t723, i64 8
  %t725 = bitcast i8* %t724 to { %MatchCase**, i64 }**
  %t726 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t725
  %t727 = icmp eq i32 %t720, 18
  %t728 = select i1 %t727, { %MatchCase**, i64 }* %t726, { %MatchCase**, i64 }* null
  %t729 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t728
  %t730 = extractvalue { %MatchCase**, i64 } %t729, 1
  %t731 = sitofp i64 %t730 to double
  %t732 = fcmp oge double %t719, %t731
  %t733 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t734 = load double, double* %l6
  br i1 %t732, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t735 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t736 = extractvalue %Statement %statement, 0
  %t737 = alloca %Statement
  store %Statement %statement, %Statement* %t737
  %t738 = getelementptr inbounds %Statement, %Statement* %t737, i32 0, i32 1
  %t739 = bitcast [24 x i8]* %t738 to i8*
  %t740 = getelementptr inbounds i8, i8* %t739, i64 8
  %t741 = bitcast i8* %t740 to { %MatchCase**, i64 }**
  %t742 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t741
  %t743 = icmp eq i32 %t736, 18
  %t744 = select i1 %t743, { %MatchCase**, i64 }* %t742, { %MatchCase**, i64 }* null
  %t745 = load double, double* %l6
  %t746 = fptosi double %t745 to i64
  %t747 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t744
  %t748 = extractvalue { %MatchCase**, i64 } %t747, 0
  %t749 = extractvalue { %MatchCase**, i64 } %t747, 1
  %t750 = icmp uge i64 %t746, %t749
  ; bounds check: %t750 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t746, i64 %t749)
  %t751 = getelementptr %MatchCase*, %MatchCase** %t748, i64 %t746
  %t752 = load %MatchCase*, %MatchCase** %t751
  %t753 = load %MatchCase, %MatchCase* %t752
  %t754 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t753)
  %t755 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t735, { %EffectRequirement*, i64 }* %t754)
  store { %EffectRequirement*, i64 }* %t755, { %EffectRequirement*, i64 }** %l5
  %t756 = load double, double* %l6
  %t757 = sitofp i64 1 to double
  %t758 = fadd double %t756, %t757
  store double %t758, double* %l6
  br label %loop.latch18
loop.latch18:
  %t759 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t760 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t763 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t764 = load double, double* %l6
  %t765 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t765
merge15:
  %t766 = extractvalue %Statement %statement, 0
  %t767 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t768 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t766, 0
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t766, 1
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t766, 2
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t766, 3
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t766, 4
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t766, 5
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t766, 6
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t766, 7
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t766, 8
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t766, 9
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t766, 10
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t766, 11
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t766, 12
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t766, 13
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t766, 14
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t766, 15
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t766, 16
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t766, 17
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t766, 18
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t766, 19
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t766, 20
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t766, 21
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t766, 22
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %s837 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1566780570, i32 0, i32 0
  %t838 = icmp eq i8* %t836, %s837
  br i1 %t838, label %then22, label %merge23
then22:
  %t839 = extractvalue %Statement %statement, 0
  %t840 = alloca %Statement
  store %Statement %statement, %Statement* %t840
  %t841 = getelementptr inbounds %Statement, %Statement* %t840, i32 0, i32 1
  %t842 = bitcast [32 x i8]* %t841 to i8*
  %t843 = bitcast i8* %t842 to %Expression*
  %t844 = load %Expression, %Expression* %t843
  %t845 = icmp eq i32 %t839, 19
  %t846 = select i1 %t845, %Expression %t844, %Expression zeroinitializer
  %t847 = alloca %Expression
  store %Expression %t846, %Expression* %t847
  %t848 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t847)
  store { %EffectRequirement*, i64 }* %t848, { %EffectRequirement*, i64 }** %l7
  %t849 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t850 = extractvalue %Statement %statement, 0
  %t851 = alloca %Statement
  store %Statement %statement, %Statement* %t851
  %t852 = getelementptr inbounds %Statement, %Statement* %t851, i32 0, i32 1
  %t853 = bitcast [32 x i8]* %t852 to i8*
  %t854 = getelementptr inbounds i8, i8* %t853, i64 8
  %t855 = bitcast i8* %t854 to %Block*
  %t856 = load %Block, %Block* %t855
  %t857 = icmp eq i32 %t850, 19
  %t858 = select i1 %t857, %Block %t856, %Block zeroinitializer
  %t859 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t858)
  %t860 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t849, { %EffectRequirement*, i64 }* %t859)
  store { %EffectRequirement*, i64 }* %t860, { %EffectRequirement*, i64 }** %l7
  %t861 = extractvalue %Statement %statement, 0
  %t862 = alloca %Statement
  store %Statement %statement, %Statement* %t862
  %t863 = getelementptr inbounds %Statement, %Statement* %t862, i32 0, i32 1
  %t864 = bitcast [32 x i8]* %t863 to i8*
  %t865 = getelementptr inbounds i8, i8* %t864, i64 16
  %t866 = bitcast i8* %t865 to %ElseBranch**
  %t867 = load %ElseBranch*, %ElseBranch** %t866
  %t868 = icmp eq i32 %t861, 19
  %t869 = select i1 %t868, %ElseBranch* %t867, %ElseBranch* null
  store %ElseBranch* %t869, %ElseBranch** %l8
  %t870 = load %ElseBranch*, %ElseBranch** %l8
  %t871 = icmp eq %ElseBranch* %t870, null
  %t872 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t873 = load %ElseBranch*, %ElseBranch** %l8
  br i1 %t871, label %then24, label %merge25
then24:
  %t874 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t874
merge25:
  %t875 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t876 = load %ElseBranch*, %ElseBranch** %l8
  %t877 = load %ElseBranch, %ElseBranch* %t876
  %t878 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %t877)
  %t879 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t875, { %EffectRequirement*, i64 }* %t878)
  store { %EffectRequirement*, i64 }* %t879, { %EffectRequirement*, i64 }** %l7
  %t880 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t880
merge23:
  %t881 = extractvalue %Statement %statement, 0
  %t882 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t883 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t881, 0
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t881, 1
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t881, 2
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t881, 3
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t881, 4
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t881, 5
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t881, 6
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t881, 7
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t881, 8
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t881, 9
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t881, 10
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t881, 11
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t881, 12
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t881, 13
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t881, 14
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t881, 15
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t881, 16
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t881, 17
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t881, 18
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t881, 19
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t881, 20
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t881, 21
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t881, 22
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %s952 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1613933868, i32 0, i32 0
  %t953 = icmp eq i8* %t951, %s952
  br i1 %t953, label %then26, label %merge27
then26:
  %t954 = extractvalue %Statement %statement, 0
  %t955 = alloca %Statement
  store %Statement %statement, %Statement* %t955
  %t956 = getelementptr inbounds %Statement, %Statement* %t955, i32 0, i32 1
  %t957 = bitcast [16 x i8]* %t956 to i8*
  %t958 = bitcast i8* %t957 to %Expression**
  %t959 = load %Expression*, %Expression** %t958
  %t960 = icmp eq i32 %t954, 20
  %t961 = select i1 %t960, %Expression* %t959, %Expression* null
  %t962 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t961)
  ret { %EffectRequirement*, i64 }* %t962
merge27:
  %t963 = extractvalue %Statement %statement, 0
  %t964 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t965 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t963, 0
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t963, 1
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t963, 2
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t963, 3
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t963, 4
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t963, 5
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t963, 6
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t963, 7
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t963, 8
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t963, 9
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t963, 10
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t963, 11
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t963, 12
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t963, 13
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t963, 14
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t963, 15
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t963, 16
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t963, 17
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t963, 18
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t963, 19
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t963, 20
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t963, 21
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t963, 22
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %s1034 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h868168677, i32 0, i32 0
  %t1035 = icmp eq i8* %t1033, %s1034
  br i1 %t1035, label %then28, label %merge29
then28:
  %t1036 = extractvalue %Statement %statement, 0
  %t1037 = alloca %Statement
  store %Statement %statement, %Statement* %t1037
  %t1038 = getelementptr inbounds %Statement, %Statement* %t1037, i32 0, i32 1
  %t1039 = bitcast [16 x i8]* %t1038 to i8*
  %t1040 = bitcast i8* %t1039 to %Expression**
  %t1041 = load %Expression*, %Expression** %t1040
  %t1042 = icmp eq i32 %t1036, 20
  %t1043 = select i1 %t1042, %Expression* %t1041, %Expression* null
  %t1044 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1043)
  ret { %EffectRequirement*, i64 }* %t1044
merge29:
  %t1045 = extractvalue %Statement %statement, 0
  %t1046 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1047 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1045, 0
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1045, 1
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1045, 2
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1045, 3
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1045, 4
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1045, 5
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1045, 6
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1045, 7
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1045, 8
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1045, 9
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1045, 10
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1045, 11
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1045, 12
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1045, 13
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1045, 14
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1045, 15
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1045, 16
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1045, 17
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1045, 18
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1045, 19
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1045, 20
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1045, 21
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1045, 22
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %s1116 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1204027478, i32 0, i32 0
  %t1117 = icmp eq i8* %t1115, %s1116
  br i1 %t1117, label %then30, label %merge31
then30:
  %t1118 = extractvalue %Statement %statement, 0
  %t1119 = alloca %Statement
  store %Statement %statement, %Statement* %t1119
  %t1120 = getelementptr inbounds %Statement, %Statement* %t1119, i32 0, i32 1
  %t1121 = bitcast [48 x i8]* %t1120 to i8*
  %t1122 = getelementptr inbounds i8, i8* %t1121, i64 24
  %t1123 = bitcast i8* %t1122 to %Expression**
  %t1124 = load %Expression*, %Expression** %t1123
  %t1125 = icmp eq i32 %t1118, 2
  %t1126 = select i1 %t1125, %Expression* %t1124, %Expression* null
  %t1127 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1126)
  ret { %EffectRequirement*, i64 }* %t1127
merge31:
  %t1128 = extractvalue %Statement %statement, 0
  %t1129 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1130 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1128, 0
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1128, 1
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1128, 2
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1128, 3
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1128, 4
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1128, 5
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1128, 6
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1128, 7
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1128, 8
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1128, 9
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1128, 10
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1128, 11
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1128, 12
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1128, 13
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1128, 14
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1128, 15
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1128, 16
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1128, 17
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1128, 18
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1128, 19
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1128, 20
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1128, 21
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1128, 22
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %s1199 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h486335986, i32 0, i32 0
  %t1200 = icmp eq i8* %t1198, %s1199
  br i1 %t1200, label %then32, label %merge33
then32:
  %t1201 = extractvalue %Statement %statement, 0
  %t1202 = alloca %Statement
  store %Statement %statement, %Statement* %t1202
  %t1203 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1204 = bitcast [24 x i8]* %t1203 to i8*
  %t1205 = getelementptr inbounds i8, i8* %t1204, i64 8
  %t1206 = bitcast i8* %t1205 to %Block*
  %t1207 = load %Block, %Block* %t1206
  %t1208 = icmp eq i32 %t1201, 4
  %t1209 = select i1 %t1208, %Block %t1207, %Block zeroinitializer
  %t1210 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1211 = bitcast [24 x i8]* %t1210 to i8*
  %t1212 = getelementptr inbounds i8, i8* %t1211, i64 8
  %t1213 = bitcast i8* %t1212 to %Block*
  %t1214 = load %Block, %Block* %t1213
  %t1215 = icmp eq i32 %t1201, 5
  %t1216 = select i1 %t1215, %Block %t1214, %Block %t1209
  %t1217 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1218 = bitcast [40 x i8]* %t1217 to i8*
  %t1219 = getelementptr inbounds i8, i8* %t1218, i64 16
  %t1220 = bitcast i8* %t1219 to %Block*
  %t1221 = load %Block, %Block* %t1220
  %t1222 = icmp eq i32 %t1201, 6
  %t1223 = select i1 %t1222, %Block %t1221, %Block %t1216
  %t1224 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1225 = bitcast [24 x i8]* %t1224 to i8*
  %t1226 = getelementptr inbounds i8, i8* %t1225, i64 8
  %t1227 = bitcast i8* %t1226 to %Block*
  %t1228 = load %Block, %Block* %t1227
  %t1229 = icmp eq i32 %t1201, 7
  %t1230 = select i1 %t1229, %Block %t1228, %Block %t1223
  %t1231 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1232 = bitcast [40 x i8]* %t1231 to i8*
  %t1233 = getelementptr inbounds i8, i8* %t1232, i64 24
  %t1234 = bitcast i8* %t1233 to %Block*
  %t1235 = load %Block, %Block* %t1234
  %t1236 = icmp eq i32 %t1201, 12
  %t1237 = select i1 %t1236, %Block %t1235, %Block %t1230
  %t1238 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1239 = bitcast [24 x i8]* %t1238 to i8*
  %t1240 = getelementptr inbounds i8, i8* %t1239, i64 8
  %t1241 = bitcast i8* %t1240 to %Block*
  %t1242 = load %Block, %Block* %t1241
  %t1243 = icmp eq i32 %t1201, 13
  %t1244 = select i1 %t1243, %Block %t1242, %Block %t1237
  %t1245 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1246 = bitcast [24 x i8]* %t1245 to i8*
  %t1247 = getelementptr inbounds i8, i8* %t1246, i64 8
  %t1248 = bitcast i8* %t1247 to %Block*
  %t1249 = load %Block, %Block* %t1248
  %t1250 = icmp eq i32 %t1201, 14
  %t1251 = select i1 %t1250, %Block %t1249, %Block %t1244
  %t1252 = getelementptr inbounds %Statement, %Statement* %t1202, i32 0, i32 1
  %t1253 = bitcast [16 x i8]* %t1252 to i8*
  %t1254 = bitcast i8* %t1253 to %Block*
  %t1255 = load %Block, %Block* %t1254
  %t1256 = icmp eq i32 %t1201, 15
  %t1257 = select i1 %t1256, %Block %t1255, %Block %t1251
  %t1258 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1257)
  ret { %EffectRequirement*, i64 }* %t1258
merge33:
  %t1259 = extractvalue %Statement %statement, 0
  %t1260 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1261 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1259, 0
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1259, 1
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1259, 2
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1259, 3
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1259, 4
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1259, 5
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1259, 6
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1259, 7
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1259, 8
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1259, 9
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1259, 10
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1259, 11
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1259, 12
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1259, 13
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1259, 14
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1259, 15
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1259, 16
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1259, 17
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1259, 18
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1259, 19
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %t1321 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1259, 20
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1259, 21
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %t1327 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1328 = icmp eq i32 %t1259, 22
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1326
  %s1330 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h479148896, i32 0, i32 0
  %t1331 = icmp eq i8* %t1329, %s1330
  br i1 %t1331, label %then34, label %merge35
then34:
  %t1332 = extractvalue %Statement %statement, 0
  %t1333 = alloca %Statement
  store %Statement %statement, %Statement* %t1333
  %t1334 = getelementptr inbounds %Statement, %Statement* %t1333, i32 0, i32 1
  %t1335 = bitcast [24 x i8]* %t1334 to i8*
  %t1336 = getelementptr inbounds i8, i8* %t1335, i64 8
  %t1337 = bitcast i8* %t1336 to %Block*
  %t1338 = load %Block, %Block* %t1337
  %t1339 = icmp eq i32 %t1332, 4
  %t1340 = select i1 %t1339, %Block %t1338, %Block zeroinitializer
  %t1341 = getelementptr inbounds %Statement, %Statement* %t1333, i32 0, i32 1
  %t1342 = bitcast [24 x i8]* %t1341 to i8*
  %t1343 = getelementptr inbounds i8, i8* %t1342, i64 8
  %t1344 = bitcast i8* %t1343 to %Block*
  %t1345 = load %Block, %Block* %t1344
  %t1346 = icmp eq i32 %t1332, 5
  %t1347 = select i1 %t1346, %Block %t1345, %Block %t1340
  %t1348 = getelementptr inbounds %Statement, %Statement* %t1333, i32 0, i32 1
  %t1349 = bitcast [40 x i8]* %t1348 to i8*
  %t1350 = getelementptr inbounds i8, i8* %t1349, i64 16
  %t1351 = bitcast i8* %t1350 to %Block*
  %t1352 = load %Block, %Block* %t1351
  %t1353 = icmp eq i32 %t1332, 6
  %t1354 = select i1 %t1353, %Block %t1352, %Block %t1347
  %t1355 = getelementptr inbounds %Statement, %Statement* %t1333, i32 0, i32 1
  %t1356 = bitcast [24 x i8]* %t1355 to i8*
  %t1357 = getelementptr inbounds i8, i8* %t1356, i64 8
  %t1358 = bitcast i8* %t1357 to %Block*
  %t1359 = load %Block, %Block* %t1358
  %t1360 = icmp eq i32 %t1332, 7
  %t1361 = select i1 %t1360, %Block %t1359, %Block %t1354
  %t1362 = getelementptr inbounds %Statement, %Statement* %t1333, i32 0, i32 1
  %t1363 = bitcast [40 x i8]* %t1362 to i8*
  %t1364 = getelementptr inbounds i8, i8* %t1363, i64 24
  %t1365 = bitcast i8* %t1364 to %Block*
  %t1366 = load %Block, %Block* %t1365
  %t1367 = icmp eq i32 %t1332, 12
  %t1368 = select i1 %t1367, %Block %t1366, %Block %t1361
  %t1369 = getelementptr inbounds %Statement, %Statement* %t1333, i32 0, i32 1
  %t1370 = bitcast [24 x i8]* %t1369 to i8*
  %t1371 = getelementptr inbounds i8, i8* %t1370, i64 8
  %t1372 = bitcast i8* %t1371 to %Block*
  %t1373 = load %Block, %Block* %t1372
  %t1374 = icmp eq i32 %t1332, 13
  %t1375 = select i1 %t1374, %Block %t1373, %Block %t1368
  %t1376 = getelementptr inbounds %Statement, %Statement* %t1333, i32 0, i32 1
  %t1377 = bitcast [24 x i8]* %t1376 to i8*
  %t1378 = getelementptr inbounds i8, i8* %t1377, i64 8
  %t1379 = bitcast i8* %t1378 to %Block*
  %t1380 = load %Block, %Block* %t1379
  %t1381 = icmp eq i32 %t1332, 14
  %t1382 = select i1 %t1381, %Block %t1380, %Block %t1375
  %t1383 = getelementptr inbounds %Statement, %Statement* %t1333, i32 0, i32 1
  %t1384 = bitcast [16 x i8]* %t1383 to i8*
  %t1385 = bitcast i8* %t1384 to %Block*
  %t1386 = load %Block, %Block* %t1385
  %t1387 = icmp eq i32 %t1332, 15
  %t1388 = select i1 %t1387, %Block %t1386, %Block %t1382
  %t1389 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1388)
  ret { %EffectRequirement*, i64 }* %t1389
merge35:
  %t1390 = extractvalue %Statement %statement, 0
  %t1391 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1392 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1390, 0
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1390, 1
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1390, 2
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1390, 3
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1390, 4
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1390, 5
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1390, 6
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1390, 7
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1390, 8
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1390, 9
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1390, 10
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1390, 11
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1390, 12
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1390, 13
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1390, 14
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1390, 15
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1390, 16
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1390, 17
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1390, 18
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1390, 19
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1390, 20
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1390, 21
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1390, 22
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %s1461 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h571715647, i32 0, i32 0
  %t1462 = icmp eq i8* %t1460, %s1461
  br i1 %t1462, label %then36, label %merge37
then36:
  %t1463 = extractvalue %Statement %statement, 0
  %t1464 = alloca %Statement
  store %Statement %statement, %Statement* %t1464
  %t1465 = getelementptr inbounds %Statement, %Statement* %t1464, i32 0, i32 1
  %t1466 = bitcast [24 x i8]* %t1465 to i8*
  %t1467 = getelementptr inbounds i8, i8* %t1466, i64 8
  %t1468 = bitcast i8* %t1467 to %Block*
  %t1469 = load %Block, %Block* %t1468
  %t1470 = icmp eq i32 %t1463, 4
  %t1471 = select i1 %t1470, %Block %t1469, %Block zeroinitializer
  %t1472 = getelementptr inbounds %Statement, %Statement* %t1464, i32 0, i32 1
  %t1473 = bitcast [24 x i8]* %t1472 to i8*
  %t1474 = getelementptr inbounds i8, i8* %t1473, i64 8
  %t1475 = bitcast i8* %t1474 to %Block*
  %t1476 = load %Block, %Block* %t1475
  %t1477 = icmp eq i32 %t1463, 5
  %t1478 = select i1 %t1477, %Block %t1476, %Block %t1471
  %t1479 = getelementptr inbounds %Statement, %Statement* %t1464, i32 0, i32 1
  %t1480 = bitcast [40 x i8]* %t1479 to i8*
  %t1481 = getelementptr inbounds i8, i8* %t1480, i64 16
  %t1482 = bitcast i8* %t1481 to %Block*
  %t1483 = load %Block, %Block* %t1482
  %t1484 = icmp eq i32 %t1463, 6
  %t1485 = select i1 %t1484, %Block %t1483, %Block %t1478
  %t1486 = getelementptr inbounds %Statement, %Statement* %t1464, i32 0, i32 1
  %t1487 = bitcast [24 x i8]* %t1486 to i8*
  %t1488 = getelementptr inbounds i8, i8* %t1487, i64 8
  %t1489 = bitcast i8* %t1488 to %Block*
  %t1490 = load %Block, %Block* %t1489
  %t1491 = icmp eq i32 %t1463, 7
  %t1492 = select i1 %t1491, %Block %t1490, %Block %t1485
  %t1493 = getelementptr inbounds %Statement, %Statement* %t1464, i32 0, i32 1
  %t1494 = bitcast [40 x i8]* %t1493 to i8*
  %t1495 = getelementptr inbounds i8, i8* %t1494, i64 24
  %t1496 = bitcast i8* %t1495 to %Block*
  %t1497 = load %Block, %Block* %t1496
  %t1498 = icmp eq i32 %t1463, 12
  %t1499 = select i1 %t1498, %Block %t1497, %Block %t1492
  %t1500 = getelementptr inbounds %Statement, %Statement* %t1464, i32 0, i32 1
  %t1501 = bitcast [24 x i8]* %t1500 to i8*
  %t1502 = getelementptr inbounds i8, i8* %t1501, i64 8
  %t1503 = bitcast i8* %t1502 to %Block*
  %t1504 = load %Block, %Block* %t1503
  %t1505 = icmp eq i32 %t1463, 13
  %t1506 = select i1 %t1505, %Block %t1504, %Block %t1499
  %t1507 = getelementptr inbounds %Statement, %Statement* %t1464, i32 0, i32 1
  %t1508 = bitcast [24 x i8]* %t1507 to i8*
  %t1509 = getelementptr inbounds i8, i8* %t1508, i64 8
  %t1510 = bitcast i8* %t1509 to %Block*
  %t1511 = load %Block, %Block* %t1510
  %t1512 = icmp eq i32 %t1463, 14
  %t1513 = select i1 %t1512, %Block %t1511, %Block %t1506
  %t1514 = getelementptr inbounds %Statement, %Statement* %t1464, i32 0, i32 1
  %t1515 = bitcast [16 x i8]* %t1514 to i8*
  %t1516 = bitcast i8* %t1515 to %Block*
  %t1517 = load %Block, %Block* %t1516
  %t1518 = icmp eq i32 %t1463, 15
  %t1519 = select i1 %t1518, %Block %t1517, %Block %t1513
  %t1520 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1519)
  ret { %EffectRequirement*, i64 }* %t1520
merge37:
  %t1521 = extractvalue %Statement %statement, 0
  %t1522 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1523 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1521, 0
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1521, 1
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1521, 2
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1521, 3
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1521, 4
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1521, 5
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1521, 6
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1521, 7
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1521, 8
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1521, 9
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1521, 10
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1521, 11
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1521, 12
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1521, 13
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1521, 14
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1521, 15
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1521, 16
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1521, 17
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1521, 18
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1521, 19
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1521, 20
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1521, 21
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1521, 22
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %s1592 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h889179835, i32 0, i32 0
  %t1593 = icmp eq i8* %t1591, %s1592
  br i1 %t1593, label %then38, label %merge39
then38:
  %t1594 = extractvalue %Statement %statement, 0
  %t1595 = alloca %Statement
  store %Statement %statement, %Statement* %t1595
  %t1596 = getelementptr inbounds %Statement, %Statement* %t1595, i32 0, i32 1
  %t1597 = bitcast [24 x i8]* %t1596 to i8*
  %t1598 = getelementptr inbounds i8, i8* %t1597, i64 8
  %t1599 = bitcast i8* %t1598 to %Block*
  %t1600 = load %Block, %Block* %t1599
  %t1601 = icmp eq i32 %t1594, 4
  %t1602 = select i1 %t1601, %Block %t1600, %Block zeroinitializer
  %t1603 = getelementptr inbounds %Statement, %Statement* %t1595, i32 0, i32 1
  %t1604 = bitcast [24 x i8]* %t1603 to i8*
  %t1605 = getelementptr inbounds i8, i8* %t1604, i64 8
  %t1606 = bitcast i8* %t1605 to %Block*
  %t1607 = load %Block, %Block* %t1606
  %t1608 = icmp eq i32 %t1594, 5
  %t1609 = select i1 %t1608, %Block %t1607, %Block %t1602
  %t1610 = getelementptr inbounds %Statement, %Statement* %t1595, i32 0, i32 1
  %t1611 = bitcast [40 x i8]* %t1610 to i8*
  %t1612 = getelementptr inbounds i8, i8* %t1611, i64 16
  %t1613 = bitcast i8* %t1612 to %Block*
  %t1614 = load %Block, %Block* %t1613
  %t1615 = icmp eq i32 %t1594, 6
  %t1616 = select i1 %t1615, %Block %t1614, %Block %t1609
  %t1617 = getelementptr inbounds %Statement, %Statement* %t1595, i32 0, i32 1
  %t1618 = bitcast [24 x i8]* %t1617 to i8*
  %t1619 = getelementptr inbounds i8, i8* %t1618, i64 8
  %t1620 = bitcast i8* %t1619 to %Block*
  %t1621 = load %Block, %Block* %t1620
  %t1622 = icmp eq i32 %t1594, 7
  %t1623 = select i1 %t1622, %Block %t1621, %Block %t1616
  %t1624 = getelementptr inbounds %Statement, %Statement* %t1595, i32 0, i32 1
  %t1625 = bitcast [40 x i8]* %t1624 to i8*
  %t1626 = getelementptr inbounds i8, i8* %t1625, i64 24
  %t1627 = bitcast i8* %t1626 to %Block*
  %t1628 = load %Block, %Block* %t1627
  %t1629 = icmp eq i32 %t1594, 12
  %t1630 = select i1 %t1629, %Block %t1628, %Block %t1623
  %t1631 = getelementptr inbounds %Statement, %Statement* %t1595, i32 0, i32 1
  %t1632 = bitcast [24 x i8]* %t1631 to i8*
  %t1633 = getelementptr inbounds i8, i8* %t1632, i64 8
  %t1634 = bitcast i8* %t1633 to %Block*
  %t1635 = load %Block, %Block* %t1634
  %t1636 = icmp eq i32 %t1594, 13
  %t1637 = select i1 %t1636, %Block %t1635, %Block %t1630
  %t1638 = getelementptr inbounds %Statement, %Statement* %t1595, i32 0, i32 1
  %t1639 = bitcast [24 x i8]* %t1638 to i8*
  %t1640 = getelementptr inbounds i8, i8* %t1639, i64 8
  %t1641 = bitcast i8* %t1640 to %Block*
  %t1642 = load %Block, %Block* %t1641
  %t1643 = icmp eq i32 %t1594, 14
  %t1644 = select i1 %t1643, %Block %t1642, %Block %t1637
  %t1645 = getelementptr inbounds %Statement, %Statement* %t1595, i32 0, i32 1
  %t1646 = bitcast [16 x i8]* %t1645 to i8*
  %t1647 = bitcast i8* %t1646 to %Block*
  %t1648 = load %Block, %Block* %t1647
  %t1649 = icmp eq i32 %t1594, 15
  %t1650 = select i1 %t1649, %Block %t1648, %Block %t1644
  %t1651 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1650)
  ret { %EffectRequirement*, i64 }* %t1651
merge39:
  %t1652 = extractvalue %Statement %statement, 0
  %t1653 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1654 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1652, 0
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1652, 1
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1652, 2
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1652, 3
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1667 = icmp eq i32 %t1652, 4
  %t1668 = select i1 %t1667, i8* %t1666, i8* %t1665
  %t1669 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1670 = icmp eq i32 %t1652, 5
  %t1671 = select i1 %t1670, i8* %t1669, i8* %t1668
  %t1672 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1673 = icmp eq i32 %t1652, 6
  %t1674 = select i1 %t1673, i8* %t1672, i8* %t1671
  %t1675 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1676 = icmp eq i32 %t1652, 7
  %t1677 = select i1 %t1676, i8* %t1675, i8* %t1674
  %t1678 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1679 = icmp eq i32 %t1652, 8
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1677
  %t1681 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1652, 9
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1652, 10
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1688 = icmp eq i32 %t1652, 11
  %t1689 = select i1 %t1688, i8* %t1687, i8* %t1686
  %t1690 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1691 = icmp eq i32 %t1652, 12
  %t1692 = select i1 %t1691, i8* %t1690, i8* %t1689
  %t1693 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1652, 13
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1652, 14
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %t1699 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1700 = icmp eq i32 %t1652, 15
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1698
  %t1702 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1703 = icmp eq i32 %t1652, 16
  %t1704 = select i1 %t1703, i8* %t1702, i8* %t1701
  %t1705 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1706 = icmp eq i32 %t1652, 17
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1704
  %t1708 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1652, 18
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %t1711 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1712 = icmp eq i32 %t1652, 19
  %t1713 = select i1 %t1712, i8* %t1711, i8* %t1710
  %t1714 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1715 = icmp eq i32 %t1652, 20
  %t1716 = select i1 %t1715, i8* %t1714, i8* %t1713
  %t1717 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1718 = icmp eq i32 %t1652, 21
  %t1719 = select i1 %t1718, i8* %t1717, i8* %t1716
  %t1720 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1721 = icmp eq i32 %t1652, 22
  %t1722 = select i1 %t1721, i8* %t1720, i8* %t1719
  %s1723 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1842783069, i32 0, i32 0
  %t1724 = icmp eq i8* %t1722, %s1723
  br i1 %t1724, label %then40, label %merge41
then40:
  %t1725 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1726 = ptrtoint [0 x %EffectRequirement]* %t1725 to i64
  %t1727 = icmp eq i64 %t1726, 0
  %t1728 = select i1 %t1727, i64 1, i64 %t1726
  %t1729 = call i8* @malloc(i64 %t1728)
  %t1730 = bitcast i8* %t1729 to %EffectRequirement*
  %t1731 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1732 = ptrtoint { %EffectRequirement*, i64 }* %t1731 to i64
  %t1733 = call i8* @malloc(i64 %t1732)
  %t1734 = bitcast i8* %t1733 to { %EffectRequirement*, i64 }*
  %t1735 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1734, i32 0, i32 0
  store %EffectRequirement* %t1730, %EffectRequirement** %t1735
  %t1736 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1734, i32 0, i32 1
  store i64 0, i64* %t1736
  store { %EffectRequirement*, i64 }* %t1734, { %EffectRequirement*, i64 }** %l9
  %t1737 = sitofp i64 0 to double
  store double %t1737, double* %l10
  %t1738 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1739 = load double, double* %l10
  br label %loop.header42
loop.header42:
  %t1783 = phi { %EffectRequirement*, i64 }* [ %t1738, %then40 ], [ %t1781, %loop.latch44 ]
  %t1784 = phi double [ %t1739, %then40 ], [ %t1782, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1783, { %EffectRequirement*, i64 }** %l9
  store double %t1784, double* %l10
  br label %loop.body43
loop.body43:
  %t1740 = load double, double* %l10
  %t1741 = extractvalue %Statement %statement, 0
  %t1742 = alloca %Statement
  store %Statement %statement, %Statement* %t1742
  %t1743 = getelementptr inbounds %Statement, %Statement* %t1742, i32 0, i32 1
  %t1744 = bitcast [56 x i8]* %t1743 to i8*
  %t1745 = getelementptr inbounds i8, i8* %t1744, i64 40
  %t1746 = bitcast i8* %t1745 to { %MethodDeclaration**, i64 }**
  %t1747 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1746
  %t1748 = icmp eq i32 %t1741, 8
  %t1749 = select i1 %t1748, { %MethodDeclaration**, i64 }* %t1747, { %MethodDeclaration**, i64 }* null
  %t1750 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1749
  %t1751 = extractvalue { %MethodDeclaration**, i64 } %t1750, 1
  %t1752 = sitofp i64 %t1751 to double
  %t1753 = fcmp oge double %t1740, %t1752
  %t1754 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1755 = load double, double* %l10
  br i1 %t1753, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1756 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1757 = extractvalue %Statement %statement, 0
  %t1758 = alloca %Statement
  store %Statement %statement, %Statement* %t1758
  %t1759 = getelementptr inbounds %Statement, %Statement* %t1758, i32 0, i32 1
  %t1760 = bitcast [56 x i8]* %t1759 to i8*
  %t1761 = getelementptr inbounds i8, i8* %t1760, i64 40
  %t1762 = bitcast i8* %t1761 to { %MethodDeclaration**, i64 }**
  %t1763 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1762
  %t1764 = icmp eq i32 %t1757, 8
  %t1765 = select i1 %t1764, { %MethodDeclaration**, i64 }* %t1763, { %MethodDeclaration**, i64 }* null
  %t1766 = load double, double* %l10
  %t1767 = fptosi double %t1766 to i64
  %t1768 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1765
  %t1769 = extractvalue { %MethodDeclaration**, i64 } %t1768, 0
  %t1770 = extractvalue { %MethodDeclaration**, i64 } %t1768, 1
  %t1771 = icmp uge i64 %t1767, %t1770
  ; bounds check: %t1771 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1767, i64 %t1770)
  %t1772 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1769, i64 %t1767
  %t1773 = load %MethodDeclaration*, %MethodDeclaration** %t1772
  %t1774 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1773, i32 0, i32 1
  %t1775 = load %Block, %Block* %t1774
  %t1776 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1775)
  %t1777 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1756, { %EffectRequirement*, i64 }* %t1776)
  store { %EffectRequirement*, i64 }* %t1777, { %EffectRequirement*, i64 }** %l9
  %t1778 = load double, double* %l10
  %t1779 = sitofp i64 1 to double
  %t1780 = fadd double %t1778, %t1779
  store double %t1780, double* %l10
  br label %loop.latch44
loop.latch44:
  %t1781 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1782 = load double, double* %l10
  br label %loop.header42
afterloop45:
  %t1785 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1786 = load double, double* %l10
  %t1787 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t1787
merge41:
  %t1788 = extractvalue %Statement %statement, 0
  %t1789 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1790 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1791 = icmp eq i32 %t1788, 0
  %t1792 = select i1 %t1791, i8* %t1790, i8* %t1789
  %t1793 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1794 = icmp eq i32 %t1788, 1
  %t1795 = select i1 %t1794, i8* %t1793, i8* %t1792
  %t1796 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1797 = icmp eq i32 %t1788, 2
  %t1798 = select i1 %t1797, i8* %t1796, i8* %t1795
  %t1799 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1800 = icmp eq i32 %t1788, 3
  %t1801 = select i1 %t1800, i8* %t1799, i8* %t1798
  %t1802 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1803 = icmp eq i32 %t1788, 4
  %t1804 = select i1 %t1803, i8* %t1802, i8* %t1801
  %t1805 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1806 = icmp eq i32 %t1788, 5
  %t1807 = select i1 %t1806, i8* %t1805, i8* %t1804
  %t1808 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1809 = icmp eq i32 %t1788, 6
  %t1810 = select i1 %t1809, i8* %t1808, i8* %t1807
  %t1811 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1812 = icmp eq i32 %t1788, 7
  %t1813 = select i1 %t1812, i8* %t1811, i8* %t1810
  %t1814 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1815 = icmp eq i32 %t1788, 8
  %t1816 = select i1 %t1815, i8* %t1814, i8* %t1813
  %t1817 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1818 = icmp eq i32 %t1788, 9
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1816
  %t1820 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1788, 10
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1788, 11
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1788, 12
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1788, 13
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1788, 14
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1788, 15
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1788, 16
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1788, 17
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1788, 18
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1788, 19
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1788, 20
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %t1853 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1788, 21
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %t1856 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1857 = icmp eq i32 %t1788, 22
  %t1858 = select i1 %t1857, i8* %t1856, i8* %t1855
  %s1859 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h2043328844, i32 0, i32 0
  %t1860 = icmp eq i8* %t1858, %s1859
  br i1 %t1860, label %then48, label %merge49
then48:
  %t1861 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t1862 = ptrtoint [0 x %EffectRequirement]* %t1861 to i64
  %t1863 = icmp eq i64 %t1862, 0
  %t1864 = select i1 %t1863, i64 1, i64 %t1862
  %t1865 = call i8* @malloc(i64 %t1864)
  %t1866 = bitcast i8* %t1865 to %EffectRequirement*
  %t1867 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t1868 = ptrtoint { %EffectRequirement*, i64 }* %t1867 to i64
  %t1869 = call i8* @malloc(i64 %t1868)
  %t1870 = bitcast i8* %t1869 to { %EffectRequirement*, i64 }*
  %t1871 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1870, i32 0, i32 0
  store %EffectRequirement* %t1866, %EffectRequirement** %t1871
  %t1872 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1870, i32 0, i32 1
  store i64 0, i64* %t1872
  store { %EffectRequirement*, i64 }* %t1870, { %EffectRequirement*, i64 }** %l11
  %t1873 = sitofp i64 0 to double
  store double %t1873, double* %l12
  %t1874 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1875 = load double, double* %l12
  br label %loop.header50
loop.header50:
  %t1920 = phi { %EffectRequirement*, i64 }* [ %t1874, %then48 ], [ %t1918, %loop.latch52 ]
  %t1921 = phi double [ %t1875, %then48 ], [ %t1919, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1920, { %EffectRequirement*, i64 }** %l11
  store double %t1921, double* %l12
  br label %loop.body51
loop.body51:
  %t1876 = load double, double* %l12
  %t1877 = extractvalue %Statement %statement, 0
  %t1878 = alloca %Statement
  store %Statement %statement, %Statement* %t1878
  %t1879 = getelementptr inbounds %Statement, %Statement* %t1878, i32 0, i32 1
  %t1880 = bitcast [48 x i8]* %t1879 to i8*
  %t1881 = getelementptr inbounds i8, i8* %t1880, i64 24
  %t1882 = bitcast i8* %t1881 to { %ModelProperty**, i64 }**
  %t1883 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1882
  %t1884 = icmp eq i32 %t1877, 3
  %t1885 = select i1 %t1884, { %ModelProperty**, i64 }* %t1883, { %ModelProperty**, i64 }* null
  %t1886 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1885
  %t1887 = extractvalue { %ModelProperty**, i64 } %t1886, 1
  %t1888 = sitofp i64 %t1887 to double
  %t1889 = fcmp oge double %t1876, %t1888
  %t1890 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1891 = load double, double* %l12
  br i1 %t1889, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1892 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1893 = extractvalue %Statement %statement, 0
  %t1894 = alloca %Statement
  store %Statement %statement, %Statement* %t1894
  %t1895 = getelementptr inbounds %Statement, %Statement* %t1894, i32 0, i32 1
  %t1896 = bitcast [48 x i8]* %t1895 to i8*
  %t1897 = getelementptr inbounds i8, i8* %t1896, i64 24
  %t1898 = bitcast i8* %t1897 to { %ModelProperty**, i64 }**
  %t1899 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1898
  %t1900 = icmp eq i32 %t1893, 3
  %t1901 = select i1 %t1900, { %ModelProperty**, i64 }* %t1899, { %ModelProperty**, i64 }* null
  %t1902 = load double, double* %l12
  %t1903 = fptosi double %t1902 to i64
  %t1904 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1901
  %t1905 = extractvalue { %ModelProperty**, i64 } %t1904, 0
  %t1906 = extractvalue { %ModelProperty**, i64 } %t1904, 1
  %t1907 = icmp uge i64 %t1903, %t1906
  ; bounds check: %t1907 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1903, i64 %t1906)
  %t1908 = getelementptr %ModelProperty*, %ModelProperty** %t1905, i64 %t1903
  %t1909 = load %ModelProperty*, %ModelProperty** %t1908
  %t1910 = getelementptr %ModelProperty, %ModelProperty* %t1909, i32 0, i32 1
  %t1911 = load %Expression, %Expression* %t1910
  %t1912 = alloca %Expression
  store %Expression %t1911, %Expression* %t1912
  %t1913 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1912)
  %t1914 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1892, { %EffectRequirement*, i64 }* %t1913)
  store { %EffectRequirement*, i64 }* %t1914, { %EffectRequirement*, i64 }** %l11
  %t1915 = load double, double* %l12
  %t1916 = sitofp i64 1 to double
  %t1917 = fadd double %t1915, %t1916
  store double %t1917, double* %l12
  br label %loop.latch52
loop.latch52:
  %t1918 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1919 = load double, double* %l12
  br label %loop.header50
afterloop53:
  %t1922 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1923 = load double, double* %l12
  %t1924 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  ret { %EffectRequirement*, i64 }* %t1924
merge49:
  %t1925 = extractvalue %Statement %statement, 0
  %t1926 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1927 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1928 = icmp eq i32 %t1925, 0
  %t1929 = select i1 %t1928, i8* %t1927, i8* %t1926
  %t1930 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1931 = icmp eq i32 %t1925, 1
  %t1932 = select i1 %t1931, i8* %t1930, i8* %t1929
  %t1933 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1934 = icmp eq i32 %t1925, 2
  %t1935 = select i1 %t1934, i8* %t1933, i8* %t1932
  %t1936 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1937 = icmp eq i32 %t1925, 3
  %t1938 = select i1 %t1937, i8* %t1936, i8* %t1935
  %t1939 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1940 = icmp eq i32 %t1925, 4
  %t1941 = select i1 %t1940, i8* %t1939, i8* %t1938
  %t1942 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1943 = icmp eq i32 %t1925, 5
  %t1944 = select i1 %t1943, i8* %t1942, i8* %t1941
  %t1945 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1946 = icmp eq i32 %t1925, 6
  %t1947 = select i1 %t1946, i8* %t1945, i8* %t1944
  %t1948 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1949 = icmp eq i32 %t1925, 7
  %t1950 = select i1 %t1949, i8* %t1948, i8* %t1947
  %t1951 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1952 = icmp eq i32 %t1925, 8
  %t1953 = select i1 %t1952, i8* %t1951, i8* %t1950
  %t1954 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1955 = icmp eq i32 %t1925, 9
  %t1956 = select i1 %t1955, i8* %t1954, i8* %t1953
  %t1957 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1958 = icmp eq i32 %t1925, 10
  %t1959 = select i1 %t1958, i8* %t1957, i8* %t1956
  %t1960 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1961 = icmp eq i32 %t1925, 11
  %t1962 = select i1 %t1961, i8* %t1960, i8* %t1959
  %t1963 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1964 = icmp eq i32 %t1925, 12
  %t1965 = select i1 %t1964, i8* %t1963, i8* %t1962
  %t1966 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1967 = icmp eq i32 %t1925, 13
  %t1968 = select i1 %t1967, i8* %t1966, i8* %t1965
  %t1969 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1970 = icmp eq i32 %t1925, 14
  %t1971 = select i1 %t1970, i8* %t1969, i8* %t1968
  %t1972 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1973 = icmp eq i32 %t1925, 15
  %t1974 = select i1 %t1973, i8* %t1972, i8* %t1971
  %t1975 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1976 = icmp eq i32 %t1925, 16
  %t1977 = select i1 %t1976, i8* %t1975, i8* %t1974
  %t1978 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1979 = icmp eq i32 %t1925, 17
  %t1980 = select i1 %t1979, i8* %t1978, i8* %t1977
  %t1981 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1982 = icmp eq i32 %t1925, 18
  %t1983 = select i1 %t1982, i8* %t1981, i8* %t1980
  %t1984 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1985 = icmp eq i32 %t1925, 19
  %t1986 = select i1 %t1985, i8* %t1984, i8* %t1983
  %t1987 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1988 = icmp eq i32 %t1925, 20
  %t1989 = select i1 %t1988, i8* %t1987, i8* %t1986
  %t1990 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1991 = icmp eq i32 %t1925, 21
  %t1992 = select i1 %t1991, i8* %t1990, i8* %t1989
  %t1993 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1994 = icmp eq i32 %t1925, 22
  %t1995 = select i1 %t1994, i8* %t1993, i8* %t1992
  %s1996 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t1997 = icmp eq i8* %t1995, %s1996
  br i1 %t1997, label %then56, label %merge57
then56:
  %t1998 = extractvalue %Statement %statement, 0
  %t1999 = alloca %Statement
  store %Statement %statement, %Statement* %t1999
  %t2000 = getelementptr inbounds %Statement, %Statement* %t1999, i32 0, i32 1
  %t2001 = bitcast [16 x i8]* %t2000 to i8*
  %t2002 = bitcast i8* %t2001 to { %Token**, i64 }**
  %t2003 = load { %Token**, i64 }*, { %Token**, i64 }** %t2002
  %t2004 = icmp eq i32 %t1998, 22
  %t2005 = select i1 %t2004, { %Token**, i64 }* %t2003, { %Token**, i64 }* null
  %t2006 = bitcast { %Token**, i64 }* %t2005 to { %Token*, i64 }*
  %t2007 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t2006)
  ret { %EffectRequirement*, i64 }* %t2007
merge57:
  %t2008 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t2009 = ptrtoint [0 x %EffectRequirement]* %t2008 to i64
  %t2010 = icmp eq i64 %t2009, 0
  %t2011 = select i1 %t2010, i64 1, i64 %t2009
  %t2012 = call i8* @malloc(i64 %t2011)
  %t2013 = bitcast i8* %t2012 to %EffectRequirement*
  %t2014 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t2015 = ptrtoint { %EffectRequirement*, i64 }* %t2014 to i64
  %t2016 = call i8* @malloc(i64 %t2015)
  %t2017 = bitcast i8* %t2016 to { %EffectRequirement*, i64 }*
  %t2018 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2017, i32 0, i32 0
  store %EffectRequirement* %t2013, %EffectRequirement** %t2018
  %t2019 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2017, i32 0, i32 1
  store i64 0, i64* %t2019
  ret { %EffectRequirement*, i64 }* %t2017
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
  %t65 = icmp eq i8* %t63, %s64
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
  %t119 = phi { %EffectRequirement*, i64 }* [ %t76, %then2 ], [ %t117, %loop.latch6 ]
  %t120 = phi double [ %t77, %then2 ], [ %t118, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t119, { %EffectRequirement*, i64 }** %l0
  store double %t120, double* %l1
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
  %t105 = fptosi double %t104 to i64
  %t106 = load { %Expression**, i64 }, { %Expression**, i64 }* %t103
  %t107 = extractvalue { %Expression**, i64 } %t106, 0
  %t108 = extractvalue { %Expression**, i64 } %t106, 1
  %t109 = icmp uge i64 %t105, %t108
  ; bounds check: %t109 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t105, i64 %t108)
  %t110 = getelementptr %Expression*, %Expression** %t107, i64 %t105
  %t111 = load %Expression*, %Expression** %t110
  %t112 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t111)
  %t113 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t94, { %EffectRequirement*, i64 }* %t112)
  store { %EffectRequirement*, i64 }* %t113, { %EffectRequirement*, i64 }** %l0
  %t114 = load double, double* %l1
  %t115 = sitofp i64 1 to double
  %t116 = fadd double %t114, %t115
  store double %t116, double* %l1
  br label %loop.latch6
loop.latch6:
  %t117 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t118 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t121 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t122 = load double, double* %l1
  %t123 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t123
merge3:
  %t124 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t125 = load i32, i32* %t124
  %t126 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t127 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t125, 0
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t125, 1
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t125, 2
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t125, 3
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t125, 4
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t125, 5
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t125, 6
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t125, 7
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t125, 8
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t125, 9
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t125, 10
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t125, 11
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t125, 12
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t125, 13
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t125, 14
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t125, 15
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %s175 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h512390329, i32 0, i32 0
  %t176 = icmp eq i8* %t174, %s175
  br i1 %t176, label %then10, label %merge11
then10:
  %t177 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t178 = load i32, i32* %t177
  %t179 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t180 = bitcast [16 x i8]* %t179 to i8*
  %t181 = bitcast i8* %t180 to %Expression**
  %t182 = load %Expression*, %Expression** %t181
  %t183 = icmp eq i32 %t178, 7
  %t184 = select i1 %t183, %Expression* %t182, %Expression* null
  %t185 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t184)
  ret { %EffectRequirement*, i64 }* %t185
merge11:
  %t186 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t187 = load i32, i32* %t186
  %t188 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t189 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t187, 0
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t187, 1
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t187, 2
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t187, 3
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t187, 4
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t187, 5
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t187, 6
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t187, 7
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t187, 8
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t187, 9
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t187, 10
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t187, 11
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t187, 12
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %t228 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t229 = icmp eq i32 %t187, 13
  %t230 = select i1 %t229, i8* %t228, i8* %t227
  %t231 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t232 = icmp eq i32 %t187, 14
  %t233 = select i1 %t232, i8* %t231, i8* %t230
  %t234 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t235 = icmp eq i32 %t187, 15
  %t236 = select i1 %t235, i8* %t234, i8* %t233
  %s237 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1445149598, i32 0, i32 0
  %t238 = icmp eq i8* %t236, %s237
  br i1 %t238, label %then12, label %merge13
then12:
  %t239 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t240 = load i32, i32* %t239
  %t241 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t242 = bitcast [16 x i8]* %t241 to i8*
  %t243 = getelementptr inbounds i8, i8* %t242, i64 8
  %t244 = bitcast i8* %t243 to %Expression**
  %t245 = load %Expression*, %Expression** %t244
  %t246 = icmp eq i32 %t240, 5
  %t247 = select i1 %t246, %Expression* %t245, %Expression* null
  %t248 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t247)
  ret { %EffectRequirement*, i64 }* %t248
merge13:
  %t249 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t250 = load i32, i32* %t249
  %t251 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t252 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t250, 0
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t250, 1
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t250, 2
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t250, 3
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t250, 4
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t250, 5
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t250, 6
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t250, 7
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t250, 8
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %t279 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t250, 9
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t250, 10
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t250, 11
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t250, 12
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %t291 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t292 = icmp eq i32 %t250, 13
  %t293 = select i1 %t292, i8* %t291, i8* %t290
  %t294 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t295 = icmp eq i32 %t250, 14
  %t296 = select i1 %t295, i8* %t294, i8* %t293
  %t297 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t298 = icmp eq i32 %t250, 15
  %t299 = select i1 %t298, i8* %t297, i8* %t296
  %s300 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1496334143, i32 0, i32 0
  %t301 = icmp eq i8* %t299, %s300
  br i1 %t301, label %then14, label %merge15
then14:
  %t302 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t303 = load i32, i32* %t302
  %t304 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t305 = bitcast [24 x i8]* %t304 to i8*
  %t306 = getelementptr inbounds i8, i8* %t305, i64 8
  %t307 = bitcast i8* %t306 to %Expression**
  %t308 = load %Expression*, %Expression** %t307
  %t309 = icmp eq i32 %t303, 6
  %t310 = select i1 %t309, %Expression* %t308, %Expression* null
  %t311 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t310)
  store { %EffectRequirement*, i64 }* %t311, { %EffectRequirement*, i64 }** %l2
  %t312 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  %t313 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t314 = load i32, i32* %t313
  %t315 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t316 = bitcast [24 x i8]* %t315 to i8*
  %t317 = getelementptr inbounds i8, i8* %t316, i64 16
  %t318 = bitcast i8* %t317 to %Expression**
  %t319 = load %Expression*, %Expression** %t318
  %t320 = icmp eq i32 %t314, 6
  %t321 = select i1 %t320, %Expression* %t319, %Expression* null
  %t322 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t321)
  %t323 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t312, { %EffectRequirement*, i64 }* %t322)
  store { %EffectRequirement*, i64 }* %t323, { %EffectRequirement*, i64 }** %l2
  %t324 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  ret { %EffectRequirement*, i64 }* %t324
merge15:
  %t325 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t326 = load i32, i32* %t325
  %t327 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t328 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t326, 0
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t326, 1
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t326, 2
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t326, 3
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t326, 4
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t326, 5
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t326, 6
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t326, 7
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t326, 8
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t326, 9
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t326, 10
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t326, 11
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t326, 12
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t326, 13
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t326, 14
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t326, 15
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %s376 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h667777838, i32 0, i32 0
  %t377 = icmp eq i8* %t375, %s376
  br i1 %t377, label %then16, label %merge17
then16:
  %t378 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t379 = ptrtoint [0 x %EffectRequirement]* %t378 to i64
  %t380 = icmp eq i64 %t379, 0
  %t381 = select i1 %t380, i64 1, i64 %t379
  %t382 = call i8* @malloc(i64 %t381)
  %t383 = bitcast i8* %t382 to %EffectRequirement*
  %t384 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t385 = ptrtoint { %EffectRequirement*, i64 }* %t384 to i64
  %t386 = call i8* @malloc(i64 %t385)
  %t387 = bitcast i8* %t386 to { %EffectRequirement*, i64 }*
  %t388 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t387, i32 0, i32 0
  store %EffectRequirement* %t383, %EffectRequirement** %t388
  %t389 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t387, i32 0, i32 1
  store i64 0, i64* %t389
  store { %EffectRequirement*, i64 }* %t387, { %EffectRequirement*, i64 }** %l3
  %t390 = sitofp i64 0 to double
  store double %t390, double* %l4
  %t391 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t392 = load double, double* %l4
  br label %loop.header18
loop.header18:
  %t432 = phi { %EffectRequirement*, i64 }* [ %t391, %then16 ], [ %t430, %loop.latch20 ]
  %t433 = phi double [ %t392, %then16 ], [ %t431, %loop.latch20 ]
  store { %EffectRequirement*, i64 }* %t432, { %EffectRequirement*, i64 }** %l3
  store double %t433, double* %l4
  br label %loop.body19
loop.body19:
  %t393 = load double, double* %l4
  %t394 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t395 = load i32, i32* %t394
  %t396 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t397 = bitcast [8 x i8]* %t396 to i8*
  %t398 = bitcast i8* %t397 to { %Expression**, i64 }**
  %t399 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t398
  %t400 = icmp eq i32 %t395, 10
  %t401 = select i1 %t400, { %Expression**, i64 }* %t399, { %Expression**, i64 }* null
  %t402 = load { %Expression**, i64 }, { %Expression**, i64 }* %t401
  %t403 = extractvalue { %Expression**, i64 } %t402, 1
  %t404 = sitofp i64 %t403 to double
  %t405 = fcmp oge double %t393, %t404
  %t406 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t407 = load double, double* %l4
  br i1 %t405, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t408 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t409 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t410 = load i32, i32* %t409
  %t411 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t412 = bitcast [8 x i8]* %t411 to i8*
  %t413 = bitcast i8* %t412 to { %Expression**, i64 }**
  %t414 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t413
  %t415 = icmp eq i32 %t410, 10
  %t416 = select i1 %t415, { %Expression**, i64 }* %t414, { %Expression**, i64 }* null
  %t417 = load double, double* %l4
  %t418 = fptosi double %t417 to i64
  %t419 = load { %Expression**, i64 }, { %Expression**, i64 }* %t416
  %t420 = extractvalue { %Expression**, i64 } %t419, 0
  %t421 = extractvalue { %Expression**, i64 } %t419, 1
  %t422 = icmp uge i64 %t418, %t421
  ; bounds check: %t422 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t418, i64 %t421)
  %t423 = getelementptr %Expression*, %Expression** %t420, i64 %t418
  %t424 = load %Expression*, %Expression** %t423
  %t425 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t424)
  %t426 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t408, { %EffectRequirement*, i64 }* %t425)
  store { %EffectRequirement*, i64 }* %t426, { %EffectRequirement*, i64 }** %l3
  %t427 = load double, double* %l4
  %t428 = sitofp i64 1 to double
  %t429 = fadd double %t427, %t428
  store double %t429, double* %l4
  br label %loop.latch20
loop.latch20:
  %t430 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t431 = load double, double* %l4
  br label %loop.header18
afterloop21:
  %t434 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t435 = load double, double* %l4
  %t436 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  ret { %EffectRequirement*, i64 }* %t436
merge17:
  %t437 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t438 = load i32, i32* %t437
  %t439 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t440 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t438, 0
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t438, 1
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %t446 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t447 = icmp eq i32 %t438, 2
  %t448 = select i1 %t447, i8* %t446, i8* %t445
  %t449 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t450 = icmp eq i32 %t438, 3
  %t451 = select i1 %t450, i8* %t449, i8* %t448
  %t452 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t453 = icmp eq i32 %t438, 4
  %t454 = select i1 %t453, i8* %t452, i8* %t451
  %t455 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t456 = icmp eq i32 %t438, 5
  %t457 = select i1 %t456, i8* %t455, i8* %t454
  %t458 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t459 = icmp eq i32 %t438, 6
  %t460 = select i1 %t459, i8* %t458, i8* %t457
  %t461 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t462 = icmp eq i32 %t438, 7
  %t463 = select i1 %t462, i8* %t461, i8* %t460
  %t464 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t465 = icmp eq i32 %t438, 8
  %t466 = select i1 %t465, i8* %t464, i8* %t463
  %t467 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t438, 9
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t438, 10
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t438, 11
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t438, 12
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t438, 13
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t438, 14
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t438, 15
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %s488 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h826984377, i32 0, i32 0
  %t489 = icmp eq i8* %t487, %s488
  br i1 %t489, label %then24, label %merge25
then24:
  %t490 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t491 = ptrtoint [0 x %EffectRequirement]* %t490 to i64
  %t492 = icmp eq i64 %t491, 0
  %t493 = select i1 %t492, i64 1, i64 %t491
  %t494 = call i8* @malloc(i64 %t493)
  %t495 = bitcast i8* %t494 to %EffectRequirement*
  %t496 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t497 = ptrtoint { %EffectRequirement*, i64 }* %t496 to i64
  %t498 = call i8* @malloc(i64 %t497)
  %t499 = bitcast i8* %t498 to { %EffectRequirement*, i64 }*
  %t500 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t499, i32 0, i32 0
  store %EffectRequirement* %t495, %EffectRequirement** %t500
  %t501 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t499, i32 0, i32 1
  store i64 0, i64* %t501
  store { %EffectRequirement*, i64 }* %t499, { %EffectRequirement*, i64 }** %l5
  %t502 = sitofp i64 0 to double
  store double %t502, double* %l6
  %t503 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t504 = load double, double* %l6
  br label %loop.header26
loop.header26:
  %t561 = phi { %EffectRequirement*, i64 }* [ %t503, %then24 ], [ %t559, %loop.latch28 ]
  %t562 = phi double [ %t504, %then24 ], [ %t560, %loop.latch28 ]
  store { %EffectRequirement*, i64 }* %t561, { %EffectRequirement*, i64 }** %l5
  store double %t562, double* %l6
  br label %loop.body27
loop.body27:
  %t505 = load double, double* %l6
  %t506 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t507 = load i32, i32* %t506
  %t508 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t509 = bitcast [8 x i8]* %t508 to i8*
  %t510 = bitcast i8* %t509 to { %ObjectField**, i64 }**
  %t511 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t510
  %t512 = icmp eq i32 %t507, 11
  %t513 = select i1 %t512, { %ObjectField**, i64 }* %t511, { %ObjectField**, i64 }* null
  %t514 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t515 = bitcast [16 x i8]* %t514 to i8*
  %t516 = getelementptr inbounds i8, i8* %t515, i64 8
  %t517 = bitcast i8* %t516 to { %ObjectField**, i64 }**
  %t518 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t517
  %t519 = icmp eq i32 %t507, 12
  %t520 = select i1 %t519, { %ObjectField**, i64 }* %t518, { %ObjectField**, i64 }* %t513
  %t521 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t520
  %t522 = extractvalue { %ObjectField**, i64 } %t521, 1
  %t523 = sitofp i64 %t522 to double
  %t524 = fcmp oge double %t505, %t523
  %t525 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t526 = load double, double* %l6
  br i1 %t524, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t527 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t528 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t529 = load i32, i32* %t528
  %t530 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t531 = bitcast [8 x i8]* %t530 to i8*
  %t532 = bitcast i8* %t531 to { %ObjectField**, i64 }**
  %t533 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t532
  %t534 = icmp eq i32 %t529, 11
  %t535 = select i1 %t534, { %ObjectField**, i64 }* %t533, { %ObjectField**, i64 }* null
  %t536 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t537 = bitcast [16 x i8]* %t536 to i8*
  %t538 = getelementptr inbounds i8, i8* %t537, i64 8
  %t539 = bitcast i8* %t538 to { %ObjectField**, i64 }**
  %t540 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t539
  %t541 = icmp eq i32 %t529, 12
  %t542 = select i1 %t541, { %ObjectField**, i64 }* %t540, { %ObjectField**, i64 }* %t535
  %t543 = load double, double* %l6
  %t544 = fptosi double %t543 to i64
  %t545 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t542
  %t546 = extractvalue { %ObjectField**, i64 } %t545, 0
  %t547 = extractvalue { %ObjectField**, i64 } %t545, 1
  %t548 = icmp uge i64 %t544, %t547
  ; bounds check: %t548 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t544, i64 %t547)
  %t549 = getelementptr %ObjectField*, %ObjectField** %t546, i64 %t544
  %t550 = load %ObjectField*, %ObjectField** %t549
  %t551 = getelementptr %ObjectField, %ObjectField* %t550, i32 0, i32 1
  %t552 = load %Expression, %Expression* %t551
  %t553 = alloca %Expression
  store %Expression %t552, %Expression* %t553
  %t554 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t553)
  %t555 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t527, { %EffectRequirement*, i64 }* %t554)
  store { %EffectRequirement*, i64 }* %t555, { %EffectRequirement*, i64 }** %l5
  %t556 = load double, double* %l6
  %t557 = sitofp i64 1 to double
  %t558 = fadd double %t556, %t557
  store double %t558, double* %l6
  br label %loop.latch28
loop.latch28:
  %t559 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t560 = load double, double* %l6
  br label %loop.header26
afterloop29:
  %t563 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t564 = load double, double* %l6
  %t565 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t565
merge25:
  %t566 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t567 = load i32, i32* %t566
  %t568 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t569 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t567, 0
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t567, 1
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t567, 2
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t567, 3
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t567, 4
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t567, 5
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t567, 6
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %t590 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t591 = icmp eq i32 %t567, 7
  %t592 = select i1 %t591, i8* %t590, i8* %t589
  %t593 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t594 = icmp eq i32 %t567, 8
  %t595 = select i1 %t594, i8* %t593, i8* %t592
  %t596 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t597 = icmp eq i32 %t567, 9
  %t598 = select i1 %t597, i8* %t596, i8* %t595
  %t599 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t600 = icmp eq i32 %t567, 10
  %t601 = select i1 %t600, i8* %t599, i8* %t598
  %t602 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t603 = icmp eq i32 %t567, 11
  %t604 = select i1 %t603, i8* %t602, i8* %t601
  %t605 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t606 = icmp eq i32 %t567, 12
  %t607 = select i1 %t606, i8* %t605, i8* %t604
  %t608 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t609 = icmp eq i32 %t567, 13
  %t610 = select i1 %t609, i8* %t608, i8* %t607
  %t611 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t612 = icmp eq i32 %t567, 14
  %t613 = select i1 %t612, i8* %t611, i8* %t610
  %t614 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t615 = icmp eq i32 %t567, 15
  %t616 = select i1 %t615, i8* %t614, i8* %t613
  %s617 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h264904746, i32 0, i32 0
  %t618 = icmp eq i8* %t616, %s617
  br i1 %t618, label %then32, label %merge33
then32:
  %t619 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t620 = ptrtoint [0 x %EffectRequirement]* %t619 to i64
  %t621 = icmp eq i64 %t620, 0
  %t622 = select i1 %t621, i64 1, i64 %t620
  %t623 = call i8* @malloc(i64 %t622)
  %t624 = bitcast i8* %t623 to %EffectRequirement*
  %t625 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t626 = ptrtoint { %EffectRequirement*, i64 }* %t625 to i64
  %t627 = call i8* @malloc(i64 %t626)
  %t628 = bitcast i8* %t627 to { %EffectRequirement*, i64 }*
  %t629 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t628, i32 0, i32 0
  store %EffectRequirement* %t624, %EffectRequirement** %t629
  %t630 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t628, i32 0, i32 1
  store i64 0, i64* %t630
  store { %EffectRequirement*, i64 }* %t628, { %EffectRequirement*, i64 }** %l7
  %t631 = sitofp i64 0 to double
  store double %t631, double* %l8
  %t632 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t633 = load double, double* %l8
  br label %loop.header34
loop.header34:
  %t690 = phi { %EffectRequirement*, i64 }* [ %t632, %then32 ], [ %t688, %loop.latch36 ]
  %t691 = phi double [ %t633, %then32 ], [ %t689, %loop.latch36 ]
  store { %EffectRequirement*, i64 }* %t690, { %EffectRequirement*, i64 }** %l7
  store double %t691, double* %l8
  br label %loop.body35
loop.body35:
  %t634 = load double, double* %l8
  %t635 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t636 = load i32, i32* %t635
  %t637 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t638 = bitcast [8 x i8]* %t637 to i8*
  %t639 = bitcast i8* %t638 to { %ObjectField**, i64 }**
  %t640 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t639
  %t641 = icmp eq i32 %t636, 11
  %t642 = select i1 %t641, { %ObjectField**, i64 }* %t640, { %ObjectField**, i64 }* null
  %t643 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t644 = bitcast [16 x i8]* %t643 to i8*
  %t645 = getelementptr inbounds i8, i8* %t644, i64 8
  %t646 = bitcast i8* %t645 to { %ObjectField**, i64 }**
  %t647 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t646
  %t648 = icmp eq i32 %t636, 12
  %t649 = select i1 %t648, { %ObjectField**, i64 }* %t647, { %ObjectField**, i64 }* %t642
  %t650 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t649
  %t651 = extractvalue { %ObjectField**, i64 } %t650, 1
  %t652 = sitofp i64 %t651 to double
  %t653 = fcmp oge double %t634, %t652
  %t654 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t655 = load double, double* %l8
  br i1 %t653, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t656 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t657 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t658 = load i32, i32* %t657
  %t659 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t660 = bitcast [8 x i8]* %t659 to i8*
  %t661 = bitcast i8* %t660 to { %ObjectField**, i64 }**
  %t662 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t661
  %t663 = icmp eq i32 %t658, 11
  %t664 = select i1 %t663, { %ObjectField**, i64 }* %t662, { %ObjectField**, i64 }* null
  %t665 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t666 = bitcast [16 x i8]* %t665 to i8*
  %t667 = getelementptr inbounds i8, i8* %t666, i64 8
  %t668 = bitcast i8* %t667 to { %ObjectField**, i64 }**
  %t669 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t668
  %t670 = icmp eq i32 %t658, 12
  %t671 = select i1 %t670, { %ObjectField**, i64 }* %t669, { %ObjectField**, i64 }* %t664
  %t672 = load double, double* %l8
  %t673 = fptosi double %t672 to i64
  %t674 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t671
  %t675 = extractvalue { %ObjectField**, i64 } %t674, 0
  %t676 = extractvalue { %ObjectField**, i64 } %t674, 1
  %t677 = icmp uge i64 %t673, %t676
  ; bounds check: %t677 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t673, i64 %t676)
  %t678 = getelementptr %ObjectField*, %ObjectField** %t675, i64 %t673
  %t679 = load %ObjectField*, %ObjectField** %t678
  %t680 = getelementptr %ObjectField, %ObjectField* %t679, i32 0, i32 1
  %t681 = load %Expression, %Expression* %t680
  %t682 = alloca %Expression
  store %Expression %t681, %Expression* %t682
  %t683 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t682)
  %t684 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t656, { %EffectRequirement*, i64 }* %t683)
  store { %EffectRequirement*, i64 }* %t684, { %EffectRequirement*, i64 }** %l7
  %t685 = load double, double* %l8
  %t686 = sitofp i64 1 to double
  %t687 = fadd double %t685, %t686
  store double %t687, double* %l8
  br label %loop.latch36
loop.latch36:
  %t688 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t689 = load double, double* %l8
  br label %loop.header34
afterloop37:
  %t692 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t693 = load double, double* %l8
  %t694 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t694
merge33:
  %t695 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t696 = load i32, i32* %t695
  %t697 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t698 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t696, 0
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t696, 1
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t696, 2
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t696, 3
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t696, 4
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t696, 5
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %t716 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t717 = icmp eq i32 %t696, 6
  %t718 = select i1 %t717, i8* %t716, i8* %t715
  %t719 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t720 = icmp eq i32 %t696, 7
  %t721 = select i1 %t720, i8* %t719, i8* %t718
  %t722 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t723 = icmp eq i32 %t696, 8
  %t724 = select i1 %t723, i8* %t722, i8* %t721
  %t725 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t726 = icmp eq i32 %t696, 9
  %t727 = select i1 %t726, i8* %t725, i8* %t724
  %t728 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t729 = icmp eq i32 %t696, 10
  %t730 = select i1 %t729, i8* %t728, i8* %t727
  %t731 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t696, 11
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t696, 12
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t696, 13
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t696, 14
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t696, 15
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %s746 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1211862785, i32 0, i32 0
  %t747 = icmp eq i8* %t745, %s746
  br i1 %t747, label %then40, label %merge41
then40:
  %t748 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t749 = load i32, i32* %t748
  %t750 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t751 = bitcast [24 x i8]* %t750 to i8*
  %t752 = getelementptr inbounds i8, i8* %t751, i64 8
  %t753 = bitcast i8* %t752 to %Block*
  %t754 = load %Block, %Block* %t753
  %t755 = icmp eq i32 %t749, 13
  %t756 = select i1 %t755, %Block %t754, %Block zeroinitializer
  %t757 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t756)
  ret { %EffectRequirement*, i64 }* %t757
merge41:
  %t758 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t759 = load i32, i32* %t758
  %t760 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t761 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t759, 0
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t759, 1
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t759, 2
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t759, 3
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t759, 4
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t759, 5
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t759, 6
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t759, 7
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t759, 8
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t759, 9
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t759, 10
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t759, 11
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t759, 12
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t759, 13
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t759, 14
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t759, 15
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %s809 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h975618503, i32 0, i32 0
  %t810 = icmp eq i8* %t808, %s809
  br i1 %t810, label %then42, label %merge43
then42:
  %t811 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t812 = load i32, i32* %t811
  %t813 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t814 = bitcast [16 x i8]* %t813 to i8*
  %t815 = bitcast i8* %t814 to %Expression**
  %t816 = load %Expression*, %Expression** %t815
  %t817 = icmp eq i32 %t812, 9
  %t818 = select i1 %t817, %Expression* %t816, %Expression* null
  %t819 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t818)
  store { %EffectRequirement*, i64 }* %t819, { %EffectRequirement*, i64 }** %l9
  %t820 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t821 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t822 = load i32, i32* %t821
  %t823 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t824 = bitcast [16 x i8]* %t823 to i8*
  %t825 = getelementptr inbounds i8, i8* %t824, i64 8
  %t826 = bitcast i8* %t825 to %Expression**
  %t827 = load %Expression*, %Expression** %t826
  %t828 = icmp eq i32 %t822, 9
  %t829 = select i1 %t828, %Expression* %t827, %Expression* null
  %t830 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t829)
  %t831 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t820, { %EffectRequirement*, i64 }* %t830)
  store { %EffectRequirement*, i64 }* %t831, { %EffectRequirement*, i64 }** %l9
  %t832 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t832
merge43:
  %t833 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t834 = load i32, i32* %t833
  %t835 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t836 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t834, 0
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t834, 1
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t834, 2
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t834, 3
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %t848 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t849 = icmp eq i32 %t834, 4
  %t850 = select i1 %t849, i8* %t848, i8* %t847
  %t851 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t852 = icmp eq i32 %t834, 5
  %t853 = select i1 %t852, i8* %t851, i8* %t850
  %t854 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t855 = icmp eq i32 %t834, 6
  %t856 = select i1 %t855, i8* %t854, i8* %t853
  %t857 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t858 = icmp eq i32 %t834, 7
  %t859 = select i1 %t858, i8* %t857, i8* %t856
  %t860 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t861 = icmp eq i32 %t834, 8
  %t862 = select i1 %t861, i8* %t860, i8* %t859
  %t863 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t864 = icmp eq i32 %t834, 9
  %t865 = select i1 %t864, i8* %t863, i8* %t862
  %t866 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t867 = icmp eq i32 %t834, 10
  %t868 = select i1 %t867, i8* %t866, i8* %t865
  %t869 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t870 = icmp eq i32 %t834, 11
  %t871 = select i1 %t870, i8* %t869, i8* %t868
  %t872 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t873 = icmp eq i32 %t834, 12
  %t874 = select i1 %t873, i8* %t872, i8* %t871
  %t875 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t834, 13
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t834, 14
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t834, 15
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %s884 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1312780988, i32 0, i32 0
  %t885 = icmp eq i8* %t883, %s884
  br i1 %t885, label %then44, label %merge45
then44:
  %t886 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t887 = load i32, i32* %t886
  %t888 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t889 = bitcast [16 x i8]* %t888 to i8*
  %t890 = bitcast i8* %t889 to %Expression**
  %t891 = load %Expression*, %Expression** %t890
  %t892 = icmp eq i32 %t887, 14
  %t893 = select i1 %t892, %Expression* %t891, %Expression* null
  %t894 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t893)
  store { %EffectRequirement*, i64 }* %t894, { %EffectRequirement*, i64 }** %l10
  %t895 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t896 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t897 = load i32, i32* %t896
  %t898 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t899 = bitcast [16 x i8]* %t898 to i8*
  %t900 = getelementptr inbounds i8, i8* %t899, i64 8
  %t901 = bitcast i8* %t900 to %Expression**
  %t902 = load %Expression*, %Expression** %t901
  %t903 = icmp eq i32 %t897, 14
  %t904 = select i1 %t903, %Expression* %t902, %Expression* null
  %t905 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t904)
  %t906 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t895, { %EffectRequirement*, i64 }* %t905)
  store { %EffectRequirement*, i64 }* %t906, { %EffectRequirement*, i64 }** %l10
  %t907 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t907
merge45:
  %t908 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t909 = load i32, i32* %t908
  %t910 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t911 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t909, 0
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t909, 1
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t909, 2
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t909, 3
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t909, 4
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t909, 5
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t909, 6
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t909, 7
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t909, 8
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t909, 9
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t909, 10
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t909, 11
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t909, 12
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t909, 13
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t909, 14
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t909, 15
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %s959 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089530004, i32 0, i32 0
  %t960 = icmp eq i8* %t958, %s959
  br i1 %t960, label %then46, label %merge47
then46:
  %t961 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t962 = ptrtoint [0 x %EffectRequirement]* %t961 to i64
  %t963 = icmp eq i64 %t962, 0
  %t964 = select i1 %t963, i64 1, i64 %t962
  %t965 = call i8* @malloc(i64 %t964)
  %t966 = bitcast i8* %t965 to %EffectRequirement*
  %t967 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t968 = ptrtoint { %EffectRequirement*, i64 }* %t967 to i64
  %t969 = call i8* @malloc(i64 %t968)
  %t970 = bitcast i8* %t969 to { %EffectRequirement*, i64 }*
  %t971 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t970, i32 0, i32 0
  store %EffectRequirement* %t966, %EffectRequirement** %t971
  %t972 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t970, i32 0, i32 1
  store i64 0, i64* %t972
  ret { %EffectRequirement*, i64 }* %t970
merge47:
  %t973 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* null, i32 1
  %t974 = ptrtoint [0 x %EffectRequirement]* %t973 to i64
  %t975 = icmp eq i64 %t974, 0
  %t976 = select i1 %t975, i64 1, i64 %t974
  %t977 = call i8* @malloc(i64 %t976)
  %t978 = bitcast i8* %t977 to %EffectRequirement*
  %t979 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* null, i32 1
  %t980 = ptrtoint { %EffectRequirement*, i64 }* %t979 to i64
  %t981 = call i8* @malloc(i64 %t980)
  %t982 = bitcast i8* %t981 to { %EffectRequirement*, i64 }*
  %t983 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t982, i32 0, i32 0
  store %EffectRequirement* %t978, %EffectRequirement** %t983
  %t984 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t982, i32 0, i32 1
  store i64 0, i64* %t984
  ret { %EffectRequirement*, i64 }* %t982
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
  %t190 = phi { %EffectRequirement*, i64 }* [ %t1, %block.entry ], [ %t188, %loop.latch2 ]
  %t191 = phi double [ %t2, %block.entry ], [ %t189, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t190, { %EffectRequirement*, i64 }** %l0
  store double %t191, double* %l1
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
  %t11 = fptosi double %t10 to i64
  %t12 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t13 = extractvalue { %Token*, i64 } %t12, 0
  %t14 = extractvalue { %Token*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t11, i64 %t14)
  %t16 = getelementptr %Token, %Token* %t13, i64 %t11
  %t17 = load %Token, %Token* %t16
  store %Token %t17, %Token* %l2
  %t18 = load %Token, %Token* %l2
  %s19 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1128151960, i32 0, i32 0
  %t20 = call i1 @is_identifier_token(%Token %t18, i8* %s19)
  %t21 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t22 = load double, double* %l1
  %t23 = load %Token, %Token* %l2
  br i1 %t20, label %then6, label %merge7
then6:
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  %t27 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t26)
  store double %t27, double* %l3
  %s28 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h10983220, i32 0, i32 0
  store i8* %s28, i8** %l4
  %t29 = load double, double* %l3
  %t30 = sitofp i64 -1 to double
  %t31 = fcmp une double %t29, %t30
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = load %Token, %Token* %l2
  %t35 = load double, double* %l3
  %t36 = load i8*, i8** %l4
  br i1 %t31, label %then8, label %merge9
then8:
  %t37 = load double, double* %l3
  %t38 = fptosi double %t37 to i64
  %t39 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t40 = extractvalue { %Token*, i64 } %t39, 0
  %t41 = extractvalue { %Token*, i64 } %t39, 1
  %t42 = icmp uge i64 %t38, %t41
  ; bounds check: %t42 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t38, i64 %t41)
  %t43 = getelementptr %Token, %Token* %t40, i64 %t38
  %t44 = load %Token, %Token* %t43
  store %Token %t44, %Token* %l5
  %t46 = load %Token, %Token* %l5
  %t47 = extractvalue %Token %t46, 0
  %t48 = extractvalue %TokenKind %t47, 0
  %t49 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t50 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t48, 0
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t48, 1
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t48, 2
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t48, 3
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t48, 4
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t48, 5
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t48, 6
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t48, 7
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %s74 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1576352120, i32 0, i32 0
  %t75 = icmp eq i8* %t73, %s74
  br label %logical_or_entry_45

logical_or_entry_45:
  br i1 %t75, label %logical_or_merge_45, label %logical_or_right_45

logical_or_right_45:
  %t76 = load %Token, %Token* %l5
  %t77 = extractvalue %Token %t76, 0
  %t78 = extractvalue %TokenKind %t77, 0
  %t79 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t80 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t78, 0
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t78, 1
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t78, 2
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t78, 3
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t78, 4
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t78, 5
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t78, 6
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t78, 7
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %s104 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h590768815, i32 0, i32 0
  %t105 = icmp eq i8* %t103, %s104
  br label %logical_or_right_end_45

logical_or_right_end_45:
  br label %logical_or_merge_45

logical_or_merge_45:
  %t106 = phi i1 [ true, %logical_or_entry_45 ], [ %t105, %logical_or_right_end_45 ]
  %t107 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t108 = load double, double* %l1
  %t109 = load %Token, %Token* %l2
  %t110 = load double, double* %l3
  %t111 = load i8*, i8** %l4
  %t112 = load %Token, %Token* %l5
  br i1 %t106, label %then10, label %merge11
then10:
  %s113 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h721793546, i32 0, i32 0
  %t114 = load %Token, %Token* %l5
  %t115 = extractvalue %Token %t114, 1
  %t116 = call i8* @sailfin_runtime_string_concat(i8* %s113, i8* %t115)
  store i8* %t116, i8** %l4
  %t117 = load double, double* %l3
  %t118 = sitofp i64 1 to double
  %t119 = fadd double %t117, %t118
  %t120 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t119)
  store double %t120, double* %l6
  %t122 = load double, double* %l6
  %t123 = sitofp i64 -1 to double
  %t124 = fcmp une double %t122, %t123
  br label %logical_and_entry_121

logical_and_entry_121:
  br i1 %t124, label %logical_and_right_121, label %logical_and_merge_121

logical_and_right_121:
  %t125 = load double, double* %l6
  %t126 = fptosi double %t125 to i64
  %t127 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t128 = extractvalue { %Token*, i64 } %t127, 0
  %t129 = extractvalue { %Token*, i64 } %t127, 1
  %t130 = icmp uge i64 %t126, %t129
  ; bounds check: %t130 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t126, i64 %t129)
  %t131 = getelementptr %Token, %Token* %t128, i64 %t126
  %t132 = load %Token, %Token* %t131
  %t133 = alloca [2 x i8], align 1
  %t134 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 0
  store i8 123, i8* %t134
  %t135 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 1
  store i8 0, i8* %t135
  %t136 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 0
  %t137 = call i1 @is_symbol_token(%Token %t132, i8* %t136)
  br label %logical_and_right_end_121

logical_and_right_end_121:
  br label %logical_and_merge_121

logical_and_merge_121:
  %t138 = phi i1 [ false, %logical_and_entry_121 ], [ %t137, %logical_and_right_end_121 ]
  %t139 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t140 = load double, double* %l1
  %t141 = load %Token, %Token* %l2
  %t142 = load double, double* %l3
  %t143 = load i8*, i8** %l4
  %t144 = load %Token, %Token* %l5
  %t145 = load double, double* %l6
  br i1 %t138, label %then12, label %merge13
then12:
  %t146 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s147 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t148 = insertvalue %EffectRequirement undef, i8* %s147, 0
  %t149 = load %Token, %Token* %l2
  %t150 = alloca %Token
  store %Token %t149, %Token* %t150
  %t151 = insertvalue %EffectRequirement %t148, %Token* %t150, 1
  %t152 = load i8*, i8** %l4
  %t153 = insertvalue %EffectRequirement %t151, i8* %t152, 2
  %t154 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t146, %EffectRequirement %t153)
  store { %EffectRequirement*, i64 }* %t154, { %EffectRequirement*, i64 }** %l0
  %t155 = load double, double* %l1
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l1
  br label %loop.latch2
merge13:
  %t158 = load i8*, i8** %l4
  %t159 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t160 = load double, double* %l1
  br label %merge11
merge11:
  %t161 = phi i8* [ %t158, %merge13 ], [ %t111, %logical_or_merge_45 ]
  %t162 = phi { %EffectRequirement*, i64 }* [ %t159, %merge13 ], [ %t107, %logical_or_merge_45 ]
  %t163 = phi double [ %t160, %merge13 ], [ %t108, %logical_or_merge_45 ]
  store i8* %t161, i8** %l4
  store { %EffectRequirement*, i64 }* %t162, { %EffectRequirement*, i64 }** %l0
  store double %t163, double* %l1
  %t164 = load i8*, i8** %l4
  %t165 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t166 = load double, double* %l1
  br label %merge9
merge9:
  %t167 = phi i8* [ %t164, %merge11 ], [ %t36, %then6 ]
  %t168 = phi { %EffectRequirement*, i64 }* [ %t165, %merge11 ], [ %t32, %then6 ]
  %t169 = phi double [ %t166, %merge11 ], [ %t33, %then6 ]
  store i8* %t167, i8** %l4
  store { %EffectRequirement*, i64 }* %t168, { %EffectRequirement*, i64 }** %l0
  store double %t169, double* %l1
  %t170 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s171 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t172 = insertvalue %EffectRequirement undef, i8* %s171, 0
  %t173 = load %Token, %Token* %l2
  %t174 = alloca %Token
  store %Token %t173, %Token* %t174
  %t175 = insertvalue %EffectRequirement %t172, %Token* %t174, 1
  %t176 = load i8*, i8** %l4
  %t177 = insertvalue %EffectRequirement %t175, i8* %t176, 2
  %t178 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t170, %EffectRequirement %t177)
  store { %EffectRequirement*, i64 }* %t178, { %EffectRequirement*, i64 }** %l0
  %t179 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t180 = load double, double* %l1
  %t181 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t182 = phi { %EffectRequirement*, i64 }* [ %t179, %merge9 ], [ %t21, %merge5 ]
  %t183 = phi double [ %t180, %merge9 ], [ %t22, %merge5 ]
  %t184 = phi { %EffectRequirement*, i64 }* [ %t181, %merge9 ], [ %t21, %merge5 ]
  store { %EffectRequirement*, i64 }* %t182, { %EffectRequirement*, i64 }** %l0
  store double %t183, double* %l1
  store { %EffectRequirement*, i64 }* %t184, { %EffectRequirement*, i64 }** %l0
  %t185 = load double, double* %l1
  %t186 = sitofp i64 1 to double
  %t187 = fadd double %t185, %t186
  store double %t187, double* %l1
  br label %loop.latch2
loop.latch2:
  %t188 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t189 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t192 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t193 = load double, double* %l1
  %t194 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t194
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
  %t38 = phi { %EffectRequirement*, i64 }* [ %t7, %block.entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t8, %block.entry ], [ %t37, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t38, { %EffectRequirement*, i64 }** %l1
  store double %t39, double* %l2
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
  %t22 = fptosi double %t21 to i64
  %t23 = load { %Token*, i64 }, { %Token*, i64 }* %t20
  %t24 = extractvalue { %Token*, i64 } %t23, 0
  %t25 = extractvalue { %Token*, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t22, i64 %t25)
  %t27 = getelementptr %Token, %Token* %t24, i64 %t22
  %t28 = load %Token, %Token* %t27
  %t29 = alloca %Token
  store %Token %t28, %Token* %t29
  %t30 = insertvalue %EffectRequirement %t19, %Token* %t29, 1
  %t31 = insertvalue %EffectRequirement %t30, i8* %description, 2
  %t32 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t18, %EffectRequirement %t31)
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
  %t34 = phi { %EffectRequirement*, i64 }* [ %t3, %block.entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t4, %block.entry ], [ %t33, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t34, { %EffectRequirement*, i64 }** %l1
  store double %t35, double* %l2
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
  %t18 = fptosi double %t17 to i64
  %t19 = load { %Token*, i64 }, { %Token*, i64 }* %t16
  %t20 = extractvalue { %Token*, i64 } %t19, 0
  %t21 = extractvalue { %Token*, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t18, i64 %t21)
  %t23 = getelementptr %Token, %Token* %t20, i64 %t18
  %t24 = load %Token, %Token* %t23
  %t25 = alloca %Token
  store %Token %t24, %Token* %t25
  %t26 = insertvalue %EffectRequirement %t15, %Token* %t25, 1
  %t27 = insertvalue %EffectRequirement %t26, i8* %description, 2
  %t28 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t14, %EffectRequirement %t27)
  store { %EffectRequirement*, i64 }* %t28, { %EffectRequirement*, i64 }** %l1
  %t29 = load double, double* %l2
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l2
  br label %loop.latch2
loop.latch2:
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t33 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t36 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t37 = load double, double* %l2
  %t38 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t38
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
  %t90 = phi { %Token*, i64 }* [ %t13, %block.entry ], [ %t88, %loop.latch2 ]
  %t91 = phi double [ %t14, %block.entry ], [ %t89, %loop.latch2 ]
  store { %Token*, i64 }* %t90, { %Token*, i64 }** %l0
  store double %t91, double* %l1
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
  %t23 = fptosi double %t22 to i64
  %t24 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t25 = extractvalue { %Token*, i64 } %t24, 0
  %t26 = extractvalue { %Token*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %Token, %Token* %t25, i64 %t23
  %t29 = load %Token, %Token* %t28
  %t30 = call i1 @is_identifier_token(%Token %t29, i8* %name)
  %t31 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then6, label %merge7
then6:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t35)
  store double %t36, double* %l2
  %t38 = load double, double* %l2
  %t39 = sitofp i64 -1 to double
  %t40 = fcmp une double %t38, %t39
  br label %logical_and_entry_37

logical_and_entry_37:
  br i1 %t40, label %logical_and_right_37, label %logical_and_merge_37

logical_and_right_37:
  %t41 = load double, double* %l2
  %t42 = fptosi double %t41 to i64
  %t43 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t44 = extractvalue { %Token*, i64 } %t43, 0
  %t45 = extractvalue { %Token*, i64 } %t43, 1
  %t46 = icmp uge i64 %t42, %t45
  ; bounds check: %t46 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t42, i64 %t45)
  %t47 = getelementptr %Token, %Token* %t44, i64 %t42
  %t48 = load %Token, %Token* %t47
  %t49 = call i1 @is_symbol_token(%Token %t48, i8* %symbol)
  br label %logical_and_right_end_37

logical_and_right_end_37:
  br label %logical_and_merge_37

logical_and_merge_37:
  %t50 = phi i1 [ false, %logical_and_entry_37 ], [ %t49, %logical_and_right_end_37 ]
  %t51 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = load double, double* %l2
  br i1 %t50, label %then8, label %merge9
then8:
  %t54 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = fptosi double %t55 to i64
  %t57 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t58 = extractvalue { %Token*, i64 } %t57, 0
  %t59 = extractvalue { %Token*, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t56, i64 %t59)
  %t61 = getelementptr %Token, %Token* %t58, i64 %t56
  %t62 = load %Token, %Token* %t61
  %t63 = call noalias i8* @malloc(i64 32)
  %t64 = bitcast i8* %t63 to %Token*
  store %Token %t62, %Token* %t64
  %t65 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t66 = ptrtoint [1 x i8*]* %t65 to i64
  %t67 = icmp eq i64 %t66, 0
  %t68 = select i1 %t67, i64 1, i64 %t66
  %t69 = call i8* @malloc(i64 %t68)
  %t70 = bitcast i8* %t69 to i8**
  %t71 = getelementptr i8*, i8** %t70, i64 0
  store i8* %t63, i8** %t71
  %t72 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t73 = ptrtoint { i8**, i64 }* %t72 to i64
  %t74 = call i8* @malloc(i64 %t73)
  %t75 = bitcast i8* %t74 to { i8**, i64 }*
  %t76 = getelementptr { i8**, i64 }, { i8**, i64 }* %t75, i32 0, i32 0
  store i8** %t70, i8*** %t76
  %t77 = getelementptr { i8**, i64 }, { i8**, i64 }* %t75, i32 0, i32 1
  store i64 1, i64* %t77
  %t78 = bitcast { %Token*, i64 }* %t54 to { i8**, i64 }*
  %t79 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t78, { i8**, i64 }* %t75)
  %t80 = bitcast { i8**, i64 }* %t79 to { %Token*, i64 }*
  store { %Token*, i64 }* %t80, { %Token*, i64 }** %l0
  %t81 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t82 = phi { %Token*, i64 }* [ %t81, %then8 ], [ %t51, %logical_and_merge_37 ]
  store { %Token*, i64 }* %t82, { %Token*, i64 }** %l0
  %t83 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t84 = phi { %Token*, i64 }* [ %t83, %merge9 ], [ %t31, %merge5 ]
  store { %Token*, i64 }* %t84, { %Token*, i64 }** %l0
  %t85 = load double, double* %l1
  %t86 = sitofp i64 1 to double
  %t87 = fadd double %t85, %t86
  store double %t87, double* %l1
  br label %loop.latch2
loop.latch2:
  %t88 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t89 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t92 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t93 = load double, double* %l1
  %t94 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t94
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
  %t94 = phi { %Token*, i64 }* [ %t13, %block.entry ], [ %t92, %loop.latch2 ]
  %t95 = phi double [ %t14, %block.entry ], [ %t93, %loop.latch2 ]
  store { %Token*, i64 }* %t94, { %Token*, i64 }** %l0
  store double %t95, double* %l1
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
  %t23 = fptosi double %t22 to i64
  %t24 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t25 = extractvalue { %Token*, i64 } %t24, 0
  %t26 = extractvalue { %Token*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr %Token, %Token* %t25, i64 %t23
  %t29 = load %Token, %Token* %t28
  %t30 = call i1 @is_identifier_token(%Token %t29, i8* %name)
  %t31 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then6, label %merge7
then6:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t35)
  store double %t36, double* %l2
  %t38 = load double, double* %l2
  %t39 = sitofp i64 -1 to double
  %t40 = fcmp une double %t38, %t39
  br label %logical_and_entry_37

logical_and_entry_37:
  br i1 %t40, label %logical_and_right_37, label %logical_and_merge_37

logical_and_right_37:
  %t41 = load double, double* %l2
  %t42 = fptosi double %t41 to i64
  %t43 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t44 = extractvalue { %Token*, i64 } %t43, 0
  %t45 = extractvalue { %Token*, i64 } %t43, 1
  %t46 = icmp uge i64 %t42, %t45
  ; bounds check: %t46 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t42, i64 %t45)
  %t47 = getelementptr %Token, %Token* %t44, i64 %t42
  %t48 = load %Token, %Token* %t47
  %t49 = alloca [2 x i8], align 1
  %t50 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  store i8 40, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 1
  store i8 0, i8* %t51
  %t52 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  %t53 = call i1 @is_symbol_token(%Token %t48, i8* %t52)
  br label %logical_and_right_end_37

logical_and_right_end_37:
  br label %logical_and_merge_37

logical_and_merge_37:
  %t54 = phi i1 [ false, %logical_and_entry_37 ], [ %t53, %logical_and_right_end_37 ]
  %t55 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  br i1 %t54, label %then8, label %merge9
then8:
  %t58 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t59 = load double, double* %l1
  %t60 = fptosi double %t59 to i64
  %t61 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t62 = extractvalue { %Token*, i64 } %t61, 0
  %t63 = extractvalue { %Token*, i64 } %t61, 1
  %t64 = icmp uge i64 %t60, %t63
  ; bounds check: %t64 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t60, i64 %t63)
  %t65 = getelementptr %Token, %Token* %t62, i64 %t60
  %t66 = load %Token, %Token* %t65
  %t67 = call noalias i8* @malloc(i64 32)
  %t68 = bitcast i8* %t67 to %Token*
  store %Token %t66, %Token* %t68
  %t69 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t70 = ptrtoint [1 x i8*]* %t69 to i64
  %t71 = icmp eq i64 %t70, 0
  %t72 = select i1 %t71, i64 1, i64 %t70
  %t73 = call i8* @malloc(i64 %t72)
  %t74 = bitcast i8* %t73 to i8**
  %t75 = getelementptr i8*, i8** %t74, i64 0
  store i8* %t67, i8** %t75
  %t76 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t77 = ptrtoint { i8**, i64 }* %t76 to i64
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to { i8**, i64 }*
  %t80 = getelementptr { i8**, i64 }, { i8**, i64 }* %t79, i32 0, i32 0
  store i8** %t74, i8*** %t80
  %t81 = getelementptr { i8**, i64 }, { i8**, i64 }* %t79, i32 0, i32 1
  store i64 1, i64* %t81
  %t82 = bitcast { %Token*, i64 }* %t58 to { i8**, i64 }*
  %t83 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t82, { i8**, i64 }* %t79)
  %t84 = bitcast { i8**, i64 }* %t83 to { %Token*, i64 }*
  store { %Token*, i64 }* %t84, { %Token*, i64 }** %l0
  %t85 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t86 = phi { %Token*, i64 }* [ %t85, %then8 ], [ %t55, %logical_and_merge_37 ]
  store { %Token*, i64 }* %t86, { %Token*, i64 }** %l0
  %t87 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t88 = phi { %Token*, i64 }* [ %t87, %merge9 ], [ %t31, %merge5 ]
  store { %Token*, i64 }* %t88, { %Token*, i64 }** %l0
  %t89 = load double, double* %l1
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  store double %t91, double* %l1
  br label %loop.latch2
loop.latch2:
  %t92 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t93 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t96 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t97 = load double, double* %l1
  %t98 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t98
}

define double @next_non_trivia({ %Token*, i64 }* %tokens, double %start) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %Token
  store double %start, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t0, %block.entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
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
  %t8 = fptosi double %t7 to i64
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 0
  %t11 = extractvalue { %Token*, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t8, i64 %t11)
  %t13 = getelementptr %Token, %Token* %t10, i64 %t8
  %t14 = load %Token, %Token* %t13
  store %Token %t14, %Token* %l1
  %t15 = load %Token, %Token* %l1
  %t16 = call i1 @is_trivia_token(%Token %t15)
  %t17 = xor i1 %t16, 1
  %t18 = load double, double* %l0
  %t19 = load %Token, %Token* %l1
  br i1 %t17, label %then6, label %merge7
then6:
  %t20 = load double, double* %l0
  ret double %t20
merge7:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l0
  br label %loop.latch2
loop.latch2:
  %t24 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t26 = load double, double* %l0
  %t27 = sitofp i64 -1 to double
  ret double %t27
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
  %t29 = icmp eq i8* %t27, %s28
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
  %t58 = icmp eq i8* %t56, %s57
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
  %t28 = icmp eq i8* %t26, %s27
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
  %t67 = icmp eq i8* %t66, %expected
  ret i1 %t67
merge3:
  br label %merge1
merge1:
  %t68 = extractvalue %Token %token, 1
  %t69 = icmp eq i8* %t68, %expected
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
  %t28 = icmp eq i8* %t26, %s27
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
  %t67 = icmp eq i8* %t66, %expected
  ret i1 %t67
merge3:
  br label %merge1
merge1:
  %t68 = extractvalue %Token %token, 1
  %t69 = icmp eq i8* %t68, %expected
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
  %t42 = phi { %EffectViolation*, i64 }* [ %t1, %block.entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t2, %block.entry ], [ %t41, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t42, { %EffectViolation*, i64 }** %l0
  store double %t43, double* %l1
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
  %t12 = fptosi double %t11 to i64
  %t13 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %new_violations
  %t14 = extractvalue { %EffectViolation*, i64 } %t13, 0
  %t15 = extractvalue { %EffectViolation*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %EffectViolation, %EffectViolation* %t14, i64 %t12
  %t18 = load %EffectViolation, %EffectViolation* %t17
  %t19 = call noalias i8* @malloc(i64 24)
  %t20 = bitcast i8* %t19 to %EffectViolation*
  store %EffectViolation %t18, %EffectViolation* %t20
  %t21 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t22 = ptrtoint [1 x i8*]* %t21 to i64
  %t23 = icmp eq i64 %t22, 0
  %t24 = select i1 %t23, i64 1, i64 %t22
  %t25 = call i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to i8**
  %t27 = getelementptr i8*, i8** %t26, i64 0
  store i8* %t19, i8** %t27
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t29 = ptrtoint { i8**, i64 }* %t28 to i64
  %t30 = call i8* @malloc(i64 %t29)
  %t31 = bitcast i8* %t30 to { i8**, i64 }*
  %t32 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 0
  store i8** %t26, i8*** %t32
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 1
  store i64 1, i64* %t33
  %t34 = bitcast { %EffectViolation*, i64 }* %t10 to { i8**, i64 }*
  %t35 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t34, { i8**, i64 }* %t31)
  %t36 = bitcast { i8**, i64 }* %t35 to { %EffectViolation*, i64 }*
  store { %EffectViolation*, i64 }* %t36, { %EffectViolation*, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch2
loop.latch2:
  %t40 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t41 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t44 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t46
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
  %t16 = icmp eq i8* %t15, %effect
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
  %t42 = phi { %EffectRequirement*, i64 }* [ %t1, %block.entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t2, %block.entry ], [ %t41, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t42, { %EffectRequirement*, i64 }** %l0
  store double %t43, double* %l1
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
  %t12 = fptosi double %t11 to i64
  %t13 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %additions
  %t14 = extractvalue { %EffectRequirement*, i64 } %t13, 0
  %t15 = extractvalue { %EffectRequirement*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %EffectRequirement, %EffectRequirement* %t14, i64 %t12
  %t18 = load %EffectRequirement, %EffectRequirement* %t17
  %t19 = call noalias i8* @malloc(i64 24)
  %t20 = bitcast i8* %t19 to %EffectRequirement*
  store %EffectRequirement %t18, %EffectRequirement* %t20
  %t21 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t22 = ptrtoint [1 x i8*]* %t21 to i64
  %t23 = icmp eq i64 %t22, 0
  %t24 = select i1 %t23, i64 1, i64 %t22
  %t25 = call i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to i8**
  %t27 = getelementptr i8*, i8** %t26, i64 0
  store i8* %t19, i8** %t27
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t29 = ptrtoint { i8**, i64 }* %t28 to i64
  %t30 = call i8* @malloc(i64 %t29)
  %t31 = bitcast i8* %t30 to { i8**, i64 }*
  %t32 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 0
  store i8** %t26, i8*** %t32
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 1
  store i64 1, i64* %t33
  %t34 = bitcast { %EffectRequirement*, i64 }* %t10 to { i8**, i64 }*
  %t35 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t34, { i8**, i64 }* %t31)
  %t36 = bitcast { i8**, i64 }* %t35 to { %EffectRequirement*, i64 }*
  store { %EffectRequirement*, i64 }* %t36, { %EffectRequirement*, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch2
loop.latch2:
  %t40 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t41 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t44 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t46
}

define i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
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
  %t9 = fptosi double %t8 to i64
  %t10 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t11 = extractvalue { %EffectRequirement*, i64 } %t10, 0
  %t12 = extractvalue { %EffectRequirement*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr %EffectRequirement, %EffectRequirement* %t11, i64 %t9
  %t15 = load %EffectRequirement, %EffectRequirement* %t14
  %t16 = extractvalue %EffectRequirement %t15, 0
  %t17 = icmp eq i8* %t16, %effect
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.enum.Statement.EnumDeclaration.variant = private unnamed_addr constant [16 x i8] c"EnumDeclaration\00"
@.enum.Statement.PipelineDeclaration.variant = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Expression.Index.variant = private unnamed_addr constant [6 x i8] c"Index\00"
@.str.len15.h889179835 = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.str.len9.h1700456022 = private unnamed_addr constant [10 x i8] c"pipeline \00"
@.enum.Statement.ExportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ExportDeclaration\00"
@.str.len3.h2089530004 = private unnamed_addr constant [4 x i8] c"Raw\00"
@.str.len5.h238194529 = private unnamed_addr constant [6 x i8] c"model\00"
@.str.len4.h217216103 = private unnamed_addr constant [5 x i8] c"Call\00"
@.enum.Expression.Unary.variant = private unnamed_addr constant [6 x i8] c"Unary\00"
@.str.len5.h500835952 = private unnamed_addr constant [6 x i8] c"test \00"
@.enum.Statement.PromptStatement.variant = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.enum.Statement.ReturnStatement.variant = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.enum.Expression.Lambda.variant = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.enum.Expression.NullLiteral.variant = private unnamed_addr constant [12 x i8] c"NullLiteral\00"
@.str.len19.h868168677 = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.enum.Statement.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len19.h479148896 = private unnamed_addr constant [20 x i8] c"PipelineDeclaration\00"
@.enum.Expression.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Expression.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.str.len5.h512542702 = private unnamed_addr constant [6 x i8] c"tool \00"
@.str.len5.h515589823 = private unnamed_addr constant [6 x i8] c"trace\00"
@.str.len13.h1678412334 = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.str.len5.h1312780988 = private unnamed_addr constant [6 x i8] c"Range\00"
@.enum.Expression.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.Expression.Range.variant = private unnamed_addr constant [6 x i8] c"Range\00"
@.str.len15.h1067284810 = private unnamed_addr constant [16 x i8] c"PromptStatement\00"
@.enum.Statement.StructDeclaration.variant = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.enum.Expression.Raw.variant = private unnamed_addr constant [4 x i8] c"Raw\00"
@.str.len19.h486335986 = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Statement.LoopStatement.variant = private unnamed_addr constant [14 x i8] c"LoopStatement\00"
@.str.len13.h590768815 = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.Expression.Struct.variant = private unnamed_addr constant [7 x i8] c"Struct\00"
@.str.len15.h1613933868 = private unnamed_addr constant [16 x i8] c"ReturnStatement\00"
@.str.len8.h196867800 = private unnamed_addr constant [9 x i8] c"prompt \22\00"
@.enum.Statement.BreakStatement.variant = private unnamed_addr constant [15 x i8] c"BreakStatement\00"
@.str.len12.h1170311443 = private unnamed_addr constant [13 x i8] c"logexecution\00"
@.str.len6.h1211862785 = private unnamed_addr constant [7 x i8] c"Lambda\00"
@.str.len10.h1576352120 = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.str.len19.h1204027478 = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.enum.Statement.TypeAliasDeclaration.variant = private unnamed_addr constant [21 x i8] c"TypeAliasDeclaration\00"
@.str.len12.h84042670 = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.str.len6.h453982107 = private unnamed_addr constant [7 x i8] c"Symbol\00"
@.enum.Statement.InterfaceDeclaration.variant = private unnamed_addr constant [21 x i8] c"InterfaceDeclaration\00"
@.enum.Statement.ToolDeclaration.variant = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.enum.Statement.ModelDeclaration.variant = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len14.h196308685 = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.enum.Expression.Member.variant = private unnamed_addr constant [7 x i8] c"Member\00"
@.enum.Statement.MatchStatement.variant = private unnamed_addr constant [15 x i8] c"MatchStatement\00"
@.str.len7.h48777630 = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.enum.Expression.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.Statement.VariableDeclaration.variant = private unnamed_addr constant [20 x i8] c"VariableDeclaration\00"
@.str.len11.h1566780570 = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Statement.ImportDeclaration.variant = private unnamed_addr constant [18 x i8] c"ImportDeclaration\00"
@.str.len6.h1496334143 = private unnamed_addr constant [7 x i8] c"Binary\00"
@.enum.Statement.ForStatement.variant = private unnamed_addr constant [13 x i8] c"ForStatement\00"
@.enum.Expression.Array.variant = private unnamed_addr constant [6 x i8] c"Array\00"
@.enum.Expression.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.Statement.ContinueStatement.variant = private unnamed_addr constant [18 x i8] c"ContinueStatement\00"
@.str.len12.h1147459442 = private unnamed_addr constant [13 x i8] c"logExecution\00"
@.str.len17.h1842783069 = private unnamed_addr constant [18 x i8] c"StructDeclaration\00"
@.str.len6.h512390329 = private unnamed_addr constant [7 x i8] c"Member\00"
@.str.len6.h826984377 = private unnamed_addr constant [7 x i8] c"Object\00"
@.str.len5.h1445149598 = private unnamed_addr constant [6 x i8] c"Unary\00"
@.enum.Expression.Object.variant = private unnamed_addr constant [7 x i8] c"Object\00"
@.str.len15.h571715647 = private unnamed_addr constant [16 x i8] c"ToolDeclaration\00"
@.enum.Statement.ExpressionStatement.variant = private unnamed_addr constant [20 x i8] c"ExpressionStatement\00"
@.enum.Statement.WithStatement.variant = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Statement.TestDeclaration.variant = private unnamed_addr constant [16 x i8] c"TestDeclaration\00"
@.enum.Statement.IfStatement.variant = private unnamed_addr constant [12 x i8] c"IfStatement\00"
@.enum.Statement.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len7.h721793546 = private unnamed_addr constant [8 x i8] c"prompt \00"
@.enum.Statement.FunctionDeclaration.variant = private unnamed_addr constant [20 x i8] c"FunctionDeclaration\00"
@.enum.Expression.Binary.variant = private unnamed_addr constant [7 x i8] c"Binary\00"
@.str.len6.h1128151960 = private unnamed_addr constant [7 x i8] c"prompt\00"
@.str.len12.h10983220 = private unnamed_addr constant [13 x i8] c"prompt block\00"
@.str.len16.h2043328844 = private unnamed_addr constant [17 x i8] c"ModelDeclaration\00"
@.str.len5.h667777838 = private unnamed_addr constant [6 x i8] c"Array\00"
@.str.len5.h975618503 = private unnamed_addr constant [6 x i8] c"Index\00"
@.str.len6.h264904746 = private unnamed_addr constant [7 x i8] c"Struct\00"
@.str.len13.h1925822000 = private unnamed_addr constant [14 x i8] c"WithStatement\00"
@.enum.Expression.Call.variant = private unnamed_addr constant [5 x i8] c"Call\00"
