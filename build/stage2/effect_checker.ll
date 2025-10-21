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

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.8 = private unnamed_addr constant [3 x i8] c"fs\00"
@.str.9 = private unnamed_addr constant [3 x i8] c"io\00"
@.str.10 = private unnamed_addr constant [24 x i8] c"filesystem helper usage\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"print\00"
@.str.14 = private unnamed_addr constant [3 x i8] c"io\00"
@.str.15 = private unnamed_addr constant [19 x i8] c"print helper usage\00"
@.str.18 = private unnamed_addr constant [8 x i8] c"console\00"
@.str.19 = private unnamed_addr constant [3 x i8] c"io\00"
@.str.20 = private unnamed_addr constant [21 x i8] c"console helper usage\00"
@.str.23 = private unnamed_addr constant [5 x i8] c"http\00"
@.str.24 = private unnamed_addr constant [4 x i8] c"net\00"
@.str.25 = private unnamed_addr constant [18 x i8] c"http helper usage\00"
@.str.28 = private unnamed_addr constant [10 x i8] c"websocket\00"
@.str.29 = private unnamed_addr constant [4 x i8] c"net\00"
@.str.30 = private unnamed_addr constant [23 x i8] c"websocket helper usage\00"
@.str.33 = private unnamed_addr constant [6 x i8] c"spawn\00"
@.str.34 = private unnamed_addr constant [3 x i8] c"io\00"
@.str.35 = private unnamed_addr constant [11 x i8] c"spawn call\00"
@.str.38 = private unnamed_addr constant [6 x i8] c"serve\00"
@.str.39 = private unnamed_addr constant [4 x i8] c"net\00"
@.str.40 = private unnamed_addr constant [11 x i8] c"serve call\00"
@.str.43 = private unnamed_addr constant [6 x i8] c"sleep\00"
@.str.44 = private unnamed_addr constant [6 x i8] c"clock\00"
@.str.45 = private unnamed_addr constant [11 x i8] c"sleep call\00"
@.enum.TokenKind.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.TokenKind.Identifier.variant = private unnamed_addr constant [11 x i8] c"Identifier\00"
@.enum.TokenKind.NumberLiteral.variant = private unnamed_addr constant [14 x i8] c"NumberLiteral\00"
@.enum.TokenKind.StringLiteral.variant = private unnamed_addr constant [14 x i8] c"StringLiteral\00"
@.enum.TokenKind.BooleanLiteral.variant = private unnamed_addr constant [15 x i8] c"BooleanLiteral\00"
@.enum.TokenKind.Symbol.variant = private unnamed_addr constant [7 x i8] c"Symbol\00"
@.enum.TokenKind.Whitespace.variant = private unnamed_addr constant [11 x i8] c"Whitespace\00"
@.enum.TokenKind.Comment.variant = private unnamed_addr constant [8 x i8] c"Comment\00"
@.enum.TokenKind.EndOfFile.variant = private unnamed_addr constant [10 x i8] c"EndOfFile\00"
@.str.57 = private unnamed_addr constant [8 x i8] c"Comment\00"

define { %EffectViolation*, i64 }* @validate_effects(%Program %program) {
entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  %l2 = alloca %Statement*
  %t0 = alloca [0 x %EffectViolation]
  %t1 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t0, i32 0, i32 0
  %t2 = alloca { %EffectViolation*, i64 }
  %t3 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t2, i32 0, i32 0
  store %EffectViolation* %t1, %EffectViolation** %t3
  %t4 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %EffectViolation*, i64 }* %t2, { %EffectViolation*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t35 = phi { %EffectViolation*, i64 }* [ %t6, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t7, %entry ], [ %t34, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t35, { %EffectViolation*, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %Program %program, 0
  %t10 = load { %Statement**, i64 }, { %Statement**, i64 }* %t9
  %t11 = extractvalue { %Statement**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = extractvalue %Program %program, 0
  %t17 = load double, double* %l1
  %t18 = fptosi double %t17 to i64
  %t19 = load { %Statement**, i64 }, { %Statement**, i64 }* %t16
  %t20 = extractvalue { %Statement**, i64 } %t19, 0
  %t21 = extractvalue { %Statement**, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr %Statement*, %Statement** %t20, i64 %t18
  %t24 = load %Statement*, %Statement** %t23
  store %Statement* %t24, %Statement** %l2
  %t25 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t26 = load %Statement*, %Statement** %l2
  %t27 = load %Statement, %Statement* %t26
  %t28 = call { %EffectViolation*, i64 }* @analyze_statement(%Statement %t27)
  %t29 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t25, { %EffectViolation*, i64 }* %t28)
  store { %EffectViolation*, i64 }* %t29, { %EffectViolation*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t37
}

define { %EffectViolation*, i64 }* @analyze_statement(%Statement %statement) {
entry:
  %l0 = alloca %FunctionSignature
  %l1 = alloca i8*
  %l2 = alloca %FunctionSignature
  %l3 = alloca i8*
  %l4 = alloca %FunctionSignature
  %l5 = alloca i8*
  %l6 = alloca { %EffectViolation*, i64 }*
  %l7 = alloca double
  %l8 = alloca %MethodDeclaration*
  %l9 = alloca i8
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
  %s351 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.351, i32 0, i32 0
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
  %s373 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.373, i32 0, i32 0
  %t374 = load %FunctionSignature, %FunctionSignature* %l0
  %t375 = extractvalue %FunctionSignature %t374, 0
  %t376 = add i8* %s373, %t375
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
  %s616 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.616, i32 0, i32 0
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
  %s638 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.638, i32 0, i32 0
  %t639 = load %FunctionSignature, %FunctionSignature* %l2
  %t640 = extractvalue %FunctionSignature %t639, 0
  %t641 = add i8* %s638, %t640
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
  %s881 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.881, i32 0, i32 0
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
  %t929 = alloca [0 x %Parameter*]
  %t930 = getelementptr [0 x %Parameter*], [0 x %Parameter*]* %t929, i32 0, i32 0
  %t931 = alloca { %Parameter**, i64 }
  %t932 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t931, i32 0, i32 0
  store %Parameter** %t930, %Parameter*** %t932
  %t933 = getelementptr { %Parameter**, i64 }, { %Parameter**, i64 }* %t931, i32 0, i32 1
  store i64 0, i64* %t933
  %t934 = insertvalue %FunctionSignature %t928, { %Parameter**, i64 }* %t931, 2
  %t935 = bitcast i8* null to %TypeAnnotation*
  %t936 = insertvalue %FunctionSignature %t934, %TypeAnnotation* %t935, 3
  %t937 = extractvalue %Statement %statement, 0
  %t938 = alloca %Statement
  store %Statement %statement, %Statement* %t938
  %t939 = getelementptr inbounds %Statement, %Statement* %t938, i32 0, i32 1
  %t940 = bitcast [48 x i8]* %t939 to i8*
  %t941 = getelementptr inbounds i8, i8* %t940, i64 32
  %t942 = bitcast i8* %t941 to { i8**, i64 }**
  %t943 = load { i8**, i64 }*, { i8**, i64 }** %t942
  %t944 = icmp eq i32 %t937, 3
  %t945 = select i1 %t944, { i8**, i64 }* %t943, { i8**, i64 }* null
  %t946 = getelementptr inbounds %Statement, %Statement* %t938, i32 0, i32 1
  %t947 = bitcast [40 x i8]* %t946 to i8*
  %t948 = getelementptr inbounds i8, i8* %t947, i64 24
  %t949 = bitcast i8* %t948 to { i8**, i64 }**
  %t950 = load { i8**, i64 }*, { i8**, i64 }** %t949
  %t951 = icmp eq i32 %t937, 6
  %t952 = select i1 %t951, { i8**, i64 }* %t950, { i8**, i64 }* %t945
  %t953 = insertvalue %FunctionSignature %t936, { i8**, i64 }* %t952, 4
  %t954 = alloca [0 x %TypeParameter*]
  %t955 = getelementptr [0 x %TypeParameter*], [0 x %TypeParameter*]* %t954, i32 0, i32 0
  %t956 = alloca { %TypeParameter**, i64 }
  %t957 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t956, i32 0, i32 0
  store %TypeParameter** %t955, %TypeParameter*** %t957
  %t958 = getelementptr { %TypeParameter**, i64 }, { %TypeParameter**, i64 }* %t956, i32 0, i32 1
  store i64 0, i64* %t958
  %t959 = insertvalue %FunctionSignature %t953, { %TypeParameter**, i64 }* %t956, 5
  %t960 = bitcast i8* null to %SourceSpan*
  %t961 = insertvalue %FunctionSignature %t959, %SourceSpan* %t960, 6
  store %FunctionSignature %t961, %FunctionSignature* %l4
  %s962 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.962, i32 0, i32 0
  %t963 = extractvalue %Statement %statement, 0
  %t964 = alloca %Statement
  store %Statement %statement, %Statement* %t964
  %t965 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t966 = bitcast [48 x i8]* %t965 to i8*
  %t967 = bitcast i8* %t966 to i8**
  %t968 = load i8*, i8** %t967
  %t969 = icmp eq i32 %t963, 2
  %t970 = select i1 %t969, i8* %t968, i8* null
  %t971 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t972 = bitcast [48 x i8]* %t971 to i8*
  %t973 = bitcast i8* %t972 to i8**
  %t974 = load i8*, i8** %t973
  %t975 = icmp eq i32 %t963, 3
  %t976 = select i1 %t975, i8* %t974, i8* %t970
  %t977 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t978 = bitcast [40 x i8]* %t977 to i8*
  %t979 = bitcast i8* %t978 to i8**
  %t980 = load i8*, i8** %t979
  %t981 = icmp eq i32 %t963, 6
  %t982 = select i1 %t981, i8* %t980, i8* %t976
  %t983 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t984 = bitcast [56 x i8]* %t983 to i8*
  %t985 = bitcast i8* %t984 to i8**
  %t986 = load i8*, i8** %t985
  %t987 = icmp eq i32 %t963, 8
  %t988 = select i1 %t987, i8* %t986, i8* %t982
  %t989 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t990 = bitcast [40 x i8]* %t989 to i8*
  %t991 = bitcast i8* %t990 to i8**
  %t992 = load i8*, i8** %t991
  %t993 = icmp eq i32 %t963, 9
  %t994 = select i1 %t993, i8* %t992, i8* %t988
  %t995 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t996 = bitcast [40 x i8]* %t995 to i8*
  %t997 = bitcast i8* %t996 to i8**
  %t998 = load i8*, i8** %t997
  %t999 = icmp eq i32 %t963, 10
  %t1000 = select i1 %t999, i8* %t998, i8* %t994
  %t1001 = getelementptr inbounds %Statement, %Statement* %t964, i32 0, i32 1
  %t1002 = bitcast [40 x i8]* %t1001 to i8*
  %t1003 = bitcast i8* %t1002 to i8**
  %t1004 = load i8*, i8** %t1003
  %t1005 = icmp eq i32 %t963, 11
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1000
  %t1007 = add i8* %s962, %t1006
  store i8* %t1007, i8** %l5
  %t1008 = load %FunctionSignature, %FunctionSignature* %l4
  %t1009 = extractvalue %Statement %statement, 0
  %t1010 = alloca %Statement
  store %Statement %statement, %Statement* %t1010
  %t1011 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1012 = bitcast [24 x i8]* %t1011 to i8*
  %t1013 = getelementptr inbounds i8, i8* %t1012, i64 8
  %t1014 = bitcast i8* %t1013 to %Block*
  %t1015 = load %Block, %Block* %t1014
  %t1016 = icmp eq i32 %t1009, 4
  %t1017 = select i1 %t1016, %Block %t1015, %Block zeroinitializer
  %t1018 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1019 = bitcast [24 x i8]* %t1018 to i8*
  %t1020 = getelementptr inbounds i8, i8* %t1019, i64 8
  %t1021 = bitcast i8* %t1020 to %Block*
  %t1022 = load %Block, %Block* %t1021
  %t1023 = icmp eq i32 %t1009, 5
  %t1024 = select i1 %t1023, %Block %t1022, %Block %t1017
  %t1025 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1026 = bitcast [40 x i8]* %t1025 to i8*
  %t1027 = getelementptr inbounds i8, i8* %t1026, i64 16
  %t1028 = bitcast i8* %t1027 to %Block*
  %t1029 = load %Block, %Block* %t1028
  %t1030 = icmp eq i32 %t1009, 6
  %t1031 = select i1 %t1030, %Block %t1029, %Block %t1024
  %t1032 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1033 = bitcast [24 x i8]* %t1032 to i8*
  %t1034 = getelementptr inbounds i8, i8* %t1033, i64 8
  %t1035 = bitcast i8* %t1034 to %Block*
  %t1036 = load %Block, %Block* %t1035
  %t1037 = icmp eq i32 %t1009, 7
  %t1038 = select i1 %t1037, %Block %t1036, %Block %t1031
  %t1039 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1040 = bitcast [40 x i8]* %t1039 to i8*
  %t1041 = getelementptr inbounds i8, i8* %t1040, i64 24
  %t1042 = bitcast i8* %t1041 to %Block*
  %t1043 = load %Block, %Block* %t1042
  %t1044 = icmp eq i32 %t1009, 12
  %t1045 = select i1 %t1044, %Block %t1043, %Block %t1038
  %t1046 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1047 = bitcast [24 x i8]* %t1046 to i8*
  %t1048 = getelementptr inbounds i8, i8* %t1047, i64 8
  %t1049 = bitcast i8* %t1048 to %Block*
  %t1050 = load %Block, %Block* %t1049
  %t1051 = icmp eq i32 %t1009, 13
  %t1052 = select i1 %t1051, %Block %t1050, %Block %t1045
  %t1053 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1054 = bitcast [24 x i8]* %t1053 to i8*
  %t1055 = getelementptr inbounds i8, i8* %t1054, i64 8
  %t1056 = bitcast i8* %t1055 to %Block*
  %t1057 = load %Block, %Block* %t1056
  %t1058 = icmp eq i32 %t1009, 14
  %t1059 = select i1 %t1058, %Block %t1057, %Block %t1052
  %t1060 = getelementptr inbounds %Statement, %Statement* %t1010, i32 0, i32 1
  %t1061 = bitcast [16 x i8]* %t1060 to i8*
  %t1062 = bitcast i8* %t1061 to %Block*
  %t1063 = load %Block, %Block* %t1062
  %t1064 = icmp eq i32 %t1009, 15
  %t1065 = select i1 %t1064, %Block %t1063, %Block %t1059
  %t1066 = extractvalue %Statement %statement, 0
  %t1067 = alloca %Statement
  store %Statement %statement, %Statement* %t1067
  %t1068 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1069 = bitcast [48 x i8]* %t1068 to i8*
  %t1070 = getelementptr inbounds i8, i8* %t1069, i64 40
  %t1071 = bitcast i8* %t1070 to { %Decorator**, i64 }**
  %t1072 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1071
  %t1073 = icmp eq i32 %t1066, 3
  %t1074 = select i1 %t1073, { %Decorator**, i64 }* %t1072, { %Decorator**, i64 }* null
  %t1075 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1076 = bitcast [24 x i8]* %t1075 to i8*
  %t1077 = getelementptr inbounds i8, i8* %t1076, i64 16
  %t1078 = bitcast i8* %t1077 to { %Decorator**, i64 }**
  %t1079 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1078
  %t1080 = icmp eq i32 %t1066, 4
  %t1081 = select i1 %t1080, { %Decorator**, i64 }* %t1079, { %Decorator**, i64 }* %t1074
  %t1082 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1083 = bitcast [24 x i8]* %t1082 to i8*
  %t1084 = getelementptr inbounds i8, i8* %t1083, i64 16
  %t1085 = bitcast i8* %t1084 to { %Decorator**, i64 }**
  %t1086 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1085
  %t1087 = icmp eq i32 %t1066, 5
  %t1088 = select i1 %t1087, { %Decorator**, i64 }* %t1086, { %Decorator**, i64 }* %t1081
  %t1089 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1090 = bitcast [40 x i8]* %t1089 to i8*
  %t1091 = getelementptr inbounds i8, i8* %t1090, i64 32
  %t1092 = bitcast i8* %t1091 to { %Decorator**, i64 }**
  %t1093 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1092
  %t1094 = icmp eq i32 %t1066, 6
  %t1095 = select i1 %t1094, { %Decorator**, i64 }* %t1093, { %Decorator**, i64 }* %t1088
  %t1096 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1097 = bitcast [24 x i8]* %t1096 to i8*
  %t1098 = getelementptr inbounds i8, i8* %t1097, i64 16
  %t1099 = bitcast i8* %t1098 to { %Decorator**, i64 }**
  %t1100 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1099
  %t1101 = icmp eq i32 %t1066, 7
  %t1102 = select i1 %t1101, { %Decorator**, i64 }* %t1100, { %Decorator**, i64 }* %t1095
  %t1103 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1104 = bitcast [56 x i8]* %t1103 to i8*
  %t1105 = getelementptr inbounds i8, i8* %t1104, i64 48
  %t1106 = bitcast i8* %t1105 to { %Decorator**, i64 }**
  %t1107 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1106
  %t1108 = icmp eq i32 %t1066, 8
  %t1109 = select i1 %t1108, { %Decorator**, i64 }* %t1107, { %Decorator**, i64 }* %t1102
  %t1110 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1111 = bitcast [40 x i8]* %t1110 to i8*
  %t1112 = getelementptr inbounds i8, i8* %t1111, i64 32
  %t1113 = bitcast i8* %t1112 to { %Decorator**, i64 }**
  %t1114 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1113
  %t1115 = icmp eq i32 %t1066, 9
  %t1116 = select i1 %t1115, { %Decorator**, i64 }* %t1114, { %Decorator**, i64 }* %t1109
  %t1117 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1118 = bitcast [40 x i8]* %t1117 to i8*
  %t1119 = getelementptr inbounds i8, i8* %t1118, i64 32
  %t1120 = bitcast i8* %t1119 to { %Decorator**, i64 }**
  %t1121 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1120
  %t1122 = icmp eq i32 %t1066, 10
  %t1123 = select i1 %t1122, { %Decorator**, i64 }* %t1121, { %Decorator**, i64 }* %t1116
  %t1124 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1125 = bitcast [40 x i8]* %t1124 to i8*
  %t1126 = getelementptr inbounds i8, i8* %t1125, i64 32
  %t1127 = bitcast i8* %t1126 to { %Decorator**, i64 }**
  %t1128 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1127
  %t1129 = icmp eq i32 %t1066, 11
  %t1130 = select i1 %t1129, { %Decorator**, i64 }* %t1128, { %Decorator**, i64 }* %t1123
  %t1131 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1132 = bitcast [40 x i8]* %t1131 to i8*
  %t1133 = getelementptr inbounds i8, i8* %t1132, i64 32
  %t1134 = bitcast i8* %t1133 to { %Decorator**, i64 }**
  %t1135 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1134
  %t1136 = icmp eq i32 %t1066, 12
  %t1137 = select i1 %t1136, { %Decorator**, i64 }* %t1135, { %Decorator**, i64 }* %t1130
  %t1138 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1139 = bitcast [24 x i8]* %t1138 to i8*
  %t1140 = getelementptr inbounds i8, i8* %t1139, i64 16
  %t1141 = bitcast i8* %t1140 to { %Decorator**, i64 }**
  %t1142 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1141
  %t1143 = icmp eq i32 %t1066, 13
  %t1144 = select i1 %t1143, { %Decorator**, i64 }* %t1142, { %Decorator**, i64 }* %t1137
  %t1145 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1146 = bitcast [24 x i8]* %t1145 to i8*
  %t1147 = getelementptr inbounds i8, i8* %t1146, i64 16
  %t1148 = bitcast i8* %t1147 to { %Decorator**, i64 }**
  %t1149 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1148
  %t1150 = icmp eq i32 %t1066, 14
  %t1151 = select i1 %t1150, { %Decorator**, i64 }* %t1149, { %Decorator**, i64 }* %t1144
  %t1152 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1153 = bitcast [16 x i8]* %t1152 to i8*
  %t1154 = getelementptr inbounds i8, i8* %t1153, i64 8
  %t1155 = bitcast i8* %t1154 to { %Decorator**, i64 }**
  %t1156 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1155
  %t1157 = icmp eq i32 %t1066, 15
  %t1158 = select i1 %t1157, { %Decorator**, i64 }* %t1156, { %Decorator**, i64 }* %t1151
  %t1159 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1160 = bitcast [24 x i8]* %t1159 to i8*
  %t1161 = getelementptr inbounds i8, i8* %t1160, i64 16
  %t1162 = bitcast i8* %t1161 to { %Decorator**, i64 }**
  %t1163 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1162
  %t1164 = icmp eq i32 %t1066, 18
  %t1165 = select i1 %t1164, { %Decorator**, i64 }* %t1163, { %Decorator**, i64 }* %t1158
  %t1166 = getelementptr inbounds %Statement, %Statement* %t1067, i32 0, i32 1
  %t1167 = bitcast [32 x i8]* %t1166 to i8*
  %t1168 = getelementptr inbounds i8, i8* %t1167, i64 24
  %t1169 = bitcast i8* %t1168 to { %Decorator**, i64 }**
  %t1170 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1169
  %t1171 = icmp eq i32 %t1066, 19
  %t1172 = select i1 %t1171, { %Decorator**, i64 }* %t1170, { %Decorator**, i64 }* %t1165
  %t1173 = load i8*, i8** %l5
  %t1174 = bitcast { %Decorator**, i64 }* %t1172 to { %Decorator*, i64 }*
  %t1175 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1008, %Block %t1065, { %Decorator*, i64 }* %t1174, i8* %t1173)
  ret { %EffectViolation*, i64 }* %t1175
merge7:
  %t1176 = extractvalue %Statement %statement, 0
  %t1177 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1178 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1176, 0
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1176, 1
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1176, 2
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1176, 3
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1176, 4
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1176, 5
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1176, 6
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1176, 7
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1176, 8
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1176, 9
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %t1208 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1176, 10
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1176, 11
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1176, 12
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1176, 13
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1176, 14
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1176, 15
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1176, 16
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1176, 17
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %t1232 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1233 = icmp eq i32 %t1176, 18
  %t1234 = select i1 %t1233, i8* %t1232, i8* %t1231
  %t1235 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1236 = icmp eq i32 %t1176, 19
  %t1237 = select i1 %t1236, i8* %t1235, i8* %t1234
  %t1238 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1239 = icmp eq i32 %t1176, 20
  %t1240 = select i1 %t1239, i8* %t1238, i8* %t1237
  %t1241 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1242 = icmp eq i32 %t1176, 21
  %t1243 = select i1 %t1242, i8* %t1241, i8* %t1240
  %t1244 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1176, 22
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %s1247 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1247, i32 0, i32 0
  %t1248 = icmp eq i8* %t1246, %s1247
  br i1 %t1248, label %then8, label %merge9
then8:
  %t1249 = alloca [0 x %EffectViolation]
  %t1250 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1249, i32 0, i32 0
  %t1251 = alloca { %EffectViolation*, i64 }
  %t1252 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1251, i32 0, i32 0
  store %EffectViolation* %t1250, %EffectViolation** %t1252
  %t1253 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1251, i32 0, i32 1
  store i64 0, i64* %t1253
  store { %EffectViolation*, i64 }* %t1251, { %EffectViolation*, i64 }** %l6
  %t1254 = sitofp i64 0 to double
  store double %t1254, double* %l7
  %t1255 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1256 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t1365 = phi { %EffectViolation*, i64 }* [ %t1255, %then8 ], [ %t1363, %loop.latch12 ]
  %t1366 = phi double [ %t1256, %then8 ], [ %t1364, %loop.latch12 ]
  store { %EffectViolation*, i64 }* %t1365, { %EffectViolation*, i64 }** %l6
  store double %t1366, double* %l7
  br label %loop.body11
loop.body11:
  %t1257 = load double, double* %l7
  %t1258 = extractvalue %Statement %statement, 0
  %t1259 = alloca %Statement
  store %Statement %statement, %Statement* %t1259
  %t1260 = getelementptr inbounds %Statement, %Statement* %t1259, i32 0, i32 1
  %t1261 = bitcast [56 x i8]* %t1260 to i8*
  %t1262 = getelementptr inbounds i8, i8* %t1261, i64 40
  %t1263 = bitcast i8* %t1262 to { %MethodDeclaration**, i64 }**
  %t1264 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1263
  %t1265 = icmp eq i32 %t1258, 8
  %t1266 = select i1 %t1265, { %MethodDeclaration**, i64 }* %t1264, { %MethodDeclaration**, i64 }* null
  %t1267 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1266
  %t1268 = extractvalue { %MethodDeclaration**, i64 } %t1267, 1
  %t1269 = sitofp i64 %t1268 to double
  %t1270 = fcmp oge double %t1257, %t1269
  %t1271 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1272 = load double, double* %l7
  br i1 %t1270, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t1273 = extractvalue %Statement %statement, 0
  %t1274 = alloca %Statement
  store %Statement %statement, %Statement* %t1274
  %t1275 = getelementptr inbounds %Statement, %Statement* %t1274, i32 0, i32 1
  %t1276 = bitcast [56 x i8]* %t1275 to i8*
  %t1277 = getelementptr inbounds i8, i8* %t1276, i64 40
  %t1278 = bitcast i8* %t1277 to { %MethodDeclaration**, i64 }**
  %t1279 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1278
  %t1280 = icmp eq i32 %t1273, 8
  %t1281 = select i1 %t1280, { %MethodDeclaration**, i64 }* %t1279, { %MethodDeclaration**, i64 }* null
  %t1282 = load double, double* %l7
  %t1283 = fptosi double %t1282 to i64
  %t1284 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1281
  %t1285 = extractvalue { %MethodDeclaration**, i64 } %t1284, 0
  %t1286 = extractvalue { %MethodDeclaration**, i64 } %t1284, 1
  %t1287 = icmp uge i64 %t1283, %t1286
  ; bounds check: %t1287 (if true, out of bounds)
  %t1288 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1285, i64 %t1283
  %t1289 = load %MethodDeclaration*, %MethodDeclaration** %t1288
  store %MethodDeclaration* %t1289, %MethodDeclaration** %l8
  %t1290 = extractvalue %Statement %statement, 0
  %t1291 = alloca %Statement
  store %Statement %statement, %Statement* %t1291
  %t1292 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1293 = bitcast [48 x i8]* %t1292 to i8*
  %t1294 = bitcast i8* %t1293 to i8**
  %t1295 = load i8*, i8** %t1294
  %t1296 = icmp eq i32 %t1290, 2
  %t1297 = select i1 %t1296, i8* %t1295, i8* null
  %t1298 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1299 = bitcast [48 x i8]* %t1298 to i8*
  %t1300 = bitcast i8* %t1299 to i8**
  %t1301 = load i8*, i8** %t1300
  %t1302 = icmp eq i32 %t1290, 3
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1297
  %t1304 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1305 = bitcast [40 x i8]* %t1304 to i8*
  %t1306 = bitcast i8* %t1305 to i8**
  %t1307 = load i8*, i8** %t1306
  %t1308 = icmp eq i32 %t1290, 6
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1303
  %t1310 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1311 = bitcast [56 x i8]* %t1310 to i8*
  %t1312 = bitcast i8* %t1311 to i8**
  %t1313 = load i8*, i8** %t1312
  %t1314 = icmp eq i32 %t1290, 8
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1309
  %t1316 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1317 = bitcast [40 x i8]* %t1316 to i8*
  %t1318 = bitcast i8* %t1317 to i8**
  %t1319 = load i8*, i8** %t1318
  %t1320 = icmp eq i32 %t1290, 9
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1315
  %t1322 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1323 = bitcast [40 x i8]* %t1322 to i8*
  %t1324 = bitcast i8* %t1323 to i8**
  %t1325 = load i8*, i8** %t1324
  %t1326 = icmp eq i32 %t1290, 10
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1321
  %t1328 = getelementptr inbounds %Statement, %Statement* %t1291, i32 0, i32 1
  %t1329 = bitcast [40 x i8]* %t1328 to i8*
  %t1330 = bitcast i8* %t1329 to i8**
  %t1331 = load i8*, i8** %t1330
  %t1332 = icmp eq i32 %t1290, 11
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1327
  %t1334 = load i8, i8* %t1333
  %t1335 = add i8 %t1334, 46
  %t1336 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1337 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1336, i32 0, i32 0
  %t1338 = load %FunctionSignature, %FunctionSignature* %t1337
  %t1339 = extractvalue %FunctionSignature %t1338, 0
  %t1340 = load i8, i8* %t1339
  %t1341 = add i8 %t1335, %t1340
  store i8 %t1341, i8* %l9
  %t1342 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1343 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1344 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1343, i32 0, i32 0
  %t1345 = load %FunctionSignature, %FunctionSignature* %t1344
  %t1346 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1347 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1346, i32 0, i32 1
  %t1348 = load %Block, %Block* %t1347
  %t1349 = load %MethodDeclaration*, %MethodDeclaration** %l8
  %t1350 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1349, i32 0, i32 2
  %t1351 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %t1350
  %t1352 = load i8, i8* %l9
  %t1353 = bitcast { %Decorator**, i64 }* %t1351 to { %Decorator*, i64 }*
  %t1354 = alloca [2 x i8], align 1
  %t1355 = getelementptr [2 x i8], [2 x i8]* %t1354, i32 0, i32 0
  store i8 %t1352, i8* %t1355
  %t1356 = getelementptr [2 x i8], [2 x i8]* %t1354, i32 0, i32 1
  store i8 0, i8* %t1356
  %t1357 = getelementptr [2 x i8], [2 x i8]* %t1354, i32 0, i32 0
  %t1358 = call { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %t1345, %Block %t1348, { %Decorator*, i64 }* %t1353, i8* %t1357)
  %t1359 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t1342, { %EffectViolation*, i64 }* %t1358)
  store { %EffectViolation*, i64 }* %t1359, { %EffectViolation*, i64 }** %l6
  %t1360 = load double, double* %l7
  %t1361 = sitofp i64 1 to double
  %t1362 = fadd double %t1360, %t1361
  store double %t1362, double* %l7
  br label %loop.latch12
loop.latch12:
  %t1363 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  %t1364 = load double, double* %l7
  br label %loop.header10
afterloop13:
  %t1367 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l6
  ret { %EffectViolation*, i64 }* %t1367
merge9:
  %t1368 = alloca [0 x %EffectViolation]
  %t1369 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t1368, i32 0, i32 0
  %t1370 = alloca { %EffectViolation*, i64 }
  %t1371 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1370, i32 0, i32 0
  store %EffectViolation* %t1369, %EffectViolation** %t1371
  %t1372 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t1370, i32 0, i32 1
  store i64 0, i64* %t1372
  ret { %EffectViolation*, i64 }* %t1370
}

define { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators, i8* %name) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca { %EffectRequirement*, i64 }*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca { %EffectRequirement*, i64 }*
  %l9 = alloca double
  %l10 = alloca %EffectRequirement
  %l11 = alloca i8*
  %l12 = alloca { %EffectViolation*, i64 }*
  %t0 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
  store double %t0, double* %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load double, double* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t35 = phi { i8**, i64 }* [ %t8, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t9, %entry ], [ %t34, %loop.latch2 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l1
  store double %t36, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = extractvalue %FunctionSignature %signature, 4
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t10, %t14
  %t16 = load double, double* %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = extractvalue %FunctionSignature %signature, 4
  %t21 = load double, double* %l2
  %t22 = fptosi double %t21 to i64
  %t23 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  %t29 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t19, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l1
  %t30 = load double, double* %l2
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l2
  br label %loop.latch2
loop.latch2:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load double, double* %l2
  br label %loop.header0
afterloop3:
  store i1 0, i1* %l3
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l4
  %t38 = load double, double* %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load double, double* %l2
  %t41 = load i1, i1* %l3
  %t42 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t54 = phi double [ %t42, %entry ], [ %t53, %loop.latch8 ]
  store double %t54, double* %l4
  br label %loop.body7
loop.body7:
  %t43 = load double, double* %l4
  %t44 = load double, double* %l0
  %t45 = load double, double* %l0
  %t46 = load double, double* %l4
  %t47 = fptosi double %t46 to i64
  store double 0.0, double* %l5
  %t49 = load double, double* %l5
  %t50 = load double, double* %l4
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l4
  br label %loop.latch8
loop.latch8:
  %t53 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t55 = load i1, i1* %l3
  %t56 = load double, double* %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load double, double* %l2
  %t59 = load i1, i1* %l3
  %t60 = load double, double* %l4
  br i1 %t55, label %then10, label %merge11
then10:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s62 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.62, i32 0, i32 0
  %t63 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t61, i8* %s62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l1
  br label %merge11
merge11:
  %t64 = phi { i8**, i64 }* [ %t63, %then10 ], [ %t57, %entry ]
  store { i8**, i64 }* %t64, { i8**, i64 }** %l1
  %t65 = call { %EffectRequirement*, i64 }* @required_effects(%Block %body)
  store { %EffectRequirement*, i64 }* %t65, { %EffectRequirement*, i64 }** %l6
  %t66 = alloca [0 x i8*]
  %t67 = getelementptr [0 x i8*], [0 x i8*]* %t66, i32 0, i32 0
  %t68 = alloca { i8**, i64 }
  %t69 = getelementptr { i8**, i64 }, { i8**, i64 }* %t68, i32 0, i32 0
  store i8** %t67, i8*** %t69
  %t70 = getelementptr { i8**, i64 }, { i8**, i64 }* %t68, i32 0, i32 1
  store i64 0, i64* %t70
  store { i8**, i64 }* %t68, { i8**, i64 }** %l7
  %t71 = alloca [0 x %EffectRequirement]
  %t72 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t71, i32 0, i32 0
  %t73 = alloca { %EffectRequirement*, i64 }
  %t74 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t73, i32 0, i32 0
  store %EffectRequirement* %t72, %EffectRequirement** %t74
  %t75 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t73, i32 0, i32 1
  store i64 0, i64* %t75
  store { %EffectRequirement*, i64 }* %t73, { %EffectRequirement*, i64 }** %l8
  %t76 = sitofp i64 0 to double
  store double %t76, double* %l9
  %t77 = load double, double* %l0
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = load double, double* %l2
  %t80 = load i1, i1* %l3
  %t81 = load double, double* %l4
  %t82 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t84 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t85 = load double, double* %l9
  br label %loop.header12
loop.header12:
  %t177 = phi double [ %t85, %entry ], [ %t174, %loop.latch14 ]
  %t178 = phi { i8**, i64 }* [ %t83, %entry ], [ %t175, %loop.latch14 ]
  %t179 = phi { %EffectRequirement*, i64 }* [ %t84, %entry ], [ %t176, %loop.latch14 ]
  store double %t177, double* %l9
  store { i8**, i64 }* %t178, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t179, { %EffectRequirement*, i64 }** %l8
  br label %loop.body13
loop.body13:
  %t86 = load double, double* %l9
  %t87 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t88 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t87
  %t89 = extractvalue { %EffectRequirement*, i64 } %t88, 1
  %t90 = sitofp i64 %t89 to double
  %t91 = fcmp oge double %t86, %t90
  %t92 = load double, double* %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load double, double* %l2
  %t95 = load i1, i1* %l3
  %t96 = load double, double* %l4
  %t97 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t99 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t100 = load double, double* %l9
  br i1 %t91, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t101 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t102 = load double, double* %l9
  %t103 = fptosi double %t102 to i64
  %t104 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t101
  %t105 = extractvalue { %EffectRequirement*, i64 } %t104, 0
  %t106 = extractvalue { %EffectRequirement*, i64 } %t104, 1
  %t107 = icmp uge i64 %t103, %t106
  ; bounds check: %t107 (if true, out of bounds)
  %t108 = getelementptr %EffectRequirement, %EffectRequirement* %t105, i64 %t103
  %t109 = load %EffectRequirement, %EffectRequirement* %t108
  store %EffectRequirement %t109, %EffectRequirement* %l10
  %t110 = load %EffectRequirement, %EffectRequirement* %l10
  %t111 = extractvalue %EffectRequirement %t110, 0
  store i8* %t111, i8** %l11
  %t113 = load i8*, i8** %l11
  %s114 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.114, i32 0, i32 0
  %t115 = icmp eq i8* %t113, %s114
  br label %logical_and_entry_112

logical_and_entry_112:
  br i1 %t115, label %logical_and_right_112, label %logical_and_merge_112

logical_and_right_112:
  %t116 = load i1, i1* %l3
  br label %logical_and_right_end_112

logical_and_right_end_112:
  br label %logical_and_merge_112

logical_and_merge_112:
  %t117 = phi i1 [ false, %logical_and_entry_112 ], [ %t116, %logical_and_right_end_112 ]
  %t118 = load double, double* %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t120 = load double, double* %l2
  %t121 = load i1, i1* %l3
  %t122 = load double, double* %l4
  %t123 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t125 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t126 = load double, double* %l9
  %t127 = load %EffectRequirement, %EffectRequirement* %l10
  %t128 = load i8*, i8** %l11
  br i1 %t117, label %then18, label %merge19
then18:
  %t129 = load double, double* %l9
  %t130 = sitofp i64 1 to double
  %t131 = fadd double %t129, %t130
  store double %t131, double* %l9
  br label %loop.latch14
merge19:
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load i8*, i8** %l11
  %t134 = call i1 @contains_effect({ i8**, i64 }* %t132, i8* %t133)
  %t135 = load double, double* %l0
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t137 = load double, double* %l2
  %t138 = load i1, i1* %l3
  %t139 = load double, double* %l4
  %t140 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t142 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t143 = load double, double* %l9
  %t144 = load %EffectRequirement, %EffectRequirement* %l10
  %t145 = load i8*, i8** %l11
  br i1 %t134, label %then20, label %merge21
then20:
  %t146 = load double, double* %l9
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  store double %t148, double* %l9
  br label %loop.latch14
merge21:
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t150 = load i8*, i8** %l11
  %t151 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t149, i8* %t150)
  store { i8**, i64 }* %t151, { i8**, i64 }** %l7
  %t152 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t153 = load i8*, i8** %l11
  %t154 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t152, i8* %t153)
  %t155 = xor i1 %t154, 1
  %t156 = load double, double* %l0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = load double, double* %l2
  %t159 = load i1, i1* %l3
  %t160 = load double, double* %l4
  %t161 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t163 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t164 = load double, double* %l9
  %t165 = load %EffectRequirement, %EffectRequirement* %l10
  %t166 = load i8*, i8** %l11
  br i1 %t155, label %then22, label %merge23
then22:
  %t167 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t168 = load %EffectRequirement, %EffectRequirement* %l10
  %t169 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t167, %EffectRequirement %t168)
  store { %EffectRequirement*, i64 }* %t169, { %EffectRequirement*, i64 }** %l8
  br label %merge23
