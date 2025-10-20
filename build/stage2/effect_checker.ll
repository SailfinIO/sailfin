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

declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)

declare noalias i8* @malloc(i64)

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
  %l5 = alloca double
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
  %t132 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t132
merge1:
  %t133 = extractvalue %Statement %statement, 0
  %t134 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t135 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t133, 0
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t133, 1
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t133, 2
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t133, 3
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t133, 4
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t133, 5
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t133, 6
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t133, 7
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t133, 8
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t133, 9
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t133, 10
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t133, 11
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t133, 12
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t175 = icmp eq i32 %t133, 13
  %t176 = select i1 %t175, i8* %t174, i8* %t173
  %t177 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t178 = icmp eq i32 %t133, 14
  %t179 = select i1 %t178, i8* %t177, i8* %t176
  %t180 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t181 = icmp eq i32 %t133, 15
  %t182 = select i1 %t181, i8* %t180, i8* %t179
  %t183 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t184 = icmp eq i32 %t133, 16
  %t185 = select i1 %t184, i8* %t183, i8* %t182
  %t186 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t187 = icmp eq i32 %t133, 17
  %t188 = select i1 %t187, i8* %t186, i8* %t185
  %t189 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t190 = icmp eq i32 %t133, 18
  %t191 = select i1 %t190, i8* %t189, i8* %t188
  %t192 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t193 = icmp eq i32 %t133, 19
  %t194 = select i1 %t193, i8* %t192, i8* %t191
  %t195 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t196 = icmp eq i32 %t133, 20
  %t197 = select i1 %t196, i8* %t195, i8* %t194
  %t198 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t199 = icmp eq i32 %t133, 21
  %t200 = select i1 %t199, i8* %t198, i8* %t197
  %t201 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t202 = icmp eq i32 %t133, 22
  %t203 = select i1 %t202, i8* %t201, i8* %t200
  %s204 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.204, i32 0, i32 0
  %t205 = icmp eq i8* %t203, %s204
  br i1 %t205, label %then2, label %merge3
then2:
  %t206 = extractvalue %Statement %statement, 0
  %t207 = alloca %Statement
  store %Statement %statement, %Statement* %t207
  %t208 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t209 = bitcast [24 x i8]* %t208 to i8*
  %t210 = getelementptr inbounds i8, i8* %t209, i64 8
  %t211 = bitcast i8* %t210 to %Block*
  %t212 = load %Block, %Block* %t211
  %t213 = icmp eq i32 %t206, 4
  %t214 = select i1 %t213, %Block %t212, %Block zeroinitializer
  %t215 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t216 = bitcast [24 x i8]* %t215 to i8*
  %t217 = getelementptr inbounds i8, i8* %t216, i64 8
  %t218 = bitcast i8* %t217 to %Block*
  %t219 = load %Block, %Block* %t218
  %t220 = icmp eq i32 %t206, 5
  %t221 = select i1 %t220, %Block %t219, %Block %t214
  %t222 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t223 = bitcast [40 x i8]* %t222 to i8*
  %t224 = getelementptr inbounds i8, i8* %t223, i64 16
  %t225 = bitcast i8* %t224 to %Block*
  %t226 = load %Block, %Block* %t225
  %t227 = icmp eq i32 %t206, 6
  %t228 = select i1 %t227, %Block %t226, %Block %t221
  %t229 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t230 = bitcast [24 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 8
  %t232 = bitcast i8* %t231 to %Block*
  %t233 = load %Block, %Block* %t232
  %t234 = icmp eq i32 %t206, 7
  %t235 = select i1 %t234, %Block %t233, %Block %t228
  %t236 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t237 = bitcast [40 x i8]* %t236 to i8*
  %t238 = getelementptr inbounds i8, i8* %t237, i64 24
  %t239 = bitcast i8* %t238 to %Block*
  %t240 = load %Block, %Block* %t239
  %t241 = icmp eq i32 %t206, 12
  %t242 = select i1 %t241, %Block %t240, %Block %t235
  %t243 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t244 = bitcast [24 x i8]* %t243 to i8*
  %t245 = getelementptr inbounds i8, i8* %t244, i64 8
  %t246 = bitcast i8* %t245 to %Block*
  %t247 = load %Block, %Block* %t246
  %t248 = icmp eq i32 %t206, 13
  %t249 = select i1 %t248, %Block %t247, %Block %t242
  %t250 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t251 = bitcast [24 x i8]* %t250 to i8*
  %t252 = getelementptr inbounds i8, i8* %t251, i64 8
  %t253 = bitcast i8* %t252 to %Block*
  %t254 = load %Block, %Block* %t253
  %t255 = icmp eq i32 %t206, 14
  %t256 = select i1 %t255, %Block %t254, %Block %t249
  %t257 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t258 = bitcast [16 x i8]* %t257 to i8*
  %t259 = bitcast i8* %t258 to %Block*
  %t260 = load %Block, %Block* %t259
  %t261 = icmp eq i32 %t206, 15
  %t262 = select i1 %t261, %Block %t260, %Block %t256
  %t263 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t262)
  store { %EffectRequirement*, i64 }* %t263, { %EffectRequirement*, i64 }** %l1
  %t264 = sitofp i64 0 to double
  store double %t264, double* %l2
  %t265 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t266 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t309 = phi { %EffectRequirement*, i64 }* [ %t265, %then2 ], [ %t307, %loop.latch6 ]
  %t310 = phi double [ %t266, %then2 ], [ %t308, %loop.latch6 ]
  store { %EffectRequirement*, i64 }* %t309, { %EffectRequirement*, i64 }** %l1
  store double %t310, double* %l2
  br label %loop.body5
loop.body5:
  %t267 = load double, double* %l2
  %t268 = extractvalue %Statement %statement, 0
  %t269 = alloca %Statement
  store %Statement %statement, %Statement* %t269
  %t270 = getelementptr inbounds %Statement, %Statement* %t269, i32 0, i32 1
  %t271 = bitcast [24 x i8]* %t270 to i8*
  %t272 = bitcast i8* %t271 to { %WithClause**, i64 }**
  %t273 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t272
  %t274 = icmp eq i32 %t268, 13
  %t275 = select i1 %t274, { %WithClause**, i64 }* %t273, { %WithClause**, i64 }* null
  %t276 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t275
  %t277 = extractvalue { %WithClause**, i64 } %t276, 1
  %t278 = sitofp i64 %t277 to double
  %t279 = fcmp oge double %t267, %t278
  %t280 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t281 = load double, double* %l2
  br i1 %t279, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t282 = extractvalue %Statement %statement, 0
  %t283 = alloca %Statement
  store %Statement %statement, %Statement* %t283
  %t284 = getelementptr inbounds %Statement, %Statement* %t283, i32 0, i32 1
  %t285 = bitcast [24 x i8]* %t284 to i8*
  %t286 = bitcast i8* %t285 to { %WithClause**, i64 }**
  %t287 = load { %WithClause**, i64 }*, { %WithClause**, i64 }** %t286
  %t288 = icmp eq i32 %t282, 13
  %t289 = select i1 %t288, { %WithClause**, i64 }* %t287, { %WithClause**, i64 }* null
  %t290 = load double, double* %l2
  %t291 = fptosi double %t290 to i64
  %t292 = load { %WithClause**, i64 }, { %WithClause**, i64 }* %t289
  %t293 = extractvalue { %WithClause**, i64 } %t292, 0
  %t294 = extractvalue { %WithClause**, i64 } %t292, 1
  %t295 = icmp uge i64 %t291, %t294
  ; bounds check: %t295 (if true, out of bounds)
  %t296 = getelementptr %WithClause*, %WithClause** %t293, i64 %t291
  %t297 = load %WithClause*, %WithClause** %t296
  store %WithClause* %t297, %WithClause** %l3
  %t298 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t299 = load %WithClause*, %WithClause** %l3
  %t300 = getelementptr %WithClause, %WithClause* %t299, i32 0, i32 0
  %t301 = load %Expression, %Expression* %t300
  %t302 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* null)
  %t303 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t298, { %EffectRequirement*, i64 }* %t302)
  store { %EffectRequirement*, i64 }* %t303, { %EffectRequirement*, i64 }** %l1
  %t304 = load double, double* %l2
  %t305 = sitofp i64 1 to double
  %t306 = fadd double %t304, %t305
  store double %t306, double* %l2
  br label %loop.latch6
loop.latch6:
  %t307 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t308 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t311 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t311
merge3:
  %t312 = extractvalue %Statement %statement, 0
  %t313 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t314 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t312, 0
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t312, 1
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t312, 2
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t312, 3
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t312, 4
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t312, 5
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t312, 6
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t312, 7
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t312, 8
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t312, 9
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t312, 10
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t312, 11
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t312, 12
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t312, 13
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t312, 14
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t312, 15
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t312, 16
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t312, 17
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t312, 18
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %t371 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t372 = icmp eq i32 %t312, 19
  %t373 = select i1 %t372, i8* %t371, i8* %t370
  %t374 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t375 = icmp eq i32 %t312, 20
  %t376 = select i1 %t375, i8* %t374, i8* %t373
  %t377 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t378 = icmp eq i32 %t312, 21
  %t379 = select i1 %t378, i8* %t377, i8* %t376
  %t380 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t381 = icmp eq i32 %t312, 22
  %t382 = select i1 %t381, i8* %t380, i8* %t379
  %s383 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.383, i32 0, i32 0
  %t384 = icmp eq i8* %t382, %s383
  br i1 %t384, label %then10, label %merge11
