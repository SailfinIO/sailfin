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
  %t7 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
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
  %t16 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
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
  %t38 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load double, double* %l2
  %t41 = load i1, i1* %l3
  %t42 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t90 = phi i1 [ %t41, %entry ], [ %t88, %loop.latch8 ]
  %t91 = phi double [ %t42, %entry ], [ %t89, %loop.latch8 ]
  store i1 %t90, i1* %l3
  store double %t91, double* %l4
  br label %loop.body7
loop.body7:
  %t43 = load double, double* %l4
  %t44 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t45 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t44
  %t46 = extractvalue { %DecoratorInfo*, i64 } %t45, 1
  %t47 = sitofp i64 %t46 to double
  %t48 = fcmp oge double %t43, %t47
  %t49 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = load double, double* %l2
  %t52 = load i1, i1* %l3
  %t53 = load double, double* %l4
  br i1 %t48, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t54 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t55 = load double, double* %l4
  %t56 = fptosi double %t55 to i64
  %t57 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t54
  %t58 = extractvalue { %DecoratorInfo*, i64 } %t57, 0
  %t59 = extractvalue { %DecoratorInfo*, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  %t61 = getelementptr %DecoratorInfo, %DecoratorInfo* %t58, i64 %t56
  %t62 = load %DecoratorInfo, %DecoratorInfo* %t61
  store %DecoratorInfo %t62, %DecoratorInfo* %l5
  %t64 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t65 = extractvalue %DecoratorInfo %t64, 0
  %s66 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.66, i32 0, i32 0
  %t67 = icmp eq i8* %t65, %s66
  br label %logical_or_entry_63

logical_or_entry_63:
  br i1 %t67, label %logical_or_merge_63, label %logical_or_right_63

logical_or_right_63:
  %t69 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t70 = extractvalue %DecoratorInfo %t69, 0
  %s71 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.71, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  br label %logical_or_entry_68

logical_or_entry_68:
  br i1 %t72, label %logical_or_merge_68, label %logical_or_right_68

logical_or_right_68:
  %t73 = load %DecoratorInfo, %DecoratorInfo* %l5
  %t74 = extractvalue %DecoratorInfo %t73, 0
  %s75 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.75, i32 0, i32 0
  %t76 = icmp eq i8* %t74, %s75
  br label %logical_or_right_end_68

logical_or_right_end_68:
  br label %logical_or_merge_68

logical_or_merge_68:
  %t77 = phi i1 [ true, %logical_or_entry_68 ], [ %t76, %logical_or_right_end_68 ]
  br label %logical_or_right_end_63

logical_or_right_end_63:
  br label %logical_or_merge_63

logical_or_merge_63:
  %t78 = phi i1 [ true, %logical_or_entry_63 ], [ %t77, %logical_or_right_end_63 ]
  %t79 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = load double, double* %l2
  %t82 = load i1, i1* %l3
  %t83 = load double, double* %l4
  %t84 = load %DecoratorInfo, %DecoratorInfo* %l5
  br i1 %t78, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t85 = load double, double* %l4
  %t86 = sitofp i64 1 to double
  %t87 = fadd double %t85, %t86
  store double %t87, double* %l4
  br label %loop.latch8
loop.latch8:
  %t88 = load i1, i1* %l3
  %t89 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t92 = load i1, i1* %l3
  %t93 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load double, double* %l2
  %t96 = load i1, i1* %l3
  %t97 = load double, double* %l4
  br i1 %t92, label %then14, label %merge15
then14:
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s99 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.99, i32 0, i32 0
  %t100 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t98, i8* %s99)
  store { i8**, i64 }* %t100, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t101 = phi { i8**, i64 }* [ %t100, %then14 ], [ %t94, %entry ]
  store { i8**, i64 }* %t101, { i8**, i64 }** %l1
  %t102 = call { %EffectRequirement*, i64 }* @required_effects(%Block %body)
  store { %EffectRequirement*, i64 }* %t102, { %EffectRequirement*, i64 }** %l6
  %t103 = alloca [0 x i8*]
  %t104 = getelementptr [0 x i8*], [0 x i8*]* %t103, i32 0, i32 0
  %t105 = alloca { i8**, i64 }
  %t106 = getelementptr { i8**, i64 }, { i8**, i64 }* %t105, i32 0, i32 0
  store i8** %t104, i8*** %t106
  %t107 = getelementptr { i8**, i64 }, { i8**, i64 }* %t105, i32 0, i32 1
  store i64 0, i64* %t107
  store { i8**, i64 }* %t105, { i8**, i64 }** %l7
  %t108 = alloca [0 x %EffectRequirement]
  %t109 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t108, i32 0, i32 0
  %t110 = alloca { %EffectRequirement*, i64 }
  %t111 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t110, i32 0, i32 0
  store %EffectRequirement* %t109, %EffectRequirement** %t111
  %t112 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t110, i32 0, i32 1
  store i64 0, i64* %t112
  store { %EffectRequirement*, i64 }* %t110, { %EffectRequirement*, i64 }** %l8
  %t113 = sitofp i64 0 to double
  store double %t113, double* %l9
  %t114 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t116 = load double, double* %l2
  %t117 = load i1, i1* %l3
  %t118 = load double, double* %l4
  %t119 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t121 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t122 = load double, double* %l9
  br label %loop.header16
loop.header16:
  %t214 = phi double [ %t122, %entry ], [ %t211, %loop.latch18 ]
  %t215 = phi { i8**, i64 }* [ %t120, %entry ], [ %t212, %loop.latch18 ]
  %t216 = phi { %EffectRequirement*, i64 }* [ %t121, %entry ], [ %t213, %loop.latch18 ]
  store double %t214, double* %l9
  store { i8**, i64 }* %t215, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t216, { %EffectRequirement*, i64 }** %l8
  br label %loop.body17
loop.body17:
  %t123 = load double, double* %l9
  %t124 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t125 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t124
  %t126 = extractvalue { %EffectRequirement*, i64 } %t125, 1
  %t127 = sitofp i64 %t126 to double
  %t128 = fcmp oge double %t123, %t127
  %t129 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load double, double* %l2
  %t132 = load i1, i1* %l3
  %t133 = load double, double* %l4
  %t134 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t136 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t137 = load double, double* %l9
  br i1 %t128, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t138 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t139 = load double, double* %l9
  %t140 = fptosi double %t139 to i64
  %t141 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t138
  %t142 = extractvalue { %EffectRequirement*, i64 } %t141, 0
  %t143 = extractvalue { %EffectRequirement*, i64 } %t141, 1
  %t144 = icmp uge i64 %t140, %t143
  ; bounds check: %t144 (if true, out of bounds)
  %t145 = getelementptr %EffectRequirement, %EffectRequirement* %t142, i64 %t140
  %t146 = load %EffectRequirement, %EffectRequirement* %t145
  store %EffectRequirement %t146, %EffectRequirement* %l10
  %t147 = load %EffectRequirement, %EffectRequirement* %l10
  %t148 = extractvalue %EffectRequirement %t147, 0
  store i8* %t148, i8** %l11
  %t150 = load i8*, i8** %l11
  %s151 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.151, i32 0, i32 0
  %t152 = icmp eq i8* %t150, %s151
  br label %logical_and_entry_149

logical_and_entry_149:
  br i1 %t152, label %logical_and_right_149, label %logical_and_merge_149

logical_and_right_149:
  %t153 = load i1, i1* %l3
  br label %logical_and_right_end_149

logical_and_right_end_149:
  br label %logical_and_merge_149

logical_and_merge_149:
  %t154 = phi i1 [ false, %logical_and_entry_149 ], [ %t153, %logical_and_right_end_149 ]
  %t155 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t157 = load double, double* %l2
  %t158 = load i1, i1* %l3
  %t159 = load double, double* %l4
  %t160 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t162 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t163 = load double, double* %l9
  %t164 = load %EffectRequirement, %EffectRequirement* %l10
  %t165 = load i8*, i8** %l11
  br i1 %t154, label %then22, label %merge23
then22:
  %t166 = load double, double* %l9
  %t167 = sitofp i64 1 to double
  %t168 = fadd double %t166, %t167
  store double %t168, double* %l9
  br label %loop.latch18
merge23:
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t170 = load i8*, i8** %l11
  %t171 = call i1 @contains_effect({ i8**, i64 }* %t169, i8* %t170)
  %t172 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t174 = load double, double* %l2
  %t175 = load i1, i1* %l3
  %t176 = load double, double* %l4
  %t177 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t179 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t180 = load double, double* %l9
  %t181 = load %EffectRequirement, %EffectRequirement* %l10
  %t182 = load i8*, i8** %l11
  br i1 %t171, label %then24, label %merge25
then24:
  %t183 = load double, double* %l9
  %t184 = sitofp i64 1 to double
  %t185 = fadd double %t183, %t184
  store double %t185, double* %l9
  br label %loop.latch18
merge25:
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t187 = load i8*, i8** %l11
  %t188 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t186, i8* %t187)
  store { i8**, i64 }* %t188, { i8**, i64 }** %l7
  %t189 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t190 = load i8*, i8** %l11
  %t191 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t189, i8* %t190)
  %t192 = xor i1 %t191, 1
  %t193 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t195 = load double, double* %l2
  %t196 = load i1, i1* %l3
  %t197 = load double, double* %l4
  %t198 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t200 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t201 = load double, double* %l9
  %t202 = load %EffectRequirement, %EffectRequirement* %l10
  %t203 = load i8*, i8** %l11
  br i1 %t192, label %then26, label %merge27
then26:
  %t204 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t205 = load %EffectRequirement, %EffectRequirement* %l10
  %t206 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t204, %EffectRequirement %t205)
  store { %EffectRequirement*, i64 }* %t206, { %EffectRequirement*, i64 }** %l8
  br label %merge27
merge27:
  %t207 = phi { %EffectRequirement*, i64 }* [ %t206, %then26 ], [ %t200, %loop.body17 ]
  store { %EffectRequirement*, i64 }* %t207, { %EffectRequirement*, i64 }** %l8
  %t208 = load double, double* %l9
  %t209 = sitofp i64 1 to double
  %t210 = fadd double %t208, %t209
  store double %t210, double* %l9
  br label %loop.latch18
loop.latch18:
  %t211 = load double, double* %l9
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t213 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header16
afterloop19:
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t218 = load { i8**, i64 }, { i8**, i64 }* %t217
  %t219 = extractvalue { i8**, i64 } %t218, 1
  %t220 = icmp eq i64 %t219, 0
  %t221 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load double, double* %l2
  %t224 = load i1, i1* %l3
  %t225 = load double, double* %l4
  %t226 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t228 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t229 = load double, double* %l9
  br i1 %t220, label %then28, label %merge29
then28:
  %t230 = alloca [0 x %EffectViolation]
  %t231 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t230, i32 0, i32 0
  %t232 = alloca { %EffectViolation*, i64 }
  %t233 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t232, i32 0, i32 0
  store %EffectViolation* %t231, %EffectViolation** %t233
  %t234 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t232, i32 0, i32 1
  store i64 0, i64* %t234
  ret { %EffectViolation*, i64 }* %t232
merge29:
  %t235 = alloca [0 x %EffectViolation]
  %t236 = getelementptr [0 x %EffectViolation], [0 x %EffectViolation]* %t235, i32 0, i32 0
  %t237 = alloca { %EffectViolation*, i64 }
  %t238 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t237, i32 0, i32 0
  store %EffectViolation* %t236, %EffectViolation** %t238
  %t239 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t237, i32 0, i32 1
  store i64 0, i64* %t239
  store { %EffectViolation*, i64 }* %t237, { %EffectViolation*, i64 }** %l12
  %t240 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  %t241 = insertvalue %EffectViolation undef, i8* %name, 0
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t243 = insertvalue %EffectViolation %t241, { i8**, i64 }* %t242, 1
  %t244 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t245 = bitcast { %EffectRequirement*, i64 }* %t244 to { %EffectRequirement**, i64 }*
  %t246 = insertvalue %EffectViolation %t243, { %EffectRequirement**, i64 }* %t245, 2
  %t247 = call { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %t240, %EffectViolation %t246)
  store { %EffectViolation*, i64 }* %t247, { %EffectViolation*, i64 }** %l12
  %t248 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t248
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
  %t705 = bitcast [16 x i8]* %t704 to i8*
  %t706 = bitcast i8* %t705 to %Expression**
  %t707 = load %Expression*, %Expression** %t706
  %t708 = icmp eq i32 %t702, 20
  %t709 = select i1 %t708, %Expression* %t707, %Expression* null
  %t710 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t709)
  store { %EffectRequirement*, i64 }* %t710, { %EffectRequirement*, i64 }** %l5
  %t711 = sitofp i64 0 to double
  store double %t711, double* %l6
  %t712 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t713 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t756 = phi { %EffectRequirement*, i64 }* [ %t712, %then14 ], [ %t754, %loop.latch18 ]
  %t757 = phi double [ %t713, %then14 ], [ %t755, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t756, { %EffectRequirement*, i64 }** %l5
  store double %t757, double* %l6
  br label %loop.body17
loop.body17:
  %t714 = load double, double* %l6
  %t715 = extractvalue %Statement %statement, 0
  %t716 = alloca %Statement
  store %Statement %statement, %Statement* %t716
  %t717 = getelementptr inbounds %Statement, %Statement* %t716, i32 0, i32 1
  %t718 = bitcast [24 x i8]* %t717 to i8*
  %t719 = getelementptr inbounds i8, i8* %t718, i64 8
  %t720 = bitcast i8* %t719 to { %MatchCase**, i64 }**
  %t721 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t720
  %t722 = icmp eq i32 %t715, 18
  %t723 = select i1 %t722, { %MatchCase**, i64 }* %t721, { %MatchCase**, i64 }* null
  %t724 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t723
  %t725 = extractvalue { %MatchCase**, i64 } %t724, 1
  %t726 = sitofp i64 %t725 to double
  %t727 = fcmp oge double %t714, %t726
  %t728 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t729 = load double, double* %l6
  br i1 %t727, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t730 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t731 = extractvalue %Statement %statement, 0
  %t732 = alloca %Statement
  store %Statement %statement, %Statement* %t732
  %t733 = getelementptr inbounds %Statement, %Statement* %t732, i32 0, i32 1
  %t734 = bitcast [24 x i8]* %t733 to i8*
  %t735 = getelementptr inbounds i8, i8* %t734, i64 8
  %t736 = bitcast i8* %t735 to { %MatchCase**, i64 }**
  %t737 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t736
  %t738 = icmp eq i32 %t731, 18
  %t739 = select i1 %t738, { %MatchCase**, i64 }* %t737, { %MatchCase**, i64 }* null
  %t740 = load double, double* %l6
  %t741 = fptosi double %t740 to i64
  %t742 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t739
  %t743 = extractvalue { %MatchCase**, i64 } %t742, 0
  %t744 = extractvalue { %MatchCase**, i64 } %t742, 1
  %t745 = icmp uge i64 %t741, %t744
  ; bounds check: %t745 (if true, out of bounds)
  %t746 = getelementptr %MatchCase*, %MatchCase** %t743, i64 %t741
  %t747 = load %MatchCase*, %MatchCase** %t746
  %t748 = load %MatchCase, %MatchCase* %t747
  %t749 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t748)
  %t750 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t730, { %EffectRequirement*, i64 }* %t749)
  store { %EffectRequirement*, i64 }* %t750, { %EffectRequirement*, i64 }** %l5
  %t751 = load double, double* %l6
  %t752 = sitofp i64 1 to double
  %t753 = fadd double %t751, %t752
  store double %t753, double* %l6
  br label %loop.latch18
