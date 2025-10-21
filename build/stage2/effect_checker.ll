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

declare i8* @sailfin_runtime_get_field(i8*, i8*)

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

define { %EffectRequirement*, i64 }* @collect_effects_from_optional_block(%Block* %block) {
entry:
  %t0 = icmp eq %Block* %block, null
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
  %t6 = load %Block, %Block* %block
  %t7 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t6)
  ret { %EffectRequirement*, i64 }* %t7
}

define { %EffectRequirement*, i64 }* @collect_effects_from_optional_statement(%Statement* %statement) {
entry:
  %t0 = icmp eq %Statement* %statement, null
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
  %t6 = load %Statement, %Statement* %statement
  %t7 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %t6)
  ret { %EffectRequirement*, i64 }* %t7
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
  %t475 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t476 = extractvalue %Statement %statement, 0
  %t477 = alloca %Statement
  store %Statement %statement, %Statement* %t477
  %t478 = getelementptr inbounds %Statement, %Statement* %t477, i32 0, i32 1
  %t479 = bitcast [24 x i8]* %t478 to i8*
  %t480 = bitcast i8* %t479 to %ForClause*
  %t481 = load %ForClause, %ForClause* %t480
  %t482 = icmp eq i32 %t476, 14
  %t483 = select i1 %t482, %ForClause %t481, %ForClause zeroinitializer
  %t484 = extractvalue %ForClause %t483, 0
  %t485 = alloca %Expression
  store %Expression %t484, %Expression* %t485
  %t486 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t485)
  %t487 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t475, { %EffectRequirement*, i64 }* %t486)
  store { %EffectRequirement*, i64 }* %t487, { %EffectRequirement*, i64 }** %l4
  %t488 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  %t489 = extractvalue %Statement %statement, 0
  %t490 = alloca %Statement
  store %Statement %statement, %Statement* %t490
  %t491 = getelementptr inbounds %Statement, %Statement* %t490, i32 0, i32 1
  %t492 = bitcast [24 x i8]* %t491 to i8*
  %t493 = bitcast i8* %t492 to %ForClause*
  %t494 = load %ForClause, %ForClause* %t493
  %t495 = icmp eq i32 %t489, 14
  %t496 = select i1 %t495, %ForClause %t494, %ForClause zeroinitializer
  %t497 = extractvalue %ForClause %t496, 1
  %t498 = alloca %Expression
  store %Expression %t497, %Expression* %t498
  %t499 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t498)
  %t500 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t488, { %EffectRequirement*, i64 }* %t499)
  store { %EffectRequirement*, i64 }* %t500, { %EffectRequirement*, i64 }** %l4
  %t501 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l4
  ret { %EffectRequirement*, i64 }* %t501
merge11:
  %t502 = extractvalue %Statement %statement, 0
  %t503 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t504 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t505 = icmp eq i32 %t502, 0
  %t506 = select i1 %t505, i8* %t504, i8* %t503
  %t507 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t508 = icmp eq i32 %t502, 1
  %t509 = select i1 %t508, i8* %t507, i8* %t506
  %t510 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t511 = icmp eq i32 %t502, 2
  %t512 = select i1 %t511, i8* %t510, i8* %t509
  %t513 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t514 = icmp eq i32 %t502, 3
  %t515 = select i1 %t514, i8* %t513, i8* %t512
  %t516 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t517 = icmp eq i32 %t502, 4
  %t518 = select i1 %t517, i8* %t516, i8* %t515
  %t519 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t520 = icmp eq i32 %t502, 5
  %t521 = select i1 %t520, i8* %t519, i8* %t518
  %t522 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t523 = icmp eq i32 %t502, 6
  %t524 = select i1 %t523, i8* %t522, i8* %t521
  %t525 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t526 = icmp eq i32 %t502, 7
  %t527 = select i1 %t526, i8* %t525, i8* %t524
  %t528 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t529 = icmp eq i32 %t502, 8
  %t530 = select i1 %t529, i8* %t528, i8* %t527
  %t531 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t532 = icmp eq i32 %t502, 9
  %t533 = select i1 %t532, i8* %t531, i8* %t530
  %t534 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t535 = icmp eq i32 %t502, 10
  %t536 = select i1 %t535, i8* %t534, i8* %t533
  %t537 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t538 = icmp eq i32 %t502, 11
  %t539 = select i1 %t538, i8* %t537, i8* %t536
  %t540 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t541 = icmp eq i32 %t502, 12
  %t542 = select i1 %t541, i8* %t540, i8* %t539
  %t543 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t544 = icmp eq i32 %t502, 13
  %t545 = select i1 %t544, i8* %t543, i8* %t542
  %t546 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t547 = icmp eq i32 %t502, 14
  %t548 = select i1 %t547, i8* %t546, i8* %t545
  %t549 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t550 = icmp eq i32 %t502, 15
  %t551 = select i1 %t550, i8* %t549, i8* %t548
  %t552 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t553 = icmp eq i32 %t502, 16
  %t554 = select i1 %t553, i8* %t552, i8* %t551
  %t555 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t556 = icmp eq i32 %t502, 17
  %t557 = select i1 %t556, i8* %t555, i8* %t554
  %t558 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t559 = icmp eq i32 %t502, 18
  %t560 = select i1 %t559, i8* %t558, i8* %t557
  %t561 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t562 = icmp eq i32 %t502, 19
  %t563 = select i1 %t562, i8* %t561, i8* %t560
  %t564 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t565 = icmp eq i32 %t502, 20
  %t566 = select i1 %t565, i8* %t564, i8* %t563
  %t567 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t568 = icmp eq i32 %t502, 21
  %t569 = select i1 %t568, i8* %t567, i8* %t566
  %t570 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t571 = icmp eq i32 %t502, 22
  %t572 = select i1 %t571, i8* %t570, i8* %t569
  %s573 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.573, i32 0, i32 0
  %t574 = icmp eq i8* %t572, %s573
  br i1 %t574, label %then12, label %merge13
then12:
  %t575 = extractvalue %Statement %statement, 0
  %t576 = alloca %Statement
  store %Statement %statement, %Statement* %t576
  %t577 = getelementptr inbounds %Statement, %Statement* %t576, i32 0, i32 1
  %t578 = bitcast [24 x i8]* %t577 to i8*
  %t579 = getelementptr inbounds i8, i8* %t578, i64 8
  %t580 = bitcast i8* %t579 to %Block*
  %t581 = load %Block, %Block* %t580
  %t582 = icmp eq i32 %t575, 4
  %t583 = select i1 %t582, %Block %t581, %Block zeroinitializer
  %t584 = getelementptr inbounds %Statement, %Statement* %t576, i32 0, i32 1
  %t585 = bitcast [24 x i8]* %t584 to i8*
  %t586 = getelementptr inbounds i8, i8* %t585, i64 8
  %t587 = bitcast i8* %t586 to %Block*
  %t588 = load %Block, %Block* %t587
  %t589 = icmp eq i32 %t575, 5
  %t590 = select i1 %t589, %Block %t588, %Block %t583
  %t591 = getelementptr inbounds %Statement, %Statement* %t576, i32 0, i32 1
  %t592 = bitcast [40 x i8]* %t591 to i8*
  %t593 = getelementptr inbounds i8, i8* %t592, i64 16
  %t594 = bitcast i8* %t593 to %Block*
  %t595 = load %Block, %Block* %t594
  %t596 = icmp eq i32 %t575, 6
  %t597 = select i1 %t596, %Block %t595, %Block %t590
  %t598 = getelementptr inbounds %Statement, %Statement* %t576, i32 0, i32 1
  %t599 = bitcast [24 x i8]* %t598 to i8*
  %t600 = getelementptr inbounds i8, i8* %t599, i64 8
  %t601 = bitcast i8* %t600 to %Block*
  %t602 = load %Block, %Block* %t601
  %t603 = icmp eq i32 %t575, 7
  %t604 = select i1 %t603, %Block %t602, %Block %t597
  %t605 = getelementptr inbounds %Statement, %Statement* %t576, i32 0, i32 1
  %t606 = bitcast [40 x i8]* %t605 to i8*
  %t607 = getelementptr inbounds i8, i8* %t606, i64 24
  %t608 = bitcast i8* %t607 to %Block*
  %t609 = load %Block, %Block* %t608
  %t610 = icmp eq i32 %t575, 12
  %t611 = select i1 %t610, %Block %t609, %Block %t604
  %t612 = getelementptr inbounds %Statement, %Statement* %t576, i32 0, i32 1
  %t613 = bitcast [24 x i8]* %t612 to i8*
  %t614 = getelementptr inbounds i8, i8* %t613, i64 8
  %t615 = bitcast i8* %t614 to %Block*
  %t616 = load %Block, %Block* %t615
  %t617 = icmp eq i32 %t575, 13
  %t618 = select i1 %t617, %Block %t616, %Block %t611
  %t619 = getelementptr inbounds %Statement, %Statement* %t576, i32 0, i32 1
  %t620 = bitcast [24 x i8]* %t619 to i8*
  %t621 = getelementptr inbounds i8, i8* %t620, i64 8
  %t622 = bitcast i8* %t621 to %Block*
  %t623 = load %Block, %Block* %t622
  %t624 = icmp eq i32 %t575, 14
  %t625 = select i1 %t624, %Block %t623, %Block %t618
  %t626 = getelementptr inbounds %Statement, %Statement* %t576, i32 0, i32 1
  %t627 = bitcast [16 x i8]* %t626 to i8*
  %t628 = bitcast i8* %t627 to %Block*
  %t629 = load %Block, %Block* %t628
  %t630 = icmp eq i32 %t575, 15
  %t631 = select i1 %t630, %Block %t629, %Block %t625
  %t632 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t631)
  ret { %EffectRequirement*, i64 }* %t632