then10:
  %t385 = extractvalue %Statement %statement, 0
  %t386 = alloca %Statement
  store %Statement %statement, %Statement* %t386
  %t387 = getelementptr inbounds %Statement, %Statement* %t386, i32 0, i32 1
  %t388 = bitcast [24 x i8]* %t387 to i8*
  %t389 = getelementptr inbounds i8, i8* %t388, i64 8
  %t390 = bitcast i8* %t389 to %Block*
  %t391 = load %Block, %Block* %t390
  %t392 = icmp eq i32 %t385, 4
  %t393 = select i1 %t392, %Block %t391, %Block zeroinitializer
  %t394 = getelementptr inbounds %Statement, %Statement* %t386, i32 0, i32 1
  %t395 = bitcast [24 x i8]* %t394 to i8*
  %t396 = getelementptr inbounds i8, i8* %t395, i64 8
  %t397 = bitcast i8* %t396 to %Block*
  %t398 = load %Block, %Block* %t397
  %t399 = icmp eq i32 %t385, 5
  %t400 = select i1 %t399, %Block %t398, %Block %t393
  %t401 = getelementptr inbounds %Statement, %Statement* %t386, i32 0, i32 1
  %t402 = bitcast [40 x i8]* %t401 to i8*
  %t403 = getelementptr inbounds i8, i8* %t402, i64 16
  %t404 = bitcast i8* %t403 to %Block*
  %t405 = load %Block, %Block* %t404
  %t406 = icmp eq i32 %t385, 6
  %t407 = select i1 %t406, %Block %t405, %Block %t400
  %t408 = getelementptr inbounds %Statement, %Statement* %t386, i32 0, i32 1
  %t409 = bitcast [24 x i8]* %t408 to i8*
  %t410 = getelementptr inbounds i8, i8* %t409, i64 8
  %t411 = bitcast i8* %t410 to %Block*
  %t412 = load %Block, %Block* %t411
  %t413 = icmp eq i32 %t385, 7
  %t414 = select i1 %t413, %Block %t412, %Block %t407
  %t415 = getelementptr inbounds %Statement, %Statement* %t386, i32 0, i32 1
  %t416 = bitcast [40 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 24
  %t418 = bitcast i8* %t417 to %Block*
  %t419 = load %Block, %Block* %t418
  %t420 = icmp eq i32 %t385, 12
  %t421 = select i1 %t420, %Block %t419, %Block %t414
  %t422 = getelementptr inbounds %Statement, %Statement* %t386, i32 0, i32 1
  %t423 = bitcast [24 x i8]* %t422 to i8*
  %t424 = getelementptr inbounds i8, i8* %t423, i64 8
  %t425 = bitcast i8* %t424 to %Block*
  %t426 = load %Block, %Block* %t425
  %t427 = icmp eq i32 %t385, 13
  %t428 = select i1 %t427, %Block %t426, %Block %t421
  %t429 = getelementptr inbounds %Statement, %Statement* %t386, i32 0, i32 1
  %t430 = bitcast [24 x i8]* %t429 to i8*
  %t431 = getelementptr inbounds i8, i8* %t430, i64 8
  %t432 = bitcast i8* %t431 to %Block*
  %t433 = load %Block, %Block* %t432
  %t434 = icmp eq i32 %t385, 14
  %t435 = select i1 %t434, %Block %t433, %Block %t428
  %t436 = getelementptr inbounds %Statement, %Statement* %t386, i32 0, i32 1
  %t437 = bitcast [16 x i8]* %t436 to i8*
  %t438 = bitcast i8* %t437 to %Block*
  %t439 = load %Block, %Block* %t438
  %t440 = icmp eq i32 %t385, 15
  %t441 = select i1 %t440, %Block %t439, %Block %t435
  %t442 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t441)
  store { %EffectRequirement*, i64 }* %t442, { %EffectRequirement*, i64 }** %l4
  %t443 = extractvalue %Statement %statement, 0
  %t444 = alloca %Statement
  store %Statement %statement, %Statement* %t444
  %t445 = getelementptr inbounds %Statement, %Statement* %t444, i32 0, i32 1
  %t446 = bitcast [24 x i8]* %t445 to i8*
  %t447 = bitcast i8* %t446 to %ForClause*
  %t448 = load %ForClause, %ForClause* %t447
  %t449 = icmp eq i32 %t443, 14
  %t450 = select i1 %t449, %ForClause %t448, %ForClause zeroinitializer
  %t451 = extractvalue %ForClause %t450, 0
  %t452 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t453 = extractvalue %Statement %statement, 0
  %t454 = alloca %Statement
  store %Statement %statement, %Statement* %t454
  %t455 = getelementptr inbounds %Statement, %Statement* %t454, i32 0, i32 1
  %t456 = bitcast [24 x i8]* %t455 to i8*
  %t457 = bitcast i8* %t456 to %ForClause*
  %t458 = load %ForClause, %ForClause* %t457
  %t459 = icmp eq i32 %t453, 14
  %t460 = select i1 %t459, %ForClause %t458, %ForClause zeroinitializer
  %t461 = extractvalue %ForClause %t460, 1
  %t462 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* null)
  %t463 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t452, { %EffectRequirement*, i64 }* %t462)
  store { %EffectRequirement*, i64 }* %t463, { %EffectRequirement*, i64 }** %l4
  %t464 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t464
merge11:
  %t465 = extractvalue %Statement %statement, 0
  %t466 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t467 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t465, 0
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t465, 1
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t465, 2
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t465, 3
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t465, 4
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t465, 5
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t465, 6
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t465, 7
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t465, 8
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t465, 9
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t465, 10
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t465, 11
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t465, 12
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t465, 13
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t465, 14
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t465, 15
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t465, 16
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t465, 17
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t465, 18
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t465, 19
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t465, 20
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %t530 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t531 = icmp eq i32 %t465, 21
  %t532 = select i1 %t531, i8* %t530, i8* %t529
  %t533 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t534 = icmp eq i32 %t465, 22
  %t535 = select i1 %t534, i8* %t533, i8* %t532
  %s536 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.536, i32 0, i32 0
  %t537 = icmp eq i8* %t535, %s536
  br i1 %t537, label %then12, label %merge13
then12:
  %t538 = extractvalue %Statement %statement, 0
  %t539 = alloca %Statement
  store %Statement %statement, %Statement* %t539
  %t540 = getelementptr inbounds %Statement, %Statement* %t539, i32 0, i32 1
  %t541 = bitcast [24 x i8]* %t540 to i8*
  %t542 = getelementptr inbounds i8, i8* %t541, i64 8
  %t543 = bitcast i8* %t542 to %Block*
  %t544 = load %Block, %Block* %t543
  %t545 = icmp eq i32 %t538, 4
  %t546 = select i1 %t545, %Block %t544, %Block zeroinitializer
  %t547 = getelementptr inbounds %Statement, %Statement* %t539, i32 0, i32 1
  %t548 = bitcast [24 x i8]* %t547 to i8*
  %t549 = getelementptr inbounds i8, i8* %t548, i64 8
  %t550 = bitcast i8* %t549 to %Block*
  %t551 = load %Block, %Block* %t550
  %t552 = icmp eq i32 %t538, 5
  %t553 = select i1 %t552, %Block %t551, %Block %t546
  %t554 = getelementptr inbounds %Statement, %Statement* %t539, i32 0, i32 1
  %t555 = bitcast [40 x i8]* %t554 to i8*
  %t556 = getelementptr inbounds i8, i8* %t555, i64 16
  %t557 = bitcast i8* %t556 to %Block*
  %t558 = load %Block, %Block* %t557
  %t559 = icmp eq i32 %t538, 6
  %t560 = select i1 %t559, %Block %t558, %Block %t553
  %t561 = getelementptr inbounds %Statement, %Statement* %t539, i32 0, i32 1
  %t562 = bitcast [24 x i8]* %t561 to i8*
  %t563 = getelementptr inbounds i8, i8* %t562, i64 8
  %t564 = bitcast i8* %t563 to %Block*
  %t565 = load %Block, %Block* %t564
  %t566 = icmp eq i32 %t538, 7
  %t567 = select i1 %t566, %Block %t565, %Block %t560
  %t568 = getelementptr inbounds %Statement, %Statement* %t539, i32 0, i32 1
  %t569 = bitcast [40 x i8]* %t568 to i8*
  %t570 = getelementptr inbounds i8, i8* %t569, i64 24
  %t571 = bitcast i8* %t570 to %Block*
  %t572 = load %Block, %Block* %t571
  %t573 = icmp eq i32 %t538, 12
  %t574 = select i1 %t573, %Block %t572, %Block %t567
  %t575 = getelementptr inbounds %Statement, %Statement* %t539, i32 0, i32 1
  %t576 = bitcast [24 x i8]* %t575 to i8*
  %t577 = getelementptr inbounds i8, i8* %t576, i64 8
  %t578 = bitcast i8* %t577 to %Block*
  %t579 = load %Block, %Block* %t578
  %t580 = icmp eq i32 %t538, 13
  %t581 = select i1 %t580, %Block %t579, %Block %t574
  %t582 = getelementptr inbounds %Statement, %Statement* %t539, i32 0, i32 1
  %t583 = bitcast [24 x i8]* %t582 to i8*
  %t584 = getelementptr inbounds i8, i8* %t583, i64 8
  %t585 = bitcast i8* %t584 to %Block*
  %t586 = load %Block, %Block* %t585
  %t587 = icmp eq i32 %t538, 14
  %t588 = select i1 %t587, %Block %t586, %Block %t581
  %t589 = getelementptr inbounds %Statement, %Statement* %t539, i32 0, i32 1
  %t590 = bitcast [16 x i8]* %t589 to i8*
  %t591 = bitcast i8* %t590 to %Block*
  %t592 = load %Block, %Block* %t591
  %t593 = icmp eq i32 %t538, 15
  %t594 = select i1 %t593, %Block %t592, %Block %t588
  %t595 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t594)
  ret { %EffectRequirement*, i64 }* %t595