loop.latch18:
  %t754 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t755 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t758 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t758
merge15:
  %t759 = extractvalue %Statement %statement, 0
  %t760 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t761 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t759, 0
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t759, 1
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t759, 2
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t759, 3
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t759, 4
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t759, 5
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t759, 6
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t759, 7
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t759, 8
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t759, 9
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t759, 10
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t759, 11
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t759, 12
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t759, 13
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t759, 14
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t759, 15
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %t809 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t759, 16
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t759, 17
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t759, 18
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t759, 19
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t759, 20
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t759, 21
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t759, 22
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %s830 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.830, i32 0, i32 0
  %t831 = icmp eq i8* %t829, %s830
  br i1 %t831, label %then22, label %merge23
then22:
  %t832 = extractvalue %Statement %statement, 0
  %t833 = alloca %Statement
  store %Statement %statement, %Statement* %t833
  %t834 = getelementptr inbounds %Statement, %Statement* %t833, i32 0, i32 1
  %t835 = bitcast [32 x i8]* %t834 to i8*
  %t836 = bitcast i8* %t835 to %Expression*
  %t837 = load %Expression, %Expression* %t836
  %t838 = icmp eq i32 %t832, 19
  %t839 = select i1 %t838, %Expression %t837, %Expression zeroinitializer
  %t840 = alloca %Expression
  store %Expression %t839, %Expression* %t840
  %t841 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t840)
  store { %EffectRequirement*, i64 }* %t841, { %EffectRequirement*, i64 }** %l7
  %t842 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t843 = extractvalue %Statement %statement, 0
  %t844 = alloca %Statement
  store %Statement %statement, %Statement* %t844
  %t845 = getelementptr inbounds %Statement, %Statement* %t844, i32 0, i32 1
  %t846 = bitcast [32 x i8]* %t845 to i8*
  %t847 = getelementptr inbounds i8, i8* %t846, i64 8
  %t848 = bitcast i8* %t847 to %Block*
  %t849 = load %Block, %Block* %t848
  %t850 = icmp eq i32 %t843, 19
  %t851 = select i1 %t850, %Block %t849, %Block zeroinitializer
  %t852 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t851)
  %t853 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t842, { %EffectRequirement*, i64 }* %t852)
  store { %EffectRequirement*, i64 }* %t853, { %EffectRequirement*, i64 }** %l7
  %t854 = extractvalue %Statement %statement, 0
  %t855 = alloca %Statement
  store %Statement %statement, %Statement* %t855
  %t856 = getelementptr inbounds %Statement, %Statement* %t855, i32 0, i32 1
  %t857 = bitcast [32 x i8]* %t856 to i8*
  %t858 = getelementptr inbounds i8, i8* %t857, i64 16
  %t859 = bitcast i8* %t858 to %ElseBranch**
  %t860 = load %ElseBranch*, %ElseBranch** %t859
  %t861 = icmp eq i32 %t854, 19
  %t862 = select i1 %t861, %ElseBranch* %t860, %ElseBranch* null
  %t863 = icmp ne %ElseBranch* %t862, null
  %t864 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  br i1 %t863, label %then24, label %merge25
then24:
  %t865 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t866 = extractvalue %Statement %statement, 0
  %t867 = alloca %Statement
  store %Statement %statement, %Statement* %t867
  %t868 = getelementptr inbounds %Statement, %Statement* %t867, i32 0, i32 1
  %t869 = bitcast [32 x i8]* %t868 to i8*
  %t870 = getelementptr inbounds i8, i8* %t869, i64 16
  %t871 = bitcast i8* %t870 to %ElseBranch**
  %t872 = load %ElseBranch*, %ElseBranch** %t871
  %t873 = icmp eq i32 %t866, 19
  %t874 = select i1 %t873, %ElseBranch* %t872, %ElseBranch* null
  %t875 = load %ElseBranch, %ElseBranch* %t874
  %t876 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %t875)
  %t877 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t865, { %EffectRequirement*, i64 }* %t876)
  store { %EffectRequirement*, i64 }* %t877, { %EffectRequirement*, i64 }** %l7
  br label %merge25
merge25:
  %t878 = phi { %EffectRequirement*, i64 }* [ %t877, %then24 ], [ %t864, %then22 ]
  store { %EffectRequirement*, i64 }* %t878, { %EffectRequirement*, i64 }** %l7
  %t879 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t879
merge23:
  %t880 = extractvalue %Statement %statement, 0
  %t881 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t882 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t880, 0
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t880, 1
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t880, 2
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t880, 3
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t880, 4
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t880, 5
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t880, 6
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t880, 7
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t880, 8
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t880, 9
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t880, 10
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t880, 11
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t880, 12
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t880, 13
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t880, 14
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t880, 15
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t880, 16
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t880, 17
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t880, 18
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t880, 19
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t880, 20
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t880, 21
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t880, 22
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %s951 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.951, i32 0, i32 0
  %t952 = icmp eq i8* %t950, %s951
  br i1 %t952, label %then26, label %merge27
then26:
  %t953 = extractvalue %Statement %statement, 0
  %t954 = alloca %Statement
  store %Statement %statement, %Statement* %t954
  %t955 = getelementptr inbounds %Statement, %Statement* %t954, i32 0, i32 1
  %t956 = bitcast [16 x i8]* %t955 to i8*
  %t957 = bitcast i8* %t956 to %Expression**
  %t958 = load %Expression*, %Expression** %t957
  %t959 = icmp eq i32 %t953, 20
  %t960 = select i1 %t959, %Expression* %t958, %Expression* null
  %t961 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t960)
  ret { %EffectRequirement*, i64 }* %t961
merge27:
  %t962 = extractvalue %Statement %statement, 0
  %t963 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t964 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t962, 0
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t962, 1
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t962, 2
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t962, 3
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t962, 4
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t962, 5
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t962, 6
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t962, 7
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t962, 8
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t962, 9
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t962, 10
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t962, 11
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t962, 12
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t962, 13
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t962, 14
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t962, 15
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t962, 16
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t962, 17
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t962, 18
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t962, 19
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t962, 20
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t962, 21
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t962, 22
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %s1033 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1033, i32 0, i32 0
  %t1034 = icmp eq i8* %t1032, %s1033
  br i1 %t1034, label %then28, label %merge29
then28:
  %t1035 = extractvalue %Statement %statement, 0
  %t1036 = alloca %Statement
  store %Statement %statement, %Statement* %t1036
  %t1037 = getelementptr inbounds %Statement, %Statement* %t1036, i32 0, i32 1
  %t1038 = bitcast [16 x i8]* %t1037 to i8*
  %t1039 = bitcast i8* %t1038 to %Expression**
  %t1040 = load %Expression*, %Expression** %t1039
  %t1041 = icmp eq i32 %t1035, 20
  %t1042 = select i1 %t1041, %Expression* %t1040, %Expression* null
  %t1043 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1042)
  ret { %EffectRequirement*, i64 }* %t1043
merge29:
  %t1044 = extractvalue %Statement %statement, 0
  %t1045 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1046 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t1044, 0
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %t1049 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1050 = icmp eq i32 %t1044, 1
  %t1051 = select i1 %t1050, i8* %t1049, i8* %t1048
  %t1052 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1053 = icmp eq i32 %t1044, 2
  %t1054 = select i1 %t1053, i8* %t1052, i8* %t1051
  %t1055 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1056 = icmp eq i32 %t1044, 3
  %t1057 = select i1 %t1056, i8* %t1055, i8* %t1054
  %t1058 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1059 = icmp eq i32 %t1044, 4
  %t1060 = select i1 %t1059, i8* %t1058, i8* %t1057
  %t1061 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1062 = icmp eq i32 %t1044, 5
  %t1063 = select i1 %t1062, i8* %t1061, i8* %t1060
  %t1064 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1065 = icmp eq i32 %t1044, 6
  %t1066 = select i1 %t1065, i8* %t1064, i8* %t1063
  %t1067 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1068 = icmp eq i32 %t1044, 7
  %t1069 = select i1 %t1068, i8* %t1067, i8* %t1066
  %t1070 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1071 = icmp eq i32 %t1044, 8
  %t1072 = select i1 %t1071, i8* %t1070, i8* %t1069
  %t1073 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1074 = icmp eq i32 %t1044, 9
  %t1075 = select i1 %t1074, i8* %t1073, i8* %t1072
  %t1076 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1077 = icmp eq i32 %t1044, 10
  %t1078 = select i1 %t1077, i8* %t1076, i8* %t1075
  %t1079 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1080 = icmp eq i32 %t1044, 11
  %t1081 = select i1 %t1080, i8* %t1079, i8* %t1078
  %t1082 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1083 = icmp eq i32 %t1044, 12
  %t1084 = select i1 %t1083, i8* %t1082, i8* %t1081
  %t1085 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1086 = icmp eq i32 %t1044, 13
  %t1087 = select i1 %t1086, i8* %t1085, i8* %t1084
  %t1088 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1089 = icmp eq i32 %t1044, 14
  %t1090 = select i1 %t1089, i8* %t1088, i8* %t1087
  %t1091 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1092 = icmp eq i32 %t1044, 15
  %t1093 = select i1 %t1092, i8* %t1091, i8* %t1090
  %t1094 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1095 = icmp eq i32 %t1044, 16
  %t1096 = select i1 %t1095, i8* %t1094, i8* %t1093
  %t1097 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1098 = icmp eq i32 %t1044, 17
  %t1099 = select i1 %t1098, i8* %t1097, i8* %t1096
  %t1100 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1101 = icmp eq i32 %t1044, 18
  %t1102 = select i1 %t1101, i8* %t1100, i8* %t1099
  %t1103 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1104 = icmp eq i32 %t1044, 19
  %t1105 = select i1 %t1104, i8* %t1103, i8* %t1102
  %t1106 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1107 = icmp eq i32 %t1044, 20
  %t1108 = select i1 %t1107, i8* %t1106, i8* %t1105
  %t1109 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1110 = icmp eq i32 %t1044, 21
  %t1111 = select i1 %t1110, i8* %t1109, i8* %t1108
  %t1112 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1113 = icmp eq i32 %t1044, 22
  %t1114 = select i1 %t1113, i8* %t1112, i8* %t1111
  %s1115 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1115, i32 0, i32 0
  %t1116 = icmp eq i8* %t1114, %s1115
  br i1 %t1116, label %then30, label %merge31
then30:
  %t1117 = extractvalue %Statement %statement, 0
  %t1118 = alloca %Statement
  store %Statement %statement, %Statement* %t1118
  %t1119 = getelementptr inbounds %Statement, %Statement* %t1118, i32 0, i32 1
  %t1120 = bitcast [48 x i8]* %t1119 to i8*
  %t1121 = getelementptr inbounds i8, i8* %t1120, i64 24
  %t1122 = bitcast i8* %t1121 to %Expression**
  %t1123 = load %Expression*, %Expression** %t1122
  %t1124 = icmp eq i32 %t1117, 2
  %t1125 = select i1 %t1124, %Expression* %t1123, %Expression* null
  %t1126 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1125)
  ret { %EffectRequirement*, i64 }* %t1126
merge31:
  %t1127 = extractvalue %Statement %statement, 0
  %t1128 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1129 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1130 = icmp eq i32 %t1127, 0
  %t1131 = select i1 %t1130, i8* %t1129, i8* %t1128
  %t1132 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1133 = icmp eq i32 %t1127, 1
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1131
  %t1135 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1136 = icmp eq i32 %t1127, 2
  %t1137 = select i1 %t1136, i8* %t1135, i8* %t1134
  %t1138 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1127, 3
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1127, 4
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1127, 5
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1127, 6
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1127, 7
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %t1153 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1154 = icmp eq i32 %t1127, 8
  %t1155 = select i1 %t1154, i8* %t1153, i8* %t1152
  %t1156 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1157 = icmp eq i32 %t1127, 9
  %t1158 = select i1 %t1157, i8* %t1156, i8* %t1155
  %t1159 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1160 = icmp eq i32 %t1127, 10
  %t1161 = select i1 %t1160, i8* %t1159, i8* %t1158
  %t1162 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1163 = icmp eq i32 %t1127, 11
  %t1164 = select i1 %t1163, i8* %t1162, i8* %t1161
  %t1165 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1166 = icmp eq i32 %t1127, 12
  %t1167 = select i1 %t1166, i8* %t1165, i8* %t1164
  %t1168 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1127, 13
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1127, 14
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1127, 15
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1127, 16
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1127, 17
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1127, 18
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1127, 19
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1127, 20
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1127, 21
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1127, 22
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %s1198 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1198, i32 0, i32 0
  %t1199 = icmp eq i8* %t1197, %s1198
  br i1 %t1199, label %then32, label %merge33