merge13:
  %t633 = extractvalue %Statement %statement, 0
  %t634 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t635 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t633, 0
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t633, 1
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t633, 2
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t633, 3
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t633, 4
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t633, 5
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t633, 6
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t633, 7
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t633, 8
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t633, 9
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t633, 10
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t633, 11
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t633, 12
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t633, 13
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t633, 14
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t633, 15
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t633, 16
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t633, 17
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t633, 18
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t633, 19
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t633, 20
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t633, 21
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t633, 22
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %s704 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.704, i32 0, i32 0
  %t705 = icmp eq i8* %t703, %s704
  br i1 %t705, label %then14, label %merge15
then14:
  %t706 = extractvalue %Statement %statement, 0
  %t707 = alloca %Statement
  store %Statement %statement, %Statement* %t707
  %t708 = getelementptr inbounds %Statement, %Statement* %t707, i32 0, i32 1
  %t709 = bitcast [16 x i8]* %t708 to i8*
  %t710 = bitcast i8* %t709 to %Expression**
  %t711 = load %Expression*, %Expression** %t710
  %t712 = icmp eq i32 %t706, 20
  %t713 = select i1 %t712, %Expression* %t711, %Expression* null
  %t714 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t713)
  store { %EffectRequirement*, i64 }* %t714, { %EffectRequirement*, i64 }** %l5
  %t715 = sitofp i64 0 to double
  store double %t715, double* %l6
  %t716 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t717 = load double, double* %l6
  br label %loop.header16
loop.header16:
  %t760 = phi { %EffectRequirement*, i64 }* [ %t716, %then14 ], [ %t758, %loop.latch18 ]
  %t761 = phi double [ %t717, %then14 ], [ %t759, %loop.latch18 ]
  store { %EffectRequirement*, i64 }* %t760, { %EffectRequirement*, i64 }** %l5
  store double %t761, double* %l6
  br label %loop.body17
loop.body17:
  %t718 = load double, double* %l6
  %t719 = extractvalue %Statement %statement, 0
  %t720 = alloca %Statement
  store %Statement %statement, %Statement* %t720
  %t721 = getelementptr inbounds %Statement, %Statement* %t720, i32 0, i32 1
  %t722 = bitcast [24 x i8]* %t721 to i8*
  %t723 = getelementptr inbounds i8, i8* %t722, i64 8
  %t724 = bitcast i8* %t723 to { %MatchCase**, i64 }**
  %t725 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t724
  %t726 = icmp eq i32 %t719, 18
  %t727 = select i1 %t726, { %MatchCase**, i64 }* %t725, { %MatchCase**, i64 }* null
  %t728 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t727
  %t729 = extractvalue { %MatchCase**, i64 } %t728, 1
  %t730 = sitofp i64 %t729 to double
  %t731 = fcmp oge double %t718, %t730
  %t732 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t733 = load double, double* %l6
  br i1 %t731, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t734 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t735 = extractvalue %Statement %statement, 0
  %t736 = alloca %Statement
  store %Statement %statement, %Statement* %t736
  %t737 = getelementptr inbounds %Statement, %Statement* %t736, i32 0, i32 1
  %t738 = bitcast [24 x i8]* %t737 to i8*
  %t739 = getelementptr inbounds i8, i8* %t738, i64 8
  %t740 = bitcast i8* %t739 to { %MatchCase**, i64 }**
  %t741 = load { %MatchCase**, i64 }*, { %MatchCase**, i64 }** %t740
  %t742 = icmp eq i32 %t735, 18
  %t743 = select i1 %t742, { %MatchCase**, i64 }* %t741, { %MatchCase**, i64 }* null
  %t744 = load double, double* %l6
  %t745 = fptosi double %t744 to i64
  %t746 = load { %MatchCase**, i64 }, { %MatchCase**, i64 }* %t743
  %t747 = extractvalue { %MatchCase**, i64 } %t746, 0
  %t748 = extractvalue { %MatchCase**, i64 } %t746, 1
  %t749 = icmp uge i64 %t745, %t748
  ; bounds check: %t749 (if true, out of bounds)
  %t750 = getelementptr %MatchCase*, %MatchCase** %t747, i64 %t745
  %t751 = load %MatchCase*, %MatchCase** %t750
  %t752 = load %MatchCase, %MatchCase* %t751
  %t753 = call { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %t752)
  %t754 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t734, { %EffectRequirement*, i64 }* %t753)
  store { %EffectRequirement*, i64 }* %t754, { %EffectRequirement*, i64 }** %l5
  %t755 = load double, double* %l6
  %t756 = sitofp i64 1 to double
  %t757 = fadd double %t755, %t756
  store double %t757, double* %l6
  br label %loop.latch18
loop.latch18:
  %t758 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  %t759 = load double, double* %l6
  br label %loop.header16
afterloop19:
  %t762 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l5
  ret { %EffectRequirement*, i64 }* %t762
merge15:
  %t763 = extractvalue %Statement %statement, 0
  %t764 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t765 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t763, 0
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t763, 1
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t763, 2
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t763, 3
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t763, 4
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t763, 5
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t763, 6
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t763, 7
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t763, 8
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t763, 9
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t763, 10
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t763, 11
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t763, 12
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t763, 13
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t763, 14
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t763, 15
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t763, 16
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t763, 17
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t763, 18
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t763, 19
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t763, 20
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t763, 21
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t763, 22
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %s834 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.834, i32 0, i32 0
  %t835 = icmp eq i8* %t833, %s834
  br i1 %t835, label %then22, label %merge23