merge13:
  %t596 = extractvalue %Statement %statement, 0
  %t597 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t598 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t599 = icmp eq i32 %t596, 0
  %t600 = select i1 %t599, i8* %t598, i8* %t597
  %t601 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t602 = icmp eq i32 %t596, 1
  %t603 = select i1 %t602, i8* %t601, i8* %t600
  %t604 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t605 = icmp eq i32 %t596, 2
  %t606 = select i1 %t605, i8* %t604, i8* %t603
  %t607 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t608 = icmp eq i32 %t596, 3
  %t609 = select i1 %t608, i8* %t607, i8* %t606
  %t610 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t611 = icmp eq i32 %t596, 4
  %t612 = select i1 %t611, i8* %t610, i8* %t609
  %t613 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t614 = icmp eq i32 %t596, 5
  %t615 = select i1 %t614, i8* %t613, i8* %t612
  %t616 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t617 = icmp eq i32 %t596, 6
  %t618 = select i1 %t617, i8* %t616, i8* %t615
  %t619 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t620 = icmp eq i32 %t596, 7
  %t621 = select i1 %t620, i8* %t619, i8* %t618
  %t622 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t623 = icmp eq i32 %t596, 8
  %t624 = select i1 %t623, i8* %t622, i8* %t621
  %t625 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t626 = icmp eq i32 %t596, 9
  %t627 = select i1 %t626, i8* %t625, i8* %t624
  %t628 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t629 = icmp eq i32 %t596, 10
  %t630 = select i1 %t629, i8* %t628, i8* %t627
  %t631 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t632 = icmp eq i32 %t596, 11
  %t633 = select i1 %t632, i8* %t631, i8* %t630
  %t634 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t635 = icmp eq i32 %t596, 12
  %t636 = select i1 %t635, i8* %t634, i8* %t633
  %t637 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t638 = icmp eq i32 %t596, 13
  %t639 = select i1 %t638, i8* %t637, i8* %t636
  %t640 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t641 = icmp eq i32 %t596, 14
  %t642 = select i1 %t641, i8* %t640, i8* %t639
  %t643 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t644 = icmp eq i32 %t596, 15
  %t645 = select i1 %t644, i8* %t643, i8* %t642
  %t646 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t647 = icmp eq i32 %t596, 16
  %t648 = select i1 %t647, i8* %t646, i8* %t645
  %t649 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t650 = icmp eq i32 %t596, 17
  %t651 = select i1 %t650, i8* %t649, i8* %t648
  %t652 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t653 = icmp eq i32 %t596, 18
  %t654 = select i1 %t653, i8* %t652, i8* %t651
  %t655 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t656 = icmp eq i32 %t596, 19
  %t657 = select i1 %t656, i8* %t655, i8* %t654
  %t658 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t659 = icmp eq i32 %t596, 20
  %t660 = select i1 %t659, i8* %t658, i8* %t657
  %t661 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t662 = icmp eq i32 %t596, 21
  %t663 = select i1 %t662, i8* %t661, i8* %t660
  %t664 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t596, 22
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %s667 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.667, i32 0, i32 0
  %t668 = icmp eq i8* %t666, %s667
  br i1 %t668, label %then14, label %merge15
then14:
  %t669 = extractvalue %Statement %statement, 0
  store double 0.0, double* %l5
  %t670 = sitofp i64 0 to double
  store double %t670, double* %l6
  %t671 = load double, double* %l5
  %t672 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t715 = phi double [ %t671, %then14 ], [ %t713, %loop.latch18 ]
  %t716 = phi double [ %t672, %then14 ], [ %t714, %loop.latch18 ]
  store double %t715, double* %l5
  store double %t716, double* %l6
  br label %loop.body17
loop.body17:
  %t673 = load double, double* %l6
  %t674 = extractvalue %Statement %statement, 0
  %t675 = alloca %Statement
  store %Statement %statement, %Statement* %t675
  %t676 = getelementptr inbounds %Statement, %Statement* %t675, i32 0, i32 1
  %t677 = bitcast [24 x i8]* %t676 to i8*
  %t678 = getelementptr inbounds i8, i8* %t677, i64 8
  %t679 = bitcast i8* %t678 to { %MatchCase**, i64 }**
  %t680 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t679
  %t681 = icmp eq i32 %t674, 18
  %t682 = select i1 %t681, { %MatchCase**, i64 }* %t680, { %MatchCase**, i64 }* null
  %t683 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t682
  %t684 = extractvalue { %MatchCase**, i64 } %t683, 1
  %t685 = sitofp i64 %t684 to double
  %t686 = fcmp oge double %t673, %t685
  %t687 = load double, double* %l5
  %t688 = load double, double* %l6
  br i1 %t686, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t689 = load double, double* %l5
  %t690 = extractvalue %Statement %statement, 0
  %t691 = alloca %Statement
  store %Statement %statement, %Statement* %t691
  %t692 = getelementptr inbounds %Statement, %Statement* %t691, i32 0, i32 1
  %t693 = bitcast [24 x i8]* %t692 to i8*
  %t694 = getelementptr inbounds i8, i8* %t693, i64 8
  %t695 = bitcast i8* %t694 to { %MatchCase**, i64 }**
  %t696 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t695
  %t697 = icmp eq i32 %t690, 18
  %t698 = select i1 %t697, { %MatchCase**, i64 }* %t696, { %MatchCase**, i64 }* null
  %t699 = load double, double* %l6
  %t700 = fptosi double %t699 to i64
  %t701 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t698
  %t702 = extractvalue { %MatchCase**, i64 } %t701, 0
  %t703 = extractvalue { %MatchCase**, i64 } %t701, 1
  %t704 = icmp uge i64 %t700, %t703
  ; bounds check: %t704 (if true, out of bounds)
  %t705 = getelementptr %MatchCase*, %MatchCase** %t702, i64 %t700
  %t706 = load %MatchCase*, %MatchCase** %t705
  %t707 = load %MatchCase, %MatchCase* %t706
  %t708 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t707)
  %t709 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* null, { %EffectRequirement*, i64 }* %t708)
  store double 0.0, double* %l5
  %t710 = load double, double* %l6
  %t711 = sitofp i64 1 to double
  %t712 = fadd double %t710, %t711
  store double %t712, double* %l6
  br label %loop.latch18
loop.latch18:
  %t713 = load double, double* %l5
  %t714 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t717 = load double, double* %l5
  ret { %EffectRequirement*, i64 }* null
merge15:
  %t718 = extractvalue %Statement %statement, 0
  %t719 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t720 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t718, 0
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t718, 1
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %t726 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t727 = icmp eq i32 %t718, 2
  %t728 = select i1 %t727, i8* %t726, i8* %t725
  %t729 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t718, 3
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t718, 4
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t718, 5
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t718, 6
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t718, 7
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t718, 8
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t718, 9
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t718, 10
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t718, 11
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %t756 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t757 = icmp eq i32 %t718, 12
  %t758 = select i1 %t757, i8* %t756, i8* %t755
  %t759 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t718, 13
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t718, 14
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %t765 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t718, 15
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t718, 16
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t718, 17
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t718, 18
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t718, 19
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t718, 20
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t718, 21
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t718, 22
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %s789 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.789, i32 0, i32 0
  %t790 = icmp eq i8* %t788, %s789
  br i1 %t790, label %then22, label %merge23
then22:
  %t791 = extractvalue %Statement %statement, 0
  %t792 = alloca %Statement
  store %Statement %statement, %Statement* %t792
  %t793 = getelementptr inbounds %Statement, %Statement* %t792, i32 0, i32 1
  %t794 = bitcast [32 x i8]* %t793 to i8*
  %t795 = bitcast i8* %t794 to %Expression*
  %t796 = load %Expression, %Expression* %t795
  %t797 = icmp eq i32 %t791, 19
  %t798 = select i1 %t797, %Expression %t796, %Expression zeroinitializer
  %t799 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* null)
  store { %EffectRequirement*, i64 }* %t799, { %EffectRequirement*, i64 }** %l7
  %t800 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t801 = extractvalue %Statement %statement, 0
  %t802 = alloca %Statement
  store %Statement %statement, %Statement* %t802
  %t803 = getelementptr inbounds %Statement, %Statement* %t802, i32 0, i32 1
  %t804 = bitcast [32 x i8]* %t803 to i8*
  %t805 = getelementptr inbounds i8, i8* %t804, i64 8
  %t806 = bitcast i8* %t805 to %Block*
  %t807 = load %Block, %Block* %t806
  %t808 = icmp eq i32 %t801, 19
  %t809 = select i1 %t808, %Block %t807, %Block zeroinitializer
  %t810 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t809)
  %t811 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t800, { %EffectRequirement*, i64 }* %t810)
  store { %EffectRequirement*, i64 }* %t811, { %EffectRequirement*, i64 }** %l7
  %t812 = extractvalue %Statement %statement, 0
  %t813 = alloca %Statement
  store %Statement %statement, %Statement* %t813
  %t814 = getelementptr inbounds %Statement, %Statement* %t813, i32 0, i32 1
  %t815 = bitcast [32 x i8]* %t814 to i8*
  %t816 = getelementptr inbounds i8, i8* %t815, i64 16
  %t817 = bitcast i8* %t816 to %ElseBranch**
  %t818 = load %ElseBranch*, %ElseBranch** %t817
  %t819 = icmp eq i32 %t812, 19
  %t820 = select i1 %t819, %ElseBranch* %t818, %ElseBranch* null
  %t821 = bitcast i8* null to %ElseBranch*
  %t822 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t822
merge23:
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
  %t885 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t823, 20
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t823, 21
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t823, 22
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %s894 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.894, i32 0, i32 0
  %t895 = icmp eq i8* %t893, %s894
  br i1 %t895, label %then24, label %merge25
then24:
  %t896 = extractvalue %Statement %statement, 0
  ret { %EffectRequirement*, i64 }* null
merge25:
  %t897 = extractvalue %Statement %statement, 0
  %t898 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t899 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t900 = icmp eq i32 %t897, 0
  %t901 = select i1 %t900, i8* %t899, i8* %t898
  %t902 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t903 = icmp eq i32 %t897, 1
  %t904 = select i1 %t903, i8* %t902, i8* %t901
  %t905 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t906 = icmp eq i32 %t897, 2
  %t907 = select i1 %t906, i8* %t905, i8* %t904
  %t908 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t909 = icmp eq i32 %t897, 3
  %t910 = select i1 %t909, i8* %t908, i8* %t907
  %t911 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t912 = icmp eq i32 %t897, 4
  %t913 = select i1 %t912, i8* %t911, i8* %t910
  %t914 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t915 = icmp eq i32 %t897, 5
  %t916 = select i1 %t915, i8* %t914, i8* %t913
  %t917 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t918 = icmp eq i32 %t897, 6
  %t919 = select i1 %t918, i8* %t917, i8* %t916
  %t920 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t921 = icmp eq i32 %t897, 7
  %t922 = select i1 %t921, i8* %t920, i8* %t919
  %t923 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t924 = icmp eq i32 %t897, 8
  %t925 = select i1 %t924, i8* %t923, i8* %t922
  %t926 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t927 = icmp eq i32 %t897, 9
  %t928 = select i1 %t927, i8* %t926, i8* %t925
  %t929 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t930 = icmp eq i32 %t897, 10
  %t931 = select i1 %t930, i8* %t929, i8* %t928
  %t932 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t933 = icmp eq i32 %t897, 11
  %t934 = select i1 %t933, i8* %t932, i8* %t931
  %t935 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t936 = icmp eq i32 %t897, 12
  %t937 = select i1 %t936, i8* %t935, i8* %t934
  %t938 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t939 = icmp eq i32 %t897, 13
  %t940 = select i1 %t939, i8* %t938, i8* %t937
  %t941 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t942 = icmp eq i32 %t897, 14
  %t943 = select i1 %t942, i8* %t941, i8* %t940
  %t944 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t945 = icmp eq i32 %t897, 15
  %t946 = select i1 %t945, i8* %t944, i8* %t943
  %t947 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t948 = icmp eq i32 %t897, 16
  %t949 = select i1 %t948, i8* %t947, i8* %t946
  %t950 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t897, 17
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t897, 18
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t897, 19
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t897, 20
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t897, 21
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t897, 22
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %s968 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.968, i32 0, i32 0
  %t969 = icmp eq i8* %t967, %s968
  br i1 %t969, label %then26, label %merge27