then32:
  %t1200 = extractvalue %Statement %statement, 0
  %t1201 = alloca %Statement
  store %Statement %statement, %Statement* %t1201
  %t1202 = getelementptr inbounds %Statement, %Statement* %t1201, i32 0, i32 1
  %t1203 = bitcast [24 x i8]* %t1202 to i8*
  %t1204 = getelementptr inbounds i8, i8* %t1203, i64 8
  %t1205 = bitcast i8* %t1204 to %Block*
  %t1206 = load %Block, %Block* %t1205
  %t1207 = icmp eq i32 %t1200, 4
  %t1208 = select i1 %t1207, %Block %t1206, %Block zeroinitializer
  %t1209 = getelementptr inbounds %Statement, %Statement* %t1201, i32 0, i32 1
  %t1210 = bitcast [24 x i8]* %t1209 to i8*
  %t1211 = getelementptr inbounds i8, i8* %t1210, i64 8
  %t1212 = bitcast i8* %t1211 to %Block*
  %t1213 = load %Block, %Block* %t1212
  %t1214 = icmp eq i32 %t1200, 5
  %t1215 = select i1 %t1214, %Block %t1213, %Block %t1208
  %t1216 = getelementptr inbounds %Statement, %Statement* %t1201, i32 0, i32 1
  %t1217 = bitcast [40 x i8]* %t1216 to i8*
  %t1218 = getelementptr inbounds i8, i8* %t1217, i64 16
  %t1219 = bitcast i8* %t1218 to %Block*
  %t1220 = load %Block, %Block* %t1219
  %t1221 = icmp eq i32 %t1200, 6
  %t1222 = select i1 %t1221, %Block %t1220, %Block %t1215
  %t1223 = getelementptr inbounds %Statement, %Statement* %t1201, i32 0, i32 1
  %t1224 = bitcast [24 x i8]* %t1223 to i8*
  %t1225 = getelementptr inbounds i8, i8* %t1224, i64 8
  %t1226 = bitcast i8* %t1225 to %Block*
  %t1227 = load %Block, %Block* %t1226
  %t1228 = icmp eq i32 %t1200, 7
  %t1229 = select i1 %t1228, %Block %t1227, %Block %t1222
  %t1230 = getelementptr inbounds %Statement, %Statement* %t1201, i32 0, i32 1
  %t1231 = bitcast [40 x i8]* %t1230 to i8*
  %t1232 = getelementptr inbounds i8, i8* %t1231, i64 24
  %t1233 = bitcast i8* %t1232 to %Block*
  %t1234 = load %Block, %Block* %t1233
  %t1235 = icmp eq i32 %t1200, 12
  %t1236 = select i1 %t1235, %Block %t1234, %Block %t1229
  %t1237 = getelementptr inbounds %Statement, %Statement* %t1201, i32 0, i32 1
  %t1238 = bitcast [24 x i8]* %t1237 to i8*
  %t1239 = getelementptr inbounds i8, i8* %t1238, i64 8
  %t1240 = bitcast i8* %t1239 to %Block*
  %t1241 = load %Block, %Block* %t1240
  %t1242 = icmp eq i32 %t1200, 13
  %t1243 = select i1 %t1242, %Block %t1241, %Block %t1236
  %t1244 = getelementptr inbounds %Statement, %Statement* %t1201, i32 0, i32 1
  %t1245 = bitcast [24 x i8]* %t1244 to i8*
  %t1246 = getelementptr inbounds i8, i8* %t1245, i64 8
  %t1247 = bitcast i8* %t1246 to %Block*
  %t1248 = load %Block, %Block* %t1247
  %t1249 = icmp eq i32 %t1200, 14
  %t1250 = select i1 %t1249, %Block %t1248, %Block %t1243
  %t1251 = getelementptr inbounds %Statement, %Statement* %t1201, i32 0, i32 1
  %t1252 = bitcast [16 x i8]* %t1251 to i8*
  %t1253 = bitcast i8* %t1252 to %Block*
  %t1254 = load %Block, %Block* %t1253
  %t1255 = icmp eq i32 %t1200, 15
  %t1256 = select i1 %t1255, %Block %t1254, %Block %t1250
  %t1257 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1256)
  ret { %EffectRequirement*, i64 }* %t1257
merge33:
  %t1258 = extractvalue %Statement %statement, 0
  %t1259 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1260 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1258, 0
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1258, 1
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1258, 2
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1258, 3
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1258, 4
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1258, 5
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1258, 6
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1258, 7
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1258, 8
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1258, 9
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1258, 10
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1258, 11
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1258, 12
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1258, 13
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1258, 14
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1258, 15
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1258, 16
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1258, 17
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1258, 18
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1258, 19
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1258, 20
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1258, 21
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1258, 22
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %s1329 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1329, i32 0, i32 0
  %t1330 = icmp eq i8* %t1328, %s1329
  br i1 %t1330, label %then34, label %merge35
then34:
  %t1331 = extractvalue %Statement %statement, 0
  %t1332 = alloca %Statement
  store %Statement %statement, %Statement* %t1332
  %t1333 = getelementptr inbounds %Statement, %Statement* %t1332, i32 0, i32 1
  %t1334 = bitcast [24 x i8]* %t1333 to i8*
  %t1335 = getelementptr inbounds i8, i8* %t1334, i64 8
  %t1336 = bitcast i8* %t1335 to %Block*
  %t1337 = load %Block, %Block* %t1336
  %t1338 = icmp eq i32 %t1331, 4
  %t1339 = select i1 %t1338, %Block %t1337, %Block zeroinitializer
  %t1340 = getelementptr inbounds %Statement, %Statement* %t1332, i32 0, i32 1
  %t1341 = bitcast [24 x i8]* %t1340 to i8*
  %t1342 = getelementptr inbounds i8, i8* %t1341, i64 8
  %t1343 = bitcast i8* %t1342 to %Block*
  %t1344 = load %Block, %Block* %t1343
  %t1345 = icmp eq i32 %t1331, 5
  %t1346 = select i1 %t1345, %Block %t1344, %Block %t1339
  %t1347 = getelementptr inbounds %Statement, %Statement* %t1332, i32 0, i32 1
  %t1348 = bitcast [40 x i8]* %t1347 to i8*
  %t1349 = getelementptr inbounds i8, i8* %t1348, i64 16
  %t1350 = bitcast i8* %t1349 to %Block*
  %t1351 = load %Block, %Block* %t1350
  %t1352 = icmp eq i32 %t1331, 6
  %t1353 = select i1 %t1352, %Block %t1351, %Block %t1346
  %t1354 = getelementptr inbounds %Statement, %Statement* %t1332, i32 0, i32 1
  %t1355 = bitcast [24 x i8]* %t1354 to i8*
  %t1356 = getelementptr inbounds i8, i8* %t1355, i64 8
  %t1357 = bitcast i8* %t1356 to %Block*
  %t1358 = load %Block, %Block* %t1357
  %t1359 = icmp eq i32 %t1331, 7
  %t1360 = select i1 %t1359, %Block %t1358, %Block %t1353
  %t1361 = getelementptr inbounds %Statement, %Statement* %t1332, i32 0, i32 1
  %t1362 = bitcast [40 x i8]* %t1361 to i8*
  %t1363 = getelementptr inbounds i8, i8* %t1362, i64 24
  %t1364 = bitcast i8* %t1363 to %Block*
  %t1365 = load %Block, %Block* %t1364
  %t1366 = icmp eq i32 %t1331, 12
  %t1367 = select i1 %t1366, %Block %t1365, %Block %t1360
  %t1368 = getelementptr inbounds %Statement, %Statement* %t1332, i32 0, i32 1
  %t1369 = bitcast [24 x i8]* %t1368 to i8*
  %t1370 = getelementptr inbounds i8, i8* %t1369, i64 8
  %t1371 = bitcast i8* %t1370 to %Block*
  %t1372 = load %Block, %Block* %t1371
  %t1373 = icmp eq i32 %t1331, 13
  %t1374 = select i1 %t1373, %Block %t1372, %Block %t1367
  %t1375 = getelementptr inbounds %Statement, %Statement* %t1332, i32 0, i32 1
  %t1376 = bitcast [24 x i8]* %t1375 to i8*
  %t1377 = getelementptr inbounds i8, i8* %t1376, i64 8
  %t1378 = bitcast i8* %t1377 to %Block*
  %t1379 = load %Block, %Block* %t1378
  %t1380 = icmp eq i32 %t1331, 14
  %t1381 = select i1 %t1380, %Block %t1379, %Block %t1374
  %t1382 = getelementptr inbounds %Statement, %Statement* %t1332, i32 0, i32 1
  %t1383 = bitcast [16 x i8]* %t1382 to i8*
  %t1384 = bitcast i8* %t1383 to %Block*
  %t1385 = load %Block, %Block* %t1384
  %t1386 = icmp eq i32 %t1331, 15
  %t1387 = select i1 %t1386, %Block %t1385, %Block %t1381
  %t1388 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1387)
  ret { %EffectRequirement*, i64 }* %t1388
merge35:
  %t1389 = extractvalue %Statement %statement, 0
  %t1390 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1391 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1389, 0
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1389, 1
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1389, 2
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1401 = icmp eq i32 %t1389, 3
  %t1402 = select i1 %t1401, i8* %t1400, i8* %t1399
  %t1403 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1404 = icmp eq i32 %t1389, 4
  %t1405 = select i1 %t1404, i8* %t1403, i8* %t1402
  %t1406 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1407 = icmp eq i32 %t1389, 5
  %t1408 = select i1 %t1407, i8* %t1406, i8* %t1405
  %t1409 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1389, 6
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1389, 7
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1389, 8
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1419 = icmp eq i32 %t1389, 9
  %t1420 = select i1 %t1419, i8* %t1418, i8* %t1417
  %t1421 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1422 = icmp eq i32 %t1389, 10
  %t1423 = select i1 %t1422, i8* %t1421, i8* %t1420
  %t1424 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1425 = icmp eq i32 %t1389, 11
  %t1426 = select i1 %t1425, i8* %t1424, i8* %t1423
  %t1427 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1389, 12
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %t1430 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1389, 13
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1389, 14
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1389, 15
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1389, 16
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1389, 17
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1389, 18
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1449 = icmp eq i32 %t1389, 19
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1447
  %t1451 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1452 = icmp eq i32 %t1389, 20
  %t1453 = select i1 %t1452, i8* %t1451, i8* %t1450
  %t1454 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1455 = icmp eq i32 %t1389, 21
  %t1456 = select i1 %t1455, i8* %t1454, i8* %t1453
  %t1457 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1458 = icmp eq i32 %t1389, 22
  %t1459 = select i1 %t1458, i8* %t1457, i8* %t1456
  %s1460 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1460, i32 0, i32 0
  %t1461 = icmp eq i8* %t1459, %s1460
  br i1 %t1461, label %then36, label %merge37
then36:
  %t1462 = extractvalue %Statement %statement, 0
  %t1463 = alloca %Statement
  store %Statement %statement, %Statement* %t1463
  %t1464 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1465 = bitcast [24 x i8]* %t1464 to i8*
  %t1466 = getelementptr inbounds i8, i8* %t1465, i64 8
  %t1467 = bitcast i8* %t1466 to %Block*
  %t1468 = load %Block, %Block* %t1467
  %t1469 = icmp eq i32 %t1462, 4
  %t1470 = select i1 %t1469, %Block %t1468, %Block zeroinitializer
  %t1471 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1472 = bitcast [24 x i8]* %t1471 to i8*
  %t1473 = getelementptr inbounds i8, i8* %t1472, i64 8
  %t1474 = bitcast i8* %t1473 to %Block*
  %t1475 = load %Block, %Block* %t1474
  %t1476 = icmp eq i32 %t1462, 5
  %t1477 = select i1 %t1476, %Block %t1475, %Block %t1470
  %t1478 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1479 = bitcast [40 x i8]* %t1478 to i8*
  %t1480 = getelementptr inbounds i8, i8* %t1479, i64 16
  %t1481 = bitcast i8* %t1480 to %Block*
  %t1482 = load %Block, %Block* %t1481
  %t1483 = icmp eq i32 %t1462, 6
  %t1484 = select i1 %t1483, %Block %t1482, %Block %t1477
  %t1485 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1486 = bitcast [24 x i8]* %t1485 to i8*
  %t1487 = getelementptr inbounds i8, i8* %t1486, i64 8
  %t1488 = bitcast i8* %t1487 to %Block*
  %t1489 = load %Block, %Block* %t1488
  %t1490 = icmp eq i32 %t1462, 7
  %t1491 = select i1 %t1490, %Block %t1489, %Block %t1484
  %t1492 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1493 = bitcast [40 x i8]* %t1492 to i8*
  %t1494 = getelementptr inbounds i8, i8* %t1493, i64 24
  %t1495 = bitcast i8* %t1494 to %Block*
  %t1496 = load %Block, %Block* %t1495
  %t1497 = icmp eq i32 %t1462, 12
  %t1498 = select i1 %t1497, %Block %t1496, %Block %t1491
  %t1499 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1500 = bitcast [24 x i8]* %t1499 to i8*
  %t1501 = getelementptr inbounds i8, i8* %t1500, i64 8
  %t1502 = bitcast i8* %t1501 to %Block*
  %t1503 = load %Block, %Block* %t1502
  %t1504 = icmp eq i32 %t1462, 13
  %t1505 = select i1 %t1504, %Block %t1503, %Block %t1498
  %t1506 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1507 = bitcast [24 x i8]* %t1506 to i8*
  %t1508 = getelementptr inbounds i8, i8* %t1507, i64 8
  %t1509 = bitcast i8* %t1508 to %Block*
  %t1510 = load %Block, %Block* %t1509
  %t1511 = icmp eq i32 %t1462, 14
  %t1512 = select i1 %t1511, %Block %t1510, %Block %t1505
  %t1513 = getelementptr inbounds %Statement, %Statement* %t1463, i32 0, i32 1
  %t1514 = bitcast [16 x i8]* %t1513 to i8*
  %t1515 = bitcast i8* %t1514 to %Block*
  %t1516 = load %Block, %Block* %t1515
  %t1517 = icmp eq i32 %t1462, 15
  %t1518 = select i1 %t1517, %Block %t1516, %Block %t1512
  %t1519 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1518)
  ret { %EffectRequirement*, i64 }* %t1519