merge23:
  %t170 = phi { %EffectRequirement*, i64 }* [ %t169, %then22 ], [ %t163, %loop.body13 ]
  store { %EffectRequirement*, i64 }* %t170, { %EffectRequirement*, i64 }** %l8
  %t171 = load double, double* %l9
  %t172 = sitofp i64 1 to double
  %t173 = fadd double %t171, %t172
  store double %t173, double* %l9
  br label %loop.latch14
loop.latch14:
  %t174 = load double, double* %l9
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t176 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header12
afterloop15:
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t181 = load { i8**, i64 }, { i8**, i64 }* %t180
  %t182 = extractvalue { i8**, i64 } %t181, 1
  %t183 = icmp eq i64 %t182, 0
  %t184 = load double, double* %l0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t186 = load double, double* %l2
  %t187 = load i1, i1* %l3
  %t188 = load double, double* %l4
  %t189 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t191 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t192 = load double, double* %l9
  br i1 %t183, label %then24, label %merge25
then24:
  %t193 = alloca [0 x %EffectViolation]
  %t194 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t193, i32 0, i32 0
  %t195 = alloca { %EffectViolation*, i64 }
  %t196 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t195, i32 0, i32 0
  store %EffectViolation* %t194, %EffectViolation** %t196
  %t197 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t195, i32 0, i32 1
  store i64 0, i64* %t197
  ret { %EffectViolation*, i64 }* %t195
merge25:
  %t198 = alloca [0 x %EffectViolation]
  %t199 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t198, i32 0, i32 0
  %t200 = alloca { %EffectViolation*, i64 }
  %t201 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t200, i32 0, i32 0
  store %EffectViolation* %t199, %EffectViolation** %t201
  %t202 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t200, i32 0, i32 1
  store i64 0, i64* %t202
  store { %EffectViolation*, i64 }* %t200, { %EffectViolation*, i64 }** %l12
  %t203 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  %t204 = insertvalue %EffectViolation undef, i8* %name, 0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t206 = insertvalue %EffectViolation %t204, { i8**, i64 }* %t205, 1
  %t207 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t208 = bitcast { %EffectRequirement*, i64 }* %t207 to { %EffectRequirement**, i64 }*
  %t209 = insertvalue %EffectViolation %t206, { %EffectRequirement**, i64 }* %t208, 2
  %t210 = call { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %t203, %EffectViolation %t209)
  store { %EffectViolation*, i64 }* %t210, { %EffectViolation*, i64 }** %l12
  %t211 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t211
}

define { %EffectRequirement*, i64 }* @required_effects(%Block %body) {
entry:
  %t0 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %body)
  ret { %EffectRequirement*, i64 }* %t0
}

define { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %block) {
entry:
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
  %t32 = phi { %EffectRequirement*, i64 }* [ %t4, %entry ], [ %t30, %loop.latch2 ]
  %t33 = phi double [ %t5, %entry ], [ %t31, %loop.latch2 ]
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
  ret { %EffectRequirement*, i64 }* %t34
}

define { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %statement) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %l3 = alloca %WithClause*
  %l4 = alloca { %EffectRequirement*, i64 }*
  %l5 = alloca { %EffectRequirement*, i64 }*
  %l6 = alloca double
  %l7 = alloca { %EffectRequirement*, i64 }*
  %l8 = alloca { %EffectRequirement*, i64 }*
  %l9 = alloca double
  %l10 = alloca { %EffectRequirement*, i64 }*
  %l11 = alloca double
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
  %s71 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.71, i32 0, i32 0
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
  %s132 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.132, i32 0, i32 0
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
  %s145 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.145, i32 0, i32 0
  %t146 = extractvalue %Statement %statement, 0
  %t147 = alloca %Statement
  store %Statement %statement, %Statement* %t147
  %t148 = getelementptr inbounds %Statement, %Statement* %t147, i32 0, i32 1
  %t149 = bitcast [40 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  %t151 = load i8*, i8** %t150
  %t152 = icmp eq i32 %t146, 12
  %t153 = select i1 %t152, i8* %t151, i8* null
  %t154 = add i8* %s145, %t153
  %t155 = load i8, i8* %t154
  %t156 = add i8 %t155, 34
  %t157 = alloca [2 x i8], align 1
  %t158 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 0
  store i8 %t156, i8* %t158
  %t159 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 1
  store i8 0, i8* %t159
  %t160 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 0
  %t161 = insertvalue %EffectRequirement %t144, i8* %t160, 2
  %t162 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t131, %EffectRequirement %t161)
  store { %EffectRequirement*, i64 }* %t162, { %EffectRequirement*, i64 }** %l0
  %t163 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t163
merge1:
  %t164 = extractvalue %Statement %statement, 0
  %t165 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t166 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t164, 0
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %t169 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t164, 1
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t164, 2
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t164, 3
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t164, 4
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t164, 5
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t164, 6
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t164, 7
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t164, 8
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t164, 9
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t164, 10
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t164, 11
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t164, 12
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t164, 13
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t164, 14
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t164, 15
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t164, 16
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t164, 17
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t164, 18
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t164, 19
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t164, 20
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t164, 21
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t164, 22
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %s235 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.235, i32 0, i32 0
  %t236 = icmp eq i8* %t234, %s235
  br i1 %t236, label %then2, label %merge3
then2:
  %t237 = extractvalue %Statement %statement, 0
  %t238 = alloca %Statement
  store %Statement %statement, %Statement* %t238
  %t239 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t240 = bitcast [24 x i8]* %t239 to i8*
  %t241 = getelementptr inbounds i8, i8* %t240, i64 8
  %t242 = bitcast i8* %t241 to %Block*
  %t243 = load %Block, %Block* %t242
  %t244 = icmp eq i32 %t237, 4
  %t245 = select i1 %t244, %Block %t243, %Block zeroinitializer
  %t246 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t247 = bitcast [24 x i8]* %t246 to i8*
  %t248 = getelementptr inbounds i8, i8* %t247, i64 8
  %t249 = bitcast i8* %t248 to %Block*
  %t250 = load %Block, %Block* %t249
  %t251 = icmp eq i32 %t237, 5
  %t252 = select i1 %t251, %Block %t250, %Block %t245
  %t253 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t254 = bitcast [40 x i8]* %t253 to i8*
  %t255 = getelementptr inbounds i8, i8* %t254, i64 16
  %t256 = bitcast i8* %t255 to %Block*
  %t257 = load %Block, %Block* %t256
  %t258 = icmp eq i32 %t237, 6
  %t259 = select i1 %t258, %Block %t257, %Block %t252
  %t260 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t261 = bitcast [24 x i8]* %t260 to i8*
  %t262 = getelementptr inbounds i8, i8* %t261, i64 8
  %t263 = bitcast i8* %t262 to %Block*
  %t264 = load %Block, %Block* %t263
  %t265 = icmp eq i32 %t237, 7
  %t266 = select i1 %t265, %Block %t264, %Block %t259
  %t267 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t268 = bitcast [40 x i8]* %t267 to i8*
  %t269 = getelementptr inbounds i8, i8* %t268, i64 24
  %t270 = bitcast i8* %t269 to %Block*
  %t271 = load %Block, %Block* %t270
  %t272 = icmp eq i32 %t237, 12
  %t273 = select i1 %t272, %Block %t271, %Block %t266
  %t274 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t275 = bitcast [24 x i8]* %t274 to i8*
  %t276 = getelementptr inbounds i8, i8* %t275, i64 8
  %t277 = bitcast i8* %t276 to %Block*
  %t278 = load %Block, %Block* %t277
  %t279 = icmp eq i32 %t237, 13
  %t280 = select i1 %t279, %Block %t278, %Block %t273
  %t281 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t282 = bitcast [24 x i8]* %t281 to i8*
  %t283 = getelementptr inbounds i8, i8* %t282, i64 8
  %t284 = bitcast i8* %t283 to %Block*
  %t285 = load %Block, %Block* %t284
  %t286 = icmp eq i32 %t237, 14
  %t287 = select i1 %t286, %Block %t285, %Block %t280
  %t288 = getelementptr inbounds %Statement, %Statement* %t238, i32 0, i32 1
  %t289 = bitcast [16 x i8]* %t288 to i8*
  %t290 = bitcast i8* %t289 to %Block*
  %t291 = load %Block, %Block* %t290
  %t292 = icmp eq i32 %t237, 15
  %t293 = select i1 %t292, %Block %t291, %Block %t287
  %t294 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t293)
  store { %EffectRequirement*, i64 }* %t294, { %EffectRequirement*, i64 }** %l1
  %t295 = sitofp i64 0 to double
  store double %t295, double* %l2
  %t296 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t297 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t341 = phi { %EffectRequirement*, i64 }* [ %t296, %then2 ], [ %t339, %loop.latch6 ]
  %t342 = phi double [ %t297, %then2 ], [ %t340, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t341, { %EffectRequirement*, i64 }** %l1
  store double %t342, double* %l2
  br label %loop.body5
loop.body5:
  %t298 = load double, double* %l2
  %t299 = extractvalue %Statement %statement, 0
  %t300 = alloca %Statement
  store %Statement %statement, %Statement* %t300
  %t301 = getelementptr inbounds %Statement, %Statement* %t300, i32 0, i32 1
  %t302 = bitcast [24 x i8]* %t301 to i8*
  %t303 = bitcast i8* %t302 to { %WithClause**, i64 }**
  %t304 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t303
  %t305 = icmp eq i32 %t299, 13
  %t306 = select i1 %t305, { %WithClause**, i64 }* %t304, { %WithClause**, i64 }* null
  %t307 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t306
  %t308 = extractvalue { %WithClause**, i64 } %t307, 1
  %t309 = sitofp i64 %t308 to double
  %t310 = fcmp oge double %t298, %t309
  %t311 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t312 = load double, double* %l2
  br i1 %t310, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t313 = extractvalue %Statement %statement, 0
  %t314 = alloca %Statement
  store %Statement %statement, %Statement* %t314
  %t315 = getelementptr inbounds %Statement, %Statement* %t314, i32 0, i32 1
  %t316 = bitcast [24 x i8]* %t315 to i8*
  %t317 = bitcast i8* %t316 to { %WithClause**, i64 }**
  %t318 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t317
  %t319 = icmp eq i32 %t313, 13
  %t320 = select i1 %t319, { %WithClause**, i64 }* %t318, { %WithClause**, i64 }* null
  %t321 = load double, double* %l2
  %t322 = fptosi double %t321 to i64
  %t323 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t320
  %t324 = extractvalue { %WithClause**, i64 } %t323, 0
  %t325 = extractvalue { %WithClause**, i64 } %t323, 1
  %t326 = icmp uge i64 %t322, %t325
  ; bounds check: %t326 (if true, out of bounds)
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
  ret { %EffectRequirement*, i64 }* %t343
merge3:
  %t344 = extractvalue %Statement %statement, 0
  %t345 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t346 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t344, 0
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t344, 1
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t344, 2
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t344, 3
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t344, 4
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t344, 5
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t344, 6
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %t367 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t368 = icmp eq i32 %t344, 7
  %t369 = select i1 %t368, i8* %t367, i8* %t366
  %t370 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t371 = icmp eq i32 %t344, 8
  %t372 = select i1 %t371, i8* %t370, i8* %t369
  %t373 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t374 = icmp eq i32 %t344, 9
  %t375 = select i1 %t374, i8* %t373, i8* %t372
  %t376 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t377 = icmp eq i32 %t344, 10
  %t378 = select i1 %t377, i8* %t376, i8* %t375
  %t379 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t380 = icmp eq i32 %t344, 11
  %t381 = select i1 %t380, i8* %t379, i8* %t378
  %t382 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t383 = icmp eq i32 %t344, 12
  %t384 = select i1 %t383, i8* %t382, i8* %t381
  %t385 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t386 = icmp eq i32 %t344, 13
  %t387 = select i1 %t386, i8* %t385, i8* %t384
  %t388 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t389 = icmp eq i32 %t344, 14
  %t390 = select i1 %t389, i8* %t388, i8* %t387
  %t391 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t392 = icmp eq i32 %t344, 15
  %t393 = select i1 %t392, i8* %t391, i8* %t390
  %t394 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t395 = icmp eq i32 %t344, 16
  %t396 = select i1 %t395, i8* %t394, i8* %t393
  %t397 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t398 = icmp eq i32 %t344, 17
  %t399 = select i1 %t398, i8* %t397, i8* %t396
  %t400 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t401 = icmp eq i32 %t344, 18
  %t402 = select i1 %t401, i8* %t400, i8* %t399
  %t403 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t404 = icmp eq i32 %t344, 19
  %t405 = select i1 %t404, i8* %t403, i8* %t402
  %t406 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t407 = icmp eq i32 %t344, 20
  %t408 = select i1 %t407, i8* %t406, i8* %t405
  %t409 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t410 = icmp eq i32 %t344, 21
  %t411 = select i1 %t410, i8* %t409, i8* %t408
  %t412 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t413 = icmp eq i32 %t344, 22
  %t414 = select i1 %t413, i8* %t412, i8* %t411
  %s415 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.415, i32 0, i32 0
  %t416 = icmp eq i8* %t414, %s415
  br i1 %t416, label %then10, label %merge11
then10:
  %t417 = extractvalue %Statement %statement, 0
  %t418 = alloca %Statement
  store %Statement %statement, %Statement* %t418
  %t419 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t420 = bitcast [24 x i8]* %t419 to i8*
  %t421 = getelementptr inbounds i8, i8* %t420, i64 8
  %t422 = bitcast i8* %t421 to %Block*
  %t423 = load %Block, %Block* %t422
  %t424 = icmp eq i32 %t417, 4
  %t425 = select i1 %t424, %Block %t423, %Block zeroinitializer
  %t426 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t427 = bitcast [24 x i8]* %t426 to i8*
  %t428 = getelementptr inbounds i8, i8* %t427, i64 8
  %t429 = bitcast i8* %t428 to %Block*
  %t430 = load %Block, %Block* %t429
  %t431 = icmp eq i32 %t417, 5
  %t432 = select i1 %t431, %Block %t430, %Block %t425
  %t433 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t434 = bitcast [40 x i8]* %t433 to i8*
  %t435 = getelementptr inbounds i8, i8* %t434, i64 16
  %t436 = bitcast i8* %t435 to %Block*
  %t437 = load %Block, %Block* %t436
  %t438 = icmp eq i32 %t417, 6
  %t439 = select i1 %t438, %Block %t437, %Block %t432
  %t440 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t441 = bitcast [24 x i8]* %t440 to i8*
  %t442 = getelementptr inbounds i8, i8* %t441, i64 8
  %t443 = bitcast i8* %t442 to %Block*
  %t444 = load %Block, %Block* %t443
  %t445 = icmp eq i32 %t417, 7
  %t446 = select i1 %t445, %Block %t444, %Block %t439
  %t447 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t448 = bitcast [40 x i8]* %t447 to i8*
  %t449 = getelementptr inbounds i8, i8* %t448, i64 24
  %t450 = bitcast i8* %t449 to %Block*
  %t451 = load %Block, %Block* %t450
  %t452 = icmp eq i32 %t417, 12
  %t453 = select i1 %t452, %Block %t451, %Block %t446
  %t454 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t455 = bitcast [24 x i8]* %t454 to i8*
  %t456 = getelementptr inbounds i8, i8* %t455, i64 8
  %t457 = bitcast i8* %t456 to %Block*
  %t458 = load %Block, %Block* %t457
  %t459 = icmp eq i32 %t417, 13
  %t460 = select i1 %t459, %Block %t458, %Block %t453
  %t461 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t462 = bitcast [24 x i8]* %t461 to i8*
  %t463 = getelementptr inbounds i8, i8* %t462, i64 8
  %t464 = bitcast i8* %t463 to %Block*
  %t465 = load %Block, %Block* %t464
  %t466 = icmp eq i32 %t417, 14
  %t467 = select i1 %t466, %Block %t465, %Block %t460
  %t468 = getelementptr inbounds %Statement, %Statement* %t418, i32 0, i32 1
  %t469 = bitcast [16 x i8]* %t468 to i8*
  %t470 = bitcast i8* %t469 to %Block*
  %t471 = load %Block, %Block* %t470
  %t472 = icmp eq i32 %t417, 15
  %t473 = select i1 %t472, %Block %t471, %Block %t467
  %t474 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t473)
  store { %EffectRequirement*, i64 }* %t474, { %EffectRequirement*, i64 }** %l4
  %t475 = extractvalue %Statement %statement, 0
  %t476 = alloca %Statement
  store %Statement %statement, %Statement* %t476
  %t477 = getelementptr inbounds %Statement, %Statement* %t476, i32 0, i32 1
  %t478 = bitcast [24 x i8]* %t477 to i8*
  %t479 = bitcast i8* %t478 to %ForClause*
  %t480 = load %ForClause, %ForClause* %t479
  %t481 = icmp eq i32 %t475, 14
  %t482 = select i1 %t481, %ForClause %t480, %ForClause zeroinitializer
  %t483 = extractvalue %ForClause %t482, 0
  %t484 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t485 = extractvalue %Statement %statement, 0
  %t486 = alloca %Statement
  store %Statement %statement, %Statement* %t486
  %t487 = getelementptr inbounds %Statement, %Statement* %t486, i32 0, i32 1
  %t488 = bitcast [24 x i8]* %t487 to i8*
  %t489 = bitcast i8* %t488 to %ForClause*
  %t490 = load %ForClause, %ForClause* %t489
  %t491 = icmp eq i32 %t485, 14
  %t492 = select i1 %t491, %ForClause %t490, %ForClause zeroinitializer
  %t493 = extractvalue %ForClause %t492, 1
  %t494 = alloca %Expression
  store %Expression %t493, %Expression* %t494
  %t495 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t494)
  %t496 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t484, { %EffectRequirement*, i64 }* %t495)
  store { %EffectRequirement*, i64 }* %t496, { %EffectRequirement*, i64 }** %l4
  %t497 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t497
merge11:
  %t498 = extractvalue %Statement %statement, 0
  %t499 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t500 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t498, 0
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t498, 1
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t498, 2
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t498, 3
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t498, 4
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t498, 5
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t498, 6
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t498, 7
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t498, 8
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t498, 9
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t498, 10
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t498, 11
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %t536 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t537 = icmp eq i32 %t498, 12
  %t538 = select i1 %t537, i8* %t536, i8* %t535
  %t539 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t540 = icmp eq i32 %t498, 13
  %t541 = select i1 %t540, i8* %t539, i8* %t538
  %t542 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t498, 14
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t498, 15
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t498, 16
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t498, 17
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t498, 18
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t498, 19
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t498, 20
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t498, 21
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t498, 22
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %s569 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.569, i32 0, i32 0
  %t570 = icmp eq i8* %t568, %s569
  br i1 %t570, label %then12, label %merge13
then12:
  %t571 = extractvalue %Statement %statement, 0
  %t572 = alloca %Statement
  store %Statement %statement, %Statement* %t572
  %t573 = getelementptr inbounds %Statement, %Statement* %t572, i32 0, i32 1
  %t574 = bitcast [24 x i8]* %t573 to i8*
  %t575 = getelementptr inbounds i8, i8* %t574, i64 8
  %t576 = bitcast i8* %t575 to %Block*
  %t577 = load %Block, %Block* %t576
  %t578 = icmp eq i32 %t571, 4
  %t579 = select i1 %t578, %Block %t577, %Block zeroinitializer
  %t580 = getelementptr inbounds %Statement, %Statement* %t572, i32 0, i32 1
  %t581 = bitcast [24 x i8]* %t580 to i8*
  %t582 = getelementptr inbounds i8, i8* %t581, i64 8
  %t583 = bitcast i8* %t582 to %Block*
  %t584 = load %Block, %Block* %t583
  %t585 = icmp eq i32 %t571, 5
  %t586 = select i1 %t585, %Block %t584, %Block %t579
  %t587 = getelementptr inbounds %Statement, %Statement* %t572, i32 0, i32 1
  %t588 = bitcast [40 x i8]* %t587 to i8*
  %t589 = getelementptr inbounds i8, i8* %t588, i64 16
  %t590 = bitcast i8* %t589 to %Block*
  %t591 = load %Block, %Block* %t590
  %t592 = icmp eq i32 %t571, 6
  %t593 = select i1 %t592, %Block %t591, %Block %t586
  %t594 = getelementptr inbounds %Statement, %Statement* %t572, i32 0, i32 1
  %t595 = bitcast [24 x i8]* %t594 to i8*
  %t596 = getelementptr inbounds i8, i8* %t595, i64 8
  %t597 = bitcast i8* %t596 to %Block*
  %t598 = load %Block, %Block* %t597
  %t599 = icmp eq i32 %t571, 7
  %t600 = select i1 %t599, %Block %t598, %Block %t593
  %t601 = getelementptr inbounds %Statement, %Statement* %t572, i32 0, i32 1
  %t602 = bitcast [40 x i8]* %t601 to i8*
  %t603 = getelementptr inbounds i8, i8* %t602, i64 24
  %t604 = bitcast i8* %t603 to %Block*
  %t605 = load %Block, %Block* %t604
  %t606 = icmp eq i32 %t571, 12
  %t607 = select i1 %t606, %Block %t605, %Block %t600
  %t608 = getelementptr inbounds %Statement, %Statement* %t572, i32 0, i32 1
  %t609 = bitcast [24 x i8]* %t608 to i8*
  %t610 = getelementptr inbounds i8, i8* %t609, i64 8
  %t611 = bitcast i8* %t610 to %Block*
  %t612 = load %Block, %Block* %t611
  %t613 = icmp eq i32 %t571, 13
  %t614 = select i1 %t613, %Block %t612, %Block %t607
  %t615 = getelementptr inbounds %Statement, %Statement* %t572, i32 0, i32 1
  %t616 = bitcast [24 x i8]* %t615 to i8*
  %t617 = getelementptr inbounds i8, i8* %t616, i64 8
  %t618 = bitcast i8* %t617 to %Block*
  %t619 = load %Block, %Block* %t618
  %t620 = icmp eq i32 %t571, 14
  %t621 = select i1 %t620, %Block %t619, %Block %t614
  %t622 = getelementptr inbounds %Statement, %Statement* %t572, i32 0, i32 1
  %t623 = bitcast [16 x i8]* %t622 to i8*
  %t624 = bitcast i8* %t623 to %Block*
  %t625 = load %Block, %Block* %t624
  %t626 = icmp eq i32 %t571, 15
  %t627 = select i1 %t626, %Block %t625, %Block %t621
  %t628 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t627)
  ret { %EffectRequirement*, i64 }* %t628
merge13:
  %t629 = extractvalue %Statement %statement, 0
  %t630 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t631 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t629, 0
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t629, 1
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t629, 2
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t629, 3
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t629, 4
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t629, 5
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t629, 6
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t629, 7
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t629, 8
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t629, 9
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t629, 10
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t629, 11
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t629, 12
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t629, 13
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t629, 14
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t629, 15
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t629, 16
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t629, 17
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t629, 18
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t629, 19
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t629, 20
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t629, 21
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t629, 22
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %s700 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.700, i32 0, i32 0
  %t701 = icmp eq i8* %t699, %s700
  br i1 %t701, label %then14, label %merge15