then22:
  %t836 = extractvalue %Statement %statement, 0
  %t837 = alloca %Statement
  store %Statement %statement, %Statement* %t837
  %t838 = getelementptr inbounds %Statement, %Statement* %t837, i32 0, i32 1
  %t839 = bitcast [32 x i8]* %t838 to i8*
  %t840 = bitcast i8* %t839 to %Expression*
  %t841 = load %Expression, %Expression* %t840
  %t842 = icmp eq i32 %t836, 19
  %t843 = select i1 %t842, %Expression %t841, %Expression zeroinitializer
  %t844 = alloca %Expression
  store %Expression %t843, %Expression* %t844
  %t845 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t844)
  store { %EffectRequirement*, i64 }* %t845, { %EffectRequirement*, i64 }** %l7
  %t846 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t847 = extractvalue %Statement %statement, 0
  %t848 = alloca %Statement
  store %Statement %statement, %Statement* %t848
  %t849 = getelementptr inbounds %Statement, %Statement* %t848, i32 0, i32 1
  %t850 = bitcast [32 x i8]* %t849 to i8*
  %t851 = getelementptr inbounds i8, i8* %t850, i64 8
  %t852 = bitcast i8* %t851 to %Block*
  %t853 = load %Block, %Block* %t852
  %t854 = icmp eq i32 %t847, 19
  %t855 = select i1 %t854, %Block %t853, %Block zeroinitializer
  %t856 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t855)
  %t857 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t846, { %EffectRequirement*, i64 }* %t856)
  store { %EffectRequirement*, i64 }* %t857, { %EffectRequirement*, i64 }** %l7
  %t858 = extractvalue %Statement %statement, 0
  %t859 = alloca %Statement
  store %Statement %statement, %Statement* %t859
  %t860 = getelementptr inbounds %Statement, %Statement* %t859, i32 0, i32 1
  %t861 = bitcast [32 x i8]* %t860 to i8*
  %t862 = getelementptr inbounds i8, i8* %t861, i64 16
  %t863 = bitcast i8* %t862 to %ElseBranch**
  %t864 = load %ElseBranch*, %ElseBranch** %t863
  %t865 = icmp eq i32 %t858, 19
  %t866 = select i1 %t865, %ElseBranch* %t864, %ElseBranch* null
  store %ElseBranch* %t866, %ElseBranch** %l8
  %t867 = load %ElseBranch*, %ElseBranch** %l8
  %t868 = icmp eq %ElseBranch* %t867, null
  %t869 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t870 = load %ElseBranch*, %ElseBranch** %l8
  br i1 %t868, label %then24, label %merge25
then24:
  %t871 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t871
merge25:
  %t872 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  %t873 = load %ElseBranch*, %ElseBranch** %l8
  %t874 = load %ElseBranch, %ElseBranch* %t873
  %t875 = call { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %t874)
  %t876 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t872, { %EffectRequirement*, i64 }* %t875)
  store { %EffectRequirement*, i64 }* %t876, { %EffectRequirement*, i64 }** %l7
  %t877 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l7
  ret { %EffectRequirement*, i64 }* %t877
merge23:
  %t878 = extractvalue %Statement %statement, 0
  %t879 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t880 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t878, 0
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t878, 1
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t878, 2
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t878, 3
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t878, 4
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t878, 5
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t878, 6
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t878, 7
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t878, 8
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t878, 9
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t878, 10
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t878, 11
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t878, 12
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t878, 13
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t878, 14
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t878, 15
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t878, 16
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t878, 17
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t878, 18
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t878, 19
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t878, 20
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t878, 21
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t878, 22
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %s949 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.949, i32 0, i32 0
  %t950 = icmp eq i8* %t948, %s949
  br i1 %t950, label %then26, label %merge27
then26:
  %t951 = extractvalue %Statement %statement, 0
  %t952 = alloca %Statement
  store %Statement %statement, %Statement* %t952
  %t953 = getelementptr inbounds %Statement, %Statement* %t952, i32 0, i32 1
  %t954 = bitcast [16 x i8]* %t953 to i8*
  %t955 = bitcast i8* %t954 to %Expression**
  %t956 = load %Expression*, %Expression** %t955
  %t957 = icmp eq i32 %t951, 20
  %t958 = select i1 %t957, %Expression* %t956, %Expression* null
  %t959 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t958)
  ret { %EffectRequirement*, i64 }* %t959
merge27:
  %t960 = extractvalue %Statement %statement, 0
  %t961 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t962 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t960, 0
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t960, 1
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t960, 2
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t960, 3
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t960, 4
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t960, 5
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t960, 6
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t960, 7
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t960, 8
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t960, 9
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t960, 10
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t960, 11
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t960, 12
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t960, 13
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t960, 14
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t960, 15
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t960, 16
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t960, 17
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t960, 18
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t960, 19
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t960, 20
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t960, 21
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t960, 22
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %s1031 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1031, i32 0, i32 0
  %t1032 = icmp eq i8* %t1030, %s1031
  br i1 %t1032, label %then28, label %merge29
then28:
  %t1033 = extractvalue %Statement %statement, 0
  %t1034 = alloca %Statement
  store %Statement %statement, %Statement* %t1034
  %t1035 = getelementptr inbounds %Statement, %Statement* %t1034, i32 0, i32 1
  %t1036 = bitcast [16 x i8]* %t1035 to i8*
  %t1037 = bitcast i8* %t1036 to %Expression**
  %t1038 = load %Expression*, %Expression** %t1037
  %t1039 = icmp eq i32 %t1033, 20
  %t1040 = select i1 %t1039, %Expression* %t1038, %Expression* null
  %t1041 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1040)
  ret { %EffectRequirement*, i64 }* %t1041
merge29:
  %t1042 = extractvalue %Statement %statement, 0
  %t1043 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1044 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1042, 0
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1042, 1
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1042, 2
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1042, 3
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1042, 4
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1042, 5
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1042, 6
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1042, 7
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %t1068 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1069 = icmp eq i32 %t1042, 8
  %t1070 = select i1 %t1069, i8* %t1068, i8* %t1067
  %t1071 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1042, 9
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1042, 10
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1042, 11
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1042, 12
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1042, 13
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1042, 14
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1042, 15
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1042, 16
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1042, 17
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1042, 18
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1042, 19
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1042, 20
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1042, 21
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1042, 22
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %s1113 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1113, i32 0, i32 0
  %t1114 = icmp eq i8* %t1112, %s1113
  br i1 %t1114, label %then30, label %merge31
then30:
  %t1115 = extractvalue %Statement %statement, 0
  %t1116 = alloca %Statement
  store %Statement %statement, %Statement* %t1116
  %t1117 = getelementptr inbounds %Statement, %Statement* %t1116, i32 0, i32 1
  %t1118 = bitcast [48 x i8]* %t1117 to i8*
  %t1119 = getelementptr inbounds i8, i8* %t1118, i64 24
  %t1120 = bitcast i8* %t1119 to %Expression**
  %t1121 = load %Expression*, %Expression** %t1120
  %t1122 = icmp eq i32 %t1115, 2
  %t1123 = select i1 %t1122, %Expression* %t1121, %Expression* null
  %t1124 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1123)
  ret { %EffectRequirement*, i64 }* %t1124
merge31:
  %t1125 = extractvalue %Statement %statement, 0
  %t1126 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1127 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1128 = icmp eq i32 %t1125, 0
  %t1129 = select i1 %t1128, i8* %t1127, i8* %t1126
  %t1130 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1131 = icmp eq i32 %t1125, 1
  %t1132 = select i1 %t1131, i8* %t1130, i8* %t1129
  %t1133 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1134 = icmp eq i32 %t1125, 2
  %t1135 = select i1 %t1134, i8* %t1133, i8* %t1132
  %t1136 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1137 = icmp eq i32 %t1125, 3
  %t1138 = select i1 %t1137, i8* %t1136, i8* %t1135
  %t1139 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1140 = icmp eq i32 %t1125, 4
  %t1141 = select i1 %t1140, i8* %t1139, i8* %t1138
  %t1142 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1143 = icmp eq i32 %t1125, 5
  %t1144 = select i1 %t1143, i8* %t1142, i8* %t1141
  %t1145 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1146 = icmp eq i32 %t1125, 6
  %t1147 = select i1 %t1146, i8* %t1145, i8* %t1144
  %t1148 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1149 = icmp eq i32 %t1125, 7
  %t1150 = select i1 %t1149, i8* %t1148, i8* %t1147
  %t1151 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1152 = icmp eq i32 %t1125, 8
  %t1153 = select i1 %t1152, i8* %t1151, i8* %t1150
  %t1154 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1155 = icmp eq i32 %t1125, 9
  %t1156 = select i1 %t1155, i8* %t1154, i8* %t1153
  %t1157 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1158 = icmp eq i32 %t1125, 10
  %t1159 = select i1 %t1158, i8* %t1157, i8* %t1156
  %t1160 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1161 = icmp eq i32 %t1125, 11
  %t1162 = select i1 %t1161, i8* %t1160, i8* %t1159
  %t1163 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1164 = icmp eq i32 %t1125, 12
  %t1165 = select i1 %t1164, i8* %t1163, i8* %t1162
  %t1166 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1167 = icmp eq i32 %t1125, 13
  %t1168 = select i1 %t1167, i8* %t1166, i8* %t1165
  %t1169 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1170 = icmp eq i32 %t1125, 14
  %t1171 = select i1 %t1170, i8* %t1169, i8* %t1168
  %t1172 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1173 = icmp eq i32 %t1125, 15
  %t1174 = select i1 %t1173, i8* %t1172, i8* %t1171
  %t1175 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1176 = icmp eq i32 %t1125, 16
  %t1177 = select i1 %t1176, i8* %t1175, i8* %t1174
  %t1178 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1179 = icmp eq i32 %t1125, 17
  %t1180 = select i1 %t1179, i8* %t1178, i8* %t1177
  %t1181 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1125, 18
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1125, 19
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1125, 20
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1125, 21
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1125, 22
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %s1196 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1196, i32 0, i32 0
  %t1197 = icmp eq i8* %t1195, %s1196
  br i1 %t1197, label %then32, label %merge33