merge37:
  %t1520 = extractvalue %Statement %statement, 0
  %t1521 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1522 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1523 = icmp eq i32 %t1520, 0
  %t1524 = select i1 %t1523, i8* %t1522, i8* %t1521
  %t1525 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1526 = icmp eq i32 %t1520, 1
  %t1527 = select i1 %t1526, i8* %t1525, i8* %t1524
  %t1528 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1529 = icmp eq i32 %t1520, 2
  %t1530 = select i1 %t1529, i8* %t1528, i8* %t1527
  %t1531 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1532 = icmp eq i32 %t1520, 3
  %t1533 = select i1 %t1532, i8* %t1531, i8* %t1530
  %t1534 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1535 = icmp eq i32 %t1520, 4
  %t1536 = select i1 %t1535, i8* %t1534, i8* %t1533
  %t1537 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1538 = icmp eq i32 %t1520, 5
  %t1539 = select i1 %t1538, i8* %t1537, i8* %t1536
  %t1540 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1541 = icmp eq i32 %t1520, 6
  %t1542 = select i1 %t1541, i8* %t1540, i8* %t1539
  %t1543 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1544 = icmp eq i32 %t1520, 7
  %t1545 = select i1 %t1544, i8* %t1543, i8* %t1542
  %t1546 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1547 = icmp eq i32 %t1520, 8
  %t1548 = select i1 %t1547, i8* %t1546, i8* %t1545
  %t1549 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1550 = icmp eq i32 %t1520, 9
  %t1551 = select i1 %t1550, i8* %t1549, i8* %t1548
  %t1552 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1553 = icmp eq i32 %t1520, 10
  %t1554 = select i1 %t1553, i8* %t1552, i8* %t1551
  %t1555 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1556 = icmp eq i32 %t1520, 11
  %t1557 = select i1 %t1556, i8* %t1555, i8* %t1554
  %t1558 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1559 = icmp eq i32 %t1520, 12
  %t1560 = select i1 %t1559, i8* %t1558, i8* %t1557
  %t1561 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1562 = icmp eq i32 %t1520, 13
  %t1563 = select i1 %t1562, i8* %t1561, i8* %t1560
  %t1564 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1565 = icmp eq i32 %t1520, 14
  %t1566 = select i1 %t1565, i8* %t1564, i8* %t1563
  %t1567 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1568 = icmp eq i32 %t1520, 15
  %t1569 = select i1 %t1568, i8* %t1567, i8* %t1566
  %t1570 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1571 = icmp eq i32 %t1520, 16
  %t1572 = select i1 %t1571, i8* %t1570, i8* %t1569
  %t1573 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1574 = icmp eq i32 %t1520, 17
  %t1575 = select i1 %t1574, i8* %t1573, i8* %t1572
  %t1576 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1577 = icmp eq i32 %t1520, 18
  %t1578 = select i1 %t1577, i8* %t1576, i8* %t1575
  %t1579 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1580 = icmp eq i32 %t1520, 19
  %t1581 = select i1 %t1580, i8* %t1579, i8* %t1578
  %t1582 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1583 = icmp eq i32 %t1520, 20
  %t1584 = select i1 %t1583, i8* %t1582, i8* %t1581
  %t1585 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1586 = icmp eq i32 %t1520, 21
  %t1587 = select i1 %t1586, i8* %t1585, i8* %t1584
  %t1588 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1589 = icmp eq i32 %t1520, 22
  %t1590 = select i1 %t1589, i8* %t1588, i8* %t1587
  %s1591 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1591, i32 0, i32 0
  %t1592 = icmp eq i8* %t1590, %s1591
  br i1 %t1592, label %then38, label %merge39
then38:
  %t1593 = extractvalue %Statement %statement, 0
  %t1594 = alloca %Statement
  store %Statement %statement, %Statement* %t1594
  %t1595 = getelementptr inbounds %Statement, %Statement* %t1594, i32 0, i32 1
  %t1596 = bitcast [24 x i8]* %t1595 to i8*
  %t1597 = getelementptr inbounds i8, i8* %t1596, i64 8
  %t1598 = bitcast i8* %t1597 to %Block*
  %t1599 = load %Block, %Block* %t1598
  %t1600 = icmp eq i32 %t1593, 4
  %t1601 = select i1 %t1600, %Block %t1599, %Block zeroinitializer
  %t1602 = getelementptr inbounds %Statement, %Statement* %t1594, i32 0, i32 1
  %t1603 = bitcast [24 x i8]* %t1602 to i8*
  %t1604 = getelementptr inbounds i8, i8* %t1603, i64 8
  %t1605 = bitcast i8* %t1604 to %Block*
  %t1606 = load %Block, %Block* %t1605
  %t1607 = icmp eq i32 %t1593, 5
  %t1608 = select i1 %t1607, %Block %t1606, %Block %t1601
  %t1609 = getelementptr inbounds %Statement, %Statement* %t1594, i32 0, i32 1
  %t1610 = bitcast [40 x i8]* %t1609 to i8*
  %t1611 = getelementptr inbounds i8, i8* %t1610, i64 16
  %t1612 = bitcast i8* %t1611 to %Block*
  %t1613 = load %Block, %Block* %t1612
  %t1614 = icmp eq i32 %t1593, 6
  %t1615 = select i1 %t1614, %Block %t1613, %Block %t1608
  %t1616 = getelementptr inbounds %Statement, %Statement* %t1594, i32 0, i32 1
  %t1617 = bitcast [24 x i8]* %t1616 to i8*
  %t1618 = getelementptr inbounds i8, i8* %t1617, i64 8
  %t1619 = bitcast i8* %t1618 to %Block*
  %t1620 = load %Block, %Block* %t1619
  %t1621 = icmp eq i32 %t1593, 7
  %t1622 = select i1 %t1621, %Block %t1620, %Block %t1615
  %t1623 = getelementptr inbounds %Statement, %Statement* %t1594, i32 0, i32 1
  %t1624 = bitcast [40 x i8]* %t1623 to i8*
  %t1625 = getelementptr inbounds i8, i8* %t1624, i64 24
  %t1626 = bitcast i8* %t1625 to %Block*
  %t1627 = load %Block, %Block* %t1626
  %t1628 = icmp eq i32 %t1593, 12
  %t1629 = select i1 %t1628, %Block %t1627, %Block %t1622
  %t1630 = getelementptr inbounds %Statement, %Statement* %t1594, i32 0, i32 1
  %t1631 = bitcast [24 x i8]* %t1630 to i8*
  %t1632 = getelementptr inbounds i8, i8* %t1631, i64 8
  %t1633 = bitcast i8* %t1632 to %Block*
  %t1634 = load %Block, %Block* %t1633
  %t1635 = icmp eq i32 %t1593, 13
  %t1636 = select i1 %t1635, %Block %t1634, %Block %t1629
  %t1637 = getelementptr inbounds %Statement, %Statement* %t1594, i32 0, i32 1
  %t1638 = bitcast [24 x i8]* %t1637 to i8*
  %t1639 = getelementptr inbounds i8, i8* %t1638, i64 8
  %t1640 = bitcast i8* %t1639 to %Block*
  %t1641 = load %Block, %Block* %t1640
  %t1642 = icmp eq i32 %t1593, 14
  %t1643 = select i1 %t1642, %Block %t1641, %Block %t1636
  %t1644 = getelementptr inbounds %Statement, %Statement* %t1594, i32 0, i32 1
  %t1645 = bitcast [16 x i8]* %t1644 to i8*
  %t1646 = bitcast i8* %t1645 to %Block*
  %t1647 = load %Block, %Block* %t1646
  %t1648 = icmp eq i32 %t1593, 15
  %t1649 = select i1 %t1648, %Block %t1647, %Block %t1643
  %t1650 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1649)
  ret { %EffectRequirement*, i64 }* %t1650
merge39:
  %t1651 = extractvalue %Statement %statement, 0
  %t1652 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1653 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1654 = icmp eq i32 %t1651, 0
  %t1655 = select i1 %t1654, i8* %t1653, i8* %t1652
  %t1656 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1657 = icmp eq i32 %t1651, 1
  %t1658 = select i1 %t1657, i8* %t1656, i8* %t1655
  %t1659 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1660 = icmp eq i32 %t1651, 2
  %t1661 = select i1 %t1660, i8* %t1659, i8* %t1658
  %t1662 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1663 = icmp eq i32 %t1651, 3
  %t1664 = select i1 %t1663, i8* %t1662, i8* %t1661
  %t1665 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1666 = icmp eq i32 %t1651, 4
  %t1667 = select i1 %t1666, i8* %t1665, i8* %t1664
  %t1668 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1669 = icmp eq i32 %t1651, 5
  %t1670 = select i1 %t1669, i8* %t1668, i8* %t1667
  %t1671 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1672 = icmp eq i32 %t1651, 6
  %t1673 = select i1 %t1672, i8* %t1671, i8* %t1670
  %t1674 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1675 = icmp eq i32 %t1651, 7
  %t1676 = select i1 %t1675, i8* %t1674, i8* %t1673
  %t1677 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1678 = icmp eq i32 %t1651, 8
  %t1679 = select i1 %t1678, i8* %t1677, i8* %t1676
  %t1680 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1681 = icmp eq i32 %t1651, 9
  %t1682 = select i1 %t1681, i8* %t1680, i8* %t1679
  %t1683 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1684 = icmp eq i32 %t1651, 10
  %t1685 = select i1 %t1684, i8* %t1683, i8* %t1682
  %t1686 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1687 = icmp eq i32 %t1651, 11
  %t1688 = select i1 %t1687, i8* %t1686, i8* %t1685
  %t1689 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1690 = icmp eq i32 %t1651, 12
  %t1691 = select i1 %t1690, i8* %t1689, i8* %t1688
  %t1692 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1693 = icmp eq i32 %t1651, 13
  %t1694 = select i1 %t1693, i8* %t1692, i8* %t1691
  %t1695 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1696 = icmp eq i32 %t1651, 14
  %t1697 = select i1 %t1696, i8* %t1695, i8* %t1694
  %t1698 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1699 = icmp eq i32 %t1651, 15
  %t1700 = select i1 %t1699, i8* %t1698, i8* %t1697
  %t1701 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1702 = icmp eq i32 %t1651, 16
  %t1703 = select i1 %t1702, i8* %t1701, i8* %t1700
  %t1704 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1705 = icmp eq i32 %t1651, 17
  %t1706 = select i1 %t1705, i8* %t1704, i8* %t1703
  %t1707 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1708 = icmp eq i32 %t1651, 18
  %t1709 = select i1 %t1708, i8* %t1707, i8* %t1706
  %t1710 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1711 = icmp eq i32 %t1651, 19
  %t1712 = select i1 %t1711, i8* %t1710, i8* %t1709
  %t1713 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1714 = icmp eq i32 %t1651, 20
  %t1715 = select i1 %t1714, i8* %t1713, i8* %t1712
  %t1716 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1717 = icmp eq i32 %t1651, 21
  %t1718 = select i1 %t1717, i8* %t1716, i8* %t1715
  %t1719 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1720 = icmp eq i32 %t1651, 22
  %t1721 = select i1 %t1720, i8* %t1719, i8* %t1718
  %s1722 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1722, i32 0, i32 0
  %t1723 = icmp eq i8* %t1721, %s1722
  br i1 %t1723, label %then40, label %merge41
then40:
  %t1724 = alloca [0 x %EffectRequirement]
  %t1725 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1724, i32 0, i32 0
  %t1726 = alloca { %EffectRequirement*, i64 }
  %t1727 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1726, i32 0, i32 0
  store %EffectRequirement* %t1725, %EffectRequirement** %t1727
  %t1728 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1726, i32 0, i32 1
  store i64 0, i64* %t1728
  store { %EffectRequirement*, i64 }* %t1726, { %EffectRequirement*, i64 }** %l8
  %t1729 = sitofp i64 0 to double
  store double %t1729, double* %l9
  %t1730 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1731 = load double, double* %l9
  br label %loop.header42
loop.header42:
  %t1775 = phi { %EffectRequirement*, i64 }* [ %t1730, %then40 ], [ %t1773, %loop.latch44 ]
  %t1776 = phi double [ %t1731, %then40 ], [ %t1774, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1775, { %EffectRequirement*, i64 }** %l8
  store double %t1776, double* %l9
  br label %loop.body43
loop.body43:
  %t1732 = load double, double* %l9
  %t1733 = extractvalue %Statement %statement, 0
  %t1734 = alloca %Statement
  store %Statement %statement, %Statement* %t1734
  %t1735 = getelementptr inbounds %Statement, %Statement* %t1734, i32 0, i32 1
  %t1736 = bitcast [56 x i8]* %t1735 to i8*
  %t1737 = getelementptr inbounds i8, i8* %t1736, i64 40
  %t1738 = bitcast i8* %t1737 to { %MethodDeclaration**, i64 }**
  %t1739 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1738
  %t1740 = icmp eq i32 %t1733, 8
  %t1741 = select i1 %t1740, { %MethodDeclaration**, i64 }* %t1739, { %MethodDeclaration**, i64 }* null
  %t1742 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1741
  %t1743 = extractvalue { %MethodDeclaration**, i64 } %t1742, 1
  %t1744 = sitofp i64 %t1743 to double
  %t1745 = fcmp oge double %t1732, %t1744
  %t1746 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1747 = load double, double* %l9
  br i1 %t1745, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1748 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1749 = extractvalue %Statement %statement, 0
  %t1750 = alloca %Statement
  store %Statement %statement, %Statement* %t1750
  %t1751 = getelementptr inbounds %Statement, %Statement* %t1750, i32 0, i32 1
  %t1752 = bitcast [56 x i8]* %t1751 to i8*
  %t1753 = getelementptr inbounds i8, i8* %t1752, i64 40
  %t1754 = bitcast i8* %t1753 to { %MethodDeclaration**, i64 }**
  %t1755 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1754
  %t1756 = icmp eq i32 %t1749, 8
  %t1757 = select i1 %t1756, { %MethodDeclaration**, i64 }* %t1755, { %MethodDeclaration**, i64 }* null
  %t1758 = load double, double* %l9
  %t1759 = fptosi double %t1758 to i64
  %t1760 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1757
  %t1761 = extractvalue { %MethodDeclaration**, i64 } %t1760, 0
  %t1762 = extractvalue { %MethodDeclaration**, i64 } %t1760, 1
  %t1763 = icmp uge i64 %t1759, %t1762
  ; bounds check: %t1763 (if true, out of bounds)
  %t1764 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1761, i64 %t1759
  %t1765 = load %MethodDeclaration*, %MethodDeclaration** %t1764
  %t1766 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1765, i32 0, i32 1
  %t1767 = load %Block, %Block* %t1766
  %t1768 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1767)
  %t1769 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1748, { %EffectRequirement*, i64 }* %t1768)
  store { %EffectRequirement*, i64 }* %t1769, { %EffectRequirement*, i64 }** %l8
  %t1770 = load double, double* %l9
  %t1771 = sitofp i64 1 to double
  %t1772 = fadd double %t1770, %t1771
  store double %t1772, double* %l9
  br label %loop.latch44
loop.latch44:
  %t1773 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1774 = load double, double* %l9
  br label %loop.header42
afterloop45:
  %t1777 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  ret { %EffectRequirement*, i64 }* %t1777