then14:
  %t702 = extractvalue %Statement %statement, 0
  %t703 = alloca %Statement
  store %Statement %statement, %Statement* %t703
  %t704 = getelementptr inbounds %Statement, %Statement* %t703, i32 0, i32 1
  %t705 = bitcast [24 x i8]* %t704 to i8*
  %t706 = bitcast i8* %t705 to %Expression*
  %t707 = icmp eq i32 %t702, 18
  %t708 = select i1 %t707, %Expression* %t706, %Expression* null
  %t709 = getelementptr inbounds %Statement, %Statement* %t703, i32 0, i32 1
  %t710 = bitcast [16 x i8]* %t709 to i8*
  %t711 = bitcast i8* %t710 to %Expression**
  %t712 = load %Expression*, %Expression** %t711
  %t713 = icmp eq i32 %t702, 20
  %t714 = select i1 %t713, %Expression* %t712, %Expression* %t708
  %t715 = getelementptr inbounds %Statement, %Statement* %t703, i32 0, i32 1
  %t716 = bitcast [16 x i8]* %t715 to i8*
  %t717 = bitcast i8* %t716 to %Expression*
  %t718 = icmp eq i32 %t702, 21
  %t719 = select i1 %t718, %Expression* %t717, %Expression* %t714
  %t720 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t719)
  store { %EffectRequirement*, i64 }* %t720, { %EffectRequirement*, i64 }** %l5
  %t721 = sitofp i64 0 to double
  store double %t721, double* %l6
  %t722 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t723 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t766 = phi { %EffectRequirement*, i64 }* [ %t722, %then14 ], [ %t764, %loop.latch18 ]
  %t767 = phi double [ %t723, %then14 ], [ %t765, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t766, { %EffectRequirement*, i64 }** %l5
  store double %t767, double* %l6
  br label %loop.body17
loop.body17:
  %t724 = load double, double* %l6
  %t725 = extractvalue %Statement %statement, 0
  %t726 = alloca %Statement
  store %Statement %statement, %Statement* %t726
  %t727 = getelementptr inbounds %Statement, %Statement* %t726, i32 0, i32 1
  %t728 = bitcast [24 x i8]* %t727 to i8*
  %t729 = getelementptr inbounds i8, i8* %t728, i64 8
  %t730 = bitcast i8* %t729 to { %MatchCase**, i64 }**
  %t731 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t730
  %t732 = icmp eq i32 %t725, 18
  %t733 = select i1 %t732, { %MatchCase**, i64 }* %t731, { %MatchCase**, i64 }* null
  %t734 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t733
  %t735 = extractvalue { %MatchCase**, i64 } %t734, 1
  %t736 = sitofp i64 %t735 to double
  %t737 = fcmp oge double %t724, %t736
  %t738 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t739 = load double, double* %l6
  br i1 %t737, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t740 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t741 = extractvalue %Statement %statement, 0
  %t742 = alloca %Statement
  store %Statement %statement, %Statement* %t742
  %t743 = getelementptr inbounds %Statement, %Statement* %t742, i32 0, i32 1
  %t744 = bitcast [24 x i8]* %t743 to i8*
  %t745 = getelementptr inbounds i8, i8* %t744, i64 8
  %t746 = bitcast i8* %t745 to { %MatchCase**, i64 }**
  %t747 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t746
  %t748 = icmp eq i32 %t741, 18
  %t749 = select i1 %t748, { %MatchCase**, i64 }* %t747, { %MatchCase**, i64 }* null
  %t750 = load double, double* %l6
  %t751 = fptosi double %t750 to i64
  %t752 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t749
  %t753 = extractvalue { %MatchCase**, i64 } %t752, 0
  %t754 = extractvalue { %MatchCase**, i64 } %t752, 1
  %t755 = icmp uge i64 %t751, %t754
  ; bounds check: %t755 (if true, out of bounds)
  %t756 = getelementptr %MatchCase*, %MatchCase** %t753, i64 %t751
  %t757 = load %MatchCase*, %MatchCase** %t756
  %t758 = load %MatchCase, %MatchCase* %t757
  %t759 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t758)
  %t760 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t740, { %EffectRequirement*, i64 }* %t759)
  store { %EffectRequirement*, i64 }* %t760, { %EffectRequirement*, i64 }** %l5
  %t761 = load double, double* %l6
  %t762 = sitofp i64 1 to double
  %t763 = fadd double %t761, %t762
  store double %t763, double* %l6
  br label %loop.latch18
loop.latch18:
  %t764 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t765 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t768 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t768
merge15:
  %t769 = extractvalue %Statement %statement, 0
  %t770 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t771 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t769, 0
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t769, 1
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t769, 2
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t769, 3
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t769, 4
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t769, 5
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t769, 6
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t769, 7
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t769, 8
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t769, 9
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t769, 10
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t769, 11
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t769, 12
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t769, 13
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t769, 14
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t769, 15
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t769, 16
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t769, 17
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t769, 18
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t769, 19
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t769, 20
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t769, 21
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t769, 22
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %s840 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.840, i32 0, i32 0
  %t841 = icmp eq i8* %t839, %s840
  br i1 %t841, label %then22, label %merge23
then22:
  %t842 = extractvalue %Statement %statement, 0
  %t843 = alloca %Statement
  store %Statement %statement, %Statement* %t843
  %t844 = getelementptr inbounds %Statement, %Statement* %t843, i32 0, i32 1
  %t845 = bitcast [32 x i8]* %t844 to i8*
  %t846 = bitcast i8* %t845 to %Expression*
  %t847 = load %Expression, %Expression* %t846
  %t848 = icmp eq i32 %t842, 19
  %t849 = select i1 %t848, %Expression %t847, %Expression zeroinitializer
  %t850 = alloca %Expression
  store %Expression %t849, %Expression* %t850
  %t851 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t850)
  store { %EffectRequirement*, i64 }* %t851, { %EffectRequirement*, i64 }** %l7
  %t852 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t853 = extractvalue %Statement %statement, 0
  %t854 = alloca %Statement
  store %Statement %statement, %Statement* %t854
  %t855 = getelementptr inbounds %Statement, %Statement* %t854, i32 0, i32 1
  %t856 = bitcast [32 x i8]* %t855 to i8*
  %t857 = getelementptr inbounds i8, i8* %t856, i64 8
  %t858 = bitcast i8* %t857 to %Block*
  %t859 = load %Block, %Block* %t858
  %t860 = icmp eq i32 %t853, 19
  %t861 = select i1 %t860, %Block %t859, %Block zeroinitializer
  %t862 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t861)
  %t863 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t852, { %EffectRequirement*, i64 }* %t862)
  store { %EffectRequirement*, i64 }* %t863, { %EffectRequirement*, i64 }** %l7
  %t864 = extractvalue %Statement %statement, 0
  %t865 = alloca %Statement
  store %Statement %statement, %Statement* %t865
  %t866 = getelementptr inbounds %Statement, %Statement* %t865, i32 0, i32 1
  %t867 = bitcast [32 x i8]* %t866 to i8*
  %t868 = getelementptr inbounds i8, i8* %t867, i64 16
  %t869 = bitcast i8* %t868 to %ElseBranch**
  %t870 = load %ElseBranch*, %ElseBranch** %t869
  %t871 = icmp eq i32 %t864, 19
  %t872 = select i1 %t871, %ElseBranch* %t870, %ElseBranch* null
  %t873 = bitcast i8* null to %ElseBranch*
  %t874 = icmp ne %ElseBranch* %t872, %t873
  %t875 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  br i1 %t874, label %then24, label %merge25
then24:
  %t876 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t877 = extractvalue %Statement %statement, 0
  %t878 = alloca %Statement
  store %Statement %statement, %Statement* %t878
  %t879 = getelementptr inbounds %Statement, %Statement* %t878, i32 0, i32 1
  %t880 = bitcast [32 x i8]* %t879 to i8*
  %t881 = getelementptr inbounds i8, i8* %t880, i64 16
  %t882 = bitcast i8* %t881 to %ElseBranch**
  %t883 = load %ElseBranch*, %ElseBranch** %t882
  %t884 = icmp eq i32 %t877, 19
  %t885 = select i1 %t884, %ElseBranch* %t883, %ElseBranch* null
  %t886 = load %ElseBranch, %ElseBranch* %t885
  %t887 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %t886)
  %t888 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t876, { %EffectRequirement*, i64 }* %t887)
  store { %EffectRequirement*, i64 }* %t888, { %EffectRequirement*, i64 }** %l7
  br label %merge25
merge25:
  %t889 = phi { %EffectRequirement*, i64 }* [ %t888, %then24 ], [ %t875, %then22 ]
  store { %EffectRequirement*, i64 }* %t889, { %EffectRequirement*, i64 }** %l7
  %t890 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t890
merge23:
  %t891 = extractvalue %Statement %statement, 0
  %t892 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t893 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t891, 0
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t891, 1
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t891, 2
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t891, 3
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t891, 4
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t891, 5
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t891, 6
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t891, 7
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t891, 8
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t891, 9
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t891, 10
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t891, 11
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t891, 12
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t891, 13
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t891, 14
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t891, 15
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t891, 16
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t891, 17
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t891, 18
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t891, 19
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t891, 20
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t891, 21
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t891, 22
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %s962 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.962, i32 0, i32 0
  %t963 = icmp eq i8* %t961, %s962
  br i1 %t963, label %then26, label %merge27
then26:
  %t964 = extractvalue %Statement %statement, 0
  %t965 = alloca %Statement
  store %Statement %statement, %Statement* %t965
  %t966 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t967 = bitcast [24 x i8]* %t966 to i8*
  %t968 = bitcast i8* %t967 to %Expression*
  %t969 = icmp eq i32 %t964, 18
  %t970 = select i1 %t969, %Expression* %t968, %Expression* null
  %t971 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t972 = bitcast [16 x i8]* %t971 to i8*
  %t973 = bitcast i8* %t972 to %Expression**
  %t974 = load %Expression*, %Expression** %t973
  %t975 = icmp eq i32 %t964, 20
  %t976 = select i1 %t975, %Expression* %t974, %Expression* %t970
  %t977 = getelementptr inbounds %Statement, %Statement* %t965, i32 0, i32 1
  %t978 = bitcast [16 x i8]* %t977 to i8*
  %t979 = bitcast i8* %t978 to %Expression*
  %t980 = icmp eq i32 %t964, 21
  %t981 = select i1 %t980, %Expression* %t979, %Expression* %t976
  %t982 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t981)
  ret { %EffectRequirement*, i64 }* %t982
merge27:
  %t983 = extractvalue %Statement %statement, 0
  %t984 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t985 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t983, 0
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t983, 1
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t983, 2
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t983, 3
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t983, 4
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t983, 5
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t983, 6
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t983, 7
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t983, 8
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t983, 9
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t983, 10
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t983, 11
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t983, 12
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t983, 13
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t983, 14
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t983, 15
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t983, 16
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t983, 17
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t983, 18
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t983, 19
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t983, 20
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t983, 21
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t983, 22
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %s1054 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1054, i32 0, i32 0
  %t1055 = icmp eq i8* %t1053, %s1054
  br i1 %t1055, label %then28, label %merge29
then28:
  %t1056 = extractvalue %Statement %statement, 0
  %t1057 = alloca %Statement
  store %Statement %statement, %Statement* %t1057
  %t1058 = getelementptr inbounds %Statement, %Statement* %t1057, i32 0, i32 1
  %t1059 = bitcast [24 x i8]* %t1058 to i8*
  %t1060 = bitcast i8* %t1059 to %Expression*
  %t1061 = icmp eq i32 %t1056, 18
  %t1062 = select i1 %t1061, %Expression* %t1060, %Expression* null
  %t1063 = getelementptr inbounds %Statement, %Statement* %t1057, i32 0, i32 1
  %t1064 = bitcast [16 x i8]* %t1063 to i8*
  %t1065 = bitcast i8* %t1064 to %Expression**
  %t1066 = load %Expression*, %Expression** %t1065
  %t1067 = icmp eq i32 %t1056, 20
  %t1068 = select i1 %t1067, %Expression* %t1066, %Expression* %t1062
  %t1069 = getelementptr inbounds %Statement, %Statement* %t1057, i32 0, i32 1
  %t1070 = bitcast [16 x i8]* %t1069 to i8*
  %t1071 = bitcast i8* %t1070 to %Expression*
  %t1072 = icmp eq i32 %t1056, 21
  %t1073 = select i1 %t1072, %Expression* %t1071, %Expression* %t1068
  %t1074 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1073)
  ret { %EffectRequirement*, i64 }* %t1074
merge29:
  %t1075 = extractvalue %Statement %statement, 0
  %t1076 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1077 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1075, 0
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1075, 1
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1075, 2
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1075, 3
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1075, 4
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1075, 5
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1075, 6
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1075, 7
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1075, 8
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1075, 9
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1075, 10
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1075, 11
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1075, 12
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1075, 13
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1075, 14
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1075, 15
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1075, 16
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1075, 17
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1075, 18
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1075, 19
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1075, 20
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1075, 21
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1075, 22
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %s1146 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1146, i32 0, i32 0
  %t1147 = icmp eq i8* %t1145, %s1146
  br i1 %t1147, label %then30, label %merge31
then30:
  %t1148 = extractvalue %Statement %statement, 0
  %t1149 = alloca %Statement
  store %Statement %statement, %Statement* %t1149
  %t1150 = getelementptr inbounds %Statement, %Statement* %t1149, i32 0, i32 1
  %t1151 = bitcast [48 x i8]* %t1150 to i8*
  %t1152 = getelementptr inbounds i8, i8* %t1151, i64 24
  %t1153 = bitcast i8* %t1152 to %Expression**
  %t1154 = load %Expression*, %Expression** %t1153
  %t1155 = icmp eq i32 %t1148, 2
  %t1156 = select i1 %t1155, %Expression* %t1154, %Expression* null
  %t1157 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1156)
  ret { %EffectRequirement*, i64 }* %t1157
merge31:
  %t1158 = extractvalue %Statement %statement, 0
  %t1159 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1160 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1158, 0
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1158, 1
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1158, 2
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1158, 3
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1158, 4
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1158, 5
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1158, 6
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1158, 7
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1158, 8
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1158, 9
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1158, 10
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1158, 11
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1158, 12
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1158, 13
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1158, 14
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1158, 15
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %t1208 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1158, 16
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1158, 17
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1158, 18
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1158, 19
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1158, 20
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1158, 21
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1158, 22
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %s1229 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1229, i32 0, i32 0
  %t1230 = icmp eq i8* %t1228, %s1229
  br i1 %t1230, label %then32, label %merge33
then32:
  %t1231 = extractvalue %Statement %statement, 0
  %t1232 = alloca %Statement
  store %Statement %statement, %Statement* %t1232
  %t1233 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1234 = bitcast [24 x i8]* %t1233 to i8*
  %t1235 = getelementptr inbounds i8, i8* %t1234, i64 8
  %t1236 = bitcast i8* %t1235 to %Block*
  %t1237 = load %Block, %Block* %t1236
  %t1238 = icmp eq i32 %t1231, 4
  %t1239 = select i1 %t1238, %Block %t1237, %Block zeroinitializer
  %t1240 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1241 = bitcast [24 x i8]* %t1240 to i8*
  %t1242 = getelementptr inbounds i8, i8* %t1241, i64 8
  %t1243 = bitcast i8* %t1242 to %Block*
  %t1244 = load %Block, %Block* %t1243
  %t1245 = icmp eq i32 %t1231, 5
  %t1246 = select i1 %t1245, %Block %t1244, %Block %t1239
  %t1247 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1248 = bitcast [40 x i8]* %t1247 to i8*
  %t1249 = getelementptr inbounds i8, i8* %t1248, i64 16
  %t1250 = bitcast i8* %t1249 to %Block*
  %t1251 = load %Block, %Block* %t1250
  %t1252 = icmp eq i32 %t1231, 6
  %t1253 = select i1 %t1252, %Block %t1251, %Block %t1246
  %t1254 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1255 = bitcast [24 x i8]* %t1254 to i8*
  %t1256 = getelementptr inbounds i8, i8* %t1255, i64 8
  %t1257 = bitcast i8* %t1256 to %Block*
  %t1258 = load %Block, %Block* %t1257
  %t1259 = icmp eq i32 %t1231, 7
  %t1260 = select i1 %t1259, %Block %t1258, %Block %t1253
  %t1261 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1262 = bitcast [40 x i8]* %t1261 to i8*
  %t1263 = getelementptr inbounds i8, i8* %t1262, i64 24
  %t1264 = bitcast i8* %t1263 to %Block*
  %t1265 = load %Block, %Block* %t1264
  %t1266 = icmp eq i32 %t1231, 12
  %t1267 = select i1 %t1266, %Block %t1265, %Block %t1260
  %t1268 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1269 = bitcast [24 x i8]* %t1268 to i8*
  %t1270 = getelementptr inbounds i8, i8* %t1269, i64 8
  %t1271 = bitcast i8* %t1270 to %Block*
  %t1272 = load %Block, %Block* %t1271
  %t1273 = icmp eq i32 %t1231, 13
  %t1274 = select i1 %t1273, %Block %t1272, %Block %t1267
  %t1275 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1276 = bitcast [24 x i8]* %t1275 to i8*
  %t1277 = getelementptr inbounds i8, i8* %t1276, i64 8
  %t1278 = bitcast i8* %t1277 to %Block*
  %t1279 = load %Block, %Block* %t1278
  %t1280 = icmp eq i32 %t1231, 14
  %t1281 = select i1 %t1280, %Block %t1279, %Block %t1274
  %t1282 = getelementptr inbounds %Statement, %Statement* %t1232, i32 0, i32 1
  %t1283 = bitcast [16 x i8]* %t1282 to i8*
  %t1284 = bitcast i8* %t1283 to %Block*
  %t1285 = load %Block, %Block* %t1284
  %t1286 = icmp eq i32 %t1231, 15
  %t1287 = select i1 %t1286, %Block %t1285, %Block %t1281
  %t1288 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1287)
  ret { %EffectRequirement*, i64 }* %t1288
merge33:
  %t1289 = extractvalue %Statement %statement, 0
  %t1290 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1291 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1289, 0
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1289, 1
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1289, 2
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1289, 3
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1289, 4
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1289, 5
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1289, 6
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1289, 7
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1289, 8
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1289, 9
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %t1321 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1289, 10
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1289, 11
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %t1327 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1328 = icmp eq i32 %t1289, 12
  %t1329 = select i1 %t1328, i8* %t1327, i8* %t1326
  %t1330 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1331 = icmp eq i32 %t1289, 13
  %t1332 = select i1 %t1331, i8* %t1330, i8* %t1329
  %t1333 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1334 = icmp eq i32 %t1289, 14
  %t1335 = select i1 %t1334, i8* %t1333, i8* %t1332
  %t1336 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1337 = icmp eq i32 %t1289, 15
  %t1338 = select i1 %t1337, i8* %t1336, i8* %t1335
  %t1339 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1340 = icmp eq i32 %t1289, 16
  %t1341 = select i1 %t1340, i8* %t1339, i8* %t1338
  %t1342 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1343 = icmp eq i32 %t1289, 17
  %t1344 = select i1 %t1343, i8* %t1342, i8* %t1341
  %t1345 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1346 = icmp eq i32 %t1289, 18
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1344
  %t1348 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1349 = icmp eq i32 %t1289, 19
  %t1350 = select i1 %t1349, i8* %t1348, i8* %t1347
  %t1351 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1352 = icmp eq i32 %t1289, 20
  %t1353 = select i1 %t1352, i8* %t1351, i8* %t1350
  %t1354 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1355 = icmp eq i32 %t1289, 21
  %t1356 = select i1 %t1355, i8* %t1354, i8* %t1353
  %t1357 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1358 = icmp eq i32 %t1289, 22
  %t1359 = select i1 %t1358, i8* %t1357, i8* %t1356
  %s1360 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1360, i32 0, i32 0
  %t1361 = icmp eq i8* %t1359, %s1360
  br i1 %t1361, label %then34, label %merge35
then34:
  %t1362 = extractvalue %Statement %statement, 0
  %t1363 = alloca %Statement
  store %Statement %statement, %Statement* %t1363
  %t1364 = getelementptr inbounds %Statement, %Statement* %t1363, i32 0, i32 1
  %t1365 = bitcast [24 x i8]* %t1364 to i8*
  %t1366 = getelementptr inbounds i8, i8* %t1365, i64 8
  %t1367 = bitcast i8* %t1366 to %Block*
  %t1368 = load %Block, %Block* %t1367
  %t1369 = icmp eq i32 %t1362, 4
  %t1370 = select i1 %t1369, %Block %t1368, %Block zeroinitializer
  %t1371 = getelementptr inbounds %Statement, %Statement* %t1363, i32 0, i32 1
  %t1372 = bitcast [24 x i8]* %t1371 to i8*
  %t1373 = getelementptr inbounds i8, i8* %t1372, i64 8
  %t1374 = bitcast i8* %t1373 to %Block*
  %t1375 = load %Block, %Block* %t1374
  %t1376 = icmp eq i32 %t1362, 5
  %t1377 = select i1 %t1376, %Block %t1375, %Block %t1370
  %t1378 = getelementptr inbounds %Statement, %Statement* %t1363, i32 0, i32 1
  %t1379 = bitcast [40 x i8]* %t1378 to i8*
  %t1380 = getelementptr inbounds i8, i8* %t1379, i64 16
  %t1381 = bitcast i8* %t1380 to %Block*
  %t1382 = load %Block, %Block* %t1381
  %t1383 = icmp eq i32 %t1362, 6
  %t1384 = select i1 %t1383, %Block %t1382, %Block %t1377
  %t1385 = getelementptr inbounds %Statement, %Statement* %t1363, i32 0, i32 1
  %t1386 = bitcast [24 x i8]* %t1385 to i8*
  %t1387 = getelementptr inbounds i8, i8* %t1386, i64 8
  %t1388 = bitcast i8* %t1387 to %Block*
  %t1389 = load %Block, %Block* %t1388
  %t1390 = icmp eq i32 %t1362, 7
  %t1391 = select i1 %t1390, %Block %t1389, %Block %t1384
  %t1392 = getelementptr inbounds %Statement, %Statement* %t1363, i32 0, i32 1
  %t1393 = bitcast [40 x i8]* %t1392 to i8*
  %t1394 = getelementptr inbounds i8, i8* %t1393, i64 24
  %t1395 = bitcast i8* %t1394 to %Block*
  %t1396 = load %Block, %Block* %t1395
  %t1397 = icmp eq i32 %t1362, 12
  %t1398 = select i1 %t1397, %Block %t1396, %Block %t1391
  %t1399 = getelementptr inbounds %Statement, %Statement* %t1363, i32 0, i32 1
  %t1400 = bitcast [24 x i8]* %t1399 to i8*
  %t1401 = getelementptr inbounds i8, i8* %t1400, i64 8
  %t1402 = bitcast i8* %t1401 to %Block*
  %t1403 = load %Block, %Block* %t1402
  %t1404 = icmp eq i32 %t1362, 13
  %t1405 = select i1 %t1404, %Block %t1403, %Block %t1398
  %t1406 = getelementptr inbounds %Statement, %Statement* %t1363, i32 0, i32 1
  %t1407 = bitcast [24 x i8]* %t1406 to i8*
  %t1408 = getelementptr inbounds i8, i8* %t1407, i64 8
  %t1409 = bitcast i8* %t1408 to %Block*
  %t1410 = load %Block, %Block* %t1409
  %t1411 = icmp eq i32 %t1362, 14
  %t1412 = select i1 %t1411, %Block %t1410, %Block %t1405
  %t1413 = getelementptr inbounds %Statement, %Statement* %t1363, i32 0, i32 1
  %t1414 = bitcast [16 x i8]* %t1413 to i8*
  %t1415 = bitcast i8* %t1414 to %Block*
  %t1416 = load %Block, %Block* %t1415
  %t1417 = icmp eq i32 %t1362, 15
  %t1418 = select i1 %t1417, %Block %t1416, %Block %t1412
  %t1419 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1418)
  ret { %EffectRequirement*, i64 }* %t1419