then32:
  %t1198 = extractvalue %Statement %statement, 0
  %t1199 = alloca %Statement
  store %Statement %statement, %Statement* %t1199
  %t1200 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1201 = bitcast [24 x i8]* %t1200 to i8*
  %t1202 = getelementptr inbounds i8, i8* %t1201, i64 8
  %t1203 = bitcast i8* %t1202 to %Block*
  %t1204 = load %Block, %Block* %t1203
  %t1205 = icmp eq i32 %t1198, 4
  %t1206 = select i1 %t1205, %Block %t1204, %Block zeroinitializer
  %t1207 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1208 = bitcast [24 x i8]* %t1207 to i8*
  %t1209 = getelementptr inbounds i8, i8* %t1208, i64 8
  %t1210 = bitcast i8* %t1209 to %Block*
  %t1211 = load %Block, %Block* %t1210
  %t1212 = icmp eq i32 %t1198, 5
  %t1213 = select i1 %t1212, %Block %t1211, %Block %t1206
  %t1214 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1215 = bitcast [40 x i8]* %t1214 to i8*
  %t1216 = getelementptr inbounds i8, i8* %t1215, i64 16
  %t1217 = bitcast i8* %t1216 to %Block*
  %t1218 = load %Block, %Block* %t1217
  %t1219 = icmp eq i32 %t1198, 6
  %t1220 = select i1 %t1219, %Block %t1218, %Block %t1213
  %t1221 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1222 = bitcast [24 x i8]* %t1221 to i8*
  %t1223 = getelementptr inbounds i8, i8* %t1222, i64 8
  %t1224 = bitcast i8* %t1223 to %Block*
  %t1225 = load %Block, %Block* %t1224
  %t1226 = icmp eq i32 %t1198, 7
  %t1227 = select i1 %t1226, %Block %t1225, %Block %t1220
  %t1228 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1229 = bitcast [40 x i8]* %t1228 to i8*
  %t1230 = getelementptr inbounds i8, i8* %t1229, i64 24
  %t1231 = bitcast i8* %t1230 to %Block*
  %t1232 = load %Block, %Block* %t1231
  %t1233 = icmp eq i32 %t1198, 12
  %t1234 = select i1 %t1233, %Block %t1232, %Block %t1227
  %t1235 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1236 = bitcast [24 x i8]* %t1235 to i8*
  %t1237 = getelementptr inbounds i8, i8* %t1236, i64 8
  %t1238 = bitcast i8* %t1237 to %Block*
  %t1239 = load %Block, %Block* %t1238
  %t1240 = icmp eq i32 %t1198, 13
  %t1241 = select i1 %t1240, %Block %t1239, %Block %t1234
  %t1242 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1243 = bitcast [24 x i8]* %t1242 to i8*
  %t1244 = getelementptr inbounds i8, i8* %t1243, i64 8
  %t1245 = bitcast i8* %t1244 to %Block*
  %t1246 = load %Block, %Block* %t1245
  %t1247 = icmp eq i32 %t1198, 14
  %t1248 = select i1 %t1247, %Block %t1246, %Block %t1241
  %t1249 = getelementptr inbounds %Statement, %Statement* %t1199, i32 0, i32 1
  %t1250 = bitcast [16 x i8]* %t1249 to i8*
  %t1251 = bitcast i8* %t1250 to %Block*
  %t1252 = load %Block, %Block* %t1251
  %t1253 = icmp eq i32 %t1198, 15
  %t1254 = select i1 %t1253, %Block %t1252, %Block %t1248
  %t1255 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1254)
  ret { %EffectRequirement*, i64 }* %t1255
merge33:
  %t1256 = extractvalue %Statement %statement, 0
  %t1257 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1258 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1256, 0
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1256, 1
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1256, 2
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1256, 3
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1256, 4
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1256, 5
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1256, 6
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1256, 7
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1256, 8
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1256, 9
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1256, 10
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1256, 11
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1256, 12
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1256, 13
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1256, 14
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1304 = icmp eq i32 %t1256, 15
  %t1305 = select i1 %t1304, i8* %t1303, i8* %t1302
  %t1306 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1307 = icmp eq i32 %t1256, 16
  %t1308 = select i1 %t1307, i8* %t1306, i8* %t1305
  %t1309 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1310 = icmp eq i32 %t1256, 17
  %t1311 = select i1 %t1310, i8* %t1309, i8* %t1308
  %t1312 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1313 = icmp eq i32 %t1256, 18
  %t1314 = select i1 %t1313, i8* %t1312, i8* %t1311
  %t1315 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1316 = icmp eq i32 %t1256, 19
  %t1317 = select i1 %t1316, i8* %t1315, i8* %t1314
  %t1318 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1319 = icmp eq i32 %t1256, 20
  %t1320 = select i1 %t1319, i8* %t1318, i8* %t1317
  %t1321 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1322 = icmp eq i32 %t1256, 21
  %t1323 = select i1 %t1322, i8* %t1321, i8* %t1320
  %t1324 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1325 = icmp eq i32 %t1256, 22
  %t1326 = select i1 %t1325, i8* %t1324, i8* %t1323
  %s1327 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.1327, i32 0, i32 0
  %t1328 = icmp eq i8* %t1326, %s1327
  br i1 %t1328, label %then34, label %merge35
then34:
  %t1329 = extractvalue %Statement %statement, 0
  %t1330 = alloca %Statement
  store %Statement %statement, %Statement* %t1330
  %t1331 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1332 = bitcast [24 x i8]* %t1331 to i8*
  %t1333 = getelementptr inbounds i8, i8* %t1332, i64 8
  %t1334 = bitcast i8* %t1333 to %Block*
  %t1335 = load %Block, %Block* %t1334
  %t1336 = icmp eq i32 %t1329, 4
  %t1337 = select i1 %t1336, %Block %t1335, %Block zeroinitializer
  %t1338 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1339 = bitcast [24 x i8]* %t1338 to i8*
  %t1340 = getelementptr inbounds i8, i8* %t1339, i64 8
  %t1341 = bitcast i8* %t1340 to %Block*
  %t1342 = load %Block, %Block* %t1341
  %t1343 = icmp eq i32 %t1329, 5
  %t1344 = select i1 %t1343, %Block %t1342, %Block %t1337
  %t1345 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1346 = bitcast [40 x i8]* %t1345 to i8*
  %t1347 = getelementptr inbounds i8, i8* %t1346, i64 16
  %t1348 = bitcast i8* %t1347 to %Block*
  %t1349 = load %Block, %Block* %t1348
  %t1350 = icmp eq i32 %t1329, 6
  %t1351 = select i1 %t1350, %Block %t1349, %Block %t1344
  %t1352 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1353 = bitcast [24 x i8]* %t1352 to i8*
  %t1354 = getelementptr inbounds i8, i8* %t1353, i64 8
  %t1355 = bitcast i8* %t1354 to %Block*
  %t1356 = load %Block, %Block* %t1355
  %t1357 = icmp eq i32 %t1329, 7
  %t1358 = select i1 %t1357, %Block %t1356, %Block %t1351
  %t1359 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1360 = bitcast [40 x i8]* %t1359 to i8*
  %t1361 = getelementptr inbounds i8, i8* %t1360, i64 24
  %t1362 = bitcast i8* %t1361 to %Block*
  %t1363 = load %Block, %Block* %t1362
  %t1364 = icmp eq i32 %t1329, 12
  %t1365 = select i1 %t1364, %Block %t1363, %Block %t1358
  %t1366 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1367 = bitcast [24 x i8]* %t1366 to i8*
  %t1368 = getelementptr inbounds i8, i8* %t1367, i64 8
  %t1369 = bitcast i8* %t1368 to %Block*
  %t1370 = load %Block, %Block* %t1369
  %t1371 = icmp eq i32 %t1329, 13
  %t1372 = select i1 %t1371, %Block %t1370, %Block %t1365
  %t1373 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1374 = bitcast [24 x i8]* %t1373 to i8*
  %t1375 = getelementptr inbounds i8, i8* %t1374, i64 8
  %t1376 = bitcast i8* %t1375 to %Block*
  %t1377 = load %Block, %Block* %t1376
  %t1378 = icmp eq i32 %t1329, 14
  %t1379 = select i1 %t1378, %Block %t1377, %Block %t1372
  %t1380 = getelementptr inbounds %Statement, %Statement* %t1330, i32 0, i32 1
  %t1381 = bitcast [16 x i8]* %t1380 to i8*
  %t1382 = bitcast i8* %t1381 to %Block*
  %t1383 = load %Block, %Block* %t1382
  %t1384 = icmp eq i32 %t1329, 15
  %t1385 = select i1 %t1384, %Block %t1383, %Block %t1379
  %t1386 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1385)
  ret { %EffectRequirement*, i64 }* %t1386