merge41:
  %t1778 = extractvalue %Statement %statement, 0
  %t1779 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1780 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1781 = icmp eq i32 %t1778, 0
  %t1782 = select i1 %t1781, i8* %t1780, i8* %t1779
  %t1783 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1784 = icmp eq i32 %t1778, 1
  %t1785 = select i1 %t1784, i8* %t1783, i8* %t1782
  %t1786 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1787 = icmp eq i32 %t1778, 2
  %t1788 = select i1 %t1787, i8* %t1786, i8* %t1785
  %t1789 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1790 = icmp eq i32 %t1778, 3
  %t1791 = select i1 %t1790, i8* %t1789, i8* %t1788
  %t1792 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1793 = icmp eq i32 %t1778, 4
  %t1794 = select i1 %t1793, i8* %t1792, i8* %t1791
  %t1795 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1796 = icmp eq i32 %t1778, 5
  %t1797 = select i1 %t1796, i8* %t1795, i8* %t1794
  %t1798 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1799 = icmp eq i32 %t1778, 6
  %t1800 = select i1 %t1799, i8* %t1798, i8* %t1797
  %t1801 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1802 = icmp eq i32 %t1778, 7
  %t1803 = select i1 %t1802, i8* %t1801, i8* %t1800
  %t1804 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1805 = icmp eq i32 %t1778, 8
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1803
  %t1807 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1808 = icmp eq i32 %t1778, 9
  %t1809 = select i1 %t1808, i8* %t1807, i8* %t1806
  %t1810 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1811 = icmp eq i32 %t1778, 10
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1809
  %t1813 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1814 = icmp eq i32 %t1778, 11
  %t1815 = select i1 %t1814, i8* %t1813, i8* %t1812
  %t1816 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1817 = icmp eq i32 %t1778, 12
  %t1818 = select i1 %t1817, i8* %t1816, i8* %t1815
  %t1819 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1820 = icmp eq i32 %t1778, 13
  %t1821 = select i1 %t1820, i8* %t1819, i8* %t1818
  %t1822 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1823 = icmp eq i32 %t1778, 14
  %t1824 = select i1 %t1823, i8* %t1822, i8* %t1821
  %t1825 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1826 = icmp eq i32 %t1778, 15
  %t1827 = select i1 %t1826, i8* %t1825, i8* %t1824
  %t1828 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1829 = icmp eq i32 %t1778, 16
  %t1830 = select i1 %t1829, i8* %t1828, i8* %t1827
  %t1831 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1832 = icmp eq i32 %t1778, 17
  %t1833 = select i1 %t1832, i8* %t1831, i8* %t1830
  %t1834 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1835 = icmp eq i32 %t1778, 18
  %t1836 = select i1 %t1835, i8* %t1834, i8* %t1833
  %t1837 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1838 = icmp eq i32 %t1778, 19
  %t1839 = select i1 %t1838, i8* %t1837, i8* %t1836
  %t1840 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1841 = icmp eq i32 %t1778, 20
  %t1842 = select i1 %t1841, i8* %t1840, i8* %t1839
  %t1843 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1844 = icmp eq i32 %t1778, 21
  %t1845 = select i1 %t1844, i8* %t1843, i8* %t1842
  %t1846 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1847 = icmp eq i32 %t1778, 22
  %t1848 = select i1 %t1847, i8* %t1846, i8* %t1845
  %s1849 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1849, i32 0, i32 0
  %t1850 = icmp eq i8* %t1848, %s1849
  br i1 %t1850, label %then48, label %merge49
then48:
  %t1851 = alloca [0 x %EffectRequirement]
  %t1852 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1851, i32 0, i32 0
  %t1853 = alloca { %EffectRequirement*, i64 }
  %t1854 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1853, i32 0, i32 0
  store %EffectRequirement* %t1852, %EffectRequirement** %t1854
  %t1855 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1853, i32 0, i32 1
  store i64 0, i64* %t1855
  store { %EffectRequirement*, i64 }* %t1853, { %EffectRequirement*, i64 }** %l10
  %t1856 = sitofp i64 0 to double
  store double %t1856, double* %l11
  %t1857 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1858 = load double, double* %l11
  br label %loop.header50
loop.header50:
  %t1903 = phi { %EffectRequirement*, i64 }* [ %t1857, %then48 ], [ %t1901, %loop.latch52 ]
  %t1904 = phi double [ %t1858, %then48 ], [ %t1902, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1903, { %EffectRequirement*, i64 }** %l10
  store double %t1904, double* %l11
  br label %loop.body51
loop.body51:
  %t1859 = load double, double* %l11
  %t1860 = extractvalue %Statement %statement, 0
  %t1861 = alloca %Statement
  store %Statement %statement, %Statement* %t1861
  %t1862 = getelementptr inbounds %Statement, %Statement* %t1861, i32 0, i32 1
  %t1863 = bitcast [48 x i8]* %t1862 to i8*
  %t1864 = getelementptr inbounds i8, i8* %t1863, i64 24
  %t1865 = bitcast i8* %t1864 to { %ModelProperty**, i64 }**
  %t1866 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1865
  %t1867 = icmp eq i32 %t1860, 3
  %t1868 = select i1 %t1867, { %ModelProperty**, i64 }* %t1866, { %ModelProperty**, i64 }* null
  %t1869 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1868
  %t1870 = extractvalue { %ModelProperty**, i64 } %t1869, 1
  %t1871 = sitofp i64 %t1870 to double
  %t1872 = fcmp oge double %t1859, %t1871
  %t1873 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1874 = load double, double* %l11
  br i1 %t1872, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1875 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1876 = extractvalue %Statement %statement, 0
  %t1877 = alloca %Statement
  store %Statement %statement, %Statement* %t1877
  %t1878 = getelementptr inbounds %Statement, %Statement* %t1877, i32 0, i32 1
  %t1879 = bitcast [48 x i8]* %t1878 to i8*
  %t1880 = getelementptr inbounds i8, i8* %t1879, i64 24
  %t1881 = bitcast i8* %t1880 to { %ModelProperty**, i64 }**
  %t1882 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1881
  %t1883 = icmp eq i32 %t1876, 3
  %t1884 = select i1 %t1883, { %ModelProperty**, i64 }* %t1882, { %ModelProperty**, i64 }* null
  %t1885 = load double, double* %l11
  %t1886 = fptosi double %t1885 to i64
  %t1887 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1884
  %t1888 = extractvalue { %ModelProperty**, i64 } %t1887, 0
  %t1889 = extractvalue { %ModelProperty**, i64 } %t1887, 1
  %t1890 = icmp uge i64 %t1886, %t1889
  ; bounds check: %t1890 (if true, out of bounds)
  %t1891 = getelementptr %ModelProperty*, %ModelProperty** %t1888, i64 %t1886
  %t1892 = load %ModelProperty*, %ModelProperty** %t1891
  %t1893 = getelementptr %ModelProperty, %ModelProperty* %t1892, i32 0, i32 1
  %t1894 = load %Expression, %Expression* %t1893
  %t1895 = alloca %Expression
  store %Expression %t1894, %Expression* %t1895
  %t1896 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1895)
  %t1897 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1875, { %EffectRequirement*, i64 }* %t1896)
  store { %EffectRequirement*, i64 }* %t1897, { %EffectRequirement*, i64 }** %l10
  %t1898 = load double, double* %l11
  %t1899 = sitofp i64 1 to double
  %t1900 = fadd double %t1898, %t1899
  store double %t1900, double* %l11
  br label %loop.latch52
loop.latch52:
  %t1901 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1902 = load double, double* %l11
  br label %loop.header50
afterloop53:
  %t1905 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t1905
merge49:
  %t1906 = extractvalue %Statement %statement, 0
  %t1907 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1908 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1909 = icmp eq i32 %t1906, 0
  %t1910 = select i1 %t1909, i8* %t1908, i8* %t1907
  %t1911 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1912 = icmp eq i32 %t1906, 1
  %t1913 = select i1 %t1912, i8* %t1911, i8* %t1910
  %t1914 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1915 = icmp eq i32 %t1906, 2
  %t1916 = select i1 %t1915, i8* %t1914, i8* %t1913
  %t1917 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1918 = icmp eq i32 %t1906, 3
  %t1919 = select i1 %t1918, i8* %t1917, i8* %t1916
  %t1920 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1921 = icmp eq i32 %t1906, 4
  %t1922 = select i1 %t1921, i8* %t1920, i8* %t1919
  %t1923 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1924 = icmp eq i32 %t1906, 5
  %t1925 = select i1 %t1924, i8* %t1923, i8* %t1922
  %t1926 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1927 = icmp eq i32 %t1906, 6
  %t1928 = select i1 %t1927, i8* %t1926, i8* %t1925
  %t1929 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1930 = icmp eq i32 %t1906, 7
  %t1931 = select i1 %t1930, i8* %t1929, i8* %t1928
  %t1932 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1933 = icmp eq i32 %t1906, 8
  %t1934 = select i1 %t1933, i8* %t1932, i8* %t1931
  %t1935 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1936 = icmp eq i32 %t1906, 9
  %t1937 = select i1 %t1936, i8* %t1935, i8* %t1934
  %t1938 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1939 = icmp eq i32 %t1906, 10
  %t1940 = select i1 %t1939, i8* %t1938, i8* %t1937
  %t1941 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1942 = icmp eq i32 %t1906, 11
  %t1943 = select i1 %t1942, i8* %t1941, i8* %t1940
  %t1944 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1945 = icmp eq i32 %t1906, 12
  %t1946 = select i1 %t1945, i8* %t1944, i8* %t1943
  %t1947 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1948 = icmp eq i32 %t1906, 13
  %t1949 = select i1 %t1948, i8* %t1947, i8* %t1946
  %t1950 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1951 = icmp eq i32 %t1906, 14
  %t1952 = select i1 %t1951, i8* %t1950, i8* %t1949
  %t1953 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1954 = icmp eq i32 %t1906, 15
  %t1955 = select i1 %t1954, i8* %t1953, i8* %t1952
  %t1956 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1957 = icmp eq i32 %t1906, 16
  %t1958 = select i1 %t1957, i8* %t1956, i8* %t1955
  %t1959 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1960 = icmp eq i32 %t1906, 17
  %t1961 = select i1 %t1960, i8* %t1959, i8* %t1958
  %t1962 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1963 = icmp eq i32 %t1906, 18
  %t1964 = select i1 %t1963, i8* %t1962, i8* %t1961
  %t1965 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1966 = icmp eq i32 %t1906, 19
  %t1967 = select i1 %t1966, i8* %t1965, i8* %t1964
  %t1968 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1969 = icmp eq i32 %t1906, 20
  %t1970 = select i1 %t1969, i8* %t1968, i8* %t1967
  %t1971 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1972 = icmp eq i32 %t1906, 21
  %t1973 = select i1 %t1972, i8* %t1971, i8* %t1970
  %t1974 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1975 = icmp eq i32 %t1906, 22
  %t1976 = select i1 %t1975, i8* %t1974, i8* %t1973
  %s1977 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1977, i32 0, i32 0
  %t1978 = icmp eq i8* %t1976, %s1977
  br i1 %t1978, label %then56, label %merge57
then56:
  %t1979 = extractvalue %Statement %statement, 0
  %t1980 = alloca %Statement
  store %Statement %statement, %Statement* %t1980
  %t1981 = getelementptr inbounds %Statement, %Statement* %t1980, i32 0, i32 1
  %t1982 = bitcast [16 x i8]* %t1981 to i8*
  %t1983 = bitcast i8* %t1982 to { %Token**, i64 }**
  %t1984 = load { %Token**, i64 }*, { %Token**, i64 }** %t1983
  %t1985 = icmp eq i32 %t1979, 22
  %t1986 = select i1 %t1985, { %Token**, i64 }* %t1984, { %Token**, i64 }* null
  %t1987 = bitcast { %Token**, i64 }* %t1986 to { %Token*, i64 }*
  %t1988 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1987)
  ret { %EffectRequirement*, i64 }* %t1988
merge57:
  %t1989 = alloca [0 x %EffectRequirement]
  %t1990 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1989, i32 0, i32 0
  %t1991 = alloca { %EffectRequirement*, i64 }
  %t1992 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1991, i32 0, i32 0
  store %EffectRequirement* %t1990, %EffectRequirement** %t1992
  %t1993 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1991, i32 0, i32 1
  store i64 0, i64* %t1993
  ret { %EffectRequirement*, i64 }* %t1991
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
  %t6 = icmp ne %Block* %t5, null
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = extractvalue %ElseBranch %branch, 1
  %t10 = load %Block, %Block* %t9
  %t11 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t10)
  %t12 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t8, { %EffectRequirement*, i64 }* %t11)
  store { %EffectRequirement*, i64 }* %t12, { %EffectRequirement*, i64 }** %l0
  br label %merge1
merge1:
  %t13 = phi { %EffectRequirement*, i64 }* [ %t12, %then0 ], [ %t7, %entry ]
  store { %EffectRequirement*, i64 }* %t13, { %EffectRequirement*, i64 }** %l0
  %t14 = extractvalue %ElseBranch %branch, 0
  %t15 = icmp ne %Statement* %t14, null
  %t16 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t15, label %then2, label %merge3
then2:
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t18 = extractvalue %ElseBranch %branch, 0
  %t19 = load %Statement, %Statement* %t18
  %t20 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %t19)
  %t21 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t17, { %EffectRequirement*, i64 }* %t20)
  store { %EffectRequirement*, i64 }* %t21, { %EffectRequirement*, i64 }** %l0
  br label %merge3
merge3:
  %t22 = phi { %EffectRequirement*, i64 }* [ %t21, %then2 ], [ %t16, %entry ]
  store { %EffectRequirement*, i64 }* %t22, { %EffectRequirement*, i64 }** %l0
  %t23 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t23
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
  %t4 = icmp ne %Expression* %t3, null
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t7 = extractvalue %MatchCase %case, 1
  %t8 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t7)
  %t9 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t6, { %EffectRequirement*, i64 }* %t8)
  store { %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }** %l0
  br label %merge1
merge1:
  %t10 = phi { %EffectRequirement*, i64 }* [ %t9, %then0 ], [ %t5, %entry ]
  store { %EffectRequirement*, i64 }* %t10, { %EffectRequirement*, i64 }** %l0
  %t11 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t12 = extractvalue %MatchCase %case, 2
  %t13 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t12)
  %t14 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t11, { %EffectRequirement*, i64 }* %t13)
  store { %EffectRequirement*, i64 }* %t14, { %EffectRequirement*, i64 }** %l0
  %t15 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t15
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
  %t0 = icmp eq %Expression* %expression, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = alloca [0 x %EffectRequirement]
  %t2 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1, i32 0, i32 0
  %t3 = alloca { %EffectRequirement*, i64 }
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 0
  store %EffectRequirement* %t2, %EffectRequirement** %t4
  %t5 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  ret { %EffectRequirement*, i64 }* %t3