merge35:
  %t1420 = extractvalue %Statement %statement, 0
  %t1421 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1422 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1420, 0
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1420, 1
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1420, 2
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1420, 3
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1420, 4
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1420, 5
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1420, 6
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1420, 7
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1420, 8
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1420, 9
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1420, 10
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1420, 11
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1420, 12
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1420, 13
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1420, 14
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1420, 15
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1420, 16
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1420, 17
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1420, 18
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1420, 19
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1420, 20
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1420, 21
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1420, 22
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %s1491 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1491, i32 0, i32 0
  %t1492 = icmp eq i8* %t1490, %s1491
  br i1 %t1492, label %then36, label %merge37
then36:
  %t1493 = extractvalue %Statement %statement, 0
  %t1494 = alloca %Statement
  store %Statement %statement, %Statement* %t1494
  %t1495 = getelementptr inbounds %Statement, %Statement* %t1494, i32 0, i32 1
  %t1496 = bitcast [24 x i8]* %t1495 to i8*
  %t1497 = getelementptr inbounds i8, i8* %t1496, i64 8
  %t1498 = bitcast i8* %t1497 to %Block*
  %t1499 = load %Block, %Block* %t1498
  %t1500 = icmp eq i32 %t1493, 4
  %t1501 = select i1 %t1500, %Block %t1499, %Block zeroinitializer
  %t1502 = getelementptr inbounds %Statement, %Statement* %t1494, i32 0, i32 1
  %t1503 = bitcast [24 x i8]* %t1502 to i8*
  %t1504 = getelementptr inbounds i8, i8* %t1503, i64 8
  %t1505 = bitcast i8* %t1504 to %Block*
  %t1506 = load %Block, %Block* %t1505
  %t1507 = icmp eq i32 %t1493, 5
  %t1508 = select i1 %t1507, %Block %t1506, %Block %t1501
  %t1509 = getelementptr inbounds %Statement, %Statement* %t1494, i32 0, i32 1
  %t1510 = bitcast [40 x i8]* %t1509 to i8*
  %t1511 = getelementptr inbounds i8, i8* %t1510, i64 16
  %t1512 = bitcast i8* %t1511 to %Block*
  %t1513 = load %Block, %Block* %t1512
  %t1514 = icmp eq i32 %t1493, 6
  %t1515 = select i1 %t1514, %Block %t1513, %Block %t1508
  %t1516 = getelementptr inbounds %Statement, %Statement* %t1494, i32 0, i32 1
  %t1517 = bitcast [24 x i8]* %t1516 to i8*
  %t1518 = getelementptr inbounds i8, i8* %t1517, i64 8
  %t1519 = bitcast i8* %t1518 to %Block*
  %t1520 = load %Block, %Block* %t1519
  %t1521 = icmp eq i32 %t1493, 7
  %t1522 = select i1 %t1521, %Block %t1520, %Block %t1515
  %t1523 = getelementptr inbounds %Statement, %Statement* %t1494, i32 0, i32 1
  %t1524 = bitcast [40 x i8]* %t1523 to i8*
  %t1525 = getelementptr inbounds i8, i8* %t1524, i64 24
  %t1526 = bitcast i8* %t1525 to %Block*
  %t1527 = load %Block, %Block* %t1526
  %t1528 = icmp eq i32 %t1493, 12
  %t1529 = select i1 %t1528, %Block %t1527, %Block %t1522
  %t1530 = getelementptr inbounds %Statement, %Statement* %t1494, i32 0, i32 1
  %t1531 = bitcast [24 x i8]* %t1530 to i8*
  %t1532 = getelementptr inbounds i8, i8* %t1531, i64 8
  %t1533 = bitcast i8* %t1532 to %Block*
  %t1534 = load %Block, %Block* %t1533
  %t1535 = icmp eq i32 %t1493, 13
  %t1536 = select i1 %t1535, %Block %t1534, %Block %t1529
  %t1537 = getelementptr inbounds %Statement, %Statement* %t1494, i32 0, i32 1
  %t1538 = bitcast [24 x i8]* %t1537 to i8*
  %t1539 = getelementptr inbounds i8, i8* %t1538, i64 8
  %t1540 = bitcast i8* %t1539 to %Block*
  %t1541 = load %Block, %Block* %t1540
  %t1542 = icmp eq i32 %t1493, 14
  %t1543 = select i1 %t1542, %Block %t1541, %Block %t1536
  %t1544 = getelementptr inbounds %Statement, %Statement* %t1494, i32 0, i32 1
  %t1545 = bitcast [16 x i8]* %t1544 to i8*
  %t1546 = bitcast i8* %t1545 to %Block*
  %t1547 = load %Block, %Block* %t1546
  %t1548 = icmp eq i32 %t1493, 15
  %t1549 = select i1 %t1548, %Block %t1547, %Block %t1543
  %t1550 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1549)
  ret { %EffectRequirement*, i64 }* %t1550
merge37:
  %t1551 = extractvalue %Statement %statement, 0
  %t1552 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1553 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1551, 0
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1551, 1
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1551, 2
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1551, 3
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1551, 4
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1551, 5
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1551, 6
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1551, 7
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1551, 8
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1551, 9
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1551, 10
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1551, 11
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1551, 12
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %t1592 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1551, 13
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1551, 14
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1551, 15
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1551, 16
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1551, 17
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1551, 18
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1551, 19
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1551, 20
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %t1616 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1551, 21
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %t1619 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1620 = icmp eq i32 %t1551, 22
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1618
  %s1622 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1622, i32 0, i32 0
  %t1623 = icmp eq i8* %t1621, %s1622
  br i1 %t1623, label %then38, label %merge39
then38:
  %t1624 = extractvalue %Statement %statement, 0
  %t1625 = alloca %Statement
  store %Statement %statement, %Statement* %t1625
  %t1626 = getelementptr inbounds %Statement, %Statement* %t1625, i32 0, i32 1
  %t1627 = bitcast [24 x i8]* %t1626 to i8*
  %t1628 = getelementptr inbounds i8, i8* %t1627, i64 8
  %t1629 = bitcast i8* %t1628 to %Block*
  %t1630 = load %Block, %Block* %t1629
  %t1631 = icmp eq i32 %t1624, 4
  %t1632 = select i1 %t1631, %Block %t1630, %Block zeroinitializer
  %t1633 = getelementptr inbounds %Statement, %Statement* %t1625, i32 0, i32 1
  %t1634 = bitcast [24 x i8]* %t1633 to i8*
  %t1635 = getelementptr inbounds i8, i8* %t1634, i64 8
  %t1636 = bitcast i8* %t1635 to %Block*
  %t1637 = load %Block, %Block* %t1636
  %t1638 = icmp eq i32 %t1624, 5
  %t1639 = select i1 %t1638, %Block %t1637, %Block %t1632
  %t1640 = getelementptr inbounds %Statement, %Statement* %t1625, i32 0, i32 1
  %t1641 = bitcast [40 x i8]* %t1640 to i8*
  %t1642 = getelementptr inbounds i8, i8* %t1641, i64 16
  %t1643 = bitcast i8* %t1642 to %Block*
  %t1644 = load %Block, %Block* %t1643
  %t1645 = icmp eq i32 %t1624, 6
  %t1646 = select i1 %t1645, %Block %t1644, %Block %t1639
  %t1647 = getelementptr inbounds %Statement, %Statement* %t1625, i32 0, i32 1
  %t1648 = bitcast [24 x i8]* %t1647 to i8*
  %t1649 = getelementptr inbounds i8, i8* %t1648, i64 8
  %t1650 = bitcast i8* %t1649 to %Block*
  %t1651 = load %Block, %Block* %t1650
  %t1652 = icmp eq i32 %t1624, 7
  %t1653 = select i1 %t1652, %Block %t1651, %Block %t1646
  %t1654 = getelementptr inbounds %Statement, %Statement* %t1625, i32 0, i32 1
  %t1655 = bitcast [40 x i8]* %t1654 to i8*
  %t1656 = getelementptr inbounds i8, i8* %t1655, i64 24
  %t1657 = bitcast i8* %t1656 to %Block*
  %t1658 = load %Block, %Block* %t1657
  %t1659 = icmp eq i32 %t1624, 12
  %t1660 = select i1 %t1659, %Block %t1658, %Block %t1653
  %t1661 = getelementptr inbounds %Statement, %Statement* %t1625, i32 0, i32 1
  %t1662 = bitcast [24 x i8]* %t1661 to i8*
  %t1663 = getelementptr inbounds i8, i8* %t1662, i64 8
  %t1664 = bitcast i8* %t1663 to %Block*
  %t1665 = load %Block, %Block* %t1664
  %t1666 = icmp eq i32 %t1624, 13
  %t1667 = select i1 %t1666, %Block %t1665, %Block %t1660
  %t1668 = getelementptr inbounds %Statement, %Statement* %t1625, i32 0, i32 1
  %t1669 = bitcast [24 x i8]* %t1668 to i8*
  %t1670 = getelementptr inbounds i8, i8* %t1669, i64 8
  %t1671 = bitcast i8* %t1670 to %Block*
  %t1672 = load %Block, %Block* %t1671
  %t1673 = icmp eq i32 %t1624, 14
  %t1674 = select i1 %t1673, %Block %t1672, %Block %t1667
  %t1675 = getelementptr inbounds %Statement, %Statement* %t1625, i32 0, i32 1
  %t1676 = bitcast [16 x i8]* %t1675 to i8*
  %t1677 = bitcast i8* %t1676 to %Block*
  %t1678 = load %Block, %Block* %t1677
  %t1679 = icmp eq i32 %t1624, 15
  %t1680 = select i1 %t1679, %Block %t1678, %Block %t1674
  %t1681 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1680)
  ret { %EffectRequirement*, i64 }* %t1681
merge39:
  %t1682 = extractvalue %Statement %statement, 0
  %t1683 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1684 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1682, 0
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1688 = icmp eq i32 %t1682, 1
  %t1689 = select i1 %t1688, i8* %t1687, i8* %t1686
  %t1690 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1691 = icmp eq i32 %t1682, 2
  %t1692 = select i1 %t1691, i8* %t1690, i8* %t1689
  %t1693 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1682, 3
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1682, 4
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %t1699 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1700 = icmp eq i32 %t1682, 5
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1698
  %t1702 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1703 = icmp eq i32 %t1682, 6
  %t1704 = select i1 %t1703, i8* %t1702, i8* %t1701
  %t1705 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1706 = icmp eq i32 %t1682, 7
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1704
  %t1708 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1682, 8
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %t1711 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1712 = icmp eq i32 %t1682, 9
  %t1713 = select i1 %t1712, i8* %t1711, i8* %t1710
  %t1714 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1715 = icmp eq i32 %t1682, 10
  %t1716 = select i1 %t1715, i8* %t1714, i8* %t1713
  %t1717 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1718 = icmp eq i32 %t1682, 11
  %t1719 = select i1 %t1718, i8* %t1717, i8* %t1716
  %t1720 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1721 = icmp eq i32 %t1682, 12
  %t1722 = select i1 %t1721, i8* %t1720, i8* %t1719
  %t1723 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1724 = icmp eq i32 %t1682, 13
  %t1725 = select i1 %t1724, i8* %t1723, i8* %t1722
  %t1726 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1727 = icmp eq i32 %t1682, 14
  %t1728 = select i1 %t1727, i8* %t1726, i8* %t1725
  %t1729 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1730 = icmp eq i32 %t1682, 15
  %t1731 = select i1 %t1730, i8* %t1729, i8* %t1728
  %t1732 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1733 = icmp eq i32 %t1682, 16
  %t1734 = select i1 %t1733, i8* %t1732, i8* %t1731
  %t1735 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1736 = icmp eq i32 %t1682, 17
  %t1737 = select i1 %t1736, i8* %t1735, i8* %t1734
  %t1738 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1739 = icmp eq i32 %t1682, 18
  %t1740 = select i1 %t1739, i8* %t1738, i8* %t1737
  %t1741 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1742 = icmp eq i32 %t1682, 19
  %t1743 = select i1 %t1742, i8* %t1741, i8* %t1740
  %t1744 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1745 = icmp eq i32 %t1682, 20
  %t1746 = select i1 %t1745, i8* %t1744, i8* %t1743
  %t1747 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1748 = icmp eq i32 %t1682, 21
  %t1749 = select i1 %t1748, i8* %t1747, i8* %t1746
  %t1750 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1751 = icmp eq i32 %t1682, 22
  %t1752 = select i1 %t1751, i8* %t1750, i8* %t1749
  %s1753 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1753, i32 0, i32 0
  %t1754 = icmp eq i8* %t1752, %s1753
  br i1 %t1754, label %then40, label %merge41
then40:
  %t1755 = alloca [0 x %EffectRequirement]
  %t1756 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1755, i32 0, i32 0
  %t1757 = alloca { %EffectRequirement*, i64 }
  %t1758 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1757, i32 0, i32 0
  store %EffectRequirement* %t1756, %EffectRequirement** %t1758
  %t1759 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1757, i32 0, i32 1
  store i64 0, i64* %t1759
  store { %EffectRequirement*, i64 }* %t1757, { %EffectRequirement*, i64 }** %l8
  %t1760 = sitofp i64 0 to double
  store double %t1760, double* %l9
  %t1761 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1762 = load double, double* %l9
  br label %loop.header42
loop.header42:
  %t1806 = phi { %EffectRequirement*, i64 }* [ %t1761, %then40 ], [ %t1804, %loop.latch44 ]
  %t1807 = phi double [ %t1762, %then40 ], [ %t1805, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1806, { %EffectRequirement*, i64 }** %l8
  store double %t1807, double* %l9
  br label %loop.body43
loop.body43:
  %t1763 = load double, double* %l9
  %t1764 = extractvalue %Statement %statement, 0
  %t1765 = alloca %Statement
  store %Statement %statement, %Statement* %t1765
  %t1766 = getelementptr inbounds %Statement, %Statement* %t1765, i32 0, i32 1
  %t1767 = bitcast [56 x i8]* %t1766 to i8*
  %t1768 = getelementptr inbounds i8, i8* %t1767, i64 40
  %t1769 = bitcast i8* %t1768 to { %MethodDeclaration**, i64 }**
  %t1770 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1769
  %t1771 = icmp eq i32 %t1764, 8
  %t1772 = select i1 %t1771, { %MethodDeclaration**, i64 }* %t1770, { %MethodDeclaration**, i64 }* null
  %t1773 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1772
  %t1774 = extractvalue { %MethodDeclaration**, i64 } %t1773, 1
  %t1775 = sitofp i64 %t1774 to double
  %t1776 = fcmp oge double %t1763, %t1775
  %t1777 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1778 = load double, double* %l9
  br i1 %t1776, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1779 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1780 = extractvalue %Statement %statement, 0
  %t1781 = alloca %Statement
  store %Statement %statement, %Statement* %t1781
  %t1782 = getelementptr inbounds %Statement, %Statement* %t1781, i32 0, i32 1
  %t1783 = bitcast [56 x i8]* %t1782 to i8*
  %t1784 = getelementptr inbounds i8, i8* %t1783, i64 40
  %t1785 = bitcast i8* %t1784 to { %MethodDeclaration**, i64 }**
  %t1786 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1785
  %t1787 = icmp eq i32 %t1780, 8
  %t1788 = select i1 %t1787, { %MethodDeclaration**, i64 }* %t1786, { %MethodDeclaration**, i64 }* null
  %t1789 = load double, double* %l9
  %t1790 = fptosi double %t1789 to i64
  %t1791 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1788
  %t1792 = extractvalue { %MethodDeclaration**, i64 } %t1791, 0
  %t1793 = extractvalue { %MethodDeclaration**, i64 } %t1791, 1
  %t1794 = icmp uge i64 %t1790, %t1793
  ; bounds check: %t1794 (if true, out of bounds)
  %t1795 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1792, i64 %t1790
  %t1796 = load %MethodDeclaration*, %MethodDeclaration** %t1795
  %t1797 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1796, i32 0, i32 1
  %t1798 = load %Block, %Block* %t1797
  %t1799 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1798)
  %t1800 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1779, { %EffectRequirement*, i64 }* %t1799)
  store { %EffectRequirement*, i64 }* %t1800, { %EffectRequirement*, i64 }** %l8
  %t1801 = load double, double* %l9
  %t1802 = sitofp i64 1 to double
  %t1803 = fadd double %t1801, %t1802
  store double %t1803, double* %l9
  br label %loop.latch44
loop.latch44:
  %t1804 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1805 = load double, double* %l9
  br label %loop.header42
afterloop45:
  %t1808 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  ret { %EffectRequirement*, i64 }* %t1808
merge41:
  %t1809 = extractvalue %Statement %statement, 0
  %t1810 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1811 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1812 = icmp eq i32 %t1809, 0
  %t1813 = select i1 %t1812, i8* %t1811, i8* %t1810
  %t1814 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1815 = icmp eq i32 %t1809, 1
  %t1816 = select i1 %t1815, i8* %t1814, i8* %t1813
  %t1817 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1818 = icmp eq i32 %t1809, 2
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1816
  %t1820 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1809, 3
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1809, 4
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1809, 5
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1809, 6
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1809, 7
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1809, 8
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1809, 9
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1809, 10
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1809, 11
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1809, 12
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1809, 13
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %t1853 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1809, 14
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %t1856 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1857 = icmp eq i32 %t1809, 15
  %t1858 = select i1 %t1857, i8* %t1856, i8* %t1855
  %t1859 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1860 = icmp eq i32 %t1809, 16
  %t1861 = select i1 %t1860, i8* %t1859, i8* %t1858
  %t1862 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1863 = icmp eq i32 %t1809, 17
  %t1864 = select i1 %t1863, i8* %t1862, i8* %t1861
  %t1865 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1866 = icmp eq i32 %t1809, 18
  %t1867 = select i1 %t1866, i8* %t1865, i8* %t1864
  %t1868 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1869 = icmp eq i32 %t1809, 19
  %t1870 = select i1 %t1869, i8* %t1868, i8* %t1867
  %t1871 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1872 = icmp eq i32 %t1809, 20
  %t1873 = select i1 %t1872, i8* %t1871, i8* %t1870
  %t1874 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1875 = icmp eq i32 %t1809, 21
  %t1876 = select i1 %t1875, i8* %t1874, i8* %t1873
  %t1877 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1878 = icmp eq i32 %t1809, 22
  %t1879 = select i1 %t1878, i8* %t1877, i8* %t1876
  %s1880 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1880, i32 0, i32 0
  %t1881 = icmp eq i8* %t1879, %s1880
  br i1 %t1881, label %then48, label %merge49
then48:
  %t1882 = alloca [0 x %EffectRequirement]
  %t1883 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1882, i32 0, i32 0
  %t1884 = alloca { %EffectRequirement*, i64 }
  %t1885 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1884, i32 0, i32 0
  store %EffectRequirement* %t1883, %EffectRequirement** %t1885
  %t1886 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1884, i32 0, i32 1
  store i64 0, i64* %t1886
  store { %EffectRequirement*, i64 }* %t1884, { %EffectRequirement*, i64 }** %l10
  %t1887 = sitofp i64 0 to double
  store double %t1887, double* %l11
  %t1888 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1889 = load double, double* %l11
  br label %loop.header50