then26:
  %t970 = extractvalue %Statement %statement, 0
  ret { %EffectRequirement*, i64 }* null
merge27:
  %t971 = extractvalue %Statement %statement, 0
  %t972 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t973 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t971, 0
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t971, 1
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t971, 2
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t971, 3
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t971, 4
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t971, 5
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t971, 6
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t971, 7
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t971, 8
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t971, 9
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t971, 10
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t971, 11
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t971, 12
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t971, 13
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t971, 14
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t971, 15
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t971, 16
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t971, 17
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t971, 18
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t971, 19
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t971, 20
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t971, 21
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t971, 22
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %s1042 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1042, i32 0, i32 0
  %t1043 = icmp eq i8* %t1041, %s1042
  br i1 %t1043, label %then28, label %merge29
then28:
  %t1044 = extractvalue %Statement %statement, 0
  %t1045 = alloca %Statement
  store %Statement %statement, %Statement* %t1045
  %t1046 = getelementptr inbounds %Statement, %Statement* %t1045, i32 0, i32 1
  %t1047 = bitcast [48 x i8]* %t1046 to i8*
  %t1048 = getelementptr inbounds i8, i8* %t1047, i64 24
  %t1049 = bitcast i8* %t1048 to %Expression**
  %t1050 = load %Expression*, %Expression** %t1049
  %t1051 = icmp eq i32 %t1044, 2
  %t1052 = select i1 %t1051, %Expression* %t1050, %Expression* null
  %t1053 = bitcast %Expression* %t1052 to i8*
  %t1054 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t1053)
  ret { %EffectRequirement*, i64 }* %t1054
merge29:
  %t1055 = extractvalue %Statement %statement, 0
  %t1056 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1057 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1055, 0
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1055, 1
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1055, 2
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1055, 3
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1055, 4
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1055, 5
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1055, 6
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1055, 7
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1055, 8
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1055, 9
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %t1087 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1088 = icmp eq i32 %t1055, 10
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1086
  %t1090 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1091 = icmp eq i32 %t1055, 11
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1089
  %t1093 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1094 = icmp eq i32 %t1055, 12
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1092
  %t1096 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1097 = icmp eq i32 %t1055, 13
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1095
  %t1099 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1055, 14
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1055, 15
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %t1105 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1106 = icmp eq i32 %t1055, 16
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1104
  %t1108 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1109 = icmp eq i32 %t1055, 17
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1107
  %t1111 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1112 = icmp eq i32 %t1055, 18
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1110
  %t1114 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1115 = icmp eq i32 %t1055, 19
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1113
  %t1117 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1118 = icmp eq i32 %t1055, 20
  %t1119 = select i1 %t1118, i8* %t1117, i8* %t1116
  %t1120 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1121 = icmp eq i32 %t1055, 21
  %t1122 = select i1 %t1121, i8* %t1120, i8* %t1119
  %t1123 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1124 = icmp eq i32 %t1055, 22
  %t1125 = select i1 %t1124, i8* %t1123, i8* %t1122
  %s1126 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1126, i32 0, i32 0
  %t1127 = icmp eq i8* %t1125, %s1126
  br i1 %t1127, label %then30, label %merge31
then30:
  %t1128 = extractvalue %Statement %statement, 0
  %t1129 = alloca %Statement
  store %Statement %statement, %Statement* %t1129
  %t1130 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1131 = bitcast [24 x i8]* %t1130 to i8*
  %t1132 = getelementptr inbounds i8, i8* %t1131, i64 8
  %t1133 = bitcast i8* %t1132 to %Block*
  %t1134 = load %Block, %Block* %t1133
  %t1135 = icmp eq i32 %t1128, 4
  %t1136 = select i1 %t1135, %Block %t1134, %Block zeroinitializer
  %t1137 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1138 = bitcast [24 x i8]* %t1137 to i8*
  %t1139 = getelementptr inbounds i8, i8* %t1138, i64 8
  %t1140 = bitcast i8* %t1139 to %Block*
  %t1141 = load %Block, %Block* %t1140
  %t1142 = icmp eq i32 %t1128, 5
  %t1143 = select i1 %t1142, %Block %t1141, %Block %t1136
  %t1144 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1145 = bitcast [40 x i8]* %t1144 to i8*
  %t1146 = getelementptr inbounds i8, i8* %t1145, i64 16
  %t1147 = bitcast i8* %t1146 to %Block*
  %t1148 = load %Block, %Block* %t1147
  %t1149 = icmp eq i32 %t1128, 6
  %t1150 = select i1 %t1149, %Block %t1148, %Block %t1143
  %t1151 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1152 = bitcast [24 x i8]* %t1151 to i8*
  %t1153 = getelementptr inbounds i8, i8* %t1152, i64 8
  %t1154 = bitcast i8* %t1153 to %Block*
  %t1155 = load %Block, %Block* %t1154
  %t1156 = icmp eq i32 %t1128, 7
  %t1157 = select i1 %t1156, %Block %t1155, %Block %t1150
  %t1158 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1159 = bitcast [40 x i8]* %t1158 to i8*
  %t1160 = getelementptr inbounds i8, i8* %t1159, i64 24
  %t1161 = bitcast i8* %t1160 to %Block*
  %t1162 = load %Block, %Block* %t1161
  %t1163 = icmp eq i32 %t1128, 12
  %t1164 = select i1 %t1163, %Block %t1162, %Block %t1157
  %t1165 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1166 = bitcast [24 x i8]* %t1165 to i8*
  %t1167 = getelementptr inbounds i8, i8* %t1166, i64 8
  %t1168 = bitcast i8* %t1167 to %Block*
  %t1169 = load %Block, %Block* %t1168
  %t1170 = icmp eq i32 %t1128, 13
  %t1171 = select i1 %t1170, %Block %t1169, %Block %t1164
  %t1172 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1173 = bitcast [24 x i8]* %t1172 to i8*
  %t1174 = getelementptr inbounds i8, i8* %t1173, i64 8
  %t1175 = bitcast i8* %t1174 to %Block*
  %t1176 = load %Block, %Block* %t1175
  %t1177 = icmp eq i32 %t1128, 14
  %t1178 = select i1 %t1177, %Block %t1176, %Block %t1171
  %t1179 = getelementptr inbounds %Statement, %Statement* %t1129, i32 0, i32 1
  %t1180 = bitcast [16 x i8]* %t1179 to i8*
  %t1181 = bitcast i8* %t1180 to %Block*
  %t1182 = load %Block, %Block* %t1181
  %t1183 = icmp eq i32 %t1128, 15
  %t1184 = select i1 %t1183, %Block %t1182, %Block %t1178
  %t1185 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1184)
  ret { %EffectRequirement*, i64 }* %t1185
merge31:
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
  %s1257 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1257, i32 0, i32 0
  %t1258 = icmp eq i8* %t1256, %s1257
  br i1 %t1258, label %then32, label %merge33
then32:
  %t1259 = extractvalue %Statement %statement, 0
  %t1260 = alloca %Statement
  store %Statement %statement, %Statement* %t1260
  %t1261 = getelementptr inbounds %Statement, %Statement* %t1260, i32 0, i32 1
  %t1262 = bitcast [24 x i8]* %t1261 to i8*
  %t1263 = getelementptr inbounds i8, i8* %t1262, i64 8
  %t1264 = bitcast i8* %t1263 to %Block*
  %t1265 = load %Block, %Block* %t1264
  %t1266 = icmp eq i32 %t1259, 4
  %t1267 = select i1 %t1266, %Block %t1265, %Block zeroinitializer
  %t1268 = getelementptr inbounds %Statement, %Statement* %t1260, i32 0, i32 1
  %t1269 = bitcast [24 x i8]* %t1268 to i8*
  %t1270 = getelementptr inbounds i8, i8* %t1269, i64 8
  %t1271 = bitcast i8* %t1270 to %Block*
  %t1272 = load %Block, %Block* %t1271
  %t1273 = icmp eq i32 %t1259, 5
  %t1274 = select i1 %t1273, %Block %t1272, %Block %t1267
  %t1275 = getelementptr inbounds %Statement, %Statement* %t1260, i32 0, i32 1
  %t1276 = bitcast [40 x i8]* %t1275 to i8*
  %t1277 = getelementptr inbounds i8, i8* %t1276, i64 16
  %t1278 = bitcast i8* %t1277 to %Block*
  %t1279 = load %Block, %Block* %t1278
  %t1280 = icmp eq i32 %t1259, 6
  %t1281 = select i1 %t1280, %Block %t1279, %Block %t1274
  %t1282 = getelementptr inbounds %Statement, %Statement* %t1260, i32 0, i32 1
  %t1283 = bitcast [24 x i8]* %t1282 to i8*
  %t1284 = getelementptr inbounds i8, i8* %t1283, i64 8
  %t1285 = bitcast i8* %t1284 to %Block*
  %t1286 = load %Block, %Block* %t1285
  %t1287 = icmp eq i32 %t1259, 7
  %t1288 = select i1 %t1287, %Block %t1286, %Block %t1281
  %t1289 = getelementptr inbounds %Statement, %Statement* %t1260, i32 0, i32 1
  %t1290 = bitcast [40 x i8]* %t1289 to i8*
  %t1291 = getelementptr inbounds i8, i8* %t1290, i64 24
  %t1292 = bitcast i8* %t1291 to %Block*
  %t1293 = load %Block, %Block* %t1292
  %t1294 = icmp eq i32 %t1259, 12
  %t1295 = select i1 %t1294, %Block %t1293, %Block %t1288
  %t1296 = getelementptr inbounds %Statement, %Statement* %t1260, i32 0, i32 1
  %t1297 = bitcast [24 x i8]* %t1296 to i8*
  %t1298 = getelementptr inbounds i8, i8* %t1297, i64 8
  %t1299 = bitcast i8* %t1298 to %Block*
  %t1300 = load %Block, %Block* %t1299
  %t1301 = icmp eq i32 %t1259, 13
  %t1302 = select i1 %t1301, %Block %t1300, %Block %t1295
  %t1303 = getelementptr inbounds %Statement, %Statement* %t1260, i32 0, i32 1
  %t1304 = bitcast [24 x i8]* %t1303 to i8*
  %t1305 = getelementptr inbounds i8, i8* %t1304, i64 8
  %t1306 = bitcast i8* %t1305 to %Block*
  %t1307 = load %Block, %Block* %t1306
  %t1308 = icmp eq i32 %t1259, 14
  %t1309 = select i1 %t1308, %Block %t1307, %Block %t1302
  %t1310 = getelementptr inbounds %Statement, %Statement* %t1260, i32 0, i32 1
  %t1311 = bitcast [16 x i8]* %t1310 to i8*
  %t1312 = bitcast i8* %t1311 to %Block*
  %t1313 = load %Block, %Block* %t1312
  %t1314 = icmp eq i32 %t1259, 15
  %t1315 = select i1 %t1314, %Block %t1313, %Block %t1309
  %t1316 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1315)
  ret { %EffectRequirement*, i64 }* %t1316