merge1:
  %t6 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t7 = load i32, i32* %t6
  %t8 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t9 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t10 = icmp eq i32 %t7, 0
  %t11 = select i1 %t10, i8* %t9, i8* %t8
  %t12 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t13 = icmp eq i32 %t7, 1
  %t14 = select i1 %t13, i8* %t12, i8* %t11
  %t15 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t16 = icmp eq i32 %t7, 2
  %t17 = select i1 %t16, i8* %t15, i8* %t14
  %t18 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t19 = icmp eq i32 %t7, 3
  %t20 = select i1 %t19, i8* %t18, i8* %t17
  %t21 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t22 = icmp eq i32 %t7, 4
  %t23 = select i1 %t22, i8* %t21, i8* %t20
  %t24 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t25 = icmp eq i32 %t7, 5
  %t26 = select i1 %t25, i8* %t24, i8* %t23
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t28 = icmp eq i32 %t7, 6
  %t29 = select i1 %t28, i8* %t27, i8* %t26
  %t30 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t31 = icmp eq i32 %t7, 7
  %t32 = select i1 %t31, i8* %t30, i8* %t29
  %t33 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t34 = icmp eq i32 %t7, 8
  %t35 = select i1 %t34, i8* %t33, i8* %t32
  %t36 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t37 = icmp eq i32 %t7, 9
  %t38 = select i1 %t37, i8* %t36, i8* %t35
  %t39 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t40 = icmp eq i32 %t7, 10
  %t41 = select i1 %t40, i8* %t39, i8* %t38
  %t42 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t43 = icmp eq i32 %t7, 11
  %t44 = select i1 %t43, i8* %t42, i8* %t41
  %t45 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t46 = icmp eq i32 %t7, 12
  %t47 = select i1 %t46, i8* %t45, i8* %t44
  %t48 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t49 = icmp eq i32 %t7, 13
  %t50 = select i1 %t49, i8* %t48, i8* %t47
  %t51 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t52 = icmp eq i32 %t7, 14
  %t53 = select i1 %t52, i8* %t51, i8* %t50
  %t54 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t55 = icmp eq i32 %t7, 15
  %t56 = select i1 %t55, i8* %t54, i8* %t53
  %s57 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.57, i32 0, i32 0
  %t58 = icmp eq i8* %t56, %s57
  br i1 %t58, label %then2, label %merge3
then2:
  %t59 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t60 = load i32, i32* %t59
  %t61 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t62 = bitcast [16 x i8]* %t61 to i8*
  %t63 = bitcast i8* %t62 to %Expression**
  %t64 = load %Expression*, %Expression** %t63
  %t65 = icmp eq i32 %t60, 8
  %t66 = select i1 %t65, %Expression* %t64, %Expression* null
  %t67 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t66)
  store { %EffectRequirement*, i64 }* %t67, { %EffectRequirement*, i64 }** %l0
  %t68 = sitofp i64 0 to double
  store double %t68, double* %l1
  %t69 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t70 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t112 = phi { %EffectRequirement*, i64 }* [ %t69, %then2 ], [ %t110, %loop.latch6 ]
  %t113 = phi double [ %t70, %then2 ], [ %t111, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t112, { %EffectRequirement*, i64 }** %l0
  store double %t113, double* %l1
  br label %loop.body5
loop.body5:
  %t71 = load double, double* %l1
  %t72 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t73 = load i32, i32* %t72
  %t74 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t75 = bitcast [16 x i8]* %t74 to i8*
  %t76 = getelementptr inbounds i8, i8* %t75, i64 8
  %t77 = bitcast i8* %t76 to { %Expression**, i64 }**
  %t78 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t77
  %t79 = icmp eq i32 %t73, 8
  %t80 = select i1 %t79, { %Expression**, i64 }* %t78, { %Expression**, i64 }* null
  %t81 = load { %Expression**, i64 }, { %Expression**, i64 }* %t80
  %t82 = extractvalue { %Expression**, i64 } %t81, 1
  %t83 = sitofp i64 %t82 to double
  %t84 = fcmp oge double %t71, %t83
  %t85 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t86 = load double, double* %l1
  br i1 %t84, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t87 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t88 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t89 = load i32, i32* %t88
  %t90 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t91 = bitcast [16 x i8]* %t90 to i8*
  %t92 = getelementptr inbounds i8, i8* %t91, i64 8
  %t93 = bitcast i8* %t92 to { %Expression**, i64 }**
  %t94 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t93
  %t95 = icmp eq i32 %t89, 8
  %t96 = select i1 %t95, { %Expression**, i64 }* %t94, { %Expression**, i64 }* null
  %t97 = load double, double* %l1
  %t98 = fptosi double %t97 to i64
  %t99 = load { %Expression**, i64 }, { %Expression**, i64 }* %t96
  %t100 = extractvalue { %Expression**, i64 } %t99, 0
  %t101 = extractvalue { %Expression**, i64 } %t99, 1
  %t102 = icmp uge i64 %t98, %t101
  ; bounds check: %t102 (if true, out of bounds)
  %t103 = getelementptr %Expression*, %Expression** %t100, i64 %t98
  %t104 = load %Expression*, %Expression** %t103
  %t105 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t104)
  %t106 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t87, { %EffectRequirement*, i64 }* %t105)
  store { %EffectRequirement*, i64 }* %t106, { %EffectRequirement*, i64 }** %l0
  %t107 = load double, double* %l1
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  store double %t109, double* %l1
  br label %loop.latch6
loop.latch6:
  %t110 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t111 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t114 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t114
merge3:
  %t115 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t116 = load i32, i32* %t115
  %t117 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t118 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t116, 0
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t116, 1
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t116, 2
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t116, 3
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t116, 4
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t116, 5
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t116, 6
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t116, 7
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t116, 8
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t116, 9
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t116, 10
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t116, 11
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t116, 12
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t116, 13
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t116, 14
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t116, 15
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %s166 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.166, i32 0, i32 0
  %t167 = icmp eq i8* %t165, %s166
  br i1 %t167, label %then10, label %merge11
then10:
  %t168 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t169 = load i32, i32* %t168
  %t170 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t171 = bitcast [16 x i8]* %t170 to i8*
  %t172 = bitcast i8* %t171 to %Expression**
  %t173 = load %Expression*, %Expression** %t172
  %t174 = icmp eq i32 %t169, 7
  %t175 = select i1 %t174, %Expression* %t173, %Expression* null
  %t176 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t175)
  ret { %EffectRequirement*, i64 }* %t176
merge11:
  %t177 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t178 = load i32, i32* %t177
  %t179 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t180 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t178, 0
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t178, 1
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t178, 2
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t178, 3
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t178, 4
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t178, 5
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t178, 6
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t178, 7
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %t204 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t205 = icmp eq i32 %t178, 8
  %t206 = select i1 %t205, i8* %t204, i8* %t203
  %t207 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t208 = icmp eq i32 %t178, 9
  %t209 = select i1 %t208, i8* %t207, i8* %t206
  %t210 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t211 = icmp eq i32 %t178, 10
  %t212 = select i1 %t211, i8* %t210, i8* %t209
  %t213 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t214 = icmp eq i32 %t178, 11
  %t215 = select i1 %t214, i8* %t213, i8* %t212
  %t216 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t217 = icmp eq i32 %t178, 12
  %t218 = select i1 %t217, i8* %t216, i8* %t215
  %t219 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t220 = icmp eq i32 %t178, 13
  %t221 = select i1 %t220, i8* %t219, i8* %t218
  %t222 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t223 = icmp eq i32 %t178, 14
  %t224 = select i1 %t223, i8* %t222, i8* %t221
  %t225 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t226 = icmp eq i32 %t178, 15
  %t227 = select i1 %t226, i8* %t225, i8* %t224
  %s228 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.228, i32 0, i32 0
  %t229 = icmp eq i8* %t227, %s228
  br i1 %t229, label %then12, label %merge13
then12:
  %t230 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t231 = load i32, i32* %t230
  %t232 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t233 = bitcast [16 x i8]* %t232 to i8*
  %t234 = getelementptr inbounds i8, i8* %t233, i64 8
  %t235 = bitcast i8* %t234 to %Expression**
  %t236 = load %Expression*, %Expression** %t235
  %t237 = icmp eq i32 %t231, 5
  %t238 = select i1 %t237, %Expression* %t236, %Expression* null
  %t239 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t238)
  ret { %EffectRequirement*, i64 }* %t239
merge13:
  %t240 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t241 = load i32, i32* %t240
  %t242 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t243 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t244 = icmp eq i32 %t241, 0
  %t245 = select i1 %t244, i8* %t243, i8* %t242
  %t246 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t247 = icmp eq i32 %t241, 1
  %t248 = select i1 %t247, i8* %t246, i8* %t245
  %t249 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t250 = icmp eq i32 %t241, 2
  %t251 = select i1 %t250, i8* %t249, i8* %t248
  %t252 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t253 = icmp eq i32 %t241, 3
  %t254 = select i1 %t253, i8* %t252, i8* %t251
  %t255 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t256 = icmp eq i32 %t241, 4
  %t257 = select i1 %t256, i8* %t255, i8* %t254
  %t258 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t259 = icmp eq i32 %t241, 5
  %t260 = select i1 %t259, i8* %t258, i8* %t257
  %t261 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t262 = icmp eq i32 %t241, 6
  %t263 = select i1 %t262, i8* %t261, i8* %t260
  %t264 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t265 = icmp eq i32 %t241, 7
  %t266 = select i1 %t265, i8* %t264, i8* %t263
  %t267 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t268 = icmp eq i32 %t241, 8
  %t269 = select i1 %t268, i8* %t267, i8* %t266
  %t270 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t271 = icmp eq i32 %t241, 9
  %t272 = select i1 %t271, i8* %t270, i8* %t269
  %t273 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t274 = icmp eq i32 %t241, 10
  %t275 = select i1 %t274, i8* %t273, i8* %t272
  %t276 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t277 = icmp eq i32 %t241, 11
  %t278 = select i1 %t277, i8* %t276, i8* %t275
  %t279 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t280 = icmp eq i32 %t241, 12
  %t281 = select i1 %t280, i8* %t279, i8* %t278
  %t282 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t283 = icmp eq i32 %t241, 13
  %t284 = select i1 %t283, i8* %t282, i8* %t281
  %t285 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t286 = icmp eq i32 %t241, 14
  %t287 = select i1 %t286, i8* %t285, i8* %t284
  %t288 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t289 = icmp eq i32 %t241, 15
  %t290 = select i1 %t289, i8* %t288, i8* %t287
  %s291 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.291, i32 0, i32 0
  %t292 = icmp eq i8* %t290, %s291
  br i1 %t292, label %then14, label %merge15
then14:
  %t293 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t294 = load i32, i32* %t293
  %t295 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t296 = bitcast [24 x i8]* %t295 to i8*
  %t297 = getelementptr inbounds i8, i8* %t296, i64 8
  %t298 = bitcast i8* %t297 to %Expression**
  %t299 = load %Expression*, %Expression** %t298
  %t300 = icmp eq i32 %t294, 6
  %t301 = select i1 %t300, %Expression* %t299, %Expression* null
  %t302 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t301)
  store { %EffectRequirement*, i64 }* %t302, { %EffectRequirement*, i64 }** %l2
  %t303 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  %t304 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t305 = load i32, i32* %t304
  %t306 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t307 = bitcast [24 x i8]* %t306 to i8*
  %t308 = getelementptr inbounds i8, i8* %t307, i64 16
  %t309 = bitcast i8* %t308 to %Expression**
  %t310 = load %Expression*, %Expression** %t309
  %t311 = icmp eq i32 %t305, 6
  %t312 = select i1 %t311, %Expression* %t310, %Expression* null
  %t313 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t312)
  %t314 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t303, { %EffectRequirement*, i64 }* %t313)
  store { %EffectRequirement*, i64 }* %t314, { %EffectRequirement*, i64 }** %l2
  %t315 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l2
  ret { %EffectRequirement*, i64 }* %t315
merge15:
  %t316 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t317 = load i32, i32* %t316
  %t318 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t319 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t317, 0
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t317, 1
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t317, 2
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t317, 3
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t317, 4
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t317, 5
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t317, 6
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t317, 7
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t317, 8
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t317, 9
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t317, 10
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t317, 11
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t317, 12
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t317, 13
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t317, 14
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t317, 15
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %s367 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.367, i32 0, i32 0
  %t368 = icmp eq i8* %t366, %s367
  br i1 %t368, label %then16, label %merge17
then16:
  %t369 = alloca [0 x %EffectRequirement]
  %t370 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t369, i32 0, i32 0
  %t371 = alloca { %EffectRequirement*, i64 }
  %t372 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t371, i32 0, i32 0
  store %EffectRequirement* %t370, %EffectRequirement** %t372
  %t373 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t371, i32 0, i32 1
  store i64 0, i64* %t373
  store { %EffectRequirement*, i64 }* %t371, { %EffectRequirement*, i64 }** %l3
  %t374 = sitofp i64 0 to double
  store double %t374, double* %l4
  %t375 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t376 = load double, double* %l4
  br label %loop.header18
loop.header18:
  %t416 = phi { %EffectRequirement*, i64 }* [ %t375, %then16 ], [ %t414, %loop.latch20 ]
  %t417 = phi double [ %t376, %then16 ], [ %t415, %loop.latch20 ]
  store { %EffectRequirement*, i64 }* %t416, { %EffectRequirement*, i64 }** %l3
  store double %t417, double* %l4
  br label %loop.body19