merge35:
  %t1387 = extractvalue %Statement %statement, 0
  %t1388 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1389 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1387, 0
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %t1392 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1387, 1
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1387, 2
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1387, 3
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1387, 4
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1387, 5
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1387, 6
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1387, 7
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1387, 8
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1387, 9
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1387, 10
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1387, 11
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1387, 12
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1387, 13
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1387, 14
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1387, 15
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1387, 16
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1387, 17
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1387, 18
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1387, 19
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1387, 20
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1387, 21
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1387, 22
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %s1458 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1458, i32 0, i32 0
  %t1459 = icmp eq i8* %t1457, %s1458
  br i1 %t1459, label %then36, label %merge37
then36:
  %t1460 = extractvalue %Statement %statement, 0
  %t1461 = alloca %Statement
  store %Statement %statement, %Statement* %t1461
  %t1462 = getelementptr inbounds %Statement, %Statement* %t1461, i32 0, i32 1
  %t1463 = bitcast [24 x i8]* %t1462 to i8*
  %t1464 = getelementptr inbounds i8, i8* %t1463, i64 8
  %t1465 = bitcast i8* %t1464 to %Block*
  %t1466 = load %Block, %Block* %t1465
  %t1467 = icmp eq i32 %t1460, 4
  %t1468 = select i1 %t1467, %Block %t1466, %Block zeroinitializer
  %t1469 = getelementptr inbounds %Statement, %Statement* %t1461, i32 0, i32 1
  %t1470 = bitcast [24 x i8]* %t1469 to i8*
  %t1471 = getelementptr inbounds i8, i8* %t1470, i64 8
  %t1472 = bitcast i8* %t1471 to %Block*
  %t1473 = load %Block, %Block* %t1472
  %t1474 = icmp eq i32 %t1460, 5
  %t1475 = select i1 %t1474, %Block %t1473, %Block %t1468
  %t1476 = getelementptr inbounds %Statement, %Statement* %t1461, i32 0, i32 1
  %t1477 = bitcast [40 x i8]* %t1476 to i8*
  %t1478 = getelementptr inbounds i8, i8* %t1477, i64 16
  %t1479 = bitcast i8* %t1478 to %Block*
  %t1480 = load %Block, %Block* %t1479
  %t1481 = icmp eq i32 %t1460, 6
  %t1482 = select i1 %t1481, %Block %t1480, %Block %t1475
  %t1483 = getelementptr inbounds %Statement, %Statement* %t1461, i32 0, i32 1
  %t1484 = bitcast [24 x i8]* %t1483 to i8*
  %t1485 = getelementptr inbounds i8, i8* %t1484, i64 8
  %t1486 = bitcast i8* %t1485 to %Block*
  %t1487 = load %Block, %Block* %t1486
  %t1488 = icmp eq i32 %t1460, 7
  %t1489 = select i1 %t1488, %Block %t1487, %Block %t1482
  %t1490 = getelementptr inbounds %Statement, %Statement* %t1461, i32 0, i32 1
  %t1491 = bitcast [40 x i8]* %t1490 to i8*
  %t1492 = getelementptr inbounds i8, i8* %t1491, i64 24
  %t1493 = bitcast i8* %t1492 to %Block*
  %t1494 = load %Block, %Block* %t1493
  %t1495 = icmp eq i32 %t1460, 12
  %t1496 = select i1 %t1495, %Block %t1494, %Block %t1489
  %t1497 = getelementptr inbounds %Statement, %Statement* %t1461, i32 0, i32 1
  %t1498 = bitcast [24 x i8]* %t1497 to i8*
  %t1499 = getelementptr inbounds i8, i8* %t1498, i64 8
  %t1500 = bitcast i8* %t1499 to %Block*
  %t1501 = load %Block, %Block* %t1500
  %t1502 = icmp eq i32 %t1460, 13
  %t1503 = select i1 %t1502, %Block %t1501, %Block %t1496
  %t1504 = getelementptr inbounds %Statement, %Statement* %t1461, i32 0, i32 1
  %t1505 = bitcast [24 x i8]* %t1504 to i8*
  %t1506 = getelementptr inbounds i8, i8* %t1505, i64 8
  %t1507 = bitcast i8* %t1506 to %Block*
  %t1508 = load %Block, %Block* %t1507
  %t1509 = icmp eq i32 %t1460, 14
  %t1510 = select i1 %t1509, %Block %t1508, %Block %t1503
  %t1511 = getelementptr inbounds %Statement, %Statement* %t1461, i32 0, i32 1
  %t1512 = bitcast [16 x i8]* %t1511 to i8*
  %t1513 = bitcast i8* %t1512 to %Block*
  %t1514 = load %Block, %Block* %t1513
  %t1515 = icmp eq i32 %t1460, 15
  %t1516 = select i1 %t1515, %Block %t1514, %Block %t1510
  %t1517 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1516)
  ret { %EffectRequirement*, i64 }* %t1517
merge37:
  %t1518 = extractvalue %Statement %statement, 0
  %t1519 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1520 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1518, 0
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1518, 1
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1518, 2
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1518, 3
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1518, 4
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1518, 5
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1518, 6
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1518, 7
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1518, 8
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1518, 9
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1518, 10
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1518, 11
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1518, 12
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1518, 13
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1518, 14
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1518, 15
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %t1568 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1518, 16
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1518, 17
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1518, 18
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1518, 19
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1518, 20
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1518, 21
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1518, 22
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %s1589 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1589, i32 0, i32 0
  %t1590 = icmp eq i8* %t1588, %s1589
  br i1 %t1590, label %then38, label %merge39