merge33:
  %t1317 = extractvalue %Statement %statement, 0
  %t1318 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1319 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1317, 0
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %t1322 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1323 = icmp eq i32 %t1317, 1
  %t1324 = select i1 %t1323, i8* %t1322, i8* %t1321
  %t1325 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1326 = icmp eq i32 %t1317, 2
  %t1327 = select i1 %t1326, i8* %t1325, i8* %t1324
  %t1328 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1329 = icmp eq i32 %t1317, 3
  %t1330 = select i1 %t1329, i8* %t1328, i8* %t1327
  %t1331 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1332 = icmp eq i32 %t1317, 4
  %t1333 = select i1 %t1332, i8* %t1331, i8* %t1330
  %t1334 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1335 = icmp eq i32 %t1317, 5
  %t1336 = select i1 %t1335, i8* %t1334, i8* %t1333
  %t1337 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1338 = icmp eq i32 %t1317, 6
  %t1339 = select i1 %t1338, i8* %t1337, i8* %t1336
  %t1340 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1317, 7
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1317, 8
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1317, 9
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1317, 10
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1317, 11
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1317, 12
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1317, 13
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1317, 14
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1317, 15
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1317, 16
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1317, 17
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1317, 18
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1317, 19
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1317, 20
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1317, 21
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1317, 22
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %s1388 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1388, i32 0, i32 0
  %t1389 = icmp eq i8* %t1387, %s1388
  br i1 %t1389, label %then34, label %merge35
then34:
  %t1390 = extractvalue %Statement %statement, 0
  %t1391 = alloca %Statement
  store %Statement %statement, %Statement* %t1391
  %t1392 = getelementptr inbounds %Statement, %Statement* %t1391, i32 0, i32 1
  %t1393 = bitcast [24 x i8]* %t1392 to i8*
  %t1394 = getelementptr inbounds i8, i8* %t1393, i64 8
  %t1395 = bitcast i8* %t1394 to %Block*
  %t1396 = load %Block, %Block* %t1395
  %t1397 = icmp eq i32 %t1390, 4
  %t1398 = select i1 %t1397, %Block %t1396, %Block zeroinitializer
  %t1399 = getelementptr inbounds %Statement, %Statement* %t1391, i32 0, i32 1
  %t1400 = bitcast [24 x i8]* %t1399 to i8*
  %t1401 = getelementptr inbounds i8, i8* %t1400, i64 8
  %t1402 = bitcast i8* %t1401 to %Block*
  %t1403 = load %Block, %Block* %t1402
  %t1404 = icmp eq i32 %t1390, 5
  %t1405 = select i1 %t1404, %Block %t1403, %Block %t1398
  %t1406 = getelementptr inbounds %Statement, %Statement* %t1391, i32 0, i32 1
  %t1407 = bitcast [40 x i8]* %t1406 to i8*
  %t1408 = getelementptr inbounds i8, i8* %t1407, i64 16
  %t1409 = bitcast i8* %t1408 to %Block*
  %t1410 = load %Block, %Block* %t1409
  %t1411 = icmp eq i32 %t1390, 6
  %t1412 = select i1 %t1411, %Block %t1410, %Block %t1405
  %t1413 = getelementptr inbounds %Statement, %Statement* %t1391, i32 0, i32 1
  %t1414 = bitcast [24 x i8]* %t1413 to i8*
  %t1415 = getelementptr inbounds i8, i8* %t1414, i64 8
  %t1416 = bitcast i8* %t1415 to %Block*
  %t1417 = load %Block, %Block* %t1416
  %t1418 = icmp eq i32 %t1390, 7
  %t1419 = select i1 %t1418, %Block %t1417, %Block %t1412
  %t1420 = getelementptr inbounds %Statement, %Statement* %t1391, i32 0, i32 1
  %t1421 = bitcast [40 x i8]* %t1420 to i8*
  %t1422 = getelementptr inbounds i8, i8* %t1421, i64 24
  %t1423 = bitcast i8* %t1422 to %Block*
  %t1424 = load %Block, %Block* %t1423
  %t1425 = icmp eq i32 %t1390, 12
  %t1426 = select i1 %t1425, %Block %t1424, %Block %t1419
  %t1427 = getelementptr inbounds %Statement, %Statement* %t1391, i32 0, i32 1
  %t1428 = bitcast [24 x i8]* %t1427 to i8*
  %t1429 = getelementptr inbounds i8, i8* %t1428, i64 8
  %t1430 = bitcast i8* %t1429 to %Block*
  %t1431 = load %Block, %Block* %t1430
  %t1432 = icmp eq i32 %t1390, 13
  %t1433 = select i1 %t1432, %Block %t1431, %Block %t1426
  %t1434 = getelementptr inbounds %Statement, %Statement* %t1391, i32 0, i32 1
  %t1435 = bitcast [24 x i8]* %t1434 to i8*
  %t1436 = getelementptr inbounds i8, i8* %t1435, i64 8
  %t1437 = bitcast i8* %t1436 to %Block*
  %t1438 = load %Block, %Block* %t1437
  %t1439 = icmp eq i32 %t1390, 14
  %t1440 = select i1 %t1439, %Block %t1438, %Block %t1433
  %t1441 = getelementptr inbounds %Statement, %Statement* %t1391, i32 0, i32 1
  %t1442 = bitcast [16 x i8]* %t1441 to i8*
  %t1443 = bitcast i8* %t1442 to %Block*
  %t1444 = load %Block, %Block* %t1443
  %t1445 = icmp eq i32 %t1390, 15
  %t1446 = select i1 %t1445, %Block %t1444, %Block %t1440
  %t1447 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1446)
  ret { %EffectRequirement*, i64 }* %t1447
merge35:
  %t1448 = extractvalue %Statement %statement, 0
  %t1449 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1450 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1448, 0
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1448, 1
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %t1456 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1457 = icmp eq i32 %t1448, 2
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1455
  %t1459 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1460 = icmp eq i32 %t1448, 3
  %t1461 = select i1 %t1460, i8* %t1459, i8* %t1458
  %t1462 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1463 = icmp eq i32 %t1448, 4
  %t1464 = select i1 %t1463, i8* %t1462, i8* %t1461
  %t1465 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1466 = icmp eq i32 %t1448, 5
  %t1467 = select i1 %t1466, i8* %t1465, i8* %t1464
  %t1468 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1469 = icmp eq i32 %t1448, 6
  %t1470 = select i1 %t1469, i8* %t1468, i8* %t1467
  %t1471 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1472 = icmp eq i32 %t1448, 7
  %t1473 = select i1 %t1472, i8* %t1471, i8* %t1470
  %t1474 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1475 = icmp eq i32 %t1448, 8
  %t1476 = select i1 %t1475, i8* %t1474, i8* %t1473
  %t1477 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1478 = icmp eq i32 %t1448, 9
  %t1479 = select i1 %t1478, i8* %t1477, i8* %t1476
  %t1480 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1481 = icmp eq i32 %t1448, 10
  %t1482 = select i1 %t1481, i8* %t1480, i8* %t1479
  %t1483 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1484 = icmp eq i32 %t1448, 11
  %t1485 = select i1 %t1484, i8* %t1483, i8* %t1482
  %t1486 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1487 = icmp eq i32 %t1448, 12
  %t1488 = select i1 %t1487, i8* %t1486, i8* %t1485
  %t1489 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1490 = icmp eq i32 %t1448, 13
  %t1491 = select i1 %t1490, i8* %t1489, i8* %t1488
  %t1492 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1493 = icmp eq i32 %t1448, 14
  %t1494 = select i1 %t1493, i8* %t1492, i8* %t1491
  %t1495 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1496 = icmp eq i32 %t1448, 15
  %t1497 = select i1 %t1496, i8* %t1495, i8* %t1494
  %t1498 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1499 = icmp eq i32 %t1448, 16
  %t1500 = select i1 %t1499, i8* %t1498, i8* %t1497
  %t1501 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1502 = icmp eq i32 %t1448, 17
  %t1503 = select i1 %t1502, i8* %t1501, i8* %t1500
  %t1504 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1505 = icmp eq i32 %t1448, 18
  %t1506 = select i1 %t1505, i8* %t1504, i8* %t1503
  %t1507 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1508 = icmp eq i32 %t1448, 19
  %t1509 = select i1 %t1508, i8* %t1507, i8* %t1506
  %t1510 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1511 = icmp eq i32 %t1448, 20
  %t1512 = select i1 %t1511, i8* %t1510, i8* %t1509
  %t1513 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1514 = icmp eq i32 %t1448, 21
  %t1515 = select i1 %t1514, i8* %t1513, i8* %t1512
  %t1516 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1517 = icmp eq i32 %t1448, 22
  %t1518 = select i1 %t1517, i8* %t1516, i8* %t1515
  %s1519 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1519, i32 0, i32 0
  %t1520 = icmp eq i8* %t1518, %s1519
  br i1 %t1520, label %then36, label %merge37