loop.body19:
  %t377 = load double, double* %l4
  %t378 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t379 = load i32, i32* %t378
  %t380 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t381 = bitcast [8 x i8]* %t380 to i8*
  %t382 = bitcast i8* %t381 to { %Expression**, i64 }**
  %t383 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t382
  %t384 = icmp eq i32 %t379, 10
  %t385 = select i1 %t384, { %Expression**, i64 }* %t383, { %Expression**, i64 }* null
  %t386 = load { %Expression**, i64 }, { %Expression**, i64 }* %t385
  %t387 = extractvalue { %Expression**, i64 } %t386, 1
  %t388 = sitofp i64 %t387 to double
  %t389 = fcmp oge double %t377, %t388
  %t390 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t391 = load double, double* %l4
  br i1 %t389, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t392 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t393 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t394 = load i32, i32* %t393
  %t395 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t396 = bitcast [8 x i8]* %t395 to i8*
  %t397 = bitcast i8* %t396 to { %Expression**, i64 }**
  %t398 = load { %Expression**, i64 }*, { %Expression**, i64 }** %t397
  %t399 = icmp eq i32 %t394, 10
  %t400 = select i1 %t399, { %Expression**, i64 }* %t398, { %Expression**, i64 }* null
  %t401 = load double, double* %l4
  %t402 = fptosi double %t401 to i64
  %t403 = load { %Expression**, i64 }, { %Expression**, i64 }* %t400
  %t404 = extractvalue { %Expression**, i64 } %t403, 0
  %t405 = extractvalue { %Expression**, i64 } %t403, 1
  %t406 = icmp uge i64 %t402, %t405
  ; bounds check: %t406 (if true, out of bounds)
  %t407 = getelementptr %Expression*, %Expression** %t404, i64 %t402
  %t408 = load %Expression*, %Expression** %t407
  %t409 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t408)
  %t410 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t392, { %EffectRequirement*, i64 }* %t409)
  store { %EffectRequirement*, i64 }* %t410, { %EffectRequirement*, i64 }** %l3
  %t411 = load double, double* %l4
  %t412 = sitofp i64 1 to double
  %t413 = fadd double %t411, %t412
  store double %t413, double* %l4
  br label %loop.latch20
loop.latch20:
  %t414 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  %t415 = load double, double* %l4
  br label %loop.header18
afterloop21:
  %t418 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l3
  ret { %EffectRequirement*, i64 }* %t418
merge17:
  %t419 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t420 = load i32, i32* %t419
  %t421 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t422 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t423 = icmp eq i32 %t420, 0
  %t424 = select i1 %t423, i8* %t422, i8* %t421
  %t425 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t426 = icmp eq i32 %t420, 1
  %t427 = select i1 %t426, i8* %t425, i8* %t424
  %t428 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t429 = icmp eq i32 %t420, 2
  %t430 = select i1 %t429, i8* %t428, i8* %t427
  %t431 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t432 = icmp eq i32 %t420, 3
  %t433 = select i1 %t432, i8* %t431, i8* %t430
  %t434 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t435 = icmp eq i32 %t420, 4
  %t436 = select i1 %t435, i8* %t434, i8* %t433
  %t437 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t438 = icmp eq i32 %t420, 5
  %t439 = select i1 %t438, i8* %t437, i8* %t436
  %t440 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t441 = icmp eq i32 %t420, 6
  %t442 = select i1 %t441, i8* %t440, i8* %t439
  %t443 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t444 = icmp eq i32 %t420, 7
  %t445 = select i1 %t444, i8* %t443, i8* %t442
  %t446 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t447 = icmp eq i32 %t420, 8
  %t448 = select i1 %t447, i8* %t446, i8* %t445
  %t449 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t450 = icmp eq i32 %t420, 9
  %t451 = select i1 %t450, i8* %t449, i8* %t448
  %t452 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t453 = icmp eq i32 %t420, 10
  %t454 = select i1 %t453, i8* %t452, i8* %t451
  %t455 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t456 = icmp eq i32 %t420, 11
  %t457 = select i1 %t456, i8* %t455, i8* %t454
  %t458 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t459 = icmp eq i32 %t420, 12
  %t460 = select i1 %t459, i8* %t458, i8* %t457
  %t461 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t462 = icmp eq i32 %t420, 13
  %t463 = select i1 %t462, i8* %t461, i8* %t460
  %t464 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t465 = icmp eq i32 %t420, 14
  %t466 = select i1 %t465, i8* %t464, i8* %t463
  %t467 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t420, 15
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %s470 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.470, i32 0, i32 0
  %t471 = icmp eq i8* %t469, %s470
  br i1 %t471, label %then24, label %merge25
then24:
  %t472 = alloca [0 x %EffectRequirement]
  %t473 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t472, i32 0, i32 0
  %t474 = alloca { %EffectRequirement*, i64 }
  %t475 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t474, i32 0, i32 0
  store %EffectRequirement* %t473, %EffectRequirement** %t475
  %t476 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t474, i32 0, i32 1
  store i64 0, i64* %t476
  store { %EffectRequirement*, i64 }* %t474, { %EffectRequirement*, i64 }** %l5
  %t477 = sitofp i64 0 to double
  store double %t477, double* %l6
  %t478 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t479 = load double, double* %l6
  br label %loop.header26
loop.header26:
  %t536 = phi { %EffectRequirement*, i64 }* [ %t478, %then24 ], [ %t534, %loop.latch28 ]
  %t537 = phi double [ %t479, %then24 ], [ %t535, %loop.latch28 ]
  store { %EffectRequirement*, i64 }* %t536, { %EffectRequirement*, i64 }** %l5
  store double %t537, double* %l6
  br label %loop.body27
loop.body27:
  %t480 = load double, double* %l6
  %t481 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t482 = load i32, i32* %t481
  %t483 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t484 = bitcast [8 x i8]* %t483 to i8*
  %t485 = bitcast i8* %t484 to { %ObjectField**, i64 }**
  %t486 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t485
  %t487 = icmp eq i32 %t482, 11
  %t488 = select i1 %t487, { %ObjectField**, i64 }* %t486, { %ObjectField**, i64 }* null
  %t489 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t490 = bitcast [16 x i8]* %t489 to i8*
  %t491 = getelementptr inbounds i8, i8* %t490, i64 8
  %t492 = bitcast i8* %t491 to { %ObjectField**, i64 }**
  %t493 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t492
  %t494 = icmp eq i32 %t482, 12
  %t495 = select i1 %t494, { %ObjectField**, i64 }* %t493, { %ObjectField**, i64 }* %t488
  %t496 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t495
  %t497 = extractvalue { %ObjectField**, i64 } %t496, 1
  %t498 = sitofp i64 %t497 to double
  %t499 = fcmp oge double %t480, %t498
  %t500 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t501 = load double, double* %l6
  br i1 %t499, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t502 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t503 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t504 = load i32, i32* %t503
  %t505 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t506 = bitcast [8 x i8]* %t505 to i8*
  %t507 = bitcast i8* %t506 to { %ObjectField**, i64 }**
  %t508 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t507
  %t509 = icmp eq i32 %t504, 11
  %t510 = select i1 %t509, { %ObjectField**, i64 }* %t508, { %ObjectField**, i64 }* null
  %t511 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t512 = bitcast [16 x i8]* %t511 to i8*
  %t513 = getelementptr inbounds i8, i8* %t512, i64 8
  %t514 = bitcast i8* %t513 to { %ObjectField**, i64 }**
  %t515 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t514
  %t516 = icmp eq i32 %t504, 12
  %t517 = select i1 %t516, { %ObjectField**, i64 }* %t515, { %ObjectField**, i64 }* %t510
  %t518 = load double, double* %l6
  %t519 = fptosi double %t518 to i64
  %t520 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t517
  %t521 = extractvalue { %ObjectField**, i64 } %t520, 0
  %t522 = extractvalue { %ObjectField**, i64 } %t520, 1
  %t523 = icmp uge i64 %t519, %t522
  ; bounds check: %t523 (if true, out of bounds)
  %t524 = getelementptr %ObjectField*, %ObjectField** %t521, i64 %t519
  %t525 = load %ObjectField*, %ObjectField** %t524
  %t526 = getelementptr %ObjectField, %ObjectField* %t525, i32 0, i32 1
  %t527 = load %Expression, %Expression* %t526
  %t528 = alloca %Expression
  store %Expression %t527, %Expression* %t528
  %t529 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t528)
  %t530 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t502, { %EffectRequirement*, i64 }* %t529)
  store { %EffectRequirement*, i64 }* %t530, { %EffectRequirement*, i64 }** %l5
  %t531 = load double, double* %l6
  %t532 = sitofp i64 1 to double
  %t533 = fadd double %t531, %t532
  store double %t533, double* %l6
  br label %loop.latch28
loop.latch28:
  %t534 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t535 = load double, double* %l6
  br label %loop.header26
afterloop29:
  %t538 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t538
merge25:
  %t539 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t540 = load i32, i32* %t539
  %t541 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t542 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t543 = icmp eq i32 %t540, 0
  %t544 = select i1 %t543, i8* %t542, i8* %t541
  %t545 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t546 = icmp eq i32 %t540, 1
  %t547 = select i1 %t546, i8* %t545, i8* %t544
  %t548 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t549 = icmp eq i32 %t540, 2
  %t550 = select i1 %t549, i8* %t548, i8* %t547
  %t551 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t552 = icmp eq i32 %t540, 3
  %t553 = select i1 %t552, i8* %t551, i8* %t550
  %t554 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t555 = icmp eq i32 %t540, 4
  %t556 = select i1 %t555, i8* %t554, i8* %t553
  %t557 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t558 = icmp eq i32 %t540, 5
  %t559 = select i1 %t558, i8* %t557, i8* %t556
  %t560 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t561 = icmp eq i32 %t540, 6
  %t562 = select i1 %t561, i8* %t560, i8* %t559
  %t563 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t564 = icmp eq i32 %t540, 7
  %t565 = select i1 %t564, i8* %t563, i8* %t562
  %t566 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t567 = icmp eq i32 %t540, 8
  %t568 = select i1 %t567, i8* %t566, i8* %t565
  %t569 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t570 = icmp eq i32 %t540, 9
  %t571 = select i1 %t570, i8* %t569, i8* %t568
  %t572 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t573 = icmp eq i32 %t540, 10
  %t574 = select i1 %t573, i8* %t572, i8* %t571
  %t575 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t576 = icmp eq i32 %t540, 11
  %t577 = select i1 %t576, i8* %t575, i8* %t574
  %t578 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t579 = icmp eq i32 %t540, 12
  %t580 = select i1 %t579, i8* %t578, i8* %t577
  %t581 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t582 = icmp eq i32 %t540, 13
  %t583 = select i1 %t582, i8* %t581, i8* %t580
  %t584 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t585 = icmp eq i32 %t540, 14
  %t586 = select i1 %t585, i8* %t584, i8* %t583
  %t587 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t588 = icmp eq i32 %t540, 15
  %t589 = select i1 %t588, i8* %t587, i8* %t586
  %s590 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.590, i32 0, i32 0
  %t591 = icmp eq i8* %t589, %s590
  br i1 %t591, label %then32, label %merge33
then32:
  %t592 = alloca [0 x %EffectRequirement]
  %t593 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t592, i32 0, i32 0
  %t594 = alloca { %EffectRequirement*, i64 }
  %t595 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t594, i32 0, i32 0
  store %EffectRequirement* %t593, %EffectRequirement** %t595
  %t596 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t594, i32 0, i32 1
  store i64 0, i64* %t596
  store { %EffectRequirement*, i64 }* %t594, { %EffectRequirement*, i64 }** %l7
  %t597 = sitofp i64 0 to double
  store double %t597, double* %l8
  %t598 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t599 = load double, double* %l8
  br label %loop.header34
loop.header34:
  %t656 = phi { %EffectRequirement*, i64 }* [ %t598, %then32 ], [ %t654, %loop.latch36 ]
  %t657 = phi double [ %t599, %then32 ], [ %t655, %loop.latch36 ]
  store { %EffectRequirement*, i64 }* %t656, { %EffectRequirement*, i64 }** %l7
  store double %t657, double* %l8
  br label %loop.body35
loop.body35:
  %t600 = load double, double* %l8
  %t601 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t602 = load i32, i32* %t601
  %t603 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t604 = bitcast [8 x i8]* %t603 to i8*
  %t605 = bitcast i8* %t604 to { %ObjectField**, i64 }**
  %t606 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t605
  %t607 = icmp eq i32 %t602, 11
  %t608 = select i1 %t607, { %ObjectField**, i64 }* %t606, { %ObjectField**, i64 }* null
  %t609 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t610 = bitcast [16 x i8]* %t609 to i8*
  %t611 = getelementptr inbounds i8, i8* %t610, i64 8
  %t612 = bitcast i8* %t611 to { %ObjectField**, i64 }**
  %t613 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t612
  %t614 = icmp eq i32 %t602, 12
  %t615 = select i1 %t614, { %ObjectField**, i64 }* %t613, { %ObjectField**, i64 }* %t608
  %t616 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t615
  %t617 = extractvalue { %ObjectField**, i64 } %t616, 1
  %t618 = sitofp i64 %t617 to double
  %t619 = fcmp oge double %t600, %t618
  %t620 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t621 = load double, double* %l8
  br i1 %t619, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t622 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t623 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t624 = load i32, i32* %t623
  %t625 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t626 = bitcast [8 x i8]* %t625 to i8*
  %t627 = bitcast i8* %t626 to { %ObjectField**, i64 }**
  %t628 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t627
  %t629 = icmp eq i32 %t624, 11
  %t630 = select i1 %t629, { %ObjectField**, i64 }* %t628, { %ObjectField**, i64 }* null
  %t631 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t632 = bitcast [16 x i8]* %t631 to i8*
  %t633 = getelementptr inbounds i8, i8* %t632, i64 8
  %t634 = bitcast i8* %t633 to { %ObjectField**, i64 }**
  %t635 = load { %ObjectField**, i64 }*, { %ObjectField**, i64 }** %t634
  %t636 = icmp eq i32 %t624, 12
  %t637 = select i1 %t636, { %ObjectField**, i64 }* %t635, { %ObjectField**, i64 }* %t630
  %t638 = load double, double* %l8
  %t639 = fptosi double %t638 to i64
  %t640 = load { %ObjectField**, i64 }, { %ObjectField**, i64 }* %t637
  %t641 = extractvalue { %ObjectField**, i64 } %t640, 0
  %t642 = extractvalue { %ObjectField**, i64 } %t640, 1
  %t643 = icmp uge i64 %t639, %t642
  ; bounds check: %t643 (if true, out of bounds)
  %t644 = getelementptr %ObjectField*, %ObjectField** %t641, i64 %t639
  %t645 = load %ObjectField*, %ObjectField** %t644
  %t646 = getelementptr %ObjectField, %ObjectField* %t645, i32 0, i32 1
  %t647 = load %Expression, %Expression* %t646
  %t648 = alloca %Expression
  store %Expression %t647, %Expression* %t648
  %t649 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t648)
  %t650 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t622, { %EffectRequirement*, i64 }* %t649)
  store { %EffectRequirement*, i64 }* %t650, { %EffectRequirement*, i64 }** %l7
  %t651 = load double, double* %l8
  %t652 = sitofp i64 1 to double
  %t653 = fadd double %t651, %t652
  store double %t653, double* %l8
  br label %loop.latch36