then38:
  %t1591 = extractvalue %Statement %statement, 0
  %t1592 = alloca %Statement
  store %Statement %statement, %Statement* %t1592
  %t1593 = getelementptr inbounds %Statement, %Statement* %t1592, i32 0, i32 1
  %t1594 = bitcast [24 x i8]* %t1593 to i8*
  %t1595 = getelementptr inbounds i8, i8* %t1594, i64 8
  %t1596 = bitcast i8* %t1595 to %Block*
  %t1597 = load %Block, %Block* %t1596
  %t1598 = icmp eq i32 %t1591, 4
  %t1599 = select i1 %t1598, %Block %t1597, %Block zeroinitializer
  %t1600 = getelementptr inbounds %Statement, %Statement* %t1592, i32 0, i32 1
  %t1601 = bitcast [24 x i8]* %t1600 to i8*
  %t1602 = getelementptr inbounds i8, i8* %t1601, i64 8
  %t1603 = bitcast i8* %t1602 to %Block*
  %t1604 = load %Block, %Block* %t1603
  %t1605 = icmp eq i32 %t1591, 5
  %t1606 = select i1 %t1605, %Block %t1604, %Block %t1599
  %t1607 = getelementptr inbounds %Statement, %Statement* %t1592, i32 0, i32 1
  %t1608 = bitcast [40 x i8]* %t1607 to i8*
  %t1609 = getelementptr inbounds i8, i8* %t1608, i64 16
  %t1610 = bitcast i8* %t1609 to %Block*
  %t1611 = load %Block, %Block* %t1610
  %t1612 = icmp eq i32 %t1591, 6
  %t1613 = select i1 %t1612, %Block %t1611, %Block %t1606
  %t1614 = getelementptr inbounds %Statement, %Statement* %t1592, i32 0, i32 1
  %t1615 = bitcast [24 x i8]* %t1614 to i8*
  %t1616 = getelementptr inbounds i8, i8* %t1615, i64 8
  %t1617 = bitcast i8* %t1616 to %Block*
  %t1618 = load %Block, %Block* %t1617
  %t1619 = icmp eq i32 %t1591, 7
  %t1620 = select i1 %t1619, %Block %t1618, %Block %t1613
  %t1621 = getelementptr inbounds %Statement, %Statement* %t1592, i32 0, i32 1
  %t1622 = bitcast [40 x i8]* %t1621 to i8*
  %t1623 = getelementptr inbounds i8, i8* %t1622, i64 24
  %t1624 = bitcast i8* %t1623 to %Block*
  %t1625 = load %Block, %Block* %t1624
  %t1626 = icmp eq i32 %t1591, 12
  %t1627 = select i1 %t1626, %Block %t1625, %Block %t1620
  %t1628 = getelementptr inbounds %Statement, %Statement* %t1592, i32 0, i32 1
  %t1629 = bitcast [24 x i8]* %t1628 to i8*
  %t1630 = getelementptr inbounds i8, i8* %t1629, i64 8
  %t1631 = bitcast i8* %t1630 to %Block*
  %t1632 = load %Block, %Block* %t1631
  %t1633 = icmp eq i32 %t1591, 13
  %t1634 = select i1 %t1633, %Block %t1632, %Block %t1627
  %t1635 = getelementptr inbounds %Statement, %Statement* %t1592, i32 0, i32 1
  %t1636 = bitcast [24 x i8]* %t1635 to i8*
  %t1637 = getelementptr inbounds i8, i8* %t1636, i64 8
  %t1638 = bitcast i8* %t1637 to %Block*
  %t1639 = load %Block, %Block* %t1638
  %t1640 = icmp eq i32 %t1591, 14
  %t1641 = select i1 %t1640, %Block %t1639, %Block %t1634
  %t1642 = getelementptr inbounds %Statement, %Statement* %t1592, i32 0, i32 1
  %t1643 = bitcast [16 x i8]* %t1642 to i8*
  %t1644 = bitcast i8* %t1643 to %Block*
  %t1645 = load %Block, %Block* %t1644
  %t1646 = icmp eq i32 %t1591, 15
  %t1647 = select i1 %t1646, %Block %t1645, %Block %t1641
  %t1648 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1647)
  ret { %EffectRequirement*, i64 }* %t1648
merge39:
  %t1649 = extractvalue %Statement %statement, 0
  %t1650 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1651 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1649, 0
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1655 = icmp eq i32 %t1649, 1
  %t1656 = select i1 %t1655, i8* %t1654, i8* %t1653
  %t1657 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1658 = icmp eq i32 %t1649, 2
  %t1659 = select i1 %t1658, i8* %t1657, i8* %t1656
  %t1660 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1661 = icmp eq i32 %t1649, 3
  %t1662 = select i1 %t1661, i8* %t1660, i8* %t1659
  %t1663 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1664 = icmp eq i32 %t1649, 4
  %t1665 = select i1 %t1664, i8* %t1663, i8* %t1662
  %t1666 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1667 = icmp eq i32 %t1649, 5
  %t1668 = select i1 %t1667, i8* %t1666, i8* %t1665
  %t1669 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1670 = icmp eq i32 %t1649, 6
  %t1671 = select i1 %t1670, i8* %t1669, i8* %t1668
  %t1672 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1673 = icmp eq i32 %t1649, 7
  %t1674 = select i1 %t1673, i8* %t1672, i8* %t1671
  %t1675 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1676 = icmp eq i32 %t1649, 8
  %t1677 = select i1 %t1676, i8* %t1675, i8* %t1674
  %t1678 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1679 = icmp eq i32 %t1649, 9
  %t1680 = select i1 %t1679, i8* %t1678, i8* %t1677
  %t1681 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1682 = icmp eq i32 %t1649, 10
  %t1683 = select i1 %t1682, i8* %t1681, i8* %t1680
  %t1684 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1685 = icmp eq i32 %t1649, 11
  %t1686 = select i1 %t1685, i8* %t1684, i8* %t1683
  %t1687 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1688 = icmp eq i32 %t1649, 12
  %t1689 = select i1 %t1688, i8* %t1687, i8* %t1686
  %t1690 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1691 = icmp eq i32 %t1649, 13
  %t1692 = select i1 %t1691, i8* %t1690, i8* %t1689
  %t1693 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1694 = icmp eq i32 %t1649, 14
  %t1695 = select i1 %t1694, i8* %t1693, i8* %t1692
  %t1696 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1697 = icmp eq i32 %t1649, 15
  %t1698 = select i1 %t1697, i8* %t1696, i8* %t1695
  %t1699 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1700 = icmp eq i32 %t1649, 16
  %t1701 = select i1 %t1700, i8* %t1699, i8* %t1698
  %t1702 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1703 = icmp eq i32 %t1649, 17
  %t1704 = select i1 %t1703, i8* %t1702, i8* %t1701
  %t1705 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1706 = icmp eq i32 %t1649, 18
  %t1707 = select i1 %t1706, i8* %t1705, i8* %t1704
  %t1708 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1709 = icmp eq i32 %t1649, 19
  %t1710 = select i1 %t1709, i8* %t1708, i8* %t1707
  %t1711 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1712 = icmp eq i32 %t1649, 20
  %t1713 = select i1 %t1712, i8* %t1711, i8* %t1710
  %t1714 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1715 = icmp eq i32 %t1649, 21
  %t1716 = select i1 %t1715, i8* %t1714, i8* %t1713
  %t1717 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1718 = icmp eq i32 %t1649, 22
  %t1719 = select i1 %t1718, i8* %t1717, i8* %t1716
  %s1720 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.1720, i32 0, i32 0
  %t1721 = icmp eq i8* %t1719, %s1720
  br i1 %t1721, label %then40, label %merge41
then40:
  %t1722 = alloca [0 x %EffectRequirement]
  %t1723 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1722, i32 0, i32 0
  %t1724 = alloca { %EffectRequirement*, i64 }
  %t1725 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1724, i32 0, i32 0
  store %EffectRequirement* %t1723, %EffectRequirement** %t1725
  %t1726 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1724, i32 0, i32 1
  store i64 0, i64* %t1726
  store { %EffectRequirement*, i64 }* %t1724, { %EffectRequirement*, i64 }** %l9
  %t1727 = sitofp i64 0 to double
  store double %t1727, double* %l10
  %t1728 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1729 = load double, double* %l10
  br label %loop.header42
loop.header42:
  %t1773 = phi { %EffectRequirement*, i64 }* [ %t1728, %then40 ], [ %t1771, %loop.latch44 ]
  %t1774 = phi double [ %t1729, %then40 ], [ %t1772, %loop.latch44 ]
  store { %EffectRequirement*, i64 }* %t1773, { %EffectRequirement*, i64 }** %l9
  store double %t1774, double* %l10
  br label %loop.body43