then36:
  %t1521 = extractvalue %Statement %statement, 0
  %t1522 = alloca %Statement
  store %Statement %statement, %Statement* %t1522
  %t1523 = getelementptr inbounds %Statement, %Statement* %t1522, i32 0, i32 1
  %t1524 = bitcast [24 x i8]* %t1523 to i8*
  %t1525 = getelementptr inbounds i8, i8* %t1524, i64 8
  %t1526 = bitcast i8* %t1525 to %Block*
  %t1527 = load %Block, %Block* %t1526
  %t1528 = icmp eq i32 %t1521, 4
  %t1529 = select i1 %t1528, %Block %t1527, %Block zeroinitializer
  %t1530 = getelementptr inbounds %Statement, %Statement* %t1522, i32 0, i32 1
  %t1531 = bitcast [24 x i8]* %t1530 to i8*
  %t1532 = getelementptr inbounds i8, i8* %t1531, i64 8
  %t1533 = bitcast i8* %t1532 to %Block*
  %t1534 = load %Block, %Block* %t1533
  %t1535 = icmp eq i32 %t1521, 5
  %t1536 = select i1 %t1535, %Block %t1534, %Block %t1529
  %t1537 = getelementptr inbounds %Statement, %Statement* %t1522, i32 0, i32 1
  %t1538 = bitcast [40 x i8]* %t1537 to i8*
  %t1539 = getelementptr inbounds i8, i8* %t1538, i64 16
  %t1540 = bitcast i8* %t1539 to %Block*
  %t1541 = load %Block, %Block* %t1540
  %t1542 = icmp eq i32 %t1521, 6
  %t1543 = select i1 %t1542, %Block %t1541, %Block %t1536
  %t1544 = getelementptr inbounds %Statement, %Statement* %t1522, i32 0, i32 1
  %t1545 = bitcast [24 x i8]* %t1544 to i8*
  %t1546 = getelementptr inbounds i8, i8* %t1545, i64 8
  %t1547 = bitcast i8* %t1546 to %Block*
  %t1548 = load %Block, %Block* %t1547
  %t1549 = icmp eq i32 %t1521, 7
  %t1550 = select i1 %t1549, %Block %t1548, %Block %t1543
  %t1551 = getelementptr inbounds %Statement, %Statement* %t1522, i32 0, i32 1
  %t1552 = bitcast [40 x i8]* %t1551 to i8*
  %t1553 = getelementptr inbounds i8, i8* %t1552, i64 24
  %t1554 = bitcast i8* %t1553 to %Block*
  %t1555 = load %Block, %Block* %t1554
  %t1556 = icmp eq i32 %t1521, 12
  %t1557 = select i1 %t1556, %Block %t1555, %Block %t1550
  %t1558 = getelementptr inbounds %Statement, %Statement* %t1522, i32 0, i32 1
  %t1559 = bitcast [24 x i8]* %t1558 to i8*
  %t1560 = getelementptr inbounds i8, i8* %t1559, i64 8
  %t1561 = bitcast i8* %t1560 to %Block*
  %t1562 = load %Block, %Block* %t1561
  %t1563 = icmp eq i32 %t1521, 13
  %t1564 = select i1 %t1563, %Block %t1562, %Block %t1557
  %t1565 = getelementptr inbounds %Statement, %Statement* %t1522, i32 0, i32 1
  %t1566 = bitcast [24 x i8]* %t1565 to i8*
  %t1567 = getelementptr inbounds i8, i8* %t1566, i64 8
  %t1568 = bitcast i8* %t1567 to %Block*
  %t1569 = load %Block, %Block* %t1568
  %t1570 = icmp eq i32 %t1521, 14
  %t1571 = select i1 %t1570, %Block %t1569, %Block %t1564
  %t1572 = getelementptr inbounds %Statement, %Statement* %t1522, i32 0, i32 1
  %t1573 = bitcast [16 x i8]* %t1572 to i8*
  %t1574 = bitcast i8* %t1573 to %Block*
  %t1575 = load %Block, %Block* %t1574
  %t1576 = icmp eq i32 %t1521, 15
  %t1577 = select i1 %t1576, %Block %t1575, %Block %t1571
  %t1578 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1577)
  ret { %EffectRequirement*, i64 }* %t1578
merge37:
  %t1579 = extractvalue %Statement %statement, 0
  %t1580 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1581 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1582 = icmp eq i32 %t1579, 0
  %t1583 = select i1 %t1582, i8* %t1581, i8* %t1580
  %t1584 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1585 = icmp eq i32 %t1579, 1
  %t1586 = select i1 %t1585, i8* %t1584, i8* %t1583
  %t1587 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1588 = icmp eq i32 %t1579, 2
  %t1589 = select i1 %t1588, i8* %t1587, i8* %t1586
  %t1590 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1591 = icmp eq i32 %t1579, 3
  %t1592 = select i1 %t1591, i8* %t1590, i8* %t1589
  %t1593 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1594 = icmp eq i32 %t1579, 4
  %t1595 = select i1 %t1594, i8* %t1593, i8* %t1592
  %t1596 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1597 = icmp eq i32 %t1579, 5
  %t1598 = select i1 %t1597, i8* %t1596, i8* %t1595
  %t1599 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1600 = icmp eq i32 %t1579, 6
  %t1601 = select i1 %t1600, i8* %t1599, i8* %t1598
  %t1602 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1603 = icmp eq i32 %t1579, 7
  %t1604 = select i1 %t1603, i8* %t1602, i8* %t1601
  %t1605 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1606 = icmp eq i32 %t1579, 8
  %t1607 = select i1 %t1606, i8* %t1605, i8* %t1604
  %t1608 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1609 = icmp eq i32 %t1579, 9
  %t1610 = select i1 %t1609, i8* %t1608, i8* %t1607
  %t1611 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1612 = icmp eq i32 %t1579, 10
  %t1613 = select i1 %t1612, i8* %t1611, i8* %t1610
  %t1614 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1615 = icmp eq i32 %t1579, 11
  %t1616 = select i1 %t1615, i8* %t1614, i8* %t1613
  %t1617 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1618 = icmp eq i32 %t1579, 12
  %t1619 = select i1 %t1618, i8* %t1617, i8* %t1616
  %t1620 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1621 = icmp eq i32 %t1579, 13
  %t1622 = select i1 %t1621, i8* %t1620, i8* %t1619
  %t1623 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1624 = icmp eq i32 %t1579, 14
  %t1625 = select i1 %t1624, i8* %t1623, i8* %t1622
  %t1626 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1627 = icmp eq i32 %t1579, 15
  %t1628 = select i1 %t1627, i8* %t1626, i8* %t1625
  %t1629 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1630 = icmp eq i32 %t1579, 16
  %t1631 = select i1 %t1630, i8* %t1629, i8* %t1628
  %t1632 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1633 = icmp eq i32 %t1579, 17
  %t1634 = select i1 %t1633, i8* %t1632, i8* %t1631
  %t1635 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1636 = icmp eq i32 %t1579, 18
  %t1637 = select i1 %t1636, i8* %t1635, i8* %t1634
  %t1638 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1639 = icmp eq i32 %t1579, 19
  %t1640 = select i1 %t1639, i8* %t1638, i8* %t1637
  %t1641 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1642 = icmp eq i32 %t1579, 20
  %t1643 = select i1 %t1642, i8* %t1641, i8* %t1640
  %t1644 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1645 = icmp eq i32 %t1579, 21
  %t1646 = select i1 %t1645, i8* %t1644, i8* %t1643
  %t1647 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1648 = icmp eq i32 %t1579, 22
  %t1649 = select i1 %t1648, i8* %t1647, i8* %t1646
  %s1650 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1650, i32 0, i32 0
  %t1651 = icmp eq i8* %t1649, %s1650
  br i1 %t1651, label %then38, label %merge39
then38:
  %t1652 = alloca [0 x %EffectRequirement]
  %t1653 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1652, i32 0, i32 0
  %t1654 = alloca { %EffectRequirement*, i64 }
  %t1655 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1654, i32 0, i32 0
  store %EffectRequirement* %t1653, %EffectRequirement** %t1655
  %t1656 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1654, i32 0, i32 1
  store i64 0, i64* %t1656
  store { %EffectRequirement*, i64 }* %t1654, { %EffectRequirement*, i64 }** %l8
  %t1657 = sitofp i64 0 to double
  store double %t1657, double* %l9
  %t1658 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1659 = load double, double* %l9
  br label %loop.header40
loop.header40:
  %t1703 = phi { %EffectRequirement*, i64 }* [ %t1658, %then38 ], [ %t1701, %loop.latch42 ]
  %t1704 = phi double [ %t1659, %then38 ], [ %t1702, %loop.latch42 ]
  store { %EffectRequirement*, i64 }* %t1703, { %EffectRequirement*, i64 }** %l8
  store double %t1704, double* %l9
  br label %loop.body41
loop.body41:
  %t1660 = load double, double* %l9
  %t1661 = extractvalue %Statement %statement, 0
  %t1662 = alloca %Statement
  store %Statement %statement, %Statement* %t1662
  %t1663 = getelementptr inbounds %Statement, %Statement* %t1662, i32 0, i32 1
  %t1664 = bitcast [56 x i8]* %t1663 to i8*
  %t1665 = getelementptr inbounds i8, i8* %t1664, i64 40
  %t1666 = bitcast i8* %t1665 to { %MethodDeclaration**, i64 }**
  %t1667 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1666
  %t1668 = icmp eq i32 %t1661, 8
  %t1669 = select i1 %t1668, { %MethodDeclaration**, i64 }* %t1667, { %MethodDeclaration**, i64 }* null
  %t1670 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1669
  %t1671 = extractvalue { %MethodDeclaration**, i64 } %t1670, 1
  %t1672 = sitofp i64 %t1671 to double
  %t1673 = fcmp oge double %t1660, %t1672
  %t1674 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1675 = load double, double* %l9
  br i1 %t1673, label %then44, label %merge45
then44:
  br label %afterloop43