loop.latch36:
  %t654 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t655 = load double, double* %l8
  br label %loop.header34
afterloop37:
  %t658 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t658
merge33:
  %t659 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t660 = load i32, i32* %t659
  %t661 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t662 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t660, 0
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t660, 1
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t660, 2
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t660, 3
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t660, 4
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t660, 5
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t660, 6
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t660, 7
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t660, 8
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t660, 9
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t660, 10
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t660, 11
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t660, 12
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t660, 13
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t660, 14
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t660, 15
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %s710 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.710, i32 0, i32 0
  %t711 = icmp eq i8* %t709, %s710
  br i1 %t711, label %then40, label %merge41
then40:
  %t712 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t713 = load i32, i32* %t712
  %t714 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t715 = bitcast [24 x i8]* %t714 to i8*
  %t716 = getelementptr inbounds i8, i8* %t715, i64 8
  %t717 = bitcast i8* %t716 to %Block*
  %t718 = load %Block, %Block* %t717
  %t719 = icmp eq i32 %t713, 13
  %t720 = select i1 %t719, %Block %t718, %Block zeroinitializer
  %t721 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t720)
  ret { %EffectRequirement*, i64 }* %t721
merge41:
  %t722 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t723 = load i32, i32* %t722
  %t724 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t725 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t726 = icmp eq i32 %t723, 0
  %t727 = select i1 %t726, i8* %t725, i8* %t724
  %t728 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t729 = icmp eq i32 %t723, 1
  %t730 = select i1 %t729, i8* %t728, i8* %t727
  %t731 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t723, 2
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t723, 3
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t723, 4
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t723, 5
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t723, 6
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t723, 7
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t723, 8
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t723, 9
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t723, 10
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t723, 11
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t723, 12
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t723, 13
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t723, 14
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t723, 15
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %s773 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.773, i32 0, i32 0
  %t774 = icmp eq i8* %t772, %s773
  br i1 %t774, label %then42, label %merge43
then42:
  %t775 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t776 = load i32, i32* %t775
  %t777 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t778 = bitcast [16 x i8]* %t777 to i8*
  %t779 = bitcast i8* %t778 to %Expression**
  %t780 = load %Expression*, %Expression** %t779
  %t781 = icmp eq i32 %t776, 9
  %t782 = select i1 %t781, %Expression* %t780, %Expression* null
  %t783 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t782)
  store { %EffectRequirement*, i64 }* %t783, { %EffectRequirement*, i64 }** %l9
  %t784 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t785 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t786 = load i32, i32* %t785
  %t787 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t788 = bitcast [16 x i8]* %t787 to i8*
  %t789 = getelementptr inbounds i8, i8* %t788, i64 8
  %t790 = bitcast i8* %t789 to %Expression**
  %t791 = load %Expression*, %Expression** %t790
  %t792 = icmp eq i32 %t786, 9
  %t793 = select i1 %t792, %Expression* %t791, %Expression* null
  %t794 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t793)
  %t795 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t784, { %EffectRequirement*, i64 }* %t794)
  store { %EffectRequirement*, i64 }* %t795, { %EffectRequirement*, i64 }** %l9
  %t796 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t796
merge43:
  %t797 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t798 = load i32, i32* %t797
  %t799 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t800 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t798, 0
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t798, 1
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t798, 2
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %t809 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t798, 3
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t798, 4
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t798, 5
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t798, 6
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %t821 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t822 = icmp eq i32 %t798, 7
  %t823 = select i1 %t822, i8* %t821, i8* %t820
  %t824 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t825 = icmp eq i32 %t798, 8
  %t826 = select i1 %t825, i8* %t824, i8* %t823
  %t827 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t828 = icmp eq i32 %t798, 9
  %t829 = select i1 %t828, i8* %t827, i8* %t826
  %t830 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t831 = icmp eq i32 %t798, 10
  %t832 = select i1 %t831, i8* %t830, i8* %t829
  %t833 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t834 = icmp eq i32 %t798, 11
  %t835 = select i1 %t834, i8* %t833, i8* %t832
  %t836 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t837 = icmp eq i32 %t798, 12
  %t838 = select i1 %t837, i8* %t836, i8* %t835
  %t839 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t840 = icmp eq i32 %t798, 13
  %t841 = select i1 %t840, i8* %t839, i8* %t838
  %t842 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t843 = icmp eq i32 %t798, 14
  %t844 = select i1 %t843, i8* %t842, i8* %t841
  %t845 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t846 = icmp eq i32 %t798, 15
  %t847 = select i1 %t846, i8* %t845, i8* %t844
  %s848 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.848, i32 0, i32 0
  %t849 = icmp eq i8* %t847, %s848
  br i1 %t849, label %then44, label %merge45
then44:
  %t850 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t851 = load i32, i32* %t850
  %t852 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t853 = bitcast [16 x i8]* %t852 to i8*
  %t854 = bitcast i8* %t853 to %Expression**
  %t855 = load %Expression*, %Expression** %t854
  %t856 = icmp eq i32 %t851, 14
  %t857 = select i1 %t856, %Expression* %t855, %Expression* null
  %t858 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t857)
  store { %EffectRequirement*, i64 }* %t858, { %EffectRequirement*, i64 }** %l10
  %t859 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t860 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t861 = load i32, i32* %t860
  %t862 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 1
  %t863 = bitcast [16 x i8]* %t862 to i8*
  %t864 = getelementptr inbounds i8, i8* %t863, i64 8
  %t865 = bitcast i8* %t864 to %Expression**
  %t866 = load %Expression*, %Expression** %t865
  %t867 = icmp eq i32 %t861, 14
  %t868 = select i1 %t867, %Expression* %t866, %Expression* null
  %t869 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t868)
  %t870 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t859, { %EffectRequirement*, i64 }* %t869)
  store { %EffectRequirement*, i64 }* %t870, { %EffectRequirement*, i64 }** %l10
  %t871 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t871
merge45:
  %t872 = getelementptr inbounds %Expression, %Expression* %expression, i32 0, i32 0
  %t873 = load i32, i32* %t872
  %t874 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Expression.variant.default, i32 0, i32 0
  %t875 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.Expression.Identifier.variant, i32 0, i32 0
  %t876 = icmp eq i32 %t873, 0
  %t877 = select i1 %t876, i8* %t875, i8* %t874
  %t878 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.NumberLiteral.variant, i32 0, i32 0
  %t879 = icmp eq i32 %t873, 1
  %t880 = select i1 %t879, i8* %t878, i8* %t877
  %t881 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Expression.StringLiteral.variant, i32 0, i32 0
  %t882 = icmp eq i32 %t873, 2
  %t883 = select i1 %t882, i8* %t881, i8* %t880
  %t884 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Expression.BooleanLiteral.variant, i32 0, i32 0
  %t885 = icmp eq i32 %t873, 3
  %t886 = select i1 %t885, i8* %t884, i8* %t883
  %t887 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Expression.NullLiteral.variant, i32 0, i32 0
  %t888 = icmp eq i32 %t873, 4
  %t889 = select i1 %t888, i8* %t887, i8* %t886
  %t890 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Unary.variant, i32 0, i32 0
  %t891 = icmp eq i32 %t873, 5
  %t892 = select i1 %t891, i8* %t890, i8* %t889
  %t893 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Binary.variant, i32 0, i32 0
  %t894 = icmp eq i32 %t873, 6
  %t895 = select i1 %t894, i8* %t893, i8* %t892
  %t896 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Member.variant, i32 0, i32 0
  %t897 = icmp eq i32 %t873, 7
  %t898 = select i1 %t897, i8* %t896, i8* %t895
  %t899 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.Expression.Call.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t873, 8
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Index.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t873, 9
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Array.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t873, 10
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Object.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t873, 11
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Struct.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t873, 12
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.Expression.Lambda.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t873, 13
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.Expression.Range.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t873, 14
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.Expression.Raw.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t873, 15
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %s923 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.923, i32 0, i32 0
  %t924 = icmp eq i8* %t922, %s923
  br i1 %t924, label %then46, label %merge47
then46:
  %t925 = alloca [0 x %EffectRequirement]
  %t926 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t925, i32 0, i32 0
  %t927 = alloca { %EffectRequirement*, i64 }
  %t928 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t927, i32 0, i32 0
  store %EffectRequirement* %t926, %EffectRequirement** %t928
  %t929 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t927, i32 0, i32 1
  store i64 0, i64* %t929
  ret { %EffectRequirement*, i64 }* %t927
merge47:
  %t930 = alloca [0 x %EffectRequirement]
  %t931 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t930, i32 0, i32 0
  %t932 = alloca { %EffectRequirement*, i64 }
  %t933 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t932, i32 0, i32 0
  store %EffectRequirement* %t931, %EffectRequirement** %t933
  %t934 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t932, i32 0, i32 1
  store i64 0, i64* %t934
  ret { %EffectRequirement*, i64 }* %t932
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
  %t74 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t72, %loop.latch2 ]
  %t75 = phi double [ %t7, %entry ], [ %t73, %loop.latch2 ]
  store { %Token*, i64 }* %t74, { %Token*, i64 }** %l0
  store double %t75, double* %l1
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
  %t56 = call noalias i8* @malloc(i64 32)
  %t57 = bitcast i8* %t56 to %Token*
  store %Token %t55, %Token* %t57
  %t58 = alloca [1 x i8*]
  %t59 = getelementptr [1 x i8*], [1 x i8*]* %t58, i32 0, i32 0
  %t60 = getelementptr i8*, i8** %t59, i64 0
  store i8* %t56, i8** %t60
  %t61 = alloca { i8**, i64 }
  %t62 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 0
  store i8** %t59, i8*** %t62
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = bitcast { %Token*, i64 }* %t47 to { i8**, i64 }*
  %t65 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t64, { i8**, i64 }* %t61)
  %t66 = bitcast { i8**, i64 }* %t65 to { %Token*, i64 }*
  store { %Token*, i64 }* %t66, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t67 = phi { %Token*, i64 }* [ %t66, %then8 ], [ %t44, %then6 ]
  store { %Token*, i64 }* %t67, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t68 = phi { %Token*, i64 }* [ %t66, %then6 ], [ %t24, %loop.body1 ]
  store { %Token*, i64 }* %t68, { %Token*, i64 }** %l0
  %t69 = load double, double* %l1
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l1
  br label %loop.latch2
loop.latch2:
  %t72 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t73 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t76 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t76
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
  %t78 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t76, %loop.latch2 ]
  %t79 = phi double [ %t7, %entry ], [ %t77, %loop.latch2 ]
  store { %Token*, i64 }* %t78, { %Token*, i64 }** %l0
  store double %t79, double* %l1
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
  %t60 = call noalias i8* @malloc(i64 32)
  %t61 = bitcast i8* %t60 to %Token*
  store %Token %t59, %Token* %t61
  %t62 = alloca [1 x i8*]
  %t63 = getelementptr [1 x i8*], [1 x i8*]* %t62, i32 0, i32 0
  %t64 = getelementptr i8*, i8** %t63, i64 0
  store i8* %t60, i8** %t64
  %t65 = alloca { i8**, i64 }
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 0
  store i8** %t63, i8*** %t66
  %t67 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 1
  store i64 1, i64* %t67
  %t68 = bitcast { %Token*, i64 }* %t51 to { i8**, i64 }*
  %t69 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t68, { i8**, i64 }* %t65)
  %t70 = bitcast { i8**, i64 }* %t69 to { %Token*, i64 }*
  store { %Token*, i64 }* %t70, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t71 = phi { %Token*, i64 }* [ %t70, %then8 ], [ %t48, %then6 ]
  store { %Token*, i64 }* %t71, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t72 = phi { %Token*, i64 }* [ %t70, %then6 ], [ %t24, %loop.body1 ]
  store { %Token*, i64 }* %t72, { %Token*, i64 }** %l0
  %t73 = load double, double* %l1
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l1
  br label %loop.latch2
loop.latch2:
  %t76 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t77 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t80 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t80
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
  %t35 = phi { %EffectViolation*, i64 }* [ %t1, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t2, %entry ], [ %t34, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t35, { %EffectViolation*, i64 }** %l0
  store double %t36, double* %l1
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
  %t19 = call noalias i8* @malloc(i64 24)
  %t20 = bitcast i8* %t19 to %EffectViolation*
  store %EffectViolation %t18, %EffectViolation* %t20
  %t21 = alloca [1 x i8*]
  %t22 = getelementptr [1 x i8*], [1 x i8*]* %t21, i32 0, i32 0
  %t23 = getelementptr i8*, i8** %t22, i64 0
  store i8* %t19, i8** %t23
  %t24 = alloca { i8**, i64 }
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t22, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 1, i64* %t26
  %t27 = bitcast { %EffectViolation*, i64 }* %t10 to { i8**, i64 }*
  %t28 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t27, { i8**, i64 }* %t24)
  %t29 = bitcast { i8**, i64 }* %t28 to { %EffectViolation*, i64 }*
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

define { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %collection, %EffectViolation %item) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %EffectViolation*
  store %EffectViolation %item, %EffectViolation* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %EffectViolation*, i64 }* %collection to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %EffectViolation*, i64 }*
  ret { %EffectViolation*, i64 }* %t10
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
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %EffectRequirement*
  store %EffectRequirement %item, %EffectRequirement* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %EffectRequirement*, i64 }* %collection to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %EffectRequirement*, i64 }*
  ret { %EffectRequirement*, i64 }* %t10
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
  %t35 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t2, %entry ], [ %t34, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t35, { %EffectRequirement*, i64 }** %l0
  store double %t36, double* %l1
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
  %t19 = call noalias i8* @malloc(i64 24)
  %t20 = bitcast i8* %t19 to %EffectRequirement*
  store %EffectRequirement %t18, %EffectRequirement* %t20
  %t21 = alloca [1 x i8*]
  %t22 = getelementptr [1 x i8*], [1 x i8*]* %t21, i32 0, i32 0
  %t23 = getelementptr i8*, i8** %t22, i64 0
  store i8* %t19, i8** %t23
  %t24 = alloca { i8**, i64 }
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t22, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 1, i64* %t26
  %t27 = bitcast { %EffectRequirement*, i64 }* %t10 to { i8**, i64 }*
  %t28 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t27, { i8**, i64 }* %t24)
  %t29 = bitcast { i8**, i64 }* %t28 to { %EffectRequirement*, i64 }*
  store { %EffectRequirement*, i64 }* %t29, { %EffectRequirement*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t37
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