loop.body43:
  %t1730 = load double, double* %l10
  %t1731 = extractvalue %Statement %statement, 0
  %t1732 = alloca %Statement
  store %Statement %statement, %Statement* %t1732
  %t1733 = getelementptr inbounds %Statement, %Statement* %t1732, i32 0, i32 1
  %t1734 = bitcast [56 x i8]* %t1733 to i8*
  %t1735 = getelementptr inbounds i8, i8* %t1734, i64 40
  %t1736 = bitcast i8* %t1735 to { %MethodDeclaration**, i64 }**
  %t1737 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1736
  %t1738 = icmp eq i32 %t1731, 8
  %t1739 = select i1 %t1738, { %MethodDeclaration**, i64 }* %t1737, { %MethodDeclaration**, i64 }* null
  %t1740 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1739
  %t1741 = extractvalue { %MethodDeclaration**, i64 } %t1740, 1
  %t1742 = sitofp i64 %t1741 to double
  %t1743 = fcmp oge double %t1730, %t1742
  %t1744 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1745 = load double, double* %l10
  br i1 %t1743, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t1746 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1747 = extractvalue %Statement %statement, 0
  %t1748 = alloca %Statement
  store %Statement %statement, %Statement* %t1748
  %t1749 = getelementptr inbounds %Statement, %Statement* %t1748, i32 0, i32 1
  %t1750 = bitcast [56 x i8]* %t1749 to i8*
  %t1751 = getelementptr inbounds i8, i8* %t1750, i64 40
  %t1752 = bitcast i8* %t1751 to { %MethodDeclaration**, i64 }**
  %t1753 = load { %MethodDeclaration**, i64 }*, { %MethodDeclaration**, i64 }** %t1752
  %t1754 = icmp eq i32 %t1747, 8
  %t1755 = select i1 %t1754, { %MethodDeclaration**, i64 }* %t1753, { %MethodDeclaration**, i64 }* null
  %t1756 = load double, double* %l10
  %t1757 = fptosi double %t1756 to i64
  %t1758 = load { %MethodDeclaration**, i64 }, { %MethodDeclaration**, i64 }* %t1755
  %t1759 = extractvalue { %MethodDeclaration**, i64 } %t1758, 0
  %t1760 = extractvalue { %MethodDeclaration**, i64 } %t1758, 1
  %t1761 = icmp uge i64 %t1757, %t1760
  ; bounds check: %t1761 (if true, out of bounds)
  %t1762 = getelementptr %MethodDeclaration*, %MethodDeclaration** %t1759, i64 %t1757
  %t1763 = load %MethodDeclaration*, %MethodDeclaration** %t1762
  %t1764 = getelementptr %MethodDeclaration, %MethodDeclaration* %t1763, i32 0, i32 1
  %t1765 = load %Block, %Block* %t1764
  %t1766 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %t1765)
  %t1767 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1746, { %EffectRequirement*, i64 }* %t1766)
  store { %EffectRequirement*, i64 }* %t1767, { %EffectRequirement*, i64 }** %l9
  %t1768 = load double, double* %l10
  %t1769 = sitofp i64 1 to double
  %t1770 = fadd double %t1768, %t1769
  store double %t1770, double* %l10
  br label %loop.latch44
loop.latch44:
  %t1771 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  %t1772 = load double, double* %l10
  br label %loop.header42
afterloop45:
  %t1775 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l9
  ret { %EffectRequirement*, i64 }* %t1775
merge41:
  %t1776 = extractvalue %Statement %statement, 0
  %t1777 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1778 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1779 = icmp eq i32 %t1776, 0
  %t1780 = select i1 %t1779, i8* %t1778, i8* %t1777
  %t1781 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1782 = icmp eq i32 %t1776, 1
  %t1783 = select i1 %t1782, i8* %t1781, i8* %t1780
  %t1784 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1785 = icmp eq i32 %t1776, 2
  %t1786 = select i1 %t1785, i8* %t1784, i8* %t1783
  %t1787 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1788 = icmp eq i32 %t1776, 3
  %t1789 = select i1 %t1788, i8* %t1787, i8* %t1786
  %t1790 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1791 = icmp eq i32 %t1776, 4
  %t1792 = select i1 %t1791, i8* %t1790, i8* %t1789
  %t1793 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1794 = icmp eq i32 %t1776, 5
  %t1795 = select i1 %t1794, i8* %t1793, i8* %t1792
  %t1796 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1797 = icmp eq i32 %t1776, 6
  %t1798 = select i1 %t1797, i8* %t1796, i8* %t1795
  %t1799 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1800 = icmp eq i32 %t1776, 7
  %t1801 = select i1 %t1800, i8* %t1799, i8* %t1798
  %t1802 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1803 = icmp eq i32 %t1776, 8
  %t1804 = select i1 %t1803, i8* %t1802, i8* %t1801
  %t1805 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1806 = icmp eq i32 %t1776, 9
  %t1807 = select i1 %t1806, i8* %t1805, i8* %t1804
  %t1808 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1809 = icmp eq i32 %t1776, 10
  %t1810 = select i1 %t1809, i8* %t1808, i8* %t1807
  %t1811 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1812 = icmp eq i32 %t1776, 11
  %t1813 = select i1 %t1812, i8* %t1811, i8* %t1810
  %t1814 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1815 = icmp eq i32 %t1776, 12
  %t1816 = select i1 %t1815, i8* %t1814, i8* %t1813
  %t1817 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1818 = icmp eq i32 %t1776, 13
  %t1819 = select i1 %t1818, i8* %t1817, i8* %t1816
  %t1820 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1821 = icmp eq i32 %t1776, 14
  %t1822 = select i1 %t1821, i8* %t1820, i8* %t1819
  %t1823 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1824 = icmp eq i32 %t1776, 15
  %t1825 = select i1 %t1824, i8* %t1823, i8* %t1822
  %t1826 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1827 = icmp eq i32 %t1776, 16
  %t1828 = select i1 %t1827, i8* %t1826, i8* %t1825
  %t1829 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1830 = icmp eq i32 %t1776, 17
  %t1831 = select i1 %t1830, i8* %t1829, i8* %t1828
  %t1832 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1833 = icmp eq i32 %t1776, 18
  %t1834 = select i1 %t1833, i8* %t1832, i8* %t1831
  %t1835 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1836 = icmp eq i32 %t1776, 19
  %t1837 = select i1 %t1836, i8* %t1835, i8* %t1834
  %t1838 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1839 = icmp eq i32 %t1776, 20
  %t1840 = select i1 %t1839, i8* %t1838, i8* %t1837
  %t1841 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1842 = icmp eq i32 %t1776, 21
  %t1843 = select i1 %t1842, i8* %t1841, i8* %t1840
  %t1844 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1845 = icmp eq i32 %t1776, 22
  %t1846 = select i1 %t1845, i8* %t1844, i8* %t1843
  %s1847 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.1847, i32 0, i32 0
  %t1848 = icmp eq i8* %t1846, %s1847
  br i1 %t1848, label %then48, label %merge49
then48:
  %t1849 = alloca [0 x %EffectRequirement]
  %t1850 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1849, i32 0, i32 0
  %t1851 = alloca { %EffectRequirement*, i64 }
  %t1852 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1851, i32 0, i32 0
  store %EffectRequirement* %t1850, %EffectRequirement** %t1852
  %t1853 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1851, i32 0, i32 1
  store i64 0, i64* %t1853
  store { %EffectRequirement*, i64 }* %t1851, { %EffectRequirement*, i64 }** %l11
  %t1854 = sitofp i64 0 to double
  store double %t1854, double* %l12
  %t1855 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1856 = load double, double* %l12
  br label %loop.header50
loop.header50:
  %t1901 = phi { %EffectRequirement*, i64 }* [ %t1855, %then48 ], [ %t1899, %loop.latch52 ]
  %t1902 = phi double [ %t1856, %then48 ], [ %t1900, %loop.latch52 ]
  store { %EffectRequirement*, i64 }* %t1901, { %EffectRequirement*, i64 }** %l11
  store double %t1902, double* %l12
  br label %loop.body51
loop.body51:
  %t1857 = load double, double* %l12
  %t1858 = extractvalue %Statement %statement, 0
  %t1859 = alloca %Statement
  store %Statement %statement, %Statement* %t1859
  %t1860 = getelementptr inbounds %Statement, %Statement* %t1859, i32 0, i32 1
  %t1861 = bitcast [48 x i8]* %t1860 to i8*
  %t1862 = getelementptr inbounds i8, i8* %t1861, i64 24
  %t1863 = bitcast i8* %t1862 to { %ModelProperty**, i64 }**
  %t1864 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1863
  %t1865 = icmp eq i32 %t1858, 3
  %t1866 = select i1 %t1865, { %ModelProperty**, i64 }* %t1864, { %ModelProperty**, i64 }* null
  %t1867 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1866
  %t1868 = extractvalue { %ModelProperty**, i64 } %t1867, 1
  %t1869 = sitofp i64 %t1868 to double
  %t1870 = fcmp oge double %t1857, %t1869
  %t1871 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1872 = load double, double* %l12
  br i1 %t1870, label %then54, label %merge55