loop.header50:
  %t1934 = phi { %EffectRequirement*, i64 }* [ %t1888, %then48 ], [ %t1932, %loop.latch52 ]
  %t1935 = phi double [ %t1889, %then48 ], [ %t1933, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1934, { %EffectRequirement*, i64 }** %l10
  store double %t1935, double* %l11
  br label %loop.body51
loop.body51:
  %t1890 = load double, double* %l11
  %t1891 = extractvalue %Statement %statement, 0
  %t1892 = alloca %Statement
  store %Statement %statement, %Statement* %t1892
  %t1893 = getelementptr inbounds %Statement, %Statement* %t1892, i32 0, i32 1
  %t1894 = bitcast [48 x i8]* %t1893 to i8*
  %t1895 = getelementptr inbounds i8, i8* %t1894, i64 24
  %t1896 = bitcast i8* %t1895 to { %ModelProperty**, i64 }**
  %t1897 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1896
  %t1898 = icmp eq i32 %t1891, 3
  %t1899 = select i1 %t1898, { %ModelProperty**, i64 }* %t1897, { %ModelProperty**, i64 }* null
  %t1900 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1899
  %t1901 = extractvalue { %ModelProperty**, i64 } %t1900, 1
  %t1902 = sitofp i64 %t1901 to double
  %t1903 = fcmp oge double %t1890, %t1902
  %t1904 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1905 = load double, double* %l11
  br i1 %t1903, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1906 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1907 = extractvalue %Statement %statement, 0
  %t1908 = alloca %Statement
  store %Statement %statement, %Statement* %t1908
  %t1909 = getelementptr inbounds %Statement, %Statement* %t1908, i32 0, i32 1
  %t1910 = bitcast [48 x i8]* %t1909 to i8*
  %t1911 = getelementptr inbounds i8, i8* %t1910, i64 24
  %t1912 = bitcast i8* %t1911 to { %ModelProperty**, i64 }**
  %t1913 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1912
  %t1914 = icmp eq i32 %t1907, 3
  %t1915 = select i1 %t1914, { %ModelProperty**, i64 }* %t1913, { %ModelProperty**, i64 }* null
  %t1916 = load double, double* %l11
  %t1917 = fptosi double %t1916 to i64
  %t1918 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1915
  %t1919 = extractvalue { %ModelProperty**, i64 } %t1918, 0
  %t1920 = extractvalue { %ModelProperty**, i64 } %t1918, 1
  %t1921 = icmp uge i64 %t1917, %t1920
  ; bounds check: %t1921 (if true, out of bounds)
  %t1922 = getelementptr %ModelProperty*, %ModelProperty** %t1919, i64 %t1917
  %t1923 = load %ModelProperty*, %ModelProperty** %t1922
  %t1924 = getelementptr %ModelProperty, %ModelProperty* %t1923, i32 0, i32 1
  %t1925 = load %Expression, %Expression* %t1924
  %t1926 = alloca %Expression
  store %Expression %t1925, %Expression* %t1926
  %t1927 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1926)
  %t1928 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1906, { %EffectRequirement*, i64 }* %t1927)
  store { %EffectRequirement*, i64 }* %t1928, { %EffectRequirement*, i64 }** %l10
  %t1929 = load double, double* %l11
  %t1930 = sitofp i64 1 to double
  %t1931 = fadd double %t1929, %t1930
  store double %t1931, double* %l11
  br label %loop.latch52
loop.latch52:
  %t1932 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1933 = load double, double* %l11
  br label %loop.header50
afterloop53:
  %t1936 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t1936
merge49:
  %t1937 = extractvalue %Statement %statement, 0
  %t1938 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1939 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1940 = icmp eq i32 %t1937, 0
  %t1941 = select i1 %t1940, i8* %t1939, i8* %t1938
  %t1942 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1943 = icmp eq i32 %t1937, 1
  %t1944 = select i1 %t1943, i8* %t1942, i8* %t1941
  %t1945 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1946 = icmp eq i32 %t1937, 2
  %t1947 = select i1 %t1946, i8* %t1945, i8* %t1944
  %t1948 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1949 = icmp eq i32 %t1937, 3
  %t1950 = select i1 %t1949, i8* %t1948, i8* %t1947
  %t1951 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1952 = icmp eq i32 %t1937, 4
  %t1953 = select i1 %t1952, i8* %t1951, i8* %t1950
  %t1954 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1955 = icmp eq i32 %t1937, 5
  %t1956 = select i1 %t1955, i8* %t1954, i8* %t1953
  %t1957 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1958 = icmp eq i32 %t1937, 6
  %t1959 = select i1 %t1958, i8* %t1957, i8* %t1956
  %t1960 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1961 = icmp eq i32 %t1937, 7
  %t1962 = select i1 %t1961, i8* %t1960, i8* %t1959
  %t1963 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1964 = icmp eq i32 %t1937, 8
  %t1965 = select i1 %t1964, i8* %t1963, i8* %t1962
  %t1966 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1967 = icmp eq i32 %t1937, 9
  %t1968 = select i1 %t1967, i8* %t1966, i8* %t1965
  %t1969 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1970 = icmp eq i32 %t1937, 10
  %t1971 = select i1 %t1970, i8* %t1969, i8* %t1968
  %t1972 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1973 = icmp eq i32 %t1937, 11
  %t1974 = select i1 %t1973, i8* %t1972, i8* %t1971
  %t1975 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1976 = icmp eq i32 %t1937, 12
  %t1977 = select i1 %t1976, i8* %t1975, i8* %t1974
  %t1978 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1979 = icmp eq i32 %t1937, 13
  %t1980 = select i1 %t1979, i8* %t1978, i8* %t1977
  %t1981 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1982 = icmp eq i32 %t1937, 14
  %t1983 = select i1 %t1982, i8* %t1981, i8* %t1980
  %t1984 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1985 = icmp eq i32 %t1937, 15
  %t1986 = select i1 %t1985, i8* %t1984, i8* %t1983
  %t1987 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1988 = icmp eq i32 %t1937, 16
  %t1989 = select i1 %t1988, i8* %t1987, i8* %t1986
  %t1990 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1991 = icmp eq i32 %t1937, 17
  %t1992 = select i1 %t1991, i8* %t1990, i8* %t1989
  %t1993 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1994 = icmp eq i32 %t1937, 18
  %t1995 = select i1 %t1994, i8* %t1993, i8* %t1992
  %t1996 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1997 = icmp eq i32 %t1937, 19
  %t1998 = select i1 %t1997, i8* %t1996, i8* %t1995
  %t1999 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t2000 = icmp eq i32 %t1937, 20
  %t2001 = select i1 %t2000, i8* %t1999, i8* %t1998
  %t2002 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t2003 = icmp eq i32 %t1937, 21
  %t2004 = select i1 %t2003, i8* %t2002, i8* %t2001
  %t2005 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t2006 = icmp eq i32 %t1937, 22
  %t2007 = select i1 %t2006, i8* %t2005, i8* %t2004
  %s2008 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.2008, i32 0, i32 0
  %t2009 = icmp eq i8* %t2007, %s2008
  br i1 %t2009, label %then56, label %merge57
then56:
  %t2010 = extractvalue %Statement %statement, 0
  %t2011 = alloca %Statement
  store %Statement %statement, %Statement* %t2011
  %t2012 = getelementptr inbounds %Statement, %Statement* %t2011, i32 0, i32 1
  %t2013 = bitcast [16 x i8]* %t2012 to i8*
  %t2014 = bitcast i8* %t2013 to { %Token**, i64 }**
  %t2015 = load { %Token**, i64 }*, { %Token**, i64 }** %t2014
  %t2016 = icmp eq i32 %t2010, 22
  %t2017 = select i1 %t2016, { %Token**, i64 }* %t2015, { %Token**, i64 }* null
  %t2018 = bitcast { %Token**, i64 }* %t2017 to { %Token*, i64 }*
  %t2019 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t2018)
  ret { %EffectRequirement*, i64 }* %t2019
merge57:
  %t2020 = alloca [0 x %EffectRequirement]
  %t2021 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t2020, i32 0, i32 0
  %t2022 = alloca { %EffectRequirement*, i64 }
  %t2023 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2022, i32 0, i32 0
  store %EffectRequirement* %t2021, %EffectRequirement** %t2023
  %t2024 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2022, i32 0, i32 1
  store i64 0, i64* %t2024
  ret { %EffectRequirement*, i64 }* %t2022
}

define { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %branch) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = alloca [0 x %EffectRequirement]
  %t1 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t0, i32 0, i32 0
  %t2 = alloca { %EffectRequirement*, i64 }
  %t3 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2, i32 0, i32 0
  store %EffectRequirement* %t1, %EffectRequirement** %t3
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t5 = extractvalue %ElseBranch %branch, 1
  %t6 = bitcast i8* null to %Block*
  %t7 = icmp ne %Block* %t5, %t6
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %t9 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t10 = extractvalue %ElseBranch %branch, 1
  %t11 = load %Block, %Block* %t10
  %t12 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t11)
  %t13 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }* %t12)
  store { %EffectRequirement*, i64 }* %t13, { %EffectRequirement*, i64 }** %l0
  br label %merge1
merge1:
  %t14 = phi { %EffectRequirement*, i64 }* [ %t13, %then0 ], [ %t8, %entry ]
  store { %EffectRequirement*, i64 }* %t14, { %EffectRequirement*, i64 }** %l0
  %t15 = extractvalue %ElseBranch %branch, 0
  %t16 = bitcast i8* null to %Statement*
  %t17 = icmp ne %Statement* %t15, %t16
  %t18 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t17, label %then2, label %merge3
then2:
  %t19 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t20 = extractvalue %ElseBranch %branch, 0
  %t21 = load %Statement, %Statement* %t20
  %t22 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %t21)
  %t23 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t19, { %EffectRequirement*, i64 }* %t22)
  store { %EffectRequirement*, i64 }* %t23, { %EffectRequirement*, i64 }** %l0
  br label %merge3
merge3:
  %t24 = phi { %EffectRequirement*, i64 }* [ %t23, %then2 ], [ %t18, %entry ]
  store { %EffectRequirement*, i64 }* %t24, { %EffectRequirement*, i64 }** %l0
  %t25 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t25
}

define { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %case) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = alloca %Expression
  store %Expression %t0, %Expression* %t1
  %t2 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1)
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t3 = extractvalue %MatchCase %case, 1
  %t4 = bitcast i8* null to %Expression*
  %t5 = icmp ne %Expression* %t3, %t4
  %t6 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t8 = extractvalue %MatchCase %case, 1
  %t9 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t8)
  %t10 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t7, { %EffectRequirement*, i64 }* %t9)
  store { %EffectRequirement*, i64 }* %t10, { %EffectRequirement*, i64 }** %l0
  br label %merge1
merge1:
  %t11 = phi { %EffectRequirement*, i64 }* [ %t10, %then0 ], [ %t6, %entry ]
  store { %EffectRequirement*, i64 }* %t11, { %EffectRequirement*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t13 = extractvalue %MatchCase %case, 2
  %t14 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t13)
  %t15 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t12, { %EffectRequirement*, i64 }* %t14)
  store { %EffectRequirement*, i64 }* %t15, { %EffectRequirement*, i64 }** %l0
  %t16 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t16
}

define { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %expression) {
entry:
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
  %t0 = bitcast i8* null to %Expression*
  %t1 = icmp eq %Expression* %expression, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [0 x %EffectRequirement]
  %t3 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t2, i32 0, i32 0
  %t4 = alloca { %EffectRequirement*, i64 }
  %t5 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t4, i32 0, i32 0
  store %EffectRequirement* %t3, %EffectRequirement** %t5
  %t6 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  ret { %EffectRequirement*, i64 }* %t4
merge1:
  %t7 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t8 = load i32, i32* %t7
  %t9 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t10 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t11 = icmp eq i32 %t8, 0
  %t12 = select i1 %t11, i8* %t10, i8* %t9
  %t13 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t14 = icmp eq i32 %t8, 1
  %t15 = select i1 %t14, i8* %t13, i8* %t12
  %t16 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t17 = icmp eq i32 %t8, 2
  %t18 = select i1 %t17, i8* %t16, i8* %t15
  %t19 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t20 = icmp eq i32 %t8, 3
  %t21 = select i1 %t20, i8* %t19, i8* %t18
  %t22 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t23 = icmp eq i32 %t8, 4
  %t24 = select i1 %t23, i8* %t22, i8* %t21
  %t25 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t8, 5
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t8, 6
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t8, 7
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t8, 8
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t8, 9
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t8, 10
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t8, 11
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t8, 12
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %t49 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t50 = icmp eq i32 %t8, 13
  %t51 = select i1 %t50, i8* %t49, i8* %t48
  %t52 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t8, 14
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t8, 15
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %s58 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.58, i32 0, i32 0
  %t59 = icmp eq i8* %t57, %s58
  br i1 %t59, label %then2, label %merge3
then2:
  %t60 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t61 = load i32, i32* %t60
  %t62 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t63 = bitcast [16 x i8]* %t62 to i8*
  %t64 = bitcast i8* %t63 to %Expression**
  %t65 = load %Expression*, %Expression** %t64
  %t66 = icmp eq i32 %t61, 8
  %t67 = select i1 %t66, %Expression* %t65, %Expression* null
  %t68 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t67)
  store { %EffectRequirement*, i64 }* %t68, { %EffectRequirement*, i64 }** %l0
  %t69 = sitofp i64 0 to double
  store double %t69, double* %l1
  %t70 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t71 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t113 = phi { %EffectRequirement*, i64 }* [ %t70, %then2 ], [ %t111, %loop.latch6 ]
  %t114 = phi double [ %t71, %then2 ], [ %t112, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t113, { %EffectRequirement*, i64 }** %l0
  store double %t114, double* %l1
  br label %loop.body5
loop.body5:
  %t72 = load double, double* %l1
  %t73 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t74 = load i32, i32* %t73
  %t75 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t76 = bitcast [16 x i8]* %t75 to i8*
  %t77 = getelementptr inbounds i8, i8* %t76, i64 8
  %t78 = bitcast i8* %t77 to { %Expression**, i64 }**
  %t79 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t78
  %t80 = icmp eq i32 %t74, 8
  %t81 = select i1 %t80, { %Expression**, i64 }* %t79, { %Expression**, i64 }* null
  %t82 = load { %Expression**, i64 }, { %Expression**, i64 }* %t81
  %t83 = extractvalue { %Expression**, i64 } %t82, 1
  %t84 = sitofp i64 %t83 to double
  %t85 = fcmp oge double %t72, %t84
  %t86 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t87 = load double, double* %l1
  br i1 %t85, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t88 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t89 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t90 = load i32, i32* %t89
  %t91 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t92 = bitcast [16 x i8]* %t91 to i8*
  %t93 = getelementptr inbounds i8, i8* %t92, i64 8
  %t94 = bitcast i8* %t93 to { %Expression**, i64 }**
  %t95 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t94
  %t96 = icmp eq i32 %t90, 8
  %t97 = select i1 %t96, { %Expression**, i64 }* %t95, { %Expression**, i64 }* null
  %t98 = load double, double* %l1
  %t99 = fptosi double %t98 to i64
  %t100 = load { %Expression**, i64 }, { %Expression**, i64 }* %t97
  %t101 = extractvalue { %Expression**, i64 } %t100, 0
  %t102 = extractvalue { %Expression**, i64 } %t100, 1
  %t103 = icmp uge i64 %t99, %t102
  ; bounds check: %t103 (if true, out of bounds)
  %t104 = getelementptr %Expression*, %Expression** %t101, i64 %t99
  %t105 = load %Expression*, %Expression** %t104
  %t106 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t105)
  %t107 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t88, { %EffectRequirement*, i64 }* %t106)
  store { %EffectRequirement*, i64 }* %t107, { %EffectRequirement*, i64 }** %l0
  %t108 = load double, double* %l1
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  store double %t110, double* %l1
  br label %loop.latch6
loop.latch6:
  %t111 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t112 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t115 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t115
merge3:
  %t116 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t117 = load i32, i32* %t116
  %t118 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t119 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t117, 0
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t117, 1
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t117, 2
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t117, 3
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t117, 4
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t117, 5
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t117, 6
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t117, 7
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t117, 8
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t117, 9
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t117, 10
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t117, 11
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t117, 12
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t117, 13
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t117, 14
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t117, 15
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %s167 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.167, i32 0, i32 0
  %t168 = icmp eq i8* %t166, %s167
  br i1 %t168, label %then10, label %merge11
then10:
  %t169 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t170 = load i32, i32* %t169
  %t171 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t172 = bitcast [16 x i8]* %t171 to i8*
  %t173 = bitcast i8* %t172 to %Expression**
  %t174 = load %Expression*, %Expression** %t173
  %t175 = icmp eq i32 %t170, 7
  %t176 = select i1 %t175, %Expression* %t174, %Expression* null
  %t177 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t176)
  ret { %EffectRequirement*, i64 }* %t177
merge11:
  %t178 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t179 = load i32, i32* %t178
  %t180 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t181 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t179, 0
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t179, 1
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t179, 2
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t179, 3
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t179, 4
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t179, 5
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t179, 6
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t179, 7
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t179, 8
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t179, 9
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t179, 10
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t179, 11
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t179, 12
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t179, 13
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t179, 14
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t179, 15
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %s229 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.229, i32 0, i32 0
  %t230 = icmp eq i8* %t228, %s229
  br i1 %t230, label %then12, label %merge13
then12:
  %t231 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t232 = load i32, i32* %t231
  %t233 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t234 = bitcast [16 x i8]* %t233 to i8*
  %t235 = getelementptr inbounds i8, i8* %t234, i64 8
  %t236 = bitcast i8* %t235 to %Expression**
  %t237 = load %Expression*, %Expression** %t236
  %t238 = icmp eq i32 %t232, 5
  %t239 = select i1 %t238, %Expression* %t237, %Expression* null
  %t240 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t239)
  ret { %EffectRequirement*, i64 }* %t240
merge13:
  %t241 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t242 = load i32, i32* %t241
  %t243 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t244 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t245 = icmp eq i32 %t242, 0
  %t246 = select i1 %t245, i8* %t244, i8* %t243
  %t247 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t248 = icmp eq i32 %t242, 1
  %t249 = select i1 %t248, i8* %t247, i8* %t246
  %t250 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t251 = icmp eq i32 %t242, 2
  %t252 = select i1 %t251, i8* %t250, i8* %t249
  %t253 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t254 = icmp eq i32 %t242, 3
  %t255 = select i1 %t254, i8* %t253, i8* %t252
  %t256 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t257 = icmp eq i32 %t242, 4
  %t258 = select i1 %t257, i8* %t256, i8* %t255
  %t259 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t260 = icmp eq i32 %t242, 5
  %t261 = select i1 %t260, i8* %t259, i8* %t258
  %t262 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t263 = icmp eq i32 %t242, 6
  %t264 = select i1 %t263, i8* %t262, i8* %t261
  %t265 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t266 = icmp eq i32 %t242, 7
  %t267 = select i1 %t266, i8* %t265, i8* %t264
  %t268 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t269 = icmp eq i32 %t242, 8
  %t270 = select i1 %t269, i8* %t268, i8* %t267
  %t271 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t272 = icmp eq i32 %t242, 9
  %t273 = select i1 %t272, i8* %t271, i8* %t270
  %t274 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t275 = icmp eq i32 %t242, 10
  %t276 = select i1 %t275, i8* %t274, i8* %t273
  %t277 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t278 = icmp eq i32 %t242, 11
  %t279 = select i1 %t278, i8* %t277, i8* %t276
  %t280 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t281 = icmp eq i32 %t242, 12
  %t282 = select i1 %t281, i8* %t280, i8* %t279
  %t283 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t284 = icmp eq i32 %t242, 13
  %t285 = select i1 %t284, i8* %t283, i8* %t282
  %t286 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t287 = icmp eq i32 %t242, 14
  %t288 = select i1 %t287, i8* %t286, i8* %t285
  %t289 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t290 = icmp eq i32 %t242, 15
  %t291 = select i1 %t290, i8* %t289, i8* %t288
  %s292 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.292, i32 0, i32 0
  %t293 = icmp eq i8* %t291, %s292
  br i1 %t293, label %then14, label %merge15
then14:
  %t294 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t295 = load i32, i32* %t294
  %t296 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t297 = bitcast [24 x i8]* %t296 to i8*
  %t298 = getelementptr inbounds i8, i8* %t297, i64 8
  %t299 = bitcast i8* %t298 to %Expression**
  %t300 = load %Expression*, %Expression** %t299
  %t301 = icmp eq i32 %t295, 6
  %t302 = select i1 %t301, %Expression* %t300, %Expression* null
  %t303 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t302)
  store { %EffectRequirement*, i64 }* %t303, { %EffectRequirement*, i64 }** %l2
  %t304 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  %t305 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t306 = load i32, i32* %t305
  %t307 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t308 = bitcast [24 x i8]* %t307 to i8*
  %t309 = getelementptr inbounds i8, i8* %t308, i64 16
  %t310 = bitcast i8* %t309 to %Expression**
  %t311 = load %Expression*, %Expression** %t310
  %t312 = icmp eq i32 %t306, 6
  %t313 = select i1 %t312, %Expression* %t311, %Expression* null
  %t314 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t313)
  %t315 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t304, { %EffectRequirement*, i64 }* %t314)
  store { %EffectRequirement*, i64 }* %t315, { %EffectRequirement*, i64 }** %l2
  %t316 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  ret { %EffectRequirement*, i64 }* %t316