merge45:
  %t1676 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1677 = extractvalue %Statement %statement, 0
  %t1678 = alloca %Statement
  store %Statement %statement, %Statement* %t1678
  %t1679 = getelementptr inbounds %Statement, %Statement* %t1678, i32 0, i32 1
  %t1680 = bitcast [56 x i8]* %t1679 to i8*
  %t1681 = getelementptr inbounds i8, i8* %t1680, i64 40
  %t1682 = bitcast i8* %t1681 to { %MethodDeclaration**, i64 }**
  %t1683 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1682
  %t1684 = icmp eq i32 %t1677, 8
  %t1685 = select i1 %t1684, { %MethodDeclaration**, i64 }* %t1683, { %MethodDeclaration**, i64 }* null
  %t1686 = load double, double* %l9
  %t1687 = fptosi double %t1686 to i64
  %t1688 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1685
  %t1689 = extractvalue { %MethodDeclaration**, i64 } %t1688, 0
  %t1690 = extractvalue { %MethodDeclaration**, i64 } %t1688, 1
  %t1691 = icmp uge i64 %t1687, %t1690
  ; bounds check: %t1691 (if true, out of bounds)
  %t1692 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1689, i64 %t1687
  %t1693 = load %MethodDeclaration*, %MethodDeclaration** %t1692
  %t1694 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1693, i32 0, i32 1
  %t1695 = load %Block, %Block* %t1694
  %t1696 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1695)
  %t1697 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1676, { %EffectRequirement*, i64 }* %t1696)
  store { %EffectRequirement*, i64 }* %t1697, { %EffectRequirement*, i64 }** %l8
  %t1698 = load double, double* %l9
  %t1699 = sitofp i64 1 to double
  %t1700 = fadd double %t1698, %t1699
  store double %t1700, double* %l9
  br label %loop.latch42
loop.latch42:
  %t1701 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t1702 = load double, double* %l9
  br label %loop.header40
afterloop43:
  %t1705 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  ret { %EffectRequirement*, i64 }* %t1705
merge39:
  %t1706 = extractvalue %Statement %statement, 0
  %t1707 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1708 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1706, 0
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %t1711 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1712 = icmp eq i32 %t1706, 1
  %t1713 = select i1 %t1712, i8* %t1711, i8* %t1710
  %t1714 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1715 = icmp eq i32 %t1706, 2
  %t1716 = select i1 %t1715, i8* %t1714, i8* %t1713
  %t1717 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1718 = icmp eq i32 %t1706, 3
  %t1719 = select i1 %t1718, i8* %t1717, i8* %t1716
  %t1720 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1721 = icmp eq i32 %t1706, 4
  %t1722 = select i1 %t1721, i8* %t1720, i8* %t1719
  %t1723 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1724 = icmp eq i32 %t1706, 5
  %t1725 = select i1 %t1724, i8* %t1723, i8* %t1722
  %t1726 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1727 = icmp eq i32 %t1706, 6
  %t1728 = select i1 %t1727, i8* %t1726, i8* %t1725
  %t1729 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1730 = icmp eq i32 %t1706, 7
  %t1731 = select i1 %t1730, i8* %t1729, i8* %t1728
  %t1732 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1733 = icmp eq i32 %t1706, 8
  %t1734 = select i1 %t1733, i8* %t1732, i8* %t1731
  %t1735 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1736 = icmp eq i32 %t1706, 9
  %t1737 = select i1 %t1736, i8* %t1735, i8* %t1734
  %t1738 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1739 = icmp eq i32 %t1706, 10
  %t1740 = select i1 %t1739, i8* %t1738, i8* %t1737
  %t1741 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1742 = icmp eq i32 %t1706, 11
  %t1743 = select i1 %t1742, i8* %t1741, i8* %t1740
  %t1744 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1745 = icmp eq i32 %t1706, 12
  %t1746 = select i1 %t1745, i8* %t1744, i8* %t1743
  %t1747 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1748 = icmp eq i32 %t1706, 13
  %t1749 = select i1 %t1748, i8* %t1747, i8* %t1746
  %t1750 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1751 = icmp eq i32 %t1706, 14
  %t1752 = select i1 %t1751, i8* %t1750, i8* %t1749
  %t1753 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1754 = icmp eq i32 %t1706, 15
  %t1755 = select i1 %t1754, i8* %t1753, i8* %t1752
  %t1756 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1757 = icmp eq i32 %t1706, 16
  %t1758 = select i1 %t1757, i8* %t1756, i8* %t1755
  %t1759 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1760 = icmp eq i32 %t1706, 17
  %t1761 = select i1 %t1760, i8* %t1759, i8* %t1758
  %t1762 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1763 = icmp eq i32 %t1706, 18
  %t1764 = select i1 %t1763, i8* %t1762, i8* %t1761
  %t1765 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1766 = icmp eq i32 %t1706, 19
  %t1767 = select i1 %t1766, i8* %t1765, i8* %t1764
  %t1768 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1769 = icmp eq i32 %t1706, 20
  %t1770 = select i1 %t1769, i8* %t1768, i8* %t1767
  %t1771 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1772 = icmp eq i32 %t1706, 21
  %t1773 = select i1 %t1772, i8* %t1771, i8* %t1770
  %t1774 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1775 = icmp eq i32 %t1706, 22
  %t1776 = select i1 %t1775, i8* %t1774, i8* %t1773
  %s1777 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1777, i32 0, i32 0
  %t1778 = icmp eq i8* %t1776, %s1777
  br i1 %t1778, label %then46, label %merge47
then46:
  %t1779 = alloca [0 x %EffectRequirement]
  %t1780 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1779, i32 0, i32 0
  %t1781 = alloca { %EffectRequirement*, i64 }
  %t1782 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1781, i32 0, i32 0
  store %EffectRequirement* %t1780, %EffectRequirement** %t1782
  %t1783 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1781, i32 0, i32 1
  store i64 0, i64* %t1783
  store { %EffectRequirement*, i64 }* %t1781, { %EffectRequirement*, i64 }** %l10
  %t1784 = sitofp i64 0 to double
  store double %t1784, double* %l11
  %t1785 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1786 = load double, double* %l11
  br label %loop.header48
loop.header48:
  %t1830 = phi { %EffectRequirement*, i64 }* [ %t1785, %then46 ], [ %t1828, %loop.latch50 ]
  %t1831 = phi double [ %t1786, %then46 ], [ %t1829, %loop.latch50 ]
  store { %EffectRequirement*, i64 }* %t1830, { %EffectRequirement*, i64 }** %l10
  store double %t1831, double* %l11
  br label %loop.body49
loop.body49:
  %t1787 = load double, double* %l11
  %t1788 = extractvalue %Statement %statement, 0
  %t1789 = alloca %Statement
  store %Statement %statement, %Statement* %t1789
  %t1790 = getelementptr inbounds %Statement, %Statement* %t1789, i32 0, i32 1
  %t1791 = bitcast [48 x i8]* %t1790 to i8*
  %t1792 = getelementptr inbounds i8, i8* %t1791, i64 24
  %t1793 = bitcast i8* %t1792 to { %ModelProperty**, i64 }**
  %t1794 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1793
  %t1795 = icmp eq i32 %t1788, 3
  %t1796 = select i1 %t1795, { %ModelProperty**, i64 }* %t1794, { %ModelProperty**, i64 }* null
  %t1797 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1796
  %t1798 = extractvalue { %ModelProperty**, i64 } %t1797, 1
  %t1799 = sitofp i64 %t1798 to double
  %t1800 = fcmp oge double %t1787, %t1799
  %t1801 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1802 = load double, double* %l11
  br i1 %t1800, label %then52, label %merge53
then52:
  br label %afterloop51
merge53:
  %t1803 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1804 = extractvalue %Statement %statement, 0
  %t1805 = alloca %Statement
  store %Statement %statement, %Statement* %t1805
  %t1806 = getelementptr inbounds %Statement, %Statement* %t1805, i32 0, i32 1
  %t1807 = bitcast [48 x i8]* %t1806 to i8*
  %t1808 = getelementptr inbounds i8, i8* %t1807, i64 24
  %t1809 = bitcast i8* %t1808 to { %ModelProperty**, i64 }**
  %t1810 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1809
  %t1811 = icmp eq i32 %t1804, 3
  %t1812 = select i1 %t1811, { %ModelProperty**, i64 }* %t1810, { %ModelProperty**, i64 }* null
  %t1813 = load double, double* %l11
  %t1814 = fptosi double %t1813 to i64
  %t1815 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1812
  %t1816 = extractvalue { %ModelProperty**, i64 } %t1815, 0
  %t1817 = extractvalue { %ModelProperty**, i64 } %t1815, 1
  %t1818 = icmp uge i64 %t1814, %t1817
  ; bounds check: %t1818 (if true, out of bounds)
  %t1819 = getelementptr %ModelProperty*, %ModelProperty** %t1816, i64 %t1814
  %t1820 = load %ModelProperty*, %ModelProperty** %t1819
  %t1821 = getelementptr %ModelProperty, %ModelProperty* %t1820, i32 0, i32 1
  %t1822 = load %Expression, %Expression* %t1821
  %t1823 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* null)
  %t1824 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1803, { %EffectRequirement*, i64 }* %t1823)
  store { %EffectRequirement*, i64 }* %t1824, { %EffectRequirement*, i64 }** %l10
  %t1825 = load double, double* %l11
  %t1826 = sitofp i64 1 to double
  %t1827 = fadd double %t1825, %t1826
  store double %t1827, double* %l11
  br label %loop.latch50
loop.latch50:
  %t1828 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  %t1829 = load double, double* %l11
  br label %loop.header48
afterloop51:
  %t1832 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l10
  ret { %EffectRequirement*, i64 }* %t1832