then54:
  br label %afterloop53
merge55:
  %t1873 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1874 = extractvalue %Statement %statement, 0
  %t1875 = alloca %Statement
  store %Statement %statement, %Statement* %t1875
  %t1876 = getelementptr inbounds %Statement, %Statement* %t1875, i32 0, i32 1
  %t1877 = bitcast [48 x i8]* %t1876 to i8*
  %t1878 = getelementptr inbounds i8, i8* %t1877, i64 24
  %t1879 = bitcast i8* %t1878 to { %ModelProperty**, i64 }**
  %t1880 = load { %ModelProperty**, i64 }*, { %ModelProperty**, i64 }** %t1879
  %t1881 = icmp eq i32 %t1874, 3
  %t1882 = select i1 %t1881, { %ModelProperty**, i64 }* %t1880, { %ModelProperty**, i64 }* null
  %t1883 = load double, double* %l12
  %t1884 = fptosi double %t1883 to i64
  %t1885 = load { %ModelProperty**, i64 }, { %ModelProperty**, i64 }* %t1882
  %t1886 = extractvalue { %ModelProperty**, i64 } %t1885, 0
  %t1887 = extractvalue { %ModelProperty**, i64 } %t1885, 1
  %t1888 = icmp uge i64 %t1884, %t1887
  ; bounds check: %t1888 (if true, out of bounds)
  %t1889 = getelementptr %ModelProperty*, %ModelProperty** %t1886, i64 %t1884
  %t1890 = load %ModelProperty*, %ModelProperty** %t1889
  %t1891 = getelementptr %ModelProperty, %ModelProperty* %t1890, i32 0, i32 1
  %t1892 = load %Expression, %Expression* %t1891
  %t1893 = alloca %Expression
  store %Expression %t1892, %Expression* %t1893
  %t1894 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(%Expression* %t1893)
  %t1895 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t1873, { %EffectRequirement*, i64 }* %t1894)
  store { %EffectRequirement*, i64 }* %t1895, { %EffectRequirement*, i64 }** %l11
  %t1896 = load double, double* %l12
  %t1897 = sitofp i64 1 to double
  %t1898 = fadd double %t1896, %t1897
  store double %t1898, double* %l12
  br label %loop.latch52
loop.latch52:
  %t1899 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  %t1900 = load double, double* %l12
  br label %loop.header50
afterloop53:
  %t1903 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l11
  ret { %EffectRequirement*, i64 }* %t1903
merge49:
  %t1904 = extractvalue %Statement %statement, 0
  %t1905 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t1906 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t1907 = icmp eq i32 %t1904, 0
  %t1908 = select i1 %t1907, i8* %t1906, i8* %t1905
  %t1909 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t1910 = icmp eq i32 %t1904, 1
  %t1911 = select i1 %t1910, i8* %t1909, i8* %t1908
  %t1912 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t1913 = icmp eq i32 %t1904, 2
  %t1914 = select i1 %t1913, i8* %t1912, i8* %t1911
  %t1915 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t1916 = icmp eq i32 %t1904, 3
  %t1917 = select i1 %t1916, i8* %t1915, i8* %t1914
  %t1918 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t1919 = icmp eq i32 %t1904, 4
  %t1920 = select i1 %t1919, i8* %t1918, i8* %t1917
  %t1921 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t1922 = icmp eq i32 %t1904, 5
  %t1923 = select i1 %t1922, i8* %t1921, i8* %t1920
  %t1924 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t1925 = icmp eq i32 %t1904, 6
  %t1926 = select i1 %t1925, i8* %t1924, i8* %t1923
  %t1927 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t1928 = icmp eq i32 %t1904, 7
  %t1929 = select i1 %t1928, i8* %t1927, i8* %t1926
  %t1930 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t1931 = icmp eq i32 %t1904, 8
  %t1932 = select i1 %t1931, i8* %t1930, i8* %t1929
  %t1933 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t1934 = icmp eq i32 %t1904, 9
  %t1935 = select i1 %t1934, i8* %t1933, i8* %t1932
  %t1936 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t1937 = icmp eq i32 %t1904, 10
  %t1938 = select i1 %t1937, i8* %t1936, i8* %t1935
  %t1939 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t1940 = icmp eq i32 %t1904, 11
  %t1941 = select i1 %t1940, i8* %t1939, i8* %t1938
  %t1942 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t1943 = icmp eq i32 %t1904, 12
  %t1944 = select i1 %t1943, i8* %t1942, i8* %t1941
  %t1945 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t1946 = icmp eq i32 %t1904, 13
  %t1947 = select i1 %t1946, i8* %t1945, i8* %t1944
  %t1948 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t1949 = icmp eq i32 %t1904, 14
  %t1950 = select i1 %t1949, i8* %t1948, i8* %t1947
  %t1951 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t1952 = icmp eq i32 %t1904, 15
  %t1953 = select i1 %t1952, i8* %t1951, i8* %t1950
  %t1954 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t1955 = icmp eq i32 %t1904, 16
  %t1956 = select i1 %t1955, i8* %t1954, i8* %t1953
  %t1957 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t1958 = icmp eq i32 %t1904, 17
  %t1959 = select i1 %t1958, i8* %t1957, i8* %t1956
  %t1960 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t1961 = icmp eq i32 %t1904, 18
  %t1962 = select i1 %t1961, i8* %t1960, i8* %t1959
  %t1963 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t1964 = icmp eq i32 %t1904, 19
  %t1965 = select i1 %t1964, i8* %t1963, i8* %t1962
  %t1966 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t1967 = icmp eq i32 %t1904, 20
  %t1968 = select i1 %t1967, i8* %t1966, i8* %t1965
  %t1969 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t1970 = icmp eq i32 %t1904, 21
  %t1971 = select i1 %t1970, i8* %t1969, i8* %t1968
  %t1972 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t1973 = icmp eq i32 %t1904, 22
  %t1974 = select i1 %t1973, i8* %t1972, i8* %t1971
  %s1975 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1975, i32 0, i32 0
  %t1976 = icmp eq i8* %t1974, %s1975
  br i1 %t1976, label %then56, label %merge57
then56:
  %t1977 = extractvalue %Statement %statement, 0
  %t1978 = alloca %Statement
  store %Statement %statement, %Statement* %t1978
  %t1979 = getelementptr inbounds %Statement, %Statement* %t1978, i32 0, i32 1
  %t1980 = bitcast [16 x i8]* %t1979 to i8*
  %t1981 = bitcast i8* %t1980 to { %Token**, i64 }**
  %t1982 = load { %Token**, i64 }*, { %Token**, i64 }** %t1981
  %t1983 = icmp eq i32 %t1977, 22
  %t1984 = select i1 %t1983, { %Token**, i64 }* %t1982, { %Token**, i64 }* null
  %t1985 = bitcast { %Token**, i64 }* %t1984 to { %Token*, i64 }*
  %t1986 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %t1985)
  ret { %EffectRequirement*, i64 }* %t1986
merge57:
  %t1987 = alloca [0 x %EffectRequirement]
  %t1988 = getelementptr [0 x %EffectRequirement], [0 x %EffectRequirement]* %t1987, i32 0, i32 0
  %t1989 = alloca { %EffectRequirement*, i64 }
  %t1990 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1989, i32 0, i32 0
  store %EffectRequirement* %t1988, %EffectRequirement** %t1990
  %t1991 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t1989, i32 0, i32 1
  store i64 0, i64* %t1991
  ret { %EffectRequirement*, i64 }* %t1989
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
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t6 = extractvalue %ElseBranch %branch, 1
  %t7 = call { %EffectRequirement*, i64 }* @collect_effects_from_optional_block(%Block* %t6)
  %t8 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t5, { %EffectRequirement*, i64 }* %t7)
  store { %EffectRequirement*, i64 }* %t8, { %EffectRequirement*, i64 }** %l0
  %t9 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t10 = extractvalue %ElseBranch %branch, 0
  %t11 = call { %EffectRequirement*, i64 }* @collect_effects_from_optional_statement(%Statement* %t10)
  %t12 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }* %t11)
  store { %EffectRequirement*, i64 }* %t12, { %EffectRequirement*, i64 }** %l0
  %t13 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t13
}

define { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %case) {
entry:
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