merge15:
  %t317 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t318 = load i32, i32* %t317
  %t319 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t320 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t318, 0
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t318, 1
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t318, 2
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t318, 3
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t318, 4
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t318, 5
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t318, 6
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t318, 7
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t318, 8
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t318, 9
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t318, 10
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t318, 11
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t318, 12
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t318, 13
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t318, 14
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t318, 15
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %s368 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.368, i32 0, i32 0
  %t369 = icmp eq i8* %t367, %s368
  br i1 %t369, label %then16, label %merge17
then16:
  %t370 = alloca [0 x %EffectRequirement]
  %t371 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t370, i32 0, i32 0
  %t372 = alloca { %EffectRequirement*, i64 }
  %t373 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t372, i32 0, i32 0
  store %EffectRequirement* %t371, %EffectRequirement** %t373
  %t374 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t372, i32 0, i32 1
  store i64 0, i64* %t374
  store { %EffectRequirement*, i64 }* %t372, { %EffectRequirement*, i64 }** %l3
  %t375 = sitofp i64 0 to double
  store double %t375, double* %l4
  %t376 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t377 = load double, double* %l4
  br label %loop.header18
loop.header18:
  %t417 = phi { %EffectRequirement*, i64 }* [ %t376, %then16 ], [ %t415, %loop.latch20 ]
  %t418 = phi double [ %t377, %then16 ], [ %t416, %loop.latch20 ]
  store { %EffectRequirement*, i64 }* %t417, { %EffectRequirement*, i64 }** %l3
  store double %t418, double* %l4
  br label %loop.body19
loop.body19:
  %t378 = load double, double* %l4
  %t379 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t380 = load i32, i32* %t379
  %t381 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t382 = bitcast [8 x i8]* %t381 to i8*
  %t383 = bitcast i8* %t382 to { %Expression**, i64 }**
  %t384 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t383
  %t385 = icmp eq i32 %t380, 10
  %t386 = select i1 %t385, { %Expression**, i64 }* %t384, { %Expression**, i64 }* null
  %t387 = load { %Expression**, i64 }, { %Expression**, i64 }* %t386
  %t388 = extractvalue { %Expression**, i64 } %t387, 1
  %t389 = sitofp i64 %t388 to double
  %t390 = fcmp oge double %t378, %t389
  %t391 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t392 = load double, double* %l4
  br i1 %t390, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t393 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t394 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t395 = load i32, i32* %t394
  %t396 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t397 = bitcast [8 x i8]* %t396 to i8*
  %t398 = bitcast i8* %t397 to { %Expression**, i64 }**
  %t399 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t398
  %t400 = icmp eq i32 %t395, 10
  %t401 = select i1 %t400, { %Expression**, i64 }* %t399, { %Expression**, i64 }* null
  %t402 = load double, double* %l4
  %t403 = fptosi double %t402 to i64
  %t404 = load { %Expression**, i64 }, { %Expression**, i64 }* %t401
  %t405 = extractvalue { %Expression**, i64 } %t404, 0
  %t406 = extractvalue { %Expression**, i64 } %t404, 1
  %t407 = icmp uge i64 %t403, %t406
  ; bounds check: %t407 (if true, out of bounds)
  %t408 = getelementptr %Expression*, %Expression** %t405, i64 %t403
  %t409 = load %Expression*, %Expression** %t408
  %t410 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t409)
  %t411 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t393, { %EffectRequirement*, i64 }* %t410)
  store { %EffectRequirement*, i64 }* %t411, { %EffectRequirement*, i64 }** %l3
  %t412 = load double, double* %l4
  %t413 = sitofp i64 1 to double
  %t414 = fadd double %t412, %t413
  store double %t414, double* %l4
  br label %loop.latch20
loop.latch20:
  %t415 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t416 = load double, double* %l4
  br label %loop.header18
afterloop21:
  %t419 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  ret { %EffectRequirement*, i64 }* %t419
merge17:
  %t420 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t421 = load i32, i32* %t420
  %t422 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t423 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t424 = icmp eq i32 %t421, 0
  %t425 = select i1 %t424, i8* %t423, i8* %t422
  %t426 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t427 = icmp eq i32 %t421, 1
  %t428 = select i1 %t427, i8* %t426, i8* %t425
  %t429 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t430 = icmp eq i32 %t421, 2
  %t431 = select i1 %t430, i8* %t429, i8* %t428
  %t432 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t433 = icmp eq i32 %t421, 3
  %t434 = select i1 %t433, i8* %t432, i8* %t431
  %t435 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t436 = icmp eq i32 %t421, 4
  %t437 = select i1 %t436, i8* %t435, i8* %t434
  %t438 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t439 = icmp eq i32 %t421, 5
  %t440 = select i1 %t439, i8* %t438, i8* %t437
  %t441 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t442 = icmp eq i32 %t421, 6
  %t443 = select i1 %t442, i8* %t441, i8* %t440
  %t444 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t445 = icmp eq i32 %t421, 7
  %t446 = select i1 %t445, i8* %t444, i8* %t443
  %t447 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t448 = icmp eq i32 %t421, 8
  %t449 = select i1 %t448, i8* %t447, i8* %t446
  %t450 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t451 = icmp eq i32 %t421, 9
  %t452 = select i1 %t451, i8* %t450, i8* %t449
  %t453 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t454 = icmp eq i32 %t421, 10
  %t455 = select i1 %t454, i8* %t453, i8* %t452
  %t456 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t457 = icmp eq i32 %t421, 11
  %t458 = select i1 %t457, i8* %t456, i8* %t455
  %t459 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t460 = icmp eq i32 %t421, 12
  %t461 = select i1 %t460, i8* %t459, i8* %t458
  %t462 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t463 = icmp eq i32 %t421, 13
  %t464 = select i1 %t463, i8* %t462, i8* %t461
  %t465 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t466 = icmp eq i32 %t421, 14
  %t467 = select i1 %t466, i8* %t465, i8* %t464
  %t468 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t469 = icmp eq i32 %t421, 15
  %t470 = select i1 %t469, i8* %t468, i8* %t467
  %s471 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.471, i32 0, i32 0
  %t472 = icmp eq i8* %t470, %s471
  br i1 %t472, label %then24, label %merge25
then24:
  %t473 = alloca [0 x %EffectRequirement]
  %t474 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t473, i32 0, i32 0
  %t475 = alloca { %EffectRequirement*, i64 }
  %t476 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t475, i32 0, i32 0
  store %EffectRequirement* %t474, %EffectRequirement** %t476
  %t477 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t475, i32 0, i32 1
  store i64 0, i64* %t477
  store { %EffectRequirement*, i64 }* %t475, { %EffectRequirement*, i64 }** %l5
  %t478 = sitofp i64 0 to double
  store double %t478, double* %l6
  %t479 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t480 = load double, double* %l6
  br label %loop.header26
loop.header26:
  %t537 = phi { %EffectRequirement*, i64 }* [ %t479, %then24 ], [ %t535, %loop.latch28 ]
  %t538 = phi double [ %t480, %then24 ], [ %t536, %loop.latch28 ]
  store { %EffectRequirement*, i64 }* %t537, { %EffectRequirement*, i64 }** %l5
  store double %t538, double* %l6
  br label %loop.body27
loop.body27:
  %t481 = load double, double* %l6
  %t482 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t483 = load i32, i32* %t482
  %t484 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t485 = bitcast [8 x i8]* %t484 to i8*
  %t486 = bitcast i8* %t485 to { %ObjectField**, i64 }**
  %t487 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t486
  %t488 = icmp eq i32 %t483, 11
  %t489 = select i1 %t488, { %ObjectField**, i64 }* %t487, { %ObjectField**, i64 }* null
  %t490 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t491 = bitcast [16 x i8]* %t490 to i8*
  %t492 = getelementptr inbounds i8, i8* %t491, i64 8
  %t493 = bitcast i8* %t492 to { %ObjectField**, i64 }**
  %t494 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t493
  %t495 = icmp eq i32 %t483, 12
  %t496 = select i1 %t495, { %ObjectField**, i64 }* %t494, { %ObjectField**, i64 }* %t489
  %t497 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t496
  %t498 = extractvalue { %ObjectField**, i64 } %t497, 1
  %t499 = sitofp i64 %t498 to double
  %t500 = fcmp oge double %t481, %t499
  %t501 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t502 = load double, double* %l6
  br i1 %t500, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t503 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t504 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t505 = load i32, i32* %t504
  %t506 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t507 = bitcast [8 x i8]* %t506 to i8*
  %t508 = bitcast i8* %t507 to { %ObjectField**, i64 }**
  %t509 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t508
  %t510 = icmp eq i32 %t505, 11
  %t511 = select i1 %t510, { %ObjectField**, i64 }* %t509, { %ObjectField**, i64 }* null
  %t512 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t513 = bitcast [16 x i8]* %t512 to i8*
  %t514 = getelementptr inbounds i8, i8* %t513, i64 8
  %t515 = bitcast i8* %t514 to { %ObjectField**, i64 }**
  %t516 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t515
  %t517 = icmp eq i32 %t505, 12
  %t518 = select i1 %t517, { %ObjectField**, i64 }* %t516, { %ObjectField**, i64 }* %t511
  %t519 = load double, double* %l6
  %t520 = fptosi double %t519 to i64
  %t521 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t518
  %t522 = extractvalue { %ObjectField**, i64 } %t521, 0
  %t523 = extractvalue { %ObjectField**, i64 } %t521, 1
  %t524 = icmp uge i64 %t520, %t523
  ; bounds check: %t524 (if true, out of bounds)
  %t525 = getelementptr %ObjectField*, %ObjectField** %t522, i64 %t520
  %t526 = load %ObjectField*, %ObjectField** %t525
  %t527 = getelementptr %ObjectField, %ObjectField* %t526, i32 0, i32 1
  %t528 = load %Expression, %Expression* %t527
  %t529 = alloca %Expression
  store %Expression %t528, %Expression* %t529
  %t530 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t529)
  %t531 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t503, { %EffectRequirement*, i64 }* %t530)
  store { %EffectRequirement*, i64 }* %t531, { %EffectRequirement*, i64 }** %l5
  %t532 = load double, double* %l6
  %t533 = sitofp i64 1 to double
  %t534 = fadd double %t532, %t533
  store double %t534, double* %l6
  br label %loop.latch28
loop.latch28:
  %t535 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t536 = load double, double* %l6
  br label %loop.header26
afterloop29:
  %t539 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t539
merge25:
  %t540 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t541 = load i32, i32* %t540
  %t542 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t543 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t541, 0
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t541, 1
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t541, 2
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t541, 3
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t541, 4
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t541, 5
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t541, 6
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t541, 7
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t541, 8
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t541, 9
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %t573 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t574 = icmp eq i32 %t541, 10
  %t575 = select i1 %t574, i8* %t573, i8* %t572
  %t576 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t577 = icmp eq i32 %t541, 11
  %t578 = select i1 %t577, i8* %t576, i8* %t575
  %t579 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t580 = icmp eq i32 %t541, 12
  %t581 = select i1 %t580, i8* %t579, i8* %t578
  %t582 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t583 = icmp eq i32 %t541, 13
  %t584 = select i1 %t583, i8* %t582, i8* %t581
  %t585 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t586 = icmp eq i32 %t541, 14
  %t587 = select i1 %t586, i8* %t585, i8* %t584
  %t588 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t589 = icmp eq i32 %t541, 15
  %t590 = select i1 %t589, i8* %t588, i8* %t587
  %s591 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.591, i32 0, i32 0
  %t592 = icmp eq i8* %t590, %s591
  br i1 %t592, label %then32, label %merge33
then32:
  %t593 = alloca [0 x %EffectRequirement]
  %t594 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t593, i32 0, i32 0
  %t595 = alloca { %EffectRequirement*, i64 }
  %t596 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t595, i32 0, i32 0
  store %EffectRequirement* %t594, %EffectRequirement** %t596
  %t597 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t595, i32 0, i32 1
  store i64 0, i64* %t597
  store { %EffectRequirement*, i64 }* %t595, { %EffectRequirement*, i64 }** %l7
  %t598 = sitofp i64 0 to double
  store double %t598, double* %l8
  %t599 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t600 = load double, double* %l8
  br label %loop.header34
loop.header34:
  %t657 = phi { %EffectRequirement*, i64 }* [ %t599, %then32 ], [ %t655, %loop.latch36 ]
  %t658 = phi double [ %t600, %then32 ], [ %t656, %loop.latch36 ]
  store { %EffectRequirement*, i64 }* %t657, { %EffectRequirement*, i64 }** %l7
  store double %t658, double* %l8
  br label %loop.body35
loop.body35:
  %t601 = load double, double* %l8
  %t602 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t603 = load i32, i32* %t602
  %t604 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t605 = bitcast [8 x i8]* %t604 to i8*
  %t606 = bitcast i8* %t605 to { %ObjectField**, i64 }**
  %t607 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t606
  %t608 = icmp eq i32 %t603, 11
  %t609 = select i1 %t608, { %ObjectField**, i64 }* %t607, { %ObjectField**, i64 }* null
  %t610 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t611 = bitcast [16 x i8]* %t610 to i8*
  %t612 = getelementptr inbounds i8, i8* %t611, i64 8
  %t613 = bitcast i8* %t612 to { %ObjectField**, i64 }**
  %t614 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t613
  %t615 = icmp eq i32 %t603, 12
  %t616 = select i1 %t615, { %ObjectField**, i64 }* %t614, { %ObjectField**, i64 }* %t609
  %t617 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t616
  %t618 = extractvalue { %ObjectField**, i64 } %t617, 1
  %t619 = sitofp i64 %t618 to double
  %t620 = fcmp oge double %t601, %t619
  %t621 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t622 = load double, double* %l8
  br i1 %t620, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t623 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t624 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t625 = load i32, i32* %t624
  %t626 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t627 = bitcast [8 x i8]* %t626 to i8*
  %t628 = bitcast i8* %t627 to { %ObjectField**, i64 }**
  %t629 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t628
  %t630 = icmp eq i32 %t625, 11
  %t631 = select i1 %t630, { %ObjectField**, i64 }* %t629, { %ObjectField**, i64 }* null
  %t632 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t633 = bitcast [16 x i8]* %t632 to i8*
  %t634 = getelementptr inbounds i8, i8* %t633, i64 8
  %t635 = bitcast i8* %t634 to { %ObjectField**, i64 }**
  %t636 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t635
  %t637 = icmp eq i32 %t625, 12
  %t638 = select i1 %t637, { %ObjectField**, i64 }* %t636, { %ObjectField**, i64 }* %t631
  %t639 = load double, double* %l8
  %t640 = fptosi double %t639 to i64
  %t641 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t638
  %t642 = extractvalue { %ObjectField**, i64 } %t641, 0
  %t643 = extractvalue { %ObjectField**, i64 } %t641, 1
  %t644 = icmp uge i64 %t640, %t643
  ; bounds check: %t644 (if true, out of bounds)
  %t645 = getelementptr %ObjectField*, %ObjectField** %t642, i64 %t640
  %t646 = load %ObjectField*, %ObjectField** %t645
  %t647 = getelementptr %ObjectField, %ObjectField* %t646, i32 0, i32 1
  %t648 = load %Expression, %Expression* %t647
  %t649 = alloca %Expression
  store %Expression %t648, %Expression* %t649
  %t650 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t649)
  %t651 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t623, { %EffectRequirement*, i64 }* %t650)
  store { %EffectRequirement*, i64 }* %t651, { %EffectRequirement*, i64 }** %l7
  %t652 = load double, double* %l8
  %t653 = sitofp i64 1 to double
  %t654 = fadd double %t652, %t653
  store double %t654, double* %l8
  br label %loop.latch36
loop.latch36:
  %t655 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t656 = load double, double* %l8
  br label %loop.header34
afterloop37:
  %t659 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t659
merge33:
  %t660 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t661 = load i32, i32* %t660
  %t662 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t663 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t664 = icmp eq i32 %t661, 0
  %t665 = select i1 %t664, i8* %t663, i8* %t662
  %t666 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t667 = icmp eq i32 %t661, 1
  %t668 = select i1 %t667, i8* %t666, i8* %t665
  %t669 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t670 = icmp eq i32 %t661, 2
  %t671 = select i1 %t670, i8* %t669, i8* %t668
  %t672 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t673 = icmp eq i32 %t661, 3
  %t674 = select i1 %t673, i8* %t672, i8* %t671
  %t675 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t676 = icmp eq i32 %t661, 4
  %t677 = select i1 %t676, i8* %t675, i8* %t674
  %t678 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t679 = icmp eq i32 %t661, 5
  %t680 = select i1 %t679, i8* %t678, i8* %t677
  %t681 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t682 = icmp eq i32 %t661, 6
  %t683 = select i1 %t682, i8* %t681, i8* %t680
  %t684 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t661, 7
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t661, 8
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t661, 9
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t661, 10
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t661, 11
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t661, 12
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t661, 13
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t661, 14
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t661, 15
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %s711 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.711, i32 0, i32 0
  %t712 = icmp eq i8* %t710, %s711
  br i1 %t712, label %then40, label %merge41
then40:
  %t713 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t714 = load i32, i32* %t713
  %t715 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t716 = bitcast [24 x i8]* %t715 to i8*
  %t717 = getelementptr inbounds i8, i8* %t716, i64 8
  %t718 = bitcast i8* %t717 to %Block*
  %t719 = load %Block, %Block* %t718
  %t720 = icmp eq i32 %t714, 13
  %t721 = select i1 %t720, %Block %t719, %Block zeroinitializer
  %t722 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t721)
  ret { %EffectRequirement*, i64 }* %t722
merge41:
  %t723 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t724 = load i32, i32* %t723
  %t725 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t726 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t724, 0
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t724, 1
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t724, 2
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t724, 3
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t724, 4
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t724, 5
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t724, 6
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t724, 7
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t724, 8
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t724, 9
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %t756 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t757 = icmp eq i32 %t724, 10
  %t758 = select i1 %t757, i8* %t756, i8* %t755
  %t759 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t724, 11
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t724, 12
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %t765 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t724, 13
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t724, 14
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t724, 15
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %s774 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.774, i32 0, i32 0
  %t775 = icmp eq i8* %t773, %s774
  br i1 %t775, label %then42, label %merge43
then42:
  %t776 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t777 = load i32, i32* %t776
  %t778 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t779 = bitcast [16 x i8]* %t778 to i8*
  %t780 = bitcast i8* %t779 to %Expression**
  %t781 = load %Expression*, %Expression** %t780
  %t782 = icmp eq i32 %t777, 9
  %t783 = select i1 %t782, %Expression* %t781, %Expression* null
  %t784 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t783)
  store { %EffectRequirement*, i64 }* %t784, { %EffectRequirement*, i64 }** %l9
  %t785 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t786 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t787 = load i32, i32* %t786
  %t788 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t789 = bitcast [16 x i8]* %t788 to i8*
  %t790 = getelementptr inbounds i8, i8* %t789, i64 8
  %t791 = bitcast i8* %t790 to %Expression**
  %t792 = load %Expression*, %Expression** %t791
  %t793 = icmp eq i32 %t787, 9
  %t794 = select i1 %t793, %Expression* %t792, %Expression* null
  %t795 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t794)
  %t796 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t785, { %EffectRequirement*, i64 }* %t795)
  store { %EffectRequirement*, i64 }* %t796, { %EffectRequirement*, i64 }** %l9
  %t797 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t797
merge43:
  %t798 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t799 = load i32, i32* %t798
  %t800 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t801 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t799, 0
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t799, 1
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t799, 2
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t799, 3
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t799, 4
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t799, 5
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t799, 6
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t799, 7
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t799, 8
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t799, 9
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t799, 10
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t799, 11
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t799, 12
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %t840 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t799, 13
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t799, 14
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t799, 15
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %s849 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.849, i32 0, i32 0
  %t850 = icmp eq i8* %t848, %s849
  br i1 %t850, label %then44, label %merge45
then44:
  %t851 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t852 = load i32, i32* %t851
  %t853 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t854 = bitcast [16 x i8]* %t853 to i8*
  %t855 = bitcast i8* %t854 to %Expression**
  %t856 = load %Expression*, %Expression** %t855
  %t857 = icmp eq i32 %t852, 14
  %t858 = select i1 %t857, %Expression* %t856, %Expression* null
  %t859 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t858)
  store { %EffectRequirement*, i64 }* %t859, { %EffectRequirement*, i64 }** %l10
  %t860 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t861 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t862 = load i32, i32* %t861
  %t863 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t864 = bitcast [16 x i8]* %t863 to i8*
  %t865 = getelementptr inbounds i8, i8* %t864, i64 8
  %t866 = bitcast i8* %t865 to %Expression**
  %t867 = load %Expression*, %Expression** %t866
  %t868 = icmp eq i32 %t862, 14
  %t869 = select i1 %t868, %Expression* %t867, %Expression* null
  %t870 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t869)
  %t871 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t860, { %EffectRequirement*, i64 }* %t870)
  store { %EffectRequirement*, i64 }* %t871, { %EffectRequirement*, i64 }** %l10
  %t872 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t872