merge47:
  %t1833 = extractvalue %Statement %statement, 0
  %t1834 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1835 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1833, 0
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1833, 1
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1833, 2
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1833, 3
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %t1847 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1848 = icmp eq i32 %t1833, 4
  %t1849 = select i1 %t1848, i8* %t1847, i8* %t1846
  %t1850 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1851 = icmp eq i32 %t1833, 5
  %t1852 = select i1 %t1851, i8* %t1850, i8* %t1849
  %t1853 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1854 = icmp eq i32 %t1833, 6
  %t1855 = select i1 %t1854, i8* %t1853, i8* %t1852
  %t1856 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1857 = icmp eq i32 %t1833, 7
  %t1858 = select i1 %t1857, i8* %t1856, i8* %t1855
  %t1859 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1860 = icmp eq i32 %t1833, 8
  %t1861 = select i1 %t1860, i8* %t1859, i8* %t1858
  %t1862 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1863 = icmp eq i32 %t1833, 9
  %t1864 = select i1 %t1863, i8* %t1862, i8* %t1861
  %t1865 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1866 = icmp eq i32 %t1833, 10
  %t1867 = select i1 %t1866, i8* %t1865, i8* %t1864
  %t1868 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1869 = icmp eq i32 %t1833, 11
  %t1870 = select i1 %t1869, i8* %t1868, i8* %t1867
  %t1871 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1872 = icmp eq i32 %t1833, 12
  %t1873 = select i1 %t1872, i8* %t1871, i8* %t1870
  %t1874 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1875 = icmp eq i32 %t1833, 13
  %t1876 = select i1 %t1875, i8* %t1874, i8* %t1873
  %t1877 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1878 = icmp eq i32 %t1833, 14
  %t1879 = select i1 %t1878, i8* %t1877, i8* %t1876
  %t1880 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1881 = icmp eq i32 %t1833, 15
  %t1882 = select i1 %t1881, i8* %t1880, i8* %t1879
  %t1883 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1884 = icmp eq i32 %t1833, 16
  %t1885 = select i1 %t1884, i8* %t1883, i8* %t1882
  %t1886 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1887 = icmp eq i32 %t1833, 17
  %t1888 = select i1 %t1887, i8* %t1886, i8* %t1885
  %t1889 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1890 = icmp eq i32 %t1833, 18
  %t1891 = select i1 %t1890, i8* %t1889, i8* %t1888
  %t1892 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1893 = icmp eq i32 %t1833, 19
  %t1894 = select i1 %t1893, i8* %t1892, i8* %t1891
  %t1895 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1896 = icmp eq i32 %t1833, 20
  %t1897 = select i1 %t1896, i8* %t1895, i8* %t1894
  %t1898 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1899 = icmp eq i32 %t1833, 21
  %t1900 = select i1 %t1899, i8* %t1898, i8* %t1897
  %t1901 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1902 = icmp eq i32 %t1833, 22
  %t1903 = select i1 %t1902, i8* %t1901, i8* %t1900
  %s1904 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1904, i32 0, i32 0
  %t1905 = icmp eq i8* %t1903, %s1904
  br i1 %t1905, label %then54, label %merge55
then54:
  %t1906 = extractvalue %Statement %statement, 0
  %t1907 = alloca %Statement
  store %Statement %statement, %Statement* %t1907
  %t1908 = getelementptr inbounds %Statement, %Statement* %t1907, i32 0, i32 1
  %t1909 = bitcast [16 x i8]* %t1908 to i8*
  %t1910 = bitcast i8* %t1909 to { %Token**, i64 }**
  %t1911 = load { %Token**, i64 }*, { %Token**, i64 }** %t1910
  %t1912 = icmp eq i32 %t1906, 22
  %t1913 = select i1 %t1912, { %Token**, i64 }* %t1911, { %Token**, i64 }* null
  %t1914 = bitcast { %Token**, i64 }* %t1913 to { %Token*, i64 }*
  %t1915 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1914)
  ret { %EffectRequirement*, i64 }* %t1915
merge55:
  %t1916 = alloca [0 x %EffectRequirement]
  %t1917 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1916, i32 0, i32 0
  %t1918 = alloca { %EffectRequirement*, i64 }
  %t1919 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1918, i32 0, i32 0
  store %EffectRequirement* %t1917, %EffectRequirement** %t1919
  %t1920 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1918, i32 0, i32 1
  store i64 0, i64* %t1920
  ret { %EffectRequirement*, i64 }* %t1918
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
  %t7 = extractvalue %ElseBranch %branch, 0
  %t8 = bitcast i8* null to %Statement*
  %t9 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t9
}

define { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %case) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* null)
  store { %EffectRequirement*, i64 }* %t1, { %EffectRequirement*, i64 }** %l0
  %t2 = extractvalue %MatchCase %case, 1
  %t3 = bitcast i8* null to %Expression*
  %t4 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t5 = extractvalue %MatchCase %case, 2
  %t6 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t5)
  %t7 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t4, { %EffectRequirement*, i64 }* %t6)
  store { %EffectRequirement*, i64 }* %t7, { %EffectRequirement*, i64 }** %l0
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t8
}

define { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %expression) {
entry:
  %t0 = icmp eq i8* %expression, null
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
  %t6 = alloca [0 x %EffectRequirement]
  %t7 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t6, i32 0, i32 0
  %t8 = alloca { %EffectRequirement*, i64 }
  %t9 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t8, i32 0, i32 0
  store %EffectRequirement* %t7, %EffectRequirement** %t9
  %t10 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  ret { %EffectRequirement*, i64 }* %t8
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
  %t179 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t177, %loop.latch2 ]
  %t180 = phi double [ %t2, %entry ], [ %t178, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t179, { %EffectRequirement*, i64 }** %l0
  store double %t180, double* %l1
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
  %t150 = insertvalue %EffectRequirement %t148, %Token* null, 1
  %t151 = load i8*, i8** %l4
  %t152 = insertvalue %EffectRequirement %t150, i8* %t151, 2
  %t153 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t146, %EffectRequirement %t152)
  store { %EffectRequirement*, i64 }* %t153, { %EffectRequirement*, i64 }** %l0
  %t154 = load double, double* %l1
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %t154, %t155
  store double %t156, double* %l1
  br label %loop.latch2
merge13:
  br label %merge11
merge11:
  %t157 = phi i8* [ %t116, %then10 ], [ %t111, %then8 ]
  %t158 = phi { %EffectRequirement*, i64 }* [ %t153, %then10 ], [ %t107, %then8 ]
  %t159 = phi double [ %t156, %then10 ], [ %t108, %then8 ]
  store i8* %t157, i8** %l4
  store { %EffectRequirement*, i64 }* %t158, { %EffectRequirement*, i64 }** %l0
  store double %t159, double* %l1
  br label %merge9
merge9:
  %t160 = phi i8* [ %t116, %then8 ], [ %t36, %then6 ]
  %t161 = phi { %EffectRequirement*, i64 }* [ %t153, %then8 ], [ %t32, %then6 ]
  %t162 = phi double [ %t156, %then8 ], [ %t33, %then6 ]
  store i8* %t160, i8** %l4
  store { %EffectRequirement*, i64 }* %t161, { %EffectRequirement*, i64 }** %l0
  store double %t162, double* %l1
  %t163 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s164 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.164, i32 0, i32 0
  %t165 = insertvalue %EffectRequirement undef, i8* %s164, 0
  %t166 = load %Token, %Token* %l2
  %t167 = insertvalue %EffectRequirement %t165, %Token* null, 1
  %t168 = load i8*, i8** %l4
  %t169 = insertvalue %EffectRequirement %t167, i8* %t168, 2
  %t170 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t163, %EffectRequirement %t169)
  store { %EffectRequirement*, i64 }* %t170, { %EffectRequirement*, i64 }** %l0
  br label %merge7
merge7:
  %t171 = phi { %EffectRequirement*, i64 }* [ %t153, %then6 ], [ %t21, %loop.body1 ]
  %t172 = phi double [ %t156, %then6 ], [ %t22, %loop.body1 ]
  %t173 = phi { %EffectRequirement*, i64 }* [ %t170, %then6 ], [ %t21, %loop.body1 ]
  store { %EffectRequirement*, i64 }* %t171, { %EffectRequirement*, i64 }** %l0
  store double %t172, double* %l1
  store { %EffectRequirement*, i64 }* %t173, { %EffectRequirement*, i64 }** %l0
  %t174 = load double, double* %l1
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l1
  br label %loop.latch2
loop.latch2:
  %t177 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t178 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t181 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t181
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
  %t37 = phi { %EffectRequirement*, i64 }* [ %t7, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t8, %entry ], [ %t36, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t37, { %EffectRequirement*, i64 }** %l1
  store double %t38, double* %l2
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
  %t29 = insertvalue %EffectRequirement %t19, %Token* null, 1
  %t30 = insertvalue %EffectRequirement %t29, i8* %description, 2
  %t31 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t18, %EffectRequirement %t30)
  store { %EffectRequirement*, i64 }* %t31, { %EffectRequirement*, i64 }** %l1
  %t32 = load double, double* %l2
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l2
  br label %loop.latch2
loop.latch2:
  %t35 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t36 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t39 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t39
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
  %t33 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t4, %entry ], [ %t32, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t33, { %EffectRequirement*, i64 }** %l1
  store double %t34, double* %l2
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
  %t25 = insertvalue %EffectRequirement %t15, %Token* null, 1
  %t26 = insertvalue %EffectRequirement %t25, i8* %description, 2
  %t27 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t14, %EffectRequirement %t26)
  store { %EffectRequirement*, i64 }* %t27, { %EffectRequirement*, i64 }** %l1
  %t28 = load double, double* %l2
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l2
  br label %loop.latch2
loop.latch2:
  %t31 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t32 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t35 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t35
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
  %l0 = alloca double
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
  store double 0.0, double* %l0
  %t31 = load double, double* %l0
  br label %merge1
merge1:
  %t32 = extractvalue %Token %token, 1
  %t33 = icmp eq i8* %t32, %expected
  ret i1 %t33
}

define i1 @is_symbol_token(%Token %token, i8* %expected) {
entry:
  %l0 = alloca double
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
  store double 0.0, double* %l0
  %t31 = load double, double* %l0
  br label %merge1
merge1:
  %t32 = extractvalue %Token %token, 1
  %t33 = icmp eq i8* %t32, %expected
  ret i1 %t33
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
  %t6 = bitcast { %EffectViolation*, i64 }* %t3 to { i8**, i64 }*
  %t7 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6)
  %t8 = bitcast { i8**, i64 }* %t7 to { %EffectViolation*, i64 }*
  ret { %EffectViolation*, i64 }* %t8
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
  %t6 = bitcast { %EffectRequirement*, i64 }* %t3 to { i8**, i64 }*
  %t7 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6)
  %t8 = bitcast { i8**, i64 }* %t7 to { %EffectRequirement*, i64 }*
  ret { %EffectRequirement*, i64 }* %t8
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