merge45:
  %t873 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t874 = load i32, i32* %t873
  %t875 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t876 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t874, 0
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t874, 1
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t874, 2
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t874, 3
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t874, 4
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t874, 5
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t874, 6
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t874, 7
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t874, 8
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t874, 9
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t874, 10
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t874, 11
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t874, 12
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t874, 13
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t874, 14
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t874, 15
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %s924 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.924, i32 0, i32 0
  %t925 = icmp eq i8* %t923, %s924
  br i1 %t925, label %then46, label %merge47
then46:
  %t926 = alloca [0 x %EffectRequirement]
  %t927 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t926, i32 0, i32 0
  %t928 = alloca { %EffectRequirement*, i64 }
  %t929 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t928, i32 0, i32 0
  store %EffectRequirement* %t927, %EffectRequirement** %t929
  %t930 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t928, i32 0, i32 1
  store i64 0, i64* %t930
  ret { %EffectRequirement*, i64 }* %t928
merge47:
  %t931 = alloca [0 x %EffectRequirement]
  %t932 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t931, i32 0, i32 0
  %t933 = alloca { %EffectRequirement*, i64 }
  %t934 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t933, i32 0, i32 0
  store %EffectRequirement* %t932, %EffectRequirement** %t934
  %t935 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t933, i32 0, i32 1
  store i64 0, i64* %t935
  ret { %EffectRequirement*, i64 }* %t933
}

define { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = alloca [0 x %EffectRequirement]
  %t1 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t0, i32 0, i32 0
  %t2 = alloca { %EffectRequirement*, i64 }
  %t3 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2, i32 0, i32 0
  store %EffectRequirement* %t1, %EffectRequirement** %t3
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %EffectRequirement*, i64 }* %t2, { %EffectRequirement*, i64 }** %l0
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t6 = call { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %t5, { %Token*, i64 }* %tokens)
  store { %EffectRequirement*, i64 }* %t6, { %EffectRequirement*, i64 }** %l0
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  %s9 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.9, i32 0, i32 0
  %s10 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.10, i32 0, i32 0
  %t11 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t7, { %Token*, i64 }* %tokens, i8* %s8, i8* %s9, i8* %s10)
  store { %EffectRequirement*, i64 }* %t11, { %EffectRequirement*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %s15 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.15, i32 0, i32 0
  %t16 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t12, { %Token*, i64 }* %tokens, i8* %s13, i8* %s14, i8* %s15)
  store { %EffectRequirement*, i64 }* %t16, { %EffectRequirement*, i64 }** %l0
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s18 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.18, i32 0, i32 0
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.19, i32 0, i32 0
  %s20 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.20, i32 0, i32 0
  %t21 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t17, { %Token*, i64 }* %tokens, i8* %s18, i8* %s19, i8* %s20)
  store { %EffectRequirement*, i64 }* %t21, { %EffectRequirement*, i64 }** %l0
  %t22 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s23 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.23, i32 0, i32 0
  %s24 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.24, i32 0, i32 0
  %s25 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.25, i32 0, i32 0
  %t26 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t22, { %Token*, i64 }* %tokens, i8* %s23, i8* %s24, i8* %s25)
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l0
  %t27 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s28 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.28, i32 0, i32 0
  %s29 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.29, i32 0, i32 0
  %s30 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.30, i32 0, i32 0
  %t31 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t27, { %Token*, i64 }* %tokens, i8* %s28, i8* %s29, i8* %s30)
  store { %EffectRequirement*, i64 }* %t31, { %EffectRequirement*, i64 }** %l0
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s33 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.33, i32 0, i32 0
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.34, i32 0, i32 0
  %s35 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.35, i32 0, i32 0
  %t36 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t32, { %Token*, i64 }* %tokens, i8* %s33, i8* %s34, i8* %s35)
  store { %EffectRequirement*, i64 }* %t36, { %EffectRequirement*, i64 }** %l0
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s38 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.38, i32 0, i32 0
  %s39 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.39, i32 0, i32 0
  %s40 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.40, i32 0, i32 0
  %t41 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t37, { %Token*, i64 }* %tokens, i8* %s38, i8* %s39, i8* %s40)
  store { %EffectRequirement*, i64 }* %t41, { %EffectRequirement*, i64 }** %l0
  %t42 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s43 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.43, i32 0, i32 0
  %s44 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.44, i32 0, i32 0
  %s45 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.45, i32 0, i32 0
  %t46 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t42, { %Token*, i64 }* %tokens, i8* %s43, i8* %s44, i8* %s45)
  store { %EffectRequirement*, i64 }* %t46, { %EffectRequirement*, i64 }** %l0
  %t47 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t47
}

define { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens) {
entry:
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
  %t181 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t179, %loop.latch2 ]
  %t182 = phi double [ %t2, %entry ], [ %t180, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t181, { %EffectRequirement*, i64 }** %l0
  store double %t182, double* %l1
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
  %t16 = getelementptr %Token, %Token* %t13, i64 %t11
  %t17 = load %Token, %Token* %t16
  store %Token %t17, %Token* %l2
  %t18 = load %Token, %Token* %l2
  %s19 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.19, i32 0, i32 0
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
  %s28 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.28, i32 0, i32 0
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
  %s74 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.74, i32 0, i32 0
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
  %s104 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.104, i32 0, i32 0
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
  %s113 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.113, i32 0, i32 0
  %t114 = load %Token, %Token* %l5
  %t115 = extractvalue %Token %t114, 1
  %t116 = add i8* %s113, %t115
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
  %s147 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.147, i32 0, i32 0
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
  br label %merge11
merge11:
  %t158 = phi i8* [ %t116, %then10 ], [ %t111, %then8 ]
  %t159 = phi { %EffectRequirement*, i64 }* [ %t154, %then10 ], [ %t107, %then8 ]
  %t160 = phi double [ %t157, %then10 ], [ %t108, %then8 ]
  store i8* %t158, i8** %l4
  store { %EffectRequirement*, i64 }* %t159, { %EffectRequirement*, i64 }** %l0
  store double %t160, double* %l1
  br label %merge9
merge9:
  %t161 = phi i8* [ %t116, %then8 ], [ %t36, %then6 ]
  %t162 = phi { %EffectRequirement*, i64 }* [ %t154, %then8 ], [ %t32, %then6 ]
  %t163 = phi double [ %t157, %then8 ], [ %t33, %then6 ]
  store i8* %t161, i8** %l4
  store { %EffectRequirement*, i64 }* %t162, { %EffectRequirement*, i64 }** %l0
  store double %t163, double* %l1
  %t164 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s165 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.165, i32 0, i32 0
  %t166 = insertvalue %EffectRequirement undef, i8* %s165, 0
  %t167 = load %Token, %Token* %l2
  %t168 = alloca %Token
  store %Token %t167, %Token* %t168
  %t169 = insertvalue %EffectRequirement %t166, %Token* %t168, 1
  %t170 = load i8*, i8** %l4
  %t171 = insertvalue %EffectRequirement %t169, i8* %t170, 2
  %t172 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t164, %EffectRequirement %t171)
  store { %EffectRequirement*, i64 }* %t172, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t173 = phi { %EffectRequirement*, i64 }* [ %t154, %then6 ], [ %t21, %loop.body1 ]
  %t174 = phi double [ %t157, %then6 ], [ %t22, %loop.body1 ]
  %t175 = phi { %EffectRequirement*, i64 }* [ %t172, %then6 ], [ %t21, %loop.body1 ]
  store { %EffectRequirement*, i64 }* %t173, { %EffectRequirement*, i64 }** %l0
  store double %t174, double* %l1
  store { %EffectRequirement*, i64 }* %t175, { %EffectRequirement*, i64 }** %l0
  %t176 = load double, double* %l1
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l1
  br label %loop.latch2
loop.latch2:
  %t179 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t180 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t183 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t183
}

define { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
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
  %t38 = phi { %EffectRequirement*, i64 }* [ %t7, %entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t8, %entry ], [ %t37, %loop.latch2 ]
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
  ret { %EffectRequirement*, i64 }* %t40
}

define { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
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
  %t34 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t4, %entry ], [ %t33, %loop.latch2 ]
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
  ret { %EffectRequirement*, i64 }* %t36
}

define { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }* %tokens, i8* %name, i8* %symbol) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t73 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t71, %loop.latch2 ]
  %t74 = phi double [ %t7, %entry ], [ %t72, %loop.latch2 ]
  store { %Token*, i64 }* %t73, { %Token*, i64 }** %l0
  store double %t74, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t18 = extractvalue { %Token*, i64 } %t17, 0
  %t19 = extractvalue { %Token*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %Token, %Token* %t18, i64 %t16
  %t22 = load %Token, %Token* %t21
  %t23 = call i1 @is_identifier_token(%Token %t22, i8* %name)
  %t24 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  %t29 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t28)
  store double %t29, double* %l2
  %t31 = load double, double* %l2
  %t32 = sitofp i64 -1 to double
  %t33 = fcmp une double %t31, %t32
  br label %logical_and_entry_30

logical_and_entry_30:
  br i1 %t33, label %logical_and_right_30, label %logical_and_merge_30

logical_and_right_30:
  %t34 = load double, double* %l2
  %t35 = fptosi double %t34 to i64
  %t36 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t37 = extractvalue { %Token*, i64 } %t36, 0
  %t38 = extractvalue { %Token*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr %Token, %Token* %t37, i64 %t35
  %t41 = load %Token, %Token* %t40
  %t42 = call i1 @is_symbol_token(%Token %t41, i8* %symbol)
  br label %logical_and_right_end_30

logical_and_right_end_30:
  br label %logical_and_merge_30

logical_and_merge_30:
  %t43 = phi i1 [ false, %logical_and_entry_30 ], [ %t42, %logical_and_right_end_30 ]
  %t44 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  br i1 %t43, label %then8, label %merge9
then8:
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = fptosi double %t48 to i64
  %t50 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t51 = extractvalue { %Token*, i64 } %t50, 0
  %t52 = extractvalue { %Token*, i64 } %t50, 1
  %t53 = icmp uge i64 %t49, %t52
  ; bounds check: %t53 (if true, out of bounds)
  %t54 = getelementptr %Token, %Token* %t51, i64 %t49
  %t55 = load %Token, %Token* %t54
  %t56 = alloca [1 x %Token]
  %t57 = getelementptr [1 x %Token], [1 x %Token]* %t56, i32 0, i32 0
  %t58 = getelementptr %Token, %Token* %t57, i64 0
  store %Token %t55, %Token* %t58
  %t59 = alloca { %Token*, i64 }
  %t60 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t59, i32 0, i32 0
  store %Token* %t57, %Token** %t60
  %t61 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t59, i32 0, i32 1
  store i64 1, i64* %t61
  %t62 = bitcast { %Token*, i64 }* %t47 to { i8**, i64 }*
  %t63 = bitcast { %Token*, i64 }* %t59 to { i8**, i64 }*
  %t64 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t62, { i8**, i64 }* %t63)
  %t65 = bitcast { i8**, i64 }* %t64 to { %Token*, i64 }*
  store { %Token*, i64 }* %t65, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t66 = phi { %Token*, i64 }* [ %t65, %then8 ], [ %t44, %then6 ]
  store { %Token*, i64 }* %t66, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t67 = phi { %Token*, i64 }* [ %t65, %then6 ], [ %t24, %loop.body1 ]
  store { %Token*, i64 }* %t67, { %Token*, i64 }** %l0
  %t68 = load double, double* %l1
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l1
  br label %loop.latch2
loop.latch2:
  %t71 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t72 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t75 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t75
}

define { %Token*, i64 }* @find_identifier_call({ %Token*, i64 }* %tokens, i8* %name) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t77 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t75, %loop.latch2 ]
  %t78 = phi double [ %t7, %entry ], [ %t76, %loop.latch2 ]
  store { %Token*, i64 }* %t77, { %Token*, i64 }** %l0
  store double %t78, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t18 = extractvalue { %Token*, i64 } %t17, 0
  %t19 = extractvalue { %Token*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %Token, %Token* %t18, i64 %t16
  %t22 = load %Token, %Token* %t21
  %t23 = call i1 @is_identifier_token(%Token %t22, i8* %name)
  %t24 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  %t29 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t28)
  store double %t29, double* %l2
  %t31 = load double, double* %l2
  %t32 = sitofp i64 -1 to double
  %t33 = fcmp une double %t31, %t32
  br label %logical_and_entry_30

logical_and_entry_30:
  br i1 %t33, label %logical_and_right_30, label %logical_and_merge_30

logical_and_right_30:
  %t34 = load double, double* %l2
  %t35 = fptosi double %t34 to i64
  %t36 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t37 = extractvalue { %Token*, i64 } %t36, 0
  %t38 = extractvalue { %Token*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr %Token, %Token* %t37, i64 %t35
  %t41 = load %Token, %Token* %t40
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 40, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call i1 @is_symbol_token(%Token %t41, i8* %t45)
  br label %logical_and_right_end_30

logical_and_right_end_30:
  br label %logical_and_merge_30

logical_and_merge_30:
  %t47 = phi i1 [ false, %logical_and_entry_30 ], [ %t46, %logical_and_right_end_30 ]
  %t48 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  br i1 %t47, label %then8, label %merge9
then8:
  %t51 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = fptosi double %t52 to i64
  %t54 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t55 = extractvalue { %Token*, i64 } %t54, 0
  %t56 = extractvalue { %Token*, i64 } %t54, 1
  %t57 = icmp uge i64 %t53, %t56
  ; bounds check: %t57 (if true, out of bounds)
  %t58 = getelementptr %Token, %Token* %t55, i64 %t53
  %t59 = load %Token, %Token* %t58
  %t60 = alloca [1 x %Token]
  %t61 = getelementptr [1 x %Token], [1 x %Token]* %t60, i32 0, i32 0
  %t62 = getelementptr %Token, %Token* %t61, i64 0
  store %Token %t59, %Token* %t62
  %t63 = alloca { %Token*, i64 }
  %t64 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t63, i32 0, i32 0
  store %Token* %t61, %Token** %t64
  %t65 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t63, i32 0, i32 1
  store i64 1, i64* %t65
  %t66 = bitcast { %Token*, i64 }* %t51 to { i8**, i64 }*
  %t67 = bitcast { %Token*, i64 }* %t63 to { i8**, i64 }*
  %t68 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t66, { i8**, i64 }* %t67)
  %t69 = bitcast { i8**, i64 }* %t68 to { %Token*, i64 }*
  store { %Token*, i64 }* %t69, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t70 = phi { %Token*, i64 }* [ %t69, %then8 ], [ %t48, %then6 ]
  store { %Token*, i64 }* %t70, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t71 = phi { %Token*, i64 }* [ %t69, %then6 ], [ %t24, %loop.body1 ]
  store { %Token*, i64 }* %t71, { %Token*, i64 }** %l0
  %t72 = load double, double* %l1
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l1
  br label %loop.latch2
loop.latch2:
  %t75 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t76 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t79 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t79
}

define double @next_non_trivia({ %Token*, i64 }* %tokens, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca %Token
  store double %start, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t0, %entry ], [ %t24, %loop.latch2 ]
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
  %t26 = sitofp i64 -1 to double
  ret double %t26
}

define i1 @is_trivia_token(%Token %token) {
entry:
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
  %s28 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.28, i32 0, i32 0
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
  %s57 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.57, i32 0, i32 0
  %t58 = icmp eq i8* %t56, %s57
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t59 = phi i1 [ true, %logical_or_entry_0 ], [ %t58, %logical_or_right_end_0 ]
  ret i1 %t59
}

define i1 @is_identifier_token(%Token %token, i8* %expected) {
entry:
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
  %s27 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.27, i32 0, i32 0
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
entry:
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
  %s27 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.27, i32 0, i32 0
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
entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  store { %EffectViolation*, i64 }* %violations, { %EffectViolation*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t34 = phi { %EffectViolation*, i64 }* [ %t1, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t2, %entry ], [ %t33, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t34, { %EffectViolation*, i64 }** %l0
  store double %t35, double* %l1
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
  %t17 = getelementptr %EffectViolation, %EffectViolation* %t14, i64 %t12
  %t18 = load %EffectViolation, %EffectViolation* %t17
  %t19 = alloca [1 x %EffectViolation]
  %t20 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* %t19, i32 0, i32 0
  %t21 = getelementptr %EffectViolation, %EffectViolation* %t20, i64 0
  store %EffectViolation %t18, %EffectViolation* %t21
  %t22 = alloca { %EffectViolation*, i64 }
  %t23 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t22, i32 0, i32 0
  store %EffectViolation* %t20, %EffectViolation** %t23
  %t24 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t22, i32 0, i32 1
  store i64 1, i64* %t24
  %t25 = bitcast { %EffectViolation*, i64 }* %t10 to { i8**, i64 }*
  %t26 = bitcast { %EffectViolation*, i64 }* %t22 to { i8**, i64 }*
  %t27 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t25, { i8**, i64 }* %t26)
  %t28 = bitcast { i8**, i64 }* %t27 to { %EffectViolation*, i64 }*
  store { %EffectViolation*, i64 }* %t28, { %EffectViolation*, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch2
loop.latch2:
  %t32 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t36 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t36
}

define { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %collection, %EffectViolation %item) {
entry:
  %t0 = alloca [1 x %EffectViolation]
  %t1 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* %t0, i32 0, i32 0
  %t2 = getelementptr %EffectViolation, %EffectViolation* %t1, i64 0
  store %EffectViolation %item, %EffectViolation* %t2
  %t3 = alloca { %EffectViolation*, i64 }
  %t4 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t3, i32 0, i32 0
  store %EffectViolation* %t1, %EffectViolation** %t4
  %t5 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %EffectViolation*, i64 }* %collection to { i8**, i64 }*
  %t7 = bitcast { %EffectViolation*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %EffectViolation*, i64 }*
  ret { %EffectViolation*, i64 }* %t9
}

define { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %effects, i8* %effect) {
entry:
  %t0 = call i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect)
  br i1 %t0, label %then0, label %merge1
then0:
  ret { i8**, i64 }* %effects
merge1:
  %t1 = alloca [1 x i8*]
  %t2 = getelementptr [1 x i8*], [1 x i8*]* %t1, i32 0, i32 0
  %t3 = getelementptr i8*, i8** %t2, i64 0
  store i8* %effect, i8** %t3
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t2, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 1, i64* %t6
  %t7 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %effects, { i8**, i64 }* %t4)
  ret { i8**, i64 }* %t7
}

define i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t22 = phi double [ %t1, %entry ], [ %t21, %loop.latch2 ]
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
  ret i1 0
}

define { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %collection, %EffectRequirement %item) {
entry:
  %t0 = alloca [1 x %EffectRequirement]
  %t1 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* %t0, i32 0, i32 0
  %t2 = getelementptr %EffectRequirement, %EffectRequirement* %t1, i64 0
  store %EffectRequirement %item, %EffectRequirement* %t2
  %t3 = alloca { %EffectRequirement*, i64 }
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 0
  store %EffectRequirement* %t1, %EffectRequirement** %t4
  %t5 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %EffectRequirement*, i64 }* %collection to { i8**, i64 }*
  %t7 = bitcast { %EffectRequirement*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %EffectRequirement*, i64 }*
  ret { %EffectRequirement*, i64 }* %t9
}

define { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %base, { %EffectRequirement*, i64 }* %additions) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  store { %EffectRequirement*, i64 }* %base, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t34 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t2, %entry ], [ %t33, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t34, { %EffectRequirement*, i64 }** %l0
  store double %t35, double* %l1
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
  %t17 = getelementptr %EffectRequirement, %EffectRequirement* %t14, i64 %t12
  %t18 = load %EffectRequirement, %EffectRequirement* %t17
  %t19 = alloca [1 x %EffectRequirement]
  %t20 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* %t19, i32 0, i32 0
  %t21 = getelementptr %EffectRequirement, %EffectRequirement* %t20, i64 0
  store %EffectRequirement %t18, %EffectRequirement* %t21
  %t22 = alloca { %EffectRequirement*, i64 }
  %t23 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t22, i32 0, i32 0
  store %EffectRequirement* %t20, %EffectRequirement** %t23
  %t24 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t22, i32 0, i32 1
  store i64 1, i64* %t24
  %t25 = bitcast { %EffectRequirement*, i64 }* %t10 to { i8**, i64 }*
  %t26 = bitcast { %EffectRequirement*, i64 }* %t22 to { i8**, i64 }*
  %t27 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t25, { i8**, i64 }* %t26)
  %t28 = bitcast { i8**, i64 }* %t27 to { %EffectRequirement*, i64 }*
  store { %EffectRequirement*, i64 }* %t28, { %EffectRequirement*, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch2
loop.latch2:
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t36 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t36
}

define i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t1, %entry ], [ %t22, %loop.latch2 ]
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
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
